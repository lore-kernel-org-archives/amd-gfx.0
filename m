Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD67A606A327
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EPrQEuYp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F17C10EBF9;
	Mon,  2 Nov 2026 08:06:59 +0000 (UTC)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3563010E1AE
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Oct 2026 04:01:39 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5eae12762c9so621409e0c.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 21:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793419298; x=1794024098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qUjUqHrSOpVZo1vvK2oqewHli0ce+brsa+hIMhHohPQ=;
 b=EPrQEuYpOkhzg17CAMoYjZ0RtDwijjrBzQvxnpvE5QslcSMVTQtd8p5M52Gk0yw1d6
 VtSlNiM0DFth+n/SjKAj/vA9d6rL3PGNFHdvE2PnRva7fezaKB3Pi6U8i34lW7Gzz2xE
 af5V6EEGapbHPvG2UNJ6j2TCMp7Fj22eGNwxroZfcnQlCr1e6wlZNB6SWZvUQMQKTRkX
 13FpHeyUyGUl3SD7h5e8K2PWZ9IV4hikkMxCKV+C0nH8OUbdXTiT8UGBjO0jWX3VTLF9
 Vvv7gqP+DBVZfYYUZtOrMaVZ7jvK/tSgIW/19Ls/cY9Zh+RW/DKtEIA6infMwe2y/TNf
 tD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793419298; x=1794024098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qUjUqHrSOpVZo1vvK2oqewHli0ce+brsa+hIMhHohPQ=;
 b=qK0YdCptD93SWWXDvUDMGd2wdFU86RYTDmy1+524MRQEZHlimbWVo1Tlgml9psKGhk
 e956N+28a9LG1yUUTrKjX1gJBo957PH4akYj2bzEUQXvrX+/ZYH/iIVvGU27Twtp+Xjf
 zzoEYsLVZMqFfWLHNXr3/5dIZmB9F0bYNh2z8R3s/8zAYs003zh9WdN0n98B/ugCgqFU
 dD8Gf8mRZ3555U60oVjs/wl99qIMBajuSVAw55Ofg6Pm/4tOPT5Vq/IhSrBRjQVuPA6n
 xYTSlyQFFC7EO8RdhLLFIW7GrqUxVUIfGwpAsGN6EjOz4I3t5FeG2tQf2Cp25dLldxHo
 xBow==
X-Gm-Message-State: AFq9FYJszwTUoh7D6AwtN6dbj6WW/FfAfErMzXehZosBVnby4ep4NDWG
 +B6qMjOa/9DjmaUbvVFiQKOQg1oQ6/DF6pDAc1lsVDpYd0VJZX8jv7LYj3wJZgLIsRhthw==
X-Gm-Gg: AYBFou3w/phTGt0/I8mm9EG1KJUcDoYUF5kGfaRts2/fUSyq9P7aSeBSKuaz/nXcPJd
 FYw/ztMbxmugtA4Yui+1grv2840zFJenqct0hget2DN5NKiwUj7DDdWkfTAGcie3sa5bcd/aPmi
 ljPeVIpgQ5HJj1OKA4qDPAdfPRv/sBnhFnqJhwK2D332vFmnixkEwQhNSPqYv7Q9bTsTXMIbd1y
 suCP3BIdEDkZpf9luFCY5A+h/vyop3xBTiDMO9/Pk195w7zIg1SrIqP/XnAx43IQOEcJiShkDpM
 F3JzfX5zbHs09PVl2tXuMrFKvTDzdXoq62G0ey91MsqJtL9Ier0Zqrx8aUzwBTiLAT6TYkHMRdC
 JQpAi0J8A/v77US5X4lrc/3shUBQZMr1e/ezTaTaQ+0Jhjrp429M1x4czsLFLb4hgDj2MejSkTX
 EkUQn8f2CcEO3ltMVkt2cff5FMh2z/8h+Pblk5vQv5shfue/I3+1h2tQl2V/bveimaQ9Ym84uei
 9P7ONr7O/MlpPOscjNQaHwQ63aSEPOzEF0TeEeJTfGcpMuOhd8DyytR3JCtU905je5uIY/IegzD
 TWr1XrFH6wB3P0a0te8AalkXDA==
X-Received: by 2002:a05:6122:1da0:b0:5ea:c51a:37a1 with SMTP id
 71dfb90a1353d-5ec686ff12emr2004301e0c.8.1793419297861; 
 Fri, 30 Oct 2026 21:01:37 -0700 (PDT)
