Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B9DC02198
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 20:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05AD910E3CE;
	Wed,  5 Feb 2025 20:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TJGlD+pS";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F23F10E3C2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 20:09:40 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2f45244a81fso20236a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2025 12:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738786180; x=1739390980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPYqi4iWnOAUgDyVJ7cu8qXLq/FlIcOhCSk+vsHXsRk=;
 b=TJGlD+pS3qstBvh/tObNz1+5sv0f5/fmxsyz3vgsxOQ5uDMw9TfQ4qrFGPzh/A8Bhc
 2uowGwLWn+Y60mcEkoZ1xbdkQwqRo7tCuG5W8KXGuzBs4YW+OQt53I0MpLA3bGJ8L5sI
 qQR/dOEBf/ord66LXRRyhmLPv89kcYmcfglJkLxbaPrJ6ZWOKrxHipR1iXfusUSO1Fre
 pcGJJ7iU0Lm5MIuUzTtCwYddyjERcyfMwC74+B4WkfKXrxKpHnv8l/es9yduw5jlbh9K
 uIO/o04yukc4nFZRYdBojBcUCYFERTNwCKyDWL0Kyx5F0nHAz1cCgYRoqWbjW/Yn8pN1
 j8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738786180; x=1739390980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPYqi4iWnOAUgDyVJ7cu8qXLq/FlIcOhCSk+vsHXsRk=;
 b=TQdEgrOKRgZQC92RYJdaJkXZ5GkAUqf15thvWtDSje4BX9DfHBZ3daObl3LsSGnlH9
 9FTVD5HAvzHP3RurPXVO678hsugc3jG8USiPzo9mI0FZhtQPv0vKH5H/yvERfr2/fL84
 EuzK5XjYCZRTxOpynlBib9JbzshhRdQRpMArVrYLcy91Gbr32FhDw45NOcZ68acMKb91
 PSxe5TgdcovEKNRlzy/ATPwf4AbSX51GtGhqAovVvkd3bcvY+TPhxXwismLWJcgHllsu
 0QqOADW5msg1Vj1Xqjk5QUqidqes4hr5zeEt3N8dDhggTNfLFaaaeLnvl9YFURvz0+0+
 X4HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKVxBohSVhkLsm8OaQrEVL/pDn12G1CUP4M1SQAHS/lFJHpIKazdafM78idpA3RxVLflfQnlj6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSe3Y9RqE7NBj++iDADlizISS8z+SZrhNvLqXkrl1lQVsVGEkA
 pkcijRIovEYgADeli1ADKHTkKlgwBLpIgGP/+mZr74UOSBUCALvAbE/9cEGicPEcwWiBQYShICu
 3oogwNdUS/pmNYUpGx5CbOP31azg=
X-Gm-Gg: ASbGncuJzTeS9hmF0+vq69YSuJWSm/5XzxLGGEOkMRykW17wXNtsJf8aTwOd+e4Pjyh
 pvA4qvktrNXn2MfSdFK+Y4YTZOA8TbeI9eKBQdPWyYbFkGb7B1BiKJ/pIEPYayqqo4+OekpyH
X-Google-Smtp-Source: AGHT+IHQ60USYxkvRjGRTh/QaEtwpGQ6nfDg0FCUILlqVCPJ8IZ3YPHn5LQ48nPgbzNN25m5GNIyBfoeoz2VmzgGjP0=
X-Received: by 2002:a17:90b:44:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2f9e074fa35mr2785779a91.1.1738786178744; Wed, 05 Feb 2025
 12:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
 <20250131165741.1798488-11-alexander.deucher@amd.com>
 <a034d63d-503b-41ae-a549-206ed0033640@amd.com>
In-Reply-To: <a034d63d-503b-41ae-a549-206ed0033640@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Feb 2025 15:09:26 -0500
X-Gm-Features: AWEUYZm-zAPkPWjPpIsCPc5GfgeVNcHbI4am6FRAS0CBEoNg7bWBjABnfxflKtM
Message-ID: <CADnq5_NTDXP4ZcENhzN2W_JzLRPZ+099xs_523GHaYSn0npOsQ@mail.gmail.com>
Subject: Re: [PATCH 10/44] drm/amdgpu/vcn: move more instanced data to
 vcn_instance
To: Boyuan Zhang <Boyuan.Zhang@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 4, 2025 at 10:42=E2=80=AFPM Boyuan Zhang <Boyuan.Zhang@amd.com>=
 wrote:
