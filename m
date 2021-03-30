Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64949C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7DB461935
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DB461935
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79F1F6E867;
	Tue, 30 Mar 2021 07:24:20 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBD96E867
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 07:24:18 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id ce10so23282046ejb.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 00:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=NRTr89/uo1J08FjxIx0B9LontMFQSiaCMlHZYdurkK4=;
 b=IMOHk9eHKsVTnhTB1wWEAh/DhlNunQ+IE2QQLmwwCrMO2d9k5qgRbnH5PyK1lzR0sy
 cbYF+BBMs5kb3QuejcAYAH/ywXoffQjjgS6izW6oz/APL/ptxW4etR4Jgk8hsfZOysrL
 Krk8ROXcBlGn6TpJZ6FB5rEVFg3EVIhRKnEl1G0POK2x/UMswdu0K57XJgLZ22keGj5M
 pF9bd8HwS82ap3tAPVt8gJuux0pFttd6MkQ6UQWJ9fGxvgfa7oMlAAGpPzMuyK2ImuwU
 1Fzj/OZgpCVccZGH3q/CjHvXd1j1oFMLefwmurtqwzua+KhIH5nagU7PVSyhOuo6fFOe
 8OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=NRTr89/uo1J08FjxIx0B9LontMFQSiaCMlHZYdurkK4=;
 b=W7s0cp66ORxiz707vRL7Px2H8Hsp2s8wanN5UKvoSQc/fdCIQ8g/P7hrKgq80gMUjd
 51jxn+/kUZ+jJ6biD4FJ6XBnOpJ5kLljt2ha7766Z7Bby0amHGt90JWZL09ORJKyIk4/
 tvhazc5pr5qHTigGJAqsMQS+mI4oQ3sKd4DbbLm1Cwsb9MdG1ZsuyJEWSeSIq8HuH7am
 2d2HmxOk7knwZ1v3lRH7h6S5DB+0ZSvHbkzz8BewGjUrRiJZcWDU6CLWzS8WER7p/Xuy
 lte2RH6yxKMruiqWBZQ5ZsdhAL36+wYkVBaSFxt3mFu+XQ0/aISK+LtJz6hisPon6ray
 6vSA==
X-Gm-Message-State: AOAM530rct6MvcTECRjAh2+QWaJyOVObwxohWlXFXLV2LtbKDF2yRCiO
 r2VKlIijTsRkDm/FY9kgVug=
X-Google-Smtp-Source: ABdhPJyg9kHc5/BfVqCoQk5VV08/8cZjqhZpUqaCps6pyYHNEJ2GCg/2HnaJ/9zY6yCjxcWpkLAfAg==
X-Received: by 2002:a17:906:6a06:: with SMTP id
 o6mr31414821ejr.306.1617089057673; 
 Tue, 30 Mar 2021 00:24:17 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c?
 ([2a02:908:1252:fb60:8ca4:a46e:6aa7:208c])
 by smtp.gmail.com with ESMTPSA id jj16sm9459596ejc.19.2021.03.30.00.24.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 00:24:17 -0700 (PDT)
Subject: Re: [PATCH 5/6] drm/amdgpu: Disable RPTR write back for navi12
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <Alexander.Deucher@amd.com>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-5-Emily.Deng@amd.com>
 <4ccce70f-bd74-87ab-a280-5c45b74a7d39@gmail.com>
 <BY5PR12MB4115EEED8927FFF414AF966F8F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <c358ac16-166e-ba81-3cfb-b51a4adafb9f@gmail.com>
Date: Tue, 30 Mar 2021 09:24:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4115EEED8927FFF414AF966F8F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
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

