Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08F8CA6008
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 08:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6519010E39F;
	Mon, 19 Jan 2026 08:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FmMizOfD";
	dkim-atps=neutral
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA68C10E13C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 01:11:49 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id
 4fb4d7f45d1cf-6505d1420daso363660a12.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768785108; x=1769389908; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DVBUttiwTtNNOnKb5N+xO9QPyCJvbn2+Hg5o/bF62Yc=;
 b=FmMizOfDNAbda4qgbjlFaHapc6Q4qiJGjsryYSc5AmOTuV8cOX8lF6lKsLURR/fFWK
 gv6jlxF4GQ3jEL0Pqp3F0H9NFZE/u7DSdpwo3SYn9HxlKKTQZughEwzRCDN3PK5smIWz
 WN4Nlrdxg8pqF9MWjemaukdNJPdl3f45VKGu7c/d+KnXjayzxl7wo+gQjfKNTrslFEDh
 uuoRbaFvIXPYkh3NesfcG7cL3DZVk8CZca8bn22WdVAfblDLHYC3HDlMKnAC0Nx6t8sE
 MqYLr0BJhlk73BaqfdzcaHYPZ+n3/bCzwz+HBq6RS2I1GJv6qb75JrbdqK2UTnV10Y4f
 ASeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785108; x=1769389908;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVBUttiwTtNNOnKb5N+xO9QPyCJvbn2+Hg5o/bF62Yc=;
 b=JXtDBusi9SvSqQ2tYSXl/0qHGGc64pp77pZdryQVNI6LnhhtjC3gG3ggkS7OfhqTLw
 6NKg6pS56kJkh83KrCXpGJK9nEtuI4STkVrIYiRyMBH7CQ/v3103QW7fNWeAosTf25D+
 Cm1njlfGK9URnfBaGd0NjNqrWawWsRAl3I2biTjK5kof5RTTpnTK5OTI8r9IxGxieXLP
 DYLNw7HvSeza26cCRjQbuu83YCyAcO04t5wmUOPfsFwHKr15X3lyvKSUtVBC6ze2aPbt
 ygq2ryiWnYaMDHmgzIjbs3kDtxzaMpwm7Qt0cu+XZibXiqEOtLsYOj3scDSVV2bl1B2S
 qUjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2s2pRJH5xhdUN4a8AI3dio1oY7M8V1RnRYK4joP+LkLh0XUGNk+r/Jda0Q1nbx5E8BBtwD1rg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yww3WrdLDccmZpO8eahIRu1uM4n2gSxlIgOwJ/kSHtmXDNorBi1
 OH5rmLST6kHgjsxNP6qM05ENZ5RKMnD/qTm0n7x0VEaXQVTGfi8JWi4L
X-Gm-Gg: AY/fxX6JVR63SUWD5J4iLsUhSUujPimYcyFvNOF3l/AVNK1+EdLz7irsu25+oC9W3eP
 X8TGockJQEj6857HpFBOcerlBYnVb+xGQYii9c8n8Q4FJGUvwfC5tf/AAY7ZJJxf4w7kMVlkSjF
 mqbHQ5dSjtSL5TKAp+JhakATOWB0vBH+qER1cmYQXLUA1Km16SJUilq8E2ilvk4F8Syr99h3av1
 GUfAg6YL5Slj/7AWzF5QFFF6/nq93aPP8K/yBUBHCi2eaeNvqOd77ELx75KzJxYGpz5xhaACuQs
 38NCUHQ+1x597FNqnjmNCJ/tyZ4pj3Zo1bfxG2WH/G7Sc85Zz2LKA3Uw9Xcb6cYYv0ffUeX6Vow
 s1mhwVr1Ptm9XJvO2/+3Z9fB8ugrmHrgwRLkDLRjrj+IpKVE5vVF3ae3hYwJWZtf4xVTofC11w+
 zUiUVfmF8UQm+KTx0gvspiLuaVVkUeeQ1Fy4nUd69OcLBboxQ4gAA22HkZI1yc8snN
X-Received: by 2002:a05:6402:510c:b0:640:abd5:8646 with SMTP id
 4fb4d7f45d1cf-65452acc747mr4345762a12.4.1768785108158; 
 Sun, 18 Jan 2026 17:11:48 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c4912sm8989806a12.30.2026.01.18.17.11.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 17:11:47 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com
Subject: [PATCH 00/17] drm/amd: VRR fixes, HDMI Gaming Features
Date: Mon, 19 Jan 2026 02:11:29 +0100
Message-ID: <20260119011146.62302-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 19 Jan 2026 08:18:28 +0000
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

This patch series tackles a few things:
- Fixes VRR not detected if monitor uses GTF flag for ranges
  instead of Range Limits Only
- Detects if AMD vsdb carries a wider VRR range and uses it instead
- DP->HDMI PCON changes which includes a module property to override
  PCON ID check
