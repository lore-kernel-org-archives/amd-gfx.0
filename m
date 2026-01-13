Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00AE8D30CC2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 21:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCF710E554;
	Tue, 13 Jan 2026 21:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZUX/+u3a";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F56010E554
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 21:45:58 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-11ddccf4afdso599880c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 13:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768340757; cv=none;
 d=google.com; s=arc-20240605;
 b=eYk+QRgfFlbT90xuVykOups8pPUErfTpH2HJ/JotZq2Mbhxf5rj9sbEbnHowE6FKaA
 +5a7IaMbMLx4XY7s9+hnAMTvLuWPmwzNjWYbZrprWhcQrG+ymv73vPd88x+4mNezSJsg
 HEqMiW8hqMASpyM3g4uRj/HhidOiezb0LJfjOB9zHGK125JzckVVYcogN2Ic9b7aoAVe
 Lf5Lj4zNAgEMaHG12/gJ+3dEvIvzlnQF9PAOnbsSE/Mx7fR86+Cg7anSu5PUe/7tf7Pa
 pxNeKnaCNa7s2Um3c+EGD6efM8zekSWaOLJLWCpvVoew3f2orY1C/w9d8xgWNhXC0qFo
 gjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JXdYC4zDBcnajwvj8nPar9Esj55mdAw2r8xz40Hsc3o=;
 fh=1BQ4rCM0JLUCgEPOjwKA/tl4LXSw3ngXdzfmDsqLWig=;
 b=blF1HfMSRWDa8dgyX3aw2Ml82Az98Opbjge2ROUe+CYbnv0E5wfPWXG1ytGwpYRSZ+
 GYkAOtVOd0i6wnb5KbvJlf3gx4TvLikyFT5VLkpaUfWnroe7AvzcR/YhtpifeN77PPUl
 1Y9Ju4OaF1GFcmIuFMrL9mk6c40tvb2N7q9nahYqMdGduU8+ck3qkJaJc44+cEWv9ppJ
 dj6f86dVMmHcQVuGZ950Mp5C4K3mkYQJbAYNCcFw8yqxPFui1zwVYwaIrP5ZPI/5TWsS
 Lt9aENbrB5e47cEErWWktrxBdAvLiP7aDWaJf9wDRhKSRXutVk9vmMj3Z4XEFle7KVDi
 QmoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768340757; x=1768945557; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JXdYC4zDBcnajwvj8nPar9Esj55mdAw2r8xz40Hsc3o=;
 b=ZUX/+u3a2rwc8zURhZedi5ftwgsnw5UQdhEQQeeC4OjOUtCR7ROV67Ykmv4GiEVhGe
 7/+NTIcPRIqLwN7Z6X7N1SFDnagwduRZnxmIDLw4EqBygTj/d4iCGkzi9HZEZ0FcSlXT
 Tn8vxgYjeOQuJW0w424eVFVQCaGyOCFPO1uhSnzLFPI24YKxi4dE4Aa3BiLXJ8/Nmfu0
 YH3CAC0fCFHIARvcoSWi79Td4M40H4f85UnfpCcoPdmSwQMVE1UocjWid9TdEjHrQMYC
 Dda7w2aavoLrj39GCWbFecYS8VNDCAsIW5v/ZJUXOTG8EoiR66ac2DaqiPB8UPPhVJRF
 3sMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768340757; x=1768945557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JXdYC4zDBcnajwvj8nPar9Esj55mdAw2r8xz40Hsc3o=;
 b=cVgfIAfkAmj+b49SRLanAJZSd3MBEibU3dcoFJhbxCFSJyMz29opm3iZxRSHtNSzjR
 APjv/SOgFRjazd83KfEXexac2wi4I6dCGc8VVHhfJYGjw13GiW3OLwcglxdbPDucp+Om
 OySJCIpgFOUHALpSJR9regXjGjJfn7TRVA5kCWTP7fH6NRZOemgf2LughIP7xylbWaSC
 1x6LnmTiUAPqTUDuqTAl76C+6qaV243ntCo1ZU2Dno8zVWmo1QLUKuSkKqLAP48n5guB
 Cn6m9/tVV+95uws7UpHC4e6vaLvchF/vciLVfzqFXhhgTp1vkeGUqHTBmXuMdg+j7OwJ
 cicg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwY82L57AXzAd0eA4rhDI+Dq/xHmWYQkhloQpmJ0SBQcd6zhQBjKuE971ae0VcFCDeVSuPj1IP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAX8fCIz51IuPTSl6Z72IQxuEjpW0CpaK6CkMke3zO1KWCqRbH
 OzLTZ2VWrpveYHcAGzkRwtKZnYMnBKoRCN//Si4UgUv9M9B1TfbGfmKX15X9mxlrJgsBT96w2ai
 3qPaff4zRj+B9HI0a9h3yI27BcYsae5I=
