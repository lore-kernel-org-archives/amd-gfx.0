Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1127C5DF70
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 07:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723A810E684;
	Mon, 17 Aug 2026 07:01:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XR7J7ifh";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A5AF10E321
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Aug 2026 15:20:44 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so20900115e9.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Aug 2026 08:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786893643; x=1787498443; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hA6ZcSIXBspwUlSfeLJa7+a0Uc2KtuRzGYFFOPOHJWU=;
 b=XR7J7ifhH/25v/Jn55NIxoWUB0uE5pFIoLhRNq2gk4neXihCHDB298xYJBsNPo64qI
 shLpXal3UHDtfJ3FweuebtY2b/2fKRXDd8BgnAQW0pqqlM1Ln+FY3o3zjlo4qd8c5mjy
 OdVI/vaEM1HTJ+0y6WMPrHmnN9tjlaenYiSA+v0JZ7FUjaBpR+EI8LOVUCrWh4AH5rkM
 cOGeCYxRYKx0NRImtd2xw9gZjrYJXrHo1V7NhGE4vqZ1vGDoSjuJM+Czly11OciRzNLW
 1GWEcqzKjye6gcMHB4ZMHmwqhUpgMgtzZNL1kcr1219iz2HSnJrqZfn/ltcz/avmdYO/
 XJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786893643; x=1787498443;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hA6ZcSIXBspwUlSfeLJa7+a0Uc2KtuRzGYFFOPOHJWU=;
 b=rgwm3NeN3tw9bo/sqMFv5B0vBA6REjlf+f2KQxbbhJ1jeLxTQssVKaGWkWx5agq6Bp
 YrPCANghqcz6ynd9+bGJUq1K4PuVsRcVSr81pxzJrW2hH/j9ztI5NSJhhmDAxeMm9nUK
 islazlLT829+JAwgpobnKWHmyMshrBnkzDg1tIBnGDpB+u+/DqANOZ0XiVhy0XqmTcGc
 m1GDcJIFRATsoZXy3sCqTQUdx/XTutTyQ0e+w/nCfg+EEbPbOzRdhnx5Sqibi+AnX/1P
 kra8+egl9LgjISMCtb04MacD/z9fM1D1ra4CKV7R5wRng9dO7FI/810JgSXqH6J4ATqR
 Pm6g==
X-Gm-Message-State: AOJu0YwrP1f8G3c2CdpKVVXmhkZyzJgbLh7kW+j6at4zbOxs7zZU2KyX
 pSRm3ataQY2hlRmkTb1+y9HxD89rQf/lJn6B1MiMyWMZ8zP73sOaCpnhxtraAYwD9zl/VQ==
X-Gm-Gg: AR+sD10mP3GZ8TmFtPZVBS44axZ8BUFPigxb87bAWZOkc6y5kPt2+eVGpv/gDe24W3u
 b8KCZYT5ZWq0dlMsTqvgVnZCJmW9kmTlH+y/X7+6avsizdMa+Tf7aBwMLa9kqoQ2JqAylRG9TKV
 R4m/+DvXRZ91SiOjcpiobnSG257+jm5+iO4Ui9phcXQsyWFFEgwNe270t03PIL1JB9BPL7W2TkA
 7Y8AxEkDh1LqVrmTOnMlBXiQgk7xgqZi2DV99mFcO818T7e3/eaMZaNdicvBaXgetmshXa4OYeK
 Tv74Ga8++VCVIrOFWcNMs3Bd8OZGueAbWE9InnV+KDtVU5q1qiUhjWGPeHQzF4+uaPmfhCZW4dG
 mLnbEZ5sRuzHHvcVApVY6U5L/Ehog3P+4qNk5svbvKQo0N5T3FBuPDg91COGAyTMXqhkPBvHaNq
 To77PoaZkyszjIINV3Bbd43Xs6DO35yGLB03blujAbY4qV99VcbE99NigRW/zjQe6jM9AbIlTDQ
 eBKioPs38WqUDxySxyq2Q==
X-Received: by 2002:a05:600c:4e8a:b0:499:7a4f:d13d with SMTP id
 5b1f17b1804b1-499879441bdmr265663485e9.4.1786893642518; 
 Sun, 16 Aug 2026 08:20:42 -0700 (PDT)
