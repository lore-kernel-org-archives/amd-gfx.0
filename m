Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E54CE7AB9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 18:09:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB0D10E2BD;
	Mon, 25 Sep 2023 18:09:13 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2901910E2BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 18:09:11 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1dceaa7aeffso1929811fac.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695665350; x=1696270150; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O1YlP/d3qVlwWIlt6BRMUXp2hj8nNXjKm/wLgo3YSnc=;
 b=iD9xhrIPU1bSDfcQRB+3f33zIXfCKj9dLo/7HZXNhpgcWaqvS8Z2/AKlCgMtrktprY
 UbPqvlGPevG7mwfalz5HZrOpMBLZ2qX/kW0k8iIjPH37w5EMstPioTDvAb7NYRQVAaCj
 6YFT93V7OF9oEmoiWNqJzdrsl8vgLsVSQiiLQaNj3Qq2YpsNrRLy6WVemU8uA2v4fj5w
 bOx1ZxKHf5aC5T3xx0v20yvikISvl3j4czaqMV0zmv3G4k6Ws4cxXNwttqhhS0lu6p3q
 rkQuqK+vfk7yo/8sOFq3E5p987lzARmX7hNq+tBIXXUpYyIndnsK58QEHdTyZT+sy8ew
 V1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695665350; x=1696270150;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O1YlP/d3qVlwWIlt6BRMUXp2hj8nNXjKm/wLgo3YSnc=;
 b=j69yx9f4CrCe22RAYf0QDvD7l7B/yCSi1djKYKaPQN7FJCwwOSyZ098dmYpb+g96Qc
 BoydPVJjHnBge58rNqK6gCVFfg5B1SvHsA03J4uH22qO2zJz+sTeccNSKjFa+YgVVfE0
 uzaVNet3QPBMAP7EonRAbkmlFlJtGb36zKvF+JeTcyL5ur+SwMvpEHvEObCVpjRwB8h7
 CfFjk9Hi0WfgTSrhDk1ULO0wpqFRAw+ZzruQ/scOM2H8yV7xpt9fBCUBcDOOuK1fl7S2
 3lX7WM42b29ou6f6+NL+bbQjxLRfCkL57//LkJiDIWDbkKjt5E8pWe8Ap4uDAq1kcrhB
 Nyjg==
X-Gm-Message-State: AOJu0YxytahBKjDBkrOBhDU4LTld2PXkn9aCOxzKAJEIHgfDeiq2SHB/
 uVw2/QqddB08SmGLKu6v5fJ2Wq9ni4CAIUyttLeuDyTl
X-Google-Smtp-Source: AGHT+IHHOGzQ6fY4tgLF7jaQVUrNvYOPvXb8q30xpH1UcYqdZeDsk8eAJaIi37M+D6lP1IsaD4+rJGKtaBORYnWvX0w=
X-Received: by 2002:a05:6870:d609:b0:1b7:273d:780a with SMTP id
 a9-20020a056870d60900b001b7273d780amr249684oaq.22.1695665350288; Mon, 25 Sep
 2023 11:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230923111651.719593-1-yifan1.zhang@amd.com>
 <BN9PR12MB52577619DDE258CA1F89A5E4FCFCA@BN9PR12MB5257.namprd12.prod.outlook.com>
 <BN9PR12MB5257AE0760BA4835714303A8FCFCA@BN9PR12MB5257.namprd12.prod.outlook.com>
 <CY5PR12MB63697922C3AC69AD31C7F8B3C1FCA@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB63697922C3AC69AD31C7F8B3C1FCA@CY5PR12MB6369.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Sep 2023 14:08:58 -0400
Message-ID: <CADnq5_M6vWYSYaSU=JfADyOCeqYVJbx69CbNGj-krD=u9U8LZg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 25, 2023 at 10:16=E2=80=AFAM Zhang, Yifan <Yifan1.Zhang@amd.com=
> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Hawking,
>
> No, no gfx HW programming before gfx power on, gmc_v11_0_flush_gpu_tlb re=
turns before real tbl flush happens.  The dependence is a pure SW one as be=
low:
>
> static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t =
vmid,
>                      uint32_t vmhub, uint32_t flush_type)
>  {
>      bool use_semaphore =3D gmc_v11_0_use_invalidate_semaphore(adev, vmhu=
b);
>      struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
>      u32 inv_req =3D hub->vmhub_funcs->get_invalidate_req(vmid, flush_typ=
e);  ---> get_invalidate_req  is NULL if gfxhub.funcs->init not called.
> ......
>      if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
>          return;
> }
>
> We can either move vmhub =3D=3D AMDGPU_GFXHUB(0) before get_invalidate_re=
q or move gfxhub.funcs->init to gmc sw_init as the patch does.  To align w/=
 other generations, I choose the later approach.
