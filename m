Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE63DC6379F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Feb 2023 08:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D41F810EC7E;
	Fri, 10 Feb 2023 08:04:09 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100E610EC55
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Feb 2023 04:50:00 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id 16so2747412pfo.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Feb 2023 20:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fmf+C+18uqHbrtjkcU8WtNHqdNX45uutvQ0nNnjGiio=;
 b=XbfKMKaiygftk+3FCoymQo0fjqqta8on7sN0Tah7vrlnRm06+fFEvNRRQkpxFgCYwk
 aN+aNZv4f8RmuYDwfAtZg4d5wCmLNGDYrulxaErNYDhjqqLH9ENZBQsHO64XNdBmVUca
 cG+4wwUPHIKnkLVQNVYyKX9BbTvA+VfTM3u2fh3UJAmhwFfQAWz+5qHkXOwdUfXU2d5D
 4ttDFUw+l+tQczr0v5GaMxLcqn+qbyUnx3AOexAQ21SeCVzuZQy2cPblGNgPFGr+Ll0V
 gv9aUSgaje+b9bxNqFb9rTehY/PwX9tnnQVvWUZNKJth4bqSm0POQGhuLB+hwe+F1Qgb
 mxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmf+C+18uqHbrtjkcU8WtNHqdNX45uutvQ0nNnjGiio=;
 b=ptK48C6ZaohTk8aXTsdxqeVYTVlaFBVUH/gjg5wC+olXQCyjstNYE9dL55BewcMq96
 WczybUl2jCTZuYDRn6nC64EaTTst/f9PnEqgJu7LZxUsznvpUKUrF2QX+TbBhlQ6vPZ9
 svjZW6ZINHVbiLrntBys5UFVHS4yFE6cw8m5BRq8/w43lowJLBX1cxK8C+akQx2MxPKd
 FU/g8p4kSrYHjmwb5G3zmLHoBvuOHuD7cWitfhmm4oACwbqGBNWY8bgMCePaF5NaWf91
 lmDqPRxAY/9oSo7xjqfgM/TV7U5IX4SGZEigZ9o6UvmgHMsjOY0ny6nswTzPx9Ry5C4p
 sdKA==
X-Gm-Message-State: AO0yUKX4N/5wsmCZ2ZuYr07uEOq5ODyeTGvoTGijBCD7Hf6p8cUiV6T2
 lKLvpf7Z+L6/IILOMqf1i8o=
X-Google-Smtp-Source: AK7set84McKVzgWzKB8PF4jKgFcuYCiQmlSa+pybg0QvHszf1ptNzpEuIbQiERcJYVwtm+ogtuqE6Q==
X-Received: by 2002:a62:64d1:0:b0:5a8:6463:8f77 with SMTP id
 y200-20020a6264d1000000b005a864638f77mr2587105pfb.11.1676004599534; 
 Thu, 09 Feb 2023 20:49:59 -0800 (PST)
Received: from localhost.localdomain ([202.53.32.211])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62ea0d000000b0057fec210d33sm2269218pfh.152.2023.02.09.20.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Feb 2023 20:49:59 -0800 (PST)
From: Orlando Chamberlain <orlandoch.dev@gmail.com>
To: platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [RFC PATCH 0/9] apple-gmux: support MMIO gmux type on T2 Macs
Date: Fri, 10 Feb 2023 15:48:17 +1100
Message-Id: <20230210044826.9834-1-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Feb 2023 08:04:04 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Rander Wang <rander.wang@intel.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Evan Quan <evan.quan@amd.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yong Zhi <yong.zhi@intel.com>, Aun-Ali Zaidi <admin@kodeit.net>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Bokun Zhang <Bokun.Zhang@amd.com>,
 Orlando Chamberlain <orlandoch.dev@gmail.com>,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Kerem Karabay <kekrby@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Jack Xiao <Jack.Xiao@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
 Takashi Iwai <tiwai@suse.com>, Aditya Garg <gargaditya08@live.com>,
 Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi All,

This patch series adds support for the MMIO based gmux present on these
Dual GPU Apple T2 Macs: MacBookPro15,1, MacBookPro15,3, MacBookPro16,1,
MacBookPro16,4 (although amdgpu isn't working on MacBookPro16,4 [1]).

It's only been tested by people on T2 Macs with MMIO based gmux's using
t2linux [2] kernels, but some changes may impact older port io and indexed
gmux's so testing, especially on those older Macbooks, would be
appreciated.

# 1-2:

refactor code to make it easier to add the 3rd gmux type.

# 3:

has a slight change in how the switch state is read, I don't
expect this to cause issues for older models (but still, please test if
you have one!)

# 4:

implements a system to support more than 2 gmux types

# 5:

start using the gmux's GMSP acpi method when handling interrupts. This
is needed for the MMIO gmux's, and its present in the acpi tables of some
indexed gmux's I could find so hopefully enabling this for all models
will be fine, but if not it can be only used on MMIO gmux's.

# 6:

Adds support for the MMIO based gmux on T2 macs.

# 7:

Add a sysfs interface to apple-gmux so data from ports can be read
from userspace, and written to if the user enables an unsafe kernel
parameter.

This can be used for more easily researching what unknown ports do,
and switching gpus when vga_switcheroo isn't ready (e.g. when one gpu
is bound to vfio-pci and in use by a Windows VM, I can use this to
switch my internal display between Linux and Windows easily).

