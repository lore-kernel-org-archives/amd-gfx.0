Return-Path: <SRS0=oKuu=25=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C10AC282DD
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 14:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0302053B
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2020 14:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="No8IC2Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0302053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD3389FC9;
	Wed,  8 Jan 2020 14:50:12 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E4F89FC9
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2020 14:50:11 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id q6so3644832wro.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 06:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VzPVtjVquQgiDq5NOJU1CZLM8Zgsr/fbWyu93mGTdCk=;
 b=No8IC2IzuTYcS8hv7LfvyxkQQxMi+6/3YbrGRUJ/a8ChOewarvu4mAh5eVUedBAj+V
 bBCenlxLCWRu103R/ZSGYQUa/4faeWI4nxs57BCnoskpaACJvB5OQl/r494MpAoKQuE7
 tw185J22p0BatnHk3PHc3qsV39D1WFWy02AC4/4X0E/ReNKV+pOIV770ZnFpHG+kyi8D
 0m5g/hQ/Sylj4RHCNTtWAoK10wTOGsqg6CANeN2FW7/8PFQBDdRdrVADetS8Y9Sp8LjQ
 Kb/y/FM+fPS8kOKKjQ8dtrSE67iPVHs5Pv/CGBmUb0cr9MFPqSYCSHV+CAfS4istpmif
 L1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VzPVtjVquQgiDq5NOJU1CZLM8Zgsr/fbWyu93mGTdCk=;
 b=e0wUIld6l0XZqFbM0+MiUlsRwUN4Dzmone/29n0/zU6fYolHuzBSCV0MDmxvUqoxoU
 pmeA6XUjlrsfqI2/YIcFkF0GaFTeBrz33K+2fc1eSNj7X6IgSCurDXBX74+f14XDPV9Z
 6w3GGC96zWlfFHqO889P8+fCzmN5VgEOSTFs5hdN/9tX9239yl4Prjd17miQBtOnct39
 6sOaaniEKVGV3WQjMzPG3IhFmvWKd31V/3AfBsivpVuZiXvAycOkg+Yc9FY+3RW0zVjk
 T0Mbb+kcnI2/DRndt/m4wlziNgqaTwK5r8qNB4MAiPym8tkso+9mR4r/iL+2ubf6iAm2
 RDug==
X-Gm-Message-State: APjAAAVVMHtw1Jewx87yA9V31z9TSseJvyRNFBWtSVkDfWS7WGjYSre4
 P4Y/QxnRReGDILJ2D2BpkjTgwWAVgJF6SuN+ktgUUWfh
X-Google-Smtp-Source: APXvYqxfq4uFBThfFw0fQzZH2tMUQqIhxbQlqfy3QqeQyK0h4Ta5Y9JfH9X2DxQs5yCKOcdZdGjmlh7YA0WUNNYqMew=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr5149185wrn.50.1578495009816; 
 Wed, 08 Jan 2020 06:50:09 -0800 (PST)
MIME-Version: 1.0
References: <20200108123648.7422-1-tianci.yin@amd.com>
 <ba1754a0-7230-5df7-cfb3-7b0d7c892c47@amd.com>
In-Reply-To: <ba1754a0-7230-5df7-cfb3-7b0d7c892c47@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jan 2020 09:49:57 -0500
Message-ID: <CADnq5_MQ1S60QX3=U2=LYSoiYg965yViTk0Y0WbaFTRXhvNZww@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure of the 2nd GPU when
 GDDR6 training enabled
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Long Gang <Gang.Long@amd.com>, Kevin Wang <Kevin1.Wang@amd.com>,
 Feifei Xu <Feifei.Xu@amd.com>, Tianci Yin <tianci.yin@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gV2VkLCBKYW4gOCwgMjAyMCBhdCA3OjUyIEFNIENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlh
