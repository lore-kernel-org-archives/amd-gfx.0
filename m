Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0148C4829E
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 14:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6812710E075;
	Thu, 15 Feb 2024 14:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BtS1PzwT";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DE210E075
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 14:36:32 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-5c6bd3100fcso666723a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708007792; x=1708612592; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFGUaNc2BwvT264p6miY/X79Zn3N6FcVMUURMpj9Rps=;
 b=BtS1PzwT0bbYPuOcOsyISZrDBfBbZyMNC7OvOy477BN8uMOZ/4Xg/MCIvUmJGzITso
 XE83U1QmOVrQms/nbaz6w/AY7CrYog8KLPZDbWqXdDZhwp8zB93X2YQ1nfviuqy/3me1
 qoMtLljF9gp+5ka05UgdND+I8WelQ6l49h46zyx66RkrKIB5+Qob9dBNAqauac0IwbZ9
 Q538HHKtJ9MHQGWzZHiKgQH4I1mlhcaNYtuiwz3wbG9JZzEfEcn0DoV9TemYT1bv6o11
 0q+TjWIjSQlKxbDyJmggnKMo2Ef6tyqPlV/YXvlellyyx/mT+V1/irqjhT/JajbYaoOq
 J6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708007792; x=1708612592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qFGUaNc2BwvT264p6miY/X79Zn3N6FcVMUURMpj9Rps=;
 b=L1vhggYhUtEO+kIvpLVyYeCTsH2fTUMKCzyjGC2MYXXQLm0hJM7FBYYMK6nTAQ2vIG
 hSYfkF+jUFFWDEKI3YQrodr5y8itrg6KSRDO9DWrQZOVCxksibGMd7Qu46Q8gUo/e/Lw
 pAQnhjEXkWzeS4vlu9A3H5qg/QRNBKG1CvEaBVMm8mTzeLdByAEq+KTGdom63DweXdZz
 sLInxIKEnp6F+hiyl6dPguUdqVa+77TvsisVzk92XPmPwNlXIJ/mgil586QVMzEdETcT
 Wah/PKHcNtK/GxNzet+KPiuYMzfHTq2E+gN0FMD9XQ4NEHU3UOPYquDw2Z+2dnwnuuzX
 Ekfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNmva7I4cPuuOLRcWFZ7v5CO2TlTWjUlhPOkmQbpRy53iBdQPi51vX34D4HYZuEtzHJ320pCR1386MJOndXpgTmb0do0IwoaUZyUvG+g==
X-Gm-Message-State: AOJu0YxlaoD+5JSrABxnnxCiy2PgN6TRJj2vS+IzJHiCYRfyF/O7pgMl
 2jDIK4i4xGCb5Vcp8GbLFZT0ppuzNGO4X2hwCSGaPgc/dCM9ZYoJ1XYYy6Mqiw4Tj2INck/zM7G
 otwl6K9t63w1Kcv3IwTmFBYOYIWoAWL1J
X-Google-Smtp-Source: AGHT+IFdbPG4fasZpxzyjUcZyPy4pjrktxeMaPesL0F1OTkVZX7PHpPF6MG8AFOcMwcvW7ZamLUN5a4LUTffO6gc0YA=
X-Received: by 2002:a17:90b:1993:b0:297:eca:8381 with SMTP id
 mv19-20020a17090b199300b002970eca8381mr1885914pjb.16.1708007792242; Thu, 15
 Feb 2024 06:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20240129155621.824237-1-alexander.deucher@amd.com>
 <BL1PR12MB514476B2675A7FEA612D6473F7482@BL1PR12MB5144.namprd12.prod.outlook.com>
 <55944c59-2943-4557-ad23-eff38b548383@gmail.com>
In-Reply-To: <55944c59-2943-4557-ad23-eff38b548383@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Feb 2024 09:36:20 -0500
Message-ID: <CADnq5_NtabnxNXA50+W92k-4302B=tazjhxzGDnp9or1uZmAkw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Thu, Feb 15, 2024 at 2:53=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Well using this is in sysfs is a bug to begin with. This would prevent
> starting new applications and crashing applications which don't expect
> to get an -EPERM in return here.
>
> If we need to make operations mutual exclusive with resets then we need
> to take the appropriate locks and *not* work around by abusing
> amdgpu_in_reset().
>
> The functionality of amdgpu_in_reset() is just to check in lower level
> functions if we are inside the higher level reset thread and *not*
> protect anybody from concurrent access.
>
> I think we should probably completely nuke the underlying flag and using
> the thread owner of the lock to prevent such an abuse.

Can we land some variant of this for now?  It fixes known issues and
it's the same behavior we have in sysfs and debugfs already.  It's not
clear to me how this should best be handled.  We basically want to
block any access to the GPU (registers, firmwares, etc.) while the GPU
is going through a reset.  Just locking the reset domain doesn't seem
like the right solution.

Alex

>
> Regards,
> Christian.
>
> Am 12.02.24 um 21:56 schrieb Deucher, Alexander:
> > [AMD Official Use Only - General]
> >
> > Ping?
> >
> >> -----Original Message-----
> >> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Sent: Monday, January 29, 2024 10:56 AM
> >> To: amd-gfx@lists.freedesktop.org
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> >> Subject: [PATCH] drm/amdgpu: bail on INFO IOCTL if the GPU is in reset
> >>
> >> This avoids queries to read registers or query the SMU for telemetry d=
ata while
> >> the GPU is in reset. This mirrors what we already do for sysfs.
> >>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> index a2df3025a754..d522e99c6f81 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> >> @@ -607,6 +607,9 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
> >> *data, struct drm_file *filp)
> >>        int i, found, ret;
> >>        int ui32_size =3D sizeof(ui32);
> >>
> >> +     if (amdgpu_in_reset(adev))
> >> +             return -EPERM;
> >> +
> >>        if (!info->return_size || !info->return_pointer)
> >>                return -EINVAL;
> >>
> >> --
> >> 2.42.0
>
