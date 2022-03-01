Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A76C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 19:48:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 849C010E1CD;
	Tue,  1 Mar 2022 19:48:25 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3B4E10E1CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 19:42:49 +0000 (UTC)
Received: by mail-lf1-x130.google.com with SMTP id f37so28617601lfv.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 11:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PzY8tILS7/J5BzJfiKLdBDXy8/s4RAHqODI+UdY57jc=;
 b=MSgmT6lRet0jPev3NhT8poLSNE2IuVKHhTmnMdindDPsxNrbDdzPrkBSaT4BauMeD+
 LWq3ALR2NImH9IAbyg/9Mpz0DLX1H3V94a1gLKACC1HvSqM9EwtH2Km4ZUYlkqLoZgsQ
 ZV7jqWBOB7cCGsim0JopuTtvt6tgng/ReKRwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PzY8tILS7/J5BzJfiKLdBDXy8/s4RAHqODI+UdY57jc=;
 b=3nVmQqzamVd4WKaIWf9xE++opx2HGsp+Qb84GUHYBqA1gb9uYaNjiEZuwayyIloBlJ
 mmGLwYfy4WRrCfMVZZLZbXPl28+TIiYz0nA8gcxDTBCB5zqUFSeMYZ57x/hKZWeTOWkb
 hpsF6X+MkffUsPprAXJ8yjT7XKaaCGlkOnfh3zor3cITrp+6iOJ9lytwkxfvrR91/gyF
 2esgYXx/Q+/rWwk8tl0+Kz6rfGdmRFPmxXjQxjRYhVIE94BC5erzxsdGv4TgBuPMZpWp
 gPJCs415h5ndkuoh/nGzcuyUYL0Sg160bMrlSlfF7s/d73F9a+gQNSEN5FhRS/N1os1I
 4x9Q==
X-Gm-Message-State: AOAM530gf3SC2aBVLNImGw91qVJHNVIfxx8q2HbWlkwlVz3tEKGsMesl
 +HjJqlVO9CqY3J9rgUgUrpmmnltc4z55M8BkSnc=
X-Google-Smtp-Source: ABdhPJy0I5X0IAdpN08BobgviHwvi0aUc41/ilYOpo88iULdtLyf4YDsvfqSGLau5cXcPY1GXpjK1A==
X-Received: by 2002:a19:a404:0:b0:443:2ef6:1ae7 with SMTP id
 q4-20020a19a404000000b004432ef61ae7mr16939557lfc.554.1646163767855; 
 Tue, 01 Mar 2022 11:42:47 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com.
 [209.85.208.178]) by smtp.gmail.com with ESMTPSA id
 c16-20020a056512105000b004433d4bb7e3sm1639448lfb.184.2022.03.01.11.42.43
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Mar 2022 11:42:43 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 29so23240339ljv.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 11:42:43 -0800 (PST)
X-Received: by 2002:a2e:3013:0:b0:246:2ca9:365e with SMTP id
 w19-20020a2e3013000000b002462ca9365emr17983151ljw.291.1646163763108; Tue, 01
 Mar 2022 11:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com>
 <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <282f0f8d-f491-26fc-6ae0-604b367a5a1a@amd.com>
 <b2d20961dbb7533f380827a7fcc313ff849875c1.camel@HansenPartnership.com>
 <7D0C2A5D-500E-4F38-AD0C-A76E132A390E@kernel.org>
 <73fa82a20910c06784be2352a655acc59e9942ea.camel@HansenPartnership.com>
 <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
In-Reply-To: <CAHk-=wiT5HX6Kp0Qv4ZYK_rkq9t5fZ5zZ7vzvi6pub9kgp=72g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 1 Mar 2022 11:42:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghQygmASNUWj=LZn5FR5wsce2osyR6EXcfEB_FaX_6Og@mail.gmail.com>
Message-ID: <CAHk-=wghQygmASNUWj=LZn5FR5wsce2osyR6EXcfEB_FaX_6Og@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 01 Mar 2022 19:48:24 +0000
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
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mike Rapoport <rppt@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 1, 2022 at 11:06 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So instead of that simple "if (!entry)", we'd effectively have to
> continue to use something that still works with the old world order
> (ie that "if (list_entry_is_head())" model).

Just to prove my point about how this is painful, that doesn't work at all.

If the loop iterator at the end is NULL (good, in theory), we can't
use "list_entry_is_head()" to check whether we ended. We'd have to use
a new thing entirely, to handle the "list_for_each_entry() has the
old/new semantics" cases.

That's largely why I was pushing for the "let's make it impossible to
use the loop iterator at all outside the loop". It avoids the
confusing case, and the patches to move to that stricter semantic can
be merged independently (and before) doing the actual semantic change.

I'm not saying my suggested approach is wonderful either. Honestly,
it's painful that we have so nasty semantics for the end-of-loop case
for list_for_each_entry().

The minimal patch would clearly be to keep those broken semantics, and
just force everybody to use the list_entry_is_head() case. That's the
"we know we messed up, we are too lazy to fix it, we'll just work
around it and people need to be careful" approach.

And laziness is a virtue. But bad semantics are bad semantics. So it's
a question of balancing those two issues.

               Linus
