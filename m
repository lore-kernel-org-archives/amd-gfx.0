Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF9C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35AAF611ED
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 19:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AAF611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCAB6E231;
	Mon, 17 May 2021 19:54:56 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E956E231;
 Mon, 17 May 2021 19:54:55 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id s6so8302570edu.10;
 Mon, 17 May 2021 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=pn6HLbkhe5VCCVD8p9BJTvIle8DzSLJAN/Z44NE5Q+g=;
 b=apCiEthUVlP2NlT+C8Te9m9pRQ2UgK4Lz295b27m4exzjTU36lXw6MuTJ+P9r1vhty
 wfWBo7Db1LxxhRTbgSXIrW4veo4yEouJUhPCyIwnJn0HwL8zZYHL/bEIMUkUXw0pmP/t
 LQLUsxLLYMQZuMgOrzBa/LjgLj9yg7h5r2msGWnvpTfR/hUCRZavAekoRnNBIuWpYBE2
 rc9MEuJ9z3U8aEbVEhAWjrbF3so4M7eMpJxMG+EeGN5HXOmVOOQifQdy/KWvm29SpcfY
 7CAgOCPb8TiTkilzFnJPIk0PvZnAgWnh2f+StKbt4RW3NykdmU1h2MFUjE9auENdGv8X
 RG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=pn6HLbkhe5VCCVD8p9BJTvIle8DzSLJAN/Z44NE5Q+g=;
 b=VrJ1j7IWQG7CUwV6s7rNXp1m6XwX62Ya9Nylmy34ygvT/B2iLBtttc9ChwWXSWP0Z4
 k/GTr4Np/d8FTcKgGDWucyGcY6l59zhCoE7lFtZ1lkVJPBIwRgj1As3K+Z/HOWop9GNI
 rWlRhrMQajFTnkr55uTgHuWwup4Wl7eI0dzowfaYNiQIn500w7C0apRnJveK4I8cb9Lv
 mtzU2WHp/ljCPZrgFj2s+ApyqT6X9CTij64S3rkRaupUV4TT+AdO2Ojy+IFjdsxqq9lt
 wcdQXg8I3tUY3xNCofcEKkqPKP965ojKlrHfJRGDgwfwTLLhCGR83SCRxtDi/mKHYOwC
 qfCw==
X-Gm-Message-State: AOAM530XW1XpRrS36uW0cZLNCkj3YFYpZLzZm7Ww1deYaW+/16X3QrPE
 smE/9o4TJp9Qy7zEz8MriB0=
X-Google-Smtp-Source: ABdhPJwEUvHkx4T4Q0SBXMBXCMLzw48OpqBIGVTD30mquW99ltdMw2k1zLH76+AGg8ZzkYSyWkWjbA==
X-Received: by 2002:a05:6402:19a:: with SMTP id
 r26mr2090474edv.44.1621281294033; 
 Mon, 17 May 2021 12:54:54 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:bd86:58d9:7c79:a095?
 ([2a02:908:1252:fb60:bd86:58d9:7c79:a095])
 by smtp.gmail.com with ESMTPSA id i19sm282060eds.65.2021.05.17.12.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 May 2021 12:54:53 -0700 (PDT)
Subject: Re: [PATCH v7 12/16] drm/amdgpu: Fix hang on device removal.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-pci@vger.kernel.org, daniel.vetter@ffwll.ch, Harry.Wentland@amd.com
References: <20210512142648.666476-1-andrey.grodzovsky@amd.com>
 <20210512142648.666476-13-andrey.grodzovsky@amd.com>
 <0e13e0fb-5cf8-30fa-6ed8-a0648f8fe50b@amd.com>
 <a589044b-8dac-e573-e864-4093e24574a3@amd.com>
 <356d03bf-e221-86b1-f133-83def9d956bd@gmail.com>
 <8997d1b0-8f7a-e8dd-fabe-212fd181e24a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <12f790fa-836f-c323-b8c5-dc565ee39a99@gmail.com>
Date: Mon, 17 May 2021 21:54:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8997d1b0-8f7a-e8dd-fabe-212fd181e24a@amd.com>
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
Cc: Alexander.Deucher@amd.com, gregkh@linuxfoundation.org, ppaalanen@gmail.com,
 helgaas@kernel.org, Felix.Kuehling@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T2ssIHRoZW4gcHV0dGluZyB0aGF0IG9uIG15IFRPRE8gbGlzdCBmb3IgdG9tb3Jyb3cuCgpJJ3Zl