Received: from jeta ([2a03:d000:4386:7a7b:937:de08:2c2e:37e9])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ec69bf34c0sm4620576e0c.8.2026.10.30.21.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 21:01:36 -0700 (PDT)
From: Egor Perevoshchikov <rickbatra0z@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Egor Perevoshchikov <rickbatra0z@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH] drm/amd/display: Restore PSR-SU guard in power module
Date: Sat, 31 Oct 2026 07:00:50 +0300
Message-ID: <20261031040051.46100-1-rickbatra0z@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit a5ce8695d6d1 ("drm/amd/display: Avoid configuring PSR granularity
if PSR-SU not supported") restricted DSC slice-height configuration to
PSR-SU. The power-module integration removed that guarded caller. Its
replacement in mod_power_psr_notify_mode_change() calls
psr_su_set_dsc_slice_height() unconditionally and ignores its return value.

On PSR1 links with a DSC slice configuration, this applies a PSR-SU-only
alignment check even though selective update is not enabled. If the
calculated DSC slice height is not a multiple of the nonzero advertised
SU Y granularity, the helper triggers an assertion. It also sets
dsc_slice_height before failing the check, so the caller passes this
SU-specific value into PSR1 setup despite the failure.

Restore the PSR version guard and failure handling in the new caller.
PSR1 proceeds with the zero-initialized DSC slice height, while PSR-SU
retains its alignment validation and stops setup if that validation fails.

Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3027
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Egor Perevoshchikov <rickbatra0z@gmail.com>
---
Tested on a Xiaomi Redmi Book Pro 15 2023 (TM2209), Ryzen 7 7840HS /
Radeon 780M, BIOS RMAPH5B0P0909, with Linux 7.3.0 on NixOS.

The tested panel uses PSR1. Its 2000-line mode has 16 vertical DSC slices,
giving a slice height of 125, which is not a multiple of its advertised
SU Y granularity of 4.

Before the patch, boot produced:

  WARNING: .../display/modules/power/power_psr.c:666
    psr_su_set_dsc_slice_height+0x7e/0xa0 [amdgpu]
    mod_power_psr_notify_mode_change+0x1b7/0x270 [amdgpu]
    mod_power_notify_mode_change+0x160/0x1d0 [amdgpu]

After rebuilding and booting with the patch, that warning is absent.
With VRR disabled, repeated debugfs reads report psr_state=6 (PSR_STATE3)
both with and without the patch. PSR remains functional in both cases.

The older dsc2_disable warning in #3027 is no longer reproduced on this
kernel. This patch addresses the remaining psr_su_set_dsc_slice_height
warning; it does not modify the dsc2_disable path.

The patch is based on the mainline v7.3 release:
  c03c1a14507dfaf8b856c2608f9ac216021fc222
This matches the kernel release used for hardware testing. The original
power_psr.c is identical to the Linux 7.3 source used for the
hardware-tested patch.
The patch also applies to drm-next-2026-10-31:
  f94ed3d7cba3c83eef50b1a96d630d63cf54f69c

Additional validation covered eight cases in an isolated C harness using
the actual setup and slice-height functions with hardware calls stubbed.
The original PSR1 warning was reproduced; the patch avoids it, retains
valid PSR-SU setup, and prevents setup after failed SU alignment
validation.
The patched translation unit was also compiled against Linux 7.3 headers.
PSR-SU behavior has not been tested on PSR-SU-capable hardware.

LLM assistance: source history tracing; stubbed software tests; submission
checks.

 drivers/gpu/drm/amd/display/modules/power/power_psr.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/power/power_psr.c b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
index 96bb77fff05..7139395b5c0 100644
--- a/drivers/gpu/drm/amd/display/modules/power/power_psr.c
+++ b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
@@ -94,9 +94,12 @@ bool mod_power_psr_notify_mode_change(struct mod_power *mod_power,
 	 * The value of DSC slice height is determined in DSC Driver but it does not
 	 * propagated out here, so we need to calculate it as below 'slice_height'.
 	 */
-	psr_su_set_dsc_slice_height(dc, link,
-				(struct dc_stream_state *) stream,
-				&psr_config);
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) {
+		if (!psr_su_set_dsc_slice_height(dc, link,
+						 (struct dc_stream_state *)stream,
+						 &psr_config))
+			return false;
+	}

 	dc_link_setup_psr(link, stream, &psr_config, &psr_context);


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
--
2.56.0

