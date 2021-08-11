Return-Path: <SRS0=MFBU=NC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2518C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 20:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94B1A60EB9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Aug 2021 20:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94B1A60EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B091889115;
	Wed, 11 Aug 2021 20:35:45 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE5989115;
 Wed, 11 Aug 2021 20:34:19 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 z9-20020a9d62c90000b0290462f0ab0800so4871390otk.11; 
 Wed, 11 Aug 2021 13:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Rzd2Vkj46k5v3BAQCLAT3X/kdS/UT4sWDbrVlizoCHI=;
 b=W61s8/OLb0eTl3ggZRiamq+PrLDOHy7nPOUZzTR7yVkWwNf7iQRIkIVkq1DTfyCVqd
 Ssmp2c1cmMe4aVlsRNFap/BZG4MxO3gslbHjCYjzCE4r86z2sNrraGUFSD+VMd5EpNww
 YSCAmk1gs+Py9t4HyH8HHcHM4Ti8W84YLaXSE0cvtCzRYfj4FG1/CKLKTXBZe6kioyZQ
 1dXfA+hc1x71Y1efvfIBkux6o30Vx8Q9nERGhIkAvDs++PVxoQALdapEcE7mtKQ9pXj9
 8r/EePzFzxpcu6rNgwGEZ7sI8r2YnqRK8vWeQhHJ/taAE7BCDXu/Wfe/0qVAGaHmdg4L
 RcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Rzd2Vkj46k5v3BAQCLAT3X/kdS/UT4sWDbrVlizoCHI=;
 b=Ftn582bM02abpmTw36cKuMEYbWvcqVhyhkht5fHgNjqlXrG/XRNHN3dGw0b7Om8W3D
 jUIp3H3FN3Fk+5AwdML+vejGOz0W+suAhtBUyKnhJJA1EEsp3sKSFK28wcdYQZJBHGTM
 KMrAXY1rk+7SVL5vfFVGdzzYXA/VXzcdNGJQ9zuNsaVRXLaCyLIIZAR4INrv6OmoTFOB
 ajtERMm9FkUm/6ami9nq43oyNTnCG1R0F3z4VqO9Fl1P5Lk46IFnb0dS3f5CnV2/ZVKj
 RMXqSlmWVaFRA1cFHZ9Em7RxetGo4TiMW+ATJ763kgXfRBz2FYDa5tzH2c6uY7tQBkaG
 YdhQ==
X-Gm-Message-State: AOAM530Xifuf0KWeJzAdMA2zxlnvLd/LZz6JLrf7XhMgh2qxYw7O4/jZ
 6lPVX9B3EgR3TU9sL39xj8XO2NfcCq2nmCxmfNzh+oZ/
X-Google-Smtp-Source: ABdhPJxCc6pnAfq3N8Ma0NNQO02OkNZ7jmBnpMryVISzycaIaaOYJ57SE6tfbcf3ekw49uwiKpvqMfp+iyXZS1lX+Ro=
X-Received: by 2002:a05:6830:1e78:: with SMTP id
 m24mr614888otr.23.1628714058493; 
 Wed, 11 Aug 2021 13:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210811165211.6811-1-michel@daenzer.net>
 <20210811165211.6811-2-michel@daenzer.net>
In-Reply-To: <20210811165211.6811-2-michel@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Aug 2021 16:34:07 -0400
Message-ID: <CADnq5_OhcTdPNnHU_9iY73H-dxhnjq6igy7NvHw1AeknEXkeYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Use mod_delayed_work in JPEG/UVD/VCE/VCN
 ring_end_use hooks
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
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

On Wed, Aug 11, 2021 at 12:52 PM Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
>
> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
>
> In contrast to schedule_delayed_work, this pushes back the work if it
> was already scheduled before. Specific behaviour change:
>
> Before:
>
> The scheduled work ran ~1 second after the first time ring_end_use was
> called, even if the ring was used again during that second.
>
> After:
>
> The scheduled work runs ~1 second after the last time ring_end_use is
> called.
>
> Inspired by the corresponding change in amdgpu_gfx_off_ctrl. While I
> haven't run into specific issues in this case, the new behaviour makes
> more sense to me.
>
> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>

Makes sense to me.  Applied the series.

Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  | 2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_jpeg.c
> index 8996cb4ed57a..2c0040153f6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -110,7 +110,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *r=
ing)
>  void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring)
>  {
>         atomic_dec(&ring->adev->jpeg.total_submission_cnt);
> -       schedule_delayed_work(&ring->adev->jpeg.idle_work, JPEG_IDLE_TIME=
OUT);
> +       mod_delayed_work(system_wq, &ring->adev->jpeg.idle_work, JPEG_IDL=
E_TIMEOUT);
>  }
>
>  int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index 0f576f294d8a..b6b1d7eeb8e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1283,7 +1283,7 @@ void amdgpu_uvd_ring_begin_use(struct amdgpu_ring *=
ring)
>  void amdgpu_uvd_ring_end_use(struct amdgpu_ring *ring)
>  {
>         if (!amdgpu_sriov_vf(ring->adev))
> -               schedule_delayed_work(&ring->adev->uvd.idle_work, UVD_IDL=
E_TIMEOUT);
> +               mod_delayed_work(system_wq, &ring->adev->uvd.idle_work, U=
VD_IDLE_TIMEOUT);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 1ae7f824adc7..2253c18a6688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -401,7 +401,7 @@ void amdgpu_vce_ring_begin_use(struct amdgpu_ring *ri=
ng)
>  void amdgpu_vce_ring_end_use(struct amdgpu_ring *ring)
>  {
>         if (!amdgpu_sriov_vf(ring->adev))
> -               schedule_delayed_work(&ring->adev->vce.idle_work, VCE_IDL=
E_TIMEOUT);
> +               mod_delayed_work(system_wq, &ring->adev->vce.idle_work, V=
CE_IDLE_TIMEOUT);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v1_0.c
> index 284bb42d6c86..d5937ab5ac80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1874,7 +1874,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ri=
ng *ring, bool set_clocks)
>
>  void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
>  {
> -       schedule_delayed_work(&ring->adev->vcn.idle_work, VCN_IDLE_TIMEOU=
T);
> +       mod_delayed_work(system_wq, &ring->adev->vcn.idle_work, VCN_IDLE_=
TIMEOUT);
>         mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
>  }
>
> --
> 2.32.0
>
