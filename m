Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0182ACA1002
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 02:36:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8601710E355;
	Fri,  5 Sep 2025 02:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZK5Yc4TN";
	dkim-atps=neutral
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 496A910E353
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 02:36:30 +0000 (UTC)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-70df92872ceso15154946d6.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Sep 2025 19:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757039789; x=1757644589; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a8Tnwmy6U3S19UOQ1CYH7ZoqNwWc+BjtaiF8o4uWad8=;
 b=ZK5Yc4TNtiZ1ANgXkF5Y2kA7Zv1AdFRAz2VfX20dgvdedwKoaWmyxmVBBpOHG80CKu
 6rxqUmsn4rj8mSHatU2UdLWd20eVR4YwXtK3O9kaVAWo/HUFtJjBajiN3zqi26r2Bgy6
 oScEXvosE8NFlO24YdqpRjAoJlGYSMSkitBYpH3D9TOwqibzB0Cj6rAfYHxGIE97OgIA
 0SLBcsA4hd0GfFlWFSUB0OERrMvy89MF/Yz5IF1ZEDdcmn3AElvHyx7bxTBLtHMd4h4e
 6DERrQ2Yy/k3iS74DY5MSmV+uvcJkcz1iDxOow8KFWYYSTaZN8Z9HmwZ0N2ChF9BlwZT
 iDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757039789; x=1757644589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a8Tnwmy6U3S19UOQ1CYH7ZoqNwWc+BjtaiF8o4uWad8=;
 b=saAdgDb6OvndDtl3ofuTlkKa49qEvyoSD4kc3j/IXy28vdalCtncCuO3AvNmYJ3ngO
 oqwzkJIwA/56NKybYM7fzMih7lFhsQJ1rJqQydpfc41NfnrK1GLBgv87BS3TKOAjwMZc
 Z6BkQxT6me4bKdVb4e3QkJ5UpQ+NMaO5ngp6b6bshzUnabGmZwI2SdzagztSmZvLwIHm
 fMes/BEDVJG2TO5M9dJRnwiy6rae16laBg1ggbJuFUKlCY/+DsChG/4nKScCGpkplu9W
 fr5nsOu3HbzFRmuyzjjxSHTNy2lXWPcYpphuCXCOCmk7DDo5qXVXrTl5/in0nnhpDRcd
 QPDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWml/cw1y7iDItcw5Wai1PHgwIz3+0/1UOAY7eMtCbdEQZHmWsAAzd86PVriTYm/1h+H/r11nXm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcJh5F3KzDiMz+Gm1BbgNzOod6qpVGpAIzUklT9nfgjt6Adu6X
 0SnH5tUMe/AsdsfHAxE1mSv+zf3sknnEtiI/uNWJ0N8tWi38GbNS0/n8
X-Gm-Gg: ASbGncumdbEULOvETTJ9T50JCX+d3cSEj1rSnJd+xz1Jb7oiaTAlvWLjhsIAlrxMaQn
 qpM2J7oQKJbfvuA+KWkBTdVswo6j8LRE2hEUQQDuGdqXwa7y0FZ8Msr8G+9nGSI6RJD25KzjURA
 O4WMx95skp8cGgggbHyOEV50kTZ9whS/Yy1d49bFv9DBJSbmEWbn5WO4WGynCXqorIfspDMPNXv
 lkwol5O/BA2R1VXK7BjH11xTSc493SXiQnCQ3uforAvdj68xDbjR0kqCfpEmLPFZMU36y5sC4gO
 YS7JFHTb2cNWm36H0W9F2D0E4gHcs8O+nNf0YqeZ0eb9Dp7C5Ce4h6UzqsfqHnGoRo9dh6c2RGB
 SfdUS6wd9jWKvJJ/faH4DjpLRMX09k3s=
X-Google-Smtp-Source: AGHT+IHR+I9S3891bfypw8uf5WnLPsuHQZl0qdykhUX9ruFGvD4VPwoejqEkJ2Q/llrjfdNQnPq5ow==
X-Received: by 2002:a05:6214:2462:b0:70d:ae61:7ddd with SMTP id
 6a1803df08f44-72bc5842ebcmr30272076d6.31.1757039788848; 
 Thu, 04 Sep 2025 19:36:28 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-720ae045ef6sm55974886d6.31.2025.09.04.19.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Sep 2025 19:36:28 -0700 (PDT)
