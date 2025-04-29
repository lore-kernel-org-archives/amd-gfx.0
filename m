Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C3BC3ABA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 13:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BD0810E42D;
	Tue, 29 Apr 2025 13:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RYE9DiXA";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7413510E42D
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 13:23:59 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-22de5af5e14so1717175ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 06:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745933039; x=1746537839; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOqmLxP5QGfEA6PLbhoLbFkRpBu4wxIuEa3b8ooDOj8=;
 b=RYE9DiXA59hW4qpPBZWYoGSO3BM+3jwFbakVvVqbq+4MKO6CrHneafJt82EfbSI+mi
 Ay44e4VPtC7EfRkbCxR1uoJ6NKlOHbXPH/a87zkW2zZJaUoRsxjtN6tL72GEvGyjgUUu
 FVsMGpO8DwII7vth7s+RsGJxSSjKp26xWGYmuKyTy2wRQgpq6f/3gJ77tTyde4yc+WzV
 KukIGA4vKsA5KbFNqOCNG5QyH3XdPY1ZoaPiaEY46Vn75ii/s4X02TJ2ZQI9LVPuTSo5
 P+hYed51ulkuuqjsEpYwX+zD8W8GVWS0fu9VzhKSLHQ5wCLPNOEPB2Zso5N6Nw5Fp43A
 XvGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933039; x=1746537839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOqmLxP5QGfEA6PLbhoLbFkRpBu4wxIuEa3b8ooDOj8=;
 b=fLNn0skdTxsaOOLXXXs9XAhLyQsGcvQVqXfiVrbXlMA9yiv3umu6QOZC9vvUJYxKKV
 +CbvIHNXTz91WdaXWAqmhfMBOz7Qx8bk99aSWvWgrbSSLszjJBVOIvQ5LENuDElwPSs6
 UObrzOvrll0kxnjXtUVLAv7OR2vLchk+d5SbvGSbL0Yy7gPW0UeJkGqA6iSpX9kO2cv6
 huExnFL8yHJm/lHoKRaoa5JreJec6gPy01KTucrkiene/QQAzzHxiTQm/DQJXCZ/bpJH
 kITTGn71bBxw2T2wnc0+agN8a2Ml6wDEOhCjugJTXPEeRNFXVAFiwA8zBAGqlUvxe7Ag
 gDlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdQXVhjLGOUeHTnzvtR1+QkSshXH4CYHmhuit3xVyUcpFCqmQ1Fm3OKppndK8VSMHJPoxE/QKv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRbFf0m0AGvMeE/8NfnWA/mBPe4JjGvQocPh1JLWcO87ems3PS
 kgcvw6TUH5Yki8P27mh1oDGpwRWfJ17/qf+R9kjHXpP0pMXTA6a8lmAzjqxEAesYQfoOS0T1jzM
 6iVoNU4pCQ6k2Hsm+5TCQRplfpdSQ8Q==
X-Gm-Gg: ASbGncvx2V4y791to7NbaGFB4yvcYSp5DPGwDUdztEa5EO6bCQROawHev5gEbYDo6Kk
 0I9s+mj35tW/TBeYM4JeEKwAUTYML8LvqEgdpoLLLu4sCJvawZn02LR31urdS9nfAEHc/6YnEC8
 O5IozWBR4KYJKPDb6TG4wXEQ==
X-Google-Smtp-Source: AGHT+IGMrIC3d3/fGNTEwtZmuxx2V+IX0AFaLBWEh7qjX2knZgqXuh2uZdCbyINkelEJD1c2sSK0TLrhF9Nhmzn1ZfU=
X-Received: by 2002:a17:903:3c4d:b0:220:e98e:4f17 with SMTP id
 d9443c01a7336-22dbf5e798emr90275095ad.2.1745933038873; Tue, 29 Apr 2025
 06:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250429102954.3913983-1-ray.huang@amd.com>
 <20250429102954.3913983-2-ray.huang@amd.com>
