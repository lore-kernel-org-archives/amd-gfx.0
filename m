Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D00C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 17:27:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C1B20717
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IQ/5SIJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C1B20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D43B6E9B9;
	Wed, 18 Dec 2019 17:27:42 +0000 (UTC)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF1C89B70
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 16:53:26 +0000 (UTC)
Received: by mail-lf1-x143.google.com with SMTP id 15so2215752lfr.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 08:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3qRY5XWsuCN6n8xU9fQoJH+pjwO3CHxgP4k/GmBdPYo=;
 b=IQ/5SIJ292ei03NolmBfEocYNplOmoBhNP+TWlRlx+4myoE2yY3tCOpuPqX84ODewr
 ZxIOOBR4eB7XLKzlxlNHA06k/cN6HUup8nG4oOWMpGflrWzw93Hd0PHehXWWyDZ6ZG3V
 w6hWLdp59SrCGRimV2hdbFAi3ES7UIYg62ve8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3qRY5XWsuCN6n8xU9fQoJH+pjwO3CHxgP4k/GmBdPYo=;
 b=Xx70UTwt3/Il6Q0VbTzY12Z61sZxbojLyxqLv5mGla/c6dAD3YefPQDNh7hSMxtllC
 rJxSBMT7kZ1D4dcKKJkWg4VLWwMFTHZW203qzqwQcyMKOB8n8SHabnB4LweO3YRV5GuJ
 y7jrcgoPHBH7Bbu0Q/qtXTH/D+HSeKnBe29ywik7hM1+Sftfz2MY22hty3m0O+l66zl7
 1pQ9Z1r2tnin77WktymgZoElqPXn9PvASzluDffFgbxN5WFcAyywuDfEX2atFdZpAXr0
 BZQvGmND9o6vMLxhVMFxaBx5xbdicrff9+NtWGl9NQB+nbskYABepBuxsrkg99ZTHor5
 J77Q==
X-Gm-Message-State: APjAAAUL5ovsfug6AbAidl4YOvXnwfkVo+vpF/7GNKk+QrAHqrnMVwUv
 u3iT+SsCxycS1sksFD0dwFAs+gvcN5g=
X-Google-Smtp-Source: APXvYqwXRsixO0NCOA51lqzPtJVcj1hDbMhvYJXC9B/3QLb/fIkQ6QJFkKhSO39ZqMc/7RVq0OxYDA==
X-Received: by 2002:a19:2389:: with SMTP id j131mr2320913lfj.86.1576688003748; 
 Wed, 18 Dec 2019 08:53:23 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181])
 by smtp.gmail.com with ESMTPSA id w19sm1413174lfl.55.2019.12.18.08.53.22
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 08:53:22 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id k1so2269509ljg.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 08:53:22 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr2508178ljg.133.1576688001995; 
 Wed, 18 Dec 2019 08:53:21 -0800 (PST)
MIME-Version: 1.0
References: <20191125204248.GA2485@ziepe.ca>
 <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
 <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
 <20191203024206.GC5795@mellanox.com> <20191205160324.GB5819@redhat.com>
 <20191211225703.GE3434@mellanox.com>
 <20191213101916.GD624164@phenom.ffwll.local>
 <20191218145913.GO16762@mellanox.com>
In-Reply-To: <20191218145913.GO16762@mellanox.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Dec 2019 08:53:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgR7OSE9Bn2+MbOYDbiu7n1RQaQhdc6gkEywXL9rMFcpw@mail.gmail.com>
Message-ID: <CAHk-=wgR7OSE9Bn2+MbOYDbiu7n1RQaQhdc6gkEywXL9rMFcpw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull hmm changes
To: Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Approved-At: Wed, 18 Dec 2019 17:27:41 +0000
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

On Wed, Dec 18, 2019 at 6:59 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> Do you think calling it 'mmn_subscriptions' is clear?

Why do you want that "mmn"?

Guys, the "mmn" part is clear from the _context_. The function name is

When the function name is something like "mmu_interval_read_begin()",
and the filename is "mm/mmu_notifier.c", you do NOT NEED silly
prefixes like "mmn" for local variables.

They add NOTHING.

And they make the code an illegible mess.

Yes, global function names need to be unique, and if they aren't
really core, they want some prefix that explains the context, because
global functions are called from _outside_ the context that explains
them.

But if it's a "struct mmu_interval_notifier" pointer, and it's inside
a file that is all about these pointers, it shouldn't be called
"mmn_xyz".  That's not a name. That's line noise.

So call it a "notifier". Maybe even an "interval_notifier" if you
don't mind the typing. Name it by something _descriptive_. And if you
want.

And "subscriptions" is a lovely name. What does the "mmn" buy you?

Just to clarify: the names I really hated were the local variable
names (and the argument names) that were all entirely within the
context of mm/mmu_notifier.c. Calling something "mmn_mm" is a random
jumble of letters that looks more like you're humming than you're
speaking.

Don't mumble. Speak _clearly_.

The other side of "short names" is that some non-local conventions
exist because they are _so_ global. So if it's just a mm pointer, call
it "mm". We do have some very core concepts in the kernel that
permeate _everything_, and those core things we tend to have very
short names for. So whenever you're working with VM code, you'll see
lots of small names like "mm", "vma", "pte" etc. They aren't exactly
clear, but they are _globally_ something you read and learn when you
work on the Linux VM code.

That's very diofferent from "mmn" - the "mmn" thing isn't some global
shorthand, it is just a local abomination.

So "notifier_mm" makes sense - it's the mm for a notifier. But
"mmn_notifier" does not, because "mmn" only makes sense in a local
context, and in that local context it's not any new information at
all.

See the difference? Two shorthands, but one makes sense and adds
information, while the other is just unnecessary and pointless and
doesn't add anything at all.

                Linus
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
