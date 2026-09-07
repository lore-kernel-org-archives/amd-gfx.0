Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED8DC79FA0
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 18:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB06F10E3FC;
	Mon,  7 Sep 2026 18:32:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R+Y0tPjf";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC3C10E3FC
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 18:32:00 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so45745405e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788805918; x=1789410718; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xKbOQeZsCciqMDimQzy+GkolBLKNkgykGPpnT1MTE74=;
 b=R+Y0tPjfRe7xn/7dV3il951CLpCrartxwbU3YaATYvjPb2tgP+59txnpZih49vrNyn
 Z8Z5mrmteK/2d5Up7yc4QH1N7Pd6G1DNzslFED5T5mz/IIDWvuYHa+sJVz47do/1EQXV
 4uSQq0kTyn/2C6T+UXnmUl21LNerpGkX3f6dMYobN1gsG0FNAGHVsiQj1mPte6c4GY2b
 RT3+xr4/2oTXQtdMzh1rS8zLBnsko0YAj1Ul+rkPzLdX+JIrfsbMtdGk05o6VM7HyysA
 1pMD3qYTTBt0t8T/mLbsohI92vZ/orh0EEwEmYMYVMlwpPiBPBBPFFF0XSj/8heGwoFZ
 yWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788805918; x=1789410718;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xKbOQeZsCciqMDimQzy+GkolBLKNkgykGPpnT1MTE74=;
 b=iZqXzL4HxuI8vJL0/gXYPKvmfLgyyQrQTiTyyY5FCaduMC+1hNVNQTyWk/vg1jeAvG
 qxGWlNhwYG8+QdZhUnP2uYDZgpMinYFlAutC3Egoj5GKydvu49SOPYT3GZD8V9FDgOZG
 QR5Jho3KsTQmhUWaixKx8SbaLmLaxcAkGZsTRNh6GaVQoclntQ5ynm05wek4SNwLSF9C
 DGXCHvtwFe3nIT0qcCJl6fYXGebb5FpNbLLdNjgM04CbCWVSc9SOP+wIIZ0eOXx/siHf
 20jzw1QAVFOqBttTZVHO4V1pMPITQZKXXR8dmDuYJCK6DDIXWWJ0wsDVHDaqSqU9rPfv
 MxMw==
X-Gm-Message-State: AFuF++lSqIum7Hlv5oqQqgRED/gdjtiBOIGZrGB6SUlKKaVGyHGE3cQ5
 j2Hc7idpdCYXY20m1TViDHpZUuB+Xxbld3v6iCrSsFFmrAqv7IbOc+7qXAe+Tb0f
X-Gm-Gg: AYBFou1EbURhnXu82+nFTmL+yu/uy5i9MINXhOU84/daIr61txjhmBtuBTH67LmPKiG
 0SI4jjktcmOu7N2wUffYkmRPEENr3jIP0fOVuozNaMDe5/pVr01yD3lfhyRl0/X/OR+Y9ZVI15c
 eT/ZlDGDOugGI+pHWV0gBJ79yKNa5mjup0nzHvZYoDAGeWAouZLcts6l/8D0ubtiERl4hdgiJBn
 5svicOJfEsj8EqGqCHlgf19Deodfyt94kRw4BcsNCMPXV03fU4V9DxQZFjg4xpEtsSlPELymH+D
 NiWtEj2/4e4lR3BQFSzcjbP7f4Y1/TRLGPA8CAnE/2gjxue43Jm/QxbhSxGGHY4V5ktyxZGCX9A
 wR5oaXeQZcFBIPQIZAdAalB4kWfau3vkEK8V4zyCCoy3p19j0hjtsdLYgLp7rFhmbaj87YL21nH
 NpXjwU2oQJsroSQh+uyj2s1YnmDK7y+OZtPfXLojn/3SXjBRLBzcWvcPNEw5aIhfmbUR+4ikp0X
 DjH2Qqli9r+CsmRBAPF2kBkecTCO8tG
X-Received: by 2002:a05:600c:6214:b0:49c:edd8:ba35 with SMTP id
 5b1f17b1804b1-49cf823b95dmr250098995e9.6.1788805918297; 
 Mon, 07 Sep 2026 11:31:58 -0700 (PDT)
Received: from timur-max.localnet (athedsl-4460056.home.otenet.gr.
 [79.129.254.8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d03543064sm238956215e9.13.2026.09.07.11.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 11:31:57 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 5/8] drm/amdgpu/sdma: Clear SDMA rings after reset before
 starting them
Date: Mon, 07 Sep 2026 20:31:55 +0200
Message-ID: <XpUiFQe4SfCOOy0kF2mzQg@gmail.com>
In-Reply-To: <a3a99a32-baa1-4ea6-9c8b-b7994beb8f47@amd.com>
References: <20260904072850.321759-1-timur.kristof@gmail.com>
 <20260904072850.321759-6-timur.kristof@gmail.com>
 <a3a99a32-baa1-4ea6-9c8b-b7994beb8f47@amd.com>
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

On 2026. szeptember 7., h=C3=A9tf=C5=91 9:04:55 k=C3=B6z=C3=A9p-eur=C3=B3pa=
i ny=C3=A1ri id=C5=91 Lazar, Lijo=20
wrote:
> On 04-Sep-26 12:58 PM, Timur Krist=C3=B3f wrote:
> > The ring contains commands that were emitted before the reset.
> > These need to be cleared to make sure the HW doesn't execute
> > them, because they are garbage at this point.
> >=20
> > Note that the ring reset helpers will re-emit the commands
> > that are necessary after the reset.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c index
> > fbac732f3e01..66f278f77f71 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > @@ -593,6 +593,18 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device
> > *adev, uint32_t instance_id,>=20
> >   		goto exit;
> >   =09
> >   	}
> >=20
> > +	amdgpu_ring_clear_ring(gfx_ring);
> > +	gfx_ring->wptr =3D 0;
> > +	atomic64_set((atomic64_t *)gfx_ring->wptr_cpu_addr, 0);
> > +	atomic64_set((atomic64_t *)gfx_ring->rptr_cpu_addr, 0);
> > +
> > +	if (adev->sdma.has_page_queue) {
> > +		amdgpu_ring_clear_ring(page_ring);
> > +		page_ring->wptr =3D 0;
> > +		atomic64_set((atomic64_t *)page_ring->wptr_cpu_addr,=20
0);
> > +		atomic64_set((atomic64_t *)page_ring->rptr_cpu_addr,=20
0);
> > +	}
>=20
> This could be made as a small inline function like
> amdgpu_ring_reset_ptr(ring);
>=20
> Thanks,
> Lijo

Thank you for the suggestion, I'll add that to the next version of the seri=
es.

>=20
> > +
> >=20
> >   	if (sdma_instance->funcs->start_kernel_queue) {
> >   =09
> >   		sdma_instance->funcs->start_kernel_queue(gfx_ring);
> >   		if (adev->sdma.has_page_queue)




