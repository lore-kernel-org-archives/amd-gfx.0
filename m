Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8177AC55178
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 23:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8E0218AC
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 23:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxaBzqwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8E0218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4E6D6EA8F;
	Mon, 26 Oct 2020 23:52:41 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9D66EA88;
 Mon, 26 Oct 2020 23:52:40 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4FD85221FA;
 Mon, 26 Oct 2020 23:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603756360;
 bh=Tck5dv2qtba8u2Jf38M/7hnYMasdDz2D8I9vwSUc5ds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XxaBzqwCrhRbcEwefjgmMMnrwHJv6KqJPVn1dYWk1iBVyxN+qMSr4n8XRjHnDo2JD
 S+3k7av78/1wqp2WEUTHJkKb4uinEf5deGLjI2SAPWZmE/iqmqqMjx1lFEi8L9E+Fc
 XST/aue7EgwVgworSunmqFxcYSjXSUmMDTinoHM0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 029/132] drm/amdgpu: restore ras flags when user
 resets eeprom(v2)
Date: Mon, 26 Oct 2020 19:50:21 -0400
Message-Id: <20201026235205.1023962-29-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026235205.1023962-1-sashal@kernel.org>
References: <20201026235205.1023962-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Guchun Chen <guchun.chen@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Guchun Chen <guchun.chen@amd.com>

[ Upstream commit bf0b91b78f002faa1be1902a75eeb0797f9fbcf3 ]

RAS flags needs to be cleaned as well when user requires
one clean eeprom.

v2: RAS flags shall be restored after eeprom reset succeeds.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 3f47f35eedff1..50fc974655f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -364,12 +364,19 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f, const char __user *
 static ssize_t amdgpu_ras_debugfs_eeprom_write(struct file *f, const char __user *buf,
 		size_t size, loff_t *pos)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
+	struct amdgpu_device *adev =
+		(struct amdgpu_device *)file_inode(f)->i_private;
 	int ret;
 
-	ret = amdgpu_ras_eeprom_reset_table(&adev->psp.ras.ras->eeprom_control);
+	ret = amdgpu_ras_eeprom_reset_table(
+			&(amdgpu_ras_get_context(adev)->eeprom_control));
 
-	return ret == 1 ? size : -EIO;
+	if (ret == 1) {
+		amdgpu_ras_get_context(adev)->flags = RAS_DEFAULT_FLAGS;
+		return size;
+	} else {
+		return -EIO;
+	}
 }
 
 static const struct file_operations amdgpu_ras_debugfs_ctrl_ops = {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
