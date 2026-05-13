Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2EECD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:43:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5682C10F05A;
	Wed, 13 May 2026 20:43:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nRsthbWd";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E4F10F05A
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:43:28 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43d73422431so5425682f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778705007; x=1779309807; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UghUdWhzDCmHqUToL8LrLVq2EyTEbH7HkhMe5YP6FY=;
 b=nRsthbWdDJ5v8rg2AHLskujbOhM3OiXsYRTXhtFFIPC2xAGGEw8keXWE4nU9vti0qh
 MMcQvuItibByMaEwOvWPUIlZbE/7CVGB8KZfHGG8rHxb+DZUlK8GT1Qdo/FLBFhk2pFD
 96Tdy66+w0sjIGDjAxj7iEAMRJQc/5of1HRH7ZN+DWcX848jmbyCUrlIpXVrQa5Llbet
 IyjGUJYVJzOhlq1nxfJshn2x4ntUvNWOUZPbm1ZAZTObQguXXf+fCQoiPgTTDXXhmTb6
 3WfAo6URjhDuItf3TRfyZeejEAfxzaEMAUBhPwHjyPAE/y1HFbhFMEVIznSvvwuH/JSg
 aAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705007; x=1779309807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8UghUdWhzDCmHqUToL8LrLVq2EyTEbH7HkhMe5YP6FY=;
 b=r1lPnpRRkuwQLObqk8HWom1WSYlNGqKDFawyY7YH1YCBNenUJ0qy640Q44CXLvK83U
 smOmyJO2d/+k7aSoZnam9sI1U8nG9HfZ/7d9HM+MQv48duLuVVkK9ZxMhSeN6n/Xsyo5
 A622WZjxAC0/h3hLVzbByIQeUD/1qxCrCmNXL7vVzMYKyUDz4CAolEzpUncGUKDR32mS
 kVBwaUH0lZp2q46JRMUX41tlk9ojTWlyhZEln+Zu5bxJ+LhroJ7nudf/QFut9EQY6sPI
 zIMgFW3WZOiYdELknmGzUlxooizTSt+sE/nRbGs01dcV03f01alhhZ13x3Tg+7YdKrLD
 WLXQ==
X-Gm-Message-State: AOJu0YyZlQLoF57hCm0QPOKfjXiCZvA0Ok4DsHb01iCXDGwFw8+NCTwZ
 F+8cxoHst5ReOWsMoWY+ZlsM8vmLJ0jYuoolCPDEp2HshW2QfW6lISTR7w1ksO8I
X-Gm-Gg: Acq92OGb17IrM4czGz1d5zxbEjhkqGZaHw+Xk/kw1pVwPINoZ8ujWWfvcWqgtKzNgX1
 2J2NXJiJTXPpcV42WxK5F7cZv/MgEYlUPk1T1WSyViWBIXXsmACgSYb1Wc70yA2gkSCNhRDb+J0
 qyqOu9B5Nhryp+6ZgZZa1mQLpjJr8e9kEEEnvEE3o4GA/xJp9V35i1r0RuofCsJgotYJtBJlFiz
 /6e8FCC3wqUJjs/m4CSgwONcx3Ydi9EzH7MXs0+6mY/L+9Ayl3zxr9Q5JqaKpY7GFEnAKg8wSNv
 Sgl92ZHKYwHMky9I2WdPFgJsDUKd/9wDz0Ot4m9nlJ7DixZ7nuQCi05DBz+mFb+r8xa6bLXpeoh
 /JTL5yzX03qjLhx5TbDxzhLfRbWLk5TofoDT1rhU0JxKCeNwjilcrFbKLsctZ0UKxKcOKZWB86p
 pv9N8vMrtKHUyymWR24UKMiP712coNX6qSf8ah/CLdnAtpQ1WzyIfgiry3w9LelI9QwaCW2UEj1
 kk=
X-Received: by 2002:a05:6000:2401:b0:43f:e721:76b8 with SMTP id
 ffacd0b85a97d-45c7a7dc644mr7212380f8f.37.1778705006902; 
 Wed, 13 May 2026 13:43:26 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a19c2dsm1308356f8f.21.2026.05.13.13.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:43:26 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Natalie Vock <natalie.vock@gmx.de>, Melissa Wen <mwen@igalia.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Alex Hung <alex.hung@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/4] drm/fourcc: Add modifiers for AMD GFX6-8
Date: Wed, 13 May 2026 22:43:19 +0200
Message-ID: <20260513204322.73542-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513204322.73542-1-timur.kristof@gmail.com>
References: <20260513204322.73542-1-timur.kristof@gmail.com>
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

GFX6-8 are the oldest GPUs supported by the amdgpu
kernel driver, and the last ones that didn't support
DRM format modifiers until now.

