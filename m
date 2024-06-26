Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE321C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 14:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97DE410E6D7;
	Wed, 26 Jun 2024 14:00:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mapRFX90";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AFC310E6D7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 14:00:03 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2c70c08d98fso5316932a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719410403; x=1720015203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCldR24CpPQsghSr5m/Lvfwnm5ubPmeRHEy6d4yNV4s=;
 b=mapRFX90Vz2+ErlW2ZNr1dSfU5WNa9AuCihXF3TKtVPicX7gQ68qNnRn1myapjFmyC
 LmdhZ+CdKl8jKYqJx5JqTGzbE7lH1cmR/MQ5hUJab3jZ269dVxfRn2f2tmj26PyddTYJ
 R2XRIly6vOsHTpJBYlviVWi2glxHGDuVEBvJPdmSy151jp8a510G/Ix4bC4ugu3efR7X
 r/o/aLeo2eQpD158hPz9HHysGcsscwXfKNMcBNpX9Yp7fk3puMgpK+pQs9uRVqWF4uWO
 50l0lr+Zf1TuesZDbG1P4/SsgkHE8jzM7K3HEC0OYZLL7bDsACAvVi2MHoIJ7IH2fqE8
 yq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719410403; x=1720015203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nCldR24CpPQsghSr5m/Lvfwnm5ubPmeRHEy6d4yNV4s=;
 b=n3fGYdO+clXL7PCy39TdmUEmhfzL6i3VT12jHcjL+FZZ1iJ7RVXI/kJkCc6aImMkFU
 XHB5kvo8c7VGJGyaNLkVfLcGSMZH+9FuDMJg+WfGYhRBAftJQYZ624DAZm2ZLhRnq2ei
 8iv5CoQphTxIj4HQSmYnslfetgNuXSlPhAglSCB9aLob389w0dlODFq552azdCK8+Vky
 ID2DsJNamxYG/HseB4b4N5wFanMqUFmisRpQs4bE40VeRw+D7pZnIqsPGNbF4cFQ2X/q
 i63lGKCMtLxu1DJ4BXKtPvB5sJum7anUjIXXd2vSv5Io/cm6m5cbHCwyTT+MKFPrgK+F
 isLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWxITaAsFW/qEHxeKj+dBDtN32GpCOmOlIoMDg2IoJg6Dnh8/UHKzeb/Eb8NUdKodE58izkNLUhOLglwMB3uWjFA44TfoChLZ5XVsYoA==
X-Gm-Message-State: AOJu0YzPn3tliDohTOD965dnMimrxxpJmfM4jIi1buYP5kaU+smRBk/l
 4uRE6ZSuMvKhMNuKwxDcXkYwyJRESeHPz1jmH3zn8TwhgPkN9gkaaEaPodKMJ9k078HP0vKttJ8
 IxFl6wcQSxC7NTmWXQ6Ojhg8qs0Q=
X-Google-Smtp-Source: AGHT+IECwEV4lXbGVbY8jvF/tUQcyK0flqZz0koUeEluRoRWI3+OGkYza5W5DBXrtEdEdBAcsTC8VdnzYKwVwRi7bX4=
X-Received: by 2002:a17:90b:1bcc:b0:2c8:aa0:d83 with SMTP id
 98e67ed59e1d1-2c858199a7bmr10913511a91.9.1719410402497; Wed, 26 Jun 2024
 07:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240625142418.156810-1-pierre-eric.pelloux-prayer@amd.com>
 <CADnq5_N+ofUFOWhDvKkWSy2zXYMHaHHD0m63hAPLs4EG6mTVzw@mail.gmail.com>
 <e18a1ebd-1c19-4dd0-aa59-1e6dee593db1@amd.com>
In-Reply-To: <e18a1ebd-1c19-4dd0-aa59-1e6dee593db1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jun 2024 09:59:50 -0400
Message-ID: <CADnq5_M8+qPhK57bywCv5=PTd0TC2YYL05oCGfLd6h3AwgE6eA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/radeon: check bo_va->bo is non-NULL before using it
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Wed, Jun 26, 2024 at 6:54=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 25.06.24 um 19:44 schrieb Alex Deucher:
> > On Tue, Jun 25, 2024 at 10:32=E2=80=AFAM Pierre-Eric Pelloux-Prayer
> > <pierre-eric.pelloux-prayer@amd.com> wrote:
> >> The call to radeon_vm_clear_freed might clear bo_va->bo, so
> >> we have to check it before dereferencing it.
> >>
> >> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@=
amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Should I push this to drm-misc-fixes or should Pierre push it to
> amd-staging-drm-next?
>
> Might take some minor work from you when you start to handle radeon
> change as well.

Does this depend on anything in drm-misc?  Otherwise, I can just take
it via the standard channels.  I already handle radeon patches via the
amd tree.

Alex

>
> Regards,
> Christian.
>
> >
> >> ---
> >>   drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/rad=
eon/radeon_gem.c
> >> index 3fec3acdaf28..27225d1fe8d2 100644
> >> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> >> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> >> @@ -641,7 +641,7 @@ static void radeon_gem_va_update_vm(struct radeon_=
device *rdev,
> >>          if (r)
> >>                  goto error_unlock;
> >>
> >> -       if (bo_va->it.start)
> >> +       if (bo_va->it.start && bo_va->bo)
> >>                  r =3D radeon_vm_bo_update(rdev, bo_va, bo_va->bo->tbo=
.resource);
> >>
> >>   error_unlock:
> >> --
> >> 2.45.2
> >>
>
