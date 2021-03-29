Return-Path: <SRS0=y/UM=I3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E6C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 18:09:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A2361929
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Mar 2021 18:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A2361929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mengyan1223.wang
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FC876E4A6;
	Mon, 29 Mar 2021 18:09:31 +0000 (UTC)
Received: from mengyan1223.wang (mengyan1223.wang [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A6F6E4A6;
 Mon, 29 Mar 2021 18:08:55 +0000 (UTC)
Received: from [IPv6:240e:35a:1037:8a00:70b2:e35d:833c:af3e] (unknown
 [IPv6:240e:35a:1037:8a00:70b2:e35d:833c:af3e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest
 SHA384) (Client did not present a certificate)
 (Authenticated sender: xry111@mengyan1223.wang)
 by mengyan1223.wang (Postfix) with ESMTPSA id 8E86265B2D;
 Mon, 29 Mar 2021 14:08:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
 s=mail; t=1617041334;
 bh=DnbFnwZ0/NuIMzB/7EbnclRu37Hg7RRrTWRMFouAYiY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=eud4UHFmqGdkogF/vnhMCKl190X1Lx65bFaTgdfl+MlbTUpeY7mcQy4Vbmpjtc95J
 PMqWWNP7RQ75jB/WpJ3wr3rkXC9baOSQyJPRpYIp20wzuZYlkBZtwHVFr/UkHKLl37
 dnaSp+ZX2lG0dIZeqmglsLk0cEQC9LzZ1f9CfhEh/GQL0/MvG1MxssMrKQpNZWiZUf
 hJJbRSc+mafXGpbfgbeOKZOnQDG0QVHPiOoc6Liu3sf4khCbQ6/gf/876E4QCouvFk
 0ZtsKsl1RlGA0ursq/pLBvT4uoIc2edOlSRAd8iCn5wo2bUCJKZO7codNKxm6NAAiS
 +2HbmYpCJKk9g==
Message-ID: <be9042b9294bda450659d3cd418c5e8759d57319.camel@mengyan1223.wang>
Subject: Re: [PATCH] drm/amdgpu: fix an underflow on non-4KB-page systems
From: Xi Ruoyao <xry111@mengyan1223.wang>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Date: Tue, 30 Mar 2021 02:08:36 +0800
In-Reply-To: <d192e2a8-8baf-0a8c-93a9-9abbad992c7d@gmail.com>
References: <20210329175348.26859-1-xry111@mengyan1223.wang>
 <d192e2a8-8baf-0a8c-93a9-9abbad992c7d@gmail.com>
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 29 Mar 2021 18:09:29 +0000
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
Cc: David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Dan =?ISO-8859-1?Q?Hor=E1k?= <dan@danny.cz>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS0wMy0yOSAyMDowNCArMDIwMCwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAy
OS4wMy4yMSB1bSAxOTo1MyBzY2hyaWViIFjihLkgUnVveWFvOgo+ID4gSWYgdGhlIGluaXRpYWwg
dmFsdWUgb2YgYG51bV9lbnRpcmVzYCAoY2FsY3VsYXRlZCBhdCBsaW5lIDE2NTQpIGlzIG5vdAo+
ID4gYW4gaW50ZWdyYWwgbXVsdGlwbGUgb2YgYEFNREdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0Vg
LCBpbiBsaW5lIDE2ODEgYQo+ID4gdmFsdWUgZ3JlYXRlciB0aGFuIHRoZSBpbml0aWFsIHZhbHVl
IHdpbGwgYmUgYXNzaWduZWQgdG8gaXQuwqAgVGhhdCBjYXVzZXMKPiA+IGBzdGFydCA+IGxhc3Qg
KyAxYCBhZnRlciBsaW5lIDE3MDguwqAgVGhlbiBpbiB0aGUgbmV4dCBpdGVyYXRpb24gYW4KPiA+
IHVuZGVyZmxvdyBoYXBwZW5zIGF0IGxpbmUgMTY1NC7CoCBJdCBjYXVzZXMgbWVzc2FnZQo+ID4g
Cj4gPiDCoMKgwqDCoCAqRVJST1IqIENvdWxkbid0IHVwZGF0ZSBCT19WQSAoLTEyKQo+ID4gCj4g
PiBwcmludGVkIGluIGtlcm5lbCBsb2csIGFuZCBHUFUgaGFuZ2luZy4KPiA+IAo+ID4gRm9ydGlm
eSB0aGUgY3JpdGVyaWEgb2YgdGhlIGxvb3AgdG8gZml4IHRoaXMgaXNzdWUuCj4gCj4gTkFLIHRo
ZSB2YWx1ZSBvZiBudW1fZW50cmllcyBtdXN0IGFsd2F5cyBiZSBhIG11bHRpcGxlIG9mIAo+IEFN
REdQVV9HUFVfUEFHRVNfSU5fQ1BVX1BBR0Ugb3Igb3RoZXJ3aXNlIHdlIGNvcnJ1cHQgdGhlIHBh
Z2UgdGFibGVzLgo+IAo+IEhvdyBkbyB5b3UgdHJpZ2dlciB0aGF0PwoKU2ltcGx5IHJ1biAiT3Bl
bkdMIGFyZWEiIGZyb20gZ3RrMy1kZW1vICh3aGljaCBqdXN0IHJlbmRlcnMgYSB0cmlhbmdsZSB3
aXRoIEdMKQp1bmRlciBYb3JnLCBvbiBNSVBTNjQuICBTZWUgdGhlIEJ1Z0xpbmsuCgo+IENocmlz
dGlhbi4KPiAKPiA+IAo+ID4gQnVnTGluazogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3Jn
L2RybS9hbWQvLS9pc3N1ZXMvMTU0OQo+ID4gRml4ZXM6IGEzOWYyYThkNzA2NiAoImRybS9hbWRn
cHU6IG51a2UgYW1kZ3B1X3ZtX2JvX3NwbGl0X21hcHBpbmcgdjIiKQo+ID4gUmVwb3J0ZWQtYnk6
IFhpIFJ1b3lhbyA8eHJ5MTExQG1lbmd5YW4xMjIzLndhbmc+Cj4gPiBSZXBvcnRlZC1ieTogRGFu
IEhvcsOhayA8ZGFuQGRhbm55LmN6Pgo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+
IFNpZ25lZC1vZmYtYnk6IFhpIFJ1b3lhbyA8eHJ5MTExQG1lbmd5YW4xMjIzLndhbmc+Cj4gPiAt
LS0KPiA+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMiArLQo+
ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gPiAK
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+
ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ID4gaW5kZXggYWQ5
MWMwYzNjNDIzLi5jZWUwY2M5YzgwODUgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKPiA+IEBAIC0xNzA3LDcgKzE3MDcsNyBAQCBzdGF0aWMgaW50IGFtZGdw
dV92bV9ib191cGRhdGVfbWFwcGluZyhzdHJ1Y3QKPiA+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgc3RhcnQgPSB0bXA7Cj4gPiDCoCAKPiA+IC3CoMKgwqDCoMKgwqDCoH0g
d2hpbGUgKHVubGlrZWx5KHN0YXJ0ICE9IGxhc3QgKyAxKSk7Cj4gPiArwqDCoMKgwqDCoMKgwqB9
IHdoaWxlICh1bmxpa2VseShzdGFydCA8IGxhc3QgKyAxKSk7Cj4gPiDCoCAKPiA+IMKgwqDCoMKg
wqDCoMKgwqByID0gdm0tPnVwZGF0ZV9mdW5jcy0+Y29tbWl0KCZwYXJhbXMsIGZlbmNlKTsKPiA+
IMKgIAo+ID4gCj4gPiBiYXNlLWNvbW1pdDogYTVlMTNjNmRmMGU0MTcwMmQyYjJjNzdjOGFkNDE2
NzdlYmIwNjViMwo+IAoKLS0gClhpIFJ1b3lhbyA8eHJ5MTExQG1lbmd5YW4xMjIzLndhbmc+ClNj
aG9vbCBvZiBBZXJvc3BhY2UgU2NpZW5jZSBhbmQgVGVjaG5vbG9neSwgWGlkaWFuIFVuaXZlcnNp
dHkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
