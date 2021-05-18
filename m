Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393D3C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F057A6109E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 13:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F057A6109E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCBC6EB6A;
	Tue, 18 May 2021 13:13:13 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6693B6EB6A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 13:13:12 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id f1so11085640edt.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 06:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=mb3VE/xiZa9jQ10q5FaRe7+k+J2RR81c4iJFXmfHPdE=;
 b=HzFy1suCYaI6xFe3Wb+RcWqJ+qdmN3EaFqIgyrEVmmUivs0cjfGydYALxbEaxXkBKh
 M05WO2A7+zmdMadkoQIOFOddZjLqsEpAwMhsLCB8xg8NWecuHacF153XCirl+ZMin8F8
 WUdjpE23whwfsq1wX/Tsym9sbrS7mvmnv8sjTY2GXEDo+fEkK6sBap/x3bY5K1xF+M9C
 mdonjjmJ4aPFIdlE4ASK68Q1qD0gZB22FIOuUVkvOywohcDLb+xZBbQGLEyrcY3GE42Q
 /vXorj20dOVIdL0t7DYy1mcqMlOTZUpcJ6+xzMr1OWNyqHPNZRKg43OqR6/NeLs81II+
 2zhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=mb3VE/xiZa9jQ10q5FaRe7+k+J2RR81c4iJFXmfHPdE=;
 b=nM/u9W0vc104/Y9/bbbT/paobEazO+C9Bs4Ft2EtMSSKzL5WNi0yw+z/N9fd/nZobg
 pLju/i0SkhosM+K7C7CYIrlrPca5xUZhLjgE+rQBRqxB5t+vsqQUqV8CQqw02F40ZcLa
 7UFqkCaN/RCMIKh15P7rXkdsbiQ2bg8p3nNk0JoOGxDjWEbtXfIZfPcZt3Pa8ZmvHSCt
 SqZdofzDGaGJe1GtHlzcNHDTod1I8kn6mANv2mhtzpHZGIaCfWbvrf+0xDSAx/ySvwHB
 rD2nVqLgs4YUY218Dt/MynViVTFQK3GY2hmU71wXB87sDp9V48e1eAiq6bT412Af2bLP
 COqg==
X-Gm-Message-State: AOAM533ouX5B4jEsUhCXPqf+TmQJquJ1GaNTaQGsQGKGueXpb3B4PtUv
 UzY88PLiMutSaLNQ9y2ZdAI=
X-Google-Smtp-Source: ABdhPJz8V/0AXutvkho6Gg3JOCzeKGGLCJtR5ZQ5jRlmY+ge4Nq1wxmqI27LdOweTph+pzfnxvreZQ==
X-Received: by 2002:a05:6402:416:: with SMTP id
 q22mr7076833edv.204.1621343591067; 
 Tue, 18 May 2021 06:13:11 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8470:36a5:2010:f0c4?
 ([2a02:908:1252:fb60:8470:36a5:2010:f0c4])
 by smtp.gmail.com with ESMTPSA id y2sm10161559ejg.123.2021.05.18.06.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 May 2021 06:13:10 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Fix a use-after-free
