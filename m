Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040C8C624D4
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 13:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7887F10ECEA;
	Tue,  1 Sep 2026 13:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E3Pk13l3";
	dkim-atps=neutral
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D527D10ECDA
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 13:31:02 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id
 46e09a7af769-7e9f4ab2a6fso387374a34.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 06:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788269462; cv=none;
 d=google.com; s=arc-20260327;
 b=XggP4Qr6yFEi5WUOylG9g2Ikq8z7cx7KANZ6NQkOyA+tuxo5Pse1Rn9tbXX204LezD
 R9Eq36hGllDwjsIwqUD7rwLEy3j5gB/zO9YMCuYlNuW2XKfX7/QMv/5LIk6nKQ40jYF0
 FeWPKUHRwc6tX2nFbE+tdxt4xIa2C3s46mmdmrQaA6ipoQYMahAqDwqcxIBSwDAm2z7x
 Tk5il0lXKst2XJnfqDTlYQ3UxOvMbVWtKFgqpTawg0Bne2ABBu6U8Y8WZOfUR+y3VHYp
 1cdO4o0G9S3ji5/7XXxrxwSVYHXJRYSyl260koPi9c8RJs/iAxuXv07ud8Bte622jyn1
 +wHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9b7Pj1pJkVxs/NieWcErHRBLPhgZnWVKVzNaNnuAMcI=;
 fh=+NDxSwRfOWwdlrdjbhsYG9i2gw8CI7ld18m3pbT4YNU=;
 b=F00Vk884QFZGPJBTW6KW+okKZVyZHIElRHlfC35DF5Wqi3JJZn/ZmHezRD/PmVAjlb
 lm3oxXU8GfbuRdFA5Uv9TrBaSqd2PLN+PrqMTy5gAbZ24mj8ayEZvxJini3tn4/K9evS
 vyGj4YCoTF+MtGZZSo+NL1RfC/RqIEMPsemI55TV3rTZQU1/MKM8F52KVbm86eaV3Dfr
 68DQ6XpJvsi+HWjjcDwV3NCT/p/05nnf/tvGGxbi0sFeCZKMa2oIuTo0rV93UpdT2DpD
 ckV+sUnn1zvd+Ospr9xB7/DuE6vvWrlSuZqUrKeIc+JJsegqzi3Ivt8SY1lOdrCZRTif
 H64g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788269462; x=1788874262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9b7Pj1pJkVxs/NieWcErHRBLPhgZnWVKVzNaNnuAMcI=;
 b=E3Pk13l3HDTiOTGh6JH4QFb7xiuMDMs3mBux+ex3k174W71fVO6cY5+e2M83yZgUwA
 Qt/WiXaEf2ar2ybBEuEu83pd463oyfIs+AYh4gzZTPyfszrruz3qYCnmGPg0p7cfeZ24
 zrvIkTVe9uFBdFqW7l+p0aQ+KaFI8SbHmP/Frk/IgmQfRR0dLz9/l28wES1lyma4xsAA
 6WhA9bIH0si8Z+qOA8W1kwEeOU5OrKvQV0YqHIbz6c34P03Wzp6Wi5gS9NC29iII9ntz
 pNdLz3dpXjMN6EzNz9lKHsX8A2opamA0ZEXsDhVG+CLnzG4+ADg3TpucolMovluScQEP
 3DCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788269462; x=1788874262;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9b7Pj1pJkVxs/NieWcErHRBLPhgZnWVKVzNaNnuAMcI=;
 b=omx+kLwqJqe3kwDyEHx17FHGXnnbtVJPwtwgqgsU0/Stcdglvo6E7NXZvctp5/UXnu
 Y1AP7XzUaG2VuW9EEAKcrXxdoMYHZuOhxRomkcUh4Jk/fAPa78ajGMJ6QdkfXrajAzXS
 riXggpnibnDzT+87i7rmYrmlrMxDqQXlqAKbMhksX/AoLI3/VnzTlanb4JhKFX+Yos20
 jLUwryRAmjczaPna9LoH620mEfnj0xm+OQECNFKg02rmSPbEksKGiNcX01NgwqjYEBIi
 l8jnuaWn3nL06XCOYQbuuhuk2CNTQ5THZiczsZsC09f8hmkHlz9wfFkSnD+Vyt3zzfXY
 zIgQ==
X-Gm-Message-State: AFuF++mY56eJTE1+IPWFcmM2SjAth2K21MTGpOSbYr7oOTQB3zUY2nrz
 5L2WnhbjU+D4EiOv5wm927zbj/ZE6Fw4FelUnHANRyANsMP/MRCzOq1YtWy/xraF6aMTDbrrXUM
 4/Bl7J7+/WF38w7N2nCo0XHRytpi8mzQ=
