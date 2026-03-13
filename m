Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269FA105F7A6
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 13:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA4AD10EBF5;
	Fri, 13 Mar 2026 13:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HSA3/x1+";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0146610EBEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:15:20 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-127337e3870so66993c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773407720; cv=none;
 d=google.com; s=arc-20240605;
 b=Lz6GPmRXeQSARH0sBswXXPipe1AMzFTqADqN7Ux/gyti50mUDGbXc20CAgiyNqJTAc
 RFR5d18ZQJ4aflhYikONbEI8Nvo9YuJaB46fyi2ULccMf6zcemHi3cqafPXILkeuDPFv
 89KI6tb4yy9wFW1sOIs8VZZ2SiTCDCnaGY5MputhI3ECB95hGOcWnpD9c03uWC6aHTR5
 tZb9Jww0mlswssvn7kCug/pcKHJf5+BuB2l6D0kMDv/cNcjL6uwsCXc8q+fqoywUM12E
 atLqbQuENdhuCAIYqE6Q/dCAQ73nKA8HhKj176nuI16xjrfRmiX5gF/33u9ItjWBy1CG
 Sx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yO+ph6jrCE9+/b5ByJF+pgk5N6AAQ/7AfdeVb/bmmL4=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=jO8QPlba6oivQEgQdR2EZ8knjorFCIBAMUtXc1smrPR5ebh77H6DIf41bUlF/E2580
 e2ekDC03pLU6dgd0sTPuKg4JWHlzcazqGNz9EyqQHrPlvLBabYsmvOAmEnUO2GdfPaox
 //1br7djKgqReXfEgZvmGV7jpNe5KlGcvfYVwS/GWw6JhEkGxwdw//m69T6DspdMngsX
 4GNiR9o8O1maOCIyrIpor1pNDopyWmq9cEqsUCtxCG6lCYJvcMynKX5G3utPJB34AsMv
 OmHVmEvPqpRcUA7Wmrt6BuLMDb7W2QfzssTVkGh25JeXxP/7wtU/CDrf9QmGbkc4aB+v
 fIEw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773407720; x=1774012520; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yO+ph6jrCE9+/b5ByJF+pgk5N6AAQ/7AfdeVb/bmmL4=;
 b=HSA3/x1+xCTnUEJkHljoO54n0ccanGuzSSl9Gs8s1sHito8dwCL/QuLHM6aobKVO87
 XtarVzVujFolkBjkUbLXJHDUnEA8j39VMz2LH5iNSw2wYIo0s4JKIhLe11ZPi2gFi1Vw
 Sl++RQxftd6sJzrVKEsoaNhWWvvNFsBpPqBXxdXontQ9xk8XzhMPg/cMJo2HbhYDpbsX
 7RW373B+2Di2gLicIi+5cnmz+chttINz3Hv9SlQM7gHTqnPDxyCnShBwLAqfkkzlqveu
 TeitIU7KP6iATwGKklFaMYar/Gg8YBkTQC4cdBQ112VHju/l9iqMQFusfbPtvrdRJso+
 OXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773407720; x=1774012520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yO+ph6jrCE9+/b5ByJF+pgk5N6AAQ/7AfdeVb/bmmL4=;
 b=G0X0qNRqW19mGZB82zUESJeW9hViCX3cjoVhLLaQ5tPh8+Xg8EGYuvykTTQ8dw07p3
 iPWdM9Mpqq2+cl4oSmcdPSI3WfpOloafAOufGJI2EV615LDyAbFt3Cg0mFNBbsaWzxxS
 O7Nwm3+N8IJHvk26NSn/qOUQapxyAKQA+yQvjSUmEH+Klmd/GuH6NGulsrAGq/xO9uAr
 XS8aoQXOvAHab6FsKAzxCHAQvxZTIvGkhto79hmYWCFzSZdoBP13S3t/Sm5+2at5sQJX
 7K0ymf0fGU5UVBZ6FDcai+6yKm0FAFl8LhuqCXhn0he2rb7k/5HZaXidnyApbqhNavig
 Kj8Q==
