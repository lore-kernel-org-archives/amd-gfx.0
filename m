Return-Path: <SRS0=QpD2=6M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF603C83000
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 18:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5E0206A1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2020 18:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ehem+xEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5E0206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C34B6E8B8;
	Tue, 28 Apr 2020 18:02:42 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8124B6E8B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 18:02:41 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id x17so25020357wrt.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2020 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=+Pl/JuuwcHmos3ggsut5mcI8hgZjgFygnpMFHQDjnlw=;
 b=Ehem+xEjguJCAp5o/G97pvo02eZbE9828Aeoil8MjeF26Fhyy0Sn4m2asrpav2KEsY
 5CWVvM2SutRUAHB1gW6GTUIdTWWJfE1MWDkeFVsd+dotmhz791kN9DjqetwLXqKieJsq
 or63prYTS1Tog+mHiKPLCDUP3RKe9C/+vKmlLvweDL6T6eZKSOrxgdZI5hv0WIkgt31y
 CYGC20PL4VZE2S5yc/Bqi4Jjl4/2OWexpFm7cyPcI4n8hNg1Ah/VCxORAYUD4DQWkZHN
 jdSr/zYtOs4Ata/qyrxXeBLeHaAn8lIhwDyh/JYUVszTSyDGsXkXRKRsEqf7EZc6MHbw
 LITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=+Pl/JuuwcHmos3ggsut5mcI8hgZjgFygnpMFHQDjnlw=;
 b=maP5VQKlUjggytfb5i70/59wTy1WLzVDP9agjoeJKROwJ25Yy1CUVfQ8OXMN3Tpacu
 KiCHDSNTvCJrJBAv0uzUmYstd11BjGiTt1idYyHIayhuuNa/U04/OwdQjAHzIzNZD1ZT
 eFQJA0WKj2+Pb9Xdoxwfjr501g0c5lK+d/wzODCx3HmrYo9yJXOxstw/VbHDJItXIV76
 zvDdIeHK46scgBl8Cpf9BSca2+tLriol2IjpiRuFGRS8F1Cy9poriTlNuoKvtO1nWRL5
 wjsubbkYV7jKz3PSLnhmOIU4RDunsDShu8IKFW3vWkl/Jix+FegmRZUr/wBMmawk9AXP
 blow==
X-Gm-Message-State: AGi0Puajm9JJfcSoXWuqFvaFAdjSromenMxJqvTTT4S1qCY70wIedMM7
 duAVKEZaAGY1NODNAFEGiM0=
X-Google-Smtp-Source: APiQypIeaj7k1hLHP8HDIqf7g99ItmwULwOG3424/0mYDowqa/7BigUu5SgL8ZyEGcQXs59Rj+LyQA==
X-Received: by 2002:a5d:4246:: with SMTP id s6mr34828193wrr.421.1588096960186; 
 Tue, 28 Apr 2020 11:02:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id z22sm4176424wma.20.2020.04.28.11.02.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 28 Apr 2020 11:02:39 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: align driver version with upstream
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200428155952.545150-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <eddb48a3-47f2-19ff-880f-c39e16d402f2@gmail.com>
Date: Tue, 28 Apr 2020 20:02:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200428155952.545150-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDQuMjAgdW0gMTc6NTkgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gV2UgbWF5IG5vdCB1
cHN0cmVhbSB0aGUgTUVNX1NZTkMgaW50ZXJmYWNlLCBzbyBtb3ZlIHRoYXQKPiBhZnRlciB0aGUg
U0RNQSBMMiBmaXguCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFu
LmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kcnYuYyB8IDcgKysrLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2
LmMKPiBpbmRleCA3NmE2MTk4ZjViNmUuLjg5YzRlOWRkZTZiNiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiBAQCAtODUsMTIgKzg1LDExIEBACj4gICAgKiAt
IDMuMzQuMCAtIE5vbi1EQyBjYW4gZmxpcCBjb3JyZWN0bHkgYmV0d2VlbiBidWZmZXJzIHdpdGgg
ZGlmZmVyZW50IHBpdGNoZXMKPiAgICAqIC0gMy4zNS4wIC0gQWRkIGRybV9hbWRncHVfaW5mb19k
ZXZpY2U6OnRjY19kaXNhYmxlZF9tYXNrCj4gICAgKiAtIDMuMzYuMCAtIEFsbG93IHJlYWRpbmcg
bW9yZSBzdGF0dXMgcmVnaXN0ZXJzIG9uIHNpL2Npawo+IC0gKiAtIDMuMzcuMCAtIEFkZCBBTURH
UFVfSUJfRkxBR19FTUlUX01FTV9TWU5DCj4gLSAqIC0gMy4zOC4wIC0gTDIgaXMgaW52YWxpZGF0
ZWQgYmVmb3JlIFNETUEgSUJzLCBuZWVkZWQgZm9yIGNvcnJlY3RuZXNzCj4gLSAqIC0gMy4zOS4w
IC0gQU1ER1BVX0lCX0ZMQUdfRU1JVF9NRU1fU1lOQyBhbHNvIGFmZmVjdHMgY29tcHV0ZSBJQnMK
PiArICogLSAzLjM3LjAgLSBMMiBpcyBpbnZhbGlkYXRlZCBiZWZvcmUgU0RNQSBJQnMsIG5lZWRl
ZCBmb3IgY29ycmVjdG5lc3MKPiArICogLSAzLjM4LjAgLSBBZGQgQU1ER1BVX0lCX0ZMQUdfRU1J
VF9NRU1fU1lOQwo+ICAgICovCj4gICAjZGVmaW5lIEtNU19EUklWRVJfTUFKT1IJMwo+IC0jZGVm
aW5lIEtNU19EUklWRVJfTUlOT1IJMzkKPiArI2RlZmluZSBLTVNfRFJJVkVSX01JTk9SCTM4Cj4g
ICAjZGVmaW5lIEtNU19EUklWRVJfUEFUQ0hMRVZFTAkwCj4gICAKPiAgIGludCBhbWRncHVfdnJh
bV9saW1pdCA9IDA7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
