Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AE0D3EE6B
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 15:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D894C10E9CE;
	Thu, 22 Jan 2026 15:00:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aqsql/rN";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7194010E9D4
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 15:00:45 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so7656105e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 07:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769094044; x=1769698844; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FDIGcrQeI7TUl53A1tKBQGSWEsAoREmDHrcAi67WNyY=;
 b=Aqsql/rNqxtT3A4Ir/ygTSYmDrihrrO37FoEz5k4nT+59+7p2bg5NMKotubIjodL/h
 2YL2ECUTWU8FzUQPUiQ/xMgQh2fynRiY5WGVr9T4Jij1O84jBeQw6BSuXGguQBlkjx6h
 y4zgSm0kN+DU1xaoUcHqe4TtTUOzkmfbQJbtdCnfi+7myZaa/OPiUY0sc33HlkvgywLR
 vGtISFYXn1MjfaeJ8/TqSGoWTMyu9pAxKr5+l91pQzvyS0O01ftWrXjv8a6CgcPHkfMg
 Hm3i1+SzYArKDEZ4W8mVH0OOa49F99VFKA9poBmieou0oGdrEIvhaK4eV9DbFfNdUpI+
 YfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769094044; x=1769698844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FDIGcrQeI7TUl53A1tKBQGSWEsAoREmDHrcAi67WNyY=;
 b=AsMj8FBLHuGxVc9O8Pw8qJGcCjj5hifyAH4A1av2ovliO/oU+3A0ffpn7Xpzw7A5TO
 e1TJT4Odfdx3DZLuzCDoqhT+OlSPjQgIzirh529COhfT1pwhJLlYbQXzrrwyR+tQdVBl
 xlSFQ2zwsnBS+Ssn4C6M2evP29oBMTQJ1rDM3DF1rW5JcBTXsRrYeEjWH7ToeUsFQtDa
 LRhtB7Ko8j4u7dtwYuNcptywKOmBxEfEdZCY5lnudKj1yHy1OUehCwWApnnHR6afl9Mw
 wDhfGCxeeFIsrwBxQHKQ3IE97DvQ8NHv6hrGiPqmdqRjlAnT5350UKV9lCZ/hzS9FDpM
 3/SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0hVaFeqGAYEd77RBAjTTPhWgutzfFcovOhaMMUJJyktMxry/oKuYxQBX4L2apAnJIX4vknp0S@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz92Z/GCH+RtblzufczB5oV6/gQ7e4UyKtIWzVwVJ8f5Z7hsOcV
 0QVP+BK1ULezo9/j6Y2EmscPP6gcKr/DN4DoWOdqFl/QlRvB6T6vVZHu
X-Gm-Gg: AZuq6aL1OyaK+T43t3zQycXV7lYdhnUyQFLQnM89wIIYh+zSRsxxrbRgNR5YP+Ji9u/
 5CrWAZx2AdUaF4SvfK0zae+1/YT9WV5xgZGLliii00NX0mg2ySlyTHlzcHlrTZdflE0CbAeONVw
 ppTmv4Hxv7001PYgLgMxNiDd2Tx2rTictOHDJrw+iwKYdPewrMSf+8XcUdChFk7idO9mJWUkwRo
 Qh0sLWNg5qw3TB3zjOhU4QpR1YI6CTfsRiyuv0JlRnaFhyNTz8aAdmIDdghIPmBQNalKftQQCJO
 7mP4IUZkOu1g0yU2SzHF6JdVf6O+ymUxHkday7EoF0lIKkvaH/88BBgrLuZFWENKIxwDqO+zpt9
 p3UdtyARwo0X1/XXmbqF9jt0El/UGP18kzR8fstLfm4C30oBaDXLTIJeV7OalmqTOFjM850EIiP
 3gLu0TVQBQkIeu10spOPwoTGtCax6T9VxIGCUZL9GVpmxo/BmvWYA1CScu
