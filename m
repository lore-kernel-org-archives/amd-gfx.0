Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F988F483E6
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B108210E460;
	Mon, 23 Mar 2026 19:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="THN8xojW";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E838710E5BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:10:41 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-127337e3870so394742c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:10:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293041; cv=none;
 d=google.com; s=arc-20240605;
 b=L3Z/iZr7rt/k7GZRxo/8p0OsNFj/6IcSoVI/goEXLxAA/k+MTyQjtem/UMozYoDyK1
 XF/MKCTi/oQ6c4MMmdTfEjScfyVjocXA2OY0SR7wOee17xhWksMI5IfoGffe/yfHddHo
 xv4ZsDd54YSiiC/omSIhWQFo+9XWGTLzON2yBTyb+8XxNigTRRmcJpIsKqnP+4OnbrRG
 LaLhyKULALp6Ad9t8hyYsBMO2vpFWmQGxHOoMUWjUgcELz3nskcj6ITJKhoMSUMAbTKU
 CSOjYu0VYNiOq77dmOra4eowYUvb/hWb8L7Qj382x+d55PPrsFwqj+4tdbYdtRxom/9O
 UYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Aqbj/yjmLV+Qipz3AwB8NS0L/k+BG49o7CLB/PGbJjY=;
 fh=TjSDHDexhxAlozvahAqSjH/1kZYNEUCZM+OUwnm2QTM=;
 b=eHB95e2ZTS/8oJlA/6L+gXnHXCWKfMCMPBM03YqPkWgzEMZLmyPlUOr/Ny8fg5ax8+
 JZQgE4xNRdwW1iJ40tKDaXxH1dMNSl6Q1oDteRt52ihHXqU9K/BZnVgltqfiy7gwyefj
 LJx2deEgP/Y5+NeknZNAy+HcGevl9Fr6QegihW8S/6EacO5no/bsJ2EwgwCoaMJX88cn
 Ta8hKdLEeUnjdg3NiTA44worh1GN9nyRfbvYDZhfw/CcoipNluCF2TP184G160tCssrK
 bqmec42PoGpa9jtM+T2YCzhgg46IwnmGfuaRGLJXRLP3Ps60kjefGVvQyAXtS0kERt0o
 l1QQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774293041; x=1774897841; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aqbj/yjmLV+Qipz3AwB8NS0L/k+BG49o7CLB/PGbJjY=;
 b=THN8xojWBDg7PEzE3bUY+xkhuzyRPtxYxl/waVWB/PMgWCHbrreR4dCisBf4X+RgSa
 NiOFR2NnwuNmcjtrwKRnkAPSrTPRqVDZVZWarfoUoUxEmgBD8jDpm/WQQ98iOOpGg/l2
 clyioo4D7+R8EnSCtL1K0LEa+spnU3S8lY62qt94/mZdm8Oy2kdP+dRniN7J22zBu84V
 exor269Go6tpnk/dbt8/ri5uWbNUJgeyduJYyPGHbViHTQmPu41gE2wqkBeXYeV26zK+
 yIur78FfMq4bOV89NnmtWtdzjnvaW6fw/CoGa9hIMjf6hCC1PaEoVSjro85JrK8yEx1w
 aJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293041; x=1774897841;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Aqbj/yjmLV+Qipz3AwB8NS0L/k+BG49o7CLB/PGbJjY=;
 b=hhCuH3l6azgmUJxkiTz4UcLM7dyndxrNE6rTxlbgMa+qiK1PLblgnm1LHSBj2C/+tK
 O0X8d1F0JT7UDPHUY2ZbjvOBXz4h4MUWBVsnV7R1jTGNr5T7yXgSwGDr2wDpJkbPwBfc
 S/vzebpFur/S/eS+Y2qeUqarRow5infnMRH1pcL/qeF4ykV+KGGDtWX8A5AZCErKyJyH
 RYlLM1ZxTwLRPum80BRKkMEru5zJ0V2eubkkIZRu+ZPkufklbnpYpMU/9vPIAdNomLDy
 BDMFxkflAaA66IidvXVWHoESryLe2XLikESZY3I7v0qHA2WGk8XD2ovnNBiiFc4Tp/ps
 lT7Q==
