Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493F3C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 21:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E459710E0D6;
	Mon, 17 Mar 2025 21:19:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mmhpfTwm";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E779010E0D6
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 21:19:42 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2ff53b26af2so571618a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 14:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742246382; x=1742851182; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aBPn7u2GK0umD2X4IVFKZtCjcIDU9Bi8NrnhOfnF8do=;
 b=mmhpfTwm+JzqY08754yEOc/YAtJWbRnZdMjEvuIKeyjGDPyo5yRfque+aKcf9CesdF
 PbIZB0Lj2MOlBkYjitsLAUKt58tHykPhw3xBQftYNsjuAUj7BiSzi/L2qArOrW0uNcu1
 gGkNzboVztNhbc++D2dZJRuI5tnh3JSitUtGXXxJRrk+CBGuJu/enq/G8I6FcoNJRncn
 C4SWK+09OkQVblbPRp77wEjVz0PmCSLaWgq/bADBtiHvVq5Gbvo5g+i9jn24al7whyeH
 TYUUVkWC7HKMSkCtCdCC5CLIxeTLqXULpyyZAmUczehIQsxc/XaVtt4CBvCNNa9gZ5xx
 MmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742246382; x=1742851182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBPn7u2GK0umD2X4IVFKZtCjcIDU9Bi8NrnhOfnF8do=;
 b=oTYJnM1/Y34hN9DYqjjV6MlOsb63fSqYjg+tAW59KwaZDe7C2OMTXMY3SGX1Pxf4hU
 SXFStlq17pD1xkgDJ1yiQi96r5g9Ww4J9ZNimToaSxA6MEguK3+2EXJILI4r4aIz4As9
 tMe5uXn7OJQWIEjiR/e2MC7naPpvopr7wX8AICT5fUXUCIB9IoXR4gdo2hfL1JaFmIBY
 YdDNqRC46v9y6+8AKoBu/ibwBwUPkeH7lxvROhch38o67ZPN3dk9fqi95TkWDjJGT+SC
 Oq+YuBJWPrXnpr1EhMyEl5j+5CIZ3y/BWllQYq0YsEult4gnb3PPB3jJcyEk2H/lOMVA
 zeRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhlEsjek2Ki/sef/7YRCyb4MjN7/Wx0lfRipL3o1/irHKN/o+pEsVL9EwpAXR3aHlwkSMCwmsE@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1iFdtnN+UCM8QCxsXToYfOReiHKJoi/37XMBNOZNUmoh+hc2p
 BHqqMGCH9vap78Y1Nr03eg+Ll/+OcZum4F/vGWUIedK3FQN4kWChZ8eOK7tbygAKd3RbE7Qr5AR
 hLiO6zRd1T0fxI5gWWjYHYs5zH0g=
X-Gm-Gg: ASbGncuxAcci94oYUGBwj73RHaWXRbP6fy7RsO4O9J6q25eAmWfLkEn8F+Gx1QvcqHi
 gSZj+QYq9nF8EVDZ39ebe0O8mjHRLFbj8H7ryGNpvTJVTK47fCHCd3VmE41YBRRN23nzaGQZJ5N
 0IzIUWw4CYaEXCFYWTU9HuOPhtzg==
X-Google-Smtp-Source: AGHT+IEn7/2B2FCYBmVQaHcARrO8fsVGR1Q+Nnl5XElOVZU7ADuzRXoMB1aE7rDuyAOyWbm6EA0lXGYmTyWfztMIBv8=
X-Received: by 2002:a17:90b:1b48:b0:301:1c11:aa7a with SMTP id
 98e67ed59e1d1-30151d4a772mr6580898a91.3.1742246382373; Mon, 17 Mar 2025
 14:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250317191349.942719-1-alexander.deucher@amd.com>
 <CAAxE2A5f3bx=yFDRgqsE8uK4QvO_gSkq5fHQm7s10UR3Us1Saw@mail.gmail.com>
In-Reply-To: <CAAxE2A5f3bx=yFDRgqsE8uK4QvO_gSkq5fHQm7s10UR3Us1Saw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Mar 2025 17:19:30 -0400
X-Gm-Features: AQ5f1JqrXwc76WlrbAJWvLEs7hfGJLVLZ5pxQ98gEK-fvveKZmyP4KfHjeleagI
Message-ID: <CADnq5_Nh6NyOq-taNoDHE4uQ4jQy06cZNzYUgYxWFXhsiXPv9g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add UAPI to query if user queues are supported
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 marek.olsak@amd.com, prike.liang@amd.com, sunil.khatri@amd.com
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

On Mon, Mar 17, 2025 at 4:53=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> I would prefer a bitmask of supported UQ IPs in device info, but this is =
fine too.

I can do that instead.

Alex

>
> Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>
> Marek
>
> On Mon, Mar 17, 2025 at 3:23=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
>>
>> Add an INFO query to check if user queues are supported.
>>
>> Cc: marek.olsak@amd.com
>> Cc: prike.liang@amd.com
>> Cc: sunil.khatri@amd.com
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 17 +++++++++++++++++
>>  include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
>>  2 files changed, 25 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_kms.c
>> index 3b7dfd56ccd0e..38b8983f59d3c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1340,6 +1340,23 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *filp)
>>                         return -EINVAL;
>>                 }
>>         }
>> +       case AMDGPU_INFO_UQ_SUPPORTED: {
>> +               struct drm_amdgpu_info_uq_supported uq_supported =3D {};
>> +               u32 ip_type =3D info->query_hw_ip.type;
>> +
>> +               switch (ip_type) {
>> +               case AMDGPU_HW_IP_GFX:
>> +               case AMDGPU_HW_IP_COMPUTE:
>> +               case AMDGPU_HW_IP_DMA:
>> +                       if (adev->userq_funcs[ip_type])
>> +                               uq_supported.supported =3D 1;
>> +                       ret =3D copy_to_user(out, &uq_supported,
>> +                                          min((size_t)size, sizeof(uq_s=
upported))) ? -EFAULT : 0;
>> +                       return 0;
>> +               default:
>> +                       return -EINVAL;
>> +               }
>> +       }
>>         default:
>>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>>                 return -EINVAL;
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm=
.h
>> index 5dbd9037afe75..b4b6fe006af8e 100644
>> --- a/include/uapi/drm/amdgpu_drm.h
>> +++ b/include/uapi/drm/amdgpu_drm.h
>> @@ -1195,6 +1195,8 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>>  #define AMDGPU_INFO_GPUVM_FAULT                        0x23
>>  /* query FW object size and alignment */
>>  #define AMDGPU_INFO_UQ_FW_AREAS                        0x24
>> +/* query if user queues are supported */
>> +#define AMDGPU_INFO_UQ_SUPPORTED               0x25
>>
>>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
>> @@ -1572,6 +1574,12 @@ struct drm_amdgpu_info_uq_metadata {
>>         };
>>  };
>>
>> +struct drm_amdgpu_info_uq_supported {
>> +       /** returns 1 if supported, 0 if not supported */
>> +       __u32   supported;
>> +       __u32   pad;
>> +};
>> +
>>  /*
>>   * Supported GPU families
>>   */
>> --
>> 2.48.1
>>
