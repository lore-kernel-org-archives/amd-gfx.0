Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7E9C2BAEE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 17:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB9720737
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 17:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moyllQt2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB9720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2772F6E9CE;
	Wed, 11 Mar 2020 17:58:04 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7633E6E9CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 17:58:02 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a141so3152368wme.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=W0ywpUpfKZRLgz9vAy974gX1YHAzJ+mcnxySIDxxDCw=;
 b=moyllQt2KvdtlY1Tfml/fMJu/jApYNbXvgYD7jGN45B6WhAS8oXPFdli5J6nxCDQWa
 7Dklbj23zeLPI/PZfuHTj6784Ov/vbrP2H1zx6UftIvOQrlsu1+Y8wbfPXGB+ZfMMRRD
 l0G4fHX2opi5jdmc7YRpqVr9bD0Q8A5qXvV70blc9P5cvMsMnr8o4ns8GXi7p3F2D/ql
 gxB2rx52mJU8fNWKo115MHWkIgZ9scWWqMv4uuClIDkmbQDa1y5XF3MrViUCJ7DfPNw0
 bC3PlmmnzTIdQBudplmZDQ0gWZbdoUqXZdKHJzoGMl15WGzVERT6mtRGqFtIGs52pDHj
 GORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=W0ywpUpfKZRLgz9vAy974gX1YHAzJ+mcnxySIDxxDCw=;
 b=RMi8Hlf5sRT7eypHkzow6iy3xJ1Stb+GsO3frfQbAdD1fKEw7zp+t8qWMoGt6FCZny
 c7NjnF9K32Yu3KXtxk+YwvOy/jswoB5euSB04n9ENyd6oQeiG+qy1PGdeARjMhRf0vXh
 vLSm6WjJgRnjDy9XAaDaQy07hMnQjfke5Ve7jaDCi1jr+WhmcmppN6Qlf0OByEo3XCjZ
 ZKySODHRlu72pWMueLgfD4rzJvDqFpWpCFT4euNoNqs1dP1WOk4k8oIWiRt0ucZvk0CH
 8ALmttkgIWiRRfh+UJsoHOiQxtSqlm0ce5xfCM7MFvHxXzBHLbSrMLevbUsLbjlRe5V3
 rIXg==
X-Gm-Message-State: ANhLgQ2YTnLvWYq9dDNsK8Z1d46RVeIffeL6nA2WMDNt9MYEe1xUZ6Nr
 ebqNGhVRX7ggTuww6GtwIsk=
X-Google-Smtp-Source: ADFU+vv1gPkYNmBRYyHVs0FtWDJbYLFX4V2c0icTq71hOc2Wyirsy34sc+hDCFZEXlNmSonRr7p9kw==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr4944401wmb.118.1583949481086; 
 Wed, 11 Mar 2020 10:58:01 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v13sm3100257wru.47.2020.03.11.10.57.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Mar 2020 10:58:00 -0700 (PDT)
Subject: Re: [RFC PATCH 1/2] drm/sched: implement drm_sched_entity_num_jobs
To: Nirmoy <nirmodas@amd.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, 
 Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200311171809.7115-1-nirmoy.das@amd.com>
 <98391772-ecca-035e-73ff-26a3d5c8286b@amd.com>
 <2c445cde-ce1c-f46e-25dc-22c11f8e9b59@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8b7dde8c-adaf-2aa3-16b9-c0f3e66aa755@gmail.com>
Date: Wed, 11 Mar 2020 18:57:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2c445cde-ce1c-f46e-25dc-22c11f8e9b59@amd.com>
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
Cc: Boyuan.Zhang@amd.com, nirmoy.das@amd.com, alexander.deucher@amd.com,
 James.Zhu@amd.com, Leo.Liu@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTEuMDMuMjAgdW0gMTg6NTggc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAzLzExLzIwIDY6MjMg
