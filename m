Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF59C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 11:31:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C485207F7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 11:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0qd92O9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C485207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C536E111;
	Fri, 16 Oct 2020 11:31:06 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 067E16E111
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 11:31:04 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 13so2119826wmf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 04:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=p5uR7/U+pQeu+U+BAsUdHUJvLnGN9xKMZwDW5+xAk8M=;
 b=k0qd92O927dr0rsxiLm+DyBbPuGii/LjADKmP2/E3xJr3XNvz0Opmzc1HQBtzPnKz3
 IFgHMYm0FDnPbgSr1oMyE7VX1JLbybhs1FC5BEy1CkfVr36kPUI4ZE1/ZikyxyWoP4Ap
 zQ91sqaNDt10r+P9hnq/iynuGgnOVbose90ZmJdD+jN7G0DOgkbsESP3gOUYQatmLhH5
 sh0r6zCGDMYn8MJnMfcc7P1EM9FVI75sVmVG9CCm/6eVF1sdkNYgze7UkimO4W7gsh4I
 MEOk6Z43HP1EgPhXQJVW/zT6es5tbnQaRhlYRLOfM1FgG4ZYeFAWsQynXzH9MIfO5a2H
 i03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=p5uR7/U+pQeu+U+BAsUdHUJvLnGN9xKMZwDW5+xAk8M=;
 b=Z2dtjzzxBdHxeX77bDfABJSg9j2JivrD0j8A4KowucyOSwoPKnDcSmdgmUjcUfp/ZH
 cDzrWNDAasqr8gLl+WTtOS1L4b0ELw3pTgCwtktcS9zf6yX2E61OmCUidxREgWSfB2sF
 10eYXLFIWP7vRusINpPJEYDjmXgkbSBHQfO7Fyeoz2JsL/Uoy+8a9JjoSW3Yvw1TeV71
 dIhQF7LJv590cw1pPPmy+V8EzBH79EiJWAlkVlZfScFyqx39l+mjmMjDup3NBmSlFMUJ
 wgRj+M6Evh+0OL3zRA3JbMRY/Smy49FkWl4LaS0JqgkH1vPDL7MUB1qCvJSA3HU6FKfb
 a9SQ==
X-Gm-Message-State: AOAM532biAdEIh+6PRO7j2hIPa7oIatKL9DyarVpY9VsBW13rvDq2Ha+
 T3WMkESUI+qE0JrazjzFPm0XpsEgf+A=
X-Google-Smtp-Source: ABdhPJxURpMC3dR+hHZ7h09BRwCo78uhqRt+GJDgCap88jXQQO8c/7mvYRBB2e8lLUBltZ2FgS4UbA==
X-Received: by 2002:a7b:c1d6:: with SMTP id a22mr3328530wmj.105.1602847863625; 
 Fri, 16 Oct 2020 04:31:03 -0700 (PDT)
Received: from [192.168.137.56]
 (dynamic-093-132-127-018.93.132.pool.telefonica.de. [93.132.127.18])
 by smtp.gmail.com with ESMTPSA id f14sm3190651wrt.53.2020.10.16.04.31.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 04:31:02 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: add a list in VM for BOs in the done state
To: Mihir Patel <mihir.patel@amd.com>, amd-gfx@lists.freedesktop.org
References: <20201016105511.3670-1-mihir.patel@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <3d54fa44-4912-c42d-3f81-25c37a4980f3@gmail.com>
Date: Fri, 16 Oct 2020 13:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201016105511.3670-1-mihir.patel@amd.com>
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
Cc: alexander.deucher@amd.com, Madhav.Chauhan@amd.com, pkamliya@amd.com,
 Christian.Koenig@amd.com, ksurampa@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTYuMTAuMjAgdW0gMTI6NTUgc2NocmllYiBNaWhpciBQYXRlbDoKPiBGcm9tOiBNaWhpciBC
