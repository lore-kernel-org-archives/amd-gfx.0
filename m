Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD8606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DScJEfWs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9441B10FCCF;
	Wed, 21 Oct 2026 08:53:27 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2536410E0B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 07:44:06 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so250862f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 00:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792568644; cv=none;
 d=google.com; s=arc-20260327;
 b=k/oVwxUi+FxTixoSDcmeWyQ0iaMYp2offc2CZ7k9csywsheMB8FPbKqyQMWux2OcS2
 Y8Mtrwp4rBMq6U75JFTYhec9Dq9JRIEB1rs6rYmhMUZnjbUsmsdyamNk6OPDqDYEYrcv
 RAyRd3hZnQf0HskZs364z18fxMz0+910JibWVLoPsbK3oNN/c3AOPVofveUSahqhg2Vl
 E11YriYcdPzGvlqO95mJVVpOImkkXPu8vnBp67HF2GXtDvNnlR5DYjb71yF0RjsPvgKl
 G2xd4JxEIgF1o4Ueq93aZCxn7q5Hov77bsRquIguB7H7j/5ezXSkN5STR2P0T4I7UNPf
 SPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=J80tzjP2E7TR9Dtgzlb71WIgQgOL1t9ERLRPqpbFo6k=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=Tg76uwgZD7L8ZiCmC1UbpCPO1Zgjb+NuWxoRhVL4+T4QfTXgpotJzbbNSdh4GJFPp0
 kMiZJ9lUQtmtEnJ3+gWBhn5kt0XB8HeZm1+maVBWC/V8mBj/APlW8l0sMbG+GJS+seUK
 KEMsJMTt85zNpK7s2OwDV5C60UJC88Ki7iSGiOx8LsR5PANUJUGijG+nyrGDR4VqVW3i
 lq/p6dDnzzSDRhEvilpTAemGr5AfT6jMEum39sdykZdIWRui+wmyx4R4B/b3ss0C7CZI
 58Om1V7eriJmCIxWdzBgoO02WDGYVVxerfUnyNL9eHQZypPX7USVuaAvqEgxM07higs6
 +scQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792568644; x=1793173444; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J80tzjP2E7TR9Dtgzlb71WIgQgOL1t9ERLRPqpbFo6k=;
 b=DScJEfWsc/pBFQqG+lqzpBGUFIlAZ8hL4n4Q9XebUvNxTNsyIfFKsojYchyvJD0Eu2
 Sx5C/ebFTM/p8a9ejxq+/u7UGa89DKI7kxk/iDKOdl1nTqvD8UEkXnJ6nj5F7Q5aoIq6
 RmuKEefZNK/K3O5rh4edEbzh6+Ywez9RlsS/FRhNHHsV1MLvC+3i3/DzKGBQoCX/J/yy
 5zkfInIEJG4I2SB4wYIRumPdiP8O0fsaOBFAQk/aFURKQPqu0cUd+/qfGeNoULhffhTN
 Sk9RI5vNaRa0kbo/x1VjGAuYS/LsyQFB1JXX6GDb3FQNxmgRITXimKxJveMaSxBT+sgg
 Uxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792568644; x=1793173444;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J80tzjP2E7TR9Dtgzlb71WIgQgOL1t9ERLRPqpbFo6k=;
 b=BlcPM03R3bknhjOztoj4xgCYSalkwd0VDjuT64idLmFpa4tHJX6CTT6MfZW8mz4QA4
 EKxdqdkAPCUDxhaSE+H/odic1/AHZRf+FliD3pyFeHlzv1WjRjl5Fa6MAfdEMJKY9PyZ
 lVKUitn5elqwmRZ9RnIaUk6B+7JRwmQTCupHUuYgwrVBNFNOCp/Qi4iXBLIJ9g8Np40c
 gL+ejUePu8I/lnFY308d87tp9IcSs6LbxW4VXnnIK4VL2QMVPCbmT/a0+Bd5Hbwq74OB
 Ijek9AHKdEd9rji8T/Fg+JO6miSUX3Yw2VmzEQYhio811d2/ksA/EH2HHtJXDB/wySfi
 bsgg==
