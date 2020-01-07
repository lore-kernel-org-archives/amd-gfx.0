Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D537C33C8C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 12:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF3C207E0
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 12:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPrJ7IzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF3C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CAD6E05F;
	Tue,  7 Jan 2020 12:49:03 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9126E05F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 12:49:01 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z7so53703168wrl.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 04:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=hYTzTsTif0bH1RtEvhHoKlj/xozWKsBuZPlgJQLPPsU=;
 b=hPrJ7IzFRs2n45YVNjZHSzDthpqkfl3Sr7TPea1KX0wgfvJqAbMOoalP8IBULQVtke
 DftgBnPCSzNQIHfDE/MBGwywILaUVhJw5z7vNqMqGhkgDkigA7UGOzSz6trExNe7Eb6H
 5tmsBAafSv4pmO35RIyuRqlbDlsr/i+M8fqWyPnEdBWQQ5U0uhNMDuKngHCV0/lmW1/X
 oPZukBDY2wQ+oiZzWMY84uQnVL6gDjFk/gMsNpMzi4Yw6g9mPTxJAYIt6nRLE4tgX7lZ
 4vwXsxBfGwE5YE+52Axcx20ZxZUY3T/MxNwAHe/D/UdWdhycVvNYKcrLgdrpz1R6veJG
 WSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=hYTzTsTif0bH1RtEvhHoKlj/xozWKsBuZPlgJQLPPsU=;
 b=lW25hBdW+xxEIThmeuLmPwpCctMjoRAX8JjCHY20KmZExXvVUu/qhBM0n5G39GlNKN
 PJmXgaNA4m1X7LQ1Ttwyw4OhZtqtjj4ZgiC4RtsHb4KKk4DOWuc/5bzhpbX9RmpeT/nK
 2+wqSBJ8SVubw8r7vrmO1ezektj7AwNiIUOKL6fKAhPMih9XJ14ySbSIC64aTJcjKafa
 ubYqLkaPM0oG2dKr+UfsYfuwteK+3csqrN9drye05xNJ6OTvwv+dtv5E3w5VujcTKp5e
 7V8zD/JGUPvn9LnzGRhVS2UkZNHLbPjak8PgcR2GQf2QO1fG7hoEY1n4xVtQF62aNyn/
 Qvgg==
X-Gm-Message-State: APjAAAX6q/vM1IdEWUorDZcz8n73Qbfwc8hIvGceAev1ZBX71ZW/Bwpy
 kyc5sXqdvMyc160FHO7p0iGbUUmn
X-Google-Smtp-Source: APXvYqyiUCXBDkAgi2xixu0r9gvItC4t3yV7sofvJ2YCLdb+KIiC1hOTBvy7mEB4N9KRGOG7kt+Nhg==
X-Received: by 2002:a5d:4392:: with SMTP id
 i18mr114232206wrq.199.1578401340224; 
 Tue, 07 Jan 2020 04:49:00 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id a133sm26676420wme.29.2020.01.07.04.48.59
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 Jan 2020 04:48:59 -0800 (PST)
Subject: Re: [PATCH 10/12] drm/amdgpu: immedially invalidate PTEs
To: Felix Kuehling <felix.kuehling@amd.com>, Alex.Sierra@amd.com,
 Philip.Yang@amd.com, amd-gfx@lists.freedesktop.org
References: <20200106150335.1738-1-christian.koenig@amd.com>
 <20200106150335.1738-11-christian.koenig@amd.com>
 <9247b84d-fac5-4ae1-0050-ea0544f04db1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7cd3a3e3-e033-7f49-d59c-0ae4d19510b9@gmail.com>
Date: Tue, 7 Jan 2020 13:48:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9247b84d-fac5-4ae1-0050-ea0544f04db1@amd.com>
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

