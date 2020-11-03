Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2EDC2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7DE206F9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR9ljVRi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7DE206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B6A86EC95;
	Tue,  3 Nov 2020 13:26:37 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E279A6EC95
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 13:26:35 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id s1so7664654qvm.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 05:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=IJOjnTbNGY+wWcNjQskQBNU+rGfU7rkPSgCtP7IerZ8=;
 b=jR9ljVRifEGpBUs/DFog3ciRjoHOA/8G0MdLcNizSyUCCGrMkpeKtfgiYZsxnYjb8x
 yH40ijXp3fwI9VFy7dQvr6ytokJKAyWJ9tWxcBYM9bPiubxotgkm43jSB2Mzwjk6Wh+q
 i0E4PRyDA7hE55bPEswS+NRQTGMMVNhq2qb2hIME7IPTW6U31LDaUji9y7pnzIeStP6u
 nVynvEBNGqwa0CSHmZP6Bsy20AJRjR1GAwUGckBcOVQRf7r6F9a7PmCG7FYcw875w6DQ
 vjb8zwz7owGd2FC4epbH081YKr1kM+H9SUB+FrLQxFcgqTZSIVVTpHPiHdWeeQrGKAMw
 YnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:from:to:cc:references
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=IJOjnTbNGY+wWcNjQskQBNU+rGfU7rkPSgCtP7IerZ8=;
 b=chl6wOkkQRgomXf93o1kwirXfnOaOEU2HsBQrwra+vRDf0kufsvH1gdwK4bF7DiR1w
 7YW5bNr4Dt5QxmkZsb2HO4IytGLsDn+xR9dZKTCup1gT6H8fadwwjnoJxwomOKvP+y5S
 BdrskxRKBbpNiKesvtLQX0ZU+hQ8ZkDOFJ1abcyMTzyvWfE7kdtWVzUByavGZ+wTWjzl
 uG95f4t+zyMhTmi+Y/LuNSlHobN0uTeh3Z+/r9YWsNRiv6gEovGY/o10EX3bqhPLGwEd
 Poc5PHFvMQDGgcLsTHDlgd1F3GgQKxF9P4nSj8ZdG6dQC6IjMGL9xQ4RC/mrHTbNaPEL
 jTcw==
X-Gm-Message-State: AOAM532pWQWL9Jux93QE015xm/z/RC5OUF4eGdSwuRJLKnmTncJOmDI3
 MvU10kgPBGqBiByOwoZEbNrPI05jo0w=
X-Google-Smtp-Source: ABdhPJw7Cxk8kA/BTWVsxIuto0CJbr1CNRhQHQyxRHOIY1kkkWRnOF6HQ45hplVyjsZ0H0/dmX8+2g==
X-Received: by 2002:a0c:ea2d:: with SMTP id t13mr19412886qvp.11.1604409994898; 
 Tue, 03 Nov 2020 05:26:34 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id l14sm10170589qti.34.2020.11.03.05.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 05:26:34 -0800 (PST)
Subject: Re: [PATCH 2/3] drm/amdgpu: enabled software IH ring for Vega
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20201102113353.1422-1-christian.koenig@amd.com>
 <20201102113353.1422-2-christian.koenig@amd.com>
 <CADnq5_PfY=f9gC6pEu-xzO_Z-Z1ggnW5UrR56oh9e4z96MYNBA@mail.gmail.com>
 <29159f4d-e769-193c-b304-d21693519be1@amd.com>
 <87eea327-ede5-054b-e8da-c8b5c7ba11e9@gmail.com>
