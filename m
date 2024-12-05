Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AC9E7716C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 15:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF3610EEE2;
	Thu,  5 Dec 2024 15:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KTJka0N2";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B018610EED7
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 15:56:14 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2ee7c059b97so168809a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2024 07:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733414174; x=1734018974; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+38ePLggD3Rt9Vm1VRT+hbTBYoeJt/pG/c7zAyIR18=;
 b=KTJka0N28KK2abQyYUVPmixM+byxTSvjQo3ULM+HGHQljCBbNYfwQuw/mk/GuJ3Sis
 IaEZ4Vy+WkY3f35Yb4KYl3TLZkumazBcSUzi0dn3lZ3hg6A+0w4OnntF/C4vXHTNmBgd
 IN54DSbRkefx3H65mGOXXG+2H+M9Q4P1O8d4KcDRGHKc65iQGbWwlNCIXaYDvQO+2N1s
 hyUmObDUYlQ00xNpB8g/zRvjjK9qWL0MEMuOMu3gdJSzperXVxSZTIngWjXqZ9HEemSW
 bk3/lCZuk+fR8VGNuKU3Fo/5oidTYJcgE9nOUfUAl/soMvKR3SoRTZOA1EKbwAoxA0Xx
 0ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733414174; x=1734018974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+38ePLggD3Rt9Vm1VRT+hbTBYoeJt/pG/c7zAyIR18=;
 b=c8pPMmpFbmFDnzD9gegS+nukGPS3Qjp4SdOwyZpqVXq84fMGzjtcGEcNjPCLpdvfrH
 bXmLTTUKJRAeOJZE80Ai9is563qz7q1XXLLN9JigyrYkmDEbfjZPl1Sy5DbvPe7S8vo5
 X5sD2khxa9BA0tK3voTX2HmMtgUXA+xh9guZu6NNkFyVCYRCNfkZTQHFKVAd7jTVnime
 9AP38KX3J8jEpVF8rmWcs7eqkNyVVWtxiNtgav34jupIvnRKPDY28DvDCkWfXbogGnBt
 ElChRMUFycfOiJxfMPixoTNj0Pdm/pFq2zODU0EPt/ivIdV/bQUvwUNnliVE2lk7kUS7
 9ZmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHHE4OduCUmGOn/wPIHZ4ulYcW/IaKGtQojnc1ITz0YVUrlD+PsQSrZkZdgcWU1PCxbOaGCTKH@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzc1cEoqQIp+/aNC2BnyMU1a6M2GrbjLqLek9PhE55xrUVX2L8Z
 P0ycgj3sg4I81BIlsi6qOPWC+ESpH6G1oDgXIgNX8dtXgIqqORXpys1D8hLWethuS1sAVx0i9Jw
 3aUfjwlTsWeNmf7GHISh6rwTG5gp2SA==
X-Gm-Gg: ASbGncsP7yzAHOXya2EY1wrkx9GCjY0i8ZPzP+by87GeO8gWV0KUMn6MBQxPJE8EPgk
 Ly6X/7V7MF5k0CruP6zLWWUOeqhK5ouk=
X-Google-Smtp-Source: AGHT+IFAdKSbvlEO2VZlKuKk3i2A6jsDn9VZc2geILaxkHod0p4dmX9MuGg395Woy1UjJTNz6TBkezgGMFbJH8f1yQc=
X-Received: by 2002:a17:90b:1645:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2ef011df52emr5840351a91.1.1733414172623; Thu, 05 Dec 2024
 07:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20241129135837.4070078-1-srinivasan.shanmugam@amd.com>
 <20241205151957.2465687-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241205151957.2465687-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Dec 2024 10:56:01 -0500
Message-ID: <CADnq5_NWj+mnnFfJQrdCEO0yhpRMF28uOt-Xzt0SEG5ZNdrZHA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: Add Descriptions to Process Isolation
 and Cleaner Shader Sysfs Functions
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

