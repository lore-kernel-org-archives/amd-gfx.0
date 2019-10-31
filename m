Return-Path: <SRS0=0yA7=YY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A6CCA9EC3
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 07:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A86A2083E
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2019 07:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A86A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5249F6ED93;
	Thu, 31 Oct 2019 07:29:14 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F9F6ED93
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 07:29:12 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id a15so5013111wrf.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2019 00:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=/BLu/qhgfGfwDypSh26Xu3Q2lp4Lc00StUlWtX33wnI=;
 b=SjahfnVMEwUCKaS6UPL7P1kFJ5cwnScbYPo0R4Ijx/m42ziM7f+yKRerGX6PQlor2T
 5L6cXacuQ+6K4E7VfqbRAvVpnutRSQZjlmQ6wd8d1ziJMlcUxisoGTQjTwASQ07twiqP
 VXoKNfJqnfBsgAv32H7X50O8H/XB/AbRl9EUxXu1otS+d/XA76qQCwukEzGcXz1nrA3o
 5kZDmYV+YwMMk9BM9sCzT8zt+3il7mLfvpLsZ4Q8RwSbsZK4Y9c4l2GrtKgyJJaCHs64
 14R7Q66XJ0dRfZcpIIEm3eCh8HfhSgB/31ZdL05jyFgw6ReWedqo8B3AAwG6rnd54HMR
 jp1w==
X-Gm-Message-State: APjAAAX+ea0BTmfd47t2Q2MFKIsCOY7BvyUpEeItlsSykxHWjaMsztt4
 eUkU/Zd1LRCpxSTwQlzNiWbKaL+X
X-Google-Smtp-Source: APXvYqxYdlCHe725s2AE+6uC3ptqpWT8Sypr7MTkCY+WQ3aeQUepPUGDOkvqpOiJ+MQC4by4+zCHjA==
X-Received: by 2002:a5d:6a91:: with SMTP id s17mr4275366wru.224.1572506951359; 
 Thu, 31 Oct 2019 00:29:11 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id j19sm3465865wre.0.2019.10.31.00.29.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Oct 2019 00:29:10 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: implement TMZ accessor
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20191030234233.9896-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2723dbff-806b-542f-4ed1-0e9fc807ca15@gmail.com>
Date: Thu, 31 Oct 2019 08:29:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030234233.9896-1-luben.tuikov@amd.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=/BLu/qhgfGfwDypSh26Xu3Q2lp4Lc00StUlWtX33wnI=;
 b=bI0tRXF1WYwjEtFyMeWf1Uzz48mGxX9I/kFQy2/rW5u7+mbKjwfuiP+JWBrNsJCrn1
 Ccws+6PjSMjDBdZvMHpOk76ZXcjrzd3SrZSJTlGutDu2GI+f8m+NLOdnxaU0231E37EP
 TcoSIRgRg2a+hvc5Fj/kOFBbu1qNi5SUsXbOFwyHOVhpiHHWMXbFJTOl/kyBUMc3BmXY
 qGxksCGVpR2zydG0ha8IWmzyZYLC9G7xNw8cvAbw569eG2RY0SfXId+yKPxxQEWJvUPV
 NhrlDgAMbmgqPPLNsbpmU1YmTnol120l9NneRFgyZ4Ekhxp0A8A1BmbflcOK13wlBOxr
 czLg==
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191031072909.m1gLDRIWeBWkMoHevGsJ433vU8fqyoXt8c7_EVXUpPU@z>

