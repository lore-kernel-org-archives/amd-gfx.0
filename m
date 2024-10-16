Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BE0D1AD5E
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Oct 2024 13:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6910710E70B;
	Wed, 16 Oct 2024 13:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eRpeYjVt";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14FB10E70B
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 13:52:02 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2e2d83f15f3so1117326a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Oct 2024 06:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729086722; x=1729691522; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFpoLLYYaaTpvmijUCM3JvSlQGFCH2AVXtveSEraoOI=;
 b=eRpeYjVtdCPv6ftIk9Sr9mWLAe4rzB9iN8lYTIKpkZWUeXiWMhGWYC/VxzqwoBy6hM
 yIhTopjLlwkhk4gBD8qLQayWcAa8xg8IFt0mmu7HYmtAg4MCC2bhq2CcKsi5hN/vT64S
 HnyOT1GinZ94el1RJxb+ZUM8dzUHeHcVxS6k5nbJh3xpfRw6io66WWZjKhCbzd+G4Ufv
 4WnlfxC97I2pQLLzhzjgSZq0iKzefS6NcPSSFy/DFW998J8F9WXgOf7dcGBGUZ5IoLjZ
 v9K457t+xyq/3mzRlfyn4N6P+erJ/XtUwwVq7y9gLIGUQULZXHowJOy4pgGu0TGgBHkL
 VlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729086722; x=1729691522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LFpoLLYYaaTpvmijUCM3JvSlQGFCH2AVXtveSEraoOI=;
 b=gnm2eP0Tq/kTbfG+7TmSkN1GhZcdJE4RQKW67Y7JNjZJEsIlAmrUODcIXBuSW+cGgi
 2s3C3EAkwC6h0d5AhMpqY8TkT3AlkGIMA3IhgBqkLAJCz1x9AqQwDIAz8uNIY0NhqRwB
 GUyzXkian620nxWj8kXsb2c0kv2weHF+1qcea410I1ZoS/4v8NCb7jjo21pwMkccayqV
 HGj9QBKiF7lu+pI/5IibOcORLhSmwSZ1idf1GPhbKN1Akr0T+RWdzt2Ze83G6xHyN/e5
 CNVvus2Dcll5OCvdjNkMZeR3rjzduqOoyaQ2rKuTND8KpTr/orHN8T6XghsONv8MgGsk
 L2Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8rbEHqkTV2HD2BqyVGJrRVznBvrVdy4MIUm84LReSuXG9IkPp1vOHweTrJfN7t/eit4Dbavgj@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyY7SZRqW+s1zEsUXLXJgNUtMfEs70z4ALFI98JPMSOU0Emikzr
 o6APJYJ7Lp1a5Hkpa5kP9CgQd5dsSOAt9muIl43H/XkI5CBvioErNhogILPhN0T5yHS+v6EJB50
 U5QwX8OMba7GYIHy10VQELrS+DzNfww==
X-Google-Smtp-Source: AGHT+IFA268d58Lb2xSdI7L0dKXhH5JQQfLyqTOO7qG+HLYx1wnvDUuvQbMZXVzYSNQIOfs6zBvAg4FpLbnPUFvArF0=
X-Received: by 2002:a17:90b:a16:b0:2e2:d1c0:758a with SMTP id
 98e67ed59e1d1-2e2f0db90f3mr9037105a91.8.1729086722303; Wed, 16 Oct 2024
 06:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241016023558.22970-1-Frank.Min@amd.com>
 <SN7PR12MB69328B4538D6D15775646499E9462@SN7PR12MB6932.namprd12.prod.outlook.com>
 <349b1d5d-7153-411c-9667-fbb5c5f24110@amd.com>
 <SN7PR12MB693257E4EA24395F251CCA89E9462@SN7PR12MB6932.namprd12.prod.outlook.com>
In-Reply-To: <SN7PR12MB693257E4EA24395F251CCA89E9462@SN7PR12MB6932.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Oct 2024 09:51:51 -0400
Message-ID: <CADnq5_NK15dXc0j22imwDGH7wwDfKdiDoshO1R87Jv4BV_Eyqw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix random data corruption for sdma 7
To: "Min, Frank" <Frank.Min@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>, "Olsak, Marek" <Marek.Olsak@amd.com>
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

