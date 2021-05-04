Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5FEC433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02DA610FA
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02DA610FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58FE688EBA;
	Tue,  4 May 2021 14:08:33 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1261588EBA
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 14:08:32 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id di13so10616424edb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 May 2021 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XJObAf06JpdzyNUABcSxbmizR5hrXOg62Ecu4G/mOf8=;
 b=AKWscsANlROcul/aR/iXQKALmnHKhnOaJ5RAD8U5YaWkOn4bA8ChdHVYqFJGFfkaMT
 HjQIVRu1v0BkdJBWvjfldy+g2rr2QiWSq++Dox/JLLse6V9U++dus2JuRa/DHQLiGq9u
 2+Erzfs6+d9FU3F6uJFGzuToPVnrO86iNb2ev87QKh+7emKgPuUGiLMfE68xUNrwwWoX
 z+MXbX1OFPqe78Z0RkhX/ZnGGsr6Jkkr+pIyIwVAlN2amigv410IR/BN8x0zrYdLkGxE
 qXE5wDcjuREgdUye3zOp4PIoPd2+Qufngch+FtU9aeJyj+FRo+NKp0s0qvz2SEvycn+C
 JPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XJObAf06JpdzyNUABcSxbmizR5hrXOg62Ecu4G/mOf8=;
 b=UVJYfkW+vkG1bucQl84cdUCpb9dJKrUbCTNJywgPpaRhjcHSTO9I/hLVdTppeaxzpo
 cMMqlvyC3nEO94/lxpiZrT8wy39R+cD4420/+bV841oJv1EqpyZrqH+iX38vza6bxeFx
 4DgAUakF6f/fkpJ154CNiUk3aEO57muEyl53TFOnRcTS+++9VHvaKl7IxAv0hscA8n7z
 +3byYSyu1cr2AMxX+q/5qJPsD2AfESy2em1Udl+cR1j3bqBEVKBbSzrGh8AOJbzb7GBK
 op/lI5evCuxhmCx2s0CZOVD+c9ftYl+BIiopKuvaqbL74SOIlkGbIYbO7C2AIqdkS+eF
 SIKg==
X-Gm-Message-State: AOAM531KaMosiIpYkHt+sTqppxyMDgG1iekm02PILUm343YQtZ3Xqxm+
 vW5Ag+H6wTlKspp89dhxdf8=
