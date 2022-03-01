Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF701C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 08:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FBB410EE9F;
	Wed,  2 Mar 2022 08:56:09 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9766310E7AC
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 23:11:30 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id a23so81687eju.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 15:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ojIOUCrgcIak8ZCc1skMdXRKcTVmt9Elm/o+1+I6jGA=;
 b=fmg4LXx5HRB2mrrWsHndl76rC2chdk1sBRQyNWtz+o2V+K2vg9psF6vr/ppax24roG
 0IEY6nkgVM6qwn95jhK4YeupoNeTj8/flkbxBQUDmf863ReCVguQlY3gsMWixLyIz8Mx
 ewpCP9yjbapnom8xtoCAmNy70uRnweYHKzlsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ojIOUCrgcIak8ZCc1skMdXRKcTVmt9Elm/o+1+I6jGA=;
 b=U6kYV2jB2lqkQis0bNlwnlsekxLb4nQdkZV753VvbuhGN4hwMJqQGAJtdo135st6+h
 /CUmz1pM9O8jQjVuE3mmOe3j2v+5hgTQy0a8mDG2T4eSr91KRQZ7b0FvaTs2LlefFdAQ
 7Enq9PK7O7xUjR1EVRi/0Yp6VA6R37arJ4swVZAfcz9LJC2OWx7iS4SRac15srJWa+CM
 jER8Q20iUjKO93IAUN9kqBY3DZla6sTQysnIysi/qexWPSgJBovSQK4yqFRgW2RkMYUr
 9oVojEpv4vS0MyBMknxo1IOafEgSxA9l+8Z01mvIWDusM4K539Dag6L7vF8z7TIigImw
 0I4g==
X-Gm-Message-State: AOAM532ByT7I/cOJ/N64lhBbi3hIGzuV5rxXQ5QNwmzBGJENpUp/Bhez
 JZejUgGy7xcEpohgIHemO78N0qLnGEwkpf3EcsU=
X-Google-Smtp-Source: ABdhPJwZiqu7RTBh6x8IhTFI9MGXGkDHL42M+afa+zU55UgYRPQ2qKFmoNevEI8+e2xp+pUhwZ+EtQ==
X-Received: by 2002:a17:907:366:b0:6ba:fff6:4fc7 with SMTP id
 rs6-20020a170907036600b006bafff64fc7mr20751969ejb.756.1646176288842; 
 Tue, 01 Mar 2022 15:11:28 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com.
 [209.85.221.49]) by smtp.gmail.com with ESMTPSA id
 co19-20020a0564020c1300b00412879e4645sm7674831edb.55.2022.03.01.15.11.28
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Mar 2022 15:11:28 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id t11so11338wrm.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 15:11:28 -0800 (PST)
X-Received: by 2002:a2e:924d:0:b0:246:370c:5618 with SMTP id
 v13-20020a2e924d000000b00246370c5618mr18436468ljg.358.1646175815802; Tue, 01
 Mar 2022 15:03:35 -0800 (PST)
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
 <7dc860874d434d2288f36730d8ea3312@AcuMS.aculab.com>
In-Reply-To: <7dc860874d434d2288f36730d8ea3312@AcuMS.aculab.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 1 Mar 2022 15:03:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whKqg89zu4T95+ctY-hocR6kDArpo2qO14-kV40Ga7ufw@mail.gmail.com>
Message-ID: <CAHk-=whKqg89zu4T95+ctY-hocR6kDArpo2qO14-kV40Ga7ufw@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To: David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 02 Mar 2022 08:56:07 +0000
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Cristiano Giuffrida <c.giuffrida@vu.nl>, "Bos, H.J." <h.j.bos@vu.nl>,
 "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
 "linux1394-devel@lists.sourceforge.net"
 <linux1394-devel@lists.sourceforge.net>,
 "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
 linux-arch <linux-arch@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>,
 KVM list <kvm@vger.kernel.org>, linux-scsi <linux-scsi@vger.kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>,
 "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, Arnd Bergman <arnd@arndb.de>,
 Linux PM <linux-pm@vger.kernel.org>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jakob Koschel <jakobkoschel@gmail.com>,
 "v9fs-developer@lists.sourceforge.net" <v9fs-developer@lists.sourceforge.net>,
 linux-tegra <linux-tegra@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>,
 "tipc-discussion@lists.sourceforge.net"
 <tipc-discussion@lists.sourceforge.net>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 dma <dmaengine@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mike Rapoport <rppt@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 1, 2022 at 2:58 PM David Laight <David.Laight@aculab.com> wrote:
>
> Can it be resolved by making:
> #define list_entry_is_head(pos, head, member) ((pos) == NULL)
> and double-checking that it isn't used anywhere else (except in
> the list macros themselves).

Well, yes, except for the fact that then the name is entirely misleading...

And somebody possibly uses it together with list_first_entry() etc, so
it really is completely broken to mix that change with the list
traversal change.

             Linus

               Linus
