Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E93CC34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 14:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E90C24656
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 14:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jl+B4vrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E90C24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A35F6EC0B;
	Wed, 19 Feb 2020 14:44:10 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5062B6EC0B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 14:44:09 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id g3so795710wrs.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 06:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=grmZ/jqB9ds7dYhcwb5r8w4HBc1Vgb/oW5A4PsrJjzY=;
 b=jl+B4vrBI3UxuSnt2BHOZYht5msQMWx9Dxi5EPweHQ0Z8JOlGt6tf788KsvgLc0rvM
 cUWQzG8ISGcfCH7br0Ew9fO5duwGWJJ1tzfJWKhuExT4SxxmxNlnU+VzQ5Q0nHm1v2Rv
 B7R4AFiFPYAPjCPyImS4WY1dcrPNWIJIYl0BXFPJOlA0aWmlUK4Rp/h7CISYdHZEzB0h
 M4ZI74iHTIvarx6cMxulF66snrEQEVIlra6iHxPyyWml5wUhFvH33TjwgkYLHdf7wu8i
 9m95wTxpUD3Ufjju1yQPvy8yBH28AWuP/j0Mv9VyWiwD1SzXFmvxa9DiFUajc4HcRdSM
 UX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=grmZ/jqB9ds7dYhcwb5r8w4HBc1Vgb/oW5A4PsrJjzY=;
 b=qjB5nZ8EF5wzc6gZbdHPmhzuN0rNMqJ0vTYxv0Hy+EIZiSFwBRW3+cX3PchqLszQwC
 yJcLPgMSLr+f5l8YRdNn3diAf+Cqmi2syccNFo1BWbYufPS6RvEKfwn1K3Gei7zfgQ/I
 Yhh8u+lBxejuTpcLBCvVrKln1yA4GYL6Oni5TAfjHAW7Q3y/+8nk2raBcwOrtQhfEM9X
 rvrSV9iXItQXhykk0LmeqJf9g9scMo2mRMC/fB3AF+HodSIOTezZJ0VHnbRMzw/VEqAz
 DSPndJOXrVEl1vnS1miG3QpA42VelvYpoapSi+ltdOvR70JnnX0Zoz9+tDWhWT8UwNlm
 0H3g==
X-Gm-Message-State: APjAAAU8wS8PfL7yfgS7dvwqeBwyAsz9bm+tBSzg+ABhQtSSQJA0yaST
 MvCVqEOiJa1VqK2v9SSUaSWUMPgJ
X-Google-Smtp-Source: APXvYqw0wc+lAbVd7YNpOgRb74m5sG+WzbI9eiQIHwRcl4uKEkjzryuJHVxcm/OQM8krfbwGaG/nMA==
X-Received: by 2002:a5d:514b:: with SMTP id u11mr36131378wrt.322.1582123447672; 
 Wed, 19 Feb 2020 06:44:07 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a184sm59502wmf.29.2020.02.19.06.44.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Feb 2020 06:44:07 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: add VM update fences back to the root PD
To: Tom St Denis <tom.stdenis@amd.com>, luben.tuikov@amd.com,
 Marek.Olsak@amd.com, Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org
References: <20200219142014.25386-1-christian.koenig@amd.com>
 <1fde8a92-0b9b-4b0a-e319-7b407810d36c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <45c48a55-9374-78ea-4bbc-a2c564ca5001@gmail.com>
Date: Wed, 19 Feb 2020 15:44:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1fde8a92-0b9b-4b0a-e319-7b407810d36c@amd.com>
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

