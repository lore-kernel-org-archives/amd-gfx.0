Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B460C433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0980610CD
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0980610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3FF6E17A;
	Wed, 19 May 2021 03:10:55 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B4EF6E17A
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 03:10:54 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 o17-20020a17090a9f91b029015cef5b3c50so2700077pjp.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 20:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w4NVfXw7JqZYO1CgbsLhHCmsnyFGdgHAJoBu7AfqlBE=;
 b=fy/5T/D7vL5XoSLTd5GXlmpydV2QeAVCP/VlvTpILFHaNilnaoE5eFLbxNcPvky7RG
 lQacXkbmE4OIoPi4bhuHEb/cCE1XGvJFHbw+Lh7ik647pEV377TmU67J9LkD6SqlGW+k
 smHscdB7LKKjJwUUrfyGFXHfOgUJZ2QLsUWpz/dx4pAaFinQukdOlhg8QmaXI2z40NIJ
 V+1i59SbWbIziWlNYb/vJ5pFWpcSjZZAsY4Z4WYNY62GxMZc1KDDBSE1hVn8AEHh8xNC
 AMflmywgfrJoSQu6oNH8FFmZL628pxTfLUCAwh418coLd1a0LvLbyl1yrs5xF0d0iM5e
 zZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w4NVfXw7JqZYO1CgbsLhHCmsnyFGdgHAJoBu7AfqlBE=;
 b=bsANGAa55wWplILt2zxh51Sde4YmhHlbI9jNyqB+/oiXJzrrRYQRiRgDK3FHUouacY
 0QJ+pKjqTaX6Qx/5uU067aWNGy3L8uUSle6bx/Ga5Ol+F4p4MgjAL1o43ycToN1R/Owo
 Kwmh/nlvT43U1vm8oNodijD02mBef807XhQG3kDMkwtw3sfdFJ6km/el1VJSVKwu4fRL
 vK+VdvG9sC7x9b97Gq3iOE05kq3is1pdQeHZENDyJ60y/gxcnJAakGXiZS7Cerv4Tu0K
 Qe0lfBEMY+LOY3EuLo/CQLsdahNwanBY3oy74Mdow3OrI1hVPMyelrTTxQa+jO+GC/Fm
 o3ig==
X-Gm-Message-State: AOAM531KdlvtY/ZJbopbL/p5cOSI+ZSAAP/DLFU8uwbYpeX8gsUMuKTs
 3HRw8ZDVqXufce9o+A/R7/Y0/AHk3TPcD6x+/Fg=
X-Google-Smtp-Source: ABdhPJyvDCbURh6xi0mej3thS9+W1+NwpIbH8wT5ZwvegZDkhEk9+lTIEk9LPa2W1QTw4nRbPGR4IvYVmKjLtZe5lhE=
X-Received: by 2002:a17:90a:67c6:: with SMTP id
 g6mr8720352pjm.198.1621393853629; 
 Tue, 18 May 2021 20:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210518121628.9811-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51560CD55134762EF8FE19E0F82C9@CH0PR12MB5156.namprd12.prod.outlook.com>
 <1ec97d1f-aaa3-46c1-b702-378879e67cc5@amd.com>
 <DM6PR12MB3547CE479C026EF6D7F8A26CF72C9@DM6PR12MB3547.namprd12.prod.outlook.com>
 <CH0PR12MB5156C835F4B80F4504B0E98AF82B9@CH0PR12MB5156.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5156C835F4B80F4504B0E98AF82B9@CH0PR12MB5156.namprd12.prod.outlook.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 18 May 2021 23:10:41 -0400
Message-ID: <CAAxE2A7C0QGKvf-ToA_R_-cDZsGNiQ5gxf_77_QmxvRu3YbjDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
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
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "Deng,
 Emily" <Emily.Deng@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Nieto,
 David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============1723184269=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1723184269==
Content-Type: multipart/alternative; boundary="000000000000afc74505c2a62c6b"

--000000000000afc74505c2a62c6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mesa doesn't have any use for this. It should be ok to expose just the
ioctl without userspace because it's just vbios info.

Marek

On Tue., May 18, 2021, 22:41 Gu, JiaWei (Will), <JiaWei.Gu@amd.com> wrote:

