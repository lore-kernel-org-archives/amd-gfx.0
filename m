Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E07CC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 09:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2AF92250F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 09:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AF92250F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DDE889DAB;
	Mon, 11 Jan 2021 09:32:03 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8949E89DAB
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 09:32:01 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id cw27so18059391edb.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 01:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=SYJifu0nxevdsGbl8UKM2pcO1xOODE/ttA0YdqVqUk8=;
 b=E8iJFUNbbbmbh5uyGUXv+/FiBrckeKXBkS4MP43Lf7Qdwhm8S+fapLibl1LEg6C7lW
 QjAoBuejtggHx5fSNuLFCafMC5c6obOrwIOWH5Ns69//BseRyM3t0jwkAyk9RpCS+pMs
 5uyuE5B8N//Gslksb1bFMDgEPKWAxm0CXLrQrOPnDkC1ueW1CuOXgVFq7ZSs1dEl2/+G
 FSDS5+daWr8Of348zciRMyHnq6E0ttWY7inrPjBG1L7sca6KljLDFR+RnvWMXPrWsG6O
 5G94fwSPGWDXJl9IgC0S9K7H/hDNgSUAyojwboqzgjXT0WPomPHgGxrzchd92fdcWWpp
 rpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SYJifu0nxevdsGbl8UKM2pcO1xOODE/ttA0YdqVqUk8=;
 b=lEyIWzxl00hQYmE38ypYaAzEa1Onjsvn52r338s2/x2eUfire9jeMlfuoeRa091XrN
 hFaHCRlFAivMgcGzPXXtykfQ4d9H12KkEbfdnQbW5FfK28NvB3LY15xV52tXVQJhNsXV
 kVBTK3nAzyfNHr1nqoyEKP+UoehgmeINckskJ1y9YOdU6nIOGDQP+jUnO/KmFOnhwbtN
 UyEwMvRbtyCRwMhBRQHWo8pM5Zmh+XqP0DsnzxaKSU2aGtQwXXK5UnY9vnJ+53hQwsJl
 RaDCTwSA4/FWMnY5GiwKSRD+P0b/JWa3FwXbb7MdnM3ppJmleyOisuAQ6bTuBGOtm19C
 RElg==
X-Gm-Message-State: AOAM532X/VZdYVa9Yh4Cgc5RFstkl63cdsSAtrr8A68cQTmF0u+puv0y
 nd1lYq2b9UMJPEhous2dje6No8wbOb8=
X-Google-Smtp-Source: ABdhPJwJGFZb2VQEL+HhqAVRCXchb4I3/+fw2ZWJShvuYVyRd2v5uAKRQ1xbBlp62lTO6uLzVJdW9g==
X-Received: by 2002:aa7:d64d:: with SMTP id v13mr13633126edr.196.1610357520018; 
 Mon, 11 Jan 2021 01:32:00 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j22sm6749717ejy.106.2021.01.11.01.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 01:31:59 -0800 (PST)
Subject: Re: [PATCH v2] drm/amdgpu: Decrease compute timeout to 10 s for sriov
 multiple VF
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210107025109.605633-1-Emily.Deng@amd.com>
 <BY5PR12MB41151564C8F47155067320228FAB0@BY5PR12MB4115.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ebd4caac-3b87-3c48-5d42-c51f01e2a5e1@gmail.com>
Date: Mon, 11 Jan 2021 10:31:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB41151564C8F47155067320228FAB0@BY5PR12MB4115.namprd12.prod.outlook.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCkFt
IDExLjAxLjIxIHVtIDA1OjU0IHNjaHJpZWIgRGVuZywgRW1pbHk6Cj4gW0FNRCBPZmZpY2lhbCBV
c2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQo+Cj4gUGluZyAuLi4uLgo+Cj4+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IEVtaWx5IERlbmcgPEVtaWx5LkRl
bmdAYW1kLmNvbT4KPj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgNywgMjAyMSAxMDo1MSBBTQo+
PiBUbzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gQ2M6IERlbmcsIEVtaWx5IDxF
bWlseS5EZW5nQGFtZC5jb20+Cj4+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJtL2FtZGdwdTogRGVj
cmVhc2UgY29tcHV0ZSB0aW1lb3V0IHRvIDEwIHMgZm9yIHNyaW92Cj4+IG11bHRpcGxlIFZGCj4+
Cj4+IEZyb206ICJFbWlseS5EZW5nIiA8RW1pbHkuRGVuZ0BhbWQuY29tPgo+Pgo+PiBGb3IgbXVs
dGlwbGUgVkYsIGFmdGVyIGVuZ2luZSBoYW5nLGFzIGhvc3QgZHJpdmVyIHdpbGwgZmlyc3QgZW5j
b3VudGVyIEZMUiwgc28KPj4gaGFzIG5vIG1lYW5uaW5nIHRvIHNldCBjb21wdXRlIHRvIDYwcy4K
Pj4KPj4gdjI6Cj4+ICAgIFJlZmluZSB0aGUgcGF0Y2ggYW5kIGNvbW1lbnQKPj4KPj4gU2lnbmVk
LW9mZi1ieTogRW1pbHkuRGVuZyA8RW1pbHkuRGVuZ0BhbWQuY29tPgo+PiAtLS0KPj4gZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIHwgNSArKysrLQo+PiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKPj4gaW5kZXggNTUyN2M1NDlkYjgy
Li4zNWVkZjU4YzgyNWQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfZGV2aWNlLmMKPj4gQEAgLTMxMzMsNyArMzEzMywxMCBAQCBzdGF0aWMgaW50Cj4+IGFtZGdw
dV9kZXZpY2VfZ2V0X2pvYl90aW1lb3V0X3NldHRpbmdzKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQo+PiAgICovCj4+IGFkZXYtPmdmeF90aW1lb3V0ID0gbXNlY3NfdG9famlmZmllcygxMDAw
MCk7Cj4+IGFkZXYtPnNkbWFfdGltZW91dCA9IGFkZXYtPnZpZGVvX3RpbWVvdXQgPSBhZGV2LT5n
ZnhfdGltZW91dDsKPj4gLWlmIChhbWRncHVfc3Jpb3ZfdmYoYWRldikgfHwgYW1kZ3B1X3Bhc3N0
aHJvdWdoKGFkZXYpKQo+PiAraWYgKGFtZGdwdV9zcmlvdl92ZihhZGV2KSkKPj4gK2FkZXYtPmNv
bXB1dGVfdGltZW91dCA9Cj4+IGFtZGdwdV9zcmlvdl9pc19wcF9vbmVfdmYoYWRldikgPwo+PiAr
bXNlY3NfdG9famlmZmllcyg2MDAwMCkgOgo+PiBtc2Vjc190b19qaWZmaWVzKDEwMDAwKTsKPj4g
K2Vsc2UgaWYgKGFtZGdwdV9wYXNzdGhyb3VnaChhZGV2KSkKPj4gYWRldi0+Y29tcHV0ZV90aW1l
b3V0ID0gIG1zZWNzX3RvX2ppZmZpZXMoNjAwMDApOwo+PiBlbHNlCj4+IGFkZXYtPmNvbXB1dGVf
dGltZW91dCA9IE1BWF9TQ0hFRFVMRV9USU1FT1VUOwo+PiAtLQo+PiAyLjI1LjEKPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGlu
ZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