X-Gm-Message-State: AFq9FYJ6iUXy38eHqwakdACnmr/zsByF9ZMFIR8lMiFpZyLXyhNTHADN
 XwoXjU+es5pRykUAxXCaptk6/e9CFTeFosLmzp05+zpajZIBRsYj+EFw6Dx9Mnl7tD2QmATcnCl
 m9ESIRl1NgVPN+mHoViO9YUVg21cOGaKQDa3/Wzw=
X-Gm-Gg: AYBFou16JKYVrcaCmVRo2Z9JN9AGQLlz7XCenBR8z0i8ol6POXkwTyHlyEgvwsj/IFS
 om8nxo3MSn75A2h37SjftjDc36INONAKH9DBA/TGjB9kKKZ8QjYOSRagWRWimV/Qow/E8n3hzGj
 HA/zlwU91E21kOTDj2z9+f3keiaQrTuguDxL/1e0HIOioqlqn3WlbGPwbBtSzyD5bmRHW1iuuRw
 if4K+walkFAOKTCX1NKnheMsEUSvGkL3yxPVkAxI2Q4Mpu8gdLF4PHp1AoJuYhfcHOPr4ESUxdK
 425RRrr4L0oOVGISc6shZR9KG+2EtUoB7uNn3djsKTuBvxp37xuWpCGTie3LtMv4YEGL5J52s1R
 yVjFPKgUuCVTcho5/EO9GBBP9x5Pf4w8sPpxZ
X-Received: by 2002:a05:6000:41c2:b0:48d:bae5:41c with SMTP id
 ffacd0b85a97d-48e1e7cc62bmr10931528f8f.17.1792568644123; Wed, 21 Oct 2026
 00:44:04 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: SKRVTN <skrvtn@gmail.com>
Date: Wed, 21 Oct 2026 16:43:52 +0900
X-Gm-Features: AclHuK8XOp7urVVvP4HvOFcCaNVehnSr3Zc6bn6QTTLBDKx-GxAgdB-QSpuEomk
Message-ID: <CAFGCxQsCJ9iEZc5ooASgR-898A_TfNANOe-2n-V1eMn+U3sxgg@mail.gmail.com>
Subject: [REGRESSION] amdgpu DCN 3.5: resume hard lockup with DMUB 0x09005300
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:53:26 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

I get hard lockups (a CPU spins in dmub_srv_wait_for_idle() with interrupts
disabled until the NMI watchdog panics) on a Krackan laptop, twice while
resuming from s2idle and once at runtime. They started after updating to
linux-firmware-amdgpu 20260916-1, which loads DMUB 0x09005300. With the two
previous firmware packages (DMUB 0x09004A00 and 0x09004E00) I had 100
suspend/resume cycles without a single failed resume.

I have not yet run an A/B test with the old blobs on the same kernel. I will
do that next and report back in this thread.


SYSTEM

  Machine   : Lenovo ThinkPad P14s Gen 7 AMD (21X0), BIOS R38ET26W (1.06)
  GPU       : AMD Krackan [Radeon 840M/860M], PCI 1002:1114, DCN 3.5
  Distro    : Arch-based, kernels 7.2.7 / 7.2.9 / 7.2.11 (Arch mainline
              build) and 6.18.52-lts
  Firmware  : linux-firmware-amdgpu 20260916-1
  Cmdline   : nmi_watchdog=panic softlockup_panic=1 panic=10
              (so a lockup becomes a panic that efi_pstore records)
  Peripheral: USB-C dock (Lenovo USB-C 7-in-1 hub, VIA Labs hubs
              17ef:7229 / 722a / 722c) attached in all three captures


