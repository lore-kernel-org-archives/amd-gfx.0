Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D72FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 15:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C545E10F922;
	Tue, 11 Jan 2022 15:00:28 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C14ED10F81A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 02:58:59 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id i5so7945209edf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 18:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RFZY2ueA8dih/Ph6oPag2dxgotRBXhtzjSAvUudHnIY=;
 b=P+MPAoIyBtw16udETh31u1xox98U7/zK5e4+H2Jkqdxs9duw1GWf2p3AnpbOpS/Tnh
 sF6JmmyzaL2YD7cj+PCmFJzKzbGSPfSk3L9DnCwSWQAP5TJB7inJcR0alc7Yl/w8XxON
 GZBxtAvK/V7/1ZnzI7GXFn0V8Lmp9TtPrspMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RFZY2ueA8dih/Ph6oPag2dxgotRBXhtzjSAvUudHnIY=;
 b=eoXn3mAntxPqbesNHU4yOYNFsaUHmuzw5gPPwCeE5hBLJII9ljkwolIA7SXA+90wCE
 HBi4rYrR0eaya/zU/cBubKLDYxJyx16mkfJ448wp0gCCnKTShNe68qMHS3BBYEo0D0a1
 Qhh2ExvGGIGdqAHIB95r1vKZni5Vha/aZfA/XLHnaQwppd0u/LZQ3UuqWl6xvoaMq4zc
 su6NhtmM7X3OvTbqukU8Q+wxTclyN53SDh9bNrpmOr76+ScC8ZJx0VtLZqqWU3iNaDLh
 LPztfg679qWBqFhl4S8mNC/KR8a3EIr7jQA8Ejt8qkQuBHx67VTrauQ82FUiZu00anx3
 wTvg==
X-Gm-Message-State: AOAM5312tkF5Rm3EnaHxQnwVNi7MnnZoapSGjizEmhh/s3fejCl+ryvU
 v+ui2eAzdJc1RK/zhKobj8s/IWXu3OIKfXfUuXg=
X-Google-Smtp-Source: ABdhPJzQT4+ujHgccfYvMgEorvYkwPa/+yvBwEi/7OhfE1smN/biM6jOmu61INIYRVCKQEx8tMi5YA==
X-Received: by 2002:a17:907:6da0:: with SMTP id
 sb32mr2087911ejc.455.1641869938301; 
 Mon, 10 Jan 2022 18:58:58 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com.
 [209.85.208.45])
 by smtp.gmail.com with ESMTPSA id 18sm3036085ejo.8.2022.01.10.18.58.58
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jan 2022 18:58:58 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id k15so61393827edk.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 18:58:58 -0800 (PST)
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr1899247wrm.193.1641869591441; 
 Mon, 10 Jan 2022 18:53:11 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
 <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
 <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
 <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
 <CAHk-=wi8b-YKHeNfwyYHMcgR2vJh4xpSZ0qjkv8E8Y9V8Sv2Tg@mail.gmail.com>
 <CAHk-=whnWnB9yjVaqWNKjavSJxDOEbTAPwef=O7qjL8nKZgV6A@mail.gmail.com>
In-Reply-To: <CAHk-=whnWnB9yjVaqWNKjavSJxDOEbTAPwef=O7qjL8nKZgV6A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jan 2022 18:52:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whSAYiO_TkKut6XckdQigFj39ft1Kcs2qJe5niHWPGdwg@mail.gmail.com>
Message-ID: <CAHk-=whSAYiO_TkKut6XckdQigFj39ft1Kcs2qJe5niHWPGdwg@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To: Alex Deucher <alexdeucher@gmail.com>, Jun Lei <Jun.Lei@amd.com>, 
 Mustapha Ghaddar <mustapha.ghaddar@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, 
 meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>, 
 Daniel Wheeler <daniel.wheeler@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 11 Jan 2022 15:00:28 +0000
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

On Mon, Jan 10, 2022 at 6:44 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'll double-check to see if a revert fixes it at the top of my tree.

Yup. It reverts cleanly, and the end result builds and works fine, and
doesn't show the horrendous flickering.

I have done that revert, and will continue the merge window work.
Somebody else gets to figure out what the actual bug is, but that
commit was horribly broken on my machine (Sapphire Pulse RX 580 8GB,
fwiw).

                   Linus
