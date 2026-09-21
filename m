Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE2DC982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 21:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2994410E114;
	Mon, 21 Sep 2026 21:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qMBvbYpl";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB24310E114
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 21:18:50 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 d9443c01a7336-2ddb3aea488so4387445ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 14:18:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790025530; cv=none;
 d=google.com; s=arc-20260327;
 b=GBjn1YXt5PsI8xZ0QHAcOSOUEINA5M8zrCSjXMa69/RqFU4TTO4bm1oMZUClNAztcI
 RmHMvLdfnYEWB4LFxVkc8Iz/akRqeyyz1mHLc4ewCcypa8d9eKJzuTBWZRiumztoqHGe
 2Ni5fVPNa63d+828wXIOIuL0kGLp+brCnW68gInmzT5GmgHLlG99HHv2VUfBf+awUV0d
 DYEo9HMoKjFJnX986BMcGwe9QpGJUnBjTNewpFlSgUh8sjQDCD1ZNajcUQYr1oLBnV9w
 LoprIsdQ0BDKw1EoPsghzHLG4mgLbk32Mm8dNbtF6VQTofQ+HiQHwM85qG4NsKyrkzn/
 QhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ngu6mGd66FhUjN5aGIuLGfjJpEsaPulVmk1hW6Q9q4Q=;
 fh=QGorB5rmOBMZ7omrFRbw4ryTP0XS7z0IjjEFddjD9ag=;
 b=VLxLX45507xubrCCUXkvgVRuWhn2FAcH6qjdN3OKneafVG1lAT/TyrflmdOUsE0dod
 bMXHjgrBbyIOmH9/7AJvFI/XIT1isjdkin2qoBQameV7hpTVP1RP8BkC3L03rswEvnMg
 Cme+WAQz6/xRi9FI12+ybR6/DIzpGVhw+9gKqqTvHxTis1asDpj5TvAfUt+6WAqKY4ef
 OLItcZYJESwpo8+oYfdddzd1ryEa1+/7yuJqL1xuz7ePtS2wXW+g8xEx0ErQdzksVrQO
 abLf8tVD/1a9fZDBRYJRIiOvnZhOylrINtMowqwchlYUwGDfi488qZsgxn4JD3E2u6ko
 tVQA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790025530; x=1790630330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ngu6mGd66FhUjN5aGIuLGfjJpEsaPulVmk1hW6Q9q4Q=;
 b=qMBvbYplMDankXlfQUhkMWzrcL7aSYtSHl8EbSNZhxBYI/9wiTyNOWU/zHsvAdmzVZ
 UleeuOX+JcXfwcLJw36xuVICMa9SPnCZJWo4X+cV9R4ofk86INtyeuBlRowPhF8JWQBX
 MxBZlVmlIfGDNnUPOG9I6bhDtK2eVNVwWetgwfjlWRShCQHdRiRy4Kp9cddUxOklvMqt
 rpZMIHo+1wCjYd77TEkUajtEEYIPTpXsZa/W/lldPu+gBLGk6Fv+cZun414bOxRPd+Mj
 qhqKCPhaJpB1Guq5QXqKPbAHfi8d8NYoBCtuS42i+Ybi5vTLJobkLSU6qxyg42w0oLLn
 RTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790025530; x=1790630330;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ngu6mGd66FhUjN5aGIuLGfjJpEsaPulVmk1hW6Q9q4Q=;
 b=gExjqm2HjcWcrcLVNSPLsCYlki4gqLLdKexNUIEn4wkgrUiKC8D2/O8Gpbl1RUdEkA
 F8aPrpsNCaSgUmyo8NpVwqyWUBVyk+/Gu7hkW6aa7ZnBjZQrxDnY+qhBx946GUhRVfZM
 wjPS1wyu5i6AD0kVQjb/d9bXXQojM3V53z/2X3IJ0qU+dFrC3YFBtNlxfzXcHEzbckxf
 oXRz7/1F2S6DpWrzeiQk1qwiKL1cNX2nja2JqVhz3gwunU4v13EBQnzVYW19q273rp1h
 nxQNMBcUEh3TaCe0o56nI88XcAkbbvhybTTZyeAfwLFHilqiQGvkhJGjoW1GELfuk/P8
 hqgA==
