Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F268C433F8
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7575C225AA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvll99LI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7575C225AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40AE96E82C;
	Tue, 14 Jul 2020 18:24:31 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E136E82C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:29 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id w27so13550371qtb.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bIcK/xu3/FmoIra+XTrbNEkgKAT9wu3j9vl6vLwaHm0=;
 b=cvll99LIzG/3Mjvmd5JExTtkhTYQKS+hIj6ywE9h6qcXyatBzdqx/p4MmszFPg5Lbg
 OGkfK5cm84+DKKYuwiZktlI/ABsVFEkD4nS+mJbjHcZiOusJy7O2MLX5WuJArcHvM/Ky
 RUMHE586O9eledFXG8Yd3Q0AHh5KNraTJbi2W0tR595zsXEMG+6Tso5UaDX3EAOxhk0n
 rcb9jjEJ05Z0IFdzLCPaNzjdPDARBMOHTYuiJeEL7YaJF8wrvT9rURXY2HNEV6QvhKT6
 yE0jSVDT/PIv+a0nhXoA+Cnl4JRPKXoj9J+9ZY5+hSwvrt+VtRYGfwLnsVSk9E4nMACf
 yHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bIcK/xu3/FmoIra+XTrbNEkgKAT9wu3j9vl6vLwaHm0=;
 b=UhKVXSXjkhvbFNbcFuLfhuVSnYwR+2WbTKEEZzBeeO8/X13VzCeZdwYMRk7xetjnXl
 lJ6+kO/4i3qcgJ3Muue6ZAP16bIpfZDIqizAtqvO5f5qvya13jdl6RCVaFpFMRfclN1C
 JjhhXodmmpnVS+8scFAhbHu3OMLXo8/htueQBbJf2kTtwg9zRKlMDHWXHDzZVfoZrDMc
 AemjR2W37yv6Hhzjzdd8MhUkogzpch+Xdo90HeIpuWruFACUBlLieQOgrLbo3YzdBa5C
 jhTMRHkuvh3EovXyHyCCiW12GHpMYpXJVsD3Zv1P1ngx9OTvsqgOvFHa8hVf2Kzf75Ur
 K3sg==
X-Gm-Message-State: AOAM531KMkSIyuq1iNxVk9uWOca1IsSdGZ9QoiYZx6A/jp/+lej15XaJ
 zX/TLiTrs2OIsBSS90Pxi42buyRI
X-Google-Smtp-Source: ABdhPJwc3SfqMT0FEWlKD7VNZhFnA/8zVCZKi2mJ5LaPfBOrJlXqhmU66ko7Pr/FsVFJEpWxKbBZJg==
X-Received: by 2002:ac8:4b47:: with SMTP id e7mr6275513qts.242.1594751068405; 
 Tue, 14 Jul 2020 11:24:28 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:27 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/42] drm/amdgpu: add gfx ip block for navy_flounder
Date: Tue, 14 Jul 2020 14:23:26 -0400
Message-Id: <20200714182353.2164930-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <Tao.Zhou1@amd.com>,
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

since navy_flounder has similar gc IP version with
sienna_cichlid, follow its setting for the moment.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <Tao.Zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 401e9607becc..5e24adca964b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4118,6 +4118,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 		gb_addr_config = RREG32_SOC15(GC, 0, mmGB_ADDR_CONFIG);
 		break;
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -4240,6 +4241,7 @@ static int gfx_v10_0_sw_init(void *handle)
 		adev->gfx.mec.num_queue_per_pipe = 8;
 		break;
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -7081,6 +7083,7 @@ static int gfx_v10_0_early_init(void *handle)
 		adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_NV1X;
 		break;
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_Sienna_Cichlid;
 		break;
 	default:
@@ -8578,6 +8581,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs;
 		break;
 	case CHIP_NAVI12:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 5990b7b3796f..693eab81f1d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -512,6 +512,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
+		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
