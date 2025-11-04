Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA75CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F92110E62F;
	Tue,  4 Nov 2025 15:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U2nRKrxI";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE88D10E62F
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:33:35 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-34053e17eb6so825131a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 07:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762270415; x=1762875215; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqvmH7Ux5HfrGth4AnZA4xICkO6vySBDa2bXz8Mnzq0=;
 b=U2nRKrxIOXzziuonvcbl+p+3YhZuUV2GMTRFxV6bB+lvYg3uEe0pG56r702hH+9Wew
 hkmYPjNOQ6QHZpNwbusdwMU9MZ1ww4h/dttCxFHYMGWKM2EUOh1GWqoNQMj8tcCH8ipF
 ahQkSHxbLcOkGL9Xrpo60AiqI8azxD+8YKxsot9Yi5mcHwRARoMVDVdZ2I6qW+iZjVkg
 nqw+lafD5Z824P3llPsOpQl+9/dFE4R3fXwl8tt2d5ZQYAU8QbkluKaY2sPlOaZoBF1W
 ydjNC1Csam+Xu2AakAMkRTBVLATcKG6yerAz5isVQoiy4LoDkZzxkOuIbWfwmtcorg6K
 yCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762270415; x=1762875215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lqvmH7Ux5HfrGth4AnZA4xICkO6vySBDa2bXz8Mnzq0=;
 b=hSJrqbdDCd62wcop8dVpeP9jN+QntsaX2qaIo6IAGecG/o5gUjA9sPiYdmRdGLs5dW
 YI/fELLnwb2u6ySxeCdvl8HD6rB3CO8n5WZ2QdxZmVR4+zxzaTtSk20lgN9zgIOCcKMU
 JUHWAMZNRT/6nRvnrFVkxnja2Khq3vecml18yAJd4hZq/6Vr0d+SysZtbNJZNU/IiqrM
 TtlmBg4plNR0Tm0G8igkzBZjaY3NcdPub5P9TKX5B/ChCrPDQDIKVyVN0TLlMyjW34JM
 wwRWaWM7BpDvZGcfLikC7pop2oow9C8FqsUllJg+xoO73hXiGSNpZuiR1j55M9VOnYI2
 Vs0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxcgtciouvKTSmLd55gub1sMxOxOOnISRj4/XrJw3qNeEdKWAKfybV/AFfHoo6jRHT/lKvrKsk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxK2SHMH7yCHliRylQAdw22oxj//ZkUd2h56xHx/vD6/587D3Hs
 1Eo62fPpAqoQMc1qzjxNLiA9I87bXwi0oXHWG3hh9DwkHAqeqhh+sh+MvGWzPKGzklyD39nb5ZV
 nKgrI9QEVb97FXVATp8UY25jws8Jj+dE=
X-Gm-Gg: ASbGncv6GfXeyNERKidKMz61yzhpc8OrpHbcXy84mPRGyPnjWTAQTN4/YTvf6WcoNJz
 CgYLlohxU78WQPijQhkAfJjkrlE8opbTRhV6Wl0g0UBV1UworsYXdvAmqdcyKZgNKPPvEMWVMEW
 XcFA0bk3pCN+hWWLFo+ezByRvZxqCne1/JeNBl4YeBlcalkkO2a9ldi7NuLXPLiN003J//RpT8E
 3cnW9xTbgpUCsSSDop+VC1TfBEH/fVoFOmNY71imlfKpymtz3rf693Fn/ph
X-Google-Smtp-Source: AGHT+IEIDVpxo6H3FYPhOalZgiYkvdrWlR8r1g1HMsFeg7xzn7uCiKfQ6Jtg9P8Z7SToqNGcPiriz+t4LrC83KQNGpU=
X-Received: by 2002:a05:6a21:4598:b0:341:49ff:acab with SMTP id
 adf61e73a8af0-348cd20f555mr12384567637.7.1762270415344; Tue, 04 Nov 2025
 07:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-10-timur.kristof@gmail.com>
 <97a3a818-6526-4447-ab92-14a6eb9551a3@amd.com>
 <01cfdc57f76218039efb67226b9c08189f8a1b1e.camel@gmail.com>
 <CADnq5_ONzWm3uNNo2gdScuDRMjqtoJ5RfTOqna7aTSok_vEwuQ@mail.gmail.com>
 <042cb13c-e396-4767-b78f-963401ca0018@amd.com>
In-Reply-To: <042cb13c-e396-4767-b78f-963401ca0018@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Nov 2025 10:33:23 -0500
X-Gm-Features: AWmQ_bkdf6g8rYQlMEG3pYwCfyty68cs5iESJQhhDmKopNZM4xuLS7oytgjNqu0
Message-ID: <CADnq5_OmNU2wjnTpnHj3eGambij7XPbg6=j=1EfBxJqwibATUw@mail.gmail.com>
Subject: Re: [PATCH 09/16] drm/amdgpu/si, cik,
 vi: Verify IP block when querying video codecs (v2)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
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

