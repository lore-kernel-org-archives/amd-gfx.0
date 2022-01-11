Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D9FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 20:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB8610EFE8;
	Tue, 11 Jan 2022 20:52:43 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BDD010EF16
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 20:51:39 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id b13so1447484edn.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 12:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PJOwhp3ym4DBH3RV0e5Fa2srd2TuQC5f+y1GIJOJymg=;
 b=Poqh7tlps0nmydJNHuTFFz+1v91n9FBjuZDF9S/cEn3/lSPJU4mRgLKzcVJ9y2szxK
 w3QHdSzWPsF4aFUX1EWxGT3ZSvos+xqomNwyXjbgIrXwlEUEiTBA8POYMyy8nXDbHfJe
 utQNYyrqtWyiR/ZNc+DKBtuKMA5VAvLH46Wag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PJOwhp3ym4DBH3RV0e5Fa2srd2TuQC5f+y1GIJOJymg=;
 b=RP1DbGyvf/bvv9xE113KneXAj+fe4VG3ERP0W0g3aVGQo5x/fT5abhXkfibWc25n/d
 WBi6QU/V1qlxB90X3phrwr5f5frsQOBVSqxnm/dNABSR6ZsC+NbSV4bG5EUQRlFJxvcJ
 dmt1PRA4LOfh4CiZjnYGqmKCBX0O1yIZJ0PRc9n1aycYj3/22H7tcmauKrWDhS+fb022
 LM8QMQdNZF4kSUF7VLcSkVtKQE545pvdj+xkFrED+JfuWmldOVUXhxh1huRDMiNgj9He
 CGaEkGAiasX10xHEZqoVY8qE1RORrTd9IfAOt0WnOgqPKRUbqLaCRYdRbD53DwRSp0Lm
 1HJw==
X-Gm-Message-State: AOAM531kq/iKFwIbVfPUTK4qOssz/jpn4Fw1VUCxP9+Wk4wTd0TdVh9G
 t3T2dIYQcEbj5G3qXVP58KDA1AJ3yHItWZJntZg=
X-Google-Smtp-Source: ABdhPJwqAsqCVtYyHT7hWKQl6Nz+ZvkKiJDWqhsqLDhmMoWy/fOBD7rerV/b34jD26A2W+RSyETLiA==
X-Received: by 2002:a17:906:1585:: with SMTP id
 k5mr4913792ejd.83.1641934297145; 
 Tue, 11 Jan 2022 12:51:37 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com.
 [209.85.221.47])
 by smtp.gmail.com with ESMTPSA id qa11sm3893125ejc.189.2022.01.11.12.51.35
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jan 2022 12:51:35 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id q8so418408wra.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 12:51:35 -0800 (PST)
X-Received: by 2002:a5d:6083:: with SMTP id w3mr1799927wrt.281.1641934295380; 
 Tue, 11 Jan 2022 12:51:35 -0800 (PST)
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
 <CAHk-=whSAYiO_TkKut6XckdQigFj39ft1Kcs2qJe5niHWPGdwg@mail.gmail.com>
 <CADnq5_OZR9Ft=WVVbpM_WUpFZurni4yVxGPpa4nDkhupmod_ag@mail.gmail.com>
 <6490ec74-7de2-c3a3-d852-31b8594110d8@amd.com>
In-Reply-To: <6490ec74-7de2-c3a3-d852-31b8594110d8@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jan 2022 12:51:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whZW+Cy++vucKQd6Lrj7B1bhd1-pKkgV8xxPJr35Dh2UA@mail.gmail.com>
Message-ID: <CAHk-=whZW+Cy++vucKQd6Lrj7B1bhd1-pKkgV8xxPJr35Dh2UA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.17-rc1 (pre-merge window pull)
To: Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 11 Jan 2022 20:52:42 +0000
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
 meenakshikumar somasundaram <meenakshikumar.somasundaram@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@gmail.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 "Koenig, Christian" <christian.koenig@amd.com>,
 Mustapha Ghaddar <mustapha.ghaddar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 11, 2022 at 7:38 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> Attached is a v2 of the buggy patch that should get this right.
> If you have a chance to try it out let us know

I can confirm that I do not see the horribly flickering behavior with
this patch.

I didn't look at what the actual differences were from the one I
reverted, but at least on my machine this version works.

                Linus
