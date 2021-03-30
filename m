Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C6EC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4290B619C0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4290B619C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mengyan1223.wang
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FC0E6E8F4;
	Tue, 30 Mar 2021 13:24:48 +0000 (UTC)
Received: from mengyan1223.wang (mengyan1223.wang [89.208.246.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EAD46E8B8;
 Tue, 30 Mar 2021 12:04:55 +0000 (UTC)
Received: from [IPv6:240e:35a:1037:8a00:70b2:e35d:833c:af3e] (unknown
 [IPv6:240e:35a:1037:8a00:70b2:e35d:833c:af3e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest
 SHA384) (Client did not present a certificate)
 (Authenticated sender: xry111@mengyan1223.wang)
 by mengyan1223.wang (Postfix) with ESMTPSA id 221F36594D;
 Tue, 30 Mar 2021 08:04:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
 s=mail; t=1617105894;
 bh=9n4noZb5E2aEglOTZKnCbCPj/j/5SXMSR6/nQrd4Z1Y=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=kxJCRiyaZuIykRdtEdnLeNCB1VYo85ccJt3fleCbfgrj3r1qyGVrwAZUVJU3uF4kI
 i2iXYTcWqsr3T9rnfMMri2Y9+l/4fwm39xu9PFgdZMh25sqJY+J5RRAGRRPMeQSJiq
 DxbKp7oM/F44iT7w/Y+z7ZvV+2CvBu3whU2JmmsQ0oneTHcOmyv+KCH1046dUZ8vdI
 PIYzQ5rPlInEZLchxh0a6QnGkiQ86o1QIbbEWB6UVGdnuQEx79v8JDWtPT31SMob5Y
 eDRbFnIiSC1UXko1ZhyEc5kwmZqMr/2PJenlzN1xhgcigd87MpfgzPlYhjhhKZ7Ppm
 Sy8Tfjjy6aBsQ==
Message-ID: <71e3905a5b72c5b97df837041b19175540ebb023.camel@mengyan1223.wang>
Subject: Re: [PATCH] drm/amdgpu: fix an underflow on non-4KB-page systems
From: Xi Ruoyao <xry111@mengyan1223.wang>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Date: Tue, 30 Mar 2021 20:04:32 +0800
In-Reply-To: <368b9b1b7343e35b446bb1028ccf0ae75dc2adc4.camel@mengyan1223.wang>
References: <20210329175348.26859-1-xry111@mengyan1223.wang>
 <d192e2a8-8baf-0a8c-93a9-9abbad992c7d@gmail.com>
 <be9042b9294bda450659d3cd418c5e8759d57319.camel@mengyan1223.wang>
 <9a11c873-a362-b5d1-6d9c-e937034e267d@gmail.com>
 <bf9e05d4a6ece3e8bf1f732b011d3e54bbf8000e.camel@mengyan1223.wang>
 <84b3911173ad6beb246ba0a77f93d888ee6b393e.camel@mengyan1223.wang>
 <97c520ce107aa4d5fd96e2c380c8acdb63d45c37.camel@mengyan1223.wang>
 <7701fb71-9243-2d90-e1e1-d347a53b7d77@gmail.com>
 <368b9b1b7343e35b446bb1028ccf0ae75dc2adc4.camel@mengyan1223.wang>
User-Agent: Evolution 3.40.0 
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 30 Mar 2021 13:24:40 +0000
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

T24gMjAyMS0wMy0zMCAwMzo0MCArMDgwMCwgWGkgUnVveWFvIHdyb3RlOgo+IE9uIDIwMjEtMDMt
MjkgMjE6MzYgKzAyMDAsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4gPiBBbSAyOS4wMy4yMSB1
bSAyMToyNyBzY2hyaWViIFhpIFJ1b3lhbzoKPiA+ID4gSGkgQ2hyaXN0aWFuLAo+ID4gPiAKPiA+
ID4gSSBkb24ndCB0aGluayB0aGVyZSBpcyBhbnkgY29uc3RyYWludCBpbXBsZW1lbnRlZCB0byBl
bnN1cmUgYG51bV9lbnRyaWVzICUKPiA+ID4gQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRSA9
PSAwYC7CoCBGb3IgZXhhbXBsZSwgaW4gYGFtZGdwdV92bV9ib19tYXAoKWA6Cj4gPiA+IAo+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgIC8qIHZhbGlkYXRlIHRoZSBwYXJhbWV0ZXJzICovCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqAgaWYgKHNhZGRyICYgQU1ER1BVX0dQVV9QQUdFX01BU0sgfHwgb2Zmc2V0
ICYgQU1ER1BVX0dQVV9QQUdFX01BU0sKPiA+ID4gPiA+IAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2l6ZSA9PSAwIHx8IHNpemUgJiBBTURHUFVfR1BVX1BBR0VfTUFTSykKPiA+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4gPiA+IAo+
ID4gPiAvKiBzbmlwICovCj4gPiA+IAo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIHNhZGRyIC89IEFN
REdQVV9HUFVfUEFHRV9TSVpFOwo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIGVhZGRyIC89IEFNREdQ
VV9HUFVfUEFHRV9TSVpFOwo+ID4gPiAKPiA+ID4gLyogc25pcCAqLwo+ID4gPiAKPiA+ID4gwqDC
oMKgwqDCoMKgwqDCoCBtYXBwaW5nLT5zdGFydCA9IHNhZGRyOwo+ID4gPiDCoMKgwqDCoMKgwqDC
oMKgIG1hcHBpbmctPmxhc3QgPSBlYWRkcjsKPiA+ID4gCj4gPiA+IAo+ID4gPiBJZiB3ZSByZWFs
bHkgd2FudCB0byBlbnN1cmUgKG1hcHBpbmctPmxhc3QgLSBtYXBwaW5nLT5zdGFydCArIDEpICUK
PiA+ID4gQU1ER1BVX0dQVV9QQUdFU19JTl9DUFVfUEFHRSA9PSAwLCB0aGVuIHdlIHNob3VsZCBy
ZXBsYWNlCj4gPiA+ICJBTURHUFVfR1BVX1BBR0VfTUFTSyIKPiA+ID4gaW4gInZhbGlkYXRlIHRo
ZSBwYXJhbWV0ZXJzIiB3aXRoICJQQUdFX01BU0siLgoKSXQgc2hvdWxkIGJlICJ+UEFHRV9NQVNL
IiwgIlBBR0VfTUFTSyIgaGFzIGFuIG9wcG9zaXRlIGNvbnZlbnRpb24gb2YKIkFNREdQVV9HUFVf
UEFHRV9NQVNLIiA6KC4KCj4gPiBZZWFoLCBnb29kIHBvaW50Lgo+ID4gCj4gPiA+IEkgdHJpZWQg
aXQgYW5kIGl0IGJyb2tlIHVzZXJzcGFjZTogWG9yZyBzdGFydHVwIGZhaWxzIHdpdGggRUlOVkFM
IHdpdGgKPiA+ID4gdGhpcwo+ID4gPiBjaGFuZ2UuCj4gPiAKPiA+IFdlbGwgaW4gdGhlb3J5IGl0
IGlzIHBvc3NpYmxlIHRoYXQgd2UgYWx3YXlzIGZpbGwgdGhlIEdQVVZNIG9uIGEgNGsgCj4gPiBi
YXNpcyB3aGlsZSB0aGUgbmF0aXZlIHBhZ2Ugc2l6ZSBvZiB0aGUgQ1BVIGlzIGxhcmdlci4gTGV0
IG1lIGRvdWJsZSAKPiA+IGNoZWNrIHRoZSBjb2RlLgoKT24gbXkgcGxhdGZvcm0sIHRoZXJlIGFy
ZSB0d28gaXNzdWVzIGJvdGggY2F1c2luZyB0aGUgVk0gY29ycnVwdGlvbi4gIE9uZSBpcwpmaXhl
ZCBieSBhZ2Q1Zi9saW51eEBmZTAwMWU3LiAgQW5vdGhlciBpcyBpbiBNZXNhIGZyb20gdXNlcnNw
YWNlOiAgaXQgdXNlcwpgZGV2X2luZm8tPmdhcnRfcGFnZV9zaXplYCBhcyB0aGUgYWxpZ25tZW50
LCBidXQgdGhlIGtlcm5lbCBBTURHUFUgZHJpdmVyCmV4cGVjdHMgaXQgdG8gdXNlIGBkZXZfaW5m
by0+dmlydHVhbF9hZGRyZXNzX2FsaWdubWVudGAuCgpJZiB3ZSBjYW4gbWFrZSB0aGUgY2hhbmdl
IHRvIGZpbGwgdGhlIEdQVVZNIG9uIGEgNGsgYmFzaXMsIHdlIGNhbiBmaXggdGhpcyBpc3N1ZQph
bmQgbWFrZSB2aXJ0dWFsX2FkZHJlc3NfYWxpZ25tZW50ID0gNEsuICBPdGhlcndpc2UsIHdlIHNo
b3VsZCBmb3J0aWZ5IHRoZQpwYXJhbWV0ZXIgdmFsaWRhdGlvbiwgY2hhbmdpbmcgIkFNREdQVV9H
UFVfUEFHRV9NQVNLIiB0byAiflBBR0VfTUFTSyIuICBUaGVuIHRoZQp1c2Vyc3BhY2Ugd2lsbCBq
dXN0IGdldCBhbiBFSU5WQUwsIGluc3RlYWQgb2YgYSBzbGllbnQgVk0gY29ycnVwdGlvbi4gIEFu
ZApzb21lb25lIHNob3VsZCB0ZWxsIE1lc2EgZGV2ZWxvcGVycyB0byBmaXggdGhlIGNvZGUgaW4g
dGhpcyBjYXNlLgotLQpYaSBSdW95YW8gPHhyeTExMUBtZW5neWFuMTIyMy53YW5nPgpTY2hvb2wg
b2YgQWVyb3NwYWNlIFNjaWVuY2UgYW5kIFRlY2hub2xvZ3ksIFhpZGlhbiBVbml2ZXJzaXR5Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
