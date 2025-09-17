Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFC7CAC599
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 14:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED8910E846;
	Wed, 17 Sep 2025 14:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cywaEimo";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD63C10E844
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 14:04:40 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b522e2866bcso578711a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758117880; x=1758722680; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pA6ccEBr532NgYGe0sO6K92KRsKNd/3LxyDnRxfZS6Q=;
 b=cywaEimoa0oFK6fRrv9AxLoXzIV7ffCM9HU8P2fbogKjFg7QqXw+SDQG1BidqjgLA4
 2Z+cmundTTjSCo6SDU9Ejr2Ay3nszqnBvFUnhwt4I1FR+sMgrs/opxN91F2xHKSRqt6X
 e5uJ87gIeu91HgqrVANZ1ognc+rBMmLe6NIYqi6jehBUhDjOUDBWHdJZY1FFaWsJQ6aZ
 XeLGdLfa/oAB0qKkK65UlKZm/OOfIlaARV7Cf9e1TGIKhsaxfSjsEZ5DePQ0KHLMaz60
 NThzTJEkTc9Ql0/NZtIMbpX/rsM8WsEwb9iLb/L2wpVKk6NRbawNMCeBT+HZQ4yB7guC
 grWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758117880; x=1758722680;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pA6ccEBr532NgYGe0sO6K92KRsKNd/3LxyDnRxfZS6Q=;
 b=gQxebGsto6tnDtyScopdO7I9TxAHFTIsTqc4jfhObZl9Ki1Cslz7coWi8CCBdgNOtv
 FTbi19Zq1lgN03aJduntSskRUQi8PCNfWOqA4Nh5BDbuYlUvlm5zqCfTty9Ayuk12SoO
 NPKROHRyFiX73u+0YSu8a3wuj8flF2M6y1x4mXZltKyLLRLH5NVPJ5piJ1O1fhlgSDAc
 P7UpdLaPdWsUQKFpIVKg8PwSCaaeKXjj4sA9ox4ka1UirdaKCVpArocHuW5dpzqAm2N/
 1Llu2P2odmd3P0eD/wvRhCCIThk7EP/5afIBeVrts0Eeyj9PrrUKGaXSrFDQEIlwUgi8
 wp1A==
X-Gm-Message-State: AOJu0YytSooFOdWtM7wwXa6ui2mABEco2EnFmueeADxD9rSJjyveXXNc
 DD5aP5/uDEoIKaacM4UvKh3FR0xVonkIaxaX9LPbG80sdyuLmhKXbO8fbWrjplLm6I7OELyRf/8
 +UMCzKXHknWUASCe1R0PwOkxlL4Z7Irg=
X-Gm-Gg: ASbGncsuKxeGiZ09X+yJkWMEsSTKt9GICDrb+l4uqnCLdopjG5EsxljOgCkvFdcifmS
 kweSCsdTxvvrXuf/L1lE8dTde01yEEs2RjXw2OfGHMke16C9DdwLkQHDbsauk3E1B2sTufDZ0Z1
 XWERrntIXbAOASf3jbevoaOPGu/JBqfCnTjcC753RC2R0/P4Ffce0QHNRuCsVQfRA0MvIHwIHww
 A/HT+SskktiKdzBA60=
X-Google-Smtp-Source: AGHT+IEHTLb/TvXv7skik/s4grZxmTDSsMqaQJ8nXRqnI6DRo4DU8nht2yp5MQGngLeQgdaohSwC760BA21n0RMB95M=
X-Received: by 2002:a17:902:d4c3:b0:267:8b4f:df10 with SMTP id
 d9443c01a7336-26810dd75e3mr15322415ad.0.1758117880023; Wed, 17 Sep 2025
 07:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250912055518.2719533-1-Prike.Liang@amd.com>
 <20250912055518.2719533-6-Prike.Liang@amd.com>
In-Reply-To: <20250912055518.2719533-6-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Sep 2025 10:04:27 -0400
X-Gm-Features: AS18NWD1a8VWaki0tGcMU_rLriW5Dat49gHTfcVyH3dSV_fTitstv7bAcTbK7sA
Message-ID: <CADnq5_PF+1gxpXmEu5z7585QEg8=zkXSr-r06upz0tWhEq7ikw@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] drm/amdgpu: track the userq bo va for its obj
 management
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Fri, Sep 12, 2025 at 2:04=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Track the userq obj for its life time, and reference and
> dereference the buffer flag at its creating and destroying
> period.
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 18 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 19a400bd4be1..cdcab71248d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -138,6 +138,22 @@ int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm,
>         return -EINVAL;
>  }
>
> +int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,

This can be static as it's not used outside this file.  Additionally,
I think the name is confusing.  It's just cleaning up the list.  I'd
suggest either renaming it to amdgpu_userq_buffer_vas_list_cleanup()
or just open coding it directly in the caller.

Alex

> +                               struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_userq_va_cursor *va_cursor, *tmp;
> +       int r;
> +
> +       list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, l=
ist) {
> +               r +=3D amdgpu_userq_buffer_va_put(queue->vm, va_cursor->g=
pu_addr);
> +               dev_dbg(adev->dev, "put the userq:%p va:%llx r:%d\n",
> +                       queue, va_cursor->gpu_addr, r);
> +               list_del(&va_cursor->list);
> +               kfree(va_cursor);
> +       }
> +       return r;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -200,6 +216,8 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *uq_funcs =3D adev->userq_funcs[q=
ueue->queue_type];
>
> +       /* Drop the userq reference. */
> +       amdgpu_userq_buffer_vas_put(adev, queue);
>         uq_funcs->mqd_destroy(uq_mgr, queue);
>         amdgpu_userq_fence_driver_free(queue);
>         idr_remove(&uq_mgr->userq_idr, queue_id);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index e4c2d7cabd15..b71fff65a896 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -154,4 +154,6 @@ int amdgpu_userq_buffer_va_get(struct amdgpu_usermode=
_queue *queue,
>                                struct amdgpu_bo_va_mapping *va_map, u64 a=
ddr);
>  bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr);
>  int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
> +int amdgpu_userq_buffer_vas_put(struct amdgpu_device *adev,
> +                               struct amdgpu_usermode_queue *queue);
>  #endif
> --
> 2.34.1
>
