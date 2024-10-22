Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3448FD2C559
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 14:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FE710E694;
	Tue, 22 Oct 2024 14:05:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fUGnsakF";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100B510E690
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 14:05:14 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2e3c0d1ccc6so859946a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 07:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729605913; x=1730210713; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ch3bRa9el2UM/oItvnqz60b7cvcfHqPvY0PsRShG6CQ=;
 b=fUGnsakF8n8rf5F+gL66VcMdG49IYeaKOSEFSYYEkcMp/QuyBXPr1plOb6B61vK9I9
 1lohVjFu+VTYbUoF5rTi0SgXyLvjjQwi2/IPQsmsmyDML3pGS364gLDCEGCh2N7B3EHM
 KME+CXFD2EnptczBvLdWPvpTIhJmE+VmWPm+zwJuonyKvxsYzHdhHgjtcvFKfk0QtQQM
 DR3WUBAjdp/C3eq5iFcA8Vpd8TSByPfpWfZtKgwz+kcXzIAeUy8ACWYplBVMetP0bhIn
 ows/8IJBxZHevigzuaWmVBGDJx0NocBKNAB1bDHVEXMczfMvnucWZLJs6WVs/5OtLR9X
 mHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605913; x=1730210713;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ch3bRa9el2UM/oItvnqz60b7cvcfHqPvY0PsRShG6CQ=;
 b=uOdEfoyruhnxEA9WBQ4zDCDxn7K1Es/6LWG0E1ySekGBb2ZTk+aUD6opR95VQ2yoSN
 2+Q/Fzzm8UUc6Fkv+LUaw6tORievKKPLuxINEoniXkt1AR4aydS/1+giwjbvdvYDxN7J
 ea6hMCAP2YiKz/4Swz0aO4hBUrK+rNeOLW3c8dCOo7K5ivyogX0yHHU/gu+f4cAjY31C
 SHQ/4QYl6DqkoVc4nMMqQHhKzAGxmH3qEMEIoxV1ERefejQA5b6fT5mA8ch6Cz72ktBg
 90OpSPij5+QJoJCZOYzOs6vXlX81s58lIQo2Glq++c4p9mpiBVpTqsZ0UhiFj63bXn8X
 GLug==
X-Gm-Message-State: AOJu0Yzc7HNr/Npvo0yQitckFGEr1azPNPou3mWbLrOsxezSVEXIOLmB
 wda2JF1/WxUmMFtpzs5/5EVG0KsoHTeDwBAkGITmu5gISijjrwm8Hb/pXiHZHQG0+SrWgnpRdiV
 xpIivVxMJFGtgsXjKgkxAIc0DXgg=
X-Google-Smtp-Source: AGHT+IH8aVeEjSUn1AYmDvTywDH0nvyFXbgrzCkVAGEJpHGte2xH7IVFenobQsWokMWrW4aHY6ezvmPIdoUmlLRqCrY=
X-Received: by 2002:a17:90a:8c9:b0:2e2:cd6b:c6b8 with SMTP id
 98e67ed59e1d1-2e56185681fmr7513334a91.8.1729605913515; Tue, 22 Oct 2024
 07:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20241022135307.3566557-1-Victor.Zhao@amd.com>
In-Reply-To: <20241022135307.3566557-1-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Oct 2024 10:05:01 -0400
Message-ID: <CADnq5_Mk6WqMK=Ww=23hScixDgdJZdPgOfT3LB-QgEyfieUkLQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: remove extra use of volatile
To: Victor Zhao <Victor.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, philip.yang@amd.com
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

On Tue, Oct 22, 2024 at 10:03=E2=80=AFAM Victor Zhao <Victor.Zhao@amd.com> =
wrote:
>
> as the adding of mb() should be sufficient in function unmap_queues_cpsch=
,
> remove the add of volatile type as recommended
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 5a318376203c..38c19dc8311d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2048,7 +2048,7 @@ int amdkfd_fence_wait_timeout(struct device_queue_m=
anager *dqm,
>  {
>         unsigned long end_jiffies =3D msecs_to_jiffies(timeout_ms) + jiff=
ies;
>         struct device *dev =3D dqm->dev->adev->dev;
> -       volatile uint64_t *fence_addr =3D dqm->fence_addr;
> +       uint64_t *fence_addr =3D dqm->fence_addr;
>
>         while (*fence_addr !=3D fence_value) {
>                 /* Fatal err detected, this response won't come */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index bddb169bb301..09ab36f8e8c6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -260,7 +260,7 @@ struct device_queue_manager {
>         uint16_t                vmid_pasid[VMID_NUM];
>         uint64_t                pipelines_addr;
>         uint64_t                fence_gpu_addr;
> -       volatile uint64_t       *fence_addr;
> +       uint64_t                *fence_addr;
>         struct kfd_mem_obj      *fence_mem;
>         bool                    active_runlist;
>         int                     sched_policy;
> --
> 2.34.1
>
