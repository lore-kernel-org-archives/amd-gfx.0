Return-Path: <SRS0=Ppqo=2W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F569C2D0DC
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2020 09:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8A27206DB
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jan 2020 09:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="EmLcRTdb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A27206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E34D89491;
	Wed,  1 Jan 2020 09:36:13 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Wed, 01 Jan 2020 09:36:11 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9223389491
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jan 2020 09:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1577871369;
 bh=FbO2DJrR964d1vT40CDiKnTheSgkCoUN9WYuJQr0UcU=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=EmLcRTdbiNTw27ev9AYyKxdSQtibs4MEUvh+HLKYbaVdxT5x+kDVe6moJGfY6tdXD
 MLyo2yQBEJNLvg11d+Pddl8PfrAL3dG5W3bb+7UYn09MyQ4deQBFntuRppyNpmFh6/
 BGXXqDMTu+m+0BqydY0k6oK25NkYv/a2bzOuoCNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MF3He-1ixZlh08fg-00FUQm for
 <amd-gfx@lists.freedesktop.org>; Wed, 01 Jan 2020 10:31:05 +0100
To: amd-gfx@lists.freedesktop.org
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: eGPU failed to initialize
Message-ID: <5cf8e6e2-7ec5-1412-f82d-462e9e15a8aa@gmx.com>
Date: Wed, 1 Jan 2020 17:31:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
X-Provags-ID: V03:K1:eAhHIk5tHlSBANhR+QgQMJ/kw+x149gv3pQAlMkD+Jkw/2wm4Us
 x2VNsMT6I5ihdl/TttW9q79jX24/uMjZGugUNyQ8ApioOxss5XfHSkCw6zBKx15HsMKQ2ZV
 hp7tMfwh4xM9jI+rvd6LraiOwRdQAZvUKoJSCxgS5Y5wqofCv6gLwwHN5ispBSaqjCNLQBI
 Gjvly36cNIrWeg8T5qdRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CHW5rRoJWMg=:m2Pq6oHMGJvNePsyneU+vK
 5W2TK+ATkFZTJhSWnnmnkaK6FIkcB5BfnfC6Bg5AC8/BDFALP8ENRvTg4W2TPvxUlmbDSfjIT
 rdK83YzVODA0Z4VvVM4VaQL7r08j71ma6RPfce+PPSQmUarcY9q/8D5LRQnWbPQgRrY74/Sg0
 PIUOZD0CVl2IgQXPMB/2txp2oPuy0vRx9YZy5xh3NLv9+IoCy2tnrd9N/uscRt5PtCeRaQOsq
 qQA1+mAZmfuv18tZP6lsR9SCoasZEKwGiAgr2l5M9w9f7JcKb75p5fnYo1XO32AuIgONBTv5Q
 nw5cdgpCSGu1ldN/T8Mqgin+MNUhbSff7TQ542Cg7flxfQFLW+OeLFz3xFmz5pMGzQAOYQixX
 aCWfJNTey12NTOaqI5Th5oJg64h6ZFRthZxCHYRgiOJK6GsmtXv9eTzHTzFNKcWFh7UCQ26Sa
 gkBFYlF5/ldMtsInNIt4/yFs6FKwPmXAbgSdH/SMdjLNh8Vn6A0hcc2gK9ZOoarEgAmyHrPrL
 +mZ4iODtWd9I3eqbOhQJboK8uwSfNdVFFD2WolORUhBdJ3jWXb19GKKyJpaDn22MgWgH2vVWV
 T1QXCHePEufnj1/iDDS3oL51tH6FJcYb+EDv0in3D9Xv4r2ECOjUTWQOlUjfX56Bp6r5RaooC
 RoKGVGurB2IObKY2O1ldNGdCCGYY/tM8tg4KuvFe2r6Zuek+78OUNPKXh+EDNbqAzkSTQ93tk
 jy/iFbUXXR38D42YJWyP0yMTUSGo+CncotgbTr540ABnlCUEBzwpn46MmCvn14umLp7OTTUjo
 B6cZTAZGVsyIz9MWojGBtD9rZAOz9zMuILtblBcFBoqqHnuTAN2cwDSprTze++eTnMVZ8fl8L
 1/lFmJQn+ghf+3FfhTTtYTVR1BVC30dnLCy+/xcbkgr6yAUzgbgVwUfxItjl5mLrvjeXxtz6J
 G0P4ivwHp1n0hMLWwzFmFKs//GLgNrKlOUTJb9qygFgEynzeOx1YtBOlWjkJjidpc+aBKFKk2
 HShvW5Ap7u0GSCIb/h8A/j1ihuP/TAKuDyC6RjuHoF8IAmkGAG1AKc5wDTeV8nD1FOZAdWW5u
 nR4MWfDMDaxstUdWdKVciLO2NlrUfmZ771JtFYV6H2lIqpnOokw5PzlUIrgYqxzuR5JR8Zzp+
 0FPq/b8ONUgwUVho5lr583enLWtKGAI+30VL2Hdl8llOfnwPikcsl0Vt/QlijDoBBsiT4q4iC
 x1w6DupORNks0fU6qHUcAc7Z+t7uuHp8YtG+1HImReB106ywsasouZgFqoVM=
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
Content-Type: multipart/mixed; boundary="===============1645281364=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1645281364==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Xq3sXn4bbz6mZ2b0duEjbcHY33riY564H"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xq3sXn4bbz6mZ2b0duEjbcHY33riY564H
Content-Type: multipart/mixed; boundary="yHUS028Vv8cEe5HFEXwh4d8G6JExx6nck"

