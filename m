Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BEEC2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 13:27:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E884061040
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 13:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E884061040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609AB6E139;
	Thu, 17 Jun 2021 13:27:18 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048BE89857
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 08:18:48 +0000 (UTC)
Received: by mail-lj1-x22e.google.com with SMTP id r16so7715090ljk.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 01:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=V7muk8KKGe+XfFxd73JpvxGyl10Hv3uLmnfhj616AV4=;
 b=GZ36J/8v3yEHnIaE1bA/VdmqD+khFtpAsmwdiB0nNCQiKibY5jHVRtAtcWIArI7Ay5
 uxME1d+8o65hnBI0cnl0GzWgxH3acAMDWZrXGVb69uC+a/G5/643H+AX5OXXh4+BG92X
 P2sbCsJB0Buo/suKUUF5U//0qPmJYU+QcFM4L7liB/ygeOb0WENhbS//HJuEqE1I2EbQ
 8QMjFtg/qZi2mO/wzR77OV6l4LB+aJq4ApdZfyUem/EgwyruJBeVWtKbDGYuf9Ptn9O2
 zyJMhTADsR5dkFQOiKf6XU7jRIvLxBnPcJVy8ZZUiBfP7VFiRM0eFGtXU+28PKFGLy2H
 Y28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=V7muk8KKGe+XfFxd73JpvxGyl10Hv3uLmnfhj616AV4=;
 b=sqpGdL+hbrekSMiliEvQA2vnslB74+7ycCBoIUYCH7MEMIpcN+g3VcUtnnTzE1tK/a
 kxxbYWwaDjqF8KHcgUlkiTD+HnmlOlNgyGUU3gz/p6sJDWXgtmcxF8GKIpNvJZASr0l7
 ytnKjCdWfG/zcIuwUucyoGvc2/fBMG5GSB84PMEZGrSOwl2EalISiScsqen5RUmtaKwx
 BJFD10iErOTmzyyU6IjHC+UEwSsyHKgqILs0gXL3g2hdhvwwyW3CsiXu7KRidTDo8tEj
 PcBSg9fx1ommLggUbL0fW1vkv+BaICye7RHlJwxOv5NswpfdBHaumSHZIYgcik32737D
 kwiA==
X-Gm-Message-State: AOAM532qx7DP28Jo1rBMf83dhdl97KfrwcJt8KEj368uVeWK10qeLa/K
 IahHxiQtxDCLEjf8QTPjqCdG
X-Google-Smtp-Source: ABdhPJyvPKvE+pM6k9WPNugZFb7ICxZCC8iESxs+ncVii7E4DwD2+oRu+4hVdvEAkMp1HMV+j6cshQ==
X-Received: by 2002:a2e:990c:: with SMTP id v12mr3572138lji.136.1623917927306; 
 Thu, 17 Jun 2021 01:18:47 -0700 (PDT)
Received: from luke.goog-chromeos.semihalf.net ([83.142.187.85])
 by smtp.gmail.com with ESMTPSA id t6sm498685lfp.301.2021.06.17.01.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jun 2021 01:18:46 -0700 (PDT)
From: Lukasz Bartosik <lb@semihalf.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v1] drm/amdgpu: fix framebuffer memory use after free
Date: Thu, 17 Jun 2021 10:18:43 +0200
Message-Id: <20210617081843.26987-1-lb@semihalf.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 17 Jun 2021 13:27:16 +0000
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
Cc: upstream@semihalf.com, amd-gfx@lists.freedesktop.org,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

With option CONFIG_DEBUG_LIST enabled the kernel logs show list_add
corruption warning. The warning originates from drm_framebuffer_init()
function which adds framebuffer to a framebuffers list and is called by
amdgpu_display_gem_fb_verify_and_init().
If amdgpu_display_gem_fb_verify_and_init() encounters an error after
calling drm_framebuffer_init() then framebuffer memory is released
in amdgpu_display_user_framebuffer_create() without removing framebuffer
from the list where it was added. Reuse of that memory by any other
party cause corruption of the framebuffers linked list. This fix removes
framebuffer from the linked list and unregisters it in case of failure.

