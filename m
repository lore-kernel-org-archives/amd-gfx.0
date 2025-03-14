Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44751C28B30
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 13:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D57F710E9EC;
	Fri, 14 Mar 2025 13:12:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mH06avv5";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7480510E9EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 13:12:13 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2240d930f13so4487055ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 06:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741957933; x=1742562733; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=us71VI8rB0Legg4D3O1G/8ku8Dl+rOdqgBnf5AamEhA=;
 b=mH06avv53YmvCMkgzwoz2eiMT6kwP85uFZsyDoMnVrT5w9MzvW+kz+xrae5YX8vY6k
 VuCkZ8SlQjETAwlbpHvl0DN196zkpovKPLPuR2v0FgUlB3B5Nx0OXe7pFO9IsTeaiscA
 0oMz/EyQaVlC4WBXGAo6L/scj/tUkojPIDydhXBg9XstGpgV6gj0Z8Z0JjESKlch1xqf
 pLWW7+RviZ/0AabIZVbRYdXl1oYLSCdVV+cY7eGC0hVZtD8w3vPy4HX8aU4Dc2TXwdA4
 XBGBxhdQU8qHtCQ02CCyLfYGdSPE4QaIVyD5mdiJ3WJnuSPaq5cXwB85UkNFPNdym/SH
 tEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741957933; x=1742562733;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=us71VI8rB0Legg4D3O1G/8ku8Dl+rOdqgBnf5AamEhA=;
 b=KEQbcXWX/nMBHBq6+stjCEMzzRg0E4tgqw8iIY8ZIim02HjRRCG1tbTwpQr78voQY7
 KAkJLV4e7y5tdjTZzkcYQyq0+u6VX6FegwewYDui8ATvlMafgKUhN7aaclfgXGdWk5lZ
 Ql/a65pOHB9gFMGRxj9gHMirt6dxiVwMMkYkwJ6eR5ucbkOxiPvCWM9EFAJbnjlnaSz9
 AExN1IT+XfIxAyt8kf95oj5CCqW7pXpJbdYbIXEJ+tE88klT5susDYLSCPR4CqqYbkrK
 lOzsxDepOwyD7SyH3IY093CzUCUK8kIuYbv+xriL9meh/qDjDxs/+1k8BjQBIkb5yOKx
 seSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYZmb96YwpHIztakrp83hD2zzBFK13ecJGPfSiGlprYRY3aogeywPoS8kRAdXoSo7PMqqS/gTi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJ1+VQZMmq4hIAPBUbwe05y5S+X7RSdo2Zbrymt9EZYBhNAkLY
 BsBOHmWYOSpLF9npSe3vr6JM16A3WhuINpI8eBPkYXv424Na9DifpoP0sQyAYI0CtnDA0jj3BjV
 jRpwzE2dPEgRiwX4pWUEsIaN089E=
X-Gm-Gg: ASbGncvBqBvVN0iQggZsyhU5CBLM3pUxQdU2oT3RN9yYe6AJVQRW1ZuL+EqPWG1Cucd
 NT+jfC+AgmzTnk6qM2AtkQbM0tiKbTbmMynBPCUaRBb/CgA3l1kuJVHxvCM17jBlfjDWcR5yH8v
 7l58QkYychUX3OOV8GO8Fslwq+HQ==
X-Google-Smtp-Source: AGHT+IGn7iFBbjLVbF5uD1Bl+O+ELfJWqW5/gdbzYIvLmDPZkKiCZ0MqhutzzC6HNNXL1d+rOgfnTivubYL5pcSU8LQ=
X-Received: by 2002:a17:902:cec3:b0:215:435d:b41a with SMTP id
 d9443c01a7336-225e0a1d656mr12644975ad.1.1741957932906; Fri, 14 Mar 2025
 06:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240718210558.26340-1-Philip.Yang@amd.com>
 <20240718210558.26340-5-Philip.Yang@amd.com>
 <zpzehsckjz2bee6w5bsnfpmkvtlxf6jywijz7iroausghoh43i@nxr644rwjsb3>
 <315e27ab-f1d1-a681-a32f-1fc28cd81193@amd.com>
 <rie1puzeus5.fsf@faulbaum.in-berlin.de>
In-Reply-To: <rie1puzeus5.fsf@faulbaum.in-berlin.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Mar 2025 09:12:01 -0400
X-Gm-Features: AQ5f1JpvRZFPmApVishFeHO_TGlueDyNSqN_p6gXt_cZSBDpsiMuq0wh-u93KBI
Message-ID: <CADnq5_OE75bJvDwZvGo2BhFCm4TzuarQkv9ypGf80O2M9inXYA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] drm/amdkfd: Validate user queue buffers
To: Dieter Faulbaum <dieter@faulbaum.in-berlin.de>
Cc: Philip Yang <yangp@amd.com>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org,
 Felix.Kuehling@amd.com, 
 Alexander.Deucher@amd.com, christian.koenig@amd.com, 
 regressions@lists.linux.dev
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

On Fri, Mar 14, 2025 at 8:55=E2=80=AFAM Dieter Faulbaum
<dieter@faulbaum.in-berlin.de> wrote:
>
>
> Hello Philip,
>
> Philip Yang <yangp@amd.com> writes:
>
> > On 2025-02-12 17:42, Uwe Kleine-K=C3=B6nig wrote:
> >
> >  #regzbot introduced: 68e599db7a549f010a329515f3508d8a8c3467a4
> > #regzbot monitor: https://bugs.debian.org/1093124
> >
> > Hello,
> >
> > On Thu, Jul 18, 2024 at 05:05:53PM -0400, Philip Yang wrote:
> >
> >  Find user queue rptr, ring buf, eop buffer and cwsr area BOs,
> >  and
> > check BOs are mapped on the GPU with correct size and take the
> > BO
> > reference.
> >
> > Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> > Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> >
> >
> > This change made it into v6.12-rc1 as 68e599db7a54 ("drm/amdkfd:
> > Validate user queue buffers"). A Debian user (Dieter Faulbaum,
> > on Cc)
> > reported that this change introduced a regression using a gfx803
> > device
> > resulting in a HSA exception when e.g. darktable is used. I
> > didn't even
> > try to understand the problem, but maybe one of you have an idea
> > about
> > the issue?!
> >
> > Try this patch
> >
> > https://lore.kernel.org/all/20250130000412.29812-1-Philip.Yang@amd.com/=
T/
>
> It seems for me, that your patch isn't applied in the mainline
> kernel.
> What do you think, will it once happen?-)
> Is it falling through cracks?

It's in drm-next:
https://gitlab.freedesktop.org/drm/kernel/-/commit/e7a477735f1771b9a9346a5f=
bd09d7ff0641723a

I'll cherry-pick it for stable next week.

Alex

>
>
>
> With regards
> Dieter