X-Gm-Message-State: AOJu0Yx3SoHFhmXyEclTbYwPCTYA2bmqBc6hHuxWUv/hQnznG4Sj4dT8
 MYKF619gn2YqC2rCSOnr7w4yDpG88ZFylCE3t6LDJmPywbfEDwR4y6DTgcRGYtKyNUhYqn/XhjW
 6El6ZUQ2dITPiWnRhfx9Y63wkQMlmZ5I=
X-Gm-Gg: ATEYQzxcsHaFWDgodh2vays6x3YwyLfQ/bnaxU9wqiBV7Osi33rKN2Tm9n3i/wrRztf
 4IVY6Iw5u/qhmNRFrTs+VaApHYVV7yXBSHrJAEgEfzCXCkut5S3QWa/2Pa23gMBbs6Z5zC0GMSn
 LgM/57+X6oAqq/of9hVT5/t4FFpPwjant6landPN4He7+7JYh8AJO42p93CwooSb4oVJCTJ92M8
 OUmUo/u2E9cWk93JgUTD9fKRKhnpBz2VXHpFrVmOlIoo/N/7DNdaM5cOveYgqlpnLQdKRXm8JUX
 1PfbFDCabqHxWbTRjfYSvqVBkrkSPbbxDfiSbL01bzMjnBBDFx+r2tVQKgvWD1cDCXrrdg==
X-Received: by 2002:a05:7022:f8c:b0:128:d81e:adb7 with SMTP id
 a92af1059eb24-128f3c6740emr770310c88.0.1773407719649; Fri, 13 Mar 2026
 06:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260313022840.1549516-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260313022840.1549516-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Mar 2026 09:15:07 -0400
X-Gm-Features: AaiRm50Ux4RtVSq4q6RfKLo6LKPO6AwsIwJKX_oDK47x__2oRawG0B9hSbuc-t0
Message-ID: <CADnq5_PD-3+LeRekno+59kGc8or2deHfnXEnaSoN-cOMdtNooA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix build errors due to declarations
 after labels
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
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

