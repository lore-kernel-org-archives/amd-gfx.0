Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FAAD1625B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 13:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1540710E2A2;
	Mon, 14 Oct 2024 13:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hH+7DY9w";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5661C10E2A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Oct 2024 12:59:59 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2e29497f11cso847993a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Oct 2024 05:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728910799; x=1729515599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAMRWz6Ni06FH5Y8K1vQ9Qj2l9tEBktBQKcD7nmm0Is=;
 b=hH+7DY9wSyDuLD/cWf1kH9kIh12kP5YR8wSV4mZJO0/sc9++nlheHL37C/w/6hWVhx
 XS0XD0JxNnPH4fTg6O8znn16B9hrGUoL2SxszRsgzPMcgNfkZcy1NELmHZSs45KS3v0Z
 zfih88fyvs3zBy9EKwyZRWh4GfScDEZLlHbT6uaE4Saw7IhkjGCcQoWrbrp4IwhnUgIF
 ZqjvF+bRnZ37GSlvabYgbmfkCTq75MW+ZrmrzmqLd+QIJVVZXUige8+KwDW7Ue2ZZqi7
 3ACEIlEcEiJaP8cjfortAM6c7Zy0PsuEfxDSbszBkZuA6oeQgY/rNDvREFY6huNEsQ5f
 tm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728910799; x=1729515599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wAMRWz6Ni06FH5Y8K1vQ9Qj2l9tEBktBQKcD7nmm0Is=;
 b=X4Ub5k+dahgqPRBjqsUr5C0I4z2BEaynUHrigV1+J2umhFBuYxpDQyAlfj3QnfZKVi
 yNShprwyszfXihAeZFIwZq94bn+AtagsEy1yLyl411Uc6auIOZXeKhr6pTVSPka90ZpY
 gHPfb3qxfUzmo1p8zHBaeUvvnYIIqGjwG2Uont+812V80bU12j+G5OIMCPKZH+4Z6qB4
 F6qTMFeI2OmmVd6Z52E0KWX/PGkRnSdOilMliIrbT5Xi8loUUhYXIkq27rClqeUgLaKy
 s04BJZONH9dk1htYzSDfyrxccizSuAUm4FBtxsuoGkpcSeeQY9lSuqi+UVnx/0Fl7MVv
 sOlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcxIWstiJC2dAuSUQBvY64MCZKiM0UuzObqmNQN71V73nkd2p8J3AW4BUDYMg3L1gjuNwTiqm1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+C/3QZ8KXRuaN3phMnt6BbB/BSPYkE4bei2Nzcq+c9Ln34iCq
 Vo/C4rYpEnZojXuisAOi0cHghNkg9GqopB9yWxdr+kMJGeodfetsoec6IXalZo6tKrioKWOiWfg
 TvcuCRvPj+g0ltQ/hiO2SuWSKFNs=
X-Google-Smtp-Source: AGHT+IHfIAI1KziMC/DpdOh4Ht7tKvRl7oyBCPkuLH+YiiEzGOEzkHIUZOUW4RIFxrbxcyqit0oMQ6Lffaa8FkPP6P0=
X-Received: by 2002:a17:90a:6f83:b0:2e2:a667:1a11 with SMTP id
 98e67ed59e1d1-2e2f0a22892mr5663503a91.1.1728910798760; Mon, 14 Oct 2024
 05:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <b7abd0b6-ac96-48ca-8165-a3b408137007@quicinc.com>
 <14691DD3-987C-4CC7-AA58-D3BF952F6224@xenosoft.de>
In-Reply-To: <14691DD3-987C-4CC7-AA58-D3BF952F6224@xenosoft.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Oct 2024 08:59:47 -0400
Message-ID: <CADnq5_PUi_2+kDYX8R_eanNF4iYN79MdXJ_PLcQbZKi6e4S8tg@mail.gmail.com>
Subject: Re: [PATCHES] drm/radeon issues
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, "R.T.Dickinson" <rtd@a-eon.com>, 
 mad skateman <madskateman@gmail.com>,
 Darren Stevens <darren@stevens-zone.net>, hypexed@yahoo.com.au, 
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, Wu Hoi Pok <wuhoipok@gmail.com>,
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

On Thu, Oct 10, 2024 at 11:54=E2=80=AFPM Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
>
> On 11 October 2024 at 01:49am, Jeff Johnson <quic_jjohnson@quicinc.com> w=
rote:
>
> Can you provide links to all 3 patches?
>
> 6.12-rc2 was back merged to my ath.git project, but then my laptop
> stopped booting correctly and I discovered a few Radeon KASAN reports.
> Based upon my search of lore I found:
>
> 20241003060650.18454-1-wuhoipok@gmail.com
> [PATCH] drm/radeon: add late_register for connector
>
> 20241007183241.1584-1-christian.koenig@amd.com
> [PATCH] drm/radeon: always set GEM function pointer
>
> But that is only 2 patches.
>
> - - -
>
> The third patch: https://github.com/chzigotzky/kernels/blob/main/patches/=
X1000/radeon_encoders.patch

Can whoever wrote this send it out as a proper patch?

Alex