X-Google-Smtp-Source: ABdhPJyWhfWNJCFVgiCs7VKJ+S1OS3uii2Gy+Y2BtRoHHbCCRklc8e6UOT4FFIQ8T7t8x5N/r3ufcw==
X-Received: by 2002:a05:6402:2366:: with SMTP id
 a6mr26555161eda.10.1620137310762; 
 Tue, 04 May 2021 07:08:30 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:36d2:ff0f:67e9:929c?
 ([2a02:908:1252:fb60:36d2:ff0f:67e9:929c])
 by smtp.gmail.com with ESMTPSA id u24sm14060441edt.85.2021.05.04.07.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 May 2021 07:08:30 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: Add graphics cache rinse packet for sdma
 5.0
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210504140211.1703369-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <72bdad30-4e73-3f44-b81e-2a8aa16235bd@gmail.com>
Date: Tue, 4 May 2021 16:08:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210504140211.1703369-1-alexander.deucher@amd.com>
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDQuMDUuMjEgdW0gMTY6MDIgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gQWRkIGVtaXQgbWVt
IHN5bmMgY2FsbGJhY2sgZm9yIHNkbWFfdjVfMAo+Cj4gSW4gYW1kZ3B1IHN5bmMgb2JqZWN0IHRl
c3QsIHRocmVlIHRocmVhZHMgY3JlYXRlZCBqb2JzCj4gdG8gc2VuZCBHRlggSUIgYW5kIFNETUEg
SUIgaW4gc2VxdWVuY2UuIEFmdGVyIHRoZSBmaXJzdAo+IEdGWCB0aHJlYWQgam9pbmVkLCBzb21l
dGltZXMgdGhlIHRoaXJkIHRocmVhZCB3aWxsIHJldXNlCj4gdGhlIHNhbWUgcGh5c2ljYWwgcGFn
ZSB0byBzdG9yZSB0aGUgU0RNQSBJQi4gVGhlcmUgd2lsbAo+IGJlIGEgcmlzayB0aGF0IFNETUEg
d2lsbCByZWFkIEdGWCBJQiBpbiB0aGUgcHJldmlvdXMgcGh5c2ljYWwKPiBwYWdlLiBTbyBpdCdz
IGJldHRlciB0byBmbHVzaCB0aGUgY2FjaGUgYmVmb3JlIGNvbW1pdCBzZG1hIElCLgo+Cj4gUmV2
aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPiBTaWduZWQt
b2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpBY2tlZC1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jIHwgMjggKysrKysrKysrKysr
KysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwo+IGluZGV4IDkyMGZjNmQ0YTEyNy4u
ZDI5NGVmNmE2MjVhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Nk
bWFfdjVfMC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMK
PiBAQCAtNDM3LDYgKzQzNywzMyBAQCBzdGF0aWMgdm9pZCBzZG1hX3Y1XzBfcmluZ19lbWl0X2li
KHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywKPiAgIAlhbWRncHVfcmluZ193cml0ZShyaW5nLCB1
cHBlcl8zMl9iaXRzKGNzYV9tY19hZGRyKSk7Cj4gICB9Cj4gICAKPiArLyoqCj4gKyAqIHNkbWFf
djVfMF9yaW5nX2VtaXRfbWVtX3N5bmMgLSBmbHVzaCB0aGUgSUIgYnkgZ3JhcGhpY3MgY2FjaGUg
cmluc2UKPiArICoKPiArICogQHJpbmc6IGFtZGdwdSByaW5nIHBvaW50ZXIKPiArICogQGpvYjog
am9iIHRvIHJldHJpZXZlIHZtaWQgZnJvbQo+ICsgKiBAaWI6IElCIG9iamVjdCB0byBzY2hlZHVs
ZQo+ICsgKgo+ICsgKiBmbHVzaCB0aGUgSUIgYnkgZ3JhcGhpY3MgY2FjaGUgcmluc2UuCj4gKyAq
Lwo+ICtzdGF0aWMgdm9pZCBzZG1hX3Y1XzBfcmluZ19lbWl0X21lbV9zeW5jKHN0cnVjdCBhbWRn
cHVfcmluZyAqcmluZykKPiArewo+ICsgICAgdWludDMyX3QgZ2NyX2NudGwgPQo+ICsJCSAgICBT
RE1BX0dDUl9HTDJfSU5WIHwgU0RNQV9HQ1JfR0wyX1dCIHwgU0RNQV9HQ1JfR0xNX0lOViB8Cj4g
KwkJCVNETUFfR0NSX0dMMV9JTlYgfCBTRE1BX0dDUl9HTFZfSU5WIHwgU0RNQV9HQ1JfR0xLX0lO
ViB8Cj4gKwkJCVNETUFfR0NSX0dMSV9JTlYoMSk7Cj4gKwo+ICsJLyogZmx1c2ggZW50aXJlIGNh
Y2hlIEwwL0wxL0wyLCB0aGlzIGNhbiBiZSBvcHRpbWl6ZWQgYnkgcGVyZm9ybWFuY2UgcmVxdWly
ZW1lbnQgKi8KPiArCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIFNETUFfUEtUX0hFQURFUl9PUChT
RE1BX09QX0dDUl9SRVEpKTsKPiArCWFtZGdwdV9yaW5nX3dyaXRlKHJpbmcsIFNETUFfUEtUX0dD
Ul9SRVFfUEFZTE9BRDFfQkFTRV9WQV8zMV83KDApKTsKPiArCWFtZGdwdV9yaW5nX3dyaXRlKHJp
bmcsIFNETUFfUEtUX0dDUl9SRVFfUEFZTE9BRDJfR0NSX0NPTlRST0xfMTVfMChnY3JfY250bCkg
fAo+ICsJCQlTRE1BX1BLVF9HQ1JfUkVRX1BBWUxPQUQyX0JBU0VfVkFfNDdfMzIoMCkpOwo+ICsJ
YW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgU0RNQV9QS1RfR0NSX1JFUV9QQVlMT0FEM19MSU1JVF9W
QV8zMV83KDApIHwKPiArCQkJU0RNQV9QS1RfR0NSX1JFUV9QQVlMT0FEM19HQ1JfQ09OVFJPTF8x
OF8xNihnY3JfY250bCA+PiAxNikpOwo+ICsJYW1kZ3B1X3Jpbmdfd3JpdGUocmluZywgU0RNQV9Q
S1RfR0NSX1JFUV9QQVlMT0FENF9MSU1JVF9WQV80N18zMigwKSB8Cj4gKwkJCVNETUFfUEtUX0dD
Ul9SRVFfUEFZTE9BRDRfVk1JRCgwKSk7Cj4gK30KPiArCj4gICAvKioKPiAgICAqIHNkbWFfdjVf
MF9yaW5nX2VtaXRfaGRwX2ZsdXNoIC0gZW1pdCBhbiBoZHAgZmx1c2ggb24gdGhlIERNQSByaW5n
Cj4gICAgKgo+IEBAIC0xNjQzLDYgKzE2NzAsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdw
dV9yaW5nX2Z1bmNzIHNkbWFfdjVfMF9yaW5nX2Z1bmNzID0gewo+ICAgCQkxMCArIDEwICsgMTAs
IC8qIHNkbWFfdjVfMF9yaW5nX2VtaXRfZmVuY2UgeDMgZm9yIHVzZXIgZmVuY2UsIHZtIGZlbmNl
ICovCj4gICAJLmVtaXRfaWJfc2l6ZSA9IDUgKyA3ICsgNiwgLyogc2RtYV92NV8wX3JpbmdfZW1p
dF9pYiAqLwo+ICAgCS5lbWl0X2liID0gc2RtYV92NV8wX3JpbmdfZW1pdF9pYiwKPiArCS5lbWl0
X21lbV9zeW5jID0gc2RtYV92NV8wX3JpbmdfZW1pdF9tZW1fc3luYywKPiAgIAkuZW1pdF9mZW5j
ZSA9IHNkbWFfdjVfMF9yaW5nX2VtaXRfZmVuY2UsCj4gICAJLmVtaXRfcGlwZWxpbmVfc3luYyA9
IHNkbWFfdjVfMF9yaW5nX2VtaXRfcGlwZWxpbmVfc3luYywKPiAgIAkuZW1pdF92bV9mbHVzaCA9
IHNkbWFfdjVfMF9yaW5nX2VtaXRfdm1fZmx1c2gsCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
