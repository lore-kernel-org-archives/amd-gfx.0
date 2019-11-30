Return-Path: <SRS0=vS0Q=ZX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713BFC432C3
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Dec 2019 13:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CCB2071F
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Dec 2019 13:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CCB2071F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD07089E86;
	Sun,  1 Dec 2019 13:33:14 +0000 (UTC)
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com
 [IPv6:2a00:1450:4864:20::241])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 090056E158
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 18:04:20 +0000 (UTC)
Received: by mail-lj1-x241.google.com with SMTP id m6so27871570ljc.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 10:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KeWj67j7t721qCfI+6RxBQ+EmlY5X5BSvtw/QcsnMlI=;
 b=tjRVYfOw2C+H67KUUgBsSlvZYZipvciu4Ev8gZb+raT0F5hclN9hhQNNVkn9XUXmFY
 vMI9NBy2759IcSb+mUoox61SfGuvke88DW3ZsB1gEqfccbaPVjbHS83WSs0QO1s6P6bn
 TKyzbBwQkmL3AXbPlf8x5LM1uv3LcP3oj0GP7ocufVTy30Go+gcfwQ3iYCXuPSenMiyp
 G6zmHic+3GFgi2P/HCBta41ywrCWwrVlC8cKDFsOVOBvFD5AGTKfiYeSMfSWZ2brH0G8
 9h7jUGcyu42f/WLnTszLLD4Dj6ZzEfyQulCdfTE8YI0C0v0DLXhgcpxK92lOz6FZj2TN
 pSgQ==
X-Gm-Message-State: APjAAAVIg06zINNSInS5Uhr4ZO5FGG+6++BUD5wOs/sIaTwZOo5hhD4E
 IuFYv70I4c7psa/Y3u9WiSXPuXHuuJY=
X-Google-Smtp-Source: APXvYqxVMhWmOColsp3fUP20UqVdm3FO6IocwFozgBhL2ul2kakHQtF2uo3rXuUR5CxPxRViPRPwtA==
X-Received: by 2002:a05:651c:326:: with SMTP id
 b6mr41072355ljp.119.1575137057247; 
 Sat, 30 Nov 2019 10:04:17 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com.
 [209.85.167.51])
 by smtp.gmail.com with ESMTPSA id u4sm12018713ljj.87.2019.11.30.10.04.08
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2019 10:04:09 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 203so24842346lfa.12
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Nov 2019 10:04:08 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr4691328lfk.52.1575137048166; 
 Sat, 30 Nov 2019 10:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20191125204248.GA2485@ziepe.ca>
In-Reply-To: <20191125204248.GA2485@ziepe.ca>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Nov 2019 10:03:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
Message-ID: <CAHk-=wiqguF5NakpL4L9XCmmYr4wY0wk__+6+wHVReF2sVVZhA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull hmm changes
To: Jason Gunthorpe <jgg@mellanox.com>
X-Mailman-Approved-At: Sun, 01 Dec 2019 13:33:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=KeWj67j7t721qCfI+6RxBQ+EmlY5X5BSvtw/QcsnMlI=;
 b=XsL2lb1FqLtCS9t+CqPorBjTDZfJvIvGqBi0ylnknkqqXQseOaRQaOWu/tb9DhKJzR
 x7ytWVqaMqaxS+rJJogCAe5sHqKPDP9Yxts6Nqc2xTQdGcrm2XMQYmSAm7Z8PBly5old
 FXQc3INX/SwS53DN6wz/J5itJUXkelIOzYTsQ=
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
bGFub3guY29tPiB3cm90ZToKPgo+IFlvdSB3aWxsIHByb2JhYmx5IGJlIG1vc3QgaW50ZXJlc3Rl
ZCBpbiB0aGUgcGF0Y2ggIm1tL21tdV9ub3RpZmllcjogYWRkIGFuCj4gaW50ZXJ2YWwgdHJlZSBu
b3RpZmllciIuCgpJJ20gdHJ5aW5nIHRvIHJlYWQgdGhhdCBwYXRjaCwgYW5kIEknbSBjb21wbGV0
ZWx5IHVuYWJsZSB0byBieSB0aGUKYWJzb2x1dGVseSAqaG9ycmlkKiB2YXJpYWJsZSBuYW1lcy4K
ClRoZXJlIGFyZSB6ZXJvIGV4Y3VzZXMgZm9yIG5hbWVzIGxpa2UgIm1tbl9tbSIuIFdURj8KCkkn
bGwgdHJ5IHRvIGZpZ3VyZSB0aGUgY29kZSBvdXQsIGJ1dCBteSBpbml0aWFsIHJlYWN0aW9uIHdh
cyAieWVhaCwKbm90IGluIG15IFZNIi4KCiAgICAgICAgICAgICAgICAgICBMaW51cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