>
>
> On 2025-01-31 11:57, Alex Deucher wrote:
> > Move more per instance data into the per instance structure.
> >
> > v2: index instances directly on vcn1.0 and 2.0 to make
> > it clear that they only support a single instance (Lijo)
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |   2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 196 ++++++++++++-----------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  17 +-
> >   drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c  |   4 +-
> >   drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  42 ++---
> >   drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  92 +++++------
> >   drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   |  51 +++---
> >   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   |  67 ++++----
> >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   |  19 ++-
> >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c |  14 +-
> >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c |  18 ++-
> >   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  16 +-
> >   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c |   8 +-
> >   13 files changed, 279 insertions(+), 267 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index 2c76bc5e25d92..5ee2ae66ed36b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -480,7 +480,7 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >                       if (adev->vcn.harvest_config & (1 << i))
> >                               continue;
> >
> > -                     for (j =3D 0; j < adev->vcn.num_enc_rings; j++)
> > +                     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings=
; j++)
> >                               if (adev->vcn.inst[i].ring_enc[j].sched.r=
eady)
> >                                       ++num_rings;
> >               }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vcn.c
> > index 0c3081a198d9e..9901b8e17f305 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > @@ -127,93 +127,88 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev=
)
> >       unsigned int fw_shared_size, log_offset;
> >       int i, r;
> >
> > -     mutex_init(&adev->vcn.vcn1_jpeg1_workaround);
> >       for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> > +             mutex_init(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
> >               mutex_init(&adev->vcn.inst[i].vcn_pg_lock);
> >               atomic_set(&adev->vcn.inst[i].total_submission_cnt, 0);
> >               INIT_DELAYED_WORK(&adev->vcn.inst[i].idle_work, amdgpu_vc=
n_idle_work_handler);
> >               atomic_set(&adev->vcn.inst[i].dpg_enc_submission_cnt, 0);
> > -     }
> > -
> > -     if ((adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) &&
> > -         (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> > -             adev->vcn.indirect_sram =3D true;
> > -
> > -     /*
> > -      * Some Steam Deck's BIOS versions are incompatible with the
> > -      * indirect SRAM mode, leading to amdgpu being unable to get
> > -      * properly probed (and even potentially crashing the kernel).
> > -      * Hence, check for these versions here - notice this is
> > -      * restricted to Vangogh (Deck's APU).
> > -      */
> > -     if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSION(3, 0, =
2)) {
> > -             const char *bios_ver =3D dmi_get_system_info(DMI_BIOS_VER=
SION);
> > -
> > -             if (bios_ver && (!strncmp("F7A0113", bios_ver, 7) ||
> > -                  !strncmp("F7A0114", bios_ver, 7))) {
> > -                     adev->vcn.indirect_sram =3D false;
> > -                     dev_info(adev->dev,
> > -                             "Steam Deck quirk: indirect SRAM disabled=
 on BIOS %s\n", bios_ver);
> > +             if ((adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_PSP) =
&&
> > +                 (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
> > +                     adev->vcn.inst[i].indirect_sram =3D true;
> > +
> > +             /*
> > +              * Some Steam Deck's BIOS versions are incompatible with =
the
> > +              * indirect SRAM mode, leading to amdgpu being unable to =
get
> > +              * properly probed (and even potentially crashing the ker=
nel).
> > +              * Hence, check for these versions here - notice this is
> > +              * restricted to Vangogh (Deck's APU).
> > +              */
> > +             if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D IP_VERSIO=
N(3, 0, 2)) {
> > +                     const char *bios_ver =3D dmi_get_system_info(DMI_=
BIOS_VERSION);
> > +
> > +                     if (bios_ver && (!strncmp("F7A0113", bios_ver, 7)=
 ||
> > +                                      !strncmp("F7A0114", bios_ver, 7)=
)) {
> > +                             adev->vcn.inst[i].indirect_sram =3D false=
;
> > +                             dev_info(adev->dev,
> > +                                      "Steam Deck quirk: indirect SRAM=
 disabled on BIOS %s\n", bios_ver);
> > +                     }
> >               }
> > -     }
> >
> > -     /* from vcn4 and above, only unified queue is used */
> > -     adev->vcn.using_unified_queue =3D
> > -             amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(4, 0=
, 0);
> > -
> > -     hdr =3D (const struct common_firmware_header *)adev->vcn.inst[0].=
fw->data;
> > -     adev->vcn.fw_version =3D le32_to_cpu(hdr->ucode_version);
> > -
> > -     /* Bit 20-23, it is encode major and non-zero for new naming conv=
ention.
> > -      * This field is part of version minor and DRM_DISABLED_FLAG in o=
ld naming
> > -      * convention. Since the l:wq!atest version minor is 0x5B and DRM=
_DISABLED_FLAG
> > -      * is zero in old naming convention, this field is always zero so=
 far.
> > -      * These four bits are used to tell which naming convention is pr=
esent.
> > -      */
> > -     fw_check =3D (le32_to_cpu(hdr->ucode_version) >> 20) & 0xf;
> > -     if (fw_check) {
> > -             unsigned int dec_ver, enc_major, enc_minor, vep, fw_rev;
> > -
> > -             fw_rev =3D le32_to_cpu(hdr->ucode_version) & 0xfff;
> > -             enc_minor =3D (le32_to_cpu(hdr->ucode_version) >> 12) & 0=
xff;
> > -             enc_major =3D fw_check;
> > -             dec_ver =3D (le32_to_cpu(hdr->ucode_version) >> 24) & 0xf=
;
> > -             vep =3D (le32_to_cpu(hdr->ucode_version) >> 28) & 0xf;
> > -             DRM_INFO("Found VCN firmware Version ENC: %u.%u DEC: %u V=
EP: %u Revision: %u\n",
> > -                     enc_major, enc_minor, dec_ver, vep, fw_rev);
> > -     } else {
> > -             unsigned int version_major, version_minor, family_id;
> > +             /* from vcn4 and above, only unified queue is used */
> > +             adev->vcn.inst[i].using_unified_queue =3D
> > +                     amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERS=
ION(4, 0, 0);
> > +
> > +             hdr =3D (const struct common_firmware_header *)adev->vcn.=
inst[i].fw->data;
> > +             adev->vcn.inst[i].fw_version =3D le32_to_cpu(hdr->ucode_v=
ersion);
> > +             adev->vcn.fw_version =3D le32_to_cpu(hdr->ucode_version);
> > +
> > +             /* Bit 20-23, it is encode major and non-zero for new nam=
ing convention.
> > +              * This field is part of version minor and DRM_DISABLED_F=
LAG in old naming
> > +              * convention. Since the l:wq!atest version minor is 0x5B=
 and DRM_DISABLED_FLAG
> > +              * is zero in old naming convention, this field is always=
 zero so far.
> > +              * These four bits are used to tell which naming conventi=
on is present.
> > +              */
> > +             fw_check =3D (le32_to_cpu(hdr->ucode_version) >> 20) & 0x=
f;
> > +             if (fw_check) {
> > +                     unsigned int dec_ver, enc_major, enc_minor, vep, =
fw_rev;
> > +
> > +                     fw_rev =3D le32_to_cpu(hdr->ucode_version) & 0xff=
f;
> > +                     enc_minor =3D (le32_to_cpu(hdr->ucode_version) >>=
 12) & 0xff;
> > +                     enc_major =3D fw_check;
> > +                     dec_ver =3D (le32_to_cpu(hdr->ucode_version) >> 2=
4) & 0xf;
> > +                     vep =3D (le32_to_cpu(hdr->ucode_version) >> 28) &=
 0xf;
> > +                     DRM_INFO("Found VCN firmware Version ENC: %u.%u D=
EC: %u VEP: %u Revision: %u\n",
> > +                              enc_major, enc_minor, dec_ver, vep, fw_r=
ev);
> > +             } else {
> > +                     unsigned int version_major, version_minor, family=
_id;
> >
> > -             family_id =3D le32_to_cpu(hdr->ucode_version) & 0xff;
> > -             version_major =3D (le32_to_cpu(hdr->ucode_version) >> 24)=
 & 0xff;
> > -             version_minor =3D (le32_to_cpu(hdr->ucode_version) >> 8) =
& 0xff;
> > -             DRM_INFO("Found VCN firmware Version: %u.%u Family ID: %u=
\n",
> > -                     version_major, version_minor, family_id);
> > -     }
> > +                     family_id =3D le32_to_cpu(hdr->ucode_version) & 0=
xff;
> > +                     version_major =3D (le32_to_cpu(hdr->ucode_version=
) >> 24) & 0xff;
> > +                     version_minor =3D (le32_to_cpu(hdr->ucode_version=
) >> 8) & 0xff;
> > +                     DRM_INFO("Found VCN firmware Version: %u.%u Famil=
y ID: %u\n",
> > +                              version_major, version_minor, family_id)=
;
> > +             }
> >
> > -     bo_size =3D AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SIZE;
> > -     if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
> > -             bo_size +=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode=
_size_bytes) + 8);
> > +             bo_size =3D AMDGPU_VCN_STACK_SIZE + AMDGPU_VCN_CONTEXT_SI=
ZE;
> > +             if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
> > +                     bo_size +=3D AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hd=
r->ucode_size_bytes) + 8);
> >
> > -     if (amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(5, 0, 0)=
) {
> > -             fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(struct am=
dgpu_vcn5_fw_shared));
> > -             log_offset =3D offsetof(struct amdgpu_vcn5_fw_shared, fw_=
log);
> > -     } else if (amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(4=
, 0, 0)) {
> > -             fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(struct am=
dgpu_vcn4_fw_shared));
> > -             log_offset =3D offsetof(struct amdgpu_vcn4_fw_shared, fw_=
log);
> > -     } else {
> > -             fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(struct am=
dgpu_fw_shared));
> > -             log_offset =3D offsetof(struct amdgpu_fw_shared, fw_log);
> > -     }
> > -
> > -     bo_size +=3D fw_shared_size;
> > +             if (amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_VERSION(=
5, 0, 0)) {
> > +                     fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(s=
truct amdgpu_vcn5_fw_shared));
> > +                     log_offset =3D offsetof(struct amdgpu_vcn5_fw_sha=
red, fw_log);
> > +             } else if (amdgpu_ip_version(adev, UVD_HWIP, 0) >=3D IP_V=
ERSION(4, 0, 0)) {
> > +                     fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(s=
truct amdgpu_vcn4_fw_shared));
> > +                     log_offset =3D offsetof(struct amdgpu_vcn4_fw_sha=
red, fw_log);
> > +             } else {
> > +                     fw_shared_size =3D AMDGPU_GPU_PAGE_ALIGN(sizeof(s=
truct amdgpu_fw_shared));
> > +                     log_offset =3D offsetof(struct amdgpu_fw_shared, =
fw_log);
> > +             }
> >
> > -     if (amdgpu_vcnfw_log)
> > -             bo_size +=3D AMDGPU_VCNFW_LOG_SIZE;
> > +             bo_size +=3D fw_shared_size;
> >
> > -     for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> > -             if (adev->vcn.harvest_config & (1 << i))
> > -                     continue;
> > +             if (amdgpu_vcnfw_log)
> > +                     bo_size +=3D AMDGPU_VCNFW_LOG_SIZE;
> >
> >               r =3D amdgpu_bo_create_kernel(adev, bo_size, PAGE_SIZE,
> >                                           AMDGPU_GEM_DOMAIN_VRAM |
> > @@ -239,7 +234,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
> >                       adev->vcn.inst[i].fw_shared.log_offset =3D log_of=
fset;
> >               }
> >
> > -             if (adev->vcn.indirect_sram) {
> > +             if (adev->vcn.inst[i].indirect_sram) {
> >                       r =3D amdgpu_bo_create_kernel(adev, 64 * 2 * 4, P=
AGE_SIZE,
> >                                       AMDGPU_GEM_DOMAIN_VRAM |
> >                                       AMDGPU_GEM_DOMAIN_GTT,
> > @@ -277,15 +272,14 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev=
)
> >
> >               amdgpu_ring_fini(&adev->vcn.inst[j].ring_dec);
> >
> > -             for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> > +             for (i =3D 0; i < adev->vcn.inst[j].num_enc_rings; ++i)
> >                       amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
> >
> >               amdgpu_ucode_release(&adev->vcn.inst[j].fw);
> >               mutex_destroy(&adev->vcn.inst[j].vcn_pg_lock);
> > +             mutex_destroy(&adev->vcn.inst[j].vcn1_jpeg1_workaround);
> >       }
> >
> > -     mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
> > -
> >       return 0;
> >   }
> >
> > @@ -404,12 +398,12 @@ static void amdgpu_vcn_idle_work_handler(struct w=
ork_struct *work)
> >       if (adev->vcn.harvest_config & (1 << i))
> >               return;
> >
> > -     for (j =3D 0; j < adev->vcn.num_enc_rings; ++j)
> > +     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
> >               fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ring_=
enc[j]);
> >
> >       /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> > -         !adev->vcn.using_unified_queue) {
> > +         !adev->vcn.inst[i].using_unified_queue) {
> >               struct dpg_pause_state new_state;
> >
> >               if (fence[i] ||
> > @@ -418,7 +412,7 @@ static void amdgpu_vcn_idle_work_handler(struct wor=
k_struct *work)
> >               else
> >                       new_state.fw_based =3D VCN_DPG_STATE__UNPAUSE;
> >
> > -             adev->vcn.pause_dpg_mode(adev, i, &new_state);
> > +             adev->vcn.inst[i].pause_dpg_mode(adev, i, &new_state);
> >       }
> >
> >       fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst->ring_dec);
> > @@ -456,7 +450,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)
> >
> >       /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> > -         !adev->vcn.using_unified_queue) {
> > +         !adev->vcn.inst[ring->me].using_unified_queue) {
> >               struct dpg_pause_state new_state;
> >
> >               if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_ENC) {
> > @@ -466,7 +460,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)
> >                       unsigned int fences =3D 0;
> >                       unsigned int i;
> >
> > -                     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> > +                     for (i =3D 0; i < adev->vcn.inst[ring->me].num_en=
c_rings; ++i)
> >                               fences +=3D amdgpu_fence_count_emitted(&a=
dev->vcn.inst[ring->me].ring_enc[i]);
> >
> >                       if (fences || atomic_read(&adev->vcn.inst[ring->m=
e].dpg_enc_submission_cnt))
> > @@ -475,7 +469,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *=
ring)
> >                               new_state.fw_based =3D VCN_DPG_STATE__UNP=
AUSE;
> >               }
> >
> > -             adev->vcn.pause_dpg_mode(adev, ring->me, &new_state);
> > +             adev->vcn.inst[ring->me].pause_dpg_mode(adev, ring->me, &=
new_state);
> >       }
> >       mutex_unlock(&adev->vcn.inst[ring->me].vcn_pg_lock);
> >   }
> > @@ -487,7 +481,7 @@ void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ri=
ng)
> >       /* Only set DPG pause for VCN3 or below, VCN4 and above will be h=
andled by FW */
> >       if (ring->adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG &&
> >           ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_ENC &&
> > -         !adev->vcn.using_unified_queue)
> > +         !adev->vcn.inst[ring->me].using_unified_queue)
> >               atomic_dec(&ring->adev->vcn.inst[ring->me].dpg_enc_submis=
sion_cnt);
> >
> >       atomic_dec(&ring->adev->vcn.inst[ring->me].total_submission_cnt);
> > @@ -511,7 +505,7 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_rin=
g *ring)
> >       r =3D amdgpu_ring_alloc(ring, 3);
> >       if (r)
> >               return r;
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.scratch9, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.scratch9, 0));
> >       amdgpu_ring_write(ring, 0xDEADBEEF);
> >       amdgpu_ring_commit(ring);
> >       for (i =3D 0; i < adev->usec_timeout; i++) {
> > @@ -576,14 +570,14 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_=
ring *ring,
> >               goto err;
> >
> >       ib =3D &job->ibs[0];
> > -     ib->ptr[0] =3D PACKET0(adev->vcn.internal.data0, 0);
> > +     ib->ptr[0] =3D PACKET0(adev->vcn.inst[ring->me].internal.data0, 0=
);
> >       ib->ptr[1] =3D addr;
> > -     ib->ptr[2] =3D PACKET0(adev->vcn.internal.data1, 0);
> > +     ib->ptr[2] =3D PACKET0(adev->vcn.inst[ring->me].internal.data1, 0=
);
> >       ib->ptr[3] =3D addr >> 32;
> > -     ib->ptr[4] =3D PACKET0(adev->vcn.internal.cmd, 0);
> > +     ib->ptr[4] =3D PACKET0(adev->vcn.inst[ring->me].internal.cmd, 0);
> >       ib->ptr[5] =3D 0;
> >       for (i =3D 6; i < 16; i +=3D 2) {
> > -             ib->ptr[i] =3D PACKET0(adev->vcn.internal.nop, 0);
> > +             ib->ptr[i] =3D PACKET0(adev->vcn.inst[ring->me].internal.=
nop, 0);
> >               ib->ptr[i+1] =3D 0;
> >       }
> >       ib->length_dw =3D 16;
> > @@ -746,7 +740,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu=
_ring *ring,
> >       uint32_t ib_pack_in_dw;
> >       int i, r;
> >
> > -     if (adev->vcn.using_unified_queue)
> > +     if (adev->vcn.inst[ring->me].using_unified_queue)
> >               ib_size_dw +=3D 8;
> >
> >       r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
> > @@ -759,7 +753,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu=
_ring *ring,
> >       ib->length_dw =3D 0;
> >
> >       /* single queue headers */
> > -     if (adev->vcn.using_unified_queue) {
> > +     if (adev->vcn.inst[ring->me].using_unified_queue) {
> >               ib_pack_in_dw =3D sizeof(struct amdgpu_vcn_decode_buffer)=
 / sizeof(uint32_t)
> >                                               + 4 + 2; /* engine info +=
 decoding ib in dw */
> >               ib_checksum =3D amdgpu_vcn_unified_ring_ib_header(ib, ib_=
pack_in_dw, false);
> > @@ -778,7 +772,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu=
_ring *ring,
> >       for (i =3D ib->length_dw; i < ib_size_dw; ++i)
> >               ib->ptr[i] =3D 0x0;
> >
> > -     if (adev->vcn.using_unified_queue)
> > +     if (adev->vcn.inst[ring->me].using_unified_queue)
> >               amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, ib_pack=
_in_dw);
> >
> >       r =3D amdgpu_job_submit_direct(job, ring, &f);
> > @@ -876,7 +870,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amd=
gpu_ring *ring, uint32_t hand
> >       uint64_t addr;
> >       int i, r;
> >
> > -     if (adev->vcn.using_unified_queue)
> > +     if (adev->vcn.inst[ring->me].using_unified_queue)
> >               ib_size_dw +=3D 8;
> >
> >       r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
> > @@ -890,7 +884,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amd=
gpu_ring *ring, uint32_t hand
> >
> >       ib->length_dw =3D 0;
> >
> > -     if (adev->vcn.using_unified_queue)
> > +     if (adev->vcn.inst[ring->me].using_unified_queue)
> >               ib_checksum =3D amdgpu_vcn_unified_ring_ib_header(ib, 0x1=
1, true);
> >
> >       ib->ptr[ib->length_dw++] =3D 0x00000018;
> > @@ -912,7 +906,7 @@ static int amdgpu_vcn_enc_get_create_msg(struct amd=
gpu_ring *ring, uint32_t hand
> >       for (i =3D ib->length_dw; i < ib_size_dw; ++i)
> >               ib->ptr[i] =3D 0x0;
> >
> > -     if (adev->vcn.using_unified_queue)
> > +     if (adev->vcn.inst[ring->me].using_unified_queue)
> >               amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
> >
> >       r =3D amdgpu_job_submit_direct(job, ring, &f);
> > @@ -943,7 +937,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct am=
dgpu_ring *ring, uint32_t han
> >       uint64_t addr;
> >       int i, r;
> >
> > -     if (adev->vcn.using_unified_queue)
> > +     if (adev->vcn.inst[ring->me].using_unified_queue)
> >               ib_size_dw +=3D 8;
> >
> >       r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
> > @@ -957,7 +951,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct am=
dgpu_ring *ring, uint32_t han
> >
> >       ib->length_dw =3D 0;
> >
> > -     if (adev->vcn.using_unified_queue)
> > +     if (adev->vcn.inst[ring->me].using_unified_queue)
> >               ib_checksum =3D amdgpu_vcn_unified_ring_ib_header(ib, 0x1=
1, true);
> >
> >       ib->ptr[ib->length_dw++] =3D 0x00000018;
> > @@ -979,7 +973,7 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct am=
dgpu_ring *ring, uint32_t han
> >       for (i =3D ib->length_dw; i < ib_size_dw; ++i)
> >               ib->ptr[i] =3D 0x0;
> >
> > -     if (adev->vcn.using_unified_queue)
> > +     if (adev->vcn.inst[ring->me].using_unified_queue)
> >               amdgpu_vcn_unified_ring_ib_checksum(&ib_checksum, 0x11);
> >
> >       r =3D amdgpu_job_submit_direct(job, ring, &f);
> > @@ -1396,7 +1390,7 @@ void amdgpu_debugfs_vcn_sched_mask_init(struct am=
dgpu_device *adev)
> >       struct dentry *root =3D minor->debugfs_root;
> >       char name[32];
> >
> > -     if (adev->vcn.num_vcn_inst <=3D 1 || !adev->vcn.using_unified_que=
ue)
> > +     if (adev->vcn.num_vcn_inst <=3D 1 || !adev->vcn.inst[0].using_uni=
fied_queue)
> >               return;
> >       sprintf(name, "amdgpu_vcn_sched_mask");
> >       debugfs_create_file(name, 0600, root, adev,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vcn.h
> > index 0bcf4d1c7175d..3b059f51894b9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > @@ -322,6 +322,15 @@ struct amdgpu_vcn_inst {
> >       struct mutex            vcn_pg_lock;
> >       enum amd_powergating_state cur_state;
> >       struct delayed_work     idle_work;
> > +     unsigned                fw_version;
> > +     unsigned                num_enc_rings;
> > +     bool                    indirect_sram;
> > +     struct amdgpu_vcn_reg    internal;
> > +     struct mutex            vcn1_jpeg1_workaround;
> > +     int (*pause_dpg_mode)(struct amdgpu_device *adev,
> > +                           int inst_idx,
> > +                           struct dpg_pause_state *new_state);
> > +     bool using_unified_queue;
> >   };
> >
> >   struct amdgpu_vcn_ras {
> > @@ -330,24 +339,16 @@ struct amdgpu_vcn_ras {
> >
> >   struct amdgpu_vcn {
> >       unsigned                fw_version;
> > -     unsigned                num_enc_rings;
> > -     bool                    indirect_sram;
> > -
> >       uint8_t num_vcn_inst;
> >       struct amdgpu_vcn_inst   inst[AMDGPU_MAX_VCN_INSTANCES];
> > -     struct amdgpu_vcn_reg    internal;
> > -     struct mutex            vcn1_jpeg1_workaround;
> >
> >       unsigned        harvest_config;
> > -     int (*pause_dpg_mode)(struct amdgpu_device *adev,
> > -             int inst_idx, struct dpg_pause_state *new_state);
> >
> >       struct ras_common_if    *ras_if;
> >       struct amdgpu_vcn_ras   *ras;
> >
> >       uint16_t inst_mask;
> >       uint8_t num_inst_per_aid;
> > -     bool using_unified_queue;
>
>
> unified_queue feature is determined by VCN IP version, so the "bool
> using_unified_queue" should be a generic value for all instances. Should
> we still need to separate it for each instance?

Well, you could in theory have two different VCN instances each with a
different version on an SoC.  We already have that today (e.g., navi31
contains two instances, one is 4.0.0 and the other is 4.0.1), but it
just so happens that both versions support unified queues.

Alex

>
> Boyuan
>
>
> >
> >       /* IP reg dump */
> >       uint32_t                *ip_dump;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v1_0.c
> > index 8031406e20ff9..9e428e669ada6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
> > @@ -607,12 +607,12 @@ static void jpeg_v1_0_ring_begin_use(struct amdgp=
u_ring *ring)
> >       bool    set_clocks =3D !cancel_delayed_work_sync(&adev->vcn.inst[=
0].idle_work);
> >       int             cnt =3D 0;
> >
> > -     mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
> > +     mutex_lock(&adev->vcn.inst[0].vcn1_jpeg1_workaround);
> >
> >       if (amdgpu_fence_wait_empty(&adev->vcn.inst->ring_dec))
> >               DRM_ERROR("JPEG dec: vcn dec ring may not be empty\n");
> >
> > -     for (cnt =3D 0; cnt < adev->vcn.num_enc_rings; cnt++) {
> > +     for (cnt =3D 0; cnt < adev->vcn.inst[0].num_enc_rings; cnt++) {
> >               if (amdgpu_fence_wait_empty(&adev->vcn.inst->ring_enc[cnt=
]))
> >                       DRM_ERROR("JPEG dec: vcn enc ring[%d] may not be =
empty\n", cnt);
> >       }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v1_0.c
> > index 757cacf11a817..c870d9ba64c69 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > @@ -105,7 +105,7 @@ static int vcn_v1_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> > -     adev->vcn.num_enc_rings =3D 2;
> > +     adev->vcn.inst[0].num_enc_rings =3D 2;
> >
> >       vcn_v1_0_set_dec_ring_funcs(adev);
> >       vcn_v1_0_set_enc_ring_funcs(adev);
> > @@ -138,7 +138,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >               return r;
> >
> >       /* VCN ENC TRAP */
> > -     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +     for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
> >               r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN, i + =
VCN_1_0__SRCID__UVD_ENC_GENERAL_PURPOSE,
> >                                       &adev->vcn.inst->irq);
> >               if (r)
> > @@ -166,18 +166,18 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
> >       if (r)
> >               return r;
> >
> > -     adev->vcn.internal.scratch9 =3D adev->vcn.inst->external.scratch9=
 =3D
> > +     adev->vcn.inst[0].internal.scratch9 =3D adev->vcn.inst->external.=
scratch9 =3D
> >               SOC15_REG_OFFSET(UVD, 0, mmUVD_SCRATCH9);
> > -     adev->vcn.internal.data0 =3D adev->vcn.inst->external.data0 =3D
> > +     adev->vcn.inst[0].internal.data0 =3D adev->vcn.inst->external.dat=
a0 =3D
> >               SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA0);
> > -     adev->vcn.internal.data1 =3D adev->vcn.inst->external.data1 =3D
> > +     adev->vcn.inst[0].internal.data1 =3D adev->vcn.inst->external.dat=
a1 =3D
> >               SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA1);
> > -     adev->vcn.internal.cmd =3D adev->vcn.inst->external.cmd =3D
> > +     adev->vcn.inst[0].internal.cmd =3D adev->vcn.inst->external.cmd =
=3D
> >               SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_CMD);
> > -     adev->vcn.internal.nop =3D adev->vcn.inst->external.nop =3D
> > +     adev->vcn.inst[0].internal.nop =3D adev->vcn.inst->external.nop =
=3D
> >               SOC15_REG_OFFSET(UVD, 0, mmUVD_NO_OP);
> >
> > -     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +     for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
> >               enum amdgpu_ring_priority_level hw_prio =3D amdgpu_vcn_ge=
t_enc_ring_prio(i);
> >
> >               ring =3D &adev->vcn.inst->ring_enc[i];
> > @@ -189,7 +189,7 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >                       return r;
> >       }
> >
> > -     adev->vcn.pause_dpg_mode =3D vcn_v1_0_pause_dpg_mode;
> > +     adev->vcn.inst[0].pause_dpg_mode =3D vcn_v1_0_pause_dpg_mode;
> >
> >       if (amdgpu_vcnfw_log) {
> >               volatile struct amdgpu_fw_shared *fw_shared =3D adev->vcn=
.inst->fw_shared.cpu_addr;
> > @@ -253,7 +253,7 @@ static int vcn_v1_0_hw_init(struct amdgpu_ip_block =
*ip_block)
> >       if (r)
> >               return r;
> >
> > -     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +     for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
> >               ring =3D &adev->vcn.inst->ring_enc[i];
> >               r =3D amdgpu_ring_test_helper(ring);
> >               if (r)
> > @@ -1833,7 +1833,7 @@ static void vcn_v1_0_idle_work_handler(struct wor=
k_struct *work)
> >       struct amdgpu_device *adev =3D vcn_inst->adev;
> >       unsigned int fences =3D 0, i;
> >
> > -     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> > +     for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i)
> >               fences +=3D amdgpu_fence_count_emitted(&adev->vcn.inst->r=
ing_enc[i]);
> >
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
> > @@ -1849,7 +1849,7 @@ static void vcn_v1_0_idle_work_handler(struct wor=
k_struct *work)
> >               else
> >                       new_state.jpeg =3D VCN_DPG_STATE__UNPAUSE;
> >
> > -             adev->vcn.pause_dpg_mode(adev, 0, &new_state);
> > +             adev->vcn.inst[0].pause_dpg_mode(adev, 0, &new_state);
> >       }
> >
> >       fences +=3D amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec)=
;
> > @@ -1872,7 +1872,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu=
_ring *ring)
> >       struct  amdgpu_device *adev =3D ring->adev;
> >       bool set_clocks =3D !cancel_delayed_work_sync(&adev->vcn.inst[0].=
idle_work);
> >
> > -     mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
> > +     mutex_lock(&adev->vcn.inst[0].vcn1_jpeg1_workaround);
> >
> >       if (amdgpu_fence_wait_empty(ring->adev->jpeg.inst->ring_dec))
> >               DRM_ERROR("VCN dec: jpeg dec ring may not be empty\n");
> > @@ -1898,7 +1898,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_=
ring *ring, bool set_clocks)
> >               struct dpg_pause_state new_state;
> >               unsigned int fences =3D 0, i;
> >
> > -             for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> > +             for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i)
> >                       fences +=3D amdgpu_fence_count_emitted(&adev->vcn=
.inst->ring_enc[i]);
> >
> >               if (fences)
> > @@ -1916,14 +1916,14 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgp=
u_ring *ring, bool set_clocks)
> >               else if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_VCN_JP=
EG)
> >                       new_state.jpeg =3D VCN_DPG_STATE__PAUSE;
> >
> > -             adev->vcn.pause_dpg_mode(adev, 0, &new_state);
> > +             adev->vcn.inst[0].pause_dpg_mode(adev, 0, &new_state);
> >       }
> >   }
> >
> >   void vcn_v1_0_ring_end_use(struct amdgpu_ring *ring)
> >   {
> >       schedule_delayed_work(&ring->adev->vcn.inst[0].idle_work, VCN_IDL=
E_TIMEOUT);
> > -     mutex_unlock(&ring->adev->vcn.vcn1_jpeg1_workaround);
> > +     mutex_unlock(&ring->adev->vcn.inst[0].vcn1_jpeg1_workaround);
> >   }
> >
> >   static void vcn_v1_0_print_ip_state(struct amdgpu_ip_block *ip_block,=
 struct drm_printer *p)
