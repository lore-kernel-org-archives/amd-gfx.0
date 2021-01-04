Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEB5C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 18:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A88021D1B
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 18:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A88021D1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD9889F49;
	Mon,  4 Jan 2021 18:43:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D98A89F49
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609785820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNLy5/0ahaYESIt4m9/SiWAWGBWh2aMbN8tAlLCzpnY=;
 b=Ry1Eq5J2PzFpD46T7cUhgcfzBuMIvj2j7YoqT6ko/z7E+ZPRpoKcNA4+Sjgbet6mBYaYAc
 s0iSDUn+AgDN2n/LAZWv+An94YO5M4HRlwTsQoTXKGVGdhxBddmLpEz9Yq9s5RiodVlM9s
 QQOTs95p+ztDI6y0SIKjkHks+Yk6s1c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-ZvNG987rMEis-L9Thk1LQQ-1; Mon, 04 Jan 2021 13:43:37 -0500
X-MC-Unique: ZvNG987rMEis-L9Thk1LQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42C618026AA;
 Mon,  4 Jan 2021 18:43:36 +0000 (UTC)
Received: from omen.home (ovpn-112-183.phx2.redhat.com [10.3.112.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94F6560BE5;
 Mon,  4 Jan 2021 18:43:35 +0000 (UTC)
Date: Mon, 4 Jan 2021 11:43:35 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: Couple of issues with amdgpu on my WX4100
Message-ID: <20210104114335.3f87ff27@omen.home>
In-Reply-To: <ea539e21-aed3-8f23-74b2-5a214fa9fdb2@amd.com>
References: <4df8585ab0aac5abb1e9502d1d7cc49daa2a464f.camel@redhat.com>
 <83f4291c-abe4-2995-b4ba-9f84c9235d14@amd.com>
 <20210104094547.06a61444@omen.home>
 <ea539e21-aed3-8f23-74b2-5a214fa9fdb2@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: David Airlie <airlied@linux.ie>, Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCA0IEphbiAyMDIxIDE4OjM5OjMzICswMTAwCkNocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cgo+IEFtIDA0LjAxLjIxIHVtIDE3OjQ1IHNjaHJp
ZWIgQWxleCBXaWxsaWFtc29uOgo+ID4gT24gTW9uLCA0IEphbiAyMDIxIDEyOjM0OjM0ICswMTAw
Cj4gPiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+IHdyb3RlOgo+
ID4gIAo+ID4+IEhpIE1heGltLAo+ID4+Cj4gPj4gSSBjYW4ndCBoZWxwIHdpdGggdGhlIGRpc3Bs
YXkgcmVsYXRlZCBzdHVmZi4gUHJvYmFibHkgYmVzdCBhcHByb2FjaCB0bwo+ID4+IGdldCB0aGlz
IGZpeGVzIHdvdWxkIGJlIHRvIG9wZW4gdXAgYSBidWcgdHJhY2tlciBmb3IgdGhpcyBvbiBGRE8u
Cj4gPj4KPiA+PiBCdXQgSSdtIHRoZSBvbmUgd2hvIGltcGxlbWVudGVkIHRoZSByZXNpemVhYmxl
IEJBUiBzdXBwb3J0IGFuZCB5b3VyCj4gPj4gYW5hbHlzaXMgb2YgdGhlIHByb2JsZW0gc291bmRz
IGFib3V0IGNvcnJlY3QgdG8gbWUuCj4gPj4KPiA+PiBUaGUgcmVhc29uIHdoeSB0aGlzIHdvcmtz
IG9uIExpbnV4IGlzIG1vc3QgbGlrZWx5IGJlY2F1c2Ugd2UgcmVzdG9yZSB0aGUKPiA+PiBCQVIg
c2l6ZSBvbiByZXN1bWUgKGFuZCBtYXliZSBkdXJpbmcgaW5pdGlhbCBib290IGFzIHdlbGwpLgo+
ID4+Cj4gPj4gU2VlIHRoaXMgcGF0Y2ggZm9yIHJlZmVyZW5jZToKPiA+Pgo+ID4+IGNvbW1pdCBk
MzI1MmFjZTBiYzY1MmExYTI0NDQ1NTU1NmI2YTU0OWY5NjliZjk5Cj4gPj4gQXV0aG9yOiBDaHJp
c3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4KPiA+PiBEYXRl
OsKgwqAgRnJpIEp1biAyOSAxOTo1NDo1NSAyMDE4IC0wNTAwCj4gPj4KPiA+PiAgIMKgwqDCoCBQ
Q0k6IFJlc3RvcmUgcmVzaXplZCBCQVIgc3RhdGUgb24gcmVzdW1lCj4gPj4KPiA+PiAgIMKgwqDC
oCBSZXNpemUgQkFScyBhZnRlciByZXN1bWUgdG8gdGhlIGV4cGVjdGVkIHNpemUgYWdhaW4uCj4g
Pj4KPiA+PiAgIMKgwqDCoCBCdWdMaW5rOiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90ZWN0
aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZidWd6aWxsYS5rZXJuZWwub3JnJTJG
c2hvd19idWcuY2dpJTNGaWQlM0QxOTk5NTkmYW1wO2RhdGE9MDQlN0MwMSU3Q2NocmlzdGlhbi5r
b2VuaWclNDBhbWQuY29tJTdDOTQyMTc2ZDJlNmFhNGE0ZjNhNDIwOGQ4YjBkMDMyYmQlN0MzZGQ4
OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3NDUzNzU1NTQ5OTYwNjE1
JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1
TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAmYW1wO3NkYXRhPTNyc1Il
MkZ4NHVUcGp0WEZOcWxKeUZCdGVNbVpNaldmM05lY2k3bFVsa2g4OCUzRCZhbXA7cmVzZXJ2ZWQ9
MAo+ID4+ICAgwqDCoMKgIEZpeGVzOiBkNjg5NWFkMzlmM2IgKCJkcm0vYW1kZ3B1OiByZXNpemUg
VlJBTSBCQVIgZm9yIENQVSBhY2Nlc3MgdjYiKQo+ID4+ICAgwqDCoMKgIEZpeGVzOiAyNzZiNzM4
ZGViNWIgKCJQQ0k6IEFkZCByZXNpemFibGUgQkFSIGluZnJhc3RydWN0dXJlIikKPiA+PiAgIMKg
wqDCoCBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+Cj4gPj4gICDCoMKgwqAgU2lnbmVkLW9mZi1ieTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdh
YXNAZ29vZ2xlLmNvbT4KPiA+PiAgIMKgwqDCoCBDQzogc3RhYmxlQHZnZXIua2VybmVsLm9yZ8Kg
wqDCoMKgwqAgIyB2NC4xNSsKPiA+Pgo+ID4+Cj4gPj4gSXQgc2hvdWxkIGJlIHRyaXZpYWwgdG8g
YWRkIHRoaXMgdG8gdGhlIHJlc2V0IG1vZHVsZSBhcyB3ZWxsLiBNb3N0Cj4gPj4gbGlrZWx5IGV2
ZW4gY29tcGxldGVseSB2ZW5kb3IgaW5kZXBlbmRlbnQgc2luY2UgSSdtIG5vdCBzdXJlIHdoYXQg
YSBidXMKPiA+PiByZXNldCB3aWxsIGRvIHRvIHRoaXMgY29uZmlndXJhdGlvbiBhbmQgcmVzdG9y
aW5nIGl0IGFsbCB0aGUgdGltZSBzaG91bGQKPiA+PiBiZSB0aGUgbW9zdCBkZWZlbnNpdmUgYXBw
cm9hY2guICAKPiA+IEhtbSwgdGhpcyBzaG91bGQgYWxyZWFkeSBiZSB1c2VkIGJ5IHRoZSBidXMv
c2xvdCByZXNldCBwYXRoOgo+ID4KPiA+IHBjaV9idXNfcmVzdG9yZV9sb2NrZWQoKS9wY2lfc2xv
dF9yZXN0b3JlX2xvY2tlZCgpCj4gPiAgIHBjaV9kZXZfcmVzdG9yZSgpCj4gPiAgICBwY2lfcmVz
dG9yZV9zdGF0ZSgpCj4gPiAgICAgcGNpX3Jlc3RvcmVfcmViYXJfc3RhdGUoKQo+ID4KPiA+IFZG
SU8gc3VwcG9ydCBmb3IgcmVzaXplYWJsZSBCQVJzIGhhcyBiZWVuIG9uIG15IHRvZG8gbGlzdCwg
YnV0IEkgZG9uJ3QKPiA+IGhhdmUgYWNjZXNzIHRvIGFueSBzeXN0ZW1zIHRoYXQgaGF2ZSBib3Ro
IGEgY2FwYWJsZSBkZXZpY2UgYW5kID40Rwo+ID4gZGVjb2RpbmcgZW5hYmxlZCBpbiB0aGUgQklP
Uy4gIElmIHdlIGhhdmUgYSBjb25zaXN0ZW50IHZpZXcgb2YgdGhlIEJBUgo+ID4gc2l6ZSBhZnRl
ciB0aGUgQkFScyBhcmUgZXhwYW5kZWQsIEknbSBub3Qgc3VyZSB3aHkgaXQgZG9lc24ndCBqdXN0
Cj4gPiB3b3JrLiAgRldJVywgUUVNVSBjdXJyZW50bHkgaGlkZXMgdGhlIFJFQkFSIGNhcGFiaWxp
dHkgdG8gdGhlIGd1ZXN0Cj4gPiBiZWNhdXNlIHRoZSBrZXJuZWwgZHJpdmVyIGRvZXNuJ3Qgc3Vw
cG9ydCBlbXVsYXRpb24gdGhyb3VnaCBjb25maWcKPiA+IHNwYWNlIChpZS4gaXQncyByZWFkLW9u
bHksIHdoaWNoIHRoZSBzcGVjIGRvZXNuJ3Qgc3VwcG9ydCkuICAKPiAKPiBJbiB0aGlzIGNhc2Ug
dGhlIGd1ZXN0IHNob3VsZG4ndCBiZSBhYmxlIHRvIGNoYW5nZSB0aGUgY29uZmlnIGF0IGFsbCBh
bmQgCj4gSSBoYXZlIG5vIGlkZWEgd2hhdCdzIGdvaW5nIHdyb25nIGhlcmUuCj4gCj4gPiBBSVVJ
LCByZXNvdXJjZSBhbGxvY2F0aW9uIGNhbiBmYWlsIHdoZW4gZW5hYmxpbmcgUkVCQVIgc3VwcG9y
dCwgd2hpY2gKPiA+IGlzIGEgcHJvYmxlbSBpZiB0aGUgZmFpbHVyZSBvY2N1cnMgb24gdGhlIGhv
c3QgYnV0IG5vdCB0aGUgZ3Vlc3Qgc2luY2UKPiA+IHdlIGhhdmUgbm8gbWVhbnMgdmlhIHRoZSBo
YXJkd2FyZSBwcm90b2NvbCB0byBleHBvc2Ugc3VjaCBhIGNvbmRpdGlvbi4KPiA+IFRoZXJlZm9y
ZSB0aGUgbW9kZWwgSSB3YXMgY29uc2lkZXJpbmcgZm9yIHZmaW8tcGNpIHdvdWxkIGJlIHRvIHNp
bXBseQo+ID4gcHJlLWVuYWJsZSBSRUJBUiBhdCB0aGUgbWF4IHNpemUuICAKPiAKPiBUaGF0J3Mg
YSByYXRoZXIgYmFkIGlkZWEuIFNlZSBvdXIgR1BVcyBmb3IgZXhhbXBsZSByZXR1cm4gd2F5IG1v
cmUgdGhhbiAKPiB0aGV5IGFjdHVhbGx5IG5lZWQuCj4gCj4gRS5nLiBhIFBvbGFyaXMgdXN1YWxs
eSByZXR1cm5zIDRHaUIgZXZlbiB3aGVuIG9ubHkgMkdpQiBhcmUgaW5zdGFsbGVkLCAKPiBiZWNh
dXNlIDRHaUIgaXMganVzdCB0aGUgbWF4aW11bSBhbW91bnQgb2YgUkFNIHlvdSBjYW4gcHV0IHRv
Z2V0aGVyIHdpdGggCj4gdGhlIEFTSUMgb24gYSBib2FyZC4KCldvdWxkIHRoZSBkcml2ZXIgZmFp
bCBvciBtaXNiZWhhdmUgaWYgdGhlIEJBUiBpcyBzaXplZCBsYXJnZXIgdGhhbiB0aGUKYW1vdW50
IG9mIG1lbW9yeSBvbiB0aGUgY2FyZCBvciBpcyBtZW1vcnkgc2l6ZSBkZXRlcm1pbmVkIGluZGVw
ZW5kZW50bHkKb2YgQkFSIHNpemU/CiAKPiBTb21lIGRldmljZXMgZXZlbiByZXR1cm4gYSBtYXNr
IG9mIGFsbCAxIGV2ZW4gd2hlbiB0aGV5IG5lZWQgb25seSAyTWlCLCAKPiByZXN1bHRpbmcgaW4g
bmVhcmx5IDFUaUIgb2Ygd2FzdGVkIGFkZHJlc3Mgc3BhY2Ugd2l0aCB0aGlzIGFwcHJvYWNoLgoK
VWdoLiAgSSdtIGFmcmFpZCB0byBhc2sgd2h5IGEgZGV2aWNlIHdpdGggYSAyTWlCIEJBUiB3b3Vs
ZCBpbXBsZW1lbnQgYQpSRUJBUiBjYXBhYmlsaXR5LCBidXQgSSBndWVzcyB3ZSByZWFsbHkgY2Fu
J3QgbWFrZSBhbnkgYXNzdW1wdGlvbnMKYWJvdXQgdGhlIGJyZWFkdGggb2YgU0tVcyB0aGF0IEFT
SUMgbWlnaHQgc3VwcG9ydCAob3Igc2FuaXR5IG9mIHRoZQpkZXNpZ25lcnMpLgoKV2UgY291bGQg
cHJvYmUgdG8gZGV0ZXJtaW5lIHRoZSBtYXhpbXVtIHNpemUgdGhlIGhvc3QgY2FuIHN1cHBvcnQg
YW5kCnBvdGVudGlhbGx5IGVtdWxhdGUgdGhlIGNhcGFiaWxpdHkgdG8gcmVtb3ZlIHNpemVzIHRo
YXQgd2UgY2FuJ3QKYWxsb2NhdGUsIGJ1dCB3aXRob3V0IGFueSBhYmlsaXR5IGZvciB0aGUgZGV2
aWNlIHRvIHJlamVjdCBhIHNpemUKYWR2ZXJ0aXNlZCBhcyBzdXBwb3J0ZWQgdmlhIHRoZSBjYXBh
YmlsaXR5IHByb3RvY29sIGl0IG1ha2VzIG1lIG5lcnZvdXMKaG93IHdlIGNhbiBndWFyYW50ZWUg
dGhlIHJlc291cmNlcyBhcmUgYXZhaWxhYmxlIHdoZW4gdGhlIHVzZXIKcmUtY29uZmlndXJlcyB0
aGUgZGV2aWNlLiAgVGhhdCBtaWdodCBtZWFuIHdlJ2QgbmVlZCB0byByZXNlcnZlIHRoZQpyZXNv
dXJjZXMsIHVwIHRvIHdoYXQgdGhlIGhvc3QgY2FuIHN1cHBvcnQsIHJlZ2FyZGxlc3Mgb2Ygd2hh
dCB0aGUKZGV2aWNlIGNhbiBhY3R1YWxseSB1c2UuICBJJ20gbm90IHN1cmUgaG93IGVsc2UgdG8g
a25vdyBob3cgbXVjaCB0bwpyZXNlcnZlIHdpdGhvdXQgZGV2aWNlIHNwZWNpZmljIGNvZGUgaW4g
dmZpby1wY2kuICBUaGFua3MsCgpBbGV4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