aG9naWxhbCBQYXRlbCA8TWloaXIuUGF0ZWxAYW1kLmNvbT4KPgo+IEFkZCBhIG5ldyBsaXN0IGlu
IFZNIGZvciBkb25lIHN0YXRlIGkuZS4gQk9zIHdoaWNoIGFyZQo+IGludmFsaWRhdGVkIGFuZCB1
cGRhdGVkIGluIFBURXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNaWhpciBCaG9naWxhbCBQYXRlbCA8
TWloaXIuUGF0ZWxAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMgfCAxOSArKysrKysrKysrKysrKysrLS0tCj4gICBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uaCB8ICAzICsrKwo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAx
OSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3ZtLmMKPiBpbmRleCAxMjI4MTRjM2ZmNWYuLmMwOGI3NmY0MDQyYSAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4gQEAgLTMwMCw3ICszMDAsNyBA
QCBzdGF0aWMgdm9pZCBhbWRncHVfdm1fYm9fcmVsb2NhdGVkKHN0cnVjdCBhbWRncHVfdm1fYm9f
YmFzZSAqdm1fYm8pCj4gICBzdGF0aWMgdm9pZCBhbWRncHVfdm1fYm9fZG9uZShzdHJ1Y3QgYW1k
Z3B1X3ZtX2JvX2Jhc2UgKnZtX2JvKQo+ICAgewo+ICAgCXNwaW5fbG9jaygmdm1fYm8tPnZtLT5p
bnZhbGlkYXRlZF9sb2NrKTsKPiAtCWxpc3RfZGVsX2luaXQoJnZtX2JvLT52bV9zdGF0dXMpOwo+
ICsJbGlzdF9tb3ZlKCZ2bV9iby0+dm1fc3RhdHVzLCAmdm1fYm8tPnZtLT5kb25lKTsKPiAgIAlz
cGluX3VubG9jaygmdm1fYm8tPnZtLT5pbnZhbGlkYXRlZF9sb2NrKTsKPiAgIH0KPiAgIAo+IEBA
IC0yODIzLDcgKzI4MjMsNyBAQCBpbnQgYW1kZ3B1X3ZtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsIHN0cnVjdCBhbWRncHVfdm0gKnZtLAo+ICAgCUlOSVRfTElTVF9IRUFEKCZ2bS0+
aW52YWxpZGF0ZWQpOwo+ICAgCXNwaW5fbG9ja19pbml0KCZ2bS0+aW52YWxpZGF0ZWRfbG9jayk7
Cj4gICAJSU5JVF9MSVNUX0hFQUQoJnZtLT5mcmVlZCk7Cj4gLQo+ICsJSU5JVF9MSVNUX0hFQUQo
JnZtLT5kb25lKTsKPiAgIAo+ICAgCS8qIGNyZWF0ZSBzY2hlZHVsZXIgZW50aXRpZXMgZm9yIHBh
Z2UgdGFibGUgdXBkYXRlcyAqLwo+ICAgCXIgPSBkcm1fc2NoZWRfZW50aXR5X2luaXQoJnZtLT5p
bW1lZGlhdGUsIERSTV9TQ0hFRF9QUklPUklUWV9OT1JNQUwsCj4gQEAgLTM0MTAsMTEgKzM0MTAs
MTMgQEAgdm9pZCBhbWRncHVfZGVidWdmc192bV9ib19pbmZvKHN0cnVjdCBhbWRncHVfdm0gKnZt
LCBzdHJ1Y3Qgc2VxX2ZpbGUgKm0pCj4gICAJdTY0IHRvdGFsX3JlbG9jYXRlZCA9IDA7Cj4gICAJ
dTY0IHRvdGFsX21vdmVkID0gMDsKPiAgIAl1NjQgdG90YWxfaW52YWxpZGF0ZWQgPSAwOwo+ICsJ
dTY0IHRvdGFsX2RvbmUgPSAwOwo+ICAgCXVuc2lnbmVkIGludCB0b3RhbF9pZGxlX29ianMgPSAw
Owo+ICAgCXVuc2lnbmVkIGludCB0b3RhbF9ldmljdGVkX29ianMgPSAwOwo+ICAgCXVuc2lnbmVk
IGludCB0b3RhbF9yZWxvY2F0ZWRfb2JqcyA9IDA7Cj4gICAJdW5zaWduZWQgaW50IHRvdGFsX21v
dmVkX29ianMgPSAwOwo+ICAgCXVuc2lnbmVkIGludCB0b3RhbF9pbnZhbGlkYXRlZF9vYmpzID0g
MDsKPiArCXVuc2lnbmVkIGludCB0b3RhbF9kb25lX29ianMgPSAwOwo+ICAgCXVuc2lnbmVkIGlu
dCBpZCA9IDA7Cj4gICAKPiAgIAlzZXFfcHV0cyhtLCAiXHRJZGxlIEJPczpcbiIpOwo+IEBAIC0z
NDYwLDggKzM0NjIsMTcgQEAgdm9pZCBhbWRncHVfZGVidWdmc192bV9ib19pbmZvKHN0cnVjdCBh
bWRncHVfdm0gKnZtLCBzdHJ1Y3Qgc2VxX2ZpbGUgKm0pCj4gICAJCQljb250aW51ZTsKPiAgIAkJ
dG90YWxfaW52YWxpZGF0ZWQgKz0gYW1kZ3B1X2JvX3ByaW50X2luZm8oaWQrKywJYm9fdmEtPmJh
c2UuYm8sIG0pOwo+ICAgCX0KPiAtCXNwaW5fdW5sb2NrKCZ2bS0+aW52YWxpZGF0ZWRfbG9jayk7
Cj4gICAJdG90YWxfaW52YWxpZGF0ZWRfb2JqcyA9IGlkOwo+ICsJaWQgPSAwOwo+ICsKPiArCXNl
cV9wdXRzKG0sICJcdERvbmUgQk9zOlxuIik7Cj4gKwlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUo
Ym9fdmEsIHRtcCwgJnZtLT5kb25lLCBiYXNlLnZtX3N0YXR1cykgewo+ICsJCWlmICghYm9fdmEt
PmJhc2UuYm8pCj4gKwkJCWNvbnRpbnVlOwo+ICsJCXRvdGFsX2RvbmUgKz0gYW1kZ3B1X2JvX3By
aW50X2luZm8oaWQrKywgYm9fdmEtPmJhc2UuYm8sIG0pOwo+ICsJfQo+ICsJc3Bpbl91bmxvY2so
JnZtLT5pbnZhbGlkYXRlZF9sb2NrKTsKPiArCXRvdGFsX2RvbmVfb2JqcyA9IGlkOwo+ICAgCj4g
ICAJc2VxX3ByaW50ZihtLCAiXHRUb3RhbCBpZGxlIHNpemU6ICAgICAgICAlMTJsbGRcdG9ianM6
XHQlZFxuIiwgdG90YWxfaWRsZSwKPiAgIAkJICAgdG90YWxfaWRsZV9vYmpzKTsKPiBAQCAtMzQ3
Myw1ICszNDg0LDcgQEAgdm9pZCBhbWRncHVfZGVidWdmc192bV9ib19pbmZvKHN0cnVjdCBhbWRn
cHVfdm0gKnZtLCBzdHJ1Y3Qgc2VxX2ZpbGUgKm0pCj4gICAJCSAgIHRvdGFsX21vdmVkX29ianMp
Owo+ICAgCXNlcV9wcmludGYobSwgIlx0VG90YWwgaW52YWxpZGF0ZWQgc2l6ZTogJTEybGxkXHRv
YmpzOlx0JWRcbiIsIHRvdGFsX2ludmFsaWRhdGVkLAo+ICAgCQkgICB0b3RhbF9pbnZhbGlkYXRl
ZF9vYmpzKTsKPiArCXNlcV9wcmludGYobSwgIlx0VG90YWwgZG9uZSBzaXplOiAgICAgICAgJTEy
bGxkXHRvYmpzOlx0JWRcbiIsIHRvdGFsX2RvbmUsCj4gKwkJICAgdG90YWxfZG9uZV9vYmpzKTsK
PiAgIH0KPiAgICNlbmRpZgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdm0uaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5oCj4g
aW5kZXggNzRjYzE0MTc5YzQxLi5mZmVhM2I4OWI5ZGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdm0uaAo+IEBAIC0yNzQsNiArMjc0LDkgQEAgc3RydWN0IGFtZGdwdV92
bSB7Cj4gICAJLyogQk8gbWFwcGluZ3MgZnJlZWQsIGJ1dCBub3QgeWV0IHVwZGF0ZWQgaW4gdGhl
IFBUICovCj4gICAJc3RydWN0IGxpc3RfaGVhZAlmcmVlZDsKPiAgIAo+ICsJLyogQk9zIHdoaWNo
IGFyZSBpbnZhbGlkYXRlZCwgaGFzIGJlZW4gdXBkYXRlZCBpbiB0aGUgUFRzICovCj4gKwlzdHJ1
Y3QgbGlzdF9oZWFkICAgICAgICBkb25lOwo+ICsKPiAgIAkvKiBjb250YWlucyB0aGUgcGFnZSBk
aXJlY3RvcnkgKi8KPiAgIAlzdHJ1Y3QgYW1kZ3B1X3ZtX3B0ICAgICByb290Owo+ICAgCXN0cnVj
dCBkbWFfZmVuY2UJKmxhc3RfdXBkYXRlOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
