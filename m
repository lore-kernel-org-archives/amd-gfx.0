Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724EAC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 21:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF116186A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 21:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF116186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 678CD89AF3;
	Wed, 17 Feb 2021 21:37:11 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469AA89AB5;
 Wed, 17 Feb 2021 21:37:10 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id g5so21716228ejt.2;
 Wed, 17 Feb 2021 13:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=oKQ47CjJAcgbkd+0Nqdy9WauNiGjusZDvtgTidwkFc8=;
 b=nJHtNaunz3b6pqi3a22KycuzPnyb6ANUMUkySibOh7WQqk7NYJH7HVlue/9H7ug2L9
 Sv0w2MTnoBNKH/GpdqmrJ1waDYF76qgvz4FTeNifVXUCqHtuDm9yE2DkweWWBMU1gvEN
 CV3Q9nwjohWyoNMSEgDtbyh8jZxNny79doUKu6p/Q4b6En+//+8SQxSJYhL5Of27IT0e
 Dj2MHEsTBNpgQgvATZ53FpYinGd8wH/cmhJJ/Ftbh3pw4YF+NYvdA5CoXbuChvz3Z+uT
 8gH4rP4Y2be7XiDGKaVzOG6E0P4nodQ/qXDW9AV6yfhetHLBWPaNZCFrtk0WGH+bsioW
 Bb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=oKQ47CjJAcgbkd+0Nqdy9WauNiGjusZDvtgTidwkFc8=;
 b=DihTLDy+CQcIH64/fYGvRVAUjZc4Kkzm23yoywC+6bQtfX365kR3W/9TVuQIf3ICuM
 woEwToVRPHbrH5yVPhj6ttlC0OGBKmAy39+bG9DtpIMBwqFbRnIGXTFkQPic4TYm6MFk
 EdmVpQv0HAbNDuHB5EveCQpVrFZPzFDS5SsTzXwOM0sDTD893GmpGr2Vu9t1VEKgi1nv
 djyOtcTL5VQK+6NKK8HX6wAlfPIYAaMotwZmXwAoZ5ybFC490F9/qtAD2gYIOSDgiwq8
 bMK/uuKn4k/EfLa3OZWHWirT+gD/1vURsu6+i5cTrmnbrj2uMHGPfT/yHTmZNo49qvyl
 OGoA==
X-Gm-Message-State: AOAM5320K1tpPAtiYjwE0A1Bv2VIPR+fK2Xn8QfX+TjXCGL78eO6ZriP
 dSMcJ5yNKIgnT/Ua07vG3NwPNS7xk6kkEw==
X-Google-Smtp-Source: ABdhPJzox7/MFEjzyIRT+qZN9Pz8HdKCnOExz/7q3T4Nvtqlu6pnJMlrdEPAaHwgNAQfpyupb22H0w==
X-Received: by 2002:a17:906:af63:: with SMTP id
 os3mr916642ejb.69.1613597828947; 
 Wed, 17 Feb 2021 13:37:08 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:a062:ccbc:1dde:867b?
 ([2a02:908:1252:fb60:a062:ccbc:1dde:867b])
 by smtp.gmail.com with ESMTPSA id h4sm1725347edv.80.2021.02.17.13.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Feb 2021 13:37:08 -0800 (PST)
Subject: Re: [PATCH] drm/scheduler: Fix hang when sched_entity released
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <1613495262-22605-1-git-send-email-andrey.grodzovsky@amd.com>
 <5d8f4e4f-fa2f-037b-d288-b4286e23e77a@gmail.com>
 <ddd98d12-4675-b861-f03c-6b87a34713a8@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7605d972-41e4-f9f7-7905-5f69a1574e3d@gmail.com>
