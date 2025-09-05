Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769EDCA0FED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 12:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3E910E0CD;
	Fri,  5 Sep 2025 12:47:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YS6WZLou";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A01010E0CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 12:47:46 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-61cf8280f02so3148820a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 05:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757076465; x=1757681265; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8V0H1OLCZfxiuu8XQBcN8nx8RzoFwF3Uk2NY17W+lRo=;
 b=YS6WZLouOh2TTl2YpDDR6dGyFxOkUb6MU63WiizWYAHu2ypUMIDPPM7A6bn4/DQ7pD
 Wiat64WdzJ0l9PfjyH766PcS3JmkoulusVGT/xdQXzzr82+Y4M/BLRZQXkbC033I6EoI
 ZMTXbwcDEvSEAw0sq1WH9kMawtVrsTB6R/ruS2mjaOYL941YxyU+1HiE0cKfniVanGNe
 DicoIJcyDumP4hsgi/0AoyDv1Auuncljc/VlCi5SFmUk9l23NRIC2UJXBqE3VFvVv24Y
 TRR636NHqDt0u3RQWS4mCDY1YL5W6rmxtuUSqma7GwMhkJ7TGNJl0f64v4un2UkU9fP0
 T1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757076465; x=1757681265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8V0H1OLCZfxiuu8XQBcN8nx8RzoFwF3Uk2NY17W+lRo=;
 b=LXc/A+F7SpFfCHJLr0F6ZOvGjLj/tKQAgGjnPf+E9Ih+0arT6oy6TGsyFUP+7QyPg3
 Yhmbijo6W6NdJ5IselvwkGnbLvYQaYfv1qrIvNeDE3l5fsNuLILOydUWeylGKOrtEx34
 BmKI2Ih1lfH62iyolgNS6eNqsF/h8C4j50X/Xl3g8Lqi++OFxedFRTfPTNl+iEMjD3Xz
 acJ4BWinXDkJyxAbLQQSmnrzEj1D1UALRtRdzvrVxQyQBBGSM+eV7C0gThEJ09e/iyb/
 WDBJeNKqla6IdDHzQMx6bImxnr2HSD4imbS8kFG2xBlXKmK1JPPOBEIcOZ6c0Fp+7JpE
 p7kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiFNiYy/aGSHbcSXFM9e6FDxP+3tCeWrNORUX/VeBBRV8xiowCpWYyC8EDv05TUOIJrAHYS3XE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8QWzp/n+GNcL1Ta+2/qjfHli1HunTz6ooVZ67Je4N4uJEKIet
 7EfWJpq2b3F88hvWMP4y3St4+2/W/tqbV41KUHOlGxmpBpYEBZz0cL2I
X-Gm-Gg: ASbGncv8hzfDyjNaoR3SAucGHg1uoMthiN8bzbE6p1W2T+oF9lUPVaxyYKi1uxSknq5
 wS1Ardsp8VkYiP4i9efHccrHfe2FoEVw+80pTngZtPXrNZJHbSvZHzPm1+7IxP16Ly7v/JIEoGo
 x7RmLJfQpJMbzC56hTM4PltpLIS7dXDDvH6h1aTiEjn/EjCCcf2223X4x25mbdmTa3DDqWTebBJ
 QqSpsV49RyyK8k8R80l5IOvILTzbdn/letH2/fKFxiXM42O4TgtTpQ03TaLBrvHgRpcQgHTdHdg
 Lsrb9YMz4L9JNVuDE25mSicD7fSTKsDPsbxq5N3SLv/ZnYw3k4Tp3TezF2dVJ0qI7gJWxYlL+tW
 CwuqLP6JFiOMexufIvneSJ23LAOrbh9KPxQl/
X-Google-Smtp-Source: AGHT+IELOtK5IRFTcUBKUkUyGQElbrgw77RU/Lsl576EKQ+bUF8j1WgE1Z51ERqnvOTtVzg6S9mwJw==
X-Received: by 2002:a05:6402:3508:b0:61c:30cf:885a with SMTP id
 4fb4d7f45d1cf-61d2686a2b1mr20839046a12.7.1757076464537; 
 Fri, 05 Sep 2025 05:47:44 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bd:7900:c026:1908:2e29:be84])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-621421b9debsm1513006a12.34.2025.09.05.05.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 05:47:44 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: timur.kristof@gmail.com
Subject: [PATCH 2/2] drm/amdgpu: reject gang submissions under SRIOV
Date: Fri,  5 Sep 2025 14:47:42 +0200
Message-ID: <20250905124742.11305-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905124742.11305-1-christian.koenig@amd.com>
References: <20250905124742.11305-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Gang submission means that the kernel driver guarantees that multiple
submissions are executed on the HW at the same time on different engines.

Background is that those submissions then depend on each other and each
can't finish stand alone.

SRIOV now uses world switch to preempt submissions on the engines to allow
sharing the HW resources between multiple VFs.

The problem is now that the SRIOV world switch can't know about such inter
dependencies and will cause a timeout if it waits for a partially running
gang submission.

To conclude SRIOV and gang submissions are fundamentally incompatible at
the moment. For now just disable them.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2ac9729e4c86..434a551365c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -286,7 +286,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 		}
 	}
 
-	if (!p->gang_size) {
+	if (!p->gang_size || (amdgpu_sriov_vf(p->adev) && p->gang_size > 1)) {
 		ret = -EINVAL;
 		goto free_all_kdata;
 	}
-- 
2.43.0

