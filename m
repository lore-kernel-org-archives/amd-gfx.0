Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FD8F8D779
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 20:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D7410E234;
	Thu, 16 Apr 2026 20:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kqVQ02qc";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 320DA10E277
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 20:26:54 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso101780215e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 13:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776371213; x=1776976013; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7fvtYZgLNeFP0s6Vmzgk73LU1okJQBrQkVZpMXRBWA=;
 b=kqVQ02qcRCA+YQXbcD0n1Hrl5FTLinGErTMTZ3O+0/RU6u71Zdbzj3Jt5WvGD7obwh
 OyfYleUolKsxko8fCEA8RkmqMdY9L4Kjf+mhpnGIXkOvX/qBY17yuPNrDEgPXn99DAGI
 feSwphv39aqDY0PRbB7jq2mWuFeSRopJ4TEPtd4JiWcIdNZ06Pk4o7fKPNOQYiUgXVQb
 MD1tizlsFjGkmhjGBr+djEU7e9mrkt3uZ5TSGiML7dUTG6fhd6Vx0c92OL5oXZC0Jyoh
 6uWfnKUMASd3mcdYzJDwCEVeolq4b/K1Em5NMbKvZinLIKJgkfnv5XAXsM0Lqhpis33d
 FOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776371213; x=1776976013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X7fvtYZgLNeFP0s6Vmzgk73LU1okJQBrQkVZpMXRBWA=;
 b=UF2+HlRHLFAVZ0fU1l+A/pLllrvT+Z0TSzQT+euAfbZ+bixsQpoGRjJ7V1Ru3LDMPE
 PEv7HY3QfdsXGX/HFNkHVzuYnNxqzGSrd3VHgNKNn8tTTxUfFP3bd6pkhgpkem1Whw6w
 3Y65uVrHnizfQT5DlT/ywaxfn5hgabVg8lHrX9zsoHTQeTUI0LHHQ1I5LoAV5v4Fta/G
 kaTwF4X4TVNPRqHLA6/j1Vq25XkjQTyHIkGNKMJNm8PfHttHYiax1ffaOEiujWXzPKo1
 5ETAAFlPmMIdAKoR3DkHEZzNsOg2kq+7DQs4x/xWojQlLbBE14NOHj+CITVKyhuzzhE7
 8nWQ==
X-Gm-Message-State: AOJu0Yz5a6gHmJv2YT6RxSdh3WjxtPygBnS0jtVaENEvf67fwuOQuIU8
 o86Ka6CwTfWlA3c5RwdAr67HOLxfuFiBht5N6sUdz53aCjCHyJXrutbyv1Jvrw==
X-Gm-Gg: AeBDievuYEUsJL0nRZwMpKvhBn9NWK/pCJZsBIDypdtVWelXuda+NOmg4S74WD+I0su
 toSThqIdKNLrfr6P22QZxc66NLGlmzSq6WkQaMAPgSuVbGLIozN2keZzZYLI/NhwVZqBbOPE1Tv
 0t4cfDHzpxiMCCrhyxn/2sNkYAd2GcikViHFZrPDQ8IFrFMePe8B8WCc25LKSkgtAhwUJzEvmpf
 QvC5CLE+6SOC1k/AEvNevTlkSLGSY1ek1EiGAj1ER0jcvdo8oT59yPeOuSPPSIwh9CLz4wSCS8p
 bo2I0Da5kJQCIo+T+Wg1weEMzV7Vk9g5SGYsTEBi6IKIBSQpcVTYhMl3z3GD/BSD9kMBAIZBDrl
 B4hPiKieeGph1K9ZmAJ92Lmi5OD04ZThG7JbKrr6/BguOrcpaMsuVrbOd/eFxjXVEpDaLHLc7Vk
 /NOzKHs28T4XEGE4PAfbc8BtNjRb2U1ZtMgVKju/LHs0Ybd8BO7gqmE8BDjjDKO2HSXoekrhWR9
 zoqBQ==
X-Received: by 2002:a05:600c:4fc7:b0:488:dbcb:ca08 with SMTP id
 5b1f17b1804b1-488fb787a62mr1176225e9.30.1776371212549; 
 Thu, 16 Apr 2026 13:26:52 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f581b9fbsm76941355e9.5.2026.04.16.13.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 13:26:52 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/7] drm/amdgpu/gfx6: Support harvested SI chips with disabled
 TCCs
Date: Thu, 16 Apr 2026 22:26:43 +0200
Message-ID: <20260416202643.25350-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416202643.25350-1-timur.kristof@gmail.com>
References: <20260416202643.25350-1-timur.kristof@gmail.com>
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

Link: https://bugs.freedesktop.org/show_bug.cgi?id=60879
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/2664
Fixes: 2cd46ad22383 ("drm/amdgpu: add graphic pipeline implementation for si v8")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 63 +++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 73223d97a87f5..baddb3aa7fa3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1571,6 +1571,68 @@ static void gfx_v6_0_setup_spi(struct amdgpu_device *adev)
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
+	const u32 dis_tcc_mask = amdgpu_gfx_create_bitmask(num_max_tcc) &
+				 REG_GET_FIELD(RREG32(mmCGTS_TCC_DISABLE),
+					       CGTS_TCC_DISABLE, TCC_DISABLE);
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
@@ -1729,6 +1791,7 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
 	gfx_v6_0_tiling_mode_table_init(adev);
 
 	gfx_v6_0_setup_rb(adev);
+	gfx_v6_0_setup_tcc(adev);
 
 	gfx_v6_0_setup_spi(adev);
 
-- 
2.53.0

