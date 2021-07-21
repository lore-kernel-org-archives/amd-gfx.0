Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49604C07E9B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 06:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEECB60FED
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 06:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEECB60FED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 944A16E829;
	Wed, 21 Jul 2021 06:26:16 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7700C6E829
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 06:26:15 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id t5so852791wrw.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jul 2021 23:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=M3E8D92ZjxznDXAXBWr7mOryXfWFtEOjENaAlGWejsM=;
 b=RDqIcT9ra9pzSD8VCiC0jocXGZBsm4wsPm9KYWF9KqDt9jXLjs02J9whLRk4MFCLYT
 YjH6tXL9e0CBEVk+ey6KLr/Mh6mfDOTrSLyUIK8+knQc1NEghXt8lTGkhU6AdE1nLHiK
 m1p21E3gzySVa/ZvVvNQxFSWjpjBtU1LS1u3i5ZbmAICiN5IpPqA7DGPRYgZEtQqo96J
 e9ijus28q1ms2rZCxR0hcz5x1K+m17jsXmvQx5WXX/Ab1FUzGa5URUJuGp0/kz2bkLgK
 Z0RiW69v2jhfDkWgxAIryiiDRIf3y2yWKeBXoub4DvnatGgnXKv8XwU1r3o4D+umClGT
 XdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=M3E8D92ZjxznDXAXBWr7mOryXfWFtEOjENaAlGWejsM=;
 b=A1aJDB3cbL7kq0vRX8PAYJFR0OeSLx4w5TYwOdrKNgi1/gRQiPaUfelOI7vZk5tvrA
 seG5KF46gP00d0g/IJJvWOv+smUWy0V1eXW1DOSJAiOcOqoYlhLQ/nDYYBTY4YBOUzRY
 IWiOJmrROK33AaAkSF4Ven9Uy9qWhDxtrGt5TrYP7RA4z7dec0+qJmGdNuBCnX2lMJYo
 IntD9GD+OP5yW+0DBwp71jCQ1pg3k7lJ8OxLjNN8C3wFH+a6GU/gGRP1WLvHL198HnFo
 v1SAoTN8deayLQ1eJxACXQUn1XUL8BdORrKlEON1G119TIktitkzo+dKElI3CcGk2kAG
 f4VA==
X-Gm-Message-State: AOAM530fAUqKgTUg4xTghWec4F4l45Cjt4uwViszvs3sE/h8oDqVgE3n
 1zvjs5adcWrMasCBxm2cv30=
X-Google-Smtp-Source: ABdhPJx9D1JC/5pADBuDb4PbrTPOpFnekvD07J4gZd/hvUGcxOLsubi225sI/sdNOfvRJHM0Gi3VPw==
X-Received: by 2002:adf:e7c6:: with SMTP id e6mr40518412wrn.221.1626848774121; 
 Tue, 20 Jul 2021 23:26:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:9bcf:837a:d18c:dc66?
 ([2a02:908:1252:fb60:9bcf:837a:d18c:dc66])
 by smtp.gmail.com with ESMTPSA id w9sm21897252wmc.19.2021.07.20.23.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jul 2021 23:26:13 -0700 (PDT)
