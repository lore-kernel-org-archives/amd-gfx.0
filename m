Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A3C6C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 21:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D2110F2E9;
	Wed,  1 May 2024 21:28:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HbMVdPSa";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671F010F2E9
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 21:28:12 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ae913878b0so5426782a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 May 2024 14:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714598892; x=1715203692; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2VT+oZVeDyw7JWD7ceBtLg3ElTRJEHZOi2AhO5gd1Ho=;
 b=HbMVdPSaqzephgADazY1Qkzx8/nzAKoBor9ntmyXv+WhGstO8Uukh210n+zF1qcVWb
 V4uqLnL8gsLWjHEyzp4DkAHSACk8l3PRaK/EDW+e+iH/hW5o0HIMFDM6JOR9bHVlH/Ku
 HTmPNULRO9OEEsmGxrJE5wtj5BxhNTfjuaTvGoZ6UBY10yhNwuNg9YQIYDnzU4T9vYXB
 /wZ/JgoDHaz4KGECwFND3cJSaUtCNu5J6OlNTxol/D3ZbcY3GMqoQ14waTC80PjMA1ZQ
 a+y84SzhTRXiJaGI5i3uIPXMeDN1j05JHjj2TeSrzsfCuhDQaSRuvgc2EcJSTz328OHr
 qbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714598892; x=1715203692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2VT+oZVeDyw7JWD7ceBtLg3ElTRJEHZOi2AhO5gd1Ho=;
 b=ODM8vRgFdko8KrPkkcTwlfmTwP3gnpFXLruJpzH9TyociTnT1dN+SBgSMNNZFuF/ND
 yvA9ZfnGRAwCdsjjs3lxyccQMgtytN3vjbf68jx5bmajA6FiWID/CpR8yM7CuXk5318B
 dwR71FTYVDGMV5eNpaePKzgzWzernTrKXTYYAuSlQp9HULJxoxOk37qPyJmqBXJ9EY7h
 GIreU2vs+upFulAn7jbmXOc6DdawMzdhqvBNQYbNu6qgkhIS0BTTyWaKZhyre5Cs58Jo
 Vs8hYkOdzNa4/JOxTELYzkJsF3nA5TXx1aiTvi9y1tZUAMe6zyhusTnqJDvBrwo8jOVr
 LVbA==
X-Gm-Message-State: AOJu0YyCSnjpAo3X4iG21HtNgWCECWYfHvHmYccKmrduF04/CiJDKw04
 dRWuKm+CEfOwu8nZg9+uxlyAfBf21SwPSVhLnuhkw9JewvmfjDb2/7NtFxFhw6nlZduawMlV9sC
 cGIKrZTbKlwQ/4CryHkudY8gmSr43+Q==
X-Google-Smtp-Source: AGHT+IHR3i+I8jR90lITp14RcpEfmL3Dj00Xn+yQiHaHBHeeH2DSZfZstLb+3qHpF3ebjN28szbMlngMjq+EQlO9zRY=
X-Received: by 2002:a17:90b:5144:b0:2ae:e1e0:3d8f with SMTP id
 sd4-20020a17090b514400b002aee1e03d8fmr3289625pjb.2.1714598891643; Wed, 01 May
 2024 14:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-12-shashank.sharma@amd.com>
In-Reply-To: <20240426134810.1250-12-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 May 2024 17:27:59 -0400
Message-ID: <CADnq5_M7efw7BWST0qVpkT=6deOSe7teFp=bCijBsSkhY=r+aQ@mail.gmail.com>
Subject: Re: [PATCH v9 11/14] drm/amdgpu: fix MES GFX mask
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/mixed; boundary="000000000000de8a7906176b294c"
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

