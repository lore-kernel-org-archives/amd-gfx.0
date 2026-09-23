Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7892CC982EA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 07:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859CC10E825;
	Wed, 23 Sep 2026 07:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cr6x2FcC";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F0210E51E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 00:27:33 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e83a388f8so1815375e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 17:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790123251; x=1790728051; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Iu6ChcoYkeqQpso1SWT5boNmU53jolwND8JJxt/RDZI=;
 b=Cr6x2FcChIFQBgXTfUoQ5dn79vzYAEoLlAPUZ6vwHjj0jywJs62bIOLiyo24u1lZS3
 kAr0DI9IeYI+5lUs8G8d1rmEHA7wvs1vu8G61Z9g0XIEE82/Bqsz4iC2tw29HTwrkMIS
 gUoweexHKmV4Zp6nm0yKs3EvqQ0fCiQ6w55ngf2Qa6UqZPFoMtNYQxBWSFvpmJhB/rEK
 vN8n/EdInvxvN7m22dsDbnJ0T4NYJ1rstxBiavJD2n0AIRfZhd2lFnRUTGhS54CaSvRU
 tWBqPJjr+LVNiBA1vXmaWCZ+blPRtey3A6ClyygCDs0GwD9W/i1v62fSpqMOdHXRbJLs
 cXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790123251; x=1790728051;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Iu6ChcoYkeqQpso1SWT5boNmU53jolwND8JJxt/RDZI=;
 b=XGVRLJ/opgKCGFQ8stKWPna9EKDRqZZiXmlypt83hlhiq07Mu4rs3OPQzHQSK2nof2
 u8k0e+sm6R0tMp5vIE2QXtB8aICgYfDTN6IOdy2c+lYrD3Wjsroq+sB2AhF+iXiXA/oY
 xGU6g78BLoaRmtjW7+VDpYIXjI2m2eSs88NcKssq6d1ExQ9Zxh6HnY5xGcED7Jy841qo
 0hjK3CntNFjymt+CB2l8ytMaAvsJhz9x/G2lbxP2sQU9TZBxKfjL0sXF2dujMJwsgk+f
 2DQLMyAXitfsysK/0mkx/UO+DMgKSarPAV4lS0ybGZ3k7UruyRC3/xW8mViCzkxE3eZK
 W9sw==
X-Gm-Message-State: AFuF++lXeCP02z6Gan9sMZidCG2GL/x1V/EROAZBhobt1ng8ZOwEH91z
 1EYUshN6kE+fD2esypeerJNG134CRp7V38s4FfcOO7XeSvADWircvm4Uivoi7e6C
X-Gm-Gg: AYBFou38TG//OJG6cvsw3EGH3BSRe4XNGfTJSpkH/3tnd6GXTd0tIlZfrM8w/uz2KPx
 MsVLYEyFIAbCrVF+k+w0gt0Y2t7ki/0aT1lNV7Q4K8MCUBxgFvM53DFl0qpnObyNvjLFSq9meni
 dUAnTZLPr3c3so0qy2IYRZRIe3LtQ8fE6BRiJrG91VOpfCtKVIoT7gsV99+4wpagQ+X9TV3otNO
 iNPtHc0j+deeBvd20G+8WX5j5zR1l3lm0cKg5K6X3RstTp39MovJrJGYUNAfBFbsejejRRIHwy5
 IWYUia1zrlIqDdnvKnBpFUicvQ9W0H93dMJpz9xGYYsxdOmbPNLR4Wth8ZYthqgvC6o884nZeXw
 b021Yud14ypJ+Il1IPML1LdZrVfeF2vbcD8uLyL5kqk0u1CO0s9Mj9WOHU/CNqlAVhFo5T9DNdm
 9sLNXOYFcH4fAcsxzBUnIUBcqMwtwfZudeyNdGsNG4Ukl0FotSbryRk9cXePVstZjVzGDO4MA=
