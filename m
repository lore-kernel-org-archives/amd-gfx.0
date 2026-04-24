Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA38FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D516010E628;
	Mon, 27 Apr 2026 08:37:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6dTGwlj";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FF110F5AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 14:08:18 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7dccb8644c4so2502799a34.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 07:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777039698; x=1777644498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9YAH8g2v2vBsoZmgPxB7XwrigYCMZajRhN5tYq8MvnA=;
 b=C6dTGwljJ3iu3qjJ3QV0ce4eTHjRI+vTOocAx1H6wHQsPrAOc0jcyGrlRKCqgm28DC
 SyFesGWiZ5ZHNZO3wuj0QzYnrs80NkG8xHoo49Y4GNU5Hds96F6DAaihKTWz5WFmaUKO
 fi9xvKihqs2pxdomz7dYpHDMs7xp+rBj6kUZtt+8dYCSf5eeI3RiMFsx0Iv1q/7u2nQK
 tth8X6EzVVwFtl62yHCA3AH4QvPzvG5cEIUMTHxlVOazUqc8cxDDYPCZ86t3QAhHi9V2
 C5qTgz0r8vpWZihlC15LaVY7oAl19aTaZJzQKNi0Hfz7v32R2+USkrxUx9QRmQ36IDno
 //Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777039698; x=1777644498;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9YAH8g2v2vBsoZmgPxB7XwrigYCMZajRhN5tYq8MvnA=;
 b=Enm1cihBCKu3HWWs1dgMASxH0zHR62xt56N5iWXbhQjBQfPowbQSPLsQ5aCU14rEzf
 fT2eS+xvg0ebCub6A6mPArUYKqLIxT6MQI2ymXPXOdpQAJPWhcOqpsEPn+IAwd5x6FBW
 UiCCKg/0WFA5UGQsMwvvhlx/OYqbJ1jShjypHslY8tsIrOyvxq9FSZ7aGaO1+j17O894
 iuoo1ZXaH3cla7qnz7KVLKZepUqrJhhPcg/q8WuRSy8tM++yYwy7vpzCF22Rrw6P4/uD
 8WGfFf9zXqoI2VwjjRdY9jrRZxIivmCkLHEqKmOlUmXCkQyzFHnaCGXC92c1br98VZJI
 KZHA==
X-Gm-Message-State: AOJu0YzOtF+OKGhlxMzY0MNehADevvqQ13H1S4IMPW3bjUPZHcs+7xGG
 PNFDvJD7GV9xEDu+Eby1SF9B3UINsnuSCVjgsXUCkn0XWPO4u4gC6wg=
X-Gm-Gg: AeBDievg6kPJ0A2j7X6g8bx20621fAgHSbR4PwRvQiaZOM/f9uLIDaanuKnq959KyeQ
 Da+GHsqVTBwbkKftRZmN4lSWB6ydd9kHh8h6rLi/ZyzJSc8pGFflcEH5wwOb9JJj3Patoxgogsq
 mgEZ1vG1YOSKY4/xiqFc4sVk1Gn61JBc0fnHFMau4nuWj5EWneCtVDXDddtuYRwogwikiXCrtRF
 7QYMYDKW2W9LyBv3zlfretrwCH/s4/DRODEoif06ZOxjDyGX7zOzWEuUtozcG3TIvaXWwsb1iFX
 G6OTNoMZhna3DxKu0wJ9AiQEwZVOqP62NO9nSHOAcd4USjz0fZrujkdaKBX8K9bXmUe4zOFa9Ig
 HG4fiLATSA1coLLdLesQOk8uqkbSboMk1C0+aeOqoYKQEsK5TMIZ857iykG8g3xWjZJNx8G1lAJ
 PnpMLwpJNBO3r0o/e6XkhLzkHs/q/GL9fbhkGYEGLCaS/yWNxztl800GS8EDI1/CqFYdYpU1zwE
 XxOFDfvgYrWRiFIcoxzOqnljlUx9Gzdpl+YNbH8RwczGQ==
X-Received: by 2002:a05:6830:6483:b0:7d7:4639:43ee with SMTP id
 46e09a7af769-7dc94f97a1amr21338986a34.3.1777039698033; 
 Fri, 24 Apr 2026 07:08:18 -0700 (PDT)
Received: from localhost.localdomain ([47.188.191.104])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a2dd1sm22228653fac.9.2026.04.24.07.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 07:08:17 -0700 (PDT)
From: "John B. Moore" <jbmoore61@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 airlied@gmail.com, simona@ffwll.ch, stable@vger.kernel.org,
 "John B. Moore" <jbmoore61@gmail.com>
Subject: [PATCH v2 0/2] drm/amdgpu: reject misaligned IB addresses in CS parser
Date: Fri, 24 Apr 2026 09:08:14 -0500
Message-ID: <20260424140816.43766-1-jbmoore61@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 27 Apr 2026 08:37:19 +0000
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

Userspace can submit command streams with IB addresses whose low two
bits are set.  On all hardware that amdgpu supports, those bits are
reserved (they encoded byte-swap mode on pre-amdgpu legacy HW).
Today these addresses pass through the CS parser unchecked and hit
BUG_ON(addr & 0x3) assertions in ring emission callbacks across
gfx_v9 through gfx_v12 and sdma_v4 through sdma_v7 (35 call sites),
crashing the kernel.

Patch 1 adds an early -EINVAL rejection in the CS parser before the
IB is allocated, plus a defense-in-depth WARN_ON_ONCE in
amdgpu_ib_schedule() to catch any that slip through from other code
paths.

Patch 2 is a trivial cleanup: removing a dead BUG_ON(!bo_va) in
amdgpu_cs_vm_handling() that is unreachable due to the NULL check on
the line above.

A follow-up series could convert the 35 downstream BUG_ON(addr & 0x3)
assertions in the ring emit_ib callbacks to WARN_ON_ONCE, but that is
a larger change and is not included here.

v2:
 - Rebased onto amd-staging-drm-next (was incorrectly based on a
   local branch in v1 — thanks Christian for catching this)
 - Split the dead-code BUG_ON removal into a separate patch
 - Moved the check before amdgpu_ib_get() to avoid unnecessary
   IB allocation on bad input
 - Added Fixes: tag and Cc: stable

John B. Moore (2):
  drm/amdgpu: reject IB addresses with reserved byte-swap bits
  drm/amdgpu: remove superfluous BUG_ON in amdgpu_cs_vm_handling

 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 10 ++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

-- 
2.43.0

