Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E74C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 11:44:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C20164D73
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 11:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C20164D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C0E96E15A;
	Mon, 15 Feb 2021 11:44:35 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D946E15A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 11:44:33 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id df22so7680402edb.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 03:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=79CmJfg/jrohY43dW/CnGQ5OaY20+0X+CxXyXQ+8/N0=;
 b=nernoPlkIB11/9SRZ1vBv2+xf5/5EseMDpzKpB4AYBSmEsJbm+MjTj6d9HLane48+B
 hpQ8b+jawDuanlcN2kxNqai3KGaqvb+NxLFf8S7ZLXNPp8F2cDiP7yFw+6+OZeGLJ10Q
 RKmiN+HUIEQmzwD5Osgex1EJivwkUlofjweCodV9giFxKrCi3ltWIrE8gw2pg1j0fFlY
 fuaR+vb5BZRCPI5FpPTYhcGlQMVcjC37RIffPERxnzz5sEZnMX7b+32gRHajk9/L2fNK
 qZlut+IIzwXKQjVLSErsoZ/XvJpcLkJn2wLwfujYQEkp/lSsQh0vRvl1Cm87zkwvxtNE
 JYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=79CmJfg/jrohY43dW/CnGQ5OaY20+0X+CxXyXQ+8/N0=;
 b=ON9bpI9vZwQ/vxIw9k9njQFRr8bNJM3umI93QtHt+CSNFtb5yWc1/iDvnDGVhxo/qd
 z9ykZXy+hKEpr6LjL0mlhKr3rCjJwVXV74jKyySW0+Nt9qpTRfYqmPDXwUNB7GZNNwlb
 PIs1hz3pDDg0eZEChlmBed4uTYBjx1bXc+U1tAfjjykQ1uXFWpKzsEIFlxO33unCkPiL
 aY0klRwKgr6lMOeJ+OSAlzl32wRjw7rmfi8UBC/fFBx0aYmAzbEbz0o0cE6xukcru69X
 4sRufS/9tr9Hg/3AkmxHYdDEJWDVCgLfycyd2Zq3pQ1sTTzFucsLPZKL2g5IrREu6ncp
 GdyA==
X-Gm-Message-State: AOAM5313LZ5svUXNQp4qGa/OQWu5zMl6iwvtfyiaYafHLbCSFe9N6inR
 Ss0UrLK4KSxfzGPZq12Oh6Ad4bC4qJQihA==
X-Google-Smtp-Source: ABdhPJyulPeGtgyL3wXd0nLJTgiH8tNv9r03AhCpDoX7vCwfpkO2p/+g6mzm1KmqNWZi/cP9CcW2XQ==
X-Received: by 2002:aa7:c80a:: with SMTP id a10mr15064791edt.141.1613389472407; 
 Mon, 15 Feb 2021 03:44:32 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:3e90:5494:cc4a:73e5?
 ([2a02:908:1252:fb60:3e90:5494:cc4a:73e5])
 by smtp.gmail.com with ESMTPSA id kz4sm10354847ejc.38.2021.02.15.03.44.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Feb 2021 03:44:32 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Set GTT_USWC flag to enable freesync v2
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: amd-gfx@lists.freedesktop.org, shashank.sharma@amd.com
References: <20210215114336.89977-1-christian.koenig@amd.com>
Message-ID: <0a679d74-6066-0ed8-26f8-2d02b6db5210@gmail.com>
Date: Mon, 15 Feb 2021 12:44:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210215114336.89977-1-christian.koenig@amd.com>
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