V2VsbCBpdCBzaG91bGQgYXBwbHkgb24gdG9wIG9mIGFtZC1zdGFnaW5nLWRybS1uZXh0LiBCdXQg
SSBoYXZlbid0IApmZXRjaGVkIHRoYXQgdG9kYXkgeWV0LgoKR2l2ZSBtZSBhIG1pbnV0ZSB0byBy
ZWJhc2UuCgpDaHJpc3RpYW4uCgpBbSAxOS4wMi4yMCB1bSAxNToyNyBzY2hyaWViIFRvbSBTdCBE
ZW5pczoKPiBUaGlzIGRvZXNuJ3QgYXBwbHkgb24gdG9wIG9mIDdmZDNiNjMyZTE3ZTU1YzVmZmQw
MDhmOWYwMjU3NTRlN2RhYTFiNjYgCj4gd2hpY2ggaXMgdGhlIHRpcCBvZiBkcm0tbmV4dAo+Cj4K
PiBUb20KPgo+IE9uIDIwMjAtMDItMTkgOToyMCBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3Rl
Ogo+PiBBZGQgdXBkYXRlIGZlbmNlcyB0byB0aGUgcm9vdCBQRCB3aGlsZSBtYXBwaW5nIEJPcy4K
Pj4KPj4gT3RoZXJ3aXNlIFBEcyBmcmVlZCBkdXJpbmcgdGhlIG1hcHBpbmcgd29uJ3Qgd2FpdCBm
b3IKPj4gdXBkYXRlcyB0byBmaW5pc2ggYW5kIGNhbiBjYXVzZSBjb3JydXB0aW9ucy4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAx
NCArKysrKysrKysrKystLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCj4+IGluZGV4IGU3YWIwYzFlMjc5My4uZGQ2M2NjZGJhZDJhIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBAQCAtNTg1LDggKzU4NSw4IEBAIHZvaWQg
YW1kZ3B1X3ZtX2dldF9wZF9ibyhzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSwKPj4gwqAgewo+PiDCoMKg
wqDCoMKgIGVudHJ5LT5wcmlvcml0eSA9IDA7Cj4+IMKgwqDCoMKgwqAgZW50cnktPnR2LmJvID0g
JnZtLT5yb290LmJhc2UuYm8tPnRibzsKPj4gLcKgwqDCoCAvKiBPbmUgZm9yIFRUTSBhbmQgb25l
IGZvciB0aGUgQ1Mgam9iICovCj4+IC3CoMKgwqAgZW50cnktPnR2Lm51bV9zaGFyZWQgPSAyOwo+
PiArwqDCoMKgIC8qIFR3byBmb3IgVk0gdXBkYXRlcywgb25lIGZvciBUVE0gYW5kIG9uZSBmb3Ig
dGhlIENTIGpvYiAqLwo+PiArwqDCoMKgIGVudHJ5LT50di5udW1fc2hhcmVkID0gNDsKPj4gwqDC
oMKgwqDCoCBlbnRyeS0+dXNlcl9wYWdlcyA9IE5VTEw7Cj4+IMKgwqDCoMKgwqAgbGlzdF9hZGQo
JmVudHJ5LT50di5oZWFkLCB2YWxpZGF0ZWQpOwo+PiDCoCB9Cj4+IEBAIC0xNjE5LDYgKzE2MTks
MTYgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYm9fdXBkYXRlX21hcHBpbmcoc3RydWN0IAo+PiBh
bWRncHVfZGV2aWNlICphZGV2LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcl91bmxv
Y2s7Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCArwqDCoMKgIGlmIChmbGFncyAmIEFNREdQVV9QVEVf
VkFMSUQpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm8gKnJvb3QgPSB2bS0+
cm9vdC5iYXNlLmJvOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIWRtYV9mZW5jZV9pc19z
aWduYWxlZCh2bS0+bGFzdF9kaXJlY3QpKQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRn
cHVfYm9fZmVuY2Uocm9vdCwgdm0tPmxhc3RfZGlyZWN0LCB0cnVlKTsKPj4gKwo+PiArwqDCoMKg
wqDCoMKgwqAgaWYgKCFkbWFfZmVuY2VfaXNfc2lnbmFsZWQodm0tPmxhc3RfZGVsYXllZCkpCj4+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9ib19mZW5jZShyb290LCB2bS0+bGFzdF9k
ZWxheWVkLCB0cnVlKTsKPj4gK8KgwqDCoCB9Cj4+ICsKPj4gwqDCoMKgwqDCoCByID0gdm0tPnVw
ZGF0ZV9mdW5jcy0+cHJlcGFyZSgmcGFyYW1zLCByZXN2LCBzeW5jX21vZGUpOwo+PiDCoMKgwqDC
oMKgIGlmIChyKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJvcl91bmxvY2s7CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
