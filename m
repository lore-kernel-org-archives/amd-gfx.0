Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07301F99C95
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2026 21:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AC2310E062;
	Sat, 18 Apr 2026 21:49:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pO3PB9HQ";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09DD10E062
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 21:49:37 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-488a4bc360bso10949935e9.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776548976; x=1777153776; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s79Yy2xdXBu4zfR2LqFlNsqYIVlGaT1qZnwaOfi6fqw=;
 b=pO3PB9HQEqfJ2+V7R62dawjQc0v3r8ScNK3duwdKmNiZDJBBtxGWq9nJ3crpGrAvWD
 ZtXrodoKSbZ0Gf9Pnj3r9M0exD4bEofZ/d3Zb0gqhx/QHT/i124L+TxfE/YaCDpTZXOo
 Sl80GooPsyz1FeUR15yE/W2SD3vtMBfQiFMS9F7J+E/0rLRrXT0x/NK2Q6l5zbJjXQ8t
 GaO5K9tFre7OFntAhoQixbux0SItRxhzmxY3rXATbWL65bPYuqV7FOS2l5iCfWROSS5R
 zG2SiklwgjTfp5dvY8lUSBPOTKe7CEKNyGvWohBd60PZTqYUjHvlmedQ8DbA3vChFN1I
 KR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776548976; x=1777153776;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s79Yy2xdXBu4zfR2LqFlNsqYIVlGaT1qZnwaOfi6fqw=;
 b=XiE1FBsOl3miqcZEQv8jDYhaNubuhMgs74uYaTs2LoMMAyVzvcaS9VmVTiJ+YC3MLL
 ovx3LTszZH88DQwojqzCbi41Zw7RF2wm//8I+Au4zTeljPgDgummyGz31FU3x6/vGa6f
 wMTq0QN1cRi2fLP48tKwdIzJlVLJp11TwtzaaYAcGm6mALtq9KDy9c32HmAyOdrFlHnH
 k5mcPyC8PJj/AA3bybvdfkQBEtaeRDV8aaOVnfp8qGHRsAGnkoS+3NiFV3fhnsx5gLJD
 xzKxtrH0oXSCmqmzecpfcg37en2H+CGhfPZU+cQNgLm4On8tebRGTXx73j9mOimJl/oG
 S2og==
X-Gm-Message-State: AOJu0YxDMiTsGTNd5veMFbYmTHygE393Lh6SYygeKOUFCv1sOSZb8PMV
 DKUNGx5V4XgLjNv1bI8f/juGOEdl31HulCEuj2SJsYeIHt7rq+IQnQv45lq0Rw==
X-Gm-Gg: AeBDiesK0lakZo5Ywv8c/0yx/p+DblOy+OGx3TV0Xh7y4y3smmu65oN/FFX36MFhtqY
 FZlEIeHYRsmzc8wHnodRNEnCyIcMBguqA4EbvCTrnOpt0FZ8Hhu7OArCf4JaGCT7jI9XuajKzur
 e4LMRh4UUyPXtKbeKgag93gNB0T+uCiligNEmujXzRLTqvWxdjz1g0yjPdWVtrhr9Xg7ncNXIQ3
 E53UTvee30UL+1RrXR47/EP0VBQXZBBcqANPvogTCY71rPwDETOc70zFX7GrqfIq7w5JQjC7332
 odEviLPPjZV2FFRM8U9weNPxmjuzkx65kDb1I8UBARGHutBF4mqZps3IhOFz6067IWOepe61+nM
 LPBFodg0xSmV3CpMitGtTw5idB/S4oYJGnA6hENg4R8xzjIimcqMVv6zukcg3qDo2OfzR8IhlWP
 pRDMo8Hopuh+baEYyjju9gpCK1T3MANLDXtw0uDcvQBYImr1CBuP/ivrCOcDFwgQ2+4XXojOB6D
 5tsLkocDdNao71K
X-Received: by 2002:a05:600c:4e04:b0:485:2f4a:6ae6 with SMTP id
 5b1f17b1804b1-488fb73d8f1mr130072595e9.6.1776548976243; 
 Sat, 18 Apr 2026 14:49:36 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm171531905e9.2.2026.04.18.14.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 14:49:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: Various SI fixes, fix Radeon HD 7870 XT (v2)
Date: Sat, 18 Apr 2026 23:49:29 +0200
Message-ID: <20260418214933.230912-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
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

This series fixes amdgpu to work on the Radeon HD 7870 XT
which has never worked with the Linux open source drivers before.

There are also various other fixes related to GART and UVD.

Changes in v2:
Consider CGTS_USER_TCC_DISABLE when reading disabled TCCs.
Dropped VCE related patches, will send those in a different series.

Timur Kristóf (4):
  drm/amdgpu/gmc: Fix AMDGPU_GART_PLACEMENT_LOW to not overlap with VRAM
  drm/amdgpu/uvd3.1: Don't validate the firmware when already validated
  Documentation/gpu: Add TCC, update TCP in amdgpu glossary
  drm/amdgpu/gfx6: Support harvested SI chips with disabled TCCs (v2)

 Documentation/gpu/amdgpu/amdgpu-glossary.rst |  9 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c      |  5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c        | 66 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c        | 10 +++
 4 files changed, 88 insertions(+), 2 deletions(-)

-- 
2.53.0

