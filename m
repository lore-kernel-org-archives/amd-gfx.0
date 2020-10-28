Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97380C55179
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D62B72071A
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 23:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="XsA5Vb12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62B72071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A5E6E81B;
	Wed, 28 Oct 2020 23:52:45 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB946E81B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 23:52:45 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id dk16so768018ejb.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 16:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=abyXjBJh7MHY6SDlqzUoCUFisTeyUf6InXnMcJgtsSo=;
 b=XsA5Vb12ggxWPdsdFZGA4ezoHdGXUhswHTBx6oTcoWOvBjnThmGyEW14ktimf+qWdT
 2tlQ4kR4Z97JeuqeT/77B+hlBNNI9LkQ1GmWJ3q97cvr7arcHL0DcffsLWP/+kuSfgCC
 7C9dUi6iJKXduZcWwEFu9kb85ZjIxys119fNsK8oaLbjQ3RHeKD8OmVoltr/ES7RTReg
 +77UVuLIfoSgYC+OheESKWicuwPmfF1eD8d49Jyeb+PDb0xGresBKeUcdK5cK4KzQ/Lc
 TPrMKrqPUKGZu1V+lMq2YduMyP0kQc5uuycd8p3vPN5lJjm07RTz32zbgc4Zeg7Qux7h
 6YCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=abyXjBJh7MHY6SDlqzUoCUFisTeyUf6InXnMcJgtsSo=;
 b=sxDGW9dZ3g+BKEIK26DDxeeaQhZV/VjZrIZXRANQEhbYelfAJZEyOysOI0m7+3hSpA
 FVHRz5wpvOB27id1ZKaq0uXVupLRSEX4neEf4P9gkjseiGKf2TYf8BGh+0UCC/+uaFn3
 S81tNHudjbAm7TOMI7sbm+sNDmt6b/p0TYi80WTpwsK5BoqoA3oErcdAS3qO/lu/Tikx
 gavaZuAiMwaZBKIs8WMOPOxZexZDFeIXlqUDI5R4KBEJXbk3jlwi1lcdAJPXcLAf100b
 6Gjf94/6PHu1ynJ7B6EP1u2i5K9i0Y3Fw+iUNC+8sYpMGy2MtrxKNf96+us4wt+q3ZK6
 KpKQ==
X-Gm-Message-State: AOAM5301J+Ygk3BokB/BLDu9sdJy7EIOowmjZm2fHo3dVZQuJCS2yk/I
 J17jE3ljPle5vucOY4zoR+Ic8plMn9Leeg==
X-Google-Smtp-Source: ABdhPJz+gXRjZ14ntq0OOrLChlWWu8pX++x025EBPCokvcIaLbPnLVVuXzDdj8tiLfh0yZRANJEYjw==
X-Received: by 2002:a17:906:d89:: with SMTP id m9mr1603847eji.18.1603929163708; 
 Wed, 28 Oct 2020 16:52:43 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id o13sm479174ejr.120.2020.10.28.16.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 16:52:43 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 04/11] drm/fourcc: Add AMD DRM modifiers.
Date: Thu, 29 Oct 2020 00:52:34 +0100
Message-Id: <20201028235241.3299-5-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
References: <20201028235241.3299-1-bas@basnieuwenhuizen.nl>
MIME-Version: 1.0
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
Cc: alexdeucher@gmail.com, Alex Deucher <alexander.deucher@amd.com>,
 harry.wentland@amd.com, nicholas.kazlauskas@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This adds modifiers for GFX9+ AMD GPUs.

As the modifiers need a lot of parameters I split things out in
getters and setters.
  - Advantage: simplifies the code a lot
  - Disadvantage: Makes it harder to check that you're setting all
                  the required fields.

The tiling modes seem to change every generation, but the structure
of what each tiling mode is good for stays really similar. As such
the core of the modifier is
 - the tiling mode
 - a version. Not explicitly a GPU generation, but splitting out
   a new set of tiling equations.