Received: from cachyos-x8664 ([45.141.148.169])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996109652sm73425265e9.4.2026.08.16.08.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 08:20:42 -0700 (PDT)
From: Akhmed Zhitaev <zhitaevakh@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	linux-sound@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kenneth Feng <kenneth.feng@amd.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: AMD Phoenix 1002:1640 Radeon HDA WALLCLK becomes 5.76 MHz after
 s2idle resume
Date: Sun, 16 Aug 2026 20:17:54 +0500
Message-ID: <20260816151754.7555-1-zhitaevakh@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 07:01:16 +0000
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

Hello,

I am investigating an AMD Phoenix/Hawk Point laptop with an integrated Radeon GPU and a reproducible audio-timing failure after s2idle resume.

Hardware:

  GPU:        0000:6e:00.0, PCI ID 1002:1900
  Radeon HDA: 0000:6e:00.1, PCI ID 1002:1640
  Analog HDA: 0000:6e:00.6
  Parent:     0000:00:08.1, Phoenix internal GPP bridge
  DCN:        3.1.4
  NBIO:       7.7.0, nbio_v7_7_funcs
  MP1/SMU:    13.0.10, smu_v13_0_0

The internal eDP panel is active. No external HDMI/DP sink is connected; Radeon HDA ELD entries report no monitor present and invalid ELD.

After cold boot, Radeon HDMI/DP playback is normal. After a reproducing s2idle cycle, playback stutters in Firefox, Telegram/AyuGram, and mpv. The failure reproduces with direct ALSA, without PipeWire; with hardware decoding enabled or disabled; and with Vulkan or OpenGL rendering. The Ryzen analog HDA remains smooth.

With mpv, normal A/V synchronization, display-resample, and display-vdrop stutter. --video-sync=desync makes video smooth while A/V drifts by seconds.

Direct HDA controller measurements were taken through the existing kernel MMIO mapping. The active stream used S32_LE, 8 channels, 48000 Hz, buffer_size 32768 frames. Expected transport rate is 1,536,000 bytes/s.

GOOD cold boot:
  WALLCLK approximately 23,999,690 Hz
  LPIB approximately 1,535,987 bytes/s
  approximately 47,999 frames/s

BAD after s2idle:
  WALLCLK approximately 5,759,926 Hz
  LPIB approximately 368,638 bytes/s
  approximately 11,519 frames/s

The BAD/GOOD ratio is approximately 0.24, close to 6/25. System monotonic timestamps advance normally, so this is not merely an ALSA timestamp or hw_ptr accounting error.

HDA PM-boundary probes show:

  GOOD cold boot: hda_intel_init_chip() -> approximately 24 MHz
  BAD resume:     hda_intel_init_chip() -> approximately 5.76 MHz

A complete runtime suspend/resume of 0000:6e:00.1 produced:

  runtime-suspend-entry:       approximately 5.76 MHz
  after controller shutdown:   0
  runtime-resume-entry:        0
  after azx_init_pci():        0
  after hda_intel_init_chip(): approximately 5.76 MHz

The bad source clock therefore survives the local HDA controller power cycle.

The following did not restore 24 MHz:

  snd_hda_intel unbind/bind of 0000:6e:00.1
  PCI PM reset of 0000:6e:00.1
  full runtime suspend/resume of 0000:6e:00.1
  amdgpu MODE2 GPU recovery followed by SMU resume

MODE1 was attempted once, but GFX/MES resume failed. No post-MODE1 HDA WALLCLK measurement was obtained, so no conclusion about MODE1 HDA recovery is drawn.

The HDAU ACPI power resource performs OFF -> ON successfully. Radeon HDA normal resume is ordered after completion of the amdgpu parent resume.

The active AMDGPU resume path in the v7.1.8 tree is:

  amdgpu_pmops_resume()
    -> amdgpu_device_resume()
       -> amdgpu_device_ip_resume()
          phase1: soc21_common_resume, gmc_v11_0_resume, ih_v6_0_resume
          phase2: smu_resume, gfx_v11_0_resume, sdma_v6_0_resume,
                  vcn_v4_0_resume, jpeg_v4_0_resume, mes_v11_0_resume
          phase3: dm_resume

On normal non-SR-IOV resume, PSP is excluded from the IP resume phases. For S0ix, PSP is also intentionally skipped during suspend because the source describes it as always-on hardware whose firmware/TMR state is reused.

