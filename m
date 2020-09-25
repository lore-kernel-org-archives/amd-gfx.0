Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC087C4741F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AC8C2399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl1ysvB3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC8C2399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF096ED53;
	Fri, 25 Sep 2020 20:11:07 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6516ED4A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:06 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id c18so3087197qtw.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kSE9kc/oWEd70zJ0lkkMMt+FUyiLFoZ+gFAJPre47WA=;
 b=cl1ysvB3ktQ6ZT5wWTWIxlpkgQAdhjbbT4h7/FKdza4p1bAW0XW6eksFSidZNry94U
 kt2UXQ0NU6SL62LLfrLtbIvLhqdTn6B2u3GF2yLBl9hxHJ5lsf09sGmxmbUrogt+fqI3
 T9fexhlpzFguDKH2qSa/rD4A+hTK3j2qZbC7ZEdI3bFu/XLupw11HnGpJt/1aI+2DP3U
 j+r1prLV8HvX1SH00vDQP2doxGrMz5LniywpbEFujpnrNAeMLi2MM5HVsUQBDb7cieKs
 ZO6+xZNh5g/vFWP9WzDbzg7ySKGM28k25tEIj7w6sQx8bIa0ouzYWoOvl4J6cciNp7Be
 iE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kSE9kc/oWEd70zJ0lkkMMt+FUyiLFoZ+gFAJPre47WA=;
 b=msKzzM5mxk7TFgJMFZH8GYB43MyLkBO4qFbv5I7HeIpqYu4m0btRXggYP5HywoAqKb
 IRl2WmDRn+IGLV2ba8/rzpXcYI21WsQozSbpWK75bv80sto4tBQE2nuoPQZBIj98faeS
 86trrqpx7Mjc2Gesu1PF7lOnybljeJgKWiqNULMTdHrJVsdRd8FVahnrcMs0Eh9gbr+u
 0GmgjWMWkakcvvDnD4W6q9EuR4PWYjvuFpxTG0hRQ0EXGLJetc+IcC5WYypWHL4s98xK
 UpNr8OFS5M2uu3G6meNZJIfGx0tHm3/47iX6xbC1+Qrjed77QOd4KxkTJ12dTfxeAtWy
 +qBA==
X-Gm-Message-State: AOAM53344IS/UMnQRd/Xfrtig/op4QCGT+5Ev4Ss7sKrUIaal568Ndmf
 g3pDoI9c8wpodp3ZRwqgA4P6ch5TxXA=
X-Google-Smtp-Source: ABdhPJzonJIaZFdC9PvpI0K/MyBaM99UCmK/MShpHd2vrCOZ4imnn4o/pVlMs9QG/tlEBdn349tW+g==
X-Received: by 2002:ac8:6f21:: with SMTP id i1mr1372298qtv.89.1601064664965;
 Fri, 25 Sep 2020 13:11:04 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/45] drm/amdgpu: add nv common ip block support for van gogh
Date: Fri, 25 Sep 2020 16:09:50 -0400
Message-Id: <20200925201029.1738724-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

This patch adds common ip support for van gogh.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index bc894cfba60c..2077f897d6eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -478,6 +478,9 @@ static int nv_reg_base_init(struct amdgpu_device *adev)
 	case CHIP_NAVY_FLOUNDER:
 		sienna_cichlid_reg_base_init(adev);
 		break;
+	case CHIP_VANGOGH:
+		vangogh_reg_base_init(adev);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -858,6 +861,11 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x32;
 		break;
 
+	case CHIP_VANGOGH:
+		adev->cg_flags = 0;
+		adev->pg_flags = 0;
+		adev->external_rev_id = adev->rev_id + 0x01;
+		break;
 	default:
 		/* FIXME: not supported yet */
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
