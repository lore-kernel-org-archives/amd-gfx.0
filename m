Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAA9C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BFDA206D8
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 08:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUmL798a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BFDA206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAA636E488;
	Wed, 29 Jul 2020 08:47:00 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429896E488
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 08:46:59 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id o18so2391025eds.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=EbIWwXFXwwB3sahKpGqLw80MH3oxrX4XdZNt5FBWwL8=;
 b=kUmL798atQuNfZOhIEd4BzSiX6N3D3bViKwp6nFKAoqqf7msKt6ciHnwtObOVlvRxh
 etuexOW8I1sn1/z79VAsjA0NXph/HvsMM4XD59x+UhOpw09rZU+KRsq5xF3JvkLKIJBE
 4kJB2RMGO75qvOnM6xGkyTcmmS4C7vWPk8zCTtGCb0JNn92+npX/HwMTiVZXpnfjIJox
 NKM08LAABHu+nu7EInWUV1HhrUuAqvey2I0WhyjKvP/bx9PK/piiqmaPYCGMY2Ss/fN4
 Wy782zh/sAkJGHcyxSV0TguABU/Cgt/F6YYTJU7y1BEKlpeGs+N9tz5zMp/lUA1UGRhz
 31xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=EbIWwXFXwwB3sahKpGqLw80MH3oxrX4XdZNt5FBWwL8=;
 b=LX16dFGa0pBJesVzaWjPHUCtfbcgWlJRvwENhWRiKVm2q0jb0ndlnQHLQfgl7SZI75
 NACEoCNnjDmZu0PALWDTCSNbj1tkwOitLNzYLxqXQ1wKfshwjCsgI4WdButr+Wk32npK
 OMB7oXxh++RqrjlP58Y42Lkg1TKPl75vD4p57CUkAIy7h51ZdjS4g2TzUrTjDvkR9gyd
 fsXOYW6iSeNFefLj5c+FR/d04nkbvCBJmZtfLAQbRS/DNHSZYU5wJ/t7ssVPqm0nnPvu
 en5DKbuoaOSRtwoUzN4rkKHcaGx6Fs+mgsrsngRY1E+wwKYdMP+OqzfAztDs1vA9LFyU
 VlMQ==
X-Gm-Message-State: AOAM5325P0nE2YHJO0Y/6VmFKPIvCQXG0EVQ7dT5UDpD6DN+nz5dmu+k
 35SrEFDECln4U4yQgUQMwjU=
X-Google-Smtp-Source: ABdhPJxcWaFkIojeVfZv3Fy0Ss3aqqzEM1VAiYsXNFSXmDEzQA+THSA5UNi6JWxs9witpOdFicC+AA==
X-Received: by 2002:aa7:dacb:: with SMTP id x11mr28455145eds.280.1596012417957; 
 Wed, 29 Jul 2020 01:46:57 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id v9sm1014114ejd.102.2020.07.29.01.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 01:46:57 -0700 (PDT)
Subject: Re: [PATCH 13/14] drm/amdgpu: drop the CPU pointers for the stolen
 vga bos
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200728224605.3919-1-alexander.deucher@amd.com>
 <20200728224605.3919-14-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <ebf8198e-65cc-2b69-e5ea-6ede3e6f0351@gmail.com>
Date: Wed, 29 Jul 2020 10:46:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728224605.3919-14-alexander.deucher@amd.com>
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