In-Reply-To: <20250429102954.3913983-2-ray.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Apr 2025 09:23:45 -0400
X-Gm-Features: ATxdqUFhoyje_PSNhMTpxcrBis1c1AtHUkFe4lYopk34ACGTqnH2VTgkaE5-pi8
Message-ID: <CADnq5_PRddthrN+PXgBWVLuxvQ1SKB8n7BT7La8eBKgizvinGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup sriov function for psp v12
To: Huang Rui <ray.huang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Trigger Huang <Trigger.Huang@amd.com>, 
 Zhu Lingshan <lingshan.zhu@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Apr 29, 2025 at 6:30=E2=80=AFAM Huang Rui <ray.huang@amd.com> wrote=
:
>
> PSP v12 won't have SRIOV function.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v12_0.c | 52 +++++++++-----------------
>  1 file changed, 17 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/psp_v12_0.c
> index ed24f61e1ab8..80153f837470 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
> @@ -147,41 +147,23 @@ static int psp_v12_0_ring_create(struct psp_context=
 *psp,
>         struct psp_ring *ring =3D &psp->km_ring;
>         struct amdgpu_device *adev =3D psp->adev;
>
> -       if (amdgpu_sriov_vf(psp->adev)) {
> -               /* Write low address of the ring to C2PMSG_102 */
> -               psp_ring_reg =3D lower_32_bits(ring->ring_mem_mc_addr);
> -               WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, psp_ring_reg);
> -               /* Write high address of the ring to C2PMSG_103 */
> -               psp_ring_reg =3D upper_32_bits(ring->ring_mem_mc_addr);
> -               WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_103, psp_ring_reg);
> -
> -               /* Write the ring initialization command to C2PMSG_101 */
> -               WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
> -                                            GFX_CTRL_CMD_ID_INIT_GPCOM_R=
ING);
> -
> -               /* Wait for response flag (bit 31) in C2PMSG_101 */
> -               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_=
SMN_C2PMSG_101),
> -                                  0x80000000, 0x8000FFFF, false);
> -
> -       } else {
> -               /* Write low address of the ring to C2PMSG_69 */
> -               psp_ring_reg =3D lower_32_bits(ring->ring_mem_mc_addr);
> -               WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, psp_ring_reg);
> -               /* Write high address of the ring to C2PMSG_70 */
> -               psp_ring_reg =3D upper_32_bits(ring->ring_mem_mc_addr);
> -               WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, psp_ring_reg);
> -               /* Write size of ring to C2PMSG_71 */
> -               psp_ring_reg =3D ring->ring_size;
> -               WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_71, psp_ring_reg);
> -               /* Write the ring initialization command to C2PMSG_64 */
> -               psp_ring_reg =3D ring_type;
> -               psp_ring_reg =3D psp_ring_reg << 16;
> -               WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
> -
> -               /* Wait for response flag (bit 31) in C2PMSG_64 */
> -               ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_=
SMN_C2PMSG_64),
> -                                  0x80000000, 0x8000FFFF, false);
> -       }
> +       /* Write low address of the ring to C2PMSG_69 */
> +       psp_ring_reg =3D lower_32_bits(ring->ring_mem_mc_addr);
> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_69, psp_ring_reg);
> +       /* Write high address of the ring to C2PMSG_70 */
> +       psp_ring_reg =3D upper_32_bits(ring->ring_mem_mc_addr);
> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_70, psp_ring_reg);
> +       /* Write size of ring to C2PMSG_71 */
> +       psp_ring_reg =3D ring->ring_size;
> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_71, psp_ring_reg);
> +       /* Write the ring initialization command to C2PMSG_64 */
> +       psp_ring_reg =3D ring_type;
> +       psp_ring_reg =3D psp_ring_reg << 16;
> +       WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64, psp_ring_reg);
> +
> +       /* Wait for response flag (bit 31) in C2PMSG_64 */
> +       ret =3D psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PM=
SG_64),
> +                          0x80000000, 0x8000FFFF, false);
>
>         return ret;
>  }
> --
> 2.25.1
>