Sometimes one or two tiling modes stay the same and for those we
specify a canonical version.

Then we have a bunch of parameters on how the compression works.
Different HW units have different requirements for these and we
actually have some conflicts here.

e.g. the render backends need a specific alignment but the display
unit only works with unaligned compression surfaces. To work around
that we have a DCC_RETILE option where both an aligned and unaligned
compression surface are allocated and a writer has to sync the
aligned surface to the unaligned surface on handoff.

Finally there are some GPU parameters that participate in the tiling
equations. These are constant for each GPU on the rendering/texturing
side. The display unit is very flexible however and supports all
of them :|

Some estimates:
 - Single GPU, render+texture: ~10 modifiers
 - All possible configs in a gen, display: ~1000 modifiers
 - Configs of actually existing GPUs in a gen: ~100 modifiers

For formats with a single plane everything gets put in a separate
DRM plane. However, this doesn't fit for some YUV formats, so if
the format has >1 plane, we let the driver pack the surfaces into
1 DRM plane per format plane.

This way we avoid X11 rendering onto the frontbuffer with DCC, but
still fit into 4 DRM planes.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 include/uapi/drm/drm_fourcc.h | 115 ++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 82f327801267..df56e71a7380 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1056,6 +1056,121 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
  */
 #define AMLOGIC_FBC_OPTION_MEM_SAVING		(1ULL << 0)
 
