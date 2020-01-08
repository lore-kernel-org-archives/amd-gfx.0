Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7975BC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 22:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426B420692
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 22:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI35RKES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426B420692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CDC96E343;
	Wed,  8 Jan 2020 22:23:07 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6E76E343
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 22:23:06 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id z3so5196810wru.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 14:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=medCEYmK/2Q21mgNUsUWP26si4oDaAOLqoYWtnJzxjI=;
 b=BI35RKESlYbR3th8O3L1+5/r66Cvv2Qaj1gE2DTUFjG/91CN1hgyPzcrNqmsjaqiCw
 GEGHRNPz7dKq6pkfUbHB0orEY690mK3H85zfBAK/AgeZWWDP/NamDxrEjwSSCyIwr4pX
 zyNsT1Qm/hHfj1x+GnZbzXT1oxwTRtEsG26BGD+hN3tVnH2aD7MudPMk0P7b5akw9zlr
 O8YTGJqFBvZL/6BYA9M0Y0HbbGuELjvZlbfHklzTj4a91ygH8UoMU1T/LqnT2I2i4tBM
 6Xk7GdLK1OTGQJOgysPaQDmMkcDVSeohgqq3w6Vxc2zHt5ws4BfSwBmHe+iWukmILPF4
 WP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=medCEYmK/2Q21mgNUsUWP26si4oDaAOLqoYWtnJzxjI=;
 b=ZOL/2ZX0VsxvUSE+cF06Pyv1uc4sEE4XJCZlhENlSUUshmzHc+gw4KWzHSjh8t6Eb5
 l0wj8VFsVOaaY1yGnizRPyDgiKo37lfEwdho2OfPRhHPh6XNqovOUOd4dWa2uBgVa7yl
 6vi5dCsfuTZ4JkyTEZ1KrmYiSP2+wkmcEuoObWJwnOQWicAUuimzkp4htmKXbIN1cehr
 QsW4RfP0947GNZOfBlDLS6okP2Q7q2A4Zl/lxesuTOrsmTTzo7FHBptL6FBke+hE4s86
 +4V9GzgsZxfipsGDvZro+jLNBlwPC/dbteypTdcT0twbzf91P+yMyTQCFZ2Qhivk/452
 7qrQ==
X-Gm-Message-State: APjAAAUI3aMGiqe7Wga51gW3svsxjNmVsLFkDwwa7STx0WSpzuXC3b09
 9MVFM2zXppk12zRPR8cti7HTnPR0SDLGHEWnNzd/NxPz
X-Google-Smtp-Source: APXvYqzZChZdW9X6ij7e8fj+fJ7ZwjXp8KJYkvxx9/jaXLH570JQANip79iWJ0AG8CyGZVFhevjkqjbUUkNyuSipwmo=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr7260972wrn.50.1578522184820; 
 Wed, 08 Jan 2020 14:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20200107211320.1820393-1-alexander.deucher@amd.com>
 <43f09121-e188-17f6-8039-6b61e0063df0@gmail.com>
