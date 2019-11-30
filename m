Return-Path: <SRS0=vS0Q=ZX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F342C432C0
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Dec 2019 13:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF162071F
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Dec 2019 13:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF162071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D353E89EBD;
	Sun,  1 Dec 2019 13:33:14 +0000 (UTC)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com
 [IPv6:2a00:1450:4864:20::142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1DF6E170
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 18:36:04 +0000 (UTC)
Received: by mail-lf1-x142.google.com with SMTP id r15so21962798lff.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 10:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Irn5UBlraoC6oNG6oHJ0v3sniaA47hfP9JyZ+OOZ5YQ=;
 b=Fg1l2PpDJ9gfdEAcn8jJPxCEqSM0lmzUSiits1Nu7uCu+DuoAdHYf33xD+SZylYLcy
 +g1csTK7GLbDGUx3CZpsIZ9eLHr2o+1iNggNlYg678Y5EDItqA6qgaRhmAD9PqRJshcJ
 4zpb0WlZES1NUlSPoZlA0lM9bANqRjqdwd8rPKAt5a6xeU0Lbcbhi6/aH5hSmG9JvGEl
 olHmxEznk9fE/pRd5G7yzJS/w7hCsQ0Z4mhq5qQnLk8qmgZPnKnkttRaW4g3mKg621FT
 W6P15HUy2XKwliszeB9VezTaF6Nre0/Yn3t2SfuCq7Y4zc6kVazvvnMZuUsa6K8aIisz
 5sjg==
X-Gm-Message-State: APjAAAUFT+kew1xuWpwzM5etMnSa0mvfCtrurH9d7eF8v6yjztqVd5w/
 CCPyENHzNLvU6xeRwrWvUxuYQuIKBA8=
X-Google-Smtp-Source: APXvYqwJjdnZV22//1z8pfts5u3mLfZkxyCzxvsWGqYoNNVNv0icEERHtaIW7t2y8Q7Y4MAYkKCXaw==
X-Received: by 2002:a19:c697:: with SMTP id w145mr34234715lff.54.1575138962437; 
 Sat, 30 Nov 2019 10:36:02 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177])
 by smtp.gmail.com with ESMTPSA id x64sm7075780ljb.39.2019.11.30.10.36.01
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2019 10:36:01 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id e10so26114385ljj.6
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 10:36:01 -0800 (PST)
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr28337844ljj.1.1575138960919; 
 Sat, 30 Nov 2019 10:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20191125204248.GA2485@ziepe.ca>
In-Reply-To: <20191125204248.GA2485@ziepe.ca>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2019 10:35:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgLUF3zZzTgaAM+JQu6T7MWdXLZUDgXodSZxSv0TMNCmw@mail.gmail.com>
Message-ID: <CAHk-=wgLUF3zZzTgaAM+JQu6T7MWdXLZUDgXodSZxSv0TMNCmw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull hmm changes
To: Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Approved-At: Sun, 01 Dec 2019 13:33:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=Irn5UBlraoC6oNG6oHJ0v3sniaA47hfP9JyZ+OOZ5YQ=;
 b=DqePDF5z5ErRyWSeEgVaSsv8stVnpuBr+ZgPAs/bxB2P6a9Q83YgJNJKigI+qKzX7l
 d1ItFUaSCRwJc7UUmQ1puXVuXuwv0D/q5PC8EPzfuJQ/gVPTSHLlpdwz/uBl8j4dRAmh
 vp3NOQ7crMVKbNTlP5JnOPAY9FVhRRSy9edd8=
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

T24gTW9uLCBOb3YgMjUsIDIwMTkgYXQgMTI6NDIgUE0gSmFzb24gR3VudGhvcnBlIDxqZ2dAbWVs
bGFub3guY29tPiB3cm90ZToKPgo+IEhlcmUgaXMgdGhpcyBiYXRjaCBvZiBobW0gdXBkYXRlcywg
SSB0aGluayB3ZSBhcmUgbmVhcmluZyB0aGUgZW5kIG9mIHRoaXMKPiBwcm9qZWN0IGZvciBub3cs
IGFsdGhvdWdoIEkgc3VzcGVjdCB0aGVyZSB3aWxsIGJlIHNvbWUgbW9yZSBwYXRjaGVzIHJlbGF0
ZWQgdG8KPiBobW1fcmFuZ2VfZmF1bHQoKSBpbiB0aGUgbmV4dCBjeWNsZS4KCkkndmUgZW5kZWQg
dXAgcHVsbGluZyB0aGlzLCBidXQgSSdtIG5vdCBlbnRpcmVseSBoYXBweSB3aXRoIHRoZSBjb2Rl
LgpZb3UndmUgYWxyZWFkeSBzZWVuIHRoZSBjb21tZW50cyBvbiBpdCBpbiB0aGUgZWFybGllciBy
ZXBsaWVzLgoKICAgICAgICAgICAgTGludXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
