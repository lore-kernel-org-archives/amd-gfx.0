Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12200C5DF61
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 13:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF551214D8
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 13:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF551214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A049E6E45F;
	Thu,  7 Nov 2019 13:57:55 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD2E6E45F
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Nov 2019 13:57:54 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id c17so2601202wmk.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Nov 2019 05:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=koitt3iwcJ4WBMAwsftKrAgxU8Y8o7f8kZmQEvV8DhM=;
 b=dFpP+1+ljG4ryEoD+wLMnXRGLOTvOge5oABZA89hEmeNuWgYArYE3PQchDsQ09LkHM
 tybLpQ7dby0bXTsJ8R8hT3bP8dEkKVOYH8340pzRqZ+UCWZKMW6+yeRaiJiDHs7f+oNj
 AV0j6ZdX/O/ZTFQdnloIqghPszwx7dcPVAkobtr2Fo883rmInjaDXIFUUvQeAgbmtjfm
 ym/GsvHVvdQjE5P6+x93oc7//BLD0/QprqgB/CgNv5/33ag8Sih8aFs2pug/fVVUWSOq
 LqtXsYzUd5sduTRm1MF1hqIs+79iJG6qeK34Vb9hIhdIjDRu5s3WPh+VaIh0wefOgue8
 Re8w==
X-Gm-Message-State: APjAAAVskYoHJYwmfzCzmO2lLlAoUJl/Vi8glG7gKsFbpx9ee4qykjwD
 fX24q2XT+yoJ0/pNa8EI4KjwBg9rfGClU2EFVMPcVA==
X-Google-Smtp-Source: APXvYqzstkP2jvXaqo9zC6xQVtuEoTAsKiCsAn8lWx9QaKHOsj3kAY4ra3Zk3+1O0WW6WGwsJiM2i9PmvClLCkuTcJs=
X-Received: by 2002:a1c:790b:: with SMTP id l11mr3191381wme.127.1573135073368; 
 Thu, 07 Nov 2019 05:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20191107073817.27624-1-evan.quan@amd.com>
In-Reply-To: <20191107073817.27624-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Nov 2019 08:57:41 -0500
Message-ID:
 <CADnq5_PxWYGE1-uL+pey-Rwj6EiP2EuO+Y4N7aYNL85P3QOeUw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: correct Arcturus OD support
To: "Quan, Evan" <Evan.Quan@amd.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc;
 bh=koitt3iwcJ4WBMAwsftKrAgxU8Y8o7f8kZmQEvV8DhM=;
 b=jHyOabQAg/Z13xmevjUyLcNGXVMpm1+dgv3D7jqVQV5rZ6Fs23/8OFZ5Jv/XT2+Uu5
 yXIk49+E0NLsRkRJi5571KFkhsxmmKRM3aDF03N11xdv/IpH9REeNEbO3aCsZK5GowhE
 UdOcK97bixtU3HyKTDldoiE5OaipmS9dxMwEqVd4eUUvna6ECNxVkiWchIYg4m5Bxpik
 +kGfHNg5KaLe+bNmta4FMIqbe7SoyLOFMOzYRpmGU52fGToLRADWK+mh2l6vYUnWATS1
 aP6ZZwPwW4qbDQAh3qd/h7DWs1IN7AAUDOkkwbXcj8VWnRGIhdwEC3oDPotZ1ZbA9AxB
 jTZg==
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
Cc: "Li, Candice" <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Freehill,
 Chris" <Chris.Freehill@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107135741.OabBoqErUE05ojhxmfaSzsZ26OYS5TgoQmII-_JthWM@z>

