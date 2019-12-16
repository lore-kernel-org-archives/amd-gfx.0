Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531BEC43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271A82166E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 20:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vR2eOHW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271A82166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135D06E87E;
	Mon, 16 Dec 2019 20:24:53 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F7F6E87A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 20:24:51 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p17so698084wma.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 12:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1jl2NZx2FXy+lL515/n+04qMoIKRr6llS2ZR4GSgKrY=;
 b=vR2eOHW7RQg9brWkoCehM2Tz3vn5tHYCpNJU+rc9ZVrp8iIxhgEgdfibgduzNuPVTC
 mgd8WMEW4wkKph4G60C5YF4LIHVKuFI6Ky+5wDH6WdUJS41r5w9GSKEaXWDj6TUtMNpJ
 OvC/OUxySD0k27EgrY18JvT6ZlYHRt978tXSRoB2GkiV6+yFi7YfbmPyvK66N2YDQuPe
 nWnFxIzKE2F3A/gcolG4JaT/pgVRMk0P5r2HBWY2FLb6CUe0TGs9x4jTr6nr2alRXgf/
 1UYrwCFonuHIZvo2o4d3MUf4nthjbp4IxnYSREu/v9WaEACw6rv3ADbWg03+b4O45wRF
 dIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=1jl2NZx2FXy+lL515/n+04qMoIKRr6llS2ZR4GSgKrY=;
 b=FQRS1B4eyt964qUcUgFR1UZocWSzJwk8l6mOqByaBiktL7sIiUr5HDCSX1bsJD4V/i
 B98L7aDoz5CJWxHr1jMLILjbgCvB4Jg4Q6gHBzy9tPqmqP65EwcxtVjdDyqIF/I3ar6Y
 UimofatU9fy3ZzvdwyXx1dAM/FBVqm4FYNIUWHnIvAZifgqtctBW4XPU1P6/VO3zsLN9
 RVovkZ5PMDJM0LZPVidaN39fn2BAsM+pIwVxLa6uRkNUHhpnTWh/aRXqv0OgAF/WBIjZ
 EThtvagvqnLyRMRBuoFP/uQ+4IoO3RGIV7IVhMfm4KJ2NLVk5FSioKvQR1OItIUNsJCl
 PHzA==
X-Gm-Message-State: APjAAAWk5vjfoZaJoAFvILxWSMir3KzGFaNHcOd8rLf8Vr5t75Oaazkd
 3MZf4uxpe92cvda18oRFQjKQidDq
X-Google-Smtp-Source: APXvYqxyJDZYopw0ytBRfADkUf6JWKIPH7itbc8+VeLt+sSGsrH8JgL2pgfp/IzBj7XNIVPgxK7ONQ==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr902575wma.106.1576527890207;
 Mon, 16 Dec 2019 12:24:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id k13sm22694665wrx.59.2019.12.16.12.24.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 12:24:49 -0800 (PST)
Subject: Re: [PATCH 2/3] drm/amdgpu/pm_runtime: update usage count in fence
 handling
To: Alex Deucher <alexdeucher@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
References: <20191216171834.217251-1-alexander.deucher@amd.com>
 <20191216171834.217251-2-alexander.deucher@amd.com>
 <d9b19564-79b4-6044-8b0d-5dba5adf6982@gmail.com>
 <CADnq5_M1N8Bs1-FH+TpqbDWRXk+bcEx9=+Q8+qr=Bv5NbXwwjw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e9a5d212-9392-8a3b-0afa-3fd1ee0390f5@gmail.com>
