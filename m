Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F834C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 12:14:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F686611F0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 12:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F686611F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025BD6EEA7;
	Thu, 27 May 2021 12:14:48 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3996EEA7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 12:14:46 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id r10so4484287wrj.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 05:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=K+fI4z0cZv9gHvLhxD2AtvGQu87W2ghAyZs7f0/qm+0=;
 b=kfUl4J+VjMIE453ElHQCgw+k+nXSqZEJy98U7eOuz24qfN3aYCBEyXhzwVbP6aKS9w
 Kf50ZM5R+kWoDTRiJDBXMAAZSu66QTla+zhLJLoJr3LzaueEXH0QO0RmECM5TkifwD9t
 rlz5f1IWrixDypfSW9CiLbCftIU+s5FzJi/Gsjh/coIfT3rcuIgkwGXJznvFQAQYt9lE
 +VgFCZoxwDMKNTc5TMfMcz3t0syfthuxK4Ffsn0WB+HQ3QiQ7Qs5FtposrNEVQ4akINX
 ml8J6r7dATP51pBdthSQBh/gzghm7t3IY1Cguj3cvL4gUSAaif+kcimKT0L7W729JHn/
 tvgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=K+fI4z0cZv9gHvLhxD2AtvGQu87W2ghAyZs7f0/qm+0=;
 b=m17GLfQ06rKCkzwzqyNQQQYm+4Y+W0cIAWHe1YZI3ThF97d+mxcfwJofDVaOlynXst
 qrgNk9DMWWe+xS6vcv+GHGYj3q2G9wUYyZSvG2WTv0MYwASkD/5wmI7NXUiFefSvKJK2
 UE9Hedd0Ra1Wofxrcx0919nfBnnlolK1olho4biCCe68HVzmkFiC/iODU5Y+mGm1xAxb
 qKrlnzrV03L8LUvPn8DqhrbHYN+Sir7OPqrcAH6uVZg6oxrJJGf+6ybdiZYh4LB9LRMj
 TfGlDsI+LRqKkr6bvLeaglNE3K9g+Tr40STPF4uCNVXCmiAPubNnb5ir//LW6cs0BFgh
 pJyg==
X-Gm-Message-State: AOAM533TfkxqKEPl7PFP5BQGYLkXI9hOUna9EMteCAc7vaV+v6+41w9U
 J4HKbE11gTnovW+vD7p1GzzjtbXft3U=
X-Google-Smtp-Source: ABdhPJyHqA2zoNRC8fw1/CtqSHzRLKsEhhHmVndA90IQkOts4+7RObntygyyxYSX8i+x+iwMIE0V9Q==
X-Received: by 2002:adf:f805:: with SMTP id s5mr3033795wrp.143.1622117685485; 
 Thu, 27 May 2021 05:14:45 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:e531:3aa1:4782:878a?
 ([2a02:908:1252:fb60:e531:3aa1:4782:878a])
 by smtp.gmail.com with ESMTPSA id q186sm2791217wme.20.2021.05.27.05.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 May 2021 05:14:45 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Don't flush HDP on A+A
To: Felix Kuehling <felix.kuehling@amd.com>,
 Eric Huang <jinhuieric.huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <92d943b2-7a72-e1a2-f29c-b5b54cf80d20@amd.com>
 <af255014-a915-cf58-2642-f94ae40bd10d@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <369d0acc-dc13-ae8f-6997-6f6ea2ea5215@gmail.com>
Date: Thu, 27 May 2021 14:14:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <af255014-a915-cf58-2642-f94ae40bd10d@amd.com>
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

