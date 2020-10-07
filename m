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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EFC41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D392064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSgJYWG+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D392064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54EA46E957;
	Wed,  7 Oct 2020 16:32:07 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 470F26E957
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:06 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id j3so1474635qvi.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GmoNpWrsBHmOy9nfzp9j+XhDOuviyiijMPT9qIa31vA=;
 b=CSgJYWG+NWEDgaXu9TSRMsZGRjlsQe/u2CWoEdZushuDRmBg0nS7iwXgx1cQ1yqzVI
 Q8g7zVaOb+5/RpKbQb6VWOnMFutxPBH0TIj7MRroe/6mctYnnIrJ02wdDFBICcLCvAOF
 x4ZWeV6RA+eqTYpW05+ks3ffk+ktbh2SEgeMau3zMOJ8wSxmt4N7bLqHI8AoM6dbycjx
 XlVO3rwpSdI1OezBsMGZzi2oKCa8VlQWpsJ/HI7UenXMWrfj3VYUqY9Uj+hRc8swwGH3
 xZyGfpGjiqKcJRL4Ej+1m7XSlCmViYs5XYTVMvRroIL7gwN2AxSqYXASQ2S7pLRFkG+A
 JhOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GmoNpWrsBHmOy9nfzp9j+XhDOuviyiijMPT9qIa31vA=;
 b=eio/GfD4bSkVxmt6mGZp+ouhZIXkc6pz2xWYybEbx+3Jh2/j8yeDIGLOV3aIQG44uN
 kqxxmLP5SNuj6HlYkvrc3Z6J1GM4MiYiSUoGf8SwX6rwMqc2dZNlm1r8KAtIoTdKw4z6
 DLFN+sToXzdq9/p3XiLpk2GnQFINyPkfBJVr6qGeTMEKioQRWlHWVrBUrzyfD7ED9JjK
 xmNdmXoQ/wFmF/SxuROPsQ1hnHN8TjV+pfZ5CshtBehTp7CnepfK5EwXPrvMkTF5kRlB
 /fWBh0Td+HJdkYIA+WUYwJiA/DXZwlkjY0+5jb49Wi2vQN3JB/5Wk9KslZap3bcBrKdP
 xDRw==
X-Gm-Message-State: AOAM532s/zTl1HgxLbEzeU2wte14ZoEBBIFfHq9qBBCFknjp2CavaCfB
 f35RQRwPWtfOUcKczNhJ2MMkQWWijqo=
X-Google-Smtp-Source: ABdhPJz7UQNGwJl4EYx82PV+oKwROoxEmJ+7w8k7Y7YBNnaCRBHSM2iUg8ILv/6VaNUfTcoMASQWIA==
X-Received: by 2002:a0c:fec6:: with SMTP id z6mr4179833qvs.10.1602088325238;
 Wed, 07 Oct 2020 09:32:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/50] drm/amdgpu: add gmc ip block for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:30:57 -0400
Message-Id: <20201007163135.1944186-13-alexander.deucher@amd.com>
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

Enable gmc block for dimgrey_cavefish, same as sienna_cichlid.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +
 drivers/gpu/drm/amd/amdgpu/nv.c        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index d535dfa84bdf..7710862f5748 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -648,6 +648,7 @@ static void gmc_v10_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		adev->gfxhub.funcs = &gfxhub_v2_1_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 82c03e9f55cb..6c06756a216a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -628,6 +628,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_DIMGREY_CAVEFISH:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
