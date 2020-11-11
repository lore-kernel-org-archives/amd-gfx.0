Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2E7C55ABD
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 02:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BECC2168B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 02:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="Q12PtefN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BECC2168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4476589D83;
	Wed, 11 Nov 2020 02:48:42 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FA2C89D7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 02:48:41 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id s13so860120wmh.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 18:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DuRch8EIkzmam697JxWX88zdYw1WM3fhArYjfh8a6Oc=;
 b=Q12PtefNBshq06Oc2dauhGVwAPCcSQX+D2r1IeCs5iyose12rQqZltW2b3qR7D5pAe
 Pn7qNO0GHGBqLQb9O5AABhL54xjtgfYyFrgb8rIHYKZvwU65p4AUe2KwgBwKDDXa0vzs
 S4E7qErx62t3jnJpplfvzPSZGn9PB3zgO+xvX2vJRlKEXwrpIVgZdfIWWUYaYDI3d5eJ
 wuWA7PGX72IXRaJH/ytJknBshho5Fg5cLmjlT9Pj5x5gHqleFihdBDNIj+8fp/Ma4jsc
 +ruKBGPjjKBuFNR/Y+5Yl6RLDO1J1p+EqPEWYdnhnPZ9Zjf3C61U0nOJi6+Sc5u+AWy8
 Pqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DuRch8EIkzmam697JxWX88zdYw1WM3fhArYjfh8a6Oc=;
 b=Y2P25kQ9qg7xPCsv3fA54I0kEJ/o5wpw4k6PDn1cINYDstzROJn7q4FYRUWUZNIRE2
 ljg5Pv+owjfe/2yL6Qe1W1KqVRsa2nEMbZ9gq6HHMfgVXz6cKFdA80bP8rOlXCcqGdlB
 RARxDYPKxrejg1ruv/KQjG5SL9kpNB82y9/osMNlzdu3gMtywIPrQMZRTnokT8YHijH4
 iKLTIsPpjOCl+bbdb9pwrXMGe6CoIpAKmRKlrlrl71BwX1tXXwqvsqiplOhvFF+Y60Sk
 hR7zuNr0FB8ykMQmh2L8y8FJ4EvcBpUQ1bp9NlqeNYhVbLKYY6RE4n2AehcRBKu+CSsp
 t8yg==
X-Gm-Message-State: AOAM533UAaoNyHeplTO07lxWOTeQdN5agFfP/vDVLmxAMubBQKSzNgSU
 0Q9JlnD5+parh41SUVdBJnsYCtqt5qD5W6Cs
X-Google-Smtp-Source: ABdhPJw/jmx9QK3NHSxPJG7hpmiYUVEJC3QokBX2LiewIuK8xIVhllxZ/cT6PxoBMzaaIjrVtUszBQ==
X-Received: by 2002:a7b:c099:: with SMTP id r25mr1311007wmh.189.1605062919745; 
 Tue, 10 Nov 2020 18:48:39 -0800 (PST)
Received: from localhost.localdomain
 ([2a02:aa12:a77f:2000:4cea:81e7:5fd4:93f7])
 by smtp.gmail.com with ESMTPSA id c185sm724498wma.44.2020.11.10.18.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 18:48:39 -0800 (PST)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/display: Extract 3rd plane from metadata
Date: Wed, 11 Nov 2020 03:48:40 +0100
Message-Id: <20201111024840.496679-4-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111024840.496679-1-bas@basnieuwenhuizen.nl>
References: <20201111024840.496679-1-bas@basnieuwenhuizen.nl>
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
Cc: alexdeucher@gmail.com, harry.wentland@amd.com,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now that we actually expose the right number of planes we get
problems with modifier aware libva if we use an unsupported modifier.

So this ensures that we as much as possible use a modifier that
radeonsi can actually render to without going to extreme difficulty
to synchronize an extra DCC metadata plane with implicit sync.

Looking into the opaque metadata isn't ideal but this converts to
something mainly for the purpose of the userspace driver and falls
back properly if it isn't what we expect.

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 106 ++++++++++++++++++--
 1 file changed, 98 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index f66ce6ec4843..c9e98499b8a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -631,6 +631,57 @@ amdgpu_lookup_format_info(u32 format, uint64_t modifier)
 	return NULL;
 }
 
