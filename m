Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E15E83F05
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9FF610E8BD;
	Thu,  5 Feb 2026 14:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=yahoo.com header.i=@yahoo.com header.b="pQd42bhq";
	dkim-atps=neutral
Received: from sonic303-20.consmr.mail.ir2.yahoo.com
 (sonic303-20.consmr.mail.ir2.yahoo.com [77.238.178.201])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14AA10E678
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 14:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1770215963; bh=Hz8MMKe1TI6PfQj4CvN0FAs9ZDjhW6jwcqmFBwqbWGc=;
 h=Date:From:To:Subject:References:From:Subject:Reply-To;
 b=pQd42bhq/mhOweyGlGvGl2TrCpoPFsEv2ey9UYs8bX4PckOP3MD6i/IUrjLu+IOTDGZqu5uSscHq0dswjLLyCeC+DYBi3fg3VpEECJHKBrbMGPVgya6frXOaPbayvPxtkg1ncVbfBSVgBvby45gCzb6DdXH+Si+uIr0x92JWmlBfCEMtVgYaX1cmGHrPc9plcrVVPZzmLZEwed/FduTVzaVBPvM3kWvGaUlgOXvQyxJN47gSkebrrvELP4M2RGfDCR4rwGURBtU8yZrtLCRWDdYHXJekx8dXhQydY0h8ZEjGTDYII1VP6hU9Q2obkSmlia97eENhF0WYRlhyoWs+cw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1770215963; bh=WCs2rnPQl2KNWM0WGRTWnZayIK6wp1/l0q6i/Ty/470=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=bpZgBSDBIqcxEBkhb3PU2UN52LH+sOvGLfg2OSPSpwkKrwWf5Upn98r+4EYUBaLBpnfqXLK2v+p+RozxPQCiBxpWKPaDiM1Mwj8olpMLV6s6HUQdbZ/NV/lrluAAt7vMbZumByvHzJzq10IMinEPfircuFWF5Z1BOrc9XW4RaDpg+9Qx9KY1VdL4+xClMspNwSJSsAy+Sfq6M8njYcvzf4Qch+kZ3ydH1AWGzC2Y+01Z/Z8r2LQ3LBMo9y1ONX0UuZ4/VWC6iODtb2qIu0xFTVI3wq6MKNUQKx+8OIav3ae6ZTi97J1ztJcC/wivCYsCWiTIVkMPNSGqX0iaiq/JfQ==
X-YMail-OSG: xbbL..gVM1lU4YTpVz.NNHuqZ9In3vHrDrhSIvG43ERL1Syd61MKCt4_aLodR5e
 eZR6PmDpOREEkgUZtWXBplE5M.46lu5QGb0PzhblMUnXox94VXUXxiGrAOlfZUyNnEqRT5VubFIo
 UPAsYdVzXoCECtAgCIfsrPOjTIeEgTILIVOO9zXdBlZJBMuLXkgP3FhpigKvYUnvZfcELUh.GAoT
 MS2rxdbaFaZ1TtihXF5XuPa26NOhetGsAPi8M9Eko0q1dktOvKsjG_aiRWje9ZEZzcxdKEYfsY3S
 1v7iwuEbvmoOFqXJeH3FtedTFy0xCNRe84.SeSzOJ1q0qjVUZxmQrahLFu2L73hI4mX5XYOldWHS
 s8vSxz.oFc5mLpWH7fJgitdtH_OYBq8c8C3OpqXRorMubIU1IjQMYWgYOTYdiJFLt0YQoynMfmGj
 ORa3loRhfAL7F9KIvRIBQWdYqgkNJ34tuYtDxPRFjwxIgIXuJTGHYLo21825jgxmS3de7cuvs0Q8
 Q8Mu1yM6P3db2DFdSV__cdxwihq_FKAru7jic7bJQi_Cbq4HAu4BIyGXjD8TYq8EqQfI4CYoO3Dk
 sFxG4v3J9bAColnPrws2TGYmuZiA_1VMcUPcXgex44f6JsHyTy1VONgQ3kxCRtrp70jzSDRCeUAh
 G2GeqLqmnZbyFH_K1OG5AaLP_hsMpza_Sbc0AchwKEG9PoEpVISwMATd90nF.bU2kN1oliKEQaEs
 vHlNHTD9G.MIAMv40Y1QhkUg0SlXyyF4iJtmKpSRgTM5nBhnJigsf28eLKPQAYpILi9mKK0emVXS
 O_S1yEGSsqZohzSvb_Fce7mleaJ9Nm76F8o562EZMXhc1tlx60r8pbL9VqDGxyGE5rFyoKwD_qP4
 vfKbhnW76ORZ1OIOpdBdZV41u5RNwTXvoooO2wdktjSxv5cvMc8ir9RDXiqrvLlpWCVMc8c6_Tj4
 sPq72Xd19K8W5l3hSsus.PSSs1cv3z75zz7hNmdLpPjR2uGGz.YH5bo5iRT5lufbTxKAEOuW9FGy
 AdLmx10vn6Bc1y4ZefEFDctfIXLRpBw7cHLoR9y.CSyCESGBnBMwlSC0I.7GDCGE_UtteK1qGdH3
 wfyRWkv4jdwWEIIMo1YAVI0uqDd76sxoo2mKx9lUyJ7zIIjp5E_nP_nSki41XBG3S2zkr7ytFqSc
 2GDH6FdeErcuNDLMi9_Xqxt85L19oELjGfAZp0VOf.8coz0jOnTm83b0V9ytwWfAhpvTtsJaKvUg
 tuyq.UhArzcXBoil8qkrAMzxBW86Pz4ycdy6NMGzxv.kZbN1WWJwY.N3kCYCsOv51qjNOac5clXY
 dFxJwOpBC6ElrKNO8O15NxMGS1eMjE.fFyvts0Hg4Dvt8JsSPUfGqcjsiQbEcfTi2Jkt6WJCOwGN
 JSoKrgLlr0JOgZxSJap93oyfPHhuHkwPiKk8dTU9c7et3a6jorPbU9XFNNBlRYriJDEvuelOyU3D
 cY.TUKIdjxkUrA7mKpOLI28oET80TKPO643fQBd_e5IzUZuaKCAbF3_Y3ppqUteq84.fCeX3B8HL
 bsomHUVRMBe4lRDpLKT9RKC_Gaii.AIVttdURoYajD2fOUsXbFYAACOEdqt8dbo3ULlw_0tC2OKm
 1TdTBVfmG8dOpRUSp2rURkT.rZScJVzOd2Wg0Ut7CZLhq_XnCV4JURLewkg64g8C7sPAoklDwHiJ
 4mbIYy.8YSpGJXlZSYsPmJiIUP0ghp6FeDOlphdcqZB1CMCvvLjVSwzqgXMTOVU61UqTwt1FIOsj
 3ffILdZC0d668ceI0zl.wgeqFRD7VBaI5JWIKgew9VI9qnUmWy2r6roeKD0Oyd4KlGGntoXFwSED
 z8mHufjOKGkIyArtIyIvKcE3jHkzs8k0GzlTf.yuGHIN2uizegM6w5cI3IEU4HqSXtT8..YFry8j
 YlzA9JlZvsrk2RyPiVD4U6pjRHzHsR3s_sRWndZjQyOs9fJtOSuF21FEb5lYUhOXmpzc2uEg_wQz
 eEhw9ErVO9ewongJY.PocXDqNFJb_MSbhKjgUMjXv11lI2IaYmbehvitxIGVR8WJ.Ec2NRUHZ3P5
 j9bB6ziuZxrWrB50ttMlm0kf4miU_9rMIu2Jdoq.A.7ZzCJS6WcUJnamPOLqeQxfvlCiQwim2Q2d
 mzm1eA50HZD9lfPGngakcJBVrZ_WSOWBTFHbqI3qEztqDABnKPCS9kUVvhl73MJSsFunVzTbdEdd
 gX6K1ErJI7tc2cWswZe00_vhgNMu5CbYEmIg2lqL6H3mr2.aImgoOLC7cAF7p9A--
X-Sonic-MF: <fh9a4yhnjkw@yahoo.com>
X-Sonic-ID: 76331c25-bb2b-4e6a-99c1-32c638e9c2c7
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.ir2.yahoo.com with HTTP; Wed, 4 Feb 2026 14:39:23 +0000
Date: Wed, 4 Feb 2026 14:39:19 +0000 (UTC)
From: Tom <fh9a4yhnjkw@yahoo.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Message-ID: <317581465.519740.1770215959894@mail.yahoo.com>
Subject: UVD not responding, kiq_0.2.1.0 test failed on suspend
MIME-Version: 1.0
Content-Type: multipart/alternative; 
 boundary="----=_Part_519739_1133768246.1770215959880"
References: <317581465.519740.1770215959894.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.25116 YMailNovation
X-Mailman-Approved-At: Thu, 05 Feb 2026 14:01:18 +0000
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

