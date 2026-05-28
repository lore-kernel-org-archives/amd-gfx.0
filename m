Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4E0CD6E44
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 14:48:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 567D710E303;
	Thu, 28 May 2026 14:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="by4SngdQ";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7475C10E303
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 14:48:56 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-304cf9a02f9so115811eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 07:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779979736; cv=none;
 d=google.com; s=arc-20240605;
 b=XysLUoTBj5w88j53SUYo49/PnuLsD5vTPIW9m0/k/Ifz3slR2Qbcfk5Ef8jPUc0+7O
 BUaBxYqtiX5xlM3ikVD5+XZKO1dA9dMiNTw5b6DvY9ENFp5CanQNma/P8VANI71PVYmd
 +0yOlNakxYce3rqItoevdCmQShlVeSEobk7rKy9xFaCsdq+vacw+6P+oqAJMXM2iFXS4
 aQlbHuZiBfps9a7fi0tiJ8Wo8pxPuc3OTl6d8d+O1z1G7Amrf5wEwWnHlM+78c3qCNzn
 +Cixa/UGtq4SH2zfKrlfHmgBu7S3hKWoFN5En//OPlvl5Tq2qU3yZpQrpCH+G9MffMDz
 bWNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gEkjFYCXtTEOMJo2L1vUMAHTEucxQUbP6bvCitEziBM=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=NjpNr0pAc7Dr8AVraFOZuPMfQAyl6hxSS5qgfSizNVoBz4aqUXAX+/4YUQZtNt0mNF
 MNx8Ua0himPGkSHdJbHMUHNo1GmCKtVc2lWAPiBr+R3n5F7S4/PWcmVnU/OFVz4Y+xGB
 MtCwkopRWzfF1r9/E3di3CgRYnmtid0/vLT7FWr4/HYOnMrDeUpd7NWEPKPX2NJB43Hj
 PUsBxJlfmn+yNcHyK5lUqqtffN11AC45ndOJn6flS4iMpzzj5Nnbngo7RZOV1gEiQuWq
 B534uteevY+b/J22K4S4tWcJMNE7gGC0dUHM1zqiSccqllAmf44WtY4/VbekQSMhsECE
 W6Hg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779979736; x=1780584536; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gEkjFYCXtTEOMJo2L1vUMAHTEucxQUbP6bvCitEziBM=;
 b=by4SngdQaZHV8ECaCvIkglLosD2RcDi6MsEyzNheEXb7rwtqCvLacR9mGsP9GlJalV
 Scb5FL05LXWAVR96beELF80i2lVXc7Jmy9nvc+1jrWBpOqbATYjfFhjYp4i558mNWc/K
 zqZor5TrcjBVSARo710bQQnw5o2HqnXViE6BPylampr+aqMaMfhWNTxYe+PbIGGpjG2V
 0xQgVb5/B1WF1+/DwwYRsZamaAOCddATXknuMH/8JS9lVHdYzzaul+sNj8eot4YFTx1b
 MNJTSiFcJ8XTOg+Kq2fsBt/NOqultfG0edLKx5vBYpnXnrFokz1qUYoS5Rz6FDZJ8Of6
 j1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779979736; x=1780584536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gEkjFYCXtTEOMJo2L1vUMAHTEucxQUbP6bvCitEziBM=;
 b=Mr4Wvtxr9YaaC+2nc5DmNPJHGkwPOKeO8DcagRZJBK/1FPB7rkFTciEjIrK8PNixPP
 K288J0WAczWgSiLG+jKjURNiJCUOoz6nefQCSpQrqO3PVI0Fzt25qLrBNYZVCjBps3VI
 MrHow/EEg7m9Vo+CPdwoGzPki9mSaZy+tmR/bXs3HFSiGzTrOCCUGW/XPoby4OUguLhe
 JbPdM2fQx8/HigfaYVd6ZL243AfVJDcQiCUu1DWncwgafME1sOC+kG5w6wtM0kaQXNTi
 w+2103EziLUBK69q+7+uxX0LCZqI8d0IoZpS2abjt5Q3FHxB/Ra2niHONRB6uekZ2kkD
 65KA==
X-Gm-Message-State: AOJu0YygL0ES7IYjFp4eN3rU6t8lcb1EmkjxeCkpB4YaiA8cqPHjsf3r
 XthopNGXL3bbXhFB5T1Sn1dFcEY7Gxw3iGpd2ZR6DEpRkgypm+zSCq7lDwPAaPhr7zI8J4PoAl4
 spXXEzlnfQoM8Mh/BdQ2aN3vJRBdBRc0=
X-Gm-Gg: Acq92OERXXJxVdVmoS5cwVKuRhySnNIkTD78/UOgyE6Ld9TqlBB1CdCRCco0FRE5Dr1
 WWXpQTin1mIBpL42U3lovSgBFgNqw5S/Wqyba6N6bUeIBLDdWG15G3tB/di8Cl9u4iLTUFNbZo5
 LpVTTQFK6jxGK/Bpmdd408LF0Z/ELy44MEpleEvKZIM2QKIaTWlOj497IBnLpMe/lH+WWvYmaG1
 0cJdzWmb67UnoSgetkTnfjwrx2HrB4MPi4bYUV31xIMIbtf0SwCKccmYKTot9ilPA4dFELDhETj
 V4x3ZLtb0lLG/SdV6OMqG+8KArhK4bd2ffd/fw7Zx0XPUrYmPM/LiFTkJwWms8JEKmLh+FyM33J
 2hJA1
X-Received: by 2002:a05:7022:2399:b0:12c:90f9:4da0 with SMTP id
 a92af1059eb24-1365fd75e01mr4697890c88.3.1779979735444; Thu, 28 May 2026
 07:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260527194603.3976381-1-alexander.deucher@amd.com>
In-Reply-To: <20260527194603.3976381-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 May 2026 10:48:43 -0400
X-Gm-Features: AVHnY4KevMl8rgVwmX9gHphzu1KRglB_HgjCFkKw1zqOjvccvxha5SpxMu_tbdg
Message-ID: <CADnq5_Pi8=99aTiNP2zj6jdR8072_W4b4+CNbMc86M1q8qRQ_w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma7.1: fix support for disable_kq
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

Ping?

On Wed, May 27, 2026 at 4:24=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Set the flag in the ring structure.
>
> Fixes: 80d4d3a45b86 ("drm/amdgpu/sdma7.1: add support for disable_kq")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_1.c
> index e1c0a4ff0e7ff..cd9668605a501 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1315,6 +1315,7 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block=
 *ip_block)
>                 ring->ring_obj =3D NULL;
>                 ring->use_doorbell =3D true;
>                 ring->me =3D i;
> +               ring->no_user_submission =3D adev->sdma.no_user_submissio=
n;
>
>                 for (xcc_id =3D 0; xcc_id < fls(adev->gfx.xcc_mask); xcc_=
id++) {
>                         if (adev->sdma.instance[i].xcc_id =3D=3D GET_INST=
(GC, xcc_id))
> --
> 2.54.0
>
