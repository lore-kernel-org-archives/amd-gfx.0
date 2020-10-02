Return-Path: <SRS0=93xL=DJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E64C47423
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45DF206CA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2020 15:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htIqEgDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45DF206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E136E9B1;
	Fri,  2 Oct 2020 15:09:57 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC9EE6E9B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2020 15:09:55 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id h1so933864qvo.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2020 08:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OAyxiUw+XOinaH5OMgsa3JCQhSO5U5dtP8mfiBkaCa8=;
 b=htIqEgDRsK3c/a1UiVaXMl6kkNkHNil+9Z3DOE/ow1eJql+0VLUnjvS2Pzmbfy90WO
 OzckTgAlUJ6QjwrNq91LSryPktoAVhzeflN/qfPutQ/L4r4/8BfvceCLnghoWyUuoPyw
 yr9eAOE7Z2iycoDi4RgSAoHSDKmk+OhxLjFugWQLv2bpw//xjXBaG2RiyaVDX8qFktWF
 Fe3ZV1YE1AsXryf+bromirRKU77e+PU9JKWzcLFCj6n5m4HStpoCeXXptU9pAWJJ2u1U
 XFh5u7FLzHuVyBfthz1Q5s2c/HWbyLSWIx3BaozRLWGMtCmH4P6NJpcLt0NnHkL59GKn
 jP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OAyxiUw+XOinaH5OMgsa3JCQhSO5U5dtP8mfiBkaCa8=;
 b=JOURIE8FFxQHs6Jl+yiwl6PnaTfBuhc693owOyR+n0T2iiQT6U5KBzFpS9eOD/Yzef
 GuLYEMI2iv/eU8om5X0MYUhHdDIqk9GLclT1cORdofzQ4dgCdiEZsls6sGTzloQq3ZXB
 c7XyAVWAi79ZTLb/YCseTZKK2BYJWCVoylr+dxb8Yi4BXKPe2oKJOkFs/r4JQH5YzFak
 6/EBIB7kr8n1mN4qRveDX8wUV0j9fNnvaFcLDHrPZaDa+spQLty1wQkMma6cFPlD9ESi
 fl+AC0muUYgqhy5fkKjOKZgfMLyzResX0vhWyWiE9EEljKgPK61/aSZOSfGDKFuK6VPH
 R9iw==
X-Gm-Message-State: AOAM532ukjw0yoao0eWTBKEqREO7P06O7vizNbH0TRgQNc6iUIh8ZPgX
 bXx/JgN9z1zHWZp6+yp70YjhR3Ne8Ak=
X-Google-Smtp-Source: ABdhPJxRmck+ABy/R3ckJrWZq+n1LTzjnLo5oq6E/t7H6+ktTSCNBX9pX2M9kCaNxqM7lulbTwDWpg==
X-Received: by 2002:a0c:abc5:: with SMTP id k5mr2684351qvb.40.1601651394503;
 Fri, 02 Oct 2020 08:09:54 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm1248435qkf.98.2020.10.02.08.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 08:09:53 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] drm/amdgpu: add soc15 common ip block support for
 green_sardine (v3)
Date: Fri,  2 Oct 2020 11:09:36 -0400
Message-Id: <20201002150940.1103949-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201002150940.1103949-1-alexander.deucher@amd.com>
References: <20201002150940.1103949-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

This patch adds common ip support for green_sardine.

v2: use apu flags, squash in CG/PG enablement
v3: rebase

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index afcccc6c0fc6..ed7342bbf801 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1243,7 +1243,15 @@ static int soc15_common_early_init(void *handle)
 		break;
 	case CHIP_RENOIR:
 		adev->asic_funcs = &soc15_asic_funcs;
-		adev->apu_flags |= AMD_APU_IS_RENOIR;
+		if (adev->pdev->device == 0x1636)
+			adev->apu_flags |= AMD_APU_IS_RENOIR;
+		else
+			adev->apu_flags |= AMD_APU_IS_GREEN_SARDINE;
+
+		if (adev->apu_flags & AMD_APU_IS_RENOIR)
+			adev->external_rev_id = adev->rev_id + 0x91;
+		else
+			adev->external_rev_id = adev->rev_id + 0xa1;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 				 AMD_CG_SUPPORT_GFX_MGLS |
 				 AMD_CG_SUPPORT_GFX_3D_CGCG |
@@ -1268,7 +1276,6 @@ static int soc15_common_early_init(void *handle)
 				 AMD_PG_SUPPORT_VCN |
 				 AMD_PG_SUPPORT_JPEG |
 				 AMD_PG_SUPPORT_VCN_DPG;
-		adev->external_rev_id = adev->rev_id + 0x91;
 		break;
 	default:
 		/* FIXME: not supported yet */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
