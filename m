Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283B3CCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 07:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE89D10E3E6;
	Mon, 13 Oct 2025 07:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kXPFHSPE";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2918310E2ED
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 13:48:03 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-63994113841so5249914a12.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Oct 2025 06:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760190481; x=1760795281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O170WPdulyrU1Gecp4KBZecpJyTKM3vtAtwxUA+waHs=;
 b=kXPFHSPELsJgscQnpSrp4cFL95PbFidn7A9iztQpfblHb4YuUhJA15JA+SHxJf8EIi
 a/w3SHkQis5EQ42m1bHRMq3779wQXKb56+GI4yosANF76KG7vVkmbcmmiA+QgbD+qmzy
 mnDV5LJfPS6L2gr25xlbodcvdqyb2rMgI0Kkbq/WQSTKazmRHeJXxcB7Aqv36bfwFCC1
 JxEJCdDt5X8G3DdWTEaHM6F4PbxteHnP49EfmkUzrWm9Jgmr9qXy2nFPr0DaG02YxfZl
 /ki65dH8phddDPb41RMuIqt6GKb1Qh1p0zDdd9pr3OPkJcK2JYJkFfSKnuzvJwZvh8ie
 V0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760190481; x=1760795281;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O170WPdulyrU1Gecp4KBZecpJyTKM3vtAtwxUA+waHs=;
 b=GqY3oZDwtvK4eVvwHkE4yAXnhNDPc1Lbcxtnh1AgqxH/enrMHY5NPRFzDOx2JD+6G2
 InYbtDEDrdE8Y2TrgkQScbW6JjnY3OIKDW7eia+muFC5CcVEkKMP2xPQsFh1SVWut595
 HesfGwSVB/h4kdq+kthycFpNRk1G8pDLuie4sfxPtzVLLvAPjaczZ0qSfHIRbuatemr4
 j3ww/0wfdFF25YpltbVhqk0cXLH6GUxZ06/ODiJoAVmOowctg2vdtrBmxT1XJzaFeSKQ
 ZoQlV7apwB01PtcubpIuZauXH1ZXrF1FUEpVYmWXGb5WNysp+oY3JvCpgQhD4zz0uGxE
 tLtQ==
X-Gm-Message-State: AOJu0Yy1AY3+bhbQ9PH65xBk1J8KrEIssf76DihPIXa0K96m32NIFWMC
 XxXql8Uk/PgLZbxyHMzhraVC98AhagOXecKc/Y848bQcL8xRTRzDV4n2cRq03w==
X-Gm-Gg: ASbGncsmdMcjm/YpmcXQ/md6ME4Ms90UxTCCHrNZSaKM+27iOTMqpLf5TDHanM4vdKZ
 S9eyPfe4ryurJhhIwv4/eRIDfnnNCM6JJBhso4ZiVB+nfkGD7for4+7S44fcGsNjIIMhOVmlivP
 EXPLkzjPIV5O8rSYyED79d63+uyuBmFbDEBkqgkqzyjitTDb9Uscn56D8lAIlwXSrwN6dbQ5yGx
 0iT6f+t0rYF9WS2lieLURfZkcjrl+fiHPCVRdfXLA2I7n4PYt+X+jkJkyeTYM8qmDR4iOXknD7U
 9ARJNMktEZiMiZgafwnHt7+d2+FfDPdVOntsCL/mI6LBpR+tERIE4qqMmsP3faTZHLcp4Tk12V3
 Xs/8qXeXp0q0PfpfP0cdHwoMM16sx1BisDJdKrVu1t429SCzsjPh+FU0aPZtIJjrmdF/C1pK49W
 cpMNsHdo9/
X-Google-Smtp-Source: AGHT+IEQsF2Ypz3aZgq7vr9l1MjmT7HUR2XeUPXWtppftAPb5DJGKpoMtRfa1ePlENcCgPNAAe9GUQ==
X-Received: by 2002:a05:6402:5216:b0:632:1faa:3a38 with SMTP id
 4fb4d7f45d1cf-639d5c4dc4emr13476747a12.29.1760190481318; 
 Sat, 11 Oct 2025 06:48:01 -0700 (PDT)
Received: from hyron-desktop (host-176-36-64-50.b024.la.net.ua. [176.36.64.50])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a52b0f358sm4788016a12.10.2025.10.11.06.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 06:48:00 -0700 (PDT)
From: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>
Subject: [PATCH 0/2] drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage`
Date: Sat, 11 Oct 2025 16:47:14 +0300
Message-ID: <20251011134716.83214-1-ilya.zlobintsev@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Oct 2025 07:35:45 +0000
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

Previously, reading from the `pp_od_clk_voltage` sysfs file would
include lots of null bytes between the sections, e.g.:

$ cat -v /sys/class/drm/card0/device/pp_od_clk_voltage
OD_SCLK:
0: 500Mhz
1: 2514Mhz
OD_MCLK:
0: 97Mhz
1: 1000MHz
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@OD_VDDGFX_OFFSET:
0mV
^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@OD_RANGE:
SCLK:     500Mhz       3000Mhz
MCLK:     674Mhz       1075Mhz

The reason for this is that calling `smu_cmn_get_sysfs_buf` aligns the
offset used for `sysfs_emit_at` to the current page boundary, and then
gets returned from the various `print_clk_levels` implementations to be
directly added to the buffer position. Instead, only the relative offset
showing how much was written to the buffer should be returned,
regardless of how it was changed for alignment purposes.

Now, the file is clean without any garbage data:

$ cat -v /sys/class/drm/card0/device/pp_od_clk_voltage
OD_SCLK:
0: 500Mhz
1: 2519Mhz
OD_MCLK:
0: 97Mhz
1: 1000MHz
OD_VDDGFX_OFFSET:
0mV
OD_RANGE:
SCLK:     500Mhz       3000Mhz
MCLK:     674Mhz       1075Mhz

I have changed this for SMU11, SMU13 and SMU14 as there have been user
reports of this issue on all three, and the code is the same between them.
However, I only have access to a 6900XT (SMU11), so the newer ones are
untested. I've split the change into separate patches for
SMU11 (tested) and SMU13/14 (untested), in case you believe that this
change is risky and could break something.

Sidenote: This is also my first time submitting patches to a mailing list, so
please tell me if there are any issues with the patch or email
formatting.

Signed-off-by: Ilya Zlobintsev <ilya.zlobintsev@gmail.com>

Ilya Zlobintsev (2):
  drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage` (SMU11)
  drm/amd/pm: Avoid writing nulls into `pp_od_clk_voltage` (SMU13/SMU14)

 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c    | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c    | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c    | 5 +++--
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    | 5 +++--
 8 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.51.0

