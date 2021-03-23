Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B6BC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 13:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E99BF619B7
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 13:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99BF619B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEFD6E8E5;
	Tue, 23 Mar 2021 13:04:37 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EBB16E858;
 Tue, 23 Mar 2021 13:04:36 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D79BB619B6;
 Tue, 23 Mar 2021 13:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616504674;
 bh=q6NHsIW3BnA5mhThORhjcdH3DG7oZJ3fYXk3ohPq4IE=;
 h=From:To:Cc:Subject:Date:From;
 b=NSVZHMS2Sa44doHHUf+7S7yQgC3c7fmn8mqentdeLVYtyu9W1ptJa2pLE79Fdw4T1
 x25sJWLjI8q72sGiXXjws1uxQ+Stxy21a1AGhFnFNQ71UmNVqiq17cLSooefF8iLZh
 DpQ8dPBai9dvRSoVgcW/hM+fEuLE6l21P9PUtsIJ+zZb08BftvHsYvXj1DXNCLCGxD
 DdFhaiPPrSeskOliAZMdENIJIVbTLGsDMajQLPthjqfTbvw0LACdqTKMhCKer76HYR
 Mjcz7piID8kj8USw42m8caU00xxjmYn/DiRMbafuxX6EVK/6pitlIivY+HIxUUY0qm
 mLIpyBIPjsJ3Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH] amdgpu: fix gcc -Wrestrict warning
Date: Tue, 23 Mar 2021 14:04:20 +0100
Message-Id: <20210323130430.2250052-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
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
Cc: Jinzhou Su <Jinzhou.Su@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about an sprintf() that uses the same buffer as source
and destination, which is undefined behavior in C99:

drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c: In function 'amdgpu_securedisplay_debugfs_write':
drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:141:6: error: 'sprintf' argument 3 overlaps destination object 'i2c_output' [-Werror=restrict]
  141 |      sprintf(i2c_output, "%s 0x%X", i2c_output,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  142 |       securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
      |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c:97:7: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
   97 |  char i2c_output[256];
      |       ^~~~~~~~~~

Rewrite it to remember the current offset into the buffer instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 834440ab9ff7..69d7f6bff5d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -136,9 +136,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
 		if (!ret) {
 			if (securedisplay_cmd->status == TA_SECUREDISPLAY_STATUS__SUCCESS) {
+				int pos = 0;
 				memset(i2c_output,  0, sizeof(i2c_output));
 				for (i = 0; i < TA_SECUREDISPLAY_I2C_BUFFER_SIZE; i++)
-					sprintf(i2c_output, "%s 0x%X", i2c_output,
+					pos += sprintf(i2c_output + pos, " 0x%X",
 						securedisplay_cmd->securedisplay_out_message.send_roi_crc.i2c_buf[i]);
 				dev_info(adev->dev, "SECUREDISPLAY: I2C buffer out put is :%s\n", i2c_output);
 			} else {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