--yHUS028Vv8cEe5HFEXwh4d8G6JExx6nck
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

Not sure if this is reported before, but amdgpu is initialized for an
external GPU (thunderbolt 3), which is not accessible at boot, only
after boltctl initialized the tb3 subsystem.

Then amdgpu will report an timeout, and failed to really initialize the G=
PU.
At this stage, one my of monitors (U2414H, DP) reports unsupported
framerate, while the other monitor (HP 24mh, HDMI) just reports no signal=


The involved GPU is RX580. The tb3 enclosure is AORUS GAMING BOX.

And obviously, this eGPU works pretty fine under Windows.
So my normal boot routine needs to boot into windows, then reboot into
Linux without unplug the tb3 connector, to make the eGPU work under Linux=
=2E

The kernel warning is:
Jan 01 07:22:25 thinkpad kernel: [drm] REG_WAIT timeout 10us * 3500
tries - dce_mi_free_dmif line:634
Jan 01 07:22:25 thinkpad kernel: ------------[ cut here ]------------
Jan 01 07:22:25 thinkpad kernel: WARNING: CPU: 6 PID: 804 at
drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:332
generic_reg_wait.cold+0x25/0x2c [amdgpu]
Jan 01 07:22:25 thinkpad kernel: Modules linked in: xt_CHECKSUM
xt_MASQUERADE xt_conntrack ipt_REJECT tun bridge stp llc nf_tables_set
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct amdgpu nft_chain_nat msr
nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle
ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle
gpu_sched iptable_raw ttm iptable_security nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 xt_tcpudp ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter cmac algif_hash algif_skcipher
af_alg bnep joydev mousedev btrfs xor rmi_smbus rmi_core
snd_hda_codec_hdmi iTCO_wdt mei_wdt mei_hdcp iTCO_vendor_support
snd_hda_codec_realtek intel_rapl_msr wmi_bmof raid6_pq
intel_wmi_thunderbolt iwlmvm snd_hda_codec_generic x86_pkg_temp_thermal
intel_powerclamp snd_hda_intel coretemp snd_intel_nhlt mac80211
kvm_intel snd_hda_codec nls_iso8859_1 libarc4 uvcvideo nls_cp437
intel_cstate btusb snd_hda_core
Jan 01 07:22:25 thinkpad kernel:  vfat videobuf2_vmalloc intel_uncore
btrtl snd_hwdep btbcm iwlwifi videobuf2_memops intel_rapl_perf fat
videobuf2_v4l2 btintel snd_pcm pcspkr psmouse input_leds
videobuf2_common mei_me e1000e i2c_i801 snd_timer thunderbolt bluetooth
cfg80211 videodev mei thinkpad_acpi intel_xhci_usb_role_switch
processor_thermal_device ucsi_acpi ecdh_generic mc nvram ecc
intel_rapl_common intel_soc_dts_iosf crc16 intel_pch_thermal roles
typec_ucsi ledtrig_audio rfkill typec snd int3403_thermal wmi soundcore
battery ac int340x_thermal_zone i2c_hid hid evdev int3400_thermal
mac_hid acpi_thermal_rel crypto_user acpi_call(OE) kvmgt i915 vfio_mdev
mdev vfio_iommu_type1 vfio i2c_algo_bit drm_kms_helper drm intel_gtt
agpgart syscopyarea sysfillrect sysimgblt fb_sys_fops kvm irqbypass
ip_tables x_tables xfs libcrc32c crc32c_generic sd_mod uas usb_storage
scsi_mod dm_crypt crct10dif_pclmul crc32_pclmul crc32c_intel
ghash_clmulni_intel dm_mod serio_raw atkbd libps2 aesni_intel
crypto_simd xhci_pci cryptd
Jan 01 07:22:25 thinkpad kernel:  glue_helper xhci_hcd i8042 serio
Jan 01 07:22:25 thinkpad kernel: CPU: 6 PID: 804 Comm: Xorg Tainted: G
  U     OE     5.4.6-arch3-1 #1