QW0gMjkuMDcuMjAgdW0gMDA6NDYgc2NocmllYiBBbGV4IERldWNoZXI6Cj4gV2UgbmV2ZXIgdXNl
IHRoZW0uCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYyB8IDE2ICsrKysrLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDExIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90dG0uYwo+IGluZGV4IGVjOTc1MjUxYjE3MS4uM2RmOWQ1YTUzNzQxIDEwMDY0NAo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IEBAIC0xOTE1LDcgKzE5MTUsNiBAQCBp
bnQgYW1kZ3B1X3R0bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgCXVpbnQ2
NF90IGd0dF9zaXplOwo+ICAgCWludCByOwo+ICAgCXU2NCB2aXNfdnJhbV9saW1pdDsKPiAtCXZv
aWQgKnN0b2xlbl92Z2FfYnVmLCAqc3RvbGVuX2V4dGVuZGVkX2J1ZjsKPiAgIAo+ICAgCW11dGV4
X2luaXQoJmFkZXYtPm1tYW4uZ3R0X3dpbmRvd19sb2NrKTsKPiAgIAo+IEBAIC0xOTgyLDE0ICsx
OTgxLDE0IEBAIGludCBhbWRncHVfdHRtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
Cj4gICAJciA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsX2F0KGFkZXYsIDAsIGFkZXYtPmdtYy5z
dG9sZW5fdmdhX3NpemUsCj4gICAJCQkJICAgICAgIEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0sCj4g
ICAJCQkJICAgICAgICZhZGV2LT5nbWMuc3RvbGVuX3ZnYV9tZW1vcnksCj4gLQkJCQkgICAgICAg
JnN0b2xlbl92Z2FfYnVmKTsKPiArCQkJCSAgICAgICBOVUxMKTsKPiAgIAlpZiAocikKPiAgIAkJ
cmV0dXJuIHI7Cj4gICAJciA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsX2F0KGFkZXYsIGFkZXYt
PmdtYy5zdG9sZW5fdmdhX3NpemUsCj4gICAJCQkJICAgICAgIGFkZXYtPmdtYy5zdG9sZW5fZXh0
ZW5kZWRfc2l6ZSwKPiAgIAkJCQkgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSwKPiAgIAkJ
CQkgICAgICAgJmFkZXYtPmdtYy5zdG9sZW5fZXh0ZW5kZWRfbWVtb3J5LAo+IC0JCQkJICAgICAg
ICZzdG9sZW5fZXh0ZW5kZWRfYnVmKTsKPiArCQkJCSAgICAgICBOVUxMKTsKPiAgIAlpZiAocikK
PiAgIAkJcmV0dXJuIHI7Cj4gICAKPiBAQCAtMjA0OCwxMyArMjA0NywxMCBAQCBpbnQgYW1kZ3B1
X3R0bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgICovCj4gICB2b2lkIGFt
ZGdwdV90dG1fbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgewo+IC0J
dm9pZCAqc3RvbGVuX3ZnYV9idWYsICpzdG9sZW5fZXh0ZW5kZWRfYnVmOwo+IC0KPiAgIAkvKiBy
ZXR1cm4gdGhlIFZHQSBzdG9sZW4gbWVtb3J5IChpZiBhbnkpIGJhY2sgdG8gVlJBTSAqLwo+ICAg
CWlmICghYWRldi0+Z21jLmtlZXBfc3RvbGVuX3ZnYV9tZW1vcnkpCj4gLQkJYW1kZ3B1X2JvX2Zy
ZWVfa2VybmVsKCZhZGV2LT5nbWMuc3RvbGVuX3ZnYV9tZW1vcnksIE5VTEwsICZzdG9sZW5fdmdh
X2J1Zik7Cj4gLQlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPmdtYy5zdG9sZW5fZXh0ZW5k
ZWRfbWVtb3J5LCBOVUxMLAo+IC0JCQkgICAgICAmc3RvbGVuX2V4dGVuZGVkX2J1Zik7Cj4gKwkJ
YW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5nbWMuc3RvbGVuX3ZnYV9tZW1vcnksIE5VTEws
IE5VTEwpOwo+ICsJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5nbWMuc3RvbGVuX2V4dGVu
ZGVkX21lbW9yeSwgTlVMTCwgTlVMTCk7Cj4gICB9Cj4gICAKPiAgIC8qKgo+IEBAIC0yMDYyLDE1
ICsyMDU4LDEzIEBAIHZvaWQgYW1kZ3B1X3R0bV9sYXRlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCj4gICAgKi8KPiAgIHZvaWQgYW1kZ3B1X3R0bV9maW5pKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQo+ICAgewo+IC0Jdm9pZCAqc3RvbGVuX3ZnYV9idWY7Cj4gLQo+ICAgCWlm
ICghYWRldi0+bW1hbi5pbml0aWFsaXplZCkKPiAgIAkJcmV0dXJuOwo+ICAgCj4gICAJYW1kZ3B1
X3R0bV90cmFpbmluZ19yZXNlcnZlX3ZyYW1fZmluaShhZGV2KTsKPiAgIAkvKiByZXR1cm4gdGhl
IHN0b2xlbiB2Z2EgbWVtb3J5IGJhY2sgdG8gVlJBTSAqLwo+ICAgCWlmIChhZGV2LT5nbWMua2Vl
cF9zdG9sZW5fdmdhX21lbW9yeSkKPiAtCQlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPmdt
Yy5zdG9sZW5fdmdhX21lbW9yeSwgTlVMTCwgJnN0b2xlbl92Z2FfYnVmKTsKPiArCQlhbWRncHVf
Ym9fZnJlZV9rZXJuZWwoJmFkZXYtPmdtYy5zdG9sZW5fdmdhX21lbW9yeSwgTlVMTCwgTlVMTCk7
Cj4gICAJLyogcmV0dXJuIHRoZSBJUCBEaXNjb3ZlcnkgVE1SIG1lbW9yeSBiYWNrIHRvIFZSQU0g
Ki8KPiAgIAlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPmRpc2NvdmVyeV9tZW1vcnksIE5V
TEwsIE5VTEwpOwo+ICAgCWFtZGdwdV90dG1fZndfcmVzZXJ2ZV92cmFtX2ZpbmkoYWRldik7Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
