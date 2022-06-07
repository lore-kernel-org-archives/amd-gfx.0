Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9602EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 17:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E9610F2EA;
	Tue,  7 Jun 2022 17:39:14 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C4F710F2EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 17:39:14 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-fb6b4da1dfso6069467fac.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jun 2022 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UOLmJGIN9guUyt8uZRpdgsdWlDm3gDN/hKKZR/NyyLE=;
 b=hhmGhaXZ8JEqPJE8oGeb5qqgyVDKuVASsufWkfuUXzPiWSjD52OtjPooUpU6yY0W0P
 EjQbSklrxUuf5BCXKwpy/fXQIjnDpoe0DD8QsgKbl4S07oB9jYrsaYHUWS2iSalvWtMm
 zbuPagfbNyjbl7fPGJ1daKizv3T2MSjsOs+QuOIFvUZWJIOfhtagCsF7i097/Ya6Neo8
 YNti2y5Izvn0I4yORw202ZhZSXrqcNBIfmN45klr0V28BsJgMirFvTqcQ5+GbxT5A0hw
 M9EpyMwudONjPRWFPT/ryVla11afT68IpNrlhG0tvmMyyfF/REwoWhs3sjfblZaiwsTs
 UI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UOLmJGIN9guUyt8uZRpdgsdWlDm3gDN/hKKZR/NyyLE=;
 b=23QiROg/kRegwNlohUaVNBGTokPvHPsEgk35gNhJ0HAxCDwdUVNTJWBhz5frUSGzd1
 UZVqOUI84+d1nBWADOdMfolfVo9qR7hBKe6qGmviKOLI8Rj/pDdgrgdyi3f6ik+5G64W
 YwHK9QZY89Q/dhE2unN0Q2sSu0wjkizVLewFwSuneclABu29jN/SFLODC1Zc9IekKJq2
 QZ9S+swwMjZvwjvhs3H28YabDmHRrVljjPYFnlfYwPj06zwYti6m8BgIIi4V3++ud5Tl
 YHURASIyuh7gTgVoVIc3mu1sjjQ+e5JA0TuSVuw+UFTVw0Gx/CFydQTbE9aO/VItAnXU
 AwrQ==
X-Gm-Message-State: AOAM530gdxfRPN9jYTlp4n/RpDtF6Wi5hbVu1aMA0/i7VTRH1ARqgQCc
 hlLH0SLJb9Fa3KYteGHVhglXjH1riTnkpUixFeA=
X-Google-Smtp-Source: ABdhPJxKfAnEuzcLeZETPvt+gNp6sO3pcYW0upjJip6wV6ZzZKmqo8N/GY28gE8vrhaneP84e+u5bhTvyipDEvhHxno=
X-Received: by 2002:a05:6870:3105:b0:f2:9615:ff8e with SMTP id
 v5-20020a056870310500b000f29615ff8emr32588860oaa.200.1654623552888; Tue, 07
 Jun 2022 10:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220519135642.83209-1-andrey.grodzovsky@amd.com>
 <CAJhGHyBQ60Lh3WZCa+2cE4T36t3vjNxYTBCxS7J0xhZr8Eb2wg@mail.gmail.com>
 <e1e2e63d-a1a9-12ad-97a7-a3771210edda@amd.com>
 <CAJhGHyC7VLM1PnXMu2zmdX=xtSNKo6VGO5p0AkUnaaMsuZytpA@mail.gmail.com>
 <045157bb-31a0-2d76-18b7-4272fab218ef@gmail.com>
 <YodIquufXzK581gw@slm.duckdns.org>
 <8df16635-658b-b381-9a40-3544828910fc@amd.com>
 <Yp+HXowR9nTig331@slm.duckdns.org>
In-Reply-To: <Yp+HXowR9nTig331@slm.duckdns.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jun 2022 13:39:01 -0400
Message-ID: <CADnq5_OquY8A_nMsCcwMxvDL3r0WzYAxFdrGNzYsKEP7q-Xg7g@mail.gmail.com>
Subject: Re: [PATCH] Revert "workqueue: remove unused cancel_work()"
To: Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christian Koenig <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 7, 2022 at 1:14 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Sat, May 21, 2022 at 12:04:00AM -0400, Andrey Grodzovsky wrote:
> > From 78df30cc97f10c885f5159a293e6afe2348aa60c Mon Sep 17 00:00:00 2001
> > From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> > Date: Thu, 19 May 2022 09:47:28 -0400
> > Subject: Revert "workqueue: remove unused cancel_work()"
> >
> > This reverts commit 6417250d3f894e66a68ba1cd93676143f2376a6f.
> >
> > amdpgu need this function in order to prematurly stop pending
> > reset works when another reset work already in progress.
> >
> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>
> Applied to wq/for-5.19-fixes.

Could we take it through the drm tree so we can include it with
Andrey's patches that depend on it?

Alex


>
> Thanks.
>
> --
> tejun
