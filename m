Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88CBC432C0
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 15:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A477220674
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 15:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A477220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 650006F389;
	Thu, 21 Nov 2019 15:24:44 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E266F389
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 15:24:42 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id s5so4934388wrw.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2019 07:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iG6D7ZLoreYMrLYMLJhoeab23QiSqJz/mL8ZByFK/fs=;
 b=Gb3Y1U5cPQlYBA5A6Gv0FoX9MlWi/PIU14eqFYoZGNqCR/fIphjqrPd7oq16iwIu8a
 F0cLbyj4TyoLOHF956hTOxGB4MroU3n5EHvaCn4T7sYXQO2GlsmX6STMX/QFD4iCQv6H
 Nn8jE5eZJz2c8EI1kfENPozytJlYbbT2m0gFA79gLj98mF9938TMIiG1BW0EW6npeQsy
 yKh44/Aty5q3YiVDb+E7CUJkLI3RpMMf4dcFQYCugLThGJ0iwYIBZticQ7C0FPl/PUfr
 XpuSkW+L0DaqdwEzH/1E8v6nLytSRFDKzB8cDY7umTtH9BiYQHPnOSjaXRjcjxcEgyrm
 Ytkw==
X-Gm-Message-State: APjAAAWnCzlbwF3WUZQGTf97SC/OVbc//aRqihrgUsVG/TKZiOxP3GtT
 BTpSnHmLH3yeslY9f+IwE162rmpGyPXYZXq3ulk=
X-Google-Smtp-Source: APXvYqyW7K3jHkbDT//BqS4UHp8oaTxvQo+lvNOJM79U3lNM3Uf1GvZ2iCYMCG8B6bU11wmuzqvryMBrF9HiDkgRP8E=
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr11342206wrx.154.1574349881049; 
 Thu, 21 Nov 2019 07:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20191121061655.25904-1-Jack.Zhang1@amd.com>
In-Reply-To: <20191121061655.25904-1-Jack.Zhang1@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Nov 2019 10:24:29 -0500
Message-ID:
 <CADnq5_Ob8nV2RWjY_pJ_8T84F+d8SN+kbo=Cpo_V4sTnpoThkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/amdgpu/sriov temporarily skip ras, dtm, hdcp
 for arcturus VF
To: Jack Zhang <Jack.Zhang1@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=iG6D7ZLoreYMrLYMLJhoeab23QiSqJz/mL8ZByFK/fs=;
 b=G92IDPwaaVOzfsjW+9Udy9F4UD+TTy+pQWt2+w+MQPpL1evPSjK5yp6hcNbLV3SuaV
 r97I4o7Xr6/Ik5RnFfNCZQBZWQfMSexquPs4uxcg7T11MCOY3uFF/l7z2aDwOcR7Q/Rk
 g/ynmB86ofwJWjsQjMKiJ/VeqItd7ggnokW0uQMc39XoXvaK+VdSqM5GIS0xJVqUny22
 rjJ/CTwvNlkoJZmZWsM2z9a1k9/L6RPXvr5TnCER1EgJa+EGXsS6nJVrAQN03ZkFqoiA
 zX7lLO17eBtPPcW84se+CUoXfV3NCyVMOQ7QR42wmfyrnbk7AUnL/Kc3F7fQCvxJiFor
 /FzA==
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
Message-ID: <20191121152429.FltufkwUlD5BMtGMsRsABe2V2rYJtNfP37_Ay4UqguY@z>

