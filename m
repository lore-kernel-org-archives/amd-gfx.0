Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B03CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F8D10E623;
	Tue,  4 Nov 2025 15:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LKRsScDo";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93A810E625
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:16:17 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b3b3a6f4dd4so1036431666b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 07:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762269376; x=1762874176; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIbwXZqpIKGlKNNHRDZu/vPrGVZT+h8Pzd2Cj4L3Bh0=;
 b=LKRsScDoAB10Po6yq8oljfV+E8V9ifZorFZMOmjb0CuvFH9J2McD1pVYUeleJPUyma
 Bt/EJGIJFKj92gq8+AxexT9hB47+et4rE7UW41v/9+Gd2/xBwL+WGeSfP+o0JX+dqy2R
 JHbmTWfhYeLuDqM5d135aoDe+yyGUFx7HkQQ+rOfV+yfEEROxsU7RYdQqcYpFoRHR15P
 mBbPiTAtp35XTkSTyrUqn+0m312hn2aUjubG/a0eh5qjtKMl8rTyVO/SswOUb2AvAUtn
 BPifLbgF9nWMVBITRcTB5oHV/EqM3Xfbjko4pGn+UxcmWOrE127a1DXCb/+12B3OEVgu
 6xHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762269376; x=1762874176;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DIbwXZqpIKGlKNNHRDZu/vPrGVZT+h8Pzd2Cj4L3Bh0=;
 b=Mzn8CSBZSdQn0zpNbCbRspaQ6cxCsxMVBxqjdukcewgKhJ/9pvoGtJbc+76aK53YTW
 PVhiJEUVBknf7yJOzyhm2xiohMUZigfgq5nlMOPx6OdTDQr3YC4yCAoTixBtVx+rfPs2
 kSBEXmz9E39DiMqf2lavzi+8k6fkymt5e0y+CexaGXqP5PLSukfnGTCiH/FBkTxfGDas
 4ao4S524/Up58GgKBBgjK9UMjEbakkF9nG24jZdsO7OhUEO6Um1612pDu0m3aUWQgIXT
 xbmSpdqiJ47679syG2OtE1M6Px2w2TAiBLPj0e6qki4MWaZTDVqdTJDVMzbKrsEZjbOr
 SQ/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPDZzzio+1V2bJN+nabCvPoaaakfEfyow9WBXW7N+wJvhAAiaGdJ28o+8KhmLbY3HilWmuju5g@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yye8qQi6YqN7/Lt+dPSsKoGWWVZ9gew0wDyWldDRgAXcR4pP+d4
 ZjWUwm1ZbKvD0gbnRgqJ2qY3ZvPvRz/2MotdsD7HLhPGpQU07jNhdaoe
X-Gm-Gg: ASbGnctTnpXN6DmhkkwFuhIz29PJPmx7RaN9u0f9qx6gtEaZkdn+XI0v7IVuJkOY49M
 yJmhv4Txo1OumaeeJMj7q4DqV7p+p6VuKXbjOxL/s4J3X8S3nQkmyZ1M8lKXSFqhOkyBvUW+iQC
 DwP6Zj5EQv8OAijPdF3aN5nSnruLM6TggfMHfi5J0ypOdKT+7dGuQ+OK/yj/kpTVAIMRkUQUTs4
 A12WgNxf7JiVg1KxXqj9p1n2wWeRNU+hpSnD7toJLhSjzGTUNliIsSZE5857RFWo1tPdHuq+567
 zEQYClaLdJ57PHc8BXOuEiOvbUScw2zFXBIn0ZajSw5ZcBS+y5aavDo8VZbFp5UDBFkDCaKU/jw
 NC0mWvtvtbrpfFsUbD3KRY7J45Ldal6vJSntsdqHgY7Sy21/Jfa1TB3QNN+YIeoqF8n5sCnIrQV
 7ueFZcNKKJL+zcRw/A+ieJRHT0zsCnAxwAFzVJRAaXI2bK2OvFiP8rczbBSiV0sErXplOk/4SWX
 QXNZBq8eZa9wI61EJoFeqV+u5oRVHG0t9TvGECNT6ryHCxq0MK7
X-Google-Smtp-Source: AGHT+IHdPZifIcqwTckTeWgtorwEfvEuYKhAJi6TE3R+z2ARWPZSW1HVnlLoE0fkVBVFqvrV6n49qQ==
X-Received: by 2002:a17:907:7ea0:b0:b70:4757:eb01 with SMTP id
 a640c23a62f3a-b70705ee87fmr1840687966b.32.1762269375822; 
 Tue, 04 Nov 2025 07:16:15 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:8825:f46d:d14d:d33?
 (20014C4E24CAA4008825F46DD14D0D33.dsl.pool.telekom.hu.
 [2001:4c4e:24ca:a400:8825:f46d:d14d:d33])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b725f72a688sm52730166b.49.2025.11.04.07.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 07:16:15 -0800 (PST)
Message-ID: <01cfdc57f76218039efb67226b9c08189f8a1b1e.camel@gmail.com>
Subject: Re: [PATCH 09/16] drm/amdgpu/si,cik,vi: Verify IP block when
 querying video codecs (v2)
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Date: Tue, 04 Nov 2025 16:16:12 +0100
In-Reply-To: <97a3a818-6526-4447-ab92-14a6eb9551a3@amd.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-10-timur.kristof@gmail.com>
 <97a3a818-6526-4447-ab92-14a6eb9551a3@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Tue, 2025-11-04 at 14:44 +0100, Christian K=C3=B6nig wrote:
