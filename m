Return-Path: <SRS0=keof=MB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9F5C07E9B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 19:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8523361369
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jul 2021 19:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8523361369
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BADB6EA7E;
	Fri,  9 Jul 2021 19:37:31 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87AD66EA7D;
 Fri,  9 Jul 2021 19:37:29 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id n33so7001170wms.1;
 Fri, 09 Jul 2021 12:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=tw1A+JHrPrv/3gnkBESDn7Qp8VcHyIj0wUsDYO8CN+w=;
 b=flaPb6wh/4ctiuKlzNXUFDRoLBQthvTaVPvjUDA98ezyeHvb8mOgEntHCsOObIYuYY
 YJCXAa0tHt2a2r6Jk67wuRnkzidEt2O0+e9A+g38S0r35EwPs7tCCJ9e6TvS9FaqCqOR
 nzWQ+ToPxVygZWFHF5FzXy39K0m8WvGyXD+O5X34d1AlHXk0WG3YXuxBuEkZHjUf4D1u
 BS1n3lNfTaYTceDz2hbyCMIuVShjH/PVlKh5BDPZ8RiJjN3c+Hv/j9sMDHw+kzZs6qVG
 Y6epP6FXSE0J8bCHFvZxDzDXPk+Pzi+Jqnd+oLEw1P0xJEL3xT244ropKtwwwBLMSBrV
 RyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=tw1A+JHrPrv/3gnkBESDn7Qp8VcHyIj0wUsDYO8CN+w=;
 b=fdq7NQxXUkgjy+tZJ+WPGi33xX2ifRYALFhzQdxjFvGk74Trm7795WjcElUBWoYdDF
 X5PpZj5m4kKIMt6627WNIxeqv7P/YwDR9mVtWLhfgw1DmzktTubRplKNDPebNYhNiK3+
 THc9IeCPXFlFD/AbkLN9MYXyfDUwq10oeuC8vOdROYlbEzsWAuGGr93xhpAW9C579zNY
 ePH3YOP26YxuycQ5wTyGMMRXfJ2Egjk1yaLKXsUAZ1ywQiIrmsHGQ5YU3mAoporKblC3
 ldXXh/Mtd3QFNS+XG2+8lRJQ5h/DFNRZLvoAeVDAgriBmN/EVUArhy2fKuT9dDxu59Ln
 JRvA==
X-Gm-Message-State: AOAM530BxEJQmQyDs7HRS8YtGIuyO5uW6JxaTikW8EnNhGyhPDGORUp1
 mamyusg/W/tTJBNeXg65wn/c6oIGYZI=
X-Google-Smtp-Source: ABdhPJzzjX/P0v4O3bn4/wfzjDycHsxbAmz6YZjgsrXCO6ZtxkSYP7SeSKslGbmVMtciTefPs27SfA==
X-Received: by 2002:a1c:4e0b:: with SMTP id g11mr520163wmh.167.1625859448281; 
 Fri, 09 Jul 2021 12:37:28 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:38e1:8c08:a93f:2590?
 ([2a02:908:1252:fb60:38e1:8c08:a93f:2590])
 by smtp.gmail.com with ESMTPSA id h21sm5369983wmq.38.2021.07.09.12.37.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jul 2021 12:37:27 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/ttm: Fix COW check
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20210708193621.2198733-1-alexander.deucher@amd.com>
 <20210708193621.2198733-2-alexander.deucher@amd.com>
 <a25f93e7-8c03-542c-f594-64a7c1fba292@gmail.com>
 <2fd0006e-f005-b11c-3918-a9d690a1831a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <19fbefce-b9c8-8f22-2789-0eee8f58c61a@gmail.com>
Date: Fri, 9 Jul 2021 21:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2fd0006e-f005-b11c-3918-a9d690a1831a@amd.com>
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