X-Gm-Gg: AY/fxX6Ok5OEOpFGyJHNkspC06JzlQrXCsu42R093SDDhOKBrQkPF7at4I5lkV8FHRH
 HvylkrDPk7+0Evqb7lFr2UXzdERd0i7OIbGoHffpL/xFiMl/K2EpWtANKWkw+oncqhxD23uqzea
 RDLSyOVcdhKCpSeyhS016JSs6MAjNtuzr5ioL12MeFBVY24Z7pplB7/DBbImfJVhql57yXzryFJ
 z+po7KDlmqc/vGuCuUxTM6I6TN17miw7D0HKvjFo2bc+5p+C/Z5H6Y+poIF9cCerjnTTEvJ
X-Received: by 2002:a05:7022:7e82:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-12336a94480mr195815c88.3.1768340757484; Tue, 13 Jan 2026
 13:45:57 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <20260108144843.493816-31-alexander.deucher@amd.com>
 <0426aa4f-869c-484a-b057-a4877fe3d26a@gmail.com>
 <CADnq5_OA1+hpGFUd1=5sorUKjCK0hYcNPoZR11n+6D67NycjQw@mail.gmail.com>
In-Reply-To: <CADnq5_OA1+hpGFUd1=5sorUKjCK0hYcNPoZR11n+6D67NycjQw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jan 2026 16:45:45 -0500
X-Gm-Features: AZwV_QixMj6wdz9IYmL0mL11gCkJqxE-0b0kOTkpHt01owY8b0njJLdBZeh1Et8
Message-ID: <CADnq5_NxXQbiYPaaqik2-=v=F_AduVqcp5V8S1V+rzQWmzaycQ@mail.gmail.com>
Subject: Re: [PATCH 30/42] drm/amdgpu: drop drm_sched_increase_karma()
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Jan 13, 2026 at 4:27=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Tue, Jan 13, 2026 at 8:42=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > On 1/8/26 15:48, Alex Deucher wrote:
> > > It was leftover from when the driver supported drm sched
> > > resubmit.  That was dropped long ago, so drop this as well.
> >
> > We unfortunately still need that to update the guilty flag in the conte=
xt so that amdgpu_ctx_query2() works correctly.
>
> I don't think it matters?  We don't call this for per queue resets and
> the errors seem to make their way up to userspace properly.  Maybe it
> would be better to move drm_sched_increase_karma() into
> amdgpu_job_timedout() so it covers both queue resets and adapter
> resets.

Calling drm_sched_increase_karma() appears to not do the right thing.
If I keep it in place, the context always shows up as innocent.  If I
move it up to amdgpu_job_timedout(), even per queue reset contexts
show up as innocent.  The behavior is better with it removed.

Alex

>
> Alex
>
> >
> > But we could change the code in amdgpu_ctx_query2() to check the indivi=
dual entities for error codes instead.
> >
> > Regards,
> > Christian.
> >
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> > > index 868ab5314c0d1..c9954dd8d83c8 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -5808,9 +5808,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_=
device *adev,
> > >
> > >       amdgpu_fence_driver_isr_toggle(adev, false);
> > >
> > > -     if (job && job->vm)
> > > -             drm_sched_increase_karma(&job->base);
> > > -
> > >       r =3D amdgpu_reset_prepare_hwcontext(adev, reset_context);
> > >       /* If reset handler not implemented, continue; otherwise return=
 */
> > >       if (r =3D=3D -EOPNOTSUPP)
> >
