Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5459EF9937C
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 11:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E143710F0BE;
	Thu, 23 Apr 2026 11:50:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RpGzZBar";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44FBC10F0BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 11:50:14 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so30044165e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776945013; x=1777549813; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4hmkBXXtPne2QFgo3zsPfHScxB26k0qBduR7GJjhrDQ=;
 b=RpGzZBarGOTXY9rFYYb/e+4O0ScPQCGB4CrNX7nZ7YIUXxfRYF7mu8qDrNSiY/7cET
 Ga1wKTx0a/gX14hzwIcaD7qvSucGNfe+PBSZTlP38Hw78+ABCnAilb3cC6A2X4Y3wqJV
 Fq+0+iUKTIR4LRSVg96zrwfwD9qcqhMZ5rnLyk9rZuw6p9e23FVY7Il/VnhK+lQu9Xm8
 9CO3cdLY4pkBsHtskib3EVkQdU8we52HoOCITAWLR3/7ZQKdd11nHpajgar4N2DmvNk1
 H6Z/HV15JKaYAU3B8mtDnShGi+F1X8C1se6OV5XOGrsj0/6N/sc0FUZB28Wkx+bx2kwh
 mmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776945013; x=1777549813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4hmkBXXtPne2QFgo3zsPfHScxB26k0qBduR7GJjhrDQ=;
 b=D2DBL8qFEPWaoc6rdFkbCKpQ35t7hIwFBYnaXMvBOqP8fK3KDk6LhtSh5uLWn21drq
 +zkCpW4EfMN0rQF28KFzdZKc6yMPbmmykcdyl0Ql9B6OdTrfThsTEVuDr2F9fjFztTNH
 4v+ok3L0JO7O/nk8SkGiOilfJsCCF3q6OojCi7t97KK/HC6moaJ1ei/MIQCjm9Inul90
 tOROFvdZermAxJKXEfuA38G17Wf4DlGI2o+8JvruKwR2xfO+JRpkqyN3EhkNB2Nr7Yf3
 tsv0J7BObry4Q3IHd7fAgNJKJCqrB7DLflanQoQMbYpQ9T8OQTuoH3HCBNzux5A0MCZd
 pEyQ==
X-Gm-Message-State: AOJu0Yz27WV63+PI2qFuxMc79L/j/qOc0FL0zC38hrek3vWJjPyloeQY
 ZasZHcqbp0Q+iCUKIi6yTOa2XuSIQrMPj/SrCLXWfnhtd1RESYwQjCn1e0woxXow
X-Gm-Gg: AeBDievqQ5ajLvQQ19IFtWAp+8pKgeKkd1lQ8Qi5x3aVSFFRj4BSNmKSBe6l9ol8bKS
 CV+sJ6whoFkzV2pqxanklxwxlpp6qlDSXd7ZMe7cFhceUcn4OSwGGA0zY8HY/H25TFTLInVe8nd
 MRBZdhM0vAQsGiK01kuVjbL7mLspP5CjMwm4J1reWigHcn/iJahIKy1DDfIkApJbVcFuqvG+PvP
 ryL6j2HA8PrilzwwsVqHs1b5RLFdhLPWCdYN7qOFm3+xnAI8FHeJZcSeodnJ7hwLV+LjObqKaov
 TiDRjjsfltMoyWVjWv0qhy7nFj3JasXRtZxIYwUpvtSaF/tAZrTqpZvzMm9Ltwz0rnkOe4MxWag
 zbV1oCsnP/MtzLFxmDV58NZ4hntZXVFZm0myiWoMv0v+DsYWebivR3TAgkoomUgczqS5H+B7mlD
 es25FNBqsdqZBUO/SNvkBdqIq8FHW+qQflYaul3/med4hm3tHilvQpK9XlXktv16sVaegPYGVDh
 AXWzL25WYY=
X-Received: by 2002:a05:600c:c112:b0:486:fe83:861c with SMTP id
 5b1f17b1804b1-488fb896910mr307430685e9.7.1776945012597; 
 Thu, 23 Apr 2026 04:50:12 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc14a61asm478879875e9.15.2026.04.23.04.50.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 04:50:12 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 John Olender <john.olender@gmail.com>, "Liu, Leo" <Leo.Liu@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 11/11] drm/amdgpu/vce4: Fix VCE 4 firmware size and offsets
Date: Thu, 23 Apr 2026 13:50:11 +0200
Message-ID: <2603876.XAFRqVoOGU@timur-hyperion>
In-Reply-To: <4d9390ee-cfc3-42cb-bee3-df6b9539078b@amd.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-12-timur.kristof@gmail.com>
 <4d9390ee-cfc3-42cb-bee3-df6b9539078b@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Thursday, April 23, 2026 1:31:03=E2=80=AFPM Central European Summer Time=
 Christian=20
K=C3=B6nig wrote:
> On 4/23/26 03:16, Timur Krist=C3=B3f wrote:
> > The VCPU BO contains the actual FW at an offset, but
> > it was not calculated into the VCPU BO size.
> > Subtract this from the FW size to make sure there is
> > no out of bounds access.
> >=20
> > This may fix VM faults when using VCE 4.
> >=20
> > Cc: John Olender <john.olender@gmail.com>
> > Fixes: c1dc356a116c ("drm/amdgpu: add initial vce 4.0 support for vega1=
0")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> Leo can you take a look at this? VCE4 doesn't use the classic VCE FW
> validation any more.
>=20
> So I'm not sure we have nor need that here.
>=20
> Regards,
> Christian.

Hi  Leo & Christian,

If you take a look at vce_v4_0_mc_resume() you can see that it initializes =
the=20
firmware offset like this:

offset =3D AMDGPU_VCE_FIRMWARE_OFFSET;

Specifically for the non-PSP code path, this triggers exactly the same issu=
e as=20
VCE2-3, that this causes the STACK and DATA to be also offset, and hence th=
e=20
DATA will be out of bounds of the VCPU BO.

=46or the PSP code path, the STACK and DATA no longer depend on the firmwar=
e=20
offset and size, so that is fortunately not an issue anymore. In that case=
=20
however the driver still uses the same offset for the ucode.

Best regards,
Timur

>=20
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/vce_v4_0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c index
> > 3309e7b8f2a2e..eaa3e05a52e59 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
> > @@ -281,7 +281,7 @@ static int vce_v4_0_sriov_start(struct amdgpu_device
> > *adev)>=20
> >  					=09
mmVCE_LMI_VCPU_CACHE_64BIT_BAR2),
> >  						(adev-
>vce.gpu_addr >> 40) & 0xff);
> >=20
> > -		size =3D VCE_V4_0_FW_SIZE;
> > +		size =3D VCE_V4_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
> >=20
> >  		MMSCH_V1_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCE, 0,
> >  		mmVCE_VCPU_CACHE_SIZE0), size);
> >  	=09
> >  		offset =3D (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)=20
? offset +
> >  		size : 0;




