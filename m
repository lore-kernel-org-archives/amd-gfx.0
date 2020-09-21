Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A09EC43465
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 16:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 998B4206B2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 16:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998B4206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=porcupinefactory.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33A616E06D;
	Mon, 21 Sep 2020 16:45:31 +0000 (UTC)
X-Greylist: delayed 498 seconds by postgrey-1.36 at gabe;
 Mon, 21 Sep 2020 16:39:18 UTC
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1CB6E4F3;
 Mon, 21 Sep 2020 16:39:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by comms.puri.sm (Postfix) with ESMTP id 442CBDF6E2;
 Mon, 21 Sep 2020 09:30:29 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
 by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XnmnsU6MQcby; Mon, 21 Sep 2020 09:30:27 -0700 (PDT)
Date: Mon, 21 Sep 2020 18:30:21 +0200
From: DorotaC <xofofu.dcz@porcupinefactory.org>
To: Samuel Iglesias =?UTF-8?B?R29uc8OhbHZleg==?= <siglesias@igalia.com>
Subject: Re: XDC 2020 feedback and comments
Message-ID: <20200921183016.670ce6a6.dorota.czaplejewicz@puri.sm>
In-Reply-To: <4eaa69879014a406424b9702dd6574a305f4c98e.camel@igalia.com>
References: <4eaa69879014a406424b9702dd6574a305f4c98e.camel@igalia.com>
Organization: Purism
X-Mailman-Approved-At: Mon, 21 Sep 2020 16:45:29 +0000
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
Cc: "xorg-devel@lists.freedesktop.org" <xorg-devel@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "etnaviv@lists.freedesktop.org" <etnaviv@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>,
 "board@foundation.x.org" <board@foundation.x.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "events@lists.x.org" <events@lists.x.org>,
 "mesa-dev@lists.freedesktop.org" <mesa-dev@lists.freedesktop.org>,
 "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCAyMSBTZXAgMjAyMCAxMDowMzozMiArMDIwMApTYW11ZWwgSWdsZXNpYXMgR29uc8Oh
bHZleiA8c2lnbGVzaWFzQGlnYWxpYS5jb20+IHdyb3RlOgoKPiBIaSBhbGwsCj4gCj4gSHVnZSB0
aGFua3MgYWdhaW4gdG8gdGhlIGVudGlyZSB0ZWFtIGZyb20gSW50ZWwsIGZvciB0aGVpciBncmVh
dCB3b3JrCj4gb3JnYW5pemluZyBYREMgMjAyMCwgb3VyIGZpcnN0IHZpcnR1YWwgY29uZmVyZW5j
ZSEKPiAKPiBBcyB1c3VhbCB3ZSdyZSBsb29raW5nIGZvciBmZWVkYmFjayBvbiBib3RoIFhEQyBp
dHNlbGYsIGFuZCB0aGUgQ0ZQCj4gcHJvY2VzcyBhbmQgcHJvZ3JhbSBzZWxlY3Rpb24uIEJvdGgg
YWJvdXQgd2hhdCB3YXMgZ3JlYXQgYW5kIHNob3VsZCBiZQo+IGtlcHQgZm9yIG5leHQgeWVhcidz
IGVkaXRpb24sIGFuZCB3aGVyZSB0aGVyZSdzIHJvb20gZm9yIGltcHJvdmVtZW50Lgo+IAo+IFRo
ZSBib2FyZCBkb2VzIGtlZXAgc29tZSBub3RlcywgZm9yIHRob3NlIGludGVyZXN0ZWQgaW4gd2hh
dCB3ZSBoYXZlCj4gYWxyZWFkeToKPiAKPiAtIFhEQyBub3RlcyBmb3IgcHJvc3BlY3RpdmUgb3Jn
YW5pemVyczogCj4gaHR0cHM6Ly93d3cueC5vcmcvd2lraS9FdmVudHMvUkZQLwo+IAo+IC0gQ0ZQ
IG5vdGVzOiBodHRwczovL3d3dy54Lm9yZy93aWtpL0V2ZW50cy9QYXBlcnNDb21taXR0ZWUvCj4g
Cj4gSWYgeW91IHdhbnQgdG8gc2VuZCBpbiB5b3VyIGNvbW1lbnRzIGluIHByaXZhdGUsIHBsZWFz
ZSBzZW5kIHRoZW0gdG8KPiB0aGUgWC5vcmcgRm91bmRhdGlvbiBib2FyZDogYm9hcmRAZm91bmRh
dGlvbi54Lm9yZwo+IAo+IENoZWVycywKPiAKPiBTYW0KCkhpIFNhbSwKCkknZCBsaWtlIHRvIG1h
a2UgYSBub3RlIGFib3V0IHVzaW5nIHNvbWUgbW9yZSBwcml2YWN5LWZyaWVuZGx5IHN0cmVhbWlu
ZyBwbGF0Zm9ybS4KCldoZW4gSSB0cmllZCB0byB3YXRjaCB0aGUgc3RyZWFtcywgaW5zdGVhZCBv
ZiBzaG93aW5nIHRoZSB2aWRlbywgeW91dHViZSBwcmVzZW50ZWQgbWUgd2l0aCBhIEdEUFIgZGlh
bG9nLgoKV2hpbGUgaXQgd2FzIGdsaXRjaGVkIGFuZCB1bnNraXBwYWJsZSBmb3IgbWUsIGp1c3Qg
dGhlIGZhY3QgdGhhdCBHb29nbGUgbWFkZSBpdCBub24tb3B0aW9uYWwgc2hvd3MgdGhlaXIgZGlz
cmVnYXJkIGZvciBteSBwcml2YWN5IChhbmQsIElNTywgdGhlIGxldHRlciBvZiBsYXcsIHdoaWNo
IG1hbmRhdGVzIG9wdC1pbikuIFVuZm9ydHVuYXRlbHksIEkgd2Fzbid0IGFibGUgdG8gZXZhbHVh
dGUgdGhlIGRpYWxvZydzIGNvbnRlbnRzIGR1ZSB0byB0aGUgZ2xpdGNoLCBidXQgb25saW5lIHJl
cG9ydHMgc3VnZ2VzdCB0aGV5IGFyZSBzaW1pbGFybHkgaWdub3JhbnQuIEFsbCBpbiBhbGwsIEkg
b25seSBhY2Nlc3MgeW91dHViZSB2aWEgeW91dHViZS1kbCBhbnkgbW9yZSwgYW5kIHRoYXQgZG9l
c24ndCBzdXBwb3J0IHN0cmVhbWluZy4KCldoZW4gYXR0ZW5kaW5nIEFrYWRlbXkgMiB3ZWVrcyBh
Z28sIHRoZXkgaGFkIGEgc2V0dXAgYmFzZWQgb24gQmlnQmx1ZUJ1dHRvbiB0aGF0IHdvcmtlZCB3
ZWxsIHdpdGhvdXQgdGhhdCBzb3J0IG9mIGlzc3Vlcy4KCkNoZWVycywKRG9yb3RhCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
