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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A344C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73591223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNl66UvT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73591223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AABD6E859;
	Tue, 14 Jul 2020 18:24:55 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE796E862
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:53 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id k18so13575607qtm.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=F2pLbE2X2Np4lugBQU68DI4j5/KntXuc6EJG/uhewOI=;
 b=vNl66UvTRMz7432oHq57sTWNvWOmdDOqjFHJyExivDMXcvEuhUzwb+CNz+ThXxp/Aj
 NEU2Vie/AO9GZaUit3TAG3TDEVCVofEZfNd8IWB8J1PwEL1FnpNPu5Dp0iJxDLUGIBYW
 KCewuC5cdcRYICxE6G90GT2AVgnQhnYgIrKyrFHpULysr/e3grRrrBExFMOPYKu/1bJ0
 giuYPI2cUMLZhqB+VlFmk1pUMTPfhh+VKngEh7OnUNjQUjDw3mnHNV3SBaoWKUjan49a
 nYuyZNSzo6g9DF6+BPPGhWo72LqM8kGfLXikrUDGHKwyOMiz3r5NqhiUAY9Ti3ktfaVz
 4Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=F2pLbE2X2Np4lugBQU68DI4j5/KntXuc6EJG/uhewOI=;
 b=GSWsVrQ9gNI17CQthKi+FwZYLZq1INHAosta6Y4xoJLsH1hYttTa5CQPI58csSz4N6
 hAPA+Joyyyh6E25KbdWErW2aCwd5CrdQpU6QJeefll7x1ykz4pJly/X1seAuvFDW4ygK
 mese4cGZGdznw81bRouSFLSLe+SiPA8JhP2BluDjJAgOApugjeDZEyqhqdMzbPWbfwMa
 +pQhyq0SgBTVo8HEnTSLf3OhvcTMH6RM5WlxdanP7jxBEJXzprZ62L8WXzm8RyKnkKcc
 TuzwtM0etEE3tDL9HUthCAq0kDMSF3xk0Tb9siB2vWu7vR3A0P+jfk2yvUfNWpoSqa4A
 WqfQ==
X-Gm-Message-State: AOAM533xTsUCJeMtkg/0y5RV8uoDPhub1xkS7R2t9M3NS/G/pTqpIJg2
 NVY2pjL6q43UOvjX4wwgqrmucHUj
X-Google-Smtp-Source: ABdhPJy4a959ze2tkQrkLeRIsopynW8qiq3oBDbrYsN/+VqM+gKWpnPlSh2uQgnmXXQHqlk2pAFvFw==
X-Received: by 2002:ac8:788:: with SMTP id l8mr6119825qth.177.1594751092570;
 Tue, 14 Jul 2020 11:24:52 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:51 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/42] drm/amdgpu: enable VCN3.0 DPG for navy_flounder
Date: Tue, 14 Jul 2020 14:23:44 -0400
Message-Id: <20200714182353.2164930-34-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Enable VCN3.0 DPG for navy_flounder by setting up the flag to the ASIC

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 5f8fa4994c97..2af335b2edec 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -756,7 +756,8 @@ static int nv_common_early_init(void *handle)
 		break;
 	case CHIP_NAVY_FLOUNDER:
 		adev->cg_flags = AMD_CG_SUPPORT_VCN_MGCG;
-		adev->pg_flags = AMD_PG_SUPPORT_VCN;
+		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_VCN_DPG;
 		adev->external_rev_id = adev->rev_id + 0x32;
 		break;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
