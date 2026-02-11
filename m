Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C8AECD6EE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Feb 2026 22:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEBFF10E150;
	Wed, 11 Feb 2026 22:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HpTsInzX";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B56410E150
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 22:25:19 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2b866f98574so239602eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Feb 2026 14:25:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770848718; cv=none;
 d=google.com; s=arc-20240605;
 b=TmixBzBchP1eIkcRLn11iJ55iRriZBtmGy/B8jCklmNcBZxYl8regjkH002LmmUAJc
 bm/Oi4cXC9EjRhlInR+CzMl9hhs7d1ps1t7XaoSwjvPjlKwJ4tzi/BI40oMNFq2YllyD
 T4yS9BNDtZbMtuXrvxtU0akKTTVIiFqWme7iEIC3yK7D8Wr/Y7kBgeCZmbTnCflZLbrY
 eL2muie3yw8+Z3PIGjTSjI66EPOrL77YNVCRYfl226NuauuFQ3Hz9ZK2qfT4lGceDbUb
 4pZ00B/rhlbzucgZMlCKCGATsiYL9DeAT0i8QCL0m4TqZlq9GFyhMpLIBvSf9JwBXNnM
 7KFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mvJ/kNwXJQQUOZbmlVapXJSYVpRbuZURbVAoachPsTc=;
 fh=vYmPrD16r6pn95+qUHy/jbH8wmGINh7f+m4dVjFbbyA=;
 b=etb2cHUZd+HisAaGFmcRcdounKE6ue9mSzmv1kgxbPEZl9oJJB5QZkMUoJQJPJMcE/
 CuuG0E1Qhck8G4vUJe1cuZeO4FZmQSYDadZhtilFURLCG5zCnDW4Ppf/tJEGmbCFRzcm
 JH0q95ozJYi9eA2UC4yv6puJv3sszXgMJQO7LkOxhmDpOUZnKA82NeENcIieMd++Prt6
 hv2dMTu+7vHGiHjZQqq82B2AZHKoKOWsC+ZQ6nbsvU4Jh8Jkj3Ithgbs4nk4qEZXfPtV
 VypRHxCC8QTqZz3wZBouoJ5844PispNxvBhG87RXhqlZs/VKlH2fWzkkVC5Rs5CtRIzs
 QSmg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770848718; x=1771453518; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mvJ/kNwXJQQUOZbmlVapXJSYVpRbuZURbVAoachPsTc=;
 b=HpTsInzXVvqYRTQWSPavqcORFsJj6X9XhooLCVY2r40Y2JSzv531rHi+QMdmYY0Cnj
 8pCwTE68Ok3S3eDS6MRaDxWvLqWbylryIUB2hKSLuvmqL+/7CMxdVZLQ82mKipBOHVTt
 /rwZYIu0C0i/n5zygbJE2KwFTVGHjHYumfGrYInoT/Ety4uWnkUpCbOpn3aMCNW6mNnQ
 BL4h2GwcwnRSD7ucAtrsvJABoTczlTPaDPqqcAsmqG0KoPtSV202h3SRk7fI/4T3AbCD
 m5jybu3kng19HmRVjw3YVtW3+OgrlAi1eVpPzYkVyAMsV/IVsnZr4XeDy+bfq8y/9Dxt
 udmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848718; x=1771453518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mvJ/kNwXJQQUOZbmlVapXJSYVpRbuZURbVAoachPsTc=;
 b=GiuDtwGSBxStA2Q35uXMVZQhjattnXibBsQKp0XC1Qd6QoCgVv+pXeYXicxHYqMDSX
 RxXBMvsnkO2Ass9bTqd0TobssMIycAetY8K3nyuFKvrelep51OCG+rbTeFJOwALR1v77
 1v7/9zLMUaY9n6gmp1xhMtHDy5aQlBN7xstMU5goUUB1OvrksoFlQqLeSwCUcAkrpHd4
 1OeLu+GbQNbI0zRUf4diyZhcVvqCPdhUI7Phd8sV2TqvQp1uRbDbqNbd2J8CvPMUZYyf
 JYfCnEDb26XKQ2HEXaW7gT9HiDtZhePIXzdXUsXh+KLOBGWHLk4ZYQbUIZ9g2aL2iE+f
 V2Eg==
X-Gm-Message-State: AOJu0YxR60JLYXIVwkuVyhpv8/vP+nAcCg+K2I6ElFwkClNAXc45FsUg
 /i1Fee2ivMCb8IRktvHktkXF9rU4P+H3VzKNmCfa9mk18YmfeaFEzwQTAgNVRqlwX+UcFJGda/X
 0aiAesNtQXpMiL10TmVwIlF8KcF+AwSE=
X-Gm-Gg: AZuq6aKOWtP+LrPBI9thyQGsLkQT5CTZMETIhZz5DOJeR+UVm0vnmbpGtalX8/pD9jy
 HPPp8GSRc+pJIamPbXqnFFHVkXHW+MGOQI1ce+sIXNfRZXN9QxLl5VrvptaHbpXsMSCHd5BXFO+
 itDTQCczZsJWgebIeKc+01lenEeuQ9qmyYxO0PDohxCrsz2CBafS5x7IDlM+Oq9KNvyvPy3+Twt
 ON6RQ7fvSmFvRz2yqzmmfQb8EGw0G3Bq60uL/yqKOyV9AMK2c43caeers/Jg2HgClsashDLelhs
 U9cvDIOc
