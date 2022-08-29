Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82144ECAAD4
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B07310F268;
	Mon, 29 Aug 2022 13:18:50 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852B210F251
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:18:38 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id z8so1288596edb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc;
 bh=xuQPau6oCI+xeLmpJuQfpUl7wqVwTtKwjGAeMu89Eds=;
 b=BRauwTQJIXgucgIDWUGL+4er1Xq0f/kHUwVltWdLnLDg3FPI3m40bgXYAsDFoW0a8a
 Jk6NNz2innKGPO0VK7ZE9XX96a7CFrblbYsjeBJ4XaecIojH5Q/QnPR59XoUcQGdtCwT
 jaS2/9joqZ5ih0gk3KfvGz1UjQcQUGsb70u6s18RxFKrPyxPXM/coSTYQTEK34hEr9+E
 AnHqMxN2WTa+LNJSIBiUPBaHS79Dj3PWNleeRKhsNFxlTkcyhwhVjQzLiD7OiIy7KeEn
 SYhFgAkcxLnchoVk9av6Rmc/7n3LS2NESigWRCH9CT0EFVKbgpmX5S03IuDk81gTGgwM
 M/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
 bh=xuQPau6oCI+xeLmpJuQfpUl7wqVwTtKwjGAeMu89Eds=;
 b=nIBZRHoTRjz0hDTngBevNUPuPu19Zrhtql2sNx8n2vFnVmVV71fy4c2Zc4oKfpczL2
 Kl+c12H54ilLkXbK4Ks8JTmj015kxgzGNItW1Hj1OvZ2cEn63hhXgxgOSf1ZngduTzRX
 XpDyy8dMvxEEYC7vXBCqc5Dh4HeqgTGGAqlWLy3Y0jmS9URz/5t84FJteGb1bPvdzrQg
 gk62Ybu2k8VTPQXFhJK/sg0Vs/owjx30iWJDpxawMwuhpG9SUjrP7wll0idfFJ7IMuyB
 6WdgCEt1/uDx3W202bhcnZqdI3tlNb1QEoOeysjdC9wiEx9gcQ+yGMtkoYvX3YA24J4J
 Lhug==
X-Gm-Message-State: ACgBeo3CeWlGLaTmCV71z3sHBPgGbXiNqruZw2XuuoU+WBsSRF1MO8xs
 dQ+VXGAaO3G2wSmWhxbY5BLGU0y9utk=
X-Google-Smtp-Source: AA6agR4AUw6kBpnqvMwRoe1nEHOSzSgiwyq/ERk++AK0mGeBVJbc3xGHeVWmSoUVqLGgYzrU+GvEPw==
X-Received: by 2002:a05:6402:518b:b0:448:f30:38b0 with SMTP id
 q11-20020a056402518b00b004480f3038b0mr9769422edd.164.1661779116725; 
 Mon, 29 Aug 2022 06:18:36 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 z22-20020a50cd16000000b00445f9faf13csm5726218edi.72.2022.08.29.06.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Aug 2022 06:18:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Ruijing.Dong@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/11] drm/amdgpu: cleanup VCN3 and VCN4 instance limiting v2
Date: Mon, 29 Aug 2022 15:18:21 +0200
Message-Id: <20220829131821.2049-12-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829131821.2049-1-christian.koenig@amd.com>
References: <20220829131821.2049-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check if the entity is already limited, not if it's assigned to the
first instance.

v2: only a cleanup, not a fix

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

