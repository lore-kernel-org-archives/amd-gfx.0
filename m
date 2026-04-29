Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764DCFF8867
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 13:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B040710EFDC;
	Wed, 29 Apr 2026 13:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="wKAI/pi3";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 237D710E664
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 12:47:07 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so151678325e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 05:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777466826; x=1778071626;
 darn=lists.freedesktop.org; 
 h=mime-version:message-id:date:user-agent:references:organization
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LGKOO4lpFnOw96SqYoA6Gz/B51JtRhqSbM4Rk15rzpM=;
 b=wKAI/pi3KlUE1xPXmq4YzY/lF5e7uQdEEgFBsLTyuexHCOTKGK2AaksInANC0V6uYL
 vK+YvcC05ShggOywNXbyaqFzsrufomTg9BioszsiYJVJ6HrbPZ+/hUzdM5VSn3iegHNw
 KPF0gDSKTewFyOQrSZ2Q5RbZQr8jTbYUFCZ+YuNKsKsykgE51XSRLUDwWnz8VXdgIXRe
 50wNKINIObow7uEzP3/E4WRUPBxdQpfWgMe7gBz2SvJRDdWZVzLtGSpa5OQ1NkkLZPgj
 hRlr70X1NvUGMaOhzT5UPJYoHHRn35bSabhoJyCjbvvHxo7d2fQWWpdI0YU8CqeG/P50
 kBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777466826; x=1778071626;
 h=mime-version:message-id:date:user-agent:references:organization
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LGKOO4lpFnOw96SqYoA6Gz/B51JtRhqSbM4Rk15rzpM=;
 b=DHKttzKCne5uB4Raj2NNVhGtd0r/v6CJ+8+pzx5xKjku1/Gwu8WZsrdVeoVF8ynkxY
 d/9pJYyR1dvzu8Qr5MJkxua5qA00zeBF2p52xJevzk5lTRfhNSzQPG+ihKMUTPe63jZa
 v1moezLwPId92tGfLj68rL9S8C+pg5fl27ZwQSfqpK7hjqPJL11uCT4oqBAdh7yrcssB
 V4XdYtW3eOpOwgFiAEuomkBdeNptXrnzhaNC0222DaEg12B7T2cVKFhhaUy5hjSIcVtd
 atjCr54eUWl2ykUGHXmjG+GcmHSOR2yTqgT6GHDjCFF0XZk/SRxSp10vAGhljAHGy57a
 kNkg==
X-Gm-Message-State: AOJu0Yw3yekw4wd1aYVrftR7SzqGd8l4H8389G6cU+BaZ8/tdQtho4lL
 5zJya/vcrf0KyNG+q7mP/jD/14DK3SKOlnCoe3YoQlIAdRS7lDVa0dY07hu7paxXXUo=
X-Gm-Gg: AeBDiesD3znEChZTE2AqmDSmfknqjmi73vzg7YVk6Su69TSK9zRpeRzkbEPT6ZM+Ti+
 J55suoZwSybLdKVDXIw2IuDyQx+rCgrGERKCOjrNjnzxOYymQQ2xmDNic5xgR1DWBPzglFgH4nr
 WTzZXOe+2OXBjDTkvH6+ZnZemV+PRJDy9kiGrFtWFARrX1YBQFOP5A3I8lRNcsHg+j20gFcw+ot
 BnJb/WagxOr9jAHXbOkW6ehpEt+mFW10Kpgr8YVoeQQJZChbIzRa1x2CDQJx9V503qmXvWmOET7
 0zTF7Yhnc0rdkU00Y+XnGxMO/dP9cG+436iCaJXpkXUm+1sKyc0e1P9dzfkqAYpUX+svBw/1rC2
 1ih8S1iZ/P5RzDK7lxPh7aYBM0MWgIUAlwdCrpihGE+Z/dSWED+cvEBrHU9J9GWvLojVi8SiU6s
 eir1BVrcF8xuFkoFDIqZVOfj8RKHZ0RTHNNRf2Brw=
X-Received: by 2002:a05:600c:630a:b0:487:1fb4:7e1 with SMTP id
 5b1f17b1804b1-48a77b0ee3emr144763825e9.22.1777466825067; 
 Wed, 29 Apr 2026 05:47:05 -0700 (PDT)
