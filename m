Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29039C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 21:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A022071E
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 21:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A022071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=raptorengineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F05892C2;
	Mon, 25 Nov 2019 21:52:46 +0000 (UTC)
Received: from mail.rptsys.com (mail.rptsys.com [23.155.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77BA892C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 21:52:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 52CE4D9C2B239;
 Mon, 25 Nov 2019 15:52:45 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id xj5A2I__s5IE; Mon, 25 Nov 2019 15:52:44 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 5D09CD9C2B086;
 Mon, 25 Nov 2019 15:52:44 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 5D09CD9C2B086
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id NWt55RMfBvlj; Mon, 25 Nov 2019 15:52:44 -0600 (CST)
Received: from vali.starlink.edu (unknown [192.168.3.2])
 by mail.rptsys.com (Postfix) with ESMTP id 369E0D9C2B077;
 Mon, 25 Nov 2019 15:52:44 -0600 (CST)
Date: Mon, 25 Nov 2019 15:52:43 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Message-ID:
 <154115761.2124413.1574718763227.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <5dcfdba7-dc14-99d4-d6e5-fc1768fcc5c0@amd.com>
References: <2068915477.1923611.1574622916022.JavaMail.zimbra@raptorengineeringinc.com>
 <44175d39-e507-83f9-6596-cbde108dd65a@amd.com>
 <535694171.2118031.1574716002431.JavaMail.zimbra@raptorengineeringinc.com>
 <5dcfdba7-dc14-99d4-d6e5-fc1768fcc5c0@amd.com>
Subject: Re: [PATCH 1/1] amdgpu: Enable KFD on POWER systems
MIME-Version: 1.0
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Topic: amdgpu: Enable KFD on POWER systems
Thread-Index: 5GWIJyLTpLqWBJwb7xYNivYM1RwVUw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1574718764; bh=XL/ZTCeLOfqO1awyMT36iR9Dm3dumUK8Q+egJRnzzJg=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=JqRIu5kVod5Luqgss8GCN85/jZLWTlf1h8Su+B41Qr7ERUcsnUNjj54qUFPz1M/qF
 UmP6cFqbt+Fc03t+3TZ5TYGc1PhHlt5uaSwYc8kK+nuA6aYWwSdjO5DxRhZMDM0Oeg
 xNhpBF9VH4biSOUNI3gh6/Q81HMLLf5WnY3qO8MI=
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
Cc: amd-gfx <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125215243.32Zb86OvVl95fEoHF_1QmWMDiWb-7sZTHe-wW1AvoTs@z>

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIkZlbGl4IEt1ZWhsaW5nIiA8
ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4KPiBUbzogIlRpbW90aHkgUGVhcnNvbiIgPHRwZWFyc29u
QHJhcHRvcmVuZ2luZWVyaW5nLmNvbT4KPiBDYzogImFtZC1nZngiIDxhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZz4KPiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDI1LCAyMDE5IDM6MzQ6MjAg
UE0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gYW1kZ3B1OiBFbmFibGUgS0ZEIG9uIFBPV0VS
IHN5c3RlbXMKCj4gT24gMjAxOS0xMS0yNSA0OjA2IHAubS4sIFRpbW90aHkgUGVhcnNvbiB3cm90
ZToKPj4KPj4gLS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+Pj4gRnJvbTogIkZlbGl4IEt1
ZWhsaW5nIiA8ZmVsaXgua3VlaGxpbmdAYW1kLmNvbT4KPj4+IFRvOiAiVGltb3RoeSBQZWFyc29u
IiA8dHBlYXJzb25AcmFwdG9yZW5naW5lZXJpbmcuY29tPiwgImFtZC1nZngiCj4+PiA8YW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+Cj4+PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDI1LCAy
MDE5IDExOjA3OjMxIEFNCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMV0gYW1kZ3B1OiBFbmFi
bGUgS0ZEIG9uIFBPV0VSIHN5c3RlbXMKPj4+IEhpIFRpbW90aHksCj4+Pgo+Pj4gVGhhbmsgeW91
IGZvciB0aGUgcGF0Y2ggYW5kIGZvciBjb25maXJtaW5nIHRoYXQgaXQgd29ya3MuIFdlIGRpZCBz
b21lCj4+PiBleHBlcmltZW50YWwgd29yayBvbiBQb3dlcjggYSBmZXcgeWVhcnMgYWdvLiBJIHNl
ZSB0aGF0IFRhbG9zIElJIGlzIFBvd2VyOS4KPj4+Cj4+PiBBdCB0aGUgdGltZSB3ZSB3ZXJlIHdv
cmtpbmcgb24gUG93ZXI4IHdlIGhhZCB0byBhZGQgc29tZSAjaWZkZWYKPj4+IENPTkZJR19BQ1BJ
IGd1YXJkcyBhcm91bmQgc29tZSBBQ1BJLXNwZWNpZmljIGNvZGUgaW4gS0ZELiBEbyB5b3Uga25v
dyB0bwo+Pj4gd2hhdCBleHRlbnQgQUNQSSBpcyBhdmFpbGFibGUgYW5kIHdvcmtpbmcgb24gdGhl
IFBvd2VyIGFyY2hpdGVjdHVyZT8KPj4+Cj4+PiBBbm90aGVyIHByb2JsZW0gd2UgcmFuIGludG8g
d2l0aCBQb3dlciwgaXMgdGhlIHBoeXNpY2FsIGFkZHJlc3MgbWFwLgo+Pj4gU3lzdGVtIG1lbW9y
eSBjYW4gYmUgYSBwaHlzaWNhbCBhZGRyZXNzZXMgb3V0c2lkZSB0aGUgcmFuZ2UgYWNjZXNzaWJs
ZQo+Pj4gYnkgdGhlIEdQVS4gVmVnYSBoYXMgNDQtYml0IHBoeXNpY2FsIGFkZHJlc3NpbmcuIE9s
ZGVyIFBvbGFyaXMgR1BVcyBvbmx5Cj4+PiBoYXZlIDQwLWJpdHMuIERpZCB5b3UgcnVuIGludG8g
YW55IHN1Y2ggcHJvYmxlbXM/IERvIHlvdSBuZWVkIGFuIElPTU1VCj4+PiB0byBtYWtlIHN5c3Rl
bSBtZW1vcnkgYWNjZXNzaWJsZSB0byB0aGUgR1BVPwo+Pj4KPj4+IFJlZ2FyZHMsCj4+PiAgwqAg
RmVsaXgKPj4gWWVzLCB3ZSBhcmUgUE9XRVI5LiAgSXQgbG9va3MgbGlrZSB0aGUgQUNQSSBndWFy
ZHMgYXJlIG5vIGxvbmdlciByZXF1aXJlZDsgYXMKPj4geW91IGhhdmUgc3VybWlzZWQsIFBPV0VS
IGRvZXMgbm90IHVzZSBBQ1BJICh0aGUgZXF1aXZhbGVudCBpcyBPUEFMLCB3aGljaCBpcyBhCj4+
IGRpZmZlcmVudCBpbnRlcmZhY2UgZW50aXJlbHkpLiAgV2hhdCB3ZXJlIHRoZSBBUENJIGNhbGxz
IHVzZWQgZm9yPyAgVGhlcmUgbWF5Cj4+IGJlIE9QQUwgZXF1aXZhbGVudHMgdGhhdCBjb3VsZCBi
ZSBhZGRlZCBpbiB0byByZXBsYWNlIHRoZW0gYW5kIHByb3ZpZGUgc2ltaWxhcgo+PiBmdW5jdGlv
bmFsaXR5Lgo+IAo+IFRoZXJlIGFyZSBzb21lIEFDUEkgY2FsbHMgKGUuZy4gYWNwaV9nZXRfdGFi
bGUpIGluIGtmZF9jcmF0LmMgZm9yCj4gZ2V0dGluZyBhIENSQVQgdGFibGUgZnJvbSBBQ1BJLiBU
aGlzIGlzIG9ubHkgdXNlZnVsIGZvciBBTUQgQVBVcywgd2hpY2gKPiBhcmUgeDg2XzY0LiBXZSBk
b24ndCBuZWVkIHRoaXMgZm9yIGRpc2NyZXRlIEdQVXMgYmVjYXVzZSBvbiBub24tQVBVCj4gc3lz
dGVtcyB0aGVyZSBpcyBubyBDUkFUIHRhYmxlIGFuZCB3ZSBidWlsZCBvdXIgb3duLiBJZiB5b3Ug
Y2FuIGNvbXBpbGUKPiB0aGUgY29kZSB3aXRob3V0IHByb2JsZW1zIG9uIFBvd2VyIGFuZCB3aXRo
IENPTkZJR19BQ1BJIG5vdCBkZWZpbmVkLAo+IHRoZW4gSSBndWVzcyB0aGlzIGlzIG5vIGxvbmdl
ciBhbiBpc3N1ZS4KClNvdW5kcyByZWFzb25hYmxlIC0tIHllcywgaXQgY29tcGlsZXMgd2l0aG91
dCBpc3N1ZSBzbyBJIHRoaW5rIHdlJ3JlIGdvb2QgdG8gZ28uCgo+IAo+PiBLZXJuZWwgNS40IGVu
YWJsZXMgYSA+IDMyLWJpdCBhbmQgPD02NC1iaXQgYnlwYXNzIG1vZGUgZm9yIFBPV0VSLiAgVGhp
cyBpcyBvbmUKPj4gcmVhc29uIHdlIGNhbWUgYmFjayBhbmQgcmV2aXNpdGVkIHRoZSBLRkQvUk9D
bSBmdW5jdGlvbmFsaXR5IG9uIFBPV0VSOyBhcyBpdAo+PiB0dXJucyBvdXQsIGFmdGVyIGZpeGlu
ZyB1cCB0aGUgdXNlcnNwYWNlIHRvb2xzIEtGRCBpcyBpbmRlZWQgZnVuY3Rpb25hbCBvbgo+PiBQ
T1dFUiB3aXRoIDUuNC1yYzggYW5kIGFib3ZlLiAgTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRo
ZSBQT1dFUiBJT01NVSBpcyB1c2VkCj4+IGFzIGEgbGlnaHR3ZWlnaHQgdHJhbnNsYXRpb24gbGF5
ZXIgYmV0d2VlbiB0aGUgNjQtYml0IGhvc3QgYW5kIHRoZSA0MC80NC1iaXQKPj4gR1BVLgo+Pgo+
PiBJJ20gd29ya2luZyBvbiBnZXR0aW5nIGEgRGViaWFuIFBQQSBzZXQgdXAgZm9yIFBPV0VSIHRv
IG1ha2UgdGhlIHVzZXJzcGFjZSB0b29scwo+PiBlYXNpZXIgdG8gb2J0YWluIGZvciB0ZXN0aW5n
LCBidXQgcHJvZ3Jlc3MgaXMgc2xvdyBkdWUgdG8gbGFjayBvZiBEZWJpYW4gc291cmNlCj4+IHBh
Y2thZ2VzLiAgUHJvYmFibHkgdGhlIGVhc2llc3Qgd2F5IHRvIHJlcGxpY2F0ZSAvIHRlc3QgdGhp
cyB3aXRoIEhJUCBpcyB0byB1c2UKPj4gdGhlIEFPTVAgcmVwb3NpdG9yeSB3aXRoIG15IG1vZGlm
aWNhdGlvbnM7IHB1bGwgcmVxdWVzdHMgYXJlIGFscmVhZHkgaW4gcGxhY2UKPj4gb24gR2l0aHVi
IGZvciBtb3N0IG9mIHRoZSB1c2Vyc3BhY2UgdG9vbGluZyB1cGRhdGVzLgo+Pgo+PiBUaGFuayB5
b3UhCj4gVGhhbmtzLAo+IMKgIEZlbGl4Cj4gCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
