Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0477E63F2D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 04:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624BE10E00E;
	Mon, 16 Feb 2026 04:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OI6VYV0Y";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6813910E00E
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 04:51:35 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so25462175e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Feb 2026 20:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771217494; x=1771822294; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gfbNSZ0Cjv7uEpR3TUvJNrpdOHJt8bEzYAt9jyX7fc4=;
 b=OI6VYV0YIxgt9GQGuxNWFzeoJ3bxBwEPMj5ivoUbZj3Kzkdzaj0LdK/E4FDCsp3fJa
 yQjguhyeJJncApcFldjALejzD/FNdG0aPonCAvGNjySRvXAlc+ckUpKOOY3mKqab3il8
 H4ekWPO9Q67EpqyWdXbnLtu4Vw5UVkFJEdhnnLgZQlpQv8y9UCGs+IVIrp9GOx7yg+tr
 3vD51tBO+6gil2RhT3FMj4F9//Q1MXwBFla+uIMujrPFn53BhFdR5Ra4G5cXaoTcmvMn
 bumKGK6atEJUPuMWPoqMk46RLbi/4JbozvA8/v9WvrmyPzvWKNcp0UhZ3+tKNhCWZVfq
 +iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771217494; x=1771822294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gfbNSZ0Cjv7uEpR3TUvJNrpdOHJt8bEzYAt9jyX7fc4=;
 b=KChlr1V5YkuBnvap6eFc9csgeQbEX7uWY9f7ExYqjcjVpydFKyVEfcqo+h3ixpcZK2
 8bDc++gCdcpNIuGRzI4oHG1ioliEKDvJFOQrgjKu/KAaTdVuDeYMlEoDbfe44XiJTRzs
 4j/Zjx2G5VJWR+03SxGbKOKOG5g0TH0lmlWfdVy9JMLuOvgwQFJQeo9OCYqjMWR+1wRg
 7O1ih3XcNrhe+sPzlKL7pQixkhSNyy7V+Tvq/Y7LkPKzr2oODyOzSYPsYlRAtHYMerjN
 PgGV8qF30GxLD01oPTSHsbmLKkXQ87Id+yx0BhArbCbzcrA2m+d0gIBci5KU/ydRPF/7
 g37g==
X-Gm-Message-State: AOJu0YxeAVwROveXerG/bIxoaWqvW2nOZ7jCyWtUl4SzqLNkspX6obry
 ak+h+nHvBA2tvmupC8mhwSB+GESPZxYkpg+RaulDDuQrUeicJ9MpxgI0jcCfBw==
X-Gm-Gg: AZuq6aIJOiLlpXBbyVPQIdCob6FOwYknYE/3wrDQ0XPhZWCPicspD/JhzvZRPB3n1V2
 eUChXOjYP/F8QWnVmqf4ad5qYQ55zJjBtrHCvJooQ9mVmgp4QC/2cIUR0IjR+/hnwwNKxhL70d0
 uJNyuU8YTAyQcTYqEYyP8Mg71ybHv6hfGXZjllkL3zZsJt5MNGdX9crRlmRt5uINK8/rmYH0xRS
 bHHgQztgMeMdsSMkuKyHd1oVHtyoo9SNIXte7L77de8udhkdV7UdYsccyStQK/uurxon8WlGbWC
 ny5M58WPzsuQsAPk3YeSEITTirdefFy2yZv1O6BLEOJwMlmwcDyXBKBIxKU/+Xj6K2r8g5sROG0
 wVSprjZ0giRk7lavAlrP9nrH2Yidx49KOCWZ6+RLTb1PI6zJMP42REg+xhyM9AeXEghbg+3XXGp
 5x1S2zOZBv+rx1v7eaQcf0SMwtBpm51szE3VylNcMcH80UrkVA6NWn0AjzQe0jCE+jaY9y/8GtN
 Ygk2y5WMCw7hPakoAeNtM3ObDhTFNaiC0P739YI9VPAlaEJyEtlFZTo/Q==
X-Received: by 2002:a05:600c:4f4b:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-48373a160b8mr176746765e9.3.1771217493331; 
 Sun, 15 Feb 2026 20:51:33 -0800 (PST)
