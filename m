Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D57606A31B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WXJ4XL8d
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A7411246B;
	Thu, 22 Oct 2026 09:45:00 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 447B91123B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:10:28 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso19830805e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792656626; x=1793261426; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j3+gjP3t9zh6/oNn1wxl0OBoYu3DVvNQFxGO0BjTv9A=;
 b=WXJ4XL8d6EItfXgguyVwNj2pggI/r3Oeb+JNLv5KBVwGlnNEKO/DGa1bOduXBUh9jz
 n71Mcg4uB5d/70DlJKX/AzwhJsYMbc/e3zVa/0Ar+ffit0CL029FSvFq4nIZCme0PqRv
 8WY25mh8gMOJtM6dWTU5yJVAW9jFCI2WPzlyW9wUUk+Nr/pCNpaA3cZ+EMkTd5fAAm+3
 ro658ajuMnw3fjRSIg4NpOmuOcgi7SdwFHhZsiGvdNV61T0FDTL3KZoxCvoDJKIQaeoi
 5MmaDoYYPYf+0HZLWjhkddFuLSVCSQm7jYTXuQWxRfocgyqxD3wg3Ye0G9Vwjp8RZhVH
 TZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792656626; x=1793261426;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j3+gjP3t9zh6/oNn1wxl0OBoYu3DVvNQFxGO0BjTv9A=;
 b=FhEuOaiMlAzgat0Adj5mdGH0MEtwJqE3ipOlzN8JfmaBrpy1AIe6zjTAmEQ5AthlUP
 tcHv2dKaHBNuzQFmZSA4DiB3QVdFzQfRS/7poIOrK/SF+ySpESvaNJo+SzQq5T5y0BQN
 ONqI5BAyJ/R3w0mzptg7/J+gRvlfFRl3cCuo5+JjFYZypyBXRLymmowB5KK4/nwsmExm
 6CzGTSUaTzRH6PBZVByetB2K2KNKzuvXMgu/ryb9IBU8T6oXGNhd8TuPRyUi1c0rt6cS
 qEf+QKJbZ3N0wivuwW5mQaOH8SXJqPzMEpBC7Yhzx8xiqJAUID36Z1b2eQusGgDPoSlt
 PwyQ==
X-Gm-Message-State: AFq9FYKCgeLjMPBRiMufwTlaDzN0C/SMG2P1rp8MsuzvU4sKiH5QYasH
 l029j9R1wg/lipDg1OiJkF9VktyiSLdDSpOQ+1cZkow/0+2hGK0txwA9PYoT0ildV44oGg==
X-Gm-Gg: AYBFou2FZZhfBjbVfDJEFQSAcFNLJOhkTQ7RFIkflMDnlgEtm9TU69DzbaBOe/aZ4qO
 PRLgeW+ut7t3EZzkiOZp0VP2OAHX2/zTpsHYoGUzQV7YjtMZU9rr/mJ9GDMn/wCPeS9BCwMTbZ1
 16/E7ntbKEz5H218SkuR7GePWyOYjSRZLRTWkrQGb4ZRVNY9ItYQ2/oe4iluv/LeqkRVcgKJJXF
 0TyVSazTdwtqIRO8Vam56YTk4ZB2vwvaqWzeyQdNHCUcfQVrw1Yyd92apY2oahzTaWpW0gIhlwz
 CZzvfngawKuUJmCzZDwzBrmPcVQGR4GFrP2h36+C6FG0NG4/uFQ4f2+HhshA8kmBIQYcR/BI6vZ
 6J3lheXZoW15FOcCnSfewiZ4Sc9BoGtU4QvRhu8t6NGYIr0TPlPUh59aLxNYdRKK5ZFSe2dgxMZ
 NnJqSaQPJBuEHbuRtI3IhErR9nb30T2ZjkRwp70lICyVvHBXT1hopFoiC4ZuiIjQH9YRaYSfK3u
 5UZ+96b0UM0gn2CkeFdlkdPOOxSBknnOnppB9tOGUevYzc06Nc7ILwPxMxnI2NYxJ2IPgVllrac
 JpHshk2n10338LAsC9M3T8QoAZzXC5PJqh+k4v6VDSE7YBr1
X-Received: by 2002:a05:600c:609a:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4a1fdd64e88mr84315585e9.34.1792656626370; 
 Thu, 22 Oct 2026 01:10:26 -0700 (PDT)
