Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF32E7719B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 14:00:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F5210E8AF;
	Wed,  8 Jan 2025 14:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mGlxaGUB";
	dkim-atps=neutral
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8993510E2A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1736344811; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=W3XC5tMww79TtHZoEdwZQxKo021sSBilmh6yYa0Xitk=;
 b=mGlxaGUBMUOL1ATmN/MxprsdHHN7JYxG9MbokZbeod7uAMCPIsuFZMOMkZYBaMQe0MogW9/VVNz5n9Ba0tGcsy69qqpUmVGmcAj5XZwql4U1vYxSJ9QsAKuLJy64OXjP0Tm9EMOLRV5q3i/WTOIknlkiqsF5S/Uol0e7cK9SrTk=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WNEHXDB_1736344810 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 08 Jan 2025 22:00:10 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 Jun.Ma2@amd.com, xiaogang.chen@amd.com, Kent.Russell@amd.com,
 shuox.liu@linux.alibaba.com, amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [RFC PATCH 01/13] amdgpu: wrong array index to get ip block for PSP
Date: Wed,  8 Jan 2025 21:59:53 +0800
Message-ID: <8571f3280f13a562be5f845c274524560b4bee1d.1736344725.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1736344725.git.gerry@linux.alibaba.com>
References: <cover.1736344725.git.gerry@linux.alibaba.com>
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

The adev->ip_blocks array is not indexed by AMD_IP_BLOCK_TYPE_xxx,
instead we should call amdgpu_device_ip_get_ip_block() to get the
corresponding IP block oject.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0b1e280ee228..25c06c6c8a2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3830,10 +3830,12 @@ static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	struct amdgpu_ip_block *ip_block;
 	uint32_t fw_ver;
 	int ret;
 
-	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP);
+	if (ip_block == NULL || !ip_block->status.late_initialized) {
 		dev_info(adev->dev, "PSP block is not ready yet\n.");
 		return -EBUSY;
 	}
@@ -3862,8 +3864,10 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	struct amdgpu_bo *fw_buf_bo = NULL;
 	uint64_t fw_pri_mc_addr;
 	void *fw_pri_cpu_addr;
+	struct amdgpu_ip_block *ip_block;
 
-	if (!adev->ip_blocks[AMD_IP_BLOCK_TYPE_PSP].status.late_initialized) {
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP);
+	if (ip_block == NULL || !ip_block->status.late_initialized) {
 		dev_err(adev->dev, "PSP block is not ready yet.");
 		return -EBUSY;
 	}
-- 
2.43.5

