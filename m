Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20302C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 12:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB5364F78
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 12:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB5364F78
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 978D56E9F7;
	Fri, 19 Mar 2021 12:21:06 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 745D16E9F7
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 12:21:05 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id b16so10519017eds.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Mar 2021 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=ErdMB6M8YFDNmrg/PNRQgziRKz8pU1IvxFmH3Nuy2CU=;
 b=Fzo1TBTIaMLgZYlCYf7A6/v3tTzg5mdJPjEl5RbU2CNmngxzp4mba9+6Bdup5FZ0w2
 WnL0ixJrdntmaIg2NwigiGoFF8m9k5BsOEYljL86QVGBvpji3mMPTN5fXcASvvU7hKdQ
 0AmY1k2B5eXhoCZOvWdQ9Vg4qOEx0LX1I7bs6jfnyCHGJr4sD5qxfoPQr4BySZOlxmsT
 RPO9V859R0MKhDL2FTyvOiXc47Vl0563U1RTZ9SVQXxHYtTKwxxEd3Z0xytJZLeu9dyQ
 XbkREa3uwE290nSW1D/58m3j+Wp+vjrTSAIuprWVqhIbYv1b54x7eBNB2m1rSNz5v+0n
 AfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ErdMB6M8YFDNmrg/PNRQgziRKz8pU1IvxFmH3Nuy2CU=;
 b=my6Rzle+iT2a3XAFb7SViqQjAx0ZOkOBgMqQydU3kvCPCYApma0P+6bwUgKgx5rMVn
 EaPiV7C7OQFR36X3sc31sSVQjD9u+1qF+Wc1qL/vh6sbgNcWGHpKb78jPHDO4JJL33u+
 B12OjS3QFpdVIpm9UdK7TJ5tOKV2ZxZrAfRJ3kSoUm0x7EN8SWxzWuJDjXnnOPaHkXMw
 zMN8d6KQTOzHwqxBkRx0n/NjJYfAguiYaqRbD07yuLW5JRJu9NPe12VXfzXvYafk+lUi
 tuGsDpC6EGn8QN7sEEFJNPn/4Vm1x87KrPBSVKUqdW+fKyTocPoF4eYA7FFfHp1lcM4p
 YlnA==
X-Gm-Message-State: AOAM530mP6IyTf88qxf8kcZMhrsBlnEujs8XjWVrsTfvdj3yifBt/+gB
 kLt3edPDA72dv5KBlYE7lxX1VbCjD4E=
X-Google-Smtp-Source: ABdhPJz44JAsLGkcZ+/6ABviwjN7MegKIaIoXgNEy5aG/8mWEF84yfQZAQoKTn0h6fjpSn/Rj/LECQ==
X-Received: by 2002:aa7:d687:: with SMTP id d7mr9012211edr.118.1616156464108; 
 Fri, 19 Mar 2021 05:21:04 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:2273:f2cc:fdad:3191?
 ([2a02:908:1252:fb60:2273:f2cc:fdad:3191])
 by smtp.gmail.com with ESMTPSA id a3sm3639183ejv.40.2021.03.19.05.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Mar 2021 05:21:03 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix the page fault issue in amdgpu_irq_fini
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210318114812.407295-1-Emily.Deng@amd.com>
 <173acde7-b3ed-9a3f-5191-60158af45895@gmail.com>
 <BY5PR12MB4115813BBC9E921FD6C24AB48F689@BY5PR12MB4115.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9a451561-c781-5818-4275-ca0f0fc543b5@gmail.com>
Date: Fri, 19 Mar 2021 13:21:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4115813BBC9E921FD6C24AB48F689@BY5PR12MB4115.namprd12.prod.outlook.com>
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

