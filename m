Return-Path: <SRS0=b/N7=3C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC6AC33CAD
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 12:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67622080D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2020 12:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5XgHJVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67622080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89ADE6E09A;
	Mon, 13 Jan 2020 12:16:23 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2A46E08C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 12:16:22 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id p9so9413839wmc.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jan 2020 04:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=BXSCP/jrLroPqwjjaN/dwy3ojoxuC3Ww6KTfy6BATco=;
 b=L5XgHJVPdMerCuswgSafz75dIXqxTyDZY3Z7nDgxCSHAqxgasITVe4Sxjmqlx5Ofts
 VGReOwv/4K7ni4jxvUD7tRZ4SIIvurzboRPXntTg7RTU2YoEztbUu7DTAB1nwHa26B4s
 WeUeouRKHtDrYtNaABr3xFQSSGrGu0vrxH9rtwAeElRLPzppa2+KgYQGOAj0AFH9rCUN
 RQbQXSH5vbICG2hzWjLqfEq9EUcab3YsrhUII8sFwpPRL6ZHbUJg3smgs2igLfsGlhFg
 WWebqXK8c25jLQfVfwxOTs37svef6Flpzt0khGlneZH7jdPynWWcIvoaZcS6SybQmvUI
 yGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=BXSCP/jrLroPqwjjaN/dwy3ojoxuC3Ww6KTfy6BATco=;
 b=anaRpm2KrQ4rNQM4dZN/rlNA5j7z09CBKzNeZ4ZfwZJJFs29xen1FN/DlggAF9Zape
 zyhRvSQzCv7uuUAhIZTri+TpdgAtIrXiu3MbpYaSHjntENjFKWI13hmIE9BmgW5Vwld/
 T3L7mAc2hmxajuJsjPDHH0YWZChRF6znA376cnX2JCx4UcjGWoDn3mNA9LGSlWbo8cqa
 oL/9IOF17cHyxNACN0qtaoesRcO1aOEjDeNSHSo+mhhlqkstmJrCVxSP0vtINleJ+0DD
 tt68BgJAbQsba9aMSckAY70IpQC5dCaiVs6LU09jiH2cBOZMv4Ei3FUln1Qwpi0hPel8
 dcbA==
X-Gm-Message-State: APjAAAWKgWlInxTNYU3Il6Fo8V1xWsz8fugExL83GvNfonmohE7om8Gp
 1xoSSbD1Sh4scZb+cbUuO1eUOJ9l
X-Google-Smtp-Source: APXvYqzgZxH798kd1QkqF/mkVrP9UXlWSis6P3SDnV/qCOYavcVCAOrJgPzoaBsCzq5MVUMzTohY+w==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr19384822wmj.165.1578917781180; 
 Mon, 13 Jan 2020 04:16:21 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id x10sm14231345wrv.60.2020.01.13.04.16.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Jan 2020 04:16:20 -0800 (PST)
Subject: Re: [PATCH 6/7] drm/amdgpu: GPU TLB flush API moved to amdgpu_amdkfd
To: Alex Sierra <alex.sierra@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200111183938.126310-1-alex.sierra@amd.com>
 <20200111183938.126310-6-alex.sierra@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fa31749e-95eb-23cc-b9a8-08fef92c04fc@gmail.com>
Date: Mon, 13 Jan 2020 13:16:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200111183938.126310-6-alex.sierra@amd.com>
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