Date: Wed, 17 Feb 2021 22:37:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ddd98d12-4675-b861-f03c-6b87a34713a8@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpBbSAxNy4wMi4yMSB1bSAyMjozNiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Cj4gT24g
Mi8xNy8yMSA0OjMyIFBNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAxNi4wMi4yMSB1
bSAxODowNyBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4gUHJvYmxlbTogSWYgc2NoZWR1
bGVyIGlzIGFscmVhZHkgc3RvcHBlZCBieSB0aGUgdGltZSBzY2hlZF9lbnRpdHkKPj4+IGlzIHJl
bGVhc2VkIGFuZCBlbnRpdHkncyBqb2JfcXVldWUgbm90IGVtcHR5IEkgZW5jb3VudHJlZAo+Pj4g
YSBoYW5nIGluIGRybV9zY2hlZF9lbnRpdHlfZmx1c2guIFRoaXMgaXMgYmVjYXVzZSAKPj4+IGRy
bV9zY2hlZF9lbnRpdHlfaXNfaWRsZQo+Pj4gbmV2ZXIgYmVjb21lcyBmYWxzZS4KPj4+Cj4+PiBG
aXg6IEluIGRybV9zY2hlZF9maW5pIGRldGFjaCBhbGwgc2NoZWRfZW50aXRpZXMgZnJvbSB0aGUK
Pj4+IHNjaGVkdWxlcidzIHJ1biBxdWV1ZXMuIFRoaXMgd2lsbCBzYXRpc2Z5IGRybV9zY2hlZF9l
bnRpdHlfaXNfaWRsZS4KPj4+IEFsc28gd2FrZXVwIGFsbCB0aG9zZSBwcm9jZXNzZXMgc3R1Y2sg
aW4gc2NoZWRfZW50aXR5IGZsdXNoaW5nCj4+PiBhcyB0aGUgc2NoZWR1bGVyIG1haW4gdGhyZWFk
IHdoaWNoIHdha2VzIHRoZW0gdXAgaXMgc3RvcHBlZCBieSBub3cuCj4+Pgo+Pj4gU2lnbmVkLW9m
Zi1ieTogQW5kcmV5IEdyb2R6b3Zza3kgPGFuZHJleS5ncm9kem92c2t5QGFtZC5jb20+Cj4+PiAt
LS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIHwgMzEgCj4+
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
MzEgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2No
ZWR1bGVyL3NjaGVkX21haW4uYyAKPj4+IGIvZHJpdmVycy9ncHUvZHJtL3NjaGVkdWxlci9zY2hl
ZF9tYWluLmMKPj4+IGluZGV4IDkwOGIwYjUuLjExYWJmNWQgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3NjaGVkdWxlci9zY2hlZF9tYWluLmMKPj4+IEBAIC04OTcsOSArODk3LDQwIEBAIEVYUE9S
VF9TWU1CT0woZHJtX3NjaGVkX2luaXQpOwo+Pj4gwqDCoCAqLwo+Pj4gwqAgdm9pZCBkcm1fc2No
ZWRfZmluaShzdHJ1Y3QgZHJtX2dwdV9zY2hlZHVsZXIgKnNjaGVkKQo+Pj4gwqAgewo+Pj4gK8Kg
wqDCoCBpbnQgaTsKPj4+ICvCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9lbnRpdHkgKnNfZW50aXR5
Owo+Pj4gwqDCoMKgwqDCoCBpZiAoc2NoZWQtPnRocmVhZCkKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBrdGhyZWFkX3N0b3Aoc2NoZWQtPnRocmVhZCk7Cj4+PiDCoCArwqDCoMKgIC8qIERldGFjaCBh
bGwgc2NoZWRfZW50aXRlcyBmcm9tIHRoaXMgc2NoZWR1bGVyIG9uY2UgaXQncyAKPj4+IHN0b3Bw
ZWQgKi8KPj4+ICvCoMKgwqAgZm9yIChpID0gRFJNX1NDSEVEX1BSSU9SSVRZX0NPVU5UIC0gMTsg
aSA+PSAKPj4+IERSTV9TQ0hFRF9QUklPUklUWV9NSU47IGktLSkgewo+Pj4gK8KgwqDCoMKgwqDC
oMKgIHN0cnVjdCBkcm1fc2NoZWRfcnEgKnJxID0gJnNjaGVkLT5zY2hlZF9ycVtpXTsKPj4+ICsK
Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIXJxKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
Y29udGludWU7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqAgLyogTG9vcCB0aGlzIHdheSBiZWNh
dXNlIHJxLT5sb2NrIGlzIHRha2VuIGluIAo+Pj4gZHJtX3NjaGVkX3JxX3JlbW92ZV9lbnRpdHkg
Ki8KPj4+ICvCoMKgwqDCoMKgwqDCoCBzcGluX2xvY2soJnJxLT5sb2NrKTsKPj4+ICvCoMKgwqDC
oMKgwqDCoCB3aGlsZSAoKHNfZW50aXR5ID0gbGlzdF9maXJzdF9lbnRyeV9vcl9udWxsKCZycS0+
ZW50aXRpZXMsCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRybV9zY2hlZF9lbnRpdHksCj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bGlzdCkpKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzcGluX3VubG9jaygmcnEtPmxv
Y2spOwo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX3NjaGVkX3JxX3JlbW92ZV9lbnRp
dHkocnEsIHNfZW50aXR5KTsKPj4+ICsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIE1h
cmsgYXMgc3RvcHBlZCB0byByZWplY3QgYWRkaW5nIHRvIGFueSBuZXcgcnEgKi8KPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmc19lbnRpdHktPnJxX2xvY2spOwo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgc19lbnRpdHktPnN0b3BwZWQgPSB0cnVlOwo+Pgo+PiBXaHkg
bm90IG1hcmtpbmcgaXQgYXMgc3RvcHBlZCBhbmQgdGhlbiByZW1vdmluZyBpdD8KPj4KPj4gUmVn
YXJkcywKPj4gQ2hyaXN0aWFuLgo+Cj4KPiBZb3UgbWVhbiBqdXN0IHJldmVyc2UgdGhlIG9yZGVy
IG9mIG9wZXJhdGlvbnMgaGVyZSB0byBwcmV2ZW50IGEgcmFjZSAKPiB3aGVyZSBzb21lb25lIGFk
ZGluZyBpdCBhZ2FpbiB0byBycSBiZWZvcmUgbWFya2luZyBpdCBhcyBzdG9wcGVkID8KCkV4YWN0
bHkgdGhhdCwgeWVhaC4KCkNocmlzdGlhbi4KCj4KPiBBbmRyZXkKPgo+Cj4+Cj4+PiArIHNwaW5f
dW5sb2NrKCZzX2VudGl0eS0+cnFfbG9jayk7Cj4+PiArCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBzcGluX2xvY2soJnJxLT5sb2NrKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+PiArwqDC
oMKgwqDCoMKgwqAgc3Bpbl91bmxvY2soJnJxLT5sb2NrKTsKPj4+ICsKPj4+ICvCoMKgwqAgfQo+
Pj4gKwo+Pj4gK8KgwqDCoCAvKiBXYWtldXAgZXZlcnlvbmUgc3R1Y2sgaW4gZHJtX3NjaGVkX2Vu
dGl0eV9mbHVzaCBmb3IgdGhpcyAKPj4+IHNjaGVkdWxlciAqLwo+Pj4gK8KgwqDCoCB3YWtlX3Vw
X2FsbCgmc2NoZWQtPmpvYl9zY2hlZHVsZWQpOwo+Pj4gKwo+Pj4gwqDCoMKgwqDCoCAvKiBDb25m
aXJtIG5vIHdvcmsgbGVmdCBiZWhpbmQgYWNjZXNzaW5nIGRldmljZSBzdHJ1Y3R1cmVzICovCj4+
PiDCoMKgwqDCoMKgIGNhbmNlbF9kZWxheWVkX3dvcmtfc3luYygmc2NoZWQtPndvcmtfdGRyKTsK
Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