Received: from bstg ([146.70.193.12]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c32afd4sm18360325e9.36.2026.04.29.05.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 05:47:04 -0700 (PDT)
From: =?utf-8?Q?Arsen_Arsenovi=C4=87?= <aarsenovic@baylibre.com>
To: amd-gfx@lists.freedesktop.org,  linux-mm@kvack.org
Cc: cs-tech-ext@baylibre.com
Subject: Re: [BUG] Frequent hangs or WARNINGs when using heterogeneous
 memory with an AMD MI210 GPU
In-Reply-To: <86ecjz2hhr.fsf@baylibre.com>
Organization: BayLibre
References: <86ecjz2hhr.fsf@baylibre.com>
User-Agent: mu4e 1.14.0; emacs 31.0.50
Date: Wed, 29 Apr 2026 14:47:02 +0200
Message-ID: <86tssu0w8p.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Mailman-Approved-At: Wed, 29 Apr 2026 13:05:13 +0000
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Arsen Arsenovi=C4=87 <aarsenovic@baylibre.com> writes:

> We get this by running the following OpenMP program built for offloading
> onto an AMD GPU:
>
>   https://gcc.gnu.org/cgit/gcc/tree/libgomp/testsuite/libgomp.c++/pr11969=
2-1-4.C
>
> ... built by:
>
>   x86_64-none-linux-gnu-g++ pr119692-1-4.C -foffload=3D-march=3Dgfx90a \
>     -Wl,-rpath,/opt/rocm/lib -fopenmp -O2 \
>     -DDEFAULT=3D'defaultmap(firstprivate)' \
>     -lm -o ./pr119692-1-4.exe
>
> ... using trunk GCC configured for amdgcn-amdhsa offloading[1] and
> executed as:
>
>   timeout --verbose 10s env HSA_XNACK=3D1 LD_LIBRARY_PATH=3D. ./pr119692-=
1-4.exe
>
> ... when the timeout happens (i.e. the program gets stuck for 10 seconds
> and then, when 10 seconds pass, timeout sends a SIGTERM to a.out, and
> results in the crash above).

I've now confirmed that it is possible to reproduce this specific issue
also on bare metal, also with kernel 7.0.2 and ROCm 7.2.2 (using the
rocm/dev-ubuntu-22.04:7.2.2 Docker image):

  [ 1171.959571] ------------[ cut here ]------------
  [ 1171.959577] WARNING: mm/memory.c:1753 at unmap_page_range+0x10d5/0x1bc=
0, CPU#247: pr119692-1-4.ex/143761
  [ 1171.959613] Modules linked in: xt_iprange xt_LOG nf_log_syslog xt_comm=
ent amdgpu amdxcp drm_ttm_helper ttm drm_exec drm_panel_backlight_quirks gp=
u_sched drm_suballoc_helper video drm_buddy drm_display_helper cec rc_core =
iptable_nat iptable_filter vhost_vsock vmw_vsock_virtio_transport_common vs=
ock vhost vhost_iotlb nf_conntrack_netlink xt_nat veth vxlan ip6_udp_tunnel=
 udp_tunnel xt_policy xt_mark xt_bpf xt_tcpudp br_netfilter xt_conntrack xt=
_MASQUERADE xfrm_user xfrm_algo xt_set ip_set nft_chain_nat nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype nft_compat nfsv3 nfs netfs o=
verlay 8021q garp mrp bridge stp llc bonding tls nf_tables nfnetlink binfmt=
_misc nls_iso8859_1 intel_rapl_msr intel_rapl_common amd64_edac edac_mce_am=
d kvm_amd ipmi_ssif kvm irqbypass rapl wmi_bmof pcspkr ccp input_leds joyde=
v mac_hid acpi_ipmi ptdma ipmi_si k10temp ipmi_devintf ipmi_msghandler nfsd=
 auth_rpcgss nfs_acl lockd sch_fq_codel dm_multipath grace scsi_dh_rdac scs=
i_dh_emc scsi_dh_alua sunrpc msr efi_pstore ip_tables x_tables
  [ 1171.959847]  autofs4 btrfs libblake2b raid10 raid456 async_raid6_recov=
 async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 hid_gene=
ric usbmouse igb bnxt_en ghash_clmulni_intel usbhid ast rndis_host ahci cdc=
_ether libahci dca usbnet hid i2c_algo_bit mii i2c_piix4 i2c_smbus wmi aesn=
i_intel
  [ 1171.959939] CPU: 247 UID: 0 PID: 143761 Comm: pr119692-1-4.ex Not tain=
ted 7.0.2-instinct-arsen #3 PREEMPT(lazy)
  [ 1171.959947] Hardware name: Supermicro AS -4124GS-TNR/H12DSG-O-CPU, BIO=
S 2.8 01/26/2024
  [ 1171.959951] RIP: 0010:unmap_page_range+0x10d5/0x1bc0
  [ 1171.959959] Code: 2e 2e 2e 31 c0 4c 39 b5 50 ff ff ff 0f 85 72 f2 ff f=
f e9 b1 fd ff ff 48 8b 45 90 48 8b 53 18 48 83 78 48 00 0f 84 28 f9 ff ff <=
0f> 0b e9 21 f9 ff ff a9 ff 0f 00 00 0f 85 cb fb ff ff 48 8b 10 83
  [ 1171.959964] RSP: 0018:ffffce40ffc87920 EFLAGS: 00010286
  [ 1171.959969] RAX: ffff8e18cb2ee900 RBX: fffff3333ffb6a00 RCX: 000000000=
0000000
  [ 1171.959973] RDX: ffff8e18de1b18c9 RSI: 0000000000000005 RDI: 000000000=
0000000
  [ 1171.959976] RBP: ffffce40ffc87a30 R08: 0000000000000000 R09: 000000000=
0000000
  [ 1171.959979] R10: 0000000000000000 R11: 0000000000000000 R12: ffffce40f=
fc87b90
  [ 1171.959983] R13: fffff3333ffb6a00 R14: 0000000000000001 R15: ffff8e18b=
a912018
  [ 1171.959986] FS:  0000000000000000(0000) GS:ffff8e57ac3da000(0000) knlG=
S:0000000000000000
  [ 1171.959990] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [ 1171.959994] CR2: 000070d717bfe920 CR3: 0000004169a48002 CR4: 000000000=
0f70ef0
  [ 1171.960000] PKRU: 55555554
  [ 1171.960004] Call Trace:
  [ 1171.960008]  <TASK>
  [ 1171.960022]  unmap_single_vma+0x96/0x110
  [ 1171.960031]  unmap_vmas+0xa5/0x180
  [ 1171.960041]  exit_mmap+0x13b/0x400
  [ 1171.960060]  __mmput+0x45/0x170
  [ 1171.960068]  mmput+0x31/0x40
  [ 1171.960074]  do_exit+0x285/0xad0
  [ 1171.960083]  do_group_exit+0x2d/0xb0
  [ 1171.960090]  get_signal+0x86a/0x930
  [ 1171.960099]  ? kfd_ioctl+0x4ad/0x5c0 [amdgpu]
  [ 1171.960563]  ? srso_alias_return_thunk+0x5/0xfbef5
  [ 1171.960570]  ? __x64_sys_ioctl+0xbd/0x100
  [ 1171.960580]  arch_do_signal_or_restart+0x3a/0x250
  [ 1171.960608]  exit_to_user_mode_loop+0x8f/0x500
  [ 1171.960618]  do_syscall_64+0x2cd/0x14b0
  [ 1171.960626]  ? srso_alias_return_thunk+0x5/0xfbef5
  [ 1171.960631]  ? handle_mm_fault+0x1e8/0x2f0
  [ 1171.960640]  ? srso_alias_return_thunk+0x5/0xfbef5
  [ 1171.960646]  ? do_user_addr_fault+0x2ee/0x830
  [ 1171.960655]  ? srso_alias_return_thunk+0x5/0xfbef5
  [ 1171.960660]  ? irqentry_exit+0xa5/0x600
  [ 1171.960670]  ? srso_alias_return_thunk+0x5/0xfbef5
  [ 1171.960676]  ? exc_page_fault+0x94/0x1e0
  [ 1171.960682]  ? ret_from_fork+0x1b2/0x3a0
  [ 1171.960691]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  [ 1171.960697] RIP: 0033:0x70d718dab9cf
  [ 1171.960704] Code: Unable to access opcode bytes at 0x70d718dab9a5.
  [ 1171.960708] RSP: 002b:000070d717bfda90 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000010
  [ 1171.960716] RAX: fffffffffffffffc RBX: 0000000000000003 RCX: 000070d71=
8dab9cf
  [ 1171.960720] RDX: 000070d717bfdb60 RSI: 00000000c0184b0c RDI: 000000000=
0000003
  [ 1171.960725] RBP: 00000000c0184b0c R08: 0000000040000001 R09: 000070d70=
8000dd0
  [ 1171.960728] R10: 000070d71902bc68 R11: 0000000000000246 R12: 000070d71=
7bfdc10
  [ 1171.960732] R13: 000070d717bfdb60 R14: 0000000031050b60 R15: 000070d70=
8000dd0
  [ 1171.960741]  </TASK>
  [ 1171.960746] ---[ end trace 0000000000000000 ]---

I'll try the other testcase we had (omptests t-unified-* all running in
parallel) later also.
=2D-=20
Arsen Arsenovi=C4=87

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEKBAEWCgCyFiEE/uKz0RP8AKMWLWBhUsKUMB6ixJMFAmnx/cYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25z
Lm9wZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRGRUUyQjNEMTEzRkMwMEEzMTYyRDYw
NjE1MkMyOTQzMDFFQTJDNDkzGBxhYXJzZW5vdmljQGJheWxpYnJlLmNvbQAKCRBS
wpQwHqLEk4E4AQC5CgSws6LLnLmtU3wZ14OFUYn4xKYxLH2yciVFrXqTowEApQLv
P1UbHsAtGhQ/xBW489cM7DN7aHXnRS4wSij/ag8=
=mtuB
-----END PGP SIGNATURE-----
--=-=-=--