On Wed, Oct 16, 2024 at 2:19=E2=80=AFAM Min, Frank <Frank.Min@amd.com> wrot=
e:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Lijo,
> Thanks a lot for your review and suggestions.
>
> Here are the updated patches.

Patches look good, but I agree with Lijo that we should switch to a
dedicated sdma7 header at some point in case there are other
discrepancies, but I think that can be a later update.  Some
additional comments below.

>
> Best Regards,
> Frank
>
> From: Frank Min <Frank.Min@amd.com>
> Date: Thu, 10 Oct 2024 16:41:32 +0800
> Subject: [PATCH 1/2] drm/amdgpu: fix random data corruption for sdma 7
>
> There is random data corruption caused by const fill, this is caused by
> write compression mode not correctly configured.
>
> So correct compression mode for const fill.
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h | 6 ++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 3 ++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h b/drivers/=
gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
> index d8cf830916b9..9f43c14f0bb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
> @@ -4346,6 +4346,12 @@
>  #define SDMA_PKT_CONSTANT_FILL_HEADER_sw_shift  16
>  #define SDMA_PKT_CONSTANT_FILL_HEADER_SW(x) (((x) & SDMA_PKT_CONSTANT_FI=
LL_HEADER_sw_mask) << SDMA_PKT_CONSTANT_FILL_HEADER_sw_shift)
>
> +/*define for compression field for sdma7*/
> +#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_offset 0
> +#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_mask   0x00000001
> +#define SDMA_PKT_CONSTANT_FILL_HEADER_compress_shift  16
> +#define SDMA_PKT_CONSTANT_FILL_HEADER_COMPRESS(x) (((x) & SDMA_PKT_CONST=
ANT_FILL_HEADER_compress_mask) << SDMA_PKT_CONSTANT_FILL_HEADER_compress_sh=
ift)

Might be better to put this in sdma_v7_0.c since it's not part of
sdma6.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +
>  /*define for cache_policy field*/
>  #define SDMA_PKT_CONSTANT_FILL_HEADER_cache_policy_offset 0
>  #define SDMA_PKT_CONSTANT_FILL_HEADER_cache_policy_mask   0x00000007
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_0.c
> index a8763496aed3..573fb6a56f8b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1724,7 +1724,8 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgp=
u_ib *ib,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count)
>  {
> -       ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_=
OP_CONST_FILL);
> +       ib->ptr[ib->length_dw++] =3D SDMA_PKT_CONSTANT_FILL_HEADER_OP(SDM=
A_OP_CONST_FILL) |
> +               SDMA_PKT_CONSTANT_FILL_HEADER_COMPRESS(1);
>         ib->ptr[ib->length_dw++] =3D lower_32_bits(dst_offset);
>         ib->ptr[ib->length_dw++] =3D upper_32_bits(dst_offset);
>         ib->ptr[ib->length_dw++] =3D src_data;
> --
> 2.43.0
>
> From: Frank Min <Frank.Min@amd.com>
> Date: Wed, 16 Oct 2024 14:06:01 +0800
> Subject: [PATCH 2/2] drm/amdgpu: fix typo for sdma6 constant fill packet
>
> Fix typo for sdma6 constant fill packet
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 208a1fa9d4e7..cb07327d294f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1726,7 +1726,7 @@ static void sdma_v6_0_emit_fill_buffer(struct amdgp=
u_ib *ib,
>                                        uint64_t dst_offset,
>                                        uint32_t byte_count)
>  {
> -       ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_=
OP_CONST_FILL);
> +       ib->ptr[ib->length_dw++] =3D SDMA_PKT_CONSTANT_FILL_HEADER_OP(SDM=
A_OP_CONST_FILL);
>         ib->ptr[ib->length_dw++] =3D lower_32_bits(dst_offset);
>         ib->ptr[ib->length_dw++] =3D upper_32_bits(dst_offset);
>         ib->ptr[ib->length_dw++] =3D src_data;
> --
> 2.43.0
>
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Wednesday, October 16, 2024 12:41 PM
> To: Min, Frank <Frank.Min@amd.com>; amd-gfx@lists.freedesktop.org; Deuche=
r, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking.Zhang@amd=
.com>; Koenig, Christian <Christian.Koenig@amd.com>; Gao, Likun <Likun.Gao@=
amd.com>; Olsak, Marek <Marek.Olsak@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix random data corruption for sdma 7
>
>
>
> On 10/16/2024 8:29 AM, Min, Frank wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > From: Frank Min <Frank.Min@amd.com>
> >
> > There is random data corruption caused by const fill, this is caused by=
 write compression mode not correclt configured.