X-Gm-Message-State: AFuF++m+18TI4eJvqela3acey6aOWmGuvOv0wcwnyBteLjeRcHAxfW0x
 ZhjavLneCTreOnAx6eVEj8+x6JTWAT73RVKXBdKvvS0EOGxz9m8kHsnskDvOsgGCaWpaOQBtDcu
 dqE+KreQgTQNcBWnGzQwA8D9LCNLbhoU=
X-Gm-Gg: AYBFou2TnjnccDApyVzVh+opauWnx+5Ntns06KvhUmibeoezXj3lnQOTkypqXYlmjZL
 y7ZveZSAjYYYaQarNOxkt+QAirW8lhw0XuvHDBdAyDLHr4mZj/AVhNIfrlOv0kTJoaUo8nBsKJY
 xiL1YVKeihH/UL0KUWO5pjWSS9yTH4TVlXFaYTw69aIkcK9j+lPis2p3qYvL1feCPxApGkawBr2
 21Ru/+43ylH7HU0dC3maSRV+sAQUsh0fgmbP9YXCKJPFb+k+uauHIbffZJ/8Duw6smdH0BbdUyo
 hInLKxw+VqKWiiT947tSPtx6D+P7gvqOjTQmcPE+yMraaWaust2RB6q0NYGdDECFe0r65d10TsV
 iIwiIcqj7jOnrxPwauEM4nPjUnHcWrhwF7Fv0mUX3g92p+MdE8i9q
X-Received: by 2002:a17:90b:1a92:b0:39e:55ce:af15 with SMTP id
 98e67ed59e1d1-39e599fb4d1mr22337961a91.5.1790025530208; Mon, 21 Sep 2026
 14:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260921075326.2409021-1-Jesse.Zhang@amd.com>
 <20260921075326.2409021-15-Jesse.Zhang@amd.com>
In-Reply-To: <20260921075326.2409021-15-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 17:18:38 -0400
X-Gm-Features: AcwNN1WHYzQEh0g9jSlIxfh0Yxrv5jWh27BQ08nILcpLtwHQLja-SHXre3oTaG4
Message-ID: <CADnq5_MKf1nrk6ePu+GPdMNbx8xdyPqPXcuz5A7awiZQeDov-g@mail.gmail.com>
Subject: Re: [PATCH 15/21] drm/amdgpu/gfx: add a gfx ME pipe reset capability
 helper
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Lijo.Lazar@amd.com,
 Prike.Liang@amd.com, mnovales@amd.com, Jiongyu.Zhu@amd.com
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

On Mon, Sep 21, 2026 at 4:11=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Use gfx_supported_reset's PER_PIPE bit to report GFX pipe reset support
> through a shared helper.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 2da839228911..7c597dab5b2a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2376,6 +2376,16 @@ static void amdgpu_gfx_reset_stop_compute_scheds(s=
truct amdgpu_device *adev,
>         }
>  }
>
> +bool amdgpu_gfx_me_pipe_reset_supported(struct amdgpu_device *adev)
> +{
> +       if (!!(adev->gfx.gfx_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE=
))
> +               return true;
> +       else
> +               dev_warn_once(adev->dev, "Please use the latest MEC versi=
on to see whether support pipe reset\n");

Should be ME rather than MEC?

Alex

> +
> +       return false;
> +}
> +
>  /* Caller holds reset_mutex and attempted MES suspend before HQD lookup.=
 */
>  void amdgpu_gfx_pipe_reset_prepare(struct amdgpu_device *adev,
>                                    struct amdgpu_ring *guilty_ring,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 855651f0c930..5939e1fb3b24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -707,6 +707,7 @@ struct amdgpu_gfx_pipe_reset_ctx {
>         unsigned long replay_mask;
>  };
>
> +bool amdgpu_gfx_me_pipe_reset_supported(struct amdgpu_device *adev);
>  void amdgpu_gfx_pipe_reset_prepare(struct amdgpu_device *adev,
>                                    struct amdgpu_ring *guilty_ring,
>                                    u32 me, u32 pipe,
> --
> 2.49.0
>
