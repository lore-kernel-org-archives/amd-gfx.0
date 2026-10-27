Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CBF606A31F
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wbinvd.org header.i=@wbinvd.org header.a=rsa-sha256 header.s=wbinvd header.b=aJSeNNoH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20B6010FC30;
	Wed, 28 Oct 2026 12:59:58 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF8010F81C
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 20:36:19 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-35c76e9614aso438793eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wbinvd.org; s=wbinvd; t=1793133379; x=1793738179; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n/kXFw9Qj82REiZi7BMptrUs1FkkIpA4DyKMU4QAqcI=;
 b=aJSeNNoHgPvHJeAgr1Yh2wXHu63xx9tUE8l5UCZFGTHncRa7Zy/hnVyJivfoxE0lzg
 bHSIJ1oe4XRPfeNcQgcMrhCRwjO9fA2M1TEa2ruaK6myZ4bAGh4Ag0eLRKVPSjc2kk4Q
 tpn+PgLwep6imW1nN0ca1PzvH2BL+fgjqHQUKKWhpAggi/qn+wzV2SF66biC221nA1CG
 c8iZVtUNAge6N+jX124aL4xmgzhnXwZahG//SXy7LohqXuM0FTDtij/sn/NbLCRFrfxv
 3iVb6mFRBcmLLM6NACApAh7dxLYjoCXMHRd2fESOqzIkHR2cFrDQIdp15zylE/T/0P2X
 Fk8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793133379; x=1793738179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n/kXFw9Qj82REiZi7BMptrUs1FkkIpA4DyKMU4QAqcI=;
 b=r1L60qprwxOqdNxkpm89bMvf3w/Ng0B05/qjwp5HZ1hnL4L7Imh096tHZhw8jIN2f7
 woYlNnDxXFEsnsPqDk+9Oks0B1lPGrpZ3RjI8zrHtx8l9FC3QjGSBVgJHdfaQ1w/llHk
 J3lNbixapnHR+3MOAEbOOrFD8AGByZWDwHaf0iDA7s3z0+JdUBHtW8G0J3hXXYmf32IR
 0q+ePeuUHynjRRrsoxw9R1ls438O8rhM9GNLtt8yrJoFYuGCplwzalb8VIp9VcLh4b3D
 gsCc2m5B+VrYcUW9CqNoFHl8tj7M1+373ew2OHtif1aoveeA4zEk43ByJFr4KUunB42L
 dgrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxR5qPo0RXppiDqCktHvSuyypoP08IBDHK8oW+3roh9DTJVpNGk7AfvMqa3y8ARe2giREj1r1hO@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIOycmv86pwbtkLMufd9b8NLrcec7MU8vGQeFZgsCWtAtenKf1W
 3z7NUEM7sapjuYqn0OoEfY5wo0V02kN0i60npSHwWTkgnDY8ayV0pNAb6lnMeE5lgKA=
X-Gm-Gg: AYBFou3qHMABSgGQTz5q28vhJ/qRqF4FlLICsjnDzJz/j7aoLVtyPpZxyVYli2L9JzU
 deVhjKP/ujbcxrrIPxGtT5JP4yTKCujev2c6Q7IUJ23xgDN9UxcPRviSUi0lFozCOnQR+tPF7TT
 1Uti/gq3NzKpYy6dr2eVj1t+BNkujwxsNqv9orQjujk8b18Xz2AZBeHrNBvyPUqTqo5mbUXpSEH
 RhXnSdCsa1EOHoHyhl+t9l2Gxywn8Rdid/PqMDTzQ66MPTzJ5HOe8PX7lHx58zHoBManw1e6a78
 S1ZERyD9IUDEPmDNKpluET9FotFpU/9t6wwvQEcKW0vaAWdhis7HuTB19jlW2fSyNiUiOKfhCaD
 0bJpNT8/DK/UIuPHh8dpwn20brnkRjTmRAepj1zwCzd2nfNxQEM/cKKC5oZEj/KMsN/CXVImrE0
 NRtAJjRdL4xSrC3io501uAbntZmJMtCJTnb7PsmyHu7ZB943wlJNfKPJP1V0QKtn5U/vPvmJjgF
 cHDUliYATsEllj+dr4KdAUHYVAuCleR7ZBtpYeNb9nwlnfL+RZ+6kI0Zns=
X-Received: by 2002:a05:693c:41d4:10b0:369:f64e:7feb with SMTP id
 5a478bee46e88-36a202d5efcmr770087eec.2.1793133378769; 
 Tue, 27 Oct 2026 13:36:18 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:a9d7:ed20:8d1b:4227])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a14383b02sm9457218eec.14.2026.10.27.13.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 13:36:18 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, George Zhang <george.zhang@amd.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] Revert "drm/amd/display: Allocate DCN32/1 dmub memory to GTT"
