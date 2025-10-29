Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D57CCF9E9
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CBC010E1D3;
	Wed, 29 Oct 2025 10:54:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PbABVMhD";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E79310E1D3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:54:18 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-63c12ff0c5eso2000846a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761735256; x=1762340056; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1QgQD1KB/C0R/RHwpxQaIRp5/FzujKeep78F+t5pVsY=;
 b=PbABVMhDNS1GWv2ag2Pi3T7ni87rScpq5QZ94wl/KL6wShOMfWnzVzXIr5bynuZPlO
 qbBdKfcRmnG/RA51wiKqo8Dx0MFnJpWeAa7aeYMbKVEnIFtpVvP5wMorURCIXbLyOq5k
 Xln1LSMM7NI/K00zkc+hsMqELOGTipPA00TqoEHOR64CejXgHkuXt+90jfM3tB/Nk7EN
 IUiZlaASdfNNvoBwtASzheeP5hCLLg896CnUkW1JBLCEG2OuNZQQjFUZQlaH3irjOf94
 PD9OkqG9muq2tvNRWHaHcrvIpyl9C1RP5gv/DoinKudlcHCaZ0bSMy/SNKXZLCd+P7KM
 PYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761735256; x=1762340056;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1QgQD1KB/C0R/RHwpxQaIRp5/FzujKeep78F+t5pVsY=;
 b=MItJx/Q5XBIsFzbdk99YYEDZImeyI0KDikAk604pCKEasH3vXHPuiT5S4qaHuYFMit
 bh/UMqX+qLjptuQWYhbO9LSnssUne2Ob0/Ldq6LaD4Jys3wwDQ7288PxuMWgJEKSePGY
 BoSE+dmuTLlJKJgsoU5InluaGmTskezo+tyMQwDkkmCExk5aHDz/gvuH/dWpsX3Q59SU
 dLRmUAVnVUQ+ilzsFPmNxXDfSPFAZAptgba1VamyThVKdrnGYc7mYfcoGaMYmB1+NzB4
 5QFwplaVEn6N8DEjMOQOMXexw2SfiDl5NlstscTLLqDYIfdoEJLB3jMDayBNwFhf2fQt
 afVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAvxwhpyE9Di82d8Tu/s0yqgfyNFTCGbjWOmKZgseGXBaEW26dbp097K0fzLk6gIGShD4vjrW7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvAxRMDw3msl6KvN3SzptTKX/aTv1f7m8iYJJnQc+tSsCn931y
 gl9RXwaoAaDZn2GaK9Uv07rvSnF+9YPkRZQskHjFZrxLgWmyjulMB6Oj
X-Gm-Gg: ASbGnctCQnespWtC7JWGRFnGUG0OldohTzYnDH3ukt2pXfIrczh6h0Fo084L3SgdPRM
 cFKB05JwrRoYCnrVXy/otnhPLa8B0tinHaOeICStJjOi6IUCxGgr4pu1QKjz4fdNWw/YJrBxZkV
 pbjXANK0E9Meb2RANJWanu0MZvNtXmUpOEB6dRzo2lbAnLgXr0dRhKXLxpfqkJDQuBBAEBhm7v3
 IyKqS56J23MrMdPm+yTvHgmiZU18WpAqpVCy32gL3kpf8zLugmNhwarcnQzMpu/WfA6e1BF4ZN0
 PRQ6oUP84KpJZkyA8YfWMkK5U3Yzmlfjju8lMfIGAceAWTmZEp2hTO5bq8MaBmmrvzO2S/+AUrm
 4dPZx4x6gOXzO3DrUDG+woEQ5u6e5XFr6oGVKWrLU0hTVGoDncdqef5funnjpmbxbmc8W2t98aY
 cunFiYJdvu2P4bQ5EBngPdOm9z5gKGbWaLDErI3P2xu3I+xgvdXKFaTZV4gmOp0nY9QaxSlXUzs
 Qn7eAV2uwmxkqnaSuRNlPYdizeceFrNvV1bl5yhB/XO
X-Google-Smtp-Source: AGHT+IF9PT1QCFH1IEusVHbb/7BSVN7BdymMXpP/m5nTKwdVkCiHN/sGXNO1EVuZVZ0gVuZDFWeoxw==
X-Received: by 2002:aa7:c14c:0:b0:636:66e7:1a69 with SMTP id
 4fb4d7f45d1cf-63f4dc70abfmr3970643a12.17.1761735256240; 
 Wed, 29 Oct 2025 03:54:16 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 (20014C4E24CBF70023E83719BDA98268.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef82865sm11484255a12.9.2025.10.29.03.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 03:54:14 -0700 (PDT)
Message-ID: <c80bae703d5f0f825becc35b17d855380f380a9d.camel@gmail.com>
Subject: Re: [PATCH 07/14] drm/amdgpu/si,cik,vi: Verify IP block when
 querying video codecs
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
Date: Wed, 29 Oct 2025 11:54:14 +0100
In-Reply-To: <daee8358-1480-4059-a294-050adfbc3630@amd.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-8-timur.kristof@gmail.com>
 <daee8358-1480-4059-a294-050adfbc3630@amd.com>
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

On Wed, 2025-10-29 at 11:35 +0100, Christian K=C3=B6nig wrote:
>=20
>=20
> On 10/28/25 23:06, Timur Krist=C3=B3f wrote:
> > Some harvested chips may not have any IP blocks,
> > or we may not have the firmware for the IP blocks.
> > In these cases, the query should return that no video
> > codec is supported.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 ++-
> > =C2=A0drivers/gpu/drm/amd/amdgpu/cik.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 6 ++++++
> > =C2=A0drivers/gpu/drm/amd/amdgpu/si.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 6 ++++++
> > =C2=A0drivers/gpu/drm/amd/amdgpu/vi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 6 ++++++
> > =C2=A04 files changed, 20 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index b3e6b3fcdf2c..42b5da59d00f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -1263,7 +1263,8 @@ int amdgpu_info_ioctl(struct drm_device *dev,
> > void *data, struct drm_file *filp)
> > =C2=A0			-EFAULT : 0;
> > =C2=A0	}
> > =C2=A0	case AMDGPU_INFO_VIDEO_CAPS: {
> > -		const struct amdgpu_video_codecs *codecs;
> > +		static const struct amdgpu_video_codecs no_codecs
> > =3D {0};
>=20
> No zero init for static variables please, that will raise you a
> constant checker warning.
>=20
> > +		const struct amdgpu_video_codecs *codecs =3D
> > &no_codecs;
> > =C2=A0		struct drm_amdgpu_info_video_caps *caps;
> > =C2=A0		int r;
> > =C2=A0
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
>=20
> I'm wondering if returning EOPNOTSUPP is not more appropriate here
> than returning an empty cappability list.

I don't think so.

Returning EOPNOTSUPP would indicate that the operation of querying the
codec support is not supported, and not that the list of supported
codecs is empty.

>=20
> Anyway setting the codecs list to empty in the caller is rather bad
> coding style.

Sure, I'll come up with a better way to do this.

>=20
> Regards,
> Christian.
>=20
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
