Return-Path: <SRS0=S/Du=4V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18635C3F2D1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BD320732
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2020 15:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD+c0vfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BD320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E50D6EB32;
	Wed,  4 Mar 2020 15:21:08 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E8B6EB32
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2020 15:21:07 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id y17so2873732wrn.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2020 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=vQZffr10ZXm4kAtUp7HxXIH4sPyC4GH8+A4D4w9SBI0=;
 b=gD+c0vflx4sHKbhluFJOUsQgJBjtodn/O1dV9L0CXkwuW6HE3A/89xJSYWSH9T/q30
 OfSiuGvsqQqq5xNqZxI0DudwcIh8owkmXQiqNFVr13KVA7XMChS3piqCDM9jMXpi9vOI
 U4OwtVblw26i7AnrL3GClla9L2zbj1Lh/qWJ3UROEV6Wkwz6iMysqk5iV3ou+RIApFSQ
 /aWy2goFXrvTOYVSqNOHpF1JpK0SsKVEak53oDw9lXq6UFa/obz0BoIBHi0jmNIIq3N1
 XGT6aSz5ZJt8S7sGZ1McoH1VVP2Q/SF3biWTqn49f3ox3tQfLDif9N+K2wZFMUss5vwc
 1kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=vQZffr10ZXm4kAtUp7HxXIH4sPyC4GH8+A4D4w9SBI0=;
 b=BqNPiIx2VgERW5VqzQD0NKldM2JDteFC20GJqVFHfmi8Kr5U+ZRC2J9pps8wfhsOO8
 zoS+jN+bf4Yzm1mA9TYiMubhDK/gVWqtsgH9jYU5BicQgWABvY+Wc8AVHe8MqojJpCid
 Fl0zn2XTp4fJOnItNrkq+IF5HywBNVPq8IpmGQ+ndDAXKFzDcaBxkE5MpIGR89+TYXyJ
 fcN+WaXL47Yxhu6acQlJKS35aYnp4idWnRuqTUuRq93LMVXLZhkKYOi6ofKe4VgNiSPs
 rP9kyLcXXB3CAtl9EcpU63Y+jvNaV0AV3QK2v0vNOi8Odttpv29sD7PIqrXhGJUYuFE9
 27Yg==
X-Gm-Message-State: ANhLgQ3AfGnTItVZVh1TyeAEl32o7ogg4x6GUyU5iD4tdVr2li4gOgsS
 jG650HWWAuWmBdYqARtTGNP0lQnR
X-Google-Smtp-Source: ADFU+vvXbK23lC5qZJpjgCY9V0FqC132FqjU29lQy6zXeWFPv8x+OqxTUQkXFwNZOtGrQirLqjj3nQ==
X-Received: by 2002:adf:c448:: with SMTP id a8mr4533481wrg.295.1583335266617; 
 Wed, 04 Mar 2020 07:21:06 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id o8sm4433643wmh.15.2020.03.04.07.21.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Mar 2020 07:21:06 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Fine-grained TMZ support
To: Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200304151727.221032-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3cd1c28e-4e75-645b-bc3c-a50a9babd21e@gmail.com>
Date: Wed, 4 Mar 2020 16:21:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200304151727.221032-1-luben.tuikov@amd.com>
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

