Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4FFC47082
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 19:55:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413E9613AC
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 19:55:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413E9613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E52096E58B;
	Tue,  8 Jun 2021 19:55:54 +0000 (UTC)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263256E58B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 19:50:46 +0000 (UTC)
Received: by mail-yb1-xb32.google.com with SMTP id i6so17297659ybm.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Jun 2021 12:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OaTLhSlDhb57+/+oKGnFfQyPfH2SxIe/HKR+aG2ZvZc=;
 b=PpF3Y7FvXSxWYXhLIKgSEYi6nZNzQTGaqrRuPlzTDxMp/wttQJaK95/ZdGJB9MnDKG
 BaVIdmPXk2eeGQ5fE7wAz+A9obRWLD84zZshP9TuNE/qwt+n/1T6tmLcnJLpxSjvlhRm
 9XgBZPWqT8lFJFP81jf9RjEsnR3/2dqJ3CO7d6s7f55E3sIqA6tmmWe3TuBCDSr/mmld
 N0R2t7hlK4oT68AHQBudn8bkjq+QVt8+Ihl0ROOgUhcabiT2fYC1cYiKVcaIYHp/3/Ny
 nh6xpoFYKYz+XQtWZohCK+a1bWtLumdm4VEpSpQ4VY9EGDfxNGRIWw//w5JNNI9Dmk2u
 Ge6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OaTLhSlDhb57+/+oKGnFfQyPfH2SxIe/HKR+aG2ZvZc=;
 b=QNKbVcTl4rESzyXaL5zDWhSmGtzg8sJ7upL6REXaRFD4/Mjklwvn25Las+eZBN0Xz6
 wsGFvcwkN5WFSkMbuUudQs5wW3r4N81zIpUlx26GGsDp/t3OnE/dpUWo9R95eSD2Y7R4
 GIF+QLwGxVS8ABgBAEneeNTESEcOsnu1xBjnTV3f9HuuSz2cpdMbagtd6HD9bcoXPchI
 efaE18Nzh25fDK4rUSNYbH8w1jaZWuJu9ZRQx/wQfHKeuwp06k3KhxkA4i9Lyt8rGA/O
 KQPybuWUPGQwnq//YmHvB7mTUkViQ/JuVJGwEen1e3hjeRG2Sj/Lq/YG42a63ZxOyxWs
 Mblw==
X-Gm-Message-State: AOAM531sEjtaxgPPh6qZCLFfj1A/K+mBlxTZvA5xwzPw1g5XtRyr6QtR
 h+prc2jThSUXkSadvHUuTizbPvSjm8IPYZabXXGboQ==
X-Google-Smtp-Source: ABdhPJxO5NmsaaGNUbCnwAhSSlnJ4naTQUbzmN+QEDYMbOmn/cP9rECH1h6/oPYJJFxtGRQO/R2AVK0C5Jl6TuQNP3g=
X-Received: by 2002:a25:aa48:: with SMTP id s66mr32750572ybi.341.1623181844896; 
 Tue, 08 Jun 2021 12:50:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210514114734.687096-1-Rodrigo.Siqueira@amd.com>
 <857025a9-2ac0-ed37-bc9e-a2be9e1780a9@amd.com>
 <CAC0gqY77ztqBfi3g_JYPVEqmahXVJ+bGePMK40WaPmgm4m6gVw@mail.gmail.com>
 <CAJUqKUrM6jrUrZkcfF=R7vNeoj4KvwymwM4tMVy09ndsPci-9Q@mail.gmail.com>
 <20210518185806.gsrzfcxcwo6o47kc@outlook.office365.com>
 <CAOw6vbLBTW03h1-amysV0rAn3YiT6z0C6jds5vPMz1rAEcDGow@mail.gmail.com>
 <517b3280-f7aa-eab3-472e-5e23ad5dc243@amd.com>
 <CAOw6vb+SAOsp-2Da6UMf+Xgx7V=P3MDjFqm1tjRyV6bZk_HPyg@mail.gmail.com>
 <3dfd5d78-f36f-388f-0995-fa9f421bdf0a@daenzer.net>
 <3f0316a1-6374-38ad-2010-8e71274d5e01@amd.com>
In-Reply-To: <3f0316a1-6374-38ad-2010-8e71274d5e01@amd.com>
From: Sean Paul <seanpaul@google.com>
Date: Tue, 8 Jun 2021 15:50:07 -0400
Message-ID: <CAOw6vbKErAoSKTCGKBELLR7ia+=H=_s2mMomatyporspds8cUQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix overlay validation by considering
 cursors