> [AMD Official Use Only - Internal Distribution Only]
>
> Thanks Tom's suggestion.
> I'm fine to replace ioctl with sysfs.
>
> Hi all, how about this sysfs alternative?
>
> And if it's a must to insist on ioctl, is there any Mesa expert to help
> provide the patch?
>
> Best regards,
> Jiawei
>
>
> -----Original Message-----
> From: StDenis, Tom <Tom.StDenis@amd.com>
> Sent: Tuesday, May 18, 2021 9:26 PM
> To: Koenig, Christian <Christian.Koenig@amd.com>; Gu, JiaWei (Will) <
> JiaWei.Gu@amd.com>; amd-gfx@lists.freedesktop.org; Nieto, David M <
> David.Nieto@amd.com>; maraeo@gmail.com; Deucher, Alexander <
> Alexander.Deucher@amd.com>
> Cc: Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> [AMD Official Use Only - Internal Distribution Only]
>
> If changing the ioctl is an issue why not just use sysfs?  umr already
> makes uses of all three for it's purposes so it's fine by me for either.
>
> Tom
>
> ________________________________________
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of
> Christian K=C3=B6nig <christian.koenig@amd.com>
> Sent: Tuesday, May 18, 2021 09:17
> To: Gu, JiaWei (Will); amd-gfx@lists.freedesktop.org; Nieto, David M;
> maraeo@gmail.com; Deucher, Alexander
> Cc: Deng, Emily
> Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface
>
> Well not an expert on that stuff, but looks like that should work for me.
>
> Question is can you provide a patch to use that information in Mesa as
> well? Umr might be sufficient as well as justification for upstreaming, b=
ut
> I want to be better save than sorry.
>
> Unless Marek has a better idea maybe add the vbios version to the string
> returned by GLX_MESA_query_renderer or something like that.
>
> Thanks,
> Christian.
>
> Am 18.05.21 um 14:19 schrieb Gu, JiaWei (Will):
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Hi all,
> >
> > Please help confirm that we're all fine with this new struct in uapi in
> this V3 patch:
> >
> > +struct drm_amdgpu_info_vbios {
> > +     __u8 name[64];
> > +     __u8 vbios_pn[64];
> > +     __u32 version;
> > +     __u8 vbios_ver_str[32];
> > +     __u8 date[32];
> > +};
> >
> > Best regards,
> > Jiawei
> >
> > -----Original Message-----
> > From: Jiawei Gu <Jiawei.Gu@amd.com>
> > Sent: Tuesday, May 18, 2021 8:16 PM
> > To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> > <Christian.Koenig@amd.com>; Nieto, David M <David.Nieto@amd.com>;
> > maraeo@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will)
> > <JiaWei.Gu@amd.com>
> > Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface
> >
> > Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.
> >
> > Provides a way for the user application to get the VBIOS information
> without having to parse the binary.
> > It is useful for the user to be able to display in a simple way the
> VBIOS version in their system if they happen to encounter an issue.
> >
> > V2:
> > Use numeric serial.
> > Parse and expose vbios version string.
> >
> > V3:
> > Remove redundant data in drm_amdgpu_info_vbios struct.
> >
> > Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  15 ++
> >   drivers/gpu/drm/amd/amdgpu/atom.c          | 172 ++++++++++++++++++++=
+
> >   drivers/gpu/drm/amd/amdgpu/atom.h          |  10 ++
> >   drivers/gpu/drm/amd/include/atomfirmware.h |   5 +
> >   include/uapi/drm/amdgpu_drm.h              |  10 ++
> >   5 files changed, 212 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index 8d12e474745a..524e4fe5efe8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -861,6 +861,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
> >                                           min((size_t)size,
> (size_t)(bios_size - bios_offset)))
> >                                       ? -EFAULT : 0;
> >               }
> > +             case AMDGPU_INFO_VBIOS_INFO: {
> > +                     struct drm_amdgpu_info_vbios vbios_info =3D {};
> > +                     struct atom_context *atom_context;
> > +
> > +                     atom_context =3D adev->mode_info.atom_context;
> > +                     memcpy(vbios_info.name, atom_context->name,
> sizeof(atom_context->name));
> > +                     memcpy(vbios_info.vbios_pn,
> atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
> > +                     vbios_info.version =3D atom_context->version;
> > +                     memcpy(vbios_info.vbios_ver_str,
> atom_context->vbios_ver_str,
> > +
>  sizeof(atom_context->vbios_ver_str));
> > +                     memcpy(vbios_info.date, atom_context->date,
> > +sizeof(atom_context->date));
> > +
> > +                     return copy_to_user(out, &vbios_info,
> > +                                             min((size_t)size,
> sizeof(vbios_info))) ? -EFAULT : 0;
> > +             }
> >               default:
> >                       DRM_DEBUG_KMS("Invalid request %d\n",
> >                                       info->vbios_info.type); diff
> > --git a/drivers/gpu/drm/amd/amdgpu/atom.c
> > b/drivers/gpu/drm/amd/amdgpu/atom.c
> > index 3dcb8b32f48b..6fa2229b7229 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> > @@ -31,6 +31,7 @@
> >
> >   #define ATOM_DEBUG
> >
> > +#include "atomfirmware.h"
> >   #include "atom.h"
> >   #include "atom-names.h"
> >   #include "atom-bits.h"
> > @@ -1299,12 +1300,168 @@ static void atom_index_iio(struct atom_context
> *ctx, int base)
> >       }
> >   }
> >
> > +static void atom_get_vbios_name(struct atom_context *ctx) {
> > +     unsigned char *p_rom;
> > +     unsigned char str_num;
> > +     unsigned short off_to_vbios_str;
> > +     unsigned char *c_ptr;
> > +     int name_size;
> > +     int i;
> > +
> > +     const char *na =3D "--N/A--";
> > +     char *back;
> > +
> > +     p_rom =3D ctx->bios;
> > +
> > +     str_num =3D *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS);
> > +     if (str_num !=3D 0) {
> > +             off_to_vbios_str =3D
> > +                     *(unsigned short *)(p_rom +
> > + OFFSET_TO_GET_ATOMBIOS_STRING_START);
> > +
> > +             c_ptr =3D (unsigned char *)(p_rom + off_to_vbios_str);
> > +     } else {
> > +             /* do not know where to find name */
> > +             memcpy(ctx->name, na, 7);
> > +             ctx->name[7] =3D 0;
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * skip the atombios strings, usually 4
> > +      * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th is Memory type
> > +      */
> > +     for (i =3D 0; i < str_num; i++) {
> > +             while (*c_ptr !=3D 0)
> > +                     c_ptr++;
> > +             c_ptr++;
> > +     }
> > +
> > +     /* skip the following 2 chars: 0x0D 0x0A */
> > +     c_ptr +=3D 2;
> > +
> > +     name_size =3D strnlen(c_ptr, STRLEN_LONG - 1);
> > +     memcpy(ctx->name, c_ptr, name_size);
> > +     back =3D ctx->name + name_size;
> > +     while ((*--back) =3D=3D ' ')
> > +             ;
> > +     *(back + 1) =3D '\0';
> > +}
> > +
> > +static void atom_get_vbios_date(struct atom_context *ctx) {
> > +     unsigned char *p_rom;
> > +     unsigned char *date_in_rom;
> > +
> > +     p_rom =3D ctx->bios;
> > +
> > +     date_in_rom =3D p_rom + OFFSET_TO_VBIOS_DATE;
> > +
> > +     ctx->date[0] =3D '2';
> > +     ctx->date[1] =3D '0';
> > +     ctx->date[2] =3D date_in_rom[6];
> > +     ctx->date[3] =3D date_in_rom[7];
> > +     ctx->date[4] =3D '/';
> > +     ctx->date[5] =3D date_in_rom[0];
> > +     ctx->date[6] =3D date_in_rom[1];
> > +     ctx->date[7] =3D '/';
> > +     ctx->date[8] =3D date_in_rom[3];
> > +     ctx->date[9] =3D date_in_rom[4];
> > +     ctx->date[10] =3D ' ';
> > +     ctx->date[11] =3D date_in_rom[9];
> > +     ctx->date[12] =3D date_in_rom[10];
> > +     ctx->date[13] =3D date_in_rom[11];
> > +     ctx->date[14] =3D date_in_rom[12];
> > +     ctx->date[15] =3D date_in_rom[13];
> > +     ctx->date[16] =3D '\0';
> > +}
> > +
> > +static unsigned char *atom_find_str_in_rom(struct atom_context *ctx,
> char *str, int start,
> > +                                        int end, int maxlen) {
> > +     unsigned long str_off;
> > +     unsigned char *p_rom;
> > +     unsigned short str_len;
> > +
> > +     str_off =3D 0;
> > +     str_len =3D strnlen(str, maxlen);
> > +     p_rom =3D ctx->bios;
> > +
> > +     for (; start <=3D end; ++start) {
> > +             for (str_off =3D 0; str_off < str_len; ++str_off) {
> > +                     if (str[str_off] !=3D *(p_rom + start + str_off))
> > +                             break;
> > +             }
> > +
> > +             if (str_off =3D=3D str_len || str[str_off] =3D=3D 0)
> > +                     return p_rom + start;
> > +     }
> > +     return NULL;
> > +}
> > +
> > +static void atom_get_vbios_pn(struct atom_context *ctx) {
> > +     unsigned char *p_rom;
> > +     unsigned short off_to_vbios_str;
> > +     unsigned char *vbios_str;
> > +     int count;
> > +
> > +     off_to_vbios_str =3D 0;
> > +     p_rom =3D ctx->bios;
> > +
> > +     if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS) !=3D 0) {
> > +             off_to_vbios_str =3D
> > +                     *(unsigned short *)(p_rom +
> > + OFFSET_TO_GET_ATOMBIOS_STRING_START);
> > +
> > +             vbios_str =3D (unsigned char *)(p_rom + off_to_vbios_str)=
;
> > +     } else {
> > +             vbios_str =3D p_rom + OFFSET_TO_VBIOS_PART_NUMBER;
> > +     }
> > +
> > +     if (*vbios_str =3D=3D 0) {
> > +             vbios_str =3D atom_find_str_in_rom(ctx, BIOS_ATOM_PREFIX,=
 3,
> 1024, 64);
> > +             if (vbios_str =3D=3D NULL)
> > +                     vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;
> > +     }
> > +     if (vbios_str !=3D NULL && *vbios_str =3D=3D 0)
> > +             vbios_str++;
> > +
> > +     if (vbios_str !=3D NULL) {
> > +             count =3D 0;
> > +             while ((count < BIOS_STRING_LENGTH) && vbios_str[count] >=
=3D
> ' ' &&
> > +                    vbios_str[count] <=3D 'z') {
> > +                     ctx->vbios_pn[count] =3D vbios_str[count];
> > +                     count++;
> > +             }
> > +
> > +             ctx->vbios_pn[count] =3D 0;
> > +     }
> > +}
> > +
> > +static void atom_get_vbios_version(struct atom_context *ctx) {
> > +     unsigned char *vbios_ver;
> > +
> > +     /* find anchor ATOMBIOSBK-AMD */
> > +     vbios_ver =3D atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3,
> 1024, 64);
> > +     if (vbios_ver !=3D NULL) {
> > +             /* skip ATOMBIOSBK-AMD VER */
> > +             vbios_ver +=3D 18;
> > +             memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
> > +     } else {
> > +             ctx->vbios_ver_str[0] =3D '\0';
> > +     }
> > +}
> > +
> >   struct atom_context *amdgpu_atom_parse(struct card_info *card, void
> *bios)  {
> >       int base;
> >       struct atom_context *ctx =3D
> >           kzalloc(sizeof(struct atom_context), GFP_KERNEL);
> >       char *str;
> > +     struct _ATOM_ROM_HEADER *atom_rom_header;
> > +     struct _ATOM_MASTER_DATA_TABLE *master_table;
> > +     struct _ATOM_FIRMWARE_INFO *atom_fw_info;
> >       u16 idx;
> >
> >       if (!ctx)
> > @@ -1353,6 +1510,21 @@ struct atom_context *amdgpu_atom_parse(struct
> card_info *card, void *bios)
> >               strlcpy(ctx->vbios_version, str,
> sizeof(ctx->vbios_version));
> >       }
> >
> > +     atom_rom_header =3D (struct _ATOM_ROM_HEADER *)CSTR(base);
> > +     if (atom_rom_header->usMasterDataTableOffset !=3D 0) {
> > +             master_table =3D (struct _ATOM_MASTER_DATA_TABLE *)
> > +
>  CSTR(atom_rom_header->usMasterDataTableOffset);
> > +             if (master_table->ListOfDataTables.FirmwareInfo !=3D 0) {
> > +                     atom_fw_info =3D (struct _ATOM_FIRMWARE_INFO *)
> > +
>  CSTR(master_table->ListOfDataTables.FirmwareInfo);
> > +                     ctx->version =3D atom_fw_info->ulFirmwareRevision=
;
> > +             }
> > +     }
> > +
> > +     atom_get_vbios_name(ctx);
> > +     atom_get_vbios_pn(ctx);
> > +     atom_get_vbios_date(ctx);
> > +     atom_get_vbios_version(ctx);
> >
> >       return ctx;
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h
> > b/drivers/gpu/drm/amd/amdgpu/atom.h
> > index d279759cab47..0c1839824520 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> > @@ -112,6 +112,10 @@ struct drm_device;
> >   #define ATOM_IO_SYSIO               2
> >   #define ATOM_IO_IIO         0x80
> >
> > +#define STRLEN_NORMAL                32
> > +#define STRLEN_LONG          64
> > +#define STRLEN_VERYLONG              254
> > +
> >   struct card_info {
> >       struct drm_device *dev;
> >       void (* reg_write)(struct card_info *, uint32_t, uint32_t);   /*
> filled by driver */
> > @@ -140,6 +144,12 @@ struct atom_context {
> >       uint32_t *scratch;
> >       int scratch_size_bytes;
> >       char vbios_version[20];
> > +
> > +     uint8_t name[STRLEN_LONG];
> > +     uint8_t vbios_pn[STRLEN_LONG];
> > +     uint32_t version;
> > +     uint8_t vbios_ver_str[STRLEN_NORMAL];
> > +     uint8_t date[STRLEN_NORMAL];
> >   };
> >
> >   extern int amdgpu_atom_debug;
> > diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h
> > b/drivers/gpu/drm/amd/include/atomfirmware.h
> > index 275468e4be60..28deecc2f990 100644
> > --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> > +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> > @@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{
> >     DP_VS_LEVEL0_PREEMPH_LEVEL3 =3D 0x18,
> >   };
> >
> > +#define BIOS_ATOM_PREFIX   "ATOMBIOS"
> > +#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
> > +#define BIOS_STRING_LENGTH 43
> >
> >   /*
> >   enum atom_string_def{
> > @@ -215,6 +218,8 @@ enum atombios_image_offset{
> >     MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE      =3D 20,  /*including the
> terminator 0x0!*/
> >     OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS   =3D 0x2f,
> >     OFFSET_TO_GET_ATOMBIOS_STRING_START        =3D 0x6e,
> > +  OFFSET_TO_VBIOS_PART_NUMBER                =3D 0x80,
> > +  OFFSET_TO_VBIOS_DATE                       =3D 0x50,
> >   };
> >
> >
> > /*********************************************************************
> > ******* diff --git a/include/uapi/drm/amdgpu_drm.h
> > b/include/uapi/drm/amdgpu_drm.h index 9169df7fadee..155fd9918b4d
> > 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {
> >       #define AMDGPU_INFO_VBIOS_SIZE          0x1
> >       /* Subquery id: Query vbios image */
> >       #define AMDGPU_INFO_VBIOS_IMAGE         0x2
> > +     /* Subquery id: Query vbios info */
> > +     #define AMDGPU_INFO_VBIOS_INFO          0x3
> >   /* Query UVD handles */
> >   #define AMDGPU_INFO_NUM_HANDLES                     0x1C
> >   /* Query sensor related information */ @@ -949,6 +951,14 @@ struct
> > drm_amdgpu_info_firmware {
> >       __u32 feature;
> >   };
> >
> > +struct drm_amdgpu_info_vbios {
> > +     __u8 name[64];
> > +     __u8 vbios_pn[64];
> > +     __u32 version;
> > +     __u8 vbios_ver_str[32];
> > +     __u8 date[32];
> > +};
> > +
> >   #define AMDGPU_VRAM_TYPE_UNKNOWN 0
> >   #define AMDGPU_VRAM_TYPE_GDDR1 1
> >   #define AMDGPU_VRAM_TYPE_DDR2  2
> > --
> > 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Ctom.st=
denis%40amd.com%7C332524597a5e42ad491908d919ff414f%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637569406377960645%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D=
ZFBUbqu1VjvQkpnQ4Wy6Q4XE9CB2IcFltOq3Iv12F7U%3D&amp;reserved=3D0
>