QW0gMDYuMDEuMjAgdW0gMjI6MDQgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBPbiAyMDIwLTAx
LTA2IDEwOjAzIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFdoZW4gYSBCTyBpcyBl
dmljdGVkIGltbWVkaWFsbHkgaW52YWxpZGF0ZSB0aGUgbWFwcGVkIFBURXMuCj4+Cj4+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4g
LS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMTcgKysr
KysrKysrKysrKysrKy0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92bS5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5j
Cj4+IGluZGV4IGEwM2NmYmU2NzBjNC4uNjg0NGJhNzQ2N2E2IDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+PiBAQCAtMjU2OSw2ICsyNTY5LDcgQEAgdm9pZCBh
bWRncHVfdm1fYm9faW52YWxpZGF0ZShzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvICpi
bywgYm9vbCBldmljdGVkKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV92bV9i
b19iYXNlICpib19iYXNlOwo+PiArwqDCoMKgIGludCByOwo+PiDCoCDCoMKgwqDCoMKgIC8qIHNo
YWRvdyBibyBkb2Vzbid0IGhhdmUgYm8gYmFzZSwgaXRzIHZhbGlkYXRpb24gbmVlZHMgaXRzIAo+
PiBwYXJlbnQgKi8KPj4gwqDCoMKgwqDCoCBpZiAoYm8tPnBhcmVudCAmJiBiby0+cGFyZW50LT5z
aGFkb3cgPT0gYm8pCj4+IEBAIC0yNTc2LDggKzI1NzcsMjIgQEAgdm9pZCBhbWRncHVfdm1fYm9f
aW52YWxpZGF0ZShzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+IMKgIMKgwqDCoMKg
wqAgZm9yIChib19iYXNlID0gYm8tPnZtX2JvOyBib19iYXNlOyBib19iYXNlID0gYm9fYmFzZS0+
bmV4dCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV92bSAqdm0gPSBib19i
YXNlLT52bTsKPj4gK8KgwqDCoMKgwqDCoMKgIHN0cnVjdCBkbWFfcmVzdiAqcmVzdiA9IHZtLT5y
b290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3Y7Cj4+ICsKPj4gK8KgwqDCoMKgwqDCoMKgIGlmIChi
by0+dGJvLnR5cGUgIT0gdHRtX2JvX3R5cGVfa2VybmVsKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHN0cnVjdCBhbWRncHVfYm9fdmEgKmJvX3ZhOwo+PiArCj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGJvX3ZhID0gY29udGFpbmVyX29mKGJvX2Jhc2UsIHN0cnVjdCBhbWRncHVfYm9f
dmEsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YmFzZSk7Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSBhbWRncHVfdm1fYm9fdXBkYXRl
KGFkZXYsIGJvX3ZhLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBiby0+dGJvLmJhc2UucmVzdiAhPSByZXN2KTsKPgo+IFdpbGwgdGhpcyB1cGRhdGUg
UFRFcyBmb3IgcGVyLVZNIEJPcyB3aXRob3V0IHZhbGlkYXRpbmcgdGhlbSBmaXJzdD8KClllcyBh
bmQgdGhhdCdzIGludGVudGlvbmFsLiBFc3NlbnRpYWxseSB0aGlzIHNob3VsZCBhbGxvd3MgbW92
aW5nIHBlci1WTSAKQk9zIGFyb3VuZCB3aGVuIHRoZXkgYXJlbid0IGZlbmNlZC4KCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICghcikgewo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGFtZGdwdV92bV9ib19pZGxlKGJvX2Jhc2UpOwo+Cj4gSXMgdGhpcyB0aGUgcmlnaHQg
c3RhdGU/IFRoZSBkZXNjcmlwdGlvbiBvZiBhbWRncHVfdm1fYm9faWRsZSBzYXlzIAo+IHRoYXQg
dGhpcyBpcyBmb3IgIlBEcy9QVHMgYW5kIHBlciBWTSBCT3MiLiBGb3IgcmVndWxhciBCT3MsIEkg
dGhpbmsgCj4gdGhpcyBzaG91bGQgY2FsbCBhbWRncHVfdm1fYm9fZG9uZS4KCkdvb2QgcG9pbnQs
IHRoYXQncyBpbmRlZWQgbm90IGNvcnJlY3QgZm9yIHBlci1WTSBCT3MuIExvb2tzIGxpa2UgSSBu
ZWVkIAp0byByZXdvcmsgdGhlIHdob2xlIHN0YXRlIGxvZ2ljLgoKVGhhbmtzLApDaHJpc3RpYW4u
Cgo+Cj4KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPgo+IFRo
aXMgc2tpcHMgYSBidW5jaCBvZiBzdGF0ZSBtYWNoaW5lIGxvZ2ljIGJlbG93LiBNYXliZSBzb21l
IG9mIHRoYXQgCj4gY291bGQgYmUgY2xlYW5lZCB1cC4KPgo+Cj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0KPj4gK8KgwqDCoMKgwqDCoMKgIH0KPj4gwqAgLcKgwqDCoMKgwqDCoMKgIGlmIChl
dmljdGVkICYmIGJvLT50Ym8uYmFzZS5yZXN2ID09IAo+PiB2bS0+cm9vdC5iYXNlLmJvLT50Ym8u
YmFzZS5yZXN2KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoZXZpY3RlZCAmJiBiby0+dGJvLmJh
c2UucmVzdiA9PSByZXN2KSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV92
bV9ib19ldmljdGVkKGJvX2Jhc2UpOwo+Cj4gSXQgd2lsbCBuZXZlciBnZXQgaGVyZSBmb3IgcGVy
LVZNIEJPcyBub3cgKGV4Y2VwdCBpZiBib191cGRhdGUgCj4gZmFpbGVkKS4gTm90IHN1cmUgaWYg
dGhhdCdzIGEgcHJvYmxlbS4KPgo+Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRp
bnVlOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoYm9fYmFzZS0+bW92ZWQpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYm9fYmFzZS0+bW92ZWQgPSB0cnVlOwo+Cj4gTWF5YmUgdGhlIHdob2xl
IFBUIGludmFsaWRhdGlvbiBzaG91bGQgYmUgYWZ0ZXIgdGhpcyB0byBhdm9pZCBtdWx0aXBsZSAK
PiBpbnZhbGlkYXRpb25zIG9mZiB0aGUgc2FtZSBCTz8KPgo+Cj4+Cj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChiby0+dGJvLnR5cGUgPT0gdHRtX2JvX3R5cGVfa2VybmVs
KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1k
Z3B1X3ZtX2JvX3JlbG9jYXRlZChib19iYXNlKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZWxzZSBpZiAoYm8tPnRiby5yZXN2ID09IHZtLT5yb290LmJhc2UuYm8tPnRiby5y
ZXN2KQo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
YW1kZ3B1X3ZtX2JvX21vdmVkKGJvX2Jhc2UpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBlbHNlCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBhbWRncHVfdm1fYm9faW52YWxpZGF0ZWQoYm9fYmFzZSk7Cj4KPiBJIGJlbGlldmUg
dGhlIGxhc3QgdHdvIGNhc2VzIGFyZSB1bnJlYWNoYWJsZSBub3cgKGV4Y2VwdCBpZiBib191cGRh
dGUgCj4gZmFpbGVkKS4KPgo+IFJlZ2FyZHMsCj4gwqAgRmVsaXgKPgo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
