Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C510C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E652064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqSgDMAp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E652064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1DD6E955;
	Wed,  7 Oct 2020 16:32:01 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E5576E952
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:01 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id h12so853903qtu.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a41qyaRZN+LvyO5KO5n/q7K5sdrwrbNWCnR7q74p1g0=;
 b=KqSgDMAphhOXTFOkXcLALXsuAjMKWCipa4Z6Wnfkb3jo3kj14CTFncpe5swyzCOBv+
 J1f4hljhZH4VbtDcDLR8FGdut+fzNPcq/fi5C8WKLJYTsVJLOZt7tbf1UjunwlXHa09R
 e3hRhgR9xVZb2yqeMpQKpEe4NmfCftawRJ26loOaDAxFOz9VK6Xc8G2Rwxq/WH+TIeAh
 Zd2TlEhxzzaQUBTVFsyxkRdRG1/LYasv+pQxBguEw2RAfMkfU3uo+dfOhOh3IlgKqsGR
 0VaysnugeyaVeK+F9803M9TlkiBwlnmzay0w0RM8YXSsM2SWTAaqbZZOOi9LaJTLUejV
 PZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a41qyaRZN+LvyO5KO5n/q7K5sdrwrbNWCnR7q74p1g0=;
 b=oYigP0duB1IPpe1f2HU47jIv/6i3FGhdMBb8RAh226LmW8vSy60bm0F9F+t9ODt6Qv
 RRsAJPUCT42TDmiOf//yIk109ctErr6UBGnPxzT9cExz1PK6oUphrq4YAhIAdsudCRL2
 3tx16SRTsv/tWVVvHcaoifjTY/1/40pP/93STPh4qFPKQTRpAKNlpfaXaBXOUobDiXcV
 jVE5ozfKmTpDQ4Ctnoh2y4ZV69/gUm4D2MV+u/d+sBiL1oqWyFM9QiR5bXROhT4FhS+z
 KXF2mI7MlSTAlDdp101ObAVRkp+8HFKdh4CmJF48qtWTEHi/pGJPQExPzXl2paHPAdrX
 pcFw==
X-Gm-Message-State: AOAM533Ti112JX9MM2Qp3j6Pj20HGM5hYQx0/WAq8KnIcaHyuWOeKayp
 QmiaaC32rWN6iQZS7wtTINRrjVQXMUo=
X-Google-Smtp-Source: ABdhPJx5GBOTv4sJqRllx2v3VRujnlv3K7s6Lgk3Z/3LinDGHd7zqrnCav1l6zTLUYz9Khsyw8T0fg==
X-Received: by 2002:aed:3e3a:: with SMTP id l55mr343905qtf.19.1602088320205;
 Wed, 07 Oct 2020 09:32:00 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:31:59 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/50] drm/amdgpu: add mmhub support for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:30:55 -0400
Message-Id: <20201007163135.1944186-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Same as navy_flounder.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 2063700f0bc6..e590c60cedaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -543,6 +543,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		def1 = data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
 		break;
@@ -576,6 +577,7 @@ static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *ad
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		if (def != data)
 			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
 		if (def1 != data1)
@@ -598,6 +600,7 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		def  = data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		break;
 	default:
@@ -614,6 +617,7 @@ static void mmhub_v2_0_update_medium_grain_light_sleep(struct amdgpu_device *ade
 		switch (adev->asic_type) {
 		case CHIP_SIENNA_CICHLID:
 		case CHIP_NAVY_FLOUNDER:
+		case CHIP_DIMGREY_CAVEFISH:
 			WREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid, data);
 			break;
 		default:
@@ -657,6 +661,7 @@ static void mmhub_v2_0_get_clockgating(struct amdgpu_device *adev, u32 *flags)
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		data  = RREG32_SOC15(MMHUB, 0, mmMM_ATC_L2_MISC_CG_Sienna_Cichlid);
 		data1 = RREG32_SOC15(MMHUB, 0, mmDAGB0_CNTL_MISC2_Sienna_Cichlid);
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
