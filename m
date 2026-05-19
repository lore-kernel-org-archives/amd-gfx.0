Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE68CD4F52
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 098C510E378;
	Tue, 19 May 2026 08:22:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z8qF5YpY";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B681810E378
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:22:08 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so35622105e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779178927; x=1779783727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tm/4b5VMebBm4ZVR5bCz1ABYIerYeL5C6Pbo70yc1DE=;
 b=Z8qF5YpYI1uaBwMJWCyQ0kT1Shay+DWLL+Zp8v5ntih1DMs2/lN8yZtJppR9+n6k7R
 iv9cmQXY2EgsWFbSLx6XC3QkaACUd8UShVcFhRPblkXmcUHzMeHlENqBovfLwC5cmrv9
 1NQ7lsv/vwTH/Ag1knEs1gZJ4avvKHKmJkasHvuiIH+45UtdajYVJ206A7ODKS11L4Ux
 iX/10+OSa/64fI4wA4Rs59Uw0+kal0Q9ZHllrwkbn88skhM7oRjkcB1mMUn91GAR5DjG
 idrA+SnKiHjb5JhvXtjsf2lX7HNSZWz6IzRBbZu2k5PV9s2KxtYf8IB3CK52ca+y2x9l
 cnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178927; x=1779783727;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tm/4b5VMebBm4ZVR5bCz1ABYIerYeL5C6Pbo70yc1DE=;
 b=mPufjZXVcE+Q0Bjoc60/emHHtoSIcEe/IhqgFZIdHOzGU+gMUK3NGW9N9uPERzfuoi
 SfJiTl/WPQgN66EMYI6JRSuzREV3bPv/eaEe5tJD9Nb/Oj+Himjt7te/k+63arHW3ywY
 XgnAfvhZ0cM09MFtZV1cNQQ4rJNrqoLUXNnTa1ruRU5xaFgSVYDcGwVpnbW9HagK7Mg1
 Tr00UX1cSOhHh+JLl9EI+GJ44JOJO3y9yLFN8MM6rdcHm41vBuQiGSXCx4cXPXJyNLIM
 txvFfaEKZCiaz0OMixcpB7i62weQqX2QnIO0+xNiXZ3H1W4/yxA2EZ/DsSsm2XJ84hhC
 d/AA==
X-Gm-Message-State: AOJu0YzASw8JDBR4mtWxwAKHu3Dod6rn+sB9r/XitlAd5kYFAqr6gIC1
 JtdURVPf2NptvHB09Vck41eVXCTtY6BER0VTAViIfUUT17a1tksa/8JdpD9Llw==
X-Gm-Gg: Acq92OFwZvNd59cGWq/HaU3tZEjvpd1MONLh7AVsaTLGuLkYsFGa7Tb8dCosiR7T0Ij
 YGDScKpN8TNg3/Nu5BTUhCwRDVjd/Mi+fPQAtkb1mVWIdbKaTN0Byie0lqta8EHiJH4XZcDUDMY
 SNcAEbSLsPm7LGkXhpdndCndcMEVVw5cUamexlQ30cjgv/JfuVIlUnNLI6CcSiMj83bntj+ZCeN
 k+m0DUsW0XTvdAmc7VY4QoPEX0dnTS/wHR//+7IeAKNTK3kxDyBHpqDWrqsdgDiYQt/MPEbWimw
 fFnEbym2trOHIgGlTUIzbTLfwEFIGjspxyHnI2Qf+ls1t9vl57GSVLSrRZJIn6xv3lpCpeQpfkA
 NVGL9JWsPO+vEQxB4ZH7PI9ejY8MxZk3ZMShAFNALL8/nODwMRMPtE0L29xk+NsO9clpvIUtwKU
 1UuTFd3gpchWKVvDTkWR9QiELHb9I26V4e6cezwkT6U37NlfzJAjcvRokqXaY9Pqfg
X-Received: by 2002:a05:600d:b:b0:48e:8741:fd42 with SMTP id
 5b1f17b1804b1-48fe60ee64amr217846745e9.12.1779178926943; 
 Tue, 19 May 2026 01:22:06 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm101575685e9.13.2026.05.19.01.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:22:06 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 0/5] drm/amdgpu/uvd: Fix UVD BO memory placement issues
Date: Tue, 19 May 2026 10:21:59 +0200
Message-ID: <20260519082204.60811-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
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

UVD 4.x and older have two requirements for CS BOs:
1. All BOs must not cross 256M segments
2. MSG and FB BOs must be located in the same segment as the VCPU BO

The amdgpu_uvd code attempts to solve those requirements,
but unfortunately it has hit various limitations:

* VCPU BO may be placed in a different segment
* VRAM allocations may cross 256M in low memory scenarios
* GTT manager doesn't respect placement requirements
* GTT allocations may cross 256M
* GTT->GTT moves are not implemented

Let's solve these issues by fixing the GTT manager,
making sure that GTT allocations are placed in 256M segments
and VRAM allocations are moved to GTT when they cross 256M.
It also fixes forcing MSG and FB BOs to the UVD segment
when the UVD segment isn't the first segment, which can be
the case when resizable BAR is enabled.

This series should be backported to 7.0 and 7.1 because
technically this may have been a regression for some users
caused by switching to amdgpu by default.

Timur Kristóf (5):
  drm/amdgpu: Respect placement requirements in amdgpu_gtt_mgr functions
  drm/amdgpu: Use placements of 256M GART segments for SI/CIK
  drm/amdgpu/uvd: Place VCPU BO only in VRAM for UVD 4.x and older
  drm/amdgpu/uvd: Fix forcing BOs into UVD segment when it isn't at 0
  drm/amdgpu/uvd: Move BOs to GTT when we can't place them in VRAM
    correctly

 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 30 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 57 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     | 74 +++++++++++++++------
 4 files changed, 136 insertions(+), 28 deletions(-)

-- 
2.54.0


