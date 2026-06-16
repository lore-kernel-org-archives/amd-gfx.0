Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31231CD98E1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 21:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C350C10E8A9;
	Tue, 16 Jun 2026 21:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMx8UvlW";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E5F10E8A9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 21:48:29 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-137eb8e3491so139589c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 14:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781646509; cv=none;
 d=google.com; s=arc-20240605;
 b=aVUzC3TsF971AogQDCmopwLTLEfBmcVesQkpqyUqrfih+4jTpipJNBhilDJ6MfXw1s
 Apzu+/6E2BAXC88P6I1WFZtsJBoLFXeyDKComImxwcH50DqbGXjBmRMqKQk8ebXYqpqC
 dODgEH9DdKYDHvSq1dh2SwvCACfP6xlAHewq4x9xNzJgCtUPPoztPd/QtqQeGi2Tvh/X
 AbjX92UQX1TAY16GGYaE+9Jv2qkMW4WcsCTskaLR6gWFKY9KpJ1nQMJKJuktxWKt2lQE
 9NodqPnQG+RwKvb0yQ1TNFFAMAn4KwMPNrZnmXTLpNKfUvYrkEr5HrIhiP7Gwz9luZ+B
 dHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3V33M2HouqBtPeJQ9c9v0cXZqPY8hz8+j7dLcVfKjJ4=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=IdlVMFqVXicWhbfyd/TvDKjiWA0KU1oOFWIZgTOKd1nYdsTDBzs8vtNLIzK4WR9zur
 +5diZhip5AwurT4jVDq17nUWH0eqnfdGh9MXRCV+Tjou60lzKWCrS9tAVNtmXE0+ebRN
 oyq9ERSBRTc+tkXZu+19W9mDIdzvqAeaqdTCCcccblvbD2RKIeS1zWoTss0/o167klFo
 m1bMLwDO6F2k4PjjB1zwUDuxTFPsSIJ9+jZQVArzPalds5vHiXO/ahR7Yy/aTyNMSCHS
 lYr4WdFhv0e/IHD7zyh6Qwi8fYYT+BHayV4oKTM/uOZqArS7OVj6ZtZdN/ZeyPEFiM9q
 Ku3w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781646509; x=1782251309; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3V33M2HouqBtPeJQ9c9v0cXZqPY8hz8+j7dLcVfKjJ4=;
 b=IMx8UvlW4iLECVvwKxGDJIwWC/0EFPJJeG5cmZPiUc39FGTkqzX6YJJVGL6L6OdfxQ
 rtP5DXLKs7pmGIH+7W1BWlxtxuLSg3GtVlRP/4vuNzSl0G4ozseRtaKfa9JDCiLc3ohZ
 SW0+IeG/rVK616iCVgIdIu5wjrD9CsNuMxg8+uoUP7BEHWDg9yV8EL0zIr5FgaUNPI9n
 xATIDQClgUTLiV7FCX5htOcHG4pWoYNdO3LZFg4Vw+fh2h4DVJpOfw79R9tpzYcxWDSV
 OyW4QbiBQpxt7OA8SlBsECjXX26LkgPz0evyrGfzW781E2cAUWnb2RF3rfuZszMQrO7V
 9O+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781646509; x=1782251309;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3V33M2HouqBtPeJQ9c9v0cXZqPY8hz8+j7dLcVfKjJ4=;
 b=MeDAz7bJuOzCcUV5R2X9CPOooD3vGSa0XswZTgspCYQAO0ByDrx7RH5hevh2g3xTVY
 LAVXMPigW8SLDD79QZqbeAb/YIeU5Z/PP7fH9Fz1MIClnj85pR9x39BtCn4vZ5V9herG
 tourbOSDP4SVRKcmMHsSdTc0tHvL/naySnHcEFUcW0utTdiUwF4vtnmh1B9BVZGVeIcd
 uplflqfdDgNBomWbiDoI43A8SRyEczETe2NOfcz3YBhNmhLTb19n++Mhp9K6cNxajn7y
 quOKIa7K6vmujbWURv/IOE6COlz1sxbk8dYa5FTdsJYBWWOGwnCbDRk4pRGfFPvMFjRv
 Gvqw==
X-Gm-Message-State: AOJu0Yx7+nc+1UyCsgAXCLkNo2nELwe0XCuxrvKy+svXPH+4pL5e67wM
 IgzG4oJV3McfQd/NBp1ZJY/QryVZanYAmvzwUXy/SXY3enzRlcuqm3U39d85+S2sDUIsPJpMkWi
 fyo2AXIkOQ0PKvtVIvnssr3ESUMfMSp4=