STATISTICS FROM MY KERNEL LOGS (per boot, counted from "PM: suspend entry"
and "PM: suspend exit")

  DMUB version  Package          Suspends  Resumes that never completed
  0x09004A00    20260622-1       58        0
  0x09004E00    20260810-2       42        0
  0x09005300    20260916-1       57        6

  The 6 under 0x09005300 break down as:
    2  confirmed hard lockup in dm_resume() (captured, see below)
    1  failed suspend (tasks stuck in FUSE), probably unrelated
    3  unexplained (pstore was not enabled yet)
  In addition, one hard lockup at runtime (third trace below) happened
  5.1 hours after a normal resume, also with 0x09005300.

  Caveats: the first affected boots also changed the LTS kernel
  (6.18.47 -> 6.18.52) in the same upgrade, and I never ran a 7.2.x kernel
  with the older firmware. The failures occurred on 6.18.52-lts and on
  7.2.7, 7.2.9 and 7.2.11. dcn_3_5_dmcub.bin and dcn_3_5_1_dmcub.bin both
  differ between 20260810-2 and 20260916-1 (sha256 of the decompressed
  files).


CAPTURED PANICS (efi_pstore, "Kernel panic - not syncing: Hard LOCKUP")

Both resume cases: the lockup is reported 17.8 s and 19.8 s after
"PM: resume from suspend-to-idle"; "PM: resume of devices complete" never
appears. Workqueue: async async_run_entry_fn, RIP in delay_halt(),
EFLAGS 0x2.

1) 7.2.9-arch1-1, resume (lockup 17.8 s after resume):

  dmub_srv_wait_for_idle+0x5c/0xc0 [amdgpu]
  dc_dmub_srv_wait_for_idle+0x7d/0x1d0 [amdgpu]
  dm_execute_dmub_cmd+0x48/0x70 [amdgpu]
  transmitter_control_dmcub_v1_7+0x8a/0xb0 [amdgpu]
  transmitter_control_v1_7+0x2b3/0x3c0 [amdgpu]
  dcn10_link_encoder_enable_dp_output+0xcc/0x100 [amdgpu]
  enable_dio_dp_link_output+0x7d/0xb0 [amdgpu]
  dce110_enable_dp_link_output+0x27f/0x2c0 [amdgpu]
  dp_enable_link_phy+0x4a/0x90 [amdgpu]
  dp_verify_link_cap_with_retries+0x225/0x530 [amdgpu]
  link_detect+0x595/0x730 [amdgpu]
  ? dcn10_get_hpd_state+0x4d/0x80 [amdgpu]
  dm_resume+0x59c/0x950 [amdgpu]
  amdgpu_ip_block_resume+0x27/0x50 [amdgpu]
  amdgpu_device_ip_resume_phase3+0x6d/0x90 [amdgpu]
  amdgpu_device_resume+0xc0/0x370 [amdgpu]
  ? __pfx_pci_pm_resume+0x10/0x10
  ? pci_device_is_present+0x52/0x70
  amdgpu_pmops_resume+0x4f/0xa0 [amdgpu]
  ? __pfx_pci_pm_resume+0x10/0x10
  dpm_run_callback+0x62/0x190
  ? dpm_wait_for_superior+0x13d/0x1a0
  device_resume+0x19c/0x2a0
  async_resume+0x21/0x30
  async_run_entry_fn+0x36/0x160
  process_one_work+0x19f/0x370
  worker_thread+0x1b1/0x310
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xe4/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2a7/0x330
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30