Subject: Re: [PATCH v2] drm/amd/amdgpu: consider kernel job always not guilty
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210721020504.404046-1-Jingwen.Chen2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a7f89ad6-f483-03e4-7549-2d0fb04862d8@gmail.com>
Date: Wed, 21 Jul 2021 08:26:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210721020504.404046-1-Jingwen.Chen2@amd.com>
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
Cc: horace.chen@amd.com, monk.liu@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjEuMDcuMjEgdW0gMDQ6MDUgc2NocmllYiBKaW5nd2VuIENoZW46Cj4gW1doeV0KPiBDdXJy
ZW50bHkgYWxsIHRpbWVkb3V0IGpvYiB3aWxsIGJlIGNvbnNpZGVyZWQgdG8gYmUgZ3VpbHR5LiBJ
biBTUklPVgo+IG11bHRpLXZmIHVzZSBjYXNlLCB0aGUgdmYgZmxyIGhhcHBlbnMgZmlyc3QgYW5k
IHRoZW4gam9iIHRpbWUgb3V0IGlzCj4gZm91bmQuIFRoZXJlIGNhbiBiZSBzZXZlcmFsIGpvYnMg
dGltZW91dCBkdXJpbmcgYSB2ZXJ5IHNtYWxsIHRpbWUgc2xpY2UuCj4gQW5kIGlmIHRoZSBpbm5v
Y2VudCBzZG1hIGpvYiB0aW1lIG91dCBpcyBmb3VuZCBiZWZvcmUgdGhlIHJlYWwgYmFkCj4gam9i
LCB0aGVuIHRoZSBpbm5vY2VudCBzZG1hIGpvYiB3aWxsIGJlIHNldCB0byBndWlsdHkuIFRoaXMg
d2lsbCBsZWFkCj4gdG8gYSBwYWdlIGZhdWx0IGFmdGVyIHJlc3VibWl0dGluZyBqb2IuCj4KPiBb
SG93XQo+IElmIHRoZSBqb2IgaXMgYSBrZXJuZWwgam9iLCB3ZSB3aWxsIGFsd2F5cyBjb25zaWRl
ciBpdCBub3QgZ3VpbHR5Cj4KPiBTaWduZWQtb2ZmLWJ5OiBKaW5nd2VuIENoZW4gPEppbmd3ZW4u
Q2hlbjJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgNiArKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCj4gaW5kZXggMzdmYTE5OWJlOGIzLi40MDQ2MTU0NzcwMWEgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTQ0MTAsNyArNDQx
MCw3IEBAIGludCBhbWRncHVfZGV2aWNlX3ByZV9hc2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAo+ICAgCQlhbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24ocmlu
Zyk7Cj4gICAJfQo+ICAgCj4gLQlpZihqb2IpCj4gKwlpZiAoam9iICYmIGpvYi0+dm0pCj4gICAJ
CWRybV9zY2hlZF9pbmNyZWFzZV9rYXJtYSgmam9iLT5iYXNlKTsKPiAgIAo+ICAgCXIgPSBhbWRn
cHVfcmVzZXRfcHJlcGFyZV9od2NvbnRleHQoYWRldiwgcmVzZXRfY29udGV4dCk7Cj4gQEAgLTQ4
NzQsNyArNDg3NCw3IEBAIGludCBhbWRncHVfZGV2aWNlX2dwdV9yZWNvdmVyKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAo+ICAgCQkJRFJNX0lORk8oIkJhaWxpbmcgb24gVERSIGZvciBzX2pv
YjolbGx4LCBoaXZlOiAlbGx4IGFzIGFub3RoZXIgYWxyZWFkeSBpbiBwcm9ncmVzcyIsCj4gICAJ
CQkJam9iID8gam9iLT5iYXNlLmlkIDogLTEsIGhpdmUtPmhpdmVfaWQpOwo+ICAgCQkJYW1kZ3B1
X3B1dF94Z21pX2hpdmUoaGl2ZSk7Cj4gLQkJCWlmIChqb2IpCj4gKwkJCWlmIChqb2IgJiYgam9i
LT52bSkKPiAgIAkJCQlkcm1fc2NoZWRfaW5jcmVhc2Vfa2FybWEoJmpvYi0+YmFzZSk7Cj4gICAJ
CQlyZXR1cm4gMDsKPiAgIAkJfQo+IEBAIC00ODk4LDcgKzQ4OTgsNyBAQCBpbnQgYW1kZ3B1X2Rl
dmljZV9ncHVfcmVjb3ZlcihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAkJCQkJam9i
ID8gam9iLT5iYXNlLmlkIDogLTEpOwo+ICAgCj4gICAJCS8qIGV2ZW4gd2Ugc2tpcHBlZCB0aGlz
IHJlc2V0LCBzdGlsbCBuZWVkIHRvIHNldCB0aGUgam9iIHRvIGd1aWx0eSAqLwo+IC0JCWlmIChq
b2IpCj4gKwkJaWYgKGpvYiAmJiBqb2ItPnZtKQo+ICAgCQkJZHJtX3NjaGVkX2luY3JlYXNlX2th
cm1hKCZqb2ItPmJhc2UpOwo+ICAgCQlnb3RvIHNraXBfcmVjb3Zlcnk7Cj4gICAJfQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5n
IGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVz
a3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