Message-ID: <38fe6513-f8a9-4669-8e86-89c54c465611@gmail.com>
Date: Thu, 4 Sep 2025 22:36:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: Save and restore switch state
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
References: <20250808045909.1836770-1-lijo.lazar@amd.com>
 <PH7PR12MB5997EAA3BAA43D3F72CF36C7822FA@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <PH7PR12MB5997EAA3BAA43D3F72CF36C7822FA@PH7PR12MB5997.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On 8/8/25 1:03 AM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>=20
>=20
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
> -----------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------------------------------------=
-------------------------------------------
> *=E5=8F=91=E4=BB=B6=E4=BA=BA:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:* Friday, August 8, 2025 12:58:55=
 PM
> *=E6=94=B6=E4=BB=B6=E4=BA=BA:* amd-gfx@lists.freedesktop.org <amd-gfx@l=
ists.freedesktop.org>
> *=E6=8A=84=E9=80=81:* Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, =
Alexander <Alexander.Deucher@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>=
; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> *=E4=B8=BB=E9=A2=98:* [PATCH v4] drm/amdgpu: Save and restore switch st=
ate
> =C2=A0
> During a DPC error kernel waits for the link to be active before
> notifying downstream devices. On certain platforms with Broadcom switch=

> in synthetiic mode, switch responds with values even though the link is=

> not fully ready. The config space restoration done by pcie port driver
> for SWUS/DS of dGPU is thus not effective as the switch is still doing
> internal enumeration.
>=20
> As a workaround, save state of SWUS/DS device in driver. Add additional=

> check to see if link is active and restore the values during DPC error
> callbacks.
>=20
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>=20
> v2: Use usleep_range as sleep is short. Remove dev_info logs.
> v3: remove redundant increment of 'i' in loop (Ce Sun).
> v4: Add timeout for wait (Kevin Wang)

This patch regresses amdgpu init with Kaveri on amd-staging-drm-next.
=20
A kernel oops leaves the system with frozen video and unable to
complete a reboot without using sysrq.  Reverting the commit restores
normal behavior.

Here's the dmesg snippet for e5e203e0cd53 after 'modprobe amdgpu dc=3D1':=


[  492.145848] [drm] amdgpu kernel modesetting enabled.
[  492.146050] amdgpu: Virtual CRAT table created for CPU
[  492.146072] amdgpu: Topology: Add CPU node
[  492.146451] amdgpu 0000:00:01.0: amdgpu: initializing kernel modesetti=
ng (KAVERI 0x1002:0x130F 0x1043:0x85CB 0xD4).
[  492.146473] amdgpu 0000:00:01.0: amdgpu: register mmio base: 0xFEB0000=
0
[  492.146477] amdgpu 0000:00:01.0: amdgpu: register mmio size: 262144
[  492.146559] amdgpu 0000:00:01.0: amdgpu: detected ip block number 0 <c=
ik_common>
[  492.146563] amdgpu 0000:00:01.0: amdgpu: detected ip block number 1 <g=
mc_v7_0>
[  492.146566] amdgpu 0000:00:01.0: amdgpu: detected ip block number 2 <c=
ik_ih>
[  492.146568] amdgpu 0000:00:01.0: amdgpu: detected ip block number 3 <g=
fx_v7_0>
[  492.146571] amdgpu 0000:00:01.0: amdgpu: detected ip block number 4 <c=
ik_sdma>
[  492.146573] amdgpu 0000:00:01.0: amdgpu: detected ip block number 5 <k=
v_dpm>
[  492.146576] amdgpu 0000:00:01.0: amdgpu: detected ip block number 6 <d=
m>
[  492.146579] amdgpu 0000:00:01.0: amdgpu: detected ip block number 7 <u=
vd_v4_2>
[  492.146581] amdgpu 0000:00:01.0: amdgpu: detected ip block number 8 <v=
ce_v2_0>
[  492.146611] amdgpu 0000:00:01.0: amdgpu: Fetched VBIOS from VFCT
[  492.146615] amdgpu: ATOM BIOS: 113-SPEC-102
[  492.151635] Console: switching to colour dummy device 80x25
[  492.151720] amdgpu 0000:00:01.0: vgaarb: deactivate vga console
[  492.151725] amdgpu 0000:00:01.0: amdgpu: Trusted Memory Zone (TMZ) fea=
ture not supported
[  492.151790] amdgpu 0000:00:01.0: amdgpu: vm size is 64 GB, 2 levels, b=
lock size is 10-bit, fragment size is 9-bit
[  492.151799] amdgpu 0000:00:01.0: amdgpu: VRAM: 256M 0x000000F400000000=
 - 0x000000F40FFFFFFF (256M used)