QW0gMDkuMDcuMjEgdW0gMjE6MzEgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBPbiAyMDIxLTA3
LTA5IDI6MzggYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4KPj4KPj4gQW0gMDguMDcu
MjEgdW0gMjE6MzYgc2NocmllYiBBbGV4IERldWNoZXI6Cj4+PiBGcm9tOiBGZWxpeCBLdWVobGlu
ZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4+Cj4+PiBLRkQgVGh1bmsgbWFwcyBpbnZpc2li
bGUgVlJBTSBCT3Mgd2l0aCBQUk9UX05PTkUsIE1BUF9QUklWQVRFLgo+Pj4gaXNfY293X21hcHBp
bmcgcmV0dXJucyB0cnVlIGZvciB0aGVzZSBtYXBwaW5ncy4gQWRkIGEgY2hlY2sgZm9yCj4+PiB2
bV9mbGFncyAmIFZNX1dSSVRFIHRvIGF2b2lkIG1tYXAgZmFpbHVyZXMgb24gcHJpdmF0ZSByZWFk
LW9ubHkgb3IKPj4+IFBST1RfTk9ORSBtYXBwaW5ncy4KPj4KPj4gSSdtIHByZXR0eSBzdXJlIHRo
YXQgdGhpcyBpcyBub3Qgd29ya2luZyBhcyBleHBlY3RlZC4KPgo+IE5vdCBzdXJlIHdoYXQgeW91
IG1lYW4uIERlYnVnZ2VyIGFjY2VzcyB0byB0aGUgbWVtb3J5IHRocm91Z2ggdGhlIAo+IFBST1Rf
Tk9ORSBWTUFzIGlzIGRlZmluaXRlbHkgd29ya2luZywgd2l0aCBib3RoIHB0cmFjZSBhbmQgCj4g
L3Byb2MvPHBpZD4vbWVtLgo+Cj4KPj4KPj4+Cj4+PiBGaXhlczogZjkxMTQyYzYyMTYxICgiZHJt
L3R0bTogbnVrZSBWTV9NSVhFRE1BUCBvbiBCTyBtYXBwaW5ncyB2MyIpCj4+PiBTaWduZWQtb2Zm
LWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4+IFNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4+IC0tLQo+
Pj4gZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9fdm0uYyB8IDIgKy0KPj4+IMKgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pj4KPj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9ib192bS5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0v
dHRtL3R0bV9ib192bS5jCj4+PiBpbmRleCBmNTZiZTViYzA4NjEuLmE3NWU5MGM3ZDRhYSAxMDA2
NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMKPj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3ZtLmMKPj4+IEBAIC01NTIsNyArNTUyLDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCAKPj4+IHR0bV9ib192bV9vcHMg
PSB7Cj4+PiDCoCBpbnQgdHRtX2JvX21tYXBfb2JqKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1h
LCBzdHJ1Y3QgCj4+PiB0dG1fYnVmZmVyX29iamVjdCAqYm8pCj4+PiDCoCB7Cj4+PiDCoMKgwqDC
oMKgIC8qIEVuZm9yY2Ugbm8gQ09XIHNpbmNlIHdvdWxkIGhhdmUgcmVhbGx5IHN0cmFuZ2UgYmVo
YXZpb3IgCj4+PiB3aXRoIGl0LiAqLwo+Pj4gLcKgwqDCoCBpZiAoaXNfY293X21hcHBpbmcodm1h
LT52bV9mbGFncykpCj4+PiArwqDCoMKgIGlmIChpc19jb3dfbWFwcGluZyh2bWEtPnZtX2ZsYWdz
KSAmJiAodm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKSkKPj4KPj4gaXNfY293X21hcHBpbmcoKSBh
bHJlYWR5IGNoZWNrcyBmb3IgVk1fTUFZV1JJVEUsIHNvIHRoaXMgaGVyZSAKPj4gc2hvdWxkbid0
IGJlIG5lY2Vzc2FyeS4KPgo+IEFGQUlDVCwgVk1fTUFZV1JJVEUgaXMgbm90IGJhc2VkIG9uIHRo
ZSBQUk9UXy4uLiBiaXRzIHVzZWQgdG8gY3JlYXRlIAo+IHRoZSBWTUEsIGJ1dCBiYXNlZCBvbiB0
aGUgcGVybWlzc2lvbnMgb2YgdGhlIGZpbGUuIFNvIGFzIGxvbmcgYXMgdGhlIAo+IHJlbmRlciBu
b2RlIGlzIHdyaXRhYmxlLCBWTV9NQVlXUklURSBpcyBzZXQgZm9yIGFsbCBWTUFzIHRoYXQgbWFw
IGl0Lgo+Cj4gSSB3b3VsZCBhZ3JlZSB0aGF0IGl0J3MgcHJvYmFibHkgYSBiYWQgaWRlYSBmb3Ig
dGhlIFRodW5rIHRvIG1hcCB0aGVzZSAKPiBWTUFzIHdpdGggTUFQX1BSSVZBVEUuIFdlIGNhbiB0
cnkgY2hhbmdpbmcgdGhlIFRodW5rIHRvIHVzZSBNQVBfU0hBUkVEIAo+IGZvciB0aGVzZSBQUk9U
X05PTkUgbWFwcGluZ3MuIEJ1dCB0aGF0IGRvZXNuJ3QgY2hhbmdlIHRoZSBmYWN0IHRoYXQgCj4g
dGhpcyBrZXJuZWwgcGF0Y2ggYnJva2UgZXhpc3RpbmcgdXNlcm1vZGUuCgpZZWFoLCBidXQgc2Vl
IHRoZSBkaXNjdXNzaW9uIGFyb3VuZCBNQVBfUFJJVkFURSBhbmQgQ09XIHJlZ2FyZGluZyB0aGlz
LiAKV2hhdCBUaHVuayBkaWQgaGVyZSB3YXMgYSByZWFsbHkgYmFkIGlkZWEuCgpJIHRoaW5rIHdl
IGhhdmUgb25seSB0d28gb3B0aW9ucyBoZXJlOgoxLiBBY2NlcHQgdGhlIGJyZWFrYWdlIG9mIHRo
dW5rLgoyLiBBZGQgYSB3b3JrYXJvdW5kIGluIGFtZGdwdS9hbWRrZmQgdG8gZm9yY2UgTUFQX1BS
SVZBVEUgaW50byAKTUFQX1NIQVJFRCBpbiB0aGUga2VybmVsLgoKUmVnYXJkcywKQ2hyaXN0aWFu
LgoKPgo+IFJlZ2FyZHMsCj4gwqAgRmVsaXgKPgo+Cj4+Cj4+IENocmlzdGlhbi4KPj4KPj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+IMKgIMKgwqDCoMKgwqAgdHRtX2Jv
X2dldChibyk7Cj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
