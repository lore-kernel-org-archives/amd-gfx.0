Return-Path: <SRS0=Gnzf=YR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2124BCA9EAF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 07:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC92E20856
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2019 07:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC92E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB2D66E10F;
	Thu, 24 Oct 2019 07:31:05 +0000 (UTC)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E016EA53;
 Wed, 23 Oct 2019 11:56:53 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Oct 2019 04:56:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; d="scan'208";a="201968405"
Received: from jsakkine-mobl1.tm.intel.com (HELO localhost) ([10.237.50.121])
 by orsmga006.jf.intel.com with ESMTP; 23 Oct 2019 04:56:37 -0700
Date: Wed, 23 Oct 2019 14:56:37 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH] Cleanup: replace prefered with preferred
Message-ID: <20191023115637.GA23733@linux.intel.com>
References: <20191022214208.211448-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191022214208.211448-1-salyzyn@android.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Thu, 24 Oct 2019 07:31:04 +0000
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Airlie <airlied@linux.ie>, Feng Tang <feng.tang@intel.com>,
 dri-devel@lists.freedesktop.org, Roman Li <Roman.Li@amd.com>,
 "David S. Miller" <davem@davemloft.net>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, netdev@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Rafael Aquini <aquini@redhat.com>,
 "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Thomas Hellstrom <thellstrom@vmware.com>, Jonathan Corbet <corbet@lwn.net>,
 Francesco Ruggeri <fruggeri@arista.com>,
 Matthew Garrett <matthewgarrett@google.com>, amd-gfx@lists.freedesktop.org,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, kernel-team@android.com,
 linux-media@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
 "Steven Rostedt \(VMware\)" <rostedt@goodmis.org>,
 Hans de Goede <hdegoede@redhat.com>, hersen wu <hersenxs.wu@amd.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, linux-nfs@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Harry Wentland <harry.wentland@amd.com>, Maxim Martynov <maxim@arista.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anna Schumaker <anna.schumaker@netapp.com>, linux-bluetooth@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, David Ahern <dsahern@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Jukka Rissanen <jukka.rissanen@linux.intel.com>, linux-wpan@vger.kernel.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191023115637.w3Ge1kSs8bRCg19alXGXm1KYWztB_UIjesPumBTLYiY@z>

T24gVHVlLCBPY3QgMjIsIDIwMTkgYXQgMDI6NDE6NDVQTSAtMDcwMCwgTWFyayBTYWx5enluIHdy
b3RlOgo+IFJlcGxhY2UgYWxsIG9jY3VycmVuY2VzIG9mIHByZWZlcmVkIHdpdGggcHJlZmVycmVk
IHRvIG1ha2UgZnV0dXJlCj4gY2hlY2twYXRjaC5wbCdzIGhhcHB5LiAgQSBmZXcgcGxhY2VzIHRo
ZSBpbmNvcnJlY3Qgc3BlbGxpbmcgaXMKPiBtYXRjaGVkIHdpdGggdGhlIGNvcnJlY3Qgc3BlbGxp
bmcgdG8gcHJlc2VydmUgZXhpc3RpbmcgdXNlciBzcGFjZSBBUEkuCj4gCj4gU2lnbmVkLW9mZi1i
eTogTWFyayBTYWx5enluIDxzYWx5enluQGFuZHJvaWQuY29tPgoKSSdkIGZpeCBzdWNoIHRoaW5n
cyB3aGVuIHRoZSBjb2RlIGlzIG90aGVyd2lzZSBjaGFuZ2UgYW5kIHNjb3BlIHRoaXMKcGF0Y2gg
b25seSB0byBEb2N1bWVudGF0aW9uLy4gVGhlcmUgaXMgbm8gcHJhZ21hdGljIGJlbmVmaXQgb2Yg
ZG9pbmcKdGhpcyBmb3IgdGhlIGNvZGUuCgovSmFya2tvCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