[  492.151804] amdgpu 0000:00:01.0: amdgpu: GART: 1024M 0x000000FF0000000=
0 - 0x000000FF3FFFFFFF
[  492.151819] [drm] Detected VRAM RAM=3D256M, BAR=3D256M
[  492.151822] [drm] RAM width 128bits UNKNOWN
[  492.151982] amdgpu 0000:00:01.0: amdgpu: amdgpu: 256M of VRAM memory r=
eady
[  492.151986] amdgpu 0000:00:01.0: amdgpu: amdgpu: 7849M of GTT memory r=
eady.
[  492.152017] [drm] GART: num cpu pages 262144, num gpu pages 262144
[  492.152063] [drm] PCIE GART of 1024M enabled (table at 0x000000F400E00=
000).
[  492.157012] amdgpu 0000:00:01.0: amdgpu: [drm] Internal thermal contro=
ller without fan control
[  492.157021] amdgpu 0000:00:01.0: amdgpu: [drm] dpm initialized
[  492.160402] [drm] Found UVD firmware Version: 1.64 Family ID: 9
[  492.162619] [drm] Found VCE firmware Version: 50.10 Binary ID: 2
[  492.171961] amdgpu 0000:00:01.0: [drm] Unsupported Connector type:5!
[  492.171969] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't =
find connector id 7 in connector table of size 7.
[  492.172925] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't =
find connector id 8 in connector table of size 7.
[  492.173619] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't =
find connector id 9 in connector table of size 7.
[  492.174311] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't =
find connector id 10 in connector table of size 7.
[  492.175040] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't =
find connector id 11 in connector table of size 7.
[  492.175827] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't =
find connector id 12 in connector table of size 7.
[  492.176519] [drm:bios_parser_get_connector_id [amdgpu]] *ERROR* Can't =
find connector id 13 in connector table of size 7.
[  492.177351] amdgpu 0000:00:01.0: amdgpu: [drm] Display Core v3.2.344 i=
nitialized on DCE 8.1
[  492.199366] snd_hda_intel 0000:00:01.1: bound 0000:00:01.0 (ops amdgpu=
_dm_audio_component_bind_ops [amdgpu])
[  492.250812] [drm] UVD initialized successfully.
[  492.371074] [drm] VCE initialized successfully.
[  492.375051] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[  492.375074] kfd kfd: amdgpu: Total number of KFD nodes to be created: =
1
[  492.375192] amdgpu: Virtual CRAT table created for GPU
[  492.375275] amdgpu: Topology: Add dGPU node [0x130f:0x1002]
[  492.375278] kfd kfd: amdgpu: added device 1002:130f
[  492.375290] amdgpu 0000:00:01.0: amdgpu: SE 1, SH per SE 1, CU per SH =
8, active_cu_number 8
[  492.377072] BUG: kernel NULL pointer dereference, address: 00000000000=
0003c
[  492.377079] #PF: supervisor read access in kernel mode
[  492.377083] #PF: error_code(0x0000) - not-present page
[  492.377088] PGD 0 P4D 0=20
[  492.377093] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  492.377100] CPU: 3 UID: 0 PID: 1739 Comm: modprobe Not tainted 6.14.0-=
bisect-kaveri-oops #10
[  492.377108] Hardware name: System manufacturer System Product Name/A88=
X-PRO, BIOS 2001 04/30/2015
[  492.377116] RIP: 0010:amdgpu_device_cache_pci_state+0x7d/0x100 [amdgpu=
]
[  492.378216] Code: 84 9d 49 6a 00 48 8b 45 f8 f6 80 3c 08 00 00 01 74 0=
7 48 8b 80 f0 09 00 00 48 8b 40 10 48 8b 58 10 48 85 db 74 04 48 8b 58 38=
 <66> 81 7b 3c 02 10 74 07 b8 01 00 00 00 eb 91 48 83 bd 18 5f 05 00
