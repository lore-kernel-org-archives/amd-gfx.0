Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F1ECCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 09:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767AD10EA50;
	Fri,  7 Nov 2025 09:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dbBS8kE/";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2524510EA50
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 09:39:30 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-429b9b6ce96so332003f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 01:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762508369; x=1763113169; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFME50k3SySuDE+iLLKa0AXt8Z67HqhUJYP4rhwUCng=;
 b=dbBS8kE/XgSRBtEUzETTsZp3abaEAcgBtkY4yq5rjfJ6T9YhBDFPQpGpDIWW22Q6mT
 hm+99nSFEd94kvWRwXDaFY72vuG1+Di+9ftOHBEMCynxGxMG1cDwjDdv/cbmPHbPlDzO
 2qtaQPFa0VYnMFpPEk33aHNlh8LdxdMIBdsI/N99V9ixopSBlyo/RZE4YMkQQupBDUiP
 Zw9e0XxQfiaN6A7chZ45gyVC30wLkh1U1J6IpjOsmHWOalvyblESszKX2K0kkOEn7klv
 3/vWtE7bucQCvkhgQypgq573mHvlEB5RTRpCRZnGdqi84UbyDojeP0zlk7dPCSFoJVHy
 lsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762508369; x=1763113169;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hFME50k3SySuDE+iLLKa0AXt8Z67HqhUJYP4rhwUCng=;
 b=I5uISzheQe3kl8i3dt+/QXx7f+RiUfz172ojAlB7vxnjM4xexgkhw4dQIDYy9PGfmk
 hduTQalktNdLs4j482sRlxafrJ3j19ZJwq65sSJ5MqgcUwmpUIZYU4/2aZRq+aa/g32R
 oi2rSIG+BwYMnyFCoz3BhKyqntzK9plT3x7zb3EOsHmQPkJ6qkqE2gShKEIWck1D4JPb
 l09iEky6LQajRvlkHg6XWgilkWhOFwcGpbSl8kxEPnkCqSKQLbkP37NB4WHb0ZOuL3n8
 OTOM4YGtmcawzkPqPAwYFAypIeAxC2oJtsGFKFtwcVjWRlbISVcuqYY3g1+KjuIoKmac
 pbfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFA+tfrG/Se/mNRuZW096dHeVjgCKl77Oe0GFioaRIrA71H0dYSR+6dQ2vA/QlFU/G0g+jj2eb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCrhvrQmP2Jo0b7YfsW+UH0v+kTYs25DcoQECHfZdfXOqjbw+L
 aV50pVT6rKGGyzJdb+eIQLkZlq/KZgO1IfnUAzv4h+nPWGVTtlYW9OEF
X-Gm-Gg: ASbGncuXV0O5SwbnJY46Wev5p0CCxqKZfq1qxf+iHdOS2AMrh7MyN2SKmhGEkLvd3wP
 HLrraC3ZCZmZY57ysTOWY1y2dUZVnsVm0jY/vcntCXpGP+UoUoaM+sAZWVxsapDEW5N9fbHkuU+
 azoN01pEpNjuitFM5EhCuyNiKCJCDWov+PlWVdAp093SxAhffFePkuiqgcdFiz4a62KxJvtaV8z
 EMoa5ZbtQiG6Z9EfZmE68+cKqxqksPfNUumZaHqFbBaF5IvrAhoddYjba6Ra/wOW6DoHbttgT4E
 SsZ2mmATVF0Zkv4nGai/N7vGr99vToU0FZiX0tN05FblC9kTJe4Rr9cxDKDKRWafONvE+WxntrZ
 o4f/Xo7CfUN03AVulrfc6z8afA1mHV9BdGyToqnY20+6hKzEbb+9pVRQW5vVYGWlBssfJ5JjS92
 0sivznp9kd7oHEJMpgkVJ3Khk3qRp60jZ8A1ST9NfIvk0gVPypli5er/noXpl98EXwW2EB3QKma
 pxMIwOMqrw6nHkOH1RCIzz4O8Hw/KcViTMOncgsVWYC
