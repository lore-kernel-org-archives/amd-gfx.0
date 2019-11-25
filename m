Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE63C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 02:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B5B20674
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 02:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B5B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA2C589B9E;
	Mon, 25 Nov 2019 02:56:32 +0000 (UTC)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04BE689B9E
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 02:56:30 +0000 (UTC)
Received: by mail-il1-x141.google.com with SMTP id v17so8927610ilg.7
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Nov 2019 18:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b3ZCmOmB5v3YUUtkfpjo2zeo1r/y5FN7gIfzgSLNA14=;
 b=PHEB+ummhidXjgA3hIPs0bIKhvpNCj0zkOkzsD1BPyXrD45bELkx9TAP1tbSQlZoX8
 dS3oeOCB6mBjIy7Gd6YlsvKom6uyW50zH3+4dDl4XgpLJ085TxZ6yQwyt/zyDozE7L2T
 donk4DuZysIkPRAzH98Zs/8ZumIJVLGzmCSePDrxw7F/gBKUg4GugG/6ZIaCKWwCQhmf
 QnJ/msQe06Q6cRWuIN6J/LOro/0u2r07IwhoalPZ6CdyNJ7zB3JGTfv/8uzbImof17g0
 LKETmL4w0DFLI6LCAhHlS1ilJXmB8zPisPM9WJmwXCrL9IJe/8wuKEzSeKdFfgxKzoNO
 Uuhw==
X-Gm-Message-State: APjAAAWCfO3OW7P0P3DLMfF0bS0UsPx/IfWuE9tBlxtnyKrAhCWUe98R
 wisSGEYxgrOpqZMa3jWn74wbPh8eYyDtYJU1Mhgr+Q==
X-Google-Smtp-Source: APXvYqx5K6svuRrDFk9TdyvpTmH94/L886EU0JCo5MRKhCkiplVNVqOFYSCKGvgJr8/hX+gfOVAi/FuUZGRr9oy2q7M=
X-Received: by 2002:a92:cd03:: with SMTP id z3mr30225427iln.76.1574650590133; 
 Sun, 24 Nov 2019 18:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20191115160119.658620-1-alexander.deucher@amd.com>
 <CADnq5_P5m-eWDy5Xb5qs2HpcZbh3FxLTAxhxsXRZGDbkYrTZnA@mail.gmail.com>
In-Reply-To: <CADnq5_P5m-eWDy5Xb5qs2HpcZbh3FxLTAxhxsXRZGDbkYrTZnA@mail.gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Mon, 25 Nov 2019 03:56:18 +0100
Message-ID:
 <CAD=4a=UAKO9Y+6fwy8QTBsemUuGe6yhwB8eVgkGHZzYWa_nDpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: re-enable wait in pipelock,
 but add timeout
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=b3ZCmOmB5v3YUUtkfpjo2zeo1r/y5FN7gIfzgSLNA14=;
 b=Puxwc5gv+yXLIyyJidpklVbSOnVDNtD5O99bjCzZ8WLKgoRkZ1QJBDotgZJoiGEe96
 /nr0WWDgDgGSQ1KHzGp0NYnNhfgenU/AZRqCiUqH3J0VSGVFDYNkFHj2+ShpvIPknArB
 uBKih9akre7LdyhmOlWvRL4JV7JJN6taM8fpypEn0rpIpyzE0yaypfFWMpBmrmAxObGo
 k/lsBuo7pXhNyCEJubDcdkvAaN/i06g88USOmecolzIXpEyYMBXY4KgVpMQws9cDS/Lc
 B7a9c8I157ZDln1wL2u1YYEzD1/epkFHaJYkCcu76OBijsObiFn35K/0Kxp6W2fxjutl
 24sg==
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125025618.CZmxyhxWpsyMueQw--xd125YaNOHhDOY7E0bQPMBxBc@z>