> >
> > So correct compression mode for const fill.
> >
> > Signed-off-by: Frank Min <Frank.Min@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h | 5 ++++-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 3 ++-
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
> > index d8cf830916b9..18e73057e6ba 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
> > @@ -116,11 +116,14 @@
> >  #define SDMA_PKT_COPY_LINEAR_HEADER_sub_op_shift  8  #define
> > SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(x) (((x) &
> > SDMA_PKT_COPY_LINEAR_HEADER_sub_op_mask) <<
> > SDMA_PKT_COPY_LINEAR_HEADER_sub_op_shift)
> >
> > -/*define for encrypt field*/
> > +/*define for encrypt/compress field*/
> >  #define SDMA_PKT_COPY_LINEAR_HEADER_encrypt_offset 0
> >  #define SDMA_PKT_COPY_LINEAR_HEADER_encrypt_mask   0x00000001
> >  #define SDMA_PKT_COPY_LINEAR_HEADER_encrypt_shift  16
> > +/*sdma6 use bit 16 for data encryption*/
> >  #define SDMA_PKT_COPY_LINEAR_HEADER_ENCRYPT(x) (((x) &
> > SDMA_PKT_COPY_LINEAR_HEADER_encrypt_mask) <<
> > SDMA_PKT_COPY_LINEAR_HEADER_encrypt_shift)
> > +/*sdma7 use bit 16 for dcc compression*/ #define
> > +SDMA_PKT_COPY_LINEAR_HEADER_COMPRESS(x) (((x) &
> > +SDMA_PKT_COPY_LINEAR_HEADER_encrypt_mask) <<
> > +SDMA_PKT_COPY_LINEAR_HEADER_encrypt_shift)
> >
>
> This doesn't look like the right way. The confusion is there because it u=
ses SDMA_PKT_COPY_LINEAR_HEADER_OP instead of SDMA_PKT_CONSTANT_FILL_HEADER=
_OP.
>
> It's better to
>
> 1) Bring in sdma 7 packet header definition (Mixing with SDMA 6 is also n=
ot good)
>
> 2) Use SDMA_PKT_CONSTANT_FILL_HEADER_OP instead of SDMA_PKT_COPY_LINEAR_H=
EADER_OP
>
> 3) Use the correct bit mask/shift as defined in sdma 7 packet header defi=
nition for const_fill.
>
> Thanks,
> Lijo
>
> >  /*define for tmz field*/
> >  #define SDMA_PKT_COPY_LINEAR_HEADER_tmz_offset 0 diff --git
> > a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > index a8763496aed3..9181579ae6a1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > @@ -1724,7 +1724,8 @@ static void sdma_v7_0_emit_fill_buffer(struct amd=
gpu_ib *ib,
> >                                        uint64_t dst_offset,
> >                                        uint32_t byte_count)  {
> > -       ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDM=
A_OP_CONST_FILL);
> > +       ib->ptr[ib->length_dw++] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDM=
A_OP_CONST_FILL) |
> > +               SDMA_PKT_COPY_LINEAR_HEADER_COMPRESS(1);
> >         ib->ptr[ib->length_dw++] =3D lower_32_bits(dst_offset);
> >         ib->ptr[ib->length_dw++] =3D upper_32_bits(dst_offset);
> >         ib->ptr[ib->length_dw++] =3D src_data;
> > --
> > 2.43.0
> >
