Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D6CC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 07:35:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C3EA206A5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 07:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5h40Arh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C3EA206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1986EB71;
	Fri, 10 Jul 2020 07:35:46 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 247706EB70
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 07:35:45 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z2so4881249wrp.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=gZM2gUzapCBYarlAWIuGnH1Vagi7Z7Q+k33FrgXquV0=;
 b=j5h40ArhoWl/+XF8uDuKntHKEAOmrfHhEQvB5ptBsOyvKGZ1f5UIrKsCVGFuUlO72x
 UIKF2dnyJ0KvhawYcnXTGD9QYpixPurGCJ4fgbrbCJSJ2q/VPpaxTneFJRfHc7hmqF7I
 TojXza6OchrguY0u/M1AUskCuKRBVwf00jiPJoqkaKgGH5F6EEZSPzVPk/GbL2FgDJ9r
 GavXk1qy/VyvNiIlWBFIiVm6cfYe8e4cQkmyueteYkECT96yh1dRaG2S0YMJIXlSGJFQ
 LP3wzhFlArgLNqOpi2oN9eJyb4IGdXPvzVWXUzPxkD7mgE6TrxGMPA83mhCYbkQRKAM2
 w82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=gZM2gUzapCBYarlAWIuGnH1Vagi7Z7Q+k33FrgXquV0=;
 b=Rk/uoENfy3HKDQMdtDuqxrD2A/kMyrOmvCrs1SwH7v5UTEG6qAq25nLJAbwsdDkB41
 hYAhCUPGLUFljLUXiDXXF5xiBSjKxsfv7C501E6cxrrXgApIKE+heCMS4o5SamIW20ry
 gCDUk1dex5/9dr/6g8wChhbeDQfOmJz66cIivJ4tWj66JfYhaHTYitMzzDQMkQNOf42k
 dLneNrPgxIatu1VsycXjsqFeGbPXgpb0v7l/gpbltV9sJkb6P5YftcMjYnZ7LoV9p/y5
 7Ee57PfS33xNUwsi5t6n4UnQIKELyRYZEJ5xtNPFb39TQGVIbTlj0ekvdPAhgncYmAMK
 h6zQ==
X-Gm-Message-State: AOAM530sJw8xrTVwqK1/eBvPYINrq1A03nGFes5e566qBtuLHv2XG4DZ
 4P0yLvsndTyqpzsfdNf6z1m5OTdC
X-Google-Smtp-Source: ABdhPJxNRUHEYE1Uf6h29XRbBZvW3kLkRBjJhNQyYdxlVXyZ+bRpAgICrXRraJx5OvpoP9xduclX8Q==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr63324983wrq.243.1594366543777; 
 Fri, 10 Jul 2020 00:35:43 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id c25sm7633892wml.46.2020.07.10.00.35.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jul 2020 00:35:43 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx10: fix race condition for kiq
To: Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
References: <20200710054452.2058855-1-Jack.Xiao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <49b4e0c9-35d1-f01f-ca7f-e672c6b346f7@gmail.com>
Date: Fri, 10 Jul 2020 09:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200710054452.2058855-1-Jack.Xiao@amd.com>
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

QW0gMTAuMDcuMjAgdW0gMDc6NDQgc2NocmllYiBKYWNrIFhpYW86Cj4gRHVyaW5nIHByZWVtcHRp
b24gdGVzdCBmb3IgZ2Z4MTAsIGl0IHVzZXMga2lxIHRvIHRyaWdnZXIKPiBnZnggcHJlZW1wdGlv
biwgd2hpY2ggd291bGQgcmVzdWx0IGluIHJhY2UgY29uZGl0aW9uCj4gd2l0aCBmbHVzaGluZyBU
TEIgZm9yIGtpcS4KPgo+IFNpZ25lZC1vZmYtYnk6IEphY2sgWGlhbyA8SmFjay5YaWFvQGFtZC5j
b20+CgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgOSAr
KysrKysrKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jCj4gaW5kZXggYTYxNzBh
MzQ2YjM5Li5kZGY2ZDgxMjg3NTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYwo+IEBAIC03ODM2LDEyICs3ODM2LDE3IEBAIHN0YXRpYyBpbnQgZ2Z4X3YxMF8wX3Jp
bmdfcHJlZW1wdF9pYihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcpCj4gICAJc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+ICAgCXN0cnVjdCBhbWRncHVfa2lxICpraXEg
PSAmYWRldi0+Z2Z4LmtpcTsKPiAgIAlzdHJ1Y3QgYW1kZ3B1X3JpbmcgKmtpcV9yaW5nID0gJmtp
cS0+cmluZzsKPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7Cj4gICAKPiAgIAlpZiAoIWtpcS0+cG1m
IHx8ICFraXEtPnBtZi0+a2lxX3VubWFwX3F1ZXVlcykKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4g
ICAKPiAtCWlmIChhbWRncHVfcmluZ19hbGxvYyhraXFfcmluZywga2lxLT5wbWYtPnVubWFwX3F1
ZXVlc19zaXplKSkKPiArCXNwaW5fbG9ja19pcnFzYXZlKCZraXEtPnJpbmdfbG9jaywgZmxhZ3Mp
Owo+ICsKPiArCWlmIChhbWRncHVfcmluZ19hbGxvYyhraXFfcmluZywga2lxLT5wbWYtPnVubWFw
X3F1ZXVlc19zaXplKSkgewo+ICsJCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmtpcS0+cmluZ19s
b2NrLCBmbGFncyk7Cj4gICAJCXJldHVybiAtRU5PTUVNOwo+ICsJfQo+ICAgCj4gICAJLyogYXNz
ZXJ0IHByZWVtcHRpb24gY29uZGl0aW9uICovCj4gICAJYW1kZ3B1X3Jpbmdfc2V0X3ByZWVtcHRf
Y29uZF9leGVjKHJpbmcsIGZhbHNlKTsKPiBAQCAtNzg1Miw2ICs3ODU3LDggQEAgc3RhdGljIGlu
dCBnZnhfdjEwXzBfcmluZ19wcmVlbXB0X2liKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPiAg
IAkJCQkgICArK3JpbmctPnRyYWlsX3NlcSk7Cj4gICAJYW1kZ3B1X3JpbmdfY29tbWl0KGtpcV9y
aW5nKTsKPiAgIAo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgma2lxLT5yaW5nX2xvY2ssIGZs
YWdzKTsKPiArCj4gICAJLyogcG9sbCB0aGUgdHJhaWxpbmcgZmVuY2UgKi8KPiAgIAlmb3IgKGkg
PSAwOyBpIDwgYWRldi0+dXNlY190aW1lb3V0OyBpKyspIHsKPiAgIAkJaWYgKHJpbmctPnRyYWls
X3NlcSA9PQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