2) 7.2.11-arch1-1, resume (lockup 19.8 s after resume):

  dmub_srv_wait_for_idle+0x5c/0xc0 [amdgpu]
  dc_dmub_srv_wait_for_idle+0x7d/0x1d0 [amdgpu]
  dm_execute_dmub_cmd+0x48/0x70 [amdgpu]
  transmitter_control_dmcub_v1_7+0x8a/0xb0 [amdgpu]
  transmitter_control_v1_7+0x2b3/0x3c0 [amdgpu]
  dcn10_link_encoder_enable_dp_output+0xcc/0x100 [amdgpu]
  enable_dio_dp_link_output+0x7d/0xb0 [amdgpu]
  dce110_enable_dp_link_output+0x27f/0x2c0 [amdgpu]
  dp_enable_link_phy+0x4a/0x90 [amdgpu]
  dp_verify_link_cap_with_retries+0x225/0x530 [amdgpu]
  link_detect+0x595/0x730 [amdgpu]
  ? dcn10_get_hpd_state+0x4d/0x80 [amdgpu]
  dm_resume+0x59c/0x950 [amdgpu]
  amdgpu_ip_block_resume+0x27/0x50 [amdgpu]
  amdgpu_device_ip_resume_phase3+0x6d/0x90 [amdgpu]
  amdgpu_device_resume+0xc0/0x370 [amdgpu]
  ? __pfx_pci_pm_resume+0x10/0x10
  ? pci_device_is_present+0x52/0x70
  amdgpu_pmops_resume+0x4f/0xa0 [amdgpu]
  ? __pfx_pci_pm_resume+0x10/0x10
  dpm_run_callback+0x62/0x190
  ? dpm_wait_for_superior+0x13d/0x1a0
  device_resume+0x19c/0x2a0
  async_resume+0x21/0x30
  async_run_entry_fn+0x36/0x160
  process_one_work+0x19f/0x370
  worker_thread+0x1b1/0x310
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xe4/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2a7/0x330
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30

3) 7.2.7-arch1-1, runtime, Workqueue events_unbound
dm_ism_sso_delayed_work_func:

  delay_halt+0x3f/0x70
  dmub_srv_wait_for_idle+0x5c/0xc0 [amdgpu]
  dc_dmub_srv_wait_for_idle+0x7d/0x1d0 [amdgpu]
  dm_execute_dmub_cmd+0x48/0x70 [amdgpu]
  dmub_replay_set_power_opt_and_coasting_vtotal+0xa9/0xd0 [amdgpu]
  edp_set_replay_power_opt_and_coasting_vtotal+0xb8/0x110 [amdgpu]
  mod_power_replay_set_power_opt_and_coasting_vtotal+0xe0/0x100 [amdgpu]
  mod_power_set_replay_event+0x331/0x7f0 [amdgpu]
  amdgpu_dm_replay_set_event+0xce/0xe0 [amdgpu]
  amdgpu_dm_crtc_set_static_screen_optimze+0x46/0x80 [amdgpu]
  dm_ism_commit_idle_optimization_state+0x5b/0x160 [amdgpu]
  amdgpu_dm_ism_commit_event+0xfe/0x710 [amdgpu]
  dm_ism_sso_delayed_work_func+0x35/0x40 [amdgpu]
  process_one_work+0x19f/0x370
  worker_thread+0x1b1/0x310
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xe4/0x120
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2a7/0x330
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30


RESUME TIMELINE (seconds after "PM: resume from suspend-to-idle")

                                     good resume   bad resume   bad resume
                                     (7.2.9)       (7.2.9)      (7.2.11)
  SMU is resumed successfully        +0.30         +0.30        +0.30
  xhci_hcd 0000:c6:00.4: Port        not logged    +0.357       +0.368
    resume timed out, port 7-1
  PM: resume of devices complete     +0.93         never        never
  Hard LOCKUP reported               -             +17.8        +19.8

  Port 7-1 on xhci_hcd 0000:c6:00.4 is the upstream hub of the dock. In the
  successful resumes of the same captures the dock hub only logs "usb 7-1.5:
  failed to resume async: error -5" and resume still completes. I do not
  know which DisplayPort connector link_detect() is working on when it
  hangs.


QUESTIONS

  1. Is DMUB 9.0.83 (0x09005300) for dcn_3_5_dmcub.bin / dcn_3_5_1_dmcub.bin
     a known problem? Several DMCUB updates were reverted upstream before.
  2. Is a revert or fixed firmware planned? I am happy to test.
  3. Should dmub_srv_wait_for_idle() be able to spin for well over
     10 s with interrupts disabled during dm_resume()? The hard lockup
     watchdog turns it into a panic here; without it the machine hangs.

I can send more of the captured logs on request. They contain no
credentials, I removed host, user and network information.

Thanks,
Guy
