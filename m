Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2709C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 08:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9351260FDC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 08:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9351260FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 396106F5D3;
	Fri, 21 May 2021 08:40:38 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DD76F5D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 08:40:36 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id k14so25825342eji.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=TVW7yE6edVDzMhTOpUAjIzTW3IAUEIEAw5bNXswVvJA=;
 b=sDE/LUzEGwE0lg6jVuru+7OIIq6KdH63nvcRACPjO2Q1RZQKJtoIkBrs0yyVKjPoOw
 8glUZb4ha9EWgivRZY+YnfFQhXF/fVFNi8QfLSwpZn7FIIG/8h5XXMUxYNHDTBmsTFKz
 dei/s2WttFC0Qwxz2YUDRhyQ8CEKfjJXyRwn16FsLC9MKY3nyHUlKuIgDK8FdhYzEFqB
 do3UjspTf62ZPRpLzy8ztNvBPiARsDPU95Tc1n2UXbuxLBgvuCHtU6vI2vAeT79h1HQ8
 34JLLpCw3o7Rc2cewYr6wNu3gKzjLJyNl01VgPtJ3l+2ksSHO34RMNs2dSVhuysZPDyG
 tF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=TVW7yE6edVDzMhTOpUAjIzTW3IAUEIEAw5bNXswVvJA=;
 b=rZjAuP9BL+bNVv+x6Qe5MkiTsNk/Z2z/K/0tO6o5fQ6r9Y6Km6EIs1B3bnQvLbs36q
 GNbEkLc2blywrGs8iIIhXvSd3y9EDidftCyLU4WGv6C+pi2evLiZ/WKypS1kwISpNRx+
 OPqgwiNw0zURpuTdacYTxEVs4pECaw5XuHw+fTVXOJ67XrxqcZWAC3DnLvPEJpsIHo7I
 IPq/3XXFFf1TUSAlP6AoAWIan1ZTljhycJ4xf9FNnQt/cMtHAG0BZNkepCcFEumK+47L
 MpG0WetLo98qgpTHL90qIA3tZuLHww4FM6ZAvgYei2SresLv11Y9GcyfdDCTlSq67hv6
 ku7Q==
X-Gm-Message-State: AOAM533LvhOlQW1rJG83dhfJx174lnCeAx05UsL+QiYoKXUVEJ0MpXYp
 9PRuyHVBELjbnI7P/C/iAtBMD6vn59g=
X-Google-Smtp-Source: ABdhPJyHhHC+7Ar7Ywb95hUcfqMjBB2ZPQpMftgchODbswqgR6DQy6eQYhcnwtpCbm/CQJjg8joUNg==
X-Received: by 2002:a17:906:2ac5:: with SMTP id
 m5mr9128065eje.517.1621586435649; 
 Fri, 21 May 2021 01:40:35 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d?
 ([2a02:908:1252:fb60:b48f:ff97:fb4c:5b1d])
 by smtp.gmail.com with ESMTPSA id f20sm3405614edu.24.2021.05.21.01.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 May 2021 01:40:35 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] drm/amdgpu: Use preemptible placement for KFD
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210521022256.14184-1-Felix.Kuehling@amd.com>
 <20210521022256.14184-2-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d4a47e24-519e-a3f5-3344-a0f42d12d794@gmail.com>
Date: Fri, 21 May 2021 10:40:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210521022256.14184-2-Felix.Kuehling@amd.com>
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

QW0gMjEuMDUuMjEgdW0gMDQ6MjIgc2NocmllYiBGZWxpeCBLdWVobGluZzoKPiBLRkQgdXNlcnB0
ciBCT3MgYW5kIFNHIEJPcyB1c2VkIGZvciBETUEgbWFwcGluZ3MgY2FuIGJlIHByZWVtcHRlZCB3
aXRoCj4gQ1dTUi4gVGhlcmVmb3JlIHdlIGNhbiB1c2UgcHJlZW1wdGlibGUgcGxhY2VtZW50IGFu
ZCBhdm9pZCB1bndhbnRlZAo+IGV2aWN0aW9ucyBkdWUgdG8gR1RUIGFjY291bnRpbmcuCj4KPiBT
aWduZWQtb2ZmLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KCkFj
a2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0t
LQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIHwg
NyArKysrLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRf
Z3B1dm0uYwo+IGluZGV4IDkyOGU4ZDU3Y2QwOC4uMmI4Yjg5NTM1MTk4IDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmRfZ3B1dm0uYwo+IEBAIC02
MjEsOCArNjIxLDggQEAga2ZkX21lbV9hdHRhY2hfdXNlcnB0cihzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwgc3RydWN0IGtnZF9tZW0gKm1lbSwKPiAgIAo+ICAgCXJldCA9IGFtZGdwdV9nZW1f
b2JqZWN0X2NyZWF0ZShhZGV2LCBib19zaXplLCAxLAo+ICAgCQkJCSAgICAgICBBTURHUFVfR0VN
X0RPTUFJTl9DUFUsCj4gLQkJCQkgICAgICAgMCwgdHRtX2JvX3R5cGVfc2csCj4gLQkJCQkgICAg
ICAgbWVtLT5iby0+dGJvLmJhc2UucmVzdiwKPiArCQkJCSAgICAgICBBTURHUFVfR0VNX0NSRUFU
RV9QUkVFTVBUSUJMRSwKPiArCQkJCSAgICAgICB0dG1fYm9fdHlwZV9zZywgbWVtLT5iby0+dGJv
LmJhc2UucmVzdiwKPiAgIAkJCQkgICAgICAgJmdvYmopOwo+ICAgCWlmIChyZXQpCj4gICAJCXJl
dHVybiByZXQ7Cj4gQEAgLTY2Miw2ICs2NjIsNyBAQCBrZmRfbWVtX2F0dGFjaF9kbWFidWYoc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHN0cnVjdCBrZ2RfbWVtICptZW0sCj4gICAJZG1hX2J1
Zl9wdXQobWVtLT5kbWFidWYpOwo+ICAgCj4gICAJKmJvID0gZ2VtX3RvX2FtZGdwdV9ibyhnb2Jq
KTsKPiArCSgqYm8pLT5mbGFncyB8PSBBTURHUFVfR0VNX0NSRUFURV9QUkVFTVBUSUJMRTsKPiAg
IAkoKmJvKS0+cGFyZW50ID0gYW1kZ3B1X2JvX3JlZihtZW0tPmJvKTsKPiAgIAo+ICAgCXJldHVy
biAwOwo+IEBAIC0xNDEwLDcgKzE0MTEsNyBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9hbGxv
Y19tZW1vcnlfb2ZfZ3B1KAo+ICAgCX0gZWxzZSBpZiAoZmxhZ3MgJiBLRkRfSU9DX0FMTE9DX01F
TV9GTEFHU19VU0VSUFRSKSB7Cj4gICAJCWRvbWFpbiA9IEFNREdQVV9HRU1fRE9NQUlOX0dUVDsK
PiAgIAkJYWxsb2NfZG9tYWluID0gQU1ER1BVX0dFTV9ET01BSU5fQ1BVOwo+IC0JCWFsbG9jX2Zs
YWdzID0gMDsKPiArCQlhbGxvY19mbGFncyA9IEFNREdQVV9HRU1fQ1JFQVRFX1BSRUVNUFRJQkxF
Owo+ICAgCQlpZiAoIW9mZnNldCB8fCAhKm9mZnNldCkKPiAgIAkJCXJldHVybiAtRUlOVkFMOwo+
ICAgCQl1c2VyX2FkZHIgPSB1bnRhZ2dlZF9hZGRyKCpvZmZzZXQpOwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
