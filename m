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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A392C41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A93C62064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6nms8lt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93C62064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D006E971;
	Wed,  7 Oct 2020 16:32:41 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ECE76E972
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:40 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id 188so3409910qkk.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+li7XYnjKTAlB6ao/wKJkDXMz9yVDkY/YffAV39veGQ=;
 b=E6nms8lt9P/Gwa0MEcMPRY5KXzcRJGPukgWHZIfHoVios/ePqyw0iTCHTo7FdmOkhp
 azUKBGtlTviGDFv14Z8EMtFZjOZnDIwmF32N1Sxi66K7x2QzeuC0ToYI9YGCPYDIyHxi
 ZNU9zBFJ6ka8vOLahhZq0zYm2uDWuhBXiTssw2U7zbTEsQgg9BdkWdJHynBGwZsWMWUf
 Zk1fpKOZr5NL97qQZCuHNX0L8JI9+NSyh/MypQTdMBNS2y5zRdWWt0wGP0kobbzLQbGS
 jGRc0mA8/QYtOT6zkwuWUambfAR/mU/oE+Ntap0z3yQmTX7sAbvhyt1KCDVIdb/n0f4C
 Yicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+li7XYnjKTAlB6ao/wKJkDXMz9yVDkY/YffAV39veGQ=;
 b=gZQWIYQqaMfUR3ig75Tink99kazFq2RI0FtU2VcpPRUGg9wXdu3heisCYUOkCurS7w
 v1oxTa10iiKGYhcePu9pTKDRzJHxYfH3g/uxT9W6DDYrlo2j92dEqfdZIDfP71BrO483
 3BmepyZ/m2QUq56DTajhbK0/wE3o3uVVIEXfICQMWCM167RNKGQr6XMWmPwcg5HuvJKP
 2ZuzoeioKwmrVMVpr+ldiUEkOxI1IS8bwLj+79q8P07RwzhT8o1/DWmH3eBWKMkmz5c1
 CgTnN4cEeLXf/snwOSxanr0L+QXmsas/ub+/HF0ddnZi8LDAB6Bs6i7NAU2JJ0sodcnh
 POug==
X-Gm-Message-State: AOAM531lrizmm8BTiC6Q/H/il4GLcb1mhfhnPUvYQqkfdma14mKGCKDJ
 fSyyPRzDsE870960VsOFgvbRWLpMnR0=
X-Google-Smtp-Source: ABdhPJwW71F1amJRSw0VMONnEWwIPl5Kp2yuFYqfJEucPFmfqHK6AUtcJjxMBkb5+qnc94eAltk91A==
X-Received: by 2002:a37:a3d8:: with SMTP id m207mr3554043qke.175.1602088359178; 
 Wed, 07 Oct 2020 09:32:39 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:38 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 36/50] drm/amdgpu: enable GFX clock gating for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:21 -0400
Message-Id: <20201007163135.1944186-37-alexander.deucher@amd.com>
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

Enable GFX MGCG, CGCG and 3DCG for dimgrey_cavefish.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 12dc78bb2e25..371646f6cd8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -904,7 +904,10 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	case CHIP_DIMGREY_CAVEFISH:
-		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG |
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