--000000000000afc74505c2a62c6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Mesa doesn&#39;t have any use for this. It should be ok t=
o expose just the ioctl without userspace because it&#39;s just vbios info.=
<div dir=3D"auto"><br></div><div dir=3D"auto">Marek</div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue., May 18, 2=
021, 22:41 Gu, JiaWei (Will), &lt;<a href=3D"mailto:JiaWei.Gu@amd.com">JiaW=
ei.Gu@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">[AMD O=
fficial Use Only - Internal Distribution Only]<br>
<br>
Thanks Tom&#39;s suggestion.<br>
I&#39;m fine to replace ioctl with sysfs.<br>
<br>
Hi all, how about this sysfs alternative?<br>
<br>
And if it&#39;s a must to insist on ioctl, is there any Mesa expert to help=
 provide the patch?<br>
<br>
Best regards,<br>
Jiawei<br>
<br>
<br>
-----Original Message-----<br>
From: StDenis, Tom &lt;<a href=3D"mailto:Tom.StDenis@amd.com" target=3D"_bl=
ank" rel=3D"noreferrer">Tom.StDenis@amd.com</a>&gt; <br>
Sent: Tuesday, May 18, 2021 9:26 PM<br>
To: Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com" targe=
t=3D"_blank" rel=3D"noreferrer">Christian.Koenig@amd.com</a>&gt;; Gu, JiaWe=
i (Will) &lt;<a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_blank" rel=3D"=
noreferrer">JiaWei.Gu@amd.com</a>&gt;; <a href=3D"mailto:amd-gfx@lists.free=
desktop.org" target=3D"_blank" rel=3D"noreferrer">amd-gfx@lists.freedesktop=
.org</a>; Nieto, David M &lt;<a href=3D"mailto:David.Nieto@amd.com" target=
=3D"_blank" rel=3D"noreferrer">David.Nieto@amd.com</a>&gt;; <a href=3D"mail=
to:maraeo@gmail.com" target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.com<=
/a>; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com" ta=
rget=3D"_blank" rel=3D"noreferrer">Alexander.Deucher@amd.com</a>&gt;<br>
Cc: Deng, Emily &lt;<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_blank"=
 rel=3D"noreferrer">Emily.Deng@amd.com</a>&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface<br>