On GFX6-8, the GFX block can only use pre-determined tiling
modes which are programmed by the kernel according to the
tiling mode table. GFX6 uses the GB_TILE_MODE0...31 registers,
and GFX7-8 also has GB_MACROTILE_MODE0...15 registers.
DCC is also supported on GFX8, albeit not displayable.

Note that the tiling table is uAPI and userspace relies on
specific modes being present at specific indices.

How the tiling works is primarily determined by the
so-called array mode.
Use the TILE field to specify the array mode.

Pixel data is organized into micro tiles.
Each micro tile may be 8x8 / 8x8x4 / 8x8x8 pixels,
depending on the array mode.
Add the MICROTILE field to specify microtile mode.

Microtiles may be further organized into macro tiles,
which have many configurable parameters. Macro tile mode
selection depends on how many bits per pixel an image has.
Add the PIPE_CONFIG, TILE_SPLIT, BANK_WIDTH, BANK_HEIGHT,
MACRO_TILE_ASPECT, NUM_BANKS fields to specify parameters
of macro tiled modes.

Furthermore, tiling is also influenced by memory
configuration: GB_ADDR_CONFIG.ROW_SIZE needs to be
considered when calculating TILE_SPLIT, but does not
need to be included in the modifiers, and also
PIPE_INTERLEAVE matters, but it's hardcoded to the
same value on all GFX6-8 GPUs and changing it would
break userspace, so it also doesn't need to be included.

As a side note, tiling works similarly on GFX4-5 but
that will need some additional PIPE_CONFIG enum values
as well as some extra fields to represent some factors
which don't matter on GFX6-8, such as NUM_RANKS
among other things.

Initially, let's only expose the tiling modes that are
most relevant to sharing buffers between different
processes:

Exposed tiling modes:
- 1D_TILED_THIN1: micro tiled only
- 2D_TILED_THIN1: macro tiled

Exposed micro tile modes:
- DISPLAY: supported by DCE (the display engine)
- THIN: more efficient but not displayable

Exposed macro tile modes:
All possible parameters (25088 permutations).

More modes may be exposed in the future as needed.

Technically, the amount of possible combinations
of all possible tiling parameters is in the range
of hundreds of thousands, but in practice, there are
just a handful of possible modifiers for a surface.

For example on GFX8, a surface would have these
modifiers, from best to worst performance:

- 2D_TILED_THIN1 + THIN + DCC (macro tiled)
- 2D_TILED_THIN1 + THIN (macro tiled)
- 2D_TILED_THIN1 + DISPLAY (macro tiled)
- THIN (micro tiled only)
- DISPLAY (micro tiled only)
- LINEAR

The macro tiling parameters depend on the bits per pixel
of the specific surface.

When sharing buffers between different GFX6-8 GPUs,
it is possible but not likely that they support the exact
same macrotiling configuration, so they will likely need
to fall back to using micro tiled modes, which are still
much better than using linear buffers.

