Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C517C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 17:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 289B524653
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 17:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 289B524653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25116F8BF;
	Thu,  5 Dec 2019 17:15:43 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D896F8BF
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 17:15:42 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id y11so4566122wrt.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2019 09:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JmZmOHVY7NdAoujHvKDGK4ZbduuaoY7SHlfghSsgwJ0=;
 b=BZCJH6uZJUKemUe8FtXIcvLgqiSEADTvPKO1sJCWruQx6OZhYBwLtN6m6QPQ7UX3r0
 Xcg7Y7NdqGIWs9OBRUJfN880XDutrJlLoEIFw+XeHWv93xBcS60qLbGXsT8ORKjtuHZC
 L7ILlXtgZHdzbqMtUA3BgtbWm+dCebb9C1ODvDbjckWeNCMMrmvbCayCuttxzcuuZzUE
 cVWGzG/mKpCThQAn5scOmuaLiY1TqX+pscp5hu/VxeBQJcoNJpwdoc8N3NGHp+UosSNH
 Ni0DAJqfkIcHvQRlIl9RXiQRPoMQioSQZNQvCgDXfh2LsWG6PVFgR1ZftivY4A8jY/EI
 20+w==
X-Gm-Message-State: APjAAAXYs4X1x321wa7FWbPEe92KJUYaVG7jgRkFxwLUXgnG7l3MoRuG
 AEYXDnSKdUMSC6/p9rSd/CAINZZk
X-Google-Smtp-Source: APXvYqwwVQGZDtlpKCujVa1iyazM1+PL1+Pg+USakns9tbcntJOhYQAfDfe8JV6NAwupm2o4kh+WZw==
X-Received: by 2002:adf:e550:: with SMTP id z16mr11257425wrm.315.1575566141166; 
 Thu, 05 Dec 2019 09:15:41 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t8sm12989815wrp.69.2019.12.05.09.15.40
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Dec 2019 09:15:40 -0800 (PST)
Subject: Re: [PATCH 5/5] drm/amdgpu: immedially invalidate PTEs
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 philip.yang@amd.com, Alex.Sierra@amd.com
References: <20191205133940.3865-1-christian.koenig@amd.com>
 <20191205133940.3865-5-christian.koenig@amd.com>
 <1f71140d-0480-886f-b344-04f419a5a37f@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <806ae7fe-893d-10e5-e812-2c9b80bb4a3a@gmail.com>
