Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1442F99C9A
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2026 21:49:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A864D10E1F5;
	Sat, 18 Apr 2026 21:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QPl1Cb3L";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B9B10E17C
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 21:49:43 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso17179155e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 14:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776548982; x=1777153782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iFssyEsx7i6kriqtBKGS3voK53oBGP2pg3PipZoqby8=;
 b=QPl1Cb3LkZYx2ebad6517LOBFVZKhWYphki4YVHLE9h2W3c58ZlfNQiRqVbAsreqtg
 IQqh+rOJgwT9G5t7/W0Dmdsw7RgPWtop4ka/cETTc4C1g/833Q5RqkqH/njdqTzKLjtl
 24bNimNor/lQvGA1Xj/GXKo8rBLmBRNkleZwBpdBID2XWqthrillYPxK43jbGlI7sFp/
 tqAlZ/kL28GytSf8ld9aXZse/Mr6ktnEgsxm3fneGSPcorZjhx1A9CkT5rOAU22LDKLM
 46tCYUyBkEqDkr0vxmCLPB/RACP7xTcAUFsxBiYTJoopq0ST1FfIBbqJHsHckRSyUTo5
 1DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776548982; x=1777153782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iFssyEsx7i6kriqtBKGS3voK53oBGP2pg3PipZoqby8=;
 b=SPpD5TcYE6liw4pDHfQoWB1+m9LmJwkPTe3CdBhojBq1l+8SE5kQmaZwRvXiQNdwj0
 +SUes0XGkBWDFW5NG6uU7bAmzWfKdaQ0NM9krozkxWw+k4A+09t4bLYEqoBNUKTyytqR
 aC+wbTYuSoZ/l2nDGCzXansmjkI3kriKUslXsFWxYrLfhk+zp+XJZEES4+jkUm6SJXOF
 vJMqKPU6zcgnidUxWBUGXQJnyJMjg5Xw7Q6E0PzVGFj2CnYLuaX7myhuzGQ4/409a/LC
 PaCCo3EEqKem9MaDFArucBKaQWHXU+2NSEaJ7LinTlkUjW6BPAmwP1Sg2vt4bcs12fLn
 pBWA==
X-Gm-Message-State: AOJu0YwfUZm2WTkZFp4cZNWn5p2GOTbFwZ1X0nbcvS1c+0kpe3BC91dk
 ctf5WqlLrY8fj5KQdXBykdyCxWEEFn5OL68fv2MbiZKPTWKZo3Ajc9MOt6Pb6w==
X-Gm-Gg: AeBDieteDTPoCLOE9IYh7t5tVG0hBkKuLqIsMg5FmIma/+UpETYTEUttW+sUiTpJ7go
 k4H88vnnl3zVpjg/hUKm3ajVmeIdklVRPPOU6XoyXXzQim9py5q6kxVNxKBVGihvcNbvhD5MDnF
 +KuPBO9qzZZ+wX5Xou00Qw7ZTym8pmEQcB7mZ3pHlvpx57Yp6sQycSqIqddFUFPR5YTiBXmht0A
 VBikV0e82hztRXrYnG/0LFt3As5SvOocD0DQDxWEsYOpeX4ai1Gg2ExT8XNGfRZyss9KrmYcehg
 /It44gIyEnpZGaPUQmGiJ/dRSUqij66+bKQjYtL5ZE/Nzlm7TyCTMl7Mjo598+LPkBoIlq916Hz
 Jul+098Ew5Bp1jg/NO89gEQR+Vylx7d3E5eCP9c/2uxzgsJIOaa9Cls4PaxGv89G4PisNq5qeQq
 OY9+G2d6MpRqfwWGeGX6QJujGtpCXTKQ7PQHUADkkMkBixKBdwFuceLh1WJrovmwQQMmMWYnjZ3
 ClHKA==
X-Received: by 2002:a05:600c:4711:b0:485:6e40:5584 with SMTP id
 5b1f17b1804b1-488fb745261mr115836865e9.6.1776548981636; 
 Sat, 18 Apr 2026 14:49:41 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm171531905e9.2.2026.04.18.14.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 14:49:41 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/4] drm/amdgpu/gfx6: Support harvested SI chips with disabled
 TCCs (v2)
Date: Sat, 18 Apr 2026 23:49:33 +0200
Message-ID: <20260418214933.230912-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260418214933.230912-1-timur.kristof@gmail.com>
References: <20260418214933.230912-1-timur.kristof@gmail.com>
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

This commit fixes amdgpu to work on the Radeon HD 7870 XT
which has never worked with the Linux open source drivers before.

Some boards have "harvested" chips, meaning that some parts of
the chip are disabled and fused, and it's sold for cheaper and
under a different marketing name.
On a harvested chip, any of the following can be disabled:
- CUs (Compute Units)
- RBs (Render Backend, aka. ROP)
- Memory channels (ie. the chip has a lower bandwidth)
- TCCs (ie. less L2 cache)

