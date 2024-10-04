Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72CACF8857
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 19:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8935C10EA98;
	Fri,  4 Oct 2024 19:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ycs3SASr";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 456E010EA98
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 19:40:35 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-71df23e0ffaso15601b3a.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Oct 2024 12:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728070835; x=1728675635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q++BU2Wxr2TMwdyOV9LpjfY1EWPIpDpOJKXgxE3G6wU=;
 b=Ycs3SASrdLtkjT3qYVhxZ5SYDegkX0I1TQa2wWQOyq1ZNSXcT9qltZ+5JvKylFi45M
 bDhEfz/fACSX8ZJ965LTZsi6ZdgCpfA5QVuI9MWPGO0MViWYH+55w/KOhBkCrmNlicHd
 a9rLaQmSfbwMT+G8WVKpWVPRSd8ZFK69WJGJG4eyrMp64WKJWODjTt7kb2lIire6Sb1e
 V/fJuDd6ucASH42EEzecqKA88X1tDf0ONEkpd/e+xDdxMEZSG1YVqQnUEpI6R4mHYd5o
 O7Ty3qpJ4pV3QbTrTnlTuEq79YY2jWw1Vts3TdNpTc3CTtDdFuq2pViHyOu0oK/gh2B/
 C/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728070835; x=1728675635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q++BU2Wxr2TMwdyOV9LpjfY1EWPIpDpOJKXgxE3G6wU=;
 b=AREe7PUIwMY+07s7585H09Icu75esPe67CqBCJOC0YSvOdSOdmu4eixWrac9TRW/4d
 tgjeAg5CqS75mVv8CL1Qv1GJyf2fDKT924Ft7QAGfvWh/4YEDFoWjne7Ztpkuigbps99
 WzxIA/PdPWXRK7hGc/TaQDP655dkC0m3w45V9LfIQMD1maBe1gb5a/sne71xG3HLRXrn
 zXLhUbq0/XQ69f15Mr+rMG0M6lZaX6NfMbtpx7TIOrMMGv+aK3JP+VQycfFNUl4Gm03Y
 iFYefwpg03l7xzTNF2DaZ97wBC7iv4v6kJe+dQE+2jCgLUM4lEuahLKsTodOEYtKyKFb
 HCEw==
X-Gm-Message-State: AOJu0YxIoRh4OjQNKl3T+QL7wuq3i13hji+mgow0ZbSTKIhYObMY5qRS
 aPEAjNzIjZMsvDVti7GEPXlcM6oXROaVORRrvfOyD9/qB1WkIVMREbzIqNrRHY9PQA5GQCRsqxw
 VWP1I6WSd2PC9nU+ZgYcADkBjpLuxvv7O
X-Google-Smtp-Source: AGHT+IGw1+xxTo6LiZyqZR55+bTExJmuKNGHm5o8JMovzapVZamwXDwdDlwdaUj9mAYTwKEfq2JBDV2aV8L9eKaU/ag=
X-Received: by 2002:a05:6a21:9999:b0:1cf:405b:edf7 with SMTP id
 adf61e73a8af0-1d6dfa367b8mr3047189637.4.1728070834668; Fri, 04 Oct 2024
 12:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
 <20241004184444.435356-10-boyuan.zhang@amd.com>
In-Reply-To: <20241004184444.435356-10-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Oct 2024 15:40:23 -0400
Message-ID: <CADnq5_PJAYUgeJS876br9LxgaMQw5h=hC4LPkahQ5rhQ7G5OUw@mail.gmail.com>
Subject: Re: [PATCH 09/18] drm/amdgpu: add set_powergating_state_instance
To: boyuan.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org, leo.liu@amd.com, christian.koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com
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

On Fri, Oct 4, 2024 at 2:45=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Add a new function to allow setting requested powergating state for the
> given instance. If the instance value doesn't match with the one inside
> ip_block, then do nothing since this request is for other instances with
> the same block type.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 3442564fe174..ae59497f3074 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -358,6 +358,10 @@ int amdgpu_device_ip_set_clockgating_state(void *dev=
,
>  int amdgpu_device_ip_set_powergating_state(void *dev,
>                                            enum amd_ip_block_type block_t=
ype,
>                                            enum amd_powergating_state sta=
te);
> +int amdgpu_device_ip_set_powergating_state_instance(void *dev,
> +                                          enum amd_ip_block_type block_t=
ype,
> +                                          enum amd_powergating_state sta=
te,
> +                                          unsigned int inst);
>  void amdgpu_device_ip_get_clockgating_state(struct amdgpu_device *adev,
>                                             u64 *flags);
>  int amdgpu_device_ip_wait_for_idle(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 35a3e71a5a84..f0b6a9675405 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2162,6 +2162,43 @@ int amdgpu_device_ip_set_powergating_state(void *d=
ev,
>         return r;
>  }
>
> +/**
> + * amdgpu_device_ip_set_powergating_state_instance - set the PG state
> + *
> + * @dev: amdgpu_device pointer
> + * @block_type: Type of hardware IP (SMU, GFX, UVD, etc.)
> + * @state: powergating state (gate or ungate)
> + *
> + * Sets the requested powergating state for the given instance of
> + * the hardware IP specified.
> + * Returns the error code from the last instance.
> + */
> +int amdgpu_device_ip_set_powergating_state_instance(void *dev,
> +                                          enum amd_ip_block_type block_t=
ype,
> +                                          enum amd_powergating_state sta=
te,
> +                                          unsigned int inst)
> +{
> +       struct amdgpu_device *adev =3D dev;
> +       int i, r =3D 0;
> +
> +       for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +               if (!adev->ip_blocks[i].status.valid)
> +                       continue;
> +               if (adev->ip_blocks[i].version->type !=3D block_type)
> +                       continue;
> +               if (adev->ip_blocks[i].instance !=3D inst)
> +                       continue;
> +               if (!adev->ip_blocks[i].version->funcs->set_powergating_s=
tate)
> +                       continue;
> +               r =3D adev->ip_blocks[i].version->funcs->set_powergating_=
state(
> +                       (void *)&adev->ip_blocks[i], state);
> +               if (r)
> +                       DRM_ERROR("set_powergating_state of IP block <%s>=
 failed %d\n",
> +                                 adev->ip_blocks[i].version->funcs->name=
, r);
> +       }
> +       return r;
> +}
> +

I think it would also be cleaner to update
amdgpu_device_ip_set_powergating_state() to take the instance as a new
parameter.  Same for amdgpu_device_ip_set_clockgating_state().

Alex

>  /**
>   * amdgpu_device_ip_get_clockgating_state - get the CG state
>   *
> --
> 2.34.1
>
