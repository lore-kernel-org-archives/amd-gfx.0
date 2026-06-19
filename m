Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E57ECD98F2
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 18:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0482310E0E3;
	Fri, 19 Jun 2026 18:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iXOHtU/x";
	dkim-atps=neutral
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A07E210E0E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 18:17:36 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-966cfdee844so59225241.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 11:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781893056; cv=none;
 d=google.com; s=arc-20240605;
 b=OMA7hYzh7FiMDDv/IazoUK0Nj0wnSdZIH48XZrQkDFshvZAacQblMpkCSBnP1dhRUu
 8jBODevRtyuTed7W/1fBmF35MMyCBMqlYUJAkZPxs0T86e0K+on837hf+wlSWOwELeQZ
 78TCsl3jY4tRVJtRItfsavdCTM4yLPQ3sgFp0pyVzvt4Ppk/CGpTuIOxJVw22d5V+6JA
 WwjS2nIShaeNOXuCx0P5H2hKIPsCNDkOy4N+brBlioj4x+sEzUrbMBnRCxEs0NtZqk1+
 sZeU2vEpnZqLLNEv6Q2qBcoAzPM+owvDxkv6C9/USMEMJRQsBuc8BEGzS361kwBLWV5X
 iqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T5wKHnl8LLAvf7smihy8fH6AHuXSVm/l4Z6zkQtcLaU=;
 fh=xc1U0xMT5rabAMPWWDaq6mFqxuOonDxjEGsAiioZB1c=;
 b=JRKvbfMxwy8QM5+fVAgChLWatoHACIYeO41OQyKVvavgaHzYqgtC8pwq1baJnBF63s
 CMvL6WsKtrH4pOlfd0PJrkQ907LejjcT+tWR6RPlPG80pDcXBFFbvpHFWv2hv11YHyOr
 bfnUd6AjnRry0QjLbxF7IlQGWyYlLWkE/3V4ht7Q0qJQXavieIPnKbKMy9WFagMvqP9j
 TWfMtyBXa6pdvnLp5RbBLGBZF5ssC+SK5SmmyM2kLA4yBZchjKOi5s++vFz0OGPQWZAe
 XszOf/HBfTD6NYeTJO2pJ4LMUu1JI9MHzFwo0vO4+Kwa5kRXHzNJdmBOw77SFk6RYCLA
 gBnw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781893056; x=1782497856; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5wKHnl8LLAvf7smihy8fH6AHuXSVm/l4Z6zkQtcLaU=;
 b=iXOHtU/xmeYhY7FKNC6LPeLN773WvLTlAuNvGtJj36aG2A7pQZLa+W/2bA4jhlhHGt
 dSPcWSvmn5GkLSGxyS1n7SWI0i3K8NuvWsQU7npJ6b0vwi75Wly5BQdb7fwmOOBNEzDG
 bSZpbrvlR+zonoOkTL1rzSRt+CBZZuI9FnoVFpyXHg6zz0uVrcGgQsuYO5TgPAR1HVfM
 v7nnIspjZUFYRJF0d62xeG7iqFG6YSGkDcV6o9AqgQO73IL7rryagR/ZYZfIweEgT0qX
 9jEYLhzXHFwvn6MpqorPZghG/IplpK0zaI2fyYqWUv4R8crm2oDmcP0PkzoO6gA+j+Su
 RRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781893056; x=1782497856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T5wKHnl8LLAvf7smihy8fH6AHuXSVm/l4Z6zkQtcLaU=;
 b=myllwEHeE9KmiFU5IXd65+cWL2L8dZp6MZmZOqVVcCNqTFw/YtAc2ZyDocLLD3fHeb
 dZOo5ZBEnv2VWuNgtetPrJY7hltqeyNob3xwhCOeuq6aD3akZi1IWEXSUDZ4EN0N/CWg
 kl2R6GC2Eb0U2DNoWnc1Eep2hC7KdQI+4yuASfcfFgN7rEaTr595vaXYMo1Gk2FT3yhr
 1t4ASFECUgg4N8ytNk8Kow4+fXzThQcJ86yEV+D/TC5xP0gifj9H3O2gfxMSW+sbk5Df
 uTadtWHUnPkUCcp1ScXFiaIRzGzW3SP6Tbigna2T6HH694FCvpl+pebzXVggI+h0Yp5o
 G1DA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wJgF8zCqYb2rWr/TvvnPFm4t8aUm0yTNZ3/qB05ErptlxzsbH5m5swH98r/a9w2M9khrafFka@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1RIyWncUkOBfoGG5BOziviBEWgWWg+efes6lg+y6GdKgjUl5o
 MYr/OuD9R49KffdvzaYtwAmHhjdYM0IH/xpDDHHf3Qg3pEAgSu7bo1QBpnqs0la5+kucimENZfo
 Mkp8BXejFptbS40JtpTmoFwSFUuz/hdU=
