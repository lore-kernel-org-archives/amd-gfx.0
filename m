Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09B6C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Dec 2023 16:41:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3354610E612;
	Tue, 12 Dec 2023 16:41:55 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C408D10E612
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 16:41:52 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1f5bd86ceb3so4279806fac.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Dec 2023 08:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702399312; x=1703004112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRdrB8cd28H/2/Izbx2aUiI9Yik6mjNLx89/vPRuiT0=;
 b=EW9P+EtcwZEESbGOGQNZf79a8bsL+dT1DzGrme9Ei29D5epTs7zucDxB2ieXv//jmo
 lTcLFemuKcKt4ERJkFcHBhaCGvloEt4T04T/VN+vU4QkLgGiZveZISxcjkYIj4bgfabh
 OU3GJ+tspmIYvPKKhyUux2sIiAstO1deSe9AAPlsCQZPuaScBffKdTTC6d/w/dYsfe6L
 RedBp4dX2UIbyUulaNVgJ8bm755fUCXmJ0i+CocBf/flOL/ZtVEAkEEQ3Uqv9Rim8iQy
 Y70I0hqoqpqRuXtQyeiwHW0Pzww0SDiAYU3RWqWhb2Fyx6JQ+uScpqU+2bZwNFXtYLa9
 1dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702399312; x=1703004112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRdrB8cd28H/2/Izbx2aUiI9Yik6mjNLx89/vPRuiT0=;
 b=DKvN5c23aHKORWHLG4KhJ3mIhf1icWop6hAjk2AN0y51t4hSX/22mWAHg4sjsZbT8F
 TPunuqAr5nAC0C3Q/O4G68bqVe4QxS8/H7WdcR0BFeFmpxJ8ucYycEBMb6ObqXeXTK/9
 ishB2G5qi9tifxjTD0BpYbrWGHrAUn45SE+3eUD3cdUuW/Hn9u1xuwd82+MthkNmM/M1
 2v0D5wGjZEmkNjKGCPujWRDYHA66JY2Z8nSK+/fhacg/3VVBO05jbfzP9AHKfw0Znbwa
 fLTdWun0W6d7I6eXprsQJToj3x6pszNATCI9+amRxRgtB4baSdtrWESruWbmHrb2uzeX
 FVbw==
X-Gm-Message-State: AOJu0YwhN0Tiu5m/nNghnZt4Qmato7cy86VdTiLesf5sakgWt03m4pvg
 4tQ6obZtp8YlcMB4JBjiCGKYWAG64YiPKi4EbUg=
X-Google-Smtp-Source: AGHT+IE8T/ikLkFXi7N3tOYjDQb/4Wsf/bEp9kibW34I6ENqYarhzFArv5a//G8zYaNUisaAoNIG/cX0Su07oh64vTQ=
X-Received: by 2002:a05:6870:c1cf:b0:203:89b:4597 with SMTP id
 i15-20020a056870c1cf00b00203089b4597mr840428oad.40.1702399311894; Tue, 12 Dec
 2023 08:41:51 -0800 (PST)
MIME-Version: 1.0
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
 <3a06ae67808800386117c90714637ef9a0267b37.camel@sipsolutions.net>
 <c4dc3d03-5241-4b2b-b0ff-6517f063ba29@amd.com>
In-Reply-To: <c4dc3d03-5241-4b2b-b0ff-6517f063ba29@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Dec 2023 11:41:40 -0500
Message-ID: <CADnq5_PEDDAjjMOKpeLAHoFVCgbo6Sg8iVWC7sX4Ntn-PHk90g@mail.gmail.com>
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and wifi
 / amdgpu due for the v6.8 merge window
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Ma Jun <Jun.Ma2@amd.com>, linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 12, 2023 at 11:25=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/12/2023 03:46, Johannes Berg wrote:
> > On Mon, 2023-12-11 at 12:02 +0100, Hans de Goede wrote:
> >> Hi Wifi and AMDGPU maintainers,
> >>
> >> Here is a pull-request for the platform-drivers-x86 parts of:
> >>
> >> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-J=
un.Ma2@amd.com/
> >>
> >>  From my pov the pdx86 bits are ready and the platform-drivers-x86-amd=
-wbrf-v6.8-1 tag can be merged by you to merge the wifi-subsys resp. the am=
dgpu driver changes on top.
> >>
> >> This only adds kernel internal API, so if in the future the API needs =
work that can be done.
> >
> > OK, thanks! I've pulled this into wireless-next, and applied the two
> > wireless related patches on top.
> >
> > I guess if AMDGPU does the same, it will combine nicely in 6.8.
> >
> > johannes
>
> Yup, I've pulled the whole series into amd-staging-drm-next for now and
> I expect as long as we have no problems with it reported under our
> testing Alex or Christian will do the same include drm/amd portions of
> it in an upcoming drm-next pull request.

I've pushed out an updated -next branch as well:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-next

Alex
