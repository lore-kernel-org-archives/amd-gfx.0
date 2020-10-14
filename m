Return-Path: <SRS0=q64Q=DV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC20AC433E7
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 08:36:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47A3020BED
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2020 08:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9GDTe/k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A3020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E0B6EA24;
	Wed, 14 Oct 2020 08:36:29 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52BE56EA25
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 08:36:28 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id a3so3585527ejy.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2020 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=Zh/+ndBatYU9XZbK28mQYWZeKFcFGy/rqjIRCNaD1sc=;
 b=U9GDTe/kdyPL/njnzW5aaBuAx77CadIFAitX1m5SgDUj0d9AkELi23e9Q0rq0rO46t
 9WsnBeQ2SgH3D5ZcJz490zO3D6k0HVtAXe5kyFPt2f928P+lMxmip6YBv9MFnVTmbxyL
 f5lqCElu9AmS5NYTHshE7xyTT68I1whmgcuUpZ3aO+DFJRYUKbApYbBa/7kL3VVHSJ74
 7w7YAVW2tgmKjKZLEdg+k8Cl/OmijzfmaepL0b8d2u87iNRsQ3tTi13zr1lkTKVfeQtB
 LlG8ZEjb23SgpRIk5vPLpLZfybouGbGftT7XbpBw/cp9U4r2GCQL0PTIK7psxkjpD+2N
 ub6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=Zh/+ndBatYU9XZbK28mQYWZeKFcFGy/rqjIRCNaD1sc=;
 b=Sqz+GFHM1EF4C/hdi8svIdZ9GaqAqai3Xl8a7CYW2Qe+0Q/1lEuQli+2Ryk2wMnXBY
 EZRJRiV9cRAWiMlExLtDbUkwA5F4cJpS/0iysnxFkz0eWv6Iz5eGygI/jnqw+ML/r2H4
 SPB7po7LNoYIeHdMiiHI+BWtl60P1JczzvuW+CE7vx/426QojnipOXyT5QrKgiqsPp58
 PCfmnTekJKm4FfIJOsYYSUwFUGF4ty8Fq+6M7mA76ts9UCiBrM4Io/Zn66IhGHpvJmfX
 jlxOom+r8Bky7ij7bXD/8ijGsvNWbX11crXylfDPjYr+lysAEOCKPk0GG+XWS2vzxEWM
 nlCg==
X-Gm-Message-State: AOAM531hq6ByhFBaLa0xySTHy0pp1lcvIsDoa4pnUQdv/ATTm1UOt/cN
 WQxt+lTqc98QYQp9N5tWNiA=
X-Google-Smtp-Source: ABdhPJwulvDBiYMHMifvsJVXgeAp+65GyMjtU+Tcc4wS5IPS1ZoZeZoqQ1MZtzq1Tuh58RSCsK8k0A==
X-Received: by 2002:a17:906:ad87:: with SMTP id
 la7mr4023964ejb.85.1602664587001; 
 Wed, 14 Oct 2020 01:36:27 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id g3sm1150088edy.12.2020.10.14.01.36.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 01:36:25 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu: increase the reserved VM size to 2MB
To: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20201013170820.1548-1-christian.koenig@amd.com>
 <BL0PR12MB24337593D8FB1AA27A5E1AB89C050@BL0PR12MB2433.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6e57bfbc-fe17-7e1c-5f9e-b5bad7ffad17@gmail.com>
