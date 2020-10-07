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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252E2C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22E62064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKxXOHf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22E62064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDCB56E969;
	Wed,  7 Oct 2020 16:32:35 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 795696E966
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:34 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id s7so3419039qkh.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S0E+RiiQ6C8dEXxOoIaKPeU99CeLiGLnqcl1Jaxinlc=;
 b=gKxXOHf3jvxx0cOd92GT/V3aYHT3IKHyLSBYF7JzgzBpwv4ZisXERa0Ii1695goEoJ
 7OcBQm/1qPs/2IS8wIbuK1ZKVGUE2hson60Dxox0MzL4vQQCRj8dNKcdgj7+9czLs35T
 Qs994ImNaa3LRBh39JUao/+/k608VnBuTQPLn0HxDtMdMmyuVFvIE9imH4Zs8r6hr0dH
 0+eY2xmiLjBmmUKvuui058JT9X6Cp/7AaiMYf3+TVu74W99244Q+XBZlTw6YZSYHwjD4
 0lhUkCc3KRp/13TJae6h7nU28hfd3ta6oQcW4GndlmE0NR2MapJ6bVHvyjIcBBAr6+YB
 D6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S0E+RiiQ6C8dEXxOoIaKPeU99CeLiGLnqcl1Jaxinlc=;
 b=tgYyzm+dYlEdlSlMY+WOTZPCcWt/FelDQOjEyvwRYyzTckmPT1gD0R6Q+1KWLodcvB
 pD9l3mtHzIdAs2TaObwqDBfp7/3TLmcK9CfoqovWYJ0iE/x5+bY6L8ywkXNVsfaUWUoI
 m66hqS9jFF/dVaJp7iesYP3BpixpoPUwqnZpeCqh2hKcSC/fnOsv5xgBEXkxwaZvc8ih
 zfTlqI4WIIstKD7/TT1utowFm3et+83WSYTVRF1Ps9Nb732DoEU/veHSvpxtfVbKIx5i
 fPbWIVC915NbSNLdCFQOa0FeAWo1g+3mgj+a7apM+P4i8qRD7IaGgDTHK1MG+33b718n
 ghdQ==
X-Gm-Message-State: AOAM533spr1+mqU4Ozboe0Vw8IwMDh+c0lEMjjV8FoOarASe3vVy68Dg
 FOQNarxEBUppGD9yz8Pyl9af5msOSvQ=
X-Google-Smtp-Source: ABdhPJz+DeGcWuu0MIH9w6C0XtEjsxYvE3cZx93ijOu2zMCu62kLnIRGycA6MJhEVm0tXVhDbUyrVg==
X-Received: by 2002:a05:620a:1275:: with SMTP id
 b21mr3480412qkl.135.1602088353525; 
 Wed, 07 Oct 2020 09:32:33 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:32 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 31/50] drm/amdgpu: enable VCN3.0 PG and CG for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:16 -0400
Message-Id: <20201007163135.1944186-32-alexander.deucher@amd.com>
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
 Kenneth Feng <kenneth.feng@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Enable VCN3.0 PG and CG for dimgrey_cavefish

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 94ccacd786ce..45177edee516 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -904,8 +904,9 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	case CHIP_DIMGREY_CAVEFISH:
-		adev->cg_flags = 0;
-		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG;
+		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x3c;
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
