Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C866C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 13:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DCD820836
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 13:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5z0Osfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DCD820836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22F886EB3F;
	Wed, 11 Dec 2019 13:07:40 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21EB6EB3F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 13:07:38 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id f129so6915468wmf.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 05:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=JnTkrwovdaKMx9wVPKTTMEIoEgdWwQ46Q0lQVmp3VP0=;
 b=Q5z0OsfiUBWzEm7ApJsqf1+sV4SPQbmHDczPQcIP6davlPRTGp7Rw+Un7veXNT777s
 QS81tNv+eh6i1a8uTu1hqpfRhvbFRfI3ZnFdwqb42LNgTZlnAbjC9vCdB8EYvrRjoAzx
 ZTLwVDyrHNR2PQERhckSvfLZZpDaY/SovEhOWFmKhwdJjG62sOtyqANOW2koYugQFF0e
 2gDcLsaEtUSCbgQCGT0tY5Q+SOgI4/fSnB7+bps1emwWTk4azOnDd5wQnsicjCMGFWOV
 rETw8lqgsS2ubaTyul2OACQRyyHVCYF64CjpDubJkejal600lulbSZaEgf8BDG+0lS8Z
 RdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=JnTkrwovdaKMx9wVPKTTMEIoEgdWwQ46Q0lQVmp3VP0=;
 b=ZpQxnnJSmxjg0fjkkvTxVJM3fVPV2prlBpKy2y4hC2i6wK+Djqmx1SxjshuHP53V6M
 O2BQHW/49AjcOlruJOncHXSd0NsckU/8NEIhfCBBbdPjlqyIwHlzUgg79naZighjnTjw
 ZMCV+5VSUapMPTTqAZqT1cb72kAlkmKGQLFxn5PGV16HXwHWQRv4hbHiVdQdXxQ53UM5
 TWTjLsTbfEB6Hj9JteSklq1V/hg2+WZcDFdpqM8Tu625PTIdFteJq+KgF5QD8VJ/iVQK
 cVlup9Syd8kJs0iOyZsdgc5DXDvA7SgDeIqAiL4lxdpDf0P30RPQMh1YfmlFUgVfmsCn
 uwFg==
X-Gm-Message-State: APjAAAUVfm2/iEII0H1tY88CAG5DY+L8CFXC9+I2D66tQ96GER2SsiSJ
 TCLm2VUjURtGzu00KS0qMEQ=
X-Google-Smtp-Source: APXvYqwIC7Bv7RFDhDq/GH9riWzbaLBF4nDnv3VMuyPUvjxBehLypW0ZDahnefIekJWCUHya21GnyQ==
X-Received: by 2002:a1c:dc08:: with SMTP id t8mr3712099wmg.139.1576069657268; 
 Wed, 11 Dec 2019 05:07:37 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v4sm6071260wml.2.2019.12.11.05.07.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 05:07:36 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: wait for all rings to drain before runtime
 suspending
To: zhoucm1 <david1.zhou@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20191210220804.1376829-1-alexander.deucher@amd.com>
 <7c81d222-16d4-ad6f-a8f4-d90855930fc1@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <efcaaa66-c926-af7c-d1f1-4082b989e255@gmail.com>
Date: Wed, 11 Dec 2019 14:07:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7c81d222-16d4-ad6f-a8f4-d90855930fc1@amd.com>
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

