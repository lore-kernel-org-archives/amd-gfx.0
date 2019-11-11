Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBA0C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29788214DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 17:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29788214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D0589DF9;
	Mon, 11 Nov 2019 17:33:44 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007AC89DF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 17:33:43 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id b17so144155wmj.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 09:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yJI32BfYLajhgoz7rwfO5JHnRxblijMT7csnv73RZzg=;
 b=jgTPnVL6v+Gi+xfACUIQrRMoRwBS+P5LrummvP+z0cCgNzfoJSTkodljg2w45QHTxb
 WkpSCkdG2l/wxt+cIVYbmelXcJEGtdSeH6gV1dqPGpJxPg6IztCLL6C1MDc/5Wox3ofe
 dyeaINiqBj2TH8BvZeHdG6CXWRaQJgz8+ect7qUVlUbAkytdmHD7xLCJaKWu1m8yeLvL
 BSj7NFjsXt24gQ7mD4kGYTc47wddREUplI+pTvPRGy5hAGvx6ENMHnqkNPZx8jicT3Cx
 RZeHBRfC+3z/I1YDsD6ZLUMZDpK9k0j9wDrnokrF95+DCSfd6dVa1aMjQaHMig1gZlqr
 xR2Q==
X-Gm-Message-State: APjAAAV8IVYbLSDtDOqxwuS3hWie0wy/fuq9D7b/Q3IaLtNu6DnD52BV
 Ufgof9LsHkFgSfvcMgVYhj/KNkFgq9cNzuvSesVFwU1S
X-Google-Smtp-Source: APXvYqywKAQqOKdATJwkJj1DJZzpawYVb5WbLjN6S1Me/AbNTyr6mUUZmJ+W28wD+OANI0FSi/UafOTeLnTL6W9YQv0=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr90960wme.127.1573493622532;
 Mon, 11 Nov 2019 09:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20191111092506.18913-1-evan.quan@amd.com>
In-Reply-To: <20191111092506.18913-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 Nov 2019 12:33:31 -0500
Message-ID:
 <CADnq5_OhXnzYx6EgMM87dh1jgUi6Br86Axwi_KfvLjXuO2+gxw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: avoid DPM reenable process on Navi1x
 ASICs
To: Evan Quan <evan.quan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=yJI32BfYLajhgoz7rwfO5JHnRxblijMT7csnv73RZzg=;
 b=nCjdgLmoMcbpJzKS3QkkWSUO8zGhFunFRBRJKyWSvqRXBGrHrHKfUkiAc33xTE5ieR
 XZEHl5NiLs9BMjj++0M0r3O9wdSsT88YUOgkQGRSs22eUuJNxgo6cWY+4pmyCBrKxqmm
 bSYldne4cON2zAZF3pZmVd6IYSa6Q7lVOTzS/vIZD2Uy3x9o6bM9zBvcwVDNIw9626Vr
 aa9/q3D9wQhyhtmUa4myWv1pxplDzPC93AkpL//ElTnQQ7cerUfG+6qBvd8RON+0ge3q
 A6LexnDwUJJgWIIyUMYtpDJYOc0KuF1dx6F/qOTgVgFK2TiBcNESkzPuchtnc9H09D+f
 XTzQ==
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111173331.ScXxlKnBiE0-jZhjrts-Mr999BW5Nlo9W5kmpQFWPIE@z>