X-Gm-Gg: AfdE7cmeL6bJFpp1T97DxuhSsZQ4zafgUkoOlYBYGM2bSbkURfuWrxvGbwevaRLTf8z
 iDDvKAsu2ALowkvfgyGk7Y6ev5jYLQ/PTrUcOap+3/MYVVGYIuaOCBGaKkmG8xWCqrCBUD0pU2g
 gzFGV75NnPuL0A9aWAexl6uPkGnmRCFH8PnuGOd7q1ecezLT30SbAPBO0C+FZHbprB5fA7Ga9XW
 QFRa301PZk4U3DjDpIi3YN2/LrYuS1cbRc0hV1GShKPg3fGf/qy4XfehEqY0OgHu+v1CfH/Fn1n
 29ad9bps8UBja6OvgYjGAr01+w/67N9UldhiQPixT8/Ev5hkVRs0WdQoOxjZ4IvmkxjFRw==
X-Received: by 2002:a05:6102:3e2a:b0:633:3bf6:977c with SMTP id
 ada2fe7eead31-72b1402325fmr496697137.1.1781893055578; Fri, 19 Jun 2026
 11:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260619171733.2976352-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260619171733.2976352-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jun 2026 14:17:23 -0400
X-Gm-Features: AVVi8CfAwOeCU7vT83ez3VssHgsWlM2OxGR66px5uvo8lPUIFGyHPgChZY_glZw
Message-ID: <CADnq5_MhbBpkV6dyZsWrTTyhQNWBqU8FpQyFgkByzdtOf7MNHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

On Fri, Jun 19, 2026 at 1:54=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> amdgpu_device_ip_soft_reset() allocates an array of AMDGPU_MAX_RINGS
> ring pointers on the stack. On 64-bit builds this consumes around 1280
> bytes and triggers:
>
> warning: stack frame size (1304) exceeds limit (1024)
>
> Move the temporary ring pointer array to heap allocation to reduce stack
> usage.
>
> Fixes: a6319ac34a13 ("drm/amdgpu: Add IP block soft reset as a GPU recove=
ry method")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ip.c
> index 65505bc50399..eeb9383b1010 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -524,7 +524,7 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *g=
uilty_ring,
>                                 struct amdgpu_fence *guilty_fence)
>  {
>         struct amdgpu_device *adev =3D guilty_ring->adev;
> -       struct amdgpu_ring *rings[AMDGPU_MAX_RINGS];
> +       struct amdgpu_ring **rings;
>         struct amdgpu_ip_block *ip_block;
>         enum amd_ip_block_type ip_type;
>         u32 num_rings, ring_type_mask;
> @@ -539,6 +539,10 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *=
guilty_ring,
>                 return -EOPNOTSUPP;
>         }
>
> +       rings =3D kcalloc(AMDGPU_MAX_RINGS, sizeof(*rings), GFP_KERNEL);

We can't allocate memory in the reset path otherwise we could
deadlock, this needs to be pre-allocated if you use the heap.

Alex

> +       if (!rings)
> +               return -ENOMEM;
> +
>         dev_err(adev->dev, "Starting %s IP block soft reset\n",
>                 ip_block->version->funcs->name);
>
> @@ -546,20 +550,25 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring =
*guilty_ring,
>         amdgpu_filter_rings(adev, ring_type_mask, rings, &num_rings);
>
>         amdgpu_device_lock_reset_domain(adev->reset_domain);
> -       amdgpu_multi_ring_reset_helper_begin(rings, num_rings, guilty_rin=
g, guilty_fence);
> +       amdgpu_multi_ring_reset_helper_begin(rings, num_rings, guilty_rin=
g,
> +                                            guilty_fence);
>
>         r =3D ip_block->version->funcs->soft_reset(ip_block);
>
> -       r =3D amdgpu_multi_ring_reset_helper_end(rings, num_rings, guilty=
_ring, r);
> +       r =3D amdgpu_multi_ring_reset_helper_end(rings, num_rings, guilty=
_ring,
> +                                              r);
>         amdgpu_device_unlock_reset_domain(adev->reset_domain);
>
>         if (r) {
>                 dev_err(adev->dev, "Failed %s IP block soft reset: %d\n",
>                         ip_block->version->funcs->name, r);
> -               return r;
> +               goto out_free;
>         }
>
>         dev_err(adev->dev, "Successful %s IP block soft reset\n",
>                 ip_block->version->funcs->name);
> -       return 0;
> +
> +out_free:
> +       kfree(rings);
> +       return r;
>  }
> --
> 2.34.1
>