X-Received: by 2002:a05:600c:a013:b0:477:79c7:8994 with SMTP id
 5b1f17b1804b1-4803e7f0e39mr144220535e9.30.1769094043496; 
 Thu, 22 Jan 2026 07:00:43 -0800 (PST)
Received: from timur-hyperion.localnet (5400182B.dsl.pool.telekom.hu.
 [84.0.24.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cf1acsm72039655e9.14.2026.01.22.07.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 07:00:42 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Jon Doron <jond@wiz.io>, stable@vger.kernel.org,
 "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_gmc_filter_faults_remove
Date: Thu, 22 Jan 2026 16:00:41 +0100
Message-ID: <4882409.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <9d5291d6-9e1f-4df4-ad0b-ba7543d8a2af@amd.com>
References: <20260121182447.2434085-1-alexander.deucher@amd.com>
 <9d5291d6-9e1f-4df4-ad0b-ba7543d8a2af@amd.com>
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

On Thursday, January 22, 2026 6:07:27=E2=80=AFAM Central European Standard =
Time Lazar,=20
Lijo wrote:
> On 21-Jan-26 11:54 PM, Alex Deucher wrote:
> > From: Jon Doron <jond@wiz.io>
> >=20
> > On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
> > ih2 interrupt ring buffers are not initialized. This is by design, as
> > these secondary IH rings are only available on discrete GPUs. See
> > vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
> > AMD_IS_APU is set.
> >=20
> > However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
> > get the timestamp of the last interrupt entry. When retry faults are
> > enabled on APUs (noretry=3D0), this function is called from the SVM page
> > fault recovery path, resulting in a NULL pointer dereference when
> > amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].
> >=20
> > The crash manifests as:
> >    BUG: kernel NULL pointer dereference, address: 0000000000000004
> >    RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
> >   =20
> >    Call Trace:
> >     amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
> >     svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
> >     amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
> >     gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
> >     amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
> >     amdgpu_ih_process+0x84/0x100 [amdgpu]
> >=20
> > This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC HW
> > IP 9.3.0 from noretry=3D1") which changed the default for Renoir APU fr=
om
> > noretry=3D1 to noretry=3D0, enabling retry fault handling and thus
> > exercising the buggy code path.
> >=20
> > Fix this by adding a check for ih1.ring_size before attempting to use
> > it. Also restore the soft_ih support from commit dd299441654f
> > ("drm/amdgpu:
> > Rework retry fault removal").  This is needed if the hardware doesn't
> > support secondary HW IH rings.
> >=20
> > v2: additional updates (Alex)
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
> > Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jon Doron <jond@wiz.io>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> > 8e65fec9f534e..243d75917458a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct
> > amdgpu_device *adev, uint64_t addr,>=20
> >   	if (adev->irq.retry_cam_enabled)
> >   =09
> >   		return;
> >=20
> > +	else if (adev->irq.ih1.ring_size)
> > +		ih =3D &adev->irq.ih1;
> > +	else if (adev->irq.ih_soft.enabled)
> > +		ih =3D &adev->irq.ih_soft;
>=20
> Faults are delegated to soft ring when retry_cam is enabled -
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/dr=
ive
> rs/gpu/drm/amd/amdgpu/amdgpu_gmc.c#L541

Hi,

As far as I know the retry CAM is not available on APUs.
Please correct me if I'm wrong.

Thanks,
Timur

>=20
> That matches with the original logic in d299441654f ("drm/amdgpu: Rework
> retry fault removal").
>=20
> To match exactly with the logic in above commit, I think it should use
> soft ring only when retry cam is enabled. Presently, it's returning
> without doing anything.
>=20
> Thanks,
> Lijo
>=20
> > +	else
> > +		return;
> >=20
> > -	ih =3D &adev->irq.ih1;
> >=20
> >   	/* Get the WPTR of the last entry in IH ring */
> >   	last_wptr =3D amdgpu_ih_get_wptr(adev, ih);
> >   	/* Order wptr with ring data. */




