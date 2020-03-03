Return-Path: <SRS0=6yRT=4U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8073C3F2C6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 15:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63D720842
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2020 15:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNV2HJFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63D720842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80ECA6E44F;
	Tue,  3 Mar 2020 15:14:37 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA88D6E44F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Mar 2020 15:14:35 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a5so3672579wmb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2020 07:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=VUSXQBaPom6hA/fObdQ6xBQS5hwbhO6gO1718ECi2Kc=;
 b=bNV2HJFiyw+WNB9opac63oKCUS6c3ON6Jo0EVz/N6gpC7/xiPYFVceJqMaKio6cH+d
 85SDylkyWas1a2cY53UGIKByJ50pemGgTWkEDtbtJ7WBqx9O/+RcW1etL55hoU09zb2J
 PwxiCJLDMsmWA3Uw5dZNLf6Ta5oDomZzWdNVyzIxOqegWjuGaureGRmF3iju4LW+z63G
 7biyTdMIo5uY6ji1LE3NBCmZ2DKJCRWMUgZkaUFiuLAtvf03d63bpJIA0owKzP/3GWQq
 ApdttL2ylxgFcQE+p7afcUbiTz9Rzfs+d5gjGMPKBgEYb5S6bWr3I47rIsB/yqTPJFF1
 qwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=VUSXQBaPom6hA/fObdQ6xBQS5hwbhO6gO1718ECi2Kc=;
 b=R3pjRhcpPiUEUdXBH9hp1uZQ3oQkFCFfEsM8B3U5RA/rxlDcjjZo/a2PGr/KqpN9HN
 kzYK2pyHeyq70OpJ8kpWmyi8E5VDQ11GsYXr9mITrHp0brw5PSoEJiSP6uoURusGSMfd
 dNQZTQAO2jh1r684H6dMEKBAWHZESCHAGn6PlelVcah2/nXPc+oEXtm6FP8uP9BiEGJC
 Ai7KHRm0FZvcfEBTlenDKDHkzUx1FQCnkwHvy+hrDlukt+KHSw1Jc0BBEsZW/6RbWiQr
 o4L5jFQubdsSY+/aX1ze0z19EqkbglGNQkxtJHRNqkE8nECJZUpRwKjYmRAX/bzGNWBh
 GqyQ==
X-Gm-Message-State: ANhLgQ08hANu9P72mKjLnY30Usf+aCA1vaBRRs/QoemYAHqk800ulboX
 ICt7n7hWPsBCRQHOvaZySHI=
X-Google-Smtp-Source: ADFU+vu0Jv0A3qlubi+unfvNtBIx/NWyhm3dWUq1f4Mv+6olHPjd+9l60IIT94ZDvtHV13oRP9OvPg==
X-Received: by 2002:a7b:c3ce:: with SMTP id t14mr4707078wmj.92.1583248474443; 
 Tue, 03 Mar 2020 07:14:34 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f3sm3681947wrs.26.2020.03.03.07.14.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Mar 2020 07:14:33 -0800 (PST)
Subject: Re: [PATCH v6 1/1] drm/amdgpu: set compute queue priority at mqd_init
To: Nirmoy <nirmodas@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200303125039.53141-1-nirmoy.das@amd.com>
 <99ff4cb5-3d6a-c14c-20c6-553d2b22df50@amd.com>
 <478f74f6-db21-0e52-9b19-e968d2fa6924@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b866db7d-f084-158b-c891-32221109b839@gmail.com>