Jan 01 07:22:25 thinkpad kernel: Hardware name: LENOVO
20KHCTO1WW/20KHCTO1WW, BIOS N23ET68W (1.43 ) 10/16/2019
Jan 01 07:22:25 thinkpad kernel: RIP:
0010:generic_reg_wait.cold+0x25/0x2c [amdgpu]
Jan 01 07:22:25 thinkpad kernel: Code: e9 82 23 fe ff 44 8b 44 24 24 48
8b 4c 24 18 44 89 fa 89 ee 48 c7 c7 50 73 ab c1 e8 96 5d 92 ef 83 7b 20
01 0f 84 48 31 fe ff <0f> 0b e9 41 31 fe ff e8 b2 16 e7 ff 48 c7 c7 00
50 b7 c1 e8 e6 8e
Jan 01 07:22:25 thinkpad kernel: RSP: 0018:ffff9e61c147b5c8 EFLAGS: 00010=
297
Jan 01 07:22:25 thinkpad kernel: RAX: 0000000000000044 RBX:
ffff95854881e200 RCX: 0000000000000000
Jan 01 07:22:25 thinkpad kernel: RDX: 0000000000000000 RSI:
ffff95854e397708 RDI: 00000000ffffffff
Jan 01 07:22:25 thinkpad kernel: RBP: 000000000000000a R08:
0000000000000507 R09: 0000000000000004
Jan 01 07:22:25 thinkpad kernel: R10: 0000000000000000 R11:
0000000000000001 R12: 0000000000000322
Jan 01 07:22:25 thinkpad kernel: R13: 0000000000000dad R14:
0000000000000001 R15: 0000000000000dac
Jan 01 07:22:25 thinkpad kernel: FS:  00007f9e87acbdc0(0000)
GS:ffff95854e380000(0000) knlGS:0000000000000000
Jan 01 07:22:25 thinkpad kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Jan 01 07:22:25 thinkpad kernel: CR2: 00007f9e831de5b0 CR3:
00000004893f4006 CR4: 00000000003606e0
Jan 01 07:22:25 thinkpad kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
Jan 01 07:22:25 thinkpad kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
Jan 01 07:22:25 thinkpad kernel: Call Trace:
Jan 01 07:22:25 thinkpad kernel:  dce_mi_free_dmif+0xf7/0x160 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  dce110_reset_hw_ctx_wrap+0x193/0x260
[amdgpu]
Jan 01 07:22:25 thinkpad kernel:  dce110_apply_ctx_to_hw+0x51/0x5d0 [amdg=
pu]
Jan 01 07:22:25 thinkpad kernel:  ?
dce110_apply_ctx_for_surface+0x22e/0x2c0 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  dc_commit_state+0x280/0x5e0 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:
amdgpu_dm_atomic_commit_tail+0x1151/0x1da0 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  ? __mod_zone_page_state+0x66/0xa0
Jan 01 07:22:25 thinkpad kernel:  ? dm_read_reg_func+0x1f/0x90 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  ?
dce110_timing_generator_get_position+0x55/0x60 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  ? dm_crtc_get_scanoutpos+0x85/0xe0
[amdgpu]
Jan 01 07:22:25 thinkpad kernel:  ? commit_tail+0x94/0x110 [drm_kms_helpe=
r]
Jan 01 07:22:25 thinkpad kernel:  commit_tail+0x94/0x110 [drm_kms_helper]=