[  492.378226] RSP: 0018:ffffa74fc1a137b8 EFLAGS: 00010246
[  492.378233] RAX: ffff9b7881a0b000 RBX: 0000000000000000 RCX: 000000000=
0000074
[  492.378238] RDX: 000000000000005e RSI: ffff9b7881291e10 RDI: ffff9b788=
5402e36
[  492.378242] RBP: ffff9b7887300010 R08: 0000000e00000010 R09: 000000000=
0002930
[  492.378246] R10: 0000000029300000 R11: 0000000000000000 R12: 000000000=
00004a8
[  492.378251] R13: 0000000000000000 R14: ffff9b7880180000 R15: 000000000=
0000000
[  492.378255] FS:  00007f9d9e2acf00(0000) GS:ffff9b7b90180000(0000) knlG=
S:0000000000000000
[  492.378261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  492.378265] CR2: 000000000000003c CR3: 0000000104950000 CR4: 000000000=
00506f0
[  492.378270] Call Trace:
[  492.378277]  <TASK>
[  492.378283]  ? __die_body.cold+0x19/0x27
[  492.378292]  ? page_fault_oops+0x15c/0x2e0
[  492.378298]  ? search_module_extables+0x19/0x60
[  492.378306]  ? search_bpf_extables+0x5f/0x80
[  492.378313]  ? exc_page_fault+0x7e/0x1a0
[  492.378319]  ? asm_exc_page_fault+0x26/0x30
[  492.378328]  ? amdgpu_device_cache_pci_state+0x7d/0x100 [amdgpu]
[  492.378951]  ? amdgpu_device_cache_pci_state+0x48/0x100 [amdgpu]
[  492.379442]  amdgpu_device_init.cold+0x1f59/0x2412 [amdgpu]
[  492.380088]  amdgpu_driver_load_kms+0x13/0x70 [amdgpu]
[  492.380582]  amdgpu_pci_probe+0x1e1/0x480 [amdgpu]
[  492.381068]  local_pci_probe+0x45/0x90
[  492.381075]  pci_device_probe+0xdd/0x270
[  492.381082]  really_probe+0xde/0x340
[  492.381087]  ? pm_runtime_barrier+0x54/0x90
[  492.381093]  ? __pfx___driver_attach+0x10/0x10
[  492.381097]  __driver_probe_device+0x78/0x110
[  492.381103]  driver_probe_device+0x1f/0xa0
[  492.381107]  __driver_attach+0xba/0x1c0
[  492.381112]  bus_for_each_dev+0x8f/0xe0
[  492.381119]  bus_add_driver+0x112/0x1f0
[  492.381126]  driver_register+0x72/0xd0
[  492.381131]  ? __pfx_amdgpu_init+0x10/0x10 [amdgpu]
[  492.381616]  do_one_initcall+0x5b/0x310
[  492.381624]  do_init_module+0x60/0x230
[  492.381629]  init_module_from_file+0x89/0xe0
[  492.381637]  idempotent_init_module+0x115/0x310
[  492.381644]  __x64_sys_finit_module+0x65/0xc0
[  492.381650]  do_syscall_64+0x82/0x190
[  492.381656]  ? vfs_read+0x164/0x370
[  492.381661]  ? vfs_read+0x164/0x370
[  492.381665]  ? __rseq_handle_notify_resume+0xa2/0x4a0
[  492.381671]  ? restore_fpregs_from_fpstate+0x3c/0xa0
[  492.381678]  ? switch_fpu_return+0x4e/0xd0
[  492.381684]  ? syscall_exit_to_user_mode+0x172/0x210
[  492.381689]  ? do_syscall_64+0x8e/0x190
[  492.381694]  ? vfs_statx+0x81/0x120
[  492.381700]  ? vfs_fstatat+0x75/0xa0
[  492.381705]  ? __do_sys_newfstatat+0x3c/0x80
[  492.381712]  ? syscall_exit_to_user_mode+0x4d/0x210
[  492.381717]  ? do_syscall_64+0x8e/0x190
[  492.381721]  ? do_syscall_64+0x8e/0x190
[  492.381726]  ? do_syscall_64+0x8e/0x190
[  492.381731]  ? exc_page_fault+0x7e/0x1a0
[  492.381735]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  492.381742] RIP: 0033:0x7f9d9db12779
[  492.381760] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05=
 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4f 86 0d 00 f7 d8 64 89 01 48
