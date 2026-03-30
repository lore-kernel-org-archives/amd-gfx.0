Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E2B1061B18
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 17:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29E6C10E28C;
	Mon, 30 Mar 2026 17:19:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vr3knwHI";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A4610E28C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 17:19:55 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12a77005d69so385966c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 10:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774891194; cv=none;
 d=google.com; s=arc-20240605;
 b=HKgwcpzuslXbnh5y5h1Etq6IBpnf/FP1+VQWmqHjjSBaitrlHbB7948WPaDM/lf3oT
 u0GhI1gIcRRWUGzfpsrXnym19gAMQVNxL6z2s4SkLHZpjBc8kWomrSOylMMqp05rINdp
 uo1NmOPGSl6CM3e4j9MeZFOwVNSR4mVf8ocMUjYDatD1lhAjun826oEjydri59RrXSmK
 MAUhtx0sS7d42SYexK7bLQcAUPvGMHJZTYeJ8PUMIajFjby5Eu6q1z4TjI68ob5X43LG
 PBAqYf+M2uTaOGFG28iEvwm6Xer+0PczFNHp2r+uWuAzglB3TR6SjTIzk9Zcg0PbOVkh
 XxsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qNodS30HzyFyM23X0gbQnkXHk3SjIlMLdrdy/uZnSsE=;
 fh=+jYedTXkJMLCCAigTiD49Kv1g3JhoyfrqkQ39E6EHwU=;
 b=TxW03uOP+6yI9f/cbS2ePVRENNKvpGw9ht9yEB2a8NZh6aIS9EKq38PZJKd0yXkVV/
 vsWZ8YC+kWPs3zVMXdcvnPDZNQ7OCJQFF+l3lkIslHM+eqHkRWwYjby98nUmPz8UHe1d
 9id/jLF21Tvqd7I9j2n3l/3hs1nAVcZVbS1WvP2UyrG2M6/K0EbNooVwI0Ig+bc6JFuq
 t8xfT628RkCwe3Df0GRZO+Xr5P70hSgpI5gT5QzikOa4/NyHv4kovCIleYntAUE4Mqyp
 DULMPZRxFILUVnfY97Cl9q/1KJXaYnf6Z6IFM/Uw/Tp0yImZ7GCb55ZX5B++le1xKbco
 w9pA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774891194; x=1775495994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNodS30HzyFyM23X0gbQnkXHk3SjIlMLdrdy/uZnSsE=;
 b=Vr3knwHI73ZNFy7M80g56FL9ZlgXpBHkHJSH37EsyiRrSkjOG8Rwsy6rqSFd3izciM
 vVavqt27/rCuIgU+KBPanBsNKDkpL+/piHqS0DJz/NWkAxPCv6VwOGZLns1rtyhbYhZD
 cYcMjCn9wQGH0aKX/D+13mlw8AE9Y3WKuBZMqksOvqem4+UF/UcCYLak4UgJLAdnC/mG
 23+faph89smB6zW4AOUIafD7iR6qmweaX19zosTsjv0Fl8s+ptl7sYBzPqkcaPmbhJvL
 Jq1aZwfSuIgE4LipAdvRn+ratk0JCZ14YnldmI4TX4g6vPb3cxQAdGDP8+K9z/79w5Vd
 JM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774891194; x=1775495994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qNodS30HzyFyM23X0gbQnkXHk3SjIlMLdrdy/uZnSsE=;
 b=o0DTUPtfHFYcLrSV4tPVwtAkYJ4HEHMt0pA5hfvEnnxt+p/OrQcqEMWcGQs6hnaa19
 caGCWIxcanblvaqGADDXQeYYPCSxuB0vVnQgAuZq5a79py271lei9A1KwZEuIDSlXkxJ
 goTqJQhdNAzaaYBghY8+3p+Yg7PseJO9fIGn0k1U5udxkOd53rX2XNZulkma952W625M
 l9/e2lUixvRyNi0yxwyBg+01tn1YelH7iAeTjCutwtpgS63juGYNS+/6lBUrcSWI2asd
 MlfxrTxCK8JcasfeYUg4VuVJLeeKm0HGfMJCrrd5CH6VhMwZd69x+emrobGa0gBZd3dW
 piHA==
X-Gm-Message-State: AOJu0YxG5Hl3sGcWRsyzV+U5T1QyEyUorTlQxg9+5OGwpUNDT8riXz5S
 2gxmovcPFJVTxUYkJOywuEaXqv5Jw6NWKsYJmYnQU3uNhfNVx5sQKThIykVUcZZxURsFQ3j+9nR
 QETYvHbpEC4Z5JQ3oOkyoH+/zNP/Z4J8=
X-Gm-Gg: ATEYQzz9aoKNe9psiq/2ImvhlQIPS66OUxpHpfaAN5IUtwW1nZSXvxXvTL0ROubjo86
 hcGQkNbrXKaqAB/R3sP3vzRF7rTVYvH588tcBrPmh3GfvTTrgIv/xmi1GNOdPRR7LvwfBpsj3xf
 TgZhriMk844fJN7CWl8H2/od2TydfQSYX0d6wAmKmxKpf5n9BxvEqvq7/jD4RnS9BZlUvjZ3mHy
 Yj8zPBKfJB8eIP/NO7SfIWZpBUN3E15EJs5D6kKkDd7tZNEmAHLf9680BQ1XHPr3l8dmB2JcrYZ
 7SNsjo/2rXQhVuzKWCYi1Xv9g9JxvHHruWJNcuTBtmxz4IEPcDchIMg3I+K6gUEVX7FO/WaIvtz
 WzazB
