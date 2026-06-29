Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A02C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 13:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E1910E8E4;
	Mon, 29 Jun 2026 13:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lkw9q4eW";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96A210E8E4
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 13:35:26 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-30e869ebc19so129998eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 06:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782740126; cv=none;
 d=google.com; s=arc-20260327;
 b=Uv3c+GGI8ezmHkuXKQ9zsaoifzfxXKkLkffHGyIM24caXYI9TT6hQJrNzaQFB3/9Au
 HhD2sZyg1EYIKYpY+7Ff8X1/Ju8jSHwQcyxqgvj33ApA4ubP3YD0p3ffJGF5L7UWpI9U
 XnSmv13AjFQb80P5D1yd7t3H9KiGScZgDGyTjyZ6NMTvRDK18j4to4XdoKAmrXFDMpOk
 4PomfsEc5MNJBJy6HJwxYpWFrdL/k4657tRVwSDq3LNzXv3+g+M+/doxwcfzXpN0dZB9
 UNw0bhL2mm+OHvrh/5FVGmzIIsmXx6nvVJboxxX1BClmik/HEw3pGIHb1A18QsqP09OB
 x5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=M4EBbNbMCFlSnwASewhNQtdDsv2158+niDnSjHsJc+E=;
 fh=advj4YxN8NmzRI1C4RdCPL3MlBHBQPZW0GAWMPKaSnc=;
 b=pGeM7gyyrt71rudf9/EjCp4L7N2xX1tW3qpdtWWXMyO1urz8SYF/GPTJ+7FmceerJi
 yLk9t1HL4hVtQUc2+67MmzWQlAXfs58k+MsaTDK8iiYX1KacSCv5p408kRa16qans2oY
 x3RUcZs820yAwoMVIAbx3PEW1umuDMaMp7sfH9BkQjy9mFRXVBXgETsAAhdlGPnNjK63
 c+pvKbW/ldq1lBB5UIUgcUMUElLlZRVcihj5Pu01POZ8IAFvbiF12WWayTbzNDULLxFE
 3UbRwY20eDcV0dQXbPsnu8znSp5XcOE5reDP1/XpEJxF74m8ML4kUhNOF2DZnBad7prm
 1zHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782740126; x=1783344926; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=M4EBbNbMCFlSnwASewhNQtdDsv2158+niDnSjHsJc+E=;
 b=Lkw9q4eWlU6Lvh77icge42FdroBjgETYnpteXIgjWs09mDdCIRZ1kNc9G/arsbPizI
 6Vc9Fg+gXnsaa5b8pccWKqmI3UHgXU7OGEcEDT4A75FWcrCXgceidzcvsya7V/Jki7HX
 /R1pQk9TFDgwdeQC5muisI+BffboSfC7kGaPhViP1hfwcSsKAqzi04j0H+2+GyvIRl+c
 rCCn4LP8Hpz2qHxKR1HK8sTaBOOF2Yn0O+SSzsRlU8NA4TCYmfCy79zh0avemUT+L92m
 nyMv94/ZN4xPgpZhIjzzMewZJdJjq4Gr7vXIvchDnPQ7CqU4xE1/l7DKGMxXThz45Gwo
 LR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740126; x=1783344926;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M4EBbNbMCFlSnwASewhNQtdDsv2158+niDnSjHsJc+E=;
 b=RwRhkFjPq8qDBsby6aHaEGMGdk0+4hOL+i/0XtyNjCdnFoaob3Mc4npJOMG0fSqBun
 J8PVxuwXkyFeQfQSdz/T/rB+N4hhpePezbXfXvkEJMTFRw5DXbjBIzbFs7hzmzkqgVKV
 X8Sh54Zwec5Bi4PWvKsjbiRvBowNf/v8RgbtMbGQALUT0JSucrqhAJ/9JIpkEYlP9Dzb
 rmD7cjtfNCnGFObzmNKtOGIcFLL4eaASHJRk90ZpQjVySCcGNHZjBqgquFdfxKnSLNSy
 P1HDhar2M4bAJMtUJl4kMv4PVvKz+m31lVa8xFAF4CmGdYPNV1HOo0F2eNmlJykaGaV+
 Ye3w==
X-Gm-Message-State: AOJu0YzIGxp/i/JVUQFDx0Oil1x03vRfmTQSI7jVq3XMsOy61VPvEkQN
 WATvgyO/GPHUPxZNqc81IUTvCZCiLLkzcOra6V6ypiTx0dvFQbjY3pDCoTDxvNtoDRbxwiMZSGP
 KILL3u4t4ZfWI9Sah/deLhBZrEODHkVw=
