Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E14CCFC539
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Nov 2025 13:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1179410E07D;
	Sat, 22 Nov 2025 13:46:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=tnonline.net header.i=@tnonline.net header.b="HYJgC26J";
	dkim-atps=neutral
X-Greylist: delayed 1055 seconds by postgrey-1.36 at gabe;
 Sat, 22 Nov 2025 13:46:06 UTC
Received: from mx.tnonline.net (mx.tnonline.net [135.181.111.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DB1710E07D
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Nov 2025 13:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=tnonline.net; s=default; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O4X46MCGzSqtJ/XMb24Z6GPd3hu3DcFIdAofU/v1GH0=; t=1763819166; x=1765028766; 
 b=HYJgC26JNwRAc5lppksiPt7Gvke+rsWt+t5jRFmHEJAU30KiHZbLipDeutsOptzLcTnv+zDomgx
 kfrj62ybAhzP9rSS685UGrkW4znuiHTU1O9e7R7xsj6LuUbBPb9zEv0U04l2bAVIvkPwpL/aZhpWW
 2G4C+xOZ2Wu37PzxrVDxpdK6iAUvphvcgRLBBnR3hhQpCaQZVwuHZTNM+Z3PNw2sK92SuexjNUzDV
 Q6qedQBSc8qvhGytBvNfYeJ72hzVu6Xloh+EMV25X4BAYjdwdLR3N41hSF2TcmKlpGBf7NG6oHErR
 mjf8AqOydHKiE0ZW1NpB6r/ZwWIoeW3LX9LA==;
Received: from [2001:470:28:704::1] (port=36566 helo=tnonline.net)
 by mx.tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <forza@tnonline.net>)
 id 1vMnfB-000000003Un-1xBG for amd-gfx@lists.freedesktop.org;
 Sat, 22 Nov 2025 13:28:29 +0000
Received: from [192.168.0.114] (port=44550)
 by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98.2) (envelope-from <forza@tnonline.net>)
 id 1vMnfD-00000000G3Y-0u6E for amd-gfx@lists.freedesktop.org;
 Sat, 22 Nov 2025 14:28:27 +0100
Date: Sat, 22 Nov 2025 14:28:26 +0100 (GMT+01:00)
From: Forza <forza@tnonline.net>
To: amd-gfx@lists.freedesktop.org
Message-ID: <e39d7fe.312e0638.19aabc06e96@tnonline.net>
Subject: amdgpu CFI failure at ttm_bo_vm_fault_reserved with LLVM-21
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
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

Hi,

When compiling kernel 6.12.58 with CFI and using LLVM-21, I see a lot of wa=
rnings related to amdgpu.

dmesg shows hundreds of messages like these:


[22467.209770] [T10150] CFI failure at ttm_bo_vm_fault_reserved+0x149/0x460=
 [ttm] (target: amdgpu_ttm_io_mem_reserve+0x0/0xa0 [amdgpu]; expected type:=
 0x5c03b537)
[22467.210003] [T10150] WARNING: CPU: 3 PID: 10150 at ttm_bo_vm_fault_reser=
ved+0x149/0x460 [ttm]
[22467.210007] [T10150] Modules linked in: nf_conntrack_netlink nfnetlink_a=
cct vhost_net vhost vhost_iotlb tap tun wireguard nfsd auth_rpcgss nfs_acl =
lockd grace nfs_localio sunrpc ip6t_REJECT nf_reject_ipv6 ip6table_filter i=
p6table_nat xt_ecn ip6table_mangle ip6table_raw xt_limit xt_conntrack ipt_R=
EJECT nf_reject_ipv4 iptable_filter xt_nat iptable_nat xt_DSCP xt_multiport=
 xt_owner xt_TCPOPTSTRIP iptable_mangle xt_CT iptable_raw ip_set_bitmap_por=