<br>
[AMD Official Use Only - Internal Distribution Only]<br>
<br>
If changing the ioctl is an issue why not just use sysfs?=C2=A0 umr already=
 makes uses of all three for it&#39;s purposes so it&#39;s fine by me for e=
ither.<br>
<br>
Tom<br>
<br>
________________________________________<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org" =
target=3D"_blank" rel=3D"noreferrer">amd-gfx-bounces@lists.freedesktop.org<=
/a>&gt; on behalf of Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.k=
oenig@amd.com" target=3D"_blank" rel=3D"noreferrer">christian.koenig@amd.co=
m</a>&gt;<br>
Sent: Tuesday, May 18, 2021 09:17<br>
To: Gu, JiaWei (Will); <a href=3D"mailto:amd-gfx@lists.freedesktop.org" tar=
get=3D"_blank" rel=3D"noreferrer">amd-gfx@lists.freedesktop.org</a>; Nieto,=
 David M; <a href=3D"mailto:maraeo@gmail.com" target=3D"_blank" rel=3D"nore=
ferrer">maraeo@gmail.com</a>; Deucher, Alexander<br>
Cc: Deng, Emily<br>
Subject: Re: [PATCH] drm/amdgpu: Add vbios info ioctl interface<br>
<br>
Well not an expert on that stuff, but looks like that should work for me.<b=
r>
<br>
Question is can you provide a patch to use that information in Mesa as well=
? Umr might be sufficient as well as justification for upstreaming, but I w=
ant to be better save than sorry.<br>
<br>
Unless Marek has a better idea maybe add the vbios version to the string re=
turned by GLX_MESA_query_renderer or something like that.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 18.05.21 um 14:19 schrieb Gu, JiaWei (Will):<br>
&gt; [AMD Official Use Only - Internal Distribution Only]<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; Please help confirm that we&#39;re all fine with this new struct in ua=
pi in this V3 patch:<br>
&gt;<br>
&gt; +struct drm_amdgpu_info_vbios {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u8 name[64];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u8 vbios_pn[64];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 version;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u8 vbios_ver_str[32];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u8 date[32];<br>
&gt; +};<br>
&gt;<br>
&gt; Best regards,<br>
&gt; Jiawei<br>
&gt;<br>
&gt; -----Original Message-----<br>
&gt; From: Jiawei Gu &lt;<a href=3D"mailto:Jiawei.Gu@amd.com" target=3D"_bl=
ank" rel=3D"noreferrer">Jiawei.Gu@amd.com</a>&gt;<br>
&gt; Sent: Tuesday, May 18, 2021 8:16 PM<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank"=
 rel=3D"noreferrer">amd-gfx@lists.freedesktop.org</a>; Koenig, Christian <b=