X-Received: by 2002:a05:7022:2217:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-12ab2761862mr3235133c88.0.1774891194041; Mon, 30 Mar 2026
 10:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
 <20260326075412.1378411-15-lijo.lazar@amd.com>
In-Reply-To: <20260326075412.1378411-15-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Mar 2026 13:19:42 -0400
X-Gm-Features: AQROBzApmV_51xGreolIff-eqOOg-D6e7h_WvE0wpGwFSEwrn8xCoVsz4h7xQOY
Message-ID: <CADnq5_PNu1KunCG-3AHV1oWvVR0+OTsR+AyN7s=BE4147oh9ww@mail.gmail.com>
Subject: Re: [PATCH 14/14] drm/amdgpu: Consolidate reserve region allocations
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Feifei.Xu@amd.com
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

On Thu, Mar 26, 2026 at 4:04=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Move marking reserve regions to a single function. It loops through all
> the reserve region ids. The ones with non-zero size are reserved. There
> are still some reservations which could happen later during runtime like
> firmware extended reservation region.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

patches 10-14 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 89 ++++++++-----------------
>  1 file changed, 26 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index d88d75a1eaeb..dae9434c6a93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1789,7 +1789,8 @@ int amdgpu_ttm_mark_vram_reserved(struct amdgpu_dev=
ice *adev,
>                                          &resv->bo,
>                                          resv->needs_cpu_map ? &resv->cpu=
_ptr : NULL);
>         if (ret) {
> -               dev_dbg(adev->dev, "reserve vram failed: id=3D%d offset=
=3D0x%llx size=3D0x%llx ret=3D%d\n",
> +               dev_err(adev->dev,
> +                       "reserve vram failed: id=3D%d offset=3D0x%llx siz=
e=3D0x%llx ret=3D%d\n",
>                         id, resv->offset, resv->size, ret);
>                 memset(resv, 0, sizeof(*resv));
>         }
> @@ -1814,6 +1815,24 @@ void amdgpu_ttm_unmark_vram_reserved(struct amdgpu=
_device *adev,
>         memset(resv, 0, sizeof(*resv));
>  }
>
> +/*
> + * Reserve all regions with non-zero size. Regions whose info is not
> + * yet available (e.g., fw extended region) may still be reserved
> + * during runtime.
> + */
> +static int amdgpu_ttm_alloc_vram_resv_regions(struct amdgpu_device *adev=
)
> +{
> +       int i, r;
> +
> +       for (i =3D 0; i < AMDGPU_RESV_MAX; i++) {
> +               r =3D amdgpu_ttm_mark_vram_reserved(adev, i);
> +               if (r)
> +                       return r;
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   * Memoy training reservation functions
>   */
> @@ -1854,35 +1873,6 @@ static void amdgpu_ttm_training_data_block_init(st=
ruct amdgpu_device *adev)
>                         ctx->c2p_train_data_offset);
>  }
>
> -/*
> - * reserve TMR memory at the top of VRAM which holds
> - * IP Discovery data and is protected by PSP.
> - */
> -static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
> -{
> -       struct psp_memory_training_context *ctx =3D &adev->psp.mem_train_=
ctx;
> -       int ret;
> -
> -       ret =3D amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_MEM_TRAIN=
);
> -       if (ret) {
> -               dev_err(adev->dev, "memory training region reservation fa=
iled(%d)!\n", ret);
> -               return ret;
> -       }
> -
> -       if (adev->mman.resv_region[AMDGPU_RESV_MEM_TRAIN].size) {
> -               amdgpu_ttm_training_data_block_init(adev);
> -               ctx->init =3D PSP_MEM_TRAIN_RESERVE_SUCCESS;
> -       }
> -
> -       ret =3D amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_FW);
> -       if (ret) {
> -               dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
> -               return ret;
> -       }
> -
> -       return 0;
> -}
> -
>  static int amdgpu_ttm_pools_init(struct amdgpu_device *adev)
>  {
>         int i;
> @@ -2133,45 +2123,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>
>         amdgpu_ttm_init_vram_resv_regions(adev);
>
> -       /*
> -        *The reserved vram for firmware must be pinned to the specified
> -        *place on the VRAM, so reserve it early.
> -        */
> -       r =3D amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_FW_VRAM_USA=
GE);
> +       r =3D amdgpu_ttm_alloc_vram_resv_regions(adev);
>         if (r)
>                 return r;
>
> -       /*
> -        * The reserved VRAM for the driver must be pinned to a specific
> -        * location in VRAM, so reserve it early.
> -        */
> -       r =3D amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_DRV_VRAM_US=
AGE);
> -       if (r)
> -               return r;
> +       if (adev->mman.resv_region[AMDGPU_RESV_MEM_TRAIN].size) {
> +               struct psp_memory_training_context *ctx =3D
> +                                       &adev->psp.mem_train_ctx;
>
> -       /*
> -        * only NAVI10 and later ASICs support IP discovery.
> -        * If IP discovery is enabled, a block of memory should be
> -        * reserved for it.
> -        */
> -       if (adev->discovery.reserve_tmr) {
> -               r =3D amdgpu_ttm_reserve_tmr(adev);
> -               if (r)
> -                       return r;
> +               amdgpu_ttm_training_data_block_init(adev);
> +               ctx->init =3D PSP_MEM_TRAIN_RESERVE_SUCCESS;
>         }
>
> -       r =3D amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_VGA)=
;
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_EXTE=
NDED);
> -       if (r)
> -               return r;
> -
> -       r =3D amdgpu_ttm_mark_vram_reserved(adev, AMDGPU_RESV_STOLEN_RESE=
RVED);
> -       if (r)
> -               return r;
> -
>         dev_info(adev->dev, " %uM of VRAM memory ready\n",
>                  (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024))=
);
>
> --
> 2.49.0
>
