Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD74F10A88FB
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 18:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 809EF10EA39;
	Thu, 26 Mar 2026 18:03:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jfx5EZRv";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A77FF10EA39
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:03:01 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12a77005d69so120592c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774548181; cv=none;
 d=google.com; s=arc-20240605;
 b=a45+yY3PPPxei8OlCoptBeKv9Bopg+uNsGPesJ8owNllhDXanhiZwa72+KWsGdgusq
 EVepJXgmsOfRYMnKuRXsM79IyeLcqs5XVDRq0aQnsFGRckkpty/9dsRYoVTXVo8Y9jmZ
 dvmGPpovzSpVGitkb5htvlaR56WF51qh1B7+1p/l2TWvqBVO9WBJzomMo+UIUswzTXcS
 PBh8M7FGVEMbEcE+H9gl5hUayywpQcRDVmHnEjSg28ERF3AY1h0xPdCMDnOacOGl7m1Z
 CvUsubZaI6BD49r+iMeh+bwE9kUb5i8Iy5x5kX4pqXp6NWlEzh5cyhvs/q3ZrC+tNywy
 1Ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fHWiGNdgXUxhB3BDvLxfM4sjGalFSynDwmqqtq1k1oA=;
 fh=TjSDHDexhxAlozvahAqSjH/1kZYNEUCZM+OUwnm2QTM=;
 b=eVTfF3A4y85ToO+y8SLRXNZvCX9VwtWYOUBYSbwdqcG6MgBXHjYaQAMqLiIw3LiKwA
 Ot3P4Ti4JNIGBQXvClrIxB1cTZrjKjaNPlfhcDJCG9nPSP2SvCT79R8jEK7T+l6TXIOf
 KWZPQpembrY99t0X3e2bgK6zPAwyxj2Bjx2c3+R2NZAPoixDoUzZVRzCm2xPJB1Bwpl1
 3lmeawAsIeFwsuyrxHCtL16CyvLEPihkHQvjy4Lvw+rQAgIV47a2NvQzHx6QS7AhXifL
 J3XQ5HYQz904Fu06LRrp33pRdX5c/eFD3k8T/8PqSlX/SkFROIWGTxGN7BHy50Z/ETR/
 fXNg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774548181; x=1775152981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fHWiGNdgXUxhB3BDvLxfM4sjGalFSynDwmqqtq1k1oA=;
 b=jfx5EZRvY2MAI1ewjQf2bN6oZ/TDA+llfzv9eNjJBzmVho/A9H0LathwcH7Y3Kh9IU
 FxwQwtA90Qp9ue3J6NuEidGB0Mb5zELnZT1bJ0HzZeKVYhz98Iq2Na0yXuRU2wWLiryc
 WzClG4SObwhspbA9UsGdmpT2TXopAOs0DnVDO3WtEfK8TrVq1VZ4SaQZggCH2WPj21bj
 AUyqtlr9RiBEG/HGW/KxPiWZiSMupBbdZxUDWDs1naJA7sUzGnuJaett2O4+SZEGTvUb
 +jFy2UWH/coaG69pqSJZo8CuqupQaD5KrdBnZc8gO2suoj4vzDfGTouTMSUbzIaCINxt
 VuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774548181; x=1775152981;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fHWiGNdgXUxhB3BDvLxfM4sjGalFSynDwmqqtq1k1oA=;
 b=EVlM2hIiYAECrODYDGWkHLJFCD4kGUuOVsPkDvTadUz1Kvsz4JjWWdOOCAyeSEygYV
 MGkpRziFzXOyaQxCqMC6BasQzB+xvj6qOwSp+0mAzCEXyFCzop27DdgqDmURG4KD/5ME
 bQfkCTNR10nf0Pavvi1mMOglFkT0ZefwyVRv907OT4mV3Pjoi4xaBm6A2M4m9lh0t0+o
 xVmaWfJQoT6XOlUfDymCna1YNkvxKsx6q8FTYYQ1PWv9Xvj4gdr7+SKcHq8lmKxhF8sH
 cMv9I77fira9Z97zgGEhpGkAwp+SiAl5FzvcM7P4p2Dbyz6sJU9hpOXMnKFpYSg9fP38
 HpPg==
