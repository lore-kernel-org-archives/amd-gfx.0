Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F29606A687
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s1Sb1+v0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A2C112968;
	Fri, 27 Nov 2026 09:58:49 +0000 (UTC)
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F9C810E481
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 00:02:52 +0000 (UTC)
Received: by mail-wm2-f5.google.com with SMTP id
 5b1f17b1804b1-4bbb1caea72so1487385e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 16:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795737770; x=1796342570; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xjtr07JDs5eYYSE0PvekGDI6C8K/1rOMD113yDyp5fc=;
 b=s1Sb1+v0rV8JTAnBHFkjmOL6x+AlM+0giIMgN0n6VuAT8Pm0Kku9HZYyvTQPGlmeBW
 pd2vBpj2IxkkqQeEz1dvg62AvPj6DRm5vRv/s0knaopboMk12lvNWdO3K9gcm8GRmPXr
 I6SjHeynYeMjMAlj6h/6BysQOyT7zoVLoNMN0uo+bUeEp5UeYxyYbKm2MZsUb8OZyUiR
 FaHq1Vsr0wAWlfQEeYcIOVA441Vs96T6xNSLjCErsPbzH+cwB5AAKYDWAXEX7oToBcdy
 NSNms6VhFoxS4Y0z4zTpr0HObFYF+V2vhpat5FaB13aY2sGuU2LCh6SaLAZYbQM1SqhJ
 Bfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795737770; x=1796342570;
 h=content-transfer-encoding:content-type:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xjtr07JDs5eYYSE0PvekGDI6C8K/1rOMD113yDyp5fc=;
 b=Yvi1pT15Sziwd/gnRKcb6nNEGfa0NqV9O9VZdUiOg5fccHBZMna0QvH1Q67XJPv3ZS
 Jh/F/EPXHg7rZoeo2sfJJU8l24VkmLJujgN34FHxG78RiDeGE/OVM0j821NuCOTh86Pr
 Ggezpy8EthCeysfbFbYfFeWXvEtrpnQnj5+DyqimgLDSxk4E0Lf15FXV5Fu5y/XxkX1d
 tpNZbzCSlLVoFZioNVbXMeJlZSkj+5mN+SxjdE+zlTUKAyNFXmpyMj6jU3SzwrsjJq96
 mT8xViV8CRXU192MMAElJu4dj2e2dTdWBFNG0PvPGvQmXMWQxQh87Wa4LMkF1FftTv42
 P42g==
X-Gm-Message-State: APuU4Z9J3XZI7myRlBkHEb6lnHYzUDRyfmZPthTzSc2sEYJHb/B0YP0C
 gQbVv3HLLTB8en6c3R/s6kJLSxh3+8/HFlngcXfyuAFH+sqqH71m0k+dZsPTMTm30tA=
X-Gm-Gg: AZFdTZdfPbbCGuuHAeM+SpjX9qTqR1l5N2yoLejeI9DDsQXTcBdUz8GORdkPbcyVlVp
 nP++F4tpzTVXI8P4/EbChNFgGonEUoFXAIbaXR++KlzjrFGwVEWoDN3fijHT5egoLLeWUum+QYK
 ABhPl3DhgfSelYONDfAmWBN+ZMZmPMA+lXq6lAbwExDUz4skwE6CqebPUQFmM9ws0Kr7dgMG1tz
 mI5e8XCkTEgKvjdxDe8owQ6a+WggH3h08AzM/14C8vmNy71p0e/71xSxAYXI41eNgXzaKSnV7PR
 3iVWf1k0gJNTC8dAa79TH6zJMSHFe+KpMnK+kbvke20zzPD4hYbACH2B3a06TP+rd24mR736FX3
 7y5W6s0KbQVu8CJWYJEOGbZPrtF/EYoBGJThPDkLQ7a4p1iOhPsBfLmn/2ZN0nRF2Fm9Ne1u+pR
 uk9Sldr3m19p0IQNRIBFfFEs61xIIXnN0t6c3Oc3LS5fVAV1ZwwvMk3QKjzC07XtU7+UTjmLW1M
 eWz/5qwMgqQ7HYlqKDMsZGllEVoyvuAQYmGPFl06M00pZU6MyiovX2XIiAT/uRK2oMS/gC6jF/Q
 ireqLSV91ZlySPisuTio0liOOJxomBhiuy2X
X-Received: by 2002:a05:600c:8210:b0:4bb:6a2d:b438 with SMTP id
 5b1f17b1804b1-4bb88786c81mr454598565e9.0.1795737770158; 
 Thu, 26 Nov 2026 16:02:50 -0800 (PST)