Date: Thu, 5 Dec 2019 18:15:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1f71140d-0480-886f-b344-04f419a5a37f@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=JmZmOHVY7NdAoujHvKDGK4ZbduuaoY7SHlfghSsgwJ0=;
 b=WT7pEflcDKNtMmAelw0AWcGoZQ8XJ+rkKhzm7JVmP2KUN6hYJcvvtZ1Sva2HBdEmPf
 OODcsncP/fWUFPYVJOO8QHqSAaT0DLEGTdDBiA2YdIGM2WoWiA26AzQXghLrqwMogGNX
 hJImT09b599fM/iyoKnJMR3gd9LM9S7fipe9t4KfNkSH6TR1n6AMLdDrgXzMiu5tOLZa
 ZHBkfcfXbZVK56kJZ8zYdxIli6hcd51zl5O/5GOwVFs2E7V/XhrN4Y6yYTsn160jS0OJ
 Og5/6kEMRnC58z2eVdWXQTJXnj5kvBy5RnZReZuyDu5EvDEckEr9wFOhfXEBJ1NLz2Kx
 72bA==
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDUuMTIuMTkgdW0gMTc6NDUgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBPbiAyMDE5LTEy
LTA1IDg6MzkgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gV2hlbiBhIEJPIGlzIGV2
aWN0ZWQgaW1tZWRpYWxseSBpbnZhbGlkYXRlIHRoZSBtYXBwZWQgUFRFcy4KPgo+IEkgdGhpbmsg
eW91IG1lbnRpb25lZCB0aGF0IHRoaXMgaXMganVzdCBhIHByb29mIG9mIGNvbmNlcHQuCgpJIGFs
c28gbmVlZCB0aGlzIGZvciBpbW1lZGlhdGVseSBnZXR0aW5nIHJpZCBvZiBtYXBwaW5ncyBpbiBE
TUEtYnVmIApiYXNlZCBQMlAuCgo+IEkgd291bGRuJ3Qgc3VibWl0IHRoZSBwYXRjaCBsaWtlIHRo
aXMgYmVjYXVzZSBpdCdzIG92ZXJraWxsIGZvciBWTXMgCj4gdGhhdCBkb24ndCB3YW50IHRvIHVz
ZSByZWNvdmVyYWJsZSBwYWdlIGZhdWx0cyBhbmQgcHJvYmFibHkgaGFzIGEgCj4gcGVyZm9ybWFu
Y2UgaW1wYWN0LiBJIHdvdWxkIGRvIHNvbWV0aGluZyBzcGVjaWZpYyB0byBjb21wdXRlIFZNcyBp
biAKPiBvdXIgTU1VIG5vdGlmaWVyLgoKSSBzdGlsbCBuZWVkIHRvIHRlc3QgdGhpcywgYnV0IEkg
aG9wZSB0aGF0IGl0IGRvZXNuJ3QgaGF2ZSB0aGF0IG11Y2ggCmltcGFjdCBvbiBwZXJmb3JtYW5j
ZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBSZWdhcmRzLAo+IMKgIEZlbGl4Cj4KPj4KPj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
Pgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAx
NyArKysrKysrKysrKysrKysrLQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZtLmMKPj4gaW5kZXggODM5ZDZkZjM5NGZjLi5lNTc4MTEzYmZkNTUgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IEBAIC0yNTY1LDYgKzI1NjUsNyBAQCB2
b2lkIGFtZGdwdV92bV9ib19pbnZhbGlkYXRlKHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRl
diwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVf
Ym8gKmJvLCBib29sIGV2aWN0ZWQpCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1
X3ZtX2JvX2Jhc2UgKmJvX2Jhc2U7Cj4+ICvCoMKgwqAgaW50IHI7Cj4+IMKgIMKgwqDCoMKgwqAg
Lyogc2hhZG93IGJvIGRvZXNuJ3QgaGF2ZSBibyBiYXNlLCBpdHMgdmFsaWRhdGlvbiBuZWVkcyBp
dHMgCj4+IHBhcmVudCAqLwo+PiDCoMKgwqDCoMKgIGlmIChiby0+cGFyZW50ICYmIGJvLT5wYXJl
bnQtPnNoYWRvdyA9PSBibykKPj4gQEAgLTI1NzIsOCArMjU3MywyMiBAQCB2b2lkIGFtZGdwdV92
bV9ib19pbnZhbGlkYXRlKHN0cnVjdCAKPj4gYW1kZ3B1X2RldmljZSAqYWRldiwKPj4gwqAgwqDC
oMKgwqDCoCBmb3IgKGJvX2Jhc2UgPSBiby0+dm1fYm87IGJvX2Jhc2U7IGJvX2Jhc2UgPSBib19i
YXNlLT5uZXh0KSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSA9
IGJvX2Jhc2UtPnZtOwo+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRtYV9yZXN2ICpyZXN2ID0g
dm0tPnJvb3QuYmFzZS5iby0+dGJvLmJhc2UucmVzdjsKPj4gKwo+PiArwqDCoMKgwqDCoMKgwqAg
aWYgKGJvLT50Ym8udHlwZSAhPSB0dG1fYm9fdHlwZV9rZXJuZWwpIHsKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3RydWN0IGFtZGdwdV9ib192YSAqYm9fdmE7Cj4+ICsKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYm9fdmEgPSBjb250YWluZXJfb2YoYm9fYmFzZSwgc3RydWN0IGFtZGdw
dV9ib192YSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBiYXNlKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV92bV9ib191
cGRhdGUoYWRldiwgYm9fdmEsCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGJvLT50Ym8uYmFzZS5yZXN2ICE9IHJlc3YpOwo+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoIXIpIHsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBh
bWRncHVfdm1fYm9faWRsZShib19iYXNlKTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBjb250aW51ZTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+PiArwqDCoMKgwqDC
oMKgwqAgfQo+PiDCoCAtwqDCoMKgwqDCoMKgwqAgaWYgKGV2aWN0ZWQgJiYgYm8tPnRiby5iYXNl
LnJlc3YgPT0gCj4+IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNlLnJlc3YpIHsKPj4gK8KgwqDC
oMKgwqDCoMKgIGlmIChldmljdGVkICYmIGJvLT50Ym8uYmFzZS5yZXN2ID09IHJlc3YpIHsKPj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3ZtX2JvX2V2aWN0ZWQoYm9fYmFzZSk7
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
