Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA15CA9EC3
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 07:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655752083E
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 07:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655752083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BEC6ED8F;
	Thu, 31 Oct 2019 07:24:18 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B166ED8F
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 07:24:16 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id n1so5003626wra.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 00:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=PpROy/ukT/s6JHM2VW4TD7H37iB1maCBysspO6Z6n9Y=;
 b=A/XBDL6lS+/er3Cyj8hKm7J/FX4kRWtkAmaqunZvOYUNR9gXqXDhB51IYvUleMwJgQ
 OjzYVHhg7Sct3PSsZbEE0NfkrTd9rlNTEecvHRRJatIVKKbIcwM0xvvWM6Hol0l9CLxB
 UeAqQFYBXY2YnsH+ijJYYwaMDmjqFUg23pVLxs40+6I4o91US+DAMQhYYor2LLZQrHDc
 PI9djdSNyKrIohzZCO4EaXtpYToW3ID7HmZPzKNzXgzVX0R/2WdfJ8WJUvVOSgASuvYi
 B0lu8aN0oeSn6vIVb7wtumfqYUeiPZv7G0uwREP5bxIF9cWVsPHDjaDflq/+PyJSkBEo
 XqeQ==
X-Gm-Message-State: APjAAAUFfnVkyhzTr0KkJiqYJTxoqSfWYj00jfb5Zt/fN6yxD/JkcQcC
 GHkYg+YgLpZyIe6aJhxY9x4=
X-Google-Smtp-Source: APXvYqxCp1Q17Gq6GaUQUmEWOja6/vRLhd0Hh+17YyeVsO31VYuh+vm98cwcpI/KtSw9SCalZb3dpA==
X-Received: by 2002:a5d:51c2:: with SMTP id n2mr3905365wrv.149.1572506654954; 
 Thu, 31 Oct 2019 00:24:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i3sm3213827wrw.69.2019.10.31.00.24.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Oct 2019 00:24:14 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/gpuvm: add some additional comments in
 amdgpu_vm_update_ptes
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20191030184134.250234-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8295fffb-c2b2-9ac1-b864-d498999b3332@gmail.com>
Date: Thu, 31 Oct 2019 08:24:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030184134.250234-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=PpROy/ukT/s6JHM2VW4TD7H37iB1maCBysspO6Z6n9Y=;
 b=EO136iw6aiIQP83qxzQguFUHtefJcjdPPdcyOOs763jZH1VMPjhSbkoZbOyBCY9Swy
 NkEqRQmQQYUz9CLZq78xL9IpWBpfs28MXQfAKUE3QZ0WMv1XBJomvd5jiiZ/dSaO9Zzm
 wdkTWa3nV43lJCMtVzC95OHgSJM69qkDdIwllZWClcOgGIyPMWe/PS+fXYCQ47NX1/yT
 evvZ+7315axh1hSgoEBtIMiCbyfoAHumHdDzIJFcIZDnFG1P9aXNMS6WPGawklJceLnu
 AEn0CYNrOeZmYhZkmoFyhxXu9dS4W4seP6cNVpagy97+hYRkPid9YYohceEOsIYyxJiI
 n6yA==
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031072413.9hBnJOfMvSo4fKIuzg9wtsUXFp-kVo6AwjOXOIgEWbw@z>

QW0gMzAuMTAuMTkgdW0gMTk6NDEgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVG8gYmV0dGVyIGNs
YXJpZnkgd2hhdCBpcyBoYXBwZW5pbmcgaW4gdGhpcyBmdW5jdGlvbi4KPgo+IFNpZ25lZC1vZmYt
Ynk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5
OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAxMCArKysrKysrKystCj4g
ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IGM4Y2U0MjIwMDA1OS4uM2Mw
YmQ2NDcyYTQ2IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV92bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiBA
QCAtMTQxOSw2ICsxNDE5LDkgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3Ry
dWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCj4gICAJCXVpbnQ2NF90IGluY3Is
IGVudHJ5X2VuZCwgcGVfc3RhcnQ7Cj4gICAJCXN0cnVjdCBhbWRncHVfYm8gKnB0Owo+ICAgCj4g
KwkJLyogbWFrZSBzdXJlIHRoYXQgdGhlIHBhZ2UgdGFibGVzIGNvdmVyaW5nIHRoZSBhZGRyZXNz
IHJhbmdlIGFyZQo+ICsJCSAqIGFjdHVhbGx5IGFsbG9jYXRlZAo+ICsJCSAqLwo+ICAgCQlyID0g
YW1kZ3B1X3ZtX2FsbG9jX3B0cyhwYXJhbXMtPmFkZXYsIHBhcmFtcy0+dm0sICZjdXJzb3IsCj4g
ICAJCQkJCXBhcmFtcy0+ZGlyZWN0KTsKPiAgIAkJaWYgKHIpCj4gQEAgLTE0OTIsNyArMTQ5NSwx
MiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3ZtX3Vw
ZGF0ZV9wYXJhbXMgKnBhcmFtcywKPiAgIAkJfSB3aGlsZSAoZnJhZ19zdGFydCA8IGVudHJ5X2Vu
ZCk7Cj4gICAKPiAgIAkJaWYgKGFtZGdwdV92bV9wdF9kZXNjZW5kYW50KGFkZXYsICZjdXJzb3Ip
KSB7Cj4gLQkJCS8qIEZyZWUgYWxsIGNoaWxkIGVudHJpZXMgKi8KPiArCQkJLyogRnJlZSBhbGwg
Y2hpbGQgZW50cmllcy4KPiArCQkJICogVXBkYXRlIHRoZSB0YWJsZXMgd2l0aCB0aGUgZmxhZ3Mg
YW5kIGFkZHJlc3NlcyBhbmQgZnJlZSB1cCBzdWJzZXF1ZW50Cj4gKwkJCSAqIHRhYmxlcyBpbiB0
aGUgY2FzZSBvZiBodWdlIHBhZ2VzIG9yIGZyZWVkIHVwIGFyZWFzLgo+ICsJCQkgKiBUaGlzIGlz
IHRoZSBtYXhpbXVtIHlvdSBjYW4gZnJlZSwgYmVjYXVzZSBhbGwgb3RoZXIgcGFnZSB0YWJsZXMg
YXJlIG5vdAo+ICsJCQkgKiBjb21wbGV0ZWx5IGNvdmVyZWQgYnkgdGhlIHJhbmdlIGFuZCBzbyBw
b3RlbnRpYWxseSBzdGlsbCBpbiB1c2UuCj4gKwkJCSAqLwo+ICAgCQkJd2hpbGUgKGN1cnNvci5w
Zm4gPCBmcmFnX3N0YXJ0KSB7Cj4gICAJCQkJYW1kZ3B1X3ZtX2ZyZWVfcHRzKGFkZXYsIHBhcmFt
cy0+dm0sICZjdXJzb3IpOwo+ICAgCQkJCWFtZGdwdV92bV9wdF9uZXh0KGFkZXYsICZjdXJzb3Ip
OwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