X-Gm-Gg: AfdE7clhIKxxRXRHxIiwAIPmRZ3Vn3pvMFrZF6Hk/RckmnITXJkBDXHkGQSu07TCPLF
 UuTeUnAMhgjA6gxn1P3gUzCOes3t7bxbKZ6Ri03wPMZQgAYZnjGmDYCPHtO9EwMgAmrKZr1jRgg
 oSkpY+WPXVACvA7dlLJp6W0al74fMCBn4/rj9KiiqnvFxollrVdrLiw+czrzDMjOp6F2LcjLw91
 +T8zS3UCik4WivMmeHGQjQdxTHt/H1s+t51x5Jkbzl/SSZMcsMUFE54OEsPPF6oydeSSdqzZYTO
 /1VDbS5X6qVRqAqxY8bwfpdOZ4AVAb/8CwzFq26nzqOM2rgC/hGT/bfzZsg=
X-Received: by 2002:a05:7022:2641:b0:12d:ce63:d8c5 with SMTP id
 a92af1059eb24-139dba00a1dmr4870006c88.2.1782740125921; Mon, 29 Jun 2026
 06:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260629132837.2288044-1-David.Francis@amd.com>
In-Reply-To: <20260629132837.2288044-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jun 2026 09:35:12 -0400
X-Gm-Features: AVVi8CdW6P02PpLMqjng2xRC9mp4CIU7R1Ki9R3VToHTpoHJSI-SEMU2nuggAo8
Message-ID: <CADnq5_Pn_fiEV3u1JOWOucFk3CpqA5HfK1FibGD6u1Opmo3MTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Use kvcalloc to allocate arrays
To: David Francis <David.Francis@amd.com>
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

On Mon, Jun 29, 2026 at 9:29=E2=80=AFAM David Francis <David.Francis@amd.co=
m> wrote:
>
> There were a few instances in kfd_chardev.c of kvzalloc being
> used to allocate memory for an array.
>
> Switch those to kvcalloc, which
> - is the standard way of allocating a xero-initialized array
> - does a check for the mul overflowing
>
> Signed-off-by: David Francis <David.Francis@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index ab9e53dc8deb..7d8215169c10 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1917,13 +1917,13 @@ static int criu_checkpoint_devices(struct kfd_pro=
cess *p,
>         struct kfd_criu_device_bucket *device_buckets =3D NULL;
>         int ret =3D 0, i;
>
> -       device_buckets =3D kvzalloc(num_devices * sizeof(*device_buckets)=
, GFP_KERNEL);
> +       device_buckets =3D kvcalloc(num_devices, sizeof(*device_buckets),=
 GFP_KERNEL);
>         if (!device_buckets) {
>                 ret =3D -ENOMEM;
>                 goto exit;
>         }
>
> -       device_priv =3D kvzalloc(num_devices * sizeof(*device_priv), GFP_=
KERNEL);
> +       device_priv =3D kvcalloc(num_devices, sizeof(*device_priv), GFP_K=
ERNEL);
>         if (!device_priv) {
>                 ret =3D -ENOMEM;
>                 goto exit;
> @@ -2043,17 +2043,17 @@ static int criu_checkpoint_bos(struct kfd_process=
 *p,
>         int ret =3D 0, pdd_index, bo_index =3D 0, id;
>         void *mem;
>
> -       bo_buckets =3D kvzalloc(num_bos * sizeof(*bo_buckets), GFP_KERNEL=
);
> +       bo_buckets =3D kvcalloc(num_bos, sizeof(*bo_buckets), GFP_KERNEL)=
;
>         if (!bo_buckets)
>                 return -ENOMEM;
>
> -       bo_privs =3D kvzalloc(num_bos * sizeof(*bo_privs), GFP_KERNEL);
> +       bo_privs =3D kvcalloc(num_bos, sizeof(*bo_privs), GFP_KERNEL);
>         if (!bo_privs) {
>                 ret =3D -ENOMEM;
>                 goto exit;
>         }
>
> -       files =3D kvzalloc(num_bos * sizeof(struct file *), GFP_KERNEL);
> +       files =3D kvcalloc(num_bos, sizeof(struct file *), GFP_KERNEL);
>         if (!files) {
>                 ret =3D -ENOMEM;
>                 goto exit;
> @@ -2584,7 +2584,7 @@ static int criu_restore_bos(struct kfd_process *p,
>         if (!bo_buckets)
>                 return -ENOMEM;
>
> -       files =3D kvzalloc(args->num_bos * sizeof(struct file *), GFP_KER=
NEL);
> +       files =3D kvcalloc(args->num_bos, sizeof(struct file *), GFP_KERN=
EL);
>         if (!files) {
>                 ret =3D -ENOMEM;
>                 goto exit;
> --
> 2.34.1
>