------=_Part_519739_1133768246.1770215959880
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi
I try live boot of ubuntu 26.04 snapshot 3 (6.18.0-9) on dell inspiron 5576=
 with RX460 dGPU, everything seems ok, until i try to put system to sleep:(=
sleep/suspend worked fine on ubuntu 22.04 last time i checked and it works =
fine in windows)
[ =C2=A0593.187045] PM: suspend entry (deep)
[ =C2=A0593.187143] Filesystems sync: 0.000 seconds
[ =C2=A0593.191490] Freezing user space processes
[ =C2=A0593.193435] Freezing user space processes completed (elapsed 0.001 =
seconds)
[ =C2=A0593.193446] OOM killer disabled.
[ =C2=A0593.193447] Freezing remaining freezable tasks
[ =C2=A0593.194764] Freezing remaining freezable tasks completed (elapsed 0=
.001 seconds)
[ =C2=A0593.194816] printk: Suspending console(s) (use no_console_suspend t=
o debug)
[ =C2=A0593.323573] sd 1:0:0:0: [sda] Synchronizing SCSI cache
[ =C2=A0593.423009] ata1.00: Entering standby power mode
[ =C2=A0593.553102] [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF=
80000).
[ =C2=A0593.623444] psmouse serio1: Failed to disable mouse on isa0060/seri=
o1
[ =C2=A0594.733234] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, trying to reset the VCPU!!!
[ =C2=A0595.754613] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, trying to reset the VCPU!!!
[ =C2=A0596.775980] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, trying to reset the VCPU!!!
[ =C2=A0597.797336] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, trying to reset the VCPU!!!
[ =C2=A0598.818700] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, trying to reset the VCPU!!!
[ =C2=A0599.840060] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, trying to reset the VCPU!!!
[ =C2=A0600.861418] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, trying to reset the VCPU!!!
[ =C2=A0601.882800] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, trying to reset the VCPU!!!
[ =C2=A0602.904165] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, trying to reset the VCPU!!!
[ =C2=A0603.925523] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, trying to reset the VCPU!!!
[ =C2=A0603.946463] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respondin=
g, giving up!!!
[ =C2=A0603.947393] amdgpu 0000:03:00.0: amdgpu: set_powergating_state of I=
P block <uvd_v6_0> failed -1
[ =C2=A0604.217843] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdg=
pu]] *ERROR* ring uvd test failed (-110)
[ =C2=A0604.218768] amdgpu 0000:03:00.0: amdgpu: resume of IP block <uvd_v6=
_0> failed -110
[ =C2=A0604.218773] amdgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume fa=
iled (-110).
[ =C2=A0604.219420] ------------[ cut here ]------------
[ =C2=A0604.219425] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.220350] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.220426] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.220462] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.220467] Tainted: [P]=3DPROPRIETARY_MODULE, [O]=3DOOT_MODULE
[ =C2=A0604.220468] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.220470] Workqueue: async async_run_entry_fn
[ =C2=A0604.220476] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.221397] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.221400] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.221403] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000=
0000000000
[ =C2=A0604.221404] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.221405] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.221406] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.221407] R13: 0000000000000000 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.221409] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.221410] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.221411] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.221413] Call Trace:
[ =C2=A0604.221415] =C2=A0<TASK>
[ =C2=A0604.221420] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.222316] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.223208] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.224094] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.224979] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.224986] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.224989] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.224993] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.224996] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.224998] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.225001] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.225005] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.225007] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.225009] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.225012] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.225014] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.225017] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.225019] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.225022] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.225026] =C2=A0</TASK>
[ =C2=A0604.225027] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.225086] ------------[ cut here ]------------
[ =C2=A0604.225087] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.226002] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.226061] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.226094] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.226098] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.226099] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.226101] Workqueue: async async_run_entry_fn
[ =C2=A0604.226106] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.227029] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.227031] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.227034] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000=
0000000000
[ =C2=A0604.227035] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.227036] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.227037] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.227038] R13: 0000000000000002 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.227039] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.227041] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.227042] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.227043] Call Trace:
[ =C2=A0604.227044] =C2=A0<TASK>
[ =C2=A0604.227048] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.227939] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.228843] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.229731] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.230619] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.230624] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.230627] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.230631] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.230634] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.230636] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.230639] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.230642] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.230644] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.230646] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.230649] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.230651] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.230654] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.230656] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.230658] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.230662] =C2=A0</TASK>
[ =C2=A0604.230663] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.230720] ------------[ cut here ]------------
[ =C2=A0604.230721] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.231654] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.231714] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.231746] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.231751] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.231752] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.231753] Workqueue: async async_run_entry_fn
[ =C2=A0604.231759] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.232678] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.232681] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.232685] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000=
0000000000
[ =C2=A0604.232686] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.232687] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.232689] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.232690] R13: 0000000000000002 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.232691] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.232693] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.232695] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.232696] Call Trace:
[ =C2=A0604.232698] =C2=A0<TASK>
[ =C2=A0604.232702] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.233601] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.234506] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.235404] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.236275] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.236281] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.236283] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.236287] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.236290] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.236292] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.236295] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.236299] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.236301] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.236302] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.236305] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.236307] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.236310] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.236312] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.236315] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.236319] =C2=A0</TASK>
[ =C2=A0604.236320] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.236389] ------------[ cut here ]------------
[ =C2=A0604.236391] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.237301] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.237370] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.237404] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.237408] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.237409] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.237410] Workqueue: async async_run_entry_fn
[ =C2=A0604.237416] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.238328] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.238330] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.238332] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000=
0000000000
[ =C2=A0604.238333] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.238334] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.238335] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.238336] R13: 0000000000000002 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.238338] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.238339] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.238340] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.238342] Call Trace:
[ =C2=A0604.238343] =C2=A0<TASK>
[ =C2=A0604.238347] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.239247] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.240137] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.241032] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.241934] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.241940] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.241942] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.241946] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.241949] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.241951] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.241954] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.241958] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.241960] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.241961] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.241964] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.241966] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.241969] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.241972] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.241974] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.241978] =C2=A0</TASK>
[ =C2=A0604.241979] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.242037] ------------[ cut here ]------------
[ =C2=A0604.242038] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.242954] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.243013] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.243046] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.243050] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.243051] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.243052] Workqueue: async async_run_entry_fn
[ =C2=A0604.243058] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.243986] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.243988] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.243990] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000=
0000000000
[ =C2=A0604.243992] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.243993] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.243994] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.243995] R13: 0000000000000002 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.243996] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.243997] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.243998] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.244000] Call Trace:
[ =C2=A0604.244001] =C2=A0<TASK>
[ =C2=A0604.244005] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.244899] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.245788] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.246685] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.247577] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.247582] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.247585] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.247589] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.247592] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.247594] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.247598] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.247601] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.247603] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.247604] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.247607] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.247610] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.247612] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.247615] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.247617] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.247621] =C2=A0</TASK>
[ =C2=A0604.247622] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.247680] ------------[ cut here ]------------
[ =C2=A0604.247681] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.248598] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.248658] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.248691] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.248695] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.248696] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.248697] Workqueue: async async_run_entry_fn
[ =C2=A0604.248702] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.249627] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.249629] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.249632] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000=
0000000000
[ =C2=A0604.249633] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.249634] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.249635] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.249636] R13: 0000000000000002 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.249638] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.249639] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.249640] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.249642] Call Trace:
[ =C2=A0604.249643] =C2=A0<TASK>
[ =C2=A0604.249647] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.250538] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.251444] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.252318] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.253208] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.253215] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.253218] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.253222] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.253224] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.253227] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.253230] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.253233] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.253235] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.253237] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.253240] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.253242] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.253245] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.253248] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.253250] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.253254] =C2=A0</TASK>
[ =C2=A0604.253255] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.253313] ------------[ cut here ]------------
[ =C2=A0604.253313] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.254240] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.254299] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.254332] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.254336] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.254337] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.254339] Workqueue: async async_run_entry_fn
[ =C2=A0604.254344] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.255268] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.255271] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.255274] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000=
0000000000
[ =C2=A0604.255275] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.255276] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.255278] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.255279] R13: 0000000000000002 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.255280] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.255281] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.255282] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.255284] Call Trace:
[ =C2=A0604.255285] =C2=A0<TASK>
[ =C2=A0604.255289] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.256183] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.257090] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.257988] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.258877] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.258884] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.258887] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.258891] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.258893] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.258895] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.258899] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.258902] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.258904] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.258906] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.258908] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.258911] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.258913] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.258916] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.258918] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.258922] =C2=A0</TASK>
[ =C2=A0604.258923] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.258981] ------------[ cut here ]------------
[ =C2=A0604.258982] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.259903] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.259962] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.259995] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.259999] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.259999] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.260001] Workqueue: async async_run_entry_fn
[ =C2=A0604.260006] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.260922] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.260925] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.260928] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000=
0000000000
[ =C2=A0604.260929] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.260930] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.260931] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.260932] R13: 0000000000000002 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.260934] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.260935] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.260936] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.260938] Call Trace:
[ =C2=A0604.260939] =C2=A0<TASK>
[ =C2=A0604.260943] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.261840] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.262729] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.263628] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.264519] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.264525] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.264528] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.264532] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.264535] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.264537] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.264541] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.264544] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.264546] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.264548] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.264551] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.264553] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.264556] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.264558] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.264561] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.264565] =C2=A0</TASK>
[ =C2=A0604.264566] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.264618] ------------[ cut here ]------------
[ =C2=A0604.264619] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.265538] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.265598] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.265631] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.265635] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.265636] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.265638] Workqueue: async async_run_entry_fn
[ =C2=A0604.265643] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.266566] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.266569] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.266571] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 000000=
0000000000
[ =C2=A0604.266573] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.266574] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.266575] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.266576] R13: 0000000000000002 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.266577] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.266578] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.266580] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.266581] Call Trace:
[ =C2=A0604.266583] =C2=A0<TASK>
[ =C2=A0604.266586] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.267483] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.268375] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.269253] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.270146] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.270152] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.270155] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.270159] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.270161] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.270163] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.270167] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.270170] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.270172] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.270173] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.270176] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.270179] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.270181] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.270184] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.270186] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.270191] =C2=A0</TASK>
[ =C2=A0604.270192] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.270242] ------------[ cut here ]------------
[ =C2=A0604.270243] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.271162] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.271222] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.271255] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.271260] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.271260] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.271262] Workqueue: async async_run_entry_fn
[ =C2=A0604.271267] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.272177] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.272180] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.272182] RAX: 0000000000000000 RBX: ffff8edc1d6ad440 RCX: 000000=
0000000000
[ =C2=A0604.272184] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.272185] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.272186] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.272187] R13: 0000000000000000 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.272188] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.272189] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.272190] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.272192] Call Trace:
[ =C2=A0604.272193] =C2=A0<TASK>
[ =C2=A0604.272197] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.273091] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.273992] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.274885] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.275774] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.275780] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.275782] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.275786] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.275789] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.275791] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.275794] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.275798] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.275799] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.275801] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.275804] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.275807] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.275809] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.275812] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.275814] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.275818] =C2=A0</TASK>
[ =C2=A0604.275819] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.275870] ------------[ cut here ]------------
[ =C2=A0604.275871] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.276783] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.276844] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.276877] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.276881] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.276882] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.276883] Workqueue: async async_run_entry_fn
[ =C2=A0604.276889] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.277807] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.277810] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.277812] RAX: 0000000000000000 RBX: ffff8edc1d6ad440 RCX: 000000=
0000000000
[ =C2=A0604.277814] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.277815] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.277816] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.277817] R13: 0000000000000001 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.277818] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.277819] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.277820] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.277822] Call Trace:
[ =C2=A0604.277823] =C2=A0<TASK>
[ =C2=A0604.277827] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.278729] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.279624] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.280518] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.281407] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.281412] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.281415] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.281419] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.281421] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.281423] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.281427] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.281430] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.281432] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.281434] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.281437] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.281439] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.281442] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.281444] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.281446] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.281451] =C2=A0</TASK>
[ =C2=A0604.281452] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.281510] ------------[ cut here ]------------
[ =C2=A0604.281511] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.282435] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.282494] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.282527] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.282532] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.282533] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.282534] Workqueue: async async_run_entry_fn
[ =C2=A0604.282540] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.283454] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.283456] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.283459] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX: 000000=
0000000000
[ =C2=A0604.283460] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.283461] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.283462] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.283463] R13: 0000000000000000 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.283464] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.283465] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.283467] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.283468] Call Trace:
[ =C2=A0604.283469] =C2=A0<TASK>
[ =C2=A0604.283473] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.284377] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.285266] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.286158] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.287044] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.287051] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.287054] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.287058] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.287061] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.287063] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.287066] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.287070] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.287071] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.287073] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.287076] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.287079] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.287081] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.287084] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.287086] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.287090] =C2=A0</TASK>
[ =C2=A0604.287091] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.287150] ------------[ cut here ]------------
[ =C2=A0604.287151] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.288065] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.288124] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.288157] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.288161] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.288162] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.288163] Workqueue: async async_run_entry_fn
[ =C2=A0604.288168] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.289092] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.289095] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.289097] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX: 000000=
0000000000
[ =C2=A0604.289099] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.289100] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.289101] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.289102] R13: 0000000000000000 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.289104] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.289105] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.289106] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.289108] Call Trace:
[ =C2=A0604.289109] =C2=A0<TASK>
[ =C2=A0604.289113] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.290008] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.290898] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.291804] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.292693] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.292700] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.292703] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.292707] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.292710] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.292712] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.292715] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.292718] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.292720] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.292722] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.292725] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.292727] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.292730] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.292732] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.292735] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.292739] =C2=A0</TASK>
[ =C2=A0604.292740] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.292797] ------------[ cut here ]------------
[ =C2=A0604.292798] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.293717] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.293776] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.293809] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.293813] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.293814] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.293816] Workqueue: async async_run_entry_fn
[ =C2=A0604.293821] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.294743] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.294746] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.294749] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX: 000000=
0000000000
[ =C2=A0604.294750] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.294751] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.294752] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.294753] R13: 0000000000000000 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.294754] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.294756] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.294757] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.294758] Call Trace:
[ =C2=A0604.294759] =C2=A0<TASK>
[ =C2=A0604.294763] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.295655] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.296554] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.297444] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.298317] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.298321] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.298324] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.298328] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.298331] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.298333] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.298336] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.298339] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.298341] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.298343] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.298346] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.298349] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.298351] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.298353] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.298366] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.298372] =C2=A0</TASK>
[ =C2=A0604.298373] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.298431] ------------[ cut here ]------------
[ =C2=A0604.298432] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.299345] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.299415] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.299448] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.299452] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.299453] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.299454] Workqueue: async async_run_entry_fn
[ =C2=A0604.299459] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.300382] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.300385] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.300388] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RCX: 000000=
0000000000
[ =C2=A0604.300389] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.300390] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.300392] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.300393] R13: 0000000000000000 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.300394] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.300395] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.300396] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.300398] Call Trace:
[ =C2=A0604.300399] =C2=A0<TASK>
[ =C2=A0604.300403] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.301294] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.302194] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.303113] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.304092] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.304098] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.304100] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.304104] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.304107] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.304109] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.304112] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.304116] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.304117] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.304119] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.304122] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.304125] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.304127] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.304130] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.304132] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.304137] =C2=A0</TASK>
[ =C2=A0604.304138] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.304195] ------------[ cut here ]------------
[ =C2=A0604.304196] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.305131] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.305192] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.305227] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.305231] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.305232] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.305233] Workqueue: async async_run_entry_fn
[ =C2=A0604.305239] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.306233] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.306236] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.306238] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RCX: 000000=
0000000000
[ =C2=A0604.306240] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.306241] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.306242] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.306243] R13: 0000000000000000 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.306244] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.306245] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.306246] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.306248] Call Trace:
[ =C2=A0604.306249] =C2=A0<TASK>
[ =C2=A0604.306253] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.307150] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.308044] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.308934] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.309814] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.309819] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.309822] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.309826] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.309828] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.309830] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.309834] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.309837] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.309839] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.309841] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.309844] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.309846] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.309848] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.309851] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.309853] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.309858] =C2=A0</TASK>
[ =C2=A0604.309859] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.309916] ------------[ cut here ]------------
[ =C2=A0604.309917] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.310833] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.310893] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.310926] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.310930] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.310931] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.310932] Workqueue: async async_run_entry_fn
[ =C2=A0604.310937] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.311850] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.311853] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246
[ =C2=A0604.311855] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RCX: 000000=
0000000000
[ =C2=A0604.311856] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.311857] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.311858] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.311859] R13: 0000000000000000 R14: 0000000000000002 R15: 000000=
0000000000
[ =C2=A0604.311860] FS: =C2=A00000000000000000(0000) GS:ffff8edf19670000(00=
00) knlGS:0000000000000000
[ =C2=A0604.311862] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.311863] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.311864] Call Trace:
[ =C2=A0604.311866] =C2=A0<TASK>
[ =C2=A0604.311869] =C2=A0amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]
[ =C2=A0604.312766] =C2=A0? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]
[ =C2=A0604.313662] =C2=A0amdgpu_device_suspend+0x10a/0x170 [amdgpu]
[ =C2=A0604.314562] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.315452] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.315457] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.315460] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.315464] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.315466] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.315468] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.315472] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.315475] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.315477] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.315478] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.315481] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.315483] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.315486] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.315489] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.315491] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.315495] =C2=A0</TASK>
[ =C2=A0604.315497] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.330697] ------------[ cut here ]------------
[ =C2=A0604.330700] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.331627] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.331689] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.331725] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.331730] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.331730] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.331732] Workqueue: async async_run_entry_fn
[ =C2=A0604.331739] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.332660] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.332662] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
[ =C2=A0604.332665] RAX: 0000000000000000 RBX: ffff8edc1d6a5a38 RCX: 000000=
0000000000
[ =C2=A0604.332666] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.332667] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.332668] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.332669] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8e=
dc1d680000
[ =C2=A0604.332671] FS: =C2=A00000000000000000(0000) GS:ffff8edf196f0000(00=
00) knlGS:0000000000000000
[ =C2=A0604.332672] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.332673] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.332675] Call Trace:
[ =C2=A0604.332676] =C2=A0<TASK>
[ =C2=A0604.332681] =C2=A0gfx_v8_0_hw_fini+0x2a/0x3a0 [amdgpu]
[ =C2=A0604.333595] =C2=A0gfx_v8_0_suspend+0xe/0x20 [amdgpu]
[ =C2=A0604.334511] =C2=A0amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
[ =C2=A0604.335403] =C2=A0amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdg=
pu]
[ =C2=A0604.336277] =C2=A0amdgpu_device_suspend+0x113/0x170 [amdgpu]
[ =C2=A0604.337160] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.338049] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.338054] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.338056] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.338060] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.338063] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.338065] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.338069] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.338072] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.338074] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.338075] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.338078] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.338081] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.338083] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.338086] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.338088] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.338092] =C2=A0</TASK>
[ =C2=A0604.338093] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.338150] ------------[ cut here ]------------
[ =C2=A0604.338151] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.339074] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.339132] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.339165] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.339169] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.339170] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.339171] Workqueue: async async_run_entry_fn
[ =C2=A0604.339176] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.340096] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.340098] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
[ =C2=A0604.340101] RAX: 0000000000000000 RBX: ffff8edc1d6a5a50 RCX: 000000=
0000000000
[ =C2=A0604.340102] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.340103] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.340104] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.340105] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8e=
dc1d680000
[ =C2=A0604.340106] FS: =C2=A00000000000000000(0000) GS:ffff8edf196f0000(00=
00) knlGS:0000000000000000
[ =C2=A0604.340108] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.340109] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.340111] Call Trace:
[ =C2=A0604.340112] =C2=A0<TASK>
[ =C2=A0604.340115] =C2=A0gfx_v8_0_hw_fini+0x3b/0x3a0 [amdgpu]
[ =C2=A0604.341033] =C2=A0gfx_v8_0_suspend+0xe/0x20 [amdgpu]
[ =C2=A0604.341948] =C2=A0amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
[ =C2=A0604.342836] =C2=A0amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdg=
pu]
[ =C2=A0604.343723] =C2=A0amdgpu_device_suspend+0x113/0x170 [amdgpu]
[ =C2=A0604.344619] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.345520] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.345526] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.345529] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.345533] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.345535] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.345538] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.345541] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.345545] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.345546] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.345548] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.345551] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.345553] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.345556] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.345558] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.345561] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.345565] =C2=A0</TASK>
[ =C2=A0604.345566] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.345618] ------------[ cut here ]------------
[ =C2=A0604.345619] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.346540] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.346598] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.346631] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.346636] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.346636] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.346638] Workqueue: async async_run_entry_fn
[ =C2=A0604.346643] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.347566] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.347568] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
[ =C2=A0604.347571] RAX: 0000000000000000 RBX: ffff8edc1d6a5a80 RCX: 000000=
0000000000
[ =C2=A0604.347572] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.347573] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.347574] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.347575] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8e=
dc1d680000
[ =C2=A0604.347577] FS: =C2=A00000000000000000(0000) GS:ffff8edf196f0000(00=
00) knlGS:0000000000000000
[ =C2=A0604.347578] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.347579] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.347581] Call Trace:
[ =C2=A0604.347582] =C2=A0<TASK>
[ =C2=A0604.347586] =C2=A0gfx_v8_0_hw_fini+0x4c/0x3a0 [amdgpu]
[ =C2=A0604.348508] =C2=A0gfx_v8_0_suspend+0xe/0x20 [amdgpu]
[ =C2=A0604.349417] =C2=A0amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
[ =C2=A0604.350300] =C2=A0amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdg=
pu]
[ =C2=A0604.351188] =C2=A0amdgpu_device_suspend+0x113/0x170 [amdgpu]
[ =C2=A0604.352081] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.352969] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.352975] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.352977] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.352981] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.352984] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.352986] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.352989] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.352993] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.352994] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.352996] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.352999] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.353002] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.353004] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.353007] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.353009] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.353013] =C2=A0</TASK>
[ =C2=A0604.353014] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.353064] ------------[ cut here ]------------
[ =C2=A0604.353064] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.353984] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0604.354042] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0604.354074] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0604.354078] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0604.354079] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0604.354081] Workqueue: async async_run_entry_fn
[ =C2=A0604.354086] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0604.355008] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0604.355010] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246
[ =C2=A0604.355013] RAX: 0000000000000000 RBX: ffff8edc1d6a5a98 RCX: 000000=
0000000000
[ =C2=A0604.355014] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0604.355015] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0604.355016] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0604.355017] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8e=
dc1d680000
[ =C2=A0604.355018] FS: =C2=A00000000000000000(0000) GS:ffff8edf196f0000(00=
00) knlGS:0000000000000000
[ =C2=A0604.355019] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0604.355021] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0604.355022] Call Trace:
[ =C2=A0604.355023] =C2=A0<TASK>
[ =C2=A0604.355027] =C2=A0gfx_v8_0_hw_fini+0x5d/0x3a0 [amdgpu]
[ =C2=A0604.355934] =C2=A0gfx_v8_0_suspend+0xe/0x20 [amdgpu]
[ =C2=A0604.356852] =C2=A0amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
[ =C2=A0604.357726] =C2=A0amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdg=
pu]
[ =C2=A0604.358609] =C2=A0amdgpu_device_suspend+0x113/0x170 [amdgpu]
[ =C2=A0604.359499] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0604.360391] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0604.360396] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0604.360399] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0604.360403] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0604.360405] =C2=A0async_suspend+0x21/0x40
[ =C2=A0604.360408] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0604.360411] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0604.360415] =C2=A0worker_thread+0x317/0x450
[ =C2=A0604.360416] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0604.360418] =C2=A0kthread+0x10b/0x220
[ =C2=A0604.360421] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0604.360424] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.360426] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0604.360429] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0604.360431] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0604.360435] =C2=A0</TASK>
[ =C2=A0604.360436] ---[ end trace 0000000000000000 ]---
[ =C2=A0604.600867] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdg=
pu]] *ERROR* ring kiq_0.2.1.0 test failed (-110)
[ =C2=A0604.601775] [drm:gfx_v8_0_hw_fini [amdgpu]] *ERROR* KCQ disable fai=
led
[ =C2=A0604.837747] amdgpu: cp is busy, skip halt cp
[ =C2=A0605.072838] amdgpu: rlc is busy, skip halt rlc
[ =C2=A0605.073900] ------------[ cut here ]------------
[ =C2=A0605.073901] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu=
/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0605.074834] Modules linked in: btrfs blake2b_generic ufs qnx4 hfspl=
us hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer =
qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) =
amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component =
snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_=
intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hw=
dep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_even=
t ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp m=
ac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm d=
rm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device s=
nd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 =
platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstic=
k dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp=
 dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn
