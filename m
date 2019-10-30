Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E89CA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 13:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58C120874
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 13:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58C120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F8996EA09;
	Wed, 30 Oct 2019 13:52:54 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2B316EA09
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 13:52:52 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id p4so2393735wrm.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 06:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rmJND8L2wgQ6Me6iAkS7JDDdDCi1sGzPNUQiG4Cn5Ik=;
 b=UrsPJ6gxu3ZEMDlmgxJ1Geu0niz4P3uL4CZMtS0nB46XKdwoqbCIFV48/OwtBgH0wr
 cnzH5lj6SWHsetejqE9FGbpc1LW+kKsiEK8jOo1acVbWE9VbqwgnDaLwG9LggfS7Qn+u
 uQT1qhvfKFQ09+J4/MaJ3wh9slxlpIbXL3tGpo9ZwA3gj390QnkzMomys1vQXtJD6dVQ
 mgnVh9k58BUU1ql46l50w3stCpLADpJgHxC00Kh9iqVMH4teX/T/s3AA2OTxHo5ZrAr4
 cFvV3mqqXcY44lvtb61ibOeY/9v4xLKFxQmqGmeWhaYV0Ch8Ok/0EGqgX4gEwZ9AOWhh
 y0FQ==
X-Gm-Message-State: APjAAAWWfsBm0cCg+gvQVHwj5w7xRPLrUpKT7E7Kc4R9T/6kMHiyZjO/
 0+dzzsASY6QSSHatI9y4R30cfR5r
X-Google-Smtp-Source: APXvYqxnh60Q3CJy3j1F+Bo/ehx2qolIc/xx866Wk/eCmnlslW3gbsxvV7S/DorcrIepSjbrkUXGWA==
X-Received: by 2002:a5d:4f04:: with SMTP id c4mr23987201wru.373.1572443571405; 
 Wed, 30 Oct 2019 06:52:51 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id 6sm83567wmd.36.2019.10.30.06.52.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Oct 2019 06:52:50 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: remove PT BOs when unmapping
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <1572379585-1401-1-git-send-email-JinhuiEric.Huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ebd653c8-d9e9-b104-769f-e68dee0e4c65@gmail.com>
Date: Wed, 30 Oct 2019 14:52:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572379585-1401-1-git-send-email-JinhuiEric.Huang@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=rmJND8L2wgQ6Me6iAkS7JDDdDCi1sGzPNUQiG4Cn5Ik=;
 b=H+in1kV6fPHjh5XhkuqQ1Y1VEkSoa6k4yfFwh9Raad2GPuwwLwJaq6lPcirg73BGBS
 xmHDc/nVnzfNBmybVQJSRdpXdhlGKGJOkGIJeLjeNmLgNU3qkeHUXs6zDiMqgCRSFXHE
 74yPv7xuQbZro5JETArU8Pu93HmzL5jwR6EENtj4qFgH7ucLCsf4E0Yv+z0igLfQlsj/
 v5RYzqoeR3f0T55BqTkReG1pWBh61ZtIEvhuF8Sq58nk5KiPLZrEgJ/UhKmNkk/iTlSN
 Btlu/LXAIMaARpOirrUuyfvWVPsz6h6ktqtxFuPJESKjlOgy39xBQXVKF3RPdtUCYQiE
 AeSw==
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
Message-ID: <20191030135249.9GWKm-mrYQmYKCY0cOWBOPOiLjp1pqeCOnN_kxn03ZM@z>

