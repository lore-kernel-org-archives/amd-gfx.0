Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1591BC3DA49
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jul 2024 06:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA43D10E33D;
	Tue, 30 Jul 2024 06:40:22 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1690B10E44B
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jul 2024 06:40:18 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 46U6eCUU4185775; Tue, 30 Jul 2024 12:10:12 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 46U6eCHo4185774;
 Tue, 30 Jul 2024 12:10:12 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1 1/2] drm/amdgpu: Remove debugfs
 amdgpu_reset_dump_register_list
Date: Tue, 30 Jul 2024 12:10:07 +0530
Message-Id: <20240730064008.4185728-2-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730064008.4185728-1-sunil.khatri@amd.com>
References: <20240730064008.4185728-1-sunil.khatri@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are some problem with existing amdgpu_reset_dump_register_list
debugfs node. It is supposed to read a list of registers but there
could be cases when the IP is not in correct power state. Register
read in such cases could lead to more problems.

We are taking care of all such power states in devcoredump and
dumping the registers of need for debugging. So cleaning this code
and we dont need this functionality via debugfs anymore.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 96 ---------------------
 1 file changed, 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0e1a11b6b989..cbef720de779 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2026,100 +2026,6 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
-static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
-				char __user *buf, size_t size, loff_t *pos)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
-	char reg_offset[12];
-	int i, ret, len = 0;
-
-	if (*pos)
-		return 0;
-
-	memset(reg_offset, 0, 12);
-	ret = down_read_killable(&adev->reset_domain->sem);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < adev->reset_info.num_regs; i++) {
-		sprintf(reg_offset, "0x%x\n", adev->reset_info.reset_dump_reg_list[i]);
-		up_read(&adev->reset_domain->sem);
-		if (copy_to_user(buf + len, reg_offset, strlen(reg_offset)))
-			return -EFAULT;
-
-		len += strlen(reg_offset);
-		ret = down_read_killable(&adev->reset_domain->sem);
-		if (ret)
-			return ret;
-	}
-
-	up_read(&adev->reset_domain->sem);
-	*pos += len;
-
-	return len;
-}
-
-static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
-			const char __user *buf, size_t size, loff_t *pos)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
-	char reg_offset[11];
-	uint32_t *new = NULL, *tmp = NULL;
-	unsigned int len = 0;
-	int ret, i = 0;
-
-	do {
-		memset(reg_offset, 0, 11);
-		if (copy_from_user(reg_offset, buf + len,
-					min(10, (size-len)))) {
-			ret = -EFAULT;
-			goto error_free;
-		}
-
-		new = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
-		if (!new) {
-			ret = -ENOMEM;
-			goto error_free;
-		}
-		tmp = new;
-		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
-			ret = -EINVAL;
-			goto error_free;
-		}
-
-		len += ret;
-		i++;
-	} while (len < size);
-
-	new = kmalloc_array(i, sizeof(uint32_t), GFP_KERNEL);
-	if (!new) {
-		ret = -ENOMEM;
-		goto error_free;
-	}
-	ret = down_write_killable(&adev->reset_domain->sem);
-	if (ret)
-		goto error_free;
-
-	swap(adev->reset_info.reset_dump_reg_list, tmp);
-	swap(adev->reset_info.reset_dump_reg_value, new);
-	adev->reset_info.num_regs = i;
-	up_write(&adev->reset_domain->sem);
-	ret = size;
-
-error_free:
-	if (tmp != new)
-		kfree(tmp);
-	kfree(new);
-	return ret;
-}
-
-static const struct file_operations amdgpu_reset_dump_register_list = {
-	.owner = THIS_MODULE,
-	.read = amdgpu_reset_dump_register_list_read,
-	.write = amdgpu_reset_dump_register_list_write,
-	.llseek = default_llseek
-};
-
 int amdgpu_debugfs_init(struct amdgpu_device *adev)
 {
 	struct dentry *root = adev_to_drm(adev)->primary->debugfs_root;
@@ -2204,8 +2110,6 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_vm_info_fops);
 	debugfs_create_file("amdgpu_benchmark", 0200, root, adev,
 			    &amdgpu_benchmark_fops);
-	debugfs_create_file("amdgpu_reset_dump_register_list", 0644, root, adev,
-			    &amdgpu_reset_dump_register_list);
 
 	adev->debugfs_vbios_blob.data = adev->bios;
 	adev->debugfs_vbios_blob.size = adev->bios_size;
-- 
2.34.1

