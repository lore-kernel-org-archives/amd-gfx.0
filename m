Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233D5C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 12:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB052075C
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 12:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB052075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC78389850;
	Tue, 26 Nov 2019 12:07:56 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0CD689850
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 12:07:55 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id 139so392060ywv.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 04:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=R31Zc6O5jamMMXVsKEOQMm2aay9kS+BmHGMBk0OsgY8=;
 b=jVCVeIEGnQ9MXA+zn2pfpAhsaP+w4ji0O4WMD6y11RIv0p2TS/yy1n2g7gabHbY160
 TYne0Y1HHTuDNK526IpL772Ich8l6IgKFrFpRssNwh2E/fGcWUkK1m7Jb1gCrEvpUHSj
 Stk/S6EXWZelAOMqtABSJRL733cVRWpn/eY0cItxC++Ketjaod2776mPRdcFVfdM5nvn
 uRSx4pAgqMfFED+2IsClOqMag5/xWVhtIF97GBDOiRSNDGvTt7OHqcbEXMAw+9Ag96LP
 /H2NflyVAsTbuMcOzlIGclHn1gNlx4DPgKkohKJWrqY+vEdGQopG0Ngs1PSTUOycji+p
 u8WA==
X-Gm-Message-State: APjAAAVK162pUBUVEHg0Y2pG7S04wY+KvfA1RYAWDLO8KrCHJMs0D0s8
 sRC4K3KUSpid5TzbNXYdQfE=
X-Google-Smtp-Source: APXvYqy5IEFo1zhCBYNV/3fJt+uQljqraKKMjtC37Av9FiQOt1MDbmxA4eClcX2DdBWRtdX285/jmg==
X-Received: by 2002:a81:3047:: with SMTP id w68mr13973451yww.290.1574770075238; 
 Tue, 26 Nov 2019 04:07:55 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j79sm5117402ywa.100.2019.11.26.04.07.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Nov 2019 04:07:54 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Apply noretry setting for mmhub9.4
To: Felix Kuehling <felix.kuehling@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <1574463347-27961-1-git-send-email-Oak.Zeng@amd.com>
 <68bce28c-6b9d-8626-b2e0-09d6f4b3bb05@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f6fc9754-8789-5b04-ed47-47a8d5a7742d@gmail.com>
Date: Tue, 26 Nov 2019 13:07:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <68bce28c-6b9d-8626-b2e0-09d6f4b3bb05@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=R31Zc6O5jamMMXVsKEOQMm2aay9kS+BmHGMBk0OsgY8=;
 b=Jfv2mRvu4cYh3XWcc4sLlmDSr517NkAH0OkA9uxTIT41enKrb7d2zHTRxlmd58gwS6
 XHr6QjHU+3GBOnNBHIugO9DL9vTVdmDvBdm63keq3mItwszAhTBcWIRKoJ9L/NoBd2Uf
 s5c/rCrneiQEXrewVJiyO5tK/aep6WRuai8+2yqiXESl5+ZwjWgHa6qkYqoLOsPRxeGg
 aRTexIICkJ/mRG1gduXS4pN1ct97Zkpn+cz1o54usQxnt6qSjwijUVTriUeHpJ00Ky7T
 zQ5KbDb5DCaAL7H4dwhxyh1n7MP6hcwHmlk/rZ+SKga8apSCA5p1cSC73EBIwHH1VeBl
 dgOg==
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
Cc: Jay.Cornwall@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126120752.ECcjnOepKsIn6Britxh9mvp8tDHV45WAj4t6UTPybxg@z>

QW0gMjMuMTEuMTkgdW0gMDA6MjEgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBPbiAyMDE5LTEx
LTIyIDU6NTUgcC5tLiwgT2FrIFplbmcgd3JvdGU6Cj4+IENvbmZpZyB0aGUgdHJhbnNsYXRpb24g
cmV0cnkgYmVoYXZpb3IgYWNjb3JkaW5nIHRvIG5vcmV0cnkKPj4ga2VybmVsIHBhcmFtZXRlcgo+
Pgo+PiBDaGFuZ2UtSWQ6IEk1YjkxZWE3NzcxNTEzN2NmOGNiODRlMjU4Y2NkZmJiMTljN2E0ZWQx
Cj4+IFNpZ25lZC1vZmYtYnk6IE9hayBaZW5nIDxPYWsuWmVuZ0BhbWQuY29tPgo+PiBTdWdnZXN0
ZWQtYnk6IEpheSBDb3Jud2FsbCA8SmF5LkNvcm53YWxsQGFtZC5jb20+Cj4KPiBSZXZpZXdlZC1i
eTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpSZXZpZXdlZC1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPgo+Cj4+IC0tLQo+
PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgfCA1ICsrKy0tCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80LmMgCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbW1odWJfdjlfNC5jCj4+IGluZGV4IDc1M2Vl
YTIuLjg1OTliZmQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L21t
aHViX3Y5XzQuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9tbWh1Yl92OV80
LmMKPj4gQEAgLTMxNCw3ICszMTQsOCBAQCBzdGF0aWMgdm9pZCBtbWh1Yl92OV80X3NldHVwX3Zt
aWRfY29uZmlnKHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRldiwgaW50IGh1YmlkKQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+dm1fbWFuYWdl
ci5ibG9ja19zaXplIC0gOSk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBTZW5kIG5vLXJldHJ5
IFhOQUNLIG9uIGZhdWx0IHRvIHN1cHByZXNzIFZNIGZhdWx0IHN0b3JtLiAqLwo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgdG1wID0gUkVHX1NFVF9GSUVMRCh0bXAsIFZNTDJWQzBfVk1fQ09OVEVYVDFf
Q05UTCwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJFVFJZX1BF
Uk1JU1NJT05fT1JfSU5WQUxJRF9QQUdFX0ZBVUxULCAwKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJFVFJZX1BFUk1JU1NJT05fT1JfSU5WQUxJRF9QQUdFX0ZB
VUxULAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWFtZGdwdV9u
b3JldHJ5KTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIFdSRUczMl9TT0MxNV9PRkZTRVQoTU1IVUIs
IDAsIG1tVk1MMlZDMF9WTV9DT05URVhUMV9DTlRMLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaHViaWQgKiBNTUhVQl9JTlNUQU5DRV9SRUdJU1RFUl9PRkZT
RVQgKyBpLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG1w
KTsKPj4gQEAgLTkwNSw0ICs5MDYsNCBAQCBzdGF0aWMgdm9pZCAKPj4gbW1odWJfdjlfNF9xdWVy
eV9yYXNfZXJyb3JfY291bnQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4+IMKgIGNvbnN0
IHN0cnVjdCBhbWRncHVfbW1odWJfZnVuY3MgbW1odWJfdjlfNF9mdW5jcyA9IHsKPj4gwqDCoMKg
wqDCoCAucmFzX2xhdGVfaW5pdCA9IGFtZGdwdV9tbWh1Yl9yYXNfbGF0ZV9pbml0LAo+PiDCoMKg
wqDCoMKgIC5xdWVyeV9yYXNfZXJyb3JfY291bnQgPSBtbWh1Yl92OV80X3F1ZXJ5X3Jhc19lcnJv
cl9jb3VudCwKPj4gLX07Cj4+IFwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQo+PiArfTsKPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
