Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B416DC77B72
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 11:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D2F10E2CD;
	Thu, 20 Apr 2023 11:58:00 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B51910E27C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 11:57:59 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id c9so5875743ejz.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681991877; x=1684583877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0N7N4u1E4zTI0mHX2ZbJqWHmjtZPDaeWWfFthO13c5g=;
 b=VugA7WTDmmf2XCd1yH/8Jfh8KSJskg+qb6GnFBlu46b4uLBWTDLEIyFv6nqRjr5FXT
 wA8tsLjt52Ywj9kZ3bicZxsl972ysYGwtAlY/hd9+buDzRj5TXsasiE4tN/5hpLvAF+v
 8u5FORCkG/ru0GYaAdZiJL1IQnq324pd9XxuF8lYqPcHKH0vDSJENEYDC1rmk9o0YIpK
 TpOkGmfnkYPt2SxJONKaaLO+6feZasvyrh8FREfPmeBMLj21o2DXX+gtizSifMLYoozW
 /spoXzGUGolUW4ms4Q4O7JNFQxktqsWPozaC7XfHjGjpibB7XuQDQSD/l50VgO41L+KP
 3OFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681991877; x=1684583877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0N7N4u1E4zTI0mHX2ZbJqWHmjtZPDaeWWfFthO13c5g=;
 b=NNcK7ohCJTJ0NtgiI5gy4Ficc+0k2im6CC9u2k2pOFkB5rAMWd/nR+EjBWJFnf5V8K
 kaeFwZaD7kKDsC7LIs0Fl5r6uSg8YFYQ9P+7fvSHCaoMAi+cAH82zYjFiU6TVhkbyqnJ
 Rw2AdSDWQ5azttBonZ8mUcIISS52lz4grXsKFhqyJbbsvCqX8x8/cJbkB2vW134ztbdP
 Fa24Kfycu7jOTmjyd1++EaFIJJL83CGOwm3YinEqynmberwKyTv8j1lWGiToyaPt2cVu
 e0KkXn6Y6D6WJxCl64PvrHHGxrqQyttgFoLzmHZ8Kf0Ja7EcttjsqPhXBU2/vz1yuzow
 2S6g==
X-Gm-Message-State: AAQBX9dZq01yOAwflA5NSxSh4xygI/a2W7Tm7L9B4YysYLI852iWlyUE
 LWNi/WoNk7NJtvLWG1TdrlXVr0sVixHn3w==
X-Google-Smtp-Source: AKy350bQ+G8UetWPDIw9rEvuDHJRh7sp/BZtVORXoUEIHDa8Zxct89kfC3XFoQ1OhQ/trJKdKr4IUA==
X-Received: by 2002:a17:906:1dd6:b0:94f:928a:af0f with SMTP id
 v22-20020a1709061dd600b0094f928aaf0fmr1194331ejh.47.1681991877572; 
 Thu, 20 Apr 2023 04:57:57 -0700 (PDT)
Received: from able.fritz.box (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a170906645400b0095342bfb701sm689385ejn.16.2023.04.20.04.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 04:57:57 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu: mark force completed fences with -ECANCELED
Date: Thu, 20 Apr 2023 13:57:48 +0200
Message-Id: <20230420115752.31470-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230420115752.31470-1-christian.koenig@amd.com>
References: <20230420115752.31470-1-christian.koenig@amd.com>
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
Cc: luben.tuikov@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When we force complete fences we should mark them as canceled.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 877fae84b8ed..a7627cc0118d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -725,6 +725,7 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
  */
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
 {
+	amdgpu_fence_driver_set_error(ring, -ECANCELED);
 	amdgpu_fence_write(ring, ring->fence_drv.sync_seq);
 	amdgpu_fence_process(ring);
 }
-- 
2.34.1

