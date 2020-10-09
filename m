Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B34AC43457
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 22:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5757222C3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 22:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBWTS1+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5757222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792176EE43;
	Fri,  9 Oct 2020 22:49:00 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4461A6EE43
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 22:48:59 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id s7so12268966qkh.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Oct 2020 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oiNjyh2trq/fxU6Upm51coJZfs7ZRS9Tkd6aofdALr0=;
 b=LBWTS1+7e2P08HPDGZvVPN5NHf5hQn3VRCql3TSFVEVJOGSGLyf2c3skaUO7ar5HwZ
 3EuWGambjVjvKU18Al6qo9Th1p7Oi9Qxv9iMz69t46r5x1f3OpH3ADaUOea4J6BBhTak
 LJgPzyfTKmE2LPK3RczJBtmSdIVJcTrNRQ9OJJZkFoy3w2qcM+z6PDKnJRrEzIIHS82d
 jRR4WQkPacS21Pxl7k8HwVMk/oHySQ2sdrv6jgkU2E+a3aSdOvs3668enpo/STUEAIim
 /sZu6sAJ8qgzuGroPq1Ip71JX2b2lGbsr+WE8wT28vgaZGNkScznBc629HrxT2gArEqQ
 h6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oiNjyh2trq/fxU6Upm51coJZfs7ZRS9Tkd6aofdALr0=;
 b=OTvLrkmc4Aif0cEI/PR1eI+hEoY2dG/52/IQWrA7eqn58bKb8kzF2RTw2e2TSiGBIE
 8GSMy5gRwasJB9SmkzzTidK1BobkQaayJzEK4FI5AkfoJJWb+4k/zbh4bTDguf7qCOOC
 CCOOqtK5pvlGtMLrfKON1kLigd2abTwJ5pWep7BYp70M6Awl+mBOffX5bvadjiElVoKF
 SE6/Ygabdjtj7l7ufIiqU1IxgqcO0l8fFI8ITj31x0X9Ebwz1n4MOHhp4uWuPNXPBnah
 afXaPb1VcOLWLi/PWY6CtCCnfDwWnlUWolMkd102ejqEcEIz8uj+NYE9IMfawBu+4OTM
 V44Q==
X-Gm-Message-State: AOAM531NrdmB2RnlpcSwnAmsQufMHJbbHascj9pRGmAih0f5VqpyS1hl
 4tWNvKJwBGPEbji4Q9Q1tHK8JSX/9aw=
X-Google-Smtp-Source: ABdhPJxBC+thr97P9jo86bDw5wf4wafsUaPm/pralWMLnHgtmtVnoNg+UTpdWXvkq4p2rrXHBLGWWA==
X-Received: by 2002:a05:620a:15ac:: with SMTP id
 f12mr236589qkk.19.1602283738277; 
 Fri, 09 Oct 2020 15:48:58 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t3sm7185482qtq.24.2020.10.09.15.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 15:48:57 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amd/display: Add green_sardine support to DM
Date: Fri,  9 Oct 2020 18:48:47 -0400
Message-Id: <20201009224847.238484-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201009224847.238484-1-alexander.deucher@amd.com>
References: <20201009224847.238484-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman Li <Roman.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

Display Manager support for green_sardine

Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index f45f9baec156..aae53589879a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -100,6 +100,10 @@ MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
 #define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
 #endif
+#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
+#define FIRMWARE_GREEN_SARDINE_DMUB "amdgpu/green_sardine_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE_DMUB);
+#endif
 #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
 #define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
@@ -945,6 +949,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 		init_data.flags.gpu_vm_support = true;
+#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
+		if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
+			init_data.flags.disable_dmcu = true;
+#endif
 		break;
 	default:
 		break;
@@ -1245,6 +1253,10 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		dmub_asic = DMUB_ASIC_DCN21;
 		fw_name_dmub = FIRMWARE_RENOIR_DMUB;
+#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
+		if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
+			fw_name_dmub = FIRMWARE_GREEN_SARDINE_DMUB;
+#endif
 		break;
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	case CHIP_SIENNA_CICHLID:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
