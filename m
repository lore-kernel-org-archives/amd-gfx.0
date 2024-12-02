Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A955DD78321
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 15:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3651210E0E8;
	Mon,  2 Dec 2024 15:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ml3AWRXs";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B77310E0E8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 15:22:42 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-7fc9b94cad0so288114a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Dec 2024 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733152962; x=1733757762; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfT3KpUFGJG4FSKzOwYNgNvxiNEcrQWtCfXw2lKcN7g=;
 b=ml3AWRXs29rh0KbxIo7Zt3hernkxNWWbrj94UlmDKt5amNDRAs18MyFIB4Zj0P52nB
 bMMZTEpHQNejFZEYoTk5RsVOfMf6evy6FRY6Ssxok/xrZy7fB2VsXpIgCXdqYMWEFTMB
 iOwJkOcTfyGuJVyhsMMQxqcQU3wBE42gOtNAJYI44Pi4kwyD1NSDzPed1jxEEdb5oDnA
 H/EEwCdfFqH25JEvvz2m3KqGiLTdegRx56DyKWG39qPeFRB0JbtZ4m5+5/s9HCgKz2d1
 UEueGIwTvL0bmG+wCSHCqJ8UDRM8vEorCitDhXrZqxYHLSwvWwroE5I1hy6q2zgOdrOf
 7xuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733152962; x=1733757762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfT3KpUFGJG4FSKzOwYNgNvxiNEcrQWtCfXw2lKcN7g=;
 b=KXSxtq7dRbBWW3OwmH/Yq70pUZChfLwlpYLR9Eo7dfRblpAp8tBdPwfNvZ3SXi7QiV
 eswmMBq1DW0e26HNnjXnQpzemZJK3vzq2pfKK/IAKuOmQSMAnAg3Aub8OATeX34xsxMo
 yjVM/cNT/kwbgo6uKsfeK9w8kWni+MaVdbR552b6HHQSv6hkqlMQOZ7rjmHiiEG4HT0Z
 TU+xjs6CYAmFKSJtpUsb73W8Yssv1/70xZHdiW70cu8eypVK4roQLXjk/6fTyVzfk1MQ
 uK5rFcsMS7oypPfhQr0X9DMq7VS0SToCw4+sqyr/aH66zuItPpBWZ5C9epY9SEpH1zg3
 lT2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcaEDirxy7Go2NQNB802jJpEPgcnsyF52TCoOUKITSDzXvZNRjyT84IvE8O4lrmTY7TMXvbtb8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWkbERPh+mKpknAHyDyBirCsS5HyYZ8PpVgssLbVzq7jorVSKB
 7FTSi/yFVtX5vLSwuZ8go1fuTEPIgV85X6erEUSECiyrXMtRcetkvDquiUZnQ+A2weryFd1WclW
 V8rdur6a+WzZPl42ciSZkso2m+Un7ozgO
X-Gm-Gg: ASbGncv0El/ASd47CH6/j559h0fLvDuz/l657qE13n0ij+NCvrQ7ENurNUh55oNEDK8
 AaZb+GxtE2Mx8WupMMaANIJPrN/zPFAE=
X-Google-Smtp-Source: AGHT+IHDuucvm9z8lMh6UU7jfQ1UniYtptvn5WBiY6NgROIN0PZFaAWImrU5RIbh/0iODziE8lWCjZERWoPbV+2cPh4=
X-Received: by 2002:a05:6a21:6d9e:b0:1e0:ccfa:7f09 with SMTP id
 adf61e73a8af0-1e0e0b56fecmr14035587637.11.1733152961715; Mon, 02 Dec 2024
 07:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20241127194350.2085774-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241127194350.2085774-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Dec 2024 10:22:29 -0500
Message-ID: <CADnq5_MQU_ru0Y7Z6=PCTRD3fPnVKMivOaOY0juDm9f6Gj=mrA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add Annotations to Process Isolation
 functions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Nov 27, 2024 at 2:57=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This update adds explanations to key functions that manage how the
