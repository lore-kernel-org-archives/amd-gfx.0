Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8E8C11D3D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D869924656
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 14:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGNSFkG6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D869924656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BAF6ECC1;
	Thu, 27 Feb 2020 14:40:15 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E89F6ECC7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 14:40:14 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id j16so2107291wrt.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 06:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sGjBMwipw+Cp7QXt0l73+tVVMPm35dUj6dG3FsWGbKw=;
 b=DGNSFkG6g4peDf5jyPXXLFTPGJ+A6I5fBfz+Vy4Db+qw6U9J/Ouc72YAiLSerAvMWb
 r7791udcqp4v522ETYDhKa4xiOdIZzoTVF5kpYA/b6cKRDM8/EtHx0KlBsY9UHV0Hx3d
 kgncOq18sdrsYIbyod+ncoQZcYjoHaYpeXoyDMwdSUbFhchvYqcg644bdlZMXtpEiVlL
 MvDnnqVE761gSvxCAQ0MS4jNY3qVIx5+qm1ASfStQVL9oeIuRsi9vkUnCzeq2zT1VtcA
 GD/eCUEjGlz/HiAy7/80BfvCzVKoxNLA0XASfo/Ny0JF92L/USj6uDVrV0kikCmX0DnD
 IPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sGjBMwipw+Cp7QXt0l73+tVVMPm35dUj6dG3FsWGbKw=;
 b=NDIEGar1BCQzG/DrcPs0arrL2P4L5BAP4U3A6VWn8GAQMkOQTCTX98zvtv9N7BMFkZ
 ETKsUviQ+2LMWK7bSEqhqsv4I+hdIVmWWO8n6TI2rPx8onCfwI3gnj5I345uN1lfu9lY
 AkOdzgPn0GsYXdczlwEtwCSkpb66ukF/VJzFLe8s0vD86VSlFlgGUJdTcIYZzjTioS+T
 LWWZ5RZaFS45imOpvF1+5H5ug/ILRhQ+kk6yNHOLfh6Gbd6lVXtWba6sMdhq9yMHSwqX
 ntQHaTrnQR8erOJgZ0cuEHGqmVEv1Y/C2tA6PukA8WJVQ/3XnKtT6kFHlS4n7Hrhm8yJ
 5Ewg==
X-Gm-Message-State: APjAAAVdLM5yxZ0PyHQ8+phQpsNsEkckF/0wWK4z0SJCT32VYkpiu1rW
 vZXOucfucr2KkGkvhRl+MWJAej3YUPbDMF2RUmK+NQZ3
X-Google-Smtp-Source: APXvYqzfJGEGU2dNqbfs/hdJjcFci6JXcSreOkYPRjc6ucafYmJGFsbfyGdPXHPZ4ggoeU5Zy004We0xdEsDwPcx7ws=
X-Received: by 2002:a05:6000:4b:: with SMTP id
 k11mr4084592wrx.362.1582814412929; 
 Thu, 27 Feb 2020 06:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20200227124641.1412-1-yttao@amd.com>
