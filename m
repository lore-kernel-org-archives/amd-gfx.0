Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B081CCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35D0E10E461;
	Mon, 13 Oct 2025 14:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WgcBJWS6";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00B1810E45E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:06 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6364eb29e74so7569552a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366105; x=1760970905; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YZPF3TsDwqw3Z9G6KN4eJ0Uvl8lh/hd0MSmrorlao90=;
 b=WgcBJWS6h/lVC/GDbc6ki7knfNyGmIZQtKRshklVlt9wl2DARcmuk2o3gWLcMTpp8e
 D/km8fpUy6+ogx+AUVY2GJkvnZRZ1l+8zBD0fJl/cwrRQ2Wz1PtyaxjJGTUb6SZO5UhE
 OE14lt72ShXpAL1etB7hp1wCLNkY1nn+iOXzWPbJhyIP8uBOrFigR1OnvyHjZYIBP6wX
 t8U/Cr7NX7pCuOq+DsQojpixkfrPWfMtHTsfT7d1v0bb04TJqq3vbnHZSPi5D2bmCf9l
 lEx+HppzYpq9tK/cZPZir757LGr6zRQlQlN+jjVUKlRtGzN/rIX4qGM4oLl5If7w1VV+
 PmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366105; x=1760970905;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YZPF3TsDwqw3Z9G6KN4eJ0Uvl8lh/hd0MSmrorlao90=;
 b=ocm8aGwE4Qd1iKHp75gGcs3m+LEySOVEAYO+UzM4SMjhW817C8YrlsVUN/aozWZyMB
 hN/TqEWWzgZHJXcACmpQHy1LezGGJB1gh7gHpvSpAhbp0xXGheV8Zgs7XBbKHUq5tOmz
 Th4u+cYATiRVSGJMS+vRDTF6f4n5hP4WRFTpZKICqF47+TN1iKw77rCBnwccB9kBkDWS
 KiGLsJ45JOW2LbfAcgpIkWNvtjxFx6wfB9fN8ntpiLLWD4vPsDAApa1H+qXpQ5al4YMt
 VuUs0JAmIB1fBWWgBN+tBI4VIM1HLhbJjNS3XOnR8RKu5XGHnEzg3L+KQPovSNqdwslu
 pQ7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEY5a8KM1ItB23ry41x8b5ECrs97NOVKM/+/uDIiXLLm/twxho9iR/uLg+eOjI/JM1SJQ7k7xZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz3q2Ad7Z3ya0iTVYrKJ02p1BVVpzrVfGkTpY9hsDH9bVr8VWTe
 9lJ+T/lT3UaRJqo0tUhg+u5s7/GuajVknf2TnkKy2W3ag23MARMqyO50
X-Gm-Gg: ASbGncsnv9AAZqIN2DtNK9qDBPxJDs21Zt1JO8ce8X0YY/67uW3Ul+xDt0HqxGskBMP
 PR14DQusL4g55HxdtbYObztLWLujR0ZWBTeifdgqV+c7lND0hAYnsu+QloPK0utRSPNtIYYtPDl
 KJLYTJTVCIllS1z5JW3o46E4kLwMPZrQMrrJgAv4f8nliK/4U2+8i88OX9svssc/u1/vwc/FDbk
 P0EzSBrlaxb6RrJ7+Dv6zeyFgpglF2ShqlbRXeQezvgaPI4BsQpoE/nIK03RPDSGzjJHkkx1Kii
 M5EKkQBed2MohrMgzVTLfMJqgw3baArDynH0P3bdApKmiwTnUVfOHMMwsXo3ttLO62h3ec9uXiE
 o6ccNkRwGU3xWI+7RsEWDhFY/RQFo/Gbe2Edk2f/bVZwGj5H2zaGsIfA6IBzcnvK+3w==
X-Google-Smtp-Source: AGHT+IGs/aNwZAUk3NKcgSt1hAEhaNDM53lJclve2de3HSTb59YjSiCLEeLKHZJKg92EZaBGz33KPA==
X-Received: by 2002:a05:6402:1453:b0:639:fefb:996a with SMTP id
 4fb4d7f45d1cf-639fefc0db9mr14527206a12.12.1760366105193; 
 Mon, 13 Oct 2025 07:35:05 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:04 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: Independence for dma_fences!
Date: Mon, 13 Oct 2025 15:48:27 +0200
Message-ID: <20251013143502.1655-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

Hi everyone,

dma_fences have ever lived under the tyranny dictated by the module
lifetime of their issuer, leading to crashes should anybody still holding
a reference to a dma_fence when the module of the issuer was unloaded.

But those days are over! The patch set following this mail finally
implements a way for issuers to release their dma_fence out of this
slavery and outlive the module who originally created them.

Previously various approaches have been discussed, including changing the
locking semantics of the dma_fence callbacks (by me) as well as using the
drm scheduler as intermediate layer (by Sima) to disconnect dma_fences
from their actual users.

Changing the locking semantics turned out to be much more trickier than
originally thought because especially on older drivers (nouveau, radeon,
but also i915) this locking semantics is actually needed for correct
operation.

Using the drm_scheduler as intermediate layer is still a good idea and
should probably be implemented to make live simpler for some drivers, but
doesn't work for all use cases. Especially TLB flush fences, preemption
fences and userqueue fences don't go through the drm scheduler because it
doesn't make sense for them.

Tvrtko did some really nice prerequisite work by protecting the returned
strings of the dma_fence_ops by RCU. This way dma_fence creators where
able to just wait for an RCU grace period after fence signaling before
they could be save to free those data structures.

Now this patch set here goes a step further and protects the whole
dma_fence_ops structure by RCU, so that after the fence signals the
pointer to the dma_fence_ops is set to NULL when there is no wait nor
release callback given. All functionality which use the dma_fence_ops
reference are put inside an RCU critical section, except for the
deprecated issuer specific wait and of course the optional release
callback.

Additional to the RCU changes the lock protecting the dma_fence state
previously had to be allocated external. This set here now changes the
functionality to make that external lock optional and allows dma_fences
to use an inline lock and be self contained.

The new approach is then applied to amdgpu allowing the module to be
unloaded even when dma_fences issued by it are still around.

Please review and comment,
Christian.