On Thu, Dec 5, 2024 at 10:30=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This update adds explanations to key functions related to process
> isolation and cleaner shader execution sysfs interfaces.
>
> - `amdgpu_gfx_set_run_cleaner_shader`: Describes how to manually run a
>   cleaner shader, which clears the Local Data Store (LDS) and General
>   Purpose Registers (GPRs) to ensure data isolation between GPU workloads=
.
>
> - `amdgpu_gfx_get_enforce_isolation`: Describes how to query the current
>   settings of the 'enforce_isolation' feature for each GPU partition.
>
> - `amdgpu_gfx_set_enforce_isolation`: Describes how to enable or disable
>   process isolation for GPU partitions through the sysfs interface.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2:
>  - Incorporated feedbacks for function descriptions (Alex)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 45 +++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index e54f42e3797e..7e2ad7818903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1484,6 +1484,24 @@ static int amdgpu_gfx_run_cleaner_shader(struct am=
dgpu_device *adev, int xcp_id)
>         return 0;
>  }
>
> +/**
> + * amdgpu_gfx_set_run_cleaner_shader - Execute the AMDGPU GFX Cleaner Sh=
ader
> + * @dev: The device structure
> + * @attr: The device attribute structure
> + * @buf: The buffer containing the input data
> + * @count: The size of the input data
> + *
> + * Provides the sysfs interface to manually run a cleaner shader, which =
is
> + * used to clear the GPU state between different tasks. Writing a value =
to the
> + * 'run_cleaner_shader' sysfs file triggers the cleaner shader execution=
.
> + * The value written corresponds to the partition index on multi-partiti=
on
> + * devices. On single-partition devices, the value should be '0'.
> + *
> + * The cleaner shader clears the Local Data Store (LDS) and General Purp=
ose
> + * Registers (GPRs) to ensure data isolation between GPU workloads.
> + *
> + * Return: The number of bytes written to the sysfs file.
> + */
>  static ssize_t amdgpu_gfx_set_run_cleaner_shader(struct device *dev,
>                                                  struct device_attribute =
*attr,
>                                                  const char *buf,
> @@ -1532,6 +1550,19 @@ static ssize_t amdgpu_gfx_set_run_cleaner_shader(s=
truct device *dev,
>         return count;
>  }
>
> +/**
> + * amdgpu_gfx_get_enforce_isolation - Query AMDGPU GFX Enforce Isolation=
 Settings
> + * @dev: The device structure
> + * @attr: The device attribute structure
> + * @buf: The buffer to store the output data
> + *
> + * Provides the sysfs read interface to get the current settings of the =
'enforce_isolation'
> + * feature for each GPU partition. Reading from the 'enforce_isolation'
> + * sysfs file returns the isolation settings for all partitions, where '=
0'
> + * indicates disabled and '1' indicates enabled.
> + *
> + * Return: The number of bytes read from the sysfs file.
> + */
>  static ssize_t amdgpu_gfx_get_enforce_isolation(struct device *dev,
>                                                 struct device_attribute *=
attr,
>                                                 char *buf)
> @@ -1555,6 +1586,20 @@ static ssize_t amdgpu_gfx_get_enforce_isolation(st=
ruct device *dev,
>         return size;
>  }
>
> +/**
> + * amdgpu_gfx_set_enforce_isolation - Control AMDGPU GFX Enforce Isolati=
on
> + * @dev: The device structure
> + * @attr: The device attribute structure
> + * @buf: The buffer containing the input data
> + * @count: The size of the input data
> + *
> + * This function allows control over the 'enforce_isolation' feature, wh=
ich
> + * serializes access to the graphics engine. Writing '1' or '0' to the
> + * 'enforce_isolation' sysfs file enables or disables process isolation =
for
> + * each partition. The input should specify the setting for all partitio=
ns.
> + *
> + * Return: The number of bytes written to the sysfs file.
> + */
>  static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
>                                                 struct device_attribute *=
attr,
>                                                 const char *buf, size_t c=
ount)
> --
> 2.34.1
>
