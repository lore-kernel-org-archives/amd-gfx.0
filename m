Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE39C5DF61
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 14:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1082214D8
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 14:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1082214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3CAB6E0AC;
	Thu,  7 Nov 2019 14:03:10 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB856E0AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 14:03:09 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id h3so3098429wrx.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Nov 2019 06:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wn0k6o8GeqhrJ147XOgAIxncRAkMLpgIgIwzY51CuRg=;
 b=ZH0Wu7IS+EIiCc/SMK6/ED6ptEqB7zmCnGquOXgUVBVNXQt2d+fKub+21TWHwpZWi4
 cu1VuCdz0z1ll71pTuifO9EUMNwnaeL4fOKcr+C7A/rlo+YNwGwrbJwGIr3SvSUiMrEg
 QuRLXxkIQZnGf4E/jYc4i3bfKbJpe/erjQxfVLdiNprB9e3i7Og9zcsV5e0421IAQDBc
 ztLbpQpaOcs3lHRP+hQdaMjL8nBD4Ff17NTZCcB/zwB0jPi+mUfw/MyQySoKVB4jJeYN
 jqCx72KJqe0WKJblA9zcFFcYRY3Zoe8Q+uMeFCYnjtAQRIQ2aDbbtL4UluMNRzr0h3zZ
 BX+Q==
X-Gm-Message-State: APjAAAXa08qDX2mnBjVrwX18ry0g70r8D1Ba/ME09Yh2qgiZbpOLv4dT
 JI04TENXID5fcwMSyTw9xhH9o4vRYOzr6csRTiY=
X-Google-Smtp-Source: APXvYqy7scEUkELBgaXcrTr0sTt2KC2455Pqw1Zz2LpdF375RbRnFV8jnioFDbIE2v+7wOKGXVP9vVkgoRfR1hIEn1Q=
X-Received: by 2002:adf:9d87:: with SMTP id p7mr3006518wre.11.1573135387606;
 Thu, 07 Nov 2019 06:03:07 -0800 (PST)
MIME-Version: 1.0
References: <1573061209-13148-1-git-send-email-Oak.Zeng@amd.com>
In-Reply-To: <1573061209-13148-1-git-send-email-Oak.Zeng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Nov 2019 09:02:56 -0500
Message-ID:
 <CADnq5_OinRnn+39TiX2SQkoBwwMPRO2vt0nTSLkwSBq-Mw2vBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add comments to gmc structure
To: "Zeng, Oak" <Oak.Zeng@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=wn0k6o8GeqhrJ147XOgAIxncRAkMLpgIgIwzY51CuRg=;
 b=HSgFB9u26NPNDCnDZH1CKaRZh98/Q6wnoq7IQiQwdEiwWXIqHqgpkF9l382sfaNbrU
 AxpqvYkWhifgGqKuiK+A1AJLlU6GbaQ8ehcyPH83qwX09FFFQoGn7S1Sn/L6mCdn3FAC
 RgwvF1571GFvWmjge5XMsEit5jR5u2K5gw87qVVYtPxs9JZSxsYb2/srjxRjpMopePIm
 kpbBHPBdv66SDi+/pax9bnOlwcX9/vb//Nb5TAbES+a8O22UYjD7XBnKVW2clODW4C63
 HPe2P2C8XTlaIj2cUExeJydJ0wnt9PEOzwMvqYI7b087debmqMZli6Fh28RIyxsu4Qyv
 mSTw==
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107140256.r8LT7RFwIA_ptOkgQTHlkMeeq5Bi3fu3nFa7fGYoo7s@z>