bi5rb2VuaWdAYW1kLmNvbT4gd3JvdGU6Cj4KPiBBbSAwOC4wMS4yMCB1bSAxMzozNiBzY2hyaWVi
IFRpYW5jaSBZaW46Cj4gPiBGcm9tOiAiVGlhbmNpLllpbiIgPHRpYW5jaS55aW5AYW1kLmNvbT4K
PiA+Cj4gPiBbd2h5XQo+ID4gSW4gZHVhbCBHUFVzIHNjZW5hcmlvLCBzdG9sZW5fc2l6ZSBpcyBh
c3NpZ25lZCB0byB6ZXJvIG9uIHRoZSAybmQgR1BVLAo+ID4gdGhlbiB0aGUgYm90dG9tIHJlZ2lv
biBvZiBWUkFNIHdhcyBhbGxvY2F0ZWQgYXMgR1RULCB1bmZvcnR1bmF0ZWx5Cj4gPiBhIHNtYWxs
IHJlZ2lvbiBvZiBib3R0b20gVlJBTSB3YXMgZW5jcm9hY2hlZCBieSBVTUMgZmlybXdhcmUgZHVy
aW5nCj4gPiBHRERSNiBCSVNUIHRyYWluaW5nLCB0aGlzIGNhdXNlIHBhZ2VmYXVsdC4KPgo+IFdo
YXQgSSdtIG1pc3NpbmcgaGVyZSBpcyB3aHkgaXMgdGhlIHN0b2xlbiBzaXplIHplcm8gb24gdGhl
IDJuZCBHUFU/Cj4KPiBNYXliZSB3ZSBuZWVkIHRvIHJlYWQgdGhlIHN0b2xlbiBzaXplIGFmdGVy
IHBvc3RpbmcgdGhlIEdQVSBpbnN0ZWFkPwoKVGhlcmUgaXMgbm8gc3RvbGVuIG1lbW9yeSBvbiBz
ZWNvbmRhcnkgR1BVcyBiZWNhdXNlIHRoZXJlIGlzIG5vIHByZS1PUwpjb25zb2xlIHVzaW5nIHRo
YXQgbWVtb3J5LgoKQWxleAoKPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4gPgo+ID4gW2hv
d10KPiA+IEZvcmNpbmcgc3RvbGVuX3NpemUgdG8gM01CLCB0aGVuIHRoZSBib3R0b20gcmVnaW9u
IG9mIFZSQU0gd2FzCj4gPiBhbGxvY2F0ZWQgYXMgc3RvbGVuIG1lbW9yeSwgR1RUIGNvcnJ1cHRp
b24gYXZvaWQuCj4gPiBUaGUgc3RvbGVuIG1lbW9yeSBvZiB0aGUgMm5kIEdQVSB3aWxsIGJlIGZy
ZWUgaW4gbGF0ZV9pbml0IHBoYXNlLAo+ID4gbm8gbWVtb3J5IHdhc3RlZC4KPiA+Cj4gPiBDaGFu
Z2UtSWQ6IEljZDBhZDdkZTQxMzMzMjgyOTQ5YmIxZTNlNjc2YzZjMzA3ZGRkMDgxCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBUaWFuY2kuWWluIDx0aWFuY2kueWluQGFtZC5jb20+Cj4gPiAtLS0KPiA+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oIHwgIDYgKysrKysrCj4gPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192MTBfMC5jICB8IDIxICsrKysrKysrKysr
KysrKysrKysrKwo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykKPiA+Cj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5oCj4gPiBpbmRleCBjOTFkZDYw
MmQ1ZjEuLjQ0MGI3OTMzMTZkZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuaAo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2dtYy5oCj4gPiBAQCAtNjAsNiArNjAsMTEgQEAKPiA+ICAgICovCj4gPiAgICNkZWZp
bmUgQU1ER1BVX0dNQ19GQVVMVF9USU1FT1VUICAgIDUwMDBVTEwKPiA+Cj4gPiArLyoKPiA+ICsg
KiBEZWZhdWx0IHN0b2xlbiBtZW1vcnkgc2l6ZSwgMTAyNCAqIDc2OCAqIDQKPiA+ICsgKi8KPiA+
ICsjZGVmaW5lIEFNREdQVV9TVE9MRU5fVkdBX0RFRkFVTFRfU0laRSAgICAgICAweDMwMDAwMAo+
ID4gKwo+ID4gICBzdHJ1Y3QgZmlybXdhcmU7Cj4gPgo+ID4gICAvKgo+ID4gQEAgLTE5Miw2ICsx
OTcsNyBAQCBzdHJ1Y3QgYW1kZ3B1X2dtYyB7Cj4gPiAgICAgICB1aW50MzJfdCAgICAgICAgICAg
ICAgICBzcmJtX3NvZnRfcmVzZXQ7Cj4gPiAgICAgICBib29sICAgICAgICAgICAgICAgICAgICBw
cnRfd2FybmluZzsKPiA+ICAgICAgIHVpbnQ2NF90ICAgICAgICAgICAgICAgIHN0b2xlbl9zaXpl
Owo+ID4gKyAgICAgYm9vbCAgICAgICAgICAgICAgICAgICAgc3RvbGVuX3RlbXBfcmVzZXJ2ZWQ7
Cj4gPiAgICAgICAvKiBhcGVydHVyZXMgKi8KPiA+ICAgICAgIHU2NCAgICAgICAgICAgICAgICAg
ICAgIHNoYXJlZF9hcGVydHVyZV9zdGFydDsKPiA+ICAgICAgIHU2NCAgICAgICAgICAgICAgICAg
ICAgIHNoYXJlZF9hcGVydHVyZV9lbmQ7Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ21jX3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNf
djEwXzAuYwo+ID4gaW5kZXggN2RjOGMwNjhjNjJhLi4wYzk2YjY3ZDZjYTcgMTAwNjQ0Cj4gPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3YxMF8wLmMKPiA+IEBAIC01NjYsNiArNTY2LDEx
IEBAIHN0YXRpYyBpbnQgZ21jX3YxMF8wX2xhdGVfaW5pdCh2b2lkICpoYW5kbGUpCj4gPiAgICAg
ICBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhh
bmRsZTsKPiA+ICAgICAgIGludCByOwo+ID4KPiA+ICsgICAgIGlmIChhZGV2LT5nbWMuc3RvbGVu
X3RlbXBfcmVzZXJ2ZWQpIHsKPiA+ICsgICAgICAgICAgICAgYW1kZ3B1X2JvX2xhdGVfaW5pdChh
ZGV2KTsKPiA+ICsgICAgICAgICAgICAgYWRldi0+Z21jLnN0b2xlbl90ZW1wX3Jlc2VydmVkID0g
ZmFsc2U7Cj4gPiArICAgICB9Cj4gPiArCj4gPiAgICAgICByID0gYW1kZ3B1X2dtY19hbGxvY2F0
ZV92bV9pbnZfZW5nKGFkZXYpOwo+ID4gICAgICAgaWYgKHIpCj4gPiAgICAgICAgICAgICAgIHJl
dHVybiByOwo+ID4gQEAgLTc1Niw2ICs3NjEsMjIgQEAgc3RhdGljIGludCBnbWNfdjEwXzBfc3df
aW5pdCh2b2lkICpoYW5kbGUpCj4gPiAgICAgICAgICAgICAgIHJldHVybiByOwo+ID4KPiA+ICAg
ICAgIGFkZXYtPmdtYy5zdG9sZW5fc2l6ZSA9IGdtY192MTBfMF9nZXRfdmJpb3NfZmJfc2l6ZShh
ZGV2KTsKPiA+ICsgICAgIC8qCj4gPiArICAgICAgKiBJbiBkdWFsIEdQVXMgc2NlbmFyaW8sIHN0
b2xlbl9zaXplIGlzIGFzc2lnbmVkIHRvIHplcm8gb24gdGhlIDJuZCBHUFUsCj4gPiArICAgICAg
KiB0aGVuIHRoZSBib3R0b20gcmVnaW9uIG9mIFZSQU0gd2FzIGFsbG9jYXRlZCBhcyBHVFQsIHVu
Zm9ydHVuYXRlbHkKPiA+ICsgICAgICAqIGEgc21hbGwgcmVnaW9uIG9mIGJvdHRvbSBWUkFNIHdh
cyBlbmNyb2FjaGVkIGJ5IFVNQyBmaXJtd2FyZSBkdXJpbmcKPiA+ICsgICAgICAqIEdERFI2IEJJ
U1QgdHJhaW5pbmcsIHRoaXMgY2F1c2UgcGFnZWZhdWx0Lgo+ID4gKyAgICAgICogVGhlIHBhZ2Ug
ZmF1bHQgY2FuIGJlIGZpeGVkIGJ5IGZvcmNpbmcgc3RvbGVuX3NpemUgdG8gM01CLCB0aGVuIHRo
ZSBib3R0b20KPiA+ICsgICAgICAqIHJlZ2lvbiBvZiBWUkFNIHdhcyBhbGxvY2F0ZWQgYXMgc3Rv
bGVuIG1lbW9yeSwgR1RUIGNvcnJ1cHRpb24gYXZvaWQuCj4gPiArICAgICAgKiBUaGUgc3RvbGVu
IG1lbW9yeSBvZiB0aGUgMm5kIEdQVSB3aWxsIGJlIGZyZWUgaW4gbGF0ZV9pbml0IHBoYXNlLAo+
ID4gKyAgICAgICogbm8gbWVtb3J5IHdhc3RlZC4KPiA+ICsgICAgICAqLwo+ID4gKyAgICAgaWYg
KGFkZXYtPmZ3X3ZyYW1fdXNhZ2UubWVtX3RyYWluX3N1cHBvcnQgJiYKPiA+ICsgICAgICAgICAg
ICAgYWRldi0+Z21jLnN0b2xlbl9zaXplID09IDApIHsKPiA+ICsgICAgICAgICAgICAgYWRldi0+
Z21jLnN0b2xlbl9zaXplID0gQU1ER1BVX1NUT0xFTl9WR0FfREVGQVVMVF9TSVpFOwo+ID4gKyAg
ICAgICAgICAgICBhZGV2LT5nbWMuc3RvbGVuX3RlbXBfcmVzZXJ2ZWQgPSB0cnVlOwo+ID4gKyAg
ICAgfSBlbHNlCj4gPiArICAgICAgICAgICAgIGFkZXYtPmdtYy5zdG9sZW5fdGVtcF9yZXNlcnZl
ZCA9IGZhbHNlOwo+ID4KPiA+ICAgICAgIC8qIE1lbW9yeSBtYW5hZ2VyICovCj4gPiAgICAgICBy
ID0gYW1kZ3B1X2JvX2luaXQoYWRldik7Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
