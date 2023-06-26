Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C30EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 18:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD03F10E23F;
	Mon, 26 Jun 2023 18:55:43 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2AD10E23F
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 18:55:42 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a1a12e95b1so2737853b6e.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687805741; x=1690397741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pF++ZJcStVMwcg+sT2az0K3nlVT2a2zKgZJHwUd+4OM=;
 b=TZjop3QfJ+NdcwV6kaBGpGEaukcCGAJ0W/sJ0ONsK2rk4ZLcvdO5vvfJLv+HiKZ5jz
 c4Ml/7nBU8aF+JUPen5w0HBkVvVZDlF8MsBo8rbTg9iPvfzxPuT5K0oO0STtOcsF9/SI
 yz50epYdsP9ZibK+NX0mipfmk6Fo1/aEZJkbq03LwhnalLUWD+MHGHihfF2MlwiPsPBC
 8GpNTDkQPbOQO7JGM9h2jsmWPBg+NoltdgyNNheYc8H4FdJuy8fh8RheW7KubbLs5e7a
 y/rhpMmNEscSS996amApEngoAX5aIpg+8Chdzdm8EzCbe4wKcUN/xq6PYqzNpnT2+eaS
 h5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687805741; x=1690397741;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pF++ZJcStVMwcg+sT2az0K3nlVT2a2zKgZJHwUd+4OM=;
 b=iYuen3viZl8zTbSnkfEgvoZha4Gv8AlT5ix6+QdH4qfs1paj8dfCQmbUoAzkN2avRe
 so9RBsFvIKgjYj7ZcbkfzYxXY8yhVEZILZbVkyhcv453qUEV6JuqfWtwuuFdHN8r9s6V
 3XmMNhIJRoILSC6qjIHqXxW4kELSKHXJJ+OeldS5WUEnPA1Ske6zP89nfcQPOi4p1jDh
 i6uEZZPkAuOSRLzg0WH7NF6ne0SOFwZDuiw+r+sHcQoo5qMf9aInKiL1QCMDC2xlnvxr
 dkDYr+5cvwZFxCgZonm97MxByVW9OzEg8ket36ggPDN5qt23bZnjdoXZYKNWB6QT6H46
 EMrw==
X-Gm-Message-State: AC+VfDwemftqh1j2x3vFY7GZy1Xe+8IhJCmnoH39vf/Ex8WCDwMoLave
 fYb/mRQLRPerCASKGcHlwUQ4y3AN5Vyg12GK25s=
X-Google-Smtp-Source: ACHHUZ5vSJ/3U3SMY6K9ugvbLcWwJpLb0EvNTDNIAc97Oi31bMf9mFf3Y4kn5mpNqCYnkSkJvmXhkbUDIzwpso5suA8=
X-Received: by 2002:aca:b9c6:0:b0:39c:7f78:ba6d with SMTP id
 j189-20020acab9c6000000b0039c7f78ba6dmr18142547oif.19.1687805740778; Mon, 26
 Jun 2023 11:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230626150407.1447-1-mario.limonciello@amd.com>
 <20230626150407.1447-5-mario.limonciello@amd.com>
In-Reply-To: <20230626150407.1447-5-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Jun 2023 14:55:29 -0400
Message-ID: <CADnq5_OizgHEKchE+y39kZnARdmJ4fgsi4mvFzz3NcHg3NDyXA@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amd: Add documentation for how to flash a dGPU
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 26, 2023 at 11:04=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>

Needs a basic patch description.  Even just "add documentation"

With that fixed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/gpu/amdgpu/flashing.rst   | 33 +++++++++++++++++++++++++
>  Documentation/gpu/amdgpu/index.rst      |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++++++
>  3 files changed, 50 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/flashing.rst
>
> diff --git a/Documentation/gpu/amdgpu/flashing.rst b/Documentation/gpu/am=
dgpu/flashing.rst
> new file mode 100644
> index 0000000000000..bd745c42a538f
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/flashing.rst
> @@ -0,0 +1,33 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + dGPU firmware flashing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +IFWI
> +----
> +Flashing the dGPU integrated firmware image (IFWI) is supported by GPUs =
that
> +use the PSP to orchestrate the update (Navi3x or newer GPUs).
> +For supported GPUs, `amdgpu` will export a series of sysfs files that ca=
n be
> +used for the flash process.
> +
> +The IFWI flash process is:
> +
> +1. Ensure the IFWI image is intended for the dGPU on the system.
> +2. "Write" the IFWI image to the sysfs file `psp_vbflash`. This will sta=
ge the IFWI in memory.
> +3. "Read" from the `psp_vbflash` sysfs file to initiate the flash proces=
s.
> +4. Poll the `psp_vbflash_status` sysfs file to determine when the flash =
process completes.
> +
> +USB-C PD F/W
> +------------
> +On GPUs that support flashing an updated USB-C PD firmware image, the pr=
ocess
> +is done using the `usbc_pd_fw` sysfs file.
> +
> +* Reading the file will provide the current firmware version.
> +* Writing the name of a firmware payload stored in `/lib/firmware/amdgpu=
` to the sysfs file will initiate the flash process.
> +
> +The firmware payload stored in `/lib/firmware/amdgpu` can be named any n=
ame
> +as long as it doesn't conflict with other existing binaries that are use=
d by
> +`amdgpu`.
> +
> +sysfs files
> +-----------
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgp=
u/index.rst
> index 03c2966cae798..912e699fd3731 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -10,6 +10,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) a=
rchitectures.
>     module-parameters
>     driver-core
>     display/index
> +   flashing
>     xgmi
>     ras
>     thermal
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 7872004ed7f9b..047760bafcc23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -3476,6 +3476,11 @@ void psp_copy_fw(struct psp_context *psp, uint8_t =
*start_addr, uint32_t bin_size
>         drm_dev_exit(idx);
>  }
>
> +/**
> + * DOC: usbc_pd_fw
> + * Reading from this file will retrieve the USB-C PD firmware version. W=
riting to
> + * this file will trigger the update process.
> + */
>  static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
>                    psp_usbc_pd_fw_sysfs_read,
>                    psp_usbc_pd_fw_sysfs_write);
> @@ -3569,6 +3574,11 @@ static ssize_t amdgpu_psp_vbflash_read(struct file=
 *filp, struct kobject *kobj,
>         return 0;
>  }
>
> +/**
> + * DOC: psp_vbflash
> + * Writing to this file will stage an IFWI for update. Reading from this=
 file
> + * will trigger the update process.
> + */
>  static struct bin_attribute psp_vbflash_bin_attr =3D {
>         .attr =3D {.name =3D "psp_vbflash", .mode =3D 0660},
>         .size =3D 0,
> @@ -3576,6 +3586,12 @@ static struct bin_attribute psp_vbflash_bin_attr =
=3D {
>         .read =3D amdgpu_psp_vbflash_read,
>  };
>
> +/**
> + * DOC: psp_vbflash_status
> + * The status of the flash process.
> + * 0: IFWI flash not complete.
> + * 1: IFWI flash complete.
> + */
>  static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
>                                          struct device_attribute *attr,
>                                          char *buf)
> --
> 2.34.1
>
