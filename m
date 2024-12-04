Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B18DE7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:29:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E08D10E2A6;
	Wed,  4 Dec 2024 15:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pl/eE1iY";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E46F10E2A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:29:25 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-7fc9b94cad0so494129a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2024 07:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733326164; x=1733930964; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZdwB34r2eKYH5Pwgr2Y98v5+PFUCXLsffrBOpTj3uo=;
 b=Pl/eE1iY3O1dtYI0nqJM11zd1fKl8vcyuBKA2rxidxSOWfdIqv6LX3i6Nu7XNfmBSX
 oIgWEvTHAP1p6T64vJHCYtWgcBvnrhPuB60dN1kcAfU+GX+A/vctlvi/Nl2F87cT8CiL
 evdEV28s7HusHZfCe9fwFy8UWikYxSxMjq8sxw/2FSyY2JUMjvKUkE2Qx4ud9ThdCYb9
 0I4ubwMW+zXtBo2n6jiHWEHCEiuyra+EAGx3OAplUG2FaTNcAwgLIJJSxs4GpPSMjl8+
 vIyz5lwQpng2oPy7ri/Qyute+85lWapK1LXblKyhZvVhwxhx2If5vBI7s0GIYG7Hqm70
 Qblw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733326164; x=1733930964;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZdwB34r2eKYH5Pwgr2Y98v5+PFUCXLsffrBOpTj3uo=;
 b=K1oyrSVoopU9H598zJW4kLOl8696nfUq/egiuLVgpWvfWLbSwNYWcZQxPL5e0oilSC
 YNLyHdd9t6pvLcGNGz3u1c/EEQ4XulX0W16NxhJGu0CJoTg6fLzwpWpQjcJCWbCVo5WB
 cA4gOCBw5qbmTX3UJg8EC+kzrdC00//2P2Q2NIeigLxsgQG5GnMwNmVilHRCmYlDnfDG
 kScgzauGNGs9yUar4ZKZWj0knTrFbjcnJDImSVODq7t7I29zkKItae96hf2xRqJZr9Tg
 qa+5fbgJITWF/5RIxj64iw6RO9ixed8KRlqiZcNVQMt+pFIGJddv4NkeyQ5UcHdNnhnX
 smAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8LnF1Nr3vgO2jBequeurhcnGScKp2N1++LJ66O8jsGo6whCm0hjzlaARi4t+/Kfzks06EgtY0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7T202IuKbIqhDq9Kw7QwobtfYATYIISl404Y79Zuc7vRDcBPx
 AByrU/sXHZsg7ronyxmI0PcUam87KtXZQIN3kaQV4Nj2emS4uU2Qvka3RpnlTN/Fo0Wc6OlP/cR
 Wy7kFGlmwq5JB1brIlUpKQlAIZU4=
X-Gm-Gg: ASbGncvnL9ogzm6mMx1wLsIRaAl4PPTF05QbJ0q9GVYVIVM0a1SBSV32J02R4NaJ86U
 3viu+EVK2Mx6EopooM1tWgelrp0VV4+k=
X-Google-Smtp-Source: AGHT+IEc9FRmDChKjK9vKFPeKzJ2ouS2E10JqqpxfWnzWeyze8rH/9cYxGJc0Xb9Rei3U3mRaFySiXK2dCCue6hNLrI=
X-Received: by 2002:a17:90a:bd8d:b0:2ef:35de:708b with SMTP id
 98e67ed59e1d1-2ef35de88f2mr713038a91.4.1733326164330; Wed, 04 Dec 2024
 07:29:24 -0800 (PST)
MIME-Version: 1.0
References: <20241129135837.4070078-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241129135837.4070078-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Dec 2024 10:29:11 -0500
Message-ID: <CADnq5_N4oHk3LFVko8pSzfLb1SNwMgra3m08r42LP4u5Hm-b5Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Add Descriptions to Process Isolation and
 Cleaner Shader Sysfs Functions
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

On Fri, Nov 29, 2024 at 8:59=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This update adds explainations to key functions related to process

explanations

> isolation and cleaner shader execution sysfs interfaces.
>
> - `amdgpu_gfx_set_run_cleaner_shader`: Describes how to run the cleaner
>   shader via the sysfs interface in clearing the Local Data Store
> (LDS) and General Purpose Registers (GPRs).
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
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 45 +++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index e54f42e3797e..881a633bf0ab 100644
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
> + * This function allows manual execution of the cleaner shader, which is

Provides the sysfs interface to manually run a cleaner shader which is

> + * used to reset the GPU state between different tasks. Writing '0' to t=
he

s/reset/clear/

You say 0 here and then you say that the value corresponds to the
partition number later.  I'd condense this down to one sentence and
say that it is the partition.

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
> + * This function provides the current settings of the 'enforce_isolation=
'

This provides the sysfs read interface to get the current settings of
the 'enforce_isolation'

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

This provides the sysfs write interface for the 'enforce_isolation'
feature, which

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