Received: from tvab-pc (v2202507270734364850.supersrv.de. [152.53.198.198])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd234fasm72133325e9.3.2026.10.22.01.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 01:10:25 -0700 (PDT)
From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH v2 0/3] drm/amd: fix DCN3.2 flicker/hangs after OD_MCLK (VRAM
 overclock)
Date: Thu, 22 Oct 2026 11:09:22 +0300
Message-ID: <20261022080925.13994-1-shidlovskiyilya@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 22 Oct 2026 09:44:57 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On DCN3.2 (Navi31, RX 7900 GRE here), raising the UCLK max through
OD_MCLK makes the display flicker (full-width stripes) and eventually hang
the whole system, if the current mode does not allow memory P-state
switching. DC reads the UCLK DPM levels from PMFW only in init_hw, so after
the OD commit it keeps asking for the old top level as UCLK hard min
("set UCLK min = max"). That is no longer the top level, so PMFW switches
UCLK outside of vblank.

The series makes DC re-read the UCLK levels (bounding box and WM ranges
included) after an OD commit/restore that changed UCLK, and on resume after
the user OD settings are restored. It also refreshes the SMU driver's UCLK
DPM table, so pp_dpm_mclk shows the real levels.

Bug report and review of v1: https://gitlab.freedesktop.org/drm/amd/-/issues/6009
(v1 was posted there as a comment, not to the list.)

Changes in v2:
- Only act when the user has customized UCLK (user_od_feature_mask &
  PP_OD_FEATURE_UCLK_BIT), instead of on every OD commit (Kenneth).
  PP_OD_FEATURE_UCLK_BIT is ASIC specific, so the check is done in the
  smu13.0.0 code, which sets a flag that the generic code reads.
- The SMU patch now comes before the DC patch, which depends on it.
- Rebased on amd-staging-drm-next.
- Added Leo's ack for the display parts.

Testing:
v2 is build-tested against amd-staging-drm-next. The hardware test is on
an equivalent backport to the Ubuntu 7.3.0-9 kernel (same code, plus a
small local backport of the user_od_feature_mask tracking, which Ubuntu
7.3 does not have yet).

Hardware: RX 7900 GRE (Navi31, SMU 13.0.0), 5120x1440@144 (DSC, ODM 4:1)
+ 2560x1440@100, UCLK OD max 1124 -> 1300 MHz, toggled via LACT.

v1 results:
- On OD commit, DC logs the new max UCLK (1300 MHz). pp_dpm_mclk shows
  1300 as the top level, and the current level stays at 1300 (20/20
  samples, no drops to 772).
- About 4 minutes of heavy window switching on the 5120x1440@144 output:
  no stripes, no hang, no amdgpu errors.
- 3 OC on/off toggles: one short flash exactly at the switch (memory
  retraining during scanout, expected), then clean.
- Same scenario with the stock module: stripes, then a full system hang.

v2 results:
v2 hardware test (same RX 7900 GRE, 5120x1440@144 + 2560x1440@100; v2 backported
to the Ubuntu 7.3.0-9 amdgpu, LACT applying power cap / voltage offset at boot):
- boot and login with stock VRAM: no "DC memclk states refreshed" at all, so
  non-UCLK OD commits (power cap, voltage offset) no longer touch DC; the
  short login flash seen with v1 is gone;
- VRAM OC on (OD_MCLK 1300): exactly one refresh, "max UCLK 1300 MHz";
  pp_dpm_mclk top level 1300 and current level 1300 (12/12 samples);
- VRAM OC off: exactly one refresh, "max UCLK 1124 MHz";
- desktop stays clean, no stripes, no hangs.

Known limitations (unchanged from v1):
- The OD commit itself still happens during scanout, hence the single
  flash at the switch.
- Only DCN3.2/SMU 13.0.0 is handled. Other ASICs with OD_MCLK probably
  need the same hook in their ppt code.

Ilya Shidlovskiy (3):
  drm/amd/display: dcn32: rebuild WM range table when memclk states
    change
  drm/amd/pm: smu13.0.0: refresh the UCLK DPM table after an OD_MCLK
    change
  drm/amd: let DC re-read UCLK DPM levels after an OD_MCLK change

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++++
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  8 ++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 +++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 33 ++++++++++++++++++-
 9 files changed, 127 insertions(+), 5 deletions(-)


base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
-- 
2.55.0