QW0gMzEuMTAuMTkgdW0gMDA6NDMgc2NocmllYiBUdWlrb3YsIEx1YmVuOgo+IEltcGxlbWVudCBh
biBhY2Nlc3NvciBvZiBhZGV2LT50bXouZW5hYmxlZC4gTGV0IG5vdAo+IGNvZGUgYXJvdW5kIGFj
Y2VzcyBpdCBhcyAiaWYgKGFkZXYtPnRtei5lbmFibGVkKSIKPiBhcyB0aGUgb3JnYW5pemF0aW9u
IG1heSBjaGFuZ2UuIEluc3RlYWQuLi4KPgo+IFJlY3J1aXQgImJvb2wgYW1kZ3B1X2lzX3Rteihh
ZGV2KSIgdG8gcmV0dXJuCj4gZXhhY3RseSB0aGlzIEJvb2xlYW4gdmFsdWUuIFRoYXQgaXMsIHRo
aXMgZnVuY3Rpb24KPiBpcyBub3cgYW4gYWNjZXNzb3Igb2YgYW4gYWxyZWFkeSBpbml0aWFsaXpl
ZCBhbmQKPiBzZXQgYWRldiBhbmQgYWRldi0+dG16Lgo+Cj4gQWRkICJ2b2lkIGFtZGdwdV90bXpf
c2V0KGFkZXYpIiB0byBjaGVjayBhbmQgc2V0Cj4gYWRldi0+dG16LiogYXQgaW5pdGlhbGl6YXRp
b24gdGltZS4gQWZ0ZXIgd2hpY2gKPiBvbmUgdXNlcyAiYm9vbCBhbWRncHVfaXNfdG16KGFkZXYp
IiB0byBxdWVyeQo+IHdoZXRoZXIgYWRldiBzdXBwb3J0cyBUTVouCgpBY3R1YWxseSBJIHdvdWxk
IHJhdGhlciBjb21wbGV0ZWx5IHJlbW92ZSB0aGUgYW1kZ3B1X3Rtei5baGNdIGZpbGVzLiBTZWUg
ClRNWiBpcyBhIGZlYXR1cmUgYW5kIG5vdCBhIGhhcmR3YXJlIGJsb2NrLgoKQWxsIHRoYXQgc3R1
ZmYgc2hvdWxkIHByb2JhYmx5IG1vdmVkIGludG8gdGhlIFBTUCBoYW5kbGluZywgc2luY2UgdGhl
IApjb250cm9sIG9mIFRNWiBpcyBlbmFibGVkIG9yIGRpc2FibGVkIGluIHRoZSBoYXJkd2FyZSBp
cyB0aGVyZS4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPiBBbHNvLCByZW1vdmUgY2lyY3VsYXIg
aGVhZGVyIGZpbGUgaW5jbHVkZS4KPgo+IFNpZ25lZC1vZmYtYnk6IEx1YmVuIFR1aWtvdiA8bHVi
ZW4udHVpa292QGFtZC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHUuaCAgICAgICAgfCAgNSArKysrKwo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X2RldmljZS5jIHwgIDIgKy0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90bXouYyAgICB8IDIzICsrKysrKysrKysrLS0tLS0tLS0tLS0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90bXouaCAgICB8ICA3ICsrLS0tLS0KPiAgIDQgZmlsZXMg
Y2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaAo+IGluZGV4IDdkMWU1MjhjYzc4My4uMjNiZDgxYTc2NTcwIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4gKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKPiBAQCAtMTI0OSw1ICsxMjQ5LDEw
IEBAIF9uYW1lIyNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCQkJCQlcCj4gICAJCQkJCQkJCQlc
Cj4gICBzdGF0aWMgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgcG11X2F0dHJfIyNfbmFtZSA9IF9f
QVRUUl9STyhfbmFtZSkKPiAgIAo+ICtzdGF0aWMgaW5saW5lIGJvb2wgYW1kZ3B1X2lzX3Rteihz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiArewo+ICsJcmV0dXJuIGFkZXYtPnRtei5lbmFi
bGVkOwo+ICt9Cj4gKwo+ICAgI2VuZGlmCj4gICAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2RldmljZS5jCj4gaW5kZXggNGVlZTQwYjlkMGIwLi5mMTJiODE3NDgwYmIgMTAw
NjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCj4gQEAgLTEw
NTgsNyArMTA1OCw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2RldmljZV9jaGVja19hcmd1bWVudHMo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAKPiAgIAlhZGV2LT5maXJtd2FyZS5sb2Fk
X3R5cGUgPSBhbWRncHVfdWNvZGVfZ2V0X2xvYWRfdHlwZShhZGV2LCBhbWRncHVfZndfbG9hZF90
eXBlKTsKPiAgIAo+IC0JYWRldi0+dG16LmVuYWJsZWQgPSBhbWRncHVfaXNfdG16KGFkZXYpOwo+
ICsJYW1kZ3B1X3Rtel9zZXQoYWRldik7Cj4gICAKPiAgIAlyZXR1cm4gcmV0Owo+ICAgfQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdG16LmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdG16LmMKPiBpbmRleCA4MjM1MjdhMGZhNDcu
LjUxOGI5ZDMzNTU1MCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdG16LmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdG16
LmMKPiBAQCAtMjcsMjYgKzI3LDI1IEBACj4gICAjaW5jbHVkZSAiYW1kZ3B1LmgiCj4gICAjaW5j
bHVkZSAiYW1kZ3B1X3Rtei5oIgo+ICAgCj4gLQo+ICAgLyoqCj4gLSAqIGFtZGdwdV9pc190bXog
LSB2YWxpZGF0ZSB0cnVzdCBtZW1vcnkgem9uZQo+IC0gKgo+ICsgKiBhbWRncHVfdG16X3NldCAt
LSBjaGVjayBhbmQgc2V0IGlmIGEgZGV2aWNlIHN1cHBvcnRzIFRNWgo+ICAgICogQGFkZXY6IGFt
ZGdwdV9kZXZpY2UgcG9pbnRlcgo+ICAgICoKPiAtICogUmV0dXJuIHRydWUgaWYgQGRldiBzdXBw
b3J0cyB0cnVzdGVkIG1lbW9yeSB6b25lcyAoVE1aKSwgYW5kIHJldHVybiBmYWxzZSBpZgo+IC0g
KiBAZGV2IGRvZXMgbm90IHN1cHBvcnQgVE1aLgo+ICsgKiBDaGVjayBhbmQgc2V0IGlmIGFuIHRo
ZSBkZXZpY2UgQGFkZXYgc3VwcG9ydHMgVHJ1c3RlZCBNZW1vcnkKPiArICogWm9uZXMgKFRNWiku
Cj4gICAgKi8KPiAtYm9vbCBhbWRncHVfaXNfdG16KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQo+ICt2b2lkIGFtZGdwdV90bXpfc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQo+ICAg
ewo+ICAgCWlmICghYW1kZ3B1X3RteikKPiAtCQlyZXR1cm4gZmFsc2U7Cj4gKwkJcmV0dXJuOwo+
ICAgCj4gLQlpZiAoYWRldi0+YXNpY190eXBlIDwgQ0hJUF9SQVZFTiB8fCBhZGV2LT5hc2ljX3R5
cGUgPT0gQ0hJUF9BUkNUVVJVUykgewo+IC0JCWRldl93YXJuKGFkZXYtPmRldiwgImRvZXNuJ3Qg
c3VwcG9ydCB0cnVzdGVkIG1lbW9yeSB6b25lcyAoVE1aKVxuIik7Cj4gLQkJcmV0dXJuIGZhbHNl
Owo+ICsJaWYgKGFkZXYtPmFzaWNfdHlwZSA8IENISVBfUkFWRU4gfHwKPiArCSAgICBhZGV2LT5h
c2ljX3R5cGUgPT0gQ0hJUF9BUkNUVVJVUykgewo+ICsJCWRldl93YXJuKGFkZXYtPmRldiwgIlRy
dXN0ZWQgTWVtb3J5IFpvbmUgKFRNWikgZmVhdHVyZSBub3Qgc3VwcG9ydGVkXG4iKTsKPiArCQly
ZXR1cm47Cj4gICAJfQo+ICAgCj4gLQlkZXZfaW5mbyhhZGV2LT5kZXYsICJUTVogZmVhdHVyZSBp
cyBlbmFibGVkXG4iKTsKPiArCWFkZXYtPnRtei5lbmFibGVkID0gdHJ1ZTsKPiAgIAo+IC0JcmV0
dXJuIHRydWU7Cj4gKwlkZXZfaW5mbyhhZGV2LT5kZXYsICJUcnVzdGVkIE1lbW9yeSBab25lIChU
TVopIGZlYXR1cmUgc3VwcG9ydGVkIGFuZCBlbmFibGVkXG4iKTsKPiAgIH0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rtei5oIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rtei5oCj4gaW5kZXggMjhlMDUxNzdmYjg5Li5hZDNhZDhj
MDExZjkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rt
ei5oCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Rtei5oCj4gQEAg
LTI0LDE2ICsyNCwxMyBAQAo+ICAgI2lmbmRlZiBfX0FNREdQVV9UTVpfSF9fCj4gICAjZGVmaW5l
IF9fQU1ER1BVX1RNWl9IX18KPiAgIAo+IC0jaW5jbHVkZSAiYW1kZ3B1LmgiCj4gLQo+ICAgLyoK
PiAtICogVHJ1c3QgbWVtb3J5IHpvbmUgc3R1ZmYKPiArICogVHJ1c3RlZCBNZW1vcnkgWm9uZSBw
YXJ0aWN1bGFycwo+ICAgICovCj4gICBzdHJ1Y3QgYW1kZ3B1X3RteiB7Cj4gICAJYm9vbAllbmFi
bGVkOwo+ICAgfTsKPiAgIAo+IC0KPiAtZXh0ZXJuIGJvb2wgYW1kZ3B1X2lzX3RteihzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldik7Cj4gK2V4dGVybiB2b2lkIGFtZGdwdV90bXpfc2V0KHN0cnVj
dCBhbWRncHVfZGV2aWNlICphZGV2KTsKPiAgIAo+ICAgI2VuZGlmCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