X-Received: by 2002:a05:600c:19d2:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-49fdf1370bcmr9734545e9.16.1790123251286; 
 Tue, 22 Sep 2026 17:27:31 -0700 (PDT)
Received: from NBLK-WAX9X ([78.175.157.66]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48868889337sm2229702f8f.34.2026.09.22.17.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 17:27:30 -0700 (PDT)
From: =?UTF-8?q?Ata=20=C4=B0lhan=20K=C3=B6kt=C3=BCrk?= <atailhan2006@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [DRM] amdgpu: HDMI FreeSync not exposed on Samsung S22C31x despite
 AMD VSDB
Date: Wed, 23 Sep 2026 03:27:18 +0300
Message-ID: <20260923002718.5915-1-atailhan2006@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 23 Sep 2026 07:55:58 +0000
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

I am investigating an issue where HDMI FreeSync
is not exposed for a Samsung S22C31x monitor on
an AMD Picasso/Raven 2 GPU, although the monitor
advertises an AMD FreeSync range in its EDID and
VRR works under Windows.

Hardware/software:

* GPU: 03:00.0 VGA compatible controller [0300]:
Advanced Micro Devices, Inc. [AMD/ATI] Picasso/Raven 2
[Radeon Vega Series / Radeon Vega Mobile Series]
[1002:15d8] (rev c2)
* Kernel: 7.2.5-200.fc44
* Compositor: Sway (Wayland)
* Monitor: Samsung S22C31x
* Connector: HDMI-A-1
* EDID serial: H9DX100210
* Kernel command line includes: amdgpu.freesync_video=1

Observed:

* swaymsg -t get_outputs reports "Adaptive sync: disabled" for HDMI-A-1.
* Adaptive sync remains disabled at both 1920x1080@60 Hz and 1920x1080@75 Hz.
* The same monitor exposes and enables FreeSync under Windows.

The EDID contains the following AMD Vendor-Specific Data Block:

Vendor-Specific Data Block (AMD), OUI 00-00-1A:
    Version: 1
    Feature Caps: 0x01
    Minimum Refresh Rate: 48 Hz
    Maximum Refresh Rate: 75 Hz
    Flags 1.x: 0x00

The HDMI VSDB therefore appears to advertise a 48-75 Hz FreeSync range.

There is also this message in dmesg:

amdgpu 0000:03:00.0: [drm] Failed to setup vendor infoframe on connector HDMI-A-1: -22

I believe this is the -EINVAL path from
drm_hdmi_vendor_infoframe_from_display_mode() for this timing and
is probably unrelated to the FreeSync issue.

The part I am currently investigating is amdgpu_dm_update_freesync_caps().

For HDMI, the driver calls parse_hdmi_amd_vsdb(), which
on this DCN configuration goes through the DMUB path:

parse_hdmi_amd_vsdb()
  -> parse_edid_cea()
     -> parse_edid_cea_dmub()
        -> dm_edid_parser_send_cea()
           -> output->amd_vsdb.freesync_supported

If the DMUB parser returns freesync_supported == 0,
the driver does not expose the connector as VRR capable.

What makes this interesting is that the DRM EDID parser also
contains the corresponding AMD VSDB information in
connector->display_info.amd_vsdb, while the DMUB result
does not result in FreeSync being exposed.

I am wondering about the following:

1. Is the AMD VSDB layout above expected to be accepted by
the DMUB EDID parser, particularly with
Feature Caps 0x01, Flags 1.x == 0x00, and no MCCS VCP code byte?

2. If the DMUB parser rejects this form of AMD VSDB, should amdgpu_dm
fall back to the software-parsed connector->display_info.amd_vsdb
when determining FreeSync capability?

I have a working kernel tree and can run diagnostic tests
or test a small patch. I can also provide drm.debug
output or DMUB-related traces if useful.

Thanks,
Ata İlhan Köktürk