--000000000000de8a7906176b294c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 9:57=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> Current MES GFX mask prevents FW to enable oversubscription. This patch
> does the following:
> - Fixes the mask values and adds a description for the same.
> - Removes the central mask setup and makes it IP specific, as it would
>   be different when the number of pipes and queues are different.
>
> V9: introduce this patch in the series
>
> Cc: Christian K=C3=B6nig <Christian.Koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 -
>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 9 +++++++--
>  4 files changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index a00cf4756ad0..b405fafc0b71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -151,9 +151,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                 adev->mes.compute_hqd_mask[i] =3D 0xc;
>         }
>
> -       for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> -               adev->mes.gfx_hqd_mask[i] =3D i ? 0 : 0xfffffffe;
> -
>         for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
>                 if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
>                     IP_VERSION(6, 0, 0))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 4c8fc3117ef8..598556619337 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -110,7 +110,6 @@ struct amdgpu_mes {
>         uint32_t                        vmid_mask_gfxhub;
>         uint32_t                        vmid_mask_mmhub;
>         uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_C=
OMPUTE_PIPES];
> -       uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_P=
IPES];
>         uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA=
_PIPES];
>         uint32_t                        aggregated_doorbells[AMDGPU_MES_P=
RIORITY_NUM_LEVELS];
>         uint32_t                        sch_ctx_offs;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v10_1.c
> index 1e5ad1e08d2a..4d1121d1a1e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -290,8 +290,13 @@ static int mes_v10_1_set_hw_resources(struct amdgpu_=
mes *mes)
>                 mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
>                         mes->compute_hqd_mask[i];
>
> -       for (i =3D 0; i < MAX_GFX_PIPES; i++)
> -               mes_set_hw_res_pkt.gfx_hqd_mask[i] =3D mes->gfx_hqd_mask[=
i];
> +       /*
> +        * GFX pipe 0 queue 0 is being used by kernel
> +        * Set GFX pipe 0 queue 1 for MES scheduling
> +        * GFX pipe 1 can't be used for MES due to HW limitation.
> +        */
> +       mes_set_hw_res_pkt.gfx_hqd_mask[0] =3D 0x2;
> +       mes_set_hw_res_pkt.gfx_hqd_mask[1] =3D 0;
>
>         for (i =3D 0; i < MAX_SDMA_PIPES; i++)
>                 mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D mes->sdma_hqd_mas=
k[i];
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 63f281a9984d..feb7fa2c304c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -387,8 +387,13 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_=
mes *mes)
>                 mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
>                         mes->compute_hqd_mask[i];
>
> -       for (i =3D 0; i < MAX_GFX_PIPES; i++)
> -               mes_set_hw_res_pkt.gfx_hqd_mask[i] =3D mes->gfx_hqd_mask[=
i];
> +       /*
> +        * GFX pipe 0 queue 0 is being used by kernel
> +        * Set GFX pipe 0 queue 1 for MES scheduling
> +        * GFX pipe 1 can't be used for MES due to HW limitation.
> +        */
> +       mes_set_hw_res_pkt.gfx_hqd_mask[0] =3D 0x2;
> +       mes_set_hw_res_pkt.gfx_hqd_mask[1] =3D 0;

FWIW, I think this should work on pipe1.  Might be worth playing with.
The attached patches should enable pipe1 for kernel queues similar to
gfx10.  Anyway, something for the future.
Patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
>         for (i =3D 0; i < MAX_SDMA_PIPES; i++)
>                 mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D mes->sdma_hqd_mas=
k[i];
> --
> 2.43.2
>

--000000000000de8a7906176b294c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-drm-amdgpu-gfx11-add-pipe1-hardware-support.patch"
Content-Disposition: attachment; 
	filename="0002-drm-amdgpu-gfx11-add-pipe1-hardware-support.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lvobvtqy0>
X-Attachment-Id: f_lvobvtqy0