[  492.381768] RSP: 002b:00007ffe4cd71358 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000139
[  492.381774] RAX: ffffffffffffffda RBX: 0000564c05216d70 RCX: 00007f9d9=
db12779
[  492.381779] RDX: 0000000000000004 RSI: 0000564c0521bbf0 RDI: 000000000=
0000007
[  492.381783] RBP: 0000000000000004 R08: 0000000000000000 R09: 000000000=
0000000
[  492.381787] R10: 0000000000000000 R11: 0000000000000246 R12: 0000564c0=
521bbf0
[  492.381791] R13: 0000000000040000 R14: 0000564c05216e90 R15: 000000000=
0000000
[  492.381798]  </TASK>
[  492.381801] Modules linked in: amdgpu(+) amdxcp gpu_sched drm_panel_ba=
cklight_quirks drm_buddy sch_cake ifb sch_htb cls_u32 cls_flow cls_fw act=
_mirred sch_ingress ip6t_REJECT nf_reject_ipv6 nft_chain_nat nft_limit xt=
_iprange xt_MASQUERADE xt_addrtype xt_nat nf_nat xt_LOG nf_log_syslog xt_=
limit xt_tcpudp xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 i=
pt_REJECT nf_reject_ipv4 nft_compat nf_tables binfmt_misc nls_ascii nls_c=
p437 vfat fat edac_mce_amd snd_hda_codec_realtek kvm_amd snd_hda_codec_ge=
neric snd_hda_codec_hdmi snd_hda_scodec_component ccp snd_hda_intel snd_i=
ntel_dspcfg snd_intel_sdw_acpi kvm eeepc_wmi snd_hda_codec asus_wmi spars=
e_keymap snd_hda_core snd_hwdep platform_profile snd_pcm battery rfkill w=
mi_bmof snd_timer pcspkr k10temp fam15h_power at24 snd soundcore evdev sg=
 nct6775 nct6775_core hwmon_vid drivetemp efi_pstore configfs nfnetlink e=
fivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 dm_crypt dm_mo=
d hid_generic usbhid hid radeon drm_ttm_helper sd_mod ttm ghash_clmulni_i=
ntel
[  492.381896]  sha512_ssse3 drm_exec i2c_algo_bit sha256_ssse3 drm_subal=
loc_helper sha1_ssse3 drm_display_helper cec rc_core aesni_intel ahci drm=
_client_lib ohci_pci drm_kms_helper crypto_simd libahci ehci_pci xhci_pci=
 libata ehci_hcd cryptd ohci_hcd e1000e xhci_hcd drm sp5100_tco usbcore s=
csi_mod watchdog i2c_piix4 i2c_smbus usb_common scsi_common video wmi but=
ton
[  492.381970] CR2: 000000000000003c
[  492.382003] ---[ end trace 0000000000000000 ]---

Thanks,
John

