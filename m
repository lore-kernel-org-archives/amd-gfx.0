Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09D4E83EE8
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 08:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5458310E496;
	Wed,  4 Feb 2026 08:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l4qZPReY";
	dkim-atps=neutral
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EACC10E741
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 18:56:30 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id
 a640c23a62f3a-b87266fdf56so78414266b.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 10:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770144989; x=1770749789; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8DB17b0cBX6Qw97KlErLRuuI9KRBT1rxn3aOxrZP4eU=;
 b=l4qZPReY+tuvwC+aVWIkfrxzwgIoPvLBwPdbwj+UVpfxWOF2fEYtgv8z6DsqYpHjW0
 y9MjofJhqzTVn1wh+v20PDkn61JTEaG5WjFDRveqWpYThBnOii3brok9renLwkT8ifP0
 vikcIHeCxBIhQVVD7/mkraWk8EuyYZ3rp90bd0TyUiYCVz5hrObuTskfzHwzzYj9ynJf
 AIyoYBgiVZFfSf2exnUQXfDj6WJXA7G8Nu+371kBfO9eyTYokJy1mRoqOeLfn11fC9EZ
 zVxQmpBfFVuxMhlpB8ZRWKV8MbV3UQbfV4YHtSxqH2sRxq8KWIj55nvLu18tKn35YB9/
 E+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770144989; x=1770749789;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DB17b0cBX6Qw97KlErLRuuI9KRBT1rxn3aOxrZP4eU=;
 b=s2F1pEPYdMLgVbHNVHBEoBuNPZcHTPLbjbCs86gY1NEHjM3rXsMlqb6453f2AP1+XL
 u3QmXkw0QJdtPZEUZV1i8Sy4hNwMHjwFGJWPZpyd1Coe2DfjMKM7uPbPJQ72sZZWXnwA
 ciH9+JDxz+jL4kmp9I0c6ttHX/D47EZjtz/lcMl+M1RUmdl+mwqFgN+0uCuL3QCV1fpE
 gPiLuYVPjZMGjEjlhbD1q1RYW0N1YPFcWYK2AxMOEulWGz2ka758VzMJjGVEipEfYQLZ
 XZJabOiLuFeIM/OsUb6aR/sS8wuelkQY27uS4WADu5qNmjTFDRJygzbfLB10ZXhH+sEa
 Ysvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVN1FQnAIoWaeRJgXmRwnZrheMO8zvCnU3wduxEzc0L7db3hBPQLvdViQL2YS9cO4uYWnRC2jTN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxEactagSTX4GS+oqBG6JSx/nkl3DmrSd7xnURMAcWjx8ME68s7
 f/tjK5WNwrTOURcUZYw335nxmkiTGF1bhNfEpEGkSf0LEDH+tcIL6XqK
X-Gm-Gg: AZuq6aLZVP1Bxip2q/z9FJqpRYSl84ue9UIohebmVsLzfnbEQpsvoKGkpGeHLPyW7Cl
 QeXvIK7q2WODAwsoJQuocldHlJ//neC1qBBNsMaZQOqZSwm83M5biN6UzsY08Feezo4qzBCMy04
 RlJeyifB9ke2HamlS7PHqzkC8czvX4ywChx01m6xkMh0Ba0bfrn24+Z5bXnSYsinaxY153n8iLh
 B9+h2NM40s3IAUa83gshDHvzf9PDn27GEPNGHW0Z/lLfThWDkS7p5W3piFduhDrJvPk2CX7kXhv
 ZVA9q973K3b2nexXKqbUS/WXk29ISEJ0pgslFmvI/KTkzraDspAslxapkEOzI2XcZYpZJbTV9Cv
 0xK04C9PWrOiEQ/Ru1qm31Xu6sOuhWhUU1pB+MPzvxOlsWSYODNfbZtce5Y3zAmNAwFcGy2o+Me
 HZ+X3z4GvxDOnZH0c4IN8dr4dTSf4LhQvkc8Di3JKwYtlEpRB5vnJ6m8Ncb8YxTE0R
X-Received: by 2002:a17:907:a48:b0:b87:2099:9f6b with SMTP id
 a640c23a62f3a-b8e9f170ccemr21178866b.3.1770144989044; 
 Tue, 03 Feb 2026 10:56:29 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9fad97a7sm16715766b.0.2026.02.03.10.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 10:56:28 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com,
 bernhard.berger@gmail.com, michel.daenzer@mailbox.org,
 daniel@fooishbar.org, admin@ptr1337.dev
Subject: [PATCH v3 00/19] drm/amd: VRR fixes, HDMI Gaming Features
Date: Tue,  3 Feb 2026 19:56:07 +0100
Message-ID: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Feb 2026 08:10:21 +0000
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

VRR range fixes are simple and fix VRR support for many monitors. They
close about 5 issues on the amdgpu issue tracker.

Adaptive Sync over PCON is only available as FreeSync over HDMI. TVs which
do not support FreeSync, do not have working VRR with DP -> HDMI 2.1
adapters even though adapters will take care of HDMI VRR info packets.