On Tue, Nov 4, 2025 at 10:29=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 11/4/25 16:27, Alex Deucher wrote:
> > On Tue, Nov 4, 2025 at 10:16=E2=80=AFAM Timur Krist=C3=B3f <timur.krist=
of@gmail.com> wrote:
> >>
> >> On Tue, 2025-11-04 at 14:44 +0100, Christian K=C3=B6nig wrote:
> >>> On 11/3/25 23:23, Timur Krist=C3=B3f wrote:
> >>>> Some harvested chips may not have any IP blocks,
> >>>> or we may not have the firmware for the IP blocks.
> >>>> In these cases, the query should return that no video
> >>>> codec is supported.
> >>>>
> >>>> v2:
> >>>> - When codecs is NULL, treat that as empty codec list.
> >>>
> >>> I'm still not sure if returning an error instead wouldn't be better.
> >>>
> >>> @Alex and Leo what do you guys think?
> >>>
> >>> Regards,
> >>> Christian.
> >>
> >> Returning an error from this function would indicate to userspace that
> >> there was an error with querying the list of codecs.
> >>
> >> That is not what we want. We simply want to tell userspace that no
> >> codecs are supported.
> >
> > If the IP is harvested or if it's been disabled, we wouldn't be
> > exposing any rings via drm_amdgpu_info_hw_ip so I don't think we need
> > this.
>
> Oh good point as well. But should we then return an error?
>
> I think yes, because the HW isn't available at all and so querying the av=
ailable codecs doesn't make sense in the first place.

Either way works for me.

Alex

>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >>
> >> Thanks & best regards,
> >> Timur
> >>
> >>
> >>>
> >>>>
> >>>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>>> ---
> >>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++--
> >>>>  drivers/gpu/drm/amd/amdgpu/cik.c        | 6 ++++++
> >>>>  drivers/gpu/drm/amd/amdgpu/si.c         | 6 ++++++
> >>>>  drivers/gpu/drm/amd/amdgpu/vi.c         | 6 ++++++
> >>>>  4 files changed, 23 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>>> index b3e6b3fcdf2c..71eceac58fb6 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >>>> @@ -1263,8 +1263,9 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> >>>> void *data, struct drm_file *filp)
> >>>>                     -EFAULT : 0;
> >>>>     }
> >>>>     case AMDGPU_INFO_VIDEO_CAPS: {
> >>>> -           const struct amdgpu_video_codecs *codecs;
> >>>> +           const struct amdgpu_video_codecs *codecs =3D NULL;
> >>>>             struct drm_amdgpu_info_video_caps *caps;
> >>>> +           u32 codec_count;
> >>>>             int r;
> >>>>
> >>>>             if (!adev->asic_funcs->query_video_codecs)
> >>>> @@ -1291,7 +1292,9 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> >>>> void *data, struct drm_file *filp)
> >>>>             if (!caps)
> >>>>                     return -ENOMEM;
> >>>>
> >>>> -           for (i =3D 0; i < codecs->codec_count; i++) {
> >>>> +           codec_count =3D codecs ? codecs->codec_count : 0;
> >>>> +
> >>>> +           for (i =3D 0; i < codec_count; i++) {
> >>>>                     int idx =3D codecs-
> >>>>> codec_array[i].codec_type;
> >>>>
> >>>>                     switch (idx) {
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/cik.c
> >>>> index 9cd63b4177bf..b755238c2c3d 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> >>>> @@ -130,6 +130,12 @@ static const struct amdgpu_video_codecs
> >>>> cik_video_codecs_decode =3D
> >>>>  static int cik_query_video_codecs(struct amdgpu_device *adev, bool
> >>>> encode,
> >>>>                               const struct amdgpu_video_codecs
> >>>> **codecs)
> >>>>  {
> >>>> +   const enum amd_ip_block_type ip =3D
> >>>> +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> >>>> AMD_IP_BLOCK_TYPE_UVD;
> >>>> +
> >>>> +   if (!amdgpu_device_ip_is_valid(adev, ip))
> >>>> +           return 0;
> >>>> +
> >>>>     switch (adev->asic_type) {
> >>>>     case CHIP_BONAIRE:
> >>>>     case CHIP_HAWAII:
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/si.c
> >>>> index e0f139de7991..9468c03bdb1b 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> >>>> @@ -1003,6 +1003,12 @@ static const struct amdgpu_video_codecs
> >>>> hainan_video_codecs_decode =3D
> >>>>  static int si_query_video_codecs(struct amdgpu_device *adev, bool
> >>>> encode,
> >>>>                              const struct amdgpu_video_codecs
> >>>> **codecs)
> >>>>  {
> >>>> +   const enum amd_ip_block_type ip =3D
> >>>> +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> >>>> AMD_IP_BLOCK_TYPE_UVD;
> >>>> +
> >>>> +   if (!amdgpu_device_ip_is_valid(adev, ip))
> >>>> +           return 0;
> >>>> +
> >>>>     switch (adev->asic_type) {
> >>>>     case CHIP_VERDE:
> >>>>     case CHIP_TAHITI:
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>> index a611a7345125..f0e4193cf722 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> >>>> @@ -256,6 +256,12 @@ static const struct amdgpu_video_codecs
> >>>> cz_video_codecs_decode =3D
> >>>>  static int vi_query_video_codecs(struct amdgpu_device *adev, bool
> >>>> encode,
> >>>>                              const struct amdgpu_video_codecs
> >>>> **codecs)
> >>>>  {
> >>>> +   const enum amd_ip_block_type ip =3D
> >>>> +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> >>>> AMD_IP_BLOCK_TYPE_UVD;
> >>>> +
> >>>> +   if (!amdgpu_device_ip_is_valid(adev, ip))
> >>>> +           return 0;
> >>>> +
> >>>>     switch (adev->asic_type) {
> >>>>     case CHIP_TOPAZ:
> >>>>             if (encode)
>
