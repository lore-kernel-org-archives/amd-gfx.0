Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B17CD129A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Apr 2024 07:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC1CF113204;
	Wed, 10 Apr 2024 07:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=netflix.com header.i=@netflix.com header.b="lLKaljID";
	dkim-atps=neutral
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com
 [209.85.166.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF9010E384
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Apr 2024 04:34:46 +0000 (UTC)
Received: by mail-il1-f181.google.com with SMTP id
 e9e14a558f8ab-36a38c13550so3731395ab.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Apr 2024 21:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netflix.com; s=google; t=1712723685; x=1713328485; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a/JPFUxV2ArWkhwNnn1v7zuWOs9XoBJjsryMcg9Mcoo=;
 b=lLKaljIDk9OkiyVqqIs2eKQk6F1VyxX8qixJiln01CrrjMAzun1SL1tDBnmcEsactF
 /BIXZzme7douP7BtXndvjyucb4R21nXwjdzyGZahxLZtHyBBZQdehShkpggiWimIGKOg
 vpJHVwGiVj05CTuJ7N5XGGqhyN3vgEFmDHvbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712723685; x=1713328485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a/JPFUxV2ArWkhwNnn1v7zuWOs9XoBJjsryMcg9Mcoo=;
 b=bUb1mu/Cjo3xWh7iLf7Mb6RoT2HDAIhd1NymIE+lUdy3DcAywFzirUZ+imkJFayEDd
 MzeTqIO2Ccm/WpugrrmYh6suKNT39IB9YTcOLQkg66o/r+TMc/mbOgHjIP9F0U94vtMu
 vPTLgfejCqS3MM2Ib+GTYjVpiCNwuKIhB6/EX542MA2cicwMHGAgQjEpognWMfjtK5FV
 J1a8Ku7Wh/X427z12NXt40RYS5xUyFVKpcXu2cw2Qyi8oywlkFdRS77tL2J6oX+TKSRB
 KEBVAaUpT+GDwsrEe5SONbR0Ii6JUiiWvs76XaksfoMk7cFEOLqYr3BpF9aEAkvwuE7W
 jGeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0xWeVcxFh3B9VB6BSQ67DJROB2BWMDBDfIU17NSeLaf10LQoBzarvvuW+02HhhCDYESmqIHYiOhkBIWd3hhTtxrYKsj2JQpy3K3EIaQ==
X-Gm-Message-State: AOJu0YzplJ/HoV26JFSF6W79+reggBDDyEhb1+p8RGXssC40G1dmi7zd
 Yw/6NCdkudPXWWumw7toI/4gR0SFG+YopXa3uF6OwFEXXhXEJOI9/fV2otjLMXI=
X-Google-Smtp-Source: AGHT+IFILeN96Xd9wtsGDWKumJLAOJAbRVY+isMe2Tofq8xMm3T+C68RphVpIWdR/vNbrvujRnChCQ==
X-Received: by 2002:a05:6e02:1607:b0:369:ed5b:dd56 with SMTP id
 t7-20020a056e02160700b00369ed5bdd56mr2350659ilu.17.1712723685172; 
 Tue, 09 Apr 2024 21:34:45 -0700 (PDT)
Received: from localhost ([2601:285:8700:8f20:fa81:e682:614d:196f])
 by smtp.gmail.com with UTF8SMTPSA id
 hb2-20020a0566386c0200b0048290482c7bsm2023528jab.54.2024.04.09.21.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Apr 2024 21:34:44 -0700 (PDT)
From: Jose Fernandez <josef@netflix.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Wenjing Liu <wenjing.liu@amd.com>,
 Alan Liu <haoping.liu@amd.com>, George Shen <george.shen@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Ilya Bakoulin <ilya.bakoulin@amd.com>, Nasir Osman <nasir.osman@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Leo Ma <hanghong.ma@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Jose Fernandez <josef@netflix.com>
Subject: [PATCH] drm/amd/display: Fix division by zero in setup_dsc_config
Date: Tue,  9 Apr 2024 22:34:33 -0600
Message-Id: <20240410043433.12854-1-josef@netflix.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 10 Apr 2024 07:12:47 +0000
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