To: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210518030041.2228-1-xinhui.pan@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <67bf0c1c-ad9f-7344-b6dd-60f0fe8614c8@gmail.com>
Date: Tue, 18 May 2021 15:13:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210518030041.2228-1-xinhui.pan@amd.com>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMDUuMjEgdW0gMDU6MDAgc2NocmllYiB4aW5odWkgcGFuOgo+IGxvb2tzIGxpa2Ugd2Ug
Zm9yZ2V0IHRvIHNldCB0dG0tPnNnIHRvIE5VTEwuCj4gSGl0IHBhbmljIGJlbG93Cj4KPiBbIDEy
MzUuODQ0MTA0XSBnZW5lcmFsIHByb3RlY3Rpb24gZmF1bHQsIHByb2JhYmx5IGZvciBub24tY2Fu
b25pY2FsIGFkZHJlc3MgMHg2YjZiNmI2YjZiNmI3YjRiOiAwMDAwIFsjMV0gU01QIERFQlVHX1BB
R0VBTExPQyBOT1BUSQo+IFsgMTIzNS44NjIxODZdIENQVTogNSBQSUQ6IDI1MTgwIENvbW06IGtm
ZHRlc3QgVGFpbnRlZDogRyAgICAgICAgVyAgICAgICAgIDUuMTEuMCsgIzExNAo+IFsgMTIzNS44
NzA2MzNdIEhhcmR3YXJlIG5hbWU6IFN5c3RlbSBtYW51ZmFjdHVyZXIgU3lzdGVtIFByb2R1Y3Qg
TmFtZS9QUklNRSBaMzkwLUEsIEJJT1MgMTQwMSAxMS8yNi8yMDE5Cj4gWyAxMjM1Ljg4MDY4OV0g
UklQOiAwMDEwOl9fc2dfZnJlZV90YWJsZSsweDU1LzB4OTAKPiBbIDEyMzUuODg1NjU0XSBDb2Rl
OiAzOSBjNiA3NyAxYyA0MSBjNyA0NiAwYyAwMCAwMCAwMCAwMCA4NSBkMiA3NCA0NiA0OSBjNyAw
NiAwMCAwMCAwMCAwMCA1YiA0MSA1YyA0MSA1ZCA0MSA1ZSA1ZCBjMyA4ZCA0OCBmZiA0OSA4OSBj
OCA0OCBjMSBlMSAwNSA8NDg+IDhiIDFjIDBmIDQ0IDI5IGM2IDQxIDg5IDc2IDBjIDQ4IDgzIGUz
IGY4Cj4gWyAxMjM1LjkwNjA4NF0gUlNQOiAwMDAwOmZmZmZhZDFjNDMwY2ZiZDAgRUZMQUdTOiAw
MDAxMDIwMgo+IFsgMTIzNS45MTE2NzFdIFJBWDogMDAwMDAwMDAwMDAwMDA4MCBSQlg6IGZmZmY5
M2UyNjZkMmU2ZDggUkNYOiAwMDAwMDAwMDAwMDAwZmUwCj4gWyAxMjM1LjkxOTM5M10gUkRYOiAw
MDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDBhNTZiNmI2YiBSREk6IDZiNmI2YjZiNmI2YjZi
NmIKPiBbIDEyMzUuOTI3MTkwXSBSQlA6IGZmZmZhZDFjNDMwY2ZiZjAgUjA4OiAwMDAwMDAwMDAw
MDAwMDdmIFIwOTogMDAwMDAwMDAwMDAwMDAwMQo+IFsgMTIzNS45MzQ5NzBdIFIxMDogMDAwMDAw
MDAwMDAwMDAwMSBSMTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiAwMDAwMDAwMDAwMDAwMDgwCj4g
WyAxMjM1Ljk0Mjc2Nl0gUjEzOiBmZmZmZmZmZjllN2ZlOWYwIFIxNDogZmZmZjkzZTIwYzM0ODhi
MCBSMTU6IGZmZmY5M2UyNzBiYzhiMjAKPiBbIDEyMzUuOTUwNTYzXSBGUzogIDAwMDA3ZjUwMTNj
YTYzYzAoMDAwMCkgR1M6ZmZmZjkzZjA3NTIwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAw
MDAwCj4gWyAxMjM1Ljk1OTQwNF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAw
MDAwMDA4MDA1MDAzMwo+IFsgMTIzNS45NjU2ODNdIENSMjogMDAwMDdmZjQ0YjA4ZmFmZiBDUjM6
IDAwMDAwMDAyMGY4NGUwMDIgQ1I0OiAwMDAwMDAwMDAwMzcwNmUwCj4gWyAxMjM1Ljk3MzQ3Ml0g
RFIwOiAwMDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAw
MDAwMDAwMDAKPiBbIDEyMzUuOTgxMjY5XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAw
MDAwMGZmZmUwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMAo+IFsgMTIzNS45ODkwNzRdIENhbGwg
VHJhY2U6Cj4gWyAxMjM1Ljk5MTc1MV0gIHNnX2ZyZWVfdGFibGUrMHgxNy8weDIwCj4gWyAxMjM1
Ljk5NTY2N10gIGFtZGdwdV90dG1fYmFja2VuZF91bmJpbmQuY29sZCsweDRkLzB4ZjcgW2FtZGdw
dV0KPiBbIDEyMzYuMDAyMjg4XSAgYW1kZ3B1X3R0bV9iYWNrZW5kX2Rlc3Ryb3krMHgyOS8weDEz
MCBbYW1kZ3B1XQo+IFsgMTIzNi4wMDg0NjRdICB0dG1fdHRfZGVzdHJveSsweDFlLzB4MzAgW3R0
bV0KPiBbIDEyMzYuMDEzMDY2XSAgdHRtX2JvX2NsZWFudXBfbWVtdHlwZV91c2UrMHg1MS8weGEw
IFt0dG1dCj4gWyAxMjM2LjAxODc4M10gIHR0bV9ib19yZWxlYXNlKzB4MjYyLzB4YTUwIFt0dG1d
Cj4gWyAxMjM2LjAyMzU0N10gIHR0bV9ib19wdXQrMHg4Mi8weGQwIFt0dG1dCj4gWyAxMjM2LjAy
Nzc2Nl0gIGFtZGdwdV9ib191bnJlZisweDI2LzB4NTAgW2FtZGdwdV0KPiBbIDEyMzYuMDMyODA5
XSAgYW1kZ3B1X2FtZGtmZF9ncHV2bV9hbGxvY19tZW1vcnlfb2ZfZ3B1KzB4N2FhLzB4ZDkwIFth
bWRncHVdCj4gWyAxMjM2LjA0MDQwMF0gIGtmZF9pb2N0bF9hbGxvY19tZW1vcnlfb2ZfZ3B1KzB4
ZTIvMHgzMzAgW2FtZGdwdV0KPiBbIDEyMzYuMDQ2OTEyXSAga2ZkX2lvY3RsKzB4NDYzLzB4Njkw
IFthbWRncHVdCj4gWyAxMjM2LjA1MTYzMl0gID8ga2ZkX2Rldl9pc19sYXJnZV9iYXIrMHhmMC8w
eGYwIFthbWRncHVdCj4gWyAxMjM2LjA1NzM2MF0gIF9feDY0X3N5c19pb2N0bCsweDkxLzB4YzAK
PiBbIDEyMzYuMDYxNDU3XSAgZG9fc3lzY2FsbF82NCsweDM4LzB4OTAKPiBbIDEyMzYuMDY1Mzgz
XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhOQo+IFsgMTIzNi4wNzA5
MjBdIFJJUDogMDAzMzoweDdmNTAxM2RiZTUwYgo+Cj4gU2lnbmVkLW9mZi1ieTogeGluaHVpIHBh
biA8eGluaHVpLnBhbkBhbWQuY29tPgoKTWF5YmUgc2hvcnRlbiB0aGUgYmFja3RyYWNlIGEgYml0
LCB0aGUgcmVnaXN0ZXIgYW5kIGFic29sdXRlIGFkZHJlc3MgCmluZm9ybWF0aW9uIGFyZSBjb21w
bGV0ZWx5IHVzZWxlc3MgdW5sZXNzIHlvdSBoYXZlIHRoZSBleGFjdCBzYW1lIGtlcm5lbCAKYmlu
YXJ5LgoKQXBhcnQgZnJvbSB0aGF0IHBhdGNoIGlzIFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2
bmlnIAo8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDEgKwo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gaW5k
ZXggODljZDkzYjI0NDA0Li43NTRmOTg0NzQ5N2QgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jCj4gQEAgLTExNTgsNiArMTE1OCw3IEBAIHN0YXRpYyB2b2lkIGFt
ZGdwdV90dG1fdHRfdW5wb3B1bGF0ZShzdHJ1Y3QgdHRtX2RldmljZSAqYmRldiwKPiAgIAlpZiAo
Z3R0ICYmIGd0dC0+dXNlcnB0cikgewo+ICAgCQlhbWRncHVfdHRtX3R0X3NldF91c2VyX3BhZ2Vz
KHR0bSwgTlVMTCk7Cj4gICAJCWtmcmVlKHR0bS0+c2cpOwo+ICsJCXR0bS0+c2cgPSBOVUxMOwo+
ICAgCQl0dG0tPnBhZ2VfZmxhZ3MgJj0gflRUTV9QQUdFX0ZMQUdfU0c7Cj4gICAJCXJldHVybjsK
PiAgIAl9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