QW0gMzAuMDMuMjEgdW0gMDk6MjAgc2NocmllYiBEZW5nLCBFbWlseToKPiBbQU1EIE9mZmljaWFs
IFVzZSBPbmx5IC0gSW50ZXJuYWwgRGlzdHJpYnV0aW9uIE9ubHldCj4KPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0KPj4gRnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2tvZW5pZy5sZWljaHR6
dW1lcmtlbkBnbWFpbC5jb20+Cj4+IFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDMwLCAyMDIxIDM6MTMg
UE0KPj4gVG86IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+PiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNl0gZHJtL2FtZGdwdTog
RGlzYWJsZSBSUFRSIHdyaXRlIGJhY2sgZm9yIG5hdmkxMgo+Pgo+Pgo+Pgo+PiBBbSAzMC4wMy4y
MSB1bSAwNjo0MSBzY2hyaWViIEVtaWx5IERlbmc6Cj4+PiBJdCB3aWxsIGhpdCByYW1kb21seSBz
ZG1hIGhhbmcsIGFuZCBwZW5kaW5nIG9uIHV0Y2wyIGFkZHJlc3MKPj4+IHRyYW5zbGF0aW9uIHdo
ZW4gYWNjZXNzIHRoZSBSUFRSIHBvbGxpbmcgYWRkcmVzcy4KPj4+Cj4+PiBBY2NvcmRpbmcgc2Rt
YSBmaXJtd2FyZSB0ZWFtIG1lbnRpb25lZCwgdGhlIFJQVFIgd3JpdGViYWNrIGlzIGRvbmUgYnkK
Pj4+IGhhcmR3YXJlIGF1dG9tYXRpY2FsbHksIGFuZCB3aWxsIGhpdCBpc3N1ZSB3aGVuIGNsb2Nr
IGdhdGluZyBvY2N1cnMuCj4+PiBTbyBzdG9wIHVzaW5nIHRoZSBycHRyIHdyaXRlIGJhY2sgZm9y
IHNkbWE1LjAuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogRW1pbHkgRGVuZyA8RW1pbHkuRGVuZ0Bh
bWQuY29tPgo+Pj4gLS0tCj4+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1
XzAuYyB8IDE4ICsrKysrKysrKysrKy0tLS0tLQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEyIGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NkbWFfdjVfMC5jCj4+PiBpbmRleCA5MjBmYzZkNGExMjcuLjYzZTRhNzgxODFiOCAx
MDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCj4+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y1XzAuYwo+Pj4gQEAgLTI5
OCwxMyArMjk4LDE5IEBAIHN0YXRpYyB2b2lkCj4+IHNkbWFfdjVfMF9yaW5nX3BhdGNoX2NvbmRf
ZXhlYyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsCj4+PiAgICAgKi8KPj4+ICAgIHN0YXRpYyB1
aW50NjRfdCBzZG1hX3Y1XzBfcmluZ19nZXRfcnB0cihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcp
Cj4+PiAgICB7Cj4+PiAtdTY0ICpycHRyOwo+Pj4gK3N0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gcmluZy0+YWRldjsKPj4+ICt1NjQgcnB0cjsKPj4+ICt1MzIgbG93Yml0LCBoaWdoYml0Owo+
Pj4gKwo+Pj4gK2xvd2JpdCA9IFJSRUczMihzZG1hX3Y1XzBfZ2V0X3JlZ19vZmZzZXQoYWRldiwg
cmluZy0+bWUsCj4+IG1tU0RNQTBfR0ZYX1JCX1JQVFIpKTsKPj4+ICtoaWdoYml0ID0gUlJFRzMy
KHNkbWFfdjVfMF9nZXRfcmVnX29mZnNldChhZGV2LCByaW5nLT5tZSwKPj4+ICttbVNETUEwX0dG
WF9SQl9SUFRSX0hJKSk7Cj4+IFRoYXQgd29uJ3Qgd29yayBsaWtlIHRoaXMuCj4+Cj4+IFdlIGhh
dmUgdGhlIHJlYWRwb2ludGVyIHdyaXRlYmFjayBiZWNhdXNlIHdlIG90aGVyd2lzZSBjYW4ndCBn
dWFyYW50ZWUKPj4gdGhhdCB0aGUgdHdvIDMyYml0IHZhbHVlcyByZWFkIGZyb20gdGhlIHJlZ2lz
dGVycyBhcmUgY29oZXJlbnQuCj4+Cj4+IEluIG90aGVyIHdvcmRzIGl0IGNhbiBiZSB0aGF0IHRo
ZSBoaSBycHRyIGlzIGFscmVhZHkgd3JhcHBlZCBhcm91bmQgd2hpbGUgdGhlCj4+IGxvIGlzIHN0
aWxsIHRoZSBvbGQgdmFsdWUuCj4+Cj4+IFdoeSBleGFjdGx5IGRvZXNuJ3QgdGhlIHdyaXRlYmFj
ayB3b3JrPwo+Pgo+PiBDaHJpc3RpYW4uCj4gSXNzdWUgb2NjdXJzLCB3aGVuIG9jY3VycyBjbG9j
a2dhdGluZywgYXQgdGhlIHNhbWUgdGltZSwgdGhlIHJwdHIgd3JpdGUgYmFjayBvY2N1cnMuIEF0
IHRoaXMgdGltZSwgdGhlIHV0Y2wyIHRyYW5zbGF0aW9uIHdpbGwgaGFuZy4KCk1obSwgY3JhcC4g
QWxleCBhcmUgeW91IHVwIHRvIGRhdGUgb24gdGhpcyBidWc/CgpJJ20gbm90IGFuIGV4cGVydCBv
biB0aGUgU0RNQSwgYnV0IG15IGxhc3Qgc3RhdHVzIGlzIHRoYXQgd3JpdGViYWNrIGlzIAptYW5k
YXRvcnkgd2hlbiB3ZSB1c2UgNjRiaXQgcnB0ci93cHRyLgoKT3RoZXJ3aXNlIHdlIG5lZWQgYSB3
b3JrYXJvdW5kIGhvdyB0byByZWFkIGEgY29uc2lzdGVudCA2NGJpdCBycHRyIGZyb20gCnR3byAz
MmJpdCByZWdpc3RlcnMuCgpDYW4geW91IGNoZWNrIHRoZSByZWdpc3RlciBkb2N1bWVudGF0aW9u
IGlmIHRoZXJlIGlzIGFueSBkb3VibGUgCmJ1ZmZlcmluZyBvciBzdHVmZiBsaWtlIHRoYXQ/CgpD
aHJpc3RpYW4uCgo+Pj4gLS8qIFhYWCBjaGVjayBpZiBzd2FwcGluZyBpcyBuZWNlc3Nhcnkgb24g
QkUgKi8KPj4+IC1ycHRyID0gKCh1NjQgKikmcmluZy0+YWRldi0+d2Iud2JbcmluZy0+cnB0cl9v
ZmZzXSk7Cj4+PiArcnB0ciA9IGhpZ2hiaXQ7Cj4+PiArcnB0ciA9IHJwdHIgPDwgMzI7Cj4+PiAr
cnB0ciB8PSBsb3diaXQ7Cj4+Pgo+Pj4gLURSTV9ERUJVRygicnB0ciBiZWZvcmUgc2hpZnQgPT0g
MHglMDE2bGx4XG4iLCAqcnB0cik7Cj4+PiAtcmV0dXJuICgoKnJwdHIpID4+IDIpOwo+Pj4gK0RS
TV9ERUJVRygicnB0ciBiZWZvcmUgc2hpZnQgPT0gMHglMDE2bGx4XG4iLCBycHRyKTsKPj4+ICty
ZXR1cm4gKHJwdHIgPj4gMik7Cj4+PiAgICB9Cj4+Pgo+Pj4gICAgLyoqCj4+PiBAQCAtNzAyLDcg
KzcwOCw3IEBAIHN0YXRpYyBpbnQgc2RtYV92NV8wX2dmeF9yZXN1bWUoc3RydWN0Cj4+IGFtZGdw
dV9kZXZpY2UgKmFkZXYpCj4+PiAgICBXUkVHMzIoc2RtYV92NV8wX2dldF9yZWdfb2Zmc2V0KGFk
ZXYsIGksCj4+IG1tU0RNQTBfR0ZYX1JCX1JQVFJfQUREUl9MTyksCj4+PiAgICAgICAgICAgbG93
ZXJfMzJfYml0cyhhZGV2LT53Yi5ncHVfYWRkciArIHdiX29mZnNldCkgJgo+PiAweEZGRkZGRkZD
KTsKPj4+IC1yYl9jbnRsID0gUkVHX1NFVF9GSUVMRChyYl9jbnRsLCBTRE1BMF9HRlhfUkJfQ05U
TCwKPj4gUlBUUl9XUklURUJBQ0tfRU5BQkxFLCAxKTsKPj4+ICtyYl9jbnRsID0gUkVHX1NFVF9G
SUVMRChyYl9jbnRsLCBTRE1BMF9HRlhfUkJfQ05UTCwKPj4+ICtSUFRSX1dSSVRFQkFDS19FTkFC
TEUsIDApOwo+Pj4KPj4+ICAgIFdSRUczMihzZG1hX3Y1XzBfZ2V0X3JlZ19vZmZzZXQoYWRldiwg
aSwKPj4gbW1TRE1BMF9HRlhfUkJfQkFTRSksIHJpbmctPmdwdV9hZGRyID4+IDgpOwo+Pj4gICAg
V1JFRzMyKHNkbWFfdjVfMF9nZXRfcmVnX29mZnNldChhZGV2LCBpLAo+PiBtbVNETUEwX0dGWF9S
Ql9CQVNFX0hJKSwKPj4+IHJpbmctPmdwdV9hZGRyID4+IDQwKTsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