- Parses HDMI gaming features in generic drm
- Reintroduces proper HF-VSIF and VTEM info packets
- Adds support for Auto Low Latency Mode
- Adds support for HDMI VRR

VRR range fixes are simple and fix VRR support for many monitors. They close
about 5 issues on the amdgpu issue tracker.

Adaptive Sync over PCON is only available as FreeSync over HDMI. TVs which do
not support FreeSync, do not have working VRR with DP -> HDMI 2.1 adapters even
though adapters will take care of HDMI VRR info packets.

I myself validated these changes with my Samsung S95B + Bernhard validated on
LG C4 + FreeSync-less Sony Bravia 8. I used Alienware AW3423DWF that only
has HDMI 2.0 to check that FreeSync still triggers properly for "older" hardware

For missing VRRmax or VRRmax == 0, the upper boundary is the currently selected
video mode refresh rate. I wasn't sure how best to implement it but ended up
on a great solution. We first check if maybe there is a VRR range in AMD vsdb.
If not, rely on limitation of base refresh rate in VTEM vsif.

More history on previous shape of HF-VSIF and VTEM in their respective patches
but the info packets were previously included in the driver code. HF-VSIF was
improperly handled and VTEM doesn't seem to have been plumbed as it had no
use before. I recoded these and this code should be much easier to understand
and maintain.

ALLM support uses the info from EDID to determine if ALLM is supported by sink
and if that's the case, always signals for ALLM to be enabled. In PC use,
be it for gaming, desktop use, work etc. we always want the lowest latency and
less processing + possibly higher available refresh rates when gaming mode is
turned on.

HDMI VRR support relies on sending VTEM info packet in place of FreeSync
info packets. Though VTEM has it's own place in the info packet pipeline,
I didn't touch it as it already replaces FreeSync info packets. If there's
a need to change this, please let me know for v2.

Both features were tested and work just like they were intended to. Gaming
mode is automatically triggered and HDMI VRR is used in place of FreeSync
(if available). This HDMI VRR preference actually fixes VRR-induced
flickering on many TVs (S95B in my case) with somehow subpar
FreeSync implementation.

If you don't agree with this preference, I can add a module setting that will
let users control this behavior. For example, FreeSync would be preferred by
default, but amdgpu.prefer_hdmi_vrr=true would change that.

I still think it's better to not force users to search for solutions manually
especially since it seems like DP and eDP don't save info about FreeSync version
and completely rely on basic VRR support. This would then be mirrored.

There's still an issue with some TVs behaving like a mode change is happening
when VRR is triggered and I'd like to maybe tackle this too. When using HDMI
through PCON, VRR is always active, like it's in VRR_STATE_ACTIVE_FIXED mode.
This makes my TV much nicer to use and replication this behavior would be
worthwhile IMO.

Everything in this patch series has been based on already public code/knowledge
or trying things out until they work/break.

This patch series supersedes previous patches/series:
https://lore.kernel.org/amd-gfx/20251209231107.1968472-1-tomasz.pakula.oficjalny@gmail.com/
https://lore.kernel.org/amd-gfx/20260113214104.146856-1-tomasz.pakula.oficjalny@gmail.com/
https://lore.kernel.org/amd-gfx/20260113183540.86266-1-tomasz.pakula.oficjalny@gmail.com/

Tomasz Pakuła (17):
  drm/amd/display: Return if DisplayID not found in parse_amd_vsdb()
  drm/amd/display: Refactor amdgpu_dm_update_freesync_caps()
  drm/amd/display: Check for VRR range in CEA AMD vsdb
  drm/amd/display: Use bigger VRR range if found in AMD vsdb
  drm/amd/display: Refactor PCON VRR compatibility check
  drm/amd/display: Add PCON VRR ID check override
  drm/amd/display: Add CH7218 PCON ID
  drm/edid: Parse more info from HDMI Forum vsdb
  drm/amd/display: Rename PCON adaptive sync types
  drm/amd/display: Enable HDMI VRR over PCON
  drm/amd/display: Support HDMI VRRmax=0
  drm/amd/display: Build HDMI vsif in correct slot
  drm/amd/display: Save HDMI gaming info to edid caps
  drm/amd/display: Restore ALLM support in HDMI vsif
  drm/amd/display: Trigger ALLM if it's available
  drm/amd/display: Reintroduce VTEM info frame
  drm/amd/display: Enable HDMI VRR

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 206 +++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  49 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +-
 .../amd/display/include/ddc_service_types.h   |   1 +
 .../amd/display/modules/freesync/freesync.c   |   4 +
 .../amd/display/modules/inc/mod_info_packet.h |  17 +-
 .../display/modules/info_packet/info_packet.c | 295 ++++++++++++------
 drivers/gpu/drm/amd/include/amd_shared.h      |   6 +
 drivers/gpu/drm/drm_edid.c                    |  41 ++-
 include/drm/drm_connector.h                   |  47 +++
 13 files changed, 489 insertions(+), 191 deletions(-)

-- 
2.52.0

