Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F78C28D13
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Aug 2022 13:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E5FC10E02D;
	Thu, 25 Aug 2022 13:32:23 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C7210E04A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 13:31:59 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id z2so26143715edc.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Aug 2022 06:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=f+V6Nsaz5rE7Eaif8vKpzM3qlOOSHI8TRyY6f9pXp6g=;
 b=DiNlw4LQFjcudqPuQ0n2/j39RMxyt6t90e1nZ5353h3dVA9laTRNDLTo22oA+NKzDl
 UWfjYbU2YozJwSH5xyGblCMqIdpPkvlgVvphDsdUwMEt5JFZlCVJLNp/ZlMnMlIOtnaV
 0yUxCof39ZcstmHYmADqLmE4Xwg0RJg0wJ1qDpZuQ2CUx7M9A2MTG8askLhgqzCfPg7f
 jK7OqlUuwf2T+E5TT4re60woVOK4XYp1lJykoampHWPOmaUra8Es9FYr59ilYIZ0IT9j
 xtorB+kjeFsrCcCg8zicK0S11BSMWhtep5FgWR5qclGWp8JXtPO6DI9TNdB6g/BEsXF5
 Ia+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=f+V6Nsaz5rE7Eaif8vKpzM3qlOOSHI8TRyY6f9pXp6g=;
 b=StxlnreDjpaP99YlEupzk+V83Gg7+Z84jZ/jXhYl6Kyzuq5X3fuTNeiGID7yvpiOML
 EQA/oJXDHKzx6X8Py/5BN3/Xor5XqWv0QF0vQJB9esPOKNARoOG49f7Mx7roXJH2B0i3
 HCcEavSGr8WTswmH+ns9G73O1jpy6GN1HSw2YZvORGzhQEaCf2cfLjA4zfSQBaDLd8BA
 8fkR89CPt6ahgZmKt8o6WAo1yg85pychuJQdppKxZ7mGgq7lvvp8OTBtGLIppkqMhpRH
 2DEu0jYWPbTeMaUXgm7Ajqs/rWjbduKNCP1jrSX/LkfH8xtd8c3QVTCLMdUJh/8irpFE
 2/6g==
X-Gm-Message-State: ACgBeo1Fgapg7rDfTIAwYBj8WVXR4YarZImQxxN5Gvw3KZv2hraqeIYn
 V43J6ZcKfNvTvpudVqjC/WVqX3omXryGaA==
X-Google-Smtp-Source: AA6agR5WJO57p4mf/ksHVVEybNvA0szE2ZphOOzdCpDp0mHVgi6+ScX6/77mI5L5XaAfC9L768fbyg==
X-Received: by 2002:a05:6402:1e90:b0:446:5aa1:808b with SMTP id
 f16-20020a0564021e9000b004465aa1808bmr3357971edf.90.1661434319243; 
 Thu, 25 Aug 2022 06:31:59 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a509b12000000b004404e290e7esm4913471edi.77.2022.08.25.06.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Aug 2022 06:31:58 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/11] drm/amdgpu: fix VCN3 and VCN4 instance limiting
Date: Thu, 25 Aug 2022 15:31:42 +0200
Message-Id: <20220825133142.8272-12-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220825133142.8272-1-christian.koenig@amd.com>
References: <20220825133142.8272-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Alexander.Deucher@amd.com, bas@basnieuwenhuizen.nl, timur.kristof@gmail.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Trigger.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check if the entity is already limited, not if it's assigned to the
first instance.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 5 ++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3cabceee5f57..5e64c3426728 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1862,13 +1862,12 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
 	uint32_t msg_lo = 0, msg_hi = 0;
 	unsigned i;
 	int r;
 
-	/* The first instance can decode anything */
-	if (!ring->me)
+	/* Abort if it's already limited */
+	if (job->base.entity->num_sched_list <= 1)
 		return 0;
 
 	for (i = 0; i < ib->length_dw; i += 2) {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 9338172eec8b..a8264fe2201d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1430,13 +1430,12 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.entity->rq->sched);
 	struct amdgpu_vcn_decode_buffer *decode_buffer;
 	uint64_t addr;
 	uint32_t val;
 
-	/* The first instance can decode anything */
-	if (!ring->me)
+	/* Abort if it's already limited */
+	if (job->base.entity->num_sched_list <= 1)
 		return 0;
 
 	/* unified queue ib header has 8 double words. */
-- 
2.25.1