T24gTW9uLCBOb3YgMTEsIDIwMTkgYXQgNDoyNSBBTSBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQu
Y29tPiB3cm90ZToKPgo+IE90aGVyd2lzZSwgd2l0aG91dCBSTEMgcmVpbml0aWFsaXphdGlvbiwg
dGhlIERQTSByZWVuYWJsZW1lbnQKPiB3aWxsIGZhaWwuIFRoYXQgYWZmZWN0cyB0aGUgY3VzdG9t
IHBwdGFibGUgdXBsb2FkaW5nLgo+Cj4gQ2hhbmdlLUlkOiBJNmZlMmVkNWNlMjNmMmE1YjY2ZjM3
MWMwYjZkMWY5MjQ4MzdlNWFmNgo+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFu
QGFtZC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9z
bXUuYyAgICB8IDMyICsrKysrKysrKysrKysrKy0tLS0KPiAgLi4uL2dwdS9kcm0vYW1kL3Bvd2Vy
cGxheS9pbmMvYW1kZ3B1X3NtdS5oICAgIHwgIDEgKwo+ICAyIGZpbGVzIGNoYW5nZWQsIDI2IGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dl
cnBsYXkvYW1kZ3B1X3NtdS5jCj4gaW5kZXggNzZhNDE1NGIzYmUyLi5hNGQ2N2IzMGZkNzIgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jCj4gQEAgLTEy
OTMsMTAgKzEyOTMsMjUgQEAgc3RhdGljIGludCBzbXVfaHdfZmluaSh2b2lkICpoYW5kbGUpCj4g
ICAgICAgICAgICAgICAgIHJldHVybiByZXQ7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIHJldCA9
IHNtdV9zdG9wX2RwbXMoc211KTsKPiAtICAgICAgIGlmIChyZXQpIHsKPiAtICAgICAgICAgICAg
ICAgcHJfd2FybigiRmFpbCB0byBzdG9wIERwbXMhXG4iKTsKPiAtICAgICAgICAgICAgICAgcmV0
dXJuIHJldDsKPiArICAgICAgIC8qCj4gKyAgICAgICAgKiBGb3IgY3VzdG9tIHBwdGFibGUgdXBs
b2FkaW5nLCBza2lwIHRoZSBEUE0gZmVhdHVyZXMKPiArICAgICAgICAqIGRpc2FibGUgcHJvY2Vz
cyBvbiBOYXZpMXggQVNJQ3MuCj4gKyAgICAgICAgKiAgIC0gQXMgdGhlIGdmeCByZWxhdGVkIGZl
YXR1cmVzIGFyZSB1bmRlciBjb250cm9sIG9mCj4gKyAgICAgICAgKiAgICAgUkxDIG9uIHRob3Nl
IEFTSUNzLiBSTEMgcmVpbml0aWFsaXphdGlvbiB3aWxsIGJlCj4gKyAgICAgICAgKiAgICAgbmVl
ZGVkIHRvIHJlZW5hYmxlIHRoZW0uIFRoYXQgd2lsbCBjb3N0IG11Y2ggbW9yZQo+ICsgICAgICAg
ICogICAgIGVmZm9ydHMuCj4gKyAgICAgICAgKgo+ICsgICAgICAgICogICAtIFNNVSBmaXJtd2Fy
ZSBjYW4gaGFuZGxlIHRoZSBEUE0gcmVlbmFibGVtZW50Cj4gKyAgICAgICAgKiAgICAgcHJvcGVy
bHkuCj4gKyAgICAgICAgKi8KPiArICAgICAgIGlmICghc211LT51cGxvYWRpbmdfY3VzdG9tX3Bw
X3RhYmxlIHx8Cj4gKyAgICAgICAgICAgISgoYWRldi0+YXNpY190eXBlID49IENISVBfTkFWSTEw
KSAmJgo+ICsgICAgICAgICAgICAgKGFkZXYtPmFzaWNfdHlwZSA8PSBDSElQX05BVkkxMikpKSB7
Cj4gKyAgICAgICAgICAgICAgIHJldCA9IHNtdV9zdG9wX2RwbXMoc211KTsKPiArICAgICAgICAg
ICAgICAgaWYgKHJldCkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIHByX3dhcm4oIkZhaWwg
dG8gc3RvcCBEcG1zIVxuIik7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsK
PiArICAgICAgICAgICAgICAgfQo+ICAgICAgICAgfQo+Cj4gICAgICAgICBrZnJlZSh0YWJsZV9j
b250ZXh0LT5kcml2ZXJfcHB0YWJsZSk7Cj4gQEAgLTEzMjQsMTMgKzEzMzksMTYgQEAgaW50IHNt
dV9yZXNldChzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKPiAgICAgICAgIHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2ID0gc211LT5hZGV2Owo+ICAgICAgICAgaW50IHJldCA9IDA7Cj4KPiArICAg
ICAgIHNtdS0+dXBsb2FkaW5nX2N1c3RvbV9wcF90YWJsZSA9IHRydWU7Cj4gKwoKRG8gd2UgbmVl
ZCB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gcmVsb2FkaW5nIGZvciBhIHBwdGFibGUgdXBkYXRl
IGFuZApyZWxvYWRpbmcgZm9yIGEgZ3B1IHJlc2V0IG9yIHN1c3BlbmQvcmVzdW1lIG9yIGlzIHRo
YXQgYWxyZWFkeQpoYW5kbGVkPwpTaG91bGRuJ3Qgd2UgYmUgc2V0dGluZy9jbGVhcmluZyB1cGxv
YWRpbmdfY3VzdG9tX3BwX3RhYmxlIGluCnNtdV9zeXNfc2V0X3BwX3RhYmxlKCkgYXJvdW5kIHRo
ZSBjYWxsIHRvIHNtdV9yZXNldCgpPwoKQWxleAoKPiAgICAgICAgIHJldCA9IHNtdV9od19maW5p
KGFkZXYpOwo+ICAgICAgICAgaWYgKHJldCkKPiAtICAgICAgICAgICAgICAgcmV0dXJuIHJldDsK
PiArICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4KPiAgICAgICAgIHJldCA9IHNtdV9od19pbml0
KGFkZXYpOwo+IC0gICAgICAgaWYgKHJldCkKPiAtICAgICAgICAgICAgICAgcmV0dXJuIHJldDsK
PiArCj4gK291dDoKPiArICAgICAgIHNtdS0+dXBsb2FkaW5nX2N1c3RvbV9wcF90YWJsZSA9IGZh
bHNlOwo+Cj4gICAgICAgICByZXR1cm4gcmV0Owo+ICB9Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9hbWRncHVfc211LmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oCj4gaW5kZXggODEyMGU3NTg3NTg1Li4yMTU4
NDFmNWZiOTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5j
L2FtZGdwdV9zbXUuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2luYy9h
bWRncHVfc211LmgKPiBAQCAtMzkxLDYgKzM5MSw3IEBAIHN0cnVjdCBzbXVfY29udGV4dAo+Cj4g
ICAgICAgICB1aW50MzJfdCBzbWNfaWZfdmVyc2lvbjsKPgo+ICsgICAgICAgYm9vbCB1cGxvYWRp
bmdfY3VzdG9tX3BwX3RhYmxlOwo+ICB9Owo+Cj4gIHN0cnVjdCBpMmNfYWRhcHRlcjsKPiAtLQo+
IDIuMjQuMAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