Jan 01 07:22:25 thinkpad kernel:  drm_atomic_helper_commit+0x108/0x110
[drm_kms_helper]
Jan 01 07:22:25 thinkpad kernel:  drm_atomic_helper_set_config+0x81/0x90
[drm_kms_helper]
Jan 01 07:22:25 thinkpad kernel:  drm_mode_setcrtc+0x1f0/0x730 [drm]
Jan 01 07:22:25 thinkpad kernel:  ? dma_fence_default_wait+0x23a/0x2c0
Jan 01 07:22:25 thinkpad kernel:  ? drm_mode_getcrtc+0x180/0x180 [drm]
Jan 01 07:22:25 thinkpad kernel:  drm_ioctl_kernel+0xb2/0x100 [drm]
Jan 01 07:22:25 thinkpad kernel:  drm_ioctl+0x209/0x360 [drm]
Jan 01 07:22:25 thinkpad kernel:  ? drm_mode_getcrtc+0x180/0x180 [drm]
Jan 01 07:22:25 thinkpad kernel:  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
Jan 01 07:22:25 thinkpad kernel:  do_vfs_ioctl+0x43d/0x6c0
Jan 01 07:22:25 thinkpad kernel:  ksys_ioctl+0x5e/0x90
Jan 01 07:22:25 thinkpad kernel:  ? switch_fpu_return+0x2d/0x140
Jan 01 07:22:25 thinkpad kernel:  __x64_sys_ioctl+0x16/0x20
Jan 01 07:22:25 thinkpad kernel:  do_syscall_64+0x4e/0x140
Jan 01 07:22:25 thinkpad kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa=
9
Jan 01 07:22:25 thinkpad kernel: RIP: 0033:0x7f9e8891225b
Jan 01 07:22:25 thinkpad kernel: Code: 0f 1e fa 48 8b 05 25 9c 0c 00 64
c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa
b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d f5 9b 0c 00
f7 d8 64 89 01 48
Jan 01 07:22:25 thinkpad kernel: RSP: 002b:00007fff7908d8f8 EFLAGS:
00003246 ORIG_RAX: 0000000000000010
Jan 01 07:22:25 thinkpad kernel: RAX: ffffffffffffffda RBX:
00007fff7908d930 RCX: 00007f9e8891225b
Jan 01 07:22:25 thinkpad kernel: RDX: 00007fff7908d930 RSI:
00000000c06864a2 RDI: 000000000000000d
Jan 01 07:22:25 thinkpad kernel: RBP: 00000000c06864a2 R08:
0000000000000000 R09: 0000000000000000
Jan 01 07:22:25 thinkpad kernel: R10: 0000000000000000 R11:
0000000000003246 R12: 000056450439de20
Jan 01 07:22:25 thinkpad kernel: R13: 000000000000000d R14:
00007fff7908dbc8 R15: 00005645043996e0
Jan 01 07:22:25 thinkpad kernel: ---[ end trace 2b805e0326fe3e37 ]---

The full dmesg can be found here:
https://gist.github.com/adam900710/ada1566160e61be1efa5d789b124bc80

Hopes one day eGPU can work better under Linux.

Thanks,
Qu


--yHUS028Vv8cEe5HFEXwh4d8G6JExx6nck--

--Xq3sXn4bbz6mZ2b0duEjbcHY33riY564H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFLBAEBCAA1FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl4MZtYXHHF1d2VucnVv
LmJ0cmZzQGdteC5jb20ACgkQwj2R86El/qh0ZwgApBVPocHl8dmTQpqNCzptespU
4Cd/Ffv9teRh9QQsJq7cMt7hxBpIRIT4pxH1ZbdVzlRkXXW/AWDNbCVxWbw4PSx+
7BJbzS6llSKT/l2lGEQZlMBFtZFl8Mwex85IKZ90SjJ/smEKaQQlDXi0J35kT3uv
lrLAQu9zZ0pmWIccVP6Yq0/9bcq/Z6cjt/y+VY0/71a/ZsM4RjZo66GkwPj1uhRn
SunwKho4gZsCkmFmrtfhLd54KsH6D4Znp7ov9Z9Qn+h7oR8O+tI8vpsJ31/+65EO
u2ioQA9WXt3JY+IAcbA6+FUVh5mvSFNE+HUT2dSeIlvi1wxHckSivB77EgN7SQ==
=i7rq
-----END PGP SIGNATURE-----

--Xq3sXn4bbz6mZ2b0duEjbcHY33riY564H--

--===============1645281364==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1645281364==--
