Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534D7C369C1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 07:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B30710E860;
	Wed, 16 Apr 2025 07:25:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wQbLrOCT";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 842C410E13A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 18:28:16 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so48612055e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744741695; x=1745346495; darn=lists.freedesktop.org;
 h=cc:to:from:subject:message-id:date:content-transfer-encoding
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L49TGW+7xz/Nh6pz+awW7HEg66lfzot3qylqJrkV2gw=;
 b=wQbLrOCTZw/o49EVp3x3K7yph8PC0fYgTd3K7MlpYWXCf77Fh2iAn+ZocIQEEt45Gr
 Bxfihre3vi9oQofl4AFTVbPPIOztxprtgGo1FUdElLY4g6IeQjK6HT9QKRXTLuC9n/5a
 SG1cEUUAVLbAkaXVwOxCpxKgiNWOK4OSWvlk26j4kH60HSx2JCEmYbEVfyEsHugp6RFa
 SIiiK4TQAZnLXVHj3dOFzHK/xLus5aC1bmk55E/uekr1zhnpbgeanytjtmgZgnUlj2sY
 K7AoicoNeutiLt/KwE4/ct2xhqhImf/ucu15SLgodVK2wo5MJzxyjgXt6bFpIVl8S4lb
 fq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744741695; x=1745346495;
 h=cc:to:from:subject:message-id:date:content-transfer-encoding
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L49TGW+7xz/Nh6pz+awW7HEg66lfzot3qylqJrkV2gw=;
 b=H3vyCFiMNt1UOO8+3VLfSB7XXnpDtYbYamDpNDameEaN5ePthwCu7GGwMj0BKXWzy0
 KRGvyHdgc5Ol8hjse8ojkAbVNTCm3CdZAZI0r75mJ9fvPOuXsfXh1LkOvRcvfsuiacMN
 xG+I092wdkE7t38RpST56ZBsyrWPHjhHgrOzRRNYZdlfCY7i5TdJQ7jLfKmIYIgarGFK
 QhSSbFPXWVtmAtn336ogb0m3RYpdYsokqoEuK5+Z29jJuy4Z/478R1m1Ze/dQMLY4gOD
 eAaS1dFDISZPZpaqKEqSrq1e7cmtXYbz73LBXak6ynok2EMsrphn9yvmO/Ytl04K/S+R
 k1vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDQS/cP0KMT6y+RORASS870P9UjikUHWZY+XoUq367qXKIz7e2yX2oMm8hemzV5Ks5jDQa/3cC@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxpri4EhiOomS09rzL3VZq9snU3iOuV+aomaXXzCirFjyHsBXvl
 V5Dcoe5DbJXlZy12qQmCE0iJBHcvaol7tsiFMGctH7FtNKeZIpKmWJ/n4UjPLsY=
X-Gm-Gg: ASbGncvNAAZ4vfKEW2mx8ss+XZq+C5kW+y694Ov4PaKnMmMWkWxmeX+/oTKqTKur47a
 do6CPCz6RSiuwddM0df+X4HX8gHwC6Emy7tHY9AaXXO/h8SB4ipFuhMiWeUXpywibQkMZ3EHbxY
 2BJ00gykfgdDs5mxRU0t74LwzW6YQi2aLh25rSclCQUv2WEDkWQEgx6YBUvmUyN8oL6Qc/6rRFB
 k6d9qzaGxT8kgiXZsEjH/CLnhi4Hm8OlUf8xrXq92gXT/H58fBEGm6PSOEZync12C1qVD7YPJuQ
 Hb+m6TUhlob4G/j0wmcoCudlU78F5pe7ruDCc6YX
X-Google-Smtp-Source: AGHT+IH6mc9ELyei13BV0wrRCDW96LMH74+mJafLGoFBT7/zz8c7C0skMK9mvtbozXXRqxJ2TdA7Lg==
X-Received: by 2002:a05:600c:1d95:b0:43d:878c:7c40 with SMTP id
 5b1f17b1804b1-44059fcb970mr2110625e9.10.1744741694981; 
 Tue, 15 Apr 2025 11:28:14 -0700 (PDT)
