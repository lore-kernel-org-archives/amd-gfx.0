Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03781C35FFC
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 18:38:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C7310E149;
	Sat, 22 Mar 2025 18:38:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KKKMFzrM";
	dkim-atps=neutral
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10BD610E144
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 18:37:55 +0000 (UTC)
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-7c547932d2eso181067085a.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668674; x=1743273474; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bx6xFFIVvPFdbTr2tzmdj9oQb1cpDUWAXFxMuGK/J0w=;
 b=KKKMFzrMorKeFtWE5oRP+ceLWQ/n2cnVC7/1VJbgnfWkpmg0zEu574yP22z4w6FuFr
 7p8HKJTbhjffWHBInL9SOqqO3R5CXD+fFadU8le029oVv99UeGkEW8bWMmxbJcevAuT+
 ud3kR884RxJpqcJXRuVNk1lIMmmE6nAeO/tvdZTcRAoH7/4E7rTwaFS3Rc9+hy+cWwnf
 IwE7pFWzUjwBo9G+Y4usK23gMPtuyKy8kViGKiWxhVa2S6HP/MjdYgOeNuDlhTa59dr9
 9EHtkgsUWb+nKMV4njhvPB9+7SQT1T/clzSwy+FQvD73dQEEvJB+lnEQ2pSVwfJH/vBS
 GmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668674; x=1743273474;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bx6xFFIVvPFdbTr2tzmdj9oQb1cpDUWAXFxMuGK/J0w=;
 b=Fq5yNYduiWSXBMZqMACg2DR5eALQA+2xEmWOLe971Fh/VBZdJWy8jKDidg6Tn2amDB
 0SfW+osRTl6qWgaj7kPcsqtKEIz/odJ2Tn/g4jp6sCGHTtNHW86ahetG/9RPaa+LmiZt
 MxJjQHiQqi/4VoctqyM/b7iaUxcniYW11/lJnS4zs58NdP2gm9xSC0s6H2VDI76TrGOG
 PmYsqsbtgd3Yy3Id8pBY9wl1dCkXGfgEfcqqQssiixwu3koSskKJ+WBk+ZAKDWNQPSbb
 SUIndqXzI6ef434BtU1t16P6qX0fiY7PwklcSrJ5VY3MaryeubMAZxSC/Rsyh2DZFWUw
 riEQ==
X-Gm-Message-State: AOJu0YzSGIjskGG+7S7k5DEVdDUmV63RO0DzqcF1pPBTLqOjspjSuQbM
 q1HI+tjjZT3xg9AIUnWyinqYyi3aTS4VD55JXRX1yOnuR5MIUYiXj5aEsw==
X-Gm-Gg: ASbGncsvlMpHOT+bTNOi103fNg0fBedbBUCljGVY/G+aTcfnIO9hO7f43Xw7JEZcmHC
 1HK8KLHT7pSzCrbCfyb2xkaeoRkgm6Y5ij7oA9V+P7J04xO6UdzPXlgCTzS7HLoE7BDYbPiWXfw
 dufz9XD41m5hkZSnirVDs7viVRPMWZgtfXTFZRwPwSU9u/a58LT7VbK4ZxGdJErVFWz+VVJS1hq
 ncNwNaDeMIRCaeWbeHLa+NTFkiwvt36CreIIaXa7W8XmQLhaDTN50vEbZL6//uRqqlCIDtNOQFO
 VDc9qX04iWlQc/DtyI8Kv+lWAMVGuYAY6ifcr97ypO+CykI/JFfvmSY5ruo+GsWYVDZCHDM/DN7
 p2g==
X-Google-Smtp-Source: AGHT+IEDuocMygkZfCHlvf6aoNdti6x3f0ScuuSCyOdT5UGNQ9w2/a0HBoRadfDEoLDSM0z1S+iyAg==
X-Received: by 2002:a05:620a:2a05:b0:7c0:9f12:2b7e with SMTP id
 af79cd13be357-7c5ba1348demr806427585a.11.1742668673742; 
 Sat, 22 Mar 2025 11:37:53 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec688sm279895085a.64.2025.03.22.11.37.53
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:37:53 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/5] Small tidy up of CIK code
Date: Sat, 22 Mar 2025 14:37:41 -0400
Message-ID: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
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

This series tidy up CIK code a bit.

It uses some functions already available to remove redundant code in GMC7
and CIK SDMA.
Some GOLDEN defines are moved into GFX7, the only place where they are used.
It fixes coding style in VI and DCE8.

Alexandre Demers (5):
  drm/amdgpu: use gmc_v7_0_is_idle() since it is available under GMC7
  drm/amdgpu: use cik_sdma_is_idle() in CIK SDMA
  drm/amdgpu: small cleanup to CIK SDMA
  drm/amdgpu: move X_GB_ADDR_CONFIG_GOLDEN in GFX7
  drm/amdgpu: fix style in dce_v8_0.c and in vi.c

 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 18 ++++--------------
 drivers/gpu/drm/amd/amdgpu/cikd.h     |  3 ---
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 10 +++-------
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c |  9 +--------
 drivers/gpu/drm/amd/amdgpu/vi.c       |  8 ++++++++
 6 files changed, 18 insertions(+), 31 deletions(-)

-- 
2.49.0