In-Reply-To: <43f09121-e188-17f6-8039-6b61e0063df0@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2020 17:22:53 -0500
Message-ID: <CADnq5_NdhBwooRcjZRRzx9njhJm9rycbdOmAE301h7XppXe6xg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: enable S/G display on PCO and RV2
To: Christian Koenig <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKYW4gOCwgMjAyMCBhdCA1OjE5IEFNIENocmlzdGlhbiBLw7ZuaWcKPGNrb2VuaWcu
bGVpY2h0enVtZXJrZW5AZ21haWwuY29tPiB3cm90ZToKPgo+IEFtIDA3LjAxLjIwIHVtIDIyOjEz
IHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+ID4gSXQgc2hvdWxkIHdvcmsgb24gYWxsIFJhdmVuIHZh
cmlhbnRzLCBidXQgc29tZSB1c2VycyBoYXZlCj4gPiByZXBvcnRlZCBpc3N1ZXMgd2l0aCBvcmln
aW5hbCBSYXZlbiB3aXRoIElPTU1VIGVuYWJsZWQuCj4gPiBTbyBmYXIgdGhlcmUgaGF2ZSBiZWVu
IG5vIGlzc3VlcyBvYnNlcnZlZCB3aXRoIFBDTyBvciBSVjIuCj4gPgo+ID4gU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgo+ID4gLS0tCj4gPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgICB8IDIyICsrKysr
KysrKysrKysrLS0tLS0KPiA+ICAgLi4uL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbS5jIHwgMTggKysrKysrKysrKy0tLS0tCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjgg
aW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZGlzcGxheS5jCj4gPiBpbmRleCA0ZTY5OTA3MWQxNDQuLjZkNTIw
YTNlZWM0MCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9kaXNwbGF5LmMKPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
aXNwbGF5LmMKPiA+IEBAIC01MTMsMTMgKzUxMywyMyBAQCB1aW50MzJfdCBhbWRncHVfZGlzcGxh
eV9zdXBwb3J0ZWRfZG9tYWlucyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiA+ICAgICAg
ICAqIHdpbGwgbm90IGFsbG93IFVTV0MgbWFwcGluZ3MuCj4gPiAgICAgICAgKiBBbHNvLCBkb24n
dCBhbGxvdyBHVFQgZG9tYWluIGlmIHRoZSBCTyBkb2Vucyd0IGhhdmUgVVNXQyBmYWxnIHNldC4K
PiA+ICAgICAgICAqLwo+ID4gLSAgICAgaWYgKGFkZXYtPmFzaWNfdHlwZSA+PSBDSElQX0NBUlJJ
Wk8gJiYKPiA+IC0gICAgICAgICBhZGV2LT5hc2ljX3R5cGUgPCBDSElQX1JBVkVOICYmCj4gPiAt
ICAgICAgICAgKGFkZXYtPmZsYWdzICYgQU1EX0lTX0FQVSkgJiYKPiA+IC0gICAgICAgICAoYm9f
ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9DUFVfR1RUX1VTV0MpICYmCj4gPiArICAgICBpZiAo
KGJvX2ZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dDKSAmJgo+ID4gICAgICAg
ICAgIGFtZGdwdV9ib19zdXBwb3J0X3Vzd2MoYm9fZmxhZ3MpICYmCj4gPiAtICAgICAgICAgYW1k
Z3B1X2RldmljZV9hc2ljX2hhc19kY19zdXBwb3J0KGFkZXYtPmFzaWNfdHlwZSkpCj4gPiAtICAg
ICAgICAgICAgIGRvbWFpbiB8PSBBTURHUFVfR0VNX0RPTUFJTl9HVFQ7Cj4gPiArICAgICAgICAg
YW1kZ3B1X2RldmljZV9hc2ljX2hhc19kY19zdXBwb3J0KGFkZXYtPmFzaWNfdHlwZSkpIHsKPiA+
ICsgICAgICAgICAgICAgc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPiA+ICsgICAgICAgICAg
ICAgY2FzZSBDSElQX0NBUlJJWk86Cj4gPiArICAgICAgICAgICAgIGNhc2UgQ0hJUF9TVE9ORVk6
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgZG9tYWluIHw9IEFNREdQVV9HRU1fRE9NQUlOX0dU
VDsKPiA+ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ICsgICAgICAgICAgICAgY2Fz
ZSBDSElQX1JBVkVOOgo+ID4gKyAgICAgICAgICAgICAgICAgICAgIC8qIGVuYWJsZSBTL0cgb24g
UENPIGFuZCBSVjIgKi8KPiA+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoYWRldi0+cmV2X2lk
ID49IDB4OCB8fCBhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHgxNWQ4KQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZG9tYWluIHw9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsKPiA+ICsg
ICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ICsgICAgICAgICAgICAgZGVmYXVsdDoKPiA+
ICsgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ICsgICAgICAgICAgICAgfQo+ID4gKyAg
ICAgfQo+ID4gICAjZW5kaWYKPiA+Cj4gPiAgICAgICByZXR1cm4gZG9tYWluOwo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCj4gPiBp
bmRleCBiOTk4YjAzODI0NzcuLjA1MTE4Yzg4NjBmOSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKPiA+IEBAIC05MDYs
MTMgKzkwNiwxOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9kbV9pbml0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQo+ID4KPiA+ICAgICAgIGluaXRfZGF0YS5kY2VfZW52aXJvbm1lbnQgPSBEQ0Vf
RU5WX1BST0RVQ1RJT05fRFJWOwo+ID4KPiA+IC0gICAgIC8qCj4gPiAtICAgICAgKiBUT0RPIGRl
YnVnIHdoeSB0aGlzIGRvZXNuJ3Qgd29yayBvbiBSYXZlbgo+ID4gLSAgICAgICovCj4gPiAtICAg
ICBpZiAoYWRldi0+ZmxhZ3MgJiBBTURfSVNfQVBVICYmCj4gPiAtICAgICAgICAgYWRldi0+YXNp
Y190eXBlID49IENISVBfQ0FSUklaTyAmJgo+ID4gLSAgICAgICAgIGFkZXYtPmFzaWNfdHlwZSA8
IENISVBfUkFWRU4pCj4gPiArICAgICBzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgewo+ID4gKyAg
ICAgY2FzZSBDSElQX0NBUlJJWk86Cj4gPiArICAgICBjYXNlIENISVBfU1RPTkVZOgo+ID4gICAg
ICAgICAgICAgICBpbml0X2RhdGEuZmxhZ3MuZ3B1X3ZtX3N1cHBvcnQgPSB0cnVlOwo+ID4gKyAg
ICAgICAgICAgICBicmVhazsKPiA+ICsgICAgIGNhc2UgQ0hJUF9SQVZFTjoKPiA+ICsgICAgICAg
ICAgICAgLyogZW5hYmxlIFMvRyBvbiBQQ08gYW5kIFJWMiAqLwo+ID4gKyAgICAgICAgICAgICBp
ZiAoYWRldi0+cmV2X2lkID49IDB4OCB8fCBhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHgxNWQ4KQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgIGluaXRfZGF0YS5mbGFncy5ncHVfdm1fc3VwcG9ydCA9
IHRydWU7Cj4gPiArICAgICAgICAgICAgIGJyZWFrOwo+ID4gKyAgICAgZGVmYXVsdDoKPiA+ICsg
ICAgICAgICAgICAgYnJlYWs7Cj4gPiArICAgICB9Cj4KPiBJdCBtaWdodCBiZSBhIGdvb2QgaWRl
YSB0byBlbmFibGUgZ3B1X3ZtX3N1cHBvcnQgaW5kZXBlbmRlbnQgYW55d2F5Lgo+Cj4gTWlnaHQg
YmUgZXZlbiBhIGdvb2QgaWRlYSB0byBkbyB0aGlzIGluIGEgc2VwYXJhdGUgcGF0Y2guCj4KPiBC
dXQgZWl0aGVyIHdheSBJJ20gbm90IGFuIGV4cGVydCBvbiBob3cgdGhlIGhhcmR3YXJlIHdvcmtz
IGluIHRoaXMgYXJlYSwKPiBzbyBBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPiBmb3IgdGhpcyBzZXJpZXMKPiBlaXRoZXIgd2F5Lgo+CgpZZWFoLCB3
ZSBjYW4gcHJvYmFibHkganVzdCBhbHdheXMgc2V0IHRoZSAuZ3B1X3ZtX3N1cHBvcnQgZmxhZyBp
ZiB0aGUKYXNpYyBzdXBwb3J0cyBpdC4gIEl0IHdvbid0IGdldCBlbmFibGVkIHVubGVzcyB3ZSBh
ZGQgR1RUIGFzIGEgdmFsaWQKZG9tYWluLgoKQWxleAoKCj4gUmVnYXJkcywKPiBDaHJpc3RpYW4u
Cj4KPiA+Cj4gPiAgICAgICBpZiAoYW1kZ3B1X2RjX2ZlYXR1cmVfbWFzayAmIERDX0ZCQ19NQVNL
KQo+ID4gICAgICAgICAgICAgICBpbml0X2RhdGEuZmxhZ3MuZmJjX3N1cHBvcnQgPSB0cnVlOwo+
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
