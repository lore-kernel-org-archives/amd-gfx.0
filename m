Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB58C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 07:14:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EBB61417
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 07:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EBB61417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D80A6E091;
	Fri,  4 Jun 2021 07:14:20 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29FE76E091;
 Fri,  4 Jun 2021 07:14:19 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id og14so7651236ejc.5;
 Fri, 04 Jun 2021 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=/P6C5qybY/q+1vxzvn7jQLyL3bc3qA6knEuzqM8bOeI=;
 b=sdAjb+7y9XnZqeiLqrH1Y6sUvIDUM+UCNXPdcFMtsz9Scw9z553DE2mIpv7gEoRc1I
 7oFcEiBDvG8N4bdsKxVXz1nxqj+IrOCBvQTqLnhVJUqZlfj7mprlCZTvIEBQD8GnN2S1
 h2/OFVzrMDU+7ErwECzqJrbg+fOh6CnOB5EGWaGmSBZPmhH1wJc5eFF/MdFnUA0+lJk2
 uC33Ywu5Q/83lAy5Vt6IB9koBU7W1bOpbYWshO1CszaNarFnyTGxRa+Hv9Te0k47Ax9e
 VhnhJQS7fUx7MObGaJvLWnnW+4vve/ZwRFXqVrXlC3ooocytRX/cnZNKJjGzUJ7XGog/
 c2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=/P6C5qybY/q+1vxzvn7jQLyL3bc3qA6knEuzqM8bOeI=;
 b=jrISxA3R2y6HaMtMlU5WiFM3vNasttmNJT8a1NxoGs8Zy0KvSohT6QjmpL6t13h5qU
 ws3QPe6/SrF0cKWNyVQdKjFzBhzndQ0DkpKfs6AQrbP8zq1nQQkZ/AL5pQYowTW/VOd9
 3N/G9cEUiwlvljH8Qdg6vuDaHnJW3A8esFKVxI+3aipU40p+H5MCB7QmTNtyj8+MeiRS
 E7V44wCvdKVRenIY4+KbmmBNfFuCJEmu9PSeKxOYjBL/FFxH3041Nl/5Wc8BIVL9+jwa
 suSh4LZxAvLFo0SjVvT71WzqnEUGUnDY0HQ9DmDN+wYqTwBkSpOmQ9k1Gypu3FialAX8
 KuYA==
X-Gm-Message-State: AOAM532AK8BCeGYB258xr2VX/1vpJV9HOq3w6V6TspEyJY19JWx+0blz
 N4+xJDjlDSlhe4hm7HmyKaxSWfJOBqo=
X-Google-Smtp-Source: ABdhPJwJELdgn0P0dMdg+NANfZtY50Z/FwT+gyijse6tn22fK5QP5EXZsAj56rMN30TDbJhuBCS0Fw==
X-Received: by 2002:a17:906:ccd9:: with SMTP id
 ot25mr2855004ejb.386.1622790857901; 
 Fri, 04 Jun 2021 00:14:17 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7b4b:873a:17b5:b581?
 ([2a02:908:1252:fb60:7b4b:873a:17b5:b581])
 by smtp.gmail.com with ESMTPSA id c19sm2874714edv.36.2021.06.04.00.14.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 00:14:17 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] radeon: fix coding issues reported from sparse
To: Chen Li <chenli@uniontech.com>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <87o8cnfr3s.wl-chenli@uniontech.com>
 <87lf7qfi1v.wl-chenli@uniontech.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <12eca88f-908c-4112-fb62-1f35c171b1f2@gmail.com>
Date: Fri, 4 Jun 2021 09:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87lf7qfi1v.wl-chenli@uniontech.com>
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