> On 11/3/25 23:23, Timur Krist=C3=B3f wrote:
> > Some harvested chips may not have any IP blocks,
> > or we may not have the firmware for the IP blocks.
> > In these cases, the query should return that no video
> > codec is supported.
> >=20
> > v2:
> > - When codecs is NULL, treat that as empty codec list.
>=20
> I'm still not sure if returning an error instead wouldn't be better.
>=20
> @Alex and Leo what do you guys think?
>=20
> Regards,
> Christian.

Returning an error from this function would indicate to userspace that
there was an error with querying the list of codecs.

That is not what we want. We simply want to tell userspace that no
codecs are supported.

Thanks & best regards,
Timur


>=20
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++--
> > =C2=A0drivers/gpu/drm/amd/amdgpu/cik.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 6 ++++++
> > =C2=A0drivers/gpu/drm/amd/amdgpu/si.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 6 ++++++
> > =C2=A0drivers/gpu/drm/amd/amdgpu/vi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 6 ++++++
> > =C2=A04 files changed, 23 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index b3e6b3fcdf2c..71eceac58fb6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -1263,8 +1263,9 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> > void *data, struct drm_file *filp)
> > =C2=A0			-EFAULT : 0;
> > =C2=A0	}
> > =C2=A0	case AMDGPU_INFO_VIDEO_CAPS: {
> > -		const struct amdgpu_video_codecs *codecs;
> > +		const struct amdgpu_video_codecs *codecs =3D NULL;
> > =C2=A0		struct drm_amdgpu_info_video_caps *caps;
> > +		u32 codec_count;
> > =C2=A0		int r;
> > =C2=A0
> > =C2=A0		if (!adev->asic_funcs->query_video_codecs)
> > @@ -1291,7 +1292,9 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> > void *data, struct drm_file *filp)
> > =C2=A0		if (!caps)
> > =C2=A0			return -ENOMEM;
> > =C2=A0
> > -		for (i =3D 0; i < codecs->codec_count; i++) {
> > +		codec_count =3D codecs ? codecs->codec_count : 0;
> > +
> > +		for (i =3D 0; i < codec_count; i++) {
> > =C2=A0			int idx =3D codecs-
> > >codec_array[i].codec_type;
> > =C2=A0
> > =C2=A0			switch (idx) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
> > b/drivers/gpu/drm/amd/amdgpu/cik.c
> > index 9cd63b4177bf..b755238c2c3d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> > @@ -130,6 +130,12 @@ static const struct amdgpu_video_codecs
> > cik_video_codecs_decode =3D
> > =C2=A0static int cik_query_video_codecs(struct amdgpu_device *adev, boo=
l
> > encode,
> > =C2=A0				=C2=A0 const struct amdgpu_video_codecs
> > **codecs)
> > =C2=A0{
> > +	const enum amd_ip_block_type ip =3D
> > +		encode ? AMD_IP_BLOCK_TYPE_VCE :
> > AMD_IP_BLOCK_TYPE_UVD;
> > +
> > +	if (!amdgpu_device_ip_is_valid(adev, ip))
> > +		return 0;
> > +
> > =C2=A0	switch (adev->asic_type) {
> > =C2=A0	case CHIP_BONAIRE:
> > =C2=A0	case CHIP_HAWAII:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/si.c
> > b/drivers/gpu/drm/amd/amdgpu/si.c
> > index e0f139de7991..9468c03bdb1b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/si.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> > @@ -1003,6 +1003,12 @@ static const struct amdgpu_video_codecs
> > hainan_video_codecs_decode =3D
> > =C2=A0static int si_query_video_codecs(struct amdgpu_device *adev, bool
> > encode,
> > =C2=A0				 const struct amdgpu_video_codecs
> > **codecs)
> > =C2=A0{
> > +	const enum amd_ip_block_type ip =3D
> > +		encode ? AMD_IP_BLOCK_TYPE_VCE :
> > AMD_IP_BLOCK_TYPE_UVD;
> > +
> > +	if (!amdgpu_device_ip_is_valid(adev, ip))
> > +		return 0;
> > +
> > =C2=A0	switch (adev->asic_type) {
> > =C2=A0	case CHIP_VERDE:
> > =C2=A0	case CHIP_TAHITI:
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
> > b/drivers/gpu/drm/amd/amdgpu/vi.c
> > index a611a7345125..f0e4193cf722 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vi.c
> > @@ -256,6 +256,12 @@ static const struct amdgpu_video_codecs
> > cz_video_codecs_decode =3D
> > =C2=A0static int vi_query_video_codecs(struct amdgpu_device *adev, bool
> > encode,
> > =C2=A0				 const struct amdgpu_video_codecs
> > **codecs)
> > =C2=A0{
> > +	const enum amd_ip_block_type ip =3D
> > +		encode ? AMD_IP_BLOCK_TYPE_VCE :
> > AMD_IP_BLOCK_TYPE_UVD;
> > +
> > +	if (!amdgpu_device_ip_is_valid(adev, ip))
> > +		return 0;
> > +
> > =C2=A0	switch (adev->asic_type) {
> > =C2=A0	case CHIP_TOPAZ:
> > =C2=A0		if (encode)