[ =C2=A0605.074894] =C2=A0joydev input_leds mac_hid sch_fq_codel ppdev lp m=
sr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_is=
o8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor as=
ync_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_=
sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb gha=
sh_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci ua=
s usb_storage aesni_intel
[ =C2=A0605.074929] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0W =C2=A0O =C2=A0 =C2=A0 =C2=A0 =C2=A06.18.0-9-g=
eneric #9-Ubuntu PREEMPT(voluntary)
[ =C2=A0605.074934] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOO=
T_MODULE
[ =C2=A0605.074935] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0=
.7 01/29/2018
[ =C2=A0605.074936] Workqueue: async async_run_entry_fn
[ =C2=A0605.074942] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]
[ =C2=A0605.075902] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 <0f> 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f
[ =C2=A0605.075904] RSP: 0018:ffffd4e34aa37c50 EFLAGS: 00010246
[ =C2=A0605.075907] RAX: 0000000000000000 RBX: ffff8edc1d680c70 RCX: 000000=
0000000000
[ =C2=A0605.075908] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000=
0000000000
[ =C2=A0605.075909] RBP: ffffd4e34aa37c70 R08: 0000000000000000 R09: 000000=
0000000000
[ =C2=A0605.075910] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000
[ =C2=A0605.075911] R13: 0000000000000000 R14: ffff8edc1d6d0d58 R15: ffff8e=
dc1d680000
[ =C2=A0605.075913] FS: =C2=A00000000000000000(0000) GS:ffff8edf196f0000(00=
00) knlGS:0000000000000000
[ =C2=A0605.075914] CS: =C2=A00010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ =C2=A0605.075915] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 000000=
00001506f0
[ =C2=A0605.075917] Call Trace:
[ =C2=A0605.075918] =C2=A0<TASK>
[ =C2=A0605.075919] =C2=A0? delay_halt.part.0+0x3e/0x70
[ =C2=A0605.075927] =C2=A0gmc_v8_0_hw_fini+0x1f/0xb0 [amdgpu]
[ =C2=A0605.076856] =C2=A0gmc_v8_0_suspend+0xe/0x20 [amdgpu]
[ =C2=A0605.077781] =C2=A0amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]
[ =C2=A0605.078676] =C2=A0amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdg=
pu]
[ =C2=A0605.079560] =C2=A0amdgpu_device_suspend+0x113/0x170 [amdgpu]
[ =C2=A0605.080438] =C2=A0amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]
[ =C2=A0605.081318] =C2=A0pci_pm_suspend+0x85/0x1b0
[ =C2=A0605.081323] =C2=A0? __pfx_pci_pm_suspend+0x10/0x10
[ =C2=A0605.081326] =C2=A0dpm_run_callback+0x5f/0x160
[ =C2=A0605.081330] =C2=A0device_suspend+0x1e4/0x4e0
[ =C2=A0605.081332] =C2=A0async_suspend+0x21/0x40
[ =C2=A0605.081335] =C2=A0async_run_entry_fn+0x33/0x130
[ =C2=A0605.081339] =C2=A0process_one_work+0x18e/0x370
[ =C2=A0605.081342] =C2=A0worker_thread+0x317/0x450
[ =C2=A0605.081344] =C2=A0? __pfx_worker_thread+0x10/0x10
[ =C2=A0605.081345] =C2=A0kthread+0x10b/0x220
[ =C2=A0605.081348] =C2=A0? recalc_sigpending+0x76/0xb0
[ =C2=A0605.081351] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0605.081353] =C2=A0ret_from_fork+0x134/0x150
[ =C2=A0605.081368] =C2=A0? __pfx_kthread+0x10/0x10
[ =C2=A0605.081371] =C2=A0ret_from_fork_asm+0x1a/0x30
[ =C2=A0605.081375] =C2=A0</TASK>
[ =C2=A0605.081376] ---[ end trace 0000000000000000 ]---
[ =C2=A0605.083479] amdgpu 0000:03:00.0: amdgpu: PCI CONFIG reset
[ =C2=A0605.083699] ACPI: EC: interrupt blocked
[ =C2=A0605.109649] ACPI: PM: Preparing to enter system sleep state S3
[ =C2=A0605.435280] ACPI Warning: Time parameter 120 us > 100 us violating =
ACPI spec, please fix the firmware. (20250807/exsystem-142)
[ =C2=A0605.436113] ACPI: EC: event blocked
[ =C2=A0605.436114] ACPI: EC: EC stopped
[ =C2=A0605.436115] ACPI: PM: Saving platform NVS memory
[ =C2=A0605.436214] Disabling non-boot CPUs ...
[ =C2=A0605.438631] smpboot: CPU 3 is now offline
[ =C2=A0605.442252] smpboot: CPU 2 is now offline
[ =C2=A0605.445111] smpboot: CPU 1 is now offline
[ =C2=A0605.447033] ACPI: PM: Low-level resume complete
[ =C2=A0605.447067] ACPI: EC: EC started
[ =C2=A0605.447069] ACPI: PM: Restoring platform NVS memory
[ =C2=A0605.447227] AMD-Vi: Virtual APIC enabled
[ =C2=A0605.447251] AMD-Vi: Virtual APIC enabled
[ =C2=A0605.447254] LVT offset 0 assigned for vector 0x400
[ =C2=A0605.447757] Enabling non-boot CPUs ...
[ =C2=A0605.447830] smpboot: Booting Node 0 Processor 1 APIC 0x11
[ =C2=A0605.451533] CPU1 is up
[ =C2=A0605.451598] smpboot: Booting Node 0 Processor 2 APIC 0x12
[ =C2=A0605.455447] CPU2 is up
[ =C2=A0605.455507] smpboot: Booting Node 0 Processor 3 APIC 0x13
[ =C2=A0605.459382] CPU3 is up
[ =C2=A0605.460791] ACPI: PM: Waking up from system sleep state S3
[ =C2=A0605.512016] ACPI: EC: interrupt unblocked
[ =C2=A0605.518861] [drm] PCIE GART of 1024M enabled (table at 0x000000F400=
A00000).
[ =C2=A0605.518874] ACPI: EC: event unblocked
[ =C2=A0605.518899] amdgpu: smu version 27.17.00
[ =C2=A0605.536571] [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF=
80000).
[ =C2=A0605.551074] [drm] UVD initialized successfully.
[ =C2=A0605.718769] [drm] UVD and UVD ENC initialized successfully.
[ =C2=A0605.752031] [drm] VCE initialized successfully.
[ =C2=A0605.763611] usb 1-2: reset high-speed USB device number 2 using xhc=
i_hcd
[ =C2=A0605.773339] usb 2-1.4: reset high-speed USB device number 4 using e=
hci-pci
[ =C2=A0605.819760] [drm] VCE initialized successfully.
[ =C2=A0605.939506] usb 2-1.2: reset full-speed USB device number 3 using e=
hci-pci
[ =C2=A0605.984372] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ =C2=A0605.986837] sd 1:0:0:0: [sda] Starting disk
[ =C2=A0605.990324] ata1.00: configured for UDMA/133
[ =C2=A0606.034393] OOM killer enabled.
[ =C2=A0606.034400] Restarting tasks: Starting
[ =C2=A0606.036871] Restarting tasks: Done
[ =C2=A0606.036937] random: crng reseeded on system resumption
[ =C2=A0606.037313] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_=
00000302.bin
[ =C2=A0606.037348] Bluetooth: hci0: QCA: patch rome 0x302 build 0x3e8, fir=
mware rome 0x302 build 0x111
[ =C2=A0606.049086] PM: suspend exit
[ =C2=A0606.325705] Generic FE-GE Realtek PHY r8169-0-200:00: attached PHY =
driver (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
[ =C2=A0606.403987] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.b=
in
[ =C2=A0606.426895] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connect=
ion command is advertised, but not supported.
[ =C2=A0606.481379] r8169 0000:02:00.0 enp2s0: Link is Down
[ =C2=A0606.673801] Bluetooth: MGMT ver 1.23
[ =C2=A0606.684146] kauditd_printk_skb: 6 callbacks suppressed
[ =C2=A0606.684153] audit: type=3D1400 audit(1770175422.234:141): apparmor=
=3D"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.u=
buntu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6784 comm=3D"pvs=
can" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=
=3D0 ouid=3D0 olabel=3D"unconfined"
[ =C2=A0606.684159] audit: type=3D1400 audit(1770175422.234:142): apparmor=
=3D"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.u=
buntu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6784 comm=3D"pvs=
can" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=
=3D0 ouid=3D0 olabel=3D"unconfined"
[ =C2=A0606.684162] audit: type=3D1400 audit(1770175422.234:143): apparmor=
=3D"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.u=
buntu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6784 comm=3D"pvs=
can" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=
=3D0 ouid=3D0 olabel=3D"unconfined"
[ =C2=A0606.684165] audit: type=3D1400 audit(1770175422.234:144): apparmor=
=3D"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.u=
buntu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6784 comm=3D"pvs=
can" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=
=3D0 ouid=3D0 olabel=3D"unconfined"
[ =C2=A0606.763476] audit: type=3D1400 audit(1770175422.314:145): apparmor=
=3D"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.u=
buntu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6789 comm=3D"vgs=
can" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=
=3D0 ouid=3D0 olabel=3D"unconfined"
[ =C2=A0606.763489] audit: type=3D1400 audit(1770175422.314:146): apparmor=
=3D"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.u=
buntu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6789 comm=3D"vgs=
can" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=
=3D0 ouid=3D0 olabel=3D"unconfined"
[ =C2=A0606.763492] audit: type=3D1400 audit(1770175422.314:147): apparmor=
=3D"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.u=
buntu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6789 comm=3D"vgs=
can" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=
=3D0 ouid=3D0 olabel=3D"unconfined"
[ =C2=A0606.763494] audit: type=3D1400 audit(1770175422.314:148): apparmor=
=3D"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.u=
buntu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6789 comm=3D"vgs=
can" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=
=3D0 ouid=3D0 olabel=3D"unconfined"
[ =C2=A0606.857207] audit: type=3D1400 audit(1770175422.407:149): apparmor=
=3D"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.u=
buntu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6790 comm=3D"vgc=
hange" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsui=
d=3D0 ouid=3D0 olabel=3D"unconfined"
[ =C2=A0606.857221] audit: type=3D1400 audit(1770175422.407:150): apparmor=
=3D"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.u=
buntu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6790 comm=3D"vgc=
hange" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsui=
d=3D0 ouid=3D0 olabel=3D"unconfined"
ubuntu@ubuntu:~$


------=_Part_519739_1133768246.1770215959880
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div class=3D"yahoo-style-wrap" style=3D"font-fami=
ly:Helvetica Neue, Helvetica, Arial, sans-serif;font-size:13px;"><div><div>=
<div class=3D"ydp35a41134gs" style=3D"margin: 0px; min-width: 0px; padding:=
 0px 0px 20px; width: auto; color: rgb(34, 34, 34); font-family: &quot;Goog=
le Sans&quot;, Roboto, RobotoDraft, Helvetica, Arial, sans-serif; font-size=
: medium; background-color: rgb(255, 255, 255);"><div><div class=3D"ydp35a4=
1134ii ydp35a41134gt" style=3D"direction: ltr; margin: 8px 0px 0px; padding=
: 0px; position: relative;"><div class=3D"ydp35a41134a3s ydp35a41134aiL" st=
yle=3D"direction: ltr; font-stretch: normal; font-size: small; line-height:=
 1.5; font-family: Arial, Helvetica, sans-serif; position: relative;"><div =
id=3D"ydp35a41134avWBGd-82"><div dir=3D"ltr">Hi<div><br></div><div>I try li=
ve boot of ubuntu 26.04 snapshot 3 (6.18.0-9) on dell inspiron 5576 with RX=
460 dGPU, everything seems ok, until i try to put system to sleep:</div><di=
v>(sleep/suspend worked fine on ubuntu 22.04 last time i checked and it wor=
ks fine in windows)</div><div><br></div><div>[ &nbsp;593.187045] PM: suspen=
d entry (deep)<br>[ &nbsp;593.187143] Filesystems sync: 0.000 seconds<br>[ =
&nbsp;593.191490] Freezing user space processes<br>[ &nbsp;593.193435] Free=
zing user space processes completed (elapsed 0.001 seconds)<br>[ &nbsp;593.=
193446] OOM killer disabled.<br>[ &nbsp;593.193447] Freezing remaining free=
zable tasks<br>[ &nbsp;593.194764] Freezing remaining freezable tasks compl=
eted (elapsed 0.001 seconds)<br>[ &nbsp;593.194816] printk: Suspending cons=
ole(s) (use no_console_suspend to debug)<br>[ &nbsp;593.323573] sd 1:0:0:0:=
 [sda] Synchronizing SCSI cache<br>[ &nbsp;593.423009] ata1.00: Entering st=
andby power mode<br>[ &nbsp;593.553102] [drm] PCIE GART of 256M enabled (ta=
ble at 0x000000F4FFF80000).<br>[ &nbsp;593.623444] psmouse serio1: Failed t=
o disable mouse on isa0060/serio1<br>[ &nbsp;594.733234] [drm:uvd_v6_0_star=
t [amdgpu]] *ERROR* UVD not responding, trying to reset the VCPU!!!<br>[ &n=
bsp;595.754613] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, t=
rying to reset the VCPU!!!<br>[ &nbsp;596.775980] [drm:uvd_v6_0_start [amdg=
pu]] *ERROR* UVD not responding, trying to reset the VCPU!!!<br>[ &nbsp;597=
.797336] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, trying t=
o reset the VCPU!!!<br>[ &nbsp;598.818700] [drm:uvd_v6_0_start [amdgpu]] *E=
RROR* UVD not responding, trying to reset the VCPU!!!<br>[ &nbsp;599.840060=
] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, trying to reset=
 the VCPU!!!<br>[ &nbsp;600.861418] [drm:uvd_v6_0_start [amdgpu]] *ERROR* U=
VD not responding, trying to reset the VCPU!!!<br>[ &nbsp;601.882800] [drm:=
uvd_v6_0_start [amdgpu]] *ERROR* UVD not responding, trying to reset the VC=
PU!!!<br>[ &nbsp;602.904165] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not =
responding, trying to reset the VCPU!!!<br>[ &nbsp;603.925523] [drm:uvd_v6_=
0_start [amdgpu]] *ERROR* UVD not responding, trying to reset the VCPU!!!<b=
r>[ &nbsp;603.946463] [drm:uvd_v6_0_start [amdgpu]] *ERROR* UVD not respond=
ing, giving up!!!<br>[ &nbsp;603.947393] amdgpu 0000:03:00.0: amdgpu: set_p=
owergating_state of IP block &lt;uvd_v6_0&gt; failed -1<br>[ &nbsp;604.2178=
43] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* rin=
g uvd test failed (-110)<br>[ &nbsp;604.218768] amdgpu 0000:03:00.0: amdgpu=
: resume of IP block &lt;uvd_v6_0&gt; failed -110<br>[ &nbsp;604.218773] am=
dgpu 0000:03:00.0: amdgpu: amdgpu_device_ip_resume failed (-110).<br>[ &nbs=
p;604.219420] ------------[ cut here ]------------<br>[ &nbsp;604.219425] W=
ARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amd=
gpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.220350] Modules linked in: bt=
rfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs=
 rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skcipher af_al=
g bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec=
_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_codec_h=
dmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_inte=
l_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_=
seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_c=
ore ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sc=
hed drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_display_h=
elper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd =
btmtk btrtl btbcm btintel libarc4 platform_profile soundcore bluetooth rtsx=
_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap w=
mi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_pii=
x4 i2c_smbus dell_rbtn<br>[ &nbsp;604.220426] &nbsp;joydev input_leds mac_h=
id sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnetlink dmi_sy=
sfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov async_me=
mcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multit=
ouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_cl=
mulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid w=
mi realtek ahci libahci uas usb_storage aesni_intel<br>[ &nbsp;604.220462] =
CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu PRE=
EMPT(voluntary)<br>[ &nbsp;604.220467] Tainted: [P]=3DPROPRIETARY_MODULE, [=
O]=3DOOT_MODULE<br>[ &nbsp;604.220468] Hardware name: Dell Inc. Inspiron 55=
76/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.220470] Workqueue: async as=
ync_run_entry_fn<br>[ &nbsp;604.220476] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 =
[amdgpu]<br>[ &nbsp;604.221397] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 d=
e 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e=
9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d=
 14 8d 00 0f<br>[ &nbsp;604.221400] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 0001=
0246<br>[ &nbsp;604.221403] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX=
: 0000000000000000<br>[ &nbsp;604.221404] RDX: 0000000000000000 RSI: 000000=
0000000000 RDI: 0000000000000000<br>[ &nbsp;604.221405] RBP: ffffd4e34aa37c=
a8 R08: 0000000000000000 R09: 0000000000000000<br>[ &nbsp;604.221406] R10: =
0000000000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ &nbsp;604=
.221407] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000<=
br>[ &nbsp;604.221409] FS: &nbsp;0000000000000000(0000) GS:ffff8edf19670000=
(0000) knlGS:0000000000000000<br>[ &nbsp;604.221410] CS: &nbsp;0010 DS: 000=
0 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;604.221411] CR2: 000064d8a61373=
c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ &nbsp;604.221413] Call =
Trace:<br>[ &nbsp;604.221415] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.221420] &nb=
sp;amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ &nbsp;604.222316] =
&nbsp;? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ &nbsp;604.223208=
] &nbsp;amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ &nbsp;604.224094] &=
nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.224979] &nbsp;p=
ci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604.224986] &nbsp;? __pfx_pci_pm_suspen=
d+0x10/0x10<br>[ &nbsp;604.224989] &nbsp;dpm_run_callback+0x5f/0x160<br>[ &=
nbsp;604.224993] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;604.224996] &n=
bsp;async_suspend+0x21/0x40<br>[ &nbsp;604.224998] &nbsp;async_run_entry_fn=
+0x33/0x130<br>[ &nbsp;604.225001] &nbsp;process_one_work+0x18e/0x370<br>[ =
&nbsp;604.225005] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp;604.225007] &n=
bsp;? __pfx_worker_thread+0x10/0x10<br>[ &nbsp;604.225009] &nbsp;kthread+0x=
10b/0x220<br>[ &nbsp;604.225012] &nbsp;? recalc_sigpending+0x76/0xb0<br>[ &=
nbsp;604.225014] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.225017] &nb=
sp;ret_from_fork+0x134/0x150<br>[ &nbsp;604.225019] &nbsp;? __pfx_kthread+0=
x10/0x10<br>[ &nbsp;604.225022] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbs=
p;604.225026] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.225027] ---[ end trace 000=
0000000000000 ]---<br>[ &nbsp;604.225086] ------------[ cut here ]---------=
---<br>[ &nbsp;604.225087] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd=
/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.2=
26002] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix =
msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac alg=
if_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hd=
a_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec=
_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda=
_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm s=
nd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_raw=
midi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_p=
anel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_s=
uballoc_helper drm_display_helper cec rc_core snd_seq_device snd_timer i2c_=
algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_prof=
ile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi de=
ll_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_des=
criptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604.226061] &=
nbsp;joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parport=
 efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid45=
6 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq r=
aid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video r=
8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel seri=
o_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_storage aesni_i=
ntel<br>[ &nbsp;604.226094] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Ta=
inted: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.=
18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;604.226098] Tainted:=
 [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.2260=
99] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br=
>[ &nbsp;604.226101] Workqueue: async async_run_entry_fn<br>[ &nbsp;604.226=
106] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.227029] Cod=
e: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 =
08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea f=
f ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.227031]=
 RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ &nbsp;604.227034] RAX: 00=
00000000000000 RBX: ffff8edc1d6a5a20 RCX: 0000000000000000<br>[ &nbsp;604.2=
27035] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000<br=
>[ &nbsp;604.227036] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 00000=
00000000000<br>[ &nbsp;604.227037] R10: 0000000000000000 R11: 0000000000000=
000 R12: ffff8edc1d680000<br>[ &nbsp;604.227038] R13: 0000000000000002 R14:=
 0000000000000002 R15: 0000000000000000<br>[ &nbsp;604.227039] FS: &nbsp;00=
00000000000000(0000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<br>[ =
&nbsp;604.227041] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br=
>[ &nbsp;604.227042] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 00000=
000001506f0<br>[ &nbsp;604.227043] Call Trace:<br>[ &nbsp;604.227044] &nbsp=
;&lt;TASK&gt;<br>[ &nbsp;604.227048] &nbsp;amdgpu_fence_driver_hw_fini+0x11=
d/0x160 [amdgpu]<br>[ &nbsp;604.227939] &nbsp;? amdgpu_ttm_evict_resources+=
0x39/0x70 [amdgpu]<br>[ &nbsp;604.228843] &nbsp;amdgpu_device_suspend+0x10a=
/0x170 [amdgpu]<br>[ &nbsp;604.229731] &nbsp;amdgpu_pmops_suspend+0x3d/0xe0=
 [amdgpu]<br>[ &nbsp;604.230619] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ &nbsp=
;604.230624] &nbsp;? __pfx_pci_pm_suspend+0x10/0x10<br>[ &nbsp;604.230627] =
&nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;604.230631] &nbsp;device_suspe=
nd+0x1e4/0x4e0<br>[ &nbsp;604.230634] &nbsp;async_suspend+0x21/0x40<br>[ &n=
bsp;604.230636] &nbsp;async_run_entry_fn+0x33/0x130<br>[ &nbsp;604.230639] =
&nbsp;process_one_work+0x18e/0x370<br>[ &nbsp;604.230642] &nbsp;worker_thre=
ad+0x317/0x450<br>[ &nbsp;604.230644] &nbsp;? __pfx_worker_thread+0x10/0x10=
<br>[ &nbsp;604.230646] &nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.230649] &n=
bsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;604.230651] &nbsp;? __pfx_kthr=
ead+0x10/0x10<br>[ &nbsp;604.230654] &nbsp;ret_from_fork+0x134/0x150<br>[ &=
nbsp;604.230656] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.230658] &nb=
sp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;604.230662] &nbsp;&lt;/TASK&gt;<b=
r>[ &nbsp;604.230663] ---[ end trace 0000000000000000 ]---<br>[ &nbsp;604.2=
30720] ------------[ cut here ]------------<br>[ &nbsp;604.230721] WARNING:=
 CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq=
