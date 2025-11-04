Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958B8CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3414910E62B;
	Tue,  4 Nov 2025 15:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XNPWqRbJ";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F5B110E62B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:28:10 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-7adc44440c6so48682b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 07:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762270090; x=1762874890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79oZ7EXufi0RobrJm9+KeJTF63blvy58F9fU4girbBQ=;
 b=XNPWqRbJ8rZ+NObjx2Hp3Fz09fGR19pBfMfwey3j1aNEpWKwLCBYA9ZEuLXw5b2pAh
 kCiKxV8M7F2sP0JwRGTY4odzQg7HsEW/tH2sQHpgJwqkLcXRXc0Y5C2igQan157I2OxL
 X3iMtla7xGesNqfGyxlg/ZPg1XjwUpdwAYG1Trv2Mx2jAiSBZANfvCkWRr1nyTIjVzcI
 Yxr3JAQwG5waHvkJC2T5luNa1ZJ7nHHWBuN+r8AtINCtSObysoMf6dG8Ip+ICh7eoa0i
 HJe+2raVmw9jlYXemYbskB052QD6xmkn41UeEFMM1RUj0YtsQJdpunGd9sztPadLJ4Ye
 VTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762270090; x=1762874890;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79oZ7EXufi0RobrJm9+KeJTF63blvy58F9fU4girbBQ=;
 b=wmWwa+OtxXRspsoHMqlEOTZu9fiHvSUgiSYZPdN54JFmj8hdJbiT+gVOuDgsPnGsQr
 B6glG8VsbX5zYGWbreq9Dw/TAxEkw4EvLjIskowPTC2zDUSLn2RnBqQnLsqD+LRuRrll
 XK8e3gVkHNczJjOhkid0vq8QSa52DOeHZkHsiozX/ITbhf8u2Vc+dLJYziJ/DGZYcR8Z
 ouV/TRrZ/7GERATzydZxzVv1iquobRfcUhzniR+cG7UKTOAPmM0pX86o1NdoSX1OA8Gp
 3ektZY4P274idAPgqNdJ376LRL8wvN7PypbyXDT18FVmR6UlZXUx/R6PwNHpMlbrvzdF
 6+JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvJGWZq1Sk9D+rWWXkcZFU02Jsprarusm2mXwV9WgO4wXxcIK7KCFQnPMiLj5iWn5sn1Hsz+TD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfVut0PJA2aZVxSNbrMtqkLm3fkOw5pQdgEgKOOxRyk3GjXpxy
 nYX20v3SR86vDoEQqYzLsm3A/PHd8lWYd36lzgFY9H/3ZAcEvXcWwpFonvJrFkDT14sU8DmKIPk
 lY+JXh5xX5JdoaKw135O4q3B9uy5arFw=
X-Gm-Gg: ASbGnct0L+d3yFxZ1yeil+s5JgGeOdc8Ti5h5VfWcCS3DT/bwotyjP7ig2iLcYlsigK
 BH+6200YToEholC/6xILhOIeqBrjq77fN83dcdrHgy1sdpFt6RwTS5KlinDLOpw/boatroPooMr
 7wsjIKH2S3aIRflu9rbrM/7IZTVrs8qcCK4t2DJqZrLyCxgsbdC73l5tQFt0td9VQSP43H7/WeP
 fn9rXWbRqAsxH6XKIkQ1KOFgNh1sB4I4CQ1s5I0Sa79x1Xb3t7B4qQg55yRBkQe1bfSQpY=
X-Google-Smtp-Source: AGHT+IF4/87AkYtFQIFNwTA1u+u7RMRYdvfI5HU4y/v61Z5hLe6AFv3mUvg43xl+uzH2mGXTZRUppxRxvfcLyvc97No=
X-Received: by 2002:a05:6a21:32a4:b0:340:3bc8:626f with SMTP id
 adf61e73a8af0-348ccd00947mr12315612637.4.1762270089513; Tue, 04 Nov 2025
 07:28:09 -0800 (PST)
MIME-Version: 1.0
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-10-timur.kristof@gmail.com>
 <97a3a818-6526-4447-ab92-14a6eb9551a3@amd.com>
 <01cfdc57f76218039efb67226b9c08189f8a1b1e.camel@gmail.com>