Handle chips with harvested TCCs by patching the registers
that configure how TCCs are mapped.

If some TCCs are disabled, we need to make sure that
the disabled TCCs are not used, and the remaining TCCs
are used optimally.

TCP_CHAN_STEER_LO/HI control which TCC is used by TCP channels.
TCP_ADDR_CONFIG.NUM_TCC_BANKS controls how many channels are used.

Note that the TCC configuration is highly relevant to performance.
Suboptimal configuration (eg. CHAN_STEER=0) can significantly
reduce gaming performance.

For optimal performance:
- Rely on the CHAN_STEER from the golden registers table,
  only skip disabled TCCs but keep the mapping order.
- Limit NUM_TCC_BANKS to number of active TCCs to avoid thrashing,
  which performs better than using the same TCC twice.

v2:
- Also consider CGTS_USER_TCC_DISABLE for disabled TCCs.

Link: https://bugs.freedesktop.org/show_bug.cgi?id=60879
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/2664
Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation for si v8")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 73223d97a87f5..ac90d8e9d86a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1571,6 +1571,71 @@ static void gfx_v6_0_setup_spi(struct amdgpu_device *adev)
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
+/**
+ * gfx_v6_0_setup_tcc() - setup which TCCs are used
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Verify whether the current GPU has any TCCs disabled,
+ * which can happen when the GPU is harvested and some
+ * memory channels are disabled, reducing the memory bus width.
+ * For example, on the Radeon HD 7870 XT (Tahiti LE).
+ *
+ * If some TCCs are disabled, we need to make sure that
+ * the disabled TCCs are not used, and the remaining TCCs
+ * are used optimally.
+ *
+ * TCP_CHAN_STEER_LO/HI control which TCC is used by TCP channels.
+ * TCP_ADDR_CONFIG.NUM_TCC_BANKS controls how many channels are used.
+ *
+ * For optimal performance:
+ * - Rely on the CHAN_STEER from the golden registers table,
+ *   only skip disabled TCCs but keep the mapping order.
+ * - Limit NUM_TCC_BANKS to number of active TCCs to avoid thrashing,
+ *   which performs better than using the same TCC twice.
+ */
+static void gfx_v6_0_setup_tcc(struct amdgpu_device *adev)
+{
+	u32 i, tcc, tcp_addr_config, num_active_tcc = 0;
+	u64 chan_steer, patched_chan_steer = 0;
+	const u32 num_max_tcc = adev->gfx.config.max_texture_channel_caches;
+	const u32 dis_tcc_mask =
+		amdgpu_gfx_create_bitmask(num_max_tcc) &
+		(REG_GET_FIELD(RREG32(mmCGTS_TCC_DISABLE),
+			       CGTS_TCC_DISABLE, TCC_DISABLE) |
+		 REG_GET_FIELD(RREG32(mmCGTS_USER_TCC_DISABLE),
+			       CGTS_USER_TCC_DISABLE, TCC_DISABLE));
+
+	/* When no TCC is disabled, the golden registers table already has optimal TCC setup */
+	if (!dis_tcc_mask)
+		return;
+
+	/* Each 4-bit nibble contains the index of a TCC used by all TCPs */
+	chan_steer = RREG32(mmTCP_CHAN_STEER_LO) | ((u64)RREG32(mmTCP_CHAN_STEER_HI) << 32ull);
+
+	/* Patch the TCP to TCC mapping to skip disabled TCCs */
+	for (i = 0; i < num_max_tcc; ++i) {
+		tcc = (chan_steer >> (u64)(4 * i)) & 0xf;
+
+		if (!((1 << tcc) & dis_tcc_mask)) {
+			/* Copy enabled TCC indices to the patched register value. */
+			patched_chan_steer |= (u64)tcc << (u64)(4 * num_active_tcc);
+			++num_active_tcc;
+		}
+	}
+
+	WARN_ON(num_active_tcc != num_max_tcc - hweight32(dis_tcc_mask));
+
+	/* Patch number of TCCs used by TCPs */
+	tcp_addr_config = REG_SET_FIELD(RREG32(mmTCP_ADDR_CONFIG),
+					TCP_ADDR_CONFIG, NUM_TCC_BANKS,
+					num_active_tcc - 1);
+
+	WREG32(mmTCP_ADDR_CONFIG, tcp_addr_config);
+	WREG32(mmTCP_CHAN_STEER_HI, upper_32_bits(patched_chan_steer));
+	WREG32(mmTCP_CHAN_STEER_LO, lower_32_bits(patched_chan_steer));
+}
+
 static void gfx_v6_0_config_init(struct amdgpu_device *adev)
 {
 	adev->gfx.config.double_offchip_lds_buf = 0;
@@ -1729,6 +1794,7 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
 	gfx_v6_0_tiling_mode_table_init(adev);
 
 	gfx_v6_0_setup_rb(adev);
+	gfx_v6_0_setup_tcc(adev);
 
 	gfx_v6_0_setup_spi(adev);
 
-- 
2.53.0

