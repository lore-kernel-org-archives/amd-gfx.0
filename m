Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA5C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 13:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B4664DD6
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 13:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B4664DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B276E5B2;
	Mon,  1 Feb 2021 13:59:24 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFDBE6E5C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 13:59:22 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id a9so6131703ejr.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Feb 2021 05:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=8UpoluN94lw/8pMjf0ExenXaneoV/LK4rBMKOtrDt0s=;
 b=DH+rTApo8Ghi1acGN9647Agxpy5Qawq1LniQ7waBkrdM5bHcShDGOA2ZuKNvQDSvbs
 SAb4OXqFKKaArGOJP3vyhw95cxMTEskwjrZyofhNTokPaq2piqZoPvHrShy0VeeCsU1H
 xojxkDWzDn0FUQthDxWdBTIAptrXWB/VVuDQIRLkxcku0fj+YzjNb5Gefb/FhHXbeYyO
 AlAs20ahzsa09bV9GPWIPtDD4Yxi6t85UxJEyLBVggCAz3yQ01zvlCfp2k1ZUQC2KP5q
 FdHajEceYcteFDz0/+zo2aLE1NeAysrOmcOide37rXeJ2encMcn/BqnZNJnocIqBBWwu
 1Vkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=8UpoluN94lw/8pMjf0ExenXaneoV/LK4rBMKOtrDt0s=;
 b=T/lHxRrlXQa/f46Z6jMYOzCOzx9lkt1AEN2eLp/5DFGYCaJ5b8Smg86gJS4VglcvWj
 nFvrSLuPSfmk+XqLX2yMFCRTlRSpH9zJs5U03Tc3pkD+Ij14437NvyWx2J3LKUM61521
 qjH/Dhj68gbR3cWDhdpJHaNetRLqh+JF/YvizGDygyCRvjY1FMcuQ7ZEyiQj4iUN/qKk
 LqOUWjF5/T0Yu5KOy+R8Mhcx5jNIBEZVYynhVw7zD9RSvhe/U1B2kJlUbyYL+to1HHRZ
 tvpYYoxzWiVFtUkKfVzTWMslfOBM/8b7wqIsQOSDQql2n8iY9EqmFAGRAtezrwA9owM/
 /eeA==
X-Gm-Message-State: AOAM533j+s6j/b5bSVtpI/Uh7NZcasr7am5S9Gcfh8D54RvknWyRhvFo
 qiRwMa/QrCKsoi8BHPjMG7s=
X-Google-Smtp-Source: ABdhPJxywG6rVF//tRiFmUq0fEV//EXoIB606wETXG5hAyJBPoJa18cFjf9W1Ykte+cf9PPuO7J2sw==
X-Received: by 2002:a17:907:9495:: with SMTP id
 dm21mr18003504ejc.462.1612187961292; 
 Mon, 01 Feb 2021 05:59:21 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id y11sm947835ejd.72.2021.02.01.05.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Feb 2021 05:59:20 -0800 (PST)
Subject: Re: [PATCH 3/3] drm/amdgpu: enable gfx wave limiting for high
 priority compute jobs
To: Nirmoy <nirmodas@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20210201120735.2970-1-nirmoy.das@amd.com>
 <20210201120735.2970-3-nirmoy.das@amd.com>
 <f2ed5848-5c26-3d60-0f57-2a918eff17e0@amd.com>
 <76da5ca4-8425-6beb-2284-0068b87a2db2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <90786e48-aa52-aa84-c1cc-8cc502cb02ea@gmail.com>
Date: Mon, 1 Feb 2021 14:59:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <76da5ca4-8425-6beb-2284-0068b87a2db2@amd.com>
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
Cc: Alexander.Deucher@amd.com, Alan.Harrison@amd.com, Felix.Kuehling@amd.com,
 ray.huang@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDEuMDIuMjEgdW0gMTQ6NTYgc2NocmllYiBOaXJtb3k6Cj4KPiBPbiAyLzEvMjEgMToxOSBQ
TSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4gQW0gMDEuMDIuMjEgdW0gMTM6MDcgc2Nocmll
YiBOaXJtb3kgRGFzOgo+Pj4gRW5hYmxlIGdmeCB3YXZlIGxpbWl0aW5nIGZvciBnZnggam9icyBi
ZWZvcmUgcHVzaGluZyBoaWdoIHByaW9yaXR5Cj4+PiBjb21wdXRlIGpvYnMgc28gdGhhdCBoaWdo
IHByaW9yaXR5IGNvbXB1dGUgam9icyBnZXRzIG1vcmUgcmVzb3VyY2VzCj4+PiB0byBmaW5pc2gg
ZWFybHkuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQu
Y29tPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIu
YyB8IDkgKysrKysrKysrCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspCj4+
Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pYi5j
IAo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+Pj4gaW5kZXgg
MDI0ZDBhNTYzYTY1Li5lZTQ4OTg5ZGZiNGMgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfaWIuYwo+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2liLmMKPj4+IEBAIC0xOTUsNiArMTk1LDEwIEBAIGludCBhbWRncHVfaWJf
c2NoZWR1bGUoc3RydWN0IGFtZGdwdV9yaW5nIAo+Pj4gKnJpbmcsIHVuc2lnbmVkIG51bV9pYnMs
Cj4+PiDCoMKgwqDCoMKgIGlmICgoaWItPmZsYWdzICYgQU1ER1BVX0lCX0ZMQUdfRU1JVF9NRU1f
U1lOQykgJiYgCj4+PiByaW5nLT5mdW5jcy0+ZW1pdF9tZW1fc3luYykKPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCByaW5nLT5mdW5jcy0+ZW1pdF9tZW1fc3luYyhyaW5nKTsKPj4+IMKgICvCoMKgwqAg
aWYgKHJpbmctPmZ1bmNzLT5lbWl0X3dhdmVfbGltaXQgJiYgam9iICYmCj4+PiArwqDCoMKgwqDC
oMKgwqAgam9iLT5iYXNlLnNfcHJpb3JpdHkgPj0gRFJNX1NDSEVEX1BSSU9SSVRZX0hJR0gpCj4+
PiArwqDCoMKgwqDCoMKgwqAgcmluZy0+ZnVuY3MtPmVtaXRfd2F2ZV9saW1pdChyaW5nLCB0cnVl
KTsKPj4KPj4gU2luY2Ugd2UgY2FuIG9ubHkgZG8gdGhpcyBmb3Igb25lIHJpbmcgYW55d2F5IHdl
IHNob3VsZCBwcm9iYWJseSAKPj4gY2hlY2sgdGhlIHJpbmcgcHJpb3JpdHkgaW5zdGVhZCBvZiB0
aGUgam9iIHByaW9yaXR5Lgo+Cj4KPgo+Pgo+PiBBbHRlcm5hdGl2ZWx5IHlvdSBjb3VsZCBwdXQg
dGhpcyBpbnRvIGJlZ2luX3VzZSBhbmQgZW5kX3VzZSBjYWxsYmFja3MgCj4+IG9mIHRoZSByaW5n
IGluc3RlYWQgb2YgYWRkaW5nIGFuIGV4dHJhIGNhbGxiYWNrIGZvciB0aGlzLgo+Cj4KPiBJIGRp
ZG4ndCBrbm93IGFib3V0IGJlZ2luX3VzZSBjYWxsYmFja3MuIEkgd2lsbCByZXNlbmQgd2l0aCBh
Ym92ZSAKPiBzdWdnZXN0ZWQgY2hhbmdlcy4KCldhaXQgYSBzZWNvbmQuIEkndmUganVzdCBkb3Vi
bGUgY2hlY2tlZCBzaW5jZSBiZWdpbi9lbmQgdXNlIHdhcyBhZGRlZCAKZm9yIHBvd2VyIG1hbmFn
ZW1lbnQgaGFuZGxpbmcuCgpTbyB5b3VyIGNhc2Ugd29uJ3Qgd29yayBoZXJlIHdpdGhvdXQgZnVy
dGhlciBjb2RlIGNoYW5nZS4KCkJldHRlciB0byBzdGljayB3aXRoIHlvdXIgY3VycmVudCBhcHBy
b2FjaCBhbmQganVzdCBjaGVjayB0aGUgcmluZyAKaW5zdGVhZCBvZiB0aGUgam9iLgoKQ2hyaXN0
aWFuLgoKPgo+Cj4gVGhhbmtzLAo+Cj4gTmlybW95Cj4KPgo+Pgo+PiBDaHJpc3RpYW4uCj4+Cj4+
PiArCj4+PiDCoMKgwqDCoMKgIGlmIChyaW5nLT5mdW5jcy0+aW5zZXJ0X3N0YXJ0KQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHJpbmctPmZ1bmNzLT5pbnNlcnRfc3RhcnQocmluZyk7Cj4+PiDCoCBA
QCAtMjk1LDYgKzI5OSwxMSBAQCBpbnQgYW1kZ3B1X2liX3NjaGVkdWxlKHN0cnVjdCBhbWRncHVf
cmluZyAKPj4+ICpyaW5nLCB1bnNpZ25lZCBudW1faWJzLAo+Pj4gwqDCoMKgwqDCoCByaW5nLT5j
dXJyZW50X2N0eCA9IGZlbmNlX2N0eDsKPj4+IMKgwqDCoMKgwqAgaWYgKHZtICYmIHJpbmctPmZ1
bmNzLT5lbWl0X3N3aXRjaF9idWZmZXIpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X3Jp
bmdfZW1pdF9zd2l0Y2hfYnVmZmVyKHJpbmcpOwo+Pj4gKwo+Pj4gK8KgwqDCoCBpZiAocmluZy0+
ZnVuY3MtPmVtaXRfd2F2ZV9saW1pdCAmJiBqb2IgJiYKPj4+ICvCoMKgwqDCoMKgwqDCoCBqb2It
PmJhc2Uuc19wcmlvcml0eSA+PSBEUk1fU0NIRURfUFJJT1JJVFlfSElHSCkKPj4+ICvCoMKgwqDC
oMKgwqDCoCByaW5nLT5mdW5jcy0+ZW1pdF93YXZlX2xpbWl0KHJpbmcsIGZhbHNlKTsKPj4+ICsK
Pj4+IMKgwqDCoMKgwqAgYW1kZ3B1X3JpbmdfY29tbWl0KHJpbmcpOwo+Pj4gwqDCoMKgwqDCoCBy
ZXR1cm4gMDsKPj4+IMKgIH0KPj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
