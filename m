Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BACDC3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D5F52073D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcAuyC0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D5F52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38EA6E20E;
	Thu,  5 Mar 2020 11:32:05 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD99C6E20E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 11:32:04 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id n15so1229894wrw.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2020 03:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Cws+DCGywKR0TBjSdAgdqw87XU/i5TPPxoNB+SQEIQw=;
 b=QcAuyC0+4UNm3iGnLyQg01YKwITP5s5DC7LaUytt+v/6wVnbvJ8+5lB8Ryav07ymu8
 V6BZlHg7cNqECWz9JSydrSSHThQZ55FeXl6Yb8XwVl1zU6TMXjUcdXt8ENBnNO1YX5SU
 rk8dS77c6sz3mLeVwoim4IGQC9DB3ft+caNIOj+Ql8eMYxyJBNtADEmb5yHPF/4pRWrx
 LK9HCY11Di133pyzFOUkHmLk88ckyhmP6zD++M0yLb/ixEg7K8umKB9rHn4N7dG3qXnx
 MmT7Q/noe4aV3U31wdg3Rav2FafrLFodsMMlPmEOGjVxpsqh/rmIvRU05Y6Jang9z3YC
 tJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Cws+DCGywKR0TBjSdAgdqw87XU/i5TPPxoNB+SQEIQw=;
 b=JjSxRxlWW8I750drgThydJxMqPJoVrYUjGliL1Y8PXxoqmT4UAA5OnoVco/LlL6nGw
 3wnUeq3AsnLdfw2FUASSFrMeoREqX0zFwPRQpcSgGxdIo4XcL1MOnWloyqLJsaHuusAs
 3d8kgG7/emNJC4YVbuV7UhQvBVWjRedVgtaU4W7rwb788KGrLIYpqMR507T9WOzn8k5t
 5NcTqtGPRDht9BT9SBbtd0Lc90FPt0+m4wtckpQZG1SW1U8v+7mmYHYLlJ/2ahIq4tGa
 iKQGrkviAFmEX5hh1MyrHQ3s8ngKbVCa2mxvc5l9jZhuiQh0waVQNY+Ptq5PrZ+lHwS7
 0kPg==
X-Gm-Message-State: ANhLgQ2Z3BJQKQq7Myea2GJTaLmRFIwdOk1DA/QAfm8w2CrFoVuv7oGs
 c/sNrQ7HFabaumMii5d6G5VTBRMW
X-Google-Smtp-Source: ADFU+vvtWyOTQmTGm/PYyLGydXvmYJKZz2Zka8AHmhAA+hpeWOlPQl3yR4a9kfddNZIZe//hdAVR0A==
X-Received: by 2002:adf:a30a:: with SMTP id c10mr4606737wrb.175.1583407923218; 
 Thu, 05 Mar 2020 03:32:03 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f17sm34436503wrj.28.2020.03.05.03.32.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 03:32:02 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Use better names to reflect it is CP MQD
 buffer
