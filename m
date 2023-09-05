Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62FBCA100E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 20:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F0E110E511;
	Tue,  5 Sep 2023 20:46:08 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D693510E511
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 20:46:05 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57325fcd970so1842861eaf.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693946765; x=1694551565; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wqpjwkvc/VyR45JuNKy6svbgiknMW28iQgRQOh1ZTNo=;
 b=b3/v5O77U8QGIi72S3YT1iNR+axo5PcSy7bkGSQ2PdhtwILBJYz9SOrqI+dC9iP4tQ
 pSiUF9fByHHbhv5ladMccgCLSMudH5Jk2XNrPWh3vwHwSwbqpYPGXK5xfTTvO3fnp7xE
 K1QkpbMGB22+ISiHQR1FXgsVOGOu1ogfH+CY1Bhgc2dVfOaVkTNKk0+WXs3idHdRJX/N
 kR+5MrmB9BSwmof4LeIEY3Jk3KyE3eOphr1EwUB0MZT1jfZFm4bEHBwRhG1cx4vBMHW3
 4ACmFXypOTZ3tQia/WRTjVQ/r6OA+9l7NKBzZxKZVgpTMtmTSl/GQinHpzMlYE/JTT09
 058A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693946765; x=1694551565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wqpjwkvc/VyR45JuNKy6svbgiknMW28iQgRQOh1ZTNo=;
 b=AiBWMA/zOARly+9vBuyt3AKIlteYmaQgIcNbKNfb1kC+wfT2GzJ7UYjwzEmrGMCMaw
 LrnzDMiH6BsNcPBXTojOdYpddmAGPBMlB0RJsIjs/AvpeAhrsxwH5ZiTJs1nGnEy+n15
 KIE8JGK4yM5ktTCi87WBdJB6La4DnhpjFh6o4npzYzMtI04TCehT9uxcGCB1GDtnXuPx
 ZzgF8VZPkcmhJ08Rp8tZWS+3JHubDhhh0aAucYTRR3Cf7/360vcr5epw0qx1EDcOak0C
 PWD7DGE6I+E69ob1XdyG5YdBboWsBk3Zh0fx9RCT5ofIDq9VSXVi8YrY7fAcakv5mU29
 jX3g==
X-Gm-Message-State: AOJu0YyhJihuYYAnsHoxorZsxoyZN5oAI7Bpi/XUDNxiHTEFCabejYmh
 CghvSbU9/lYDWRctz5Dr8RgF9MH9u7kkzTKWuJE=
X-Google-Smtp-Source: AGHT+IGZMRT5uHUg8ZBQN+04W7yh87M4R2FLC5iItDioYo0/iSsauhHtzA4MGcCeyzQqRvKHBTP9cxxPrwCyB7Kj4PM=
X-Received: by 2002:a05:6808:168d:b0:3a4:8a13:98a5 with SMTP id
 bb13-20020a056808168d00b003a48a1398a5mr19180216oib.16.1693946764917; Tue, 05
 Sep 2023 13:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-2-christian.koenig@amd.com>
In-Reply-To: <20230905060415.1400-2-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 16:45:53 -0400
Message-ID: <CADnq5_Mu9mNohqHNA=k0pjn0vPY4aXd5T+sR4o0GCkGt_TSqvQ@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 5, 2023 at 3:00=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The KIQ code path was ignoring the second flush. Also avoid long lines an=
d
> re-calculating the register offsets over and over again.

I'd split this into two patches, one for the code cleanup and one to
fix the missing flush.

Alex

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 29 +++++++++++++++++----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 0673cda547bb..4f6990ba71cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -814,13 +814,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_de=
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
>             adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 0)) {
>                 /* Vega20+XGMI caches PTEs in TC and TLB. Add a
> @@ -852,6 +856,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_dev=
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
> @@ -870,9 +878,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
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
> @@ -884,9 +892,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
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
> @@ -895,14 +903,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_de=
vice *adev, uint32_t vmid,
>                  */
>                 if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &&
>                     (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2))=
)
> -                       RREG32_NO_KIQ(hub->vm_inv_eng0_req +
> -                                     hub->eng_distance * eng);
> +                       RREG32_NO_KIQ(req);
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
> @@ -919,9 +926,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
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
