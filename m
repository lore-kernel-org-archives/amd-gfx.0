Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D72EE49AD
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 22:47:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D97110E00B;
	Tue,  5 Sep 2023 22:47:04 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F5710E00B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 22:47:03 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3a76d882080so2379057b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693954022; x=1694558822; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+x8OIWdF1eZX00Tf8HJQUWlNTZnJV4hTCB5eoHXTd0=;
 b=KndOXfWgberRgPeQaypkt3RXDt7Lk59jQkbWC87Ib3ipZDW2ZiaO58WAWgIL1IXK6o
 55rtjzzIAMO0o70kEwC/JqtVSFSsff6LffXsFwnSxzXjdfsuaXv+SLWyUyvEHvNfnNjd
 5ZDycAIjQNLZyz++dMnL5z1sw3da9V4RAfEs0xBBmovabZ603Bt9JklFYKjsh1F66RH/
 TEtDDrQzoK9GSfzOQeUMNvJjos+pN03bUMbBPVoUvXLSdqle5lOkxNckP2Txev9O9XA1
 fEvmhi/9xy5Bx7jZk2UGXr5fzh1loMON92XLe0MDmGfHc93z99UsXVtDLWotIutYZma6
 U1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693954022; x=1694558822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+x8OIWdF1eZX00Tf8HJQUWlNTZnJV4hTCB5eoHXTd0=;
 b=dIN89k+iE/b/tFUs0EqXR1xXKqHku7BaHXTIiHONE5SKAxgWBfJjjihNDt/r0Na/tN
 ezQ+SbKl04WpoRVtFw0HFM/MY8Vg2LUSdOlVWVTd1hHolvfU9cXK3XLioHq6Ec5Iwur1
 pK2e/iXhTppg9QiSAImEJN3HMO+z0LwAHMEo+Q3ZS+korc+xmwPTaNJWV7wrAcN5Vh2H
 fBo5NadLH8czo7Mn1l07UamGWWDKn7Br2W3phrQSBYiuAJOUkglcGDg83FHTjau0441V
 SHFxpbcIbKxqyzYUpisknjPNVTDnqlr/1BsdU5SDo7pmeZEK4wuHbsRsMj0x0ZH/To0N
 bvwQ==
X-Gm-Message-State: AOJu0YxXL3jjHEPhHGcdzOoFut/+aHcWeiNRzprNiWhaHloXMncQLUl8
 dbsxfiR+VZ2TPMoYsv5FwkMfoUVn+Gd1/yZ80NY=
X-Google-Smtp-Source: AGHT+IGHwcO0IypPpbEQ/6prMrPChfH0op/bNU42a9m8UykphaAsMU3UHn6B+WyjBzu3UDmCPElZuFJjZtJ6i6RLkHM=
X-Received: by 2002:a05:6808:10c8:b0:3a8:6abe:8380 with SMTP id
 s8-20020a05680810c800b003a86abe8380mr20420238ois.53.1693954022365; Tue, 05
 Sep 2023 15:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-8-christian.koenig@amd.com>
In-Reply-To: <20230905060415.1400-8-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 18:46:51 -0400
Message-ID: <CADnq5_NMr1SHCW-ku3S=RUuW_4ZKGAO7cPjSWL=pndXkiKJ9vw@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amdgpu: cleanup gmc_v10_0_flush_gpu_tlb_pasid
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

On Tue, Sep 5, 2023 at 2:15=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> The same PASID can be used by more than one VMID, reset each of them.
>
> Use the common KIQ handling.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 66 ++++++++------------------
>  1 file changed, 19 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 1f70c57bcd69..407ddb926941 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -341,57 +341,27 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amd=
gpu_device *adev,
>                                         uint16_t pasid, uint32_t flush_ty=
pe,
>                                         bool all_hub, uint32_t inst)
>  {
> +       uint16_t queried;
>         int vmid, i;
> -       signed long r;
> -       uint32_t seq;
> -       uint16_t queried_pasid;
> -       bool ret;
> -       u32 usec_timeout =3D amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :=
 adev->usec_timeout;
> -       struct amdgpu_ring *ring =3D &adev->gfx.kiq[0].ring;
> -       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> -
> -       if (amdgpu_emu_mode =3D=3D 0 && ring->sched.ready) {
> -               spin_lock(&adev->gfx.kiq[0].ring_lock);
> -               /* 2 dwords flush + 8 dwords fence */
> -               amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + =
8);
> -               kiq->pmf->kiq_invalidate_tlbs(ring,
> -                                       pasid, flush_type, all_hub);
> -               r =3D amdgpu_fence_emit_polling(ring, &seq, MAX_KIQ_REG_W=
AIT);
> -               if (r) {
> -                       amdgpu_ring_undo(ring);
> -                       spin_unlock(&adev->gfx.kiq[0].ring_lock);
> -                       return -ETIME;
> -               }
> -
> -               amdgpu_ring_commit(ring);
> -               spin_unlock(&adev->gfx.kiq[0].ring_lock);
> -               r =3D amdgpu_fence_wait_polling(ring, seq, usec_timeout);
> -               if (r < 1) {
> -                       dev_err(adev->dev, "wait for kiq fence error: %ld=
.\n", r);
> -                       return -ETIME;
> -               }
> -
> -               return 0;
> -       }
>
>         for (vmid =3D 1; vmid < AMDGPU_NUM_VMID; vmid++) {
> -
> -               ret =3D gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, v=
mid,
> -                               &queried_pasid);
> -               if (ret && queried_pasid =3D=3D pasid) {
> -                       if (all_hub) {
> -                               for_each_set_bit(i, adev->vmhubs_mask, AM=
DGPU_MAX_VMHUBS)
> -                                       gmc_v10_0_flush_gpu_tlb(adev, vmi=
d,
> -                                                       i, flush_type);
> -                       } else {
> -                               gmc_v10_0_flush_gpu_tlb(adev, vmid,
> -                                               AMDGPU_GFXHUB(0), flush_t=
ype);
> -                       }
> -                       if (!adev->enable_mes)
> -                               break;
> +               bool valid;
> +
> +               valid =3D gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev,=
 vmid,
> +                                                                 &querie=
d);
> +               if (!valid || queried !=3D pasid)
> +                       continue;
> +
> +               if (all_hub) {
> +                       for_each_set_bit(i, adev->vmhubs_mask,
> +                                        AMDGPU_MAX_VMHUBS)
> +                               gmc_v10_0_flush_gpu_tlb(adev, vmid, i,
> +                                                       flush_type);
> +               } else {
> +                       gmc_v10_0_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB=
(0),
> +                                               flush_type);
>                 }
>         }
> -
>         return 0;
>  }
>
> @@ -1009,8 +979,10 @@ static int gmc_v10_0_gart_enable(struct amdgpu_devi=
ce *adev)
>
>  static int gmc_v10_0_hw_init(void *handle)
>  {
> -       int r;
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       int r;
> +
> +       adev->gmc.flush_pasid_uses_kiq =3D !amdgpu_emu_mode;
>
>         /* The sequence of these two function calls matters.*/
>         gmc_v10_0_init_golden_registers(adev);
> --
> 2.34.1
>
