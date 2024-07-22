Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2108C3DA59
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 19:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D0210E2CE;
	Mon, 22 Jul 2024 19:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VejNqneX";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF9BA10E2CE
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 19:36:43 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2c964f5a037so2591182a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721677003; x=1722281803; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/8X/AtNSLV0rySM6FEIHF+gBEJIFEtdy/sMFA1TsEY=;
 b=VejNqneX/PzWRHIjIV5fpt8XAmgD+sKlv5BmR06h/T6MCT4i1fkzldV+NWmZ5SJvGP
 56HjNlQxpvwvxJSYS3nDw+CpcEjFbnIT9WJQbtr6EoXBih1EnBUJnPXIZQkgcvpd689u
 K//xx2ubJHaKzGe4ouoW5nX67HFWxoZbHfMQz7ytlbXmv2z7w6Noa2N50iZG3Mh0CKbL
 bAPdndWJnOsOj8IfUR8L/3r7IqXaNV3Uqu3/F1BNuzN1Mm1YNGY27WjHWWQVDdhTaef9
 agwqLEheboG9vO9xqJkKN+NZMHIt0MRP/k9vD4va6IAqKK3jl3wE/RmUhagQ4YleX/Jn
 nnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721677003; x=1722281803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X/8X/AtNSLV0rySM6FEIHF+gBEJIFEtdy/sMFA1TsEY=;
 b=ew3R8kVjEAnlMmx4HQcXuF4XxcOI0LxHFOXPTkU+PPW3eX08pz+RHE0k6p/VfpIAiC
 kl0c/kvXSAMs4+2KkzMLGXNNcpZIQ3u4BkCZG39q6w4kCCUsixeTi4zk5tNNFW3vdgpf
 tl2hIUXvco+GIatAlcpTBHg/1IobTcy78CIy0cqlYZf1e/KJfPzh5mdLSTrD+6wWKT7L
 a6QaeyOqUGHVJrrLFmORgg7HiH4DBY/tnpJufHdRx0fbrh0Q/blTX2qYuLATNtosp9WU
 Y4KUuDrU5a1Sl3fjfi1FMMidYgwepiLSctOUGItG6dcJRE0BH9HEWf1CZua8SXFnJzY3
 B6Vw==
X-Gm-Message-State: AOJu0YxVebglqXCxaOuUUHVlsHYQCrZM/KBMHhjg7CLEzsCbdYsSzfre
 hlxyorCisfVVxgZrtq7xFvlL9anRdYEjtLnCy/pm0BNTFyaQ7D8eug9INSmgDvbUJ3gTSlIwpC7
 khsJxDyCxfFYtjv10HwodwsylIbsjP6/8
X-Google-Smtp-Source: AGHT+IFuU1ek+alw6l9KYCvYv1XDuPEPWx49yEyjlRj57SPzoWhARcA5IEhQhKjISX7M/trIZKyxlga/J3XwUdOjyU8=
X-Received: by 2002:a17:90a:8d13:b0:2c8:8a5:c1b9 with SMTP id
 98e67ed59e1d1-2cd1603a851mr5649797a91.13.1721677003203; Mon, 22 Jul 2024
 12:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240722081625.85392-1-jesse.zhang@amd.com>
In-Reply-To: <20240722081625.85392-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Jul 2024 15:36:31 -0400
Message-ID: <CADnq5_OFNouf7gsQ-KzB1sJ-kdW=qA3jdZFyZJyFMoG6nmuRyQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix gfx10 kiq ring_lock warning on full reset
To: Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jul 22, 2024 at 4:16=E2=80=AFAM Jesse Zhang <jesse.zhang@amd.com> w=
rote:
>
> Fix warning about kiq ring.
> Unlock kiq ring when queue reset fails.
>
> [  285.999224] amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
> [  312.018425] watchdog: BUG: soft lockup - CPU#11 stuck for 26s! [kworke=
r/u64:2:878]
> [  312.018428] Modules linked in: amdgpu(E) amdxcp drm_exec gpu_sched drm=
_buddy drm_suballoc_helper drm_ttm_helper ttm drm_display_helper cec rc_cor=
e drm_kms_helper i2c_algo_bit rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd g=
race netfs xt_conntrack nft_chain_nat r8153_ecm cdc_ether usbnet xt_MASQUER=
ADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 =
xfrm_user xfrm_algo xt_multiport xt_addrtype nft_compat nf_tables br_netfil=
ter libcrc32c nfnetlink bridge stp llc r8152 mii joydev input_leds overlay =
snd_hda_codec_hdmi edac_mce_amd snd_hda_intel snd_intel_dspcfg snd_intel_sd=
w_acpi kvm_amd snd_hda_codec snd_hda_core snd_hwdep kvm hid_generic snd_pcm=
 crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 =
aesni_intel snd_seq_midi snd_seq_midi_event snd_rawmidi crypto_simd usbhid =
cryptd hid snd_seq snd_pci_acp5x snd_seq_device snd_timer snd_rn_pci_acp3x =
rapl snd_acp_config snd_soc_acpi snd ccp snd_pci_acp3x wmi_bmof soundcore k=
10temp mac_hid sunrpc binfmt_misc sch_fq_codel msr parport_pc
> [  312.018466]  ppdev lp drm parport efi_pstore ip_tables x_tables autofs=
4 ucsi_ccg typec_ucsi typec nvme crc32_pclmul nvme_core xhci_pci i2c_design=
ware_pci i2c_piix4 xhci_pci_renesas i2c_ccgx_ucsi video wmi
> [  312.018475] CPU: 11 PID: 878 Comm: kworker/u64:2 Tainted: G           =
 E      6.8.0+ #171
