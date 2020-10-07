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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55993C4727F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96202064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL4oZ6j/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96202064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83BBC6E949;
	Wed,  7 Oct 2020 16:31:54 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42BD36E949
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:31:53 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id y198so3507474qka.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R+/rxPS5QqTdIO/sgSysGSYmFfay11l02Mv5eG7kFZo=;
 b=PL4oZ6j/tW02gdJaP8ytjA3ROc62IOuWDxMrEKUoHtpKI6jZqygcl22bWBYORMExN0
 tRwbJM4ihs2oysSk37Lfq15TH40N55bcbXEK/Ydk+xk745UrpXIvJbi6bEYurC+Ktl5k
 pYuHGuqo9FMnqey+ezDEgF8Rd+c7Vn4RowUErCPojUp9D6fyaZwb+MC05VRYL3IMyXYp
 UD4yQJ8d0W7ZT5/cYP++/lXHnVAiCUhXoXHy8puvfYocBMahq1dRdkdgdjRGzm7a5wiT
 5mSCH5t8rdL7Nw/DUzb6czF43R1YcFKpHoy/3RMM97zRapnepd1YhuLY9QFGCIebgKnp
 QPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R+/rxPS5QqTdIO/sgSysGSYmFfay11l02Mv5eG7kFZo=;
 b=BFoyRtLPIeXbMimm+xi6brgocpifkYspqNTnwACDpXVUzO40tbkpTFhI4oq0Pu3xuN
 yO7D9/I2Uniwnz+oRuj2LshOuUbNCxvfv0WYv2IuHbNF5pLQQne0o3GzP1ahTo1AWj1Y
 Si0e161GtWDQNuES+R2Kww+DeDLaXWxmt9egPZ02kYEc5d8OivivykWPDQUoXJjzJVHp
 5zCiErJdMxJxjUBuuG+F+ljecSiU1yUfA7ftr8BsIL1jpdN5CxCzeneiYxHs+cpli/YV
 grYbqBXZWI1K24VssutkOTK9xtI5C2nXf9WT3xamde+3XYx60kEX/SxJXX9YovdZRYXr
 MMPA==
X-Gm-Message-State: AOAM533q7HlILqYFMAAzonRAOJN4FlwUqPJjrlWBihhSOFQhLn1r8L4+
 QK8RxhARC5KZGxu03bRB6nmczQGbcpU=
X-Google-Smtp-Source: ABdhPJzGqVldRl2yT98DQEul30ArMruKWI/P7NV0jpK9WOVklrq03eSzE7WXqdYU/P3+1jnmKKEDzw==
X-Received: by 2002:a37:dc03:: with SMTP id v3mr3780453qki.300.1602088312219; 
 Wed, 07 Oct 2020 09:31:52 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:31:51 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/50] drm/amdgpu: add gmc support for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:30:51 -0400
Message-Id: <20201007163135.1944186-7-alexander.deucher@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index bde63e7cd501..d535dfa84bdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -763,6 +763,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		case CHIP_SIENNA_CICHLID:
 		case CHIP_NAVY_FLOUNDER:
 		case CHIP_VANGOGH:
+		case CHIP_DIMGREY_CAVEFISH:
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
@@ -829,6 +830,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
@@ -943,6 +945,7 @@ static void gmc_v10_0_init_golden_registers(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
 	case CHIP_VANGOGH:
+	case CHIP_DIMGREY_CAVEFISH:
 		break;
 	default:
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
