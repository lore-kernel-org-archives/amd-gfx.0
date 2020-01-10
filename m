Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B2C33CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 11:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E882072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 11:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcgCECLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E882072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A236E9CD;
	Fri, 10 Jan 2020 11:29:53 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F18C06E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 11:29:51 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id d16so1444499wre.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 03:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=GkykaostqZnp6INpGWMUTYjURcyoJpOoGMKisbRhJBw=;
 b=dcgCECLG2y8E2LYekJs7F5w0kytZfFliGF7p1sXNtjvBidiMerdHxIbfXJ5+dqQNib
 Qqk/lRXZIhwdMHH3mRUmNTjO02b5HXjMydFBSaAnfkGm4/37m2mZ5CH8gQKumgkcYITO
 jWN+BVzTeUMK9D424uWePmqPhzgQ6D7ZMJQ9itLk6CpiRGQdgadYzdgStntKeo6tRPnz
 YzNWlWZg0ryTUYrG8ah8WWQ+qU5FnbuU7vpA/Kf1I4UGt2FEYZnbr421nfD2u5+Ci0u5
 +KtdpntOFTbNDR5xPvwTbW/38SFaOqh1pOyndgSUXXzaldyd/sW5Y/E50itE7FWl/UQF
 NWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=GkykaostqZnp6INpGWMUTYjURcyoJpOoGMKisbRhJBw=;
 b=LSkMBg6wUeVSMQ4+D3eJRG+sxsVl4kVdE+kz7B7AoQzIqe73/hHJs2z+zzRKdrgImR
 LmiuT8h6Xm1AW7IROAbmiuiBZVICBVbyzMZpCQIjfqh8cXRzc0xcVe4vwGMKFqTJhgh3
 yXIyTLvBnle4YgvUhZOG4q5s1ue+IdcIO0MCzKfpocdOqhyaIt8bhd7KqOrAAVMcuPdS
 d3G9jZmmzn9fDGVGA7/92QLB4FJaIFlgOR8ox3pyYhE0wa4ZW7bXZq1aOsgZ7eR8x8JK
 Bxt5CDAZwa2Lk6JTxiA6NTW8CI5GjcMSEPq/I6gs5O0wr+DCCz7jidFoSsRe1Ua6K28t
 mz7Q==
X-Gm-Message-State: APjAAAV2p9I+oFrdJgLvIkY0suQ/2ezb1kb1Nxv4Czmr6rg81InRaNCx
 XIe6Vz22bnWP5/2R4a+MtQw=
X-Google-Smtp-Source: APXvYqy+maLkwVtZg/0ldJRBO5PoM1YM5hiSxbiua17lgVwpQfvE5qH4mAAPKX72F4KcY9U0JKXOMw==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr2984100wrj.349.1578655790643; 
 Fri, 10 Jan 2020 03:29:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i16sm1965119wmb.36.2020.01.10.03.29.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Jan 2020 03:29:50 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure of the secondary GPU
 when GDDR6 training enabled(V4)