IGFscmVhZHkgZm91bmQgYSBwcm9ibGVtIHdpdGggaG93IHdlIGZpbmlzaCBvZiBmZW5jZXMsIGdv
aW5nIHRvIAp3cml0ZSBtb3JlIG9uIHRoaXMgdG9tb3Jyb3cuCgpDaHJpc3RpYW4uCgpBbSAxNy4w
NS4yMSB1bSAyMTo0NiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+IFllcCwgeW91IGNhbiB0
YWtlIGEgbG9vay4KPgo+IEFuZHJleQo+Cj4gT24gMjAyMS0wNS0xNyAzOjM5IHAubS4sIENocmlz
dGlhbiBLw7ZuaWcgd3JvdGU6Cj4+IFlvdSBuZWVkIHRvIG5vdGUgd2hvIHlvdSBhcmUgcGluZ2lu
ZyBoZXJlLgo+Pgo+PiBJJ20gc3RpbGwgYXNzdW1pbmcgeW91IHdhaXQgZm9yIGZlZWRiYWNrIGZy
b20gRGFuaWVsLiBPciBzaG91bGQgSSAKPj4gdGFrZSBhIGxvb2s/Cj4+Cj4+IENocmlzdGlhbi4K
Pj4KPj4gQW0gMTcuMDUuMjEgdW0gMTY6NDAgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+
IFBpbmcKPj4+Cj4+PiBBbmRyZXkKPj4+Cj4+PiBPbiAyMDIxLTA1LTE0IDEwOjQyIGEubS4sIEFu
ZHJleSBHcm9kem92c2t5IHdyb3RlOgo+Pj4+IFBpbmcKPj4+Pgo+Pj4+IEFuZHJleQo+Pj4+Cj4+
Pj4gT24gMjAyMS0wNS0xMiAxMDoyNiBhLm0uLCBBbmRyZXkgR3JvZHpvdnNreSB3cm90ZToKPj4+
Pj4gSWYgcmVtb3Zpbmcgd2hpbGUgY29tbWFuZHMgaW4gZmxpZ2h0IHlvdSBjYW5ub3Qgd2FpdCB0
byBmbHVzaCB0aGUKPj4+Pj4gSFcgZmVuY2VzIG9uIGEgcmluZyBzaW5jZSB0aGUgZGV2aWNlIGlz
IGdvbmUuCj4+Pj4+Cj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEFuZHJleSBHcm9kem92c2t5IDxhbmRy
ZXkuZ3JvZHpvdnNreUBhbWQuY29tPgo+Pj4+PiAtLS0KPj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgfCAxNiArKysrKysrKysrLS0tLS0tCj4+Pj4+IMKg
IDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQo+Pj4+Pgo+
Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNl
LmMgCj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKPj4+
Pj4gaW5kZXggMWZmYjM2YmQwYjE5Li5mYTAzNzAyZWNiZmIgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4+Pj4+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCj4+Pj4+IEBAIC0zNiw2ICszNiw3
IEBACj4+Pj4+IMKgICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS5oPgo+Pj4+PiDCoCAjaW5jbHVk
ZSA8bGludXgvcG1fcnVudGltZS5oPgo+Pj4+PiArI2luY2x1ZGUgPGRybS9kcm1fZHJ2Lmg+Cj4+
Pj4+IMKgICNpbmNsdWRlICJhbWRncHUuaCIKPj4+Pj4gwqAgI2luY2x1ZGUgImFtZGdwdV90cmFj
ZS5oIgo+Pj4+PiBAQCAtNTI1LDggKzUyNiw3IEBAIGludCBhbWRncHVfZmVuY2VfZHJpdmVyX2lu
aXQoc3RydWN0IAo+Pj4+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4+PiDCoMKgICovCj4+Pj4+
IMKgIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9maW5pX2h3KHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2KQo+Pj4+PiDCoCB7Cj4+Pj4+IC3CoMKgwqAgdW5zaWduZWQgaSwgajsKPj4+Pj4gLcKg
wqDCoCBpbnQgcjsKPj4+Pj4gK8KgwqDCoCBpbnQgaSwgcjsKPj4+Pj4gwqDCoMKgwqDCoCBmb3Ig
KGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsgaSsrKSB7Cj4+Pj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsKPj4+Pj4gQEAg
LTUzNSwxMSArNTM1LDE1IEBAIHZvaWQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9maW5pX2h3KHN0cnVj
dCAKPj4+Pj4gYW1kZ3B1X2RldmljZSAqYWRldikKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgY29udGludWU7Cj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXJpbmctPm5vX3Nj
aGVkdWxlcikKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZHJtX3NjaGVkX2Zpbmko
JnJpbmctPnNjaGVkKTsKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIHIgPSBhbWRncHVfZmVuY2Vfd2Fp
dF9lbXB0eShyaW5nKTsKPj4+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChyKSB7Cj4+Pj4+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIG5vIG5lZWQgdG8gdHJpZ2dlciBHUFUgcmVzZXQgYXMgd2Ug
YXJlIHVubG9hZGluZyAqLwo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLyogWW91IGNhbid0IHdhaXQg
Zm9yIEhXIHRvIHNpZ25hbCBpZiBpdCdzIGdvbmUgKi8KPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlm
ICghZHJtX2Rldl9pc191bnBsdWdnZWQoJmFkZXYtPmRkZXYpKQo+Pj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByID0gYW1kZ3B1X2ZlbmNlX3dhaXRfZW1wdHkocmluZyk7Cj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCBlbHNlCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSAtRU5PREVW
Owo+Pj4+PiArwqDCoMKgwqDCoMKgwqAgLyogbm8gbmVlZCB0byB0cmlnZ2VyIEdQVSByZXNldCBh
cyB3ZSBhcmUgdW5sb2FkaW5nICovCj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAocikKPj4+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21w
bGV0aW9uKHJpbmcpOwo+Pj4+PiAtwqDCoMKgwqDCoMKgwqAgfQo+Pj4+PiArCj4+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAocmluZy0+ZmVuY2VfZHJ2LmlycV9zcmMpCj4+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9pcnFfcHV0KGFkZXYsIHJpbmctPmZlbmNlX2Rydi5p
cnFfc3JjLAo+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmluZy0+ZmVuY2VfZHJ2LmlycV90eXBlKTsKPj4+Pj4KPj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
