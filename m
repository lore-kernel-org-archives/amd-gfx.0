Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE95C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 23:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5018C10E196;
	Mon, 10 Feb 2025 23:03:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4CBHSm4";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42FCE10E1F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 18:15:25 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-ab7d601bda0so75384666b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 10:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739211324; x=1739816124; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qJV1rgacZpDBBz9dWk61btrLIQ0FzziI9339+dVw5oE=;
 b=D4CBHSm4PriPXKF2O0UhdzZ5nWrAlRdq+HNXfz5tQRJBKdr8UYSwU/adDtvxe3yDTL
 4R7wKHHZTavqEcZyKsK6Lxdiynn2SY4TIEaEHgJE1UbXN7O10d5zvcX2iSKp4Q12PKCO
 dLK4oiVNTU3rBFw1CDOL0+iNtx2ax+gWlxTVew7TfvwwoAtPzQjO+LrCPVOmJpzxd5c+
 QriSXWHXqVtDYvqPCMsSHZifVGJsmZ2VBv3LDFz1tjGBF2xB9oZwJStDmVVx22CJM8p1
 ki4zcYTWCuFtMYeGyQsvxhALBbLmNjqvVUWV7st+NkD6P3xJogsmgIHh2PNbzR/wizK6
 m9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739211324; x=1739816124;
 h=content-transfer-encoding:mime-version:message-id:subject:cc:to
 :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qJV1rgacZpDBBz9dWk61btrLIQ0FzziI9339+dVw5oE=;
 b=DfvX9Ze3TYS/3BFj7SDJ1QYTuRlgJo999wzbMI37HulnB9IHHjGUiykN7c6Vm3FhCK
 5QHaNRB+8JAXHrcwXqRczmN3GKpMAXaPwWxwpoLUJnt0qwY0i0w4aNX5n5CukQFX+H/R
 I+Ge+bB0F0SsIcl0nIHnXPay/maRZbHfWf1zN18oU3lXEb+N0jCbzScV1UBm2BTcWUvw
 2m5yhYryTgHPu5Yyru1t97bfXgM0t5ECjO9TWi1qnf05rP2LputHErzbDnEVDujBAX4U
 eIhmbYyaz97pt2f4rVtMuUdyQVqLoHDYtveXAhiA6UVOP7me7EafddF7JBxxHwz9MdCI
 pd7w==
X-Gm-Message-State: AOJu0YyVulWlIMPW77ChZPV5KgUExfowXUv/ET8/jPObD3lMP2zo9FpO
 +uPOLGHOCfDKnzE+6hWfPWViXvyHcGZ/0hNXFryQ0UqXpEygvTgEPBukcvyL
X-Gm-Gg: ASbGncvpzSybOUBKafQShnFpfD3NpQ2jVk2xZwTFJ22V/PSK8X1a/TFF1Qi7/lOXinU
 ZkuH1ebbKqKrf4RzlXclSqMBzDVcBff4JIE4BkyYfXgm+elUYCN3J485WM81QYda7KDTQsvvqxA
 n6iw8rq3NW9Wy5OnbTby/Pmdm7wR7XqFyPFi1ulo0gS84xPZ/xiLwiCdLlELlkNdq/XBoMgEI/T
 BZQnlsXrc2F4v51/ALEwINuWBMnHHE4SxF8mfkLS4syfjUNWlJCmQvssr6kfaJNKtVw4qw+TBYt
 MlCVlaTvhxIsOiaaP4gNDkqLsOterkkz
X-Google-Smtp-Source: AGHT+IEH9VPL3jeCxUwyp282Q8Fb/cN5oEN0K/DdSnhXtJ6KA9hqwh+vV5t9Bz5K6FuA9iHoVtUq5Q==
X-Received: by 2002:a17:907:c281:b0:ab7:bc17:b3a4 with SMTP id
 a640c23a62f3a-ab7bc17b58bmr443229266b.34.1739211323290; 
 Mon, 10 Feb 2025 10:15:23 -0800 (PST)
Received: from foxbook (adtq181.neoplus.adsl.tpnet.pl. [79.185.228.181])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7d1df3161sm101465966b.108.2025.02.10.10.15.22
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Mon, 10 Feb 2025 10:15:23 -0800 (PST)
Date: Mon, 10 Feb 2025 19:15:18 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: regressions@lists.linux.dev, Kenneth Feng <kenneth.feng@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [REGRESSION 6.14][BISECTED] AMD Carrizo shutdown hang since amdgpu
 commit ff69bba05f08
Message-ID: <20250210191518.351576aa@foxbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 10 Feb 2025 23:03:45 +0000
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

Hi,

I have a machine with this APU:
AMD PRO A10-8770 R7, 10 COMPUTE CORES 4C+6G

6.13 was OK, with 6.14-rc2 it hangs on shutdown after the display
turns off.

git-bisect says:
# first bad commit: [ff69bba05f085cd6d4277c27ac7600160167b384] drm/amd/pm: add inst to dpm_set_powergating_by_smu

The preceding commit does indeed shutdown normally.
AMDGPU is built into the kernel image, not sure if it matters.

