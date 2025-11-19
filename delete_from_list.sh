#!/system/bin/sh

# 取得腳本所在目錄
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

LIST_FILE="$SCRIPT_DIR/1.txt"
TARGET_DIR="/data/user/0/com.garena.game.df"

# 檢查 1.txt 是否存在
if [ ! -f "$LIST_FILE" ]; then
    echo "找不到 $LIST_FILE"
    exit 1
fi

echo "開始依照 1.txt 刪除 (支援資料夾、檔案、萬用字元)..."

while IFS= read -r ITEM || [ -n "$ITEM" ]; do
    [ -z "$ITEM" ] && continue

    PATH_TO_DELETE="$TARGET_DIR/$ITEM"

    for TARGET in $PATH_TO_DELETE; do

        if [ -d "$TARGET" ]; then
            rm -rf "$TARGET"
            echo "已刪除資料夾：$TARGET"
        elif [ -f "$TARGET" ]; then
            rm -f "$TARGET"
            echo "已刪除檔案：$TARGET"
        else
            echo "不存在：$TARGET"
        fi

    done
done < "$LIST_FILE"

echo "完成！"