r>
&gt; &lt;<a href=3D"mailto:Christian.Koenig@amd.com" target=3D"_blank" rel=
=3D"noreferrer">Christian.Koenig@amd.com</a>&gt;; Nieto, David M &lt;<a hre=
f=3D"mailto:David.Nieto@amd.com" target=3D"_blank" rel=3D"noreferrer">David=
.Nieto@amd.com</a>&gt;; <br>
&gt; <a href=3D"mailto:maraeo@gmail.com" target=3D"_blank" rel=3D"noreferre=
r">maraeo@gmail.com</a>; Deucher, Alexander &lt;<a href=3D"mailto:Alexander=
.Deucher@amd.com" target=3D"_blank" rel=3D"noreferrer">Alexander.Deucher@am=
d.com</a>&gt;<br>
&gt; Cc: Deng, Emily &lt;<a href=3D"mailto:Emily.Deng@amd.com" target=3D"_b=
lank" rel=3D"noreferrer">Emily.Deng@amd.com</a>&gt;; Gu, JiaWei (Will) <br>
&gt; &lt;<a href=3D"mailto:JiaWei.Gu@amd.com" target=3D"_blank" rel=3D"nore=
ferrer">JiaWei.Gu@amd.com</a>&gt;<br>
&gt; Subject: [PATCH] drm/amdgpu: Add vbios info ioctl interface<br>
&gt;<br>
&gt; Add AMDGPU_INFO_VBIOS_INFO subquery id for detailed vbios info.<br>
&gt;<br>
&gt; Provides a way for the user application to get the VBIOS information w=
ithout having to parse the binary.<br>
&gt; It is useful for the user to be able to display in a simple way the VB=
IOS version in their system if they happen to encounter an issue.<br>
&gt;<br>
&gt; V2:<br>
&gt; Use numeric serial.<br>
&gt; Parse and expose vbios version string.<br>
&gt;<br>
&gt; V3:<br>
&gt; Remove redundant data in drm_amdgpu_info_vbios struct.<br>
&gt;<br>
&gt; Signed-off-by: Jiawei Gu &lt;<a href=3D"mailto:Jiawei.Gu@amd.com" targ=
et=3D"_blank" rel=3D"noreferrer">Jiawei.Gu@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c=C2=A0 =C2=A0 |=C2=
=A0 15 ++<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/atom.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 172 +++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/atom.h=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 10 ++<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/include/atomfirmware.h |=C2=A0 =C2=A05=
 +<br>
