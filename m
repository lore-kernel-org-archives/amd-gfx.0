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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B0C433EC
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:25:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B48223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwz84oBn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B48223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B266E6E865;
	Tue, 14 Jul 2020 18:25:02 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654F06E865
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:25:01 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id e13so16534495qkg.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hGzB8/rmv61XkfY7+2+uFKKbR+XpOgTRWnjz2DI0q3o=;
 b=lwz84oBnQoljgtIr1inuwjLilXy9ZfPHvZ5Z/uD/SdGtnb+GfWwIjX5zzwJo3zly9x
 /ZZW+aYgQeFLWfO3LAdf2eHxlBEWr22IXmQ3AinaAUXzaNTkoNdNqMSGOhaJIgrdIbwT
 QL2/wZo05kEGMESoUP2ts6cv6nT1Y7Jvsy3tLFrsmBOWDHNHWfhdLe4gqkSjOxfPou9x
 jzZRphwR4Z4rSO+uHYdJxkaEEG3HX4ksptCTJ17dYn78SDyJ+hJBjWP0fG68IRJrXFQT
 TJT4gTkHmobQEugUUdKTZN7pKwsxg2+YG5v7P/C3SzsetinCYmukmwFS61Mmo4BS22Sk
 eWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hGzB8/rmv61XkfY7+2+uFKKbR+XpOgTRWnjz2DI0q3o=;
 b=mM6tfOgHokefq4xmugj3a+X9RW+dFCfY3rz2FPzhOCHdu/DTUo7Bc4ouH1h17uhDzJ
 oMKRJax4tPGKH4Q8gnuwPH7aFsQP1Z4U+IXSqwN0vMV7WWrEhUcatxxp7+QtNN2RWw0L
 RqJaKJH8cm/GSEeXEmMOsvs6WnDbQAZalATXNN827t634YmP5Nb4Cjf2rKS545BWE/wQ
 lrawC3Om5c2GdTwblEDpfsdlKH3eMOrqtO76qujurMf2uzliTu2npj6bPycy5VYbM4Yd
 claBxdKFhleOw8lIECYLPW5OW+t1zT1KyRBd5DJg5vKviKWMSwBZf/L+v24nuYAwdayj
 SbSQ==
X-Gm-Message-State: AOAM531Xh/Taa3d3KQXZH8FbPwj9BNmdmcijglzeqbKR/Ue552vzaa5v
 450l6MiAmjoXXx30/tPz/1AwYRRZ
X-Google-Smtp-Source: ABdhPJz37EWwKpYrGb5Y4FGlgR9sfqSMyzgoIG59YFbh9u0diXrvhnxUADrOaX7dHvKBhpD9RBhfvw==
X-Received: by 2002:ae9:de45:: with SMTP id s66mr5672271qkf.360.1594751100320; 
 Tue, 14 Jul 2020 11:25:00 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:59 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 39/42] drm/amdgpu: enable athub/mmhub PG for navy_flounder
Date: Tue, 14 Jul 2020 14:23:50 -0400
Message-Id: <20200714182353.2164930-40-alexander.deucher@amd.com>
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
 Kenneth Feng <kenneth.feng@amd.com>, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Enable athub/mmhub PG by setting the corresponding flags.
Actually the enablement is exercised by PMFW.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 31e4036b110c..1260d7d138ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -766,7 +766,9 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_JPEG_MGCG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
-			AMD_PG_SUPPORT_JPEG;
+			AMD_PG_SUPPORT_JPEG |
+			AMD_PG_SUPPORT_ATHUB |
+			AMD_PG_SUPPORT_MMHUB;
 		adev->external_rev_id = adev->rev_id + 0x32;
 		break;
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