In-Reply-To: <01cfdc57f76218039efb67226b9c08189f8a1b1e.camel@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Nov 2025 10:27:57 -0500
X-Gm-Features: AWmQ_bmfpL6X8bJ-yx7Iv-uZ7blrKvnHwPzxpduwBlO6fuf0cG44Hu4kYixuQq4
Message-ID: <CADnq5_ONzWm3uNNo2gdScuDRMjqtoJ5RfTOqna7aTSok_vEwuQ@mail.gmail.com>
Subject: Re: [PATCH 09/16] drm/amdgpu/si, cik,
 vi: Verify IP block when querying video codecs (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Tue, Nov 4, 2025 at 10:16=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Tue, 2025-11-04 at 14:44 +0100, Christian K=C3=B6nig wrote:
> > On 11/3/25 23:23, Timur Krist=C3=B3f wrote:
> > > Some harvested chips may not have any IP blocks,
> > > or we may not have the firmware for the IP blocks.
> > > In these cases, the query should return that no video
> > > codec is supported.
> > >
> > > v2:
> > > - When codecs is NULL, treat that as empty codec list.
> >
> > I'm still not sure if returning an error instead wouldn't be better.
> >
> > @Alex and Leo what do you guys think?
> >
> > Regards,
> > Christian.
>
> Returning an error from this function would indicate to userspace that
> there was an error with querying the list of codecs.
>
> That is not what we want. We simply want to tell userspace that no
> codecs are supported.

If the IP is harvested or if it's been disabled, we wouldn't be
exposing any rings via drm_amdgpu_info_hw_ip so I don't think we need
this.

Alex

>
> Thanks & best regards,
> Timur
>
>
> >
> > >
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++--
> > >  drivers/gpu/drm/amd/amdgpu/cik.c        | 6 ++++++
> > >  drivers/gpu/drm/amd/amdgpu/si.c         | 6 ++++++
> > >  drivers/gpu/drm/amd/amdgpu/vi.c         | 6 ++++++
> > >  4 files changed, 23 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > index b3e6b3fcdf2c..71eceac58fb6 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > > @@ -1263,8 +1263,9 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> > > void *data, struct drm_file *filp)
> > >                     -EFAULT : 0;
> > >     }
> > >     case AMDGPU_INFO_VIDEO_CAPS: {
> > > -           const struct amdgpu_video_codecs *codecs;
> > > +           const struct amdgpu_video_codecs *codecs =3D NULL;
> > >             struct drm_amdgpu_info_video_caps *caps;
> > > +           u32 codec_count;
> > >             int r;
> > >
> > >             if (!adev->asic_funcs->query_video_codecs)
> > > @@ -1291,7 +1292,9 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> > > void *data, struct drm_file *filp)
> > >             if (!caps)
> > >                     return -ENOMEM;
> > >
> > > -           for (i =3D 0; i < codecs->codec_count; i++) {
> > > +           codec_count =3D codecs ? codecs->codec_count : 0;
> > > +
> > > +           for (i =3D 0; i < codec_count; i++) {
> > >                     int idx =3D codecs-
> > > >codec_array[i].codec_type;
> > >
> > >                     switch (idx) {
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
> > > b/drivers/gpu/drm/amd/amdgpu/cik.c
> > > index 9cd63b4177bf..b755238c2c3d 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> > > @@ -130,6 +130,12 @@ static const struct amdgpu_video_codecs
> > > cik_video_codecs_decode =3D
> > >  static int cik_query_video_codecs(struct amdgpu_device *adev, bool
> > > encode,
> > >                               const struct amdgpu_video_codecs
> > > **codecs)
> > >  {
> > > +   const enum amd_ip_block_type ip =3D
> > > +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> > > AMD_IP_BLOCK_TYPE_UVD;
> > > +
> > > +   if (!amdgpu_device_ip_is_valid(adev, ip))
> > > +           return 0;
> > > +
> > >     switch (adev->asic_type) {
> > >     case CHIP_BONAIRE:
> > >     case CHIP_HAWAII:
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/si.c
> > > b/drivers/gpu/drm/amd/amdgpu/si.c
> > > index e0f139de7991..9468c03bdb1b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/si.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> > > @@ -1003,6 +1003,12 @@ static const struct amdgpu_video_codecs
> > > hainan_video_codecs_decode =3D
> > >  static int si_query_video_codecs(struct amdgpu_device *adev, bool
> > > encode,
> > >                              const struct amdgpu_video_codecs
> > > **codecs)
> > >  {
> > > +   const enum amd_ip_block_type ip =3D
> > > +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> > > AMD_IP_BLOCK_TYPE_UVD;
> > > +
> > > +   if (!amdgpu_device_ip_is_valid(adev, ip))
> > > +           return 0;
> > > +
> > >     switch (adev->asic_type) {
> > >     case CHIP_VERDE:
> > >     case CHIP_TAHITI:
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> > > b/drivers/gpu/drm/amd/amdgpu/vi.c
> > > index a611a7345125..f0e4193cf722 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > > @@ -256,6 +256,12 @@ static const struct amdgpu_video_codecs
> > > cz_video_codecs_decode =3D
> > >  static int vi_query_video_codecs(struct amdgpu_device *adev, bool
> > > encode,
> > >                              const struct amdgpu_video_codecs
> > > **codecs)
> > >  {
> > > +   const enum amd_ip_block_type ip =3D
> > > +           encode ? AMD_IP_BLOCK_TYPE_VCE :
> > > AMD_IP_BLOCK_TYPE_UVD;
> > > +
> > > +   if (!amdgpu_device_ip_is_valid(adev, ip))
> > > +           return 0;
> > > +
> > >     switch (adev->asic_type) {
> > >     case CHIP_TOPAZ:
> > >             if (encode)
