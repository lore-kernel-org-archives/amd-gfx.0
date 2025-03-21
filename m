Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D87BC36002
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 20:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC0710E839;
	Fri, 21 Mar 2025 20:54:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YphSW/1w";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC1010E839
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 20:54:03 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-301b4f97cc1so690712a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 13:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742590443; x=1743195243; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+yGGzkRR4t447ydZXLz5SQw8iFB3QWThHQ6qV+Tq/UA=;
 b=YphSW/1wOZCGTbeJbL/HtipBQ0010sBODLYCeURO9o/1IS630WxPXDEAi/NeIoADzB
 oMvMTxxyiQdEQWEWdjX4Rdn/sktUo4CFRCCKk/h5WGqlCjBH1p2/zwxVWMh6o7kBq5Th
 7ZPy3i4awNfItlEIK+1JMTuYljv+AAT/PiMApvHoPtQYyMTq9Dj2zZp9KqSaAmMyxpEr
 0AXJjxFLtOJt4nVUvTugCjt4JlmQozwtxKy/wtqahy4uWYVXPqdywGFPpnVfckl7UM8Y
 qlBiQ7RaMY5faDqiay+u//Qg5hK+6oeVwGoc2bfH6F2RxXXy6aXXb6Kq9VSWeSXhGAnH
 3SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742590443; x=1743195243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+yGGzkRR4t447ydZXLz5SQw8iFB3QWThHQ6qV+Tq/UA=;
 b=Ni9Q6tPshFMieVpPZWQs7bj/KgCOodCW4KE+WKP6Aaso3+5ELnLJrG0O/7PK/ysVCy
 I+Rob7W+cwscbxT4t3a4LNKVAYchUEJTZESbtSY7aA5Y7mqpnTJU1BEcIOb/LmsD+kpN
 vaWSBySpMIi/L9QLqlMS/tn2twHuJ9ZQ1Rx+dF7iyUxLyRbyzZftQDq0l07hrQb0Cr+o
 tu1aa3se19bfBUzqpoxTlcK5xQCtENjuzegxqS0w4piWkHeilU6kkc6PM2gSAziVssi2
 a7Pq208+W1G/xnAMC5C/Um3fXiij+iPdH/VDAw2B0cH1JGc+CSXkebgn0oayzQm1zbYM
 qhlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7wCOOQ3do545auDJl4/NaSPHX+ZvqI8IVI9PAAnxNHd90X7WIzlEjLIQBSHhc+kPRevgG7NrZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwTQnLCxBpuUOnpMbgG5Bbbfq6eL08DPXBLLmaekcsRawU3DEKh
 yBJak96Dgj5XqSJ/hIpvib/Z9XWZPEqkolwzZHi4gU2HrXmtlcY7YOzB43kkmW7O4g4GovfCEM4
 h3av2tHa7tXu+n//RYR41/3gp27F6sw==
X-Gm-Gg: ASbGncsUlSYDASlAjbds9MyoqFg+UfnUKzDgb3QQQmzbxVbkI+Lx8BLN9Qkh1xcm4OJ
 bI8ECnRlsese1XiSRIFLEUcQbHvxpSIH7kdJy9fDF2ZyWYFwSzFeoUi/WMMY5OV2na9Z8Jc7glc
 J2rfjBfkwGTBtz974fDw5U4/Lb8A==
X-Google-Smtp-Source: AGHT+IFbmo6lfoiFiTCj7a6/MdENZcLbqZeYj9cvKVei8y/G3G8+RcDgdbICaDC968W7huOb/ldnWs41zFVcLEwT/Xk=
X-Received: by 2002:a17:90b:4a89:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-3030fee30e6mr2558195a91.3.1742590442583; Fri, 21 Mar 2025
 13:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250317212919.1018717-1-alexander.deucher@amd.com>
 <CAAxE2A5FxaUh7vtPdqC-c_tAtSzXOjonpBBUj8=C7HDbL-pR0w@mail.gmail.com>
In-Reply-To: <CAAxE2A5FxaUh7vtPdqC-c_tAtSzXOjonpBBUj8=C7HDbL-pR0w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Mar 2025 16:53:50 -0400
X-Gm-Features: AQ5f1JqNc5DICZc3yKu_kRgNwYz4nBv5bGKbXP0AqDLK4jxKGZfQhBGOo5QaqGo
Message-ID: <CADnq5_PiTSCfqyYDsJXcaUFABUkmg4+_VU07winkoih3H3Ln1g@mail.gmail.com>
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

I can move it into device_info if that's better.

Alex

On Fri, Mar 21, 2025 at 3:42=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> This is not in device_info, but it'll do.
>
> Reviewed-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
>
> Marek
>
> On Mon, Mar 17, 2025 at 5:38=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
>>
>> Add an INFO query to check if user queues are supported.
>>
>> v2: switch to a mask of IPs (Marek)
>>
>> Cc: marek.olsak@amd.com
>> Cc: prike.liang@amd.com
>> Cc: sunil.khatri@amd.com
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
>>  include/uapi/drm/amdgpu_drm.h           |  8 ++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_kms.c
>> index 3b7dfd56ccd0e..1d683c0487697 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -1340,6 +1340,19 @@ int amdgpu_info_ioctl(struct drm_device *dev, voi=
d *data, struct drm_file *filp)
>>                         return -EINVAL;
>>                 }
>>         }
>> +       case AMDGPU_INFO_UQ_SUPPORTED: {
>> +               struct drm_amdgpu_info_uq_supported uq_supported =3D {};
>> +
>> +               if (adev->userq_funcs[AMDGPU_HW_IP_GFX])
>> +                       uq_supported.supported |=3D (1 << AMDGPU_HW_IP_G=
FX);
>> +               if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE])
>> +                       uq_supported.supported |=3D (1 << AMDGPU_HW_IP_C=
OMPUTE);
>> +               if (adev->userq_funcs[AMDGPU_HW_IP_DMA])
>> +                       uq_supported.supported |=3D (1 << AMDGPU_HW_IP_D=
MA);
>> +               ret =3D copy_to_user(out, &uq_supported,
>> +                                  min((size_t)size, sizeof(uq_supported=
))) ? -EFAULT : 0;
>> +               return 0;
>> +       }
>>         default:
>>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>>                 return -EINVAL;
>> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm=
.h
>> index 5dbd9037afe75..4b64e91002c05 100644
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
>> +       /** returns a mask for each IP type (1 << AMDGPU_HW_IP_*) */
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
