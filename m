Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4DCD3E2BA
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2024 19:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF66F10E531;
	Mon, 28 Oct 2024 19:27:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VIVoNCuS";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12DD10E531
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 19:27:47 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-71e4c2e36d5so154780b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2024 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730143667; x=1730748467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SO15O8sgZBq50EdG+eigbp42F4ZVv0POlGk5+5TafE0=;
 b=VIVoNCuSx5DwFRiSkoH39Bq7aEhPTqd7mi3DPBMW6gNM1jhHCY+LgmBv4f5tIF7SCp
 szxVrEoqZEJFtykF54yRYQ7yjD8h095xTzXcRcF8av+WwaatRATrwBHk+gb0Mh895BrV
 U3EjDMCPjgG+9b/x+R3CmXOtapulnCTi4yZjTKVXp35eivMqcERsQQRAaf7I8iN5Xy5x
 UJE2/IuPAaOHaGP+27qrQMDFHhd98QQysao3zf3o1F/9AH4YlcCQLXKKm9hruP9PoDOa
 e6/0damGyCiVzS0yBsGktysSLfdrTX8GMlyYoj1GRTZriAYdUyQevyLI/ImFxZCSFSgy
 VE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730143667; x=1730748467;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SO15O8sgZBq50EdG+eigbp42F4ZVv0POlGk5+5TafE0=;
 b=LumFGfDSZTK/1gerBMoTKkXvdKlvReSJ2Y+GqDV+JEr0kVpdiSL8g873SqyS/DIOCK
 0GQMYMwxqRhLbib3YrFivy4lsbg8ML9/tP5N7Cr7vRMP7NMiOjAbxCKAjLlYvorYnqNz
 Be8mL9cEu1DA8O8CjxZS6b3w1ijdEKpWnLgErPV+TEOHrvdzf+soD/3Mtx1hNcOhThFF
 /TxlC2P4Psz7DG5G3/Nu+Zp4pkTFIR/gvTJznXVqQHGfCTPsMtTl+ZQCM2KgDqjE1XGR
 gbg+gS1xElDXYXFh+mE5qd0FeE4XtTp7HCCaOJDa0m5bYWI14/tMkV16xKLDovERcyPq
 Qtcw==
X-Gm-Message-State: AOJu0Yw6TgPNDraYR7LVicXIk0klrwRlDKedQyeMKZkpDwp8hRqMVk0A
 qSR9S8rS3YwDk5g1sQ5GvjaJTxo+FYTzs3GmIXHfPj8lRTfRDKO8JdRKbYPFs8FRfLv3N9Hbbqh
 cTsNXEfGrs6kRMVuMbUBX3pS2wLU=
X-Google-Smtp-Source: AGHT+IGLnYHKM6U5cwqBOrt6BW+fAafVhXj4moKxc/qITdBbk5O57HFxnQwEs0IDLlvTnEYkZN0HoBsBJZQEId7fPPw=
X-Received: by 2002:a05:6a00:4f91:b0:71e:5e9a:2db with SMTP id
 d2e1a72fcca58-72063060a1emr5748629b3a.6.1730143667306; Mon, 28 Oct 2024
 12:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
 <20241025023545.465886-10-boyuan.zhang@amd.com>
In-Reply-To: <20241025023545.465886-10-boyuan.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Oct 2024 15:27:35 -0400
Message-ID: <CADnq5_OQ=Nj_U5gYODLkHnoPpvKBpWrtVQynKJ=z=1E7_QUeBw@mail.gmail.com>
Subject: Re: [PATCH 09/29] drm/amdgpu: track instances of the same IP block
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

On Thu, Oct 24, 2024 at 10:48=E2=80=AFPM <boyuan.zhang@amd.com> wrote:
>
> From: Boyuan Zhang <boyuan.zhang@amd.com>
>
> Add a new function to count the number of instance of the same IP block
> in the current ip_block list, then use the returned count value to set
> the newly defined instance variable in ip_block, to track the instance
> number of each ip_block.
>
> Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 25 +++++++++++++++++++++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index fba10ad44be9..2e2c6a556cc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -390,6 +390,7 @@ struct amdgpu_ip_block {
>         struct amdgpu_ip_block_status status;
>         const struct amdgpu_ip_block_version *version;
>         struct amdgpu_device *adev;
> +       unsigned int instance;

Thinking towards future work, we should add a `bool harvested;` member
to the structure so that we can skip harvested instances in the common
code going forward.

Alex

>  };
>
>  int amdgpu_device_ip_block_version_cmp(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 7c06e3a9146c..065463b5d6a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2322,6 +2322,28 @@ int amdgpu_device_ip_block_version_cmp(struct amdg=
pu_device *adev,
>         return 1;
>  }
>
> +/**
> + * amdgpu_device_ip_get_num_instances - get number of instances of an IP=
 block
> + *
> + * @adev: amdgpu_device pointer
> + * @type: Type of hardware IP (SMU, GFX, UVD, etc.)
> + *
> + * Returns the count of the hardware IP blocks structure for that type.
> + */
> +static unsigned int
> +amdgpu_device_ip_get_num_instances(struct amdgpu_device *adev,
> +                                   enum amd_ip_block_type type)
> +{
> +       unsigned int i, count =3D 0;
> +
> +       for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +               if (adev->ip_blocks[i].version->type =3D=3D type)
> +                       count++;
> +       }
> +
> +       return count;
> +}
> +
>  /**
>   * amdgpu_device_ip_block_add
>   *
> @@ -2354,7 +2376,8 @@ int amdgpu_device_ip_block_add(struct amdgpu_device=
 *adev,
>                   ip_block_version->funcs->name);
>
>         adev->ip_blocks[adev->num_ip_blocks].adev =3D adev;
> -
> +       adev->ip_blocks[adev->num_ip_blocks].instance =3D
> +               amdgpu_device_ip_get_num_instances(adev, ip_block_version=
->type);
>         adev->ip_blocks[adev->num_ip_blocks++].version =3D ip_block_versi=
on;
>
>         return 0;
> --
> 2.34.1
>
