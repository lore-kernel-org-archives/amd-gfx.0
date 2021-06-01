Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A73C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 07:02:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B78EE610C8
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 07:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78EE610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4676E030;
	Tue,  1 Jun 2021 07:02:06 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCB56E030
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 07:02:04 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id u24so6466461edy.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jun 2021 00:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=RgTEj4WUEH0RNmWdEOjYzq23a465YD+6NHqv2O/a9lc=;
 b=ITXZvhzUeW3s5wQlGZ8SGGdxOqxiqAmcoks1rfq+ish95F+NzEthW09G1tBIBfcLd2
 TWI24qxEUDK+DUAydB/DTFcRwO6BkzZo1bj9sl4/JK8sFwBUvr0IYLL42W6ZpmCHF6SK
 qGVpyNDuPbLTU6xzkrSMXGbccSO0G7gyg/V74D1mKG5SgOMqMYmfzg0AgUAKDOy1/I4l
 EmCvVfYSVRwbgu8FE/Z/pi6nGy0RCP4g3RH2lOFjInoKGp9pzsYWeSXxVGqbHQF6ViCP
 eMWznIybDqhLFibuvBF3hCHGS5YQ7zE+Kbd2U4EruGiOxdc4ed2kW/QsGnZI75i9eMku
 7I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=RgTEj4WUEH0RNmWdEOjYzq23a465YD+6NHqv2O/a9lc=;
 b=QdrtZkSR5y6A4CKC0RhiAOgoGeD6AlW5UoNXh7GX5ENWtz7OnPFRorZEKpBAPNN9Gd
 zLpxdVlgjzC2VtQGonBcD7eqP9SUWvGlMPW7aOn5GJagtXpWNMBxgDbuZZR2LK5qYTJX
 Ggarmb/yx4TZibD2k6T+05sdHNKMyLU+RgB6C2QdbChpzc7LARL3N9Bp/K0QBtZ4Bggt
 OZwVS/OLkcJZfML8nkKRhJCbZBNztzU240/JAF+Qh7ai53z2hUfikt3mQ9NVjfzEFjlX
 G/aEeFenLq3Av7+rf8ib/PZRTKVleSNwxSqiQXtyDu2TjjYOHaMJC84fSREeH6RF+hqw
 NrSQ==
X-Gm-Message-State: AOAM531EcAQbUfIcbrnKnZnjG8W+6f7f8fnax6tV7Z/JXviW78GIWeKj
 UtPoAug0edyzO2d+1mL4x6hPGiTKMMI=
X-Google-Smtp-Source: ABdhPJwAkgzwkbC8FMPvPzmkioQwl48cuRpz9iNarbrX+tnNeOHw2Z39OT+k+KwUt6TAxZc6LKgDcg==
X-Received: by 2002:a05:6402:254d:: with SMTP id
 l13mr30831328edb.281.1622530923466; 
 Tue, 01 Jun 2021 00:02:03 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:5ee0:b6d9:de45:97bd?
 ([2a02:908:1252:fb60:5ee0:b6d9:de45:97bd])
 by smtp.gmail.com with ESMTPSA id j22sm6956783ejt.11.2021.06.01.00.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 00:02:03 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Fix a bug on flag table_freed
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210601000625.551445-1-jinhuieric.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d80dce26-ddf9-ecee-501f-e3afc0595f4d@gmail.com>
Date: Tue, 1 Jun 2021 09:02:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210601000625.551445-1-jinhuieric.huang@amd.com>
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

CgpBbSAwMS4wNi4yMSB1bSAwMjowNiBzY2hyaWViIEVyaWMgSHVhbmc6Cj4gdGFibGVfZnJlZWQg
d2lsbCBiZSBhbHdheXMgdHJ1ZSB3aGVuIG1hcHBpbmcgYSBtZW1vcnkgd2l0aCBzaXplCj4gYmln
Z2VyIHRoYW4gMk1CLiBUaGUgcHJvYmxlbSBpcyBwYWdlIHRhYmxlJ3MgZW50cmllcyBhcmUgYWx3
YXlzCj4gZXhpc3RlZCwgYnV0IGV4aXN0aW5nIG1hcHBpbmcgZGVwZW5kcyBvbiBwYWdlIHRhbGJl
J3MgYm8sIHNvCj4gdXNpbmcgYSBjaGVjayBvZiBwYWdlIHRhYmxlJ3MgYm8gZXhpc3RlZCB3aWxs
IHJlc29sdmUgdGhlIGlzc3VlLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXJpYyBIdWFuZyA8amluaHVp
ZXJpYy5odWFuZ0BhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4gZm9yIHRoaXMgb25lLgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNyArKysrKy0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCA1MzljMTE3OTA2Y2MuLjJjMjBiYmE3ZGMxYSAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTE1ODIsOSArMTU4
MiwxMiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV91cGRhdGVfcHRlcyhzdHJ1Y3QgYW1kZ3B1X3Zt
X3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKPiAgIAkJCSAqIGNvbXBsZXRlbHkgY292ZXJlZCBieSB0
aGUgcmFuZ2UgYW5kIHNvIHBvdGVudGlhbGx5IHN0aWxsIGluIHVzZS4KPiAgIAkJCSAqLwo+ICAg
CQkJd2hpbGUgKGN1cnNvci5wZm4gPCBmcmFnX3N0YXJ0KSB7Cj4gLQkJCQlhbWRncHVfdm1fZnJl
ZV9wdHMoYWRldiwgcGFyYW1zLT52bSwgJmN1cnNvcik7Cj4gKwkJCQkvKiBNYWtlIHN1cmUgcHJl
dmlvdXMgbWFwcGluZyBpcyBmcmVlZCAqLwo+ICsJCQkJaWYgKGN1cnNvci5lbnRyeS0+YmFzZS5i
bykgewo+ICsJCQkJCXBhcmFtcy0+dGFibGVfZnJlZWQgPSB0cnVlOwo+ICsJCQkJCWFtZGdwdV92
bV9mcmVlX3B0cyhhZGV2LCBwYXJhbXMtPnZtLCAmY3Vyc29yKTsKPiArCQkJCX0KPiAgIAkJCQlh
bWRncHVfdm1fcHRfbmV4dChhZGV2LCAmY3Vyc29yKTsKPiAtCQkJCXBhcmFtcy0+dGFibGVfZnJl
ZWQgPSB0cnVlOwo+ICAgCQkJfQo+ICAgCj4gICAJCX0gZWxzZSBpZiAoZnJhZyA+PSBzaGlmdCkg
ewoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