X-Gm-Gg: AR+sD13Q6Z905sxkCv4MB0nI8xmKza5IRPNFx6TlXMxzDwxlqdQiN68uHiN/eibcWJ2
 SFkahx4mdibGJmo2tdKJ46CegieVc/xHU30qGXhOe0y2UrLlZax6I2lGummqgMbTqjfq9bqe/le
 KntUbgH/WuFNtZcH72qyhXIo/A92bHPH/bdb0v4sRKPEekL3jvNZPqJXaDEA5KlYCk995aNzKWE
 BIBxJptO190Bo69mZRlbvgKqpaOecEOb0yMfOj3mpl0HENvsJI73h2d1inOMFUYSn8upVp7lRs8
 n6xeNgMeQ9rXxhfA1Km3qAS02Pr7jFpFP4//l/gCj8b1GAnIBItlaY0zbTbn+MDAaGp0RIZNtkE
 CgZhIT6fbvC+n6WT0reCDs6AdGAXy+wY=
X-Received: by 2002:a05:6808:1a20:b0:496:7c2:46e5 with SMTP id
 5614622812f47-4b55be62db2mr9909925b6e.0.1788269461724; Tue, 01 Sep 2026
 06:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260901061908.3881527-1-lijo.lazar@amd.com>
In-Reply-To: <20260901061908.3881527-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Sep 2026 09:30:49 -0400
X-Gm-Features: AcwNN1V8R-3xdyaUgREzzGYLVoD77X6FZlxO1qkZfQcdQ6JV35D5zensPEX8CnY
Message-ID: <CADnq5_PZf3ijSgaoyNxNKgBOYSBf55_nmVMRwU0A+mNGaAhzLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove gfxoff calls in GC v12.1
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Le.Ma@amd.com
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

On Tue, Sep 1, 2026 at 2:55=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> The calls are redundant as GFXOFF is not there on GC v12.1.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index d60cd64d444e..937fe1f1897e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1384,7 +1384,6 @@ static void gfx_v12_1_ip_dump(struct amdgpu_ip_bloc=
k *ip_block)
>
>         num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
>
> -       amdgpu_gfx_off_ctrl(adev, false);
>         for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
>                 xcc_offset =3D xcc_id * reg_count;
>                 for (i =3D 0; i < reg_count; i++)
> @@ -1392,7 +1391,6 @@ static void gfx_v12_1_ip_dump(struct amdgpu_ip_bloc=
k *ip_block)
>                                 RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg=
_list_12_1[i],
>                                                                    GET_IN=
ST(GC, xcc_id)));
>         }
> -       amdgpu_gfx_off_ctrl(adev, true);
>
>         /* dump compute queue registers for all instances */
>         if (!adev->gfx.ip_dump_compute_queues)
> @@ -1401,7 +1399,7 @@ static void gfx_v12_1_ip_dump(struct amdgpu_ip_bloc=
k *ip_block)
>         num_inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_m=
ec *
>                 adev->gfx.mec.num_queue_per_pipe;
>         reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> -       amdgpu_gfx_off_ctrl(adev, false);
> +
>         mutex_lock(&adev->srbm_mutex);
>         for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
>                 xcc_offset =3D xcc_id * reg_count * num_inst;
> @@ -1428,7 +1426,6 @@ static void gfx_v12_1_ip_dump(struct amdgpu_ip_bloc=
k *ip_block)
>         }
>         soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
>         mutex_unlock(&adev->srbm_mutex);
> -       amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
> @@ -3310,20 +3307,7 @@ static void gfx_v12_cntl_pg(struct amdgpu_device *=
adev, bool enable)
>  static int gfx_v12_1_set_powergating_state(struct amdgpu_ip_block *ip_bl=
ock,
>                                            enum amd_powergating_state sta=
te)
>  {
> -       struct amdgpu_device *adev =3D ip_block->adev;
> -       bool enable =3D (state =3D=3D AMD_PG_STATE_GATE);
> -
> -       if (amdgpu_sriov_vf(adev))
> -               return 0;
> -
> -       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> -       case IP_VERSION(12, 1, 0):
> -               amdgpu_gfx_off_ctrl(adev, enable);
> -               break;
> -       default:
> -               break;
> -       }
> -
> +       /* No powergating state for GC v12.1 */
>         return 0;
>  }
>
> --
> 2.49.0
>
