Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50D9C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Aug 2022 15:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB3C9BF91;
	Thu,  4 Aug 2022 15:53:15 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A3069BF8A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Aug 2022 15:53:02 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id b16so195153edd.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Aug 2022 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kfOK7s3xFsw9XOCf5rZ5v1wNOUbWhtj/0D6S2FQvtM4=;
 b=xkMI17oM3zfPjoCLWJIfoLEnzXtAFKPZa4ZWlivsE178VeTOwHGHU9Hr4pUoF4Fx5S
 e5YGoJoRK/7ejxUK4KXnY7eldNgTsVQ2YrMR5ogMfXVKZJtB/QUM5al6wZmb10Kdg3jN
 s80XcOp8siV+ER6lpOr5DSL58AxHq3TX45uYGA1BvPIJLivLpurOqY402nDfKfJZEzYY
 kQnYggNAwZjX6kO83NC1DuySWHjriR7yj2vyTtF38zJF7oVm/t7a9+qkfrSmrcH2CSgW
 9rYw92j4oquUkSL8DYp7d/2V15rgUrXkgF1HU9mqEJzxSGqzGYh1tcYl0fdN0SrmHJ0G
 LPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kfOK7s3xFsw9XOCf5rZ5v1wNOUbWhtj/0D6S2FQvtM4=;
 b=6hPTEX+DGdJ9Ugo/AYibAeaZ3NIy6yZg68VfHdQXLIehc7/3KkoorX4ZZrWQK4EBz4
 3M4GSrTxkBHDzs4ShmlRqVr9kdya/sCR7Rk965eMvk720eZxFtSojabrBADkEMYIXYxL
 oyRqDHL6kwDWHj5cbOMzTM037DgTfdqDBg/UVVICIHP2raShqxnlw9FIGd4iOWw8LJEA
 14MHZXIhYkW7tRZrQUMcRTVJnAY5s97ZeiHPd1OLfIUfxKlI248wpBof6IZGBTXS7y4l
 /9ALaw+Ddy7fwah8H0Ti1SkXkDUCYcZdNQVFie/qIGHmwpxQPjS8LwTbhbqjl+zWQUI1
 PlpQ==
X-Gm-Message-State: ACgBeo1e9aqCtsrvNFExnzKnJY75KI2eD1PgpS1fSnO9RzM8pIOfk2xu
 DMzFMKTzSayhirUTfOCbaq4N4JdRHR7NZWp/ekPvVg==
X-Google-Smtp-Source: AA6agR6lQ9q9dJTBGl3Gilpz3rF721hsEVFdi6SAsf5d+O2sa6KidsumgOaF4nVCpZCbmEiXDBPvWVfWUWYmNO/CD1s=
X-Received: by 2002:a05:6402:2d1:b0:43c:bb20:71bf with SMTP id
 b17-20020a05640202d100b0043cbb2071bfmr2688992edx.59.1659628380746; Thu, 04
 Aug 2022 08:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220708102124.493372-1-Arunpravin.PaneerSelvam@amd.com>
 <20220714145423.721e1c3b@maurocar-mobl2>
 <83d9f973-abdd-3d8b-5955-84cfc3f49eea@amd.com>
 <CADnq5_MNkeG4E9ZXRLpgFQxrDN9jDhk7KYYHbjvtY-cUt5Kk8A@mail.gmail.com>
 <076231a3-38e9-e013-e106-aa926d009e77@amd.com>
 <87zgh6b1dp.wl-ashutosh.dixit@intel.com>
In-Reply-To: <87zgh6b1dp.wl-ashutosh.dixit@intel.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 4 Aug 2022 16:52:49 +0100
Message-ID: <CAHbf0-EpHZmpqFgbyY753xQ2HZ_26bYT3qkYy0+EiVfYowzqxg@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: add drm buddy support to amdgpu"
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
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
Cc: Mauro Carvalho Chehab <mauro.chehab@linux.intel.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

When is this relanding?

Cheers

Mike

On Mon, 18 Jul 2022 at 21:40, Dixit, Ashutosh <ashutosh.dixit@intel.com> wr=
ote:
>
> On Thu, 14 Jul 2022 08:00:32 -0700, Christian K=C3=B6nig wrote:
> >
> > Am 14.07.22 um 15:33 schrieb Alex Deucher:
> > > On Thu, Jul 14, 2022 at 9:09 AM Christian K=C3=B6nig
> > > <christian.koenig@amd.com> wrote:
> > >> Hi Mauro,
> > >>
> > >> well the last time I checked drm-tip was clean.
> > >>
> > >> The revert is necessary because we had some problems with the commit
> > >> which we couldn't fix in the 5.19 cycle.
> > > Would it be worth reverting the revert and applying the actual fix[1]=
?
> > >   It's a huge revert unfortunately while the actual fix is like 10
> > > lines of code.  I'm concerned there will be subtle fallout from the
> > > revert due to how extensive it is.
> >
> > We have other bug fixes and cleanups around that patch which didn't mad=
e it
> > into 5.19 either. I don't want to create an ever greater mess.
> >
> > Real question is why building drm-tip work for me but not for others?
>
> Seeing this on latest drm-tip:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:54:1: error: redefinition of=
 =E2=80=98amdgpu_vram_mgr_first_block=E2=80=99
>    54 | amdgpu_vram_mgr_first_block(struct list_head *list)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h:29,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu.h:73,
>                  from drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:28:
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h:57:1: note: previous definit=
ion of =E2=80=98amdgpu_vram_mgr_first_block=E2=80=99 with type =E2=80=98str=
uct drm_buddy_block *(struct list_head *)=E2=80=99
>    57 | amdgpu_vram_mgr_first_block(struct list_head *list)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:59:20: error: redefinition o=
f =E2=80=98amdgpu_is_vram_mgr_blocks_contiguous=E2=80=99
>    59 | static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct li=
st_head *head)
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.h:62:20: note: previous defini=
tion of =E2=80=98amdgpu_is_vram_mgr_blocks_contiguous=E2=80=99 with type =
=E2=80=98bool(struct list_head *)=E2=80=99 {aka =E2=80=98_Bool(struct list_=
head *)=E2=80=99}
>    62 | static inline bool amdgpu_is_vram_mgr_blocks_contiguous(struct li=
st_head *head)
>       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[4]: *** [scripts/Makefile.build:249: drivers/gpu/drm/amd/amdgpu/amdg=
pu_vram_mgr.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
> make[3]: *** [scripts/Makefile.build:466: drivers/gpu/drm/amd/amdgpu] Err=
or 2
> make[2]: *** [scripts/Makefile.build:466: drivers/gpu/drm] Error 2
> make[1]: *** [scripts/Makefile.build:466: drivers/gpu] Error 2
