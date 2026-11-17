Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389C2606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sGk0Cpzm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF53A10E622;
	Tue, 17 Nov 2026 15:14:48 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87A6810E52F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 15:14:41 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-4bd3984f529so168323b6e.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 07:14:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928481; cv=none;
 d=google.com; s=arc-20260327;
 b=XM55E4i34jpsYo95oZXbDrj21DdjtpOuu+M6Z84OijDdf9a7C4jwxFFAYfesRBZCbu
 fFqKJ4rZEZlIdMotK76ml78tWISkD+Q2ONMTBW1Khr4xmik2AAHtbt/j0NsWAU1laV06
 BNUS0AtLrFPmJ0SLrS8RcJ8SmOAVxCUgvNT2piAqxOg+SZPfwtCaMtvwu5pNg34Zaa/r
 8mv7+JP+ZNfGVZX1QO31oBTeOMV6g+NojbFDlv2K8Namr7sUDarylniTicz+Q9/+GsdD
 eAYmnCenAurngQDpFy4hpX14r+ZvggSswt87PzfBSbRgEMojwFbDbt+G7KBhpo6uXV9p
 /mAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uH2nxEGkV1g5Jfii2IZZNF90xHIevojAZP7NrTVDZIo=;
 fh=9Aa9t1GWI15GjZgE0zsZXkPIOx3z5ApcHxbG5r5gQTk=;
 b=F0iMa2kL4GCzJQShXG2AXGhmENhYUL7SdqR7FTeTAkvilvvoY3qOFmOS3CJb4Jcsaf
 naE+Zm8DipzDGsonM2fuA/UUS+B6hjGfjV1dRibAdkesG0W3ZMNJXev71lacGSCSbybq
 Lw5yHlViHSBpPqg9UsdUaQGz2txl6p2MTX9KHPNSEdYoFFqJpH3QiqDjF4+SBwkrONTV
 A03d5Hm9ARsydZAVlOE9Kv+aBMzuWl46IdxI9B9kmCiHOUtxYSHLCuK5c3Yb4SzVdQ+d
 zFDetk8ACmP6SnYVKZArgvBfnv/01tluUzcJ2DmQwhwDASEtTogjxUzrWxSXhiIqM9vq
 Tmig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794928481; x=1795533281; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uH2nxEGkV1g5Jfii2IZZNF90xHIevojAZP7NrTVDZIo=;
 b=sGk0CpzmqniZ7CUTslDGUjNBkazeQth77qSpozqbEp3e9ijC+ijeQi2ABu4S1FN9b7
 /5yLudpxWkwwkqmq+2NiZapIKsdSL1jcAKCh0vrRCdkcW1R4oD+PO2nIvxMD1PvqZIeg
 CSRg1pib1TiMfxg73q6nnN5oA7uRyGwgOe3axodSQuOuxaIoUfZdn9CBGR4YMiL+RrYj
 tZMi77LOAI+EkneTpUiqpMPfW5IdAHE0axz8oyFKTJLXZodpEfT/R3gjmsIDzw4ui6r4
 yIqXLpiLQzuKQS9EfVgyV0W6jqCxcwzfYj0CUlZRWwsoWAd2Gex14E3KJToT35RuUxWV
 hQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928481; x=1795533281;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uH2nxEGkV1g5Jfii2IZZNF90xHIevojAZP7NrTVDZIo=;
 b=mdq5znsczPSUff6yD/iawf20M/SopVJeOn2nWOw0UyzcHFEn2bZXlCer01Qon134bV
 f/6hITvxkuclxqVyMuFv8qtJsSaaOZ+z6brwzm6zP6LFK0/WNT/Jr4ECBCnS/A+Nwyv8
 XbCP6b6sgQlDVwyByD8sBs9Nq+zSPTLUlYlsphwCbVHW8IAQG9ENhjfSPUh9Al4ITHOQ
 rRgMkRMjabTv40Q5wna59/OthNb66Mpm+PZgcMyUnptbmL1ZOWT95gp/SWRbvCnbpAJp
 o5Y4HtThY8jzak0pAAohiweJH68BLlXjdZLmCI+ehCq2+nSUEqMz7UefL3Q8OyNXLuiu
 DYaA==
X-Gm-Message-State: APuU4Z8tUptsFGmtTU1PpyRs9eURVmQshq83sP+Qgsd3SdGveFL7eMc+
 mFCZ5zHvxRZ+Evcq45LrSe0KSNR6HLA+hXSRv1Kg5DyJEixP73oy3aVsBuC3et/LFR3Lzqt+5wF
 Q7nXzxfvul9bYs1tg6g4tRsrKghIYKAA=