Received: from localhost ([2.216.7.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445708sm15206699f8f.96.2025.04.15.11.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 11:28:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Apr 2025 19:28:13 +0100
Message-Id: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
Subject: [REGRESSION] amdgpu: async system error exception from
 hdp_v5_0_flush_hdp()
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: <alexander.deucher@amd.com>, <frank.min@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Cc: <stable@vger.kernel.org>, <david.belanger@amd.com>,
 <christian.koenig@amd.com>, <peter.chen@cixtech.com>,
 <cix-kernel-upstream@cixtech.com>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.20.0
X-Mailman-Approved-At: Wed, 16 Apr 2025 07:25:00 +0000
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


#regzbot introduced: v6.12..v6.13

I use RX6600 on arm64 Orion o6 board and it seems that amdgpu is broken on =
recent kernels, fails on boot:

[drm] amdgpu: 7886M of GTT memory ready.
[drm] GART: num cpu pages 131072, num gpu pages 131072
SError Interrupt on CPU11, code 0x00000000be000011 -- SError
CPU: 11 UID: 0 PID: 255 Comm: (udev-worker) Tainted: G S                  6=
.15.0-rc2+ #1 VOLUNTARY
Tainted: [S]=3DCPU_OUT_OF_SPEC
Hardware name: Radxa Computer (Shenzhen) Co., Ltd. Radxa Orion O6/Radxa Ori=
on O6, BIOS 1.0 Jan  1 1980
pstate: 83400009 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=3D--)
pc : amdgpu_device_rreg+0x60/0xe4 [amdgpu]
lr : hdp_v5_0_flush_hdp+0x6c/0x80 [amdgpu]
sp : ffffffc08321b490
x29: ffffffc08321b490 x28: ffffff80b8b80000 x27: ffffff80b8bd0178
x26: ffffff80b8b8fe88 x25: 0000000000000001 x24: ffffff8081647000
x23: ffffffc079d6e000 x22: ffffff80b8bd5000 x21: 000000000007f000
x20: 000000000001fc00 x19: 00000000ffffffff x18: 00000000000015fc
x17: 00000000000015fc x16: 00000000000015cf x15: 00000000000015ce
x14: 00000000000015d0 x13: 00000000000015d1 x12: 00000000000015d2
x11: 00000000000015d3 x10: 000000000000ec00 x9 : 00000000000015fd
x8 : 00000000000015fd x7 : 0000000000001689 x6 : 0000000000555401
x5 : 0000000000000001 x4 : 0000000000100000 x3 : 0000000000100000
x2 : 0000000000000000 x1 : 000000000007f000 x0 : 0000000000000000
Kernel panic - not syncing: Asynchronous SError Interrupt
CPU: 11 UID: 0 PID: 255 Comm: (udev-worker) Tainted: G S                  6=
.15.0-rc2+ #1 VOLUNTARY
Tainted: [S]=3DCPU_OUT_OF_SPEC
Hardware name: Radxa Computer (Shenzhen) Co., Ltd. Radxa Orion O6/Radxa Ori=
on O6, BIOS 1.0 Jan  1 1980
Call trace:
 show_stack+0x2c/0x84 (C)
 dump_stack_lvl+0x60/0x80
 dump_stack+0x18/0x24
 panic+0x148/0x330
 add_taint+0x0/0xbc
 arm64_serror_panic+0x64/0x7c
 do_serror+0x28/0x68
 el1h_64_error_handler+0x30/0x48
 el1h_64_error+0x6c/0x70
 amdgpu_device_rreg+0x60/0xe4 [amdgpu] (P)
 hdp_v5_0_flush_hdp+0x6c/0x80 [amdgpu]
 gmc_v10_0_hw_init+0xec/0x1fc [amdgpu]
 amdgpu_device_init+0x19f8/0x2480 [amdgpu]
 amdgpu_driver_load_kms+0x20/0xb0 [amdgpu]
 amdgpu_pci_probe+0x1b8/0x5d4 [amdgpu]
 pci_device_probe+0xbc/0x1a8
 really_probe+0xc0/0x39c
 __driver_probe_device+0x7c/0x14c
 driver_probe_device+0x3c/0x120
 __driver_attach+0xc4/0x200
 bus_for_each_dev+0x68/0xb4
 driver_attach+0x24/0x30
 bus_add_driver+0x110/0x240
 driver_register+0x68/0x124
 __pci_register_driver+0x44/0x50
 amdgpu_init+0x84/0xf94 [amdgpu]
 do_one_initcall+0x60/0x1e0
 do_init_module+0x54/0x200
 load_module+0x18f8/0x1e68
 init_module_from_file+0x74/0xa0
 __arm64_sys_finit_module+0x1e0/0x3f0
 invoke_syscall+0x64/0xe4
 el0_svc_common.constprop.0+0x40/0xe0
 do_el0_svc+0x1c/0x28
 el0_svc+0x34/0xd0
 el0t_64_sync_handler+0x10c/0x138
 el0t_64_sync+0x198/0x19c
SMP: stopping secondary CPUs
Kernel Offset: disabled
CPU features: 0x1000,000000e0,f169a650,9b7ff667
Memory Limit: none
---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---

(bios version seems to be 45 years old but that is the state of the board
when I received it)

Also saw this crash with RX6700. Old radeons like HD5450 and nvidia gt1030
work fine on that board.

A little bit of testing showed that it was introduced between 6.12 and 6.13=
.
Also it seems that changes were taken by some distro kernels already and
different iso images I tried failed to boot before I bumped into some iso
with kernel 6.8 that worked just fine.

The only change related to hdp_v5_0_flush_hdp() was
cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP

Reverting that commit ^^ did help and resolved that problem. Before sending
revert as-is I was interested to know if there supposed to be a proper fix
for this or maybe someone is interested to debug this or have any suggestio=
ns.

In theory I also need to confirm that exactly that change introduced the
regression.

Thanks,
Alexey