> Kernel Fusion Driver (KFD) and Kernel Graphics Driver (KGD) share the
> GPU.
>
> amdgpu_gfx_enforce_isolation_wait_for_kfd: Controls the waiting period
> for KFD to ensure it takes turns with KGD in using the GPU. It uses a
> mutex to safely manage shared data, like timing and state, and tracks
> when KFD starts and stops waiting.
>
> amdgpu_gfx_enforce_isolation_ring_begin_use: Ensures KFD has enough time
> to run before new tasks are submitted to the GPU ring. It uses a mutex
> to synchronize access and may adjust the KFD scheduler.
>
> amdgpu_gfx_enforce_isolation_ring_end_use: Handles cleanup and state
> updates when finishing the use of a GPU ring. It may also adjust the KFD
> scheduler, using a mutex to manage shared data access.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 31 +++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index e54f42e3797e..ce9ecd1fe748 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1940,6 +1940,19 @@ void amdgpu_gfx_enforce_isolation_handler(struct w=
ork_struct *work)
>         mutex_unlock(&adev->enforce_isolation_mutex);
>  }
>
> +/**
> + * amdgpu_gfx_enforce_isolation_wait_for_kfd - Manage KFD wait period fo=
r process isolation
> + * @adev: amdgpu_device pointer
> + * @idx: Index of the GPU partition
> + *
> + * This function controls how the Kernel Fusion Driver (KFD) waits so th=
at both
> + * the KFD and the Kernel Graphics Driver (KGD) use the GPU one after th=
e other.
> + * It decides if the KFD should pause to let the KGD use the GPU.
> + * A mutex is used to ensure that shared information, like timing and st=
ate,
> + * is accessed safely by both drivers.
> + * The function also records when the KFD's wait period starts and ends,
> + * to ensure the time-sharing works correctly.

maybe add something like:
When kernel submissions come in, the jobs are given a time slice and
once that time slice is up, if there are KFD user queues active,
kernel submissions are blocked until KFD has had its time slice.  Once
the KFD time slice is up, KFD user queues are preempted and kernel
submissions are unblocked and allowed to run again.

> + */
>  static void
>  amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
>                                           u32 idx)
> @@ -1985,6 +1998,15 @@ amdgpu_gfx_enforce_isolation_wait_for_kfd(struct a=
mdgpu_device *adev,
>                 msleep(GFX_SLICE_PERIOD_MS);
>  }
>
> +/**
> + * amdgpu_gfx_enforce_isolation_ring_begin_use - Begin use of a ring wit=
h enforced isolation
> + * @ring: Pointer to the amdgpu_ring structure
> + *
> + * This function is called when beginning the use of a GPU ring with enf=
orced isolation.
> + * It ensures that the KFD has had sufficient time to run before allowin=
g more work to
> + * be submitted to the ring. The function acquires a mutex to synchroniz=
e access and
> + * may control the KFD scheduler to maintain process isolation.

I would say something like:
Ring begin_use helper implementation for gfx which serializes access
to the gfx IP between kernel submission IOCTLs and KFD user queues
when isolation enforcement is enabled.  The kernel submission IOCTLs
and KFD user queues each get a time slice when both are active.

> + */
>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *rin=
g)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -2012,6 +2034,15 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(s=
truct amdgpu_ring *ring)
>         mutex_unlock(&adev->enforce_isolation_mutex);
>  }
>
> +/**
> + * amdgpu_gfx_enforce_isolation_ring_end_use - End use of a ring with en=
forced isolation
> + * @ring: Pointer to the amdgpu_ring structure
> + *
> + * This function is called when ending the use of a GPU ring with enforc=
ed isolation.
> + * It ensures that any necessary cleanup or state updates are performed,=
 and it may
> + * control the KFD scheduler to maintain process isolation. The function=
 uses a mutex
> + * to synchronize access to shared data.

I'd say something like:
Ring end_use helper implementation for gfx which serializes access to
the gfx IP between kernel submission IOCTLs and KFD user queues when
isolation enforcement is enabled.  The kernel submission IOCTLs and
KFD user queues each get a time slice when both are active.

> + */
>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> --
> 2.34.1
>