QW0gMDQuMDMuMjAgdW0gMTY6MTcgc2NocmllYiBMdWJlbiBUdWlrb3Y6Cj4gQWRkIGZpbmUtZ3Jh
aW5lZCBwZXItQVNJQyBUTVogc3VwcG9ydC4KPgo+IEF0IHRoZSBtb21lbnQgVE1aIHN1cHBvcnQg
aXMgZXhwZXJpbWVudGFsIGZvciBhbGwKPiBBU0lDcyB3aGljaCBzdXBwb3J0IGl0Lgo+Cj4gU2ln
bmVkLW9mZi1ieTogTHViZW4gVHVpa292IDxsdWJlbi50dWlrb3ZAYW1kLmNvbT4KPiBSZXZpZXdl
ZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgoKSSd2ZSBwdXNo
ZWQgdGhlIGZpeGVzIGZvciBUTVogYnVmZmVyIG1vdmVzIHRoaXMgbW9ybmluZywgc28gSSB0aGlu
ayB3ZSAKc2hvdWxkIGJlIGNsZWFyIHRvIGV2ZW4gZW5hYmxlIGl0IGJ5IGRlZmF1bHQgZm9yIGF0
IGxlYXN0IFJhdmVuLgoKQnV0IGVpdGhlciB3YXkgdGhpcyBwYXRjaCBpczogUmV2aWV3ZWQtYnk6
IENocmlzdGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jIHwgMzAgKysrKysrKysrKysr
KysrKy0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9nbWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+IGlu
ZGV4IDYxYTc0MzM2ODMwMi4uNGY4ZmQwNjdkMTUwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nbWMuYwo+IEBAIC0zODMsMTggKzM4MywyOCBAQCBpbnQgYW1kZ3B1X2dt
Y19hbGxvY2F0ZV92bV9pbnZfZW5nKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAgICov
Cj4gICB2b2lkIGFtZGdwdV9nbWNfdG16X3NldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
PiAgIHsKPiAtCWlmICghYW1kZ3B1X3RteikKPiAtCQlyZXR1cm47Cj4gLQo+IC0JaWYgKGFkZXYt
PmFzaWNfdHlwZSA8IENISVBfUkFWRU4gfHwKPiAtCSAgICBhZGV2LT5hc2ljX3R5cGUgPT0gQ0hJ
UF9BUkNUVVJVUykgewo+ICsJc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPiArCWNhc2UgQ0hJ
UF9SQVZFTjoKPiArCWNhc2UgQ0hJUF9SRU5PSVI6Cj4gKwljYXNlIENISVBfTkFWSTEwOgo+ICsJ
Y2FzZSBDSElQX05BVkkxNDoKPiArCWNhc2UgQ0hJUF9OQVZJMTI6Cj4gKwkJLyogRG9uJ3QgZW5h
YmxlIGl0IGJ5IGRlZmF1bHQgeWV0Lgo+ICsJCSAqLwo+ICsJCWlmIChhbWRncHVfdG16IDwgMSkg
ewo+ICsJCQlhZGV2LT5nbWMudG16X2VuYWJsZWQgPSBmYWxzZTsKPiArCQkJZGV2X2luZm8oYWRl
di0+ZGV2LAo+ICsJCQkJICJUcnVzdGVkIE1lbW9yeSBab25lIChUTVopIGZlYXR1cmUgZGlzYWJs
ZWQgYXMgZXhwZXJpbWVudGFsIChkZWZhdWx0KVxuIik7Cj4gKwkJfSBlbHNlIHsKPiArCQkJYWRl
di0+Z21jLnRtel9lbmFibGVkID0gdHJ1ZTsKPiArCQkJZGV2X2luZm8oYWRldi0+ZGV2LAo+ICsJ
CQkJICJUcnVzdGVkIE1lbW9yeSBab25lIChUTVopIGZlYXR1cmUgZW5hYmxlZCBhcyBleHBlcmlt
ZW50YWwgKGNtZCBsaW5lKVxuIik7Cj4gKwkJfQo+ICsJCWJyZWFrOwo+ICsJZGVmYXVsdDoKPiAg
IAkJYWRldi0+Z21jLnRtel9lbmFibGVkID0gZmFsc2U7Cj4gICAJCWRldl93YXJuKGFkZXYtPmRl
diwKPiAgIAkJCSAiVHJ1c3RlZCBNZW1vcnkgWm9uZSAoVE1aKSBmZWF0dXJlIG5vdCBzdXBwb3J0
ZWRcbiIpOwo+IC0JfSBlbHNlIHsKPiAtCj4gLQkJYWRldi0+Z21jLnRtel9lbmFibGVkID0gdHJ1
ZTsKPiAtCQlkZXZfaW5mbyhhZGV2LT5kZXYsCj4gLQkJCSAiVHJ1c3RlZCBNZW1vcnkgWm9uZSAo
VE1aKSBmZWF0dXJlIHN1cHBvcnRlZCBhbmQgZW5hYmxlZFxuIik7Cj4gKwkJYnJlYWs7Cj4gICAJ
fQo+ICAgfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