X-Received: by 2002:a05:7022:6ba0:b0:123:308f:667b with SMTP id
 a92af1059eb24-1272f73bb50mr170406c88.2.1770848718142; Wed, 11 Feb 2026
 14:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20260211221336.1443070-1-mario.limonciello@amd.com>
In-Reply-To: <20260211221336.1443070-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Feb 2026 17:25:06 -0500
X-Gm-Features: AZwV_QhZPrgAQM6_CN2Y9NcIc9A-ac3dgh5vJf-PcESJE5Av5xYB6Z1JTeigvqo
Message-ID: <CADnq5_Ok927jfPuPw0OUg97Q2pa2uymQfeWFVrvuBfiMDCGXpA@mail.gmail.com>
Subject: Re: [RFC] amdkfd: Add GPU family name property to KFD topology
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Stella.Laurenzo@amd.com, 
 Slobodan.Josic@amd.com, Filip.Jankovic@amd.com
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

On Wed, Feb 11, 2026 at 5:14=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Add a new 'gpu_family' property to the KFD topology sysfs interface that
> exposes the GPU family name in ROCm TheRock format (e.g., gfx110X, gfx90X=
).
>
> The property is algorithmically derived from gfx_target_version, which
> encodes the version as MMMNNRR (major.minor.revision). The family name
> follows the pattern "gfx{major}{minor}X", making it easy for users and
> tools to identify which ROCm compiler target to use.
>
> The property only appears for GFX9 and newer GPUs, as older generations
> predate TheRock targets. Unknown or unsupported GPUs will not display
> the property.
>
> Example usage:
>   $ cat /sys/class/kfd/kfd/topology/nodes/1/properties | grep gpu_family
>   gpu_family gfx115X

I would call this isa_version or isa_family.  gfx_target_version is
the ISA version of a chip (i.e., the compiler target).  It's not the
same as the GC IP version or the chip family.  That should help
differentiate it and avoid confusion.

Alex

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> The idea is that this can help a user figure out which wheels they need
> for their hardware.
>
> Cc: Stella.Laurenzo@amd.com
> Cc: Slobodan.Josic@amd.com
> Cc: Filip.Jankovic@amd.com
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 37 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.h |  1 +
>  2 files changed, 38 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 08c63b4cc9a5f..ab029d87eb9ea 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -471,6 +471,9 @@ static ssize_t node_show(struct kobject *kobj, struct=
 attribute *attr,
>                               dev->node_props.max_slots_scratch_cu);
>         sysfs_show_32bit_prop(buffer, offs, "gfx_target_version",
>                               dev->node_props.gfx_target_version);
> +       if (dev->node_props.gpu_family[0])
> +               sysfs_show_gen_prop(buffer, offs, "gpu_family %s\n",
> +                                   dev->node_props.gpu_family);
>         sysfs_show_32bit_prop(buffer, offs, "vendor_id",
>                               dev->node_props.vendor_id);
>         sysfs_show_32bit_prop(buffer, offs, "device_id",
> @@ -2048,6 +2051,37 @@ static void kfd_topology_set_capabilities(struct k=
fd_topology_device *dev)
>         kfd_topology_set_dbg_firmware_support(dev);
>  }
>
> +/**
> + * kfd_get_gpu_family_name - Get GPU family name from gfx_target_version
> + * @gfx_target_version: Numeric GPU target version
> + * @family_name: Output buffer for family name
> + * @size: Size of output buffer
> + *
> + * Converts gfx_target_version to TheRock family format (e.g., "gfx110X"=
).
> + * The gfx_target_version encodes version as MMMNNRR where:
> + *   MMM =3D major version
> + *   NN  =3D minor version
> + *   RR  =3D revision
> + * Family format is "gfx{major}{minor}X", e.g., 110501 (11.5.01) -> "gfx=
115X"
> + * If the version is not recognized, family_name is set to empty string.
> + */
> +static void kfd_get_gpu_family_name(uint32_t gfx_target_version,
> +                                   char *family_name, size_t size)
> +{
> +       int major, minor;
> +
> +       /* Only support TheRock GPU families (GFX9 and newer) */
> +       if (gfx_target_version < 90000) {
> +               family_name[0] =3D '\0';
> +               return;
> +       }
> +
> +       major =3D gfx_target_version / 10000;
> +       minor =3D (gfx_target_version / 100) % 100;
> +
> +       snprintf(family_name, size, "gfx%d%dX", major, minor);
> +}
> +
>  int kfd_topology_add_device(struct kfd_node *gpu)
>  {
>         uint32_t gpu_id;
> @@ -2105,6 +2139,9 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>
>         dev->node_props.gfx_target_version =3D
>                                 gpu->kfd->device_info.gfx_target_version;
> +       kfd_get_gpu_family_name(dev->node_props.gfx_target_version,
> +                               dev->node_props.gpu_family,
> +                               sizeof(dev->node_props.gpu_family));
>         dev->node_props.vendor_id =3D gpu->adev->pdev->vendor;
>         dev->node_props.device_id =3D gpu->adev->pdev->device;
>         dev->node_props.capability |=3D
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.h
> index 3de8ec0043bb4..8e52dd59b53dd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
> @@ -81,6 +81,7 @@ struct kfd_node_properties {
>         uint32_t eop_buffer_size;
>         uint32_t debug_memory_size;
>         char name[KFD_TOPOLOGY_PUBLIC_NAME_SIZE];
> +       char gpu_family[8];  /* GPU family name in TheRock format (e.g., =
gfx110X) */
>  };
>
>  struct kfd_mem_properties {
> --
> 2.53.0
>