T24gVGh1LCBOb3YgMjEsIDIwMTkgYXQgMToxNyBBTSBKYWNrIFpoYW5nIDxKYWNrLlpoYW5nMUBh
bWQuY29tPiB3cm90ZToKPgo+IFRlbXBvcmFyaWx5IHNraXAgcmFzLGR0bSxoZGNwIGluaXRpYWxp
emUgYW5kIHRlcm1pbmF0ZSBmb3IgYXJjdHVydXMgVkYKPiBDdXJyZW50bHkgdGhlIHRocmVlIGZl
YXR1cmVzIGhhdmVuJ3QgYmVlbiBlbmFibGVkIGF0IFNSSU9WLCBpdCB3b3VsZAo+IHRyaWdnZXIg
Z3Vlc3QgZHJpdmVyIGxvYWQgZmFpbCB3aXRoIHRoZSBiYXJlLW1ldGFsIHBhdGggb2YgdGhlIHRo
cmVlCj4gZmVhdHVyZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKYWNrIFpoYW5nIDxKYWNrLlpoYW5n
MUBhbWQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcHNw
LmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5n
ZWQsIDM2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfcHNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
cHNwLmMKPiBpbmRleCAyYThhMDhhLi5jM2E0MmQzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9wc3AuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9wc3AuYwo+IEBAIC03NTYsNiArNzU2LDEyIEBAIGludCBwc3BfcmFzX2Vu
YWJsZV9mZWF0dXJlcyhzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCwKPgo+ICBzdGF0aWMgaW50IHBz
cF9yYXNfdGVybWluYXRlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQo+ICB7Cj4gKyAgICAgICAv
Kgo+ICsgICAgICAgICogVE9ETzogYnlwYXNzIHRoZSB0ZXJtaW5hdGUgaW4gc3Jpb3YgZm9yIG5v
dwo+ICsgICAgICAgICovCj4gKyAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikp
Cj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ICsKClBsZWFzZSBtb3ZlIHRoaXMgYmVsb3cg
dGhlIHN0YWNrIHZhcmlhYmxlcy4gIFlvdSBhcmUgaW50cm9kdWNpbmcKd2FybmluZ3MgaGVyZS4g
IFNhbWUgY29tbWVudCBmb3IgYWxsIGh1bmtzIG9mIHRoaXMgcGF0Y2guCgpBbGV4Cgo+ICAgICAg
ICAgaW50IHJldDsKPgo+ICAgICAgICAgaWYgKCFwc3AtPnJhcy5yYXNfaW5pdGlhbGl6ZWQpCj4g
QEAgLTc3Nyw2ICs3ODMsMTIgQEAgc3RhdGljIGludCBwc3BfcmFzX3Rlcm1pbmF0ZShzdHJ1Y3Qg
cHNwX2NvbnRleHQgKnBzcCkKPgo+ICBzdGF0aWMgaW50IHBzcF9yYXNfaW5pdGlhbGl6ZShzdHJ1
Y3QgcHNwX2NvbnRleHQgKnBzcCkKPiAgewo+ICsgICAgICAgLyoKPiArICAgICAgICAqIFRPRE86
IGJ5cGFzcyB0aGUgaW5pdGlhbGl6ZSBpbiBzcmlvdiBmb3Igbm93Cj4gKyAgICAgICAgKi8KPiAr
ICAgICAgIGlmIChhbWRncHVfc3Jpb3ZfdmYocHNwLT5hZGV2KSkKPiArICAgICAgICAgICAgICAg
cmV0dXJuIDA7Cj4gKwo+ICAgICAgICAgaW50IHJldDsKPgo+ICAgICAgICAgaWYgKCFwc3AtPmFk
ZXYtPnBzcC50YV9yYXNfdWNvZGVfc2l6ZSB8fAo+IEBAIC04NzIsNiArODg0LDEyIEBAIHN0YXRp
YyBpbnQgcHNwX2hkY3BfbG9hZChzdHJ1Y3QgcHNwX2NvbnRleHQgKnBzcCkKPiAgfQo+ICBzdGF0
aWMgaW50IHBzcF9oZGNwX2luaXRpYWxpemUoc3RydWN0IHBzcF9jb250ZXh0ICpwc3ApCj4gIHsK
PiArICAgICAgIC8qCj4gKyAgICAgICAgKiBUT0RPOiBieXBhc3MgdGhlIGluaXRpYWxpemUgaW4g
c3Jpb3YgZm9yIG5vdwo+ICsgICAgICAgICovCj4gKyAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3Zm
KHBzcC0+YWRldikpCj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ICsKPiAgICAgICAgIGlu
dCByZXQ7Cj4KPiAgICAgICAgIGlmICghcHNwLT5hZGV2LT5wc3AudGFfaGRjcF91Y29kZV9zaXpl
IHx8Cj4gQEAgLTk2MCw2ICs5NzgsMTIgQEAgaW50IHBzcF9oZGNwX2ludm9rZShzdHJ1Y3QgcHNw
X2NvbnRleHQgKnBzcCwgdWludDMyX3QgdGFfY21kX2lkKQo+Cj4gIHN0YXRpYyBpbnQgcHNwX2hk
Y3BfdGVybWluYXRlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQo+ICB7Cj4gKyAgICAgICAvKgo+
ICsgICAgICAgICogVE9ETzogYnlwYXNzIHRoZSB0ZXJtaW5hdGUgaW4gc3Jpb3YgZm9yIG5vdwo+
ICsgICAgICAgICovCj4gKyAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKHBzcC0+YWRldikpCj4g
KyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ICsKPiAgICAgICAgIGludCByZXQ7Cj4KPiAgICAg
ICAgIGlmICghcHNwLT5oZGNwX2NvbnRleHQuaGRjcF9pbml0aWFsaXplZCkKPiBAQCAtMTA1MSw2
ICsxMDc1LDEyIEBAIHN0YXRpYyBpbnQgcHNwX2R0bV9sb2FkKHN0cnVjdCBwc3BfY29udGV4dCAq
cHNwKQo+Cj4gIHN0YXRpYyBpbnQgcHNwX2R0bV9pbml0aWFsaXplKHN0cnVjdCBwc3BfY29udGV4
dCAqcHNwKQo+ICB7Cj4gKyAgICAgICAvKgo+ICsgICAgICAgICogVE9ETzogYnlwYXNzIHRoZSBp
bml0aWFsaXplIGluIHNyaW92IGZvciBub3cKPiArICAgICAgICAqLwo+ICsgICAgICAgaWYgKGFt
ZGdwdV9zcmlvdl92Zihwc3AtPmFkZXYpKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPiAr
Cj4gICAgICAgICBpbnQgcmV0Owo+Cj4gICAgICAgICBpZiAoIXBzcC0+YWRldi0+cHNwLnRhX2R0
bV91Y29kZV9zaXplIHx8Cj4gQEAgLTExMDksNiArMTEzOSwxMiBAQCBpbnQgcHNwX2R0bV9pbnZv
a2Uoc3RydWN0IHBzcF9jb250ZXh0ICpwc3AsIHVpbnQzMl90IHRhX2NtZF9pZCkKPgo+ICBzdGF0
aWMgaW50IHBzcF9kdG1fdGVybWluYXRlKHN0cnVjdCBwc3BfY29udGV4dCAqcHNwKQo+ICB7Cj4g
KyAgICAgICAvKgo+ICsgICAgICAgICogVE9ETzogYnlwYXNzIHRoZSB0ZXJtaW5hdGUgaW4gc3Jp
b3YgZm9yIG5vdwo+ICsgICAgICAgICovCj4gKyAgICAgICBpZiAoYW1kZ3B1X3NyaW92X3ZmKHBz
cC0+YWRldikpCj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ICsKPiAgICAgICAgIGludCBy
ZXQ7Cj4KPiAgICAgICAgIGlmICghcHNwLT5kdG1fY29udGV4dC5kdG1faW5pdGlhbGl6ZWQpCj4g
LS0KPiAyLjcuNAo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
