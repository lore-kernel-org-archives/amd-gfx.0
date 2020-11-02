Return-Path: <SRS0=PoT7=EI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F58C4742C
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 17:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7AFC21D91
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2020 17:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpLkXv3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AFC21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AE7F6E47E;
	Mon,  2 Nov 2020 17:44:48 +0000 (UTC)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C0E6E0DC;
 Mon,  2 Nov 2020 17:17:05 +0000 (UTC)
Received: by mail-pl1-x642.google.com with SMTP id b19so7151234pld.0;
 Mon, 02 Nov 2020 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=a0jYTmrFpdw95OyIRLlDuQeZ5xit+fHnq5W5rVj7juA=;
 b=VpLkXv3FGasnw6RWFjbzBHclWI38P4gsSsNqXgS6d11F7eDNPz8jieDqz1GfhXrowq
 VG9eE9esFFmJ1hqZ6b/YDr3U1xF9lwwlNX03ZM0LRJyTPg09csiv/4n07l5bHGiecQr/
 lDPamuHlPhk8Kxjz7rrWg5y2doc0SFZzJM0XaXt1kAtJs5TXYVUn0zShcNE9GaQIyIm9
 Nrkcae3MkVppfjUk35bRCgiL1+Cx+a9rjiYxtwhNnTadoRHNxWt3+KwJTWhjBWU2r0oV
 7zOhUX01tvJDluzsQi9AE7UOyk4GpLRYG9LXpmcXrMLm91yuPPozaXppA0q944QRTFdE
 zGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a0jYTmrFpdw95OyIRLlDuQeZ5xit+fHnq5W5rVj7juA=;
 b=HoJJY1DItHBhLR90ubcRvX75fH3d8hO0YUyXvALEulPY70hOUUqCZpDSPXxpcyOopB
 YSx33mbH0yJ8yDUezODRBcjokdnJlrpItwtiTAd2Ye+uVPj29tjh0fzqAMLwuHnmmwc3
 t5tokAO2JRqmTHOosaL0xFQtijh7SKWKaykNEQuTUkPtXjudZPV8UiJRXodEWgquhSuF
 GaZk0f7tB8UZ7/Qu5XR1QAOdO7sFBpw1Bz0Jr5MfeolSByig7JtsbrrsdhPjcwYNPYeY
 fsTefqXvqYnQP8f1jOsoMWTYao4YR8GNWU9wP+U43tDTWXUi/p8fnaK+QW+HP6CBLvnu
 vSeQ==
X-Gm-Message-State: AOAM533WFgiE7pELVM4gFLfQCEcK+qYEYvN8nTfWD7ZhUkS2ln5fp3AN
 kZSsWwFWhqerjEBcEHm/9ss=
X-Google-Smtp-Source: ABdhPJzBvEf8/a8mYK9gWC2o0GG6EkLwG/D1jjlRP3lTFRhwncusiDCdB/RROZx1ly3sBcCr6BQDqQ==
X-Received: by 2002:a17:902:a589:b029:d6:856a:2978 with SMTP id
 az9-20020a170902a589b02900d6856a2978mr21413557plb.67.1604337424893; 
 Mon, 02 Nov 2020 09:17:04 -0800 (PST)
Received: from localhost ([160.202.157.3])
 by smtp.gmail.com with ESMTPSA id j11sm13951700pfc.64.2020.11.02.09.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:17:04 -0800 (PST)
Date: Mon, 2 Nov 2020 22:46:58 +0530
From: Deepak R Varma <mh12gx2825@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, gregkh@linuxfoundation.org,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] drm/amdgpu/gfx: improve code indentation and alignment
Message-ID: <8a81ed33f995301350742aff6cce0463e37c8bb0.1604336791.git.mh12gx2825@gmail.com>
References: <d644879c4cac32a7cbdbbeebc97c98efd421e17f.1604336791.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d644879c4cac32a7cbdbbeebc97c98efd421e17f.1604336791.git.mh12gx2825@gmail.com>
X-Mailman-Approved-At: Mon, 02 Nov 2020 17:44:47 +0000
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
Cc: melissa.srw@gmail.com, daniel.vetter@ffwll.ch, mh12gx2825@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

General code indentation and alignment changes such as replace spaces
by tabs or align function arguments as per the coding style
guidelines. Issue reported by checkpatch script.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 56fdbe626d30..987f9b6dbc3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3192,7 +3192,7 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v10_0_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
-                                 struct amdgpu_cu_info *cu_info);
+				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance);
@@ -4200,10 +4200,10 @@ static void gfx_v10_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v10_0_select_me_pipe_q(struct amdgpu_device *adev,
-									  u32 me, u32 pipe, u32 q, u32 vm)
- {
-       nv_grbm_select(adev, me, pipe, q, vm);
- }
+				       u32 me, u32 pipe, u32 q, u32 vm)
+{
+	nv_grbm_select(adev, me, pipe, q, vm);
+}
 
 
 static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 94b7e0531d09..3e9a230f84df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5058,7 +5058,7 @@ static int gfx_v8_0_pre_soft_reset(void *handle)
 		gfx_v8_0_cp_compute_enable(adev, false);
 	}
 
-       return 0;
+	return 0;
 }
 
 static int gfx_v8_0_soft_reset(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6959aebae6d4..48f98c750956 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -787,7 +787,7 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
-                                 struct amdgpu_cu_info *cu_info);
+				struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