+
+/*
+ * Tries to extract the renderable DCC offset from the opaque metadata attached
+ * to the buffer.
+ */
+static int
+extract_render_dcc_offset(struct amdgpu_device *adev,
+			  struct drm_gem_object *obj,
+			  uint64_t *offset)
+{
+	struct amdgpu_bo *rbo;
+	int r = 0;
+	uint32_t metadata[10]; /* Something that fits a descriptor + header. */
+	uint32_t size;
+
+	rbo = gem_to_amdgpu_bo(obj);
+	r = amdgpu_bo_reserve(rbo, false);
+
+	if (unlikely(r)) {
+		/* Don't show error message when returning -ERESTARTSYS */
+		if (r != -ERESTARTSYS)
+			DRM_ERROR("Unable to reserve buffer: %d\n", r);
+		return r;
+	}
+
+	r = amdgpu_bo_get_metadata(rbo, metadata, sizeof(metadata), &size, NULL);
+	amdgpu_bo_unreserve(rbo);
+
+	if (r)
+		return r;
+
+	/*
+	 * The first word is the metadata version, and we need space for at least
+	 * the version + pci vendor+device id + 8 words for a descriptor.
+	 */
+	if (size < 40  || metadata[0] != 1)
+		return -EINVAL;
+
+	if (adev->family >= AMDGPU_FAMILY_NV) {
+		/* resource word 6/7 META_DATA_ADDRESS{_LO} */
+		*offset = ((u64)metadata[9] << 16u) |
+			  ((metadata[8] & 0xFF000000u) >> 16);
+	} else {
+		/* resource word 5/7 META_DATA_ADDRESS */
+		*offset = ((u64)metadata[9] << 8u) |
+			  ((u64)(metadata[7] & 0x1FE0000u) << 23);
+	}
+
+	return 0;
+}
+
 static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 {
 	struct amdgpu_device *adev = drm_to_adev(afb->base.dev);
@@ -646,6 +697,8 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 		int pipe_xor_bits = 0;
 		int bank_xor_bits = 0;
 		int packers = 0;
+		int rb = 0;
+		int pipes = ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes);
 		uint32_t dcc_offset = AMDGPU_TILING_GET(afb->tiling_flags, DCC_OFFSET_256B);
 
 		switch (swizzle >> 2) {
@@ -691,18 +744,17 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 		if (has_xor) {
 			switch (version) {
 			case AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS:
-				pipe_xor_bits = min(block_size_bits - 8,
-						    ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes));
+				pipe_xor_bits = min(block_size_bits - 8, pipes);
 				packers = min(block_size_bits - 8 - pipe_xor_bits,
 					      ilog2(adev->gfx.config.gb_addr_config_fields.num_pkrs));
 				break;
 			case AMD_FMT_MOD_TILE_VER_GFX10:
-				pipe_xor_bits = min(block_size_bits - 8,
-						    ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes));
+				pipe_xor_bits = min(block_size_bits - 8, pipes);
 				break;
 			case AMD_FMT_MOD_TILE_VER_GFX9:
-				pipe_xor_bits = min(block_size_bits - 8,
-						    ilog2(adev->gfx.config.gb_addr_config_fields.num_pipes) +
+				rb = ilog2(adev->gfx.config.gb_addr_config_fields.num_se) +
+				     ilog2(adev->gfx.config.gb_addr_config_fields.num_rb_per_se);
+				pipe_xor_bits = min(block_size_bits - 8, pipes +
 						    ilog2(adev->gfx.config.gb_addr_config_fields.num_se));
 				bank_xor_bits = min(block_size_bits - 8 - pipe_xor_bits,
 						    ilog2(adev->gfx.config.gb_addr_config_fields.num_banks));
@@ -721,6 +773,7 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 			bool dcc_i64b = AMDGPU_TILING_GET(afb->tiling_flags, DCC_INDEPENDENT_64B) != 0;
 			bool dcc_i128b = version >= AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
 			const struct drm_format_info *format_info;
+			u64 render_dcc_offset;
 
 			/* Enable constant encode on RAVEN2 and later. */
 			bool dcc_constant_encode = adev->asic_type > CHIP_RAVEN ||
@@ -738,8 +791,45 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 				    AMD_FMT_MOD_SET(DCC_MAX_COMPRESSED_BLOCK, max_cblock_size);
 
 			afb->base.offsets[1] = dcc_offset * 256 + afb->base.offsets[0];
-			afb->base.pitches[1] = AMDGPU_TILING_GET(afb->tiling_flags, DCC_PITCH_MAX) + 1;
-
+			afb->base.pitches[1] =
+				AMDGPU_TILING_GET(afb->tiling_flags, DCC_PITCH_MAX) + 1;
+
+			/*
+			 * If the userspace driver uses retiling the tiling flags do not contain
+			 * info on the renderable DCC buffer. Luckily the opaque metadata contains
+			 * the info so we can try to extract it. The kernel does not use this info
+			 * but we should convert it to a modifier plane for getfb2, so the
+			 * userspace driver that gets it doesn't have to juggle around another DCC
+			 * plane internally.
+			 */
+			if (extract_render_dcc_offset(adev, afb->base.obj[0],
+						      &render_dcc_offset) == 0 &&
+			    render_dcc_offset != 0 &&
+			    render_dcc_offset != afb->base.offsets[1] &&
+			    render_dcc_offset < UINT_MAX) {
+				uint32_t dcc_block_bits;  /* of base surface data */
+
+				modifier |= AMD_FMT_MOD_SET(DCC_RETILE, 1);
+				afb->base.offsets[2] = render_dcc_offset;
+
+				if (adev->family >= AMDGPU_FAMILY_NV) {
+					int extra_pipe = 0;
+
+					if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
+					    pipes == packers && pipes > 1)
+						extra_pipe = 1;
+
+					dcc_block_bits = max(20, 16 + pipes + extra_pipe);
+				} else {
+					modifier |= AMD_FMT_MOD_SET(RB, rb) |
+						    AMD_FMT_MOD_SET(PIPE, pipes);
+					dcc_block_bits = max(20, 18 + rb);
+				}
+
+				dcc_block_bits -= ilog2(afb->base.format->cpp[0]);
+				afb->base.pitches[2] = ALIGN(afb->base.width,
+							     1u << ((dcc_block_bits + 1) / 2));
+			}
 			format_info = amdgpu_lookup_format_info(afb->base.format->format,
 								modifier);
 			if (!format_info)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