In-Reply-To: <20200227124641.1412-1-yttao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Feb 2020 09:40:01 -0500
Message-ID: <CADnq5_OrzQQOG_vn3LkUz9qBMvNU0oudGt5PwCN3_wbZ2OacMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: no need to clean debugfs at amdgpu
To: Yintian Tao <yttao@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2020 at 7:46 AM Yintian Tao <yttao@amd.com> wrote:
>
> drm_minor_unregister will invoke drm_debugfs_cleanup
> to clean all the child node under primary minor node.
> We don't need to invoke amdgpu_debugfs_fini and
> amdgpu_debugfs_regs_cleanup to clean agian.
> Otherwise, it will raise the NULL pointer like below.
> [   45.046029] BUG: unable to handle kernel NULL pointer dereference at 00000000000000a8
> [   45.047256] PGD 0 P4D 0
> [   45.047713] Oops: 0002 [#1] SMP PTI
> [   45.048198] CPU: 0 PID: 2796 Comm: modprobe Tainted: G        W  OE     4.18.0-15-generic #16~18.04.1-Ubuntu
> [   45.049538] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   45.050651] RIP: 0010:down_write+0x1f/0x40
> [   45.051194] Code: 90 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 53 48 89 fb e8 ce d9 ff ff 48 ba 01 00 00 00 ff ff ff ff 48 89 d8 <f0> 48 0f c1 10 85 d2 74 05 e8 53 1c ff ff 65 48 8b 04 25 00 5c 01
> [   45.053702] RSP: 0018:ffffad8f4133fd40 EFLAGS: 00010246
> [   45.054384] RAX: 00000000000000a8 RBX: 00000000000000a8 RCX: ffffa011327dd814
> [   45.055349] RDX: ffffffff00000001 RSI: 0000000000000001 RDI: 00000000000000a8
> [   45.056346] RBP: ffffad8f4133fd48 R08: 0000000000000000 R09: ffffffffc0690a00
> [   45.057326] R10: ffffad8f4133fd58 R11: 0000000000000001 R12: ffffa0113cff0300
> [   45.058266] R13: ffffa0113c0a0000 R14: ffffffffc0c02a10 R15: ffffa0113e5c7860
> [   45.059221] FS:  00007f60d46f9540(0000) GS:ffffa0113fc00000(0000) knlGS:0000000000000000
> [   45.060809] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   45.061826] CR2: 00000000000000a8 CR3: 0000000136250004 CR4: 00000000003606f0
> [   45.062913] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   45.064404] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   45.065897] Call Trace:
> [   45.066426]  debugfs_remove+0x36/0xa0
> [   45.067131]  amdgpu_debugfs_ring_fini+0x15/0x20 [amdgpu]
> [   45.068019]  amdgpu_debugfs_fini+0x2c/0x50 [amdgpu]
> [   45.068756]  amdgpu_pci_remove+0x49/0x70 [amdgpu]
> [   45.069439]  pci_device_remove+0x3e/0xc0
> [   45.070037]  device_release_driver_internal+0x18a/0x260
> [   45.070842]  driver_detach+0x3f/0x80
> [   45.071325]  bus_remove_driver+0x59/0xd0
> [   45.071850]  driver_unregister+0x2c/0x40
> [   45.072377]  pci_unregister_driver+0x22/0xa0
> [   45.073043]  amdgpu_exit+0x15/0x57c [amdgpu]
> [   45.073683]  __x64_sys_delete_module+0x146/0x280
> [   45.074369]  do_syscall_64+0x5a/0x120
> [   45.074916]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> v2: remove all debugfs cleanup/fini code at amdgpu
>
> Signed-off-by: Yintian Tao <yttao@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 30 ---------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  7 -----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 10 -------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 -
>  7 files changed, 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 3bb74056b9d2..abc148280ba5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -992,18 +992,6 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>         return 0;
>  }
>
> -void amdgpu_debugfs_regs_cleanup(struct amdgpu_device *adev)
> -{
> -       unsigned i;
> -
> -       for (i = 0; i < ARRAY_SIZE(debugfs_regs); i++) {
> -               if (adev->debugfs_regs[i]) {
> -                       debugfs_remove(adev->debugfs_regs[i]);
> -                       adev->debugfs_regs[i] = NULL;
> -               }
> -       }
> -}
> -
>  static int amdgpu_debugfs_test_ib(struct seq_file *m, void *data)
>  {
>         struct drm_info_node *node = (struct drm_info_node *) m->private;
> @@ -1339,31 +1327,13 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
>                                         ARRAY_SIZE(amdgpu_debugfs_list));
>  }
>
> -void amdgpu_debugfs_fini(struct amdgpu_device *adev)
> -{
> -       int i;
> -
> -       for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
> -               struct amdgpu_ring *ring = adev->rings[i];
> -
> -               if (!ring)
> -                       continue;
> -
> -               amdgpu_debugfs_ring_fini(ring);
> -       }
> -       amdgpu_ttm_debugfs_fini(adev);
> -       debugfs_remove(adev->debugfs_preempt);
> -}
> -
>  #else
>  int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  {
>         return 0;
>  }
> -void amdgpu_debugfs_fini(struct amdgpu_device *adev) { }
>  int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
>  {
>         return 0;
>  }
> -void amdgpu_debugfs_regs_cleanup(struct amdgpu_device *adev) { }
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> index b382527e359a..de12d1101526 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> @@ -32,7 +32,6 @@ struct amdgpu_debugfs {
>  };
>
>  int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
> -void amdgpu_debugfs_regs_cleanup(struct amdgpu_device *adev);
>  int amdgpu_debugfs_init(struct amdgpu_device *adev);
>  void amdgpu_debugfs_fini(struct amdgpu_device *adev);
>  int amdgpu_debugfs_add_files(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8ef8a49b9255..351096ab4301 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3237,7 +3237,6 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
>         adev->rmmio = NULL;
>         amdgpu_device_doorbell_fini(adev);
>
> -       amdgpu_debugfs_regs_cleanup(adev);
>         device_remove_file(adev->dev, &dev_attr_pcie_replay_count);
>         if (adev->ucode_sysfs_en)
>                 amdgpu_ucode_sysfs_fini(adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 7cf5f597b90a..02d80b9dbfe1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -1139,7 +1139,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>                 DRM_ERROR("Hotplug removal is not supported\n");
>         drm_dev_unplug(dev);
>         drm_dev_put(dev);
> -       amdgpu_debugfs_fini(adev);
>         amdgpu_driver_unload_kms(dev);
>         pci_disable_device(pdev);
>         pci_set_drvdata(pdev, NULL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 18e11b0fdc3e..ca6b52054b4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -499,13 +499,6 @@ int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>         return 0;
>  }
>
> -void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring)
> -{
> -#if defined(CONFIG_DEBUG_FS)
> -       debugfs_remove(ring->ent);
> -#endif
> -}
> -
>  /**
>   * amdgpu_ring_test_helper - tests ring and set sched readiness status
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 660867cf2597..1947a326de57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2571,13 +2571,3 @@ int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
>         return 0;
>  #endif
>  }
> -
> -void amdgpu_ttm_debugfs_fini(struct amdgpu_device *adev)
> -{
> -#if defined(CONFIG_DEBUG_FS)
> -       unsigned i;
> -
> -       for (i = 0; i < ARRAY_SIZE(ttm_debugfs_entries); i++)
> -               debugfs_remove(adev->mman.debugfs_entries[i]);
> -#endif
> -}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 2c4ad5b589d0..dc6502d1060b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -134,6 +134,5 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>                                  struct ttm_mem_reg *mem);
>
>  int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
> -void amdgpu_ttm_debugfs_fini(struct amdgpu_device *adev);
>
>  #endif
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
