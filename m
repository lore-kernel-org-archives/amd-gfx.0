Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC38C7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 13:46:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA77710E83C;
	Wed, 18 Jun 2025 13:46:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BUEbOfnr";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7697310E83C
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 13:46:39 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-31305ee3281so1187777a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750254399; x=1750859199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/+dJG3F08qnun0OMdrTbLgJ5sErhqNPY1uYEI2qzME=;
 b=BUEbOfnrzliG8sfY2/W5SuZq40OXb+nXDjf8voD93Wz7h66uR4Ks5Is+i2/8gDL/pM
 hRoKzKiv+XZmc2Qf1zX91JqhjEmns/9JinZvTsGgk9GqjC47YH2bxpJrx4x/co96+b1H
 F1lCD63aYnMajpQV18tUCCon2c7kESSJ/QnavRL+zf1x4PjD4ozGOtY2xLt98P+wRtb1
 MVZOUcIZwYFqGeGRbVze0DuB8pgbILwq5sEFIakVk73cJcBrmwITwOS1E/6YFAxJgPVi
 16huqKKSCY3yCEAhpxHODC9IcpE9ZzBBqUzuWLQEMvGAPNKgTvfstv1AtGNhO5NSIwgD
 aqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750254399; x=1750859199;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/+dJG3F08qnun0OMdrTbLgJ5sErhqNPY1uYEI2qzME=;
 b=mntPOPjqSZBXnfGNy8GkENhAteVBFFM2LM7oQyAihKZtFIjMtR3JL1rKqwXUS7ttZh
 gLAEGVJtCLUrBMwz/mF9UrTJ+38SwfDNj+wtPAGmHaeW14EoTtJwauy8lsyCjqL/ZDGI
 Ndo1x2zE/+86GdR05s1bBax/zmmxXQUZ7eTXEkEemCclPuVl+gQCWZacAvrYx+WQyEjm
 T/J2MzYcsaeJi7flk+/GLKHwlAVT/jCcDi8eiCKqutKAS9OO4B8XHMm7cMfx1xEPzFPq
 PLMc180J808yzt9sNP/EvA5y5Kkbv7x1CrftoBsYAZWJF+aTwnbGn0Otujfav4ssStGz
 B2Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI+ozN10NTF8/VMbzhpDqdp6qJWmCiOaegL0l0V4u7kGWww83C6YzOkqnDu1oFEXIRqc0e9Pkq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoBNJjGkIWtSp4w4/lH7IzCMVUAsSqufweJjoEwSIhM3h1A5nr
 JhYNddvRFMUr1CvqULccdWHEkVhqcGRLT3ZWdjnt1jTTskrSwHLsltHKzemzPPhG/9Q+VVlyXXP
 dpV5uDErnA8BEuV0yfIq+Gt+nl+7dr7o=
X-Gm-Gg: ASbGncu73XIWOe/T0R31PgiSMd5Qy2VY/zGJ2Zh6whDL9UGCcuzwA9VeGdsQqXN6Uk+
 amDuiqy3nllx9QGe6Eu93OMW9+MVPm2ix5ZVgKYNe/wo7NXppzx0DlfYYUVyd44utZJ3imLuvVD
 gtRmqctvdzlyveZNVnDVj5VGyZh2OgGEdGSmE92RNv1UX1
X-Google-Smtp-Source: AGHT+IEoQW2OeSeAyDRNiJUchBB0CqO0vV5ktvN4tSpL7lf212CO4qGOnDe2Ls8E7g5FqYb9n2fvkPRcXWH3PlsZ3IA=
X-Received: by 2002:a17:90a:e7c8:b0:312:639:a06d with SMTP id
 98e67ed59e1d1-313f1daa350mr9845839a91.5.1750254398833; Wed, 18 Jun 2025
 06:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250616093945.GA1613200@noisy.programming.kicks-ass.net>
 <4f5f95ff-b97e-41db-b9fd-5204e6581a30@amd.com>
 <20250616145437.GG1613376@noisy.programming.kicks-ass.net>
 <2bbcc44d-9079-4a73-ba6c-e93fdcb9cf6f@kernel.org>
 <20250618085123.GF1613376@noisy.programming.kicks-ass.net>
 <f474345d-78f6-424b-8c0f-584c5f0c162d@amd.com>
 <83550401-b2ae-4165-84b2-4f9343d3d1ed@kernel.org>
In-Reply-To: <83550401-b2ae-4165-84b2-4f9343d3d1ed@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Jun 2025 09:46:27 -0400
X-Gm-Features: AX0GCFthzwPwaWNnNSm3u0xjB-OjoCpV80EBKg2tNkm4wre4xVfxFUZ2xMpsmMU
Message-ID: <CADnq5_MHFgcZokeyRzK8V1Y0qAz20uafR7dYpGvhCPeVvbwRtw@mail.gmail.com>
Subject: Re: amdgpu vs kexec
To: Mario Limonciello <superm1@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Peter Zijlstra <peterz@infradead.org>, "Lazar, Lijo" <lijo.lazar@amd.com>,
 alexander.deucher@amd.com, 
 Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
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

On Wed, Jun 18, 2025 at 9:41=E2=80=AFAM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 6/18/2025 4:05 AM, Christian K=C3=B6nig wrote:
> > On 6/18/25 10:51, Peter Zijlstra wrote:
> >> On Tue, Jun 17, 2025 at 09:12:12PM -0500, Mario Limonciello wrote:
> >>
> >>> How about if we reset before the kexec?  There is a symbol for driver=
s to
> >>> use to know they're about to go through kexec to do $THINGS.
> >>>
> >>> Something like this:
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> index 0fc0eeedc6461..2b1216b14d618 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>> @@ -34,6 +34,7 @@
> >>>
> >>>   #include <linux/cc_platform.h>
> >>>   #include <linux/dynamic_debug.h>
> >>> +#include <linux/kexec.h>
> >>>   #include <linux/module.h>
> >>>   #include <linux/mmu_notifier.h>
> >>>   #include <linux/pm_runtime.h>
> >>> @@ -2544,6 +2545,9 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
> >>>                  adev->mp1_state =3D PP_MP1_STATE_UNLOAD;
> >>>          amdgpu_device_ip_suspend(adev);
> >>>          adev->mp1_state =3D PP_MP1_STATE_NONE;
> >>> +
> >>> +       if (kexec_in_progress)
> >>> +               amdgpu_asic_reset(adev);
> >>>   }
> >>>
> >>>   static int amdgpu_pmops_prepare(struct device *dev)
> >>
> >> I will throw this in the dev kernel... I'll let you know.
> >
> > Mhm if the drivers are informed about the kexec
>
> It looks like PeterZ found the symbol isn't exported; but that's not to
> say it "can't be" if it fixes this issue.
>
> > then we could also send the unload/reset packet only to the PSP IIRC.
> >
> > That might have a better chance of succeeding than a full ASIC reset.
> >
> > Lijo should know more about that.
> >
> > Regards,
> > Christian.
>
> Another idea is to do a FLR on the way down.

I think you want something like:

r =3D amdgpu_dpm_set_mp1_state(adev, PP_MP1_STATE_UNLOAD);

Alex