Received: from [192.168.1.11] ([31.94.68.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe75sm50065144f8f.24.2026.11.26.16.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 16:02:49 -0800 (PST)
Message-ID: <d34513d6-8f84-4456-9b69-67643f4eab85@gmail.com>
Date: Fri, 27 Nov 2026 00:02:47 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Richard Lane <richardlanedev@gmail.com>
From: Richard Lane <richardlanedev@gmail.com>
Subject: [PATCH v4 0/3] drm/amd: Enable 2x1 tiled display support on Apple
 Intel Retina iMacs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 09:58:44 +0000
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi folks,

Apple 21.5" 4K (iMac18,2, iMac19,2) and 27" 5K (iMac15,1, iMac17,1,
iMac18,3, Polaris-based iMac19,1) Retina iMacs drive their internal
4096x2304 or 5120x2880 panel as a 2x1 tiled display using two streams
over an internal eDP root link and a secondary DP link.

At boot, the Apple EFI firmware initializes only a single pipe and
leaves the secondary DP tile unlatched with HPD deasserted. Because the
secondary tile reports HPD low and requires a vendor-specific DPCD
handshake before it responds as a DisplayPort sink, amdgpu currently
fails to detect the second tile, leaving Linux limited to single-tile
resolutions.

This series enables full dual-tile operation on DCE < 12 Apple 4K/5K
Retina iMacs so that the internal panel behaves like a standard
DisplayID tiled monitor:

1. Calculate the pre-OS framebuffer reservation in GMC v7 and v8 using
   mmGRPH_PITCH and the mmGRPH_PRIMARY_SURFACE_ADDRESS offset from
   vram_start so the full relocated Apple EFI scanout surface is
   preserved during boot handover without vendor-specific quirks.
2. Latch the root eDP link via DPCD 0x4F1 prior to EDID read on Apple
   hardware (DCE < 12), point the secondary DP link to the root eDP
   link (apple_imac_peer) via an EDID quirk covering 4K and 5K Retina
   iMacs, latch the secondary tile via DPCD 0x4F1 on the root eDP link,
   write the 3-byte Boot Camp source table (0x310) on the secondary
   link, keep the secondary tile out of D3 power-down, and unlatch the
   TCON back to single-pipe mode on suspend/shutdown. Once unlocked,
   DRM's DisplayID parser populates has_tile, tile_group, and
   tile_is_single_monitor on both connectors natively. (DCE >= 12
   support for Vega-equipped iMac19,1, iMacPro1,1, and 2020 iMac20,x is
   noted as TODO.)
3. Compute context->bw_ctx.bw.dce.all_displays_in_sync in
   dce100_validate_bandwidth() using
   resource_are_streams_timing_synchronizable() and copy it to
   pp_display_cfg->all_displays_in_sync in
   dce_pplib_apply_display_requirements(), matching the existing DCE 11
   bw_calcs() flow so SMU7 can downclock MCLK at idle on DCE <= 10
   without modeset underflows.

Changes in v4:
- Patch 2: Drop the link_dp_phy.c hunk that skipped DP_SET_POWER D3 on
  the secondary DP link, as testing confirmed both DPMS blanking/wake
  and S3 suspend/resume work properly without it.

Changes in v3:
- Patch 2: Added pre-EDID DPCD 0x4F1 latch on the root eDP link in
  dm_helpers_read_local_edid() so dual-tile detection works even when
  third party bootloaders are not present on the EFI partition. Added
  21.5" 4K Retina iMac panel IDs (AE19/1A for iMac18,2 and iMac19,2)
  and renamed apple_5k_peer / amdgpu_dm_apple5k_unlatch() to
  apple_imac_peer / amdgpu_dm_apple_imac_unlatch().
- Patch 3: Dropped the dm_pp_apply_display_requirements() call in
  amdgpu_dm.c and instead computed all_displays_in_sync in
  dce100_validate_bandwidth() and copied it in
  dce_pplib_apply_display_requirements() (dce_clk_mgr.c) to match the
  existing DCE 11 bw_calcs() path.

Changes in v2:
- Patch 1: Replaced the hardcoded 64 MiB Apple quirk in amdgpu_gmc.c
  with a generic calculation in gmc_v7_0_get_vbios_fb_size() and
  gmc_v8_0_get_vbios_fb_size() using mmGRPH_PITCH and
  mmGRPH_PRIMARY_SURFACE_ADDRESS.
- Patch 2: Dropped the DRM_MODE_CONNECTOR_eDP override in
  amdgpu_dm_connector.c in favor of DRM's native DisplayID tile
  properties (has_tile, tile_group, tile_is_single_monitor).
  Renamed tiled_peer to apple_5k_peer and set it only on the secondary
  DP link, removing dm_helpers_wire_tiled_peer(),
  dc_link_is_apple_5k_secondary(), and inline explanatory comments.
- Patch 3: Made the PowerPlay sync check generic for any combination of
  synchronized displays by checking timing_sync_info.group_size ==
  params.stream_count instead of tiled_peer.

Regards,
Richard

Richard Lane (3):
  drm/amdgpu: use pitch and surface offset for GMC v7/v8 fb size
  drm/amd/display: unlock secondary tile on Apple 4K/5K iMac panels
  drm/amd/display: report synced displays to PowerPlay on DCE <= 10

 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  8 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  8 +++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 ++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 35 +++++++++++++++++++
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  3 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../drm/amd/display/dc/link/link_detection.c  |  7 +++-
 .../dc/link/protocols/link_dp_capability.c    |  4 +++
 .../dc/resource/dce100/dce100_resource.c      |  9 +++++
 9 files changed, 87 insertions(+), 7 deletions(-)

-- 
2.55.0
