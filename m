Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201DFC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 20:27:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A205B10E8B9;
	Mon, 28 Feb 2022 20:27:13 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E4DD10E8A7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 20:03:54 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id 29so18933756ljv.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 12:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uod9R4vPcpqIjzHofeC96qXcIXUlGW+U5alvKq7K0ZA=;
 b=Y+K+LAchMzIcesbCiqrzhisJgvbUIKYh3oFG/AlZJTKul1K9rRfHylHsN/EgM8hdwz
 P3hABFpC0Wcw+/0V4cKR5X0P787Wy9QwMeL5ORY50P9+oNZqmMp6NkFq4yV6NAIkP79C
 0bvk8ZnwfFSPqzKfD7Qqea+fs2YLRTaNcLanw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uod9R4vPcpqIjzHofeC96qXcIXUlGW+U5alvKq7K0ZA=;
 b=KYR6LA3Wgkb/BUOyJb/VBAzdc0ag6AJHgnjjnzVIWuqQedbb7cdXRNinyfUbHDPSmd
 mAen9W50qc9gNdfCK4yLWZVSAGH3j0LsIx3TUx2bjYpRZUEDIPy58mPgt/0SDutPYU7q
 uXxM0RGWNavgHLPEUuwN2lCzB40TjnivJidYaghCTYILQ8NCdqymF7Lx4bG0ngJiPDT1
 xAOSy/9BqmdlcXgstxzmuvvvsmeeHfBsbJT7laVD4h0dxUh5RnIbjgCD1XG7P2IHPPct
 dDaCF002WWKQl2HR1aBTA0o6imR3Shm3P68ZhjZV3TDq+vFvTgzwkCxWoNWRvZ+XN+Qt
 Lvvw==
X-Gm-Message-State: AOAM5308W2KuZhbqVgJ3/JnMpg/0N3ud/MmwO7enERmIByW0nuB9oNvf
 HmwTXU6MVbqh8VO1ThYtUD8YiaOm0sNVz7s71RM=
X-Google-Smtp-Source: ABdhPJz18O+QB2OuaxK1ZzS49E0j+0LlK06jyu8Zk/Q4ZTXoo1yCnyTx92iilOP84x+sUSVcNVTkCA==
X-Received: by 2002:a2e:a792:0:b0:246:4680:e553 with SMTP id
 c18-20020a2ea792000000b002464680e553mr15669773ljf.175.1646078632755; 
 Mon, 28 Feb 2022 12:03:52 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com.
 [209.85.167.52]) by smtp.gmail.com with ESMTPSA id
 u19-20020a2e91d3000000b002461bced9e2sm1509897ljg.79.2022.02.28.12.03.51
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Feb 2022 12:03:51 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id d23so23227505lfv.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 12:03:51 -0800 (PST)
X-Received: by 2002:ac2:44a4:0:b0:445:8fc5:a12a with SMTP id
 c4-20020ac244a4000000b004458fc5a12amr7653619lfm.27.1646078630855; Mon, 28 Feb
 2022 12:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
In-Reply-To: <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Feb 2022 12:03:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
Message-ID: <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 28 Feb 2022 20:27:12 +0000
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
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 alsa-devel@alsa-project.org, KVM list <kvm@vger.kernel.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-iio@vger.kernel.org,
 nouveau@lists.freedesktop.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Cristiano Giuffrida <c.giuffrida@vu.nl>, "Bos, H.J." <h.j.bos@vu.nl>,
 linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
 linux-arch <linux-arch@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>,
 linux-aspeed@lists.ozlabs.org, linux-scsi <linux-scsi@vger.kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>, linux-staging@lists.linux.dev,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 intel-wired-lan@lists.osuosl.org, kgdb-bugreport@lists.sourceforge.net,
 bcm-kernel-feedback-list@broadcom.com,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergman <arnd@arndb.de>,
 Linux PM <linux-pm@vger.kernel.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>, dma <dmaengine@vger.kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jakob Koschel <jakobkoschel@gmail.com>, v9fs-developer@lists.sourceforge.net,
 linux-tegra <linux-tegra@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-sgx@vger.kernel.org,
 linux-block <linux-block@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 linux-usb@vger.kernel.org, samba-technical@lists.samba.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
 tipc-discussion@lists.sourceforge.net,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-mediatek@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mike Rapoport <rppt@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 28, 2022 at 11:56 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do wish we could actually poison the 'pos' value after the loop
> somehow - but clearly the "might be uninitialized" I was hoping for
> isn't the way to do it.

Side note: we do need *some* way to do it.

Because if we make that change, and only set it to another pointer
when not the head, then we very much change the semantics of
"list_for_each_head()". The "list was empty" case would now exit with
'pos' not set at all (or set to NULL if we add that). Or it would be
set to the last entry.

And regardless, that means that all the

        if (pos == head)

kinds of checks after the loop would be fundamentally broken.

Darn. I really hoped for (and naively expected) that we could actually
have the compiler warn about the use-after-loop case. That whole
"compiler will now complain about bad use" was integral to my clever
plan to use the C99 feature of declaring the iterator inside the loop.

But my "clever plan" was apparently some ACME-level Wile E. Coyote sh*t.

Darn.

                   Linus