X-Gm-Gg: AYBFou00yCBr61v8NOAZpRooNoWBUtQhuTqAxKlUxNznLNRoeh3u+XLvwouggE4MlI+
 FZ9QnKTpLxvGaHR78fBpv0qOrbDQZiXVgeyafklo7VbpBFoiFkTBX9cifCT3AqK6ha2cTm9tgsv
 i5FGtCwkqlI24RoKnpnhfWZf6VRbk+R9gh80fLWG33qtojK5HqXsmmqYKd1KrKrrK2tboJbSRgJ
 JlcOuYKbjyTUuJAHSO4pBIcTUPpq7QAAMORHQRrvzh88GBKAGqrNu4F793jUCKkKMMS8Ag9qf/3
 kO6CrtCABa0LkOkq28rWWBDP4v5X1MDEvqrJL8PXU780t5q8HpcVvc0j9TuaFaTg+fj50n+J/xK
 ZI/cFqcrWHueNS+2znEmiXOHf6wtpen1TsLIH4d2MW67w2npVRV5/UjbudMltNdoSf5Yae3r7uc
 9TNuqlr1RVFU70qOqtM2dATIupq/+njll/m0MLRBL9DvCQN5gPrb6offd2JzA=
X-Received: by 2002:a05:6808:1a0b:b0:4bd:73d9:85c7 with SMTP id
 5614622812f47-56e5d0ed674mr19410334b6e.0.1794928480549; Tue, 17 Nov 2026
 07:14:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109184113.3656539-1-alexander.deucher@amd.com>
In-Reply-To: <20261109184113.3656539-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 10:14:29 -0500
X-Gm-Features: AclHuK-HdNwyvQEglfzNJbBU4cnDhMtA7xdTMBYfNmsdfUVYAFfzMtFlGaeyrxg
Message-ID: <CADnq5_NxpL68R-g0Zp9Hguk-pJWyvi_tTuURGvPXEORrwWTOjg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update mes max sdma pipes
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Frank Min <Frank.Min@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 2:21=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> From: Frank Min <Frank.Min@amd.com>
>
> Newer SDMA IPs support more instances, so update mes max sdma pipe.
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 +++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +-
>  2 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 0409325017a27..a00160ad7b61c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -114,6 +114,8 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>  {
>         int i, r, num_pipes, num_queues =3D 0;
>         int num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) =
: 1;
> +       int max_sdma_pipes =3D amdgpu_ip_version(adev, GC_HWIP, 0) >=3D I=
P_VERSION(13, 0, 0) ?
> +               AMDGPU_MES_MAX_SDMA_PIPES : 2;
>         u32 gfx_hqd_mask =3D amdgpu_mes_get_hqd_mask(adev->gfx.me.num_pip=
e_per_me,
>                                 adev->gfx.me.num_queue_per_pipe,
>                                 adev->gfx.disable_kq ? 0 : adev->gfx.num_=
gfx_rings);
> @@ -169,15 +171,12 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>
>         num_pipes =3D adev->sdma.num_inst_per_xcc ?
>                 adev->sdma.num_inst_per_xcc : adev->sdma.num_instances;
> -       if (num_pipes > AMDGPU_MES_MAX_SDMA_PIPES)
> +       if (num_pipes > max_sdma_pipes)
>                 dev_warn(adev->dev, "more SDMA pipes than supported by ME=
S! (%d vs %d)\n",
> -                        num_pipes, AMDGPU_MES_MAX_SDMA_PIPES);
> +                        num_pipes, max_sdma_pipes);
>
> -       for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
> -               if (i >=3D num_pipes)
> -                       break;
> +       for (i =3D 0; i < min(num_pipes, max_sdma_pipes); i++)
>                 adev->mes.sdma_hqd_mask[i] =3D 0xfc;
> -       }
>
>         dev_info(adev->dev,
>                          "MES: vmid_uq_mask_mmhub 0x%08x, vmid_uq_mask_gf=
xhub 0x%08x\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 652cd09504538..ff38e45f4ff01 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -33,7 +33,7 @@
>
>  #define AMDGPU_MES_MAX_COMPUTE_PIPES        8
>  #define AMDGPU_MES_MAX_GFX_PIPES            2
> -#define AMDGPU_MES_MAX_SDMA_PIPES           2
> +#define AMDGPU_MES_MAX_SDMA_PIPES           4
>
>  #define AMDGPU_MES_API_VERSION_SHIFT   12
>  #define AMDGPU_MES_FEAT_VERSION_SHIFT  24
> --
> 2.56.0
>
