Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AF8C02196
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 06:29:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB5610E25C;
	Fri,  7 Feb 2025 06:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oviBWoa8";
	dkim-atps=neutral
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09FD010EA27
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 06:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1738909737; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=lrfHz371nFgrSE4rdplp/ux6OP/aeNxXTIRd8Ul/kf0=;
 b=oviBWoa8dyxM+QNVEjPY1KotMZwIA0OFvQZQT3+Bsyy+GmXggZ1I6qznDlh2P32OkY2/qPm7pMRqyJNvI8e7z8CNIFibDF7r96hy5werXFg0hf91R48T5cL5x+sjqK092I0+UjVJTF400byGLnEdNoy8yFV4nEePY2tb639+yjw=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WOyT2pT_1738909736 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 07 Feb 2025 14:28:56 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v1 3/4] drm/amdgpu: bail out when failed to load fw in
 psp_init_cap_microcode()
Date: Fri,  7 Feb 2025 14:28:51 +0800
Message-ID: <d6d0b42a335784ae16500664ed3a0fc17bbe0476.1738909308.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738909308.git.gerry@linux.alibaba.com>
References: <cover.1738909308.git.gerry@linux.alibaba.com>
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

In function psp_init_cap_microcode(), it should bail out when failed to
load firmware, otherwise it may cause invalid memory access.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0d1eb7b8e59b..952da6c7943d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3838,9 +3838,10 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 		if (err == -ENODEV) {
 			dev_warn(adev->dev, "cap microcode does not exist, skip\n");
 			err = 0;
-			goto out;
+		} else {
+			dev_err(adev->dev, "fail to initialize cap microcode\n");
 		}
-		dev_err(adev->dev, "fail to initialize cap microcode\n");
+		goto out;
 	}
 
 	info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CAP];
-- 
2.43.5