QW0gMTEuMTIuMTkgdW0gMDM6MjYgc2NocmllYiB6aG91Y20xOgo+Cj4gT24gMjAxOS8xMi8xMSDk
uIrljYg2OjA4LCBBbGV4IERldWNoZXIgd3JvdGU6Cj4+IEFkZCBhIHNhZmV0eSBjaGVjayB0byBy
dW50aW1lIHN1c3BlbmQgdG8gbWFrZSBzdXJlIGFsbCBvdXRzdGFuZGluZwo+PiBmZW5jZXMgaGF2
ZSBzaWduYWxlZCBiZWZvcmUgd2Ugc3VzcGVuZC7CoCBEb2Vzbid0IGZpeCBhbnkga25vd24gaXNz
dWUuCj4+Cj4+IFdlIGFscmVhZHkgZG8gdGhpcyB2aWEgdGhlIGZlbmNlIGRyaXZlciBzdXNwZW5k
IGZ1bmN0aW9uLCBidXQgd2UKPj4ganVzdCBmb3JjZSBjb21wbGV0aW9uIHJhdGhlciB0aGFuIGJh
aWxpbmcuwqAgVGhpcyBiYWlscyBvbiBydW50aW1lCj4+IHN1c3BlbmQgc28gd2UgY2FuIHRyeSBh
Z2FpbiBsYXRlciBvbmNlIHRoZSBmZW5jZXMgYXJlIHNpZ25hbGVkIHRvCj4+IGF2b2lkIG1pc3Np
bmcgYW55IG91dHN0YW5kaW5nIHdvcmsuCj4KPiBUaGUgaWRlYSBzb3VuZHMgT0sgdG8gbWUsIGJ1
dCBpZiB5b3Ugd2FudCB0byBkcmFpbiB0aGUgcmluZ3MsIHlvdSAKPiBzaG91bGQgbWFrZSBzdXJl
IG5vIG1vcmUgc3VibWlzc2lvbiwgcmlnaHQ/Cj4KPiBTbyB5b3Ugc2hvdWxkIHBhcmsgYWxsIHNj
aGVkdWxlcnMgYmVmb3JlIHdhaXRpbmcgZm9yIGFsbCBvdXRzdGFuZGluZyAKPiBmZW5jZXMgY29t
cGxldGVkLgoKQXQgdGhhdCBwb2ludCB1c2Vyc3BhY2Ugc2hvdWxkIGFscmVhZHkgYmUgcHV0IHRv
IGhvbGQsIHNvIG5vIG5ldyAKc3VibWlzc2lvbnMuIEJ1dCBpdCBwcm9iYWJseSB3b24ndCBodXJ0
IHN0b3BwaW5nIHRoZSBzY2hlZHVsZXIgYW55d2F5LgoKQnV0IGFub3RoZXIgaXNzdWUgSSBzZWUg
aXMgd2hhdCBoYXBwZW5zIGlmIHdlIGxvY2tlZCB1cCB0aGUgaGFyZHdhcmU/CgpDaHJpc3RpYW4u
Cgo+Cj4gLURhdmlkCj4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Rydi5jIHwgMTIgKysrKysrKysrKystCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAx
MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+IGluZGV4IDJmMzY3MTQ2YzcyYy4uODEzMjJiMGE4YWNm
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMK
Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCj4+IEBAIC0x
MjE0LDEzICsxMjE0LDIzIEBAIHN0YXRpYyBpbnQgCj4+IGFtZGdwdV9wbW9wc19ydW50aW1lX3N1
c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQo+PiDCoMKgwqDCoMKgIHN0cnVjdCBwY2lfZGV2ICpw
ZGV2ID0gdG9fcGNpX2RldihkZXYpOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZGV2aWNlICpk
cm1fZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0gZHJtX2Rldi0+ZGV2X3ByaXZhdGU7Cj4+IC3CoMKgwqAgaW50IHJl
dDsKPj4gK8KgwqDCoCBpbnQgcmV0LCBpOwo+PiDCoCDCoMKgwqDCoMKgIGlmICghYWRldi0+cnVu
cG0pIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHBtX3J1bnRpbWVfZm9yYmlkKGRldik7Cj4+IMKg
wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVCVVNZOwo+PiDCoMKgwqDCoMKgIH0KPj4gwqAgK8Kg
wqDCoCAvKiB3YWl0IGZvciBhbGwgcmluZ3MgdG8gZHJhaW4gYmVmb3JlIHN1c3BlbmRpbmcgKi8K
Pj4gK8KgwqDCoCBmb3IgKGkgPSAwOyBpIDwgQU1ER1BVX01BWF9SSU5HUzsgaSsrKSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcgPSBhZGV2LT5yaW5nc1tpXTsK
Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChyaW5nICYmIHJpbmctPnNjaGVkLnJlYWR5KSB7Cj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IGFtZGdwdV9mZW5jZV93YWl0X2VtcHR5KHJpbmcp
Owo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUJVU1k7Cj4+ICvCoMKgwqDCoMKgwqDCoCB9Cj4+ICvC
oMKgwqAgfQo+PiArCj4+IMKgwqDCoMKgwqAgaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9j
byhkcm1fZGV2KSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRybV9kZXYtPnN3aXRjaF9wb3dlcl9z
dGF0ZSA9IERSTV9TV0lUQ0hfUE9XRVJfQ0hBTkdJTkc7Cj4+IMKgwqDCoMKgwqAgZHJtX2ttc19o
ZWxwZXJfcG9sbF9kaXNhYmxlKGRybV9kZXYpOwo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
