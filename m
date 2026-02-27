Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FC6FD532A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 09:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54AE210EAA1;
	Fri, 27 Feb 2026 09:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="A+6pYEIX";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD7310EA4E
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 07:55:09 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-48379a42f76so13028525e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 23:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772178908; x=1772783708; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0bo1+MeHyz3oo0R9LPXDVH4BNCFrZ2q0p2S2NbLydZI=;
 b=A+6pYEIXWEW7cWn8OIuPXubR9GI76T5KDQvZKHwYHhqS1GOgaLABxHrz+oYTiRWxSE
 +H2zBp0xvbRwCc7iWacIxYJ7dnUPSAZQhmVrHFYK3RULG81VocebYyf3GRMr5EgCsRtD
 E29ZcK+l74HbfSZKTcsp/1qlPelWSm+yCMvGfz3PYwqcxEUqteJw2cjO7K60BbEYoHTz
 ovYqADgeq6kuvmTJzhxpcTHCyD+PP2LHR9R7x/G7zqwTxY1Q4o9pB04VIAkj9gtvB+jE
 HaT8JF7Fz1S5jF/lsc6xAMEMZmhUSU7RCD2s5TjsttgEUTRWueGIgxF6R0RjNLyJiqL7
 +ZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772178908; x=1772783708;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0bo1+MeHyz3oo0R9LPXDVH4BNCFrZ2q0p2S2NbLydZI=;
 b=KXAEDubpV8UP16RMvgVEw24dlnZHL8FE98fRzHSXamdFDQzSmaAMvLWT3t/0HUBf5s
 0feGdjIcrrze40Zf2yBUcD7f7nFqK4mv0pPMzEH+UbUThIL6MGjZdE/6BlxzWquV5amG
 MRuy/RSUHWyTEltWVA5xylcVSlDczrXTVXKLetZSGtMGEPHB2glgYY8qh1AYh2bHYpZR
 xYKMBF1YbvKwqFaJsE/9ZfU+RgWeVZm31nLOZMkoB7UOnh6W2JirvyhezDbqs2VvmjiL
 Q9zfMhzJT6KEn7UxYKrpJNzagrVj3kjFpPOP6U7johjPkGF+yCpFGxfHSpxgAp+sumu/
 RQLA==
X-Gm-Message-State: AOJu0YxcP3tpxuw/xFHQbbkLH6GKkfeITDWqTyGp4mJzt/Pzz2YkxLvV
 /e8zg65ZUPm/cROwO4eVgSYalonJSACPQjW8wdyvDM4Y6KdFELemDRwfjNKkQIggZ8k=
X-Gm-Gg: ATEYQzwM02t2RP43TEWf1mp8bKLaMqxyMg7U+GJvdIXUT7On616S/o9/e5GVctysGHj
 t8Px9VZNnqLC4E4rPOD+nW9yKL0MYtKYPItwXZ4rhgscNcKhMYbmz2uldVLbpQMJMus/twXKKxe
 N2ZkVg7XvWJsBYKDep2jV9jjuciw0YEtY8rWP1svps2HtYKS5sbOhrG916bT7TEDdLRcm9F7cHx
 An7+BkEaaHDTZDXsTWYGah6sk3PEH3mJFJFUogF5jgrgdVugjIX0caIFeZFw5OZjs8IibGRmpkX
 CbISTb4oL0bEmqYnKyaTo1MhJYWXyLIAZQdxZJRGLByleXSZZzknthHo3W0M8PQkPX91vEt4A7f
 VS3s46AocZPwu5F/LsxtNxW1yecEeiHsReo7R1Rpb0NWDwWNFzGn++WH470bIDsmhAxgCLYnewi
 z4zBh8Di+4kKzgLf/LI3dQc5G+aNef
X-Received: by 2002:a05:600c:828c:b0:482:dbd7:a1c1 with SMTP id
 5b1f17b1804b1-483c9c23c72mr23232475e9.34.1772178907803; 
 Thu, 26 Feb 2026 23:55:07 -0800 (PST)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7507adsm219000415e9.9.2026.02.26.23.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 23:55:07 -0800 (PST)
Date: Fri, 27 Feb 2026 10:55:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amdgpu: add missing lock in amdgpu_benchmark_do_move
Message-ID: <aaFN2JyOolrjynKP@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 27 Feb 2026 09:17:17 +0000
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

[ Smatch checking is paused while we raise funding. #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Pierre-Eric Pelloux-Prayer,

Commit 30f2daedf4d8 ("drm/amdgpu: add missing lock in
amdgpu_benchmark_do_move") from Nov 18, 2025 (linux-next), leads to
the following Smatch static checker warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c:57 amdgpu_benchmark_do_move()
	warn: inconsistent returns '&adev->mman.default_entity.lock'.

drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
    31 static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
    32                                     uint64_t saddr, uint64_t daddr, int n, s64 *time_ms)
    33 {
    34         ktime_t stime, etime;
    35         struct dma_fence *fence;
    36         int i, r;
    37 
    38         mutex_lock(&adev->mman.default_entity.lock);
    39         stime = ktime_get();
    40         for (i = 0; i < n; i++) {
    41                 r = amdgpu_copy_buffer(adev, &adev->mman.default_entity,
    42                                        saddr, daddr, size, NULL, &fence,
    43                                        false, 0);
    44                 if (r)
    45                         goto exit_do_move;
    46                 r = dma_fence_wait(fence, false);
    47                 dma_fence_put(fence);
    48                 if (r)
    49                         goto exit_do_move;
    50         }
    51         mutex_unlock(&adev->mman.default_entity.lock);
    52 
    53 exit_do_move:

The unlock should be after the exit_do_move label.

    54         etime = ktime_get();
    55         *time_ms = ktime_ms_delta(etime, stime);
    56 
--> 57         return r;
    58 }

regards,
dan carpenter