&gt;=C2=A0 =C2=A0include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 ++<br>
&gt;=C2=A0 =C2=A05 files changed, 212 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; index 8d12e474745a..524e4fe5efe8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; @@ -861,6 +861,21 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *filp)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0min((size_t)size, (size_t)(bios_size - bios_offset)))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? -EFA=
ULT : 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_INFO_VBIO=
S_INFO: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0struct drm_amdgpu_info_vbios vbios_info =3D {};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0struct atom_context *atom_context;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0atom_context =3D adev-&gt;mode_info.atom_context;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0memcpy(<a href=3D"http://vbios_info.name" rel=3D"noreferrer noreferr=
er" target=3D"_blank">vbios_info.name</a>, atom_context-&gt;name, sizeof(at=
om_context-&gt;name));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0memcpy(vbios_info.vbios_pn, atom_context-&gt;vbios_pn, sizeof(atom_c=
ontext-&gt;vbios_pn));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vbios_info.version =3D atom_context-&gt;version;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0memcpy(vbios_info.vbios_ver_str, atom_context-&gt;vbios_ver_str,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sizeof(atom_context-&gt;vbios_ver_str));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0memcpy(vbios_info.date, atom_context-&gt;date, <br>
&gt; +sizeof(atom_context-&gt;date));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return copy_to_user(out, &amp;vbios_info,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0DRM_DEBUG_KMS(&quot;Invalid request %d\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0info-&=
gt;vbios_info.type); diff <br>
&gt; --git a/drivers/gpu/drm/amd/amdgpu/atom.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt; index 3dcb8b32f48b..6fa2229b7229 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/atom.c<br>
&gt; @@ -31,6 +31,7 @@<br>
&gt;<br>
&gt;=C2=A0 =C2=A0#define ATOM_DEBUG<br>
&gt;<br>
&gt; +#include &quot;atomfirmware.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;atom.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;atom-names.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;atom-bits.h&quot;<br>
&gt; @@ -1299,12 +1300,168 @@ static void atom_index_iio(struct atom_contex=
t *ctx, int base)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +static void atom_get_vbios_name(struct atom_context *ctx) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char *p_rom;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char str_num;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned short off_to_vbios_str;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char *c_ptr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int name_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int i;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const char *na =3D &quot;--N/A--&quot;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *back;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0p_rom =3D ctx-&gt;bios;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0str_num =3D *(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMB=
ER_OF_STRINGS);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (str_num !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0off_to_vbios_str =3D<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*(unsigned short *)(p_rom + <br>
&gt; + OFFSET_TO_GET_ATOMBIOS_STRING_START);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_ptr =3D (unsigned c=
har *)(p_rom + off_to_vbios_str);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* do not know where =
to find name */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(ctx-&gt;name, =
na, 7);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;name[7] =3D 0=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * skip the atombios strings, usually 4<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * 1st is P/N, 2nd is ASIC, 3rd is PCI type, 4th =
is Memory type<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; str_num; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while (*c_ptr !=3D 0)=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0c_ptr++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_ptr++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* skip the following 2 chars: 0x0D 0x0A */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0c_ptr +=3D 2;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0name_size =3D strnlen(c_ptr, STRLEN_LONG - 1);<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0memcpy(ctx-&gt;name, c_ptr, name_size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0back =3D ctx-&gt;name + name_size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while ((*--back) =3D=3D &#39; &#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0*(back + 1) =3D &#39;\0&#39;;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void atom_get_vbios_date(struct atom_context *ctx) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char *p_rom;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char *date_in_rom;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0p_rom =3D ctx-&gt;bios;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0date_in_rom =3D p_rom + OFFSET_TO_VBIOS_DATE;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[0] =3D &#39;2&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[1] =3D &#39;0&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[2] =3D date_in_rom[6];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[3] =3D date_in_rom[7];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[4] =3D &#39;/&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[5] =3D date_in_rom[0];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[6] =3D date_in_rom[1];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[7] =3D &#39;/&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[8] =3D date_in_rom[3];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[9] =3D date_in_rom[4];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[10] =3D &#39; &#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[11] =3D date_in_rom[9];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[12] =3D date_in_rom[10];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[13] =3D date_in_rom[11];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[14] =3D date_in_rom[12];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[15] =3D date_in_rom[13];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctx-&gt;date[16] =3D &#39;\0&#39;;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static unsigned char *atom_find_str_in_rom(struct atom_context *ctx, =
char *str, int start,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int =
end, int maxlen) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned long str_off;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char *p_rom;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned short str_len;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0str_off =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0str_len =3D strnlen(str, maxlen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0p_rom =3D ctx-&gt;bios;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (; start &lt;=3D end; ++start) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (str_off =3D 0; s=
tr_off &lt; str_len; ++str_off) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (str[str_off] !=3D *(p_rom + start + str_off))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (str_off =3D=3D st=
r_len || str[str_off] =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return p_rom + start;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void atom_get_vbios_pn(struct atom_context *ctx) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char *p_rom;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned short off_to_vbios_str;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char *vbios_str;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int count;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0off_to_vbios_str =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0p_rom =3D ctx-&gt;bios;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (*(p_rom + OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_ST=
RINGS) !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0off_to_vbios_str =3D<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0*(unsigned short *)(p_rom + <br>
&gt; + OFFSET_TO_GET_ATOMBIOS_STRING_START);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vbios_str =3D (unsign=
ed char *)(p_rom + off_to_vbios_str);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vbios_str =3D p_rom +=
 OFFSET_TO_VBIOS_PART_NUMBER;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (*vbios_str =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vbios_str =3D atom_fi=
nd_str_in_rom(ctx, BIOS_ATOM_PREFIX, 3, 1024, 64);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vbios_str =3D=3D =
NULL)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0vbios_str +=3D sizeof(BIOS_ATOM_PREFIX) - 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vbios_str !=3D NULL &amp;&amp; *vbios_str =3D=
=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vbios_str++;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vbios_str !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((count &lt; BI=
OS_STRING_LENGTH) &amp;&amp; vbios_str[count] &gt;=3D &#39; &#39; &amp;&amp=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 vbios_str[count] &lt;=3D &#39;z&#39;) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ctx-&gt;vbios_pn[count] =3D vbios_str[count];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0count++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;vbios_pn[coun=
t] =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void atom_get_vbios_version(struct atom_context *ctx) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char *vbios_ver;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* find anchor ATOMBIOSBK-AMD */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0vbios_ver =3D atom_find_str_in_rom(ctx, BIOS_VERS=
ION_PREFIX, 3, 1024, 64);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (vbios_ver !=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* skip ATOMBIOSBK-AM=
D VER */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vbios_ver +=3D 18;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(ctx-&gt;vbios_=
ver_str, vbios_ver, STRLEN_NORMAL);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctx-&gt;vbios_ver_str=
[0] =3D &#39;\0&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0struct atom_context *amdgpu_atom_parse(struct card_info *c=
ard, void *bios)=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct atom_context *ctx =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kzalloc(sizeof(struct atom_con=
text), GFP_KERNEL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *str;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _ATOM_ROM_HEADER *atom_rom_header;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _ATOM_MASTER_DATA_TABLE *master_table;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct _ATOM_FIRMWARE_INFO *atom_fw_info;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0u16 idx;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ctx)<br>
&gt; @@ -1353,6 +1510,21 @@ struct atom_context *amdgpu_atom_parse(struct c=
ard_info *card, void *bios)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strlcpy(ctx-&gt;=
vbios_version, str, sizeof(ctx-&gt;vbios_version));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0atom_rom_header =3D (struct _ATOM_ROM_HEADER *)CS=
TR(base);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (atom_rom_header-&gt;usMasterDataTableOffset !=
=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0master_table =3D (str=
uct _ATOM_MASTER_DATA_TABLE *)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CSTR(atom_rom_header-&gt;usMasterDataTab=
leOffset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (master_table-&gt;=
ListOfDataTables.FirmwareInfo !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0atom_fw_info =3D (struct _ATOM_FIRMWARE_INFO *)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CSTR(master_=
table-&gt;ListOfDataTables.FirmwareInfo);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ctx-&gt;version =3D atom_fw_info-&gt;ulFirmwareRevision;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0atom_get_vbios_name(ctx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0atom_get_vbios_pn(ctx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0atom_get_vbios_date(ctx);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0atom_get_vbios_version(ctx);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ctx;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/atom.h<br>
&gt; index d279759cab47..0c1839824520 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/atom.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/atom.h<br>
&gt; @@ -112,6 +112,10 @@ struct drm_device;<br>
&gt;=C2=A0 =C2=A0#define ATOM_IO_SYSIO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A02<br>
&gt;=C2=A0 =C2=A0#define ATOM_IO_IIO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x80<=
br>
&gt;<br>
&gt; +#define STRLEN_NORMAL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 32<br>
&gt; +#define STRLEN_LONG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 64<br>
&gt; +#define STRLEN_VERYLONG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 254<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0struct card_info {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct drm_device *dev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0void (* reg_write)(struct card_info *, uint3=
2_t, uint32_t);=C2=A0 =C2=A0/*=C2=A0 filled by driver */<br>
&gt; @@ -140,6 +144,12 @@ struct atom_context {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t *scratch;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int scratch_size_bytes;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char vbios_version[20];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint8_t name[STRLEN_LONG];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint8_t vbios_pn[STRLEN_LONG];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t version;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint8_t vbios_ver_str[STRLEN_NORMAL];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0uint8_t date[STRLEN_NORMAL];<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;<br>
&gt;=C2=A0 =C2=A0extern int amdgpu_atom_debug;<br>
&gt; diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h <br>
&gt; b/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt; index 275468e4be60..28deecc2f990 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt; +++ b/drivers/gpu/drm/amd/include/atomfirmware.h<br>
&gt; @@ -197,6 +197,9 @@ enum atom_dp_vs_preemph_def{<br>
&gt;=C2=A0 =C2=A0 =C2=A0DP_VS_LEVEL0_PREEMPH_LEVEL3 =3D 0x18,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;<br>
&gt; +#define BIOS_ATOM_PREFIX=C2=A0 =C2=A0&quot;ATOMBIOS&quot;<br>
&gt; +#define BIOS_VERSION_PREFIX=C2=A0 &quot;ATOMBIOSBK-AMD&quot;<br>
&gt; +#define BIOS_STRING_LENGTH 43<br>
&gt;<br>
&gt;=C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0enum atom_string_def{<br>
&gt; @@ -215,6 +218,8 @@ enum atombios_image_offset{<br>
&gt;=C2=A0 =C2=A0 =C2=A0MAXSIZE_OF_ATOMBIOS_ASIC_BUS_MEM_TYPE=C2=A0 =C2=A0 =
=C2=A0 =3D 20,=C2=A0 /*including the terminator 0x0!*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0OFFSET_TO_GET_ATOMBIOS_NUMBER_OF_STRINGS=C2=A0 =C2=
=A0=3D 0x2f,<br>
&gt;=C2=A0 =C2=A0 =C2=A0OFFSET_TO_GET_ATOMBIOS_STRING_START=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =3D 0x6e,<br>
&gt; +=C2=A0 OFFSET_TO_VBIOS_PART_NUMBER=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D 0x80,<br>
&gt; +=C2=A0 OFFSET_TO_VBIOS_DATE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x50,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; /*********************************************************************=
<br>
&gt; ******* diff --git a/include/uapi/drm/amdgpu_drm.h <br>
&gt; b/include/uapi/drm/amdgpu_drm.h index 9169df7fadee..155fd9918b4d <br>
&gt; 100644<br>
&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt; @@ -756,6 +756,8 @@ struct drm_amdgpu_cs_chunk_data {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#define AMDGPU_INFO_VBIOS_SIZE=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 0x1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Subquery id: Query vbios image */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0#define AMDGPU_INFO_VBIOS_IMAGE=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A00x2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Subquery id: Query vbios info */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0#define AMDGPU_INFO_VBIOS_INFO=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 0x3<br>
&gt;=C2=A0 =C2=A0/* Query UVD handles */<br>
&gt;=C2=A0 =C2=A0#define AMDGPU_INFO_NUM_HANDLES=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1C<br>
&gt;=C2=A0 =C2=A0/* Query sensor related information */ @@ -949,6 +951,14 @=
@ struct <br>
&gt; drm_amdgpu_info_firmware {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 feature;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;<br>
&gt; +struct drm_amdgpu_info_vbios {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u8 name[64];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u8 vbios_pn[64];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u32 version;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u8 vbios_ver_str[32];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0__u8 date[32];<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#define AMDGPU_VRAM_TYPE_UNKNOWN 0<br>
&gt;=C2=A0 =C2=A0#define AMDGPU_VRAM_TYPE_GDDR1 1<br>
&gt;=C2=A0 =C2=A0#define AMDGPU_VRAM_TYPE_DDR2=C2=A0 2<br>
&gt; --<br>
&gt; 2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx@lists.freedesktop.org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Ctom.stdenis%40amd.com%7C332524597a5e42ad491908d919ff414f%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637569406377960645%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DZFBUbqu1VjvQkpnQ4Wy6Q4XE9CB2IcFltOq3Iv12F7U%3D&amp;amp;res=
erved=3D0" rel=3D"noreferrer noreferrer" target=3D"_blank">https://nam11.sa=
felinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2=
Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Ctom.stdenis%40amd.co=
m%7C332524597a5e42ad491908d919ff414f%7C3dd8961fe4884e608e11a82d994e183d%7C0=
%7C0%7C637569406377960645%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI=
joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3DZFBUbqu1Vj=
vQkpnQ4Wy6Q4XE9CB2IcFltOq3Iv12F7U%3D&amp;amp;reserved=3D0</a><br>
</blockquote></div>

--000000000000afc74505c2a62c6b--

--===============1723184269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1723184269==--
