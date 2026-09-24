Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1A2C9830E
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 15:48:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4C410E1C5;
	Thu, 24 Sep 2026 15:48:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QeDeT8YW";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FEBE10E1C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 15:48:15 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-791391ddb18so68197137.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 08:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790264894; cv=none;
 d=google.com; s=arc-20260327;
 b=YleVJkbPyzrzLFKz1Ym99wYbVjbOR6kTMYvWCb6r+/5THvWklt38YBgF1c4cMX0ta5
 liQhBOaqrNyNC9G8w+ln08teaYD8jX6DIpVMhC63RBaW17lgoRbVyJ1LV8Ggt3vAxVNS
 y2iagHBma2fmuBaOqlH/1jgq1y03l9dyC/d10LXdkq0N7P+ss1FThfD6/YdRAm6r2aCh
 bzNTFcrppodVT9FlnR0iQK2qAVjO8sZ5kBusLDm8BpCysPXzc/CN8lJP2pVSoPvC+tsW
 +cM88HnzxKadUnDCFtp/BJ37gSbTcIx6L8+02a+XmiPiNzPQSiD4qH8y9ZUK/4QBRwR0
 l5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gXvLRIPOW0qs+xFKGmB8PcgEXF6rCEdfJOqd6gX76+s=;
 fh=yKS+issIu7/wbTAjPhkQW3BNMOA9gBlQiwrGoIwRZ10=;
 b=sxXPEPzKEMcHNf5kOi1opChuIgceO0CD4fU2mBsCUzP1x3/L1Hrnm5PksU6GvkWgC3
 HchNyLFzWbZbHwkulNqc5GwPSAdjiYvc0elwsAT8CKNe1QFPcCmH8TGLWz54jSprWL5p
 WJKGCoXYkbuaoPK84Z5mosa2AORyYf71WMChoPfVFSEXH2jmH0ysvDqkCuDwhf36SId5
 /fn/YsxC5U2CJ6yfC2nePRfbDXYLCl9f6poX0xm7fHxv4wpfXxO0EJGlKXzxhSGKKlFk
 /KBZnS3QB+6hFX3wR8Vc3hguBAyH8QvPgDPpSfLedIr5qP3T+opd361n0+2frTe1WIeq
 B7MQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790264894; x=1790869694; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gXvLRIPOW0qs+xFKGmB8PcgEXF6rCEdfJOqd6gX76+s=;
 b=QeDeT8YWhNjjyAimlR1x7pbBa3OTuS0+yC31ES7jV/HccB1ReIB7bmSqM2wCaYAoPR
 ZkiidxR855Sz0Q5mph5CWydcPiH+f5DprtlNLWVJdMxiwIucVBlaCVDmGOG3Xi+dvSvt
 lvyQoBeV4ULFfLuN9nChDnjYGXBv95xYW17p7u0PrmjnKXq48KXzqQ2Vwd/0B4VMlJiR
 p5CrXhNHaXEtV15FUL37LIybfQDFgl5SEGyEcRDHgLGUv9TWcWn1oMvpfOTo2Fji3Rrd
 HsZrMtVqRfDIVhQJ6wGgqM2TIHPQ3Y1UNYId8nIW75FU6mLstXK8JQqUPACTpasrj2Gq
 13Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790264894; x=1790869694;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gXvLRIPOW0qs+xFKGmB8PcgEXF6rCEdfJOqd6gX76+s=;
 b=OYmdSNgjTasCrwBESVqJ9hqFVYH8sAKgs0hT6wy7z4AtQZ8rz8HmoKkMZD6ZD8B5G5
 +NyV9s0VV8MHM2nWdQzzdAjVGDz+sF3U/8XFKVjy1smGWZJDrgWvFQOtCTcCzfTboD0U
 U9nEbpSJPtU2o4nIU5RBopQ1CDFtgf52NxQCBrv4TW4JDLUZbwGuvUrbU+ph6fz6iN8d
 1rVOg+TpihSs2Gi16xPbxo8ikLybIeqLO3Edfq76U5wI1U3FVPO7RyqVJhwY/xKhPdfD
 zKf1XtNi4UrdRvwgVyx3WOqhh9dhhxfcl/5IQP331M1JJO2ITCJ34l/16c0V9xmVSWY0
 6FSQ==
X-Gm-Message-State: AFuF++nXjCtSG0uGAtzG+ckmng7fu8dvg9tpFssxqgdatvNKVIa1ipBQ
 IxXR0BOhiT6EnvpG2NZVWPModJhRLTWBCD+yJBfp2Z1Fzz51Lad245SXe0laIcwH6v0kJ4MV7P/
 mvgCXdDCX4T7X3F5gS+y9HRs+37BxT58=
