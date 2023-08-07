Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9727FC001DB
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Aug 2023 15:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4ABC610E129;
	Mon,  7 Aug 2023 15:21:05 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FE810E1FE
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Aug 2023 15:20:54 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-56ca1eebcd7so2833164eaf.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Aug 2023 08:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691421653; x=1692026453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ucqsrXOUi/Um/0fcGfcKckHZDqeKcE0Jl2z8Y2Va1Y=;
 b=eUVFrLMRUSIjSrAAx+YBEcoRgVitPRF3IWxg7ERsQUwTyEBSr79tYFQ71VJGyB7FVd
 60u1RaWebibs0L3Zk5Nr3uW649lNkZGGXJdR0U15OrBUgYMYgRmi+YDDfCLzul1cuq/L
 KTNZUFlZmAjAiZG3LdqqtBCSSB8WZ7YoDq8EK5a9aKPaOL8JNYfAoa7QfPKS7uQ420LC
 s3IrbD1tYsyfOvCaZOA1Vry9I2h0eGG51E4LVMAjfiD9nNWonEP7BgHstFvgpjYsJ0bf
 +7jPGpl2fAhpa0xGaSiJLqa9YKdQm+IpaBai84Pc4Cv5v2HQCQjkzZgyCFwiU+uP5UE/
 YHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691421653; x=1692026453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ucqsrXOUi/Um/0fcGfcKckHZDqeKcE0Jl2z8Y2Va1Y=;
 b=N1IPRlutjEO8PkGIspKG2twJ3Vn++i0U8KKR9aey5WkTSYkRRAt0X/eFAtbJo23Sdi
 ZuTxSx45r/2p5DrOza2aBCUfBpk52/ZfupsVs3MS4JKvr9ND53R/EF2BvGezsas+EuOS
 5KztR77DfageZG6bF5V/t+r8hjBTboJwut1ETM6bar2R+f1Ivip5borzPSLMYv/WRUhi
 KICexbTKj3noYgJ4RCmIufEP7vb+g80IxA3icFD+sRmJkSY5lfyFnjC9b+XWGftyolNS
 FV89pVmo0eoSzuj0KKAs7lzMFBcNmA1qH96VbbP1VyYCiovLNwIDDQqBpz/lL4nghopx
 XpvQ==
X-Gm-Message-State: AOJu0YxbICnTnlWOsSIBTSUQd+jsvBFCWEgRrMToYaKTnIpRUh07ie8B
 2/faKmbIKq98KmDJMYYbTiZmGXYGdqv+xhELufM=
X-Google-Smtp-Source: AGHT+IGNEN7u0+ZNj0zoNnW26jFwUf0mhxZU81KjzdLlgn1lOLpzgWE+h6dQHqjYp3rngdpOKtC6xUjkPUlTG0M1PhI=
X-Received: by 2002:a4a:9243:0:b0:56d:10bb:c2d4 with SMTP id
 g3-20020a4a9243000000b0056d10bbc2d4mr8498891ooh.1.1691421653625; Mon, 07 Aug
 2023 08:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230801201515.26789-1-mario.limonciello@amd.com>
In-Reply-To: <20230801201515.26789-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Aug 2023 11:20:42 -0400
Message-ID: <CADnq5_Pwn6r3FZPtz9CeSr-M1Bhey8SF2ojDa09yeneL6e9=nw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: fix debugfs access for discovery blob
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 1, 2023 at 4:15=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Accessing the blob for amdgpu discovery from debugfs triggers:
>
> [ 1924.487667] kernel BUG at mm/usercopy.c:102!
>
> usercopy_abort() explains that it needs to be solved by creating
> a cache to store the data.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2748#note_2023519
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 17 ++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  2 ++
>  3 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a3b86b86dc477..66a2251bdeba4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -791,8 +791,11 @@ struct amdgpu_device {
>         bool                            accel_working;
>         struct notifier_block           acpi_nb;
>         struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
> -       struct debugfs_blob_wrapper     debugfs_vbios_blob;
> -       struct debugfs_blob_wrapper     debugfs_discovery_blob;
> +#if defined(CONFIG_DEBUG_FS)
> +       struct debugfs_blob_wrapper     debugfs_vbios_blob;
> +       struct debugfs_blob_wrapper     debugfs_discovery_blob;
> +       struct kmem_cache               *discovery_blob_cache;
> +#endif
>         struct mutex                    srbm_mutex;
>         /* GRBM index mutex. Protects concurrent access to GRBM index */
>         struct mutex                    grbm_idx_mutex;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 56e89e76ff179..55ea5be14b188 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -2180,7 +2180,15 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev=
)
>         debugfs_create_blob("amdgpu_vbios", 0444, root,
>                             &adev->debugfs_vbios_blob);
>
> -       adev->debugfs_discovery_blob.data =3D adev->mman.discovery_bin;
> +
> +       adev->discovery_blob_cache =3D kmem_cache_create_usercopy("amdgpu=
_discovery",
> +                                                               adev->mma=
n.discovery_tmr_size,
> +                                                               0, 0, 0,
> +                                                               adev->mma=
n.discovery_tmr_size,
> +                                                               NULL);
> +       adev->debugfs_discovery_blob.data =3D kmem_cache_alloc(adev->disc=
overy_blob_cache, GFP_KERNEL);
> +       memcpy(adev->debugfs_discovery_blob.data, adev->mman.discovery_bi=
n,
> +              adev->mman.discovery_tmr_size);
>         adev->debugfs_discovery_blob.size =3D adev->mman.discovery_tmr_si=
ze;
>         debugfs_create_blob("amdgpu_discovery", 0444, root,
>                             &adev->debugfs_discovery_blob);
> @@ -2188,6 +2196,12 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev=
)
>         return 0;
>  }
>
> +void amdgpu_debugfs_fini(struct amdgpu_device *adev)
> +{
> +       kmem_cache_free(adev->discovery_blob_cache, adev->debugfs_discove=
ry_blob.data);
> +       kmem_cache_destroy(adev->discovery_blob_cache);
> +}
> +
>  #else
>  int amdgpu_debugfs_init(struct amdgpu_device *adev)
>  {
> @@ -2197,4 +2211,5 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *=
adev)
>  {
>         return 0;
>  }
> +inline void amdgpu_debugfs_fini(struct amdgpu_device *adev) {}
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 0593ef8fe0a63..1a3b30dff5171 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2276,6 +2276,8 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>         struct drm_device *dev =3D pci_get_drvdata(pdev);
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
>
> +       amdgpu_debugfs_fini(adev);
> +
>         amdgpu_xcp_dev_unplug(adev);
>         drm_dev_unplug(dev);
>
> --
> 2.34.1
>