[   23.252465] ------------[ cut here ]------------
[   23.252469] list_add corruption. next->prev should be prev (ffff9921c16203a8), but was 733a656c69665f6d. (next=ffff9920debec508).
[   23.252506] WARNING: CPU: 1 PID: 1637 at lib/list_debug.c:25 __list_add_valid+0x56/0x8f
[   23.252520] Modules linked in: xt_cgroup rfcomm cmac algif_hash algif_skcipher af_alg uinput xt_MASQUERADE uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common btusb btrtl btintel btbcm bluetooth ecdh_generic ecc iio_trig_sysfs snd_hda_codec_hdmi designware_i2s snd_hda_intel snd_intel_dspcfg i2c_piix4 snd_hda_codec snd_hwdep snd_hda_core acpi_als industrialio_triggered_buffer kfifo_buf industrialio snd_soc_acp_rn_rt5682_mach snd_soc_max98357a snd_soc_adau7002 snd_soc_acp_rt5682_mach snd_soc_acp_da7219mx98357_mach acp_audio_dma snd_soc_da7219 ip6table_nat fuse ath10k_pci ath10k_core ath mac80211 cfg80211 r8152 mii joydev
[   23.252595] CPU: 1 PID: 1637 Comm: DrmThread Not tainted 5.13.0-rc6 #22
[   23.252603] Hardware name: HP Grunt/Grunt, BIOS Google_Grunt.11031.162.0 04/08/2021
[   23.252608] RIP: 0010:__list_add_valid+0x56/0x8f
[   23.252616] Code: 47 4c 39 fb 0f 95 c1 4c 39 f3 0f 95 c0 20 c8 5b 41 5e 41 5f 5d c3 48 c7 c7 f4 37 9f bc 4c 89 f6 4c 89 f9 31 c0 e8 0c c7 c5 ff <0f> 0b eb 16 48 c7 c7 c2 f6 99 bc 4c 89 fe 4c 89 f1 31 c0 e8 f4 c6
[   23.252622] RSP: 0018:fffface940c87ba0 EFLAGS: 00010246
[   23.252629] RAX: 8ae6d9bca9cb6a00 RBX: ffff9920debec100 RCX: 8ae6d9bca9cb6a00
[   23.252634] RDX: 0000000000000027 RSI: 00000000ffffdfff RDI: ffff9921ead12e48
[   23.252638] RBP: fffface940c87bb8 R08: 0000000000000000 R09: fffface940c87938
[   23.252643] R10: 00000000ffffdfff R11: ffffffffbcc821f0 R12: 0000000000000000
[   23.252647] R13: ffff9920debec508 R14: ffff9921c16203a8 R15: ffff9920debec508
[   23.252652] FS:  00007e6190717640(0000) GS:ffff9921ead00000(0000) knlGS:0000000000000000
[   23.252658] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   23.252662] CR2: 00002e7a09404000 CR3: 0000000120644000 CR4: 00000000001506e0
[   23.252667] Call Trace:
[   23.252676]  drm_framebuffer_init+0xfb/0x13c
[   23.252685]  amdgpu_display_gem_fb_verify_and_init+0x4b/0x10a
[   23.252693]  ? kmem_cache_alloc_trace+0x104/0x1dc
[   23.252703]  amdgpu_display_user_framebuffer_create+0xe0/0x195
[   23.252709]  drm_internal_framebuffer_create+0x2fd/0x3d4
[   23.252718]  drm_mode_addfb2+0x39/0xd6
[   23.252724]  ? drm_internal_framebuffer_create+0x3d4/0x3d4
[   23.252731]  drm_ioctl_kernel+0x99/0xfb
[   23.252739]  drm_ioctl+0x25a/0x3a4
[   23.252745]  ? drm_internal_framebuffer_create+0x3d4/0x3d4
[   23.252753]  amdgpu_drm_ioctl+0x49/0x7d
[   23.252760]  __se_sys_ioctl+0x7c/0xb8
[   23.252767]  do_syscall_64+0x5f/0xa9
[   23.252774]  ? exit_to_user_mode_prepare+0x68/0x81
[   23.252781]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   23.252790] RIP: 0033:0x7e619b2aff07
[   23.252796] Code: 3c 1c 48 f7 d8 49 39 c4 72 b2 e8 14 ff ff ff 85 c0 78 b7 48 83 c4 08 4c 89 e0 5b 41 5c 41 5d 5d c3 66 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 29 af 0b 00 f7 d8 64 89 01 48
[   23.252801] RSP: 002b:00007e6190715e48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[   23.252808] RAX: ffffffffffffffda RBX: 4120acd8347d3800 RCX: 00007e619b2aff07
[   23.252812] RDX: 00007e6190715e80 RSI: 00000000c06864b8 RDI: 000000000000001d
[   23.252817] RBP: 00007e6190715e70 R08: 00007e61907160e8 R09: 00007e61907160f8
[   23.252821] R10: 00007e6190716108 R11: 0000000000000246 R12: 000000000000001d
[   23.252825] R13: 0000000000000168 R14: 00007e6190715e80 R15: 00000000c06864b8
[   23.252830] ---[ end trace 34051e69065d2c6d ]---

Fixes: 6eed95b00b45 ("drm/amd/display: Store tiling_flags in the framebuffer.")
Signed-off-by: Lukasz Bartosik <lb@semihalf.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index c13985fb35be..933190281b91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1085,14 +1085,17 @@ int amdgpu_display_gem_fb_verify_and_init(
 			    mode_cmd->modifier[0]);
 
 		ret = -EINVAL;
-		goto err;
+		goto err_fb_cleanup;
 	}
 
 	ret = amdgpu_display_framebuffer_init(dev, rfb, mode_cmd, obj);
 	if (ret)
-		goto err;
+		goto err_fb_cleanup;
 
 	return 0;
+err_fb_cleanup:
+	drm_framebuffer_unregister_private(&rfb->base);
+	drm_framebuffer_cleanup(&rfb->base);
 err:
 	drm_dbg_kms(dev, "Failed to verify and init gem fb: %d\n", ret);
 	rfb->base.obj[0] = NULL;
-- 
2.32.0.272.g935e593368-goog

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