Message-ID: <0731ec7c-1c43-8b81-1ef1-61eb456f9c4c@gmail.com>
Date: Tue, 3 Nov 2020 14:26:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87eea327-ede5-054b-e8da-c8b5c7ba11e9@gmail.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDIuMTEuMjAgdW0gMjA6NTggc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFtIDAyLjEx
LjIwIHVtIDE5OjU5IHNjaHJpZWIgRmVsaXggS3VlaGxpbmc6Cj4+IEFtIDIwMjAtMTEtMDIgdW0g
MTo1MyBwLm0uIHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+Pj4gT24gTW9uLCBOb3YgMiwgMjAyMCBh
dCA2OjM0IEFNIENocmlzdGlhbiBLw7ZuaWcKPj4+IDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdt
YWlsLmNvbT4gd3JvdGU6Cj4+Pj4gU2VlbXMgbGlrZSB3ZSB3b24ndCBnZXQgdGhlIGhhcmR3YXJl
IElIMS8yIHJpbmdzIG9uIFZlZ2EyMCB3b3JraW5nLgo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+Pj4+IC0tLQo+Pj4+
IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jIHwgNyArKysrKysrCj4+
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQo+Pj4+Cj4+Pj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2ExMF9paC5jIAo+Pj4+IGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTEwX2loLmMKPj4+PiBpbmRleCA0MDdjNjA5M2MyZWMu
LmNlZjYxZGQ0NmEzNyAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS92ZWdhMTBfaWguYwo+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2Ex
MF9paC5jCj4+Pj4gQEAgLTkxLDYgKzkxLDkgQEAgc3RhdGljIHZvaWQgdmVnYTEwX2loX2VuYWJs
ZV9pbnRlcnJ1cHRzKHN0cnVjdCAKPj4+PiBhbWRncHVfZGV2aWNlICphZGV2KQo+Pj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhZGV2LT5pcnEuaWgyLmVuYWJsZWQgPSB0cnVlOwo+Pj4+IMKgwqDCoMKgwqDC
oMKgwqAgfQo+Pj4+ICsKPj4+PiArwqDCoMKgwqDCoMKgIGlmIChhZGV2LT5pcnEuaWhfc29mdC5y
aW5nX3NpemUpCj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRldi0+aXJxLmlo
X3NvZnQuZW5hYmxlZCA9IHRydWU7Cj4+Pj4gwqAgfQo+Pj4+Cj4+Pj4gwqAgLyoqCj4+Pj4gQEAg
LTYwNiw2ICs2MDksMTAgQEAgc3RhdGljIGludCB2ZWdhMTBfaWhfc3dfaW5pdCh2b2lkICpoYW5k
bGUpCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT5pcnEuaWgyLnVzZV9kb29yYmVsbCA9IHRy
dWU7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT5pcnEuaWgyLmRvb3JiZWxsX2luZGV4ID0g
KGFkZXYtPmRvb3JiZWxsX2luZGV4LmloICsgCj4+Pj4gMikgPDwgMTsKPj4+Pgo+Pj4+ICvCoMKg
wqDCoMKgwqAgciA9IGFtZGdwdV9paF9yaW5nX2luaXQoYWRldiwgJmFkZXYtPmlycS5paF9zb2Z0
LCAKPj4+PiBQQUdFX1NJWkUsIHRydWUpOwo+Pj4+ICvCoMKgwqDCoMKgwqAgaWYgKHIpCj4+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+Pj4gKwo+Pj4gU2hvdWxk
IHdlIG9ubHkgZW5hYmxlIHRoaXMgb24gdmVnYTIwPwo+PiBJdCBhZmZlY3RzIG90aGVyIEdQVXMg
YXMgd2VsbC4gSW5jbHVkaW5nIHByb2JhYmx5IHNvbWUgTmF2aSBHUFVzLiBXZSdsbAo+PiBwcm9i
YWJseSBuZWVkIGEgc2ltaWxhciBjaGFuZ2UgaW4gbmF2aTEwX2loLmMuCgpBbmQgZ21jX3YxMC5j
IGRvZXNuJ3QgZXZlbiBoYXZlIHRoZSByZWNvdmVyYWJsZSBwYWdlIGZhdWx0IGhhbmRsaW5nIHll
dC4KCkdvaW5nIHRvIGFkZCB0aGF0IGFzIHdlbGwuCgpDaHJpc3RpYW4uCgo+PiBJcyB0aGVyZSBh
IHdheSB0byByZWxpYWJseSBkZXRlY3Qgd2hldGhlciBJSCByZWRpcmVjdGlvbiB3b3Jrcy4gT3Ig
ZG8gd2UKPj4gbmVlZCB0byBhbGxvY2F0ZSB0aGUgc29mdCBJSCByaW5nIHVuY29uZGl0aW9uYWxs
eT8KPgo+IFdlIGNhbiBhbGxvY2F0ZSBpdCB1bmNvbmRpdGlvbmFsbHkgb24gVmVnYSBhbmQgTmF2
aSwgaXQncyBqdXN0IGEgCj4gc2luZ2xlIHBhZ2UgcmluZyBidWZmZXIgd2hpY2ggaXMgb25seSB1
c2VkIHdoZW4gbmVlZGVkLgo+Cj4gV2hhdCB3b3JyaWVzIG1lIG1vcmUgaXMgdGhhdCB0ZXN0aW5n
IHNob3dzIHRoYXQgSSBjYW4ndCBldmVuIGVuYWJsZSBJViAKPiB0cmFjaW5nIG9yIHJpc2sgdGhh
dCBhIHNpbmdsZSBDUFUgYmVjb21lcyBzbyBidXN5IHdpdGggcHJvY2Vzc2luZyBJVnMgCj4gdGhh
dCBJIGdldCAic3R1Y2sgZm9yIDIzIHNlY29uZHMiIHdhcm5pbmdzLgo+Cj4gV2UgKnJlYWxseSog
bmVlZCB0aGUgaGFyZHdhcmUgdG8gd29yayBjb3JyZWN0bHkgZWl0aGVyIGJ5IHVzaW5nIHRoZSAK
PiBDQU0gZm9yIGZpbHRlcmluZyBwYWdlIGZhdWx0cyBvciBieSByZWRpcmVjdGluZyB0aGVtIHRv
IHRoZSBkaWZmZXJlbnQgCj4gSUggcmluZy4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4+
Cj4+IFJlZ2FyZHMsCj4+IMKgwqAgRmVsaXgKPj4KPj4KPj4+IEFsZXgKPj4+Cj4+Pgo+Pj4+IMKg
wqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV9pcnFfaW5pdChhZGV2KTsKPj4+Pgo+Pj4+IMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+Pj4gLS0gCj4+Pj4gMi4yNS4xCj4+Pj4KPj4+PiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4+IGFtZC1nZngg
bWFpbGluZyBsaXN0Cj4+Pj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4+PiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
