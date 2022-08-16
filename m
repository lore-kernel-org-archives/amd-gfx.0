Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B7DC25B0E
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Aug 2022 21:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2698410E234;
	Tue, 16 Aug 2022 21:37:57 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F2610E22B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 21:37:51 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id p132so13486296oif.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Aug 2022 14:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=T/DBzcdPPhKJuNQgYdFxsjx9GQTXaHFnGaIrrPYRwlw=;
 b=HY9pWQeYrZN+wK2iqhExUCwHXjuMcEXAAyJAqdg8RERg0M5khHAcrHEzXe57owN0Bl
 Fqn/WO0Y3dHkquJwjf57TSdZwqBBsImajplmVXHR0BexYQGe20iXxiHbusmRCYXXWX4g
 JR20vwoP0iWoDLQBiCyvoEm8eDUQtaFsVtRUewTPnOspE67QnmnewW8ZFAQhS7QFCaSF
 LQpslOXmtFAHISlOrJGQruem2BgFrt1GbjK8y2sUvKMXONob1M0eeQh1BcPRWNVEOwo/
 Oy9G2iIyojxRWaxd9n6Z+YWaRNhkOQ6MCxD2vZhYMsLLYveTYcOvg9FOE88Ytcd5Yr7o
 RApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=T/DBzcdPPhKJuNQgYdFxsjx9GQTXaHFnGaIrrPYRwlw=;
 b=l6luLAaRBD4RNX7+v6sHzjSr1nYbS2NM4lnUSfDuwmymWMBT2p91orT/+LNxeDr1M9
 zogTgb3c1ZrYiVrNrQQ4wdsm5XhlBOMb5TPYJ4WTxBVDpLFR7RsKTeNSr5INW0/uaIVU
 /BWzbGYJJKSxSeA8M2zP1amavL3UnvSk6czyXYXV+Y7tM4wvDp63Z3dJfCgBCSIvpvwj
 tJ8Y5WT8mauL3vcQyUZWp2QYkxKAeYeC9po2fELsRVvLZ06fDWytOnNt0AN2RwkxOeLy
 +NtMGU0kvnkXbUQzyilzTj8tyJhvzX9aA8m7iAK3X5Gj/EALDyOCRhefxsYduRgxe8Ni
 2neQ==
X-Gm-Message-State: ACgBeo25NM9aHOoLUsRu8zdsUzIiO3H88H9eWKJ8cw7hwnfpC5Tcv19u
 cOj5GgzftiYDWeBBCU+z9XZ9ic2AcQSwy1LBakA=
X-Google-Smtp-Source: AA6agR6dn+3bvjMVN0kR4pIjpv8tyrI+yE1/6wATozBQ0i/5r2JUs0qUdISFgArdP31htrXKVkf+k5s+xK2WkUmUcfY=
X-Received: by 2002:a05:6808:1491:b0:343:7543:1a37 with SMTP id
 e17-20020a056808149100b0034375431a37mr238693oiw.106.1660685870635; Tue, 16
 Aug 2022 14:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220816084410.6048-1-michel@daenzer.net>
 <a8515153-3159-4a4f-4701-b940068850b2@daenzer.net>
In-Reply-To: <a8515153-3159-4a4f-4701-b940068850b2@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Aug 2022 17:37:39 -0400
Message-ID: <CADnq5_OMJ+qp5dk=iCiZ0y8ua+FpwH6Gcd9v7k+xnUuOEHSz4g@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/amdgpu: add pipe1 hardware support"
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: Jack Xiao <Jack.Xiao@amd.com>,
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org, Prike Liang <Prike.Liang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 16, 2022 at 5:12 AM Michel D=C3=A4nzer <michel@daenzer.net> wro=
te:
>
> On 2022-08-16 10:44, Michel D=C3=A4nzer wrote:
> > From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >
> > This reverts commit 4c7631800e6bf0eced08dd7b4f793fcd972f597d.
> >
> > Triggered GFX hangs with GNOME Wayland on Navi 21.
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2117
>
> Don't get me wrong, I'm really looking forward to this functionality, as =
it's required for reaping the full benefit of https://gitlab.gnome.org/GNOM=
E/mutter/-/merge_requests/1880 . But it has to actually work. :)
>

Applied.  Arun is looking into this.  We can re-enable it once it's
working in this use case.

Thanks,

Alex

>
> --
> Earthling Michel D=C3=A4nzer            |                  https://redhat=
.com
> Libre software enthusiast          |         Mesa and Xwayland developer
>