X-Gm-Message-State: AOJu0Yw9uiDasDR9TfGwIQi2UVj1VphgW2f4ovqdCPqc+QI+oD+H4RMQ
 WWpEezjVfnIOCCJj+5MJKA5R7Yse/rvuKKmZmeyRxxxDLTe7uVP/pu8MLQnzRXmDCckDCXcDhnU
 EgpY5inayahQz1VHeOkKKkP2GBNKifzk=
X-Gm-Gg: ATEYQzzDqZ53KQERxfdkncOd1JdUM7m8SDLY8aOTKXnIQ1VkwaqQX2hdTDCEifiHcp8
 LqVsMOwjgwxGI8jM8pXZxYE2178yjNvhoiW7jhZEgIZPKo5hZU+FnILoHwJPTXn04tOnhRziKhU
 DmmbM/ep0ECqJkCNQZRJOFDoPiKJX8O6KsShIw8H/stmfMyVCtYY4XCcAOeXpirFiG88ytndjRd
 QvNuV1ZUKbGmRvEP8Ck3MZzHg2McUrHgy99a6GAvjWgUOp3wq6VmvQRobQ0oVEKSRynML6ev46g
 dnaS0GDMibzKIUccpjE0Cv0Ascc9UwegYa0UushY+HUiFzpaVuZPyTP1OpJw3FXyODTpMyu1727
 QBN+h
X-Received: by 2002:a05:7022:ba6:b0:127:332d:63e with SMTP id
 a92af1059eb24-12a726d8b7emr2745989c88.5.1774293041120; Mon, 23 Mar 2026
 12:10:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260320200208.1188307-1-Amber.Lin@amd.com>
 <20260320200208.1188307-6-Amber.Lin@amd.com>
In-Reply-To: <20260320200208.1188307-6-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2026 15:10:29 -0400
X-Gm-Features: AaiRm51_ZcqUlh5306BOe5yOY1wlsENxPy3Vb1O2RGkLlrqBGszFhER_ZOqJpA0
Message-ID: <CADnq5_My31vVJVAmTiEAaS4nCeTC9fm_NXF5rO459kpmYP=dvg@mail.gmail.com>
Subject: Re: [PATCH 5/8] drm/amdgpu: Missing multi-XCC support in MES
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

On Fri, Mar 20, 2026 at 5:19=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> In a multi-XCC GPU, pass the master XCC's ID to amdgpu_mes_suspend,
> amdgpu_mes_resume, and detect_and_reset_hung_queues so the command will b=
e
> sent to the matching master MES when the compute partition mode is not
> SPX.
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  7 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |  9 +++++----
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c             |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c             | 14 +-------------
>  .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  4 ++--
>  6 files changed, 15 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 710bca87c32b..4f44b933e373 100644
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_1.c
> index 70d80c2aed52..4b279259b9d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -1888,24 +1888,12 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_blo=
ck *ip_block)
>
>  static int mes_v12_1_suspend(struct amdgpu_ip_block *ip_block)
>  {
> -       int r;
> -
> -       r =3D amdgpu_mes_suspend(ip_block->adev);
> -       if (r)
> -               return r;
> -
>         return mes_v12_1_hw_fini(ip_block);
>  }
>
>  static int mes_v12_1_resume(struct amdgpu_ip_block *ip_block)
>  {
> -       int r;
> -
> -       r =3D mes_v12_1_hw_init(ip_block);
> -       if (r)
> -               return r;
> -
> -       return amdgpu_mes_resume(ip_block->adev);
> +       return mes_v12_1_hw_init(ip_block);

These changes seem unrelated.  Should these hunks be a separate patch?

Alex

>  }
>
>  static int mes_v12_1_early_init(struct amdgpu_ip_block *ip_block)
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
