Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC75C81824
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 09:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 434BA24955
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 09:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434BA24955
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chris-wilson.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7CE6E09A;
	Tue, 12 May 2020 09:03:18 +0000 (UTC)
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCFB36E09A;
 Tue, 12 May 2020 09:03:17 +0000 (UTC)
X-Default-Received-SPF: pass (skip=forwardok (res=PASS))
 x-ip-name=78.156.65.138; 
Received: from localhost (unverified [78.156.65.138]) 
 by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id
 21170102-1500050 for multiple; Tue, 12 May 2020 10:03:13 +0100
MIME-Version: 1.0
In-Reply-To: <20200512085944.222637-2-daniel.vetter@ffwll.ch>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
 <20200512085944.222637-2-daniel.vetter@ffwll.ch>
Subject: Re: [RFC 01/17] dma-fence: add might_sleep annotation to _wait()
From: Chris Wilson <chris@chris-wilson.co.uk>
To: DRI Development <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
Message-ID: <158927419210.15653.14325088525231607229@build.alporthouse.com>
User-Agent: alot/0.8.1
Date: Tue, 12 May 2020 10:03:12 +0100
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
Cc: linux-rdma@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Daniel Vetter <daniel.vetter@intel.com>, Christian König <christian.koenig@amd.com>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UXVvdGluZyBEYW5pZWwgVmV0dGVyICgyMDIwLTA1LTEyIDA5OjU5OjI4KQo+IEJ1dCBvbmx5IGZv
ciBub24temVybyB0aW1lb3V0LCB0byBhdm9pZCBmYWxzZSBwb3NpdGl2ZXMuCj4gCj4gT25lIHF1
ZXN0aW9uIGhlcmUgaXMgd2hldGhlciB0aGUgbWlnaHRfc2xlZXAgc2hvdWxkIGJlIHVuY29uZGl0
aW9uYWwsCj4gb3Igb25seSBmb3IgcmVhbCB0aW1lb3V0cy4gSSdtIG5vdCBzdXJlLCBzbyB3ZW50
IHdpdGggdGhlIG1vcmUKPiBkZWZlbnNpdmUgb3B0aW9uLiBCdXQgaW4gdGhlIGludGVyZXN0IG9m
IGxvY2tpbmcgZG93biB0aGUgY3Jvc3MtZHJpdmVyCj4gZG1hX2ZlbmNlIHJ1bGVzIHdlIG1pZ2h0
IHdhbnQgdG8gYmUgbW9yZSBhZ2dyZXNzaXZlLgoKWW91IGNhbiBhcmd1ZSBmb3IgZW5mb3JjaW5n
IG1pZ2h0X3NsZWVwKCkgYXMgaW50ZXJuYWwgcXVlcmllcyBzaG91bGQgYmUKdXNpbmcgZG1hX2Zl
bmNlX2lzX3NpZ25hbGVkKCkgYW5kIG5vdCBkbWFfZmVuY2Vfd2FpdF90aW1lb3V0KDApLgoKPiBD
YzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMu
bGluYXJvLm9yZwo+IENjOiBsaW51eC1yZG1hQHZnZXIua2VybmVsLm9yZwo+IENjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IENjOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gQ2M6IENocmlzIFdpbHNvbiA8Y2hyaXNAY2hyaXMtd2lsc29uLmNvLnVrPgo+IENjOiBN
YWFydGVuIExhbmtob3JzdCA8bWFhcnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPgo+IENj
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4gU2lnbmVkLW9m
Zi1ieTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBpbnRlbC5jb20+Cj4gLS0tCj4gIGRy
aXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2UuYyB8IDMgKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5j
IGIvZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5jCj4gaW5kZXggMDUyYTQxZTI0NTFjLi42ODAy
MTI1MzQ5ZmIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5jCj4gKysr
IGIvZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5jCj4gQEAgLTIwOCw2ICsyMDgsOSBAQCBkbWFf
ZmVuY2Vfd2FpdF90aW1lb3V0KHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlLCBib29sIGludHIsIHNp
Z25lZCBsb25nIHRpbWVvdXQpCj4gICAgICAgICBpZiAoV0FSTl9PTih0aW1lb3V0IDwgMCkpCj4g
ICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICAKPiArICAgICAgIGlmICh0aW1lb3V0
ID4gMCkKPiArICAgICAgICAgICAgICAgbWlnaHRfc2xlZXAoKTsKCm1pZ2h0X3NsZWVwX2lmKHRp
bWVvdXQgPiAwKTsKLUNocmlzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