X-Gm-Gg: Acq92OGQo4svk/drMAENqla2lkcwB7XthIcm5Ze71lV9HfQA9iH5+uRDzHg95xYUHHS
 1T29feiDbQznb8Ebdegf49nMWJ5m01XFikx2mli8ladOrjBtHwcs8KmUw2U+YcYDuDuz23Hr6im
 nhKRJTYAZuJz43Tm5gz3mpfQpRMDGSI1tE8iId5QbPDnwaiQe3XdVzvizpjVoF3Ud+eDZO1+ei0
 MPZB+RPehoHu1DI4z0pRduWFqqaZ3ijPD708cLJpmvywou4RXoI0K3BcocVV7gSs/YQA98cxZD1
 JHcOEWZGXlDuNn17maOV75T3opX+NaE8IjEkpOinDXXMm7aLbDxQfQ9op6abRtuz7HK40g==
X-Received: by 2002:a05:7023:b06:b0:137:d966:d890 with SMTP id
 a92af1059eb24-1398f6ce9f3mr184043c88.7.1781646508706; Tue, 16 Jun 2026
 14:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260611035747.548780-1-Jesse.Zhang@amd.com>
 <20260611035747.548780-2-Jesse.Zhang@amd.com>
In-Reply-To: <20260611035747.548780-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Jun 2026 17:48:17 -0400
X-Gm-Features: AVVi8Cea56Muv1HIdGlJsnZ3oC4CWNY4XqmvhNAtR3G14LalIef7aXTQHb2WgJs
Message-ID: <CADnq5_NfxwDAP7B6wjpo7EOMOXW1ajO7LFAeVtwvrRAP=1jozQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] drm/amdgpu/gfx11: handle error interrupts for
 userqs
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Wed, Jun 10, 2026 at 11:58=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>

Once again, feel free to take ownership of these.  You did most of the work=
.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Call the new userq reset helper, and dispatch KQs first by ring_id
> before falling back to the user-queue lookup.
>
> v2: squash in fixes
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 32 ++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 0bd9d8a21f5e..c49a31a3789c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -6681,22 +6681,29 @@ static int gfx_v11_0_set_priv_inst_fault_state(st=
ruct amdgpu_device *adev,
>  static void gfx_v11_0_handle_priv_fault(struct amdgpu_device *adev,
>                                         struct amdgpu_iv_entry *entry)
>  {
> -       u8 me_id, pipe_id, queue_id;
> -       struct amdgpu_ring *ring;
> -       int i;
> -
> -       me_id =3D (entry->ring_id & 0x0c) >> 2;
> -       pipe_id =3D (entry->ring_id & 0x03) >> 0;
> -       queue_id =3D (entry->ring_id & 0x70) >> 4;
> +       u32 doorbell_offset =3D entry->src_data[0] & AMDGPU_CTXID0_DOORBE=
LL_ID_MASK;
>
> +       /*
> +        * Try KQ first by ring_id (HW slot is authoritative). The
> +        * KMD compute_hqd_mask contract guarantees KCQ and user queues
> +        * never share a HW slot.
> +        */
>         if (!adev->gfx.disable_kq) {
> +               u8 me_id =3D (entry->ring_id & 0x0c) >> 2;
> +               u8 pipe_id =3D (entry->ring_id & 0x03) >> 0;
> +               u8 queue_id =3D (entry->ring_id & 0x70) >> 4;
> +               struct amdgpu_ring *ring;
> +               int i;
> +
>                 switch (me_id) {
>                 case 0:
>                         for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
>                                 ring =3D &adev->gfx.gfx_ring[i];
>                                 if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id)
> +                                   ring->queue =3D=3D queue_id) {
>                                         drm_sched_fault(&ring->sched);
> +                                       return;
> +                               }
>                         }
>                         break;
>                 case 1:
> @@ -6704,8 +6711,10 @@ static void gfx_v11_0_handle_priv_fault(struct amd=
gpu_device *adev,
>                         for (i =3D 0; i < adev->gfx.num_compute_rings; i+=
+) {
>                                 ring =3D &adev->gfx.compute_ring[i];
>                                 if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> -                                   ring->queue =3D=3D queue_id)
> +                                   ring->queue =3D=3D queue_id) {
>                                         drm_sched_fault(&ring->sched);
> +                                       return;
> +                               }
>                         }
>                         break;
>                 default:
> @@ -6713,6 +6722,11 @@ static void gfx_v11_0_handle_priv_fault(struct amd=
gpu_device *adev,
>                         break;
>                 }
>         }
> +
> +       /* No KQ matched: HW slot is a MES-scheduled user queue. */
> +       if (adev->enable_mes && doorbell_offset)
> +               amdgpu_userq_process_reset_irq(adev, entry->pasid,
> +                                              doorbell_offset);
>  }
>
>  static int gfx_v11_0_priv_reg_irq(struct amdgpu_device *adev,
> --
> 2.49.0
>