Date: Wed, 14 Oct 2020 10:36:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BL0PR12MB24337593D8FB1AA27A5E1AB89C050@BL0PR12MB2433.namprd12.prod.outlook.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTQuMTAuMjAgdW0gMTA6MjYgc2NocmllYiBDaGF1aGFuLCBNYWRoYXY6Cj4gW0FNRCBQdWJs
aWMgVXNlXQo+Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KPiBGcm9tOiBDaHJpc3RpYW4g
S8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4KPiBTZW50OiBUdWVzZGF5
LCBPY3RvYmVyIDEzLCAyMDIwIDEwOjM4IFBNCj4gVG86IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCj4gQ2M6IENoYXVoYW4sIE1hZGhhdiA8TWFkaGF2LkNoYXVoYW5AYW1kLmNvbT47IFBh
biwgWGluaHVpIDxYaW5odWkuUGFuQGFtZC5jb20+Cj4gU3ViamVjdDogW1BBVENIIDEvMl0gZHJt
L2FtZGdwdTogaW5jcmVhc2UgdGhlIHJlc2VydmVkIFZNIHNpemUgdG8gMk1CCj4KPiBJZGVhbGx5
IHRoaXMgc2hvdWxkIGJlIGEgbXVsdGlwbGUgb2YgdGhlIFZNIGJsb2NrIHNpemUuCj4gMk1CIHNo
b3VsZCBhdCBsZWFzdCBmaXQgZm9yIFZlZ2EvTmF2aS4KPgo+IFNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIHwgNCArKy0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmgKPiBpbmRleCA3YzQ2OTM3YzFjMGUuLjgxY2NkMGEwYzNkYiAxMDA2
NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaAo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4gQEAgLTExMiw4ICsxMTIs
OCBAQCBzdHJ1Y3QgYW1kZ3B1X2JvX2xpc3RfZW50cnk7Cj4gICAjZGVmaW5lIEFNREdQVV9NTUhV
Ql8wCQkJCTEKPiAgICNkZWZpbmUgQU1ER1BVX01NSFVCXzEJCQkJMgo+ICAgCj4gLS8qIGhhcmRj
b2RlIHRoYXQgbGltaXQgZm9yIG5vdyAqLwo+IC0jZGVmaW5lIEFNREdQVV9WQV9SRVNFUlZFRF9T
SVpFCQkJKDFVTEwgPDwgMjApCj4gKy8qIFJlc2VydmUgMk1CIGF0IHRvcC9ib3R0b20gb2YgYWRk
cmVzcyBzcGFjZSBmb3Iga2VybmVsIHVzZSAqLwo+ICsjZGVmaW5lIEFNREdQVV9WQV9SRVNFUlZF
RF9TSVpFCQkJKDJVTEwgPDwgMjApCj4KPiBMb29rcyBmaW5lIHRvIG1lOiBSZXZpZXdlZC1ieTog
TWFkaGF2IENoYXVoYW4gPG1hZGhhdi5jaGF1aGFuQGFtZC5jb20+Cj4gQ2xhcmlmaWNhdGlvbiBv
biBjb21tZW50Ogo+IFdlIGNoZWNrIHZhX2FkZHJlc3MgPCBBTURHUFVfVkFfUkVTRVJWRURfU0la
RSBmb3IgaW52YWxpZCByZXNlcnZhdGlvbnMsIHNob3VsZG7igJl0IHRoaXMgYmUgImJvdHRvbSJp
bnN0ZWFkIG9mICJ0b3AvYm90dG9tIiBvZiBhZGRyZXNzIHNwYWNlPz8KCkluIGFtZGdwdV9pbmZv
X2lvY3RsKCkgd2UgcmVwb3J0IEFNREdQVV9WQV9SRVNFUlZFRF9TSVpFIGFzIHN0YXJ0IG9mIHRo
ZSAKdXNhYmxlIGFkZHJlc3Mgc3BhY2UgYW5kIHZtX3NpemUgLSBBTURHUFVfVkFfUkVTRVJWRURf
U0laRSBhcyBlbmQuCgpDb3VsZCBiZSB0aGF0IHdlIGRvbid0IGNoZWNrIGlmIHRoZSBhZGRyZXNz
IGluIHRoZSByZXNlcnZlZCBob2xlIGF0IHRoZSAKZW5kIG9mIHRoZSBhZGRyZXNzIHNwYWNlLiBU
aGF0IHdvdWxkIGJlIGEgYnVnIGFuZCBzaG91bGQgcHJvYmFibHkgYmUgZml4ZWQuCgpDaHJpc3Rp
YW4uCgo+Cj4gUmVnYXJkcywKPiBNYWRoYXYKPiAgIAo+ICAgLyogbWF4IHZtaWRzIGRlZGljYXRl
ZCBmb3IgcHJvY2VzcyAqLwo+ICAgI2RlZmluZSBBTURHUFVfVk1fTUFYX1JFU0VSVkVEX1ZNSUQJ
MQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
