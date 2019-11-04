Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F255CA9EA0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 12:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE24921E6F
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 12:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE24921E6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2786E316;
	Mon,  4 Nov 2019 12:15:40 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40ECA6E30E;
 Mon,  4 Nov 2019 12:15:38 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id w18so16816768wrt.3;
 Mon, 04 Nov 2019 04:15:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=kgaLOfDehIIJnMyO/MNt6yFQwc6+ICB3GSdiRkEpiAU=;
 b=S1Cq6VMpKDhtuMriX8kofTw1Q3lDH0K/lrwZ/ojNrPCZXRTuL381fBk0xAWUHNcc93
 5V8CPqA/OzuQO/kDPRyLLnn6BaOrm2y85G+f/dK8f/BqHwCP+LEz+b9nUPlxlL93vRUR
 lnC5mG3gLt4rG7veiGrJ13vWtq/36lDndzjVS3Wx6LOA0skPLCaDWG3vijRc48QkMG7G
 7TfHIacGjQ74RcPco0i6PTxQLH8DUvdE/df9ZDcbMb3aBG/EQXjQ59SiSF89XnpuuMj6
 Vne+1VKmuD/enMZ822vWUUEgTTU18UBwmz55JhF6ZqnbiHbqNujBFTEP2QXStMckmlfL
 1LSg==
X-Gm-Message-State: APjAAAUNCc74abl6c0bEga8NKD9F8oFQhwDLPFheUFC4xbDmteijZxh5
 CbL7awsEupto6CwgoqMnMcqFk421
X-Google-Smtp-Source: APXvYqz+I/M9QPJH6yizbQkRALEWCUXFcBzoTM5rVB65JWd3evNGCBoUSeGLFKKyO5cu9Q/xaxorKA==
X-Received: by 2002:adf:f547:: with SMTP id j7mr23755132wrp.69.1572869736813; 
 Mon, 04 Nov 2019 04:15:36 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id x205sm22208906wmb.5.2019.11.04.04.15.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 Nov 2019 04:15:36 -0800 (PST)
Subject: Re: [PATCH v2] drm/sched: Fix passing zero to 'PTR_ERR' warning
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>
References: <1572372468-20569-1-git-send-email-andrey.grodzovsky@amd.com>
 <MN2PR12MB29755DDF54361142B8340FEF8F7F0@MN2PR12MB2975.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7e09156c-db05-ca46-08f0-c871c2ada43f@gmail.com>
Date: Mon, 4 Nov 2019 13:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB29755DDF54361142B8340FEF8F7F0@MN2PR12MB2975.namprd12.prod.outlook.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=kgaLOfDehIIJnMyO/MNt6yFQwc6+ICB3GSdiRkEpiAU=;
 b=RqGeQwW1c/Eiet7egdiGrrtm1dFDaeLTNUDDOHThgLDELWsiCtg2nv2oKJE52Emfbo
 eSwp2yfwmCG/T5aNRDBdjeWMgrnhsymRQGt4KjCzoGExJQ1ByU5xoeXPzj0DDFuXqsDa
 N0DXoF8eapFZYVtujRrbojnchTSPD5PARvXYwqTwR2SBqhXgrOuGb5D0lS5UEmi6n8Ml
 0p6b9bW/aeK2Ik7OEaDp1+bAKu7ruF/mqCjGlNiacPfRNNMs8bMEC9ijaFBZdvwY1I+t
 JfE5gOHCuduoNtnKUV7qFwGvBknpxKXtzMqzfdnzyjZOWYSA+7+KzEciE0pxFy1MXtD3
 t/5Q==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104121534.RGrvMz66xruW20Oy_jERXrJP1LOadreuU0sJD-S8aZw@z>

UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
CkFtIDA0LjExLjE5IHVtIDA0OjM3IHNjaHJpZWIgRGVuZywgRW1pbHk6Cj4gUmV2aWV3ZWQtYnk6
IEVtaWx5IERlbmcgPEVtaWx5LkRlbmdAYW1kLmNvbT4KPgo+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQo+PiBGcm9tOiBhbWQtZ2Z4IDxhbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnPiBPbiBCZWhhbGYgT2YKPj4gQW5kcmV5IEdyb2R6b3Zza3kKPj4gU2VudDogV2VkbmVz
ZGF5LCBPY3RvYmVyIDMwLCAyMDE5IDI6MDggQU0KPj4gVG86IGRhbi5jYXJwZW50ZXJAb3JhY2xl
LmNvbQo+PiBDYzogR3JvZHpvdnNreSwgQW5kcmV5IDxBbmRyZXkuR3JvZHpvdnNreUBhbWQuY29t
PjsgYW1kLQo+PiBnZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBkcmktZGV2ZWxAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gZHJtL3NjaGVkOiBGaXggcGFzc2lu
ZyB6ZXJvIHRvICdQVFJfRVJSJyB3YXJuaW5nCj4+Cj4+IEZpeCBhIHN0YXRpYyBjb2RlIGNoZWNr
ZXIgd2FybmluZy4KPj4KPj4gdjI6IERyb3AgUFRSX0VSUl9PUl9aRVJPLgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBBbmRyZXkgR3JvZHpvdnNreSA8YW5kcmV5Lmdyb2R6b3Zza3lAYW1kLmNvbT4KPj4g
LS0tCj4+IGRyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jIHwgNyArKysrKy0t
Cj4+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vc2NoZWR1bGVyL3NjaGVkX21haW4uYwo+PiBi
L2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+IGluZGV4IGYzOWI5N2Uu
LmRiYTQzOTAgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRf
bWFpbi5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9zY2hlZHVsZXIvc2NoZWRfbWFpbi5jCj4+
IEBAIC00OTYsOCArNDk2LDEwIEBAIHZvaWQgZHJtX3NjaGVkX3Jlc3VibWl0X2pvYnMoc3RydWN0
Cj4+IGRybV9ncHVfc2NoZWR1bGVyICpzY2hlZCkKPj4gCQlmZW5jZSA9IHNjaGVkLT5vcHMtPnJ1
bl9qb2Ioc19qb2IpOwo+Pgo+PiAJCWlmIChJU19FUlJfT1JfTlVMTChmZW5jZSkpIHsKPj4gKwkJ
CWlmIChJU19FUlIoZmVuY2UpKQo+PiArCQkJCWRtYV9mZW5jZV9zZXRfZXJyb3IoJnNfZmVuY2Ut
PmZpbmlzaGVkLAo+PiBQVFJfRVJSKGZlbmNlKSk7Cj4+ICsKPj4gCQkJc19qb2ItPnNfZmVuY2Ut
PnBhcmVudCA9IE5VTEw7Cj4+IC0JCQlkbWFfZmVuY2Vfc2V0X2Vycm9yKCZzX2ZlbmNlLT5maW5p
c2hlZCwKPj4gUFRSX0VSUihmZW5jZSkpOwo+PiAJCX0gZWxzZSB7Cj4+IAkJCXNfam9iLT5zX2Zl
bmNlLT5wYXJlbnQgPSBmZW5jZTsKPj4gCQl9Cj4+IEBAIC03NDEsOCArNzQzLDkgQEAgc3RhdGlj
IGludCBkcm1fc2NoZWRfbWFpbih2b2lkICpwYXJhbSkKPj4gCQkJCQkgIHIpOwo+PiAJCQlkbWFf
ZmVuY2VfcHV0KGZlbmNlKTsKPj4gCQl9IGVsc2Ugewo+PiArCQkJaWYgKElTX0VSUihmZW5jZSkp
Cj4+ICsJCQkJZG1hX2ZlbmNlX3NldF9lcnJvcigmc19mZW5jZS0+ZmluaXNoZWQsCj4+IFBUUl9F
UlIoZmVuY2UpKTsKPj4KPj4gLQkJCWRtYV9mZW5jZV9zZXRfZXJyb3IoJnNfZmVuY2UtPmZpbmlz
aGVkLAo+PiBQVFJfRVJSKGZlbmNlKSk7Cj4+IAkJCWRybV9zY2hlZF9wcm9jZXNzX2pvYihOVUxM
LCAmc2NoZWRfam9iLT5jYik7Cj4+IAkJfQo+Pgo+PiAtLQo+PiAyLjcuNAo+Pgo+PiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxp
bmcgbGlzdAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL2xpc3Rz
LmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKPiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0
Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