SGkgU2hhc2hhbmssCgpjYW4geW91IGdpdmUgdGhpcyBwYXRjaCBhIHRlc3Qgcm91bmQ/IEluIHRo
ZW9yeSBpdCBzaG91bGQgd29yaywgYnV0IEknbSAKbm90IDEwMCUgc3VyZS4KClRoYW5rcywKQ2hy
aXN0aWFuLgoKQW0gMTUuMDIuMjEgdW0gMTI6NDMgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+
IEZyb206IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Cj4KPiBUaGlz
IHBhdGNoIHNldHMgJ0FNREdQVV9HRU1fQ1JFQVRFX0NQVV9HVFRfVVNXQycgYXMgaW5wdXQKPiBw
YXJhbWV0ZXIgZmxhZywgZHVyaW5nIG9iamVjdCBjcmVhdGlvbiBvZiBhbiBpbXBvcnRlZCBETUEK
PiBidWZmZXIuCj4KPiBJbiBhYnNlbmNlIG9mIHRoaXMgZmxhZzoKPiAxLiBGdW5jdGlvbiBhbWRn
cHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucygpIGRvZXNuJ3QgYWRkCj4gICAgIEFNREdQVV9H
RU1fRE9NQUlOX0dUVCBhcyBzdXBwb3J0ZWQgZG9tYWluLgo+IDIuIER1ZSB0byB3aGljaCwgRnVu
Y3Rpb24gYW1kZ3B1X2Rpc3BsYXlfdXNlcl9mcmFtZWJ1ZmZlcl9jcmVhdGUoKQo+ICAgICByZWZ1
c2VzIHRvIGNyZWF0ZSBmcmFtZWJ1ZmZlciBmb3IgaW1wb3J0ZWQgRE1BIGJ1ZmZlcnMuCj4gMy4g
RHVlIHRvIHdoaWNoLCBBZGRGQigpIElPQ1RMIGZhaWxzLgo+IDQuIER1ZSB0byB3aGljaCwgYW1k
Z3B1X3ByZXNlbnRfY2hlY2tfZmxpcCgpIGNoZWNrIGZhaWxzIGluIEREWAo+IDUuIER1ZSB0byB3
aGljaCBERFggZHJpdmVyIGRvZXNuJ3QgYWxsb3cgZmxpcHMgKGdvZXMgdG8gYmxpdHRpbmcpCj4g
Ni4gRHVlIHRvIHdoaWNoIHNldHRpbmcgRnJlZXN5bmMvVlJSIHByb3BlcnR5IGZhaWxzIGZvciBQ
UklNRSBidWZmZXJzLgo+Cj4gU28sIHRoaXMgcGF0Y2ggZmluYWxseSBlbmFibGVzIEZyZWVzeW5j
IHdpdGggUFJJTUUgYnVmZmVyIG9mZmxvYWRpbmcuCj4KPiB2MiAoY2hrKTogaW5zdGVhZCBvZiBq
dXN0IGNoZWNraW5nIHRoZSBmbGFnIHdlIGNvcHkgaXQgb3ZlciBpZiB0aGUKPiAgICAgICAgICAg
IGV4cG9ydGVyIGlzIGFuIGFtZGdwdSBkZXZpY2UgYXMgd2VsbC4KPgo+IFNpZ25lZC1vZmYtYnk6
IFNoYXNoYW5rIFNoYXJtYSA8c2hhc2hhbmsuc2hhcm1hQGFtZC5jb20+Cj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyB8IDE0ICsrKysrKysr
KysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZG1h
X2J1Zi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYwo+IGlu
ZGV4IGQzNzI3ZjNhYjI3Ny4uYTU0YTg3MGYwMDZjIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCj4gQEAgLTQyMiwxNCArNDIyLDIyIEBAIGFtZGdw
dV9kbWFfYnVmX2NyZWF0ZV9vYmooc3RydWN0IGRybV9kZXZpY2UgKmRldiwgc3RydWN0IGRtYV9i
dWYgKmRtYV9idWYpCj4gICB7Cj4gICAJc3RydWN0IGRtYV9yZXN2ICpyZXN2ID0gZG1hX2J1Zi0+
cmVzdjsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGRybV90b19hZGV2KGRldik7
Cj4gLQlzdHJ1Y3QgYW1kZ3B1X2JvICpibzsKPiAgIAlzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKmdv
Ymo7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvICpibzsKPiArCXVpbnQ2NF90IGZsYWdzID0gMDsKPiAg
IAlpbnQgcmV0Owo+ICAgCj4gICAJZG1hX3Jlc3ZfbG9jayhyZXN2LCBOVUxMKTsKPiArCj4gKwlp
ZiAoZG1hX2J1Zi0+b3BzID09ICZhbWRncHVfZG1hYnVmX29wcykgewo+ICsJCXN0cnVjdCBhbWRn
cHVfYm8gKm90aGVyID0gZ2VtX3RvX2FtZGdwdV9ibyhkbWFfYnVmLT5wcml2KTsKPiArCj4gKwkJ
ZmxhZ3MgfD0gb3RoZXItPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dDOwo+
ICsJfQo+ICsKPiAgIAlyZXQgPSBhbWRncHVfZ2VtX29iamVjdF9jcmVhdGUoYWRldiwgZG1hX2J1
Zi0+c2l6ZSwgUEFHRV9TSVpFLAo+IC0JCQlBTURHUFVfR0VNX0RPTUFJTl9DUFUsCj4gLQkJCTAs
IHR0bV9ib190eXBlX3NnLCByZXN2LCAmZ29iaik7Cj4gKwkJCQkgICAgICAgQU1ER1BVX0dFTV9E
T01BSU5fQ1BVLCBmbGFncywKPiArCQkJCSAgICAgICB0dG1fYm9fdHlwZV9zZywgcmVzdiwgJmdv
YmopOwo+ICAgCWlmIChyZXQpCj4gICAJCWdvdG8gZXJyb3I7Cj4gICAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
