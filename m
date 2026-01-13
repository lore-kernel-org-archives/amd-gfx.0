Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47021D31A2A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 08:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48D3310E5DB;
	Wed, 14 Jan 2026 08:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EKZt5Des";
	dkim-atps=neutral
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34A910E381
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 21:41:08 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id
 4fb4d7f45d1cf-64b7d213fd6so1122157a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768340467; x=1768945267; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DhpWWz12kb7UClBCF/HJbq7vlz6MpTKNGbMO3aq4gGE=;
 b=EKZt5DesCtfz6Ie4vC5IIneb+h/3X9MQIk7GvfexJqQJqhf6ZMhNEQzdRdPXiXUWip
 lE8Q4NulxSNIsFEmJ7xF8dLsmv7Njbc1llhA2PwQ4zZKMq5BE+XhAb5GIittIRF9qW+f
 uJ8dWFJvbnhbsYXU/QSSNx1IOypcLX+wdHYkwHcWRSnmZRIWE/X4PMPqs8vYYka8m/yF
 YHwks5zBIVDB0gGT32ZdeRvmfe5iJstTaPlxLYTH74RZjKGTVYz29ODSe0HnKj6C+Z7w
 l3wyaJWspA+FMk8Ra0+iV7J41HuHofvsa2mP6k/12M1/IEcSyHpYRn6GIwGT2KNJ9tsh
 KV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768340467; x=1768945267;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DhpWWz12kb7UClBCF/HJbq7vlz6MpTKNGbMO3aq4gGE=;
 b=AqN0xcQvzwMD/2FTeD9AZSxUrUlj5yxopdsvIKkI+xJV6KSma61IoPpuW6Ftc+8U/a
 TsipwanQxOMUPpvNWJbBWQKQ+ZFryA0xEQbTznzspxbZBw8hb2nFzGZzlpNY/jDIoz3x
 cDn/Q7ozg5gieVQSzNJrcIIZgkoKp1NcaFcsT7pI4Fym4yeuGdkCIghZVv1zByJPrFXY
 AK+FIyjHH7tuPdKu01dGuALJEWWpaPyqR6XG2nvFKNf1h8TsdKoWgVV3r5Ika3atta/k
 E6SijTH5X8x+Jf9e5oOmKGoCxl3u5ZNbEZtcw8MmMTvKFATOzY3XnLjjVOyS42UPoZHY
 xdlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8OakaC0J1PYh0OdDLD8wWMHAucXDcVEu3BDnwvECiyI8AGbYha2fYir116cS8zOVlIkcJbeCB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwriHLEaP578Xvm+8046mmbwKzmPQrR28FENaF1Q7jlbvIhoO1Y
 0yYx3pLIZ/4M1hylkKUnTX+l73VoqGL+UmBRWcceZIP8lPVgGQA0I6u6
X-Gm-Gg: AY/fxX5yFby17fphvNs2/Pf5Et29B9BBqTeNb/Q+jTYZs19XXmuSXTZySLC7YDEDG0z
 U+un082o3FAQNxiGLUfGcLuG/Wa3SxtZh7JsiJsEzt7djBVIVSqbpdlBAPyUduKQTHafSiiEoR5
 0v35xkMlcaVISwfuzYIz6sdVTjs8FFrSRqngfIOOuuPTIIZU1iWDNdOIeZj34MraqokbNOyMILH
 B6htV/q9PdEFw7oBW6z/3RNRQ4FHWGcK3Bflzucd83wQ6dJj9EaShgBp1GbExZPn+i2iGMB/Y8+
 x6ycNugX53ZykNFdOl/K0vgZ0essHcxdt0VjsfPVHiFJjUHpru4v/mhlNtI9nu8KZGEw0Wm0UvG
 c/jcjp1is1/GPhdY+kt87J0SBTStLSTFFuI6NJKje/YXsFDrYpD8BLDtlNZUp/QX7wimJvjLAgz
 KFOTojhHd5yLtB4hJsJR4WlWPA2DbUHEgLgHbYRunfAQoNYflAkEVHIkCLN0uaLVr0
X-Received: by 2002:a05:6402:40ca:b0:64d:521e:161a with SMTP id
 4fb4d7f45d1cf-653ec466877mr183722a12.5.1768340466966; 
 Tue, 13 Jan 2026 13:41:06 -0800 (PST)
Received: from laptok.lan (87-205-5-123.static.ip.netia.com.pl. [87.205.5.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d5e0sm20858052a12.31.2026.01.13.13.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 13:41:06 -0800 (PST)
From: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
To: alexander.deucher@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] amdgpu: Enable Adaptive Sync over PCON with HDMI VRR
Date: Tue, 13 Jan 2026 22:41:01 +0100
Message-ID: <20260113214104.146856-1-tomasz.pakula.oficjalny@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Jan 2026 08:29:27 +0000
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

Adaptive Sync over PCON is only available as FreeSync over HDMI. TVs which do
not support FreeSync, do not have working VRR with DP -> HDMI 2.1 adapters even
though adapters will take care of HDMI VRR info packets.

Since HDMI VRR relies on FRL modes, this will only be enabled for PCONs in the
VRR whitelist. HDMI VRR for native HDMI connector will still not be
possible/attempted.

I myself validated these changes with my Samsung S95B + Bernhard validated on
LG C4 + FreeSync-less Sony Bravia 8. I used Alienware AW3423DWF that only
has HDMI 2.0 to check that FreeSync still triggers properly for "older" hardware

For missing VRRmax or VRRmax == 0, the upper boundary is the currently selected
video mode refresh rate. I wasn't sure how best to implement it but 10000
works since the driver already limits VRR range to the currently selected
video mode and 10000 Hz should be good enough for years to come.

Changes in v2:
- More info parsed from HDMI Forum vsdb
- EDID parsing squashed into one commit
- Support for VRRmax == 0

Tomasz Pakuła (3):
  drm/edid: parse more info from HDMI Forum vsdb
  drm/amd/display: rename PCON adaptive sync types
  drm/amd/display: enable HDMI VRR over PCON

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 +++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +-
 .../amd/display/modules/inc/mod_info_packet.h |  4 +-
 .../display/modules/info_packet/info_packet.c |  4 +-
 drivers/gpu/drm/drm_edid.c                    | 41 +++++++++++++++-
 include/drm/drm_connector.h                   | 47 +++++++++++++++++++
 6 files changed, 114 insertions(+), 11 deletions(-)

-- 
2.52.0

