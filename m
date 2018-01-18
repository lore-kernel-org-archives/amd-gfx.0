From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Subject: [PATCH 1/4] fs: add OOM badness callback in file_operatrations struct.
Date: Thu, 18 Jan 2018 11:47:49 -0500
Message-ID: <1516294072-17841-2-git-send-email-andrey.grodzovsky@amd.com>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

This allows device drivers to specify an additional badness for the OOM
when they allocate memory on behalf of userspace.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 511fbaa..938394a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1728,6 +1728,7 @@ struct file_operations {
 			u64);
 	ssize_t (*dedupe_file_range)(struct file *, u64, u64, struct file *,
 			u64);
+	long (*oom_file_badness)(struct file *);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.7.4
