Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A6606A32A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 14:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BOgOBFgi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A10410E414;
	Wed, 11 Nov 2026 14:01:57 +0000 (UTC)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2463710FB7C
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 14:01:51 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1397a4855beso14868c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 06:01:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794405710; cv=none;
 d=google.com; s=arc-20260327;
 b=AvGI7MZ8MUSBgNQTSJWRdHFWtqCfxKaC4xChFCG/uhZtnw1LsZNS9OSenkqmBaa6Eg
 sN7DkUzcz9b8W+cAjjPqoFTqb5PXucyqcAcSbbFrtAyd3cJbnmDCTiiAGavWfAOVrwpw
 jHG2y29dLCTml4366rwcS7423Y1k/eSz0PVDl0MF+pje4gJ9xgzPXhi3a4FAECPOE2vR
 1pF2g6RLPLU4d+eepxTCtI+h4jgzw3SpbCbxvYM+YE0z22bkt3Nk69PK2AffkAqqChvT
 S6S4vmQiLCg7CTZrIvMDrti3VzYiD70gefsDyV2/8WchUyHk9pHkrBpOTu+cxVhoVCup
 /31g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jSV7SBVBfQed7tWTcZPjQUUXR12PNj6dB1pSYFv/ckk=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=RjhaWqOQ59as0+EpRtbrdYCHlPXznaJZ7rRGCoZGWrIILGIUAxDU/rdnF9JAm7Zi++
 laUWtHuRggNGrWNZkq6NTvm019r4kwkQJxict+26PYTAeuniAq8bP87olElFWw0h1QHj
 Mt6mvllFvXMKGlwG5WzVZXq2PyRA6G0pY7lj2n51iPYpebsrMZVFa8ZL816LtICGnk0a
 e66C+QOF3k8ePC6ULxK4OyAQG/mARmV5edijCsQmE2eellugzH2cjcSNqOJmyrT3NnaY
 v1NZb/Y2jFxrykUwr29+JN383Cr9wSr8AgS4qnO/mRFzOpm4FTtIA4PXX8VAnquFW+rs
 gGdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794405710; x=1795010510; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jSV7SBVBfQed7tWTcZPjQUUXR12PNj6dB1pSYFv/ckk=;
 b=BOgOBFgiorl843CSE+vKgIby//tHAVIcCWCWbToKF33jVssEUo9hewf2mAN9HwUb+t
 imgF/+pjHlFitE0LBU4n7yP+zI/MTl7kiHLrYsTcwhPsSLOO7MBsRbhII/xjMqihmzYY
 eHCTKtygbzCPLhtE/MJ6Iv28LCVQBQC31uJU4Di7zWuMNLEx+5rTWhRH61KKo3ZlE5f4
 3BqUp/ooUqlY5xMX/baBJvkJvosZSu53GMFjxmk9nbzoeWAWFJHyYMurfchc/7L/zoQl
 8YHLv3Rng/addx4C9jxg9OSdEp7PWYvDB+MOnw5Ovh5xzGGD4m/x747fEgjiv69EgSB5
 niTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794405710; x=1795010510;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jSV7SBVBfQed7tWTcZPjQUUXR12PNj6dB1pSYFv/ckk=;
 b=mGAiNEbYKu/pCMKZJlPVsLYZl7w3KGrIEnsrnF4BQyeubtUCgmkqoiBjR4M4EhVh7F
 WoBsCG8d3J3/IZMowN5p/ffEPu9okHrowmk7J2BoshCKMl2zrNrBKsBtwnz5mPP5WepF
 i/CvEdKik98vETz006ZKKEKtH/p9Ema6AuI8aVTyk2dy1iA9zl9emEqqJmqmY9nVus1S
 I49uy6T1ASc+F5E5t4oH+v+pptwdYZlaRcnyznMeYZyQPHdaz+PErnSfgnWNJ0tMHACb
 Hn3HxebionTex599HDyr0RxTVTobCQ/J2OEMEkBECtfARFcPruiZjmKVwNNDQC5d9fzm
 08MQ==
