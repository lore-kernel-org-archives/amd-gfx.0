Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B66C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 13:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39A49206D5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 13:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMX3+EdY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A49206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C906E0C9;
	Tue, 10 Dec 2019 13:02:11 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACEB66E0C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 13:02:10 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id g17so20010931wro.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=lDcZs6N6GO9i+CeorS93X2bTOUDRCG6u+3HBHGuwCBA=;
 b=cMX3+EdYSZgbt/B77/evZaXhkmzit/XyfGzXH9OpnF405R6cpQ3aPyCIP/OD7w3I58
 NPrmFATJEr0eEGHVZNEYnzRqEGxXSdaZfqBHstTxZkwIj0BaHkdo7xttRGD5XIdLaG/Z
 M2QeRyxwWIGbXy/3J7ZiwjMkkUq7d8Xng/3KJGIwDlixPWBpSERfWn3SfvNF7XfU2eLF
 QS1x8tmbOKL3uM/MiEnCxzjEm6CFdAyAMs/VT8KrsUBGd4trHUM4przdNOGru+TUDnXz
 4sNCXIjBrjlILfSZOD+oDY4KjzEJvhfpOhQHsv9y3F9HjaHNZMAnGMAV6DhgvOdtYzS4
 lb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=lDcZs6N6GO9i+CeorS93X2bTOUDRCG6u+3HBHGuwCBA=;
 b=iaii5zmtNkDWrRm4duEio5ltsqGdp/edy0hmliRtgyMakwY+KZAUy0qv1bn+WZ7ijR
 wXfpbG867+Dy0F89Ic7t9WFtAAwspOF0ktcN51Mqu7AtXxTbZzo3ZYys+B7OUwO8pzYE
 UddDn0JB52kYNy+tci79Q7P7b3bjfd4/SsrDQgT8bjmlpdF+jwFP8Ws5hetuCU5k/8MO
 RC+8/t/Ga4E+mCEkAct8nXBWH/Xx1RSxkR6nq+TU0wYEDNs6gQbRWNBLoCDZ8/LXoMP5
 r+BRjBZywfkTJiuk7xlqO2mAt6FXu8ZfPCeKJocottMlIvD7dWhybGogsUDXuWYEeAY2
 TddA==
X-Gm-Message-State: APjAAAUcyrPhAAgTEFk+2IC/0QgXLX0GRM6kUfzkhLstw16VEJqiCDwB
 LKjh1oeQrBnxlembBU5OawBDk7xK
X-Google-Smtp-Source: APXvYqy4PUhyKQJpdC+jlzJlTh+WHFjVtoAYy7izX7LOW/3KWTIytJgq1rgMfmpH1Eao2vU/5uDLMw==
X-Received: by 2002:a5d:4fd0:: with SMTP id h16mr3028993wrw.255.1575982929204; 
 Tue, 10 Dec 2019 05:02:09 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id s16sm3189142wrn.78.2019.12.10.05.02.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 10 Dec 2019 05:02:08 -0800 (PST)
Subject: Re: [PATCH 4/4] drm/scheduler: do not keep a copy of sched list
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Nirmoy Das <nirmoy.aiemd@gmail.com>, alexander.deucher@amd.com,
 kenny.ho@amd.com
References: <20191210125300.3800-1-nirmoy.das@amd.com>
 <20191210125300.3800-4-nirmoy.das@amd.com>
 <800c29bf-11dd-0ac9-32ad-ef3476f07643@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9346d307-7c71-39bc-e82a-df95c11fe6e1@gmail.com>
