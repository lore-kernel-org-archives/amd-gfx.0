Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F641CCD193
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Oct 2025 22:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC9910E90E;
	Wed, 15 Oct 2025 22:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iFXsrgi6";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2BDB10E90E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 22:14:23 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b632bf035d0so1880a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Oct 2025 15:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760566463; x=1761171263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vu4rsh9hb9GtsT0JQmubGdN5cw63saKtXKOmUq2cLmQ=;
 b=iFXsrgi6TT51r77nLDKVwrV3gs1ImiJFdI0NXaCjxl0iNUH5yoqXR8913qgRcQ7KbS
 Ntpag86JLZj570Dv7HVJxCchP2vQAZdij4pJBJOBWmvSerOoyW4/eDL025SxDVN/73Sq
 PEmnCHhqQb063Ilp97A5zZJ2HcYMhE0y2L6axgeWjlEN6hOsbVXNJHdCsGrg3CqBtmWz
 Pl4MwyGUrgkZMKV0HO1Ah8ip8YJE8L+EG72nUMjf0djGzQlq8hNWfeteeZljofIp07l5
 JYGtQpTFIwHmNLGC7ad6X1nf8cCXqOv5a377cta/opvhxUFCvM/SLDtyGYBamp80XPK7
 WD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566463; x=1761171263;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vu4rsh9hb9GtsT0JQmubGdN5cw63saKtXKOmUq2cLmQ=;
 b=WKat09EtcEKX859132zELWP0Gosq+o9b5bBycoXCP6JCzACDKWu2LD8bFT76YMdI/X
 V/fkXBwg4tzOexV0saD0byJg+E/SY1idMkMgUEe/Z4absX9ToArSNgbIv3Y/wKHNz1ei
 sowN39W+DZ7uBK+T0Rsh5/GVnUQGFaOxECPJvktqmouo3LuLBTIxb2oX14lILW4ZWX1N
 GT9q8KMMuIS/Kj5vQr35mU8b1V+c8M4WGMOh3Qt2b3Zgf9P8UQ66Z3wKjWHjR7qBT9my
 kzB+aG66ixTGGMCpWsiCvk1aB/58mY1Ei+vFNvx/2b+FFayziNHh65Uwvtj+DUw2ed0M
 VdiQ==
X-Gm-Message-State: AOJu0YycfQiNjRYkPzBX5cY9in9aCvKM4NSpvMG0vshEpH1kQGvOmeYv
 CrLOo7cNuqD/Pa25Z4DcatX8IjhmKTBwiI9NZHCzutnb/dHXJaHgRWJrYaNZ/8Yi/4/0rEi9FUe
 V/3/kDGD/HUZDBG6H5Fch3+USiyOWWBE=
X-Gm-Gg: ASbGnculgUxgddM/pepvkjvqrNkj0FfjKgF71IjadeebzRKK2iYCgz+2Qz3K3ZdMKwA
 rNaFREE7Pzu+6xmCtLZpcQTMb/Gj7jLvURsQKOk3LFbeMLFgAkfqnOjq4OOMBSePMSMluXNAEMl
 oFG8gzjS1JxeGsxo6WnZoxiomORpQiI93O6SRDtFJiIUiBznIDtySgUeZ8PIldYubP1DMQhRDR4
 XIWUKy3aTK0NlqxtPpRz05DF9udKLpX52e2CajpKaHcRs9d7mzH9giCp8/avZSsQQ+IQw8=
X-Google-Smtp-Source: AGHT+IHSNZjo2YeDoa0dePjvENDN3iqvQHP/td7E2SAPt0kQIajMoGCv+oSpJoGQ2cNQTgBKfb9bFqFSsdC0oth6928=
X-Received: by 2002:a17:902:ebc4:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-290869c0b93mr30495995ad.4.1760566463219; Wed, 15 Oct 2025
 15:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251015204920.1305839-1-mario.limonciello@amd.com>
In-Reply-To: <20251015204920.1305839-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Oct 2025 18:14:11 -0400
X-Gm-Features: AS18NWCec3JI1hjAh6gqy6dwVN3bvR60JDLGRUkHpg0xhi5tjmrrTM_-b09ZIdg
Message-ID: <CADnq5_P57TV2thkomGSOuHfiNFFEuQOeP9L8O2R9YpDGCQH0gA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Resume the device on suspend failures
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, Oct 15, 2025 at 5:06=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If the GPU fails to suspend the return code is passed up to the caller
> but it's left in an inconsistent state.  This could lead to hangs
> if userspace tries to access it.

Hmm, so the caller doesn't call the resume, etc. to restore things?  I
wonder if it would be better to call amdgpu_device_resume() in the
amdgpu internal callers rather than handling it in
amdgpu_device_suspend().  For example, does it make sense to restore
the working state in the shutdown() or poweroff() callbacks?  What
about the other way around.  E.g., if resume() fails, should we call
suspend again?

Alex

>
> Instead of leaving it in this state, attempt to resume using
> amdgpu_device_resume().  IP resume functions check the HW status
> and thus should only resume the IP that got suspended if a failure
> happened part way through.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4627
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index a99185ed0642..59672b880d75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5227,7 +5227,7 @@ void amdgpu_device_complete(struct drm_device *dev)
>  int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  {
>         struct amdgpu_device *adev =3D drm_to_adev(dev);
> -       int r =3D 0;
> +       int r, rec;
>
>         if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>                 return 0;
> @@ -5240,7 +5240,7 @@ int amdgpu_device_suspend(struct drm_device *dev, b=
ool notify_clients)
>                 amdgpu_virt_fini_data_exchange(adev);
>                 r =3D amdgpu_virt_request_full_gpu(adev, false);
>                 if (r)
> -                       return r;
> +                       goto resume;
>         }
>
>         if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DEV_D3))
> @@ -5255,16 +5255,16 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool notify_clients)
>
>         r =3D amdgpu_device_ip_suspend_phase1(adev);
>         if (r)
> -               return r;
> +               goto resume;
>
>         amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_r=
unpm);
>         r =3D amdgpu_userq_suspend(adev);
>         if (r)
> -               return r;
> +               goto resume;
>
>         r =3D amdgpu_device_evict_resources(adev);
>         if (r)
> -               return r;
> +               goto resume;
>
>         amdgpu_ttm_set_buffer_funcs_status(adev, false);
>
> @@ -5272,16 +5272,22 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool notify_clients)
>
>         r =3D amdgpu_device_ip_suspend_phase2(adev);
>         if (r)
> -               return r;
> +               goto resume;
>
>         if (amdgpu_sriov_vf(adev))
>                 amdgpu_virt_release_full_gpu(adev, false);
>
>         r =3D amdgpu_dpm_notify_rlc_state(adev, false);
>         if (r)
> -               return r;
> +               goto resume;
>
>         return 0;
> +resume:
> +       rec =3D amdgpu_device_resume(dev, notify_clients);
> +       if (rec)
> +               dev_err(adev->dev, "amdgpu_device_resume failed: %d\n", r=
ec);
> +
> +       return r;
>  }
>
>  static inline int amdgpu_virt_resume(struct amdgpu_device *adev)
> --
> 2.51.0
>
