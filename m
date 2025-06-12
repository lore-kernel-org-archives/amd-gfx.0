Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E6DC61CE8
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 10:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D09CC10E7CD;
	Thu, 12 Jun 2025 10:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YCXsYI45";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0999110E7C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 10:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q+x+p+x4ca0CJXPDfoluCt0BmHRb01XhNzK7N3kRVXM=; b=YCXsYI45MnQpvFxcltyY2YuN+l
 QL9gG9g8uAOmHICVcnzuzC8gsUhBMzekYTUQjemMYEkA+Y8aEMJlsKaaqanS7VeWsGy6WhRsNagvk
 dLGc8WUbVALqScCUto0N4z84JjdQrUQNnpScgJGAPiTAvS1D5/l9plOcdrxPx98fXPlrQRrN8Uml3
 2aDiCcXuKtYDHpRSEZ7TDazz5auXPp4J79HFq5CwYM8rgkPx20g0cZ7s8XPXo1JkUHpY7BwU6/cif
 1lb7XqESJneRVkmfKeIZZUnR9x/RzDjRY3wGn7JUXjVbmJmMWTJChzuHz9Jkb6J0/KgSyUU5QF52K
 LXcnwBlg==;
Received: from [81.79.92.254] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uPfQE-002alL-Af; Thu, 12 Jun 2025 12:44:38 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 4/4] drm/amdgpu: Use memdup_user in ta_if_load_debugfs_write
Date: Thu, 12 Jun 2025 11:44:29 +0100
Message-ID: <20250612104430.41169-5-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250612104430.41169-1-tvrtko.ursulin@igalia.com>
References: <20250612104430.41169-1-tvrtko.ursulin@igalia.com>
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

Replace kzalloc() + copy_from_user() with memdup_user().

This shrinks the source code and improves separation between the kernel
and userspace slabs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 38face981c3e..e0a604b6c633 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -141,7 +141,7 @@ static const struct file_operations ta_invoke_debugfs_fops = {
  *    - TA ID (4bytes)
  */
 
-static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t len, loff_t *off)
+static ssize_t ta_if_load_debugfs_write(struct file *fp, const char __user *buf, size_t len, loff_t *off)
 {
 	uint32_t ta_type    = 0;
 	uint32_t ta_bin_len = 0;
@@ -171,13 +171,9 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 
 	copy_pos += sizeof(uint32_t);
 
-	ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
-	if (!ta_bin)
-		return -ENOMEM;
-	if (copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len)) {
-		ret = -EFAULT;
-		goto err_free_bin;
-	}
+	ta_bin = memdup_user(&buf[copy_pos], ta_bin_len);
+	if (IS_ERR(ta_bin))
+		return PTR_ERR(ta_bin);
 
 	/* Set TA context and functions */
 	set_ta_context_funcs(psp, ta_type, &context);
@@ -231,7 +227,7 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
 		goto err_free_ta_shared_buf;
 	}
 
-	if (copy_to_user((char *)buf, (void *)&context->session_id, sizeof(uint32_t)))
+	if (copy_to_user((char __user *)buf, (void *)&context->session_id, sizeof(uint32_t)))
 		ret = -EFAULT;
 
 err_free_ta_shared_buf:
-- 
2.48.0