VGhlIHNhbWUgYnVnIGlzIGxpc3RlZCB0d2ljZS4gRGlkIHlvdSBtZWFuIGEgdGhpcmQgYnVnPwoK
CkRlbiB0b3JzIDIxIG5vdi4gMjAxOSBrbCAwMDoyNSBza3JldiBBbGV4IERldWNoZXIgPGFsZXhk
ZXVjaGVyQGdtYWlsLmNvbT46Cj4KPiBQaW5nPwo+Cj4gT24gRnJpLCBOb3YgMTUsIDIwMTkgYXQg
MTE6MDEgQU0gQWxleCBEZXVjaGVyIDxhbGV4ZGV1Y2hlckBnbWFpbC5jb20+IHdyb3RlOgo+ID4K
PiA+IFJlbW92aW5nIHRoaXMgY2F1c2VzIGhhbmdzIGluIHNvbWUgZ2FtZXMsIHNvIHJlLWFkZCBp
dCwgYnV0IGFkZAo+ID4gYSB0aW1lb3V0IHNvIHdlIGRvbid0IGhhbmcgd2hpbGUgc3dpdGNoaW5n
IGZsaXAgdHlwZXMuCj4gPgo+ID4gQnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hv
d19idWcuY2dpP2lkPTIwNTE2OQo+ID4gQnVnOiBodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3Jn
L3Nob3dfYnVnLmNnaT9pZD0xMTIyNjYKPiA+IEJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwu
b3JnL3Nob3dfYnVnLmNnaT9pZD0yMDUxNjkKPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPiA+IC0tLQo+ID4gIC4uLi9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYyAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysK
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCj4gPiBpbmRl
eCAwMDQ2YTA5OWM5ZTkuLjEyMGU2MmM1MTkzYyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCj4gPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfaHdzZXEuYwo+ID4gQEAgLTEwMzMs
NiArMTAzMywyNSBAQCB2b2lkIGRjbjIwX3BpcGVfY29udHJvbF9sb2NrKAo+ID4gICAgICAgICBp
ZiAocGlwZS0+cGxhbmVfc3RhdGUgIT0gTlVMTCkKPiA+ICAgICAgICAgICAgICAgICBmbGlwX2lt
bWVkaWF0ZSA9IHBpcGUtPnBsYW5lX3N0YXRlLT5mbGlwX2ltbWVkaWF0ZTsKPiA+Cj4gPiArICAg
ICAgIGlmIChmbGlwX2ltbWVkaWF0ZSAmJiBsb2NrKSB7Cj4gPiArICAgICAgICAgICAgICAgY29u
c3QgaW50IFRJTUVPVVRfRk9SX0ZMSVBfUEVORElORyA9IDEwMDAwMDsKPiA+ICsgICAgICAgICAg
ICAgICBpbnQgaTsKPiA+ICsKPiA+ICsgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBpIDwgVElN
RU9VVF9GT1JfRkxJUF9QRU5ESU5HOyArK2kpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IGlmICghcGlwZS0+cGxhbmVfcmVzLmh1YnAtPmZ1bmNzLT5odWJwX2lzX2ZsaXBfcGVuZGluZyhw
aXBlLT5wbGFuZV9yZXMuaHVicCkpCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJyZWFrOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdWRlbGF5KDEpOwo+ID4gKyAgICAg
ICAgICAgICAgIH0KPiA+ICsKPiA+ICsgICAgICAgICAgICAgICBpZiAocGlwZS0+Ym90dG9tX3Bp
cGUgIT0gTlVMTCkgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8
IFRJTUVPVVRfRk9SX0ZMSVBfUEVORElORzsgKytpKSB7Cj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmICghcGlwZS0+Ym90dG9tX3BpcGUtPnBsYW5lX3Jlcy5odWJwLT5mdW5j
cy0+aHVicF9pc19mbGlwX3BlbmRpbmcocGlwZS0+Ym90dG9tX3BpcGUtPnBsYW5lX3Jlcy5odWJw
KSkKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWRlbGF5KDEpOwo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgfQo+ID4gKyAgICAgICAgICAgICAgIH0KPiA+ICsgICAgICAgfQo+ID4g
Kwo+ID4gICAgICAgICAvKiBJbiBmbGlwIGltbWVkaWF0ZSBhbmQgcGlwZSBzcGxpdHRpbmcgY2Fz
ZSwgd2UgbmVlZCB0byB1c2UgR1NMCj4gPiAgICAgICAgICAqIGZvciBzeW5jaHJvbml6YXRpb24u
IE9ubHkgZG8gc2V0dXAgb24gbG9ja2luZyBhbmQgb24gZmxpcCB0eXBlIGNoYW5nZS4KPiA+ICAg
ICAgICAgICovCj4gPiAtLQo+ID4gMi4yMy4wCj4gPgo+IF9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZng=