_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.231654] Modules linked in: btrfs bla=
ke2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm=
 snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep =
binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdm=
i snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd=
_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcf=
g snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_mid=
i kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath=
 irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm=
_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_display_helper c=
ec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk b=
trtl btbcm btintel libarc4 platform_profile soundcore bluetooth rtsx_usb_ms=
 dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof=
 dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_=
smbus dell_rbtn<br>[ &nbsp;604.231714] &nbsp;joydev input_leds mac_hid sch_=
fq_codel ppdev lp msr parport_pc parport efi_pstore nfnetlink dmi_sysfs aut=
ofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy as=
ync_pq async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch hi=
d_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni v=
ga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi real=
tek ahci libahci uas usb_storage aesni_intel<br>[ &nbsp;604.231746] CPU: 0 =
UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &nbsp; &nbsp; &nbsp; &nbsp=
;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu PREEMPT(vo=
luntary)<br>[ &nbsp;604.231751] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWA=
RN, [O]=3DOOT_MODULE<br>[ &nbsp;604.231752] Hardware name: Dell Inc. Inspir=
on 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.231753] Workqueue: asy=
nc async_run_entry_fn<br>[ &nbsp;604.231759] RIP: 0010:amdgpu_irq_put+0xc4/=
0xe0 [amdgpu]<br>[ &nbsp;604.232678] Code: ff 84 c0 75 85 eb 25 44 89 ea 48=
 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31=
 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 =
e9 8d 14 8d 00 0f<br>[ &nbsp;604.232681] RSP: 0018:ffffd4e34aa37c88 EFLAGS:=
 00010246<br>[ &nbsp;604.232685] RAX: 0000000000000000 RBX: ffff8edc1d6a5a2=
0 RCX: 0000000000000000<br>[ &nbsp;604.232686] RDX: 0000000000000000 RSI: 0=
000000000000000 RDI: 0000000000000000<br>[ &nbsp;604.232687] RBP: ffffd4e34=
aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[ &nbsp;604.232689] =
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ &nbs=
p;604.232690] R13: 0000000000000002 R14: 0000000000000002 R15: 000000000000=
0000<br>[ &nbsp;604.232691] FS: &nbsp;0000000000000000(0000) GS:ffff8edf196=
70000(0000) knlGS:0000000000000000<br>[ &nbsp;604.232693] CS: &nbsp;0010 DS=
: 0000 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;604.232695] CR2: 000064d8a=
61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ &nbsp;604.232696] =
Call Trace:<br>[ &nbsp;604.232698] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.232702=
] &nbsp;amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ &nbsp;604.233=
601] &nbsp;? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ &nbsp;604.2=
34506] &nbsp;amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ &nbsp;604.2354=
04] &nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.236275] &n=
bsp;pci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604.236281] &nbsp;? __pfx_pci_pm_s=
uspend+0x10/0x10<br>[ &nbsp;604.236283] &nbsp;dpm_run_callback+0x5f/0x160<b=
r>[ &nbsp;604.236287] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;604.23629=
0] &nbsp;async_suspend+0x21/0x40<br>[ &nbsp;604.236292] &nbsp;async_run_ent=
ry_fn+0x33/0x130<br>[ &nbsp;604.236295] &nbsp;process_one_work+0x18e/0x370<=
br>[ &nbsp;604.236299] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp;604.23630=
1] &nbsp;? __pfx_worker_thread+0x10/0x10<br>[ &nbsp;604.236302] &nbsp;kthre=
ad+0x10b/0x220<br>[ &nbsp;604.236305] &nbsp;? recalc_sigpending+0x76/0xb0<b=
r>[ &nbsp;604.236307] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.236310=
] &nbsp;ret_from_fork+0x134/0x150<br>[ &nbsp;604.236312] &nbsp;? __pfx_kthr=
ead+0x10/0x10<br>[ &nbsp;604.236315] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[=
 &nbsp;604.236319] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.236320] ---[ end trac=
e 0000000000000000 ]---<br>[ &nbsp;604.236389] ------------[ cut here ]----=
--------<br>[ &nbsp;604.236391] WARNING: CPU: 0 PID: 6585 at drivers/gpu/dr=
m/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;=
604.237301] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs m=
inix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cma=
c algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu s=
nd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_=
codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel sn=
d_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_=
pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp sn=
d_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 =
drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec =
drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_timer=
 i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform=
_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_w=
mi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wm=
i_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604.2373=
70] &nbsp;joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc pa=
rport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 r=
aid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6=
_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse vi=
deo r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel=
 serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_storage ae=
sni_intel<br>[ &nbsp;604.237404] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:=
21 Tainted: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nb=
sp;6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;604.237408] Tai=
nted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604=
.237409] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/20=
18<br>[ &nbsp;604.237410] Workqueue: async async_run_entry_fn<br>[ &nbsp;60=
4.237416] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.238328=
] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 8=
3 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8=
 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.23=
8330] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ &nbsp;604.238332] RA=
X: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 0000000000000000<br>[ &nbsp;=
604.238333] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000=
00<br>[ &nbsp;604.238334] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: =
0000000000000000<br>[ &nbsp;604.238335] R10: 0000000000000000 R11: 00000000=
00000000 R12: ffff8edc1d680000<br>[ &nbsp;604.238336] R13: 0000000000000002=
 R14: 0000000000000002 R15: 0000000000000000<br>[ &nbsp;604.238338] FS: &nb=
sp;0000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<=
br>[ &nbsp;604.238339] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33<br>[ &nbsp;604.238340] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: =
00000000001506f0<br>[ &nbsp;604.238342] Call Trace:<br>[ &nbsp;604.238343] =
&nbsp;&lt;TASK&gt;<br>[ &nbsp;604.238347] &nbsp;amdgpu_fence_driver_hw_fini=
+0x11d/0x160 [amdgpu]<br>[ &nbsp;604.239247] &nbsp;? amdgpu_ttm_evict_resou=
rces+0x39/0x70 [amdgpu]<br>[ &nbsp;604.240137] &nbsp;amdgpu_device_suspend+=
0x10a/0x170 [amdgpu]<br>[ &nbsp;604.241032] &nbsp;amdgpu_pmops_suspend+0x3d=
/0xe0 [amdgpu]<br>[ &nbsp;604.241934] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ =
&nbsp;604.241940] &nbsp;? __pfx_pci_pm_suspend+0x10/0x10<br>[ &nbsp;604.241=
942] &nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;604.241946] &nbsp;device_=
suspend+0x1e4/0x4e0<br>[ &nbsp;604.241949] &nbsp;async_suspend+0x21/0x40<br=
>[ &nbsp;604.241951] &nbsp;async_run_entry_fn+0x33/0x130<br>[ &nbsp;604.241=
954] &nbsp;process_one_work+0x18e/0x370<br>[ &nbsp;604.241958] &nbsp;worker=
_thread+0x317/0x450<br>[ &nbsp;604.241960] &nbsp;? __pfx_worker_thread+0x10=
/0x10<br>[ &nbsp;604.241961] &nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.24196=
4] &nbsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;604.241966] &nbsp;? __pfx=
_kthread+0x10/0x10<br>[ &nbsp;604.241969] &nbsp;ret_from_fork+0x134/0x150<b=
r>[ &nbsp;604.241972] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.241974=
] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;604.241978] &nbsp;&lt;/TASK&=
gt;<br>[ &nbsp;604.241979] ---[ end trace 0000000000000000 ]---<br>[ &nbsp;=
604.242037] ------------[ cut here ]------------<br>[ &nbsp;604.242038] WAR=
NING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgp=
u_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.242954] Modules linked in: btrf=
s blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs r=
fcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg =
bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_a=
tihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_codec_hdm=
i snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_intel_=
dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_se=
q_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_cor=
e ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sche=
d drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_display_hel=
per cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd bt=
mtk btrtl btbcm btintel libarc4 platform_profile soundcore bluetooth rtsx_u=
sb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi=
_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4=
 i2c_smbus dell_rbtn<br>[ &nbsp;604.243013] &nbsp;joydev input_leds mac_hid=
 sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnetlink dmi_sysf=
s autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov async_memc=
py async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitou=
ch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmu=
lni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi=
 realtek ahci libahci uas usb_storage aesni_intel<br>[ &nbsp;604.243046] CP=
U: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &nbsp; &nbsp; &nbsp; =
&nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu PREEM=
PT(voluntary)<br>[ &nbsp;604.243050] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=
=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.243051] Hardware name: Dell Inc. I=
nspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.243052] Workqueue=
: async async_run_entry_fn<br>[ &nbsp;604.243058] RIP: 0010:amdgpu_irq_put+=
0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.243986] Code: ff 84 c0 75 85 eb 25 44 89 =
ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 =
f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff e=
b a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.243988] RSP: 0018:ffffd4e34aa37c88 EF=
LAGS: 00010246<br>[ &nbsp;604.243990] RAX: 0000000000000000 RBX: ffff8edc1d=
6a5a20 RCX: 0000000000000000<br>[ &nbsp;604.243992] RDX: 0000000000000000 R=
SI: 0000000000000000 RDI: 0000000000000000<br>[ &nbsp;604.243993] RBP: ffff=
d4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[ &nbsp;604.243=
994] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[=
 &nbsp;604.243995] R13: 0000000000000002 R14: 0000000000000002 R15: 0000000=
000000000<br>[ &nbsp;604.243996] FS: &nbsp;0000000000000000(0000) GS:ffff8e=
df19670000(0000) knlGS:0000000000000000<br>[ &nbsp;604.243997] CS: &nbsp;00=
10 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;604.243998] CR2: 0000=
64d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ &nbsp;604.244=
000] Call Trace:<br>[ &nbsp;604.244001] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.2=
44005] &nbsp;amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ &nbsp;60=
4.244899] &nbsp;? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ &nbsp;=
604.245788] &nbsp;amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ &nbsp;604=
.246685] &nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.24757=
7] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604.247582] &nbsp;? __pfx_pci=
_pm_suspend+0x10/0x10<br>[ &nbsp;604.247585] &nbsp;dpm_run_callback+0x5f/0x=
160<br>[ &nbsp;604.247589] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;604.=
247592] &nbsp;async_suspend+0x21/0x40<br>[ &nbsp;604.247594] &nbsp;async_ru=
n_entry_fn+0x33/0x130<br>[ &nbsp;604.247598] &nbsp;process_one_work+0x18e/0=
x370<br>[ &nbsp;604.247601] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp;604.=
247603] &nbsp;? __pfx_worker_thread+0x10/0x10<br>[ &nbsp;604.247604] &nbsp;=
kthread+0x10b/0x220<br>[ &nbsp;604.247607] &nbsp;? recalc_sigpending+0x76/0=
xb0<br>[ &nbsp;604.247610] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.2=
47612] &nbsp;ret_from_fork+0x134/0x150<br>[ &nbsp;604.247615] &nbsp;? __pfx=
_kthread+0x10/0x10<br>[ &nbsp;604.247617] &nbsp;ret_from_fork_asm+0x1a/0x30=
<br>[ &nbsp;604.247621] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.247622] ---[ end=
 trace 0000000000000000 ]---<br>[ &nbsp;604.247680] ------------[ cut here =
]------------<br>[ &nbsp;604.247681] WARNING: CPU: 0 PID: 6585 at drivers/g=
pu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &=
nbsp;604.248598] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus =
hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrt=
r cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amd=
gpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd=
_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_int=
el snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep=
 snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event c=
cp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac8=
0211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_=
exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_=
timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 pla=
tform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick d=
ell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp de=
ll_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604=
.248658] &nbsp;joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_=
pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 rai=
d10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor =
raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmou=
se video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_=
intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_stora=
ge aesni_intel<br>[ &nbsp;604.248691] CPU: 0 UID: 0 PID: 6585 Comm: kworker=
/u16:21 Tainted: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp=
; &nbsp;6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;604.248695=
] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbs=
p;604.248696] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/=
29/2018<br>[ &nbsp;604.248697] Workqueue: async async_run_entry_fn<br>[ &nb=
sp;604.248702] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.2=
49627] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff=
 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; =
0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;6=
04.249629] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ &nbsp;604.24963=
2] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 0000000000000000<br>[ &=
nbsp;604.249633] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000<br>[ &nbsp;604.249634] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 =
R09: 0000000000000000<br>[ &nbsp;604.249635] R10: 0000000000000000 R11: 000=
0000000000000 R12: ffff8edc1d680000<br>[ &nbsp;604.249636] R13: 00000000000=
00002 R14: 0000000000000002 R15: 0000000000000000<br>[ &nbsp;604.249638] FS=
: &nbsp;0000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:000000000000=
0000<br>[ &nbsp;604.249639] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 000000008=
0050033<br>[ &nbsp;604.249640] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 =
CR4: 00000000001506f0<br>[ &nbsp;604.249642] Call Trace:<br>[ &nbsp;604.249=
643] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.249647] &nbsp;amdgpu_fence_driver_hw=
_fini+0x11d/0x160 [amdgpu]<br>[ &nbsp;604.250538] &nbsp;? amdgpu_ttm_evict_=
resources+0x39/0x70 [amdgpu]<br>[ &nbsp;604.251444] &nbsp;amdgpu_device_sus=
pend+0x10a/0x170 [amdgpu]<br>[ &nbsp;604.252318] &nbsp;amdgpu_pmops_suspend=
+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.253208] &nbsp;pci_pm_suspend+0x85/0x1b0<=
br>[ &nbsp;604.253215] &nbsp;? __pfx_pci_pm_suspend+0x10/0x10<br>[ &nbsp;60=
4.253218] &nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;604.253222] &nbsp;de=
vice_suspend+0x1e4/0x4e0<br>[ &nbsp;604.253224] &nbsp;async_suspend+0x21/0x=
40<br>[ &nbsp;604.253227] &nbsp;async_run_entry_fn+0x33/0x130<br>[ &nbsp;60=
4.253230] &nbsp;process_one_work+0x18e/0x370<br>[ &nbsp;604.253233] &nbsp;w=
orker_thread+0x317/0x450<br>[ &nbsp;604.253235] &nbsp;? __pfx_worker_thread=
+0x10/0x10<br>[ &nbsp;604.253237] &nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.=
253240] &nbsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;604.253242] &nbsp;? =
__pfx_kthread+0x10/0x10<br>[ &nbsp;604.253245] &nbsp;ret_from_fork+0x134/0x=
150<br>[ &nbsp;604.253248] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.2=
53250] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;604.253254] &nbsp;&lt;/=
TASK&gt;<br>[ &nbsp;604.253255] ---[ end trace 0000000000000000 ]---<br>[ &=
nbsp;604.253313] ------------[ cut here ]------------<br>[ &nbsp;604.253313=
] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 =
amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.254240] Modules linked in:=
 btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils =
xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skcipher af=
_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_co=
dec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_code=
c_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_i=
ntel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd s=
nd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10=
k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu=
_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_displa=
y_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 s=
nd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore bluetooth r=
tsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_keyma=
p wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_=
piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604.254299] &nbsp;joydev input_leds ma=
c_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnetlink dmi=
_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov async=
_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear hid_mul=
titouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval=
_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hi=
d wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ &nbsp;604.25433=
2] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &nbsp; &nbsp; &n=
bsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu =
PREEMPT(voluntary)<br>[ &nbsp;604.254336] Tainted: [P]=3DPROPRIETARY_MODULE=
, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.254337] Hardware name: Dell I=
nc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.254339] Work=
queue: async async_run_entry_fn<br>[ &nbsp;604.254344] RIP: 0010:amdgpu_irq=
_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.255268] Code: ff 84 c0 75 85 eb 25 4=
4 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d=
2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff=
 ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.255271] RSP: 0018:ffffd4e34aa37c=
88 EFLAGS: 00010246<br>[ &nbsp;604.255274] RAX: 0000000000000000 RBX: ffff8=
edc1d6a5a20 RCX: 0000000000000000<br>[ &nbsp;604.255275] RDX: 0000000000000=
000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ &nbsp;604.255276] RBP:=
 ffffd4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[ &nbsp;60=
4.255278] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1d680000=
<br>[ &nbsp;604.255279] R13: 0000000000000002 R14: 0000000000000002 R15: 00=
00000000000000<br>[ &nbsp;604.255280] FS: &nbsp;0000000000000000(0000) GS:f=
fff8edf19670000(0000) knlGS:0000000000000000<br>[ &nbsp;604.255281] CS: &nb=
sp;0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;604.255282] CR2:=
 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ &nbsp;60=
4.255284] Call Trace:<br>[ &nbsp;604.255285] &nbsp;&lt;TASK&gt;<br>[ &nbsp;=
604.255289] &nbsp;amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ &nb=
sp;604.256183] &nbsp;? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ &=
nbsp;604.257090] &nbsp;amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ &nbs=
p;604.257988] &nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.=
258877] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604.258884] &nbsp;? __pf=
x_pci_pm_suspend+0x10/0x10<br>[ &nbsp;604.258887] &nbsp;dpm_run_callback+0x=
5f/0x160<br>[ &nbsp;604.258891] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp=
;604.258893] &nbsp;async_suspend+0x21/0x40<br>[ &nbsp;604.258895] &nbsp;asy=
nc_run_entry_fn+0x33/0x130<br>[ &nbsp;604.258899] &nbsp;process_one_work+0x=
18e/0x370<br>[ &nbsp;604.258902] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp=
;604.258904] &nbsp;? __pfx_worker_thread+0x10/0x10<br>[ &nbsp;604.258906] &=
nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.258908] &nbsp;? recalc_sigpending+0=
x76/0xb0<br>[ &nbsp;604.258911] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;=
604.258913] &nbsp;ret_from_fork+0x134/0x150<br>[ &nbsp;604.258916] &nbsp;? =
__pfx_kthread+0x10/0x10<br>[ &nbsp;604.258918] &nbsp;ret_from_fork_asm+0x1a=
/0x30<br>[ &nbsp;604.258922] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.258923] ---=
[ end trace 0000000000000000 ]---<br>[ &nbsp;604.258981] ------------[ cut =
here ]------------<br>[ &nbsp;604.258982] WARNING: CPU: 0 PID: 6585 at driv=
ers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<b=
r>[ &nbsp;604.259903] Modules linked in: btrfs blake2b_generic ufs qnx4 hfs=
plus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtime=
r qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O=
) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_componen=
t snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hd=
a_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_=
hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_ev=
ent ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp=
 mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm=
 drm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_device=
 snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc=
