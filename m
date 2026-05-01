Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B443CCFA13
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2026 13:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B0A10F528;
	Fri,  1 May 2026 13:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZBYxQDh5";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D73B10F52F
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2026 13:36:08 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12734af2cdcso110933c88.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2026 06:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777642568; cv=none;
 d=google.com; s=arc-20240605;
 b=NpD75nokSxOcryqsCCq76xGFdFMJ3pfxeBb4Jdb0rr9rUbO7T4EioR3bnc1aOTUzDP
 mUUpcMEsHC0mVuJ+FMxyg63TiZVTyILRj1k1JXHp3O4nxSffDkWhlopHrFJ0BFC73Vl8
 /sl+psDSDFUy5P1XJx2s0XejjV8OwU4VoKIEIKnaPj/XvN52V9aAO9y/PZJ4pAM7yQY4
 TdFQNXrhgUhyI0Jj/NRpRnw0TZTR+vquVRNNLNZfn/MM2IJZGcXC1ZNmf4S0yZrcxG8L
 IU7RbjiujNEhps5LHVXgeUI0eU1Q/HO4TOf09tijhahL0XHpm1azlPZoxSM8cEy4lmFh
 /kSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AXu3Yp9XpZNE8yKAauzcnHFv3EF9+0OSIXsRf1B4DGE=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=Ov9QdVecYj/uCGDQ94J5T8LPEUPU3TbJIiIG7vXcoW3i/5lftpL4uculDYXDeCP0wz
 sIFM3BY6wevC9Kq8zW9IMP+aiQ6d/lWmZOvNZJS+Rw9fCgpVPCG7HS4AF75xf94p8ZPg
 2u6eGtuippjqGCHkzwTNRNCokseforUk68eYh+MY9+e5kkOPihdMNqAnDvZtovEMvmmb
 GenAzs7DCtSxCZlbdkfY6hsjVMDiQN2OvqOiPUhv7t7olJbPZrMpbu8OoMI4fqSYnqjl
 kaGxjD2CanxVywLePH/6Bj2d6x/3gkG3TB3E/rqWp+tFVuI1IZZzlPguUZqyd8s37tiy
 YJKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777642568; x=1778247368; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AXu3Yp9XpZNE8yKAauzcnHFv3EF9+0OSIXsRf1B4DGE=;
 b=ZBYxQDh5bwoZEuaC9/+Aaa2yv4XAG2QZrCA7mDj3m1t4azC70Th3GIfAXcvTMGUqQ/
 EdSa3tPezAvMTcpROzH7Ze3bQMLZBnjv+heuuYwOgSWRUjuFH2Qsv+LDvK6nggS0R+xd
 a45srpCD9gis7KyqHb3TFoIrLiUMI4kMt+Z3UXdWdoA61Fe6rbcJ/u1EDri1kVFOFdPb
 xq+AbDd3gIZK1eSukI95MJRrOvtXAQ/Ptr8nsAU9ZWo7x/dlOe1qBrUEphc/sdwgT+Un
 q4uCy7ntQW7O+hBbRFY9i5BO4ACCpusuyxy9tdMgiPv+t2B4Jc8yhK/gwH7FN7r8CB9P
 PL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777642568; x=1778247368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AXu3Yp9XpZNE8yKAauzcnHFv3EF9+0OSIXsRf1B4DGE=;
 b=iDwYqDh1kYBaUB9f+dVOF3J80jHoH7PE1znBHkpZ/w6VbZkwZxW+b953270a66I7m+
 Te0++Ig8tZSwIlzyRU6IUu21eHXyd1KIZDs5CuW/w0spSp2NrQ7mxDccC6s9eCiS49ER
 GidjSO/kPRIaL1UlA2/xzD4InNo9dv93RCgmajvKN5on5P1phR9akabAsrvaspvw7FSa
 cc8tsvnPqJhc2ASVRn5AsV9bXQrN00nKYniVnNURuEvptCB8JFUt8bY8CtamczG4TBrC
 FzxPAuojBmIRUq5MKXmGnI921ASp+Ut1Z4a+VfKu2sBX1TTanV5MItCxsJEXJfxahLUo
 18iQ==
X-Gm-Message-State: AOJu0YwADuRk+pfMUWm83XBubCa5kphBChqEjm0T/F2+Uq0R7bMo8VdQ
 GTLq+p5s26vED2LoRsm9B66bgZy4nFN1zKydzQMtvAxONnuD5FBtaYbV+m4jkwnG8ZzHtANI3DD
 5o1Yc6IkV9uwBmYgDpL08gvgcQKvgvvi4yowJ