> > @@ -2057,11 +2057,11 @@ static int vcn_v1_0_ring_patch_cs_in_place(stru=
ct amdgpu_cs_parser *p,
> >               uint32_t reg =3D amdgpu_ib_get_value(ib, i);
> >               uint32_t val =3D amdgpu_ib_get_value(ib, i + 1);
> >
> > -             if (reg =3D=3D PACKET0(p->adev->vcn.internal.data0, 0)) {
> > +             if (reg =3D=3D PACKET0(p->adev->vcn.inst[0].internal.data=
0, 0)) {
> >                       msg_lo =3D val;
> > -             } else if (reg =3D=3D PACKET0(p->adev->vcn.internal.data1=
, 0)) {
> > +             } else if (reg =3D=3D PACKET0(p->adev->vcn.inst[0].intern=
al.data1, 0)) {
> >                       msg_hi =3D val;
> > -             } else if (reg =3D=3D PACKET0(p->adev->vcn.internal.cmd, =
0)) {
> > +             } else if (reg =3D=3D PACKET0(p->adev->vcn.inst[0].intern=
al.cmd, 0)) {
> >                       r =3D vcn_v1_0_validate_bo(p, job,
> >                                                ((u64)msg_hi) << 32 | ms=
g_lo);
> >                       if (r)
> > @@ -2146,7 +2146,7 @@ static void vcn_v1_0_set_enc_ring_funcs(struct am=
dgpu_device *adev)
> >   {
> >       int i;
> >
> > -     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> > +     for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i)
> >               adev->vcn.inst->ring_enc[i].funcs =3D &vcn_v1_0_enc_ring_=
vm_funcs;
> >   }
> >
> > @@ -2157,7 +2157,7 @@ static const struct amdgpu_irq_src_funcs vcn_v1_0=
_irq_funcs =3D {
> >
> >   static void vcn_v1_0_set_irq_funcs(struct amdgpu_device *adev)
> >   {
> > -     adev->vcn.inst->irq.num_types =3D adev->vcn.num_enc_rings + 2;
> > +     adev->vcn.inst->irq.num_types =3D adev->vcn.inst[0].num_enc_rings=
 + 2;
> >       adev->vcn.inst->irq.funcs =3D &vcn_v1_0_irq_funcs;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v2_0.c
> > index e55c1f8f260e9..b0a957664250c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> > @@ -110,9 +110,9 @@ static int vcn_v2_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> >       if (amdgpu_sriov_vf(adev))
> > -             adev->vcn.num_enc_rings =3D 1;
> > +             adev->vcn.inst[0].num_enc_rings =3D 1;
> >       else
> > -             adev->vcn.num_enc_rings =3D 2;
> > +             adev->vcn.inst[0].num_enc_rings =3D 2;
> >
> >       vcn_v2_0_set_dec_ring_funcs(adev);
> >       vcn_v2_0_set_enc_ring_funcs(adev);
> > @@ -145,7 +145,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >               return r;
> >
> >       /* VCN ENC TRAP */
> > -     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +     for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
> >               r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> >                                     i + VCN_2_0__SRCID__UVD_ENC_GENERAL=
_PURPOSE,
> >                                     &adev->vcn.inst->irq);
> > @@ -175,25 +175,25 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
> >       if (r)
> >               return r;
> >
> > -     adev->vcn.internal.context_id =3D mmUVD_CONTEXT_ID_INTERNAL_OFFSE=
T;
> > -     adev->vcn.internal.ib_vmid =3D mmUVD_LMI_RBC_IB_VMID_INTERNAL_OFF=
SET;
> > -     adev->vcn.internal.ib_bar_low =3D mmUVD_LMI_RBC_IB_64BIT_BAR_LOW_=
INTERNAL_OFFSET;
> > -     adev->vcn.internal.ib_bar_high =3D mmUVD_LMI_RBC_IB_64BIT_BAR_HIG=
H_INTERNAL_OFFSET;
> > -     adev->vcn.internal.ib_size =3D mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET;
> > -     adev->vcn.internal.gp_scratch8 =3D mmUVD_GP_SCRATCH8_INTERNAL_OFF=
SET;
> > +     adev->vcn.inst[0].internal.context_id =3D mmUVD_CONTEXT_ID_INTERN=
AL_OFFSET;
> > +     adev->vcn.inst[0].internal.ib_vmid =3D mmUVD_LMI_RBC_IB_VMID_INTE=
RNAL_OFFSET;
> > +     adev->vcn.inst[0].internal.ib_bar_low =3D mmUVD_LMI_RBC_IB_64BIT_=
BAR_LOW_INTERNAL_OFFSET;
> > +     adev->vcn.inst[0].internal.ib_bar_high =3D mmUVD_LMI_RBC_IB_64BIT=
_BAR_HIGH_INTERNAL_OFFSET;
> > +     adev->vcn.inst[0].internal.ib_size =3D mmUVD_RBC_IB_SIZE_INTERNAL=
_OFFSET;
> > +     adev->vcn.inst[0].internal.gp_scratch8 =3D mmUVD_GP_SCRATCH8_INTE=
RNAL_OFFSET;
> >
> > -     adev->vcn.internal.scratch9 =3D mmUVD_SCRATCH9_INTERNAL_OFFSET;
> > +     adev->vcn.inst[0].internal.scratch9 =3D mmUVD_SCRATCH9_INTERNAL_O=
FFSET;
> >       adev->vcn.inst->external.scratch9 =3D SOC15_REG_OFFSET(UVD, 0, mm=
UVD_SCRATCH9);
> > -     adev->vcn.internal.data0 =3D mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFS=
ET;
> > +     adev->vcn.inst[0].internal.data0 =3D mmUVD_GPCOM_VCPU_DATA0_INTER=
NAL_OFFSET;
> >       adev->vcn.inst->external.data0 =3D SOC15_REG_OFFSET(UVD, 0, mmUVD=
_GPCOM_VCPU_DATA0);
> > -     adev->vcn.internal.data1 =3D mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFS=
ET;
> > +     adev->vcn.inst[0].internal.data1 =3D mmUVD_GPCOM_VCPU_DATA1_INTER=
NAL_OFFSET;
> >       adev->vcn.inst->external.data1 =3D SOC15_REG_OFFSET(UVD, 0, mmUVD=
_GPCOM_VCPU_DATA1);
> > -     adev->vcn.internal.cmd =3D mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
> > +     adev->vcn.inst[0].internal.cmd =3D mmUVD_GPCOM_VCPU_CMD_INTERNAL_=
OFFSET;
> >       adev->vcn.inst->external.cmd =3D SOC15_REG_OFFSET(UVD, 0, mmUVD_G=
PCOM_VCPU_CMD);
> > -     adev->vcn.internal.nop =3D mmUVD_NO_OP_INTERNAL_OFFSET;
> > +     adev->vcn.inst[0].internal.nop =3D mmUVD_NO_OP_INTERNAL_OFFSET;
> >       adev->vcn.inst->external.nop =3D SOC15_REG_OFFSET(UVD, 0, mmUVD_N=
O_OP);
> >
> > -     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +     for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
> >               enum amdgpu_ring_priority_level hw_prio =3D amdgpu_vcn_ge=
t_enc_ring_prio(i);
> >
> >               ring =3D &adev->vcn.inst->ring_enc[i];
> > @@ -210,7 +210,7 @@ static int vcn_v2_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >                       return r;
> >       }
> >
> > -     adev->vcn.pause_dpg_mode =3D vcn_v2_0_pause_dpg_mode;
> > +     adev->vcn.inst[0].pause_dpg_mode =3D vcn_v2_0_pause_dpg_mode;
> >
> >       r =3D amdgpu_virt_alloc_mm_table(adev);
> >       if (r)
> > @@ -292,7 +292,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block =
*ip_block)
> >       if (amdgpu_sriov_vf(adev))
> >               ring->sched.ready =3D false;
> >
> > -     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +     for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
> >               ring =3D &adev->vcn.inst->ring_enc[i];
> >               r =3D amdgpu_ring_test_helper(ring);
> >               if (r)
> > @@ -981,7 +981,7 @@ static int vcn_v2_0_start(struct amdgpu_device *ade=
v)
> >               amdgpu_dpm_enable_vcn(adev, true, 0);
> >
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_s=
ram);
> > +             return vcn_v2_0_start_dpg_mode(adev, adev->vcn.inst->indi=
rect_sram);
> >
> >       vcn_v2_0_disable_static_power_gating(adev);
> >
> > @@ -1421,9 +1421,9 @@ void vcn_v2_0_dec_ring_insert_start(struct amdgpu=
_ring *ring)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.data0, 0));
> >       amdgpu_ring_write(ring, 0);
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.cmd, 0));
> >       amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_STA=
RT << 1));
> >   }
> >
> > @@ -1438,7 +1438,7 @@ void vcn_v2_0_dec_ring_insert_end(struct amdgpu_r=
ing *ring)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[0].internal.cmd, 0=
));
> >       amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_END=
 << 1));
