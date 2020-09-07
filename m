Return-Path: <SRS0=05a7=CQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EDAC2BB84
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 11:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152A9217A0
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2020 11:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=basnieuwenhuizen-nl.20150623.gappssmtp.com header.i=@basnieuwenhuizen-nl.20150623.gappssmtp.com header.b="IgZ4b90A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152A9217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13BAA6E42B;
	Mon,  7 Sep 2020 11:11:20 +0000 (UTC)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE766E42A
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2020 11:11:18 +0000 (UTC)
Received: by mail-il1-x144.google.com with SMTP id u20so3323214ilk.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2020 04:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen-nl.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qVIkRXb3V7Lgt0fIgBMjW9DYDcINeRE4iqsExJAxe9k=;
 b=IgZ4b90AlG1J5evF0yAPopjwhb0wIw97vd1bHJhDGzEZFkF+QHXwomRn/kkD1yh8xQ
 njSjr9qCNmz7Y0J28csvQ2egb0P8//jYrYfL4VpCe6cGUQYY7Ae5smdWqWJeLMGzKNaO
 Ox7SzuZE0bWqh9UgolmayJ0YvAnHK9IRe5kVlonv7Aq4gU8rWmJ7nbBK7WwqMXNn99NL
 3QG5CrK8qWF3nRnW6JJcIOLjcBVz6EMO1v/ByMCEHEoxpXc5rkR7MA4kWbimkpEzYh0c
 ZL0ZEXruvNJxNB/S20Xn1Oq0CEH4k8WyltTksBrZFtux5iKndkX7vo/tk18m9AxW0Lt5
 N/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qVIkRXb3V7Lgt0fIgBMjW9DYDcINeRE4iqsExJAxe9k=;
 b=oG8uvH8NTaHQ0aY7Tk7q6SRz0CtCRfHciAy1AJSTob5Ocw87T4Y++25pPVm776WtqX
 Xly3l/JU2eb9E6cW0heHcLV7+0+7AJQoUZHyKU2l81xBnFa6i2X83TOibp8UBDwCgTF4
 3TDZdktIm+mk17pB5Z5fJKG68Wt4I6ZlwpgsYqHcNRj1lkd5g5UXj0hYYBIrUR4CYaxF
 GEqL4RGRr291gPqSkMGHEJyqbBEobyhemTEY23MrO2VBLcj1ofPiKrU0zYgURitDzIdo
 gRgnlRJhVs+AJYU+u/XW3HcdG9JLIv6f9U0phZkichLDYOc7R5wkBiZpXU87Ow+4zRdn
 QKbQ==
X-Gm-Message-State: AOAM53049gujbYNgRgJC84atKBxfcGKaAKe0WrM/K+c6WxsrX3ABsYLn
 lnh7EbPtEtISgdEmAFOAHM23344gKOGxmL0gNWDxwA==
X-Google-Smtp-Source: ABdhPJxM4oQHluiRrvOCoOXMFcN5zL85U/KX9UtlWwK4uaZXRVYlByGXGkCfEP17XCObfoYdNWRePbm+X7zplhniilY=
X-Received: by 2002:a92:189:: with SMTP id 131mr19211929ilb.40.1599477077917; 
 Mon, 07 Sep 2020 04:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200904160709.123970-1-bas@basnieuwenhuizen.nl>
 <CAD=4a=UAfoBBUTAxNPu709Q1JbjjwCivmFirC7Ka7DNzM3cSTA@mail.gmail.com>
