Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0C5C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 08:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84C910E55D;
	Tue, 14 Jun 2022 08:16:35 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E4210E32B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 08:16:33 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id c196so7963484pfb.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 01:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=jXa8xvrkQ1lZvQMYQK5w8BDUYXIzUNuQbVKmAR8OyQs=;
 b=LH/+3Ii/QQ7f0xZGG7fbzL8MuJGPzDBlqmKpsddrQwTgzSkmVfkTW/hy5OCtbNZx83
 2SXgWR9niM3S/cQxq/+riKWIvEFfyk3daSo3LdLK0xoteapAERKtm2NrhPNHvnGCZlAt
 xTuw+k1zXhH0g68yvZHTmSCWtxUql1+uy2Kaa2ZAxL8fd84aD7ublxLN04BYWWRpHk6n
 B+DXHXDXIzK213RmcB4sgVfXo8tklaLAN5WGVyBVqyglZcLjqrlQAnmLmhhC2U394DoZ
 9YqetBKq7Hu3AewUgUR8mHb+HnAXx+NDAeeYrMEmkyXjVr7on6yPR0wh60mrx1q+6eBJ
 nIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jXa8xvrkQ1lZvQMYQK5w8BDUYXIzUNuQbVKmAR8OyQs=;
 b=CxPpd1M0a19XnVhqM8F9fuC1asHWn1G9MS+gyAUevr02x1ucgrx3WoDFYk7A5ps9AQ
 G+fYcALpIi45Kzyt+M5Xg9d/L4xoFqs6lymG+8xDSny02jDpbAwTtsyWiZMUx3gaYOxG
 0QyV3IncNdGL2ueuxAxor3CNPV11X1Y0AoucMwTsWi5rBNOG+WmNWoUQ0Jza3Ca9iDgG
 87gsgLBXjfbTJMs1MXlle7gX7vBGiXRGcpsVxXEzKjorMN/letwVhE0p2Ge20nD1nivp
 XopyMLGzNONyZn1rFuNXphy7Xw2kpa5WEiBwBHm8Yiws3y4BxDP8bC1XNgn24c1PH4Ab
 XTuw==
X-Gm-Message-State: AOAM531Vt3Ptskdmes/pZqrXgafiIeN6Me59JG9hUhCASfs4tCmyGofv
 mS1Su1VOzFSpXhr2x46HUZXHzzXiqGnPgmSUmWTa7Q==
X-Google-Smtp-Source: ABdhPJxJrKYit0TOO6xDqGmFbxJZMqu7TH2jfFBLlagMWZx3N/pNko7K3PwkTFTlkoPMn8/ue2uAiZr2LmKm8F/VmDc=
X-Received: by 2002:a05:6a00:1690:b0:517:cc9e:3e2d with SMTP id
 k16-20020a056a00169000b00517cc9e3e2dmr3514915pfc.0.1655194593385; Tue, 14 Jun
 2022 01:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220610135426.670120-1-michel@daenzer.net>
 <2260b6a6-153c-6c12-212c-2b3f5199e6dc@gmail.com>
 <71d16c84-494c-1204-3944-d37aac8fed82@daenzer.net>
In-Reply-To: <71d16c84-494c-1204-3944-d37aac8fed82@daenzer.net>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 14 Jun 2022 09:16:22 +0100
Message-ID: <CAHbf0-Gk8jds_iNh9d8qNvc5+5jVjyCeiSqMNJjzri-ohJSmxw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix GTT size reporting in amdgpu_ioctl
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 13 Jun 2022 at 10:11, Michel D=C3=A4nzer <michel@daenzer.net> wrote=
:
>
> On 2022-06-11 09:19, Christian K=C3=B6nig wrote:
> > Am 10.06.22 um 15:54 schrieb Michel D=C3=A4nzer:
> >> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >>
> >> The commit below changed the TTM manager size unit from pages to
> >> bytes, but failed to adjust the corresponding calculations in
> >> amdgpu_ioctl.
> >>
> >> Fixes: dfa714b88eb0 ("drm/amdgpu: remove GTT accounting v2")
> >> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1930
> >> Bug: https://gitlab.freedesktop.org/mesa/mesa/-/issues/6642
> >> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> >
> > Ah, WTF! You won't believe how long I have been searching for this one.
>
> Don't feel too bad, similar things have happened to me before. :) Even af=
ter Marek's GitLab comment got me on the right track, it still took a fair =
amount of trial, error & head scratching to put this one to bed.
>
>
> --
> Earthling Michel D=C3=A4nzer            |                  https://redhat=
.com
> Libre software enthusiast          |         Mesa and Xwayland developer

That's indeed fixed the Tomb Raider / vulkan issue

I'm still seeing some strange warnings and errors on Linus's tree so
I've updated https://gitlab.freedesktop.org/drm/amd/-/issues/1992
https://gitlab.freedesktop.org/drm/amd/-/issues/2034, I'm not sure if
that's Buddy allocator, TTM Bulk moves or a whole new issue

If it's not too late feel free to add my tested by
