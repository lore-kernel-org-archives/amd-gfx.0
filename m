Return-Path: <SRS0=vS0Q=ZX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F5AC432C0
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Dec 2019 13:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B1A2071F
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Dec 2019 13:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B1A2071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7C1C89E4C;
	Sun,  1 Dec 2019 13:33:14 +0000 (UTC)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832896E158
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 18:23:52 +0000 (UTC)
Received: by mail-lf1-x142.google.com with SMTP id r15so21950182lff.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 10:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u0JfrhdDhzTetmUD+84kClCBoBttknwfKi4pRj2979M=;
 b=cg5utWue/SiMBuBaJnGRg6K+hsAjcLc8XyUTe2wvMh60dPX382imSXDtusLYJ8q601
 1zuCMUoLlQcYETR5n+NC99r7chtiCOTyKT5yeElTNgVWXXF1LDYXtoPLv7xmE67LRM3/
 KRLCW2swJlHHvDHVZ1A3y84ZgIftAHbxSBUCdnewzTjxVSyWlsEs80XjjIcd2tt9TU/d
 +9YUQvdOeuatGd/wmUfJbjaoLqBk2Pl+Nah8eifzptwp3Q+Qy/yWGHkGVDgiSCQZ4lJ4
 hcroIJPe5ZGa14nL1CWGWHRRJi2RXFprv5dCBfS/EODKxhSW/QP4Ra+0FvRhiFPZVPgl
 lx5w==
X-Gm-Message-State: APjAAAVlUU8IG0g6AuhaK/8Zs4b4kLGU3/Tpxc1DYW1LwRqJ7dbTAOZu
 8hD/nzGCAHKREfaTlqGIMl7dAT64b3I=
X-Google-Smtp-Source: APXvYqzV5DtswCK51euY1bWQ5KpN3rJ70hBrtdCLEpPN5o+W8rtavNsFHCJDsFrxXVa6XIKN44mySQ==
X-Received: by 2002:a19:2213:: with SMTP id i19mr7888058lfi.83.1575138230399; 
 Sat, 30 Nov 2019 10:23:50 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com.
 [209.85.167.44])
 by smtp.gmail.com with ESMTPSA id v7sm7573518lfa.10.2019.11.30.10.23.47
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2019 10:23:48 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id b15so675363lfc.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 10:23:47 -0800 (PST)
X-Received: by 2002:a19:4bd4:: with SMTP id y203mr36767338lfa.61.1575138227505; 
 Sat, 30 Nov 2019 10:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20191125204248.GA2485@ziepe.ca>
 <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
In-Reply-To: <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2019 10:23:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
Message-ID: <CAHk-=wiQtTsZfgTwLYgfV8Gr_0JJiboZOzVUTAgJ2xTdf5bMiw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull hmm changes
To: Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Approved-At: Sun, 01 Dec 2019 13:33:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=u0JfrhdDhzTetmUD+84kClCBoBttknwfKi4pRj2979M=;
 b=bf0MgGTip6d1PItDL8VGeE1qaDY/j9ixz0qpAQkf5F6v9M5aNPOpI4jjr2XPxAxhcA
 GJKbY/6+tUCS+LVQS13ljyhVcfEbxwb3tv5e7NTZlJijMtJ6r3T+eylFOA0z7JAlzHKn
 R52/jRzjHqCo8LV/hAE+usMuZz8TLO3DZuEW4=
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gU2F0LCBOb3YgMzAsIDIwMTkgYXQgMTA6MDMgQU0gTGludXMgVG9ydmFsZHMKPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToKPgo+IEknbGwgdHJ5IHRvIGZpZ3VyZSB0aGUg
Y29kZSBvdXQsIGJ1dCBteSBpbml0aWFsIHJlYWN0aW9uIHdhcyAieWVhaCwKPiBub3QgaW4gbXkg
Vk0iLgoKV2h5IGlzIGl0IG9rIHRvIHNvbWV0aW1lcyBkbwoKICAgIFdSSVRFX09OQ0UobW5pLT5p
bnZhbGlkYXRlX3NlcSwgY3VyX3NlcSk7CgoodG8gcGFpciB3aXRoIHRoZSB1bmxvY2tlZCBSRUFE
X09OQ0UpLCBhbmQgc29tZXRpbWVzIHRoZW4gZG8KCiAgICBtbmktPmludmFsaWRhdGVfc2VxID0g
bW1uX21tLT5pbnZhbGlkYXRlX3NlcTsKCk15IGluaXRpYWwgZ3Vlc3Mgd2FzIHRoYXQgbGF0dGVy
IGlzIG9ubHkgZG9uZSBhdCBpbml0aWFsaXphdGlvbiB0aW1lLApidXQgYXQgbGVhc3QgaW4gb25l
IGNhc2UgaXQncyBkb25lICphZnRlciogdGhlIG1uaSBoYXMgYmVlbiBhZGRlZCB0bwp0aGUgbW1u
X21tIChvaCwgaG93IEkgZGVzcGlzZSB0aG9zZSBuYW1lcyAtIEkgY2FuIG9ubHkgcmVwZWF0OiBX
VEY/KS4KClNlZSBfX21tdV9pbnRlcnZhbF9ub3RpZmllcl9pbnNlcnQoKSBpbiB0aGUKbW1uX21t
LT5hY3RpdmVfaW52YWxpZGF0ZV9yYW5nZXMgY2FzZS4KCkknbSBndWVzc2luZyB0aGF0IGl0IGRv
ZXNuJ3QgbWF0dGVyLCBiZWNhdXNlIHdoZW4gaW5zZXJ0aW5nIHRoZQpub3RpZmllciB0aGUgc2Vx
dWVuY2UgbnVtYmVyIGlzIHByZXN1bWFibHkgbm90IHVzZWQgdW50aWwgYWZ0ZXIgdGhlCmluc2Vy
dGlvbiAoYW5kIGFueSB1c2UgdGhvdWdoIG1tbl9tbSBpcyBwcm90ZWN0ZWQgYnkgdGhlCm1tbl9t
bS0+bG9jayksIGJ1dCBpdCBzdGlsbCBsb29rcyBvZGQgdG8gbWUuCgogICAgICAgICAgICAgICBM
aW51cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