I myself validated these changes with my Samsung S95B + Bernhard validated
on LG C4 + FreeSync-less Sony Bravia 8. I used Alienware AW3423DWF that
only has HDMI 2.0 to check that FreeSync still triggers properly for
"older" hardware,

For missing VRRmax or VRRmax == 0, the upper boundary is the currently
selected video mode refresh rate. I wasn't sure how best to implement it
but ended up on a great solution. We first check if maybe there is a VRR
range in AMD vsdb. If not, rely on limitation of base refresh rate in
VTEM vsif.

More history on previous shape of HF-VSIF and VTEM in their respective
patches but the info packets were previously included in the driver code.
HF-VSIF was improperly handled and VTEM doesn't seem to have been plumbed
as it had no use before. I recoded these and this code should be much
easier to understand and maintain.

ALLM support uses the info from EDID to determine if ALLM is supported by
sink and if that's the case, always signals for ALLM to be enabled. In PC
use, be it for gaming, desktop use, work etc. we always want the lowest
latency and less processing + possibly higher available refresh rates when
gaming mode is turned on.

HDMI VRR support relies on sending VTEM info packet in place of FreeSync
info packets. Though VTEM has it's own place in the info packet pipeline,
I didn't touch it as it already replaces FreeSync info packets. If there's
a need to change this, please let me know for v2.

Both features were tested and work just like they were intended to. Gaming
mode is automatically triggered and HDMI VRR is used in place of FreeSync
(if available). This HDMI VRR preference actually fixes VRR-induced
flickering on many TVs (S95B in my case) with somehow subpar
FreeSync implementation.

I still think it's better to not force users to search for solutions
manually especially since it seems like DP and eDP don't save info about
FreeSync version and completely rely on basic VRR support.
This would then be mirrored.

There's still an issue with some TVs behaving like a mode change is
happening when VRR is triggered and I'd like to maybe tackle this too. When
using HDMI through PCON, VRR is always active, like it's in
VRR_STATE_ACTIVE_FIXED mode. This makes my TV much nicer to use and
replication this behavior would be worthwhile IMO.

Everything in this patch series has been based on already public
code/knowledge or trying things out until they work/break.

This patch series supersedes previous patches/series:
https://lore.kernel.org/amd-gfx/20251209231107.1968472-1-tomasz.pakula.oficjalny@gmail.com/
https://lore.kernel.org/amd-gfx/20260113214104.146856-1-tomasz.pakula.oficjalny@gmail.com/
https://lore.kernel.org/amd-gfx/20260113183540.86266-1-tomasz.pakula.oficjalny@gmail.com/

Built on top of amd-staging-drm-next

Changes in v2:
- Updated BRR max value to 1023 after testing one by one. This should've
  been obvious since 1023 is the max value for a 10-bit field
- Fixed some comments, to silence "not a kernel doc" warning
- Considered ALLM comments from Michel Dänzer, Daniel Stone and
  Jani Nikula. ALLM is now triggered if either VRR is active or Content
  Type Hint is set to "Game". Content type hint is already supported by
  amdgpu and fully plumbed.
- Added module parameter for controlling ALLM trigger behavior. Now it can
  be configured to never trigger ALLM, trigger with VRR/Game (default) or
  be always forced on.
- Added HDMI VRR desktop mode module parameter, which is on by default.
  This mimics how FreeSync is handeled on Windows and this fixes a lot of
  issues with unwanted screen blanking and glitches around entering/exiting
  VRR mode.
- Moved hdmi vic mode check to one central function to avoid checking for
  3D and ALLM in different places which could sometimes break the logic for
  translating HDMI VIC modes into CTA vic modes (when such translation 
  is needed).
  
Changes in v3:
- Fixed wonky English
- Less struct traversal in helper functions
- Fixed possible NULL pointer dereference while checking if ALLM support is
  indicated in edid_caps of local_sink
- Fixed ALLM bit assignment overriding 3D bit data in HF-VSIF
- Fixed assignment of the upper 2 bits of BRR in VTEM

Tomasz Pakuła (19):
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
  drm/amd/display: Add parameter to control ALLM behavior
  drm/amd/display: Reintroduce VTEM info frame
  drm/amd/display: Enable HDMI VRR
  drm/amd/display: Add HDMI VRR desktop mode

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  27 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 207 ++++++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  49 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   5 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   2 +-
 .../amd/display/include/ddc_service_types.h   |   1 +
 .../amd/display/modules/freesync/freesync.c   |   4 +
 .../amd/display/modules/inc/mod_info_packet.h |  18 +-
 .../display/modules/info_packet/info_packet.c | 342 ++++++++++++------
 drivers/gpu/drm/amd/include/amd_shared.h      |   6 +
 drivers/gpu/drm/drm_edid.c                    |  41 ++-
 include/drm/drm_connector.h                   |  47 +++
 15 files changed, 559 insertions(+), 200 deletions(-)

-- 
2.52.0

