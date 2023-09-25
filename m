Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5097CE7A81
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 14:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3623E10E264;
	Mon, 25 Sep 2023 14:24:35 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D327D10E264
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 14:24:32 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6bf2427b947so3240277a34.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695651872; x=1696256672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VoebIdzAQqabF1FkK3+kTXtIMJCsUe8LphF77eg6ro=;
 b=milUn0KuOerhYzhNVy+PuSbOGDCl3qCU9tHZhLSgee21Q/2xxtlqwzskzx/fsotiUr
 Qd83Eokkwe0MbRFOeQF/HpaI6O3sPcr8pFx8uyTFTlOoOjZ2Y5o6qV/YE3xlQyuSZJOF
 g1eBkmlHv+C4CBLJQ06ylZpg2ryVmDSGPNToXxZp/9y91tL5yZB4nbKbGf0e0CdocYf8
 ObFJRLbfMZ8IfKg+hrnKf7dfRUcj/WcqBGegaELyTs6nhQecv7S1S9+rswkajWoDG7/n
 RSP1xemu23cv5D1Jcg5/j18PNoE8vbsBqCxf+RqGx5qH+1F8UC/UMubqKFPGAXU3OUIK
 LWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695651872; x=1696256672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VoebIdzAQqabF1FkK3+kTXtIMJCsUe8LphF77eg6ro=;
 b=d9DyOjdy9iwtCekIPfrpDmUfPEFwmz9C/AJ6Oy91EehPAzLVMjAPGa/X678GDNoFca
 Hba7Yjq23/Je2pE4EvmGg3PxK1AfIFYnVRVux+1T6xheFOnRjs1FLYH0q46a3gSlhjRa
 KOWaCsj4y7MJptdVmT5pYDjAGWj5bHTRWg28xu5MEy5sa613x/1WNdMV1Pwmd/6LxfEO
 bwiDhJEvDTZaxc2UbrPO/C8dVbHF73X9HJfnSZHkz0NFE4EcDh/XFsL8ljayBOSXlT0o
 6r79xAdWpQbY+B3GYzkBkdqzhj5zwxy6EhZWQ3jMfD3xaIyDERkGXec4teB/vGR3+dXU
 jcFA==
X-Gm-Message-State: AOJu0YwehpkJIyl9O1aaMGNT1ypghNisyRkkqOB9xv6aJWRKnvUbXcqO
 dXXzX9BUfJBPULq6jyFmbV1l0EjYXh71rxzeU/72PDEq
X-Google-Smtp-Source: AGHT+IFIx7m5rqwbU2hHJV/hW7QdIbw/eRS63835Be1xvDB63nbjcrjeUA/hySd9yex7C+fGTzaMuujtiJPyHW8BQds=
X-Received: by 2002:a05:6870:63ac:b0:1d0:dbdd:2792 with SMTP id
 t44-20020a05687063ac00b001d0dbdd2792mr6912102oap.39.1695651871940; Mon, 25
 Sep 2023 07:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230922213419.51846-1-luben.tuikov@amd.com>
In-Reply-To: <20230922213419.51846-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Sep 2023 10:24:20 -0400
Message-ID: <CADnq5_NapXB0PH84EszWBfGfWJxXYU4hV3j8fHpHwbaMxKeJEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix a memory leak
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Yang Wang <kevinyang.wang@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 22, 2023 at 5:51=E2=80=AFPM Luben Tuikov <luben.tuikov@amd.com>=
 wrote:
>
> Fix a memory leak in amdgpu_fru_get_product_info().
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Reported-by: Yang Wang <kevinyang.wang@amd.com>
> Fixes: 0dbf2c56262532 ("drm/amdgpu: Interpret IPMI data for product infor=
mation (v2)")

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> index 9c66d98af6d86a..7cd0dfaeee206c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
> @@ -170,6 +170,7 @@ int amdgpu_fru_get_product_info(struct amdgpu_device =
*adev)
>                 csum +=3D pia[size - 1];
>         if (csum) {
>                 DRM_ERROR("Bad Product Info Area checksum: 0x%02x", csum)=
;
> +               kfree(pia);
>                 return -EIO;
>         }
>
>
> base-commit: 14d13f757d369c9873ebbe34d02d0896f5de565e
> --
> 2.42.0
>
