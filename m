Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8603BC433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Oct 2022 06:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9AF10E71E;
	Sun, 16 Oct 2022 06:05:15 +0000 (UTC)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDD210E711
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Oct 2022 06:05:08 +0000 (UTC)
Received: by mail-vk1-xa36.google.com with SMTP id a6so4032124vkm.9
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Oct 2022 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+oZJK4qUeBvbbZ8z36EHznYCAbAJUGbr1jH6EkPyBxg=;
 b=gNFaSsw4zu2uSK6RJ1MJcTySAiGpVitkA3eCjwluDuyyBYQ5t2VwNVmPBAZILb1gSD
 UxTDO5UU/R8kiDJAnNNvMVU9Rcx/asp33u+uJ8U/sd8OBiJO5YINo4ShjfQkLJ2npctx
 qX+3U5zNxodxuwnoXgKqek1gUngrbEXZkIXc8d2K1gl1VaMyBZ8mk6FE8MlS2egekd2u
 C2fVIoJt/qvlffn7cWolazx4/khhFCY7f5p7Aeda4XIXNounKlhFxsqLJlrzD8zU47Qv
 ItPZ8FFXLFmMiVvZBDdHk0sYvpm6QSLBjjjyHBpsjY9aLq17RXiHf+cSwgPxa/eQiNEc
 FOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+oZJK4qUeBvbbZ8z36EHznYCAbAJUGbr1jH6EkPyBxg=;
 b=e/mNNHwLaxwmL4qgbec5rQD6KILXLlIqwCJlXBoES/ewjyuVsxUxSPyor7NZG6uE5R
 DlZlvYhoBFAc0DomH7f7DvuuhDp8ls55XbB4buBAy/jT/vwfOTmzrNx7/dT204xpKoIn
 5unn4YkAWo1jz4avmsRRTT6CP3KcdsDOuaUC3zhDKx9R+ONyBiLbspCXZ67t9JA1qeQ3
 EAF34ejO0o7GFX1tl59s2SZrdjnLXhq2qgIYhsbgO1qRzy1pGso0LuEP5xh4/KGNTt2f
 4dHN1AhbTlPuX18eNIB6sC3XuqDFnizY1r4GVNRGZUB1Y12fNGL8yfsxXTkzlMd7pDRS
 251A==
X-Gm-Message-State: ACrzQf0oGFGUuJIe1jIq+HCK3zVzYdLy2O4Qa+iTKUS96wyzvyn8Ieep
 T45oecnLu+tAYpcThFIO+x8rvwRbi19Ia/86sDBFP1xm
X-Google-Smtp-Source: AMsMyM4GKabx5jfmxGuaLocxCd1hwMRJIN+aDXAJGzRXMlb4JzMCF59x+RS2ZRuLn8pN3TQ1kH+VuMDxk4Gj7qsij1s=
X-Received: by 2002:a1f:1e12:0:b0:3a3:6ce9:3f11 with SMTP id
 e18-20020a1f1e12000000b003a36ce93f11mr1928579vke.15.1665900306647; Sat, 15
 Oct 2022 23:05:06 -0700 (PDT)
MIME-Version: 1.0
From: jim.cromie@gmail.com
Date: Sun, 16 Oct 2022 00:04:40 -0600
Message-ID: <CAJfuBxxAk8sy8gyFuUrc7PqyzzUR6NeLuNsoKvJpF=i7P-f3eg@mail.gmail.com>
Subject: Please remove unsupported %f in format string
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
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

while booting with drm.debug=0x3ff on cmdline, I saw this complaint.

I can go looking for it at some point, but I should report it now.


[    7.401934] fbcon: amdgpudrmfb (fb0) is primary device
[    7.401999] [drm] DSC precompute is not needed.
[    7.402114] ------------[ cut here ]------------
[    7.402115] Please remove unsupported %f in format string
[    7.402126] WARNING: CPU: 1 PID: 526 at lib/vsprintf.c:2656
format_decode+0x441/0x540
[    7.402132] Modules linked in: amdgpu(+) drm_ttm_helper ttm video
iommu_v2 gpu_sched i2c_algo_bit drm_buddy drm_display_helper
drm_kms_helper drm crct10dif_pclmul crc32_pclmul crc32c_intel nvme cc
p ghash_clmulni_intel sp5100_tco nvme_core cec r8169 wmi ip6_tables
ip_tables fuse
[    7.402146] CPU: 1 PID: 526 Comm: systemd-udevd Not tainted
6.0.0-kj-09699-g8419b52b1e22 #12
[    7.402148] Hardware name: MicroElectronics G464/TUF GAMING
X570-PLUS (WI-FI), BIOS 9004 10/10/2019
[    7.402150] RIP: 0010:format_decode+0x441/0x540
[    7.402152] Code: ff ff c6 45 05 08 ba 12 00 00 00 e9 9b fc ff ff
0f be f2 48 c7 c7 40 e9 6b b8 48 89 04 24 c6 05 28 ee 8e 01 01 e8 8d
ff 57 00 <0f> 0b 48 8b 04 24 e9 fc fd ff ff 48 8d 7c 24 08 e8
 aa f3 ff ff 88
[    7.402154] RSP: 0018:ffffaa4300a76e58 EFLAGS: 00010292
[    7.402155] RAX: 000000000000002d RBX: ffffffffc0ccb295 RCX: 0000000000000000
[    7.402157] RDX: 0000000000000003 RSI: ffffffffb86a0b3f RDI: 00000000ffffffff
[    7.402157] RBP: ffffaa4300a76e90 R08: ffffffffb8e78120 R09: ffffaa4300a76df8
[    7.402159] R10: 3fffffffffffffff R11: 000000000000002f R12: ffff8bdc3ea6ee80
[    7.402159] R13: ffffffffc0ccb295 R14: 00000000000000da R15: ffff8bdc3ea6edb8
[    7.402160] FS:  00007fa035678580(0000) GS:ffff8bdc3ea40000(0000)
knlGS:0000000000000000
[    7.402162] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.402163] CR2: 000055bf740fc1d0 CR3: 0000000128d9e000 CR4: 0000000000350ee0
[    7.402164] Call Trace:
[    7.402166]  <TASK>
[    7.402170]  vsnprintf+0x5d/0x550
[    7.402173]  va_format.constprop.0+0x61/0xf0
[    7.402175]  vsnprintf+0x184/0x550
[    7.402178]  vscnprintf+0xe/0x30
[    7.402180]  ddebug_trace+0x72/0x150
[    7.402183]  ddebug_printk+0x66/0xa0
[    7.402185]  __dynamic_pr_debug+0xd3/0x110
[    7.402189]  CalculatePrefetchSchedule.constprop.0+0x6c3/0xee0 [amdgpu]
[    7.402430]  ? trace_event_buffer_commit+0x59/0x250
[    7.402434]
dml20v2_ModeSupportAndSystemConfigurationFull+0x4a00/0x5d50 [amdgpu]
[    7.402630]  ? dml_get_voltage_level+0x15c/0x270 [amdgpu]
