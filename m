Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791D0C3F2D4
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 17:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F2972469F
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 17:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F2972469F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2BCB6F4A6;
	Fri, 28 Feb 2020 17:51:39 +0000 (UTC)
X-Greylist: delayed 418 seconds by postgrey-1.36 at gabe;
 Fri, 28 Feb 2020 10:16:41 UTC
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2224F6EEC3;
 Fri, 28 Feb 2020 10:16:41 +0000 (UTC)
Received: by a3.inai.de (Postfix, from userid 25121)
 id 965F95A5D3EC3; Fri, 28 Feb 2020 11:09:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by a3.inai.de (Postfix) with ESMTP id 92BF860D82562;
 Fri, 28 Feb 2020 11:09:39 +0100 (CET)
Date: Fri, 28 Feb 2020 11:09:39 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
To: Daniel Stone <daniel@fooishbar.org>
Subject: Re: gitlab.fd.o financial situation and impact on services
In-Reply-To: <CAPj87rOhwLPGHaHvPrZ6j8zufO8VqiwNFoBGFjx95yHr3cBm3Q@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2002281033590.15553@n3.vanv.qr>
References: <CAKMK7uHHK2SsCfpmZwEUyTJJHsoccKoadoko3cEBOoYDFkmeAw@mail.gmail.com>
 <CAEdQ38Hr-L6rg80Gf18QNM7eK-QDK0BBU-9tChT6VxrP+T4qCw@mail.gmail.com>
 <CAPj87rOhwLPGHaHvPrZ6j8zufO8VqiwNFoBGFjx95yHr3cBm3Q@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 28 Feb 2020 17:51:34 +0000
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 intel-gfx <intel-gfx@lists.freedesktop.org>,
 "X.Org development" <xorg-devel@lists.x.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 wayland <wayland-devel@lists.freedesktop.org>,
 "X.Org Foundation Board" <board@foundation.x.org>,
 Xorg Members List <members@x.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Mesa Dev <mesa-dev@lists.freedesktop.org>, Matt Turner <mattst88@gmail.com>,
 gstreamer-devel@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIEZyaWRheSAyMDIwLTAyLTI4IDA4OjU5LCBEYW5pZWwgU3RvbmUgd3JvdGU6Cj4KPkkgYmVs
aWV2ZSB0aGF0IGluIEphbnVhcnksIHdlIGhhZCAkMjA4MiBvZiBuZXR3b3JrIGNvc3QgKGFsbW9z
dAo+ZW50aXJlbHkgZWdyZXNzOyBpbmdyZXNzIGlzIGJhc2ljYWxseSBmcmVlKSBhbmQgJDE3NTAg
b2YKPmNsb3VkLXN0b3JhZ2UgY29zdCAoYWxtb3N0IGFsbCBvZiB3aGljaCB3YXMgZG93bmxvYWQp
LiBUaGF0J3MgYmFzZWQKPm9uIDE2VEIgb2YgY2xvdWQtc3RvcmFnZSAoQ0kgYXJ0aWZhY3RzLCBj
b250YWluZXIgaW1hZ2VzLCBmaWxlCj51cGxvYWRzLCBHaXQgTEZTKSBlZ3Jlc3MgYW5kIDE3LjlU
QiBvZiBvdGhlciBlZ3Jlc3MgKHRoZSB3ZWIgc2VydmljZQo+aXRzZWxmLCByZXBvIGFjdGl2aXR5
KS4gUHJvamVjdGluZyB0aGF0IG91dCBbw5cxMiBmb3IgYSB5ZWFyXSBnaXZlcwo+dXMgcm91Z2hs
eSAkNDVrIG9mIG5ldHdvcmsgYWN0aXZpdHkgYWxvbmUsCgpJIGhhZCBjb21lIHRvIGEgc2ltaWxh
ciBjb25jbHVzaW9uIGEgZmV3IHllYXJzIGJhY2s6IEl0IGlzIG5vdCB2ZXJ5CmVjb25vbWljIHRv
IHJ1biBlcGhlbWVyZWFsIGJ1aWxkcm9vdHMgKGFuZCBhbnl0aGluZyBsaWtlIGl0KSBiZXR3ZWVu
CnR3byAob3IgbW9yZSkgInNpZ25pZmljYW50IGxvY2F0aW9ucyIgb2Ygd2hpY2ggb25lIGVuZCBp
cyBsb2NhdGVkIGluCmEgTGFyZ2UgQ2xvdWQgZGF0YWNlbnRlciBsaWtlIEVDMi9BV1MvZXRjLgoK
QXMgZm9yIHN1Y2ggdXNlY2FzZXMsIG1lIGFuZCBteSBzdXJyb3VuZGluZyBwZWVycyBoYXZlIHVz
ZWQgKG90aGVyKQpvZmZlcmluZ3Mgd2hlcmUgdGhlcmUgaXMgNTAgVEIgZnJlZSBuZXR3b3JrL21v
bnRoLCBhbmQgeWVzIHRoYXQgbWF5CmhhdmUgZW50YWlsZWQgZG9pbmcgbW9yZSBhZG1pbm5pbmcg
dGhhbiBlbHNld2hlcmUgLSBidXQgYW4gYWRtaW4gCmFwcHJlY2lhdGVzICQyMDAwIGEgbG90IG1v
cmUgdGhhbiBhIGNvcnBvcmF0aW9uLCB0b28uCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