CgpBbSAxOS4wMy4yMSB1bSAwMjozOCBzY2hyaWViIERlbmcsIEVtaWx5Ogo+IFtBTUQgT2ZmaWNp
YWwgVXNlIE9ubHkgLSBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0KPgo+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNo
dHp1bWVya2VuQGdtYWlsLmNvbT4KPj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE4LCAyMDIxIDc6
NTIgUE0KPj4gVG86IERlbmcsIEVtaWx5IDxFbWlseS5EZW5nQGFtZC5jb20+OyBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kZ3B1OiBG
aXggdGhlIHBhZ2UgZmF1bHQgaXNzdWUgaW4gYW1kZ3B1X2lycV9maW5pCj4+Cj4+IEFtIDE4LjAz
LjIxIHVtIDEyOjQ4IHNjaHJpZWIgRW1pbHkgRGVuZzoKPj4+IEZvciBzb21lIHNvdXJjZSwgaXQg
d2lsbCBiZSBzaGFyZWQgYnkgc29tZSBjbGllbnQgSUQgYW5kIHNvdXJjZSBJRC4KPj4+IFRvIGZp
eCB0aGUgcGFnZSBmYXVsdCBpc3N1ZSwgc2V0IGFsbCB0aG9zZSB0byBudWxsLgo+Pj4KPj4+IFNp
Z25lZC1vZmYtYnk6IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4KPj4+IC0tLQo+Pj4g
ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jIHwgMTYgKysrKysrKysr
KysrKy0tLQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDMgZGVsZXRp
b25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9pcnEuYwo+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMK
Pj4+IGluZGV4IGFmMDI2MTA5NDIxYS4uNjIzYjFhYzYyMzFkIDEwMDY0NAo+Pj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lycS5jCj4+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaXJxLmMKPj4+IEBAIC0zNTksNyArMzU5LDcgQEAgaW50
IGFtZGdwdV9pcnFfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4+ICAgICAqLwo+
Pj4gICAgdm9pZCBhbWRncHVfaXJxX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4+
PiAgICB7Cj4+PiAtdW5zaWduZWQgaSwgajsKPj4+ICt1bnNpZ25lZCBpLCBqLCBtLCBuOwo+Pj4K
Pj4+ICAgIGlmIChhZGV2LT5pcnEuaW5zdGFsbGVkKSB7Cj4+PiAgICBkcm1faXJxX3VuaW5zdGFs
bChhZGV2X3RvX2RybShhZGV2KSk7Cj4+PiBAQCAtMzgwLDEyICszODAsMjIgQEAgdm9pZCBhbWRn
cHVfaXJxX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UKPj4gKmFkZXYpCj4+PiAgICBpZiAoIXNy
YykKPj4+ICAgIGNvbnRpbnVlOwo+Pj4KPj4+IC1rZnJlZShzcmMtPmVuYWJsZWRfdHlwZXMpOwo+
Pj4gK2lmIChzcmMtPmVuYWJsZWRfdHlwZXMpCj4+PiAra2ZyZWUoc3JjLT5lbmFibGVkX3R5cGVz
KTsKPj4gQSBOVUxMIGNoZWNrIGJlZm9yZSBrZnJlZSgpIGlzIHVuZWNlc3NhcnkgYW5kIHdpbGwg
YmUgY29tcGxhaW5lZCBhYm91dCBieSB0aGUKPj4gc3RhdGljIGNoZWNrZXJzLgo+IFNvcnJ5LCB3
aWxsIHJlbW92ZSB0aGlzLgo+Pj4gKwo+Pj4gICAgc3JjLT5lbmFibGVkX3R5cGVzID0gTlVMTDsK
Pj4+ICsKPj4gVW5yZWxhdGVkIHdoaXRlIHNwYWNlIGNoYW5nZS4KPiBTb3JyeSwgd2lsbCByZW1v
dmUgdGhpcyBhbHNvLgo+Pj4gICAgaWYgKHNyYy0+ZGF0YSkgewo+Pj4gICAga2ZyZWUoc3JjLT5k
YXRhKTsKPj4+ICAgIGtmcmVlKHNyYyk7Cj4+PiAtYWRldi0+aXJxLmNsaWVudFtpXS5zb3VyY2Vz
W2pdID0gTlVMTDsKPj4+ICt9Cj4+PiArCj4+PiArZm9yIChtID0gMDsgbSA8IEFNREdQVV9JUlFf
Q0xJRU5USURfTUFYOyArK20pIHsKPj4+ICtpZiAoIWFkZXYtPmlycS5jbGllbnRbbV0uc291cmNl
cykKPj4+ICtjb250aW51ZTsKPj4+ICtmb3IgKG4gPSAwOyBuIDwgQU1ER1BVX01BWF9JUlFfU1JD
X0lEOwo+PiArK24pCj4+PiAraWYgKGFkZXYtPmlycS5jbGllbnRbbV0uc291cmNlc1tuXSA9PQo+
PiBzcmMpCj4+PiArYWRldi0+aXJxLmNsaWVudFttXS5zb3VyY2VzW25dCj4+ID0gTlVMTDsKPj4K
Pj4gSHVpIHdoYXQ/IFRoZSBtZW1vcnkgeW91IHNldCB0byBOVUxMIGhlcmUgaXMgZnJlZWQgb24g
dGhlIGxpbmUgYmVsb3cuCj4+Cj4+IEFjY2Vzc2luZyBpdCBhZnRlciB0aGF0IHdvdWxkIGJlIGls
bGVnYWwsIHNvIHdoeSBkbyB5b3Ugd2FudCB0byBzZXQgaXQgdG8gTlVMTD8KPiBbRW1pbHldIEl0
IGlzIGluIHRoZSBsb29wICJmb3IgKGogPSAwOyBqIDwgQU1ER1BVX01BWF9JUlFfU1JDX0lEOyAr
K2opIHsiLCBzaG91bGRuJ3QgaGF2ZSBiZWVuIGZyZWVkIGluIHRoaXMgbG9vcC4gT25seSBzZXQg
IiBhZGV2LT5pcnEuY2xpZW50W2ldLnNvdXJjZXNbal0gPSBOVUxMOyIgaXMgbm90IGVub3VnaCwK
PiBhcyBpdCBtYXliZSBoYXZlIG90aGVyIGNsaWVudCBJRCBhbmQgc3JjIElEIHdpbGwgc2hhcmUg
dGhlIHNhbWUgc3JjLiBBbHNvIG5lZWQgdG8gc2V0IHRob3NlIHRvIE5VTEwuCgpObywgdGhhdCBj
YW4ndCBoYXBwZW4uCgpJdCBpcyBpbGxlZ2FsIHRvIHVzZSBhIGR5bmFtaWMgYWxsb2NhdGVkIHNv
dXJjZSB3aXRoIG11bHRpcGxlIGNsaWVudCBJRCAKYW5kIHNyYyBJRC4gV2hlcmUgZG8geW91IHNl
ZSB0aGF0PwoKV2UgY291bGQgYWxzbyBwcm9iYWJseSBjb21wbGV0ZWx5IHJlbW92ZSB0aGlzIGZl
YXR1cmUgc2luY2UgaXQgaXMgdW51c2VkIAphcyBmYXIgYXMgSSBrbm93LgoKVGhhbmtzLApDaHJp
c3RpYW4uCgo+PiBDaHJpc3RpYW4uCj4+Cj4+PiAgICB9Cj4+PiAgICB9Cj4+PiAgICBrZnJlZShh
ZGV2LT5pcnEuY2xpZW50W2ldLnNvdXJjZXMpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