On Thu, Mar 12, 2026 at 10:54=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> In C90 (which the kernel uses with -std=3Dgnu89), declarations must
> appear at the beginning of a block and cannot follow a label. The
> switch cases in amdgpu_discovery.c and gmc_v12_1.c contained variable
> declarations immediately after case labels, causing the compiler to
> error:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:560:3: error: a label can
> only be part of a statement and a declaration is not a statement
> drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c:533:3: error: a label can only be
> part of a statement and a declaration is not a statement
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 ++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c        |  3 ++-
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  5 +++--
>  3 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index f77a03ea4d90..f3d0640d800e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -548,6 +548,11 @@ static int amdgpu_discovery_table_check(struct amdgp=
u_device *adev,
>         struct table_info *info;
>         bool check_table =3D true;
>         char *table_name;
> +       struct ip_discovery_header *ihdr;
> +       struct gpu_info_header *ghdr;
> +       struct harvest_info_header *hhdr;
> +       struct vcn_info_header *vhdr;
> +       struct mall_info_header *mhdr;
>
>         r =3D amdgpu_discovery_get_table_info(adev, &info, table_id);
>         if (r)
> @@ -557,7 +562,7 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>
>         switch (table_id) {
>         case IP_DISCOVERY:
> -               struct ip_discovery_header *ihdr =3D
> +               ihdr =3D
>                         (struct ip_discovery_header *)(discovery_bin + of=
fset);
>                 act_val =3D le32_to_cpu(ihdr->signature);
>                 exp_val =3D DISCOVERY_TABLE_SIGNATURE;
> @@ -565,7 +570,7 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_name =3D "data table";
>                 break;
>         case GC:
> -               struct gpu_info_header *ghdr =3D
> +               ghdr =3D
>                         (struct gpu_info_header *)(discovery_bin + offset=
);
>                 act_val =3D le32_to_cpu(ghdr->table_id);
>                 exp_val =3D GC_TABLE_ID;
> @@ -573,7 +578,7 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_name =3D "gc table";
>                 break;
>         case HARVEST_INFO:
> -               struct harvest_info_header *hhdr =3D
> +               hhdr =3D
>                         (struct harvest_info_header *)(discovery_bin + of=
fset);
>                 act_val =3D le32_to_cpu(hhdr->signature);
>                 exp_val =3D HARVEST_TABLE_SIGNATURE;
> @@ -581,7 +586,7 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_name =3D "harvest table";
>                 break;
>         case VCN_INFO:
> -               struct vcn_info_header *vhdr =3D
> +               vhdr =3D
>                         (struct vcn_info_header *)(discovery_bin + offset=
);
>                 act_val =3D le32_to_cpu(vhdr->table_id);
>                 exp_val =3D VCN_INFO_TABLE_ID;
> @@ -589,7 +594,7 @@ static int amdgpu_discovery_table_check(struct amdgpu=
_device *adev,
>                 table_name =3D "vcn table";
>                 break;
>         case MALL_INFO:
> -               struct mall_info_header *mhdr =3D
> +               mhdr =3D
>                         (struct mall_info_header *)(discovery_bin + offse=
t);
>                 act_val =3D le32_to_cpu(mhdr->table_id);
>                 exp_val =3D MALL_INFO_TABLE_ID;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_1.c
> index 38c366b9a88b..7ea7b9c30bca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -527,10 +527,11 @@ static void gmc_v12_1_get_coherence_flags(struct am=
dgpu_device *adev,
>         unsigned int mtype, mtype_local, mtype_remote;
>         bool snoop =3D false;
>         bool is_local =3D false;
> +       bool is_aid_a1;
>
>         switch (gc_ip_version) {
>         case IP_VERSION(12, 1, 0):
> -               bool is_aid_a1 =3D (adev->rev_id & 0x10);
> +               is_aid_a1 =3D (adev->rev_id & 0x10);
>
>                 mtype_local =3D is_aid_a1 ? MTYPE_RW : MTYPE_NC;
>                 mtype_remote =3D is_aid_a1 ? MTYPE_NC : MTYPE_UC;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 8167fe642341..9b4143328371 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1220,6 +1220,7 @@ svm_range_get_pte_flags(struct kfd_node *node, stru=
ct amdgpu_vm *vm,
>         bool coherent =3D flags & (KFD_IOCTL_SVM_FLAG_COHERENT | KFD_IOCT=
L_SVM_FLAG_EXT_COHERENT);
>         bool ext_coherent =3D flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
>         unsigned int mtype_local, mtype_remote;
> +       bool is_aid_a1, is_local;
>
>         if (domain =3D=3D SVM_RANGE_VRAM_DOMAIN)
>                 bo_node =3D prange->svm_bo->node;
> @@ -1307,8 +1308,8 @@ svm_range_get_pte_flags(struct kfd_node *node, stru=
ct amdgpu_vm *vm,
>                 mapping_flags |=3D AMDGPU_VM_MTYPE_NC;
>                 break;
>         case IP_VERSION(12, 1, 0):
> -               bool is_aid_a1 =3D (node->adev->rev_id & 0x10);
> -               bool is_local =3D (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) &=
&
> +               is_aid_a1 =3D (node->adev->rev_id & 0x10);
> +               is_local =3D (domain =3D=3D SVM_RANGE_VRAM_DOMAIN) &&
>                                 (bo_node->adev =3D=3D node->adev);
>
>                 mtype_local =3D amdgpu_mtype_local =3D=3D 0 ? AMDGPU_VM_M=
TYPE_RW :
> --
> 2.49.0
>