X-Gm-Message-State: APuU4Z/WKY4dldZel8vNRXiF6HP7gNyLHqhifnhF0cDwLetPLrd75/Of
 D7xQTR9taPVeCIdWAUOaXSPNK13u2grGPkLrtAyW4BnGRqWeVvSm0xGCkgpKX/uqgk26NPrBQAI
 AltA9971GisX+QyIsUdf+afJd+zXlTMA=
X-Gm-Gg: AYBFou1X3mSIAU20rUP8XjehiSQyt6Jom5/Sgu3YZTIAxShKoMo2opLJU2yKbp1B8mg
 LJUo9FfiXXKKd2Bp4MPcyLx7ZbsOIUhMcv1PiUfTBk/6b5o/rgNOpyAHNqzNUxjB6GV+CixDIKw
 mRRkJeeEPtrPrkAvBeQz3ipbfoRdLQ3BNgrAr6uPGNP030pkRNutFuGSojIQQImCWfHa6oY7w5P
 B+KtfJnLPkd9dBszKlYSUj2yfnIGvMPwQowNUc3GjqNjTdzBMgdu663aoa/EirxQedA7d8szPB0
 bqTCka7k+7U3TUgmqaNGx3yvEAsf+AdGd5Ia54WtMBUKMT2PsRaZU/DGIMYzep2Yxsa9NCOqYp7
 hLSNaTf4PJ7to2JDFcGtZS2ui8BGILrn2a5Oz6Q+8B+jYOGkthvDwFjmwUT4/R0rjYt6vudDu02
 YhkalAgokXty3G6f4ISYzTr1IFZbBWdLYg6IE7idgjV1FTmVd79o9arvVk00Q=
X-Received: by 2002:a05:7023:a4c:b0:127:def:dd72 with SMTP id
 a92af1059eb24-1b3c02ecce5mr3698819c88.2.1794405709358; Wed, 11 Nov 2026
 06:01:49 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111032115.3787085-1-Jesse.Zhang@amd.com>
 <20261111032115.3787085-2-Jesse.Zhang@amd.com>
In-Reply-To: <20261111032115.3787085-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 09:01:37 -0500
X-Gm-Features: AclHuK-5L0Afu8dC4SyIKnVhcAAw3ZjeJi-8b4jRCHxBeIzaSmh-Ht5n3tJHnUM
Message-ID: <CADnq5_O0OJ1R0Zzp-GV=_6Qp8cqBTWgApdmu6vpQXam0HdPEJw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/gfx11: enable the GFX pipe reset with new
 enough CP firmware
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Nov 10, 2026 at 10:31=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> Resetting a GFX pipe needs support from the CP firmware. Advertise
> AMDGPU_RESET_TYPE_PER_PIPE for GFX on GC 11.0.0/2/3, on top of the per
> queue reset, when the firmware is at least PFP 2790, ME 2600 and
> MEC 2850. With older firmware only the per queue reset stays available.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 5d068a9d9c72..ea74defe7fea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1925,8 +1925,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>                     !adev->debug_disable_gpu_ring_reset) {
>                         adev->gfx.compute_supported_reset |=3D AMDGPU_RES=
ET_TYPE_PER_QUEUE;
>                         adev->gfx.gfx_supported_reset |=3D AMDGPU_RESET_T=
YPE_PER_QUEUE;
> -                       /* TODO: verify CP warm-reset support before enab=
ling PER_PIPE. */
> -                       /* adev->gfx.gfx_supported_reset |=3D AMDGPU_RESE=
T_TYPE_PER_PIPE; */
> +                       /* Resetting a GFX pipe needs the CP firmware to =
support it */
> +                       if (adev->gfx.pfp_fw_version >=3D 2790 &&
> +                           adev->gfx.me_fw_version >=3D 2600 &&
> +                           adev->gfx.mec_fw_version >=3D 2850)
> +                               adev->gfx.gfx_supported_reset |=3D AMDGPU=
_RESET_TYPE_PER_PIPE;
>                 }
>                 break;
>         default:
> --
> 2.50.1
>
