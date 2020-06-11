Return-Path: <SRS0=7JJ9=7Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49647C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 07:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 194702074B
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2020 07:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="GCUBzBxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194702074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shipmail.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B764889DC7;
	Thu, 11 Jun 2020 07:30:21 +0000 (UTC)
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se
 [213.80.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8C5689D81;
 Thu, 11 Jun 2020 07:30:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id C52C53F6E8;
 Thu, 11 Jun 2020 09:30:17 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se; dkim=pass (1024-bit key;
 unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=GCUBzBxx; 
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
 dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
 by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iIlSPVxu0sRf; Thu, 11 Jun 2020 09:30:16 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se
 [155.4.205.35]) (Authenticated sender: mb878879)
 by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E40C23F683;
 Thu, 11 Jun 2020 09:30:13 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se
 [155.4.205.35])
 by mail1.shipmail.org (Postfix) with ESMTPSA id 06F8F360305;
 Thu, 11 Jun 2020 09:30:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
 t=1591860613; bh=ax4JYSj31lLugLn4GS/xTNhVWBMkQDLT2ea6JW6fq/U=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GCUBzBxxf98lTFNSP0Dlp/n/+/bdS+fx4so3iAJYi8G/MjONQRAmflLqkOikME4iD
 MUs9rU3r/y6OHX+h/VnT1g38n1UpRlf1rQRrL0SPnh1UXImH0gRwWGozv2yL3tsxRs
 9r8MaAUOa6C2A8mHoNnl+0FXmTrNB6FX2Qv1kCb4=
Subject: Re: [Linaro-mm-sig] [PATCH 04/18] dma-fence: prime lockdep annotations
To: Daniel Vetter <daniel.vetter@ffwll.ch>,
 DRI Development <dri-devel@lists.freedesktop.org>
References: <20200604081224.863494-1-daniel.vetter@ffwll.ch>
 <20200604081224.863494-5-daniel.vetter@ffwll.ch>
From: =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28Intel=29?= <thomas_os@shipmail.org>
Message-ID: <b11c2140-1b9c-9013-d9bb-9eb2c1906710@shipmail.org>
Date: Thu, 11 Jun 2020 09:30:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604081224.863494-5-daniel.vetter@ffwll.ch>
Content-Language: en-US
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
Cc: linux-rdma@vger.kernel.org,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Thomas Hellstrom <thomas.hellstrom@intel.com>,
 Daniel Vetter <daniel.vetter@intel.com>,
 Mika Kuoppala <mika.kuoppala@intel.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDYvNC8yMCAxMDoxMiBBTSwgRGFuaWVsIFZldHRlciB3cm90ZToKPiBUd28gaW4gb25lIGdv
