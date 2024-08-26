Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1698C5321D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Aug 2024 18:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C1AD10E033;
	Mon, 26 Aug 2024 18:54:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ms8wZct9";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 798D010E033
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Aug 2024 18:54:38 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-201f577d35aso3081025ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Aug 2024 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724698478; x=1725303278; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwIemK6hTsgMyszNBSSq3XR5zcxjjB8nel9yDWFyiNg=;
 b=ms8wZct9SRiWcbOtwnC91j0iPQzTVIOqIszz6O88yr5RnoEZbNOsz2WVq0YR4SMHQE
 hDlfO/AUBabpSEwhrst3vKuR4KL1934NixOBAW7Q/NNA9Kv0vG/S8asaPhJgAmdZ/z+x
 q90F5RCxA8JxWMNGExrpGOlgIPgplUveBVBy8FFvlxPZ6RJCWEDiEBtrX+b4/fyeDRZq
 rGnuD0pfuHiIlACjhJakpqEZ9x0sqY24f9PVnaCrWCOdz7LoZA5BM9HKWpNhwH+EHgkP
 R6qob+omzrRVDByHj0RJXQ1cHn70WFV637abEwohOUs0WnAjn4RzeRYZhYx46+G0Puzm
 bqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724698478; x=1725303278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwIemK6hTsgMyszNBSSq3XR5zcxjjB8nel9yDWFyiNg=;
 b=KXwiUTSVsm9d0Y+JyCEPfqBXX1+y1xZV5uHdv2/6XaswYVZyFBJIABPYMPbXrFa6/A
 PqOpH9a+DtVyhG97uTZxWqVPVj56fhr5uK4wbumP3SZmfQK8GFLrzrRdG0FQH34PSDjC
 3a1BtttKCHXOMWRMpjhyeFpa535D+eniIXUceeF+5G8/KE1yr35khLvxTb1T/tiMp6mU
 SLOQ4ysQyMJtd+CzbOWugoX1811gCLFiML3eGWnpAWLnbSeqYVUeq89MadI2Vt1wzsbC
 cMAquUcE5c+90pZks8CQfBFw8O0IAOaBE6IdmK5kszxp7cpknWFNqG/jUyEfaiLvoluM
 N/tw==
X-Gm-Message-State: AOJu0Yz+xpJ1hPga6tP+wxsCVcZmBEp24jK4rauOVaa7nWPuVy1VCBhy
 WIflW7OczvC0YFrlX0/njRFH4zEKLQMr2USHlWLIzeAn/qHKCwxalnmEuvNNNRA825S/DTTamH6
 M80lwGcXOBcdGWlvaOOO1Xx9W2Go=
X-Google-Smtp-Source: AGHT+IG4QVMPnyqurX5xm96v4+ai5HWudi2kqRD619zBVMHroF3Pqlsc0TE/uBIgJZnyQz3iZjqhbJEjvPxvZBbJq4k=
X-Received: by 2002:a17:902:c948:b0:1fb:1ff1:89d2 with SMTP id
 d9443c01a7336-2039e55a26fmr81216765ad.6.1724698477623; Mon, 26 Aug 2024
 11:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240815170030.2582607-1-alexander.deucher@amd.com>
In-Reply-To: <20240815170030.2582607-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Aug 2024 14:54:25 -0400
Message-ID: <CADnq5_OMtegqoHh4Q1T+wa3dNCYXD62nUMx9-rEmv=tWAP7GrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx11: return early in preempt_ib()
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping on this series?

Alex

On Thu, Aug 15, 2024 at 1:10=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> When MES is enabled KIQ is not available.  Return an error
> when someone uses the debugfs preempt test interface in
> that case.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5685aee479df..5704ad25a49d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5924,6 +5924,9 @@ static int gfx_v11_0_ring_preempt_ib(struct amdgpu_=
ring *ring)
>         struct amdgpu_ring *kiq_ring =3D &kiq->ring;
>         unsigned long flags;
>
> +       if (adev->enable_mes)
> +               return -EINVAL;
> +
>         if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
>                 return -EINVAL;
>
> --
> 2.46.0
>