Final lines of dynamic debug over serial pasted below. Any ideas?

Thanks,
Michal

[   79.232113] [SURFACE]:Pipe 0: width, height, x, y
[   79.232113] viewport:1600, 1200, 0, 0
[   79.232113] recout:  1600, 1200, 0, 0
[   79.251418] amdgpu: [IPS]: dc_allow_idle_optimizations_internal: allow_idle old=0 new=1 (caller=amdgpu_dm_crtc_vblank_control_worker)
[   79.253727] [SCALER]:resource_build_scaling_params pipe 0:
[   79.253727] Viewport: height:1200 width:1600 x:0 y:0  Recout: height:1200 width:1600 x:0 y:0  HACTIVE:1600 VACTIVE:1200
[   79.253727] src_rect: height:1200 width:1600 x:0 y:0  dst_rect: height:1200 width:1600 x:0 y:0  clip_rect: height:1200 width:1600 x:0 y:0
[   79.303043] [SCALER]:resource_build_scaling_params pipe 0:
[   79.303043] Viewport: height:1200 width:1600 x:0 y:0  Recout: height:1200 width:1600 x:0 y:0  HACTIVE:1600 VACTIVE:1200
[   79.303043] src_rect: height:1200 width:1600 x:0 y:0  dst_rect: height:1200 width:1600 x:0 y:0  clip_rect: height:1200 width:1600 x:0 y:0
[   79.339233] [BANDWIDTH_CALCS]:dce110_validate_bandwidth: start
[   79.339691] [SCALER]:resource_build_scaling_params pipe 0:
[   79.339691] Viewport: height:1200 width:1600 x:0 y:0  Recout: height:1200 width:1600 x:0 y:0  HACTIVE:1600 VACTIVE:1200
[   79.339691] src_rect: height:1200 width:1600 x:0 y:0  dst_rect: height:1200 width:1600 x:0 y:0  clip_rect: height:1200 width:1600 x:0 y:0
[   79.384264] [BANDWIDTH_CALCS]:dce110_validate_bandwidth: start
[   79.384601] [SURFACE]:Pipe:0 ffff888104900000: addr hi:0xff, addr low:0xed3000, src: 0, 0, 1600, 1200; dst: 0, 0, 1600, 1200;clip: 0, 0, 1600, 1200
[   79.408652] [SURFACE]:Pipe 0: width, height, x, y
[   79.408652] viewport:1600, 1200, 0, 0
[   79.408652] recout:  1600, 1200, 0, 0
[   79.428580] [BANDWIDTH_CALCS]:dce110_validate_bandwidth: start
[   79.428597] [BANDWIDTH_CALCS]:dce110_validate_bandwidth: finish,
[   79.428597] nbpMark_b: 0 nbpMark_a: 31870 urgentMark_b: 0 urgentMark_a: 16615
[   79.428597] stutMark_b: 0 stutMark_a: 27915
[   79.428597] nbpMark_b: 0 nbpMark_a: 0 urgentMark_b: 0 urgentMark_a: 0
[   79.428597] stutMark_b: 0 stutMark_a: 0
[   79.428597] nbpMark_b: 0 nbpMark_a: 0 urgentMark_b: 0 urgentMark_a: 0
[   79.428597] stutMark_b: 0 stutMark_a: 0 stutter_mode_enable: 1
[   79.428597] cstate: 1 pstate: 1 nbpstate: 1 sync: 0 dispclk: 0
[   79.428597] sclk: 0 sclk_sleep: 12225 yclk: 2668000 blackout_recovery_time_us: 0
[   79.429071] amdgpu: [IPS]: dc_allow_idle_optimizations_internal: allow_idle old=0 new=1 (caller=amdgpu_dm_crtc_vblank_control_worker)
[   79.527445] [BANDWIDTH_CALCS]:dce110_validate_bandwidth: start
[   79.527463] [BANDWIDTH_CALCS]:dce110_validate_bandwidth: finish,
[   79.527463] nbpMark_b: 0 nbpMark_a: 31870 urgentMark_b: 0 urgentMark_a: 16615
[   79.527463] stutMark_b: 0 stutMark_a: 27915
[   79.527463] nbpMark_b: 0 nbpMark_a: 0 urgentMark_b: 0 urgentMark_a: 0
[   79.527463] stutMark_b: 0 stutMark_a: 0
[   79.527463] nbpMark_b: 0 nbpMark_a: 0 urgentMark_b: 0 urgentMark_a: 0
[   79.527463] stutMark_b: 0 stutMark_a: 0 stutter_mode_enable: 1
[   79.527463] cstate: 1 pstate: 1 nbpstate: 1 sync: 0 dispclk: 0
[   79.527463] sclk: 0 sclk_sleep: 12225 yclk: 2668000 blackout_recovery_time_us: 0
[   79.609435] amdgpu: Setting Deep Sleep Clock: 1222
[   79.616505] amdgpu: enable Low Memory PState.
[   79.708792] amdgpu: Setting Deep Sleep Clock: 1222
[   79.715842] amdgpu: enable Low Memory PState.
[   79.722763] amdgpu 0000:00:01.0: amdgpu: IP block9 already in the target gate state!
