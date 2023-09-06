Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 519EBEE14A0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 16:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBDDD10E6B1;
	Wed,  6 Sep 2023 16:02:59 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A92CE10E6A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 16:02:58 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-57128297bd7so2437003eaf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 09:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694016178; x=1694620978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xpf2OK2TtDsutjShLH/JWHF6tUm2pW1spbo4msuC6v4=;
 b=fEtMpVVbx4sivgigwJewfoXxrOlN2/7H/UwA0bBoVk18/g0UmnD2h6WmBNILUJWKi6
 3hYeULDgpBJNVFLDLq+Ug2V0qYk5JiiGCf6IMNVVgtTObxGDYr25Q1YAG1oeAA3zigzn
 OjwxMR2Udvsz/bn16IDYY2Ozi1DJ7hpT9CzSQ05p6+Ywoew8Zovgimgjtm0ya4vfJ415
 SDKqIsv+el4NDi2RGxo31dzA/zK0qyM6/ZrWV3UPr86rQM3h3vQZPPrkJKjc8xfWup59
 AKXPgrLPYBpjzg/jki1/iRtEjzxX8k/4Lz1QC7ArQvBL8wa8lSvFkdiQcFk1967NDCys
 f6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694016178; x=1694620978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xpf2OK2TtDsutjShLH/JWHF6tUm2pW1spbo4msuC6v4=;
 b=h2lMjkDKYzuBYzlphKdIetp8jiWN/zKhSxf2XsoWcZMhoEERwgcDk5/llwCCGHjP9q
 HMRlEfCXulsabPPxipZx9ZfaZSco60XWb4mxdofGbxoUZ3xkCQ7uwsRvoKuhfDwmcWh5
 fq6Wavj1DsVXzQYYT2cIPYSgEJdd7iX+s/rs/q9TyHaqzFOiVnZl+g4nqIuZk/fBatrA
 jyk3M3vD6Njqzil2bU/KdzdczazN3qAi5B2YXftcbxwcoI4b1pyIPFxyhPZXb5Ki6ByE
 KUTa1no7EuLzKs1XeOmphB0M65H1uMCdIOXuo8UN0GjAlzUSl/BR4bV4DSh+I/c3K43D
 85jQ==
X-Gm-Message-State: AOJu0YyEyl6eGgloFq+2s7tEeEvtoTCoDUmSdq++G/nt0tm7EXHMQgC7
 7d2zy1hmU0H76kR/RH6qH9kf93B9iXemSlElN7A/Ndvl
X-Google-Smtp-Source: AGHT+IHMD/xapZM5LTAjFPxlUks0RIsiIJzShPcwiUWFfzsCUWQfbUBCGv0QrTXp5Wc9ywR3QiIT7YHdpH85D6OKLgc=
X-Received: by 2002:a4a:d212:0:b0:573:4da2:4427 with SMTP id
 c18-20020a4ad212000000b005734da24427mr15009665oos.7.1694016177784; Wed, 06
 Sep 2023 09:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230906153907.216159-1-mukul.joshi@amd.com>
In-Reply-To: <20230906153907.216159-1-mukul.joshi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 6 Sep 2023 12:02:46 -0400
Message-ID: <CADnq5_MqUw5xd9O7vA=E2s89mqztKt49stsXiid-kMrTNy13Jw@mail.gmail.com>
Subject: Re: [PATCHv3] drm/amdkfd: Fix unaligned 64-bit doorbell warning
To: Mukul Joshi <mukul.joshi@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>
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
Cc: felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

+ Shashank

On Wed, Sep 6, 2023 at 11:45=E2=80=AFAM Mukul Joshi <mukul.joshi@amd.com> w=
rote:
>
> This patch fixes the following unaligned 64-bit doorbell
> warning seen when submitting packets on HIQ on GFX v9.4.3
> by making the HIQ doorbell 64-bit aligned.
> The warning is seen when GPU is loaded in any mode other
> than SPX mode.
>
> [  +0.000301] ------------[ cut here ]------------
> [  +0.000003] Unaligned 64-bit doorbell
> [  +0.000030] WARNING: /amdkfd/kfd_doorbell.c:339 write_kernel_doorbell64=
+0x72/0x80
> [  +0.000003] RIP: 0010:write_kernel_doorbell64+0x72/0x80
> [  +0.000004] RSP: 0018:ffffc90004287730 EFLAGS: 00010246
> [  +0.000005] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000=
000000
> [  +0.000003] RDX: 0000000000000001 RSI: ffffffff82837c71 RDI: 00000000ff=
ffffff
> [  +0.000003] RBP: ffffc90004287748 R08: 0000000000000003 R09: 0000000000=
000001
> [  +0.000002] R10: 000000000000001a R11: ffff88a034008198 R12: ffffc90001=
3bd004
> [  +0.000003] R13: 0000000000000008 R14: ffffc900042877b0 R15: 0000000000=
00007f
> [  +0.000003] FS:  00007fa8c7b62000(0000) GS:ffff889f88400000(0000) knlGS=
:0000000000000000
> [  +0.000004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  +0.000003] CR2: 000056111c45aaf0 CR3: 00000001414f2002 CR4: 0000000000=
770ee0
> [  +0.000003] PKRU: 55555554
> [  +0.000002] Call Trace:
> [  +0.000004]  <TASK>
> [  +0.000006]  kq_submit_packet+0x45/0x50 [amdgpu]
> [  +0.000524]  pm_send_set_resources+0x7f/0xc0 [amdgpu]
> [  +0.000500]  set_sched_resources+0xe4/0x160 [amdgpu]
> [  +0.000503]  start_cpsch+0x1c5/0x2a0 [amdgpu]
> [  +0.000497]  kgd2kfd_device_init.cold+0x816/0xb42 [amdgpu]
> [  +0.000743]  amdgpu_amdkfd_device_init+0x15f/0x1f0 [amdgpu]
> [  +0.000602]  amdgpu_device_init.cold+0x1813/0x2176 [amdgpu]
> [  +0.000684]  ? pci_bus_read_config_word+0x4a/0x80
> [  +0.000012]  ? do_pci_enable_device+0xdc/0x110
> [  +0.000008]  amdgpu_driver_load_kms+0x1a/0x110 [amdgpu]
> [  +0.000545]  amdgpu_pci_probe+0x197/0x400 [amdgpu]
>
> Fixes: cfeaeb3c0ce7 ("drm/amdgpu: use doorbell mgr for kfd kernel doorbel=
ls")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
> v1->v2:
> - Update the logic to make it work with both 32 bit
>   64 bit doorbells.
> - Add the Fixed tag
> v2->v3:
> - Revert to the original change to align it with whats done in
>   amdgpu_doorbell_index_on_bar.
>
>  drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_doorbell.c
> index c2e0b79dcc6d..7b38537c7c99 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -162,6 +162,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev =
*kfd,
>                 return NULL;
>
>         *doorbell_off =3D amdgpu_doorbell_index_on_bar(kfd->adev, kfd->do=
orbells, inx);
> +       inx *=3D 2;
>
>         pr_debug("Get kernel queue doorbell\n"
>                         "     doorbell offset   =3D=3D 0x%08X\n"
> @@ -176,6 +177,7 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd,=
 u32 __iomem *db_addr)
>         unsigned int inx;
>
>         inx =3D (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
> +       inx /=3D 2;
>
>         mutex_lock(&kfd->doorbell_mutex);
>         __clear_bit(inx, kfd->doorbell_bitmap);
> --
> 2.35.1
>
