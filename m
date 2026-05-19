Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D7BCD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA4610EE32;
	Tue, 19 May 2026 18:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dQHpLNSy";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E1E010EE32
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:33:42 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1351aa6418cso221510c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 11:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779215621; cv=none;
 d=google.com; s=arc-20240605;
 b=QY1v73F17COiy0rSdtqsYak3MPRLkFnl9t5ffZP7SzIqNReNZx34HTOXeg0I0aOgkM
 4TAmvjQM9LLKX+Cv+cbySamQDO5UWTqGjeuPkL11PL5J4+D/MhU+ypyuNukRpXBql6N8
 MBOaErm47xUB4OSfq9JYZ8WcWzwqrTTMKjpPWEZkKveVx5su7RD7kPYd4a1lRjSK91Zd
 46t/jAahR/KzRR5UTJhbLaVN4V5ucdSgT7GQ0LJDMK66B9+tVioRR2xFOx8ok9xXbpkZ
 fOrl3w7pRRayxyZXF1/x9Cliic/vMeg5GlDDl3WqMTeJmuuRT11ecOUywa+Nr/2UhGrP
 IofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bXu55LWcgpHPMeI/mlyctBv8XvHk3ApcoZPzHUConMw=;
 fh=mMwEBgaqB8GWe/mzFZQyewDVYtlOSQWYolYL+wVyf6Y=;
 b=ZT24wGOmdygZ52MhzdzjTWE7PMico4GwU+q6HWJtNFsVpa+rLOGaLFbC4XzaBRKS5X
 CghaEpCkuEtX14zi573jiMBcrjUJpGMlJrElp7yuNZzeW+b5d33ZEj9BYEgn4K/HwDzB
 CdKoARWWjO6EYHYFn/GjLtIgctcpCB1liniblLoNKb2MRCnip9orjjzTjVFCVTOs7jJS
 ZwVVs84nJQtGTTaKkrb/nvkK6V8v9aN9VPbT/adxKc9M/ohzq87hXVJGolGtlhK2kHM/
 h8WGSJjNZvTHt+0OZ5aoP4KScKKirHZ/grBx+N9zmkmDagNQ/dfSK5VFMuIW4IQmjLoL
 8+Ew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779215621; x=1779820421; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bXu55LWcgpHPMeI/mlyctBv8XvHk3ApcoZPzHUConMw=;
 b=dQHpLNSyctUGPeYRXVlLuFc7KVOHOwf65VXNfWSz3FoQ1zp+UKrJQ6iKIIQk5No2Ig
 X4nnYlOM7mxmQtwYXidQg85TsA9TRZOy9eWbewtJTS2dCsCZnFaLRG1md55mAJmtXiCx
 u24Jtkld53sgbBHUS+9BXKsSCDyO6g2XMdwGgm7hdX2T3QdJ84sVbdp14JRgOMA2rQCx
 lrzv3A8iEpnEZsZ2bYaDrAXAKm3nFXcZf4O4KTSEWArtizqdo8PeT8vMMVXQvqnzMNx9
 i9x+Oye3xdh08z0sklTyBDksuKB3H4uh+KJGMrPA3rmy/cUMWZeVl4NZV78jbYGm1K0h
 XwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779215621; x=1779820421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bXu55LWcgpHPMeI/mlyctBv8XvHk3ApcoZPzHUConMw=;
 b=iq1QboP+Gc4RALepH2WCHXIC/WaT7gYSfR/VMVObPGfO6DHKLVxkY6j24lk9RWmFHk
 XR4V6fvFMJY3D2t1oyuhW+O2IFJvma8RZZ5eYP7/n6IGnps5AeUvSZPmfzRngTYy+FS4
 hx1VQIQP1THOMSVWO5AaEkR039rKyMed8G1qZAgtPvUHGbwG3gnN74jhYqwxAyz9Ejf+
 DWSTA1XpP0V5I7sxrwaQL/y9Ve0CyYofJqjx9fzeY10xja0FFH9XDjh/owIsMWAlgFNP
 84W9HydXZICzFg6C7J4MUA52w6VQXLOYljKiI58sRVHPY2VDpTXeNBCKshHjyAjrCxXP
 1l/A==
X-Gm-Message-State: AOJu0YzNZngz/p8KF/D58+CgKjPmvKea4gmdhUf8uaTAP2yO0yNLFM6y
 1Qf4rK3SWCVR0w6knPKaYiG1Imnj15MkZCi2RIXCk4Eknm5KoVTWqEDZZ6vQoCJWIG57IYdsyAw
 NCHzj4srxV99JScBcwQBxftDt0ZRHpsg=
X-Gm-Gg: Acq92OFHB4M40sG5ccIEFzz7m7Rpiu2t7TxUrTLIYrrn9liXaKaSf8MdKdeva7VNSWV
 tWQZIQChconhqT3sodYMYPr++zFQUjeZh1B7knZ7i6RBFh3MB2aS86/5MFk7VxZtmmtKYS5AkzH
 FD3N0DLZQjBnkH4Jl6b3iSeltNyy8S+vTN5BtzrVr4faY+qRfjn5/P+apFFvPcA89aHivEDT2ft
 ngP8xnzMvvpXPNUXtyIFnso10K/3Efok6vF6s6C/qyf+L1ASS+qv4yy0FzAOkIJFDLed8+c4Yf2
 2ptyWjt9UeHOP3b/dTid1BS6xBfKkoEwogq3hVpEKHeuB0EWC4OiXuM9nnFC5oz0RblriLdklLI
 6U3QA
X-Received: by 2002:a05:7022:128e:b0:134:d037:aca3 with SMTP id
 a92af1059eb24-13504944586mr3874685c88.3.1779215621345; Tue, 19 May 2026
 11:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260519172051.635126-1-boyuan.zhang@amd.com>
In-Reply-To: <20260519172051.635126-1-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 14:33:30 -0400
X-Gm-Features: AVHnY4JErcZ4RjujZwOtZcf-xdK_wxa0RNT6_i35CLAsRPhRra-1QjT0QrFbH1s
Message-ID: <CADnq5_NHaEm_3QeMzY74hFDrXSEtk8Cs2F0pbEStvL9qEfna2w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix division by zero with invalid uvd
 dimensions
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, leo.liu@amd.com
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

On Tue, May 19, 2026 at 1:21=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> When width or height is less than 16, width_in_mb or height_in_mb
> becomes 0, leading to fs_in_mb being 0. This causes a division by
> zero when calculating num_dpb_buffer in H264 and H264 Perf decode
> paths.
>
> Add validation to reject frames with width < 16 or height < 16
> before performing any calculations that depend on these values.
>
> V2: Format change - move up all vaiable definitions.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Reviewed-by: Leo Liu <leo.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index 3a3bc0d370fa..707e9d9441ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -635,6 +635,13 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_de=
vice *adev, uint32_t *msg,
>         unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
>         unsigned int min_ctx_size =3D ~0;
>
> +       /* Reject invalid dimensions to prevent division by zero */
> +       if (width < 16 || height < 16) {
> +               DRM_ERROR("Invalid UVD decoding dimensions (%dx%d)!\n",
> +                         width, height);

I'd drop the message or make it warn_once.  Otherwise you can spam the
log.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

> +               return -EINVAL;
> +       }
> +
>         image_size =3D width * height;
>         image_size +=3D image_size / 2;
>         image_size =3D ALIGN(image_size, 1024);
> --
> 2.43.0
>
