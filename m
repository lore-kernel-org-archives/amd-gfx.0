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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D414C41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275502064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfvB7e7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275502064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A11186E974;
	Wed,  7 Oct 2020 16:32:43 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B7B86E972
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:42 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id b69so3460314qkg.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pmtUE6CWNphHSZJy2RiHgqGd+bsDBb/j0ec0z6BBHNM=;
 b=tfvB7e7v+ElbbX3rjW3VtTYEqNgLWGSItAK+YfQpDronU/KsAlArWA9HTurOTJwBLy
 I7SxoMVgOHCbL0EdkptN6f6Og6SUyRAfZjFSXabsgN/5fAtGR/uq9LHITg057bqFFKwH
 XrQx00qW+X2Bm/zjUYofP2m2A+P0eqPcnTzbRlZzWXT/VzdZy/Go6cPVRKvzCYStVLYb
 XfHb3MQwkq/fz51Ukk6vQRFs9L0Xqpi9Lr8JX/uoZVwgr2m9CQfWqyWBqHIyMjFxQke9
 3gNOq/IVDftcsfZS/9QNBhUJyPEU2bx2ucREv0tlgu9F8flPC/dE9Ar4Z94aHYKx71Dl
 kC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pmtUE6CWNphHSZJy2RiHgqGd+bsDBb/j0ec0z6BBHNM=;
 b=TEQ1lgTWEBsgSl3o+BTSb108UkYVvHUPOtbC0+yg4uvAsOIGqHpxUJxpt/EId4V1yh
 +qVTdDv9du2EV2fBhVatURAIEEulXH+0hhLep0cdI6/+FfdtUnHZ01Dq8xgZfFn464AA
 cimpQ+fpLOP/C5jtHgBH3G4L+1dgcVuUvS5KYJGaqrC78VauhhJYGLI11xs/TC6GIKZw
 AMekE7sVmy8tlEXXJmF8Q6EArMZF3rBvoPHNv4lL3r9wi8XHm0tMevKaOpM2cgoI/LuA
 e3mBBTAYvkkeEwDH3TvXJLTHUnx5wNuJdARUJpoFbykL5dhRYAWmXoNw+XVWimHUC3aU
 ZJXA==
X-Gm-Message-State: AOAM531bdMp+unQeteGbB5amESxknPgVcMPOkA+ko4c5kzHfAKei82Cf
 32UpcL+5ciTqpiC+zkT5G2bJVPAly5I=
X-Google-Smtp-Source: ABdhPJxDDPgrM4F1aCIiBnQdCbn16JTDKlHbPEnAQ6fIKMLyJdOtSqT1+ZcDq7EVu+33d30ssxQC8A==
X-Received: by 2002:ae9:f305:: with SMTP id p5mr1854026qkg.481.1602088361295; 
 Wed, 07 Oct 2020 09:32:41 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:40 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 38/50] drm/amdgpu: enable athub/mmhub PG for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:23 -0400
Message-Id: <20201007163135.1944186-39-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Set athub/mmhub PG flag for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 111637bb3ee5..229ec1d88bb6 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -913,7 +913,9 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_MC_LS;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
-			AMD_PG_SUPPORT_JPEG;
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_ATHUB |
+			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
