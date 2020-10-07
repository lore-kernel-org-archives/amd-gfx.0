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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A16DC4727E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21F12064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXUzogtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21F12064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738A56E958;
	Wed,  7 Oct 2020 16:32:12 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F20B6E93C
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:11 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id c5so2405877qtw.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9tdzARrD7fQl3g0ZWdgV3ICEhEl1cvo3in2/+QXRqUI=;
 b=CXUzogtPI3ZPlUz2bo7I9rCjZcgQbPbGxJCCK09iCMWWwCoosS99TO7a/eNwIgQ2yF
 MPFNIweY7uQD9Dv5cMKp4oVc8n/TmAg76RklRvfaWsN8XFqqbuizxavZuEy4Otn8wsIr
 zGyFz6zVlw3sQHvz35rrqxp5x3WZy2lDwlSLtRhLQefHEPzZMjDi/CnQFPb2bOlHhXxY
 Xf15LKehlXAh98zu3XXO+BxhcfHvQh7q5BLsvjsHI8XrX7v/RHPC+dSY6g66wWHggW4Q
 y55MFHj7UgS/GEvRlKwwTXnAP/qSVNQ7pm9vM9yPVGJ3CnJtPLtN8mn3LtO9ntMawStS
 g7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9tdzARrD7fQl3g0ZWdgV3ICEhEl1cvo3in2/+QXRqUI=;
 b=sC0u4kgqOXd9hKnca0yOUuRM2yE5rbZ5qI00DMuVNxtjoXlXf3ntn9VlybOabh+vWh
 R42HVLDnHLQ/cw7BbQl8ti9tpfg1LsGzOqseJCMbdAmzzUAeycUcllL6ao9+D8F2ZZyC
 M5kGQuNCtUigsus9JFk+oq7NhG+2NvhdtwmVYLkzbWaCsL8QD40+rH56LlCrKgOG5n35
 wP+yQQRMaNdLut/59TZ32/8bPGd+em9XyCYatafeKMcmxU78J1oFX8VcChOlnrKNwQ6z
 rovdVEu/645hyJDTFtPQ4QmxwYJIBVgqBesfSrm2gQGpuZqQE4p+gqKsZ1GIOJGIO4Ol
 fcvA==
X-Gm-Message-State: AOAM5328mDE1CXJF0Z2vUKA3zcvBBHitxpRezSrCUkCfYXJdJyfqWK8v
 cWP1/9lu3wxpHmiXOhsGYCEADK+aMeo=
X-Google-Smtp-Source: ABdhPJzAeFNCEyh32ShoFyV3ACVCNEIo8avF368F8YCMSYVmz288VvCSaeauAvAkRPo4UWIAEZ7oLQ==
X-Received: by 2002:aed:2964:: with SMTP id s91mr4062729qtd.278.1602088330487; 
 Wed, 07 Oct 2020 09:32:10 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:09 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/50] drm/amdgpu: add gfx ip block for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:30:59 -0400
Message-Id: <20201007163135.1944186-15-alexander.deucher@amd.com>
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

Enable gfx block for dimgrey_cavefish, same as navy_flounder.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 218f67d29257..2dfc4efa92f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4260,6 +4260,7 @@ static void gfx_v10_0_gpu_early_init(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -4384,6 +4385,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 1;
 		adev->gfx.me.num_queue_per_pipe = 1;
@@ -7263,6 +7265,7 @@ static int gfx_v10_0_early_init(void *handle)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		adev->gfx.num_gfx_rings = GFX10_NUM_GFX_RINGS_Sienna_Cichlid;
 		break;
 	default:
@@ -8790,6 +8793,7 @@ static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		adev->gfx.rlc.funcs = &gfx_v10_0_rlc_funcs;
 		break;
 	case CHIP_NAVI12:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7b261dc44786..573c16f2c537 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -630,6 +630,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
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