To: Tianci Yin <tianci.yin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200110053010.29132-1-tianci.yin@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f6e5bdb4-5cc7-7411-4139-77d26ac72b34@gmail.com>
Date: Fri, 10 Jan 2020 12:29:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200110053010.29132-1-tianci.yin@amd.com>
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
Cc: Long Gang <Gang.Long@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTAuMDEuMjAgdW0gMDY6MzAgc2NocmllYiBUaWFuY2kgWWluOgo+IEZyb206ICJUaWFuY2ku
WWluIiA8dGlhbmNpLnlpbkBhbWQuY29tPgo+Cj4gW3doeV0KPiBJbiBkdWFsIEdQVXMgc2NlbmFy
aW8sIHN0b2xlbl9zaXplIGlzIGFzc2lnbmVkIHRvIHplcm8gb24gdGhlIHNlY29uZGFyeSBHUFUs
Cj4gc2luY2UgdGhlcmUgaXMgbm8gcHJlLU9TIGNvbnNvbGUgdXNpbmcgdGhhdCBtZW1vcnkuIFRo
ZW4gdGhlIGJvdHRvbSByZWdpb24gb2YKPiBWUkFNIHdhcyBhbGxvY2F0ZWQgYXMgR1RULCB1bmZv
cnR1bmF0ZWx5IGEgc21hbGwgcmVnaW9uIG9mIGJvdHRvbSBWUkFNIHdhcwo+IGVuY3JvYWNoZWQg
YnkgVU1DIGZpcm13YXJlIGR1cmluZyBHRERSNiBCSVNUIHRyYWluaW5nLCB0aGlzIGNhdXNlIHBh
Z2UgZmF1bHQuCj4KPiBbaG93XQo+IEZvcmNpbmcgc3RvbGVuX3NpemUgdG8gM01CLCB0aGVuIHRo
ZSBib3R0b20gcmVnaW9uIG9mIFZSQU0gd2FzCj4gYWxsb2NhdGVkIGFzIHN0b2xlbiBtZW1vcnks
IEdUVCBjb3JydXB0aW9uIGF2b2lkLgo+Cj4gQ2hhbmdlLUlkOiBJMzEwYTcyYmEwNDAyOTk0ZGVm
YmU1MDgzOTg0MmE4ZWRiMDI1YTg2OAo+IFNpZ25lZC1vZmYtYnk6IFRpYW5jaS5ZaW4gPHRpYW5j
aS55aW5AYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dtYy5oIHwgIDUgKysrKysKPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192
MTBfMC5jICB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKy0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMzEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuaAo+IGluZGV4IGM5MWRkNjAyZDVmMS4uZTRiMmY5YmNhZWI3IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAo+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuaAo+IEBAIC02MCw2ICs2
MCwxMSBAQAo+ICAgICovCj4gICAjZGVmaW5lIEFNREdQVV9HTUNfRkFVTFRfVElNRU9VVAk1MDAw
VUxMCj4gICAKPiArLyoKPiArICogRGVmYXVsdCBzdG9sZW4gbWVtb3J5IHNpemUsIDEwMjQgKiA3
NjggKiA0Cj4gKyAqLwo+ICsjZGVmaW5lIEFNREdQVV9TVE9MRU5fVkdBX0RFRkFVTFRfU0laRQkw
eDMwMDAwMFVMTAo+ICsKPiAgIHN0cnVjdCBmaXJtd2FyZTsKPiAgIAo+ICAgLyoKPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+IGluZGV4IDVhZDg5YmI2ZjNiYS4uMTQ5NjFm
MWViZmFiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBf
MC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPiBAQCAt
NTY2LDcgKzU2NiwxMiBAQCBzdGF0aWMgaW50IGdtY192MTBfMF9sYXRlX2luaXQodm9pZCAqaGFu
ZGxlKQo+ICAgCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2
aWNlICopaGFuZGxlOwo+ICAgCWludCByOwo+ICAgCj4gLQlhbWRncHVfYm9fbGF0ZV9pbml0KGFk
ZXYpOwo+ICsJLyoKPiArCSAqIENhbid0IGZyZWUgdGhlIHN0b2xlbiBWR0EgbWVtb3J5IHdoZW4g
aXQgbWlnaHQgYmUgdXNlZCBmb3IgbWVtb3J5Cj4gKwkgKiB0cmFpbmluZyBhZ2Fpbi4KPiArCSAq
Lwo+ICsJaWYgKCFhZGV2LT5md192cmFtX3VzYWdlLm1lbV90cmFpbl9zdXBwb3J0KQo+ICsJCWFt
ZGdwdV9ib19sYXRlX2luaXQoYWRldik7Cj4gICAKPiAgIAlyID0gYW1kZ3B1X2dtY19hbGxvY2F0
ZV92bV9pbnZfZW5nKGFkZXYpOwo+ICAgCWlmIChyKQo+IEBAIC03NTAsNiArNzU1LDE5IEBAIHN0
YXRpYyBpbnQgZ21jX3YxMF8wX3N3X2luaXQodm9pZCAqaGFuZGxlKQo+ICAgCj4gICAJYWRldi0+
Z21jLnN0b2xlbl9zaXplID0gZ21jX3YxMF8wX2dldF92Ymlvc19mYl9zaXplKGFkZXYpOwo+ICAg
Cj4gKwkvKgo+ICsJICogSW4gZHVhbCBHUFVzIHNjZW5hcmlvLCBzdG9sZW5fc2l6ZSBpcyBhc3Np
Z25lZCB0byB6ZXJvIG9uIHRoZQo+ICsJICogc2Vjb25kYXJ5IEdQVSwgc2luY2UgdGhlcmUgaXMg
bm8gcHJlLU9TIGNvbnNvbGUgdXNpbmcgdGhhdCBtZW1vcnkuCj4gKwkgKiBUaGVuIHRoZSBib3R0
b20gcmVnaW9uIG9mIFZSQU0gd2FzIGFsbG9jYXRlZCBhcyBHVFQsIHVuZm9ydHVuYXRlbHkgYQo+
ICsJICogc21hbGwgcmVnaW9uIG9mIGJvdHRvbSBWUkFNIHdhcyBlbmNyb2FjaGVkIGJ5IFVNQyBm
aXJtd2FyZSBkdXJpbmcKPiArCSAqIEdERFI2IEJJU1QgdHJhaW5pbmcsIHRoaXMgY2F1c2UgcGFn
ZSBmYXVsdC4KPiArCSAqIFRoZSBwYWdlIGZhdWx0IGNhbiBiZSBmaXhlZCBieSBmb3JjaW5nIHN0
b2xlbl9zaXplIHRvIDNNQiwgdGhlbiB0aGUKPiArCSAqIGJvdHRvbSByZWdpb24gb2YgVlJBTSB3
YXMgYWxsb2NhdGVkIGFzIHN0b2xlbiBtZW1vcnksIEdUVCBjb3JydXB0aW9uCj4gKwkgKiBhdm9p
ZC4KPiArCSAqLwo+ICsJYWRldi0+Z21jLnN0b2xlbl9zaXplID0gbWF4KGFkZXYtPmdtYy5zdG9s
ZW5fc2l6ZSwKPiArCQkJCSAgICBBTURHUFVfU1RPTEVOX1ZHQV9ERUZBVUxUX1NJWkUpOwo+ICsK
PiAgIAkvKiBNZW1vcnkgbWFuYWdlciAqLwo+ICAgCXIgPSBhbWRncHVfYm9faW5pdChhZGV2KTsK
PiAgIAlpZiAocikKPiBAQCAtNzg5LDYgKzgwNywxMyBAQCBzdGF0aWMgdm9pZCBnbWNfdjEwXzBf
Z2FydF9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgc3RhdGljIGludCBnbWNf
djEwXzBfc3dfZmluaSh2b2lkICpoYW5kbGUpCj4gICB7Cj4gICAJc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYgPSAoc3RydWN0IGFtZGdwdV9kZXZpY2UgKiloYW5kbGU7Cj4gKwl2b2lkICpzdG9s
ZW5fdmdhX2J1ZjsKPiArCj4gKwkvKgo+ICsJICogRnJlZSB0aGUgc3RvbGVuIG1lbW9yeSBpZiBp
dCB3YXNuJ3QgYWxyZWFkeSBmcmVlZCBpbiBsYXRlX2luaXQKPiArCSAqIGJlY2F1c2Ugb2YgbWVt
b3J5IHRyYWluaW5nLgo+ICsJICovCj4gKwlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPnN0
b2xlbl92Z2FfbWVtb3J5LCBOVUxMLCAmc3RvbGVuX3ZnYV9idWYpOwo+ICAgCj4gICAJYW1kZ3B1
X3ZtX21hbmFnZXJfZmluaShhZGV2KTsKPiAgIAlnbWNfdjEwXzBfZ2FydF9maW5pKGFkZXYpOwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