To: Harry Wentland <harry.wentland@amd.com>
X-Mailman-Approved-At: Tue, 08 Jun 2021 19:55:53 +0000
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
Cc: Mark Yacoub <markyacoub@chromium.org>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 "Tianci . Yin" <tianci.yin@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Nicholas Choi <nicholas.choi@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 Mark Yacoub <markyacoub@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVHVlLCBKdW4gOCwgMjAyMSBhdCAzOjA3IFBNIEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50
bGFuZEBhbWQuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiAyMDIxLTA2LTA4IDM6NDcgYS5tLiwgTWlj
aGVsIETDpG56ZXIgd3JvdGU6Cj4gPiBPbiAyMDIxLTA2LTA3IDg6NDUgcC5tLiwgU2VhbiBQYXVs
IHdyb3RlOgo+ID4+Cj4gPj4KPiA+PiBPbiBNb24sIEp1biA3LCAyMDIxIGF0IDI6MzcgUE0gSGFy
cnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20gPG1haWx0bzpoYXJyeS53ZW50bGFu
ZEBhbWQuY29tPj4gd3JvdGU6Cj4gPj4KPiA+PiAgICAgT24gMjAyMS0wNi0wNyAyOjE5IHAubS4s
IFNlYW4gUGF1bCB3cm90ZToKPiA+PiAgICAgPiBPbiBUdWUsIE1heSAxOCwgMjAyMSBhdCAyOjU4
IFBNIFJvZHJpZ28gU2lxdWVpcmEKPiA+PiAgICAgPiA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29t
IDxtYWlsdG86Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPj4gd3JvdGU6Cj4gPj4gICAgID4+Cj4K
PiA8c25pcD4KPgo+ID4+ICAgICA+PiBIaSBNYXJrIGFuZCBTZWFuLAo+ID4+ICAgICA+Pgo+ID4+
ICAgICA+PiBJIGRvbid0IGtub3cgaWYgSSBmdWxseSBjb21wcmVoZW5kZWQgdGhlIHNjZW5hcmlv
IHdoaWNoIGluIG15IHBhdGNoCj4gPj4gICAgID4+IG1pZ2h0IGNhdXNlIGEgQ2hyb21lT1MgY3Jh
c2gsIGJ1dCB0aGlzIGlzIHdoYXQgSSB1bmRlcnN0b29kOgo+ID4+ICAgICA+Pgo+ID4+ICAgICA+
Cj4gPj4gICAgID4gQ2hyb21lIGNvbXBvc2l0b3Igb25seSBkb2VzIGFuIGF0b21pYyB0ZXN0IHdo
ZW4gdGhlIGxheW91dCBnZW9tZXRyeQo+ID4+ICAgICA+IGNoYW5nZXMgKGllOiBwbGFuZSBpcyBh
ZGRlZC9yZW1vdmVkL3Jlc2l6ZWQvbW92ZWQpLiBUaGlzIGRvZXMgbm90IHRha2UKPiA+PiAgICAg
PiBpbnRvIGNvbnNpZGVyYXRpb24gdGhlIGN1cnNvci4gT25jZSB0aGUgYXRvbWljIHRlc3QgaGFz
IGJlZW4gdmFsaWRhdGVkCj4gPj4gICAgID4gZm9yIGEgZ2l2ZW4gbGF5b3V0IGdlb21ldHJ5IChz
ZXQgb2YgcGxhbmVzL2ZicyBhbG9uZyB3aXRoIHRoZWlyIHNpemVzCj4gPj4gICAgID4gYW5kIGxv
Y2F0aW9ucyksIENocm9tZSBhc3N1bWVzIHRoaXMgd2lsbCBjb250aW51ZSB0byBiZSB2YWxpZC4K
PiA+PiAgICAgPgo+ID4+ICAgICA+IFNvIHRoZSBzaXR1YXRpb24gSSdtIGVudmlzaW9uaW5nIGlz
IGlmIHRoZSBjdXJzb3IgaXMgaGlkZGVuLCBhbgo+ID4+ICAgICA+IG92ZXJsYXktYmFzZWQgc3Ry
YXRlZ3kgd2lsbCBwYXNzIGluIHRoZSBrZXJuZWwuIElmIGF0IGFueSB0aW1lIHRoZQo+ID4+ICAg
ICA+IGN1cnNvciBiZWNvbWVzIHZpc2libGUsIHRoZSBrZXJuZWwgd2lsbCBzdGFydCBmYWlsaW5n
IGNvbW1pdHMgd2hpY2gKPiA+PiAgICAgPiBjYXVzZXMgQ2hyb21lJ3MgR1BVIHByb2Nlc3MgdG8g
Y3Jhc2guCj4gPj4gICAgID4KPiA+PiAgICAgPiBJbiBnZW5lcmFsIEknbSB1bmVhc3kgd2l0aCB1
c2luZyB0aGUgY3Vyc29yIGluIHRoZSBhdG9taWMgY2hlY2sgc2luY2UKPiA+PiAgICAgPiBpdCBm
ZWVscyBsaWtlIGl0IGNvdWxkIGJlIHJhY3kgaW5kZXBlbmRlbnQgb2YgdGhlIGlzc3VlIGFib3Zl
LiBJCj4gPj4gICAgID4gaGF2ZW4ndCBkb3ZlIGludG8gdGhlIGhlbHBlciBjb2RlIGVub3VnaCB0
byBwcm92ZSBpdCwganVzdCBhCj4gPj4gICAgID4gc3BpZGV5LXNlbnNlLgo+ID4+ICAgICA+Cj4g
Pj4KPiA+PiAgICAgSXNuJ3QgdGhlIGN1cnNvciBzdXBwb3NlZCB0byBiZSBqdXN0IGFub3RoZXIg
cGxhbmU/IElmIHNvLCBzaG91bGRuJ3QKPiA+PiAgICAgYWRkaW5nL3JlbW92aW5nIHRoZSBjdXJz
b3IgdHJpZ2dlciBhbiBhdG9taWMgdGVzdD8KPiA+Pgo+ID4+Cj4gPj4gQ2hyb21lIGlzIHVzaW5n
IGxlZ2FjeSBjdXJzb3IuCj4gPj4KPiA+PiBZZXMgaXQgd2lsbCB0cmlnZ2VyIGFuIGF0b21pYyB0
ZXN0IGluIHRoZSBrZXJuZWwsIGFuZCB0aGF0IGF0b21pYyB0ZXN0IHdpbGwgZmFpbC4gVW5mb3J0
dW5hdGVseSBDaHJvbWUgZG9lcyBub3QgZXhwZWN0IGEgZmFpbHVyZSBzbyBpdCB3aWxsIGNyYXNo
Lgo+ID4KPiA+IFRoZSBzb2x1dGlvbiBpcyBwcm9iYWJseSBpbmRlZWQgZm9yIGF0b21pYyBjaGVj
ayB0byByZWplY3Qgc3RhdGUgd2hpY2ggY291bGRuJ3Qgd29yayBpZiB0aGUgY3Vyc29yIHdhcyBl
bmFibGVkLCBldmVuIGlmIHRoZSBjdXJzb3IgaXMgY3VycmVudGx5IGRpc2FibGVkLiBPdGhlcndp
c2Ugb25lIGNhbiBoaXQgdmFyaW91cyBzdXJwcmlzaW5nIGVycm9ycyB2aWEgbGVnYWN5IEFQSXMs
IGFzIGRlc2NyaWJlZCBpbiBiODM2YTI3NGI3OTcgImRybS9hbWRncHUvZGM6IFJlcXVpcmUgcHJp
bWFyeSBwbGFuZSB0byBiZSBlbmFibGVkIHdoZW5ldmVyIHRoZSBDUlRDIGlzIi4KPiA+Cj4KPiBB
Z3JlZWQuCj4KPiBJdCdzIGEgYml0IHVuZm9ydHVuYXRlIGJ1dCB0aGUgb25seSB3YXkgdG8gZGVh
bCB3aXRoIHRoaXMgYmV0dGVyIGlzIGlmIHdlIGhhZCBzb21lIHdheSBmb3IgRFJNIG1hc3RlciB0
byB0ZWxsIHVzIHdoZXRoZXIgaXQgd2lsbCBvbmx5IHVzZSB0aGUgYXRvbWljIElPQ1RMIG9yIHVz
ZSBsZWdhY3kgSU9DVExzIChpbmNsdWRpbmcgYSBjb21iaW5hdGlvbiBvZiBhdG9taWMgYW5kIGxl
Z2FjeSkuCj4KCkkgdGhpbmsgZXZlbiB3aXRoIHRoaXMgaW5mb3JtYXRpb24gd2Ugd291bGRuJ3Qg
d2FudCB0byBkZXBlbmQgb24KY3Vyc29yIGZvciBhdG9taWMgdGVzdC4gSU1PIGtlcm5lbCBzaG91
bGQgbm90IGJhY2sgdGhlIGNvbXBvc2l0b3IgaW50bwpyZS1yZW5kZXJpbmcgdGhlIHNjZW5lIGJh
c2VkIG9uIGN1cnNvciB2aXNpYmlsaXR5LiBHaXZlbiB0aGF0IGN1cnNvcgppcyB1c3VhbGx5IGhh
bmRsZWQgaW5kZXBlbmRlbnRseSBhbmQgYXN5bmNocm9ub3VzbHkgZnJvbSBjb21wb3NpdGlvbiwK
aXQgbWFrZXMgdGhpbmdzIGV4dHJlbWVseSBjb21wbGV4IGFuZCBtb3N0IGNvbXBvc2l0b3JzIHdv
dWxkIHByb2JhYmx5Cmp1c3QgZW5hYmxlIGN1cnNvciBhbGwgdGhlIHRpbWUgdG8gd29yayBhcm91
bmQgdGhpcy4KClNlYW4KCgo+IEhhcnJ5Cj4KPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
