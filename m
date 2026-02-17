Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0C7E909CF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Feb 2026 16:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F2F10E502;
	Tue, 17 Feb 2026 16:02:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j3vZi/un";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F9410E502
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 16:02:51 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2b86a9613d8so419941eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Feb 2026 08:02:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771344170; cv=none;
 d=google.com; s=arc-20240605;
 b=NYg5O+4h7PYmlimoyJ1JFkxlAdJMIt/BaIcdpMAfHACBKy5+4wBY1Lz3MZlH13kEfO
 fagoR45XQevyULaF/LstPeQC4/scQQWBF7pgw+UCWvYN/Sid2fAl9gBo8i2/C9FyTOfD
 O2ufQVd87VFg1B0/1baLqkLlKf96RESsYShU5b8sIJ+kb6wDOQm/xgeGMSTlJ2fKs41U
 m+0FBLMI8tWsEKTSDhxVpLjCRhf1SGptpNg1sy9GZsTy/2dJ+AHX74D/5IPxw7T7Ulh7
 kD4E1fsD21oc3kmyT42ZyFMD3bjze4DiA4WwmFnWRkaenlbwIgnLSznGKuhn+9G1G9Ir
 4sHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ds5w4fDDQjAmUOKkCZAAHm6bwPF1jPuCREKc474PPb8=;
 fh=f82Ro5FfV7/IjDFkz5u1De3e/zrTiq6UiD8qCdhNCWs=;
 b=EXS/z9ePoidXvBB4FBKXkTg63DeeK2fI4JtZhXMBljpS2a53Hp3DD7EdRR7KIXZpUw
 oDFKfNrYMbseMy4W44HJ6eotHN9rQCjsfb2aliubqWIz9eMsvFO+EB+X8vfb9gc+bY3J
 ku81CN1AU7dG1p++PI2DT2JFNRXu2axEfrHE2OQwthMbq7Ppbg9gIXEDhHhnYXhM5dYZ
 TooId7VanjCMFagQsTy/NttOjs7w5WxPE3LW9vrC5ZBPf8sTbWEHDKzkzt0D+7ZnpFX4
 c3cMPfhUdP27t/fLYvQE0IiyC1C1/9bVltdYtdmXnIgjr4y7aqNMjD7fmihELZwcVFU8
 INDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771344170; x=1771948970; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ds5w4fDDQjAmUOKkCZAAHm6bwPF1jPuCREKc474PPb8=;
 b=j3vZi/unS9wJdm2vdx6TcIzxA2hCwhqvEKUpYFZvs/kbzCi2xZIBQRrVIpPMYK+JAJ
 0StUD/9LbPUK3suB6fWhs5ODWO0n6ziuZn/+YiBxumuqmGLwIdqq+Qn65uV8ZhWrvPce
 naCYEKgtgZbQy+65fpNAGLY5YRs5ksWYLcTp41gJA9um86M/aZjf6TFT6XSpGiE7c9gH
 4sHk1eJjF1PuWjuvhKQD2xdHSn644qjgdbBj9Zs7uuxKdURso/xI2zX4zJgl3gCZGm7x
 QtodQtBqNPotnHujGFP+W5sBYZeOnP3C5yP5t+RGKl+hTzKtZTYVfEZixLWWVeQ9PGgc
 EJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771344170; x=1771948970;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ds5w4fDDQjAmUOKkCZAAHm6bwPF1jPuCREKc474PPb8=;
 b=vmodjRHTnlUZsUdbH26eaovmVldT2VAfrPgYAxiqqvC00TFUK+9fpOE5PwGjQ6Y+JM
 5MP4eBWZ98lxz4GAB6ONb7ZBSrWM+dQmYekhdyvu7wgm5cRRhNdonLqxtkw8nmGoQE00
 H11yQ2z7e8tnDpy7gXmONRMIyIG7dPOoxt5IQC+9zxAO4g1Qb8UuTvJ9wxxEgD69PtnZ
 qmtgaqwZKAtUPgNWh6Nh6ERqCG3bp64rUaAgXsDKZT9qfV50FcsCt6IC/XjXhkASJav0
 3Qmacrhhx3Q7fXnnuQ7dJXN0SVPMhcBT2UEr3ff8a8hlasfoYfS6xkUNlAMzat2loMvT
 GuOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa4/KghoYHn19N5FdmoGOJTMBKn9xnG1CCI3pvEGhu9W80gWpBg3mIgMgXm3s1OFkhFhKBdjj9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzElGBlPMSpeqFRZjQS2Uvn4F3OuP2nCLS7ZBITQXtTGmPikWEZ
 mpN6zy1G/gWsHroX7nMLI6dUFbaj1LfB6Mmo8VmwNjGgny0RZPG+Jf3IbL81ES+rsz5MCgXlCvc
 t3SIVDLlD4gmgXkIAlqkZvxTgMaNOB+Y=