CgpBbSAyNi4wNS4yMSB1bSAxNTo1NSBzY2hyaWViIEZlbGl4IEt1ZWhsaW5nOgo+IEFtIDIwMjEt
MDUtMjUgdW0gMTo1NiBwLm0uIHNjaHJpZWIgRXJpYyBIdWFuZzoKPj4gV2l0aCBYR01JIGNvbm5l
Y3Rpb24gZmx1c2hpbmcgSERQIG9uIFBDSWUgaXMgdW5uZWNlc3NhcnksCj4+IGl0IGlzIGFsc28g
dG8gb3B0aW1pemUgbWVtb3J5IGFsbG9jYXRpb24gbGF0ZW5jeS4KPj4KPj4gU2lnbmVkLW9mZi1i
eTogRXJpYyBIdWFuZyA8amluaHVpZXJpYy5odWFuZ0BhbWQuY29tPgo+Pgo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5jCj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtX2NwdS5jCj4+IGluZGV4IGFjNDVkOWM3YTRl
OS4uYWVmYjNkMjkyN2Q1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm1fY3B1LmMKPj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtX2NwdS5jCj4+IEBAIC0xMDgsNiArMTA4LDggQEAgc3RhdGljIGludCBhbWRncHVfdm1f
Y3B1X3VwZGF0ZShzdHJ1Y3QKPj4gYW1kZ3B1X3ZtX3VwZGF0ZV9wYXJhbXMgKnAsCj4+ICDCoHN0
YXRpYyBpbnQgYW1kZ3B1X3ZtX2NwdV9jb21taXQoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFy
YW1zICpwLAo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IGRtYV9mZW5jZSAqKmZlbmNlKQo+PiAgwqB7Cj4+ICvC
oMKgwqDCoMKgwqAgaWYgKHAtPmFkZXYtPmdtYy54Z21pLmNvbm5lY3RlZF90b19jcHUpCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+IEkgd29uZGVyIGlmIHRoaXMg
Y2hlY2sgc2hvdWxkIGJlIGluc2lkZSBoZHBfdjRfMF9mbHVzaF9oZHAgaW5zdGVhZCBzbyBpdAo+
IGNhdGNoZXMgYWxsIHVubmVjZXNzYXJ5IEhEUCBmbHVzaGluZy4gT24gdGhlIG90aGVyIGhhbmQs
IHRoYXQgd291bGQKPiBzdGlsbCBsZWF2ZSB0aGUgbWIoKS4gQnV0IHRoYXQgbWIoKSBpcyBwcm9i
YWJseSBuZWVkZWQgYW55d2F5IHRvIGVuc3VyZQo+IHRoYXQgdGhlIEdQVSB3aWxsIHNlZSBhbnkg
cHJldmlvdXMgbWVtb3J5IHdyaXRlcy4KClllcywgdGhhdCB3YXMgYWxzbyBteSBjb25jZXJuLiBC
dXQgaXQgbG9va3MgbGlrZSBteSByZXBseSBuZXZlciBtYWRlIGl0IAp0byB0aGUgbWFpbGluZyBs
aXN0LgoKSSB0aGluayB3ZSBzaG91bGQgaGF2ZSBhIGZ1bmN0aW9uIGluIGFtZGdwdV9kZXZpY2Uu
YyB0byBkZWNpZGUgaWYgSERQIApmbHVzaC9JbnZhbGlkYXRlIGFyZSBuZWNlc3Nhcnkgb3Igbm90
LgoKVGhpcyBzaG91bGQgdGhlbiBiZSB1c2VkIGF0IGFsbCB0aGUgZGlmZmVyZW50IHBsYWNlcyB3
aGVyZSB3ZSB0cmlnZ2VyIAp0aGlzIChDUywgR0FSVCBhbmQgaGVyZSkuCgpSZWdhcmRzLApDaHJp
c3RpYW4uCgo+Cj4gUmVnYXJkcywKPiAgwqAgRmVsaXgKPgo+Cj4+ICDCoMKgwqDCoMKgwqDCoCAv
KiBGbHVzaCBIRFAgKi8KPj4gIMKgwqDCoMKgwqDCoMKgIG1iKCk7Cj4+ICDCoMKgwqDCoMKgwqDC
oCBhbWRncHVfYXNpY19mbHVzaF9oZHAocC0+YWRldiwgTlVMTCk7Cj4+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0
Cj4+IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
