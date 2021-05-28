Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4160BC2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 19:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFDBA611CA
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 19:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFDBA611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DBFA6E0CC;
	Fri, 28 May 2021 19:13:13 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1E66E0CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 19:13:13 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id l3so6913018ejc.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 12:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=smaVOqux2LTDQCRF7Bkr9WicwrFt4eI/Np/OK5/m+Sg=;
 b=tiMtgMea3rqnIIZwGeM53JJpbTZdNmNj6PjTQf6h0p0zLpZpI1NTOy6SHA0aI6SoaH
 nlSm8a7x555UA8+CSEKp2nuIWNW1L4aZFSuO3l0m/+WWCmHok/aJRIcc/oCEC8wkqytD
 5bTnUHnnuK3tFRU6dl2UIPPRkVvztxZceePTgCBvj7Wd682dRbT4JLLbqaVfqeE/30FU
 1OG+DJim8xo28kCsaMLYuxlMS/GtXEVInWCiM/f3CqjvsUKAbd+l0bluAWsST+G8li50
 A6innIGdKZf9P4FRr/SHfQfI1eX7l88ZP4FBjyOJJXHVk6/Pv8p1Ad4Rz9g5XNPNrO6a
 YF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=smaVOqux2LTDQCRF7Bkr9WicwrFt4eI/Np/OK5/m+Sg=;
 b=gcaf3rYL02IB0SEzKBkKVp9B4q8D4ZMsFrZLrhELMONZjtO/3fE7MtR/S3HqqG9tfP
 fQzm2rblUsNGJ/4CWjEOuFqErr/JSnQFeGGODirCYmjk72k3pLhtJGhz35lRbD2MxM3Y
 zUFHaSRv7iCHJLZI6ka1ycsNaNNegLZSdp8G06UuEdLRp2FuYwWJiVAJu9GBMcaqniFy
 QB1dyr1ms6AoYqX6moTDMd6z6c2tLO/UzK2NfNLlj0SmwCx9+HV63HgJGtmCuOVdvXiU
 bm471N0TOvjrhmVn9yzxi2DTI1wcwpH4i7o6/8snqlxnz4wn/++JUpdTKqS2RHZUua5m
 dvog==
X-Gm-Message-State: AOAM531pQPZo+5BH0bTEor/au+ONY4Ja63qhpSmRxizk74+HAtffS3cx
 P/VYUWQoodc1g8QrixX3HQoGdewX5q0=
