Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4A0C2D0CD
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 19:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7E0206D8
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 19:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HB5BhhAT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7E0206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B126EA63;
	Wed, 18 Dec 2019 19:43:52 +0000 (UTC)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C43B46EA5D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 19:33:46 +0000 (UTC)
Received: by mail-lj1-x241.google.com with SMTP id j6so3456850lja.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 11:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nkv/j0DmOufir99TeJBSwrc+MG8sCcIZ06VqqtU6qj4=;
 b=HB5BhhATDpbdm4h+jVarT9wg6GBJI7KN8S7Moxw6piTnQ1m9cOBJIQS/PaCI6gTwMC
 KcFBk1wxizpJ2F1l9fk+BZCervlQw4eLP6hIx3WTFqvuEuuqo1YSkFlmKAawJkGux2PE
 vW9q2+l9GY9Z481m0TD7EghEJOC9eulnbmi7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nkv/j0DmOufir99TeJBSwrc+MG8sCcIZ06VqqtU6qj4=;
 b=M85dEHwi2Z8FHKCLoeIpLzpuD3sjPvmRNTdOT0IPnOhhvRaEv9MemRVAVCHDe1cuR4
 bfI4LxChI0p7py9hEyvJPTYTjM0Pb/FYVJsZoeeZA6vYdLmhrInC5JVKQTMhEQGYr4o/
 E5+OOSmR0oV/1LozSDrfJzVZ3O4Be/97BszTlk82Ucac3h3pOH+ruyWBqIKACTKO0e5y
 9rkDhmYcFXKWdgfuvo1AxWypOqO7gNKNpexw8YBfI0GkkSAl+1Vskbd6NyQ0msgb+fOp
 eQPoaYe7sa5IEVlB6QZj1cEWTrl/PyRE01/ukzLf92KDiV15BdZcigscG6D4iJYTQ9dt
 chWw==
X-Gm-Message-State: APjAAAVvaAhz8ukaF/0GfkdrDEdpRLEqzVWF5Sn+bQCoRtYEL8pq1C39
 O/e5sKMFs78RK9X9Qnxw4HJx35xhCKc=
X-Google-Smtp-Source: APXvYqxo0RQgLedp9PjPlT98h+Sxe5uAIhrTY6LIGYVfVfo8ubXRTA+NNuehlIt433+4rrC+g3qi/A==
X-Received: by 2002:a05:651c:20a:: with SMTP id
 y10mr3121553ljn.216.1576697624759; 
 Wed, 18 Dec 2019 11:33:44 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com.
 [209.85.167.53])
 by smtp.gmail.com with ESMTPSA id p12sm1589436lfc.43.2019.12.18.11.33.41
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 11:33:42 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 15so2562118lfr.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 11:33:41 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr2827166lfk.52.1576697621256; 
 Wed, 18 Dec 2019 11:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20191125204248.GA2485@ziepe.ca>
 <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
 <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
 <20191203024206.GC5795@mellanox.com> <20191205160324.GB5819@redhat.com>
 <20191211225703.GE3434@mellanox.com>
 <20191213101916.GD624164@phenom.ffwll.local>
 <20191218145913.GO16762@mellanox.com>
 <CAHk-=wgR7OSE9Bn2+MbOYDbiu7n1RQaQhdc6gkEywXL9rMFcpw@mail.gmail.com>
 <20191218183704.GT16762@mellanox.com>
In-Reply-To: <20191218183704.GT16762@mellanox.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Dec 2019 11:33:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=9MNwP6gAqhMZ+T7GBVCt-VZyw8qb-i_eXQ61izBKrA@mail.gmail.com>
Message-ID: <CAHk-=wh=9MNwP6gAqhMZ+T7GBVCt-VZyw8qb-i_eXQ61izBKrA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull hmm changes
To: Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Approved-At: Wed, 18 Dec 2019 19:43:50 +0000
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
Cc: Ralph Campbell <rcampbell@nvidia.com>, David Airlie <airlied@linux.ie>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@lst.de>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 Jerome Glisse <jglisse@redhat.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 18, 2019 at 10:37 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> I think this is what you are looking for?

I think that with these names, I would have had an easier time reading
the original patch that made me go "Eww", yes.

Of course, now that it's just a rename patch, it's not like the patch
is all that legible, but yeah, I think the naming is saner.

              Linus
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
