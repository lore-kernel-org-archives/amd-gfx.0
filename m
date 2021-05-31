Return-Path: <SRS0=CFk9=K2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A187DC47082
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 14:08:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED4661375
	for <amd-gfx@archiver.kernel.org>; Mon, 31 May 2021 14:08:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED4661375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E3E6E4CB;
	Mon, 31 May 2021 14:08:11 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31446E4CB
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 14:08:09 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id u24so4111896edy.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 May 2021 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=Ok3dsmaf/lLzVrdp4NFaOqz8Zs339shL2VazOX+otIs=;
 b=Yphp3A+jRZIjKc1vU+Ggb6QhC2Wt4bsnvnJ1baMM2qtVI1cXsrkkEXI4r5McyCYYsu
 uMGf6+ZEvgb4KGgMRCfWpUR0URSvkNf/HTRNu6PTeGZriD8puUeHKWBVyp7kPY5Hf6+G
 Yt2A7ltawtmNa+VlR5udm/8F6dfz96Xs0Vz7Ch+ugiS/T+ZGlacxBcd3A9AhDSeLOZx2
 ArAfKaR7Nbrn+iNgQ/P4Dm7FHeuwlcdlSjTv0nNbV9mMXRif2jg4Tpv4utSuP2pWCNRZ
 B6rJIazwAb8hCckdBon6z5rWSRCJDVGs40SlhgwZs7YHk0qoHCkP5IBQYzG3Iq6OeJvr
 Obng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Ok3dsmaf/lLzVrdp4NFaOqz8Zs339shL2VazOX+otIs=;
 b=ojhRW2260qHIkuzdZtkmT7QOu3oxtElScogVwjSgoXI3yn+apwGJvcZHNoYUmEoTlN
 /C3BYNSBHFb4RJ4gf75Y3GcmSwkFR2NqDvVp7c1wj7B3W0l2AIC4fIY3fZO+jcTOrMkM
 WUrBjaenz+ZdXJDYLRCf8LWzobejFYc2nDqFBrPJypTpR1u1FM8XXkaDtPwUrksJm8xy
 +6BR2IjdrCPwg8vI4aHVBYlzCNdyTSiWvD4oLQ1u3sqp9t0/Ya1H7mtRsYoqFGYp/Lur
 ZSAMmHigijLvNLf6o3aIuTWaLEKBDIlr4slX+SgsL4/SFAhqd0XD4bolA9HJWUMt+hE5
 dIEQ==
X-Gm-Message-State: AOAM530xeNovB6WD9neMYTXUmRti3/u0VbhvUFT/bjpUxr639bFfmQY7
 vqpEEUfniVctpbWGMObSD7xHZuEOM+s=
X-Google-Smtp-Source: ABdhPJy15frnhps6E0E6YR41jMZzqHHhVu9nso9QtFm46BACI+DGzcKs7nwubKuKIZ2rPxboMDeDGQ==
X-Received: by 2002:a05:6402:3494:: with SMTP id
 v20mr25635271edc.169.1622470088345; 
 Mon, 31 May 2021 07:08:08 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:b94:4956:bad4:7c81?
 ([2a02:908:1252:fb60:b94:4956:bad4:7c81])
 by smtp.gmail.com with ESMTPSA id c26sm6972972edu.42.2021.05.31.07.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 May 2021 07:08:07 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: Fix a bug on flag table_freed
To: Eric Huang <jinhuieric.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210529225101.459466-1-jinhuieric.huang@amd.com>
 <a048b42a-71c6-97c5-0e15-44cb3f3847a2@gmail.com>
 <0e44e35b-2acd-1954-47e4-b5a1f8c3dc49@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ac9584d2-ef0a-3cae-631e-a0dd42c5555c@gmail.com>
Date: Mon, 31 May 2021 16:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0e44e35b-2acd-1954-47e4-b5a1f8c3dc49@amd.com>
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