>=20
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 3 +
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 85 +++++++++++++++++=
+++--
> =C2=A02 files changed, 83 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index e4ecce1c4196..c8fe3e34e784 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -918,6 +918,9 @@ struct amdgpu_pcie_reset_ctx {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool in_link_reset;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool occurs_dpc;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool audio_suspended;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *swus;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_saved_state *swus_pcis=
tate;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_saved_state *swds_pcis=
tate;
> =C2=A0};
> =C2=A0
> =C2=A0/*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index 26706fab0de9..0e8c17f328e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -178,6 +178,8 @@ struct amdgpu_init_level amdgpu_init_minimal_xgmi =3D=
 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BIT(AMD_IP_BLOCK_TYPE_PSP)
> =C2=A0};
> =C2=A0
> +static void amdgpu_device_load_switch_state(struct amdgpu_device *adev=
);
> +
> =C2=A0static inline bool amdgpu_ip_member_of_hwini(struct amdgpu_device=
 *adev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_ip_block_type b=
lock)
> =C2=A0{
> @@ -5027,7 +5029,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *=
adev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->reset_domain =3D=
 NULL;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(adev->pci_state)=
;
> -
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(adev->pcie_reset_ctx.swds_p=
cistate);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree(adev->pcie_reset_ctx.swus_p=
cistate);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -6985,16 +6988,34 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct p=
ci_dev *pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_device *=
tmp_adev;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_hive_inf=
o *hive;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct list_head devic=
e_list;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r =3D 0, i;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *link_dev;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r =3D 0, i, timeout;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 memsize;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 status;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_info(adev->dev, "P=
CI error: slot reset callback!!\n");
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&reset_context,=
 0, sizeof(reset_context));
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* wait for asic to come out of r=
eset */
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep(700);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->pcie_reset_ctx.swus)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 link_dev =3D adev->pcie_reset_ctx.swus;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 link_dev =3D adev->pdev;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* wait for asic to come out of r=
eset, timeout =3D 10s */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timeout =3D 10000;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 usleep_range(10000, 10500);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 r =3D pci_read_config_word(link_dev, PCI_VENDOR_ID, &status)=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 timeout -=3D 10;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } while (timeout > 0 && (status !=
=3D PCI_VENDOR_ID_ATI) &&
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 (status !=3D PCI_VENDOR_ID_AMD));
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((status !=3D PCI_VENDOR_ID_AT=
I) && (status !=3D PCI_VENDOR_ID_AMD)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 r =3D -ETIME;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto out;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_device_load_switch_state(a=
dev);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Restore PCI confspa=
ce */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_device_load_pci=
_state(pdev);
> =C2=A0
> @@ -7096,6 +7117,58 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> +static void amdgpu_device_cache_switch_state(struct amdgpu_device *ade=
v)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *parent =3D pci_up=
stream_bridge(adev->pdev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (parent->vendor !=3D PCI_VENDO=
R_ID_ATI)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If already saved, return */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (adev->pcie_reset_ctx.swus)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Upstream bridge is ATI, assume=
 it's SWUS/DS architecture */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D pci_save_state(parent);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->pcie_reset_ctx.swds_pcistat=
e =3D pci_store_saved_state(parent);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 parent =3D pci_upstream_bridge(pa=
rent);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D pci_save_state(parent);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (r)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->pcie_reset_ctx.swus_pcistat=
e =3D pci_store_saved_state(parent);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->pcie_reset_ctx.swus =3D par=
ent;
> +}
> +
> +static void amdgpu_device_load_switch_state(struct amdgpu_device *adev=
)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct pci_dev *pdev;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int r;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!adev->pcie_reset_ctx.swds_pc=
istate ||
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !adev->pc=
ie_reset_ctx.swus_pcistate)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdev =3D adev->pcie_reset_ctx.swu=
s;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D pci_load_saved_state(pdev, =
adev->pcie_reset_ctx.swus_pcistate);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!r) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pci_restore_state(pdev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 dev_warn(adev->dev, "Failed to load SWUS state, err:%d\n", r=
);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pdev =3D pci_upstream_bridge(adev=
->pdev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D pci_load_saved_state(pdev, =
adev->pcie_reset_ctx.swds_pcistate);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!r)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pci_restore_state(pdev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 dev_warn(adev->dev, "Failed to load SWDS state, err:%d\n", r=
);
> +}
> +
> =C2=A0bool amdgpu_device_cache_pci_state(struct pci_dev *pdev)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct drm_device *dev=
 =3D pci_get_drvdata(pdev);
> @@ -7120,6 +7193,8 @@ bool amdgpu_device_cache_pci_state(struct pci_dev=
 *pdev)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_device_cache_switch_state(=
adev);
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> =C2=A0}
> =C2=A0
> @@ -7555,4 +7630,4 @@ u64 amdgpu_device_get_uid(struct amdgpu_uid *uid_=
info,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return uid_info->uid[t=
ype][inst];
> -}
> \ No newline at end of file
> +}
> --=20
> 2.49.0
>=20

