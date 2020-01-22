Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57297C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 18:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ADAE2465A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 18:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADAE2465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bastelmap.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8D5F6F62C;
	Wed, 22 Jan 2020 18:10:55 +0000 (UTC)
X-Greylist: delayed 541 seconds by postgrey-1.36 at gabe;
 Wed, 22 Jan 2020 18:04:11 UTC
Received: from dd10814.kasserver.com (dd10814.kasserver.com [85.13.133.115])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F29CA6F62B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 18:04:11 +0000 (UTC)
Received: from zeus.ad.home.arpa (p5B0555BF.dip0.t-ipconnect.de [91.5.85.191])
 by dd10814.kasserver.com (Postfix) with ESMTPSA id B8A4F12005D4
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 18:55:06 +0100 (CET)
Date: Wed, 22 Jan 2020 18:55:05 +0100
From: Andreas Messer <andi@bastelmap.de>
To: amd-gfx@lists.freedesktop.org
Subject: Radeon HD7750 lookup during higher load
Message-ID: <20200122175505.GA5500@zeus.ad.home.arpa>
MIME-Version: 1.0
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Wed, 22 Jan 2020 18:10:55 +0000
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
Content-Type: multipart/mixed; boundary="===============1599213866=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--===============1599213866==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

I recently started playing the game "0.A.D." and found after a while
the display go blank. Music continues playing and the machine can still be
reached through ssh.

It looks to me same as problem reported here (dmesg output is almost
equal): https://gitlab.freedesktop.org/mesa/mesa/issues/1226

I tried switching to amdgpu driver and still observe the issue, now
with different dmesg output of course:


[ 1768.312186] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout,=
 signaled seq=3D362580, emitted seq=3D362582
[ 1768.312452] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process informati=
on: process pyrogenesis pid 4421 thread pyrogenesi:cs0 pid 4447
[ 1768.312457] [drm] GPU recovery disabled.
[ 1768.952023] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma1 timeou=
t, signaled seq=3D181, emitted seq=3D183
[ 1768.952077] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0 timeou=
t, signaled seq=3D7963, emitted seq=3D7967
[ 1768.952128] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process informati=
on: process  pid 0 thread  pid 0
[ 1768.952177] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process informati=
on: process  pid 0 thread  pid 0
[ 1768.952177] [drm] GPU recovery disabled.
[ 1768.952178] [drm] GPU recovery disabled.

I have to admit that I'm using not the most recent kernel version 5.4.8 at
the moment, but the issue is also present in in 4.19. I would like to help
fixing this problem. (I'd like to not buy a new card since this one is
good enough for my needs and working fine for anything else)

I skimmed through the recent posts on this mailing list and did not
found anything which could be related to the problem.

I have basic knowledge using gdb, compiling the kernel and making changes
to c-code but I dont really know were to start. Maybe the first step would
be to get more detailed debug output / information. I have seen some fancy
debug printouts/trace in some dmesg somewhere, not sure if they have=20
been added for testing only. Maybe some can point out were to start.

Besides that, when using the amdgpu driver i get a stack overflow hen
reading "pp_num_states" file from sysfs:

[ 2150.391319] BUG: stack guard page was hit at 0000000048d4f0c0 (stack is =
00000000c8aa4d84..0000000006729080)
[ 2150.391329] kernel stack overflow (page fault): 0000 [#1] SMP PTI
[ 2150.391335] CPU: 1 PID: 5319 Comm: cat Tainted: G            E     5.4.8=
-amesser #3
[ 2150.391338] Hardware name: Gigabyte Technology Co., Ltd. X170-WS ECC/X17=
0-WS ECC-CF, BIOS F2 06/20/2016
[ 2150.391524] RIP: 0010:amdgpu_get_pp_num_states+0x9d/0x150 [amdgpu]
[ 2150.391531] Code: 00 48 89 ef e8 04 75 a0 dd 41 89 c7 8b 44 24 04 85 c0 =
74 74 45 31 f6 48 8d 5c 24 04 49 c7 c4 8b 0e ba c0 49 c7 c5 43 0e ba c0 <42=
> 8b 44 b3 04 44 89 f1 4d 89 e0 83 f8 0a 74 29 4d 89 e8 83 f8 02
[ 2150.391535] RSP: 0018:ffffad76c40f3db8 EFLAGS: 00010286
[ 2150.391540] RAX: 000000000000000c RBX: ffffad76c40f3dbc RCX: 00000000000=
00000
[ 2150.391543] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9d2061e=
a065f
[ 2150.391546] RBP: ffff9d2061ea0000 R08: 0000000000000008 R09: 00000000000=
00000
[ 2150.391548] R10: ffff9d2061ea1653 R11: ffff9d2061ea0656 R12: ffffffffc0b=
a0e8b
[ 2150.391551] R13: ffffffffc0ba0e43 R14: 0000000000000090 R15: 00000000000=
0065f
[ 2150.391556] FS:  00007fc64cdeb540(0000) GS:ffff9d20d7240000(0000) knlGS:=
0000000000000000
[ 2150.391559] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2150.391562] CR2: ffffad76c40f4000 CR3: 00000007d15de003 CR4: 00000000003=
606e0
[ 2150.391566] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2150.391569] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 2150.391571] Call Trace:
[ 2150.391583]  ? mem_cgroup_try_charge+0x6a/0x180
[ 2150.391592]  ? mem_cgroup_throttle_swaprate+0x24/0x14a
[ 2150.391600]  dev_attr_show+0x15/0x40
[ 2150.391607]  sysfs_kf_seq_show+0x98/0x100
[ 2150.391615]  seq_read+0x13b/0x410
[ 2150.391622]  vfs_read+0x91/0x140
[ 2150.391627]  ksys_read+0x59/0xd0
[ 2150.391635]  do_syscall_64+0x4c/0x150
[ 2150.391643]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 2150.391647] RIP: 0033:0x7fc64cd13461
[ 2150.391653] Code: fe ff ff 50 48 8d 3d fe d0 09 00 e8 e9 03 02 00 66 0f =
1f 84 00 00 00 00 00 48 8d 05 99 62 0d 00 8b 00 85 c0 75 13 31 c0 0f 05 <48=
> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 41 54 49 89 d4 55 48
[ 2150.391656] RSP: 002b:00007fff0938bc78 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[ 2150.391661] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007fc64cd=
13461
[ 2150.391663] RDX: 0000000000020000 RSI: 00007fc64ce2a000 RDI: 00000000000=
00003
[ 2150.391666] RBP: 00007fc64ce2a000 R08: 00000000ffffffff R09: 00000000000=
00000
[ 2150.391669] R10: fffffffffffffb9c R11: 0000000000000246 R12: 00007fc64ce=
2a000
[ 2150.391672] R13: 0000000000000003 R14: 0000000000000fff R15: 00000000000=
20000
[ 2150.391676] Modules linked in: xt_CHECKSUM(E) nft_chain_nat(E) xt_MASQUE=
RADE(E) nf_nat(E) xt_conntrack(E) nf_conntrack(E) nf_defrag_ipv6(E) nf_defr=
ag_ipv4(E) ipt_REJECT(E) nf_reject_ipv4(E) nft_counter(E) xt_tcpudp(E) nft_=
compat(E) x_tables(E) tun(E) bridge(E) stp(E) llc(E) nf_tables(E) nfnetlink=
(E) cpufreq_userspace(E) cpufreq_conservative(E) cpufreq_powersave(E) bnep(=
E) bluetooth(E) drbg(E) ansi_cprng(E) ecdh_generic(E) ecc(E) rfkill(E) auto=
fs4(E) binfmt_misc(E) rpcsec_gss_krb5(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) =
nfs(E) lockd(E) grace(E) fscache(E) sunrpc(E) nls_ascii(E) nls_cp437(E) vfa=
t(E) fat(E) vfio_pci(E) vfio_virqfd(E) vfio_iommu_type1(E) vfio(E) parport_=
pc(E) ppdev(E) lp(E) parport(E) intel_rapl_msr(E) intel_rapl_common(E) x86_=
pkg_temp_thermal(E) intel_powerclamp(E) coretemp(E) kvm_intel(E) kvm(E) irq=
bypass(E) crct10dif_pclmul(E) crc32_pclmul(E) ghash_clmulni_intel(E) aesni_=
intel(E) crypto_simd(E) cryptd(E) glue_helper(E) intel_cstate(E) intel_unco=
re(E) intel_rapl_perf(E)
[ 2150.391732]  efivars(E) pcspkr(E) snd_hda_codec_realtek(E) amdgpu(E) snd=
_hda_codec_generic(E) mxm_wmi(E) ledtrig_audio(E) iTCO_wdt(E) iTCO_vendor_s=
upport(E) snd_hda_codec_hdmi(E) gpu_sched(E) joydev(E) evdev(E) radeon(E) s=
nd_hda_intel(E) snd_intel_nhlt(E) ttm(E) snd_hda_codec(E) snd_hda_core(E) d=
rm_kms_helper(E) snd_hwdep(E) snd_pcm(E) snd_timer(E) drm(E) snd(E) soundco=
re(E) intel_pch_thermal(E) ie31200_edac(E) button(E) acpi_pad(E) dm_mod(E) =
hid_logitech_hidpp(E) hid_logitech_dj(E) hid_generic(E) usbhid(E) hid(E) sg=
(E) nvme(E) xhci_pci(E) e1000e(E) i2c_i801(E) igb(E) xhci_hcd(E) i2c_algo_b=
it(E) dca(E) nvme_core(E) sr_mod(E) sd_mod(E) cdrom(E) usbcore(E) fan(E) th=
ermal(E) wmi(E) video(E)
[ 2150.391783] ---[ end trace 41146c7e9d1abe30 ]---
[ 2150.391956] RIP: 0010:amdgpu_get_pp_num_states+0x9d/0x150 [amdgpu]
[ 2150.391961] Code: 00 48 89 ef e8 04 75 a0 dd 41 89 c7 8b 44 24 04 85 c0 =
74 74 45 31 f6 48 8d 5c 24 04 49 c7 c4 8b 0e ba c0 49 c7 c5 43 0e ba c0 <42=
> 8b 44 b3 04 44 89 f1 4d 89 e0 83 f8 0a 74 29 4d 89 e8 83 f8 02
[ 2150.391964] RSP: 0018:ffffad76c40f3db8 EFLAGS: 00010286
[ 2150.391967] RAX: 000000000000000c RBX: ffffad76c40f3dbc RCX: 00000000000=
00000
[ 2150.391970] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9d2061e=
a065f
[ 2150.391973] RBP: ffff9d2061ea0000 R08: 0000000000000008 R09: 00000000000=
00000
[ 2150.391975] R10: ffff9d2061ea1653 R11: ffff9d2061ea0656 R12: ffffffffc0b=
a0e8b
[ 2150.391978] R13: ffffffffc0ba0e43 R14: 0000000000000090 R15: 00000000000=
0065f
[ 2150.391982] FS:  00007fc64cdeb540(0000) GS:ffff9d20d7240000(0000) knlGS:=
0000000000000000
[ 2150.391985] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2150.391988] CR2: ffffad76c40f4000 CR3: 00000007d15de003 CR4: 00000000003=
606e0
[ 2150.391991] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2150.391994] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400

This is unrelated to the other problem, it occurs also right after
booting.

Thanks for your support!

cheers,
Andreas
--=20
gnuPG keyid: 8C2BAF51
fingerprint: 28EE 8438 E688 D992 3661 C753 90B3 BAAA 8C2B AF51

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABEIAB0WIQQo7oQ45ojZkjZhx1OQs7qqjCuvUQUCXiiMcwAKCRCQs7qqjCuv
Ua33AKCwRl/P3eaYs3esJaKvf7CAQZXjOgCfbh6C2uM5E/U9GUyZP//9NaoFzDw=
=vgHY
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--

--===============1599213866==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1599213866==--