Suggested-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Marek Olšák <maraeo@gmail.com>
---
 include/uapi/drm/drm_fourcc.h | 207 +++++++++++++++++++++++++++++++---
 1 file changed, 189 insertions(+), 18 deletions(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index e527b24bd824..4a150c48f348 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1620,36 +1620,67 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
  * For multi-plane formats the above surfaces get merged into one plane for
  * each format plane, based on the required alignment only.
  *
- * Bits  Parameter                Notes
- * ----- ------------------------ ---------------------------------------------
+ * Bits    Parameter                Notes
+ * ------- ------------------------ ---------------------------------------------
+ *
+ * General fields:
+ *     7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
+ *    12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
+ *      13 DCC
+ *
+ * Fields for GFX9 and newer:
+ *      14 DCC_RETILE
+ *      15 DCC_PIPE_ALIGN
+ *      16 DCC_INDEPENDENT_64B
+ *      17 DCC_INDEPENDENT_128B
+ *   19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
+ *      20 DCC_CONSTANT_ENCODE
+ *   23:21 PIPE_XOR_BITS            Only for some chips
+ *   26:24 BANK_XOR_BITS            Only for some chips
+ *   29:27 PACKERS                  Only for some chips
+ *   32:30 RB                       Only for some chips
+ *   35:33 PIPE                     Only for some chips
+ *   55:36 -                        Reserved for future use, must be zero
+ *
+ * Fields for GFX6-8:
+ *   16:14 MICROTILE                Micro tile format
+ *   21:17 PIPE_CONFIG              Number of pipes and how pipes are interleaved
+ *   24:22 TILE_SPLIT               Tile split size
+ *   26:25 BANK_WIDTH               Number of tiles in the X direction in the same bank
+ *   28:27 BANK_HEIGHT              Number of tiles in the Y direction in the same bank
+ *   30:29 MACRO_TILE_ASPECT        Macro tile aspect ratio
+ *   32:31 NUM_BANKS                Number of banks
+ *   55:33 -                        Reserved for future use, must be zero
  *
- *   7:0 TILE_VERSION             Values are AMD_FMT_MOD_TILE_VER_*
- *  12:8 TILE                     Values are AMD_FMT_MOD_TILE_<version>_*
- *    13 DCC
- *    14 DCC_RETILE
- *    15 DCC_PIPE_ALIGN
- *    16 DCC_INDEPENDENT_64B
- *    17 DCC_INDEPENDENT_128B
- * 19:18 DCC_MAX_COMPRESSED_BLOCK Values are AMD_FMT_MOD_DCC_BLOCK_*
- *    20 DCC_CONSTANT_ENCODE
- * 23:21 PIPE_XOR_BITS            Only for some chips
- * 26:24 BANK_XOR_BITS            Only for some chips
- * 29:27 PACKERS                  Only for some chips
- * 32:30 RB                       Only for some chips
- * 35:33 PIPE                     Only for some chips
- * 55:36 -                        Reserved for future use, must be zero
  */
 #define AMD_FMT_MOD fourcc_mod_code(AMD, 0)
 
 #define IS_AMD_FMT_MOD(val) (((val) >> 56) == DRM_FORMAT_MOD_VENDOR_AMD)
 
-/* Reserve 0 for GFX8 and older */
+#define AMD_FMT_MOD_TILE_VER_GFX6 0
 #define AMD_FMT_MOD_TILE_VER_GFX9 1
 #define AMD_FMT_MOD_TILE_VER_GFX10 2
 #define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3
 #define AMD_FMT_MOD_TILE_VER_GFX11 4
 #define AMD_FMT_MOD_TILE_VER_GFX12 5
 
+/*
+ * Gfx6-8 tiling modes.
+ * A complete reference implementation is found in addrlib in the Mesa code base.
+ *
+ * - Microtiled modes (1D):
+ *   Pixel data is organized into micro tiles of 8x8 pixels.
+ *
+ * - Macrotiled modes (2D):
+ *   Micro tiles are further organized into macro tiles.
+ *   These are optimized for even load distribution among memory channels.
+ *
+ * Note that only THIN1 modes are exposed here.
+ * THICK and XTHICK are for 3D images and not relevant to DRM format modifiers.
+ */
+#define AMD_FMT_MOD_TILE_GFX6_1D_TILED_THIN1 0x2
+#define AMD_FMT_MOD_TILE_GFX6_2D_TILED_THIN1 0x4
+
 /*
  * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 as canonical
  * version.
@@ -1748,6 +1779,146 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define AMD_FMT_MOD_PIPE_SHIFT 33
 #define AMD_FMT_MOD_PIPE_MASK 0x7
 
+/*
+ * MICRO_TILE_MODE, 3 bits. Determines the micro tile format.
+ * Only relevant to Gfx6-8.
+ *
+ * DISPLAY - Displayable tiling
+ * THIN - Non-displayable tiling, a.k.a thin micro tiling
+ * DEPTH, THICK - not exposed, not relevant to DRM format modifier use cases
+ * ROTATED - not exposed, not implemented in Linux or Mesa
+ */
+#define AMD_FMT_MOD_MICROTILE_SHIFT 14ULL
+#define AMD_FMT_MOD_MICROTILE_MASK 0x7
+
+#define AMD_FMT_MOD_MICROTILE_DISPLAY 0x0
+#define AMD_FMT_MOD_MICROTILE_THIN 0x1
+
+/*
+ * PIPE_CONFIG, 5 bits. Number of pipes and how pipes are interleaved on the surface,
+ * which means the shader engine tile size and packer tile size.
+ * Typically matches the number of memory channels, or number of RBs.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ *
+ * P<n>_<a>x<b>_<c>x<d>
+ * where:
+ * <n> - number of pipes
+ * <a>x<b> - shader engine tile size
+ * <c>x<d> - packer tile size
+ */
+#define AMD_FMT_MOD_PIPE_CONFIG_SHIFT 19ULL
+#define AMD_FMT_MOD_PIPE_CONFIG_MASK 0x1f
+
+#define AMD_FMT_MOD_PIPE_CONFIG_P2 0x0
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_8x16 0x4
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_16x16 0x5
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_16x32 0x6
+#define AMD_FMT_MOD_PIPE_CONFIG_P4_32x32 0x7
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x16_8x16 0x8
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_8x16 0x9
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_8x16 0xa
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_16x32_16x16 0xb
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x16 0xc
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x32_16x32 0xd
+#define AMD_FMT_MOD_PIPE_CONFIG_P8_32x64_32x32 0xe
+#define AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_8x16 0x10
+#define AMD_FMT_MOD_PIPE_CONFIG_P16_32x32_16x16 0x11
+
+/*
+ * TILE_SPLIT, 3 bits.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ *
+ * On GFX6 (or with depth tiling modes on GFX7 and newer),
+ * the GFX block uses the GB_TILE_MODE.TILE_SPLIT field directly.
+ *
+ * On GFX7 and newer with non-depth tiling modes, the GFX block uses a
+ * split factor which is stored in the GB_TILE_MODE.SAMPLE_SPLIT field.
+ * SAMPLE_SPLIT may be: 0 - 1 byte; 1 - 2 bytes; 2 - 4 bytes; 3 - 8 bytes.
+ * The actual tile size and tile split bytes are calculated as follows:
+ *
+ *    bpp = ... <- bits per pixel in the current image
+ *    thickness = ... <- depends on array mode; may be: 1, 4, 8
+ *    num_samples = ... <- number of samples in the current image
+ *    tile_size_pixels = 8 * 8
+ *    tile_bytes_1x = thickness * tile_size_pixels * bpp / 8
+ *    sample_split_factor = 1 << SAMPLE_SPLIT
+ *    tile_split_bytes = clamp(tile_bytes_1x * sample_split_factor, 256, dram_row_size_bytes)
+ *    tile_bytes = clamp(tile_bytes_1x * num_samples, 64, tile_split_bytes)
+ *
+ * In both cases, the display block (DCE) has no SAMPLE_SPLIT
+ * and just needs the tile split bytes in the GRPH_CONTROL.GRPH_TILE_SPLIT field.
+ * To maximize compatibility between GFX6-7, we don't include the SAMPLE_SPLIT
+ * in the format modifiers.
+ *
+ * The actual tile split in bytes is: 64 << field value
+ * Possible values of this field:
+ *
+ * 0 - Tile split is 64 bytes
+ * 1 - Tile split is 128 bytes
+ * 2 - Tile split is 256 bytes
+ * 3 - Tile split is 512 bytes
+ * 4 - Tile split is 1 KiB
+ * 5 - Tile split is 2 KiB
+ * 6 - Tile split is 4 KiB
+ */
+#define AMD_FMT_MOD_TILE_SPLIT_SHIFT 24ULL
+#define AMD_FMT_MOD_TILE_SPLIT_MASK 0x7
+
+/*
+ * BANK_WIDTH, 2 bits. Number of tiles in the X direction in the same bank.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * The actual bank width is: 1 << field value
+ * Possible values:
+ *
+ * 0 - bank width is 1
+ * 1 - bank width is 2
+ * 2 - bank width is 4
+ * 3 - bank width is 8
+ */
+#define AMD_FMT_MOD_BANK_WIDTH_SHIFT 27ULL
+#define AMD_FMT_MOD_BANK_WIDTH_MASK 0x3
+
+/*
+ * BANK_HEIGHT, 2 bits. Number of tiles in the Y direction in the same bank.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * The actual bank height is: 1 << field value
+ * Possible values:
+ *
+ * 0 - bank height is 1
+ * 1 - bank height is 2
+ * 2 - bank height is 4
+ * 3 - bank height is 8
+ */
+#define AMD_FMT_MOD_BANK_HEIGHT_SHIFT 29ULL
+#define AMD_FMT_MOD_BANK_HEIGHT_MASK 0x3
+
+/*
+ * MACRO_TILE_ASPECT, 2 bits. Macro tile aspect ratio.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * Possible values:
+ *
+ * 0 - aspect ratio is 1:1
+ * 1 - aspect ratio is 4:1
+ * 2 - aspect ratio is 16:1
+ * 3 - aspect ratio is 64:1
+ */
+#define AMD_FMT_MOD_MACRO_TILE_ASPECT_SHIFT 31ULL
+#define AMD_FMT_MOD_MACRO_TILE_ASPECT_MASK 0x3
+
+/*
+ * NUM_BANKS, 2 bits. Number of banks.
+ * Only relevant to Gfx6-8 macro tiled modes.
+ * The actual number of banks is: 2 << field value
+ * Possible values:
+ *
+ * 0 - number of banks is 2
+ * 1 - number of banks is 4
+ * 2 - number of banks is 8
+ * 3 - number of banks is 16
+ */
+#define AMD_FMT_MOD_NUM_BANKS_SHIFT 33ULL
+#define AMD_FMT_MOD_NUM_BANKS_MASK 0x3
+
 #define AMD_FMT_MOD_SET(field, value) \
 	((__u64)(value) << AMD_FMT_MOD_##field##_SHIFT)
 #define AMD_FMT_MOD_GET(field, value) \
-- 
2.54.0