Date: Tue, 27 Oct 2026 13:35:26 -0700
Message-ID: <25995707c39c0c191e3ac46c4813f55a7f928403.1793131583.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 12:59:51 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After commit a637a140ab860310 ("drm/amd/display: Allocate DCN32/1 dmub
memory to GTT"), a machine with a Radeon RX 7900 shows random garbage on
the screen. It reproduces sporadically, but at times it is so bad the
machine is more or less unusable.

The garbage is always horizontal bars extending across the entire
screen, always approximately 200 pixels tall on a 3840x2160 screen,
for what looks like a single frame. The bars are mostly black, but will
sometimes exhibit striping and periodic artifacts which smell like
non-framebuffer data is being rendered to the screen.

It took some patience on the "good" side, but I was able to nail it down
to commit a637a140ab860310818a14fb4d37e39e51a06be4 with this bisect:

  bad: [cee9395acd8043be0644b25c34bfa86623f2b935] Linux 7.3-rc1
  good: [8d3ae59288f1e7d58d76558a6ee96d533bc5019f] Linux 7.2
  good: [55ab7e14222e5f0b0fd9f7711ca391d2924b35e3] Merge tag 'for-7.3/block-20260819' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
  bad: [df51bdc5e80dae43cab81f6cc641e98638303c88] Merge tag 'mtd/for-7.3' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux
  bad: [29daacacf4cd84e6917f09de6a99fb170071c14c] Merge tag 'drm-rust-next-2026-08-08' of https://gitlab.freedesktop.org/drm/rust/kernel into drm-next
  good: [fff648aec5e2790d117a0ec5c849a284d9d33d70] drm/amdgpu: include amdgpu_video_codecs.h only where needed
  bad: [336e0cd576817ac64a4b394ca2b3680029f3e37f] Revert "drm/amdgpu: fix aperture mapping leak"
  bad: [789f7486a384ca58b9d7a76abba5efa0e80e8dab] drm/amd/display: Test plane colorop helper walkers
  good: [e0e426f10ad653c5e9dd33fb4a76d55f06101992] drm/amd/display: Test helper_check_state rejects
  bad: [982b2a43682b55e7d9800000f2592832ff2865ba] drm/amdgpu: Fix IP block NULL check during soft reset
  bad: [9102b39fa924dcc3dc75a3137bfa9633c40b88c0] drm/amdgpu/userq: fix indefinite fence wait during GPU reset
  bad: [b23470a026afe64de5c1df4ad181587b49c22923] drm/amd/display: Exit LS for ISHARP before coefficient write
  bad: [f02b2e47355e9d381a7f34acc997e1c47879ca21] drm/amd/display: Add KUnit test for wb jobs
  bad: [c6a13d145cc811b19c8a0620f25868cf7d5700c0] drm/amd/display: remove unused dcn42 socbb values
  good: [1d8327353de6f1f34063840f362c208c84064f54] drm/amd/display: Fix VABC Init and OLED Support
  bad: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Allocate DCN32/1 dmub memory to GTT
  first 'bad' commit: [a637a140ab860310818a14fb4d37e39e51a06be4] drm/amd/display: Allocate DCN32/1 dmub memory to GTT

Sure enough, reverting a637a140ab860310818a14fb4d37e39e51a06be4 on top
of v7.3 completely and totally eliminates the problem for me.

Mikhail has separately reported this regression:

  https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/

...but it seems to be much more consistent for me than for Mikhail, it's
never taken more than 30 minutes even when the machine is completely
idle. I've also never been able to reproduce any artifact one single
time without commit a637a140, despite a lot of effort.

I'm not sure reverting this is the right way forward, since presumably
this would re-regress the timing issue Fangzhi alluded to in the
original commit. But nobody has proposed anything concrete yet... so
let's start the discussion here.

I'm happy to help test other better ideas as well :)

Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 9ff25bc8ee5ae..870534b7cf46d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -511,7 +511,6 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		DMUB_WINDOW_MEMORY_TYPE_FB,		/* DMUB_WINDOW_CURSOR_OFFLOAD */
 	};
 	int r;
-	int mem_domain = AMDGPU_GEM_DOMAIN_GTT;
 
 	switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 	case IP_VERSION(2, 1, 0):
@@ -648,19 +647,13 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	/* Limit to allocate dmub to GTT on DCN32/1
-	 * TODO: Other asics with GDDR7 may have worse latency
-	 */
-	if (dmub_asic != DMUB_ASIC_DCN32 &&
-	    dmub_asic != DMUB_ASIC_DCN321)
-		mem_domain |= AMDGPU_GEM_DOMAIN_VRAM;
-
 	/*
 	 * Allocate a framebuffer based on the total size of all the regions.
 	 * TODO: Move this into GART.
 	 */
 	r = amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
-				    mem_domain,
+				    AMDGPU_GEM_DOMAIN_VRAM |
+				    AMDGPU_GEM_DOMAIN_GTT,
 				    &adev->dm.dmub_bo,
 				    &adev->dm.dmub_bo_gpu_addr,
 				    &adev->dm.dmub_bo_cpu_addr);
-- 
2.47.3