CgpBbSAzMC4wNS4yMSB1bSAyMDoyOSBzY2hyaWViIEVyaWMgSHVhbmc6Cj4KPiBPbiAyMDIxLTA1
LTMwIDEyOjU0IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Cj4+Cj4+IEFtIDMwLjA1
LjIxIHVtIDAwOjUxIHNjaHJpZWIgRXJpYyBIdWFuZzoKPj4+IHRhYmxlX2ZyZWVkIHdpbGwgYmUg
YWx3YXlzIHRydWUgd2hlbiBtYXBwaW5nIGEgbWVtb3J5IHdpdGggc2l6ZQo+Pj4gYmlnZ2VyIHRo
YW4gMk1CLiBUaGUgcHJvYmxlbSBpcyBwYWdlIHRhYmxlJ3MgZW50cmllcyBhcmUgYWx3YXlzCj4+
PiBleGlzdGVkLCBidXQgZXhpc3RpbmcgbWFwcGluZyBkZXBlbmRzIG9uIHBhZ2UgdGFsYmUncyBi
bywgc28KPj4+IHVzaW5nIGEgY2hlY2sgb2YgcGFnZSB0YWJsZSdzIGJvIGV4aXN0ZWQgd2lsbCBy
ZXNvbHZlIHRoZSBpc3N1ZS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEh1YW5nIDxqaW5o
dWllcmljLmh1YW5nQGFtZC5jb20+Cj4+PiAtLS0KPj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92bS5jIHwgNCArKystCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwo+Pj4gaW5kZXggMGRlZTJlODc5N2M3Li45NWI5NGM5NWFkYWMgMTAw
NjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+Pj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPj4+IEBAIC0xNTgy
LDkgKzE1ODIsMTEgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IAo+
Pj4gYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnBhcmFtcywKPj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKiBjb21wbGV0ZWx5IGNvdmVyZWQgYnkgdGhlIHJhbmdlIGFuZCBzbyBwb3Rl
bnRpYWxseSAKPj4+IHN0aWxsIGluIHVzZS4KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKi8KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdoaWxlIChjdXJzb3IucGZuIDwg
ZnJhZ19zdGFydCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBNYWtl
IHN1cmUgcHJldmlvdXMgbWFwcGluZyBleGlzdGVkICovCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGlmIChjdXJzb3IuZW50cnktPmJhc2UuYm8pCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFyYW1zLT50YWJsZV9mcmVlZCA9IHRydWU7Cj4+
Cj4+IEluIGdlbmVyYWwgdGhpcyBpcyB0aGUgY29ycmVjdCBhcHByb2FjaCwgYnV0IEkgd291bGQg
cHVzaCB0aGF0IAo+PiBkZWNpc2lvbiBpbnRvIHRoZSBhbWRncHVfdm1fZnJlZV9wdHMoKSBmdW5j
dGlvbi4KPj4KPj4+IGFtZGdwdV92bV9mcmVlX3B0cyhhZGV2LCBwYXJhbXMtPnZtLCAmY3Vyc29y
KTsKPj4KPj4gU28gdGhhdCB3ZSBoYXZlIGhlcmUgc29tZXRoaW5nIGxpa2UKPj4KPj4gcGFyYW1z
LT50YWJsZV9mcmVlZCB8PSBhbWRncHVfdm1fZnJlZV9wdHMoLi4pOwo+Pgo+IFRoYW5rIHlvdSBm
b3IgeW91ciByZXZpZXcuIEkgd2FzIHRoaW5raW5nIHB1dCB0aGUgY2hlY2sgaW50byBmdW5jdGlv
biAKPiBhbWRncHVfdm1fZnJlZV9wdHMoKSBzaW5jZSBwcmV2aW91cyByZXZpZXcsIGl0IHdpbGwg
Y2hhbmdlIHJldHVybnMgb2YgCj4gdHdvIGZ1bmN0aW9ucyBhbWRncHVfdm1fZnJlZV9wdHMoKSBh
bmQgYW1kZ3B1X3ZtX2ZyZWVfdGFibGUoKS4gSWYgdGhlIAo+IHJldHVybnMgYXJlIG5vdCB1c2Vk
IGJ5IG90aGVyIGZ1bmN0aW9ucywgaXQgc2VlbXMgbWFrZSBhIHNpbXBsZSBjaGFuZ2UgCj4gY29t
cGxleCBmcm9tIG15IHBlcnNwZWN0aXZlLiBDYW4geW91IHNoYXJlIHRoZSByZWFzb24gb2YgeW91
ciBzdWdnZXN0aW9uPwoKQmVjYXVzZSB5b3UgY2FuIGFsc28gb3B0aW1pemUgdGhlIGJ1bGtfbW92
ZWFibGUgaGFuZGxpbmcgaW4gdGhhdCBmdW5jdGlvbi4KCkUuZy4gYnVsa19tb3ZlYWJsZSBzaG91
bGQgb25seSBiZSBzZXQgdG8gZmFsc2Ugd2hlbiBhIHRhYmxlIHdhcyBmcmVlZC4KClRoZSBvbmx5
IGNhc2Ugd2hlcmUgdGhpcyBkb2Vzbid0IG1hdHRlciBpcyB2bV9maW5pIGFuZCB3ZSByZWFsbHkg
ZG9uJ3QgCmNhcmUgZm9yIHRoYXQgc3BlY2lhbCBvbmUuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+
Cj4gUmVnYXJkcywKPiBFcmljCj4+Cj4+IFJlZ2FyZHMsCj4+IENocmlzdGlhbi4KPj4KPj4+IGFt
ZGdwdV92bV9wdF9uZXh0KGFkZXYsICZjdXJzb3IpOwo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBwYXJhbXMtPnRhYmxlX2ZyZWVkID0gdHJ1ZTsKPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH0KPj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2UgaWYgKGZyYWcg
Pj0gc2hpZnQpIHsKPj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