Date: Tue, 10 Dec 2019 14:02:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <800c29bf-11dd-0ac9-32ad-ef3476f07643@amd.com>
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
Cc: nirmoy.das@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMTIuMTkgdW0gMTQ6MDAgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFtIDEwLjEy
LjE5IHVtIDEzOjUzIHNjaHJpZWIgTmlybW95IERhczoKPj4gZW50aXR5IHNob3VsZCBub3Qga2Vl
cCBjb3B5IGFuZCBtYWludGFpbiBzY2hlZCBsaXN0IGZvcgo+PiBpdHNlbGYuCj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KPj4gLS0tCj4+IMKgIGRy
aXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgfCAxMCArLS0tLS0tLS0tCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgOSBkZWxldGlvbnMoLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfZW50aXR5LmMgCj4+
IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+PiBpbmRleCBmOWI2
Y2UyOWM1OGYuLmE1ZjcyOWY0MjFmOCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3Nj
aGVkdWxlci9zY2hlZF9lbnRpdHkuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVy
L3NjaGVkX2VudGl0eS5jCj4+IEBAIC02NywxNyArNjcsMTAgQEAgaW50IGRybV9zY2hlZF9lbnRp
dHlfaW5pdChzdHJ1Y3QgZHJtX3NjaGVkX2VudGl0eSAKPj4gKmVudGl0eSwKPj4gwqDCoMKgwqDC
oCBlbnRpdHktPmd1aWx0eSA9IGd1aWx0eTsKPj4gwqDCoMKgwqDCoCBlbnRpdHktPm51bV9zY2hl
ZF9saXN0ID0gbnVtX3NjaGVkX2xpc3Q7Cj4+IMKgwqDCoMKgwqAgZW50aXR5LT5wcmlvcml0eSA9
IHByaW9yaXR5Owo+PiAtwqDCoMKgIGVudGl0eS0+c2NoZWRfbGlzdCA9wqAga2NhbGxvYyhudW1f
c2NoZWRfbGlzdCwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzaXplb2Yoc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICopLCBHRlBfS0VSTkVMKTsKPj4gK8Kg
wqDCoCBlbnRpdHktPnNjaGVkX2xpc3QgPcKgIHNjaGVkX2xpc3Q7Cj4KPiBNYXliZSBtYWtlIHRo
aXMgIm51bV9zY2hlZF9saXN0ID4gMSA/IHNjaGVkX2xpc3QgOiBOVUxMIiB0byBhdm9pZCAKPiBh
Y2NpZGVudGFsbHkgZGVyZWZlcmVuY2luZyBhIHN0YWxlIHBvaW50ZXIgdG8gdGhlIHN0YWNrLgo+
Cj4+IMKgIC3CoMKgwqAgaWYoIWVudGl0eS0+c2NoZWRfbGlzdCkKPj4gLcKgwqDCoMKgwqDCoMKg
IHJldHVybiAtRU5PTUVNOwo+PiDCoCDCoMKgwqDCoMKgIGluaXRfY29tcGxldGlvbigmZW50aXR5
LT5lbnRpdHlfaWRsZSk7Cj4+IC0KPj4gLcKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgbnVtX3NjaGVk
X2xpc3Q7IGkrKykKPj4gLcKgwqDCoMKgwqDCoMKgIGVudGl0eS0+c2NoZWRfbGlzdFtpXSA9IHNj
aGVkX2xpc3RbaV07Cj4+IC0KPj4gwqDCoMKgwqDCoCBpZiAobnVtX3NjaGVkX2xpc3QpCj4KPiBU
aGF0IGNoZWNrIGNhbiBhY3R1YWxseSBiZSBkcm9wcGVkIGFzIHdlbGwuIFdlIHJldHVybiAtRUlO
VkFMIHdoZW4gdGhlIAo+IG51bV9zY2hlZF9saXN0IGlzIHplcm8uCj4KPiBSZWdhcmRzLAo+IENo
cmlzdGlhbi4KPgo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZW50aXR5LT5ycSA9IAo+PiAmZW50aXR5
LT5zY2hlZF9saXN0WzBdLT5zY2hlZF9ycVtlbnRpdHktPnByaW9yaXR5XTsKCkZvcmdvdCB0byBu
b3RlIHRoYXQgdGhpcyBzaG91bGQgdGhlbiBwcm9iYWJseSB1c2UgCiJzY2hlZF9saXN0WzBdLT5z
Y2hlZF9ycVtlbnRpdHktPnByaW9yaXR5XSIgZGlyZWN0bHkgd2hlbiB3ZSBjaGFuZ2UgdGhlIAph
c3NpZ25tZW50IGFib3ZlLgoKQ2hyaXN0aWFuLgoKPj4gwqAgQEAgLTMxMiw3ICszMDUsNiBAQCB2
b2lkIGRybV9zY2hlZF9lbnRpdHlfZmluaShzdHJ1Y3QgCj4+IGRybV9zY2hlZF9lbnRpdHkgKmVu
dGl0eSkKPj4gwqAgwqDCoMKgwqDCoCBkbWFfZmVuY2VfcHV0KGVudGl0eS0+bGFzdF9zY2hlZHVs
ZWQpOwo+PiDCoMKgwqDCoMKgIGVudGl0eS0+bGFzdF9zY2hlZHVsZWQgPSBOVUxMOwo+PiAtwqDC
oMKgIGtmcmVlKGVudGl0eS0+c2NoZWRfbGlzdCk7Cj4+IMKgIH0KPj4gwqAgRVhQT1JUX1NZTUJP
TChkcm1fc2NoZWRfZW50aXR5X2ZpbmkpOwo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