T24gV2VkLCBOb3YgNiwgMjAxOSBhdCAxMjoyNyBQTSBaZW5nLCBPYWsgPE9hay5aZW5nQGFtZC5j
b20+IHdyb3RlOgo+Cj4gRXhwbGFpbiBmaWVsZHMgbGlrZSBhcGVyX2Jhc2UsIGFncF9zdGFydCBl
dGMuIFRoZSBkZWZpbml0aW9uCj4gb2YgdGhvc2UgZmllbGRzIGFyZSBjb25mdXNpbmcgYXMgdGhl
eSBhcmUgZnJvbSBkaWZmZXJlbnQgdmlldwo+IChDUFUgb3IgR1BVKS4gQWRkIGNvbW1lbnRzIGZv
ciBlYXNpZXIgdW5kZXJzdGFuZC4KPgo+IENoYW5nZS1JZDogSTAyYzJhMjdjZDBkYmMyMDU0OThl
Yjg2YWFmYTcyMmYyZTBjMjVmZTYKPiBTaWduZWQtb2ZmLWJ5OiBPYWsgWmVuZyA8T2FrLlplbmdA
YW1kLmNvbT4KClNhbWUgY29tbWVudHMgYXMgdGhlIHByZXZpb3VzIHZlcnNpb24uICBXaXRoIHRo
b3NlIGFkZHJlc3NlZCwKUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KCj4gLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9n
bWMuaCB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCAy
NiBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dtYy5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5o
Cj4gaW5kZXggNTU1ZDhlNS4uMTM1NmZmOSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZ21jLmgKPiBAQCAtMTI3LDE4ICsxMjcsNDQgQEAgc3RydWN0IGFtZGdwdV94Z21p
IHsKPiAgfTsKPgo+ICBzdHJ1Y3QgYW1kZ3B1X2dtYyB7Cj4gKyAgICAgICAvKiBGQidzIHBoeXNp
Y2FsIGFkZHJlc3MgaW4gTU1JTyBzcGFjZSAoZm9yIENQVSB0bwo+ICsgICAgICAgICogbWFwIEZC
KS4gVGhpcyBpcyBkaWZmZXJlbnQgY29tcGFyZWQgdG8gdGhlIGFwZy8KPiArICAgICAgICAqIGdh
cnQvdnJhbV9zdGFydC9lbmQgZmllbGQgYXMgdGhlIGxhdGVyIGlzIGZyb20KPiArICAgICAgICAq
IEdQVSdzIHZpZXcgYW5kIGFwZXJfYmFzZSBpcyBmcm9tIENQVSdzIHZpZXcuCj4gKyAgICAgICAg
Ki8KPiAgICAgICAgIHJlc291cmNlX3NpemVfdCAgICAgICAgIGFwZXJfc2l6ZTsKPiAgICAgICAg
IHJlc291cmNlX3NpemVfdCAgICAgICAgIGFwZXJfYmFzZTsKPiAgICAgICAgIC8qIGZvciBzb21l
IGNoaXBzIHdpdGggPD0gMzJNQiB3ZSBuZWVkIHRvIGxpZQo+ICAgICAgICAgICogYWJvdXQgdnJh
bSBzaXplIG5lYXIgbWMgZmIgbG9jYXRpb24gKi8KPiAgICAgICAgIHU2NCAgICAgICAgICAgICAg
ICAgICAgIG1jX3ZyYW1fc2l6ZTsKPiAgICAgICAgIHU2NCAgICAgICAgICAgICAgICAgICAgIHZp
c2libGVfdnJhbV9zaXplOwo+ICsgICAgICAgLyogQVBHIGFwZXJ0dXJlIHN0YXJ0IGFuZCBlbmQg
aW4gTUMgYWRkcmVzcyBzcGFjZQo+ICsgICAgICAgICogRHJpdmVyIGZpbmQgYSBob2xlIGluIHRo
ZSBNQyBhZGRyZXNzIHNwYWNlCj4gKyAgICAgICAgKiB0byBwbGFjZSBBR1AgYnkgc2V0dGluZyBN
Q19WTV9BR1BfQk9UL1RPUCByZWdpc3RlcnMKPiArICAgICAgICAqIFVuZGVyIFZNSUQwLCBsb2dp
Y2FsIGFkZHJlc3MgPT0gTUMgYWRkcmVzcwo+ICsgICAgICAgICogQUdQIGFwZXJ0dXJlIGlzIHVz
ZWQgdG8gc2ltdWxhdGUgRkIgaW4gWkZCIGNhc2UKPiArICAgICAgICAqLwo+ICAgICAgICAgdTY0
ICAgICAgICAgICAgICAgICAgICAgYWdwX3NpemU7Cj4gICAgICAgICB1NjQgICAgICAgICAgICAg
ICAgICAgICBhZ3Bfc3RhcnQ7Cj4gICAgICAgICB1NjQgICAgICAgICAgICAgICAgICAgICBhZ3Bf
ZW5kOwo+ICsgICAgICAgLyogR0FSVCBhcGVydHVyZSBzdGFydCBhbmQgZW5kIGluIE1DIGFkZHJl
c3Mgc3BhY2UKPiArICAgICAgICAqIERyaXZlciBmaW5kIGEgaG9sZSBpbiB0aGUgTUMgYWRkcmVz
cyBzcGFjZQo+ICsgICAgICAgICogdG8gcGxhY2UgR0FSVCBieSBzZXR0aW5nIFZNX0NPTlRFWFQw
X1BBR0VfVEFCTEVfU1RBUlQvRU5EX0FERFIKPiArICAgICAgICAqIHJlZ2lzdGVycwo+ICsgICAg
ICAgICogVW5kZXIgVk1JRDAsIGxvZ2ljYWwgYWRkcmVzcyBpbnNpZGUgR0FSVCBhcGVydHVyZSB3
aWxsCj4gKyAgICAgICAgKiBiZSB0cmFuc2xhdGVkIHRocm91Z2ggZ3B1dm0gZ2FydCBwYWdlIHRh
YmxlIHRvIGFjY2Vzcwo+ICsgICAgICAgICogcGFnZWQgc3lzdGVtIG1lbW9yeQo+ICsgICAgICAg
ICovCj4gICAgICAgICB1NjQgICAgICAgICAgICAgICAgICAgICBnYXJ0X3NpemU7Cj4gICAgICAg
ICB1NjQgICAgICAgICAgICAgICAgICAgICBnYXJ0X3N0YXJ0Owo+ICAgICAgICAgdTY0ICAgICAg
ICAgICAgICAgICAgICAgZ2FydF9lbmQ7Cj4gKyAgICAgICAvKiBGcmFtZSBidWZmZXIgYXBlcnR1
cmUgb2YgdGhpcyBHUFUgZGV2aWNlLiBEaWZmZXJlbnQgZnJvbQo+ICsgICAgICAgICogZmJfc3Rh
cnQgKHNlZSBiZWxvdyksIHRoaXMgb25seSBjb3ZlcnMgdGhlIGxvY2FsIEdQVSBkZXZpY2UuCj4g
KyAgICAgICAgKiBEcml2ZXIgZ2V0IGZiX3N0YXJ0IGZyb20gTUNfVk1fRkJfTE9DQVRJT05fQkFT
RSAoc2V0IGJ5IHZiaW9zKQo+ICsgICAgICAgICogYW5kIGNhbGN1bGF0ZSB2cmFtX3N0YXJ0IG9m
IHRoaXMgbG9jYWwgZGV2aWNlIGJ5IGFkZGluZyBhbgo+ICsgICAgICAgICogb2Zmc2V0IGluc2lk
ZSB0aGUgWEdNSSBoaXZlLgo+ICsgICAgICAgICogVW5kZXIgVk1JRDAsIGxvZ2ljYWwgYWRkcmVz
cyA9PSBNQyBhZGRyZXNzCj4gKyAgICAgICAgKi8KPiAgICAgICAgIHU2NCAgICAgICAgICAgICAg
ICAgICAgIHZyYW1fc3RhcnQ7Cj4gICAgICAgICB1NjQgICAgICAgICAgICAgICAgICAgICB2cmFt
X2VuZDsKPiAgICAgICAgIC8qIEZCIHJlZ2lvbiAsIGl0J3Mgc2FtZSBhcyBsb2NhbCB2cmFtIHJl
Z2lvbiBpbiBzaW5nbGUgR1BVLCBpbiBYR01JCj4gLS0KPiAyLjcuNAo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
