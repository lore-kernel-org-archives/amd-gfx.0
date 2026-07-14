Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C0FC44508
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 15:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A779B10E06A;
	Tue, 14 Jul 2026 15:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="swrfaLtw";
	dkim-atps=neutral
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5223D10E06A
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 15:05:47 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-73877b6f898so201726137.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784041546; cv=none;
 d=google.com; s=arc-20260327;
 b=HFtAgeE65mnpmz/6o82K9V0L4OhwVV4puQQL1KQxsbN21EqCLKsb6+ldQOmNqBfHfA
 kXabvltyWbisJQzW1sOwOxuAgyGM0iLpCZLGBk0Z6+xNUKONwN5jGMBb4qLotzmPwGHm
 xIYIePaDvfUg+GWffDwYZNC613SCXcQgCruN5qoJUe0zjdvouJzO6VTF/+BEZf7Bt28w
 mqGZfYo8/MB9x1S/t1Xv9flTtmcdl7hsnm/I9vVyUmsYA7FA6W8llXipYX8ir2MERM2b
 V7qCDhz65cNT/LY+35x/30mDX/d5VvAq+fCHL2qNGwpmtvafa2tRiIzUoumqPwc1myhm
 +Vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iyOB+r8reDeXOR49ReQI448LhpfnlB4QhxqIHvmNFwE=;
 fh=U3hzKFl79X1czmKbG3RR4g57KasS2s70X+uipMLgRrM=;
 b=M/ZkLsTXNcLCrpbbBmiDe9ekVBCj9w365dllLHLH0RI/4FNG9E5mQPdKhrfOmZglsm
 exm7nBv6+aTaAZk4viAc9CYMGFxYuiH6UqblsP0+x+EnGkdQLEbPWWo8T8rK+TIHpFxA
 IKz5kP5DRIybSI0rxgFTnLY/oBu6oqiYBlZZqsE8o+6pBSA3TaiOnc6ZJyd5n+9bI+9T
 n0pDl4HmAwsvj0XGkf/EcgF9bzYarWqCuZpqJonEHZje1fidWvfK67WKAZY04/L1Ezau
 2tquChkjYOKjaizzSYKHvqlkuZjwf8jP+IKfV2PqDJ/5th/reeLEIC8iji6x95ko1CXy
 THrw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784041546; x=1784646346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iyOB+r8reDeXOR49ReQI448LhpfnlB4QhxqIHvmNFwE=;
 b=swrfaLtw/0RjL8AWq+la1iQg64NJj2CXJNEmId3pG0KdHsuSH/0fof9TEyxfwSULB4
 dtZCifnpBpU6MCrZ91ddJ3rrQqX71CMmIHu0nSSKbuhMHmKKiSMAo7OqgFhQq6R7TXER
 fsO7Ucx2eBiEqzTvwZSqVKR5INRki8aH8RDeSNta9tyjgzxQFpMBvf1+QKP5t9QqdcDL
 tVNY1Rgwm0QorSoBhQv7S4FqfZ6WcHf/FcoCJeR87X35Sc6UnMjn9+IqLFPYGC68w8B+
 Ct8UO3vJN1L6PqSV5FLgjlVXzkuufQO+ZHn8mj5bzZWw+rRSHES+poqBb0u6YAYLl6eM
 wfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784041546; x=1784646346;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iyOB+r8reDeXOR49ReQI448LhpfnlB4QhxqIHvmNFwE=;
 b=jUiQ1V9fZo2NRLBUMo8/15huK36Y6BDeIjOIWqibga4iKevPeR0XiBKE8QZAiCpA4O
 KOdQLsSvc7oWiUq7HqKA2p+3v0e3YV3G6HNF/V0R+vax0hVaw0HoFFu0Vl6rtR7MCCoM
 yhv94DUJH9MeaaAhfOVMUMFe+coNwalwANLtntYmLa/pxEL15CXCIFBsYGLlgxa4Hg/Q
 BfWWTLErNb9fZFNunQDC8tahemBDSEO+fhc0O+zRqEsNqhjQBMlMQNM2vioBNj9TUoqT
 Cjg+tW7rYS+LyWIL707IT8C1jHGZjkq2b9fIS9wk2HopraiwVkFZVp74azQk21mzRbE4
 pUsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPzhi5kM1lsFDwQD9P+rIyXK2Q4H5HNyxOh0WdjzRvC8Dn+r4AXsApIRyhltVaw7RuCabi3W0Q@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1ySbP/1oSr6LuPubCYCGjP91yR3EhRGYfTYxi5ag5MeRTYFVw
 aaRGXosalidXsn+5QUzYyiSLzz5WTymUUeYh87jgLJZwI/gw6FIOpm8xeFWavORghJp/QBART8t
 fKSWe5tnGGM9E+jwa12Omj6w96ESmqgM=