4 platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memst=
ick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10te=
mp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbs=
p;604.259962] &nbsp;joydev input_leds mac_hid sch_fq_codel ppdev lp msr par=
port_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_=
1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx=
 xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc =
psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clm=
ulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_=
storage aesni_intel<br>[ &nbsp;604.259995] CPU: 0 UID: 0 PID: 6585 Comm: kw=
orker/u16:21 Tainted: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; =
&nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;604.2=
59999] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[=
 &nbsp;604.259999] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.=
7 01/29/2018<br>[ &nbsp;604.260001] Workqueue: async async_run_entry_fn<br>=
[ &nbsp;604.260006] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;=
604.260922] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc =
ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f=
&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &n=
bsp;604.260925] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ &nbsp;604.=
260928] RAX: 0000000000000000 RBX: ffff8edc1d6a5a20 RCX: 0000000000000000<b=
r>[ &nbsp;604.260929] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000=
000000000000<br>[ &nbsp;604.260930] RBP: ffffd4e34aa37ca8 R08: 000000000000=
0000 R09: 0000000000000000<br>[ &nbsp;604.260931] R10: 0000000000000000 R11=
: 0000000000000000 R12: ffff8edc1d680000<br>[ &nbsp;604.260932] R13: 000000=
0000000002 R14: 0000000000000002 R15: 0000000000000000<br>[ &nbsp;604.26093=
4] FS: &nbsp;0000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:0000000=
000000000<br>[ &nbsp;604.260935] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 0000=
000080050033<br>[ &nbsp;604.260936] CR2: 000064d8a61373c0 CR3: 0000000123a6=
b000 CR4: 00000000001506f0<br>[ &nbsp;604.260938] Call Trace:<br>[ &nbsp;60=
4.260939] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.260943] &nbsp;amdgpu_fence_driv=
er_hw_fini+0x11d/0x160 [amdgpu]<br>[ &nbsp;604.261840] &nbsp;? amdgpu_ttm_e=
vict_resources+0x39/0x70 [amdgpu]<br>[ &nbsp;604.262729] &nbsp;amdgpu_devic=
e_suspend+0x10a/0x170 [amdgpu]<br>[ &nbsp;604.263628] &nbsp;amdgpu_pmops_su=
spend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.264519] &nbsp;pci_pm_suspend+0x85/0=
x1b0<br>[ &nbsp;604.264525] &nbsp;? __pfx_pci_pm_suspend+0x10/0x10<br>[ &nb=
sp;604.264528] &nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;604.264532] &nb=
sp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;604.264535] &nbsp;async_suspend+0x=
21/0x40<br>[ &nbsp;604.264537] &nbsp;async_run_entry_fn+0x33/0x130<br>[ &nb=
sp;604.264541] &nbsp;process_one_work+0x18e/0x370<br>[ &nbsp;604.264544] &n=
bsp;worker_thread+0x317/0x450<br>[ &nbsp;604.264546] &nbsp;? __pfx_worker_t=
hread+0x10/0x10<br>[ &nbsp;604.264548] &nbsp;kthread+0x10b/0x220<br>[ &nbsp=
;604.264551] &nbsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;604.264553] &nb=
sp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.264556] &nbsp;ret_from_fork+0x1=
34/0x150<br>[ &nbsp;604.264558] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;=
604.264561] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;604.264565] &nbsp;=
&lt;/TASK&gt;<br>[ &nbsp;604.264566] ---[ end trace 0000000000000000 ]---<b=
r>[ &nbsp;604.264618] ------------[ cut here ]------------<br>[ &nbsp;604.2=
64619] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c=
:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.265538] Modules linke=
d in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_u=
tils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skciph=
er af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_h=
da_codec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda=
_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core =
snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_=
amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm =
ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirk=
s gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_d=
isplay_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80=
211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore blueto=
oth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_=
keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power=
 i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604.265598] &nbsp;joydev input_le=
ds mac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnetlin=
k dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov =
async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear hi=
d_multitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi po=
lyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgasta=
te hid wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ &nbsp;604.=
265631] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &nbsp; &nbs=
p; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ub=
untu PREEMPT(voluntary)<br>[ &nbsp;604.265635] Tainted: [P]=3DPROPRIETARY_M=
ODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.265636] Hardware name: D=
ell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.265638]=
 Workqueue: async async_run_entry_fn<br>[ &nbsp;604.265643] RIP: 0010:amdgp=
u_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.266566] Code: ff 84 c0 75 85 eb=
 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d=
 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe =
ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.266569] RSP: 0018:ffffd4e34=
aa37c88 EFLAGS: 00010246<br>[ &nbsp;604.266571] RAX: 0000000000000000 RBX: =
ffff8edc1d6a5a20 RCX: 0000000000000000<br>[ &nbsp;604.266573] RDX: 00000000=
00000000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ &nbsp;604.266574]=
 RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>[ &nb=
sp;604.266575] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1d6=
80000<br>[ &nbsp;604.266576] R13: 0000000000000002 R14: 0000000000000002 R1=
5: 0000000000000000<br>[ &nbsp;604.266577] FS: &nbsp;0000000000000000(0000)=
 GS:ffff8edf19670000(0000) knlGS:0000000000000000<br>[ &nbsp;604.266578] CS=
: &nbsp;0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;604.266580]=
 CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ &nb=
sp;604.266581] Call Trace:<br>[ &nbsp;604.266583] &nbsp;&lt;TASK&gt;<br>[ &=
nbsp;604.266586] &nbsp;amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>=
[ &nbsp;604.267483] &nbsp;? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<b=
r>[ &nbsp;604.268375] &nbsp;amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[=
 &nbsp;604.269253] &nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp=
;604.270146] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604.270152] &nbsp;?=
 __pfx_pci_pm_suspend+0x10/0x10<br>[ &nbsp;604.270155] &nbsp;dpm_run_callba=
ck+0x5f/0x160<br>[ &nbsp;604.270159] &nbsp;device_suspend+0x1e4/0x4e0<br>[ =
&nbsp;604.270161] &nbsp;async_suspend+0x21/0x40<br>[ &nbsp;604.270163] &nbs=
p;async_run_entry_fn+0x33/0x130<br>[ &nbsp;604.270167] &nbsp;process_one_wo=
rk+0x18e/0x370<br>[ &nbsp;604.270170] &nbsp;worker_thread+0x317/0x450<br>[ =
&nbsp;604.270172] &nbsp;? __pfx_worker_thread+0x10/0x10<br>[ &nbsp;604.2701=
73] &nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.270176] &nbsp;? recalc_sigpend=
ing+0x76/0xb0<br>[ &nbsp;604.270179] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &=
nbsp;604.270181] &nbsp;ret_from_fork+0x134/0x150<br>[ &nbsp;604.270184] &nb=
sp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.270186] &nbsp;ret_from_fork_asm=
+0x1a/0x30<br>[ &nbsp;604.270191] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.270192=
] ---[ end trace 0000000000000000 ]---<br>[ &nbsp;604.270242] ------------[=
 cut here ]------------<br>[ &nbsp;604.270243] WARNING: CPU: 0 PID: 6585 at=
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdg=
pu]<br>[ &nbsp;604.271162] Modules linked in: btrfs blake2b_generic ufs qnx=
4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_h=
rtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) =
spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_com=
ponent snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic s=
nd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi=
 snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_mi=
di_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq a=
mdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helpe=
r ttm drm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_seq_d=
evice snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel l=
ibarc4 platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 =
memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas =
k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[=
 &nbsp;604.271222] &nbsp;joydev input_leds mac_hid sch_fq_codel ppdev lp ms=
r parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso=
8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor asy=
nc_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_s=
dmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghas=
h_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas=
 usb_storage aesni_intel<br>[ &nbsp;604.271255] CPU: 0 UID: 0 PID: 6585 Com=
m: kworker/u16:21 Tainted: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &n=
bsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;=
604.271260] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE=
<br>[ &nbsp;604.271260] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS=
 1.0.7 01/29/2018<br>[ &nbsp;604.271262] Workqueue: async async_run_entry_f=
n<br>[ &nbsp;604.271267] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &=
nbsp;604.272177] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e=
1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &=
lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br=
>[ &nbsp;604.272180] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ &nbsp=
;604.272182] RAX: 0000000000000000 RBX: ffff8edc1d6ad440 RCX: 0000000000000=
000<br>[ &nbsp;604.272184] RDX: 0000000000000000 RSI: 0000000000000000 RDI:=
 0000000000000000<br>[ &nbsp;604.272185] RBP: ffffd4e34aa37ca8 R08: 0000000=
000000000 R09: 0000000000000000<br>[ &nbsp;604.272186] R10: 000000000000000=
0 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ &nbsp;604.272187] R13: 0=
000000000000000 R14: 0000000000000002 R15: 0000000000000000<br>[ &nbsp;604.=
272188] FS: &nbsp;0000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:00=
00000000000000<br>[ &nbsp;604.272189] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0:=
 0000000080050033<br>[ &nbsp;604.272190] CR2: 000064d8a61373c0 CR3: 0000000=
123a6b000 CR4: 00000000001506f0<br>[ &nbsp;604.272192] Call Trace:<br>[ &nb=
sp;604.272193] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.272197] &nbsp;amdgpu_fence=
_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ &nbsp;604.273091] &nbsp;? amdgpu_=
ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ &nbsp;604.273992] &nbsp;amdgpu_=
device_suspend+0x10a/0x170 [amdgpu]<br>[ &nbsp;604.274885] &nbsp;amdgpu_pmo=
ps_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.275774] &nbsp;pci_pm_suspend+0=
x85/0x1b0<br>[ &nbsp;604.275780] &nbsp;? __pfx_pci_pm_suspend+0x10/0x10<br>=
[ &nbsp;604.275782] &nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;604.275786=
] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;604.275789] &nbsp;async_suspe=
nd+0x21/0x40<br>[ &nbsp;604.275791] &nbsp;async_run_entry_fn+0x33/0x130<br>=
[ &nbsp;604.275794] &nbsp;process_one_work+0x18e/0x370<br>[ &nbsp;604.27579=
8] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp;604.275799] &nbsp;? __pfx_wor=
ker_thread+0x10/0x10<br>[ &nbsp;604.275801] &nbsp;kthread+0x10b/0x220<br>[ =
&nbsp;604.275804] &nbsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;604.275807=
] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.275809] &nbsp;ret_from_for=
k+0x134/0x150<br>[ &nbsp;604.275812] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &=
nbsp;604.275814] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;604.275818] &=
nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.275819] ---[ end trace 0000000000000000 ]=
---<br>[ &nbsp;604.275870] ------------[ cut here ]------------<br>[ &nbsp;=
604.275871] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_=
irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.276783] Modules =
linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_u=
cs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_s=
kcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 =
snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib sn=
d_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_=
core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac=
_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci=
 kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_=
quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper =
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb =
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore b=
luetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sp=
arse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_=
power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604.276844] &nbsp;joydev inp=
ut_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfn=
etlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_r=
ecov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 line=
ar hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_ac=
pi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid v=
gastate hid wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ &nbsp=
;604.276877] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &nbsp;=
 &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-generic =
#9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;604.276881] Tainted: [P]=3DPROPRIET=
ARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.276882] Hardware na=
me: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.27=
6883] Workqueue: async async_run_entry_fn<br>[ &nbsp;604.276889] RIP: 0010:=
amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.277807] Code: ff 84 c0 75 =
85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 =
5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b=
8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.277810] RSP: 0018:ffff=
d4e34aa37c88 EFLAGS: 00010246<br>[ &nbsp;604.277812] RAX: 0000000000000000 =
RBX: ffff8edc1d6ad440 RCX: 0000000000000000<br>[ &nbsp;604.277814] RDX: 000=
0000000000000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ &nbsp;604.27=
7815] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 0000000000000000<br>=
[ &nbsp;604.277816] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000<br>[ &nbsp;604.277817] R13: 0000000000000001 R14: 00000000000000=
02 R15: 0000000000000000<br>[ &nbsp;604.277818] FS: &nbsp;0000000000000000(=
0000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<br>[ &nbsp;604.27781=
9] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;604.27=
7820] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>=
[ &nbsp;604.277822] Call Trace:<br>[ &nbsp;604.277823] &nbsp;&lt;TASK&gt;<b=
r>[ &nbsp;604.277827] &nbsp;amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu=
]<br>[ &nbsp;604.278729] &nbsp;? amdgpu_ttm_evict_resources+0x39/0x70 [amdg=
pu]<br>[ &nbsp;604.279624] &nbsp;amdgpu_device_suspend+0x10a/0x170 [amdgpu]=
<br>[ &nbsp;604.280518] &nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ =
&nbsp;604.281407] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604.281412] &n=
bsp;? __pfx_pci_pm_suspend+0x10/0x10<br>[ &nbsp;604.281415] &nbsp;dpm_run_c=
allback+0x5f/0x160<br>[ &nbsp;604.281419] &nbsp;device_suspend+0x1e4/0x4e0<=
br>[ &nbsp;604.281421] &nbsp;async_suspend+0x21/0x40<br>[ &nbsp;604.281423]=
 &nbsp;async_run_entry_fn+0x33/0x130<br>[ &nbsp;604.281427] &nbsp;process_o=
ne_work+0x18e/0x370<br>[ &nbsp;604.281430] &nbsp;worker_thread+0x317/0x450<=
br>[ &nbsp;604.281432] &nbsp;? __pfx_worker_thread+0x10/0x10<br>[ &nbsp;604=
.281434] &nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.281437] &nbsp;? recalc_si=
gpending+0x76/0xb0<br>[ &nbsp;604.281439] &nbsp;? __pfx_kthread+0x10/0x10<b=
r>[ &nbsp;604.281442] &nbsp;ret_from_fork+0x134/0x150<br>[ &nbsp;604.281444=
] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.281446] &nbsp;ret_from_for=
k_asm+0x1a/0x30<br>[ &nbsp;604.281451] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.2=
81452] ---[ end trace 0000000000000000 ]---<br>[ &nbsp;604.281510] --------=
----[ cut here ]------------<br>[ &nbsp;604.281511] WARNING: CPU: 0 PID: 65=
85 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 =
[amdgpu]<br>[ &nbsp;604.282435] Modules linked in: btrfs blake2b_generic uf=
s qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy =
snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs=
(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scode=
c_component snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_gene=
ric snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw=
_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_s=
eq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_=
seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_=
helper ttm drm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_=
seq_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btin=
tel libarc4 platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee=
1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dc=
dbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn=
<br>[ &nbsp;604.282494] &nbsp;joydev input_leds mac_hid sch_fq_codel ppdev =
lp msr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nl=
s_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xo=
r async_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_=
usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb=
 ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahc=
i uas usb_storage aesni_intel<br>[ &nbsp;604.282527] CPU: 0 UID: 0 PID: 658=
5 Comm: kworker/u16:21 Tainted: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbs=
p; &nbsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ &=
nbsp;604.282532] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_M=
ODULE<br>[ &nbsp;604.282533] Hardware name: Dell Inc. Inspiron 5576/0JW8XC,=
 BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.282534] Workqueue: async async_run_en=
try_fn<br>[ &nbsp;604.282540] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<b=
r>[ &nbsp;604.283454] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7=
 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54=
 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 =
0f<br>[ &nbsp;604.283456] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ =
&nbsp;604.283459] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX: 00000000=
00000000<br>[ &nbsp;604.283460] RDX: 0000000000000000 RSI: 0000000000000000=
 RDI: 0000000000000000<br>[ &nbsp;604.283461] RBP: ffffd4e34aa37ca8 R08: 00=
00000000000000 R09: 0000000000000000<br>[ &nbsp;604.283462] R10: 0000000000=
000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ &nbsp;604.283463] R=
13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000<br>[ &nbsp=
;604.283464] FS: &nbsp;0000000000000000(0000) GS:ffff8edf19670000(0000) knl=
GS:0000000000000000<br>[ &nbsp;604.283465] CS: &nbsp;0010 DS: 0000 ES: 0000=
 CR0: 0000000080050033<br>[ &nbsp;604.283467] CR2: 000064d8a61373c0 CR3: 00=
00000123a6b000 CR4: 00000000001506f0<br>[ &nbsp;604.283468] Call Trace:<br>=
[ &nbsp;604.283469] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.283473] &nbsp;amdgpu_=
fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ &nbsp;604.284377] &nbsp;? am=
dgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ &nbsp;604.285266] &nbsp;am=
dgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ &nbsp;604.286158] &nbsp;amdgp=
u_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.287044] &nbsp;pci_pm_susp=
end+0x85/0x1b0<br>[ &nbsp;604.287051] &nbsp;? __pfx_pci_pm_suspend+0x10/0x1=
0<br>[ &nbsp;604.287054] &nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;604.2=
87058] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;604.287061] &nbsp;async_=
suspend+0x21/0x40<br>[ &nbsp;604.287063] &nbsp;async_run_entry_fn+0x33/0x13=
0<br>[ &nbsp;604.287066] &nbsp;process_one_work+0x18e/0x370<br>[ &nbsp;604.=
287070] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp;604.287071] &nbsp;? __pf=
x_worker_thread+0x10/0x10<br>[ &nbsp;604.287073] &nbsp;kthread+0x10b/0x220<=
br>[ &nbsp;604.287076] &nbsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;604.2=
87079] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.287081] &nbsp;ret_fro=
m_fork+0x134/0x150<br>[ &nbsp;604.287084] &nbsp;? __pfx_kthread+0x10/0x10<b=
r>[ &nbsp;604.287086] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;604.2870=
90] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.287091] ---[ end trace 0000000000000=
000 ]---<br>[ &nbsp;604.287150] ------------[ cut here ]------------<br>[ &=
nbsp;604.287151] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.288065] Mod=
ules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs =
nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash al=
gif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_al=
c269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_l=
ib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd=
_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led=
 edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10=
k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backl=
ight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_he=
lper drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit b=
tusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundc=
ore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwm=
on sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fa=
m15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604.288124] &nbsp;joyde=
v input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstor=
e nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_ra=
id6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0=
 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_h=