QW0gMDQuMDYuMjEgdW0gMDU6MDIgc2NocmllYiBDaGVuIExpOgo+IEFsc28gZml4IHNvbWUgY29k
aW5nIGlzc3VlIHJlcG9ydGVkIGZyb20gc3BhcnNlLgo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hlbiBM
aSA8Y2hlbmxpQHVuaW9udGVjaC5jb20+CgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24v
cmFkZW9uX3V2ZC5jIHwgMjQgKysrKysrKysrKysrKy0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl91dmQuYwo+IGluZGV4IGRmYTlmZGJlOThkYS4uODVhMWYyYzMxNzQ5IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3V2ZC5jCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdXZkLmMKPiBAQCAtMTUyLDkgKzE1MiwxMSBAQCBp
bnQgcmFkZW9uX3V2ZF9pbml0KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQo+ICAgCj4gICAJ
CQlyZGV2LT51dmQuZndfaGVhZGVyX3ByZXNlbnQgPSB0cnVlOwo+ICAgCj4gLQkJCWZhbWlseV9p
ZCA9IGxlMzJfdG9fY3B1KGhkci0+dWNvZGVfdmVyc2lvbikgJiAweGZmOwo+IC0JCQl2ZXJzaW9u
X21ham9yID0gKGxlMzJfdG9fY3B1KGhkci0+dWNvZGVfdmVyc2lvbikgPj4gMjQpICYgMHhmZjsK
PiAtCQkJdmVyc2lvbl9taW5vciA9IChsZTMyX3RvX2NwdShoZHItPnVjb2RlX3ZlcnNpb24pID4+
IDgpICYgMHhmZjsKPiArCQkJZmFtaWx5X2lkID0gKF9fZm9yY2UgdTMyKShoZHItPnVjb2RlX3Zl
cnNpb24pICYgMHhmZjsKPiArCQkJdmVyc2lvbl9tYWpvciA9IChsZTMyX3RvX2NwdSgoX19mb3Jj
ZSBfX2xlMzIpKGhkci0+dWNvZGVfdmVyc2lvbikpCj4gKwkJCQkJCQkgPj4gMjQpICYgMHhmZjsK
PiArCQkJdmVyc2lvbl9taW5vciA9IChsZTMyX3RvX2NwdSgoX19mb3JjZSBfX2xlMzIpKGhkci0+
dWNvZGVfdmVyc2lvbikpCj4gKwkJCQkJCQkgPj4gOCkgJiAweGZmOwo+ICAgCQkJRFJNX0lORk8o
IkZvdW5kIFVWRCBmaXJtd2FyZSBWZXJzaW9uOiAldS4ldSBGYW1pbHkgSUQ6ICV1XG4iLAo+ICAg
CQkJCSB2ZXJzaW9uX21ham9yLCB2ZXJzaW9uX21pbm9yLCBmYW1pbHlfaWQpOwo+ICAgCj4gQEAg
LTc5MSwxNyArNzkzLDE3IEBAIGludCByYWRlb25fdXZkX2dldF9jcmVhdGVfbXNnKHN0cnVjdCBy
YWRlb25fZGV2aWNlICpyZGV2LCBpbnQgcmluZywKPiAgIAkJcmV0dXJuIHI7Cj4gICAKPiAgIAkv
KiBzdGl0Y2ggdG9nZXRoZXIgYW4gVVZEIGNyZWF0ZSBtc2cgKi8KPiAtCXdyaXRlbChjcHVfdG9f
bGUzMigweDAwMDAwZGU0KSwgJm1zZ1swXSk7Cj4gKwl3cml0ZWwoKF9fZm9yY2UgdTMyKWNwdV90
b19sZTMyKDB4MDAwMDBkZTQpLCAmbXNnWzBdKTsKPiAgIAl3cml0ZWwoMHgwLCAodm9pZCBfX2lv
bWVtICopJm1zZ1sxXSk7Cj4gLQl3cml0ZWwoY3B1X3RvX2xlMzIoaGFuZGxlKSwgJm1zZ1syXSk7
Cj4gKwl3cml0ZWwoKF9fZm9yY2UgdTMyKWNwdV90b19sZTMyKGhhbmRsZSksICZtc2dbMl0pOwo+
ICAgCXdyaXRlbCgweDAsICZtc2dbM10pOwo+ICAgCXdyaXRlbCgweDAsICZtc2dbNF0pOwo+ICAg
CXdyaXRlbCgweDAsICZtc2dbNV0pOwo+ICAgCXdyaXRlbCgweDAsICZtc2dbNl0pOwo+IC0Jd3Jp
dGVsKGNwdV90b19sZTMyKDB4MDAwMDA3ODApLCAmbXNnWzddKTsKPiAtCXdyaXRlbChjcHVfdG9f
bGUzMigweDAwMDAwNDQwKSwgJm1zZ1s4XSk7Cj4gKwl3cml0ZWwoKF9fZm9yY2UgdTMyKWNwdV90
b19sZTMyKDB4MDAwMDA3ODApLCAmbXNnWzddKTsKPiArCXdyaXRlbCgoX19mb3JjZSB1MzIpY3B1
X3RvX2xlMzIoMHgwMDAwMDQ0MCksICZtc2dbOF0pOwo+ICAgCXdyaXRlbCgweDAsICZtc2dbOV0p
Owo+IC0Jd3JpdGVsKGNwdV90b19sZTMyKDB4MDFiMzcwMDApLCAmbXNnWzEwXSk7Cj4gKwl3cml0
ZWwoKF9fZm9yY2UgdTMyKWNwdV90b19sZTMyKDB4MDFiMzcwMDApLCAmbXNnWzEwXSk7Cj4gICAJ
Zm9yIChpID0gMTE7IGkgPCAxMDI0OyArK2kpCj4gICAJCXdyaXRlbCgweDAsICZtc2dbaV0pOwo+
ICAgCj4gQEAgLTgyNyw5ICs4MjksOSBAQCBpbnQgcmFkZW9uX3V2ZF9nZXRfZGVzdHJveV9tc2co
c3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIGludCByaW5nLAo+ICAgCQlyZXR1cm4gcjsKPiAg
IAo+ICAgCS8qIHN0aXRjaCB0b2dldGhlciBhbiBVVkQgZGVzdHJveSBtc2cgKi8KPiAtCXdyaXRl
bChjcHVfdG9fbGUzMigweDAwMDAwZGU0KSwgJm1zZ1swXSk7Cj4gLQl3cml0ZWwoY3B1X3RvX2xl
MzIoMHgwMDAwMDAwMiksICZtc2dbMV0pOwo+IC0Jd3JpdGVsKGNwdV90b19sZTMyKGhhbmRsZSks
ICZtc2dbMl0pOwo+ICsJd3JpdGVsKChfX2ZvcmNlIHUzMiljcHVfdG9fbGUzMigweDAwMDAwZGU0
KSwgJm1zZ1swXSk7Cj4gKwl3cml0ZWwoKF9fZm9yY2UgdTMyKWNwdV90b19sZTMyKDB4MDAwMDAw
MDIpLCAmbXNnWzFdKTsKPiArCXdyaXRlbCgoX19mb3JjZSB1MzIpY3B1X3RvX2xlMzIoaGFuZGxl
KSwgJm1zZ1syXSk7Cj4gICAJd3JpdGVsKDB4MCwgJm1zZ1szXSk7Cj4gICAJZm9yIChpID0gNDsg
aSA8IDEwMjQ7ICsraSkKPiAgIAkJd3JpdGVsKDB4MCwgJm1zZ1tpXSk7CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
