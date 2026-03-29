Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2BCF3D600
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 09:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2260610E356;
	Sun, 29 Mar 2026 09:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O3QlhfTz";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A01E10E087
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 03:58:35 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5a13a06fc85so4234341e87.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 28 Mar 2026 20:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774756713; x=1775361513; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zKSTsi247z5P33Yjv2caAhylWteQdWO6P05Zq9/reE0=;
 b=O3QlhfTzL80ATGv+c7J/7d63t5qI5jdvEriTzFAPADdYMy7OoRgNy+Z8HQwjWDDq/v
 xuXCVL5XBOvkNdNXRaG7kkZlFZFYjJnm427LSRU4Plo+7xrpC8A1oUG/HTRKe56zVy4V
 XUpGbLAfjjqtTNnshlRnKVNZBRzFp7M5PObnlAYta/V2OSN21CrixXfO0lh/s/zCidwx
 9q75/+jzjctMQUqKTpl9vNS26TJf+veV2YL0L5BAy2dyuDsB++JOQijY7NwE4hc2JT+A
 M4BJ5BIhPBJhuJeEQ0IsfJjspEZnc9/DiEJyXjOi4Xar66xARGJhUInHfN9sB1C6EgRP
 fkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774756713; x=1775361513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zKSTsi247z5P33Yjv2caAhylWteQdWO6P05Zq9/reE0=;
 b=euF3Gf1W2RHsjO+fgii9Hqk+pYFAr3tbos8b/pNJxqEgkr0LK7KQ3o6IGzScTnQLwq
 /eSjt5F9F2FuO8S5H7ALagYmqsNzDTxRBajMxqFd6c460m1C4TrKMp7h7gkgM8Vs+Jiu
 dOf2K46o50EkVj3TEt9eR8+BThZrWgDEo4So2r0qB6upfnovGepCCJebbhUCdwJsGPfH
 N945hFW7/Si8xfk439yomMjC+Y4B7n0bDgZi9qYsRCfC90ip8gkL00rYI1UocFsm6Mv6
 tp8/32JWnP2nT10MELqFHWODwOqFsVBGUpPVo6zhv67uZ/v/e6l3zWvkhWPWEgtVdXEx
 0HYQ==
X-Gm-Message-State: AOJu0YxGLlVeQ+cS10KicTWovyY1Kuchu6lbPZ9qDU6jJ+OdmkNl0jSY
 lAMxSQx0mjJyR5HwNjAq8Adu7s1miOxAQEY/ejggWASLOf6EV8UxQE6oWxK4yRlL4w==
X-Gm-Gg: ATEYQzzh26Q/k1SQl5o2AezmpJyK3Q5R1Av/UeKJJ1/HGd+O8PiIQPTZjyeYLU9OtX1
 GVGbzW9G6CuuE3wjvKHh9IjFXHruid74U+CjPnsT6huDr5zVahFACFDblH2XztcrYLVYi2IEbjq
 ZaTpc4c8+GWfcoqBxfEodRzo802NaiPRd/iJXNJb+E87esumscOYFrJImPRoUIDQi5XwCqzbRFW
 GgXnJEITuvcwaVxM/YG3rPGT8C5kTjmUlPZ/JWHt61UTZDofEbLMSz5EuSZdRb910OL5Sk3ijPi
 nch0m7uNAGPr+PzKJhM1DTTNhD6HVsyHswCRCtXE4Oa6RnKkTmE8WHk2Cmg+A6WDDknV86Cc6Vv
 S1YxLpgiLeiSLdxEud+lreNGc2+1Oj4SSB0ofPKEolWE9yPmVrkJCI68Das5lZUk1hBPgvnFKNT
 EGvqG8+BT7PsVMEbkS0h7TqWTa7pM=
X-Received: by 2002:a05:6512:3b8d:b0:5a2:9bd8:838d with SMTP id
 2adb3069b0e04-5a2ab5feaf8mr2005713e87.6.1774756712898; 
 Sat, 28 Mar 2026 20:58:32 -0700 (PDT)
Received: from fedora.localdomain ([2a11:3805:0:93::1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b13f41f4sm806136e87.13.2026.03.28.20.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 20:58:32 -0700 (PDT)
From: Sbenazar <voroninan95ton@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, alex.deucher@amd.com, tom.chung@amd.com,
 Sbenazar <voroninan95ton@gmail.com>
Subject: [PATCH 0/3] drm/amd/display: fix Panel Replay artifacts on DCN 3.14
 (Phoenix/Hawk Point)
Date: Sun, 29 Mar 2026 06:58:26 +0300
Message-ID: <20260329035830.21953-1-voroninan95ton@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 29 Mar 2026 09:57:18 +0000
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

This series fixes visual artifacts caused by Panel Replay on AMD Phoenix
APUs (Radeon 780M, DCN 3.14). The artifacts appear as brief
green/purple horizontal bands during screen updates — workspace
switches, browser scrolling, window management. They are widely reported
across vendors (Framework 16, Lenovo T14, HONOR MagicBook) and tracked
as drm/amd#5087.

Root cause analysis identified two driver bugs and one firmware issue:

1. sr_skip_count is never reset after non-fast updates, allowing
   Panel Replay to be re-enabled on the very first fast commit
   following a full-frame update that disabled it. During compositor
   animations (e.g., GNOME workspace switch), this causes Replay
   to reactivate mid-animation.

2. The 500ms re-enable guard in amdgpu_dm_enable_self_refresh() uses
   psr_dirty_rects_change_timestamp_ns, which is only updated in the
   PSR-SU code path. For Panel Replay, this timestamp is never set,
   so the guard always passes — making it ineffective.

3. The DMCUB firmware on DCN 3.14 produces corruption during Panel
   Replay selective updates. This is a firmware-level issue that
   cannot be fixed from the driver. However, full-frame updates
   within Panel Replay work correctly.

Patches 1 and 2 fix the driver-side timing bugs that affect all DCN
versions with Panel Replay support. Patch 3 works around the firmware
issue by disabling selective update specifically on DCN 3.14, preserving
Panel Replay's static-screen power savings while avoiding the buggy SU
code path.

With all three patches, Phoenix/Hawk Point systems can use Panel Replay
without artifacts and without the amdgpu.dcdebugmask=0x410 workaround
that currently disables Replay entirely.

Tested-on: HONOR MagicBook Art 14 (FMI-XX), AMD Ryzen 7 8845HS,
           Radeon 780M, Fedora 43, kernel 6.19.9

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5087
Link: https://community.frame.work/t/workaround-graphical-corruption-with-780m-igpu/61750

Sbenazar (3):
  drm/amd/display: reset sr_skip_count on non-fast updates
  drm/amd/display: fix Panel Replay using stale PSR timestamp for
    re-enable guard
  drm/amd/display: disable Panel Replay selective update on DCN 3.14

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 15 ++++++++++++++-
 .../dc/link/protocols/link_edp_panel_control.c    | 11 ++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

--
2.48.1