# 8-9:

These patches make amdgpu and snd_hda_intel register with vga_switcheroo
on Macbooks. I would like advice from the AMD folks on how they want
this to work, so that both PX and apple-gmux laptops work properly.

For radeon and nouveau we just register for every non-thunderbolt
device, but this was changed for AMD cards in commit 3840c5bcc245
("drm/amdgpu: disentangle runtime pm and vga_switcheroo") and commit
586bc4aab878 ("ALSA: hda/hdmi - fix vgaswitcheroo detection for AMD").

This meant that only gpu's with PX register. Commit #8 makes amdgpu
register for all non-thinderbolt cards, and commit #9 makes snd_hda_intel
register for all amd cards with the PWRD (mentioned below) acpi method.
An alternative would be using apple-gmux-detect(), but that won't work
after apple-gmux has probed and claimed its memory resources.

# Issues:

1. Switching gpus at runtime has the same issue as indexed gmux's: the
inactive gpu can't probe the DDC lines for eDP [3]

2. Powering on the amdgpu with vga_switcheroo doesn't work well. I'm
told on the MacBookPro15,1 it works sometimes, and adding delays helps,
but on my MacBookPro16,1 I haven't been able to get it to work at all:

snd_hda_intel 0000:03:00.1: Disabling via vga_switcheroo
snd_hda_intel 0000:03:00.1: Cannot lock devices!
amdgpu: switched off
amdgpu: switched on
amdgpu 0000:03:00.0:
	Unable to change power state from D3hot to D0, device inaccessible
amdgpu 0000:03:00.0:
	Unable to change power state from D3cold to D0, device inaccessible
[drm] PCIE GART of 512M enabled (table at 0x00000080FEE00000).
[drm] PSP is resuming...
[drm:psp_hw_start [amdgpu]] *ERROR* PSP create ring failed!
[drm:psp_resume [amdgpu]] *ERROR* PSP resume failed
[drm:amdgpu_device_fw_loading [amdgpu]]
	*ERROR* resume of IP block <psp> failed -62
amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-62).
snd_hda_intel 0000:03:00.1: Enabling via vga_switcheroo
snd_hda_intel 0000:03:00.1:
	Unable to change power state from D3cold to D0, device inaccessible
snd_hda_intel 0000:03:00.1: CORB reset timeout#2, CORBRP = 65535
snd_hda_codec_hdmi hdaudioC0D0: Unable to sync register 0x2f0d00. -5

There are some acpi methods (PWRD, PWG1 [4, 5]) that macOS calls when
changing the amdgpu's power state, but we don't use them and that could be
a cause. Additionally unlike previous generation Macbooks which work
better, on MacBookPro16,1 the gpu is located behind 2 pci bridges:

01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
	Navi 10 XL Upstream Port of PCI Express Switch (rev 43)
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI]
	Navi 10 XL Downstream Port of PCI Express Switch
03:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
	Navi 14 [Radeon RX 5500/5500M / Pro 5500M] (rev 43)
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI]
	Navi 10 HDMI Audio

Upon attempting to power on the gpu with vga_switcheroo, all these
devices except 01:00.0 have their config space in `lspci -x` filled with
0xff. `echo 1 > /sys/bus/pci/rescan` fixes that and the dmesg errors about
changing power state, but "PSP create ring failed" still happens, and
the gpu doesn't resume properly.

[1]: https://lore.kernel.org/all/3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com/
[2]: https://t2linux.org
[3]: https://lore.kernel.org/all/9eed8ede6f15a254ad578e783b050e1c585d5a15.1439288957.git.lukas@wunner.de/
[4]: https://gist.github.com/Redecorating/6c7136b7a4ac7ce3b77d8e41740dd87b
[5]: https://lore.kernel.org/all/20120710160555.GA31562@srcf.ucam.org/

Kerem Karabay (1):
  drm/amdgpu: register a vga_switcheroo client for all GPUs that are not
    thunderbolt attached

Orlando Chamberlain (8):
  apple-gmux: use cpu_to_be32 instead of manual reorder
  apple-gmux: consolidate version reading
  apple-gmux: use first bit to check switch state
  apple-gmux: refactor gmux types
  apple-gmux: Use GMSP acpi method for interrupt clear
  apple-gmux: support MMIO gmux on T2 Macs
  apple-gmux: add sysfs interface
  hda/hdmi: Register with vga_switcheroo on Dual GPU Macbooks

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  18 +-
 drivers/platform/x86/apple-gmux.c          | 416 +++++++++++++++++----
 include/linux/apple-gmux.h                 |  50 ++-
 sound/pci/hda/hda_intel.c                  |  19 +-
 4 files changed, 409 insertions(+), 94 deletions(-)

-- 
2.39.1