Ogo+IC0gaXQgaXMgYWxsb3dlZCB0byBjYWxsIGRtYV9mZW5jZV93YWl0KCkgd2hpbGUgaG9sZGlu
ZyBhCj4gICAgZG1hX3Jlc3ZfbG9jaygpLiBUaGlzIGlzIGZ1bmRhbWVudGFsIHRvIGhvdyBldmlj
dGlvbiB3b3JrcyB3aXRoIHR0bSwKPiAgICBzbyByZXF1aXJlZC4KPgo+IC0gaXQgaXMgYWxsb3dl
ZCB0byBjYWxsIGRtYV9mZW5jZV93YWl0KCkgZnJvbSBtZW1vcnkgcmVjbGFpbSBjb250ZXh0cywK
PiAgICBzcGVjaWZpY2FsbHkgZnJvbSBzaHJpbmtlciBjYWxsYmFja3MgKHdoaWNoIGk5MTUgZG9l
cyksIGFuZCBmcm9tIG1tdQo+ICAgIG5vdGlmaWVyIGNhbGxiYWNrcyAod2hpY2ggYW1kZ3B1IGRv
ZXMsIGFuZCB3aGljaCBpOTE1IHNvbWV0aW1lcyBhbHNvCj4gICAgZG9lcywgYW5kIHByb2JhYmx5
IGFsd2F5cyBzaG91bGQsIGJ1dCB0aGF0J3Mga2luZGEgYSBkZWJhdGUpLiBBbHNvCj4gICAgZm9y
IHN0dWZmIGxpa2UgSE1NIHdlIHJlYWxseSBuZWVkIHRvIGJlIGFibGUgdG8gZG8gdGhpcywgb3Ig
dGhpbmdzCj4gICAgZ2V0IHJlYWwgZGljZXkuCj4KPiBDb25zZXF1ZW5jZSBpcyB0aGF0IGFueSBj
cml0aWNhbCBwYXRoIG5lY2Vzc2FyeSB0byBnZXQgdG8gYQo+IGRtYV9mZW5jZV9zaWduYWwgZm9y
IGEgZmVuY2UgbXVzdCBuZXZlciBhKSBjYWxsIGRtYV9yZXN2X2xvY2sgbm9yIGIpCj4gYWxsb2Nh
dGUgbWVtb3J5IHdpdGggR0ZQX0tFUk5FTC4gQWxzbyBieSBpbXBsaWNhdGlvbiBvZgo+IGRtYV9y
ZXN2X2xvY2soKSwgbm8gdXNlcnNwYWNlIGZhdWx0aW5nIGFsbG93ZWQuIFRoYXQncyBzb21lIHN1
cHJlbWVseQo+IG9ibm94aW91cyBsaW1pdGF0aW9ucywgd2hpY2ggaXMgd2h5IHdlIG5lZWQgdG8g
c3ByaW5rbGUgdGhlIHJpZ2h0Cj4gYW5ub3RhdGlvbnMgdG8gYWxsIHJlbGV2YW50IHBhdGhzLgo+
Cj4gVGhlIG9uZSBiaWcgbG9ja2luZyBjb250ZXh0IHdlJ3JlIGxlYXZpbmcgb3V0IGhlcmUgaXMg
bW11IG5vdGlmaWVycywKPiBhZGRlZCBpbgo+Cj4gY29tbWl0IDIzYjY4Mzk1YzdjNzhhNzY0ZTg5
NjNmYzE1YTdjZmQzMThiZjE4N2YKPiBBdXRob3I6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0
ZXJAZmZ3bGwuY2g+Cj4gRGF0ZTogICBNb24gQXVnIDI2IDIyOjE0OjIxIDIwMTkgKzAyMDAKPgo+
ICAgICAgbW0vbW11X25vdGlmaWVyczogYWRkIGEgbG9ja2RlcCBtYXAgZm9yIGludmFsaWRhdGVf
cmFuZ2Vfc3RhcnQvZW5kCj4KPiB0aGF0IG9uZSBjb3ZlcnMgYSBsb3Qgb2Ygb3RoZXIgY2FsbHNp
dGVzLCBhbmQgaXQncyBhbHNvIGFsbG93ZWQgdG8KPiB3YWl0IG9uIGRtYS1mZW5jZXMgZnJvbSBt
bXUgbm90aWZpZXJzLiBCdXQgdGhlcmUncyBubyByZWFkeS1tYWRlCj4gZnVuY3Rpb25zIGV4cG9z
ZWQgdG8gcHJpbWUgdGhpcywgc28gSSd2ZSBsZWZ0IGl0IG91dCBmb3Igbm93Lgo+Cj4gdjI6IEFs
c28gdHJhY2sgYWdhaW5zdCBtbXUgbm90aWZpZXIgY29udGV4dC4KPgo+IHYzOiBrZXJuZWxkb2Mg
dG8gc3BlYyB0aGUgY3Jvc3MtZHJpdmVyIGNvbnRyYWN0LiBOb3RlIHRoYXQgY3VycmVudGx5Cj4g
aTkxNSB0aHJvd3MgaW4gYSBoYXJkLWNvZGVkIDEwcyB0aW1lb3V0IG9uIGZvcmVpZ24gZmVuY2Vz
IChub3Qgc3VyZQo+IHdoeSB0aGF0IHdhcyBkb25lLCBidXQgaXQncyB0aGVyZSksIHdoaWNoIGlz
IHdoeSB0aGF0IHJ1bGUgaXMgd29yZGVkCj4gd2l0aCBTSE9VTEQgaW5zdGVhZCBvZiBNVVNULgo+
Cj4gQWxzbyBzb21lIG9mIHRoZSBtbXVfbm90aWZpZXIvc2hyaW5rZXIgcnVsZXMgbWlnaHQgc3Vy
cHJpc2UgU29DCj4gZHJpdmVycywgSSBoYXZlbid0IGZ1bGx5IGF1ZGl0ZWQgdGhlbSBhbGwuIFdo
aWNoIGlzIGluZmVhc2libGUgYW55d2F5LAo+IHdlJ2xsIG5lZWQgdG8gcnVuIHRoZW0gd2l0aCBs
b2NrZGVwIGFuZCBkbWEtZmVuY2UgYW5ub3RhdGlvbnMgYW5kIHNlZQo+IHdoYXQgZ29lcyBib29t
Lgo+Cj4gdjQ6IEEgc3BlbGxpbmcgZml4IGZyb20gTWlrYQo+Cj4gQ2M6IE1pa2EgS3VvcHBhbGEg
PG1pa2Eua3VvcHBhbGFAaW50ZWwuY29tPgo+IENjOiBUaG9tYXMgSGVsbHN0cm9tIDx0aG9tYXMu
aGVsbHN0cm9tQGludGVsLmNvbT4KPiBDYzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCj4g
Q2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwo+IENjOiBsaW51eC1yZG1hQHZnZXIu
a2VybmVsLm9yZwo+IENjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBpbnRl
bC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IENocmlzIFdpbHNvbiA8Y2hyaXNAY2hy
aXMtd2lsc29uLmNvLnVrPgo+IENjOiBNYWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9y
c3RAbGludXguaW50ZWwuY29tPgo+IENjOiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRl
ckBpbnRlbC5jb20+Cj4gLS0tCj4gICBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvZG1hLWJ1Zi5y
c3QgfCAgNiArKysrCj4gICBkcml2ZXJzL2RtYS1idWYvZG1hLWZlbmNlLmMgICAgICAgICAgfCA0
MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICBkcml2ZXJzL2RtYS1idWYvZG1hLXJl
c3YuYyAgICAgICAgICAgfCAgNCArKysKPiAgIGluY2x1ZGUvbGludXgvZG1hLWZlbmNlLmggICAg
ICAgICAgICB8ICAxICsKPiAgIDQgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKQoKSSBz
dGlsbCBoYXZlIG15IGRvdWJ0cyBhYm91dCBhbGxvd2luZyBmZW5jZSB3YWl0aW5nIGZyb20gd2l0
aGluIApzaHJpbmtlcnMuIElNTyBpZGVhbGx5IHRoZXkgc2hvdWxkIHVzZSBhIHRyeXdhaXQgYXBw
cm9hY2gsIGluIG9yZGVyIHRvIAphbGxvdyBtZW1vcnkgYWxsb2NhdGlvbiBkdXJpbmcgY29tbWFu
ZCBzdWJtaXNzaW9uIGZvciBkcml2ZXJzIHRoYXQKcHVibGlzaCBmZW5jZXMgYmVmb3JlIGNvbW1h
bmQgc3VibWlzc2lvbi4gKFNpbmNlIGVhcmx5IHJlc2VydmF0aW9uIApvYmplY3QgcmVsZWFzZSBy
ZXF1aXJlcyB0aGF0KS4KCkJ1dCBzaW5jZSBkcml2ZXJzIGFyZSBhbHJlYWR5IHdhaXRpbmcgZnJv
bSB3aXRoaW4gc2hyaW5rZXJzIGFuZCBJIHRha2UgCnlvdXIgd29yZCBmb3IgSE1NIHJlcXVpcmlu
ZyB0aGlzLAoKUmV2aWV3ZWQtYnk6IFRob21hcyBIZWxsc3Ryw7ZtIDx0aG9tYXMuaGVsbHN0cm9t
QGludGVsLmNvbT4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