X-Gm-Message-State: AOJu0YyckI8Gdb5uiNqziKooU/nO7Z6s2p/17EwYDVQjoGu5xJT4JPtj
 Rv0EQ83KpaaDuWxvHIwP3bvxl7Yq4g8ZEIHg9/VuBBVIQSKD2J6hPFAjgTDoiPF8mzMajwQh+/4
 /lcKiSOC1h2ux4Ne5C5b/5nnUXklG0pU=
X-Gm-Gg: ATEYQzxt+p1+NnLl9E/zueGxA4WDOD0xLUIFW2M6zRrEf5y0n/Ob1GJkQJga99O8+Sp
 /Md1kg5b5euRYhW2fPWZ2LwGIdhzL2Jel+qsDS8RMRL4oi++XZdhwrvvDYvlv2Hd+/vC/D+81ak
 n9UgR3DJhiyx3yAbAkA4J0u8odMGj2ItWJ543C7F1s42aGloa3CYtxAPPakUoSAsa4H59HAL0kT
 nFVkK7tK+ScEzyoVhbIvBYj6XCIz9XJK+T7lx6gTzoMUra13lsk7w9uxmqgRZc6BNFl68MIloW5
 4SlvWFyZS6bFb+8Ja+P/L5CeDLw5f+F/LDDjJczmtcW7sQG7Sr45JlUItD0QcCkCj8ITLw==
X-Received: by 2002:a05:7022:69a7:b0:128:d7b3:6c52 with SMTP id
 a92af1059eb24-12a96ebe2d2mr2093176c88.4.1774548180502; Thu, 26 Mar 2026
 11:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260324175653.1325754-1-Amber.Lin@amd.com>
 <20260324175653.1325754-7-Amber.Lin@amd.com>
In-Reply-To: <20260324175653.1325754-7-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 14:02:48 -0400
X-Gm-Features: AQROBzAsAJnvXdOvs-jbdtSzqGW9WYIS1zG9vN-q0BUtq_EB1IaW0JqSCDa971M
Message-ID: <CADnq5_OJnsfu_T+ax0-CseEx-mF9JhN=wwh4AHo9zF5dJuro=w@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] drm/amdgpu: Missing multi-XCC support in MES
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, Michael.Chen@amd.com, 
 Jesse.Zhang@amd.com
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