Date: Mon, 16 Dec 2019 21:24:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CADnq5_M1N8Bs1-FH+TpqbDWRXk+bcEx9=+Q8+qr=Bv5NbXwwjw@mail.gmail.com>
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMTIuMTkgdW0gMjE6MjIgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gT24gTW9uLCBEZWMg
MTYsIDIwMTkgYXQgMzoxOSBQTSBDaHJpc3RpYW4gS8O2bmlnCj4gPGNrb2VuaWcubGVpY2h0enVt
ZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPj4gQW0gMTYuMTIuMTkgdW0gMTg6MTggc2NocmllYiBB
bGV4IERldWNoZXI6Cj4+PiBJbmNyZW1lbnQgdGhlIHVzYWdlIGNvdW50IGluIGVtaXQgZmVuY2Us
IGFuZCBkZWNyZW1lbnQgaW4KPj4+IHByb2Nlc3MgZmVuY2UgdG8gbWFrZSBzdXJlIHRoZSBHUFUg
aXMgYWx3YXlzIGNvbnNpZGVyZWQgaW4KPj4+IHVzZSB3aGlsZSB0aGVyZSBhcmUgZmVuY2VzIG91
dHN0YW5kaW5nLiAgV2UgYWx3YXlzIHdhaXQgZm9yCj4+PiB0aGUgZW5naW5lcyB0byBkcmFpbiBp
biBydW50aW1lIHN1c3BlbmQsIGJ1dCBpbiBwcmFjdGljZQo+Pj4gdGhhdCBvbmx5IGNvdmVycyBz
aG9ydCBsaXZlZCBqb2JzIGZvciBnZnguICBUaGlzIHNob3VsZAo+Pj4gY292ZXIgdXMgZm9yIGxv
bmdlciBsaXZlZCBmZW5jZXMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyB8IDYgKysrKystCj4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPj4+IGluZGV4IDM3N2ZlMjBiY2UyMy4uZTllZmVl
MDRjYTIzIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2ZlbmNlLmMKPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5j
ZS5jCj4+PiBAQCAtMzQsNiArMzQsNyBAQAo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2tyZWYuaD4K
Pj4+ICAgICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4+PiAgICAjaW5jbHVkZSA8bGludXgvZmly
bXdhcmUuaD4KPj4+ICsjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPgo+Pj4KPj4+ICAgICNp
bmNsdWRlIDxkcm0vZHJtX2RlYnVnZnMuaD4KPj4+Cj4+PiBAQCAtMTU0LDcgKzE1NSw3IEBAIGlu
dCBhbWRncHVfZmVuY2VfZW1pdChzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHN0cnVjdCBkbWFf
ZmVuY2UgKipmLAo+Pj4gICAgICAgICAgICAgICAgICAgICAgIHNlcSk7Cj4+PiAgICAgICAgYW1k
Z3B1X3JpbmdfZW1pdF9mZW5jZShyaW5nLCByaW5nLT5mZW5jZV9kcnYuZ3B1X2FkZHIsCj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzZXEsIGZsYWdzIHwgQU1ER1BVX0ZFTkNFX0ZM
QUdfSU5UKTsKPj4+IC0KPj4+ICsgICAgIHBtX3J1bnRpbWVfZ2V0X25vcmVzdW1lKGFkZXYtPmRk
ZXYtPmRldik7Cj4+PiAgICAgICAgcHRyID0gJnJpbmctPmZlbmNlX2Rydi5mZW5jZXNbc2VxICYg
cmluZy0+ZmVuY2VfZHJ2Lm51bV9mZW5jZXNfbWFza107Cj4+PiAgICAgICAgaWYgKHVubGlrZWx5
KHJjdV9kZXJlZmVyZW5jZV9wcm90ZWN0ZWQoKnB0ciwgMSkpKSB7Cj4+PiAgICAgICAgICAgICAg
ICBzdHJ1Y3QgZG1hX2ZlbmNlICpvbGQ7Cj4+PiBAQCAtMjM0LDYgKzIzNSw3IEBAIHN0YXRpYyB2
b2lkIGFtZGdwdV9mZW5jZV9zY2hlZHVsZV9mYWxsYmFjayhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJp
bmcpCj4+PiAgICBib29sIGFtZGdwdV9mZW5jZV9wcm9jZXNzKHN0cnVjdCBhbWRncHVfcmluZyAq
cmluZykKPj4+ICAgIHsKPj4+ICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2ZlbmNlX2RyaXZlciAqZHJ2
ID0gJnJpbmctPmZlbmNlX2RydjsKPj4+ICsgICAgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gcmluZy0+YWRldjsKPj4+ICAgICAgICB1aW50MzJfdCBzZXEsIGxhc3Rfc2VxOwo+Pj4gICAg
ICAgIGludCByOwo+Pj4KPj4+IEBAIC0yNzQsNiArMjc2LDggQEAgYm9vbCBhbWRncHVfZmVuY2Vf
cHJvY2VzcyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgIEJVRygpOwo+Pj4KPj4+ICAgICAgICAgICAgICAgIGRtYV9mZW5jZV9wdXQoZmVuY2UpOwo+
Pj4gKyAgICAgICAgICAgICBwbV9ydW50aW1lX21hcmtfbGFzdF9idXN5KGFkZXYtPmRkZXYtPmRl
dik7Cj4+PiArICAgICAgICAgICAgIHBtX3J1bnRpbWVfcHV0X2F1dG9zdXNwZW5kKGFkZXYtPmRk
ZXYtPmRldik7Cj4+IEFyZSB5b3Ugc3VyZSB0aGlzIGlzIG9rPyBLZWVwIGluIG1pbmQgdGhhdCB0
aGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCBpbgo+PiBpbnRlcnJ1cHQgY29udGV4dC4KPiBBY2NvcmRp
bmcgdG86Cj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvRG9jdW1lbnRhdGlvbi9wb3dlci9y
dW50aW1lX3BtLnR4dAo+IGl0J3Mgb2sgdG8gY2FsbCB0aG9zZSBpbiBhbiBpbnRlcnJ1cHQgY29u
dGV4dC4KCkluIHRoaXMgY2FzZSB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKQ2hyaXN0aWFuLgoKPgo+IEFsZXgK
Pgo+PiBDaHJpc3RpYW4uCj4+Cj4+PiAgICAgICAgfSB3aGlsZSAobGFzdF9zZXEgIT0gc2VxKTsK
Pj4+Cj4+PiAgICAgICAgcmV0dXJuIHRydWU7Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
