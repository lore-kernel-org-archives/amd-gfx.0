Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7671EC433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 08:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B6DA20776
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 08:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp11JgiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6DA20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F3B6E3B7;
	Fri, 28 Aug 2020 08:16:49 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com
 [IPv6:2a00:1450:4864:20::641])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A12E6E3B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 08:16:48 +0000 (UTC)
Received: by mail-ej1-x641.google.com with SMTP id d26so411865ejr.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 01:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=5HHn8t3WadlHaTxbdC9x4H0nHpTSTvT70LHfs6b5Ou8=;
 b=qp11JgiZffk5zsHm6/4fs3ejyyrRBKAYmetUi8kYdKP7HXNVfI9aI8cy6GejW9/hEZ
 D/HRA15LEpKTAss3/ijJAgu88jUw9Q4alJUSTn9lIW/G64Ehd5Ijn9PepoTaduXRj1/F
 9mMXvdagzHX5mmUPwyrfzdEvpiWefqxBOPc9UFFHQYcCqTIjuums7QD1cgpPJex9BB3r
 O6mWatysZ1RuDKQ+dWk3yhr4UjpKCMfQc/+PZOa8KspGBzeRbGLneHkvInBcA2zpppOD
 IhRb+DXctuOZcU7X0j+iOw8GwJb+XVTij7bwak8s7jx8M9PJXGvJchbZwJm7M6kW91gZ
 zqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5HHn8t3WadlHaTxbdC9x4H0nHpTSTvT70LHfs6b5Ou8=;
 b=LS5H6AjxWBU6I6171yPPZPdTIldrRsCxB0egDCh69sHW//jxyXhD31XwuGfF7FeYVZ
 otjPXBCk6OQxeREAGn4nXNu45Jr//w1b4OUZ64j+7IroRi2Rd8PUHKJji9G0+Gp16Be8
 6oEda6O9jR6fgd8zuFsMeGMKcXra/ulnk2yJ6g+Db6nMGKKKwR/A3ZP6I/VMEOv2r2iJ
 3cJq/v7baGmeGw21ztLfVtEsboTRulVs8sGl0V79tqcHZvqGJT8iO7YwVcDWfKunE/LC
 cEsl7X30/k3RBcMMrDBYu61RmusMCzl9G0XJ1faYtom0jn8roBXcgbDWO+DihcQKDocw
 cURg==
X-Gm-Message-State: AOAM530ZUU/kHwObJDzN831NuFvuSQvPTzyjcXG6jtI2CwPWi5gzvz1U
 dntj/eWJ9fvM8/8s5T99il8RiaZgDJI=
X-Google-Smtp-Source: ABdhPJwZPWuhIAO5P+ut+KaIV2iKOP4HuMIBQAgreiu5MrqM2//RW4/q/Yt9nR3qBUbhMAWdaQqhjg==
X-Received: by 2002:a17:906:c1d7:: with SMTP id
 bw23mr622255ejb.315.1598602606926; 
 Fri, 28 Aug 2020 01:16:46 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id f13sm333450eds.85.2020.08.28.01.16.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 01:16:46 -0700 (PDT)
Subject: Re: [PATCH 1/4] drm/amd/pm: drop unnecessary feature->mutex lock
 protections(V2)
To: Nirmoy <nirmodas@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200825074923.32345-1-evan.quan@amd.com>
 <efc66f15-2291-dcdf-79eb-ce2085614360@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <92deaaac-9ac5-8005-7070-2965367701b6@gmail.com>
Date: Fri, 28 Aug 2020 10:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <efc66f15-2291-dcdf-79eb-ce2085614360@amd.com>
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