> >   }
> >
> > @@ -1458,7 +1458,7 @@ void vcn_v2_0_dec_ring_insert_nop(struct amdgpu_r=
ing *ring, uint32_t count)
> >       WARN_ON(ring->wptr % 2 || count % 2);
> >
> >       for (i =3D 0; i < count / 2; i++) {
> > -             amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.nop, 0=
));
> > +             amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].=
internal.nop, 0));
> >               amdgpu_ring_write(ring, 0);
> >       }
> >   }
> > @@ -1479,25 +1479,25 @@ void vcn_v2_0_dec_ring_emit_fence(struct amdgpu=
_ring *ring, u64 addr, u64 seq,
> >       struct amdgpu_device *adev =3D ring->adev;
> >
> >       WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.context_id, 0)=
);
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.context_id, 0));
> >       amdgpu_ring_write(ring, seq);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.data0, 0));
> >       amdgpu_ring_write(ring, addr & 0xffffffff);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.data1, 0));
> >       amdgpu_ring_write(ring, upper_32_bits(addr) & 0xff);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.cmd, 0));
> >       amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_FENCE << 1=
));
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.data0, 0));
> >       amdgpu_ring_write(ring, 0);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.data1, 0));
> >       amdgpu_ring_write(ring, 0);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.cmd, 0));
> >
> >       amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_TRAP << 1)=
);
> >   }
> > @@ -1520,14 +1520,14 @@ void vcn_v2_0_dec_ring_emit_ib(struct amdgpu_ri=
ng *ring,
> >       struct amdgpu_device *adev =3D ring->adev;
> >       unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.ib_vmid, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.ib_vmid, 0));
> >       amdgpu_ring_write(ring, vmid);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.ib_bar_low, 0)=
);
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.ib_bar_low, 0));
> >       amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.ib_bar_high, 0=
));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.ib_bar_high, 0));
> >       amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.ib_size, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.ib_size, 0));
> >       amdgpu_ring_write(ring, ib->length_dw);
> >   }
> >
> > @@ -1536,16 +1536,16 @@ void vcn_v2_0_dec_ring_emit_reg_wait(struct amd=
gpu_ring *ring, uint32_t reg,
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.data0, 0));
> >       amdgpu_ring_write(ring, reg << 2);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.data1, 0));
> >       amdgpu_ring_write(ring, val);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.gp_scratch8, 0=
));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.gp_scratch8, 0));
> >       amdgpu_ring_write(ring, mask);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.cmd, 0));
> >
> >       amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_REG_READ_C=
OND_WAIT << 1));
> >   }
> > @@ -1570,13 +1570,13 @@ void vcn_v2_0_dec_ring_emit_wreg(struct amdgpu_=
ring *ring,
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data0, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.data0, 0));
> >       amdgpu_ring_write(ring, reg << 2);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.data1, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.data1, 0));
> >       amdgpu_ring_write(ring, val);
> >
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.cmd, 0));
> >
> >       amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_WRITE_REG =
<< 1));
> >   }
> > @@ -1777,9 +1777,9 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_rin=
g *ring)
> >       r =3D amdgpu_ring_alloc(ring, 4);
> >       if (r)
> >               return r;
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.cmd, 0));
> >       amdgpu_ring_write(ring, VCN_DEC_KMD_CMD | (VCN_DEC_CMD_PACKET_STA=
RT << 1));
> > -     amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.scratch9, 0));
> > +     amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal=
.scratch9, 0));
> >       amdgpu_ring_write(ring, 0xDEADBEEF);
> >       amdgpu_ring_commit(ring);
> >       for (i =3D 0; i < adev->usec_timeout; i++) {
> > @@ -1863,7 +1863,7 @@ static int vcn_v2_0_start_mmsch(struct amdgpu_dev=
ice *adev,
> >       adev->vcn.inst->ring_dec.wptr_old =3D 0;
> >       vcn_v2_0_dec_ring_set_wptr(&adev->vcn.inst->ring_dec);
> >
> > -     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +     for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i) {
> >               adev->vcn.inst->ring_enc[i].wptr =3D 0;
> >               adev->vcn.inst->ring_enc[i].wptr_old =3D 0;
> >               vcn_v2_0_enc_ring_set_wptr(&adev->vcn.inst->ring_enc[i]);
> > @@ -1989,7 +1989,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_dev=
ice *adev)
> >                       SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE2),
> >                       AMDGPU_VCN_CONTEXT_SIZE);
> >
> > -             for (r =3D 0; r < adev->vcn.num_enc_rings; ++r) {
> > +             for (r =3D 0; r < adev->vcn.inst[0].num_enc_rings; ++r) {
> >                       ring =3D &adev->vcn.inst->ring_enc[r];
> >                       ring->wptr =3D 0;
> >                       MMSCH_V2_0_INSERT_DIRECT_WT(
> > @@ -2178,7 +2178,7 @@ static void vcn_v2_0_set_enc_ring_funcs(struct am=
dgpu_device *adev)
> >   {
> >       int i;
> >
> > -     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i)
> > +     for (i =3D 0; i < adev->vcn.inst[0].num_enc_rings; ++i)
> >               adev->vcn.inst->ring_enc[i].funcs =3D &vcn_v2_0_enc_ring_=
vm_funcs;
> >   }
> >
> > @@ -2189,7 +2189,7 @@ static const struct amdgpu_irq_src_funcs vcn_v2_0=
_irq_funcs =3D {
> >
> >   static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev)
> >   {
> > -     adev->vcn.inst->irq.num_types =3D adev->vcn.num_enc_rings + 1;
> > +     adev->vcn.inst->irq.num_types =3D adev->vcn.inst[0].num_enc_rings=
 + 1;
> >       adev->vcn.inst->irq.funcs =3D &vcn_v2_0_irq_funcs;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v2_5.c
> > index 1d3780a2d8513..a3bac39e4c9db 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> > @@ -121,11 +121,13 @@ static int amdgpu_ih_clientid_vcns[] =3D {
> >   static int vcn_v2_5_early_init(struct amdgpu_ip_block *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> > +     int i;
> >
> >       if (amdgpu_sriov_vf(adev)) {
> >               adev->vcn.num_vcn_inst =3D 2;
> >               adev->vcn.harvest_config =3D 0;
> > -             adev->vcn.num_enc_rings =3D 1;
> > +             for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> > +                     adev->vcn.inst[i].num_enc_rings =3D 1;
> >       } else {
> >               u32 harvest;
> >               int i;
> > @@ -134,13 +136,12 @@ static int vcn_v2_5_early_init(struct amdgpu_ip_b=
lock *ip_block)
> >                       harvest =3D RREG32_SOC15(VCN, i, mmCC_UVD_HARVEST=
ING);
> >                       if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK=
)
> >                               adev->vcn.harvest_config |=3D 1 << i;
> > +                     adev->vcn.inst[i].num_enc_rings =3D 2;
> >               }
> >               if (adev->vcn.harvest_config =3D=3D (AMDGPU_VCN_HARVEST_V=
CN0 |
> >                                       AMDGPU_VCN_HARVEST_VCN1))
> >                       /* both instances are harvested, disable the bloc=
k */
> >                       return -ENOENT;
> > -
> > -             adev->vcn.num_enc_rings =3D 2;
> >       }
> >
> >       vcn_v2_5_set_dec_ring_funcs(adev);
> > @@ -176,7 +177,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block =
*ip_block)
> >                       return r;
> >
> >               /* VCN ENC TRAP */
> > -             for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +             for (i =3D 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
> >                       r =3D amdgpu_irq_add_id(adev, amdgpu_ih_clientid_=
vcns[j],
> >                               i + VCN_2_0__SRCID__UVD_ENC_GENERAL_PURPO=
SE, &adev->vcn.inst[j].irq);
> >                       if (r)
> > @@ -205,22 +206,22 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
> >
> >               if (adev->vcn.harvest_config & (1 << j))
> >                       continue;
> > -             adev->vcn.internal.context_id =3D mmUVD_CONTEXT_ID_INTERN=
AL_OFFSET;
> > -             adev->vcn.internal.ib_vmid =3D mmUVD_LMI_RBC_IB_VMID_INTE=
RNAL_OFFSET;
> > -             adev->vcn.internal.ib_bar_low =3D mmUVD_LMI_RBC_IB_64BIT_=
BAR_LOW_INTERNAL_OFFSET;
> > -             adev->vcn.internal.ib_bar_high =3D mmUVD_LMI_RBC_IB_64BIT=
_BAR_HIGH_INTERNAL_OFFSET;
> > -             adev->vcn.internal.ib_size =3D mmUVD_RBC_IB_SIZE_INTERNAL=
_OFFSET;
> > -             adev->vcn.internal.gp_scratch8 =3D mmUVD_GP_SCRATCH8_INTE=
RNAL_OFFSET;
> > -
> > -             adev->vcn.internal.scratch9 =3D mmUVD_SCRATCH9_INTERNAL_O=
FFSET;
> > +             adev->vcn.inst[j].internal.context_id =3D mmUVD_CONTEXT_I=
D_INTERNAL_OFFSET;
> > +             adev->vcn.inst[j].internal.ib_vmid =3D mmUVD_LMI_RBC_IB_V=
MID_INTERNAL_OFFSET;
> > +             adev->vcn.inst[j].internal.ib_bar_low =3D mmUVD_LMI_RBC_I=
B_64BIT_BAR_LOW_INTERNAL_OFFSET;
> > +             adev->vcn.inst[j].internal.ib_bar_high =3D mmUVD_LMI_RBC_=
IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> > +             adev->vcn.inst[j].internal.ib_size =3D mmUVD_RBC_IB_SIZE_=
INTERNAL_OFFSET;
> > +             adev->vcn.inst[j].internal.gp_scratch8 =3D mmUVD_GP_SCRAT=
CH8_INTERNAL_OFFSET;
> > +
> > +             adev->vcn.inst[j].internal.scratch9 =3D mmUVD_SCRATCH9_IN=
TERNAL_OFFSET;
> >               adev->vcn.inst[j].external.scratch9 =3D SOC15_REG_OFFSET(=
VCN, j, mmUVD_SCRATCH9);
> > -             adev->vcn.internal.data0 =3D mmUVD_GPCOM_VCPU_DATA0_INTER=
NAL_OFFSET;
> > +             adev->vcn.inst[j].internal.data0 =3D mmUVD_GPCOM_VCPU_DAT=
A0_INTERNAL_OFFSET;
> >               adev->vcn.inst[j].external.data0 =3D SOC15_REG_OFFSET(VCN=
, j, mmUVD_GPCOM_VCPU_DATA0);
> > -             adev->vcn.internal.data1 =3D mmUVD_GPCOM_VCPU_DATA1_INTER=
NAL_OFFSET;
> > +             adev->vcn.inst[j].internal.data1 =3D mmUVD_GPCOM_VCPU_DAT=
A1_INTERNAL_OFFSET;
> >               adev->vcn.inst[j].external.data1 =3D SOC15_REG_OFFSET(VCN=
, j, mmUVD_GPCOM_VCPU_DATA1);
> > -             adev->vcn.internal.cmd =3D mmUVD_GPCOM_VCPU_CMD_INTERNAL_=
OFFSET;
> > +             adev->vcn.inst[j].internal.cmd =3D mmUVD_GPCOM_VCPU_CMD_I=
NTERNAL_OFFSET;
> >               adev->vcn.inst[j].external.cmd =3D SOC15_REG_OFFSET(VCN, =
j, mmUVD_GPCOM_VCPU_CMD);
> > -             adev->vcn.internal.nop =3D mmUVD_NO_OP_INTERNAL_OFFSET;
> > +             adev->vcn.inst[j].internal.nop =3D mmUVD_NO_OP_INTERNAL_O=
FFSET;
> >               adev->vcn.inst[j].external.nop =3D SOC15_REG_OFFSET(VCN, =
j, mmUVD_NO_OP);
> >
> >               ring =3D &adev->vcn.inst[j].ring_dec;
> > @@ -240,7 +241,7 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block =
*ip_block)
> >               if (r)
> >                       return r;
> >
> > -             for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +             for (i =3D 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
> >                       enum amdgpu_ring_priority_level hw_prio =3D amdgp=
u_vcn_get_enc_ring_prio(i);
> >
> >                       ring =3D &adev->vcn.inst[j].ring_enc[i];
> > @@ -268,6 +269,9 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block =
*ip_block)
> >
> >               if (amdgpu_vcnfw_log)
> >                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> > +
> > +             if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > +                     adev->vcn.inst[i].pause_dpg_mode =3D vcn_v2_5_pau=
se_dpg_mode;
> >       }
> >
> >       if (amdgpu_sriov_vf(adev)) {
> > @@ -276,9 +280,6 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block =
*ip_block)
> >                       return r;
> >       }
> >
> > -     if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             adev->vcn.pause_dpg_mode =3D vcn_v2_5_pause_dpg_mode;
> > -
> >       r =3D amdgpu_vcn_ras_sw_init(adev);
> >       if (r)
> >               return r;
> > @@ -369,7 +370,7 @@ static int vcn_v2_5_hw_init(struct amdgpu_ip_block =
*ip_block)
> >                       if (r)
> >                               return r;
> >
> > -                     for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +                     for (i =3D 0; i < adev->vcn.inst[j].num_enc_rings=
; ++i) {
> >                               ring =3D &adev->vcn.inst[j].ring_enc[i];
> >                               r =3D amdgpu_ring_test_helper(ring);
> >                               if (r)
> > @@ -1018,7 +1019,7 @@ static int vcn_v2_5_start(struct amdgpu_device *a=
dev, int i)
> >               amdgpu_dpm_enable_vcn(adev, true, i);
> >
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirec=
t_sram);
> > +             return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.inst[i]=
.indirect_sram);
> >
> >       /* disable register anti-hang mechanism */
> >       WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
> > @@ -1746,7 +1747,7 @@ static void vcn_v2_5_set_enc_ring_funcs(struct am=
dgpu_device *adev)
> >       for (j =3D 0; j < adev->vcn.num_vcn_inst; ++j) {
> >               if (adev->vcn.harvest_config & (1 << j))
> >                       continue;
> > -             for (i =3D 0; i < adev->vcn.num_enc_rings; ++i) {
> > +             for (i =3D 0; i < adev->vcn.inst[j].num_enc_rings; ++i) {
> >                       adev->vcn.inst[j].ring_enc[i].funcs =3D &vcn_v2_5=
_enc_ring_vm_funcs;
> >                       adev->vcn.inst[j].ring_enc[i].me =3D j;
> >               }
> > @@ -1917,10 +1918,10 @@ static void vcn_v2_5_set_irq_funcs(struct amdgp=
u_device *adev)
> >       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> > -             adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> > +             adev->vcn.inst[i].irq.num_types =3D adev->vcn.inst[i].num=
_enc_rings + 1;
> >               adev->vcn.inst[i].irq.funcs =3D &vcn_v2_5_irq_funcs;
> >
> > -             adev->vcn.inst[i].ras_poison_irq.num_types =3D adev->vcn.=
num_enc_rings + 1;
> > +             adev->vcn.inst[i].ras_poison_irq.num_types =3D adev->vcn.=
inst[i].num_enc_rings + 1;
> >               adev->vcn.inst[i].ras_poison_irq.funcs =3D &vcn_v2_6_ras_=
irq_funcs;
> >       }
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v3_0.c
> > index 13b9ed96cccda..fabe4d75a7f6b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > @@ -127,11 +127,13 @@ static void vcn_v3_0_enc_ring_set_wptr(struct amd=
gpu_ring *ring);
> >   static int vcn_v3_0_early_init(struct amdgpu_ip_block *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> > +     int i;
> >
> >       if (amdgpu_sriov_vf(adev)) {
> >               adev->vcn.num_vcn_inst =3D VCN_INSTANCES_SIENNA_CICHLID;
> >               adev->vcn.harvest_config =3D 0;
> > -             adev->vcn.num_enc_rings =3D 1;
> > +             for (i =3D 0; i < adev->vcn.num_vcn_inst; i++)
> > +                     adev->vcn.inst[i].num_enc_rings =3D 1;
> >
> >       } else {
> >               if (adev->vcn.harvest_config =3D=3D (AMDGPU_VCN_HARVEST_V=
CN0 |
> > @@ -139,11 +141,13 @@ static int vcn_v3_0_early_init(struct amdgpu_ip_b=
lock *ip_block)
> >                       /* both instances are harvested, disable the bloc=
k */
> >                       return -ENOENT;
> >
> > -             if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
> > -                 IP_VERSION(3, 0, 33))
> > -                     adev->vcn.num_enc_rings =3D 0;
> > -             else
> > -                     adev->vcn.num_enc_rings =3D 2;
> > +             for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
> > +                     if (amdgpu_ip_version(adev, UVD_HWIP, 0) =3D=3D
> > +                         IP_VERSION(3, 0, 33))
> > +                             adev->vcn.inst[i].num_enc_rings =3D 0;
> > +                     else
> > +                             adev->vcn.inst[i].num_enc_rings =3D 2;
> > +             }
> >       }
> >
> >       vcn_v3_0_set_dec_ring_funcs(adev);
> > @@ -198,22 +202,22 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> >
> > -             adev->vcn.internal.context_id =3D mmUVD_CONTEXT_ID_INTERN=
AL_OFFSET;
> > -             adev->vcn.internal.ib_vmid =3D mmUVD_LMI_RBC_IB_VMID_INTE=
RNAL_OFFSET;
> > -             adev->vcn.internal.ib_bar_low =3D mmUVD_LMI_RBC_IB_64BIT_=
BAR_LOW_INTERNAL_OFFSET;
> > -             adev->vcn.internal.ib_bar_high =3D mmUVD_LMI_RBC_IB_64BIT=
_BAR_HIGH_INTERNAL_OFFSET;
> > -             adev->vcn.internal.ib_size =3D mmUVD_RBC_IB_SIZE_INTERNAL=
_OFFSET;
> > -             adev->vcn.internal.gp_scratch8 =3D mmUVD_GP_SCRATCH8_INTE=
RNAL_OFFSET;
> > +             adev->vcn.inst[i].internal.context_id =3D mmUVD_CONTEXT_I=
D_INTERNAL_OFFSET;
> > +             adev->vcn.inst[i].internal.ib_vmid =3D mmUVD_LMI_RBC_IB_V=
MID_INTERNAL_OFFSET;
> > +             adev->vcn.inst[i].internal.ib_bar_low =3D mmUVD_LMI_RBC_I=
B_64BIT_BAR_LOW_INTERNAL_OFFSET;
> > +             adev->vcn.inst[i].internal.ib_bar_high =3D mmUVD_LMI_RBC_=
IB_64BIT_BAR_HIGH_INTERNAL_OFFSET;
> > +             adev->vcn.inst[i].internal.ib_size =3D mmUVD_RBC_IB_SIZE_=
INTERNAL_OFFSET;
> > +             adev->vcn.inst[i].internal.gp_scratch8 =3D mmUVD_GP_SCRAT=
CH8_INTERNAL_OFFSET;
> >
> > -             adev->vcn.internal.scratch9 =3D mmUVD_SCRATCH9_INTERNAL_O=
FFSET;
> > +             adev->vcn.inst[i].internal.scratch9 =3D mmUVD_SCRATCH9_IN=
TERNAL_OFFSET;
> >               adev->vcn.inst[i].external.scratch9 =3D SOC15_REG_OFFSET(=
VCN, i, mmUVD_SCRATCH9);
> > -             adev->vcn.internal.data0 =3D mmUVD_GPCOM_VCPU_DATA0_INTER=
NAL_OFFSET;
> > +             adev->vcn.inst[i].internal.data0 =3D mmUVD_GPCOM_VCPU_DAT=
A0_INTERNAL_OFFSET;
> >               adev->vcn.inst[i].external.data0 =3D SOC15_REG_OFFSET(VCN=
, i, mmUVD_GPCOM_VCPU_DATA0);
> > -             adev->vcn.internal.data1 =3D mmUVD_GPCOM_VCPU_DATA1_INTER=
NAL_OFFSET;
> > +             adev->vcn.inst[i].internal.data1 =3D mmUVD_GPCOM_VCPU_DAT=
A1_INTERNAL_OFFSET;
> >               adev->vcn.inst[i].external.data1 =3D SOC15_REG_OFFSET(VCN=
, i, mmUVD_GPCOM_VCPU_DATA1);
> > -             adev->vcn.internal.cmd =3D mmUVD_GPCOM_VCPU_CMD_INTERNAL_=
OFFSET;
> > +             adev->vcn.inst[i].internal.cmd =3D mmUVD_GPCOM_VCPU_CMD_I=
NTERNAL_OFFSET;
> >               adev->vcn.inst[i].external.cmd =3D SOC15_REG_OFFSET(VCN, =
i, mmUVD_GPCOM_VCPU_CMD);
> > -             adev->vcn.internal.nop =3D mmUVD_NO_OP_INTERNAL_OFFSET;
> > +             adev->vcn.inst[i].internal.nop =3D mmUVD_NO_OP_INTERNAL_O=
FFSET;
> >               adev->vcn.inst[i].external.nop =3D SOC15_REG_OFFSET(VCN, =
i, mmUVD_NO_OP);
> >
> >               /* VCN DEC TRAP */
> > @@ -227,7 +231,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >               ring =3D &adev->vcn.inst[i].ring_dec;
> >               ring->use_doorbell =3D true;
> >               if (amdgpu_sriov_vf(adev)) {
> > -                     ring->doorbell_index =3D vcn_doorbell_index + i *=
 (adev->vcn.num_enc_rings + 1);
> > +                     ring->doorbell_index =3D vcn_doorbell_index + i *=
 (adev->vcn.inst[i].num_enc_rings + 1);
> >               } else {
> >                       ring->doorbell_index =3D (adev->doorbell_index.vc=
n.vcn_ring0_1 << 1) + 8 * i;
> >               }
> > @@ -239,7 +243,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >               if (r)
> >                       return r;
> >
> > -             for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> > +             for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
> >                       enum amdgpu_ring_priority_level hw_prio =3D amdgp=
u_vcn_get_enc_ring_prio(j);
> >
> >                       /* VCN ENC TRAP */
> > @@ -251,7 +255,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >                       ring =3D &adev->vcn.inst[i].ring_enc[j];
> >                       ring->use_doorbell =3D true;
> >                       if (amdgpu_sriov_vf(adev)) {
> > -                             ring->doorbell_index =3D vcn_doorbell_ind=
ex + i * (adev->vcn.num_enc_rings + 1) + 1 + j;
> > +                             ring->doorbell_index =3D vcn_doorbell_ind=
ex + i * (adev->vcn.inst[i].num_enc_rings + 1) + 1 + j;
> >                       } else {
> >                               ring->doorbell_index =3D (adev->doorbell_=
index.vcn.vcn_ring0_1 << 1) + 2 + j + 8 * i;
> >                       }
> > @@ -277,6 +281,9 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >
> >               if (amdgpu_vcnfw_log)
> >                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> > +
> > +             if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > +                     adev->vcn.inst[i].pause_dpg_mode =3D vcn_v3_0_pau=
se_dpg_mode;
> >       }
> >
> >       if (amdgpu_sriov_vf(adev)) {
> > @@ -284,8 +291,6 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >               if (r)
> >                       return r;
> >       }
> > -     if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             adev->vcn.pause_dpg_mode =3D vcn_v3_0_pause_dpg_mode;
> >
> >       /* Allocate memory for VCN IP Dump buffer */
> >       ptr =3D kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32=
_t), GFP_KERNEL);
> > @@ -373,7 +378,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
> >                               ring->sched.ready =3D true;
> >                       }
> >
> > -                     for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> > +                     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings=
; ++j) {
> >                               ring =3D &adev->vcn.inst[i].ring_enc[j];
> >                               if (amdgpu_vcn_is_disabled_vcn(adev, VCN_=
ENCODE_RING, i)) {
> >                                       ring->sched.ready =3D false;
> > @@ -401,7 +406,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block =
*ip_block)
> >                       if (r)
> >                               return r;
> >
> > -                     for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> > +                     for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings=
; ++j) {
> >                               ring =3D &adev->vcn.inst[i].ring_enc[j];
> >                               r =3D amdgpu_ring_test_helper(ring);
> >                               if (r)
> > @@ -1153,7 +1158,7 @@ static int vcn_v3_0_start(struct amdgpu_device *a=
dev, int i)
> >               amdgpu_dpm_enable_vcn(adev, true, i);
> >
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirec=
t_sram);
> > +             return vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.inst[i]=
.indirect_sram);
> >
> >       /* disable VCN power gating */
> >       vcn_v3_0_disable_static_power_gating(adev, i);
> > @@ -1433,7 +1438,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_dev=
ice *adev)
> >                       mmUVD_VCPU_CACHE_SIZE2),
> >                       AMDGPU_VCN_CONTEXT_SIZE);
> >
> > -             for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> > +             for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
> >                       ring =3D &adev->vcn.inst[i].ring_enc[j];
> >                       ring->wptr =3D 0;
> >                       rb_addr =3D ring->gpu_addr;
> > @@ -1921,11 +1926,11 @@ static int vcn_v3_0_ring_patch_cs_in_place(stru=
ct amdgpu_cs_parser *p,
> >               uint32_t reg =3D amdgpu_ib_get_value(ib, i);
> >               uint32_t val =3D amdgpu_ib_get_value(ib, i + 1);
> >
> > -             if (reg =3D=3D PACKET0(p->adev->vcn.internal.data0, 0)) {
> > +             if (reg =3D=3D PACKET0(p->adev->vcn.inst[ring->me].intern=
al.data0, 0)) {
> >                       msg_lo =3D val;
> > -             } else if (reg =3D=3D PACKET0(p->adev->vcn.internal.data1=
, 0)) {
> > +             } else if (reg =3D=3D PACKET0(p->adev->vcn.inst[ring->me]=
.internal.data1, 0)) {
> >                       msg_hi =3D val;
> > -             } else if (reg =3D=3D PACKET0(p->adev->vcn.internal.cmd, =
0) &&
> > +             } else if (reg =3D=3D PACKET0(p->adev->vcn.inst[ring->me]=
.internal.cmd, 0) &&
> >                          val =3D=3D 0) {
> >                       r =3D vcn_v3_0_dec_msg(p, job,
> >                                            ((u64)msg_hi) << 32 | msg_lo=
);
> > @@ -2089,7 +2094,7 @@ static void vcn_v3_0_set_enc_ring_funcs(struct am=
dgpu_device *adev)
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> >
> > -             for (j =3D 0; j < adev->vcn.num_enc_rings; ++j) {
> > +             for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j) {
> >                       adev->vcn.inst[i].ring_enc[j].funcs =3D &vcn_v3_0=
_enc_ring_vm_funcs;
> >                       adev->vcn.inst[i].ring_enc[j].me =3D i;
> >               }
> > @@ -2255,7 +2260,7 @@ static void vcn_v3_0_set_irq_funcs(struct amdgpu_=
device *adev)
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> >
> > -             adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> > +             adev->vcn.inst[i].irq.num_types =3D adev->vcn.inst[i].num=
_enc_rings + 1;
> >               adev->vcn.inst[i].irq.funcs =3D &vcn_v3_0_irq_funcs;
> >       }
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0.c
> > index dbbeeffc90726..ee87594fafa60 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> > @@ -129,8 +129,9 @@ static int vcn_v4_0_early_init(struct amdgpu_ip_blo=
ck *ip_block)
> >               }
> >       }
> >
> > -     /* re-use enc ring as unified ring */
> > -     adev->vcn.num_enc_rings =3D 1;
> > +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> > +             /* re-use enc ring as unified ring */
> > +             adev->vcn.inst[i].num_enc_rings =3D 1;
> >
> >       vcn_v4_0_set_unified_ring_funcs(adev);
> >       vcn_v4_0_set_irq_funcs(adev);
> > @@ -214,7 +215,8 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >               ring =3D &adev->vcn.inst[i].ring_enc[0];
> >               ring->use_doorbell =3D true;
> >               if (amdgpu_sriov_vf(adev))
> > -                     ring->doorbell_index =3D (adev->doorbell_index.vc=
n.vcn_ring0_1 << 1) + i * (adev->vcn.num_enc_rings + 1) + 1;
> > +                     ring->doorbell_index =3D (adev->doorbell_index.vc=
n.vcn_ring0_1 << 1) + i *
> > +                             (adev->vcn.inst[i].num_enc_rings + 1) + 1=
;
> >               else
> >                       ring->doorbell_index =3D (adev->doorbell_index.vc=
n.vcn_ring0_1 << 1) + 2 + 8 * i;
> >               ring->vm_hub =3D AMDGPU_MMHUB0(0);
> > @@ -226,6 +228,9 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >                       return r;
> >
> >               vcn_v4_0_fw_shared_init(adev, i);
> > +
> > +             if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > +                     adev->vcn.inst[i].pause_dpg_mode =3D vcn_v4_0_pau=
se_dpg_mode;
> >       }
> >
> >       /* TODO: Add queue reset mask when FW fully supports it */
> > @@ -238,8 +243,6 @@ static int vcn_v4_0_sw_init(struct amdgpu_ip_block =
*ip_block)
> >                       return r;
> >       }
> >
> > -     if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             adev->vcn.pause_dpg_mode =3D vcn_v4_0_pause_dpg_mode;
> >
> >       r =3D amdgpu_vcn_ras_sw_init(adev);
> >       if (r)
> > @@ -1111,7 +1114,7 @@ static int vcn_v4_0_start(struct amdgpu_device *a=
dev, int i)
> >       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> >
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             return vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.indirec=
t_sram);
> > +             return vcn_v4_0_start_dpg_mode(adev, i, adev->vcn.inst[i]=
.indirect_sram);
> >
> >       /* disable VCN power gating */
> >       vcn_v4_0_disable_static_power_gating(adev, i);
> > @@ -2172,10 +2175,10 @@ static void vcn_v4_0_set_irq_funcs(struct amdgp=
u_device *adev)
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> >
> > -             adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> > +             adev->vcn.inst[i].irq.num_types =3D adev->vcn.inst[i].num=
_enc_rings + 1;
> >               adev->vcn.inst[i].irq.funcs =3D &vcn_v4_0_irq_funcs;
> >
> > -             adev->vcn.inst[i].ras_poison_irq.num_types =3D adev->vcn.=
num_enc_rings + 1;
> > +             adev->vcn.inst[i].ras_poison_irq.num_types =3D adev->vcn.=
inst[i].num_enc_rings + 1;
> >               adev->vcn.inst[i].ras_poison_irq.funcs =3D &vcn_v4_0_ras_=
irq_funcs;
> >       }
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v4_0_3.c
> > index 8396ef6831b69..35854e074d142 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > @@ -114,9 +114,11 @@ static inline bool vcn_v4_0_3_normalizn_reqd(struc=
t amdgpu_device *adev)
> >   static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> > +     int i;
> >
> > -     /* re-use enc ring as unified ring */
> > -     adev->vcn.num_enc_rings =3D 1;
> > +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> > +             /* re-use enc ring as unified ring */
> > +             adev->vcn.inst[i].num_enc_rings =3D 1;
> >
> >       vcn_v4_0_3_set_unified_ring_funcs(adev);
> >       vcn_v4_0_3_set_irq_funcs(adev);
> > @@ -194,6 +196,9 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
> >                       return r;
> >
> >               vcn_v4_0_3_fw_shared_init(adev, i);
> > +
> > +             if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > +                     adev->vcn.inst[i].pause_dpg_mode =3D vcn_v4_0_3_p=
ause_dpg_mode;
> >       }
> >
> >       /* TODO: Add queue reset mask when FW fully supports it */
> > @@ -206,9 +211,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
> >                       return r;
> >       }
> >
> > -     if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             adev->vcn.pause_dpg_mode =3D vcn_v4_0_3_pause_dpg_mode;
> > -
> >       if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN)) {
> >               r =3D amdgpu_vcn_ras_sw_init(adev);
> >               if (r) {
> > @@ -1138,7 +1140,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device =
*adev, int i)
> >               amdgpu_dpm_enable_vcn(adev, true, i);
> >
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.indir=
ect_sram);
> > +             return vcn_v4_0_3_start_dpg_mode(adev, i, adev->vcn.inst[=
i].indirect_sram);
> >
> >       vcn_inst =3D GET_INST(VCN, i);
> >       /* set VCN status busy */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v4_0_5.c
> > index f6b347fcdb7ed..0700a5f96084c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> > @@ -115,9 +115,11 @@ static void vcn_v4_0_5_unified_ring_set_wptr(struc=
t amdgpu_ring *ring);
> >   static int vcn_v4_0_5_early_init(struct amdgpu_ip_block *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> > +     int i;
> >
> > -     /* re-use enc ring as unified ring */
> > -     adev->vcn.num_enc_rings =3D 1;
> > +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> > +             /* re-use enc ring as unified ring */
> > +             adev->vcn.inst[i].num_enc_rings =3D 1;
> >       vcn_v4_0_5_set_unified_ring_funcs(adev);
> >       vcn_v4_0_5_set_irq_funcs(adev);
> >
> > @@ -173,7 +175,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
> >               ring->use_doorbell =3D true;
> >               if (amdgpu_sriov_vf(adev))
> >                       ring->doorbell_index =3D (adev->doorbell_index.vc=
n.vcn_ring0_1 << 1) +
> > -                                             i * (adev->vcn.num_enc_ri=
ngs + 1) + 1;
> > +                                             i * (adev->vcn.inst[i].nu=
m_enc_rings + 1) + 1;
> >               else
> >                       ring->doorbell_index =3D (adev->doorbell_index.vc=
n.vcn_ring0_1 << 1) +
> >                                               2 + 8 * i;
> > @@ -198,6 +200,9 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
> >
> >               if (amdgpu_vcnfw_log)
> >                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> > +
> > +             if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > +                     adev->vcn.inst[i].pause_dpg_mode =3D vcn_v4_0_5_p=
ause_dpg_mode;
> >       }
> >
> >       if (amdgpu_sriov_vf(adev)) {
> > @@ -206,9 +211,6 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
> >                       return r;
> >       }
> >
> > -     if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             adev->vcn.pause_dpg_mode =3D vcn_v4_0_5_pause_dpg_mode;
> > -
> >       /* Allocate memory for VCN IP Dump buffer */
> >       ptr =3D kcalloc(adev->vcn.num_vcn_inst * reg_count, sizeof(uint32=
_t), GFP_KERNEL);
> >       if (!ptr) {
> > @@ -1014,7 +1016,7 @@ static int vcn_v4_0_5_start(struct amdgpu_device =
*adev, int i)
> >       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> >
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             return vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.indir=
ect_sram);
> > +             return vcn_v4_0_5_start_dpg_mode(adev, i, adev->vcn.inst[=
i].indirect_sram);
> >
> >       /* disable VCN power gating */
> >       vcn_v4_0_5_disable_static_power_gating(adev, i);
> > @@ -1624,7 +1626,7 @@ static void vcn_v4_0_5_set_irq_funcs(struct amdgp=
u_device *adev)
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> >
> > -             adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> > +             adev->vcn.inst[i].irq.num_types =3D adev->vcn.inst[i].num=
_enc_rings + 1;
> >               adev->vcn.inst[i].irq.funcs =3D &vcn_v4_0_5_irq_funcs;
> >       }
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v5_0_0.c
> > index c5d59edf3a482..eeb3c9875ad50 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> > @@ -98,9 +98,11 @@ static void vcn_v5_0_0_unified_ring_set_wptr(struct =
amdgpu_ring *ring);
> >   static int vcn_v5_0_0_early_init(struct amdgpu_ip_block *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> > +     int i;
> >
> > -     /* re-use enc ring as unified ring */
> > -     adev->vcn.num_enc_rings =3D 1;
> > +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> > +             /* re-use enc ring as unified ring */
> > +             adev->vcn.inst[i].num_enc_rings =3D 1;
> >
> >       vcn_v5_0_0_set_unified_ring_funcs(adev);
> >       vcn_v5_0_0_set_irq_funcs(adev);
> > @@ -184,15 +186,15 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_bl=
ock *ip_block)
> >
> >               if (amdgpu_vcnfw_log)
> >                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
> > +
> > +             if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > +                     adev->vcn.inst[i].pause_dpg_mode =3D vcn_v5_0_0_p=
ause_dpg_mode;
> >       }
> >
> >       /* TODO: Add queue reset mask when FW fully supports it */
> >       adev->vcn.supported_reset =3D
> >               amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_e=
nc[0]);
> >
> > -     if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             adev->vcn.pause_dpg_mode =3D vcn_v5_0_0_pause_dpg_mode;
> > -
> >       vcn_v5_0_0_alloc_ip_dump(adev);
> >
> >       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev);
> > @@ -791,7 +793,7 @@ static int vcn_v5_0_0_start(struct amdgpu_device *a=
dev, int i)
> >       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> >
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             return vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.indir=
ect_sram);
> > +             return vcn_v5_0_0_start_dpg_mode(adev, i, adev->vcn.inst[=
i].indirect_sram);
> >
> >       /* disable VCN power gating */
> >       vcn_v5_0_0_disable_static_power_gating(adev, i);
> > @@ -1367,7 +1369,7 @@ static void vcn_v5_0_0_set_irq_funcs(struct amdgp=
u_device *adev)
> >               if (adev->vcn.harvest_config & (1 << i))
> >                       continue;
> >
> > -             adev->vcn.inst[i].irq.num_types =3D adev->vcn.num_enc_rin=
gs + 1;
> > +             adev->vcn.inst[i].irq.num_types =3D adev->vcn.inst[i].num=
_enc_rings + 1;
> >               adev->vcn.inst[i].irq.funcs =3D &vcn_v5_0_0_irq_funcs;
> >       }
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v5_0_1.c
> > index 51a2d70a65c9e..f428d23eb2857 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> > @@ -58,9 +58,11 @@ static void vcn_v5_0_1_unified_ring_set_wptr(struct =
amdgpu_ring *ring);
> >   static int vcn_v5_0_1_early_init(struct amdgpu_ip_block *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> > +     int i;
> >
> > -     /* re-use enc ring as unified ring */
> > -     adev->vcn.num_enc_rings =3D 1;
> > +     for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i)
> > +             /* re-use enc ring as unified ring */
> > +             adev->vcn.inst[i].num_enc_rings =3D 1;
> >
> >       vcn_v5_0_1_set_unified_ring_funcs(adev);
> >       vcn_v5_0_1_set_irq_funcs(adev);
> > @@ -586,7 +588,7 @@ static int vcn_v5_0_1_start(struct amdgpu_device *a=
dev, int i)
> >       fw_shared =3D adev->vcn.inst[i].fw_shared.cpu_addr;
> >
> >       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
> > -             return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.indir=
ect_sram);
> > +             return vcn_v5_0_1_start_dpg_mode(adev, i, adev->vcn.inst[=
i].indirect_sram);
> >
> >       vcn_inst =3D GET_INST(VCN, i);
> >
