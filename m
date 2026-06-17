Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893B3CD98F6
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D65C10F0D4;
	Wed, 17 Jun 2026 19:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CbS1/5eg";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF32910F0D9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:49 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso466775e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723688; x=1782328488; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lls78Swe6/iPY3Y7s52EAsqkCt6yo2FzIZtr7HaQvg8=;
 b=CbS1/5egtjZ/H5lz+RwJLfr/mJJ3ks9P+bK1iftRkO83k+0TDiyy5J2lF2U9B4NdrE
 1F9pwVUsGMg+EIEaNa13P8sk0oJNm+nhjUfTd5HFIw92/l7bsr5duPaBIEjuC6J2mhnQ
 hHekz2tjOc30rH8dIumaEHWuplqFXi8IxZHT5WzdywjdPEtfMvI13r9geXHwzXs2QpJ7
 7/zeO3fvtnaWQRN3xwQaOEClb3H2kM5ZvgT3TJ9tyHEDDxLj3gxo2xwlUw7ag5pJjBcM
 JgLQEVebyqjUhjaZ69bxRiOc5a476Eth1XQcmZZMQRtUl/5uZ3uqcnR9yF7rzOoVnhPe
 GpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723688; x=1782328488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lls78Swe6/iPY3Y7s52EAsqkCt6yo2FzIZtr7HaQvg8=;
 b=FRSRrL7cniH4rdxSnpQStRAF5IARD3mWdeKcPkuey1oNt8KnxBu1oeGW1xFb21xUde
 hu7yq9khFW4fqU+++9x6GXqT1iFhms5/URuDRb5XIjP7Ov7XyCwWMpoSmrG+zsduWk1G
 njVtPeHu+X3GV7TnLKU8p+UjskRMmWcjmxRlaNshE8uw2qbjiJ7hSGJgVOYorqG5SRbb
 ixEyJL/lRmgu2kFCoCX/QYoZkwk9E3jReOAa42Y2+EKfU/9ig+f+LE3l3SNgu0gIdQTX
 3RXBSB7MtQeK/DSHwJTiMToD4C12f0q7JZfPB0SrjO8scX2on1TOd3kxcwdTjzfICwJH
 +BaA==
X-Gm-Message-State: AOJu0YxFO0yNyjzFF8rpXAgEXkXmXUj7etRRPK++5SLzikZapN6g7y/G
 RLB91K2Pk7PgwDZVXePkz2jvhHXpuZjjSmfrdNkOz54wZSjNUQz42UW/O2Qe2g==
X-Gm-Gg: Acq92OGae49hmuvM43TW4+6jeQ6jG6q9H+6NxBJkWkiIpiwcXIOLty4cLaB1c/LyRSD
 bL0WMi13Gj1WWotprGbpPlTv3LGZgnftZT99EuQqb3x5h6LRMC3X+9qyXc0nYMQt9lkf/fap24p
 IMutiPbieb33WT8AMhLXqkMCRv/90L0BcP8tcJ1KCdwJZ8d3h/l6AHLDe81f4iEa9GSiyU7NJUo
 q3OHCVSGUssQ5/WAsLvDu2hOzhLREHkoh2YoZ3L0RI/jUFeMWysHuri0B9YAJtWpliNvm9h7P2i
 wS04OoZW5CZ/3qk+oBJ8Iuz9q3kJh6a5vJdrQnksl2aucGZfq671PNGQ+f8oFam17OCfwF/0Uas
 GKJTkhrxVPGMQ/Azl9DaGG8Y4DqmNeMRKlWvZy+JsQN9yL2Mg7pw0wsDi4M+HpQkq5gwChzQgT1
 vC9bxlnVntypo/U6thVvodi2LQxXSTmt6srEXpzr5GvptBkKoRnFxyuQ==
X-Received: by 2002:a05:600c:1394:b0:490:b8e6:be40 with SMTP id
 5b1f17b1804b1-4923821bef1mr11107575e9.21.1781723688414; 
 Wed, 17 Jun 2026 12:14:48 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:47 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 14/17] drm/amdgpu/gfx8: Support COND_EXEC on compute rings
Date: Wed, 17 Jun 2026 21:14:25 +0200
Message-ID: <20260617191428.1784083-15-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
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

It is useful to minimize collateral damage during an IP block
soft reset. We can clear the COND_EXEC condition so that
only the currently executing submission is at risk.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 6d69d49539ae..3c181628d87e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6790,10 +6790,12 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.get_wptr = gfx_v8_0_ring_get_wptr_compute,
 	.set_wptr = gfx_v8_0_ring_set_wptr_compute,
 	.emit_frame_size =
+		5 + /* gfx_v8_0_ring_emit_init_cond_exec (from amdgpu_ib_schedule) */
 		20 + /* gfx_v8_0_ring_emit_gds_switch */
 		7 + /* gfx_v8_0_ring_emit_hdp_flush */
 		5 + /* hdp_invalidate */
 		7 + /* gfx_v8_0_ring_emit_pipeline_sync */
+		5 + /* gfx_v8_0_ring_emit_init_cond_exec (from amdgpu_vm_flush) */
 		VI_FLUSH_GPU_TLB_NUM_WREG * 5 + 7 + /* gfx_v8_0_ring_emit_vm_flush */
 		7 + 7 + 7 + /* gfx_v8_0_ring_emit_fence_compute x3 for user fence, vm fence */
 		7 + /* gfx_v8_0_emit_mem_sync_compute */
@@ -6814,6 +6816,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
 	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
+	.init_cond_exec = gfx_v8_0_ring_emit_init_cond_exec,
 };
 
 static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_kiq = {
-- 
2.54.0