In-Reply-To: <CAD=4a=UAfoBBUTAxNPu709Q1JbjjwCivmFirC7Ka7DNzM3cSTA@mail.gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 7 Sep 2020 13:11:09 +0200
Message-ID: <CAP+8YyE8KdU06tbt1DS5FZ0SkfxoaxtoQgu7HKifQzSO6_HsUQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] amd/display: Add GFX9+ modifier support.
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Stone <daniel@fooishbar.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexdeucher@gmail.com>, Harry Wentland <harry.wentland@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gTW9uLCBTZXAgNywgMjAyMCBhdCAxMDo1MSBBTSBFcm5zdCBTasO2c3RyYW5kIDxlcm5zdHBA
Z21haWwuY29tPiB3cm90ZToKPgo+Cj4KPiBEZW4gZnJlIDQgc2VwLiAyMDIwIGtsIDE4OjA3IHNr
cmV2IEJhcyBOaWV1d2VuaHVpemVuIDxiYXNAYmFzbmlldXdlbmh1aXplbi5ubD46Cj4+Cj4+IFRo
aXMgYWRkcyBtb2RpZmllciBzdXBwb3J0IHRvIHJhZGVvbnNpLgo+Cj4KPiBXb3VsZG4ndCBpdCBi
ZSBtb3JlIGNvcnJlY3QgdG8gc2F5IHRoYXQgdGhpcyBhZGRzIG1vZGlmaWVyIHN1cHBvcnQgdG8g
YW1kZ3B1IChhbmQgZW5hYmxlcyBpdCB0byB3b3JrIHdpdGggcmFkZW9uc2kgT3BlbkdMKQo+IG9y
IHNvbWV0aGluZyBsaWtlIHRoYXQ/CgpZZXAsIHRoaXMgd2FzIGNvcHkgcGFzdGVkIGZyb20gdGhl
IHVzZXJzcGFjZSBNUiAuLi4KCj4KPiAvL0UKPgo+Pgo+PiBJdCBoYXMgYmVlbiB0ZXN0ZWQgb24K
Pj4KPj4gLSBWRUdBMTAsIFJBVkVOLCBOQVZJMTQKPj4gLSB3ZXN0b24sIHN3YXksIFggd2l0aCB4
Zjg2LXZpZGVvLWFtZGdwdSAoaS5lLiBsZWdhY3kgcGF0aCBzdGlsbCB3b3JrcykKPj4KPj4gYW5k
IGluY2x1ZGVzIHNvbWUgYmFzaWMgdGVzdGluZyBvZiB0aGUgbGF5b3V0IGNvZGUuCj4+Cj4+IFRo
ZSBtYWluIGdvYWwgaXMgdG8ga2VlcCBpdCBzb21ld2hhdCBzaW1wbGUgYW5kIHJlZ3Jlc3Npb24g
ZnJlZSwgc28KPj4gb24gdGhlIGRpc3BsYXkgc2lkZSB0aGlzIHNlcmllcyBvbmx5IGV4cG9zZXMg
d2hhdCB0aGUgY3VycmVudCBHUFUKPj4gY2FuIHJlbmRlciB0by4gV2hpbGUgd2UgY291bGQgZXhw
b3NlIG1vcmUgSSB0aGluayB0aGF0IGlzIG1vcmUKPj4gc3VpdGFibGUgZm9yIGZvbGxvdy11cCB3
b3JrIGFzIHRoZSBiZW5lZml0IHdvdWxkIGJlIG1pbmltYWwgYW5kCj4+IHRoZXJlIGFyZSBzb21l
IG1vcmUgZGVzaWduIGRpc2N1c3Npb24gdGhlcmUgdG8gZGlzY3VzcyB0aGF0IGFyZQo+PiBvcnRo
b2dvbmFsIGZyb20gdGhlIGluaXRpYWwgaW1wbGVtZW50YXRpb24uCj4+Cj4+IFNpbWlsYXJseSB0
aGlzIHNlcmllcyBvbmx5IGV4cG9zZXMgMzItYnBwIGRpc3BsYXlhYmxlIERDQyBpbiB0aGUgY2Fz
ZXMKPj4gdGhhdCByYWRlb25zaSB3b3VsZCB1c2UgaXQgYW5kIGFueSBleHRyYSBjYXBhYmlsaXRp
ZXMgaGVyZSBzaG91bGQgYmUKPj4gZnV0dXJlIHdvcmsuCj4+Cj4+IEkgYmVsaWV2ZSB0aGVzZSBh
cmUgYnkgZmFyIHRoZSBtb3N0IGNvbXBsaWNhdGVkIG1vZGlmaWVycyB3ZSd2ZSBzZWVuCj4+IHVw
IHRpbGwgbm93LCBtb3N0bHkgcmVsYXRlZCB0bwo+Pgo+PiAtIEdQVSBpZGVudGlmaWNhdGlvbiBm
b3IgY2FzZXMgd2hlcmUgaXQgbWF0dGVycyB3cnQgdGlsaW5nLgo+PiAtIEV2ZXJ5IGdlbmVyYXRp
b24gaGF2aW5nIHRpbGluZyBsYXlvdXQgY2hhbmdlcwo+PiAtIENvbXByZXNzaW9uIHNldHRpbmdz
Lgo+Pgo+PiBJIGJlbGlldmUgdGhlIGNvbXBsZXhpdHkgaXMgbmVjZXNzYXJ5IGFzIGV2ZXJ5IGxh
eW91dCBzaG91bGQgYmUgZGlmZmVyZW50Cj4+IGFuZCBhbGwgbGF5b3V0cyBzaG91bGQgYmUgdGhl
IGJlc3QgaW4gc29tZSBzaXR1YXRpb24gKHRob3VnaCBub3QgYWxsCj4+IGNvbWJpbmF0aW9ucyBv
ZiBHUFUgcGFyYW1ldGVycyB3aWxsIGFjdHVhbGx5IGhhdmUgYW4gZXhpc3RpbmcgR1BVKS4KPj4K
Pj4gVGhhdCBzYWlkLCBvbiB0aGUgcmVuZGVyIHNpZGUgdGhlIG51bWJlciBvZiBtb2RpZmllcnMg
YWN0dWFsbHkgbGlzdGVkIGZvcgo+PiBhIGdpdmVuIEdQVSBpcyB+MTAsIGFuZCBpbiB0aGUgY3Vy
cmVudCBpbXBsZW1lbnRhdGlvbiB0aGF0IGlzIHRoZSBzYW1lCj4+IGZvciB0aGUgZGlzcGxheSBz
aWRlLiAod2UgY291bGQgZXhwb3NlIG1vcmUgYWN0dWFsbHkgZGlmZmVyaW5nIGxheW91dHMKPj4g
b24gdGhlIGRpc3BsYXkgc2lkZSBmb3IgY3Jvc3MtR1BVIGNvbXBhdGliaWxpdHksIGJ1dCBJIGNv
bnNpZGVyIHRoYXQKPj4gb3V0IG9mIHNjb3BlIGZvciB0aGlzIGluaXRpYWwgd29yaykuCj4+Cj4+
IFRoaXMgc2VyaWVzIGNhbiBiZSBmb3VuZCBvbgo+PiBodHRwczovL2dpdGh1Yi5jb20vQk5pZXV3
ZW5odWl6ZW4vbGludXgvdHJlZS9tb2RpZmllcnMKPj4KPj4gQW4gdXNlcnNwYWNlIGltcGxlbWVu
dGF0aW9uIGluIHJhZGVvbnNpIGNhbiBiZSBmb3VuZCBvbgo+PiBodHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvbWVzYS9tZXNhLy0vbWVyZ2VfcmVxdWVzdHMvNjE3Ngo+Pgo+PiB2MjoKPj4K
Pj4gUGVyIHN1Z2dlc3Rpb24gZnJvbSBEYW5pZWwgVmV0dGVyIEkgYWRkZWQgbG9naWMgdG8gZ2V0
IHRoZSB0aWxpbmdfZmxhZ3MgYXQKPj4gYWRkZmIyIHRpbWUgYW5kIGNvbnZlcnQgdGhlbSBpbnRv
IG1vZGlmaWVycyBmb3IgR0ZYOSsuICBGdXJ0aGVybW9yZSwgdGhlIERDQwo+PiBjb25zdGFudCBl
Y29uZGluZyBtb2RpZmVycyBvbmx5IGdldCBleHBvc2VkIG9uIFJBVkVOMiBhbmQgbmV3ZXIuCj4+
Cj4+IEJhcyBOaWV1d2VuaHVpemVuICgxMSk6Cj4+ICAgZHJtL2FtZC9kaXNwbGF5OiBEbyBub3Qg
c2lsZW50bHkgYWNjZXB0IERDQyBmb3IgbXVsdGlwbGFuZSBmb3JtYXRzLgo+PiAgIGRybS9hbWQ6
IEluaXQgbW9kaWZpZXIgZmllbGQgb2YgaGVscGVyIGZiLgo+PiAgIGRybS9hbWQvZGlzcGxheTog
SG9ub3IgdGhlIG9mZnNldCBmb3IgcGxhbmUgMC4KPj4gICBkcm0vZm91cmNjOiAgQWRkIEFNRCBE
Uk0gbW9kaWZpZXJzLgo+PiAgIGRybS9hbWQvZGlzcGxheTogU3RvcmUgdGlsaW5nX2ZsYWdzIGlu
IHRoZSBmcmFtZWJ1ZmZlci4KPj4gICBkcm0vYW1kL2Rpc3BsYXk6IENvbnZlcnQgdGlsaW5nX2Zs
YWdzIHRvIG1vZGlmaWVycy4KPj4gICBkcm0vYW1kL2Rpc3BsYXk6IFJlZmFjdG9yIHN1cmZhY2Ug
dGlsaW5nIHNldHVwLgo+PiAgIGRybS9hbWQvZGlzcGxheTogU2V0IERDIG9wdGlvbnMgZnJvbSBt
b2RpZmllcnMuCj4+ICAgZHJtL2FtZC9kaXNwbGF5OiBBZGQgZm9ybWF0cyBmb3IgRENDIHdpdGgg
Mi8zIHBsYW5lcy4KPj4gICBkcm0vYW1kL2Rpc3BsYXk6IEV4cG9zZSBtb2RpZmllcnMuCj4+ICAg
ZHJtL2FtZC9kaXNwbGF5OiBDbGVhbiB1cCBHRlg5IHRpbGluZ19mbGFncyBwYXRoLgo+Pgo+PiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyAgIHwgMTY5ICsrKy0K
Pj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jICAgICAgICB8ICAgMiAr
LQo+PiAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X21vZGUuaCAgICAgIHwgICAz
ICsKPj4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDc1
NCArKysrKysrKysrKysrKy0tLS0KPj4gIC4uLi9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9k
bS9hbWRncHVfZG0uaCB8ICAgMiAtCj4+ICBpbmNsdWRlL3VhcGkvZHJtL2RybV9mb3VyY2MuaCAg
ICAgICAgICAgICAgICAgfCAxMTUgKysrCj4+ICA2IGZpbGVzIGNoYW5nZWQsIDg4MCBpbnNlcnRp
b25zKCspLCAxNjUgZGVsZXRpb25zKC0pCj4+Cj4+IC0tCj4+IDIuMjguMAo+Pgo+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
