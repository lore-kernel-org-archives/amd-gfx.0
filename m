Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981A7C433E7
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C67E2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8cuu62z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C67E2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62AD6E0CE;
	Mon,  1 Jun 2020 18:02:58 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2386E0D4
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:02:57 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id r16so454232qvm.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wfIjymL3FlIdWWRAV1A4uXCYccISEA3T/klxoiOlbp4=;
 b=B8cuu62zLgz4prA9CTrH6jLhA9g7MsJsM2Be3DDtEJmfOMqpjUHXMvhRVLKkB7v+4+
 4m4s1u6SlK+Rzca4+/MMgvSzXaRuM3aeLHa4sKraZPsMZanWB0IM5vWvzDBk0vtBPj4v
 h3Wm1z+x/dDaMCcJig4xbYkSqh9gbJ3/Nc3Vg/cmb83WUQbOnBu2b3wNnOQrqWPSOJMQ
 O1ckEyL25Cf6WlANt9zLdiNq2FDcnJyslpPiKnpji0xznk5WEQU3d7m+toS5DMquclC3
 0XpNmkk/zKVPU1ZsyAKpTHUQKD+TEKZJIfsPe3HOt67BFZU4Nba8298gkFeM4i4WXzAj
 32mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wfIjymL3FlIdWWRAV1A4uXCYccISEA3T/klxoiOlbp4=;
 b=mBUdaFjqGz1HIR6b/GKWbJ8mMZhoAq6Tj/kz4O2Jorjnl5dWip+pmjmbDqMAee4iah
 dKXH1jA0q9GjSSvPD/QtElfpImoyOfOgrVsHw1b3AF0qxRubjgbLegHNoZ6pgy/z9DGp
 0GANVT4UWHWxFq4UHfYI2hzvWFxTAl1ufuxqsudnkIHP7OeIY9W3xmL42Tj3+zNoBNz9
 Vy4gpQj7VGZKDkgkaSnUHFRpvpZvXkLB7dDSTmPITYnPKeETb99WBMo+YWCSg1ETxSeF
 12381dVEU+5vpNrm8b4aHOw7a48YGEmX0bBrEQ9LnAWvtLgwytKZ09lj4Jjmps+UDTWr
 nC5A==
X-Gm-Message-State: AOAM530W6Zwm+PlwyuJVI1inivblXgA+WQMc6hpe5a6oH3w1coCuLtR8
 RfsoKKdarSSyBuryHcUDSZV5N6Gq
X-Google-Smtp-Source: ABdhPJxOZc8lI1ptvIPYUkz3tirMOfmML+T+b36bNS5nxQSBoQZy9w5EEUr93zODPouVFmDTQaEH/Q==
X-Received: by 2002:a05:6214:12ad:: with SMTP id
 w13mr21167717qvu.74.1591034576512; 
 Mon, 01 Jun 2020 11:02:56 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:02:55 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 010/207] drm/amdgpu/gmc10: add sienna_cichlid support
Date: Mon,  1 Jun 2020 13:59:22 -0400
Message-Id: <20200601180239.1267430-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Same as navi10.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index ba2b7ac0c02d..fb8030cf65cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -712,6 +712,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		case CHIP_NAVI10:
 		case CHIP_NAVI14:
 		case CHIP_NAVI12:
+		case CHIP_SIENNA_CICHLID:
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
@@ -798,6 +799,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
@@ -896,6 +898,7 @@ static void gmc_v10_0_init_golden_registers(struct amdgpu_device *adev)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
 		break;
 	default:
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
