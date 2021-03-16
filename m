Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D144C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 07:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA30964F90
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 07:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA30964F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE886E210;
	Tue, 16 Mar 2021 07:34:16 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC4736E210
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 07:34:15 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id o19so20296205edc.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 00:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=QAk6a/8qAZobFJReqVWNXE0SspO6Q/JL80IEKfkWobo=;
 b=CxcL7g6ZC6GJu/VBPTBpIbt/H9UC9EKH0Db79hJIe6FOAi2nfPiFAp+6GKzMMXLxjG
 INsTcUqy/fH+PdwApa6kb93blwbz9LSXJjc4xwwtWMyo1rHkyH2qdNetCmc1FNs+TdJg
 B4OgcIy3oUPq+536foOlctCvovrWvzCscYE6yi3xEV9XOU+Mk9JK6UzNkrwpCHJkwtBp
 kNYOgz5N+uOMpsq1mzuvDRgpZS9ranr9suKgVaPhlglX0w0D+LiKPpkCJscqW+yTOiPw
 RwKPXaO6WxMmYr4BAVEW/fTw+sOag04EXadQeEWvKA1Kk2UUWA0UDt5P3mAJmDyVuz3D
 C1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QAk6a/8qAZobFJReqVWNXE0SspO6Q/JL80IEKfkWobo=;
 b=XQI30mlOaG5jyRE24RZOV1NlRQMMYTXEdovM9KLe1uNnij8iFtS3UpkeDRaeGJxYEQ
 Q+5yLXW0Ms7DIOdDJLPxLGT3eYXSEQcCD/xI9JfIGOtzxJ/E306eW1t1mOHjhR7yStsB
 IzXS2E17C3v+z3JNl1PxfozSXoHijIs5/N/yRnZAkatfEyjS/u/fxHstswUssT+EIlFV
 VXfeYZsyZbOOS4MmqBpEpHqckoNBfyHhXxHMSQW01AGGaKJZ5PRNQHODAJ1HrfWT9Oph
 PFcGJdkTnzTRQ8FcCP2of/10r7Fw2M7L59WkjqweO7o6CqHYLAgNCMQFdHyCHjbLz2TA
 L7DQ==
X-Gm-Message-State: AOAM53362E+/ThPQDsoU+g//1vl3s0VP+KJiICACahfks1AWeLOGgVxa
 1xIoLALWLIuGv/t0Hh//Q6l/j6PZujo=
X-Google-Smtp-Source: ABdhPJwxMW8CF07eIjko1tdo5Ec62ld9WqkLlbarKUDggwNleYKWZzy7BWXMGDGZGCR3sW0oHD5iRw==
X-Received: by 2002:a05:6402:c96:: with SMTP id
 cm22mr34746550edb.128.1615880054668; 
 Tue, 16 Mar 2021 00:34:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6b5d:d42e:c935:ffd2?
 ([2a02:908:1252:fb60:6b5d:d42e:c935:ffd2])
 by smtp.gmail.com with ESMTPSA id lx6sm8790805ejb.64.2021.03.16.00.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Mar 2021 00:34:14 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu/ttm: fix ifdefs for non-x86
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210315193841.1539753-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e9bb6480-0f50-c030-41d2-feea40ab5c03@gmail.com>
Date: Tue, 16 Mar 2021 08:34:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210315193841.1539753-1-alexander.deucher@amd.com>
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

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
CkFtIDE1LjAzLjIxIHVtIDIwOjM4IHNjaHJpZWIgQWxleCBEZXVjaGVyOgo+IFRoZSBlbHNlIGNs
YXVzZSBuZWVkcyB0byBiZSBDT05GSUdfNjRCSVQgbm90IENPTkZJR19YODYuCj4KPiBGaXhlczog
ZTk4ZjI1MGJkZGI1ICgiZHJtL2FtZGdwdTogZml4IGNvbXBpbGUgZXJyb3Igb24gYXJjaGl0ZWN0
dXJlIHMzOTAiKQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90
dG0uYyB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKPiBpbmRleCAxNThjOTg3Njk2ZmYuLjZk
NWNmMDUyNTMyNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMK
PiBAQCAtMTczMSwxMiArMTczMSwxNCBAQCBpbnQgYW1kZ3B1X3R0bV9pbml0KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQo+ICAgCj4gICAJLyogQ2hhbmdlIHRoZSBzaXplIGhlcmUgaW5zdGVh
ZCBvZiB0aGUgaW5pdCBhYm92ZSBzbyBvbmx5IGxwZm4gaXMgYWZmZWN0ZWQgKi8KPiAgIAlhbWRn
cHVfdHRtX3NldF9idWZmZXJfZnVuY3Nfc3RhdHVzKGFkZXYsIGZhbHNlKTsKPiArI2lmZGVmIENP
TkZJR182NEJJVAo+ICAgI2lmZGVmIENPTkZJR19YODYKPiAgIAlpZiAoYWRldi0+Z21jLnhnbWku
Y29ubmVjdGVkX3RvX2NwdSkKPiAgIAkJYWRldi0+bW1hbi5hcGVyX2Jhc2Vfa2FkZHIgPSBpb3Jl
bWFwX2NhY2hlKGFkZXYtPmdtYy5hcGVyX2Jhc2UsCj4gICAJCQkJYWRldi0+Z21jLnZpc2libGVf
dnJhbV9zaXplKTsKPiAgIAo+ICAgCWVsc2UKPiArI2VuZGlmCj4gICAJCWFkZXYtPm1tYW4uYXBl
cl9iYXNlX2thZGRyID0gaW9yZW1hcF93YyhhZGV2LT5nbWMuYXBlcl9iYXNlLAo+ICAgCQkJCWFk
ZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6ZSk7Cj4gICAjZW5kaWYKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