RnJvbSA3OTM4MDZhMjA1YjQ4ZDEzMjg2MzUwNTFlYWM0OWY5MzU3ODg1YmNlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMTEgQXByIDIwMjQgMTc6MTY6MDkgLTA0MDAKU3ViamVjdDogW1BBVENI
IDIvMl0gZHJtL2FtZGdwdS9nZngxMTogYWRkIHBpcGUxIGhhcmR3YXJlIHN1cHBvcnQKCkVuYWJs
ZSBnZnggcGlwZTEgaGFyZHdhcmUgc3VwcG9ydC4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjExXzAuYyB8IDE0ICsrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dm
eF92MTFfMC5jCmluZGV4IDgxYTM1ZDBmMGE1OGUuLjM1NzgyOTAzNjY2MmUgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jCkBAIC01MSw2ICs1MSw3IEBACiAjaW5jbHVkZSAi
bWVzX3YxMV8wLmgiCiAKICNkZWZpbmUgR0ZYMTFfTlVNX0dGWF9SSU5HUwkJMQorI2RlZmluZSBH
RlgxMV9OVU1fR0ZYX1JJTkdTXzIJCTIKICNkZWZpbmUgR0ZYMTFfTUVDX0hQRF9TSVpFCTIwNDgK
IAogI2RlZmluZSBSTENHX1VDT0RFX0xPQURJTkdfU1RBUlRfQUREUkVTUwkweDAwMDAyMDAwTApA
QCAtMTM0Miw3ICsxMzQzLDcgQEAgc3RhdGljIGludCBnZnhfdjExXzBfc3dfaW5pdCh2b2lkICpo
YW5kbGUpCiAJY2FzZSBJUF9WRVJTSU9OKDExLCAwLCAyKToKIAljYXNlIElQX1ZFUlNJT04oMTEs
IDAsIDMpOgogCQlhZGV2LT5nZngubWUubnVtX21lID0gMTsKLQkJYWRldi0+Z2Z4Lm1lLm51bV9w
aXBlX3Blcl9tZSA9IDE7CisJCWFkZXYtPmdmeC5tZS5udW1fcGlwZV9wZXJfbWUgPSAyOwogCQlh
ZGV2LT5nZngubWUubnVtX3F1ZXVlX3Blcl9waXBlID0gMTsKIAkJYWRldi0+Z2Z4Lm1lYy5udW1f
bWVjID0gMjsKIAkJYWRldi0+Z2Z4Lm1lYy5udW1fcGlwZV9wZXJfbWVjID0gNDsKQEAgLTQ3MTQs
NyArNDcxNSwxNiBAQCBzdGF0aWMgaW50IGdmeF92MTFfMF9lYXJseV9pbml0KHZvaWQgKmhhbmRs
ZSkKIAogCWFkZXYtPmdmeC5mdW5jcyA9ICZnZnhfdjExXzBfZ2Z4X2Z1bmNzOwogCi0JYWRldi0+
Z2Z4Lm51bV9nZnhfcmluZ3MgPSBHRlgxMV9OVU1fR0ZYX1JJTkdTOworCXN3aXRjaCAoYW1kZ3B1
X2lwX3ZlcnNpb24oYWRldiwgR0NfSFdJUCwgMCkpIHsKKwljYXNlIElQX1ZFUlNJT04oMTEsIDAs
IDApOgorCWNhc2UgSVBfVkVSU0lPTigxMSwgMCwgMik6CisJY2FzZSBJUF9WRVJTSU9OKDExLCAw
LCAzKToKKwkJYWRldi0+Z2Z4Lm51bV9nZnhfcmluZ3MgPSBHRlgxMV9OVU1fR0ZYX1JJTkdTXzI7
CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCWFkZXYtPmdmeC5udW1fZ2Z4X3JpbmdzID0gR0ZYMTFf
TlVNX0dGWF9SSU5HUzsKKwkJYnJlYWs7CisJfQogCWFkZXYtPmdmeC5udW1fY29tcHV0ZV9yaW5n
cyA9IG1pbihhbWRncHVfZ2Z4X2dldF9udW1fa2NxKGFkZXYpLAogCQkJCQkgIEFNREdQVV9NQVhf
Q09NUFVURV9SSU5HUyk7CiAKLS0gCjIuNDQuMAoK
--000000000000de8a7906176b294c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-drm-amdgpu-gfx11-select-HDP-ref-mask-according-to-gf.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-gfx11-select-HDP-ref-mask-according-to-gf.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lvobvtrh1>
X-Attachment-Id: f_lvobvtrh1

RnJvbSAxOWYwNDA4MzQ3YmYxYjdiN2QxNTI4MGUxYmY3MjMwMDU0ZmM2MWQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5j
b20+CkRhdGU6IFRodSwgMTEgQXByIDIwMjQgMTc6MTM6MTMgLTA0MDAKU3ViamVjdDogW1BBVENI
IDEvMl0gZHJtL2FtZGdwdS9nZngxMTogc2VsZWN0IEhEUCByZWYvbWFzayBhY2NvcmRpbmcgdG8g
Z2Z4CiByaW5nIHBpcGUKClVzZSBjb3JyZWN0IHJlZi9tYXNrIGZvciBkaWZmZXJuZW50IGdmeCBy
aW5nIHBpcGUuIFBvcnRlZCBmcm9tClpoZW5HdW8ncyBwYXRjaCBmb3IgZ2Z4MTAuCgpTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMV8wLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjExXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2dmeF92MTFfMC5jCmluZGV4IGFkNjQzMTAxM2M3MzguLjgxYTM1ZDBmMGE1OGUgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jCkBAIC01MjkzLDcgKzUyOTMsNyBAQCBzdGF0
aWMgdm9pZCBnZnhfdjExXzBfcmluZ19lbWl0X2hkcF9mbHVzaChzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcpCiAJCX0KIAkJcmVnX21lbV9lbmdpbmUgPSAwOwogCX0gZWxzZSB7Ci0JCXJlZl9hbmRf
bWFzayA9IG5iaW9faGZfcmVnLT5yZWZfYW5kX21hc2tfY3AwOworCQlyZWZfYW5kX21hc2sgPSBu
YmlvX2hmX3JlZy0+cmVmX2FuZF9tYXNrX2NwMCA8PCByaW5nLT5waXBlOwogCQlyZWdfbWVtX2Vu
Z2luZSA9IDE7IC8qIHBmcCAqLwogCX0KIAotLSAKMi40NC4wCgo=
--000000000000de8a7906176b294c--