VGhlIGV4cGxhbmF0aW9uIHNvdW5kcyBzYW5lLCBidXQgc2luY2UgSSBkb24ndCBrbm93IHRoZSBh
ZmZlY3RlZCBjb2RlIGF0IAphbGwgdGhlIHNlcmllcyBpcyBvbmx5IEFja2VkLWJ5OiBDaHJpc3Rp
YW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpNYXliZSB3YWl0IGZvciBBbGV4
IHRvIGdpdmUgeW91IGFuIHJiIGlmIHlvdSBhcmUgdW5zdXJlLCBvdGhlcndpc2UgZmVlbCAKZnJl
ZSB0byBjb21taXQuCgpDaHJpc3RpYW4uCgpBbSAyNy4wOC4yMCB1bSAwODozOSBzY2hyaWViIE5p
cm1veToKPiBTZXJpZXMgaXMgQWNrZWQtYnk6IE5pcm1veSBEYXMgPG5pcm1veS5kYXNAYW1kLmNv
bT4KPgo+Cj4gT24gOC8yNS8yMCA5OjQ5IEFNLCBFdmFuIFF1YW4gd3JvdGU6Cj4+IEFzIHRoZXNl
IG9wZXJhdGlvbnMgYXJlIHBlcmZvcm1lZCBpbiBoYXJkd2FyZSBzZXR1cCBhbmQgdGhlcmUKPj4g
aXMgYWN0dWFsbHkgbm8gcmFjZSBjb25kaXRpb25zIGR1cmluZyB0aGlzIHBlcmlvZCBjb25zaWRl
cmluZzoKPj4gMS4gdGhlIGhhcmR3YXJlIHNldHVwIGlzIHNlcmlhbCBhbmQgY2Fubm5vdCBiZSBp
biBwYXJhbGxlbAo+PiAyLiBhbGwgb3RoZXIgb3BlcmF0aW9ucyBjYW4gYmUgcGVyZm9ybWVkIG9u
bHkgYWZ0ZXIgaGFyZHdhcmUKPj4gwqDCoMKgIHNldHVwIGNvbXBsZXRlLgo+Pgo+PiBWMjogcmlj
aCB0aGUgY29tbWl0IGxvZyBkZXNjcmlwdGlvbgo+Pgo+PiBDaGFuZ2UtSWQ6IEkwOTZkN2FiMDg1
NWZmNTliMGVjYjU2ZmQ5ZDZkOTk0NmIzNjA1ZmM4Cj4+IFNpZ25lZC1vZmYtYnk6IEV2YW4gUXVh
biA8ZXZhbi5xdWFuQGFtZC5jb20+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3N3c211L2FtZGdwdV9zbXUuY8KgwqDCoMKgwqAgfCA0IC0tLS0KPj4gwqAgZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zbXVfdjExXzAuYyB8IDIgLS0KPj4gwqAgMiBmaWxlcyBj
aGFuZ2VkLCA2IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9wbS9zd3NtdS9hbWRncHVfc211LmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9z
d3NtdS9hbWRncHVfc211LmMKPj4gaW5kZXggMDlkYzUzMDM3NjJiLi5iN2NhZDhlZjYxNTMgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jCj4+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvYW1kZ3B1X3NtdS5jCj4+IEBAIC0z
NjEsMjAgKzM2MSwxNiBAQCBzdGF0aWMgaW50IAo+PiBzbXVfZ2V0X2RyaXZlcl9hbGxvd2VkX2Zl
YXR1cmVfbWFzayhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSkKPj4gwqDCoMKgwqDCoCBpbnQgcmV0
ID0gMDsKPj4gwqDCoMKgwqDCoCB1aW50MzJfdCBhbGxvd2VkX2ZlYXR1cmVfbWFza1tTTVVfRkVB
VFVSRV9NQVgvMzJdOwo+PiDCoCAtwqDCoMKgIG11dGV4X2xvY2soJmZlYXR1cmUtPm11dGV4KTsK
Pj4gwqDCoMKgwqDCoCBiaXRtYXBfemVybyhmZWF0dXJlLT5hbGxvd2VkLCBTTVVfRkVBVFVSRV9N
QVgpOwo+PiAtwqDCoMKgIG11dGV4X3VubG9jaygmZmVhdHVyZS0+bXV0ZXgpOwo+PiDCoCDCoMKg
wqDCoMKgIHJldCA9IHNtdV9nZXRfYWxsb3dlZF9mZWF0dXJlX21hc2soc211LCBhbGxvd2VkX2Zl
YXR1cmVfbWFzaywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBTTVVfRkVBVFVSRV9NQVgvMzIpOwo+PiDCoMKgwqDCoMKgIGlmIChyZXQpCj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+PiDCoCAtwqDCoMKgIG11dGV4X2xvY2so
JmZlYXR1cmUtPm11dGV4KTsKPj4gwqDCoMKgwqDCoCBiaXRtYXBfb3IoZmVhdHVyZS0+YWxsb3dl
ZCwgZmVhdHVyZS0+YWxsb3dlZCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICh1
bnNpZ25lZCBsb25nICopYWxsb3dlZF9mZWF0dXJlX21hc2ssCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBmZWF0dXJlLT5mZWF0dXJlX251bSk7Cj4+IC3CoMKgwqAgbXV0ZXhfdW5s
b2NrKCZmZWF0dXJlLT5tdXRleCk7Cj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIHJldDsKPj4gwqAg
fQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9zd3NtdS9zbXUxMS9zbXVf
djExXzAuYyAKPj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NtdV92MTFf
MC5jCj4+IGluZGV4IDU0OGRiMWVkZDM1Mi4uMjhhMTlmZmQyMmExIDEwMDY0NAo+PiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3N3c211L3NtdTExL3NtdV92MTFfMC5jCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vc3dzbXUvc211MTEvc211X3YxMV8wLmMKPj4gQEAgLTcyMSw3
ICs3MjEsNiBAQCBpbnQgc211X3YxMV8wX3NldF9hbGxvd2VkX21hc2soc3RydWN0IHNtdV9jb250
ZXh0IAo+PiAqc211KQo+PiDCoMKgwqDCoMKgIGludCByZXQgPSAwOwo+PiDCoMKgwqDCoMKgIHVp
bnQzMl90IGZlYXR1cmVfbWFza1syXTsKPj4gwqAgLcKgwqDCoCBtdXRleF9sb2NrKCZmZWF0dXJl
LT5tdXRleCk7Cj4+IMKgwqDCoMKgwqAgaWYgKGJpdG1hcF9lbXB0eShmZWF0dXJlLT5hbGxvd2Vk
LCBTTVVfRkVBVFVSRV9NQVgpIHx8IAo+PiBmZWF0dXJlLT5mZWF0dXJlX251bSA8IDY0KQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgZ290byBmYWlsZWQ7Cj4+IMKgIEBAIC03MzgsNyArNzM3LDYgQEAg
aW50IHNtdV92MTFfMF9zZXRfYWxsb3dlZF9tYXNrKHN0cnVjdCAKPj4gc211X2NvbnRleHQgKnNt
dSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gZmFpbGVkOwo+PiDCoCDCoCBmYWlsZWQ6Cj4+
IC3CoMKgwqAgbXV0ZXhfdW5sb2NrKCZmZWF0dXJlLT5tdXRleCk7Cj4+IMKgwqDCoMKgwqAgcmV0
dXJuIHJldDsKPj4gwqAgfQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
