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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81031C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E9C2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3siOztu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E9C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D33F6E31D;
	Mon,  1 Jun 2020 18:21:31 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E69D6E316
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:30 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id w90so8473765qtd.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GFRh0dLvLd4GFSxF7VFOtmRmf53wftYESsQ5P/1h+64=;
 b=S3siOztuMzVvtZo3x00q9Z85snCYTGpnjnvNf46LjgbgyxjsEM7byt/mIaIEQIEfLn
 Fj4N4JumVzSGuGxT4P9mF3RExnRD22B+0YhfPZ6DdaW5cnnCoYJlzI1H9yYzHMp7Sy0o
 mzAPSLxWV2QeJNVIRLIw9MvhCmSpSzRbWvQraH8Y6lsXm7ICd99lAY1FB3neVdu+QBmJ
 sawzI+CzmsgLYGPkH/FXtmVIvxydSp0X0Pg+B1A9tnUNLbndGayZUr46lklJZsw90oNx
 hhk3zQnb3K0jOel4rx9ueLhkdLfCQKBA80zOYSBe9kDzAsy6OEE+DyVryujLY8wJPCmg
 nrbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GFRh0dLvLd4GFSxF7VFOtmRmf53wftYESsQ5P/1h+64=;
 b=iyOkGalDbBLhW1sou/CKBpeMSB1bIM/YOk9P1eQUNSfrIhlw33f4gLyx8CdoPjtRtz
 ouo+ZzJiO3o+iXUNtKevGkxkGbtan5RUcmOzRB78D/dSfNeatc9fcnjKEo9DRXE/KM++
 xOedrSAkF6QX7MA7+Vb1ZImgjqF1WqgEa11ZaDplhJB11rM6wsj3XMH9Wwl1Hpqpk1Nq
 sqovrXJ8utA7L+18mZi6wgP6egFDaIz9x5ljWBh7iyX0jCrJtk3OGigq0NbcF+Fy4tfS
 ImiYfz/5Wyln7QfLhBewRyiu2PcGBpamNUG6nl3GVH8OXbFURFtMoUWXBYUIESCoDrqN
 Cf0w==
X-Gm-Message-State: AOAM530Sj1ayUawkNaFCH4e3Ugs+ohAWdVyjVV2e45Drh8LQI+tomT3G
 PJGLwB+uBN9HH0jHibbsJW5grpC0
X-Google-Smtp-Source: ABdhPJxyKLptF7B2IYhZxlFkSVSmfgT5uxK3aZwYwI+s6Ssm1z5Qgo47e+k0ZGgVd11R1ThX8dQuMQ==
X-Received: by 2002:ac8:73ca:: with SMTP id v10mr7512702qtp.270.1591035689034; 
 Mon, 01 Jun 2020 11:21:29 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:28 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 109/207] drm/amd/amdgpu: add IH cg support
Date: Mon,  1 Jun 2020 14:19:16 -0400
Message-Id: <20200601182054.1267858-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

IH cg verified

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index f497fbcc6f5c..9559eaf25591 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -720,7 +720,8 @@ static int nv_common_early_init(void *handle)
 			AMD_CG_SUPPORT_VCN_MGCG |
 			AMD_CG_SUPPORT_JPEG_MGCG |
 			AMD_CG_SUPPORT_HDP_MGCG |
-			AMD_CG_SUPPORT_HDP_LS;
+			AMD_CG_SUPPORT_HDP_LS |
+			AMD_CG_SUPPORT_IH_CG;
 		adev->pg_flags = AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_JPEG;
 		adev->external_rev_id = adev->rev_id + 0x28;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
