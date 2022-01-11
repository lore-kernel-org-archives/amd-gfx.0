Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E53FC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 01:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B399710E4D6;
	Tue, 11 Jan 2022 01:31:16 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C390510E4FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 01:21:27 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id w16so60858000edc.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 17:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VghT5Vb1bGkkfuhJyJBbYpfymLiEG6YlV0Ofo+lXSRs=;
 b=CuoC1S5DPEPzxhaI/t/Zt5/7ZnredBXUx63/7QgMSrKdR6dU+kjwkn5e4Y9dVXNX5l
 Vo7r+EcjrjXKC7eYS94RpKiX0PkhEoqLxQYqUn0fSn6sOhYsh649ExJNudF9PbHfqlwH
 HhetD8jit7LuyHbRhw8nh7NJ4t8W84qHpTvYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VghT5Vb1bGkkfuhJyJBbYpfymLiEG6YlV0Ofo+lXSRs=;
 b=4Ni+TjLKbnDBbnKbjMdHNMeLalQN+FsAvWdufTDL+lK3UHgidVF/TTt5EGXJLBlXp0
 XlW+0sauXajTvhmkmbbHcOXbyHoN0X95orlSwr+IPlw22He+242pq1Qjf17gO4SQn9pc
 wMwvfnhSxJzuyxA6ci3ZC2Q4l2L4TftpJw/dFnPKuOlRrH1fmgguKnftY68CajAZTMPL
 tMqcKLXp3vLy09tOqoHc0Dpp6y2IIkhojffwNn+0scxMKnJTkpg/ukAJffF5uuxk3e9f
 joCgftUZJFk4v2PDc9m6vKCKC7kX4C0GWa5W0rRNSmj5wItr8ADenOEkbS2yz2n2+NJZ
 merQ==
X-Gm-Message-State: AOAM5301/D5sqvQ1a1p2zQgubpNIpRyxJFjkMQLVQ4oO+r4r5ukv5Vy7
 KZ+fZv7BpZ8H/MDIg0hp6MqK3YIWfPzDxmPF3L8=
X-Google-Smtp-Source: ABdhPJx5k3UqcUW0TA1iYb1hHtYsesSCzhMhNDTXKRyo1pkCX0RUuyj9RxB2NoBizrsSG5lnIzt74A==
X-Received: by 2002:a05:6402:291f:: with SMTP id
 ee31mr2280593edb.194.1641864086197; 
 Mon, 10 Jan 2022 17:21:26 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com.
 [209.85.128.42])
 by smtp.gmail.com with ESMTPSA id qk11sm2972762ejc.110.2022.01.10.17.21.25
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jan 2022 17:21:25 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id
 c126-20020a1c9a84000000b00346f9ebee43so920120wme.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 17:21:25 -0800 (PST)
X-Received: by 2002:a05:600c:4c94:: with SMTP id
 g20mr337592wmp.26.1641864085524; 
 Mon, 10 Jan 2022 17:21:25 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
 <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
 <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
In-Reply-To: <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jan 2022 17:21:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
Message-ID: <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 11 Jan 2022 01:31:15 +0000
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <harry.wentland@amd.com>, Dave Airlie <airlied@gmail.com>, "Koenig,
 Christian" <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 10, 2022 at 5:11 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> We are putting together a system to try and repro the issue.  Does it
> happen with a single monitor or only with two?

Nope. With a single monitor everything seems to look fine. And when I
plug in the second monitor, it immediately starts happening again.

It also seems to depend a bit on the screen contents - or possibly on
what else is going on. Hiding the browser window makes it happen less,
I think. But I suspect that's about "less gpu activity" than anything
else.

I'll see if I can bisect it at least partially.

                  Linus