> Driver loading failure was observed on GC 11.0.4, but it should be univer=
sal to all gfx11 ASICs.

This should be fine.  the hub->init() functions don't touch hardware.
Maybe we could even rename them sw_init().  They only need to be
called once at driver load time.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex


>
> BRs,
> Yifan.
>
>
>
> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, September 25, 2023 7:33 PM
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhang, Yifan <Yifan1.Zhang@am=
d.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.=
Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init
>
> [AMD Official Use Only - General]
>
> For sw_init, it's fine to move to gmc sw_init phase, but any hardware pro=
gramming should be done after smu hw_init.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang,=
 Hawking
> Sent: Monday, September 25, 2023 19:30
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.=
Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init
>
> [AMD Official Use Only - General]
>
> [AMD Official Use Only - General]
>
> RE - gmc11 hw_init depends on adev->gfxhub.funcs->init now, move it to gm=
c11 sw_init
>
> isn't any driver loading failure observed? Since from gfx11, GFX won't be=
 powered on until smu hw_init phase. Any programming that touch gfx core is=
 invalid before it is powered on.
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yifan =
Zhang
> Sent: Saturday, September 23, 2023 19:17
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.=
Zhang@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
> Subject: [PATCH] drm/amdgpu: move gfxhub.funcs->init to gmc sw_init
>
> gmc11 hw_init depends on adev->gfxhub.funcs->init now, move it to gmc11 s=
w_init. This patch fixes below driver load error on GC 11.0.4:
>
> [   43.928149] [drm] amdgpu: 512M of VRAM memory ready
> [   43.928151] [drm] amdgpu: 7641M of GTT memory ready.
> [   43.928168] [drm] GART: num cpu pages 131072, num gpu pages 131072
> [   43.928182] BUG: kernel NULL pointer dereference, address: 00000000000=
00008
> [   43.928185] #PF: supervisor read access in kernel mode
> [   43.928187] #PF: error_code(0x0000) - not-present page
> [   43.928188] PGD 0 P4D 0
> [   43.928191] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   43.928193] CPU: 7 PID: 1278 Comm: modprobe Tainted: G           OE   =
   6.3.7+ #73