X-Google-Smtp-Source: AGHT+IEB5Ere8inVRJ7yD2b8LDDfjhDTujC2fcYBbZUY1za66Rh5BQjJ++icFG1Ydx14JghutkqZ/w==
X-Received: by 2002:a5d:5f96:0:b0:427:a05:2ff with SMTP id
 ffacd0b85a97d-42ae5afbb65mr1864323f8f.33.1762508368436; 
 Fri, 07 Nov 2025 01:39:28 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3?
 (20014C4E24CAA400C3D82D5ACB81C0D3.dsl.pool.telekom.hu.
 [2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42abe62b23csm4136278f8f.10.2025.11.07.01.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 01:39:28 -0800 (PST)
Message-ID: <f4854aa398e929cf3d7186e4d32da0d0da3a7e79.camel@gmail.com>
Subject: Re: [PATCH 04/13] drm/amdgpu/vce: Clear VCPU BO before copying
 firmware to it (v2)
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Date: Fri, 07 Nov 2025 10:39:24 +0100
In-Reply-To: <0512a9b1-1ab0-407e-91c3-f496a55dcea8@amd.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
 <20251106184448.8099-5-timur.kristof@gmail.com>
 <0512a9b1-1ab0-407e-91c3-f496a55dcea8@amd.com>
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

On Fri, 2025-11-07 at 10:25 +0100, Christian K=C3=B6nig wrote:
> On 11/6/25 19:44, Timur Krist=C3=B3f wrote:
> > The VCPU BO doesn't only contain the VCE firmware but also other
> > ranges that the VCE uses for its stack and data. Let's initialize
> > this to zero to avoid having garbage in the VCPU BO.
> >=20
> > v2:
> > - Only clear BO after creation, not on resume.
> >=20
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> For now this patch here is Reviewed-by: Christian K=C3=B6nig
> <christian.koenig@amd.com> since it addresses a clear problem and
> potentially even need to be back-ported to older kernels.

Thank you, I agree.

>=20
> But I think we should clean that up more full after we landed VCE1
> support.

Yes, I'm happy to continue this work after the VCE 1 support lands.

>=20
> Assuming that it hold true that VCE1-3 can't continue with sessions
> after suspend resume we should do something like this:
>=20
> 1. Remove all amdgpu_bo_kmap(adev->vce.vcpu_bo, &cpu_addr).
> 	As kernel BO the VCE FW BO is pinned and mapped on creation
> time.

This is already done by patch 6 of this series:
"Save/restore and pin VCPU BO for all VCE (v2)"

>=20
> 2. Rename amdgpu_vce_resume() into amdgpu_vce_reload_fw() and add the
> memset_io() there like you originally planned.

Also done by patch 6 of this series, except for the rename.

>=20
> 3. Also add resetting the VCE FW handles into amdgpu_vce_reload_fw().
>=20
> =C2=A0=C2=A0 E.g. something like this:
> =C2=A0=C2=A0	for (i =3D 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
> =C2=A0=C2=A0		atomic_set(&adev->vce.handles[i], 0);
> =C2=A0=C2=A0		adev->vce.filp[i] =3D NULL;
> 	}
>=20
> =C2=A0=C2=A0 This way the kernel will reject submissions when userspace t=
ries
> to use the same FW handles as before the suspend/resume and prevent
> the HW from crashing.
>=20
> Does that sounds like a plan to you?

Yes, that sounds like a good plan to me.

>=20
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > index b9060bcd4806..e028ad0d3b7a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> > @@ -187,6 +187,8 @@ int amdgpu_vce_sw_init(struct amdgpu_device
> > *adev, unsigned long size)
> > =C2=A0		return r;
> > =C2=A0	}
> > =C2=A0
> > +	memset_io(adev->vce.cpu_addr, 0, size);
> > +
> > =C2=A0	for (i =3D 0; i < AMDGPU_MAX_VCE_HANDLES; ++i) {
> > =C2=A0		atomic_set(&adev->vce.handles[i], 0);
> > =C2=A0		adev->vce.filp[i] =3D NULL;
