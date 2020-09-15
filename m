Return-Path: <SRS0=7kRa=CY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684D7C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:22:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F331B205F4
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2020 18:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hq7OcC8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F331B205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 726FE6E8D7;
	Tue, 15 Sep 2020 18:22:16 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 850E96E8D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 18:22:15 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id r8so3908541qtp.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2020 11:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vzzyRyQ19AaiAcBEITEU4Dl9PPsoSBvh7UZG/qkiXUA=;
 b=hq7OcC8GB/jvy7IGYuJW9d+T6NRhbjDHMjG/XQ++aoF3PONQ20UdAiHMkDomQlIZEd
 1iZMl2Lgm0eoa2zhGF/EqWLK/lS+FgwMRi1+mk/A1KmgNmMjCD7H3WjK645Fk9tF353y
 JD9JjJfRsnptPRLTnKskcoMvou0j9mMd6/6yzokBnYOYqyp2gu8gUn4zwSTi7zJejO7K
 uqaiScvk4MQG5Y8m1et1cjU2K6ouyHbsxeKwkwoHaniad0XUhXJInkQNc0L5Td7x7ng/
 I8Tlhld3BlYTTpyC3chzaVawAQrLIgvqGd0V+8HJ1Cmaq4XG4YM3Kj2EMWttpw/T56T6
 ZbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vzzyRyQ19AaiAcBEITEU4Dl9PPsoSBvh7UZG/qkiXUA=;
 b=A9HYppj2P16AdjD+i5jpkncJJOdkSn79CL/LYmdmj0w+BY3V0pcQ35zh/y7txwCcpy
 twRL8JC9+lofcbt3RbSRf8hsODCTCysNWNNk5kIP4TnZP8aIdh6PwI8+k8mpOO6gK0M6
 v2b6Dx/T73gOmQDV45ELa5RWNyHnAdATGUr3818D5Ff3btDitkaCqfbWEnR+EknneioC
 oi8ywOEg/DfTHRmPo6anRFCyIIeE+Ctw/W3aGN45C7alRW0br+azGZ56Y8tHQo45ZOLD
 BWboD02r9qErs2PiQCDymsdXCfmEjERRhAlrNlBr124gxjYRVLHLI+72Je9dbFqfaf2o
 Aj9Q==
X-Gm-Message-State: AOAM531NMiYzI47BaixWoH5LnQ5jqKtz72GoOGKhZAp/ww7L8ILbmr/n
 UIsMj4rtWCydemddL5dOZYmj96T8Kzw=
X-Google-Smtp-Source: ABdhPJyniaIoFcZdOi+diAU78maS+2cBkOhFElB884coPkn+pWwpvDqVYdrd52O2pFYtJYL/xUKM8w==
X-Received: by 2002:aed:2be2:: with SMTP id e89mr19622491qtd.298.1600194134459; 
 Tue, 15 Sep 2020 11:22:14 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id p29sm17331373qtu.68.2020.09.15.11.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 11:22:13 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove experimental flag from navi12
Date: Tue, 15 Sep 2020 14:22:06 -0400
Message-Id: <20200915182206.68607-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Navi12 has worked fine for a while now.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d87d37c25329..6e4c860e8ae0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1073,8 +1073,8 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x1636, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_RENOIR|AMD_IS_APU},
 
 	/* Navi12 */
-	{0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
-	{0x1002, 0x7362, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
+	{0x1002, 0x7362, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12},
 
 	{0, 0, 0}
 };
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
