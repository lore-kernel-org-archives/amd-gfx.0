Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E87FC46467
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 14:26:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811DA10E3E7;
	Tue,  3 Jan 2023 14:26:29 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800E210E3E7
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 14:26:28 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-12c8312131fso36925087fac.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Jan 2023 06:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vgc3L3SAVK7ZDb23iyfbs4/1bfac6Gax8LKVG/zrdlk=;
 b=ZBY/KSR9RXBI+DzDGpLN/8zM7hlJthaeKhRYNKpgWMRZRIwK6R03Krn/X4LBhmO1Jl
 G2YAyQGz3G4U+TVCIVHFYd0wOlT8eKcfZmvaCGhST97JhQAT9eDIzsRdWhqiW0bRrhOw
 Ycmibexc2UTTKZZJNIvpXoEL4z+VgV/9tziGZLmeW0OO0V/exu+hShbpyBGXPvJqWK9w
 CvHKt6OdWQ5BPB7wggfz8xg1FbEsPASd8nxbHn43WHq9PfJ8KpGjgj/zVhlLbHOvY9Xr
 RYnh7/MZkNwktC4e8/3G0MNZudA/vEFMGciJlE/Su8JzTETcgIyZNP9DdAX+Ynq1ZFDZ
 ysaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vgc3L3SAVK7ZDb23iyfbs4/1bfac6Gax8LKVG/zrdlk=;
 b=zW6J0TKXwLkZIWxKdHI1EhazH0xNJxyykBRKm4A2Jt55ohuqIfAXPqUmdmGyJpteWF
 64W7BVh6pVf5vYvhIxk4jRS23uYL88YA5ZytAcYhoRc4HZEfupqxSvTWo5W08qR5ghMB
 BENVBjHD0yjRBSaY8itY7WZCgdQQUvGMhD9Vqv9sMac4B3XpilzgFd/DZn/mHA8Poqwg
 ZW6IFRycgqo2BIG1ooxe+B1kEc+zu08fBURH6inh9owM0760g/Naa7ce6XQsBLMS2XB0
 5JX4Bk/t1/pJUGR/pkfGDXuz/Hf1v9aEJtcTEWB7PG19WJf4CLzwiH9dizslqJFgB0nX
 KlYQ==
X-Gm-Message-State: AFqh2koYuFH3K5U5NBImRP9ekOW9OB3wmh0bdEgQabY6V4ylDyigDXj8
 AjRliAxbUq48OSgPtCKLAfOCRXPpIRJpVVbraLI=
X-Google-Smtp-Source: AMrXdXvE39ESEkudRk+hOljZ9BddvUx6yPileS+knUkWXc32PG5/Xe1nCZquLhT0RcvUUhTeE4WyQrlx/WHD9wDk9lE=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr3615161oaq.46.1672755987680; Tue, 03
 Jan 2023 06:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20221219104718.21677-1-christian.koenig@amd.com>
 <Y6BuZ2jv8n9dEVxS@zn.tnic>
 <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
 <7275efdb-4d22-eb76-cea3-333391472853@gmail.com>
In-Reply-To: <7275efdb-4d22-eb76-cea3-333391472853@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Jan 2023 09:26:16 -0500
Message-ID: <CADnq5_NxbAgF6sXF6HuGzgcOoY8QOHU-0d9ghuKarx0jpt3Vog@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: mikhail.v.gavrilov@gmail.com, michel@daenzer.net,
 Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 3, 2023 at 3:34 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> I assume that this was already upstreamed while I was on sick leave?

Yes.

Alex


>
> Thanks,
> Christian.
>
> Am 21.12.22 um 22:10 schrieb Alex Deucher:
> > Applied.  Thanks!
> >
> > Alex
> >
> > On Mon, Dec 19, 2022 at 3:01 PM Borislav Petkov <bp@alien8.de> wrote:
> >> On Mon, Dec 19, 2022 at 11:47:18AM +0100, Christian K=C3=B6nig wrote:
> >>> That function consumes the reference.
> >>>
> >>> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> Fixes: aab9cf7b6954 ("drm/amdgpu: use scheduler dependencies for VM u=
pdates")
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >> Thanks, that fixes it.
> >>
> >> Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
> >> Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
> >>
> >> --
> >> Regards/Gruss,
> >>      Boris.
> >>
> >> https://people.kernel.org/tglx/notes-about-netiquette
>