QW0gMTEuMDEuMjAgdW0gMTk6Mzkgc2NocmllYiBBbGV4IFNpZXJyYToKPiBbV2h5XQo+IFRMQiBm
bHVzaCBtZXRob2QgaGFzIGJlZW4gZGVwcmVjYXRlZCB1c2luZyBrZmQya2dkIGludGVyZmFjZS4K
PiBUaGlzIGltcGxlbWVudGF0aW9uIGlzIG5vdyBvbiB0aGUgYW1kZ3B1X2FtZGtmZCBBUEkuCj4K
PiBbSG93XQo+IFRMQiBmbHVzaCBmdW5jdGlvbnMgbm93IGltcGxlbWVudGVkIGluIGFtZGdwdV9h
bWRrZmQuCj4KPiBDaGFuZ2UtSWQ6IEljNTFjY2NkZmU2ZTcxMjg4ZDc4ZGE3NzJiNmUxYjZjZWQ3
MmY4ZWY3Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+
CgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoK
PiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRrZmQuYyB8IDMy
ICsrKysrKysrKysrKysrKysrKysrKysKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuaCB8ICAyICsrCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRf
cHJvY2Vzcy5jICAgfCAgOCArKysrLS0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfYW1ka2ZkLmMKPiBpbmRleCA4OGUxMGI5NTY0MTMuLjg2MDkyODc2MjBlYSAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMKPiBAQCAtNjI4LDYgKzYy
OCwzOCBAQCBib29sIGFtZGdwdV9hbWRrZmRfaXNfa2ZkX3ZtaWQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHUzMiB2bWlkKQo+ICAgCXJldHVybiBmYWxzZTsKPiAgIH0KPiAgIAo+ICtpbnQg
YW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3ZtaWQoc3RydWN0IGtnZF9kZXYgKmtnZCwgdWlu
dDE2X3Qgdm1pZCkKPiArewo+ICsJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKilrZ2Q7Cj4gKwo+ICsJaWYgKGFkZXYtPmZhbWlseSA9PSBBTURHUFVf
RkFNSUxZX0FJKSB7Cj4gKwkJaW50IGk7Cj4gKwo+ICsJCWZvciAoaSA9IDA7IGkgPCBhZGV2LT5u
dW1fdm1odWJzOyBpKyspCj4gKwkJCWFtZGdwdV9nbWNfZmx1c2hfZ3B1X3RsYihhZGV2LCB2bWlk
LCBpLCAwKTsKPiArCX0gZWxzZSB7Cj4gKwkJYW1kZ3B1X2dtY19mbHVzaF9ncHVfdGxiKGFkZXYs
IHZtaWQsIEFNREdQVV9HRlhIVUJfMCwgMCk7Cj4gKwl9Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30K
PiArCj4gK2ludCBhbWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfcGFzaWQoc3RydWN0IGtnZF9k
ZXYgKmtnZCwgdWludDE2X3QgcGFzaWQpCj4gK3sKPiArCXN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopa2dkOwo+ICsJdWludDMyX3QgZmx1c2hfdHlw
ZSA9IDA7Cj4gKwlib29sIGFsbF9odWIgPSBmYWxzZTsKPiArCj4gKwlpZiAoYWRldi0+Z21jLnhn
bWkubnVtX3BoeXNpY2FsX25vZGVzICYmCj4gKwkJYWRldi0+YXNpY190eXBlID09IENISVBfVkVH
QTIwKQo+ICsJCWZsdXNoX3R5cGUgPSAyOwo+ICsKPiArCWlmIChhZGV2LT5mYW1pbHkgPT0gQU1E
R1BVX0ZBTUlMWV9BSSkKPiArCQlhbGxfaHViID0gdHJ1ZTsKPiArCj4gKwlyZXR1cm4gYW1kZ3B1
X2dtY19mbHVzaF9ncHVfdGxiX3Bhc2lkKGFkZXYsIHBhc2lkLCBmbHVzaF90eXBlLCBhbGxfaHVi
KTsKPiArfQo+ICsKPiAgIGJvb2wgYW1kZ3B1X2FtZGtmZF9oYXZlX2F0b21pY3Nfc3VwcG9ydChz
dHJ1Y3Qga2dkX2RldiAqa2dkKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopa2dkOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfYW1ka2ZkLmgKPiBpbmRleCAwNjlkNWQyMzA4MTAuLjQ3YjBmMjk1N2QxZiAx
MDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgK
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgKPiBAQCAt
MTM2LDYgKzEzNiw4IEBAIGludCBhbWRncHVfYW1ka2ZkX3N1Ym1pdF9pYihzdHJ1Y3Qga2dkX2Rl
diAqa2dkLCBlbnVtIGtnZF9lbmdpbmVfdHlwZSBlbmdpbmUsCj4gICAJCQkJdWludDMyX3QgKmli
X2NtZCwgdWludDMyX3QgaWJfbGVuKTsKPiAgIHZvaWQgYW1kZ3B1X2FtZGtmZF9zZXRfY29tcHV0
ZV9pZGxlKHN0cnVjdCBrZ2RfZGV2ICprZ2QsIGJvb2wgaWRsZSk7Cj4gICBib29sIGFtZGdwdV9h
bWRrZmRfaGF2ZV9hdG9taWNzX3N1cHBvcnQoc3RydWN0IGtnZF9kZXYgKmtnZCk7Cj4gK2ludCBh
bWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfdm1pZChzdHJ1Y3Qga2dkX2RldiAqa2dkLCB1aW50
MTZfdCB2bWlkKTsKPiAraW50IGFtZGdwdV9hbWRrZmRfZmx1c2hfZ3B1X3RsYl9wYXNpZChzdHJ1
Y3Qga2dkX2RldiAqa2dkLCB1aW50MTZfdCBwYXNpZCk7Cj4gICAKPiAgIGJvb2wgYW1kZ3B1X2Ft
ZGtmZF9pc19rZmRfdm1pZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIHZtaWQpOwo+
ICAgCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcm9jZXNz
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJvY2Vzcy5jCj4gaW5kZXggNTM2
YTE1M2FjOWE0Li4yNWI5MGY3MGFlY2QgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRrZmQva2ZkX3Byb2Nlc3MuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L2tmZF9wcm9jZXNzLmMKPiBAQCAtMzIsNiArMzIsNyBAQAo+ICAgI2luY2x1ZGUgPGxpbnV4L21t
YW4uaD4KPiAgICNpbmNsdWRlIDxsaW51eC9maWxlLmg+Cj4gICAjaW5jbHVkZSAiYW1kZ3B1X2Ft
ZGtmZC5oIgo+ICsjaW5jbHVkZSAiYW1kZ3B1LmgiCj4gICAKPiAgIHN0cnVjdCBtbV9zdHJ1Y3Q7
Cj4gICAKPiBAQCAtMTE1MiwxNiArMTE1MywxNyBAQCBpbnQga2ZkX3Jlc2VydmVkX21lbV9tbWFw
KHN0cnVjdCBrZmRfZGV2ICpkZXYsIHN0cnVjdCBrZmRfcHJvY2VzcyAqcHJvY2VzcywKPiAgIHZv
aWQga2ZkX2ZsdXNoX3RsYihzdHJ1Y3Qga2ZkX3Byb2Nlc3NfZGV2aWNlICpwZGQpCj4gICB7Cj4g
ICAJc3RydWN0IGtmZF9kZXYgKmRldiA9IHBkZC0+ZGV2Owo+IC0JY29uc3Qgc3RydWN0IGtmZDJr
Z2RfY2FsbHMgKmYyZyA9IGRldi0+a2ZkMmtnZDsKPiAgIAo+ICAgCWlmIChkZXYtPmRxbS0+c2No
ZWRfcG9saWN5ID09IEtGRF9TQ0hFRF9QT0xJQ1lfTk9fSFdTKSB7Cj4gICAJCS8qIE5vdGhpbmcg
dG8gZmx1c2ggdW50aWwgYSBWTUlEIGlzIGFzc2lnbmVkLCB3aGljaAo+ICAgCQkgKiBvbmx5IGhh
cHBlbnMgd2hlbiB0aGUgZmlyc3QgcXVldWUgaXMgY3JlYXRlZC4KPiAgIAkJICovCj4gICAJCWlm
IChwZGQtPnFwZC52bWlkKQo+IC0JCQlmMmctPmludmFsaWRhdGVfdGxic192bWlkKGRldi0+a2dk
LCBwZGQtPnFwZC52bWlkKTsKPiArCQkJYW1kZ3B1X2FtZGtmZF9mbHVzaF9ncHVfdGxiX3ZtaWQo
ZGV2LT5rZ2QsCj4gKwkJCQkJCQlwZGQtPnFwZC52bWlkKTsKPiAgIAl9IGVsc2Ugewo+IC0JCWYy
Zy0+aW52YWxpZGF0ZV90bGJzKGRldi0+a2dkLCBwZGQtPnByb2Nlc3MtPnBhc2lkKTsKPiArCQlh
bWRncHVfYW1ka2ZkX2ZsdXNoX2dwdV90bGJfcGFzaWQoZGV2LT5rZ2QsCj4gKwkJCQkJCXBkZC0+
cHJvY2Vzcy0+cGFzaWQpOwo+ICAgCX0KPiAgIH0KPiAgIAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