id_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_=
hid vgastate hid wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ =
&nbsp;604.288157] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &=
nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-gen=
eric #9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;604.288161] Tainted: [P]=3DPRO=
PRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.288162] Hardwa=
re name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;6=
04.288163] Workqueue: async async_run_entry_fn<br>[ &nbsp;604.288168] RIP: =
0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.289092] Code: ff 84 c=
0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5=
c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb=
 ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.289095] RSP: 0018=
:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ &nbsp;604.289097] RAX: 000000000000=
0000 RBX: ffff8edc1d6adf08 RCX: 0000000000000000<br>[ &nbsp;604.289099] RDX=
: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ &nbsp;6=
04.289100] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000000000=
0<br>[ &nbsp;604.289101] R10: 0000000000000000 R11: 0000000000000000 R12: f=
fff8edc1d680000<br>[ &nbsp;604.289102] R13: 0000000000000000 R14: 000000000=
0000002 R15: 0000000000000000<br>[ &nbsp;604.289104] FS: &nbsp;000000000000=
0000(0000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<br>[ &nbsp;604.=
289105] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;6=
04.289106] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 00000000001506f=
0<br>[ &nbsp;604.289108] Call Trace:<br>[ &nbsp;604.289109] &nbsp;&lt;TASK&=
gt;<br>[ &nbsp;604.289113] &nbsp;amdgpu_fence_driver_hw_fini+0x11d/0x160 [a=
mdgpu]<br>[ &nbsp;604.290008] &nbsp;? amdgpu_ttm_evict_resources+0x39/0x70 =
[amdgpu]<br>[ &nbsp;604.290898] &nbsp;amdgpu_device_suspend+0x10a/0x170 [am=
dgpu]<br>[ &nbsp;604.291804] &nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<=
br>[ &nbsp;604.292693] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604.29270=
0] &nbsp;? __pfx_pci_pm_suspend+0x10/0x10<br>[ &nbsp;604.292703] &nbsp;dpm_=
run_callback+0x5f/0x160<br>[ &nbsp;604.292707] &nbsp;device_suspend+0x1e4/0=
x4e0<br>[ &nbsp;604.292710] &nbsp;async_suspend+0x21/0x40<br>[ &nbsp;604.29=
2712] &nbsp;async_run_entry_fn+0x33/0x130<br>[ &nbsp;604.292715] &nbsp;proc=
ess_one_work+0x18e/0x370<br>[ &nbsp;604.292718] &nbsp;worker_thread+0x317/0=
x450<br>[ &nbsp;604.292720] &nbsp;? __pfx_worker_thread+0x10/0x10<br>[ &nbs=
p;604.292722] &nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.292725] &nbsp;? reca=
lc_sigpending+0x76/0xb0<br>[ &nbsp;604.292727] &nbsp;? __pfx_kthread+0x10/0=
x10<br>[ &nbsp;604.292730] &nbsp;ret_from_fork+0x134/0x150<br>[ &nbsp;604.2=
92732] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.292735] &nbsp;ret_fro=
m_fork_asm+0x1a/0x30<br>[ &nbsp;604.292739] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;=
604.292740] ---[ end trace 0000000000000000 ]---<br>[ &nbsp;604.292797] ---=
---------[ cut here ]------------<br>[ &nbsp;604.292798] WARNING: CPU: 0 PI=
D: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/=
0xe0 [amdgpu]<br>[ &nbsp;604.293717] Modules linked in: btrfs blake2b_gener=
ic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_d=
ummy snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_mis=
c zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_=
scodec_component snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec=
_generic snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_inte=
l_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd =
snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass=
 snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm=
_ttm_helper ttm drm_exec drm_suballoc_helper drm_display_helper cec rc_core=
 snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm=
 btintel libarc4 platform_profile soundcore bluetooth rtsx_usb_ms dell_lapt=
op ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbi=
os dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell=
_rbtn<br>[ &nbsp;604.293776] &nbsp;joydev input_leds mac_hid sch_fq_codel p=
pdev lp msr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overl=
ay nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq asy=
nc_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic =
rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rts=
x_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci l=
ibahci uas usb_storage aesni_intel<br>[ &nbsp;604.293809] CPU: 0 UID: 0 PID=
: 6585 Comm: kworker/u16:21 Tainted: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O=
 &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<b=
r>[ &nbsp;604.293813] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3D=
OOT_MODULE<br>[ &nbsp;604.293814] Hardware name: Dell Inc. Inspiron 5576/0J=
W8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.293816] Workqueue: async async_r=
un_entry_fn<br>[ &nbsp;604.293821] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdg=
pu]<br>[ &nbsp;604.294743] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c =
89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec =
cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8=
d 00 0f<br>[ &nbsp;604.294746] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<=
br>[ &nbsp;604.294749] RAX: 0000000000000000 RBX: ffff8edc1d6adf08 RCX: 000=
0000000000000<br>[ &nbsp;604.294750] RDX: 0000000000000000 RSI: 00000000000=
00000 RDI: 0000000000000000<br>[ &nbsp;604.294751] RBP: ffffd4e34aa37ca8 R0=
8: 0000000000000000 R09: 0000000000000000<br>[ &nbsp;604.294752] R10: 00000=
00000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ &nbsp;604.2947=
53] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000<br>[ =
&nbsp;604.294754] FS: &nbsp;0000000000000000(0000) GS:ffff8edf19670000(0000=
) knlGS:0000000000000000<br>[ &nbsp;604.294756] CS: &nbsp;0010 DS: 0000 ES:=
 0000 CR0: 0000000080050033<br>[ &nbsp;604.294757] CR2: 000064d8a61373c0 CR=
3: 0000000123a6b000 CR4: 00000000001506f0<br>[ &nbsp;604.294758] Call Trace=
:<br>[ &nbsp;604.294759] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.294763] &nbsp;am=
dgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ &nbsp;604.295655] &nbsp=
;? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ &nbsp;604.296554] &nb=
sp;amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ &nbsp;604.297444] &nbsp;=
amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.298317] &nbsp;pci_pm=
_suspend+0x85/0x1b0<br>[ &nbsp;604.298321] &nbsp;? __pfx_pci_pm_suspend+0x1=
0/0x10<br>[ &nbsp;604.298324] &nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;=
604.298328] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;604.298331] &nbsp;a=
sync_suspend+0x21/0x40<br>[ &nbsp;604.298333] &nbsp;async_run_entry_fn+0x33=
/0x130<br>[ &nbsp;604.298336] &nbsp;process_one_work+0x18e/0x370<br>[ &nbsp=
;604.298339] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp;604.298341] &nbsp;?=
 __pfx_worker_thread+0x10/0x10<br>[ &nbsp;604.298343] &nbsp;kthread+0x10b/0=
x220<br>[ &nbsp;604.298346] &nbsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;=
604.298349] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.298351] &nbsp;re=
t_from_fork+0x134/0x150<br>[ &nbsp;604.298353] &nbsp;? __pfx_kthread+0x10/0=
x10<br>[ &nbsp;604.298366] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;604=
.298372] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.298373] ---[ end trace 00000000=
00000000 ]---<br>[ &nbsp;604.298431] ------------[ cut here ]------------<b=
r>[ &nbsp;604.298432] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/amd/amdg=
pu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.299345=
] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos=
 jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_ha=
sh algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_cod=
ec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec_real=
tek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_code=
c snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ct=
l_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi =
ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_=
backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suball=
oc_helper drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_=
bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile s=
oundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_sm=
m_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descript=
or fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604.299415] &nbsp;=
joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_=
pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 asy=
nc_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 =
raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 =
i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw=
 i2c_hid vgastate hid wmi realtek ahci libahci uas usb_storage aesni_intel<=
br>[ &nbsp;604.299448] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted=
: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-=
9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;604.299452] Tainted: [P]=
=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.299453] =
Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &=
nbsp;604.299454] Workqueue: async async_run_entry_fn<br>[ &nbsp;604.299459]=
 RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.300382] Code: f=
f 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5=
b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff=
 ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.300385] RSP=
: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ &nbsp;604.300388] RAX: 000000=
0000000000 RBX: ffff8edc1d6af6f8 RCX: 0000000000000000<br>[ &nbsp;604.30038=
9] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ &=
nbsp;604.300390] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 000000000=
0000000<br>[ &nbsp;604.300392] R10: 0000000000000000 R11: 0000000000000000 =
R12: ffff8edc1d680000<br>[ &nbsp;604.300393] R13: 0000000000000000 R14: 000=
0000000000002 R15: 0000000000000000<br>[ &nbsp;604.300394] FS: &nbsp;000000=
0000000000(0000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<br>[ &nbs=
p;604.300395] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ &=
nbsp;604.300396] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 000000000=
01506f0<br>[ &nbsp;604.300398] Call Trace:<br>[ &nbsp;604.300399] &nbsp;&lt=
;TASK&gt;<br>[ &nbsp;604.300403] &nbsp;amdgpu_fence_driver_hw_fini+0x11d/0x=
160 [amdgpu]<br>[ &nbsp;604.301294] &nbsp;? amdgpu_ttm_evict_resources+0x39=
/0x70 [amdgpu]<br>[ &nbsp;604.302194] &nbsp;amdgpu_device_suspend+0x10a/0x1=
70 [amdgpu]<br>[ &nbsp;604.303113] &nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [am=
dgpu]<br>[ &nbsp;604.304092] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604=
.304098] &nbsp;? __pfx_pci_pm_suspend+0x10/0x10<br>[ &nbsp;604.304100] &nbs=
p;dpm_run_callback+0x5f/0x160<br>[ &nbsp;604.304104] &nbsp;device_suspend+0=
x1e4/0x4e0<br>[ &nbsp;604.304107] &nbsp;async_suspend+0x21/0x40<br>[ &nbsp;=
604.304109] &nbsp;async_run_entry_fn+0x33/0x130<br>[ &nbsp;604.304112] &nbs=
p;process_one_work+0x18e/0x370<br>[ &nbsp;604.304116] &nbsp;worker_thread+0=
x317/0x450<br>[ &nbsp;604.304117] &nbsp;? __pfx_worker_thread+0x10/0x10<br>=
[ &nbsp;604.304119] &nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.304122] &nbsp;=
? recalc_sigpending+0x76/0xb0<br>[ &nbsp;604.304125] &nbsp;? __pfx_kthread+=
0x10/0x10<br>[ &nbsp;604.304127] &nbsp;ret_from_fork+0x134/0x150<br>[ &nbsp=
;604.304130] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.304132] &nbsp;r=
et_from_fork_asm+0x1a/0x30<br>[ &nbsp;604.304137] &nbsp;&lt;/TASK&gt;<br>[ =
&nbsp;604.304138] ---[ end trace 0000000000000000 ]---<br>[ &nbsp;604.30419=
5] ------------[ cut here ]------------<br>[ &nbsp;604.304196] WARNING: CPU=
: 0 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put=
+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.305131] Modules linked in: btrfs blake2b=
_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd=
_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binf=
mt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi sn=
d_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda=
_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg sn=
d_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kv=
m_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irq=
bypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_bud=
dy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_display_helper cec r=
c_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl=
 btbcm btintel libarc4 platform_profile soundcore bluetooth rtsx_usb_ms del=
l_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof del=
l_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbu=
s dell_rbtn<br>[ &nbsp;604.305192] &nbsp;joydev input_leds mac_hid sch_fq_c=
odel ppdev lp msr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4=
 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_=
pq async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_ge=
neric rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16=
fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek =
ahci libahci uas usb_storage aesni_intel<br>[ &nbsp;604.305227] CPU: 0 UID:=
 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &nbsp; &nbsp; &nbsp; &nbsp;W &=
nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu PREEMPT(volunt=
ary)<br>[ &nbsp;604.305231] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, =
[O]=3DOOT_MODULE<br>[ &nbsp;604.305232] Hardware name: Dell Inc. Inspiron 5=
576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.305233] Workqueue: async a=
sync_run_entry_fn<br>[ &nbsp;604.305239] RIP: 0010:amdgpu_irq_put+0xc4/0xe0=
 [amdgpu]<br>[ &nbsp;604.306233] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 =
de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff =
e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8=
d 14 8d 00 0f<br>[ &nbsp;604.306236] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 000=
10246<br>[ &nbsp;604.306238] RAX: 0000000000000000 RBX: ffff8edc1d6af6f8 RC=
X: 0000000000000000<br>[ &nbsp;604.306240] RDX: 0000000000000000 RSI: 00000=
00000000000 RDI: 0000000000000000<br>[ &nbsp;604.306241] RBP: ffffd4e34aa37=
ca8 R08: 0000000000000000 R09: 0000000000000000<br>[ &nbsp;604.306242] R10:=
 0000000000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ &nbsp;60=
4.306243] R13: 0000000000000000 R14: 0000000000000002 R15: 0000000000000000=
<br>[ &nbsp;604.306244] FS: &nbsp;0000000000000000(0000) GS:ffff8edf1967000=
0(0000) knlGS:0000000000000000<br>[ &nbsp;604.306245] CS: &nbsp;0010 DS: 00=
00 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;604.306246] CR2: 000064d8a6137=
3c0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ &nbsp;604.306248] Call=
 Trace:<br>[ &nbsp;604.306249] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.306253] &n=
bsp;amdgpu_fence_driver_hw_fini+0x11d/0x160 [amdgpu]<br>[ &nbsp;604.307150]=
 &nbsp;? amdgpu_ttm_evict_resources+0x39/0x70 [amdgpu]<br>[ &nbsp;604.30804=
4] &nbsp;amdgpu_device_suspend+0x10a/0x170 [amdgpu]<br>[ &nbsp;604.308934] =
&nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.309814] &nbsp;=
pci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604.309819] &nbsp;? __pfx_pci_pm_suspe=
nd+0x10/0x10<br>[ &nbsp;604.309822] &nbsp;dpm_run_callback+0x5f/0x160<br>[ =
&nbsp;604.309826] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;604.309828] &=
nbsp;async_suspend+0x21/0x40<br>[ &nbsp;604.309830] &nbsp;async_run_entry_f=
n+0x33/0x130<br>[ &nbsp;604.309834] &nbsp;process_one_work+0x18e/0x370<br>[=
 &nbsp;604.309837] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp;604.309839] &=
nbsp;? __pfx_worker_thread+0x10/0x10<br>[ &nbsp;604.309841] &nbsp;kthread+0=
x10b/0x220<br>[ &nbsp;604.309844] &nbsp;? recalc_sigpending+0x76/0xb0<br>[ =
&nbsp;604.309846] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.309848] &n=
bsp;ret_from_fork+0x134/0x150<br>[ &nbsp;604.309851] &nbsp;? __pfx_kthread+=
0x10/0x10<br>[ &nbsp;604.309853] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nb=
sp;604.309858] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.309859] ---[ end trace 00=
00000000000000 ]---<br>[ &nbsp;604.309916] ------------[ cut here ]--------=
----<br>[ &nbsp;604.309917] WARNING: CPU: 0 PID: 6585 at drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.=
310833] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix=
 msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac al=
gif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_h=
da_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_code=
c_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hd=
a_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm =
snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_ra=
wmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_=
panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_=
suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_timer i2c=
_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_pro=
file soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi d=
ell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_de=
scriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604.310893] =
&nbsp;joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parpor=
t efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid4=
56 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq =
raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video =
r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel ser=
io_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_storage aesni_=
intel<br>[ &nbsp;604.310926] CPU: 0 UID: 0 PID: 6585 Comm: kworker/u16:21 T=
ainted: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6=
.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;604.310930] Tainted=
: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.310=
931] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<b=
r>[ &nbsp;604.310932] Workqueue: async async_run_entry_fn<br>[ &nbsp;604.31=
0937] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.311850] Co=
de: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4=
 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea =
ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.311853=
] RSP: 0018:ffffd4e34aa37c88 EFLAGS: 00010246<br>[ &nbsp;604.311855] RAX: 0=
000000000000000 RBX: ffff8edc1d6af6f8 RCX: 0000000000000000<br>[ &nbsp;604.=
311856] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000<b=
r>[ &nbsp;604.311857] RBP: ffffd4e34aa37ca8 R08: 0000000000000000 R09: 0000=
000000000000<br>[ &nbsp;604.311858] R10: 0000000000000000 R11: 000000000000=
0000 R12: ffff8edc1d680000<br>[ &nbsp;604.311859] R13: 0000000000000000 R14=
: 0000000000000002 R15: 0000000000000000<br>[ &nbsp;604.311860] FS: &nbsp;0=
000000000000000(0000) GS:ffff8edf19670000(0000) knlGS:0000000000000000<br>[=
 &nbsp;604.311862] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 0000000080050033<b=
r>[ &nbsp;604.311863] CR2: 000064d8a61373c0 CR3: 0000000123a6b000 CR4: 0000=
0000001506f0<br>[ &nbsp;604.311864] Call Trace:<br>[ &nbsp;604.311866] &nbs=
p;&lt;TASK&gt;<br>[ &nbsp;604.311869] &nbsp;amdgpu_fence_driver_hw_fini+0x1=
1d/0x160 [amdgpu]<br>[ &nbsp;604.312766] &nbsp;? amdgpu_ttm_evict_resources=
+0x39/0x70 [amdgpu]<br>[ &nbsp;604.313662] &nbsp;amdgpu_device_suspend+0x10=
a/0x170 [amdgpu]<br>[ &nbsp;604.314562] &nbsp;amdgpu_pmops_suspend+0x3d/0xe=
0 [amdgpu]<br>[ &nbsp;604.315452] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ &nbs=
p;604.315457] &nbsp;? __pfx_pci_pm_suspend+0x10/0x10<br>[ &nbsp;604.315460]=
 &nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;604.315464] &nbsp;device_susp=
end+0x1e4/0x4e0<br>[ &nbsp;604.315466] &nbsp;async_suspend+0x21/0x40<br>[ &=
nbsp;604.315468] &nbsp;async_run_entry_fn+0x33/0x130<br>[ &nbsp;604.315472]=
 &nbsp;process_one_work+0x18e/0x370<br>[ &nbsp;604.315475] &nbsp;worker_thr=