The active smu_v13_0_0_ppt_funcs has no gfx_state_change_set member, so the generic D0-entry call has no ASIC-specific implementation on this path.

The active NBIO discovery dispatch is:

  IP_VERSION(7, 7, 0) / (7, 7, 1)
    -> adev->nbio.funcs = &nbio_v7_7_funcs

soc21_common_resume() invokes soc21_common_hw_init(), which calls nbio_v7_7_init_registers() during resume as well as cold initialization.

Read-only NBIO snapshots of the registers referenced by the active implementation were bit-identical at pre-s0ix, post-resume-pre-atomic, and post-atomic-restore:

  BIF0_PCIE_MST_CTRL_3
  BIF0_CPM_CONTROL
  BIF0_PCIE_CNTL2
  BIF0_PCIE_TX_POWER_CTRL_1
  RCC_DEV0_EPF5_STRAP4

The logged DCN audio DTO and clock-manager state did not show a corresponding 6/25 change. These display-side DTO registers are distinct from the PCI HDA WALLCLK register.

The v7.1.8 tree contains BacoAudioD3PME and EnableAudioStutterWA definitions, but BacoAudioD3PME is not mapped in the active smu_v13_0_0 message map and the active PPT implementation has no set_azalia_d3_pme callback. EnableAudioStutterWA has no active Phoenix mapping or callback. Neither is being presented as a known fix, and neither was sent.

The evidence establishes that the Radeon HDA WALLCLK itself changes from approximately 24 MHz to approximately 5.76 MHz after s2idle; the stream DMA follows the same ratio; the state survives local HDA recovery and MODE2 recovery; and it is not explained by the logged DCN DTO or NBIO state. The remaining hypothesis is a platform- or firmware-owned reference-clock mux/divider or power-domain state affecting GP17/HDAU that is not restored correctly across S0ix. This is a hypothesis, not a demonstrated register-level root cause.

I would appreciate guidance on whether Phoenix/Hawk Point PMFW has a documented HDA/Azalia clock restore sequence, whether an audio-specific SMU message is expected for this ASIC, and whether PSP or platform firmware is expected to restore the GP17/HDAU reference clock during S0ix resume.

No kernel workaround has been added, and no undocumented SMU message has been issued.

======================================================================
Appendix A: Representative GOOD/BAD HDA measurements
======================================================================

HDA controller timing samples (PCI 0000:6e:00.1, PCM8, S32_LE, 8ch, 48000 Hz)

GOOD cold boot:
  WALLCLK_Hz=23999690
  LPIB_Bps=1535987
  frames_per_sec=47999
  configured_rate=48000

BAD after s2idle + AC wake:
  WALLCLK_Hz=5759926
  LPIB_Bps=368638
  frames_per_sec=11519
  configured_rate=48000

BAD/GOOD ratio: approximately 0.24 (approximately 6/25).

======================================================================
Appendix B: HDA PM-boundary measurements
======================================================================

Radeon HDA PM-boundary WALLCLK measurements (0000:6e:00.1, 1002:1640)

GOOD cold-boot initialization:
  hda_intel_init_chip(): approximately 24 MHz

Failing system resume after s2idle:
  hda_intel_init_chip(): approximately 5.76 MHz

BAD runtime suspend/resume:
  runtime-suspend-entry:       approximately 5.76 MHz
  after controller shutdown:   0
  runtime-resume-entry:        0
  after azx_init_pci():        0
  after hda_intel_init_chip(): approximately 5.76 MHz

======================================================================
Appendix C: NBIO/DCN state snapshots
======================================================================

NBIO 7.7.0, implementation nbio_v7_7_funcs.

Read-only NBIO snapshots were bit-identical at:

  pre-s0ix
  post-resume-pre-atomic
  post-atomic-restore

Registers:
  BIF0_PCIE_MST_CTRL_3
  BIF0_CPM_CONTROL
  BIF0_PCIE_CNTL2
  BIF0_PCIE_TX_POWER_CTRL_1
  RCC_DEV0_EPF5_STRAP4

Relevant DCN phase state:
  xtalin=24000, dccg_ref=24000
  audio_dtb_dto=00000001/00000000
  audio_dto_src=00000030
  dtb_p=00000492

The visible DCN audio DTO state did not change by the 6/25 ratio across the failing resume. These display-side DTO registers are distinct from the PCI HDA controller WALLCLK register.

Thanks,
Akhmed Zhitaev