UE0sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+Pgo+PiBPbiAzLzExLzIwIDE6MTggUE0sIE5p
cm1veSBEYXMgd3JvdGU6Cj4+PiBJbXBsZW1lbnQgZHJtX3NjaGVkX2VudGl0eV9udW1fam9icygp
IHNvIHRoYXQgZHJtIGRyaXZlcnMgY2FuCj4+PiBxdWVyeSBudW1iZXIgb2Ygam9icyBpbiBhbiBl
bnRpdHkuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQu
Y29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0
eS5jIHwgMTUgKysrKysrKysrKysrKysrCj4+PiDCoCBpbmNsdWRlL2RybS9ncHVfc2NoZWR1bGVy
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArCj4+PiDCoCAyIGZpbGVzIGNoYW5n
ZWQsIDE2IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3NjaGVkdWxlci9zY2hlZF9lbnRpdHkuYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxl
ci9zY2hlZF9lbnRpdHkuYwo+Pj4gaW5kZXggOTBmZDljMzBhZTVhLi5kZmU4MjE2ZjJkNTIgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX2VudGl0eS5jCj4+PiBAQCAt
MTE5LDYgKzExOSwyMSBAQCBzdGF0aWMgYm9vbCBkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUoc3Ry
dWN0IAo+Pj4gZHJtX3NjaGVkX2VudGl0eSAqZW50aXR5KQo+Pj4gwqDCoMKgwqDCoCByZXR1cm4g
ZmFsc2U7Cj4+PiDCoCB9Cj4+PiDCoCArLyoqCj4+PiArICogZHJtX3NjaGVkX2VudGl0eV9udW1f
am9iIC0gR2V0IG51bWJlciBvZiBqb2JzIGluIHRoZSBlbnRpdHkKPgo+Cj4gdHlwbyBzL2RybV9z
Y2hlZF9lbnRpdHlfbnVtX2pvYi9kcm1fc2NoZWRfZW50aXR5X251bV9qb2JzCj4KPgo+Pj4gKyAq
Cj4+PiArICogQGVudGl0eTogc2NoZWR1bGVyIGVudGl0eQo+Pj4gKyAqCj4+PiArICogUmV0dXJu
cyBudW1iZXIgb2Ygam9icyBpbiB0aGUgZW50aXR5Cj4+PiArICovCj4+PiAraW50IGRybV9zY2hl
ZF9lbnRpdHlfbnVtX2pvYnMoc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKmVudGl0eSkKPj4+ICt7
Cj4+PiArwqDCoMKgIGlmIChkcm1fc2NoZWRfZW50aXR5X2lzX2lkbGUoZW50aXR5KSkKPj4+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4+ICsKPj4+ICvCoMKgwqAgcmV0dXJuIHNwc2NfcXVl
dWVfY291bnQoJmVudGl0eS0+am9iX3F1ZXVlKTsKPj4+ICt9Cj4+Cj4+Cj4+IFdoYXQgYWJvdXQg
dGhlIGpvYnMgd2hpY2ggYWxyZWFkeSBoYXZlIGJlZW4gZGVxdWV1ZWQgZnJvbSBqb2JfcXVldWUg
Cj4+IGFuZCBhcmUgaW4gcHJvZ3Jlc3MgaW4gdGhlIEhXIHJpbmcgYnV0IHlldCB0byBjb21wbGV0
ZSAtIGRvbid0IHRoZXkgCj4+IGNvdW50ID8KPgo+IEhpIEFuZHJleSwKPgo+IEkgYW0gdGhpbmtp
bmcgaW4gdGVybXMgb2Ygc29mdHdhcmUgc2lkZSBvZiB0aGUgY291bnRpbmcgYmVjYXVzZSBmb3Ig
YW4gCj4gZW50aXR5IG9uY2UgYSBqb2IgZGVxdWV1ZWQsIHRoYXQgam9iIGlzIGNvbXBsZXRlbHkg
bG9zdC4KPgo+IEkgbWlnaHQgYmUgd3JvbmcgaGVyZSB0aGF0J3Mgd2h5IHRhZ2dlZCBSRkMgOikK
Ck15IHF1ZXN0aW9uIGlzIHJhdGhlciB3aGF0IGRvIHdlIG5lZWQgdGhhdCBmb3IgaW4gdGhlIGZp
cnN0IHBsYWNlPwoKVGhhbmtzLApDaHJpc3RpYW4uCgo+Cj4KPiBSZWdhcmRzLAo+Cj4gTmlybW95
Cj4KPgo+Pgo+PiBBbmRyZXkKPj4KPj4KPj4KPj4+ICtFWFBPUlRfU1lNQk9MKGRybV9zY2hlZF9l
bnRpdHlfbnVtX2pvYnMpOwo+Pj4gwqAgLyoqCj4+PiDCoMKgICogZHJtX3NjaGVkX2VudGl0eV9p
c19yZWFkeSAtIENoZWNrIGlmIGVudGl0eSBpcyByZWFkeQo+Pj4gwqDCoCAqCj4+PiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9kcm0vZ3B1X3NjaGVkdWxlci5oIGIvaW5jbHVkZS9kcm0vZ3B1X3NjaGVk
dWxlci5oCj4+PiBpbmRleCBkODk3MjgzNmQyNDguLmI1Y2VmZjc1Y2JiZSAxMDA2NDQKPj4+IC0t
LSBhL2luY2x1ZGUvZHJtL2dwdV9zY2hlZHVsZXIuaAo+Pj4gKysrIGIvaW5jbHVkZS9kcm0vZ3B1
X3NjaGVkdWxlci5oCj4+PiBAQCAtMzQxLDUgKzM0MSw2IEBAIHZvaWQgZHJtX3NjaGVkX2ZlbmNl
X2ZpbmlzaGVkKHN0cnVjdCAKPj4+IGRybV9zY2hlZF9mZW5jZSAqZmVuY2UpOwo+Pj4gwqAgdW5z
aWduZWQgbG9uZyBkcm1fc2NoZWRfc3VzcGVuZF90aW1lb3V0KHN0cnVjdCBkcm1fZ3B1X3NjaGVk
dWxlciAKPj4+ICpzY2hlZCk7Cj4+PiDCoCB2b2lkIGRybV9zY2hlZF9yZXN1bWVfdGltZW91dChz
dHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyByZW1haW5pbmcpOwo+
Pj4gK2ludCBkcm1fc2NoZWRfZW50aXR5X251bV9qb2JzKHN0cnVjdCBkcm1fc2NoZWRfZW50aXR5
ICplbnRpdHkpOwo+Pj4gwqAgwqAgI2VuZGlmCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KPiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCj4gaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
