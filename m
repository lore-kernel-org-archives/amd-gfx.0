Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C924C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 01:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA61810E187;
	Tue, 11 Jan 2022 01:31:15 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA62310E507
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 01:29:07 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id k15so60800797edk.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 17:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NvnMrqyyprPM82tM0QymR8SVUNtcjFg9kaau7vLVoys=;
 b=bJYuXFund9ha/pHIpixqe7ZULRG3XbPW/bwVA7ekt6FXGMxCxnXxW4Fckng6N5csqk
 CyQhn5VacnnVs0QpdCxP+hbBvwGfQp/bqct74HUPFt2EyD1c2GPpLFRq3POifHGPxFQr
 PP+TEmIue3otyL9vk0BEUmsF4uO6DbqkrFWHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NvnMrqyyprPM82tM0QymR8SVUNtcjFg9kaau7vLVoys=;
 b=KOuPAZdSAyGpuaweSmdwV8oUmHiF84yNAKuqR1xHEubPsaV6w3Dt2JEk3NfqSF/9DZ
 6djRo512rU/q0UfeWIVEOYXrSfz9NsTEVCsKG3AkuKzYVWtUHQqyxEs84YxEiqClWRa/
 8kWV+OqSW5GQInt6WlsBztvYMYHzN0rhr+bCOyAqT5s9LWXgf4uIoWyqX/f3uUMXQ3IR
 G1STXffkA6bwPnqWGMmMdRJ+YfXVi4OjKXjfr7iSExtwpCXkTBqvMoyqg18HR+tVmgSG
 0b2ylZWa7v0iTBtuPt/OgYIB/WXgL/p69UPrMvzIEDz+La31UfNqq+JOwpWsl5EL99H3
 59Eg==
X-Gm-Message-State: AOAM532N/Mf4Ym6XOIfdg9mrLym6fMj66+hk7jMGcPam8t/B4rpMuGkr
 GLfFHtLS6nWt21f6B4bNYJMjGUeX1wRRtV4vc6M=
X-Google-Smtp-Source: ABdhPJyARGCzZJofZTOJhKy0JU69M+A5G8knTzFzzZdnL/cEFXXsopT+W3NkyPiiwkGIncTEAaMBgg==
X-Received: by 2002:a17:907:8a06:: with SMTP id
 sc6mr1782688ejc.214.1641864546331; 
 Mon, 10 Jan 2022 17:29:06 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com.
 [209.85.128.47])
 by smtp.gmail.com with ESMTPSA id p3sm2977600ejo.61.2022.01.10.17.29.05
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jan 2022 17:29:05 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id
 l12-20020a7bc34c000000b003467c58cbdfso507802wmj.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jan 2022 17:29:05 -0800 (PST)
X-Received: by 2002:a1c:19c6:: with SMTP id 189mr334541wmz.155.1641864544815; 
 Mon, 10 Jan 2022 17:29:04 -0800 (PST)
MIME-Version: 1.0
References: <CAPM=9tz=_hRpQV1V3M-=KmVVEbr1K166qeb-ne64PHk9Sn-ozg@mail.gmail.com>
 <CAHk-=wg9hDde_L3bK9tAfdJ4N=TJJ+SjO3ZDONqH5=bVoy_Mzg@mail.gmail.com>
 <CAKMK7uEag=v-g6ygHPcT-uQJJx+5KOh2ZRzC2QtM-MCjjW67TA@mail.gmail.com>
 <CADnq5_P9n39RQ5+Nm8O=YKXXvXh1CEzwC2fOEzEJuS2zQLUWEw@mail.gmail.com>
 <CAHk-=wgDGcaRxUwRCR6p-rxDVO78Yj4YyM6ZsPRGiT2JOCoQ6A@mail.gmail.com>
 <CADnq5_OYO7kq+9DBnDvbSfpouFvdLB0LPSL6+f1ZPRBsV=qEqA@mail.gmail.com>
 <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiCCRG9Lwzr+Cur=K1V2GJ9ab_ket7EnG4RZhJ8jJM7xQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jan 2022 17:28:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9EQdO=gdgrajp03xNf6dtcE03oYucXmJJst0GgSs=VA@mail.gmail.com>
Message-ID: <CAHk-=wj9EQdO=gdgrajp03xNf6dtcE03oYucXmJJst0GgSs=VA@mail.gmail.com>
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

On Mon, Jan 10, 2022 at 5:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It also seems to depend a bit on the screen contents - or possibly on
> what else is going on. Hiding the browser window makes it happen less,
> I think. But I suspect that's about "less gpu activity" than anything
> else.

Actually, sometimes "more activity" makes it go away too. Moving a
window around wildly with the mouse makes it *stop* happen.

But moving the mouse over different elements of the screen - or
writing text in the web browser email window - seems to make it worse.

Funky.

It does "feel" to me like some bandwidth limitation, it has kind of
the same behavior that I remember from the bad old times when you were
pushing the video card past a resolution that it could really handle.

But that can't be the case, this card has had no problems with this before.

               Linus