Received: from groovy.localdomain
 (dynamic-2a02-3100-6670-3f00-a1f3-fb2e-d2ae-14c6.310.pool.telefonica.de.
 [2a02:3100:6670:3f00:a1f3:fb2e:d2ae:14c6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acf5b9sm21514219f8f.34.2026.02.15.20.51.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 20:51:32 -0800 (PST)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Mario Kleiner <mario.kleiner.de@gmail.com>, stable@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Prevent cursor bo's from being pinned to
 VRAM address zero
Date: Mon, 16 Feb 2026 05:47:35 +0100
Message-ID: <20260216044735.6814-1-mario.kleiner.de@gmail.com>
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

Why?

On some AMD gpu's in some configurations, the start of the VRAM domain, as
reported by amdgpu_ttm_domain_start(adev, AMDGPU_GEM_DOMAIN_VRAM), is
placed at address 0 during GMC init. This is a problem if, during a cursor
plane update, the cursor image bo, which gets always pinned into VRAM,
is placed at offset zero of the VRAM domain, and thereby at the
absolute address afb->address 0.

The display hw apparently doesn't like such a zero start address for at
least native cursor mode, as various checks inside DC are in place, e.g.,
high level dc_stream_check_cursor_attributes(), and lower level DCN
version specific cursor hw programming checks, which do reject cursor
attribute updates with attributes->address.quad_part == 0.

User visible symptoms of this are seriously broken mouse cursors under
both X11 and Wayland (tested with KDE/KWin, GNOME/Mutter, GDM login
manager): Mouse cursor flickers, is invisible, randomly becomes invisible,
or fails to adapt the cursor shape to the context, e.g., when moving from
a text input field to other windows, or window decorations etc. This makes
the cursor irritating and impossible to use.

The drm.debug=4 log shows DRM KMS debug messages of the form
"DC: Cursor address is 0!", and the general syslog prints errors like
"[drm:amdgpu_dm_plane_handle_cursor_update [amdgpu]] *ERROR* DC failed to
set cursor attributes"

I observe this bug on my dual-gpu Apple 2017 MacBookPro since Linux 4.11,
where the kernels early EFI setup force-enables both the Intel iGPU and
AMD dGPU. This leads to the AMD VRAM start being placed at 0x0 and then
causes massive cursor problems. On earlier kernels, only the AMD dGPU was
exposed, the Intel iGPU was disabled / hidden from Linux by EFI firmware.
This caused the AMD gpu to place VRAM start at the non-zero
address 0x000000F400000000, and the mouse cursor worked fine. I confirmed
with umr that the mmMC_VM_FB_LOCATION register of my Polaris 11 gpu indeed
read back 0x0000 in the lower 16 bits in the dual-gpu case, causing
gmc_v8_0_vram_gtt_location() to setup start of VRAM domain at zero.
I don't know what causes the change, but most likely the UEFI firmware
somehow triggers this change before main kernel boot - calling into the
VBIOS, I guess.

There is at least one 8 months old bug report in AMD's issue tracker,
reporting the same symptoms on other AMD setups, cfe.:
https://gitlab.freedesktop.org/drm/amd/-/issues/4302

So unless there is another more clean and reliable way to prevent the
cursor bo from being placed at address zero, or unless the display hw
is actually fine with address zero and those checks in DC are overly
cautious, this needs to be fixed.

Note that simply removing the "zero address -> reject cursor update"
checks worked on my Polaris11 with DCE 11.2 display engine, fixing the
cursor without causing any other obvious trouble. So maybe this is only
a limitation of recent DCN engine versions, or a pointless check.

How?

Add a new AMD bo placement flag which requests bo pinning / placement at
non-zero VRAM address only during amdgpu_bo_pin(). Use this flag for bo's
on the cursor plane during amdgpu_dm_plane_helper_prepare_fb().

I don't know if this is the best approach. It feels hacky, but it is the
only approach I was able to do and it seems to work fine enough.

If this is a good enough fix, it should be backported, but backporting
to earlier than Linux 6.12 might be cumbersome due to changes to the
amdgpu_bo_pin() implementation.

Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: <stable@vger.kernel.org> # v6.12+
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c            | 11 +++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  6 ++++--
 include/uapi/drm/amdgpu_drm.h                         |  7 +++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1fb956400696..97131fc8fbdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -975,6 +975,17 @@ int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
 		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
 		    bo->placements[i].mem_type == TTM_PL_VRAM)
 			bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
+
+		/* Ensure bo is never pinned at amdgpu_bo_gpu_offset() == 0
+		 * for VRAM allocations, as some of the DC code does not
+		 * like that, e.g., mouse cursor display image bo's.
+		 */
+		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS &&
+		    bo->placements[i].mem_type == TTM_PL_VRAM &&
+		    !bo->placements[i].fpfn &&
+		    !amdgpu_ttm_domain_start(adev, TTM_PL_VRAM)) {
+			bo->placements[i].fpfn = 1;
+		}
 	}
 
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 394880ec1078..cd7f53d3036c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -959,10 +959,12 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 		goto error_unlock;
 	}
 
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+	if (plane->type != DRM_PLANE_TYPE_CURSOR) {
 		domain = amdgpu_display_supported_domains(adev, rbo->flags);
-	else
+	} else {
 		domain = AMDGPU_GEM_DOMAIN_VRAM;
+		rbo->flags |= AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS;
+	}
 
 	rbo->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
 	r = amdgpu_bo_pin(rbo, domain);
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 1d34daa0ebcd..6dee7653c54e 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -181,6 +181,13 @@ extern "C" {
 #define AMDGPU_GEM_CREATE_EXT_COHERENT		(1 << 15)
 /* Set PTE.D and recompress during GTT->VRAM moves according to TILING flags. */
 #define AMDGPU_GEM_CREATE_GFX12_DCC		(1 << 16)
+/* Flag that BO must not be placed in VRAM domain at offset zero if the
+ * VRAM domain itself starts at address zero.
+ *
+ * Used internally to prevent placement of cursor image BO at that location,
+ * as the display hardware doesn't like that for hardware cursors.
+ */
+#define AMDGPU_GEM_CREATE_VRAM_NON_ZERO_ADDRESS (1 << 17)
 
 struct drm_amdgpu_gem_create_in  {
 	/** the requested memory size */
-- 
2.43.0