t ip_set_hash_net ip_set_hash_ip xt_esp ipt_ah nft_xfrm nf_tables nf_nat_pp=
tp nf_conntrack_pptp nf_nat nf_conntrack_sip nf_conntrack_irc nf_conntrack_=
ftp nf_conntrack_h323 nf_conntrack_netbios_ns nf_conntrack_broadcast nf_con=
ntrack_bridge nf_conntrack nf_defrag_ipv6 ip6_tables ip_tables xt_recent xt=
_set ip_set nfnetlink nf_defrag_ipv4 nf_socket_ipv4 sch_cake vfat fat amdgp=
u mfd_core drm_buddy hwmon_vid kvm_amd drm_suballoc_helper drm_exec i2c_alg=
o_bit drm_display_helper gpu_sched amdxcp kvm drm_ttm_helper gigabyte_wmi i=
rqbypass r8169 ttm i2c_piix4 i2c_smbus e1000e video backlight
[22467.210044] [T10150]  gpio_amdpt tpm_crb gpio_generic tpm_tis tpm_tis_co=
re 8250 8250_base serial_mctrl_gpio serial_base dm_mirror dm_region_hash dm=
_log
[22467.210050] [T10150] CPU: 3 UID: 77 PID: 10150 Comm: qemu:alpine-q Taint=
ed: P        W          6.12.58-gentoo #4
[22467.210052] [T10150] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN
[22467.210052] [T10150] Hardware name: Gigabyte Technology Co., Ltd. B450M =
DS3H/B450M DS3H-CF, BIOS F67g 03/11/2025
[22467.210053] [T10150] RIP: 0010:ttm_bo_vm_fault_reserved+0x149/0x460 [ttm=
]
[22467.210056] [T10150] Code: 00 75 37 48 83 7e 18 00 75 30 c6 46 28 00 48 =
8b 45 10 4c 8b 58 48 4d 85 db 74 1f 48 89 ef 41 ba c9 4a fc a3 45 03 53 f1 =
74 02 <0f> 0b 2e e8 6f 5c 2e c5 85 c0 0f 85 7f 02 00 00 49 8b 45 00 4d 89
[22467.210057] [T10150] RSP: 0000:ffffd2331362bcd8 EFLAGS: 00010296
[22467.210058] [T10150] RAX: ffffffffc0d9a530 RBX: ffff8c4a48383048 RCX: 48=
bcac0481527e00
[22467.210059] [T10150] RDX: 0000000000000001 RSI: ffff8c4a45971700 RDI: ff=
ff8c4a4420ef40
[22467.210060] [T10150] RBP: ffff8c4a4420ef40 R08: 0000000000000000 R09: 02=
00000000000000
[22467.210061] [T10150] R10: 00000000cece28b7 R11: ffffffffc0536c00 R12: 00=
007f1c4fe7a000
[22467.210062] [T10150] R13: ffff8c5127204aa0 R14: ffffd2331362be20 R15: ff=
ff8c4a44200010
[22467.210063] [T10150] FS:  00007f1d97d469c0(0000) GS:ffff8c513e580000(000=
0) knlGS:0000000000000000
[22467.210064] [T10150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[22467.210065] [T10150] CR2: 00007f1c4fe7a260 CR3: 00000002bc36a000 CR4: 00=
00000000b50ef0
[22467.210066] [T10150] Call Trace:
[22467.210066] [T10150]  <TASK>
[22467.210068] [T10150]  ? srso_alias_return_thunk+0x5/0xfbef5
[22467.210069] [T10150]  ? srso_alias_return_thunk+0x5/0xfbef5
[22467.210070] [T10150]  ? warn_thunk_thunk+0x1a/0x40
[22467.210072] [T10150]  ? __cfi_amdgpu_gem_fault+0x10/0x10 [amdgpu]
[22467.210309] [T10150]  amdgpu_gem_fault+0x9d/0x100 [amdgpu]
[22467.210536] [T10150]  ? __do_fault+0x13c/0x270
[22467.210538] [T10150]  ? handle_mm_fault+0xe31/0x1cd0
[22467.210541] [T10150]  ? do_user_addr_fault+0x2fa/0x740
[22467.210543] [T10150]  ? exc_page_fault+0x58/0xb0
[22467.210545] [T10150]  ? asm_exc_page_fault+0x26/0x30
[22467.210548] [T10150]  </TASK>
[22467.210549] [T10150] ---[ end trace 0000000000000000 ]---


[22467.239938] [T10150] CFI failure at __do_fault+0x134/0x270 (target: amdg=
pu_gem_fault+0x0/0x100 [amdgpu]; expected type: 0x21420ec1)
[22467.240166] [T10150] WARNING: CPU: 5 PID: 10150 at __do_fault+0x134/0x27=
0
[22467.240167] [T10150] Modules linked in: nf_conntrack_netlink nfnetlink_a=
cct vhost_net vhost vhost_iotlb tap tun wireguard nfsd auth_rpcgss nfs_acl =
lockd grace nfs_localio sunrpc ip6t_REJECT nf_reject_ipv6 ip6table_filter i=
p6table_nat xt_ecn ip6table_mangle ip6table_raw xt_limit xt_conntrack ipt_R=
EJECT nf_reject_ipv4 iptable_filter xt_nat iptable_nat xt_DSCP xt_multiport=
 xt_owner xt_TCPOPTSTRIP iptable_mangle xt_CT iptable_raw ip_set_bitmap_por=
t ip_set_hash_net ip_set_hash_ip xt_esp ipt_ah nft_xfrm nf_tables nf_nat_pp=
tp nf_conntrack_pptp nf_nat nf_conntrack_sip nf_conntrack_irc nf_conntrack_=
ftp nf_conntrack_h323 nf_conntrack_netbios_ns nf_conntrack_broadcast nf_con=
ntrack_bridge nf_conntrack nf_defrag_ipv6 ip6_tables ip_tables xt_recent xt=
_set ip_set nfnetlink nf_defrag_ipv4 nf_socket_ipv4 sch_cake vfat fat amdgp=
u mfd_core drm_buddy hwmon_vid kvm_amd drm_suballoc_helper drm_exec i2c_alg=
o_bit drm_display_helper gpu_sched amdxcp kvm drm_ttm_helper gigabyte_wmi i=
rqbypass r8169 ttm i2c_piix4 i2c_smbus e1000e video backlight
[22467.240205] [T10150]  gpio_amdpt tpm_crb gpio_generic tpm_tis tpm_tis_co=
re 8250 8250_base serial_mctrl_gpio serial_base dm_mirror dm_region_hash dm=
_log
[22467.240210] [T10150] CPU: 5 UID: 77 PID: 10150 Comm: qemu:alpine-q Taint=
ed: P        W          6.12.58-gentoo #4
[22467.240212] [T10150] Tainted: [P]=3DPROPRIETARY_MODULE, [W]=3DWARN
[22467.240213] [T10150] Hardware name: Gigabyte Technology Co., Ltd. B450M =
DS3H/B450M DS3H-CF, BIOS F67g 03/11/2025
[22467.240214] [T10150] RIP: 0010:__do_fault+0x134/0x270
[22467.240215] [T10150] Code: fa e8 f0 fc 0a 00 f7 c5 00 02 00 00 74 01 fb =
4c 89 73 68 49 8b 47 70 48 89 df 4c 8b 58 28 41 ba 3f f1 bd de 45 03 53 f1 =
74 02 <0f> 0b 2e e8 b4 3b 04 01 a9 73 1d 00 00 75 2e 4c 8b 73 50 49 8b 4e
[22467.240216] [T10150] RSP: 0000:ffffd2331362bda8 EFLAGS: 00010213
[22467.240217] [T10150] RAX: ffffffffc1104318 RBX: ffffd2331362be20 RCX: ff=
ffffffc1104318
[22467.240218] [T10150] RDX: 0000000004762300 RSI: ffff8c4a5d88c000 RDI: ff=
ffd2331362be20
[22467.240219] [T10150] RBP: 0000000000000043 R08: 000ffffffffff000 R09: 02=
00000000000000
[22467.240220] [T10150] R10: 00000000364e5757 R11: ffffffffc05433b0 R12: ff=
ff8c5127204aa0
[22467.240221] [T10150] R13: ffff8c5127204aa0 R14: ffff8c4a4bc08b00 R15: ff=
ff8c5127204aa0
[22467.240222] [T10150] FS:  00007f1d97d469c0(0000) GS:ffff8c513e680000(000=
0) knlGS:0000000000000000
[22467.240223] [T10150] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[22467.240224] [T10150] CR2: 00007f1c4ffa1000 CR3: 00000002bc36a000 CR4: 00=
00000000b50ef0
[22467.240225] [T10150] Call Trace:
[22467.240225] [T10150]  <TASK>
[22467.240227] [T10150]  handle_mm_fault+0xe31/0x1cd0
[22467.240230] [T10150]  do_user_addr_fault+0x2fa/0x740
[22467.240232] [T10150]  exc_page_fault+0x58/0xb0
[22467.240234] [T10150]  asm_exc_page_fault+0x26/0x30
[22467.240236] [T10150] RIP: 0033:0x7f1d99b962ae
[22467.240237] [T10150] Code: c5 fe 6f 7c 16 a0 c5 7e 6f 44 16 80 48 29 ce =
48 ff c7 48 01 fe 48 8d 54 11 80 66 90 c5 fe 6f 0e c5 fe 6f 56 20 c5 fe 6f =
5e 40 <c5> fe 6f 66 60 48 83 ee 80 c5 fd 7f 0f c5 fd 7f 57 20 c5 fd 7f 5f
[22467.240238] [T10150] RSP: 002b:00007ffe705cfaa8 EFLAGS: 00010206
[22467.240239] [T10150] RAX: 00007f1c4b493d00 RBX: 0000000000001680 RCX: 00=
007f1c4b493d00
[22467.240240] [T10150] RDX: 00007f1c4b495300 RSI: 00007f1c4ffa0fa0 RDI: 00=
007f1c4b493ea0
[22467.240241] [T10150] RBP: 00007f1c4b495380 R08: 0000000000000000 R09: 00=
007f1c74668f18
[22467.240242] [T10150] R10: 0000000000000001 R11: 0000000000000246 R12: 00=
00000000001680
[22467.240243] [T10150] R13: 00007f1c7327a180 R14: 0000000000000384 R15: 00=
00000000000343
[22467.240245] [T10150]  </TASK>
[22467.240245] [T10150] ---[ end trace 0000000000000000 ]---



This is a AMD Ryzen 5600G processor with built in Radeon Graphics.=20

I did not see such messages using LLVM-20

Thanks,
Forza=20
