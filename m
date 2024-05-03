Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9537C10F16
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 10:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA1110EC67;
	Mon,  6 May 2024 10:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wwh/3Qjp";
	dkim-atps=neutral
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E148611255C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 15:10:34 +0000 (UTC)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-2db6f5977e1so107152321fa.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714749033; x=1715353833; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6cA818j+GlhEcx44ZEaQerMzdrfyNCJNPL2WjQJyvUs=;
 b=Wwh/3QjpWnqEl9ZW8tE3+1eJhVN+PBOdeFtnnPLmh6ycht7AY62x/1cNxpmRAaBOzI
 nYQA9TrH0opzsi87yMBVvG8nk4Wb0diw16B0x/7op7+YwwDArAmhdjzXYy3qHFEfKdkw
 ozzX8v1zGlhz86rkKEe2JNSQPxFCUBoDA+yZdQH7bVVxAR17w0kYondsaQXYIgRxVWuz
 EgPWcvxnzz7I/EoYaOy5rHwDZRYumSiz4wDpCpJvWLk4cFukxX2xm8J3e+hvUsJU+CE9
 Yvq67G9gGVCMToTSulb0D9Tv7srV3Q4+4mQ0l2zqRdHxluQ/iBzIKtNBpqH95Fdiosiz
 iGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714749033; x=1715353833;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cA818j+GlhEcx44ZEaQerMzdrfyNCJNPL2WjQJyvUs=;
 b=dJP+tk9+a5Q4JmT4avvCkF4x/2d9oz53fNLTe0NZlPfeN3XhhiIH/ieWbXbIgUwLUn
 hkMDguet5pPnpYaqD7t5PHEkGWgTCa1rZE99BSQX+5cq8TnBhzigNpbzt8TC8IVNpwp4
 nPL1bP4RWeRFONZsKhhXUAmGgv/GKlc9tF1PSPJLwfAQvTSSZg6AxPqvuwQZXatOgpJS
 Hjctd1zuuDpOMPvYHHcM8r5xmWz9PIBv233mRucyk5MTYseLNMTwq+uu1msykgq44vB8
 m0HkvHv1GtZmkvF+U0J41mwBr6b6/p4gHU4QLH+gz7InYG5sxeMmPiFTAFwftGim2DFz
 gWyg==
X-Gm-Message-State: AOJu0YzkFzU2Cr2eKcmj1gQJmMiVxYDDWrYrv2DNpHKnk6FJCuYB4NlM
 /rxpoBmXGamO3zBjgtcImnisfGETmjqc2qW53C9F9yiQd2k50sLmmt7g14tmkM4=
X-Google-Smtp-Source: AGHT+IHaANcjPF/kV6xF/DVbR1bjO7nGLz706i72D0cuk0S/N50bV2lbcIq/iqeR4Rh5czshXwaDUw==
X-Received: by 2002:a05:651c:61e:b0:2e0:a574:4a13 with SMTP id
 k30-20020a05651c061e00b002e0a5744a13mr1756889lje.32.1714749032419; 
 Fri, 03 May 2024 08:10:32 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 k7-20020a7bc407000000b0041674bf7d4csm9540479wmi.48.2024.05.03.08.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 08:10:31 -0700 (PDT)
Date: Fri, 3 May 2024 18:10:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Likun.Gao@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [bug report] drm/amdgpu: Add sdma v7_0 ip block support (v7)
Message-ID: <1b173ebd-fd57-4593-aa0a-505ee6d84979@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 06 May 2024 09:59:59 +0000
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

Hello Likun Gao,

Commit b412351e91bd ("drm/amdgpu: Add sdma v7_0 ip block support
(v7)") from Jul 4, 2023 (linux-next), leads to the following Smatch
static checker warning:

	drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c:171 sdma_v7_0_ring_set_wptr()
	warn: duplicate check '*is_queue_unmap' (previous on line 161)

drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
    140 static void sdma_v7_0_ring_set_wptr(struct amdgpu_ring *ring)
    141 {
    142         struct amdgpu_device *adev = ring->adev;
    143         uint32_t *wptr_saved;
    144         uint32_t *is_queue_unmap;
    145         uint64_t aggregated_db_index;
    146         uint32_t mqd_size = adev->mqds[AMDGPU_HW_IP_DMA].mqd_size;
    147 
    148         DRM_DEBUG("Setting write pointer\n");
    149 
    150         if (ring->is_mes_queue) {
    151                 wptr_saved = (uint32_t *)(ring->mqd_ptr + mqd_size);
    152                 is_queue_unmap = (uint32_t *)(ring->mqd_ptr + mqd_size +
                        ^^^^^^^^^^^^^^^^
Set here

    153                                               sizeof(uint32_t));
    154                 aggregated_db_index =
    155                         amdgpu_mes_get_aggregated_doorbell_index(adev,
    156                                                          ring->hw_prio);
    157 
    158                 atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
    159                              ring->wptr << 2);
    160                 *wptr_saved = ring->wptr << 2;
    161                 if (*is_queue_unmap) {
                            ^^^^^^^^^^^^^^^
Checked here

    162                         WDOORBELL64(aggregated_db_index, ring->wptr << 2);
    163                         DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
    164                                         ring->doorbell_index, ring->wptr << 2);
    165                         WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
    166                 } else {
    167                         DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
    168                                         ring->doorbell_index, ring->wptr << 2);
    169                         WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
    170 
--> 171                         if (*is_queue_unmap)
                                    ^^^^^^^^^^^^^^^
This is dead code.  We know it's false.

    172                                 WDOORBELL64(aggregated_db_index,
    173                                             ring->wptr << 2);
    174                 }
    175         } else {
    176                 if (ring->use_doorbell) {
    177                         DRM_DEBUG("Using doorbell -- "
    178                                   "wptr_offs == 0x%08x "

regards,
dan carpenter
