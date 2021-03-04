Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7113AC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3CBE64F5C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 18:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3CBE64F5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BDA6EA5A;
	Thu,  4 Mar 2021 18:04:10 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716316EA5A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 18:04:09 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id b13so26908128edx.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Mar 2021 10:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=XwU25uACaHqYeCuAMSgt4w3T4tx+RRUCBocduBz5tJ0=;
 b=mbMGwwuHYGlT0jnsFHAEOm+ApXsSz+C72cXSowjxz2hvbjw6xyzawj7kWuj6fswHgI
 sWey4JkIsZa9bJ5clAYPctq3FJLBT4b1ylpDWmRcSFTkxWP+eg/EOjP74RSQ+U4UvHvm
 ohQ43aWiHgaQj2y2yDOExIKnnXLxC0DQXHgh5gD6Vq9kM8wSfln5MxMOCMw6qfZ1asKZ
 UK2ZqS3h1o4rIxtA+/zwxFIpDpg/Ep3DS1oyLHJwmaW0LkF9xqo69toNen1pyvNus4LS
 iqd3tnTxxai/hhifT343fk/v1lPmYsYIC0zWTeIxxCcr9eX3hv222Jlr15FoCaOj5ggE
 jpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XwU25uACaHqYeCuAMSgt4w3T4tx+RRUCBocduBz5tJ0=;
 b=muF+vCjPU1UMAnusJPAzyVvM1DZhHOVMgw/J6zKpcT0FyyVCTqG0gl8xGLelNe8+O5
 G5N8TdtiLA7LqYP1B2nzhZ4K4K+IECiLjYj7q55P72SVhkjr0aKOv0RUwLdIc0gOCUci
 PCIRtPo4+tp3p3H9qaotv+nASM30CkF/Yeakkyf7Op5rWLfjQ6EZ83z0/zyBjfiTKvg8
 y1f93YqeodGFeYRcjCXXEVlxxk0lyqmtiS6gf/uXD7yTwJAIzQ0oroV+EQDA0JDkxiNU
 cLZSFWrxUOLZtDwFDPiJBMjK/NHL664qglCErwAyCgG8IGQnhaFh3sgHBzSkS4alhGRx
 h5Fw==
X-Gm-Message-State: AOAM5325R2PqpcKKpbiIUopzenlkt8yddwrD6mmF/ORv3Rl/DzT2bXec
 Dh9XwAQPxvHES/y6KjGfB0FrimNY6/L9gQ==
X-Google-Smtp-Source: ABdhPJzf+Gca7E+UD1L7safVGpfA1afkXWUSLXb9hcwWS68MmoigCoiUAC9crY12AWNgCX9PGS73sg==
X-Received: by 2002:a05:6402:46:: with SMTP id
 f6mr5782750edu.252.1614881048124; 
 Thu, 04 Mar 2021 10:04:08 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:3d04:4b7c:635f:3a0?
 ([2a02:908:1252:fb60:3d04:4b7c:635f:3a0])
 by smtp.gmail.com with ESMTPSA id si7sm4715ejb.84.2021.03.04.10.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Mar 2021 10:04:07 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: enable TMZ by default on Raven asics
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210225164403.444369-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <123a94ef-cf38-f446-f051-053b37f961ca@gmail.com>
Date: Thu, 4 Mar 2021 19:04:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210225164403.444369-1-alexander.deucher@amd.com>
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