+/*
+ * AMD modifiers
+ *
+ * Memory layout:
+ *
+ * without DCC:
+ *   - main surface
+ *
+ * with DCC & without DCC_RETILE:
+ *   - main surface in plane 0
+ *   - DCC surface in plane 1 (RB-aligned, pipe-aligned if DCC_PIPE_ALIGN is set)
+ *
+ * with DCC & DCC_RETILE:
+ *   - main surface in plane 0
+ *   - displayable DCC surface in plane 1 (not RB-aligned & not pipe-aligned)
+ *   - pipe-aligned DCC surface in plane 2 (RB-aligned & pipe-aligned)
+ *
+ * For multi-plane formats the above surfaces get merged into one plane for
+ * each format plane, based on the required alignment only.
+ */
+#define AMD_FMT_MOD fourcc_mod_code(AMD, 0)
+
+#define IS_AMD_FMT_MOD(val) (((val) >> 56) == DRM_FORMAT_MOD_VENDOR_AMD)
+
+/* Reserve 0 for GFX8 and older */
+#define AMD_FMT_MOD_TILE_VER_GFX9 1
+#define AMD_FMT_MOD_TILE_VER_GFX10 2
+#define AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS 3
+
+/*
+ * 64K_S is the same for GFX9/GFX10/GFX10_RBPLUS and hence has GFX9 as canonical
+ * version.
+ */
+#define AMD_FMT_MOD_TILE_GFX9_64K_S 9
+
+/*
+ * 64K_D for non-32 bpp is the same for GFX9/GFX10/GFX10_RBPLUS and hence has
+ * GFX9 as canonical version.
+ */
+#define AMD_FMT_MOD_TILE_GFX9_64K_D 10
+#define AMD_FMT_MOD_TILE_GFX9_64K_S_X 25
+#define AMD_FMT_MOD_TILE_GFX9_64K_D_X 26
+#define AMD_FMT_MOD_TILE_GFX9_64K_R_X 27
+
+#define AMD_FMT_MOD_DCC_BLOCK_64B 0
+#define AMD_FMT_MOD_DCC_BLOCK_128B 1
+#define AMD_FMT_MOD_DCC_BLOCK_256B 2
+
+#define AMD_FMT_MOD_TILE_VERSION_SHIFT 0
+#define AMD_FMT_MOD_TILE_VERSION_MASK 0xFF
+#define AMD_FMT_MOD_TILE_SHIFT 8
+#define AMD_FMT_MOD_TILE_MASK 0x1F
+
+/* Whether DCC compression is enabled. */
+#define AMD_FMT_MOD_DCC_SHIFT 13
+#define AMD_FMT_MOD_DCC_MASK 0x1
+
+/*
+ * Whether to include two DCC surfaces, one which is rb & pipe aligned, and
+ * one which is not-aligned.
+ */
+#define AMD_FMT_MOD_DCC_RETILE_SHIFT 14
+#define AMD_FMT_MOD_DCC_RETILE_MASK 0x1
+
+/* Only set if DCC_RETILE = false */
+#define AMD_FMT_MOD_DCC_PIPE_ALIGN_SHIFT 15
+#define AMD_FMT_MOD_DCC_PIPE_ALIGN_MASK 0x1
+
+#define AMD_FMT_MOD_DCC_INDEPENDENT_64B_SHIFT 16
+#define AMD_FMT_MOD_DCC_INDEPENDENT_64B_MASK 0x1
+#define AMD_FMT_MOD_DCC_INDEPENDENT_128B_SHIFT 17
+#define AMD_FMT_MOD_DCC_INDEPENDENT_128B_MASK 0x1
+#define AMD_FMT_MOD_DCC_MAX_COMPRESSED_BLOCK_SHIFT 18
+#define AMD_FMT_MOD_DCC_MAX_COMPRESSED_BLOCK_MASK 0x1
+
+/*
+ * DCC supports embedding some clear colors directly in the DCC surface.
+ * However, on older GPUs the rendering HW ignores the embedded clear color
+ * and prefers the driver provided color. This necessitates doing a fastclear
+ * eliminate operation before a process transfers control.
+ *
+ * If this bit is set that means the fastclear eliminate is not needed for these
+ * embeddable colors.
+ */
+#define AMD_FMT_MOD_DCC_CONSTANT_ENCODE_SHIFT 19
+#define AMD_FMT_MOD_DCC_CONSTANT_ENCODE_MASK 0x1
+
+/*
+ * The below fields are for accounting for per GPU differences. These are only
+ * relevant for GFX9 and later and if the tile field is *_X/_T.
+ *
+ * PIPE_XOR_BITS = always needed
+ * BANK_XOR_BITS = only for TILE_VER_GFX9
+ * PACKERS = only for TILE_VER_GFX10_RBPLUS
+ * RB = only for TILE_VER_GFX9 & DCC
+ * PIPE = only for TILE_VER_GFX9 & DCC & (DCC_RETILE | DCC_PIPE_ALIGN)
+ */
+#define AMD_FMT_MOD_PIPE_XOR_BITS_SHIFT 20
+#define AMD_FMT_MOD_PIPE_XOR_BITS_MASK 0x7
+#define AMD_FMT_MOD_BANK_XOR_BITS_SHIFT 23
+#define AMD_FMT_MOD_BANK_XOR_BITS_MASK 0x7
+#define AMD_FMT_MOD_PACKERS_SHIFT 26 /* aliases with BANK_XOR_BITS */
+#define AMD_FMT_MOD_PACKERS_MASK 0x7
+#define AMD_FMT_MOD_RB_SHIFT 29
+#define AMD_FMT_MOD_RB_MASK 0x7
+#define AMD_FMT_MOD_PIPE_SHIFT 32
+#define AMD_FMT_MOD_PIPE_MASK 0x7
+
+#define AMD_FMT_MOD_SET(field, value) \
+	((uint64_t)(value) << AMD_FMT_MOD_##field##_SHIFT)
+#define AMD_FMT_MOD_GET(field, value) \
+	(((value) >> AMD_FMT_MOD_##field##_SHIFT) & AMD_FMT_MOD_##field##_MASK)
+#define AMD_FMT_MOD_CLEAR(field) \
+	(~((uint64_t)AMD_FMT_MOD_##field##_MASK << AMD_FMT_MOD_##field##_SHIFT))
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
