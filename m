Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C3FC5B567
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5020B10E6AD;
	Mon, 10 Aug 2026 06:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OC/SxMU6";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9679E10E074
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 19:41:35 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so8435435e9.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 12:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786218094; x=1786822894; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gQVcGNcLq6m/6ixB9nJIXsf/NAsejBiY35GyaVjtWxw=;
 b=OC/SxMU6eZrzbZZpxsRjYjwIIB1s88d90MJGFoSJPL2jkHrqLJIzgTQ3X2vG8pUOyp
 6F6d1ll1/asMQIRAK0jHDfe9MaqkdtBpS9RV5myWkDV3JsMXIeNzBY5WppFWTqg82YvE
 7z0khvRWlhkK3TApVPEIDejVBXYBLqvdvFcVHJ3hY2VDg/GYHEzIE6RGTBuwe9HEhkn7
 S+qbXVdSuURtk9YRoQ54xGwtFGCCvAttHmjc//OvPdFplJkvvqJbmsGBhlo8GwCrV0MA
 TvP6ecQTwn1QqBwwCPM+IcJNILloqKuAcWU+EJ5bkURUr/p4+qxSLJkk2xcPm/NY6te3
 d34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786218094; x=1786822894;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gQVcGNcLq6m/6ixB9nJIXsf/NAsejBiY35GyaVjtWxw=;
 b=ihgY9RNWGqNKu45qzcAFwjC5Seo0axSjY4oRKmbpO4GKdGSLjx8GuWbpqaR+Y590ok
 yTLR6Kvn7NVwIuDitRMnAkftsoSS1uw6DZW8ogqpuAjK22I66FSdqYoUa97vMbPtWQgl
 Hee4KmFPGnvsCKGQ+771DfYAGSr0EkWpCGDJ5oyUQMW/uqNZNlrbqPzp9RwT9NnE6fmB
 vBvNjM5FQjzecJz21X5q9WE8+cDHTt/9cIh+JVwAnTvWGUGa6es+S7xCwazTt8jz3P/d
 YZudBahlu/q+mIQYJPNvJ8GsTMbDoZjUZrrMfjp895IDN1Zoh7r9iRZG1ZLyQyJGQAh4
 HCXw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpcbkv7dv6iElcWrgyeL9EKjZ9FBF77g+NLbKvrTgd2f4raopSbeJEOhgm23iUi7THqQyJoS7Su@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxHtqYGZ846f4A7iyc5y1mYpTDQkUQj4efAGFrKjtlBza+Q7696
 Tem+tRvKN8ydaNN55dRliNdinpN8T0NIXIcejmkZye2IfWj6DGWhwPvV
X-Gm-Gg: AR+sD117GzmKO+qYOk9I9GltT77jLgdt2AZXcVVQbR2YcoTWpq7EjHp5B9vdEBM8Ku/
 RzUTRQj+aKue/nA8jKTX8GT/WC8yQmeQN5GAKz2VkXkXFyhwZqvkRogEwfz0hbLcn7aLjMeZzsc
 kRaGZVkJiPs+/7pr76MH9Zz8MmIA+c3TmPulYrM4nqcq3suhn3srmY1+yXrZCMoGqKsJCF/cSoT
 0cggPpqwDCwzAlH2YZdgjr2V3wxTbzh13nj8YfaMBOK5uPE7+2UaV4Xy0Jpj2ZScHfTBegO8ZPn
 ZIgS01KStWLZVcWOKiPHlTh1xxgVMDnZWFvCi9L+y4jADZodrrTB2Kk190F0swSboueXcYOKR9g
 lWmYx54T2qnTByVt7Z4WxMm4pEsxMD1YdAKRRWbiaSEgCpDRBp4siB0X8zT+5fiMpau7wP7PsNI
 hGIkPpGhUOy/pxFZy0o1WyS1QZKYA7AtzFSEpO3CssjIzuADGnrUrR3x1U+u/6ncV2R5g=
X-Received: by 2002:a05:600c:3b20:b0:499:4893:97d3 with SMTP id
 5b1f17b1804b1-4994e7cb8ebmr390890085e9.13.1786218093825; 
 Sat, 08 Aug 2026 12:41:33 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e7b3fsm18742073f8f.20.2026.08.08.12.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 12:41:33 -0700 (PDT)
Date: Sat, 8 Aug 2026 22:41:28 +0300
From: Dan Carpenter <error27@gmail.com>
To: Asad Kamal <asad.kamal@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lijo Lazar <lijo.lazar@amd.com>, Yang Wang <kevinyang.wang@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/pm: silence uninitialized variable warnings
Message-ID: <aneGaKJUl_Jyu05n@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Smatch complains that:

    drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu15/smu_v15_0_8_ppt.c:1964
    smu_v15_0_8_set_performance_level() error: uninitialized symbol 'ret'.

In this line there is an "if (ret)" condition where "ret" is either
zero or uninitialized.  Initialize "ret" at the start of the function to
avoid a potential uninitialized variable bug.  But also delete the
condition since it is never true.

Fixes: 422b399b09c7 ("drm/amd/pm: Add od_edit_dpm_table support")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 59fdd2319b66..c78e611d2a25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@ -1920,7 +1920,7 @@ static int smu_v15_0_8_set_performance_level(struct smu_context *smu,
 	struct smu_dpm_table *gfx_table = &dpm_context->dpm_tables.gfx_table;
 	struct smu_dpm_table *uclk_table = &dpm_context->dpm_tables.uclk_table;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
-	int ret;
+	int ret = 0;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
@@ -1961,9 +1961,6 @@ static int smu_v15_0_8_set_performance_level(struct smu_context *smu,
 				SMU_DPM_TABLE_MAX(uclk_table);
 		}
 
-		if (ret)
-			goto out;
-
 		smu_cmn_reset_custom_level(smu);
 
 		break;
-- 
2.53.0

