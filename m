Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A56BCAC59A
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 12:44:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A90D810E827;
	Thu, 18 Sep 2025 12:44:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UkEILYcL";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C16110E68A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 09:46:47 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-45f2acb5f42so5358965e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758188806; x=1758793606; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IJAzy7TZLPpiK0Xxbzu1n/iJ3JX7fhsQtzUstUQDi6k=;
 b=UkEILYcLJDfYD/wyeyhz9413hMw5eM44VefXoikph9tVlJLNEQuyiqPC+IwKIN7Y9n
 /X7ceRLI8S/fEsX1AuLz2g+XWrOs26xPer06TLqjU93KgkcIC+GSfZ0bEyWGY5J4YqFm
 miANuGe9hqHQgePYK6y5rlN4XQlBvl9/o4Sc4fhR7o9PG2NztPhfmsf05B7yniwfBai7
 guE+AuB1H/NMj7vau0KIEwNG+EvoIbXB4HX3sMwY02bfDKJnVwJkA5jUcanC66PO+8sy
 89VsWZhlO9hgyX+0mJgHCStgvvrOl/1EYxYhXx9zfzMrnfuaaZIrzzy+hWtYYrNaMyj5
 rgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758188806; x=1758793606;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IJAzy7TZLPpiK0Xxbzu1n/iJ3JX7fhsQtzUstUQDi6k=;
 b=GPHHJK9zEHoXsFWo9NPalwd96lDlzaQcDow45Cbi1PfZV4dC09Xvoe2JYkeZ48T+xO
 VbaMUrtfXSmqdIT2dlAkSaQ7Wiswhd29oz0nWudJwIJ1YEBp/2e4+OE3lJUi/NDSMCUs
 WOGwerlp1w27ywfnZf8z6jp5v65tckk+vkDSZ16e9go35Wy4yKDHnmsYIPOzh6maCsay
 YH2bqUzyitsCHo+irF9ChtFv8krEl4E4IKBaAkEZ3rDmo/Dz/JqRJSiiBA4rHV7ZvoPq
 mRSG4AQY12N0xcpEdQ0bOpxfoa6+uGGTdkS/NkJAuR9bHXsBVqc0IThtfXM8XI1ElqFm
 3yoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj6hNEI4+XiLF4jIPW0dutF87lnMvN5Sv0AbYSsYrXaYgYIRxIDWCFCCSSZv6keTn9X4dyc/oo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwxLENvU2l5YinKlce0taSgDyDTehOSVugsAjdZuDo1dtfL5qt1
 c6Tmde7Co/jfcaFUuFHF06KH/O9JY1rwob5SgB/oKGWmEMJ2vyIxFlaRHZAp7l7NDxQ=
X-Gm-Gg: ASbGncsmxH/lVKbb6JgncSwDd2DKI152zH7AI27B052Grv4JX5s2tL+NyTbxwanelmQ
 JDl0Yth1u+ko2WFvxwPFcYT4gPyUtq2oeGfWK2NLQO7JuhC2FvlBaeTim3ibdbecogM9kpgupIx
 YAzXTk/cNhMwqEaOPrdgRw3rjGD1kBkSxLnj4IgmtwerJiasC7YSq/XUeE3G9x5bxLBzdAhsXlK
 GarTMq5v+N3iiKrDR1RmIMQXbU2A7l3Bt0+6JyWyMud9nN7o7n5uFO64y295leeJUlxusCmloo1
 bJjVdl5Qd/fkN6HIqJeIs9tO2ttcj/CL7Bk2lcQ212zXyG+N4La06iTa35UHqRw2dk5Hyyc3gwC
 A+EhXk1SXdnqhmTStwUAZcG5nrqtlcq1mQhMLBIuc9u21ow==
X-Google-Smtp-Source: AGHT+IH1uv0RIxQ38Bm26GanPvGmDL+dRiH2jf2osh70wH0uYOlhbcgFH9gpcU5WdxVF0lInLAkHNQ==
X-Received: by 2002:a05:600c:8905:b0:459:d577:bd24 with SMTP id
 5b1f17b1804b1-464f79bed6cmr20555095e9.7.1758188805990; 
 Thu, 18 Sep 2025 02:46:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-46138694957sm84698395e9.4.2025.09.18.02.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 02:46:45 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:46:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Arvind Yadav <Arvind.Yadav@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu/userq: Fix error codes in
 mes_userq_mqd_create()
Message-ID: <aMvVAsrczM9W2S7P@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 18 Sep 2025 12:44:21 +0000
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

Return the error code if amdgpu_userq_input_va_validate() fails.  Don't
return success.

Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address and size")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2db9b2c63693..775b0bd5d6c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -298,8 +298,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
-		if (amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
-		    max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE)))
+		r = amdgpu_userq_input_va_validate(queue->vm, compute_mqd->eop_va,
+		    max_t(u32, PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE));
+		if (r)
 			goto free_mqd;
 
 		userq_props->eop_gpu_addr = compute_mqd->eop_va;
@@ -330,8 +331,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		userq_props->tmz_queue =
 			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
 
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
-		    shadow_info.shadow_size))
+		r = amdgpu_userq_input_va_validate(queue->vm, mqd_gfx_v11->shadow_va,
+		    shadow_info.shadow_size);
+		if (r)
 			goto free_mqd;
 
 		kfree(mqd_gfx_v11);
@@ -351,8 +353,9 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 			goto free_mqd;
 		}
 
-		if (amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
-		    shadow_info.csa_size))
+		r = amdgpu_userq_input_va_validate(queue->vm, mqd_sdma_v11->csa_va,
+		    shadow_info.csa_size);
+		if (r)
 			goto free_mqd;
 
 		userq_props->csa_addr = mqd_sdma_v11->csa_va;
-- 
2.51.0