T24gVGh1LCBOb3YgNywgMjAxOSBhdCAyOjM4IEFNIFF1YW4sIEV2YW4gPEV2YW4uUXVhbkBhbWQu
Y29tPiB3cm90ZToKPgo+IE9EIGlzIG5vdCBzdXBwb3J0ZWQgb24gQXJjdHVydXMuIFRodXMgdGhl
Cj4gcHBfb2RfY2xrX3ZvbHRhZ2Ugc3lzZnMgaW50ZXJmYWNlIGlzIGFsc28gbm90IHN1cHBvcnRl
ZC4KPgo+IENoYW5nZS1JZDogSWI3MDYzMmE1NWEwOTgwY2YwNGMzNDMyZDQzZGJjZjg2OWNkMWI0
YmYKPiBTaWduZWQtb2ZmLWJ5OiBFdmFuIFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgoKWW91IG1p
Z2h0IHdhbnQgdG8gY2hlY2sgd2l0aCBDaHJpcyBhbmQgS2VudCBhYm91dCB0aGlzLiAgSSB0aGlu
ayB0aGVyZQppcyBhIHVzZSBjYXNlIGZvciBPRCBvbiBST0NtIGluIHNvbWUgY2FzZXMuICBBc3N1
bWluZyB0aGV5IGFyZSBvayB3aXRoCml0LApSZXZpZXdlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4
YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKQWxleAoKPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jIHwgOCArKysrKy0tLQo+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L2FtZGdwdV9zbXUuYwo+IGluZGV4IGMyMWZlN2FjNWRmOC4uNzZhNDE1NGIzYmUy
IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUu
Ywo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwo+IEBA
IC03MTQsNiArNzE0LDkgQEAgc3RhdGljIGludCBzbXVfc2V0X2Z1bmNzKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSA9ICZh
ZGV2LT5zbXU7Cj4KPiArICAgICAgIGlmIChhZGV2LT5wbS5wcF9mZWF0dXJlICYgUFBfT1ZFUkRS
SVZFX01BU0spCj4gKyAgICAgICAgICAgICAgIHNtdS0+b2RfZW5hYmxlZCA9IHRydWU7Cj4gKwo+
ICAgICAgICAgc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPiAgICAgICAgIGNhc2UgQ0hJUF9W
RUdBMjA6Cj4gICAgICAgICAgICAgICAgIHZlZ2EyMF9zZXRfcHB0X2Z1bmNzKHNtdSk7Cj4gQEAg
LTcyNSw2ICs3MjgsOCBAQCBzdGF0aWMgaW50IHNtdV9zZXRfZnVuY3Moc3RydWN0IGFtZGdwdV9k
ZXZpY2UgKmFkZXYpCj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAgY2FzZSBDSElQ
X0FSQ1RVUlVTOgo+ICAgICAgICAgICAgICAgICBhcmN0dXJ1c19zZXRfcHB0X2Z1bmNzKHNtdSk7
Cj4gKyAgICAgICAgICAgICAgIC8qIE9EIGlzIG5vdCBzdXBwb3J0ZWQgb24gQXJjdHVydXMgKi8K
PiArICAgICAgICAgICAgICAgc211LT5vZF9lbmFibGVkID1mYWxzZTsKPiAgICAgICAgICAgICAg
ICAgYnJlYWs7Cj4gICAgICAgICBjYXNlIENISVBfUkVOT0lSOgo+ICAgICAgICAgICAgICAgICBy
ZW5vaXJfc2V0X3BwdF9mdW5jcyhzbXUpOwo+IEBAIC03MzMsOSArNzM4LDYgQEAgc3RhdGljIGlu
dCBzbXVfc2V0X2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTlZBTDsKPiAgICAgICAgIH0KPgo+IC0gICAgICAgaWYgKGFkZXYtPnBt
LnBwX2ZlYXR1cmUgJiBQUF9PVkVSRFJJVkVfTUFTSykKPiAtICAgICAgICAgICAgICAgc211LT5v
ZF9lbmFibGVkID0gdHJ1ZTsKPiAtCj4gICAgICAgICByZXR1cm4gMDsKPiAgfQo+Cj4gLS0KPiAy
LjIzLjAKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+
IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeApf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
