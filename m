Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B295C25B75
	for <amd-gfx@archiver.kernel.org>; Sun, 19 May 2024 10:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 444DB10E0CE;
	Sun, 19 May 2024 10:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GHEoCR+q";
	dkim-atps=neutral
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26E910EF06
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 15:31:36 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-43df751b5b8so6106871cf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1715959896; x=1716564696;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k7megH/H2PCv2+j9G389xKdUzN7SbYmctbozhmOjrak=;
 b=GHEoCR+q0xBXL4qm/k22EsxjJ1Yh+7n0UHuXBBDrPfn6z2IL9snl7LRK4A06DUAU+P
 Nm+y9kTbpu5EbwaC5L/VxbNbFQIYoha8um0Pm0MGZuKIw5YBHWc9C0Wz7e8BnZoAcViR
 bjwotxltOZAhWnpJNvXhLT4UtB3ii7EWU0P4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715959896; x=1716564696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7megH/H2PCv2+j9G389xKdUzN7SbYmctbozhmOjrak=;
 b=BHkopW2m83w5G5A25KLd62KYEWc02dQmupnYeniNxz9PlFOIOIjC8xTgWz0xhKYKt+
 ldWdtK16pJ8DmOY+YH76xkZ3lV/0fGsit4m5jaze2rFJM6iHbJe6olUisiI5n+PJS1IH
 8LlNMEX373XHC1jXjEpjRzuT04cw1dqURRdjC4IPFhi39X6uIUx4WleW4wE1lA3E1zOm
 FuVVkEM1LjS+YK46ITpCD3/o0EVi8zt1UWaBe/gwd4bWd4DJDQtxZQZGqi99Kl97Imcm
 3+XE2O6cRM4kr2nvqUe5BMB/F+dHpwxCmK9P9S55G+eFlNiyuH1UeYpxf9O1tX2jpzVV
 ldMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0H+0i8hEikNFdiphLGBE+8lu1DPTxC6wRD745FpU5hV1PlnB/GXH52/FIJJJ7CkdGfR4tBWIVXHqzKtLePN9nhBMLtGOdWFDm5qP0sQ==
X-Gm-Message-State: AOJu0YzglAIiCgFXAUS0jzUeFUy2ge/aB+VGnJPitX/ObNmUuWVxbBTz
 CBQpMiwKRujGkyO8LQkLj/HBYx4utkD4hbu5MyWF+geJgl6aXooO0DgQDsUlhdCsMOO9wWN/4zq
 O7a2vj7g11zfGvNns2GVbcAnjFKxzcrz1jI4t
X-Google-Smtp-Source: AGHT+IGhcIgFiNUmswLwDNFrEyhlQEYmVuB0KuktpQFJvPdoeuKAcVFmkHhvUvnReCh+DA3a2Vh8QYXmcY74cB7LSJU=
X-Received: by 2002:a05:622a:1109:b0:43a:699e:114c with SMTP id
 d75a77b69052e-43dec39cd25mr388192291cf.31.1715959895750; Fri, 17 May 2024
 08:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240516115721.1.I8d413e641239c059d018d46cc569048b813a5d9b@changeid>
 <9dd1cfd1-fe13-4434-a7cc-e14113dcaf53@amd.com>
In-Reply-To: <9dd1cfd1-fe13-4434-a7cc-e14113dcaf53@amd.com>
From: Tim Van Patten <timvp@chromium.org>
Date: Fri, 17 May 2024 09:31:25 -0600
Message-ID: <CAMaBtwFTBp-oAMLD4BKgrxQrfvWpJ6NbWBpyoLXeaqg8ebLGaQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove GC HW IP 9.3.0 from noretry=1
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, alexander.deucher@amd.com, 
 prathyushi.nangia@amd.com, Tim Van Patten <timvp@google.com>, 
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>, Le Ma <le.ma@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Shaoyun.liu" <Shaoyun.liu@amd.com>, 
 Shiwu Zhang <shiwu.zhang@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 chris.kuruts@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 19 May 2024 10:46:43 +0000
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

On Fri, May 17, 2024 at 12:35=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 16.05.24 um 19:57 schrieb Tim Van Patten:
> > From: Tim Van Patten <timvp@google.com>
> >
> > The following commit updated gmc->noretry from 0 to 1 for GC HW IP
> > 9.3.0:
> >
> >      commit 5f3854f1f4e2 ("drm/amdgpu: add more cases to noretry=3D1")
> >
> > This causes the device to hang when a page fault occurs, until the
> > device is rebooted. Instead, revert back to gmc->noretry=3D0 so the dev=
ice
> > is still responsive.
>
> Wait a second. Why does the device hang on a page fault? That shouldn't
> happen independent of noretry.

No idea, but hopefully someone within AMD can help answer that.

I'm not an expert in this area, I was just able to bisect to the CL
causing the change in behavior. There are other reports of people
bisecting to the same CL, so this issue appears to extend beyond
ChromeOS:
https://gitlab.freedesktop.org/mesa/mesa/-/issues/9728#note_2063879

> So that strongly sounds like this is just hiding a bug elsewhere.

That's entirely possible, bringing the number of real issues up to (at
least) two:
1. Why the page faults are occurring to begin with.
  - Any video of size 66x2158 seems to trigger the issue.
2. Why the page faults result in the device hanging with gmc->noretry=3D1.

I've asked prathyushi.nangia@amd (chris.kuruts@amd may be helping as
well) to look into the page faults further, since they can't hang the
device if they don't exist. She should be able to provide any further
details if you're interested, but please feel free to reach out to me
as well if you have any other questions.