X-Gm-Gg: AeBDieusnsUcs3uTZDHgk2gx0rLR1aGi7Zm45zdLyNup4YQKae1o1ysUwtH+V8+u3dN
 rAQijz3Fysjfd0LoVnC6bzazLArk6k7PtpVeof7EuFFYY1yXAtQudMJiZMne8uew58g44pxi9cr
 yfhc0TIB1w6OYzUyzCunrMxb88/RHAnjEgF4do1AXfhW140AjBn8PqCgny8DODnI2LeautsbZzb
 mnmske7ANnqEr69V1pU90x4g99l5xMkfrzT4b+DamZDosWpeHsdJTKS8eAdtKvdo9e259a0uuJ1
 OzzJHbmhudtAtvnn5++SW9TD1MLoUjg2G6QVBxqD0DuZd2VEAUzHGTnPyE41NZAnBt1clfjfohX
 H6Dpa
X-Received: by 2002:a05:7022:6291:b0:12d:b654:8180 with SMTP id
 a92af1059eb24-12deac6a39cmr1801807c88.2.1777642567789; Fri, 01 May 2026
 06:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
 <20260430161146.2851078-9-Jesse.Zhang@amd.com>
In-Reply-To: <20260430161146.2851078-9-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 May 2026 09:35:55 -0400
X-Gm-Features: AVHnY4IToKiII0Gv7yVIwBdrFdfwYaYQ1FBu0Dnp5km8wexDnOWyFsw3wU7_C5k
Message-ID: <CADnq5_NCSXtqJrgnXH3UiD=MkxEo+hJQjknAaO4LNmQToYH1VA@mail.gmail.com>
Subject: Re: [PATCH v4 09/10] drm/amdgpu/userq: report SDMA UMQ doorbell info
 via AMDGPU_INFO_DOORBELL
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, Apr 30, 2026 at 12:19=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> From: "Jesse.zhang" <Jesse.zhang@amd.com>
>
> Extend AMDGPU_INFO_DOORBELL with an AMDGPU_HW_IP_DMA case so userspace
> can discover:
>
>   - The SDMA UMQ doorbell BAR range (index_start..index_end), used to
>     validate per-queue doorbell offsets.
>   - Whether an aggregated doorbell slot exists in adev->agdb_bo
>     (agdb_enable) and its dword offset within that BO (agdb_offset).
>
> A user-mode driver opens the global aggregated-doorbell BO via
> AMDGPU_GEM_OP_OPEN_GLOBAL with AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL,
> mmaps it, and writes the queue's 32-bit WPTR at the byte offset
> agdb_offset * 4 to wake MES =E2=80=94 bypassing amdgpu_userq_signal_ioctl
> entirely.
>
> This is the user-visible half of moving the SDMA UMQ wake path out of
> the kernel.  The kernel-side wake is removed in a follow-up patch.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> --->  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index a3beeff800bf..1c6368d25b7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1437,6 +1437,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>                         doorbell_info.index_start =3D adev->doorbell_inde=
x.vcn.vcn_ring0_1 << 1;
>                         doorbell_info.index_end =3D (adev->doorbell_index=
.vcn.vcn_ring6_7 << 1) + 1;
>                         break;
> +               case AMDGPU_HW_IP_DMA:
> +                       if (adev->agdb_bo) {

I think this IOCTL should return an error adev->agdb_bo is NULL.  We
probably also need a per-IP flag to determine if the aggregated
doorbell is required or not.  That way we can easily support other IP
versions that may not require the aggregated doorbell.

Can you also add a patch to add doorbell info support for compute and
gfx for consistency?

Thanks,

Alex


> +                               doorbell_info.agdb_enable =3D 1;
> +                               doorbell_info.agdb_offset =3D adev->sdma.=
agdb_offset;
> +                       }
> +                       doorbell_info.index_start =3D
> +                               adev->doorbell_index.sdma_engine[0] << 1;
> +                       doorbell_info.index_end =3D
> +                               (adev->doorbell_index.sdma_engine[adev->s=
dma.num_instances - 1]
> +                                << 1) + 1;
> +                       break;
>                 default:
>                         return -EINVAL;
>                 }
> --
> 2.49.0
>
