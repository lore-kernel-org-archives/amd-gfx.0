Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF2C33CB2
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 11:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF572214D8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 11:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftp6skno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF572214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 869E96E971;
	Fri, 31 Jan 2020 11:58:19 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD05C6E971
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 11:58:18 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id b17so8387264wmb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 03:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=o47aCp52FAxqBuP6YPIbHVzG+ZR+z27cIRZxqXjRBzg=;
 b=ftp6skno7L7zbZBxisIHuVM9vlvPoBU1npw2/P09zCF4LymNz21Gui5TkhrRJ1YWFK
 GczgkGwODWxQERubi2XknmTMZnC/NqdgkVvoitvCHrIh8ubr9UmD2hk8pfcUAUB32Zsl
 RnU22ebpdUWLMbaHOBessdqb4quL0fG1A4Xfnzx9UyN30WZ8cgxxMWPv5myBXq+197lI
 5jls2/v3/xGHikAomUG4zIyCaeQUlW65cpYeUMgWGXXzJVUpkUVZSsSEUuhfkXGKB9fq
 WPlJaDtFPCzykOtbUUVb3g3pg62ksZK6CJfVk85z6uNMv4UcPqOJU3ZSr7sBK+Ls507W
 Xusw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=o47aCp52FAxqBuP6YPIbHVzG+ZR+z27cIRZxqXjRBzg=;
 b=C8DaF33YPBvoW1rvfPJNPbgWAslkG/A+qMVILNTE6lDZtJMsr5ZcRS4ii7q5nkHEkh
 mS1GEoZ1DBrs+qu68zMVZOCS6s4qyIqKb1VuZmWLszUiRYhR+cVjh0fkkiD1InAgMROM
 rUfc01NnFh8Dz3FP9e3gRreR5Ad0KYWlzt9z//0w1QLovVgLAIysJV9nR2U3kw4ogXlP
 mdY0/qrPVQtjh0RiVgNHmLDWnmTjBq+7O+sH0kOAh5CCpWMpyDjaWUlz/n7zxUw86yxL
 G8OdN9Gf0q+z1X5zlwvT8T2uRZiUrZHjEGk3SiFsUkLCVdjMu4DN0TYI7RBbyWC7A0PZ
 RH1Q==
X-Gm-Message-State: APjAAAWZeOcQCA1hzaA22W3AWX683EQAiXVmD7xHUJT7HMJ4PVUm3Q+L
 J+SAKh/9NSJJjcLp8MHl/bZt6azY
X-Google-Smtp-Source: APXvYqxJvsGt8qyqrwipAsNOL8DyE+9nIspw8igO8LH/pb1MC1lRCOCDVbEEWlbxq1K2zib+oXHIyw==
X-Received: by 2002:a1c:3803:: with SMTP id f3mr4162521wma.134.1580471897022; 
 Fri, 31 Jan 2020 03:58:17 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e6sm10389917wme.3.2020.01.31.03.58.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 31 Jan 2020 03:58:16 -0800 (PST)
Subject: Re: [PATCH 1/5] drm/amdgpu: fix braces in amdgpu_vm_update_ptes
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200130124940.30380-1-christian.koenig@amd.com>
 <43ecd5a5-6087-0cb6-4ba0-adf0d4b3ac07@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <beb94356-a60b-61d1-92b1-aa13daa57700@gmail.com>
Date: Fri, 31 Jan 2020 12:58:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <43ecd5a5-6087-0cb6-4ba0-adf0d4b3ac07@amd.com>
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

QW0gMzAuMDEuMjAgdW0gMjM6MTEgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPgo+IE9uIDIwMjAt
MDEtMzAgNzo0OSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gRm9yIHRoZSByb290IFBEIG1h
c2sgY2FuIGJlIDB4ZmZmZmZmZmYgYXMgd2VsbCB3aGljaCB3b3VsZAo+PiBvdmVycnVuIHRvIDAg
aWYgd2UgZG9uJ3QgY2FzdCBpdCBiZWZvcmUgd2UgYWRkIG9uZS4KPiBZb3UncmUgZml4aW5nIHBh
cmVudGhlc2VzLCBub3QgYnJhY2VzLgo+Cj4gUGFyZW50aGVzZXM6ICgpCj4gQnJhY2tldHM6IFtd
Cj4gQnJhY2VzOiB7fQoKWWVhaCwgSSBjYW4ndCByZW1lbWJlciB3aGljaCBpcyB3aGF0IGluIEVu
Z2xpc2guIE5lZWQgdG8gZG91YmxlIGNoZWNrIAp0aGF0IG5leHQgdGltZS4KCj4KPiBXaXRoIHRo
ZSB0aXRsZSBmaXhlZCwgdGhpcyBwYXRjaCBpcwo+Cj4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhs
aW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgoKVGhhbmtzIGZvciB0aGUgcmV2aWV3LApDaHJp
c3RpYW4uCgo+Cj4+Cj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4KPj4gVGVzdGVkLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlz
QGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uYyB8IDIgKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdm0uYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBp
bmRleCA1Y2IxODIyMzFmNWQuLjRiYTZhNWU1ZDA5NCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4gQEAgLTE0ODcsNyArMTQ4Nyw3IEBAIHN0YXRpYyBpbnQg
YW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzKHN0cnVjdCAKPj4gYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMg
KnBhcmFtcywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGluY3IgPSAodWludDY0X3QpQU1ER1BVX0dQ
VV9QQUdFX1NJWkUgPDwgc2hpZnQ7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBtYXNrID0gYW1kZ3B1
X3ZtX2VudHJpZXNfbWFzayhhZGV2LCBjdXJzb3IubGV2ZWwpOwo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgcGVfc3RhcnQgPSAoKGN1cnNvci5wZm4gPj4gc2hpZnQpICYgbWFzaykgKiA4Owo+PiAtwqDC
oMKgwqDCoMKgwqAgZW50cnlfZW5kID0gKHVpbnQ2NF90KShtYXNrICsgMSkgPDwgc2hpZnQ7Cj4+
ICvCoMKgwqDCoMKgwqDCoCBlbnRyeV9lbmQgPSAoKHVpbnQ2NF90KW1hc2sgKyAxKSA8PCBzaGlm
dDsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVudHJ5X2VuZCArPSBjdXJzb3IucGZuICYgfihlbnRy
eV9lbmQgLSAxKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVudHJ5X2VuZCA9IG1pbihlbnRyeV9l
bmQsIGVuZCk7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