On Tue, Mar 24, 2026 at 1:57=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> In a multi-XCC GPU, pass the master XCC's ID to amdgpu_mes_suspend,
> amdgpu_mes_resume, and detect_and_reset_hung_queues so the command will b=
e
> sent to the matching master MES when the compute partition mode is not
> SPX.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c               | 7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h               | 9 +++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c                | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c            | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
>  5 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index d778c3da8203..f3a4ae1fd521 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -300,7 +300,7 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>         mutex_destroy(&adev->mes.mutex_hidden);
>  }
>
> -int amdgpu_mes_suspend(struct amdgpu_device *adev)
> +int amdgpu_mes_suspend(struct amdgpu_device *adev, uint32_t xcc_id)
>  {
>         struct mes_suspend_gang_input input;
>         int r;
> @@ -310,6 +310,7 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
>
>         memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
>         input.suspend_all_gangs =3D 1;
> +       input.xcc_id =3D xcc_id;
>
>         /*
>          * Avoid taking any other locks under MES lock to avoid circular
> @@ -324,7 +325,7 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev)
>         return r;
>  }
>
> -int amdgpu_mes_resume(struct amdgpu_device *adev)
> +int amdgpu_mes_resume(struct amdgpu_device *adev, uint32_t xcc_id)
>  {
>         struct mes_resume_gang_input input;
>         int r;
> @@ -334,6 +335,7 @@ int amdgpu_mes_resume(struct amdgpu_device *adev)
>
>         memset(&input, 0x0, sizeof(struct mes_resume_gang_input));
>         input.resume_all_gangs =3D 1;
> +       input.xcc_id =3D xcc_id;
>
>         /*
>          * Avoid taking any other locks under MES lock to avoid circular
> @@ -462,6 +464,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct am=
dgpu_device *adev,
>                 adev->mes.hung_queue_db_array_size * sizeof(u32));
>         input.queue_type =3D queue_type;
>         input.detect_only =3D detect_only;
> +       input.xcc_id =3D xcc_id;
>
>         r =3D adev->mes.funcs->detect_and_reset_hung_queues(&adev->mes,
>                                                           &input);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 2e6ae9f84db0..643b4f8d757a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -325,8 +325,9 @@ struct mes_reset_queue_input {
>  };
>
>  struct mes_detect_and_reset_queue_input {
> -       uint32_t                           queue_type;
> -       bool                               detect_only;
> +       uint32_t        queue_type;
> +       bool            detect_only;
> +       uint32_t        xcc_id;
>  };
>
>  struct mes_inv_tlbs_pasid_input {
> @@ -442,8 +443,8 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *a=
dev, int pipe);
>  int amdgpu_mes_init(struct amdgpu_device *adev);
>  void amdgpu_mes_fini(struct amdgpu_device *adev);
>
> -int amdgpu_mes_suspend(struct amdgpu_device *adev);
> -int amdgpu_mes_resume(struct amdgpu_device *adev);
> +int amdgpu_mes_suspend(struct amdgpu_device *adev, uint32_t xcc_id);
> +int amdgpu_mes_resume(struct amdgpu_device *adev, uint32_t xcc_id);
>
>  int amdgpu_mes_map_legacy_queue(struct amdgpu_device *adev,
>                                 struct amdgpu_ring *ring, uint32_t xcc_id=
);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 78d1f3eb522e..35734d34763a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -5200,7 +5200,7 @@ static int gfx_v11_0_post_soft_reset(struct amdgpu_=
ip_block *ip_block)
>         /**
>          * GFX soft reset will impact MES, need resume MES when do GFX so=
ft reset
>          */
> -       return amdgpu_mes_resume(adev);
> +       return amdgpu_mes_resume(adev, 0);
>  }
>
>  static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *ad=
ev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 9508709abd49..d02a84711394 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -266,7 +266,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_d=
evice *adev,
>
>         if (found_hung_queue) {
>                 /* Resume scheduling after hang recovery */
> -               r =3D amdgpu_mes_resume(adev);
> +               r =3D amdgpu_mes_resume(adev, input.xcc_id);
>         }
>
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 18bc5ba25f8f..ec8d7f4be840 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -367,7 +367,7 @@ static int suspend_all_queues_mes(struct device_queue=
_manager *dqm)
>         if (!down_read_trylock(&adev->reset_domain->sem))
>                 return -EIO;
>
> -       r =3D amdgpu_mes_suspend(adev);
> +       r =3D amdgpu_mes_suspend(adev, ffs(dqm->dev->xcc_mask) - 1);
>         up_read(&adev->reset_domain->sem);
>
>         if (r) {
> @@ -387,7 +387,7 @@ static int resume_all_queues_mes(struct device_queue_=
manager *dqm)
>         if (!down_read_trylock(&adev->reset_domain->sem))
>                 return -EIO;
>
> -       r =3D amdgpu_mes_resume(adev);
> +       r =3D amdgpu_mes_resume(adev, ffs(dqm->dev->xcc_mask) - 1);
>         up_read(&adev->reset_domain->sem);
>
>         if (r) {
> --
> 2.43.0
>
