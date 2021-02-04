Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC9FC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051F064DD6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 18:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051F064DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8993B89F19;
	Thu,  4 Feb 2021 18:47:16 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96A1789F07
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 18:47:15 +0000 (UTC)
Received: by mail-qt1-x829.google.com with SMTP id z22so3159384qto.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 10:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iHNlQ9osNbV+Iyl10ZrCTWSEgOcCsrnU5L+TbAj+ukA=;
 b=LwSCAaSRkH9XSBWNQu1x5QyaNC993ShGnlxHtTaXT791fWr87MNW58FLRMgZgU53v6
 f0O1eFCYsJWqjjQaBCJubeXuYd3m06JRS3NNLEuAso4UpAm6ijzZ7/Zdqe7swcqJLozp
 QHdGkTyXZPetQxZNJhDtme5U4GMs4bkAsf+ia6im0+4j+fF34A1RdvlLeaO3v9KYbzUM
 vLH1lR/hAxdx5RThLqxmszGvqdGFEGJLB9rBupooUc3NlrqNFinJ+77IgpGoL7QD0XKR
 OWjxiVrbFX5W3PcH8KkHT42EL0oyNO8dZBRcoD6k2GMljU7+Nmhihi4eKixTdE/GOkz6
 chtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iHNlQ9osNbV+Iyl10ZrCTWSEgOcCsrnU5L+TbAj+ukA=;
 b=nUJIMU0k6qohWPw+OKIsWbRIVC+FG7Kj7psSK85GVX50gYLLFrBhfkdN1uUBg/HMbj
 GO+Z8rgE33p5po3ZNPxirFbn7kMRt3LdL8+KikB8kl/78KOEddzGXKgc54EcseZit8xF
 Tt2GGhjqYCu4C0nZRuLpMK2n/QDQuB9mWXgDlLt8u1taZJ/J2y4xAb4W23zJP1ZArBSd
 7ZqwRUx9lBkerkKkc5LjeAQqGlOQnN8E7l9BP363qcQe8BrQg7IKRw0kVY8XY6ObwVwf
 /oQXR8uW9WQdO2x9Jo6/LagWIeGTSHhMOKWft1/ypn5V+W5+0a3SGoVDpHp2IOYhigjr
 wPaw==
X-Gm-Message-State: AOAM530Rop9RzxXj+uaU4KKI9xVk+/UzDBlszUtezrL/XKs5z+xdR65h
 bk2Hi4MLGJYYqZQdrOTaU+b6FnUvgkU=
X-Google-Smtp-Source: ABdhPJwKAFYvtxTG9NYHKGMsBfCXUIVLwNsep8mlHB4+0OqGAfBjHuo/t9q4qfc8hWpH6PAVLJf7DA==
X-Received: by 2002:ac8:782:: with SMTP id l2mr907440qth.271.1612464434663;
 Thu, 04 Feb 2021 10:47:14 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id j188sm5833644qke.67.2021.02.04.10.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 10:47:14 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amdgpu/si: minor clean up of reset code
Date: Thu,  4 Feb 2021 13:47:00 -0500
Message-Id: <20210204184706.168934-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Drop duplicate reset method logging, whitespace changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 7817e5156cb5..668dd6dfe6a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1380,7 +1380,7 @@ static int si_gpu_pci_config_reset(struct amdgpu_device *adev)
 	u32 i;
 	int r = -EINVAL;
 
-	dev_info(adev->dev, "GPU pci config reset\n");
+	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
 	/* set mclk/sclk to bypass */
 	si_set_clk_bypass_mode(adev);
@@ -1404,6 +1404,7 @@ static int si_gpu_pci_config_reset(struct amdgpu_device *adev)
 		}
 		udelay(1);
 	}
+	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
 
 	return r;
 }
@@ -1414,12 +1415,8 @@ static int si_asic_reset(struct amdgpu_device *adev)
 
 	dev_info(adev->dev, "PCI CONFIG reset\n");
 
-	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
-
 	r = si_gpu_pci_config_reset(adev);
 
-	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
-
 	return r;
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