Date: Tue, 3 Mar 2020 16:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <478f74f6-db21-0e52-9b19-e968d2fa6924@amd.com>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDMuMDMuMjAgdW0gMTU6Mjkgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAzLzMvMjAgMzowMyBQ
TSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDMuMDMuMjAgdW0gMTM6NTAgc2Nocmll
YiBOaXJtb3kgRGFzOgo+Pj4gW1NOSVBdCj4+PiDCoCBzdHJ1Y3QgYW1kZ3B1X21lYyB7Cj4+PiDC
oMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfYm/CoMKgwqAgKmhwZF9lb3Bfb2JqOwo+Pj4gwqDCoMKg
wqDCoCB1NjTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhwZF9lb3BfZ3B1X2FkZHI7Cj4+PiBAQCAt
MjgwLDggKzI5MCw5IEBAIHN0cnVjdCBhbWRncHVfZ2Z4IHsKPj4+IMKgwqDCoMKgwqAgdWludDMy
X3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9nZnhfc2NoZWQ7Cj4+PiDCoMKgwqDCoMKgIHVu
c2lnbmVkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudW1fZ2Z4X3JpbmdzOwo+Pj4gwqDCoMKgwqDC
oCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgY29tcHV0ZV9yaW5nW0FNREdQVV9NQVhfQ09NUFVURV9SSU5H
U107Cj4+PiArwqDCoMKgIHN0cnVjdCBkcm1fZ3B1X3NjaGVkdWxlciAKPj4+ICoqY29tcHV0ZV9w
cmlvX3NjaGVkW0FNREdQVV9HRlhfUElQRV9QUklPX01BWF07Cj4+PiDCoMKgwqDCoMKgIHN0cnVj
dCBkcm1fZ3B1X3NjaGVkdWxlciAKPj4+ICpjb21wdXRlX3NjaGVkW0FNREdQVV9NQVhfQ09NUFVU
RV9SSU5HU107Cj4+PiAtwqDCoMKgIHVpbnQzMl90wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudW1f
Y29tcHV0ZV9zY2hlZDsKPj4+ICvCoMKgwqAgdWludDMyX3QgbnVtX2NvbXB1dGVfc2NoZWRbQU1E
R1BVX0dGWF9QSVBFX1BSSU9fTUFYXTsKPj4+IMKgwqDCoMKgwqAgdW5zaWduZWTCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG51bV9jb21wdXRlX3JpbmdzOwo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1k
Z3B1X2lycV9zcmPCoMKgwqDCoMKgwqDCoCBlb3BfaXJxOwo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3Qg
YW1kZ3B1X2lycV9zcmPCoMKgwqDCoMKgwqDCoCBwcml2X3JlZ19pcnE7Cj4+Cj4+IFdlbGwgbXkg
cXVlc3Rpb24gaXMgd2h5IHdlIHdlIG5lZWQgY29tcHV0ZV9wcmlvX3NjaGVkIGhlcmU/Cj4KPiBU
aGlzIG9uZSBpcyBzbyB0aGF0IEkgY2FuIGxldmVyYWdlIHNpbmdsZSBzY2hlZCBhcnJheSAKPiBj
b21wdXRlX3NjaGVkW0FNREdQVV9NQVhfQ09NUFVURV9SSU5HU10KPgo+IHRvIHN0b3JlIGJvdGgg
cHJpb3JpdHnCoCBzY2hlZCBsaXN0wqAgaW5zdGVhZCBvZgo+Cj4gc3RydWN0IGRybV9ncHVfc2No
ZWR1bGVyIAo+ICpjb21wdXRlX3NjaGVkW0FNREdQVV9HRlhfUElQRV9QUklPX01BWF1bQU1ER1BV
X01BWF9DT01QVVRFX1JJTkdTXTsKPgo+IEkgZ3Vlc3MgdGhpcyBtYWtlIGN0eCBjb2RlIHVubmVj
ZXNzYXJpbHkgY29tcGxleC4KCldlbGwsIGl0IHdvdWxkIGJlIGdvb2QgaWYgdGhlIGN0eCBjb2Rl
IGRpZG4ndCBuZWVkIHRvIGZpbGwgaW4gCmNvbXB1dGVfc2NoZWQgaW4gdGhlIGZpcnN0IHBsYWNl
LgoKRS5nLiB0aGF0IHRoZSBoYXJkd2FyZSBiYWNrZW5kcyBwcm92aWRlIHRvIHRoZSBjdHggaGFu
ZGxpbmcgd2hpY2ggCnNjaGVkdWxlcnMgdG8gdXNlIGZvciBhIHNwZWNpZmljIHVzZSBjYXNlLgoK
Pj4gQ2FuJ3Qgd2UganVzdCBkZXNpZ24gdGhhdCBhczoKPj4gc3RydWN0IGRybV9ncHVfc2NoZWR1
bGVyIAo+PiAqY29tcHV0ZV9zY2hlZFtBTURHUFVfR0ZYX1BJUEVfUFJJT19NQVhdW0FNREdQVV9N
QVhfSElfQ09NUFVURV9SSU5HU107Cj4+IHVpbnQzMl90IG51bV9jb21wdXRlX3NjaGVkW0FNREdQ
VV9HRlhfUElQRV9QUklPX01BWF07Cj4gV2hhdCBzaG91bGQgYmUgdGhlIHZhbHVlIG9mIEFNREdQ
VV9NQVhfSElfQ09NUFVURV9SSU5HUyA/Cj4+Cj4+IEkgbWVhbiB0aGUgZHJtX2dwdV9zY2hlZHVs
ZXIgKiBhcnJheSBkb2Vzbid0IG5lZWRzIHRvIGJlIGNvbnN0cnVjdGVkIAo+PiBieSB0aGUgY29u
dGV4dCBjb2RlIGluIHRoZSBmaXJzdCBwbGFjZS4KPiBEbyB5b3UgbWVhbiBhbWRncHVfY3R4X2lu
aXRfc2NoZWQoKSBzaG91bGQgYmVsb25nIHRvIHNvbWV3aGVyZSBlbHNlIAo+IG1heSBiZSBpbiBh
bWRncHVfcmluZy5jID8KClRoYXQncyBvbmUgcG9zc2liaWxpdHksIHllcy4gT24gdGhlIG90aGVy
IGhhbmQgZmVlbCBmcmVlIHRvIGdvIGFoZWFkIAp3aXRoIHRoZSBib29sZWFuIGZvciBub3cuCgpU
aGlzIHNlZW1zIHRvIGJlIGEgdG8gY29tcGxleCBhbmQgdG8gd2lkZSBjbGVhbnVwIHRoYXQgd2Ug
c2hvdWxkIGRvIGl0IAphcyBwYXJ0IG9mIHRoaXMgcGF0Y2ggc2V0LgoKUmVnYXJkcywKQ2hyaXN0
aWFuLgoKPj4KPj4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8KPj4KPj4gUmVnYXJkcywKPj4g
Q2hyaXN0aWFuLgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