X-Gm-Gg: AZuq6aISfppLcQ+8B1EJeM0XHw/TJJ21EtQfrIX76GA0ePcjgk5xGMYum4e+KSGSs1L
 UDRib2r1GQbX9smsrF9fD+1uPQc5kiyvj+LY+ripIrN3AtzXe3vASy8bZb8KZd0LeO2mXt9Ha+f
 wBbKliO/q22bF089hX2YYyCB3fVLDxC8JFhdMUU8v1OXjHpQqPpPMfukXL7pjSwkGInGto4Dy3J
 KoRMvL76v/hpqck72zHn0c698dezJEaALlBUj42+ncG5RnazMyUG3Ri0LQniBsRj2YQuJp1jJPY
 Pe788ezHlbzbVQoqIOn2rLgdZkMI1/yoAA0vhAt18eqYw3948+56kG6fd+UPv2LQ9/uelA==
X-Received: by 2002:a05:7022:3f88:b0:127:1186:8139 with SMTP id
 a92af1059eb24-127399924b3mr2422472c88.7.1771344169843; Tue, 17 Feb 2026
 08:02:49 -0800 (PST)
MIME-Version: 1.0
References: <20260211102657.4180-1-pierre-eric.pelloux-prayer@amd.com>
 <20260211102657.4180-2-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260211102657.4180-2-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Feb 2026 11:02:37 -0500
