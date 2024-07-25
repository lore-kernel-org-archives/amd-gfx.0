Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EC84C3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 20:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C23210E730;
	Thu, 25 Jul 2024 20:42:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZvQHIykD";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3252310E730
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 20:42:37 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-a6fd513f18bso113395166b.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721940155; x=1722544955; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/IW+DKBY8uoSbYHydOelJe9J1W7btZ+kDmOih44jr4=;
 b=ZvQHIykDgDswlTusJMO/jVSr1owlOxsfD9YDTCeNMPTITq+huCN3vlH9W2Bv4cvtEm
 eMbtjJThKxXSUxIAdqkJTIZR0zcQWgiqK6Kc1Gie1oEWQJHyJVLS6dy38fXXhUqJOB2J
 P46fheKhL/R8Eo8Rai7MfZWHw+mbnyyz5JqnK+gEb2ArVOlYJTlK5VgiVizd2HdVZSdu
 EaCT955znJwLC6U1GGh8C0YYsqKSoExzv0kvN11rsEKG3i0A2+DFR0wvIAd99dSdbdip
 CK3SoTj2F3lubkX0+HkXnskrVG2ykeR6tv4jdjAX2y3WCvb+C8IdjbDJmn96sUEsidgP
 LEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721940155; x=1722544955;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/IW+DKBY8uoSbYHydOelJe9J1W7btZ+kDmOih44jr4=;
 b=eqI5xZ2W83/cfWcVVnnraJ1uEnnrXVGyL5Ci4mP+Xky1oZkVePb2E68an7bUlI7uJr
 YNMluE+zS9R4LjjN3HIYvrMeVRrS9lXGEkjVEmuM967s0ai7bzILPmae7Qd79x/ixgmf
 o1laacYLEbYKWYcHzwnXKxQss93L+jxwoctdtevMboSZIvbptdswMiQIeFSbJir94MyA
 /Pe87joG7aSMGBoK2sbDDTdz1qdMqW2sYrRhIaqW+1gzIXh9C9qcermdvGmeab+FyGRR
 JQZaxwVJ1iOunBpagAfN8Ct+71yCVmBvhZguoxXpDhyO1Q+1LOa1W8TvV2i/t0btPojd
 2JwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBnG0gL7uKLliZpcEQUcct2MtZ7dDPtpNW2sEmY1ndE1TIjD4iyjQidx30mpLuY0EYpN5IHiAtqu3kpFUELITgcWm3r98OlEJTfTHLDg==
X-Gm-Message-State: AOJu0Yyk10+wtK9fz1sR1XDy9MwfQSCKM2+gh9f361uSQ6Nq5yh8IiTH
 G4oYK83+waUZufketaNqrmQgk9iCUdrWwP2ETNr+s3pVACEpz5PWtN0CEpXQfRo2IOEMQ5ySreG
 UJeHb09PlbRQ97kZSlhZ+P7p9CnJGpQ==
X-Google-Smtp-Source: AGHT+IGCVQ9EK+t7BarR3zwDkL43Loc6zYTxYtmvkClVwuU02sRONnMO2Q1hugarMXyC838hOVWgYY+ODif29Mh1Z9s=
X-Received: by 2002:a17:907:9403:b0:a7a:952b:95b1 with SMTP id
 a640c23a62f3a-a7acb411eb7mr243184866b.24.1721940155086; Thu, 25 Jul 2024
 13:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240725080750.183176-1-christian.koenig@amd.com>
 <CADnq5_Of6-Lm-riL_Ea7DAwpjHmaFrmfCav=x0ukLJseP5NFHQ@mail.gmail.com>
In-Reply-To: <CADnq5_Of6-Lm-riL_Ea7DAwpjHmaFrmfCav=x0ukLJseP5NFHQ@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 26 Jul 2024 06:42:23 +1000
Message-ID: <CAPM=9txZ-qGE1EEVnq0xXdD3_z5E-kpjs_JCLQYJO-UrHnLEXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix contiguous handling for IB parsing v2
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 amd-gfx@lists.freedesktop.org
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

On Thu, 25 Jul 2024 at 23:35, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Jul 25, 2024 at 4:07=E2=80=AFAM Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Otherwise we won't get correct access to the IB.
> >
> > v2: keep setting AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS to avoid problems in
> >     the VRAM backend.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3501
> > Fixes: e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour=
")
>
> Cc: stable
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Cc: stable@vger.kernel.org
Tested-by: Dave Airlie <airlied@redhat.com>

Dave.
