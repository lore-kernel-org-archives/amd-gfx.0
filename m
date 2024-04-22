Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4BFC10F15
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 07:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D2751131EF;
	Tue, 23 Apr 2024 07:43:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=netflix.com header.i=@netflix.com header.b="nslx70Ka";
	dkim-atps=neutral
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com
 [209.85.166.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5417B112B83
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 14:35:57 +0000 (UTC)
Received: by mail-io1-f44.google.com with SMTP id
 ca18e2360f4ac-7da04b08b82so146353639f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netflix.com; s=google; t=1713796556; x=1714401356; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a/JPFUxV2ArWkhwNnn1v7zuWOs9XoBJjsryMcg9Mcoo=;
 b=nslx70KarQ4HhxXGyp2t1E6v16EEd5ZT54unFmRWNKHae6THD8Z6h501lFS4+Dkprv
 8KbxJw2txgECTG4hd3EVQIOna/x7Bl25AIXxhNsdK18BgHfklXdACCnnwE8uPLHAUQ2k
 XGplYxmFSwBeFH8rys6v6QB6aJORBC6122yI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713796556; x=1714401356;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a/JPFUxV2ArWkhwNnn1v7zuWOs9XoBJjsryMcg9Mcoo=;
 b=i69fTS1+ybo2t0I20aAtIm+vHiv0L7mtuWcocQS793BfDnm1f32RoaQeVOQQEcrMdf
 3F4HC6LQdFIJ5aUa7OE4JZoQFo70cJAol0rIMMkaHy15hJTe2ThuNa64RUyrB+4JvJMA
 KzzSnL9fbGHGbAuOi85j8VYaCcsE1fo2KLfcBM9hzsB4trC4/B0vYzvvEnwvLqZaRfIq
 4SQRuFD531repUXIZ3DVKKxd8YlF8TUtZZbtqhbn2PmcyWZvmwrO/3K4HeoGMj8bF3J6
 osQRpzD/qMZ127RLyGSeNY66rNFQHDZOtpFHuUhvggjB6AX4RvP2lbqMaVhz1yy6U/bx
 zY6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM9fX9rsaUo41to4xySq7dfEzgIykXR+KK9guCoOy2vPXWJlOzVNG6wdY7l31QErMqvsNuwZO0ZM0cyOqNnn1b8Pw7Dh0/NAn+13UpkA==
X-Gm-Message-State: AOJu0Yx3jVwvKDVSwTb3hH1KwvluDki/UAicl1LM0NvDC6oFWRbaCMa/
 MQ2H1RfCg4uq61kcUi7ARTMUhf9/L1tCwK0iWdoi4KRxX6eGTsBLCrDJWjzrCXQ=
X-Google-Smtp-Source: AGHT+IGDHc8HUrs0iww/TdL2zMyyadTokjPSQhWtaZ8TbB4GbBiQ8FO8zM77jN0fCSdoCB79InX/Ew==
X-Received: by 2002:a05:6602:1b92:b0:7cb:ffe6:b320 with SMTP id
 dq18-20020a0566021b9200b007cbffe6b320mr11608580iob.5.1713796555960; 
 Mon, 22 Apr 2024 07:35:55 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:e98c:6f5c:74a4:9a12])
 by smtp.gmail.com with UTF8SMTPSA id
 dv10-20020a056638608a00b00482f7427748sm2849642jab.135.2024.04.22.07.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 07:35:55 -0700 (PDT)
From: Jose Fernandez <josef@netflix.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Wenjing Liu <wenjing.liu@amd.com>,
 Alan Liu <haoping.liu@amd.com>, George Shen <george.shen@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Ilya Bakoulin <ilya.bakoulin@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Leo Ma <hanghong.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Jose Fernandez <josef@netflix.com>
Subject: [PATCH RESEND] drm/amd/display: Fix division by zero in
 setup_dsc_config
Date: Mon, 22 Apr 2024 08:35:44 -0600
Message-Id: <20240422143544.20481-1-josef@netflix.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Apr 2024 07:43:25 +0000
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

When slice_height is 0, the division by slice_height in the calculation
of the number of slices will cause a division by zero driver crash. This
leaves the kernel in a state that requires a reboot. This patch adds a
check to avoid the division by zero.

The stack trace below is for the 6.8.4 Kernel. I reproduced the issue on
a Z16 Gen 2 Lenovo Thinkpad with a Apple Studio Display monitor
connected via Thunderbolt. The amdgpu driver crashed with this exception
when I rebooted the system with the monitor connected.

kernel: ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447)
kernel: ? do_trap (arch/x86/kernel/traps.c:113 arch/x86/kernel/traps.c:154)
kernel: ? setup_dsc_config (drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dc_dsc.c:1053) amdgpu
kernel: ? do_error_trap (./arch/x86/include/asm/traps.h:58 arch/x86/kernel/traps.c:175)
kernel: ? setup_dsc_config (drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dc_dsc.c:1053) amdgpu
kernel: ? exc_divide_error (arch/x86/kernel/traps.c:194 (discriminator 2))
kernel: ? setup_dsc_config (drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dc_dsc.c:1053) amdgpu
kernel: ? asm_exc_divide_error (./arch/x86/include/asm/idtentry.h:548)
kernel: ? setup_dsc_config (drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dc_dsc.c:1053) amdgpu
kernel: dc_dsc_compute_config (drivers/gpu/drm/amd/amdgpu/../display/dc/dsc/dc_dsc.c:1109) amdgpu

After applying this patch, the driver no longer crashes when the monitor
is connected and the system is rebooted. I believe this is the same
issue reported for 3113.

Signed-off-by: Jose Fernandez <josef@netflix.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3113
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index ac41f9c0a283..597d5425d6cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -1055,7 +1055,12 @@ static bool setup_dsc_config(
 	if (!is_dsc_possible)
 		goto done;
 
-	dsc_cfg->num_slices_v = pic_height/slice_height;
+	if (slice_height > 0)
+		dsc_cfg->num_slices_v = pic_height/slice_height;
+	else {
+		is_dsc_possible = false;
+		goto done;
+	}
 
 	if (target_bandwidth_kbps > 0) {
 		is_dsc_possible = decide_dsc_target_bpp_x16(
-- 
2.44.0