X-Gm-Features: AaiRm52PCCSzU4QYVzs4N2Ex_L7aEWiZQn__J-gR4mjdzdGVpgCy8sdjxtXFQqk
Message-ID: <CADnq5_N8tOnB6TRTESD724F-X4_ak=f83qJ-cKSZX3ntmg9mkQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] drm/amdgpu: move devcoredump generation to a worker
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 11, 2026 at 5:28=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Update the way drm_coredump_printer is used based on its documentation
> and Xe's code: the main idea is to generate the final version in one go
> and then use memcpy to return the chunks requested by the caller of
> amdgpu_devcoredump_read.
>
> The generation is moved to a separate worker thread.
>
> This cuts the time to copy the dump from 40s to ~0s on my machine.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 66 +++++++++++++++++--
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  9 +++
>  3 files changed, 74 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 057c8bd2ad89..ae81a428cfb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1200,6 +1200,11 @@ struct amdgpu_device {
>
>         struct amdgpu_reset_domain      *reset_domain;
>
> +#ifdef CONFIG_DEV_COREDUMP
> +       /* If a coredump state capture is in progress don't start a new o=
ne. */
> +       bool coredump_in_progress;
> +#endif
> +
>         struct mutex                    benchmark_mutex;
>
>         bool                            scpm_enabled;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 42a969512dcc..0808ca98ccd9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -34,6 +34,8 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool s=
kip_vram_check,
>  }
>  #else
>
> +#define AMDGPU_CORE_DUMP_SIZE_MAX (256 * 1024 * 1024)
> +
>  const char *hw_ip_names[MAX_HWIP] =3D {
>         [GC_HWIP]               =3D "GC",
>         [HDP_HWIP]              =3D "HDP",
> @@ -196,11 +198,9 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu=
_device *adev,
>  }
>
>  static ssize_t
> -amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
> -                       void *data, size_t datalen)
> +amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_core=
dump_info *coredump)
>  {
>         struct drm_printer p;
> -       struct amdgpu_coredump_info *coredump =3D data;
>         struct drm_print_iterator iter;
>         struct amdgpu_vm_fault_info *fault_info;
>         struct amdgpu_ip_block *ip_block;
> @@ -208,7 +208,6 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, =
size_t count,
>
>         iter.data =3D buffer;
>         iter.offset =3D 0;
> -       iter.start =3D offset;
>         iter.remain =3D count;
>
>         p =3D drm_coredump_printer(&iter);
> @@ -323,11 +322,60 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset=
, size_t count,
>         return count - iter.remain;
>  }
>
> +static ssize_t
> +amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
> +                       void *data, size_t datalen)
> +{
> +       struct amdgpu_coredump_info *coredump =3D data;
> +       ssize_t byte_copied;
> +
> +       if (!coredump)
> +               return -ENODEV;
> +
> +       flush_work(&coredump->work);
> +
> +       if (!coredump->formatted)
> +               return -ENODEV;
> +
> +       if (offset >=3D coredump->formatted_size)
> +               return 0;
> +
> +       byte_copied =3D count < coredump->formatted_size - offset ? count=
 :
> +               coredump->formatted_size - offset;
> +       memcpy(buffer, coredump->formatted + offset, byte_copied);
> +
> +       return byte_copied;
> +}
> +
>  static void amdgpu_devcoredump_free(void *data)
>  {
> +       struct amdgpu_coredump_info *coredump =3D data;
> +
> +       cancel_work_sync(&coredump->work);
> +       coredump->adev->coredump_in_progress =3D false;
> +       kfree(coredump->formatted);
>         kfree(data);
>  }
>
> +static void amdgpu_devcoredump_deferred_work(struct work_struct *work)
> +{
> +       struct amdgpu_coredump_info *coredump =3D container_of(work, type=
of(*coredump), work);
> +
> +       dev_coredumpm(coredump->adev->dev, THIS_MODULE, coredump, 0, GFP_=
NOWAIT,
> +                     amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> +
> +       /* Do a one-time preparation of the coredump output because
> +        * repeatingly calling drm_coredump_printer is very slow.
> +        */
> +       coredump->formatted_size =3D
> +               amdgpu_devcoredump_format(NULL, AMDGPU_CORE_DUMP_SIZE_MAX=
, coredump);
> +       coredump->formatted =3D kvzalloc(coredump->formatted_size, GFP_KE=
RNEL);
> +       if (!coredump->formatted)
> +               return;
> +       amdgpu_devcoredump_format(coredump->formatted, coredump->formatte=
d_size, coredump);
> +       coredump->adev->coredump_in_progress =3D false;
> +}
> +
>  void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>                      bool vram_lost, struct amdgpu_job *job)
>  {
> @@ -335,10 +383,15 @@ void amdgpu_coredump(struct amdgpu_device *adev, bo=
ol skip_vram_check,
>         struct amdgpu_coredump_info *coredump;
>         struct drm_sched_job *s_job;
>
> +       if (adev->coredump_in_progress)
> +               return;
> +
>         coredump =3D kzalloc(sizeof(*coredump), GFP_NOWAIT);
>         if (!coredump)
>                 return;
>
> +       adev->coredump_in_progress =3D true;
> +
>         coredump->skip_vram_check =3D skip_vram_check;
>         coredump->reset_vram_lost =3D vram_lost;
>
> @@ -361,8 +414,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool=
 skip_vram_check,
>
>         ktime_get_ts64(&coredump->reset_time);
>
> -       dev_coredumpm(dev->dev, THIS_MODULE, coredump, 0, GFP_NOWAIT,
> -                     amdgpu_devcoredump_read, amdgpu_devcoredump_free);
> +       /* Kick off coredump formatting to a worker thread. */
> +       INIT_WORK(&coredump->work, amdgpu_devcoredump_deferred_work);
> +       queue_work(system_unbound_wq, &coredump->work);
>
>         drm_info(dev, "AMDGPU device coredump file has been created\n");
>         drm_info(dev, "Check your /sys/class/drm/card%d/device/devcoredum=
p/data\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> index ef9772c6bcc9..4c37a852b74a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> @@ -35,9 +35,18 @@ struct amdgpu_coredump_info {
>         struct amdgpu_device            *adev;
>         struct amdgpu_task_info         reset_task_info;
>         struct timespec64               reset_time;
> +
> +       struct work_struct work;
> +
>         bool                            skip_vram_check;
>         bool                            reset_vram_lost;
>         struct amdgpu_ring              *ring;
> +       /* Readable form of coredevdump, generate once to speed up
> +        * reading it (see drm_coredump_printer's documentation).
> +        */
> +       ssize_t                         formatted_size;
> +       char                            *formatted;
> +
>  };
>  #endif
>
> --
> 2.43.0
>
