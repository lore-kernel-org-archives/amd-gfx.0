Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDE1FA3741
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 15:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193C310E528;
	Wed, 26 Oct 2022 15:36:19 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F071310E524;
 Wed, 26 Oct 2022 15:36:01 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id sc25so22278384ejc.12;
 Wed, 26 Oct 2022 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwUGcgzRYL20XpSh0K0nSFSgs1f9ZtaAcW2vydQz0LU=;
 b=pnHZ8lRXU6QOXaVzky78fYw1t1RPQO4+mnU+MymQVQiMShZ3KDQVkigOmMNuhxdU+r
 3M68z92K7vvjGR2FR2mvqov2Z1Sv6BQsUubvJjwFzHi2AozDJX/cIjM6lvW8ANSZWhJ3
 25YsD3gvUcGTRg4YEtR9ruRIU33XDuF9GAKuG2sr60Ud4GiQWoK8yYBZvwnajZDJfEeO
 cZNkXSPZDPW96lyjE+6QAFWZXb0dSIHMee78+jyDdqXSnFeFHWFUisG4bhfVyztDSYfQ
 XvnJv1YCrroijKTi5iQXnFUyRFVvySlrCL6XSfr+igCvzaj98s592kroUx8laYFThLpQ
 KVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwUGcgzRYL20XpSh0K0nSFSgs1f9ZtaAcW2vydQz0LU=;
 b=TCDg3/L2DKtjTpEeIL2UmAayioYnBSQ8gvJpvZ1AyyZMcM1exa96HXl0b2wo3yJX56
 06XEnDnkx8JecuwsVRhfPJPj9ohpskWocRYI6gAsD2YQXBH/8DPEZRqW0IIAYdQdhdBY
 0xpGasSSDvfwVU7YMChIjkoi1NZJNX+oPKRDQRF/M1mCAv268eW6MREE2c8sj+Z0LzHy
 enyQb1kSnOkTD0ayVztWChLqTHLaXM0zAs4R6xMbUN5oB4Hzu6ngIqPPj4ovZhoTJbmB
 BBnyvzKGMkgTOxqtRi/u5+rnvHJQv/MniXsefcYAanc2IK9h6N9ZHAS9OOLIZ3NIMLIk
 fJPg==
X-Gm-Message-State: ACrzQf1k2HIFTuPgV0lWp8CdVapKTOzY39fSFhPSQHsHAdBG2+FsLA2M
 /OgKHAs2SIazhQevXW6ejDE=
X-Google-Smtp-Source: AMsMyM4RonCJTgGO2vi93Fobxgvuj73s/9PEcnDNzuQKv50KxY6qrBcpKp91kPn5r4bkVqkqxkxfNA==
X-Received: by 2002:a17:907:a48:b0:7a7:3714:1629 with SMTP id
 be8-20020a1709070a4800b007a737141629mr15067907ejc.569.1666798560440; 
 Wed, 26 Oct 2022 08:36:00 -0700 (PDT)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 la3-20020a170907780300b007abafe43c3bsm3066715ejc.86.2022.10.26.08.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Oct 2022 08:36:00 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: luben.tuikov@amd.com, vprosyak@amd.com, Alexander.Deucher@amd.com,
 daniel.vetter@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: stop resubmitting jobs for bare metal reset
Date: Wed, 26 Oct 2022 17:35:54 +0200
Message-Id: <20221026153557.63541-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221026153557.63541-1-christian.koenig@amd.com>
References: <20221026153557.63541-1-christian.koenig@amd.com>
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

Re-submitting IBs by the kernel has many problems because pre-
requisite state is not automatically re-created as well. In
other words neither binary semaphores nor things like ring
buffer pointers are in the state they should be when the
hardware starts to work on the IBs again.

Additional to that even after more than 5 years of
developing this feature it is still not stable and we have
massively problems getting the reference counts right.

As discussed with user space developers this behavior is not
helpful in the first place. For graphics and multimedia
workloads it makes much more sense to either completely
re-create the context or at least re-submitting the IBs
from userspace.

For compute use cases re-submitting is also not very
helpful since userspace must rely on the accuracy of
the result.

Because of this we stop this practice and instead just
properly note that the fence submission was canceled. The
only use case we keep the re-submission for now is SRIOV
and function level resets.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d4584e577b51..39e94feba1ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5288,7 +5288,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 				continue;
 
 			/* No point to resubmit jobs if we didn't HW reset*/
-			if (!tmp_adev->asic_reset_res && !job_signaled)
+			if (!tmp_adev->asic_reset_res && !job_signaled &&
+			    amdgpu_sriov_vf(tmp_adev))
 				drm_sched_resubmit_jobs(&ring->sched);
 
 			drm_sched_start(&ring->sched, !tmp_adev->asic_reset_res);
-- 
2.25.1

