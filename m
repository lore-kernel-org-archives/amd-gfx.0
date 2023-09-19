Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05569CE79A9
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 20:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F3A10E0F1;
	Tue, 19 Sep 2023 20:02:17 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347E310E0F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 20:02:15 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5731fe1d2bfso3241664eaf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695153734; x=1695758534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pd7Bm/mECUaszLIcSb3ljtyhi/NDj2DOhZUW3t3Zn4=;
 b=LQGNhfH1+Dl3akyCtc7vJz779MPoMfc5drmuJRs/Q5DcJP/ioegKJpPHyxySyLzU8c
 GvUq48QSmrgfMFjLklo5yM43f62a6DChjz0rsDCUXXKrCSEZVEeLSJp8rfwGpkSSsn61
 vtO0TblDM4zu0JHGoSiYZcCQBMIM8FLSQgi7iU698aTBRLAPrPW2H/IIdUKffM1bs36s
 VwhuEB9sWffPn56W8ynCfWMrL2wUc+KD5pkcTe2b6BBWaCcTaX1z9YTbakIotCd09/Ls
 iEANfOKvXhGuSiMDIZRWGTBRA4tOXWs4V/k3NtT4jRIsqgprHcqpMKtjd75zt+I811FS
 W5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695153734; x=1695758534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4pd7Bm/mECUaszLIcSb3ljtyhi/NDj2DOhZUW3t3Zn4=;
 b=bCNGs0Dg8pKYN6EJ9EsBjInQ/Kwnnv7zaQQkQ8jBsmRdsRHPQI9+dh6SirmKJNFzjG
 0T9IbWm6xPi9KzQiIe5r7EszYFoOHHdkL1vOMbir3CnP48l2b1FE7DTcOXeR8Y0aVbgi
 oFJvzKXTHA7mzZYAGyAVP7cKntAxwhSewotYGweLtHp7XaEKvFq1LAUijkUScxiKJ8Yb
 /ZkxRXVqwiSB7OuVyM4AmIfDdPJlf7sS4LK/yJC0SDNK8CztX65GvNd5uDcoXLyXoIba
 1VE5/T07l+Jz1XLKgbquNk6oaSDxe90Q3/OmzdQJOU9WLdTR9N7d0hJWEEJq4KyMNKed
 iwdQ==
X-Gm-Message-State: AOJu0Yx6Mas0whOM/ko1g9emz6QyK6qkcYsy3+spXHWhP5L3PGyL0nIf
 csnXRb9rsqchZpDvg0C6zVoTzwWNIr5cbU593KQ=
X-Google-Smtp-Source: AGHT+IGXs5kSVuBg8fWCmIXloN5rx5l4qaC+KOTEgY+MzsuCmSyEDJh5WVIdnCL9sR3F2wzb2mcejKwjzhvF/4y1eow=
X-Received: by 2002:a05:6870:a105:b0:1d0:f5bd:6e9 with SMTP id
 m5-20020a056870a10500b001d0f5bd06e9mr519698oae.22.1695153734261; Tue, 19 Sep
 2023 13:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230919120822.95241-1-christian.koenig@amd.com>
In-Reply-To: <20230919120822.95241-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Sep 2023 16:02:02 -0400
Message-ID: <CADnq5_M2FL4O2ZX2E41vBRxJz9TYBdTDMnwVvT8m1ZJmPhSHzw@mail.gmail.com>
Subject: Re: [PATCH 01/11] drm/amdgpu: fix and cleanup gmc_v9_0_flush_gpu_tlb
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 19, 2023 at 8:08=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The KIQ code path was ignoring the second flush. Also avoid long lines an=
d
> re-calculating the register offsets over and over again.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 29 +++++++++++++++++----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 2936a0fb7527..0f82ab48887a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -816,13 +816,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_de=
vice *adev, uint32_t vmid,
>                                         uint32_t vmhub, uint32_t flush_ty=
pe)
>  {
>         bool use_semaphore =3D gmc_v9_0_use_invalidate_semaphore(adev, vm=
hub);
> +       u32 j, inv_req, inv_req2, tmp, sem, req, ack;
>         const unsigned int eng =3D 17;
> -       u32 j, inv_req, inv_req2, tmp;
>         struct amdgpu_vmhub *hub;
>
>         BUG_ON(vmhub >=3D AMDGPU_MAX_VMHUBS);
>
>         hub =3D &adev->vmhub[vmhub];
> +       sem =3D hub->vm_inv_eng0_sem + hub->eng_distance * eng;
> +       req =3D hub->vm_inv_eng0_req + hub->eng_distance * eng;
> +       ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
>         if (adev->gmc.xgmi.num_physical_nodes &&
>             amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 0=
)) {
>                 /* Vega20+XGMI caches PTEs in TC and TLB. Add a
> @@ -854,6 +858,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>
>                 amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_re=
q,
>                                                    1 << vmid);
> +               if (inv_req2)
> +                       amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack=
,
> +                                                          inv_req2, 1 <<=
 vmid);
> +
>                 up_read(&adev->reset_domain->sem);
>                 return;
>         }
> @@ -872,9 +880,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>                 for (j =3D 0; j < adev->usec_timeout; j++) {
>                         /* a read return value of 1 means semaphore acqui=
re */
>                         if (vmhub >=3D AMDGPU_MMHUB0(0))
> -                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, hub=
->vm_inv_eng0_sem + hub->eng_distance * eng);
> +                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, sem=
);
>                         else
> -                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, hub->v=
m_inv_eng0_sem + hub->eng_distance * eng);
> +                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, sem);
>                         if (tmp & 0x1)
>                                 break;
>                         udelay(1);
> @@ -886,9 +894,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>
>         do {
>                 if (vmhub >=3D AMDGPU_MMHUB0(0))
> -                       WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_re=
q + hub->eng_distance * eng, inv_req);
> +                       WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
>                 else
> -                       WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req +=
 hub->eng_distance * eng, inv_req);
> +                       WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
>
>                 /*
>                  * Issue a dummy read to wait for the ACK register to
> @@ -897,14 +905,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_de=
vice *adev, uint32_t vmid,
>                  */
>                 if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &&
>                     (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, =
4, 2)))
> -                       RREG32_NO_KIQ(hub->vm_inv_eng0_req +
> -                                     hub->eng_distance * eng);
> +                       RREG32_SOC15_IP_NO_KIQ(GC, req);
>
>                 for (j =3D 0; j < adev->usec_timeout; j++) {
>                         if (vmhub >=3D AMDGPU_MMHUB0(0))
> -                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, hub=
->vm_inv_eng0_ack + hub->eng_distance * eng);
> +                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, ack=
);
>                         else
> -                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, hub->v=
m_inv_eng0_ack + hub->eng_distance * eng);
> +                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, ack);
>                         if (tmp & (1 << vmid))
>                                 break;
>                         udelay(1);
> @@ -921,9 +928,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>                  * write with 0 means semaphore release
>                  */
>                 if (vmhub >=3D AMDGPU_MMHUB0(0))
> -                       WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_se=
m + hub->eng_distance * eng, 0);
> +                       WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
>                 else
> -                       WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem +=
 hub->eng_distance * eng, 0);
> +                       WREG32_SOC15_IP_NO_KIQ(GC, sem, 0);
>         }
>
>         spin_unlock(&adev->gmc.invalidate_lock);
> --
> 2.34.1
>
