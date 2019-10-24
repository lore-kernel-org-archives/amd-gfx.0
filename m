Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA8ECA9EA0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 08:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309C4206DD
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 08:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309C4206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08C16E90D;
	Fri, 25 Oct 2019 08:12:42 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2377C6E5F0;
 Thu, 24 Oct 2019 18:46:28 +0000 (UTC)
Received: from localhost (unknown [75.104.69.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D08A420659;
 Thu, 24 Oct 2019 18:46:26 +0000 (UTC)
Date: Thu, 24 Oct 2019 14:46:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] Cleanup: replace prefered with preferred
Message-ID: <20191024184619.GB260560@kroah.com>
References: <20191022214208.211448-1-salyzyn@android.com>
 <20191023115637.GA23733@linux.intel.com>
 <fa12cb96-7a93-bf85-214d-a7bfaf8b8b0a@android.com>
 <875zkecosr.fsf@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875zkecosr.fsf@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Mailman-Approved-At: Fri, 25 Oct 2019 08:12:41 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1571942787;
 bh=LcyuoGg9oQj2WX2v7tCYiF0gA66s4qp8WOPNh6Xx7QE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CbyBTNu2fVYsik/kCROL/cnq39RKtShNVeJoYppp1ZSAP3n/kz95S8eff/ReQnyUf
 8y2Q8nmnO/d6RIlNdvHv/04IF/+Cz4wPj3HZs7fMDGoIX0E4qYRcI85rRfKl+V5oPH
 srzrOAG66fo+khOjey6zl8LLwlgbCg8yIC0yGnao=
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
Cc: Alexander Aring <alex.aring@gmail.com>, linux-efi@vger.kernel.org,
 Linus =?iso-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Feng Tang <feng.tang@intel.com>,
 Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Roman Li <Roman.Li@amd.com>,
 "David S. Miller" <davem@davemloft.net>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, netdev@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Rafael Aquini <aquini@redhat.com>,
 "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Thomas Hellstrom <thellstrom@vmware.com>, Jonathan Corbet <corbet@lwn.net>,
 Francesco Ruggeri <fruggeri@arista.com>,
 Matthew Garrett <matthewgarrett@google.com>, amd-gfx@lists.freedesktop.org,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 Harry Wentland <harry.wentland@amd.com>, linux-media@vger.kernel.org,
 Leo Li <sunpeng.li@amd.com>, "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>,
 Hans de Goede <hdegoede@redhat.com>, hersen wu <hersenxs.wu@amd.com>,
 dri-devel@lists.freedesktop.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, kernel-team@android.com,
 Maxim Martynov <maxim@arista.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mark Salyzyn <salyzyn@android.com>,
 linux-bluetooth@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 David Ahern <dsahern@gmail.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org,
 Anna Schumaker <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191024184619.DBuJWvKpdi3EA2yghbrvsmVWjxUs7bi2zIjNYAz2Efg@z>

T24gVGh1LCBPY3QgMjQsIDIwMTkgYXQgMDM6MjY6MjhQTSArMDMwMCwgSmFuaSBOaWt1bGEgd3Jv
dGU6Cj4gT24gV2VkLCAyMyBPY3QgMjAxOSwgTWFyayBTYWx5enluIDxzYWx5enluQGFuZHJvaWQu
Y29tPiB3cm90ZToKPiA+IEkgd2lsbCBzcGxpdCB0aGlzIGJldHdlZW4gcHVyZSBhbmQgaW5lcnQg
ZG9jdW1lbnRhdGlvbi9jb21tZW50cyBmb3Igbm93LCAKPiA+IHdpdGggYSBmb2xsb3d1cCBsYXRl
ciBmb3IgdGhlIGNvZGUgcG9ydGlvbiB3aGljaCB1bmRlcnN0YW5kYWJseSBpcyBtb3JlIAo+ID4g
Y29udHJvdmVyc2lhbC4KPiAKPiBQbGVhc2Ugc3BsaXQgYnkgZHJpdmVyL3N1YnN5c3RlbSB0b28s
IGFuZCBpdCdsbCBiZSBhbGwgYXJvdW5kIG11Y2gKPiBlYXNpZXIgZm9yIGV2ZXJ5b25lLgoKSSBh
Z3JlZSwgc3BlbGxpbmcgZml4ZXMgYXJlIHRyaXZpYWwgYW5kIHNob3VsZCBnbyBpbiBwZXItc3Vi
c3lzdGVtLgoKdGhhbmtzLAoKZ3JlZyBrLWgKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4