QW0gMjUuMDIuMjEgdW0gMTc6NDQgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gVGhpcyBoYXMgYmVl
biBzdGFibGUgZm9yIGEgd2hpbGUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFs
ZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9kcnYuYyB8ICA0ICsrLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuYyB8IDEwICsrKysrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdlZCwgMTIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMKPiBpbmRleCAyZjcxZDM2ZDI4NTYuLjIxNTA0ZWE5MDg1ZiAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMKPiBAQCAtMTY0LDcgKzE2NCw3
IEBAIGludCBhbWRncHVfZGlzY292ZXJ5ID0gLTE7Cj4gICBpbnQgYW1kZ3B1X21lczsKPiAgIGlu
dCBhbWRncHVfbm9yZXRyeSA9IC0xOwo+ICAgaW50IGFtZGdwdV9mb3JjZV9hc2ljX3R5cGUgPSAt
MTsKPiAtaW50IGFtZGdwdV90bXo7Cj4gK2ludCBhbWRncHVfdG16ID0gLTE7IC8qIGF1dG8gKi8K
PiAgIGludCBhbWRncHVfcmVzZXRfbWV0aG9kID0gLTE7IC8qIGF1dG8gKi8KPiAgIGludCBhbWRn
cHVfbnVtX2tjcSA9IC0xOwo+ICAgCj4gQEAgLTc5MCw3ICs3OTAsNyBAQCBtb2R1bGVfcGFyYW1f
bmFtZWQoYWJtbGV2ZWwsIGFtZGdwdV9kbV9hYm1fbGV2ZWwsIHVpbnQsIDA0NDQpOwo+ICAgICoK
PiAgICAqIFRoZSBkZWZhdWx0IHZhbHVlOiAwIChvZmYpLiAgVE9ETzogY2hhbmdlIHRvIGF1dG8g
dGlsbCBpdCBpcyBjb21wbGV0ZWQuCj4gICAgKi8KPiAtTU9EVUxFX1BBUk1fREVTQyh0bXosICJF
bmFibGUgVE1aIGZlYXR1cmUgKC0xID0gYXV0bywgMCA9IG9mZiAoZGVmYXVsdCksIDEgPSBvbiki
KTsKPiArTU9EVUxFX1BBUk1fREVTQyh0bXosICJFbmFibGUgVE1aIGZlYXR1cmUgKC0xID0gYXV0
byAoZGVmYXVsdCksIDAgPSBvZmYsIDEgPSBvbikiKTsKPiAgIG1vZHVsZV9wYXJhbV9uYW1lZCh0
bXosIGFtZGdwdV90bXosIGludCwgMDQ0NCk7Cj4gICAKPiAgIC8qKgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiBpbmRleCBmZTFhMzlmZmRhNzIuLjFhODkyNTI2ZDAy
MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKPiBAQCAtMzg0
LDYgKzM4NCwxNiBAQCB2b2lkIGFtZGdwdV9nbWNfdG16X3NldChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKPiAgIHsKPiAgIAlzd2l0Y2ggKGFkZXYtPmFzaWNfdHlwZSkgewo+ICAgCWNhc2Ug
Q0hJUF9SQVZFTjoKPiArCQlpZiAoYW1kZ3B1X3RteiA9PSAwKSB7Cj4gKwkJCWFkZXYtPmdtYy50
bXpfZW5hYmxlZCA9IGZhbHNlOwo+ICsJCQlkZXZfaW5mbyhhZGV2LT5kZXYsCj4gKwkJCQkgIlRy
dXN0ZWQgTWVtb3J5IFpvbmUgKFRNWikgZmVhdHVyZSBkaXNhYmxlZCAoY21kIGxpbmUpXG4iKTsK
PiArCQl9IGVsc2Ugewo+ICsJCQlhZGV2LT5nbWMudG16X2VuYWJsZWQgPSB0cnVlOwo+ICsJCQlk
ZXZfaW5mbyhhZGV2LT5kZXYsCj4gKwkJCQkgIlRydXN0ZWQgTWVtb3J5IFpvbmUgKFRNWikgZmVh
dHVyZSBlbmFibGVkXG4iKTsKPiArCQl9Cj4gKwkJYnJlYWs7Cj4gICAJY2FzZSBDSElQX1JFTk9J
UjoKPiAgIAljYXNlIENISVBfTkFWSTEwOgo+ICAgCWNhc2UgQ0hJUF9OQVZJMTQ6CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