> [  312.018477] Hardware name: AMD Splinter/Splinter-GNR, BIOS WS54117N_14=
0 01/16/2024
> [  312.018478] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sc=
hed]
> [  312.018485] RIP: 0010:native_queued_spin_lock_slowpath+0x88/0x300
> [  312.018490] Code: 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 41 8b 04 24 30 e=
4 09 d0 a9 00 01 ff ff 75 5e 85 c0 74 14 41 0f b6 04 24 84 c0 74 0b f3 90 <=
41> 0f b6 04 24 84 c0 75 f5 b8 01 00 00 00 66 41 89 04 24 5b 41 5c
> [  312.018492] RSP: 0018:ffffa327c0de7b80 EFLAGS: 00000202
> [  312.018493] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 000000000=
0000000
> [  312.018494] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8ab91=
3e16cf8
> [  312.018495] RBP: ffffa327c0de7ba8 R08: 0000000000000000 R09: fffffa400=
7040000
> [  312.018495] R10: ffffa327c0de7bb8 R11: 0000000000000040 R12: ffff8ab91=
3e16cf8
> [  312.018496] R13: ffff8ab913e00000 R14: ffff8ab913e00000 R15: ffff8ab91=
3e00000
> [  312.018497] FS:  0000000000000000(0000) GS:ffff8ab9956c0000(0000) knlG=
S:0000000000000000
> [  312.018498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  312.018498] CR2: 00007f44b24d319c CR3: 000000023b83c000 CR4: 000000000=
0750ef0
> [  312.018499] PKRU: 55555554
> [  312.018500] Call Trace:
> [  312.018501]  <IRQ>
> [  312.018504]  ? show_regs+0x6c/0x80
> [  312.018508]  ? watchdog_timer_fn+0x206/0x290
> [  312.018511]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [  312.018513]  ? __hrtimer_run_queues+0xc8/0x220
> [  312.018517]  ? hrtimer_interrupt+0x10d/0x250
> [  312.018519]  ? __sysvec_apic_timer_interrupt+0x51/0x130
> [  312.018522]  ? sysvec_apic_timer_interrupt+0x7f/0x90
> [  312.018525]  </IRQ>
> [  312.018525]  <TASK>
> [  312.018526]  ? asm_sysvec_apic_timer_interrupt+0x1f/0x30
> [  312.018529]  ? native_queued_spin_lock_slowpath+0x88/0x300
> [  312.018530]  _raw_spin_lock+0x2d/0x40
> [  312.018532]  amdgpu_gfx_disable_kgq+0x6f/0x1d0 [amdgpu]
> [  312.018646]  gfx_v10_0_hw_fini+0x111/0x130 [amdgpu]
> [  312.018742]  gfx_v10_0_suspend+0x12/0x20 [amdgpu]
> [  312.018832]  amdgpu_device_ip_suspend_phase2+0x244/0x470 [amdgpu]
> [  312.018909]  amdgpu_device_ip_suspend+0x4b/0x90 [amdgpu]
> [  312.018989]  amdgpu_device_pre_asic_reset+0xda/0x4b0 [amdgpu]
> [  312.019068]  amdgpu_device_gpu_recover+0x319/0xe20 [amdgpu]
> [  312.019147]  amdgpu_job_timedout+0x177/0x280 [amdgpu]
> [  312.019266]  drm_sched_job_timedout+0x7c/0x100 [gpu_sched]
> [  312.019269]  process_scheduled_works+0x9a/0x3a0
> [  312.019272]  ? __pfx_worker_thread+0x10/0x10
> [  312.019273]  worker_thread+0x15f/0x2d0
> [  312.019275]  ? __pfx_worker_thread+0x10/0x10
> [  312.019276]  kthread+0xfb/0x130
> [  312.019277]  ? __pfx_kthread+0x10/0x10
> [  312.019278]  ret_from_fork+0x3d/0x60
> [  312.019280]  ? __pfx_kthread+0x10/0x10
> [  312.019281]  ret_from_fork_asm+0x1b/0x30
> [  312.019284]  </TASK>
>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Good catch.  I've squashed this into the appropriate patch and pushed
and updated branch here:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next-q=
ueue-reset

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index fde11159270c..59024fbf8c22 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -9478,6 +9478,7 @@ static int gfx_v10_0_reset_compute_ring(struct amdg=
pu_ring *ring,
>                                    0, 0);
>         amdgpu_ring_commit(kiq_ring);
>
> +       spin_unlock_irqrestore(&kiq->ring_lock, flags);
>         r =3D amdgpu_ring_test_ring(kiq_ring);
>         if (r)
>                 return r;
> @@ -9530,8 +9531,6 @@ static int gfx_v10_0_reset_compute_ring(struct amdg=
pu_ring *ring,
>         if (r)
>                 return r;
>
> -       spin_unlock_irqrestore(&kiq->ring_lock, flags);
> -
>         return amdgpu_ring_test_ring(ring);
>  }
>
> --
> 2.25.1
>