X-Gm-Gg: AfdE7ckzfRYC6WkJG5e7yj9I0hHIYzHsvoRMzn8R0beRf23vuoH8IDO7G0OfEmOmlnp
 zITA4tBCMUOdZ1OSGSbsIc9rzkUbfOKYRHyTY4l2IkcL2+W7oVPkrnEXfgT4x9EjpkgPSEGfLVn
 ZbuW1pja5EwPN0kJ64iJzg3OubUigjlNutgG45DwcbgD8qySIoGVOZ+kRT9KZS3HUjX0Fri6e9P
 cyo/pOZa21EKljqPNZ2TE/oh3+pVSyJr2QvPsINBMnTHoZFiL57O5UVS7/QM2O8aIdWRirFJFVK
 aYjZNVb5+yJwsMiEBSEDtgyp7lN4Zy8CTtFt1RMTRQyV//Hkjb7BKLP6x3A=
X-Received: by 2002:a05:6102:4499:b0:739:b6bf:bc9e with SMTP id
 ada2fe7eead31-74533da1db6mr3112793137.3.1784041546185; Tue, 14 Jul 2026
 08:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <20260713125838.30607-2-timur.kristof@gmail.com>
 <46f1492b-7e48-4a62-8a2b-7a058221f033@ursulin.net>
In-Reply-To: <46f1492b-7e48-4a62-8a2b-7a058221f033@ursulin.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 11:05:33 -0400
X-Gm-Features: AUfX_mzFhRNv6j0sN-FXreJZVd1cV9FHLBvH_GolK32-jKV1Yj3oy1NlfXo7dZs
Message-ID: <CADnq5_MWaSxpnMBRYsk-vqhKPvZB_ohq4yCZsu_iYMG+M2dmiA@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amdgpu/gfx7: Make amdgpu_gfx_mqd_sw_init() usable
 on GFX7
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com, 
 Natalie Vock <natalie.vock@gmx.de>
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

On Tue, Jul 14, 2026 at 10:59=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.n=
et> wrote:
>
>
> On 13/07/2026 13:58, Timur Krist=C3=B3f wrote:
> > We don't use KIQ on GFX7 but otherwise MQD works the
> > same way as GFX8 and newer.
> >
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 96c9d4f00b27..0f142c156afa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -420,7 +420,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ad=
ev,
> >   #endif
> >
> >       /* create MQD for KIQ */
> > -     if (!adev->enable_mes_kiq && !ring->mqd_obj) {
> > +     if (adev->asic_type >=3D CHIP_TOPAZ && !adev->enable_mes_kiq && !=
ring->mqd_obj) {
>
> CHIP_TOPAZ is gfx7? Hm if it is then the branch would already run there.
> So the change is limiting the branch to a subset of platforms, while the
> patch title made me think it is enabling something on gfx7. Perhaps
> somehow indirectly or what am I not understanding?

TOPAZ is gfx8.

Alex

>
> Regards,
>
> Tvrtko
>
> >               /* originaly the KIQ MQD is put in GTT domain, but for SR=
IOV VRAM domain is a must
> >                * otherwise hypervisor trigger SAVE_VF fail after driver=
 unloaded which mean MQD
> >                * deallocated and gart_unbind, to strict diverage we dec=
ide to use VRAM domain for
>