X-Gm-Gg: AYBFou0dir50Yf3tQONuIEm7lPn+lPd8fE5krp9yFCF/EOAVL7y4eRhsa2jhqEmuLLd
 yjDdEslvt6xK16xs8BZA3Nxc3cD9dktkWFmTgeb763VwYBFvpoNXw86fxn7+9Mz5zIHYmo6iy+B
 5jWBqbizIAyyu5j3UyroJ7b/txFMy74cYk+VYQ3GMBlsVL48aHawkTNjpr0BoBpJEyJJsjJ8ynq
 CYARl3xIx4Zt17yZ6QAExJyP+FYUe63kIyQagOhuD+IwmG9FQsTl5bzQB8Ujk+LVXKlA1t28AKg
 MTHKHZMtb0fWxINdNLwre5PcfvpdSpQZ4QNnND9iDXP7yh7FrDLhTjB+1jQHUKJKkse8j+L4TkH
 Eq3Jt7Ju2sObvq+3xpWBN/0p2NlXHTmj4YuewkvPROg==
X-Received: by 2002:a05:6102:3e83:b0:7a9:b6d8:8214 with SMTP id
 ada2fe7eead31-7b081279521mr98384137.1.1790264893805; Thu, 24 Sep 2026
 08:48:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260924133644.1541887-1-mukul.joshi@amd.com>
In-Reply-To: <20260924133644.1541887-1-mukul.joshi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Sep 2026 11:48:01 -0400
X-Gm-Features: AclHuK9e2uay8RwFh1QUsb2W1yZVNxybXmAHdHGS74TsZlAspwo0QYu9XK-7b7c
Message-ID: <CADnq5_NzFc5zAQA_oyO4GD2K3Dczy9x5P8Mn6d6gjUTA7UbR-A@mail.gmail.com>
Subject: Re: [PATCHv2] drm/amdgpu: place VRAM-capable dma-buf imports in the
 PREEMPT domain
To: Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
 Harish.Kasiviswanathan@amd.com, philip.yang@amd.com, Christian.Koenig@amd.com
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

On Thu, Sep 24, 2026 at 9:37=E2=80=AFAM Mukul Joshi <mukul.joshi@amd.com> w=
rote:
>
> An imported dma-buf BO backed by a VRAM-capable exporter holds no host
> pages of its own, yet when validated into TTM_PL_TT it is charged against
> the GTT page budget; importing many such buffers can exhaust that budget
> and fail with -ENOMEM even though no host memory is used. Set
> AMDGPU_GEM_CREATE_PREEMPTIBLE on these imports so they land in the PREEMP=
T
> domain instead, which is GTT-like and still bound (keeping the exporter
> resident) but carries no host-page limit.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v1->v2:
> - Check if p2p access is allowed. If not, clear the PREEMPT flag since
>   the BO will be put in GTT domain.
> - v1 reviewed by Felix.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index 4031ebe075d8..bbe518757907 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -472,6 +472,15 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, st=
ruct dma_buf *dma_buf)
>                                          AMDGPU_GEM_CREATE_COHERENT |
>                                          AMDGPU_GEM_CREATE_EXT_COHERENT |
>                                          AMDGPU_GEM_CREATE_UNCACHED);
> +
> +               /*
> +                * A VRAM-capable import is backed by the exporter's devi=
ce
> +                * memory, not host pages of its own. Place it in the PRE=
EMPT
> +                * domain (GTT-like, but with no host-page budget) so man=
y such
> +                * imports cannot exhaust the GTT limit.
> +                */
> +               if (other->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)
> +                       flags |=3D AMDGPU_GEM_CREATE_PREEMPTIBLE;
>         }
>
>         ret =3D amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
> @@ -618,6 +627,17 @@ struct drm_gem_object *amdgpu_gem_prime_import(struc=
t drm_device *dev,
>                 return ERR_CAST(attach);
>         }
>
> +       /*
> +        * The PREEMPT domain is only correct when the attachment actuall=
y
> +        * resolves to P2P access, in which case the import lives in the
> +        * exporter's VRAM and consumes no host GTT pages.  Without P2P t=
he
> +        * import is staged in system memory and must count against the G=
TT
> +        * budget normally, so drop AMDGPU_GEM_CREATE_PREEMPTIBLE again. =
 The
> +        * BO is not published yet, so clearing the flag here is race-fre=
e.
> +        */
> +       if (!attach->peer2peer)
> +               gem_to_amdgpu_bo(obj)->flags &=3D ~AMDGPU_GEM_CREATE_PREE=
MPTIBLE;
> +
>         get_dma_buf(dma_buf);
>         obj->import_attach =3D attach;
>         return obj;
> --
> 2.55.0
>