> [   43.928198] RIP: 0010:gmc_v11_0_flush_gpu_tlb+0x59/0x4d0 [amdgpu]
> [   43.928406] Code: 8b 4d d4 48 89 4d c8 83 f9 0d 0f 87 7c 04 00 00 48 8=
b 45 c8 44 89 ee 44 89 e7 48 8d 04 80 48 c1 e0 04 49 8b 84 07 90 eb 00 00 <=
48> 8b 40 08 ff d0 0f 1f 00 44 8b 45 d4 41 89 c5 45 85 c0 0f 85 c0
> [   43.928409] RSP: 0018:ffffae24c28277f0 EFLAGS: 00010256
> [   43.928411] RAX: 0000000000000000 RBX: ffff95bf0ed80000 RCX: 000000000=
0000000
> [   43.928413] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
0000000
> [   43.928414] RBP: ffffae24c2827848 R08: 0003000000000077 R09: 000000000=
0000401
> [   43.928416] R10: 0000000000001000 R11: 0000000000001000 R12: 000000000=
0000000
> [   43.928417] R13: 0000000000000000 R14: 0000000000000000 R15: ffff95bf0=
ed80000
> [   43.928418] FS:  00007f2703c83000(0000) GS:ffff95c26e7c0000(0000) knlG=
S:0000000000000000
> [   43.928421] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   43.928422] CR2: 0000000000000008 CR3: 000000012c300000 CR4: 000000000=
0750ee0
> [   43.928424] PKRU: 55555554
> [   43.928425] Call Trace:
> [   43.928426]  <TASK>
> [   43.928428]  ? show_regs+0x6e/0x80
> [   43.928434]  ? __die+0x29/0x70
> [   43.928436]  ? page_fault_oops+0x154/0x4a0
> [   43.928440]  ? amdgpu_bo_move+0x25b/0x790 [amdgpu]
> [   43.928612]  ? do_user_addr_fault+0x325/0x710
> [   43.928615]  ? exc_page_fault+0x7a/0x180
> [   43.928619]  ? asm_exc_page_fault+0x2b/0x30
> [   43.928623]  ? gmc_v11_0_flush_gpu_tlb+0x59/0x4d0 [amdgpu]
> [   43.928797]  ? amdgpu_gart_bind+0x64/0xc0 [amdgpu]
> [   43.928974]  amdgpu_gmc_flush_gpu_tlb+0x258/0x2e0 [amdgpu]
> [   43.929159]  amdgpu_gart_invalidate_tlb+0x66/0xa0 [amdgpu]
> [   43.929332]  amdgpu_gtt_mgr_recover+0x67/0x80 [amdgpu]
> [   43.929504]  gmc_v11_0_hw_init+0x4c/0x130 [amdgpu]
> [   43.929690]  amdgpu_device_init+0x1766/0x2d60 [amdgpu]
> [   43.929858]  ? pci_bus_read_config_word+0x4b/0x80
> [   43.929862]  ? do_pci_enable_device+0xdb/0x110
> [   43.929866]  amdgpu_driver_load_kms+0x1e/0x1a0 [amdgpu]
> [   43.930032]  amdgpu_pci_probe+0x16b/0x4e0 [amdgpu]
> [   43.930201]  local_pci_probe+0x4c/0xb0
> [   43.930204]  pci_device_probe+0xcc/0x280
> [   43.930207]  really_probe+0x1c4/0x430
> [   43.930210]  __driver_probe_device+0x8a/0x180
> [   43.930212]  driver_probe_device+0x23/0xc0
> [   43.930214]  __driver_attach+0xfb/0x200
> [   43.930215]  ? __pfx___driver_attach+0x10/0x10
> [   43.930217]  bus_for_each_dev+0x7e/0xd0
> [   43.930221]  driver_attach+0x22/0x30
> [   43.930222]  bus_add_driver+0x120/0x230
> [   43.930224]  driver_register+0x68/0x130
> [   43.930226]  ? __pfx_init_module+0x10/0x10 [amdgpu]
> [   43.930394]  __pci_register_driver+0x6c/0x80
> [   43.930396]  amdgpu_init+0x67/0xff0 [amdgpu]
> [   43.930549]  do_one_initcall+0x4a/0x240
> [   43.930554]  ? kmalloc_trace+0x2e/0xa0
> [   43.930559]  do_init_module+0x52/0x230
> [   43.930563]  load_module+0x2386/0x2880
> [   43.930566]  ? security_kernel_post_read_file+0x60/0x70
> [   43.930571]  __do_sys_finit_module+0xc8/0x140
> [   43.930573]  ? __do_sys_finit_module+0xc8/0x140
> [   43.930576]  __x64_sys_finit_module+0x1c/0x30
> [   43.930578]  do_syscall_64+0x5d/0x90
> [   43.930581]  ? syscall_exit_to_user_mode+0x2a/0x50
> [   43.930583]  ? __x64_sys_mmap+0x37/0x50
> [   43.930586]  ? do_syscall_64+0x6d/0x90
> [   43.930588]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Fixes: c6f52f1ffd91 (drm/amdgpu: cleanup gmc_v11_0_flush_gpu_tlb)
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 --  drivers/gpu/drm/amd/amdgp=
u/gmc_v11_0.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 42fc0cc13fdd..9c4562bda8cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1329,8 +1329,6 @@ static int gfx_v11_0_sw_init(void *handle)
>         struct amdgpu_kiq *kiq;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -       adev->gfxhub.funcs->init(adev);
> -
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(11, 0, 0):
>         case IP_VERSION(11, 0, 2):
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 7d61f66625fa..d0e3583a3cac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -720,6 +720,8 @@ static int gmc_v11_0_sw_init(void *handle)
>
>         adev->mmhub.funcs->init(adev);
>
> +       adev->gfxhub.funcs->init(adev);
> +
>         spin_lock_init(&adev->gmc.invalidate_lock);
>
>         r =3D amdgpu_atomfirmware_get_vram_info(adev,
> --
> 2.37.3
>
>