To: Yong Zhao <Yong.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200304203529.8771-1-Yong.Zhao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3279d6d8-800f-4309-11dc-4e7a7a873891@gmail.com>
Date: Thu, 5 Mar 2020 12:32:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200304203529.8771-1-Yong.Zhao@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDQuMDMuMjAgdW0gMjE6MzUgc2NocmllYiBZb25nIFpoYW86Cj4gQWRkICJDUCIgdG8gQU1E
R1BVX0dFTV9DUkVBVEVfTVFEX0dGWDkgdG8gaW5kaWNhdGUgaXQgaXMgb25seSBmb3IgQ1AgTVFE
LgoKWW91IHNob3VsZCBwcm9iYWJseSBub3RlIHRoYXQgd2UgY2FuIGRvIHRoaXMgYmVjYXVzZSBp
dCB3YXMgYWx3YXlzIAppbGxlZ2FsIGZvciB1c2Vyc3BhY2UgdG8gdXNlIHRoZSBmbGFnLgoKPiBD
aGFuZ2UtSWQ6IEllNjljZDNiYTQ3N2U0YmFjMTYxZWE1YjIwZWMyOTE5YTM1ZjM1MjhlCj4gU2ln
bmVkLW9mZi1ieTogWW9uZyBaaGFvIDxZb25nLlpoYW9AYW1kLmNvbT4KCkFja2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIHwgNiArKystLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyAgICB8IDcgKysrKystLQo+ICAgaW5j
bHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmggICAgICAgICAgICAgIHwgMiArLQo+ICAgMyBmaWxl
cyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jCj4gaW5kZXggYmMyZTcyYTY2ZGI5Li43
MjZjOTFhYjY3NjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZC5jCj4gQEAgLTIyNCw3ICsyMjQsNyBAQCB2b2lkIGFtZGdwdV9hbWRrZmRfZ3B1X3Jlc2V0
KHN0cnVjdCBrZ2RfZGV2ICprZ2QpCj4gICAKPiAgIGludCBhbWRncHVfYW1ka2ZkX2FsbG9jX2d0
dF9tZW0oc3RydWN0IGtnZF9kZXYgKmtnZCwgc2l6ZV90IHNpemUsCj4gICAJCQkJdm9pZCAqKm1l
bV9vYmosIHVpbnQ2NF90ICpncHVfYWRkciwKPiAtCQkJCXZvaWQgKipjcHVfcHRyLCBib29sIG1x
ZF9nZng5KQo+ICsJCQkJdm9pZCAqKmNwdV9wdHIsIGJvb2wgY3BfbXFkX2dmeDkpCj4gICB7Cj4g
ICAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKilr
Z2Q7Cj4gICAJc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBOVUxMOwo+IEBAIC0yNDAsOCArMjQwLDgg
QEAgaW50IGFtZGdwdV9hbWRrZmRfYWxsb2NfZ3R0X21lbShzdHJ1Y3Qga2dkX2RldiAqa2dkLCBz
aXplX3Qgc2l6ZSwKPiAgIAlicC50eXBlID0gdHRtX2JvX3R5cGVfa2VybmVsOwo+ICAgCWJwLnJl
c3YgPSBOVUxMOwo+ICAgCj4gLQlpZiAobXFkX2dmeDkpCj4gLQkJYnAuZmxhZ3MgfD0gQU1ER1BV
X0dFTV9DUkVBVEVfTVFEX0dGWDk7Cj4gKwlpZiAoY3BfbXFkX2dmeDkpCj4gKwkJYnAuZmxhZ3Mg
fD0gQU1ER1BVX0dFTV9DUkVBVEVfQ1BfTVFEX0dGWDk7Cj4gICAKPiAgIAlyID0gYW1kZ3B1X2Jv
X2NyZWF0ZShhZGV2LCAmYnAsICZibyk7Cj4gICAJaWYgKHIpIHsKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gaW5kZXggZmNhODdiYWZlMTc0Li42NjVkYjIzNTNhNzgg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gQEAgLTEwNDMs
NyArMTA0Myw3IEBAIGludCBhbWRncHVfdHRtX2dhcnRfYmluZChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKPiAgIAlpZiAoYW1kZ3B1X2JvX2VuY3J5cHRlZChhYm8pKQo+ICAgCQlmbGFncyB8
PSBBTURHUFVfUFRFX1RNWjsKPiAgIAo+IC0JaWYgKGFiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NS
RUFURV9NUURfR0ZYOSkgewo+ICsJaWYgKGFiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9D
UF9NUURfR0ZYOSkgewo+ICAgCQl1aW50NjRfdCBwYWdlX2lkeCA9IDE7Cj4gICAKPiAgIAkJciA9
IGFtZGdwdV9nYXJ0X2JpbmQoYWRldiwgZ3R0LT5vZmZzZXQsIHBhZ2VfaWR4LAo+IEBAIC0xMDUx
LDcgKzEwNTEsMTAgQEAgaW50IGFtZGdwdV90dG1fZ2FydF9iaW5kKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAo+ICAgCQlpZiAocikKPiAgIAkJCWdvdG8gZ2FydF9iaW5kX2ZhaWw7Cj4gICAK
PiAtCQkvKiBQYXRjaCBtdHlwZSBvZiB0aGUgc2Vjb25kIHBhcnQgQk8gKi8KPiArCQkvKiBUaGUg
bWVtb3J5IHR5cGUgb2YgdGhlIGZpcnN0IHBhZ2UgZGVmYXVsdHMgdG8gVUMuIE5vdwo+ICsJCSAq
IG1vZGlmeSB0aGUgbWVtb3J5IHR5cGUgdG8gTkMgZnJvbSB0aGUgc2Vjb25kIHBhZ2Ugb2YKPiAr
CQkgKiB0aGUgQk8gb253YXJkLgo+ICsJCSAqLwo+ICAgCQlmbGFncyAmPSB+QU1ER1BVX1BURV9N
VFlQRV9WRzEwX01BU0s7Cj4gICAJCWZsYWdzIHw9IEFNREdQVV9QVEVfTVRZUEVfVkcxMChBTURH
UFVfTVRZUEVfTkMpOwo+ICAgCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1
X2RybS5oIGIvaW5jbHVkZS91YXBpL2RybS9hbWRncHVfZHJtLmgKPiBpbmRleCBlYWY5NGE0MjE5
MDEuLjFlNTljMDE0NjUzMSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvZHJtL2FtZGdwdV9k
cm0uaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9kcm0vYW1kZ3B1X2RybS5oCj4gQEAgLTEzMCw3ICsx
MzAsNyBAQCBleHRlcm4gIkMiIHsKPiAgIC8qIEZsYWcgdGhhdCBpbmRpY2F0ZXMgYWxsb2NhdGlu
ZyBNUUQgZ2FydCBvbiBHRlg5LCB3aGVyZSB0aGUgbXR5cGUKPiAgICAqIGZvciB0aGUgc2Vjb25k
IHBhZ2Ugb253YXJkIHNob3VsZCBiZSBzZXQgdG8gTkMuCj4gICAgKi8KPiAtI2RlZmluZSBBTURH
UFVfR0VNX0NSRUFURV9NUURfR0ZYOQkJKDEgPDwgOCkKPiArI2RlZmluZSBBTURHUFVfR0VNX0NS
RUFURV9DUF9NUURfR0ZYOQkJKDEgPDwgOCkKPiAgIC8qIEZsYWcgdGhhdCBCTyBtYXkgY29udGFp
biBzZW5zaXRpdmUgZGF0YSB0aGF0IG11c3QgYmUgd2lwZWQgYmVmb3JlCj4gICAgKiByZWxlYXNp
bmcgdGhlIG1lbW9yeQo+ICAgICovCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2Ft
ZC1nZngK