ead+0x317/0x450<br>[ &nbsp;604.315477] &nbsp;? __pfx_worker_thread+0x10/0x1=
0<br>[ &nbsp;604.315478] &nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.315481] &=
nbsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;604.315483] &nbsp;? __pfx_kth=
read+0x10/0x10<br>[ &nbsp;604.315486] &nbsp;ret_from_fork+0x134/0x150<br>[ =
&nbsp;604.315489] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.315491] &n=
bsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;604.315495] &nbsp;&lt;/TASK&gt;<=
br>[ &nbsp;604.315497] ---[ end trace 0000000000000000 ]---<br>[ &nbsp;604.=
330697] ------------[ cut here ]------------<br>[ &nbsp;604.330700] WARNING=
: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_ir=
q_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.331627] Modules linked in: btrfs bl=
ake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcom=
m snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep=
 binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihd=
mi snd_hda_scodec_component snd_hda_codec_realtek_lib snd_hda_codec_hdmi sn=
d_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspc=
fg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_mi=
di kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core at=
h irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_quirks gpu_sched dr=
m_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper drm_display_helper =
cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk =
btrtl btbcm btintel libarc4 platform_profile soundcore bluetooth rtsx_usb_m=
s dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmo=
f dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c=
_smbus dell_rbtn<br>[ &nbsp;604.331689] &nbsp;joydev input_leds mac_hid sch=
_fq_codel ppdev lp msr parport_pc parport efi_pstore nfnetlink dmi_sysfs au=
tofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_recov async_memcpy a=
sync_pq async_xor async_tx xor raid6_pq raid1 raid0 linear hid_multitouch h=
id_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni =
vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid vgastate hid wmi rea=
ltek ahci libahci uas usb_storage aesni_intel<br>[ &nbsp;604.331725] CPU: 1=
 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &nbsp; &nbsp; &nbsp; &nbs=
p;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu PREEMPT(v=
oluntary)<br>[ &nbsp;604.331730] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DW=
ARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.331730] Hardware name: Dell Inc. Inspi=
ron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.331732] Workqueue: as=
ync async_run_entry_fn<br>[ &nbsp;604.331739] RIP: 0010:amdgpu_irq_put+0xc4=
/0xe0 [amdgpu]<br>[ &nbsp;604.332660] Code: ff 84 c0 75 85 eb 25 44 89 ea 4=
8 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 3=
1 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4=
 e9 8d 14 8d 00 0f<br>[ &nbsp;604.332662] RSP: 0018:ffffd4e34aa37c30 EFLAGS=
: 00010246<br>[ &nbsp;604.332665] RAX: 0000000000000000 RBX: ffff8edc1d6a5a=
38 RCX: 0000000000000000<br>[ &nbsp;604.332666] RDX: 0000000000000000 RSI: =
0000000000000000 RDI: 0000000000000000<br>[ &nbsp;604.332667] RBP: ffffd4e3=
4aa37c50 R08: 0000000000000000 R09: 0000000000000000<br>[ &nbsp;604.332668]=
 R10: 0000000000000000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ &nb=
sp;604.332669] R13: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8edc1d6=
80000<br>[ &nbsp;604.332671] FS: &nbsp;0000000000000000(0000) GS:ffff8edf19=
6f0000(0000) knlGS:0000000000000000<br>[ &nbsp;604.332672] CS: &nbsp;0010 D=
S: 0000 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;604.332673] CR2: 00005f77=
b6a8f7d0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>[ &nbsp;604.332675]=
 Call Trace:<br>[ &nbsp;604.332676] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.33268=
1] &nbsp;gfx_v8_0_hw_fini+0x2a/0x3a0 [amdgpu]<br>[ &nbsp;604.333595] &nbsp;=
gfx_v8_0_suspend+0xe/0x20 [amdgpu]<br>[ &nbsp;604.334511] &nbsp;amdgpu_ip_b=
lock_suspend+0x27/0x60 [amdgpu]<br>[ &nbsp;604.335403] &nbsp;amdgpu_device_=
ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]<br>[ &nbsp;604.336277] &nbsp;amdgpu_=
device_suspend+0x113/0x170 [amdgpu]<br>[ &nbsp;604.337160] &nbsp;amdgpu_pmo=
ps_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.338049] &nbsp;pci_pm_suspend+0=
x85/0x1b0<br>[ &nbsp;604.338054] &nbsp;? __pfx_pci_pm_suspend+0x10/0x10<br>=
[ &nbsp;604.338056] &nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;604.338060=
] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;604.338063] &nbsp;async_suspe=
nd+0x21/0x40<br>[ &nbsp;604.338065] &nbsp;async_run_entry_fn+0x33/0x130<br>=
[ &nbsp;604.338069] &nbsp;process_one_work+0x18e/0x370<br>[ &nbsp;604.33807=
2] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp;604.338074] &nbsp;? __pfx_wor=
ker_thread+0x10/0x10<br>[ &nbsp;604.338075] &nbsp;kthread+0x10b/0x220<br>[ =
&nbsp;604.338078] &nbsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;604.338081=
] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.338083] &nbsp;ret_from_for=
k+0x134/0x150<br>[ &nbsp;604.338086] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &=
nbsp;604.338088] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;604.338092] &=
nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.338093] ---[ end trace 0000000000000000 ]=
---<br>[ &nbsp;604.338150] ------------[ cut here ]------------<br>[ &nbsp;=
604.338151] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu/amdgpu_=
irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.339074] Modules =
linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs nls_u=
cs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash algif_s=
kcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_alc269 =
snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_lib sn=
d_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_=
core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led edac=
_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10k_pci=
 kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backlight_=
quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_helper =
drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit btusb =
cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundcore b=
luetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwmon sp=
arse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fam15h_=
power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604.339132] &nbsp;joydev inp=
ut_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstore nfn=
etlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_raid6_r=
ecov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 line=
ar hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_hid_ac=
pi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_hid v=
gastate hid wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ &nbsp=
;604.339165] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &nbsp;=
 &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-generic =
#9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;604.339169] Tainted: [P]=3DPROPRIET=
ARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.339170] Hardware na=
me: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;604.33=
9171] Workqueue: async async_run_entry_fn<br>[ &nbsp;604.339176] RIP: 0010:=
amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.340096] Code: ff 84 c0 75 =
85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 =
5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b=
8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.340098] RSP: 0018:ffff=
d4e34aa37c30 EFLAGS: 00010246<br>[ &nbsp;604.340101] RAX: 0000000000000000 =
RBX: ffff8edc1d6a5a50 RCX: 0000000000000000<br>[ &nbsp;604.340102] RDX: 000=
0000000000000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ &nbsp;604.34=
0103] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: 0000000000000000<br>=
[ &nbsp;604.340104] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8e=
dc1d680000<br>[ &nbsp;604.340105] R13: 0000000000000000 R14: ffff8edc1d6d0d=
88 R15: ffff8edc1d680000<br>[ &nbsp;604.340106] FS: &nbsp;0000000000000000(=
0000) GS:ffff8edf196f0000(0000) knlGS:0000000000000000<br>[ &nbsp;604.34010=
8] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;604.34=
0109] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 00000000001506f0<br>=
[ &nbsp;604.340111] Call Trace:<br>[ &nbsp;604.340112] &nbsp;&lt;TASK&gt;<b=
r>[ &nbsp;604.340115] &nbsp;gfx_v8_0_hw_fini+0x3b/0x3a0 [amdgpu]<br>[ &nbsp=
;604.341033] &nbsp;gfx_v8_0_suspend+0xe/0x20 [amdgpu]<br>[ &nbsp;604.341948=
] &nbsp;amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]<br>[ &nbsp;604.342836] &=
nbsp;amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]<br>[ &nbsp;604.34=
3723] &nbsp;amdgpu_device_suspend+0x113/0x170 [amdgpu]<br>[ &nbsp;604.34461=
9] &nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;604.345520] &nb=
sp;pci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604.345526] &nbsp;? __pfx_pci_pm_su=
spend+0x10/0x10<br>[ &nbsp;604.345529] &nbsp;dpm_run_callback+0x5f/0x160<br=
>[ &nbsp;604.345533] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;604.345535=
] &nbsp;async_suspend+0x21/0x40<br>[ &nbsp;604.345538] &nbsp;async_run_entr=
y_fn+0x33/0x130<br>[ &nbsp;604.345541] &nbsp;process_one_work+0x18e/0x370<b=
r>[ &nbsp;604.345545] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp;604.345546=
] &nbsp;? __pfx_worker_thread+0x10/0x10<br>[ &nbsp;604.345548] &nbsp;kthrea=
d+0x10b/0x220<br>[ &nbsp;604.345551] &nbsp;? recalc_sigpending+0x76/0xb0<br=
>[ &nbsp;604.345553] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.345556]=
 &nbsp;ret_from_fork+0x134/0x150<br>[ &nbsp;604.345558] &nbsp;? __pfx_kthre=
ad+0x10/0x10<br>[ &nbsp;604.345561] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ =
&nbsp;604.345565] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.345566] ---[ end trace=
 0000000000000000 ]---<br>[ &nbsp;604.345618] ------------[ cut here ]-----=
-------<br>[ &nbsp;604.345619] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm=
/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;6=
04.346540] Modules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs mi=
nix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac=
 algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu sn=
d_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_c=
odec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd=
_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_p=
cm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd=
_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 d=
rm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec d=
rm_suballoc_helper drm_display_helper cec rc_core snd_seq_device snd_timer =
i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_=
profile soundcore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wm=
i dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi=
_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;604.34659=
8] &nbsp;joydev input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc par=
port efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 ra=
id456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_=
pq raid1 raid0 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse vid=
eo r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel =
serio_raw i2c_hid vgastate hid wmi realtek ahci libahci uas usb_storage aes=
ni_intel<br>[ &nbsp;604.346631] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:2=
1 Tainted: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbs=
p;6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;604.346636] Tain=
ted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;604.=
346636] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/201=
8<br>[ &nbsp;604.346638] Workqueue: async async_run_entry_fn<br>[ &nbsp;604=
.346643] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;604.347566]=
 Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83=
 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 =
ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;604.347=
568] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246<br>[ &nbsp;604.347571] RAX=
: 0000000000000000 RBX: ffff8edc1d6a5a80 RCX: 0000000000000000<br>[ &nbsp;6=
04.347572] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000=
0<br>[ &nbsp;604.347573] RBP: ffffd4e34aa37c50 R08: 0000000000000000 R09: 0=
000000000000000<br>[ &nbsp;604.347574] R10: 0000000000000000 R11: 000000000=
0000000 R12: ffff8edc1d680000<br>[ &nbsp;604.347575] R13: 0000000000000000 =
R14: ffff8edc1d6d0d88 R15: ffff8edc1d680000<br>[ &nbsp;604.347577] FS: &nbs=
p;0000000000000000(0000) GS:ffff8edf196f0000(0000) knlGS:0000000000000000<b=
r>[ &nbsp;604.347578] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 000000008005003=
3<br>[ &nbsp;604.347579] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 0=
0000000001506f0<br>[ &nbsp;604.347581] Call Trace:<br>[ &nbsp;604.347582] &=
nbsp;&lt;TASK&gt;<br>[ &nbsp;604.347586] &nbsp;gfx_v8_0_hw_fini+0x4c/0x3a0 =
[amdgpu]<br>[ &nbsp;604.348508] &nbsp;gfx_v8_0_suspend+0xe/0x20 [amdgpu]<br=
>[ &nbsp;604.349417] &nbsp;amdgpu_ip_block_suspend+0x27/0x60 [amdgpu]<br>[ =
&nbsp;604.350300] &nbsp;amdgpu_device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu=
]<br>[ &nbsp;604.351188] &nbsp;amdgpu_device_suspend+0x113/0x170 [amdgpu]<b=
r>[ &nbsp;604.352081] &nbsp;amdgpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &n=
bsp;604.352969] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ &nbsp;604.352975] &nbs=
p;? __pfx_pci_pm_suspend+0x10/0x10<br>[ &nbsp;604.352977] &nbsp;dpm_run_cal=
lback+0x5f/0x160<br>[ &nbsp;604.352981] &nbsp;device_suspend+0x1e4/0x4e0<br=
>[ &nbsp;604.352984] &nbsp;async_suspend+0x21/0x40<br>[ &nbsp;604.352986] &=
nbsp;async_run_entry_fn+0x33/0x130<br>[ &nbsp;604.352989] &nbsp;process_one=
_work+0x18e/0x370<br>[ &nbsp;604.352993] &nbsp;worker_thread+0x317/0x450<br=
>[ &nbsp;604.352994] &nbsp;? __pfx_worker_thread+0x10/0x10<br>[ &nbsp;604.3=
52996] &nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.352999] &nbsp;? recalc_sigp=
ending+0x76/0xb0<br>[ &nbsp;604.353002] &nbsp;? __pfx_kthread+0x10/0x10<br>=
[ &nbsp;604.353004] &nbsp;ret_from_fork+0x134/0x150<br>[ &nbsp;604.353007] =
&nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.353009] &nbsp;ret_from_fork_=
asm+0x1a/0x30<br>[ &nbsp;604.353013] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;604.353=
014] ---[ end trace 0000000000000000 ]---<br>[ &nbsp;604.353064] ----------=
--[ cut here ]------------<br>[ &nbsp;604.353064] WARNING: CPU: 1 PID: 6585=
 at drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [a=
mdgpu]<br>[ &nbsp;604.353984] Modules linked in: btrfs blake2b_generic ufs =
qnx4 hfsplus hfs minix msdos jfs nls_ucs2_utils xfs rfcomm snd_seq_dummy sn=
d_hrtimer qrtr cmac algif_hash algif_skcipher af_alg bnep binfmt_misc zfs(P=
O) spl(O) amdgpu snd_hda_codec_alc269 snd_hda_codec_atihdmi snd_hda_scodec_=
component snd_hda_codec_realtek_lib snd_hda_codec_hdmi snd_hda_codec_generi=
c snd_hda_intel snd_hda_codec snd_hda_core snd_intel_dspcfg snd_intel_sdw_a=
cpi snd_hwdep snd_pcm snd_ctl_led edac_mce_amd snd_seq_midi kvm_amd snd_seq=
_midi_event ccp snd_rawmidi ath10k_pci kvm ath10k_core ath irqbypass snd_se=
q amdxcp mac80211 drm_panel_backlight_quirks gpu_sched drm_buddy drm_ttm_he=
lper ttm drm_exec drm_suballoc_helper drm_display_helper cec rc_core snd_se=
q_device snd_timer i2c_algo_bit btusb cfg80211 snd btmtk btrtl btbcm btinte=
l libarc4 platform_profile soundcore bluetooth rtsx_usb_ms dell_laptop ee10=
04 memstick dell_wmi dell_smm_hwmon sparse_keymap wmi_bmof dell_smbios dcdb=
as k10temp dell_wmi_descriptor fam15h_power i2c_piix4 i2c_smbus dell_rbtn<b=
r>[ &nbsp;604.354042] &nbsp;joydev input_leds mac_hid sch_fq_codel ppdev lp=
 msr parport_pc parport efi_pstore nfnetlink dmi_sysfs autofs4 overlay nls_=
iso8859_1 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor =
async_tx xor raid6_pq raid1 raid0 linear hid_multitouch hid_generic rtsx_us=
b_sdmmc psmouse video r8169 i2c_hid_acpi polyval_clmulni vga16fb rtsx_usb g=
hash_clmulni_intel serio_raw i2c_hid vgastate hid wmi realtek ahci libahci =
uas usb_storage aesni_intel<br>[ &nbsp;604.354074] CPU: 1 UID: 0 PID: 6585 =
Comm: kworker/u16:21 Tainted: P &nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp;=
 &nbsp; &nbsp; &nbsp;6.18.0-9-generic #9-Ubuntu PREEMPT(voluntary)<br>[ &nb=
sp;604.354078] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MOD=
ULE<br>[ &nbsp;604.354079] Hardware name: Dell Inc. Inspiron 5576/0JW8XC, B=
IOS 1.0.7 01/29/2018<br>[ &nbsp;604.354081] Workqueue: async async_run_entr=
y_fn<br>[ &nbsp;604.354086] RIP: 0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>=
[ &nbsp;604.355008] Code: ff 84 c0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e=
8 e1 fc ff ff 48 83 c4 08 5b 41 5c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c=
4 &lt;0f&gt; 0b b8 ea ff ff ff eb ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f=
<br>[ &nbsp;604.355010] RSP: 0018:ffffd4e34aa37c30 EFLAGS: 00010246<br>[ &n=
bsp;604.355013] RAX: 0000000000000000 RBX: ffff8edc1d6a5a98 RCX: 0000000000=
000000<br>[ &nbsp;604.355014] RDX: 0000000000000000 RSI: 0000000000000000 R=
DI: 0000000000000000<br>[ &nbsp;604.355015] RBP: ffffd4e34aa37c50 R08: 0000=
000000000000 R09: 0000000000000000<br>[ &nbsp;604.355016] R10: 000000000000=
0000 R11: 0000000000000000 R12: ffff8edc1d680000<br>[ &nbsp;604.355017] R13=
: 0000000000000000 R14: ffff8edc1d6d0d88 R15: ffff8edc1d680000<br>[ &nbsp;6=
04.355018] FS: &nbsp;0000000000000000(0000) GS:ffff8edf196f0000(0000) knlGS=
:0000000000000000<br>[ &nbsp;604.355019] CS: &nbsp;0010 DS: 0000 ES: 0000 C=
R0: 0000000080050033<br>[ &nbsp;604.355021] CR2: 00005f77b6a8f7d0 CR3: 0000=
000123a6b000 CR4: 00000000001506f0<br>[ &nbsp;604.355022] Call Trace:<br>[ =
&nbsp;604.355023] &nbsp;&lt;TASK&gt;<br>[ &nbsp;604.355027] &nbsp;gfx_v8_0_=
hw_fini+0x5d/0x3a0 [amdgpu]<br>[ &nbsp;604.355934] &nbsp;gfx_v8_0_suspend+0=
xe/0x20 [amdgpu]<br>[ &nbsp;604.356852] &nbsp;amdgpu_ip_block_suspend+0x27/=
0x60 [amdgpu]<br>[ &nbsp;604.357726] &nbsp;amdgpu_device_ip_suspend_phase2+=
0x1bc/0x3c0 [amdgpu]<br>[ &nbsp;604.358609] &nbsp;amdgpu_device_suspend+0x1=
13/0x170 [amdgpu]<br>[ &nbsp;604.359499] &nbsp;amdgpu_pmops_suspend+0x3d/0x=
e0 [amdgpu]<br>[ &nbsp;604.360391] &nbsp;pci_pm_suspend+0x85/0x1b0<br>[ &nb=
sp;604.360396] &nbsp;? __pfx_pci_pm_suspend+0x10/0x10<br>[ &nbsp;604.360399=
] &nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;604.360403] &nbsp;device_sus=
pend+0x1e4/0x4e0<br>[ &nbsp;604.360405] &nbsp;async_suspend+0x21/0x40<br>[ =
&nbsp;604.360408] &nbsp;async_run_entry_fn+0x33/0x130<br>[ &nbsp;604.360411=
] &nbsp;process_one_work+0x18e/0x370<br>[ &nbsp;604.360415] &nbsp;worker_th=
read+0x317/0x450<br>[ &nbsp;604.360416] &nbsp;? __pfx_worker_thread+0x10/0x=
10<br>[ &nbsp;604.360418] &nbsp;kthread+0x10b/0x220<br>[ &nbsp;604.360421] =
&nbsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;604.360424] &nbsp;? __pfx_kt=
hread+0x10/0x10<br>[ &nbsp;604.360426] &nbsp;ret_from_fork+0x134/0x150<br>[=
 &nbsp;604.360429] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;604.360431] &=
nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;604.360435] &nbsp;&lt;/TASK&gt;=
<br>[ &nbsp;604.360436] ---[ end trace 0000000000000000 ]---<br>[ &nbsp;604=
.600867] amdgpu 0000:03:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR=
* ring kiq_0.2.1.0 test failed (-110)<br>[ &nbsp;604.601775] [drm:gfx_v8_0_=
hw_fini [amdgpu]] *ERROR* KCQ disable failed<br>[ &nbsp;604.837747] amdgpu:=
 cp is busy, skip halt cp<br>[ &nbsp;605.072838] amdgpu: rlc is busy, skip =
halt rlc<br>[ &nbsp;605.073900] ------------[ cut here ]------------<br>[ &=
nbsp;605.073901] WARNING: CPU: 1 PID: 6585 at drivers/gpu/drm/amd/amdgpu/am=
dgpu_irq.c:639 amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;605.074834] Mod=
ules linked in: btrfs blake2b_generic ufs qnx4 hfsplus hfs minix msdos jfs =
nls_ucs2_utils xfs rfcomm snd_seq_dummy snd_hrtimer qrtr cmac algif_hash al=
gif_skcipher af_alg bnep binfmt_misc zfs(PO) spl(O) amdgpu snd_hda_codec_al=
c269 snd_hda_codec_atihdmi snd_hda_scodec_component snd_hda_codec_realtek_l=
ib snd_hda_codec_hdmi snd_hda_codec_generic snd_hda_intel snd_hda_codec snd=
_hda_core snd_intel_dspcfg snd_intel_sdw_acpi snd_hwdep snd_pcm snd_ctl_led=
 edac_mce_amd snd_seq_midi kvm_amd snd_seq_midi_event ccp snd_rawmidi ath10=
k_pci kvm ath10k_core ath irqbypass snd_seq amdxcp mac80211 drm_panel_backl=
ight_quirks gpu_sched drm_buddy drm_ttm_helper ttm drm_exec drm_suballoc_he=
lper drm_display_helper cec rc_core snd_seq_device snd_timer i2c_algo_bit b=
tusb cfg80211 snd btmtk btrtl btbcm btintel libarc4 platform_profile soundc=
ore bluetooth rtsx_usb_ms dell_laptop ee1004 memstick dell_wmi dell_smm_hwm=
on sparse_keymap wmi_bmof dell_smbios dcdbas k10temp dell_wmi_descriptor fa=
m15h_power i2c_piix4 i2c_smbus dell_rbtn<br>[ &nbsp;605.074894] &nbsp;joyde=
v input_leds mac_hid sch_fq_codel ppdev lp msr parport_pc parport efi_pstor=
e nfnetlink dmi_sysfs autofs4 overlay nls_iso8859_1 raid10 raid456 async_ra=
id6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0=
 linear hid_multitouch hid_generic rtsx_usb_sdmmc psmouse video r8169 i2c_h=
id_acpi polyval_clmulni vga16fb rtsx_usb ghash_clmulni_intel serio_raw i2c_=
hid vgastate hid wmi realtek ahci libahci uas usb_storage aesni_intel<br>[ =
&nbsp;605.074929] CPU: 1 UID: 0 PID: 6585 Comm: kworker/u16:21 Tainted: P &=
nbsp; &nbsp; &nbsp; &nbsp;W &nbsp;O &nbsp; &nbsp; &nbsp; &nbsp;6.18.0-9-gen=
eric #9-Ubuntu PREEMPT(voluntary)<br>[ &nbsp;605.074934] Tainted: [P]=3DPRO=
PRIETARY_MODULE, [W]=3DWARN, [O]=3DOOT_MODULE<br>[ &nbsp;605.074935] Hardwa=
re name: Dell Inc. Inspiron 5576/0JW8XC, BIOS 1.0.7 01/29/2018<br>[ &nbsp;6=
05.074936] Workqueue: async async_run_entry_fn<br>[ &nbsp;605.074942] RIP: =
0010:amdgpu_irq_put+0xc4/0xe0 [amdgpu]<br>[ &nbsp;605.075902] Code: ff 84 c=
0 75 85 eb 25 44 89 ea 48 89 de 4c 89 e7 e8 e1 fc ff ff 48 83 c4 08 5b 41 5=
c 41 5d 5d 31 d2 31 f6 31 ff e9 ec cd 54 c4 &lt;0f&gt; 0b b8 ea ff ff ff eb=
 ab b8 fe ff ff ff eb a4 e9 8d 14 8d 00 0f<br>[ &nbsp;605.075904] RSP: 0018=
:ffffd4e34aa37c50 EFLAGS: 00010246<br>[ &nbsp;605.075907] RAX: 000000000000=
0000 RBX: ffff8edc1d680c70 RCX: 0000000000000000<br>[ &nbsp;605.075908] RDX=
: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000<br>[ &nbsp;6=
05.075909] RBP: ffffd4e34aa37c70 R08: 0000000000000000 R09: 000000000000000=
0<br>[ &nbsp;605.075910] R10: 0000000000000000 R11: 0000000000000000 R12: f=
fff8edc1d680000<br>[ &nbsp;605.075911] R13: 0000000000000000 R14: ffff8edc1=
d6d0d58 R15: ffff8edc1d680000<br>[ &nbsp;605.075913] FS: &nbsp;000000000000=
0000(0000) GS:ffff8edf196f0000(0000) knlGS:0000000000000000<br>[ &nbsp;605.=
075914] CS: &nbsp;0010 DS: 0000 ES: 0000 CR0: 0000000080050033<br>[ &nbsp;6=
05.075915] CR2: 00005f77b6a8f7d0 CR3: 0000000123a6b000 CR4: 00000000001506f=
0<br>[ &nbsp;605.075917] Call Trace:<br>[ &nbsp;605.075918] &nbsp;&lt;TASK&=
gt;<br>[ &nbsp;605.075919] &nbsp;? delay_halt.part.0+0x3e/0x70<br>[ &nbsp;6=
05.075927] &nbsp;gmc_v8_0_hw_fini+0x1f/0xb0 [amdgpu]<br>[ &nbsp;605.076856]=
 &nbsp;gmc_v8_0_suspend+0xe/0x20 [amdgpu]<br>[ &nbsp;605.077781] &nbsp;amdg=
pu_ip_block_suspend+0x27/0x60 [amdgpu]<br>[ &nbsp;605.078676] &nbsp;amdgpu_=
device_ip_suspend_phase2+0x1bc/0x3c0 [amdgpu]<br>[ &nbsp;605.079560] &nbsp;=
amdgpu_device_suspend+0x113/0x170 [amdgpu]<br>[ &nbsp;605.080438] &nbsp;amd=
gpu_pmops_suspend+0x3d/0xe0 [amdgpu]<br>[ &nbsp;605.081318] &nbsp;pci_pm_su=
spend+0x85/0x1b0<br>[ &nbsp;605.081323] &nbsp;? __pfx_pci_pm_suspend+0x10/0=
x10<br>[ &nbsp;605.081326] &nbsp;dpm_run_callback+0x5f/0x160<br>[ &nbsp;605=
.081330] &nbsp;device_suspend+0x1e4/0x4e0<br>[ &nbsp;605.081332] &nbsp;asyn=
c_suspend+0x21/0x40<br>[ &nbsp;605.081335] &nbsp;async_run_entry_fn+0x33/0x=
130<br>[ &nbsp;605.081339] &nbsp;process_one_work+0x18e/0x370<br>[ &nbsp;60=
5.081342] &nbsp;worker_thread+0x317/0x450<br>[ &nbsp;605.081344] &nbsp;? __=
pfx_worker_thread+0x10/0x10<br>[ &nbsp;605.081345] &nbsp;kthread+0x10b/0x22=
0<br>[ &nbsp;605.081348] &nbsp;? recalc_sigpending+0x76/0xb0<br>[ &nbsp;605=
.081351] &nbsp;? __pfx_kthread+0x10/0x10<br>[ &nbsp;605.081353] &nbsp;ret_f=
rom_fork+0x134/0x150<br>[ &nbsp;605.081368] &nbsp;? __pfx_kthread+0x10/0x10=
<br>[ &nbsp;605.081371] &nbsp;ret_from_fork_asm+0x1a/0x30<br>[ &nbsp;605.08=
1375] &nbsp;&lt;/TASK&gt;<br>[ &nbsp;605.081376] ---[ end trace 00000000000=
00000 ]---<br>[ &nbsp;605.083479] amdgpu 0000:03:00.0: amdgpu: PCI CONFIG r=
eset<br>[ &nbsp;605.083699] ACPI: EC: interrupt blocked<br>[ &nbsp;605.1096=
49] ACPI: PM: Preparing to enter system sleep state S3<br>[ &nbsp;605.43528=
0] ACPI Warning: Time parameter 120 us &gt; 100 us violating ACPI spec, ple=
ase fix the firmware. (20250807/exsystem-142)<br>[ &nbsp;605.436113] ACPI: =
EC: event blocked<br>[ &nbsp;605.436114] ACPI: EC: EC stopped<br>[ &nbsp;60=
5.436115] ACPI: PM: Saving platform NVS memory<br>[ &nbsp;605.436214] Disab=
ling non-boot CPUs ...<br>[ &nbsp;605.438631] smpboot: CPU 3 is now offline=
<br>[ &nbsp;605.442252] smpboot: CPU 2 is now offline<br>[ &nbsp;605.445111=
] smpboot: CPU 1 is now offline<br>[ &nbsp;605.447033] ACPI: PM: Low-level =
resume complete<br>[ &nbsp;605.447067] ACPI: EC: EC started<br>[ &nbsp;605.=
447069] ACPI: PM: Restoring platform NVS memory<br>[ &nbsp;605.447227] AMD-=
Vi: Virtual APIC enabled<br>[ &nbsp;605.447251] AMD-Vi: Virtual APIC enable=
d<br>[ &nbsp;605.447254] LVT offset 0 assigned for vector 0x400<br>[ &nbsp;=
605.447757] Enabling non-boot CPUs ...<br>[ &nbsp;605.447830] smpboot: Boot=
ing Node 0 Processor 1 APIC 0x11<br>[ &nbsp;605.451533] CPU1 is up<br>[ &nb=
sp;605.451598] smpboot: Booting Node 0 Processor 2 APIC 0x12<br>[ &nbsp;605=
.455447] CPU2 is up<br>[ &nbsp;605.455507] smpboot: Booting Node 0 Processo=
r 3 APIC 0x13<br>[ &nbsp;605.459382] CPU3 is up<br>[ &nbsp;605.460791] ACPI=
: PM: Waking up from system sleep state S3<br>[ &nbsp;605.512016] ACPI: EC:=
 interrupt unblocked<br>[ &nbsp;605.518861] [drm] PCIE GART of 1024M enable=
d (table at 0x000000F400A00000).<br>[ &nbsp;605.518874] ACPI: EC: event unb=
locked<br>[ &nbsp;605.518899] amdgpu: smu version 27.17.00<br>[ &nbsp;605.5=
36571] [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).<br>[ =
&nbsp;605.551074] [drm] UVD initialized successfully.<br>[ &nbsp;605.718769=
] [drm] UVD and UVD ENC initialized successfully.<br>[ &nbsp;605.752031] [d=
rm] VCE initialized successfully.<br>[ &nbsp;605.763611] usb 1-2: reset hig=
h-speed USB device number 2 using xhci_hcd<br>[ &nbsp;605.773339] usb 2-1.4=
: reset high-speed USB device number 4 using ehci-pci<br>[ &nbsp;605.819760=
] [drm] VCE initialized successfully.<br>[ &nbsp;605.939506] usb 2-1.2: res=
et full-speed USB device number 3 using ehci-pci<br>[ &nbsp;605.984372] ata=
1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)<br>[ &nbsp;605.986837] =
sd 1:0:0:0: [sda] Starting disk<br>[ &nbsp;605.990324] ata1.00: configured =
for UDMA/133<br>[ &nbsp;606.034393] OOM killer enabled.<br>[ &nbsp;606.0344=
00] Restarting tasks: Starting<br>[ &nbsp;606.036871] Restarting tasks: Don=
e<br>[ &nbsp;606.036937] random: crng reseeded on system resumption<br>[ &n=
bsp;606.037313] Bluetooth: hci0: using rampatch file: qca/rampatch_usb_0000=
0302.bin<br>[ &nbsp;606.037348] Bluetooth: hci0: QCA: patch rome 0x302 buil=
d 0x3e8, firmware rome 0x302 build 0x111<br>[ &nbsp;606.049086] PM: suspend=
 exit<br>[ &nbsp;606.325705] Generic FE-GE Realtek PHY r8169-0-200:00: atta=
ched PHY driver (mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)<br>[ &nbsp;6=
06.403987] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin<br>[ &=
nbsp;606.426895] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection=
 command is advertised, but not supported.<br>[ &nbsp;606.481379] r8169 000=
0:02:00.0 enp2s0: Link is Down<br>[ &nbsp;606.673801] Bluetooth: MGMT ver 1=
.23<br>[ &nbsp;606.684146] kauditd_printk_skb: 6 callbacks suppressed<br>[ =
&nbsp;606.684153] audit: type=3D1400 audit(1770175422.234:141): apparmor=3D=
"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubun=
tu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6784 comm=3D"pvscan=
" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0=
 ouid=3D0 olabel=3D"unconfined"<br>[ &nbsp;606.684159] audit: type=3D1400 a=
udit(1770175422.234:142): apparmor=3D"ALLOWED" operation=3D"getattr" class=
=3D"posix_mqueue" profile=3D"snap.ubuntu-desktop-bootstrap.subiquity-server=
" name=3D"/" pid=3D6784 comm=3D"pvscan" requested=3D"getattr" denied=3D"get=
attr" class=3D"posix_mqueue" fsuid=3D0 ouid=3D0 olabel=3D"unconfined"<br>[ =
&nbsp;606.684162] audit: type=3D1400 audit(1770175422.234:143): apparmor=3D=
"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubun=
tu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6784 comm=3D"pvscan=
" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0=
 ouid=3D0 olabel=3D"unconfined"<br>[ &nbsp;606.684165] audit: type=3D1400 a=
udit(1770175422.234:144): apparmor=3D"ALLOWED" operation=3D"getattr" class=
=3D"posix_mqueue" profile=3D"snap.ubuntu-desktop-bootstrap.subiquity-server=
" name=3D"/" pid=3D6784 comm=3D"pvscan" requested=3D"getattr" denied=3D"get=
attr" class=3D"posix_mqueue" fsuid=3D0 ouid=3D0 olabel=3D"unconfined"<br>[ =
&nbsp;606.763476] audit: type=3D1400 audit(1770175422.314:145): apparmor=3D=
"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubun=
tu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6789 comm=3D"vgscan=
" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0=
 ouid=3D0 olabel=3D"unconfined"<br>[ &nbsp;606.763489] audit: type=3D1400 a=
udit(1770175422.314:146): apparmor=3D"ALLOWED" operation=3D"getattr" class=
=3D"posix_mqueue" profile=3D"snap.ubuntu-desktop-bootstrap.subiquity-server=
" name=3D"/" pid=3D6789 comm=3D"vgscan" requested=3D"getattr" denied=3D"get=
attr" class=3D"posix_mqueue" fsuid=3D0 ouid=3D0 olabel=3D"unconfined"<br>[ =
&nbsp;606.763492] audit: type=3D1400 audit(1770175422.314:147): apparmor=3D=
"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubun=
tu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6789 comm=3D"vgscan=
" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=3D0=
 ouid=3D0 olabel=3D"unconfined"<br>[ &nbsp;606.763494] audit: type=3D1400 a=
udit(1770175422.314:148): apparmor=3D"ALLOWED" operation=3D"getattr" class=
=3D"posix_mqueue" profile=3D"snap.ubuntu-desktop-bootstrap.subiquity-server=
" name=3D"/" pid=3D6789 comm=3D"vgscan" requested=3D"getattr" denied=3D"get=
attr" class=3D"posix_mqueue" fsuid=3D0 ouid=3D0 olabel=3D"unconfined"<br>[ =
&nbsp;606.857207] audit: type=3D1400 audit(1770175422.407:149): apparmor=3D=
"ALLOWED" operation=3D"getattr" class=3D"posix_mqueue" profile=3D"snap.ubun=
tu-desktop-bootstrap.subiquity-server" name=3D"/" pid=3D6790 comm=3D"vgchan=
ge" requested=3D"getattr" denied=3D"getattr" class=3D"posix_mqueue" fsuid=
=3D0 ouid=3D0 olabel=3D"unconfined"<br>[ &nbsp;606.857221] audit: type=3D14=
00 audit(1770175422.407:150): apparmor=3D"ALLOWED" operation=3D"getattr" cl=
ass=3D"posix_mqueue" profile=3D"snap.ubuntu-desktop-bootstrap.subiquity-ser=
ver" name=3D"/" pid=3D6790 comm=3D"vgchange" requested=3D"getattr" denied=
=3D"getattr" class=3D"posix_mqueue" fsuid=3D0 ouid=3D0 olabel=3D"unconfined=
"<br>ubuntu@ubuntu:~$</div><div><br></div></div><div class=3D"ydp35a41134yj=
6qo"></div><div class=3D"ydp35a41134adL"></div></div></div></div><div class=
=3D"ydp35a41134WhmR8e" data-hash=3D"0" id=3D"ydp35a41134avWBGd-83" style=3D=
"clear: both;"></div></div></div></div><br></div></div></body></html>
------=_Part_519739_1133768246.1770215959880--