X-Google-Smtp-Source: ABdhPJw+d4bYnlBtXs6rJ+8nEZ6Hhub4QrsqcOeRbgIn5A3LLAA5oCsXMKbsPxZCW09Mg+rY+m2qnw==
X-Received: by 2002:a17:906:6dc3:: with SMTP id
 j3mr10824847ejt.448.1622229191900; 
 Fri, 28 May 2021 12:13:11 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:fdb1:7ac0:d8f4:63ec?
 ([2a02:908:1252:fb60:fdb1:7ac0:d8f4:63ec])
 by smtp.gmail.com with ESMTPSA id q4sm3077207edv.24.2021.05.28.12.13.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 May 2021 12:13:11 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] drm/amdgpu: flush gart changes after all BO
 recovery
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210528165105.96761-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a43efd59-25eb-51d9-ebcb-c63e0759b7d0@gmail.com>
Date: Fri, 28 May 2021 21:13:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210528165105.96761-1-nirmoy.das@amd.com>
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
Cc: Christian.Koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMjguMDUuMjEgdW0gMTg6NTEgc2NocmllYiBOaXJtb3kgRGFzOgo+IERvbid0IGZsdXNoIGdh
cnQgY2hhbmdlcyBhZnRlciByZWNvdmVyaW5nIGVhY2ggQk8gaW5zdGVhZAo+IGRvIGl0IGFmdGVy
IHJlY292ZXJpbmcgYWxsIHRoZSBCT3MuIEZsaXNoaW5nIGdhcnQgYWxzbyBuZWVkZWQKPiBmb3Ig
YW1kZ3B1X3R0bV9hbGxvY19nYXJ0KCkuCj4KPiB2NDogdXNlIGNvbnRhaW5lcl9vZiB0byByZXRy
aWV2ZSBhZGV2IHN0cnVjdC4KPiB2MzogcmVuYW1lIGFtZGdwdV9nYXJ0X3RsYl9mbHVzaCgpIC0+
IGFtZGdwdV9nYXJ0X2ludmFsaWRhdGVfdGxiKCkuCj4gdjI6IGFic3RyYWN0IG91dCBnYXJ0IHRs
YiBmbHVzaGluZyBsb2dpYyB0byBhbWRncHVfZ2FydC5jCj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJt
b3kgRGFzIDxuaXJtb3kuZGFzQGFtZC5jb20+CgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKPiAtLS0KPiAgIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMgICAgfCAyMiArKysrKysrKysrKysrKy0tLS0tLS0KPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmggICAgfCAgMiArLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYyB8ICA0ICsrKysKPiAg
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyAgICAgfCAgMSArCj4gICA0
IGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dhcnQuYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmMKPiBpbmRleCA1NTYyYjVjOTBjMDMu
LjM1Y2M4MDA5YWM3YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZ2FydC5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dh
cnQuYwo+IEBAIC0zMTIsOCArMzEyLDYgQEAgaW50IGFtZGdwdV9nYXJ0X2JpbmQoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQ2NF90IG9mZnNldCwKPiAgIAkJICAgICBpbnQgcGFnZXMs
IHN0cnVjdCBwYWdlICoqcGFnZWxpc3QsIGRtYV9hZGRyX3QgKmRtYV9hZGRyLAo+ICAgCQkgICAg
IHVpbnQ2NF90IGZsYWdzKQo+ICAgewo+IC0JaW50IHIsIGk7Cj4gLQo+ICAgCWlmICghYWRldi0+
Z2FydC5yZWFkeSkgewo+ICAgCQlXQVJOKDEsICJ0cnlpbmcgdG8gYmluZCBtZW1vcnkgdG8gdW5p
bml0aWFsaXplZCBHQVJUICFcbiIpOwo+ICAgCQlyZXR1cm4gLUVJTlZBTDsKPiBAQCAtMzIyLDE2
ICszMjAsMjYgQEAgaW50IGFtZGdwdV9nYXJ0X2JpbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsIHVpbnQ2NF90IG9mZnNldCwKPiAgIAlpZiAoIWFkZXYtPmdhcnQucHRyKQo+ICAgCQlyZXR1
cm4gMDsKPgo+IC0JciA9IGFtZGdwdV9nYXJ0X21hcChhZGV2LCBvZmZzZXQsIHBhZ2VzLCBkbWFf
YWRkciwgZmxhZ3MsCj4gLQkJICAgIGFkZXYtPmdhcnQucHRyKTsKPiAtCWlmIChyKQo+IC0JCXJl
dHVybiByOwo+ICsJcmV0dXJuIGFtZGdwdV9nYXJ0X21hcChhZGV2LCBvZmZzZXQsIHBhZ2VzLCBk
bWFfYWRkciwgZmxhZ3MsCj4gKwkJCSAgICAgICBhZGV2LT5nYXJ0LnB0cik7Cj4gK30KPiArCj4g
Ky8qKgo+ICsgKiBhbWRncHVfZ2FydF9pbnZhbGlkYXRlX3RsYiAtIGludmFsaWRhdGUgZ2FydCBU
TEIKPiArICoKPiArICogQGFkZXY6IGFtZGdwdSBkZXZpY2UgZHJpdmVyIHBvaW50ZXIKPiArICoK
PiArICogSW52YWxpZGF0ZSBnYXJ0IFRMQiB3aGljaCBjYW4gYmUgdXNlIGFzIGEgd2F5IHRvIGZs
dXNoIGdhcnQgY2hhbmdlcwo+ICsgKgo+ICsgKi8KPiArdm9pZCBhbWRncHVfZ2FydF9pbnZhbGlk
YXRlX3RsYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiArewo+ICsJaW50IGk7Cj4KPiAg
IAltYigpOwo+ICAgCWFtZGdwdV9hc2ljX2ZsdXNoX2hkcChhZGV2LCBOVUxMKTsKPiAgIAlmb3Ig
KGkgPSAwOyBpIDwgYWRldi0+bnVtX3ZtaHViczsgaSsrKQo+ICAgCQlhbWRncHVfZ21jX2ZsdXNo
X2dwdV90bGIoYWRldiwgMCwgaSwgMCk7Cj4gLQlyZXR1cm4gMDsKPiAgIH0KPgo+ICAgLyoqCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nYXJ0LmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2FydC5oCj4gaW5kZXggYTI1ZmU5N2Iw
MTk2Li5lMTA0MDIyMTk3YWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2dhcnQuaAo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9nYXJ0LmgKPiBAQCAtNjYsNSArNjYsNSBAQCBpbnQgYW1kZ3B1X2dhcnRfbWFwKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2LCB1aW50NjRfdCBvZmZzZXQsCj4gICBpbnQgYW1kZ3B1X2dhcnRf
YmluZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdWludDY0X3Qgb2Zmc2V0LAo+ICAgCQkg
ICAgIGludCBwYWdlcywgc3RydWN0IHBhZ2UgKipwYWdlbGlzdCwKPiAgIAkJICAgICBkbWFfYWRk
cl90ICpkbWFfYWRkciwgdWludDY0X3QgZmxhZ3MpOwo+IC0KPiArdm9pZCBhbWRncHVfZ2FydF9p
bnZhbGlkYXRlX3RsYihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7Cj4gICAjZW5kaWYKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2d0dF9tZ3IuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ndHRfbWdyLmMKPiBpbmRleCA4ODYw
NTQ1MzQ0YzcuLmExY2Q3NzVmZDYxYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZ3R0X21nci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2d0dF9tZ3IuYwo+IEBAIC0yMDYsMTAgKzIwNiwxMiBAQCB1aW50NjRfdCBhbWRn
cHVfZ3R0X21ncl91c2FnZShzdHJ1Y3QgdHRtX3Jlc291cmNlX21hbmFnZXIgKm1hbikKPiAgIGlu
dCBhbWRncHVfZ3R0X21ncl9yZWNvdmVyKHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlciAqbWFu
KQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfZ3R0X21nciAqbWdyID0gdG9fZ3R0X21ncihtYW4p
Owo+ICsJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXY7Cj4gICAJc3RydWN0IGFtZGdwdV9ndHRf
bm9kZSAqbm9kZTsKPiAgIAlzdHJ1Y3QgZHJtX21tX25vZGUgKm1tX25vZGU7Cj4gICAJaW50IHIg
PSAwOwo+Cj4gKwlhZGV2ID0gY29udGFpbmVyX29mKG1nciwgdHlwZW9mKCphZGV2KSwgbW1hbi5n
dHRfbWdyKTsKPiAgIAlzcGluX2xvY2soJm1nci0+bG9jayk7Cj4gICAJZHJtX21tX2Zvcl9lYWNo
X25vZGUobW1fbm9kZSwgJm1nci0+bW0pIHsKPiAgIAkJbm9kZSA9IGNvbnRhaW5lcl9vZihtbV9u
b2RlLCBzdHJ1Y3QgYW1kZ3B1X2d0dF9ub2RlLCBub2RlKTsKPiBAQCAtMjE5LDYgKzIyMSw4IEBA
IGludCBhbWRncHVfZ3R0X21ncl9yZWNvdmVyKHN0cnVjdCB0dG1fcmVzb3VyY2VfbWFuYWdlciAq
bWFuKQo+ICAgCX0KPiAgIAlzcGluX3VubG9jaygmbWdyLT5sb2NrKTsKPgo+ICsJYW1kZ3B1X2dh
cnRfaW52YWxpZGF0ZV90bGIoYWRldik7Cj4gKwo+ICAgCXJldHVybiByOwo+ICAgfQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwo+IGluZGV4IGMwYWVmMzI3MjkyYS4u
Nzg2NjUwYTRhNDkzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
Ywo+IEBAIC0xMDE0LDYgKzEwMTQsNyBAQCBpbnQgYW1kZ3B1X3R0bV9hbGxvY19nYXJ0KHN0cnVj
dCB0dG1fYnVmZmVyX29iamVjdCAqYm8pCj4gICAJCQlyZXR1cm4gcjsKPiAgIAkJfQo+Cj4gKwkJ
YW1kZ3B1X2dhcnRfaW52YWxpZGF0ZV90bGIoYWRldik7Cj4gICAJCXR0bV9yZXNvdXJjZV9mcmVl
KGJvLCAmYm8tPm1lbSk7Cj4gICAJCWJvLT5tZW0gPSB0bXA7Cj4gICAJfQo+IC0tCj4gMi4zMS4x
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFt
ZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGlu
ZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRl
c2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
