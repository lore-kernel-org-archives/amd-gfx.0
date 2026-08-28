Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22ABC61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 15:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 297A810E14B;
	Fri, 28 Aug 2026 15:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sWzY5tu7";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDEE710E14B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:34:03 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so127418866b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787931242; x=1788536042; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=144B9L4fVxAwmM7ePMpn+O5PJ9vdiXtByCerzmO2bNc=;
 b=sWzY5tu7/wsKqB+DoRNSX1DbBELtTFtZvErF3z6T2aFs+7XQx9yW+JNQ3aKIZCk4uP
 PqqHGtmpWlH1WAzaXuNgBvSrZuMs4i3BQyZdkBtNxBdjlQ7v8oklMqH5mb39VsDEsMnY
 secbFd++Y4oLJklRIqQtY3hxXHrG2HtB/ZaKflzjZIqh3zWu3LUSqLE496s5LWvhidtG
 Td15GvNJDHpR9ws2ohgnOHf0ZNj4vZYHawzEGFRQD7xF7kD6agewQYQmQkNTKXCLNlW6
 Ud4BwvZ2YrRDkS3n4BnCJnYPNTJCcK/rlLW90PerOFvNsZXu9+mDMfgcqVFjWJ+92J4q
 nKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787931242; x=1788536042;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=144B9L4fVxAwmM7ePMpn+O5PJ9vdiXtByCerzmO2bNc=;
 b=rRCgwLbWPVu4Kl2WPzmoBRGMl/I5u7Mkg6H1yzBxurawMe9ifu1RKwydioRcos3044
 i5/6tNZ9SEijvkC2l6GWsCcuSHF0LXf9JQIOdUbAULj+9osCn8OzlxNhCnNw5shPm31o
 bHjC3e28VrERT9yZdtj+VVnDQnQJMcQqowYa7qX2Qa1Oh8/3SKrHULUOMFrp7h7xtgi0
 aSca18XzsCxTrJ0GMCYJsa3xYMmeHJ0xmrloetlmdm4cDWG6NCduWTfWhBkZzL8EJO7Y
 Bz7GfONeXIRQY0P9ikyZ3p0hERZ2+p9mehcQGjuZcXvIYvtKrW1TDYaBVV1nK5pvJAyk
 ybQQ==
X-Gm-Message-State: AFuF++nhoJu4r7RvxAMzLWKHp5pUeTWSL90HTDUJ99eJUTobEhz6RIyz
 biNy5YGiaPhnCi0zcficuzZSOcWCT/6+CMhPHDJsE4U2Zx5WoWGdnVsxsVlxfg==
X-Gm-Gg: AR+sD12RE/F9ASIS8WQ25cs1azuArm5NpXXSqGTCWZE+F9Mpkmq39ciYQ/a+E8hFs9P
 j+b7aeqQhzntf3W0AU4G9FOPvTeZdTa5Ln2Af11HhqGvtVYhPdJjipC2nU8cxlem62dPP0seG2J
 tZ3W38TiBC1YzhlxknpdSynRO+QyJBg89u40LjcO7P1TkyGItPIoZDuJkr9AMpTtW9UJaNnAQuo
 saKe5BrN8SIfX51Pqsm8CtJXUJG3sJ+nCPmdVO7MzPc+biYQAbT283CdtF6/4Ox9c+Q3PrR/Ijo
 WqRmfvyI8NmWnN7Sj+hRQPocGBDxtw3eUdbb3UN+SqqK+QHbKyiPNvMK1TMAK2BWA1vde7fTBc7
 hfGfQD/Q3qcZZw3QvRxxP8FqY0FgQueRuce9wHHYn3nV7RMycu3YkvTBCW6cefPBcTtw9Lt4RMl
 WT3ddwQh1OMCzDmdUp+Tx1XV8mvZVU52yB5jhYPGriANPZhIlCL27rBRv2F0Lvc3YI/DhoXbwcj
 xqipKaFkZEJCEYju7REQ6xb+E2PchVDYrahp5n+mQqGkPI=
X-Received: by 2002:a17:907:ea91:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c2556fe5799mr624376466b.9.1787931242018; 
 Fri, 28 Aug 2026 08:34:02 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B9A5E.dsl.pool.telekom.hu.
 [94.27.154.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee0b23esm91823166b.2.2026.08.28.08.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 08:34:01 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 5/5] drm/amdgpu/sdma: In legacy queue reset function,
 check if KFD is initialized
Date: Fri, 28 Aug 2026 17:34:00 +0200
Message-ID: <eXQmQAWNSiaitYh_wg0biA@gmail.com>
In-Reply-To: <efaaf188-bfe0-4fb4-9a13-23cfe386367c@amd.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <20260828120729.25908-6-timur.kristof@gmail.com>
 <efaaf188-bfe0-4fb4-9a13-23cfe386367c@amd.com>
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

On Friday, August 28, 2026 4:11:47=E2=80=AFPM Central European Summer Time =
Lazar, Lijo=20
wrote:
> On 28-Aug-26 5:37 PM, Timur Krist=C3=B3f wrote:
> > Avoid calling amdgpu_amdkfd_suspend() and amdgpu_amdkfd_resume()
> > when the KFD device is not initialized.
> >=20
> > This allows the function to be used on GPUs where KFD is
> > not supported or the support is hidden behind an experimental
> > flag, such as CIK, in the future.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c index
> > 9eebd8380834..8798caed1ff1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > @@ -664,9 +664,14 @@ int amdgpu_sdma_reset_queue_legacy(struct amdgpu_r=
ing
> > *ring,>=20
> >   	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> >=20
> > -	amdgpu_amdkfd_suspend(adev, true);
> > +	if (adev->kfd.dev)
> > +		amdgpu_amdkfd_suspend(adev, true);
>=20
> The right place would have been suspend/resume functions and that check
> is already there.
>=20
> Thanks,
> Lijo

I see. In that case we can just drop this patch.

>=20
> > +
> >=20
> >   	r =3D amdgpu_sdma_reset_engine(adev, ring->me, true);
> >=20
> > -	amdgpu_amdkfd_resume(adev, true);
> > +
> > +	if (adev->kfd.dev)
> > +		amdgpu_amdkfd_resume(adev, true);
> > +
> >=20
> >   	if (r)
> >   =09
> >   		return r;