QW0gMjkuMTAuMTkgdW0gMjE6MDYgc2NocmllYiBIdWFuZywgSmluSHVpRXJpYzoKPiBUaGUgaXNz
dWUgaXMgUFQgQk9zIGFyZSBub3QgZnJlZWQgd2hlbiB1bm1hcHBpbmcgVkEsCj4gd2hpY2ggY2F1
c2VzIHZyYW0gdXNhZ2UgYWNjdW11bGF0ZWQgaXMgaHVnZSBpbiBzb21lCj4gbWVtb3J5IHN0cmVz
cyB0ZXN0LCBzdWNoIGFzIGtmZCBiaWcgYnVmZmVyIHN0cmVzcyB0ZXN0Lgo+IEZ1bmN0aW9uIGFt
ZGdwdV92bV9ib191cGRhdGVfbWFwcGluZygpIGlzIGNhbGxlZCBieSBib3RoCj4gYW1kZ3B1X3Zt
X2JvX3VwZGF0ZSgpIGFuZCBhbWRncHVfdm1fY2xlYXJfZnJlZWQoKS4gVGhlCj4gc29sdXRpb24g
aXMgcmVwbGFjaW5nIGFtZGdwdV92bV9ib191cGRhdGVfbWFwcGluZygpIGluCj4gYW1kZ3B1X3Zt
X2NsZWFyX2ZyZWVkKCkgd2l0aCByZW1vdmluZyBQVCBCT3MgZnVuY3Rpb24KPiB0byBzYXZlIHZy
YW0gdXNhZ2UuCgpOQUssIHRoYXQgaXMgaW50ZW50aW9uYWwgYmVoYXZpb3IuCgpPdGhlcndpc2Ug
d2UgY2FuIHJ1biBpbnRvIG91dCBvZiBtZW1vcnkgc2l0dWF0aW9ucyB3aGVuIHBhZ2UgdGFibGVz
IG5lZWQgCnRvIGJlIGFsbG9jYXRlZCBhZ2FpbiB1bmRlciBzdHJlc3MuCgpSZWdhcmRzLApDaHJp
c3RpYW4uCgo+Cj4gQ2hhbmdlLUlkOiBJYzI0ZTM1YmZmOGNhODUyNjViNDE4YTY0MjM3M2YxODlk
OTcyYTkyNAo+IFNpZ25lZC1vZmYtYnk6IEVyaWMgSHVhbmcgPEppbmh1aUVyaWMuSHVhbmdAYW1k
LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwg
NTYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDQ4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdm0uYwo+IGluZGV4IDBmNGMzYjIuLjhhNDgwYzcgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+IEBAIC0xOTMwLDYgKzE5MzAsNTEgQEAgc3Rh
dGljIHZvaWQgYW1kZ3B1X3ZtX3BydF9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBz
dHJ1Y3QgYW1kZ3B1X3ZtICp2bSkKPiAgIH0KPiAgIAo+ICAgLyoqCj4gKyAqIGFtZGdwdV92bV9y
ZW1vdmVfcHRlcyAtIGZyZWUgUFQgQk9zCj4gKyAqCj4gKyAqIEBhZGV2OiBhbWRncHUgZGV2aWNl
IHN0cnVjdHVyZQo+ICsgKiBAdm06IGFtZGdwdSB2bSBzdHJ1Y3R1cmUKPiArICogQHN0YXJ0OiBz
dGFydCBvZiBtYXBwZWQgcmFuZ2UKPiArICogQGVuZDogZW5kIG9mIG1hcHBlZCBlbnRyeQo+ICsg
Kgo+ICsgKiBGcmVlIHRoZSBwYWdlIHRhYmxlIGxldmVsLgo+ICsgKi8KPiArc3RhdGljIGludCBh
bWRncHVfdm1fcmVtb3ZlX3B0ZXMoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCj4gKwkJc3Ry
dWN0IGFtZGdwdV92bSAqdm0sIHVpbnQ2NF90IHN0YXJ0LCB1aW50NjRfdCBlbmQpCj4gK3sKPiAr
CXN0cnVjdCBhbWRncHVfdm1fcHRfY3Vyc29yIGN1cnNvcjsKPiArCXVuc2lnbmVkIHNoaWZ0LCBu
dW1fZW50cmllczsKPiArCj4gKwlhbWRncHVfdm1fcHRfc3RhcnQoYWRldiwgdm0sIHN0YXJ0LCAm
Y3Vyc29yKTsKPiArCXdoaWxlIChjdXJzb3IubGV2ZWwgPCBBTURHUFVfVk1fUFRCKSB7Cj4gKwkJ
aWYgKCFhbWRncHVfdm1fcHRfZGVzY2VuZGFudChhZGV2LCAmY3Vyc29yKSkKPiArCQkJcmV0dXJu
IC1FTk9FTlQ7Cj4gKwl9Cj4gKwo+ICsJd2hpbGUgKGN1cnNvci5wZm4gPCBlbmQpIHsKPiArCQlh
bWRncHVfdm1fZnJlZV90YWJsZShjdXJzb3IuZW50cnkpOwo+ICsJCW51bV9lbnRyaWVzID0gYW1k
Z3B1X3ZtX251bV9lbnRyaWVzKGFkZXYsIGN1cnNvci5sZXZlbCAtIDEpOwo+ICsKPiArCQlpZiAo
Y3Vyc29yLmVudHJ5ICE9ICZjdXJzb3IucGFyZW50LT5lbnRyaWVzW251bV9lbnRyaWVzIC0gMV0p
IHsKPiArCQkJLyogTmV4dCBwdGIgZW50cnkgKi8KPiArCQkJc2hpZnQgPSBhbWRncHVfdm1fbGV2
ZWxfc2hpZnQoYWRldiwgY3Vyc29yLmxldmVsIC0gMSk7Cj4gKwkJCWN1cnNvci5wZm4gKz0gMVVM
TCA8PCBzaGlmdDsKPiArCQkJY3Vyc29yLnBmbiAmPSB+KCgxVUxMIDw8IHNoaWZ0KSAtIDEpOwo+
ICsJCQljdXJzb3IuZW50cnkrKzsKPiArCQl9IGVsc2Ugewo+ICsJCQkvKiBOZXh0IHB0YiBlbnRy
eSBpbiBuZXh0IHBkMCBlbnRyeSAqLwo+ICsJCQlhbWRncHVfdm1fcHRfYW5jZXN0b3IoJmN1cnNv
cik7Cj4gKwkJCXNoaWZ0ID0gYW1kZ3B1X3ZtX2xldmVsX3NoaWZ0KGFkZXYsIGN1cnNvci5sZXZl
bCAtIDEpOwo+ICsJCQljdXJzb3IucGZuICs9IDFVTEwgPDwgc2hpZnQ7Cj4gKwkJCWN1cnNvci5w
Zm4gJj0gfigoMVVMTCA8PCBzaGlmdCkgLSAxKTsKPiArCQkJYW1kZ3B1X3ZtX3B0X2Rlc2NlbmRh
bnQoYWRldiwgJmN1cnNvcik7Cj4gKwkJfQo+ICsJfQo+ICsKPiArCXJldHVybiAwOwo+ICt9Cj4g
Kwo+ICsvKioKPiAgICAqIGFtZGdwdV92bV9jbGVhcl9mcmVlZCAtIGNsZWFyIGZyZWVkIEJPcyBp
biB0aGUgUFQKPiAgICAqCj4gICAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCj4gQEAg
LTE5NDksNyArMTk5NCw2IEBAIGludCBhbWRncHVfdm1fY2xlYXJfZnJlZWQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCj4gICAJCQkgIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSkKPiAgIHsK
PiAgIAlzdHJ1Y3QgYW1kZ3B1X2JvX3ZhX21hcHBpbmcgKm1hcHBpbmc7Cj4gLQl1aW50NjRfdCBp
bml0X3B0ZV92YWx1ZSA9IDA7Cj4gICAJc3RydWN0IGRtYV9mZW5jZSAqZiA9IE5VTEw7Cj4gICAJ
aW50IHI7Cj4gICAKPiBAQCAtMTk1OCwxMyArMjAwMiwxMCBAQCBpbnQgYW1kZ3B1X3ZtX2NsZWFy
X2ZyZWVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+ICAgCQkJc3RydWN0IGFtZGdwdV9i
b192YV9tYXBwaW5nLCBsaXN0KTsKPiAgIAkJbGlzdF9kZWwoJm1hcHBpbmctPmxpc3QpOwo+ICAg
Cj4gLQkJaWYgKHZtLT5wdGVfc3VwcG9ydF9hdHMgJiYKPiAtCQkgICAgbWFwcGluZy0+c3RhcnQg
PCBBTURHUFVfR01DX0hPTEVfU1RBUlQpCj4gLQkJCWluaXRfcHRlX3ZhbHVlID0gQU1ER1BVX1BU
RV9ERUZBVUxUX0FUQzsKPiArCQlyID0gYW1kZ3B1X3ZtX3JlbW92ZV9wdGVzKGFkZXYsIHZtLAo+
ICsJCQkJKG1hcHBpbmctPnN0YXJ0ICsgMHgxZmYpICYgKH4weDFmZmxsKSwKPiArCQkJCShtYXBw
aW5nLT5sYXN0ICsgMSkgJiAofjB4MWZmbGwpKTsKPiAgIAo+IC0JCXIgPSBhbWRncHVfdm1fYm9f
dXBkYXRlX21hcHBpbmcoYWRldiwgdm0sIGZhbHNlLCBOVUxMLAo+IC0JCQkJCQltYXBwaW5nLT5z
dGFydCwgbWFwcGluZy0+bGFzdCwKPiAtCQkJCQkJaW5pdF9wdGVfdmFsdWUsIDAsIE5VTEwsICZm
KTsKPiAgIAkJYW1kZ3B1X3ZtX2ZyZWVfbWFwcGluZyhhZGV2LCB2bSwgbWFwcGluZywgZik7Cj4g
ICAJCWlmIChyKSB7Cj4gICAJCQlkbWFfZmVuY2VfcHV0KGYpOwo+IEBAIC0xOTgwLDcgKzIwMjEs
NiBAQCBpbnQgYW1kZ3B1X3ZtX2NsZWFyX2ZyZWVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
LAo+ICAgCX0KPiAgIAo+ICAgCXJldHVybiAwOwo+IC0KPiAgIH0KPiAgIAo+ICAgLyoqCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
