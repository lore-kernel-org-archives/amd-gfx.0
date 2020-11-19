Return-Path: <SRS0=HxJR=EZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D39FC2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2020 07:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10C22223F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2020 07:59:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQISRozm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10C22223F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674B689AFF;
	Thu, 19 Nov 2020 07:59:40 +0000 (UTC)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1CF689AFF
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2020 07:59:38 +0000 (UTC)
Received: by mail-ed1-x542.google.com with SMTP id q3so4810126edr.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 23:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=9ooTeuKa3WKAR5FLLhcrypqWh0iRKQgxf9JxERr4NuI=;
 b=qQISRozmz9rz4jym8rx1/awBYc8pkNmHgbg1SXg7PWPoydMtgN5hWcwclUjUbiLbAf
 rHTH6ScLvysdd7f16Szd8ui0mvQn5lCP83DRgmNUaS/rJ8NCnkkTGzX4YLHxY059Nx+1
 0bkTAyzSVB2ws37ZW13EtBHFEeuqqdDZiKDLPzlcHW7dJTxhaOpmaLVojCQtC1uFSbZ/
 hzSMAFq5d+iI5HNct6h4zNKEsvrY2hDft13VtKYTMzXpJZlBXnxklGlI2e8v+ApnKmjI
 pBTLueqzWOuNBRucp3+yKoNa9RxLkvmTGBFLuWGQHyh69m4vALfAq0jWwBkpq2qOJEEZ
 AhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=9ooTeuKa3WKAR5FLLhcrypqWh0iRKQgxf9JxERr4NuI=;
 b=ELSRMk7ZiKU9DucVW8dg+lOWFs3E0LtC46ZO8VCRzzlNJW/aIv62nZ0ilVLTBymMZ5
 5JTO6WR5J/EhMr7VC5O4szPgeXaYJY3TJ3DYOueGBRfgvYa6gccVDvyJf80myelIMEE/
 mDs6LCQJ7qFrI7t/YgWbpKdZEbuw1AQBJO/uXTWSZgpDqJlkqMk4u81UBcmBjntvqwuE
 beTDaElw8+itTtVzm8EONbW9BIBDGkBAOGglhlEugNfQ641XUbfsYEHMmSz9ABHyYFa5
 xrkawsBEGVwfukL5Y8efMX5rNX6dJug+IIV9yeRW13Uxeu7E9IHEKUFBWOtO1QeJ17gg
 pBVg==
X-Gm-Message-State: AOAM531JLDcBrvbNb8rVIbbrOtTJg4XaC928FdkOJgDdkCzJdHbaYkrb
 QzWhcwSMz5v9t8FfkyZXXsQ=
X-Google-Smtp-Source: ABdhPJxyZ/dofGUEHwoy1ZSmhczfNhDuLFgH9w+mmKPOHp+5bZBnYtlKEBSGZTQlUwA6m7lLIbALhA==
X-Received: by 2002:a50:d5dd:: with SMTP id g29mr30359756edj.379.1605772777389; 
 Wed, 18 Nov 2020 23:59:37 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id l25sm9773960edj.94.2020.11.18.23.59.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2020 23:59:36 -0800 (PST)
Subject: Re: [PATCH v3 1/5] drm/amdgpu/vcn: refactor dec message functions
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
 <1605716641-22176-2-git-send-email-James.Zhu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <51461496-7d05-8f34-abec-dc0098d54954@gmail.com>
Date: Thu, 19 Nov 2020 08:59:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1605716641-22176-2-git-send-email-James.Zhu@amd.com>
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
Cc: jamesz@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTguMTEuMjAgdW0gMTc6MjMgc2NocmllYiBKYW1lcyBaaHU6Cj4gcmVmYWN0b3IgZGVjIG1l
c3NhZ2UgZnVuY3Rpb25zIHRvIGFkZCBkZWMgc29mdHdhcmUgcmluZyBzdXBwb3J0Lgo+Cj4gU2ln
bmVkLW9mZi1ieTogSmFtZXMgWmh1IDxKYW1lcy5aaHVAYW1kLmNvbT4KPiAtLS0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYyB8IDMwICsrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDExIGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92Y24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+IGlu
ZGV4IDdlMTlhNjYuLjMyMjUxZGIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3Zjbi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Zjbi5jCj4gQEAgLTUxMCwxNiArNTEwLDE2IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3Zjbl9k
ZWNfc2VuZF9tc2coc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+ICAgfQo+ICAgCj4gICBzdGF0
aWMgaW50IGFtZGdwdV92Y25fZGVjX2dldF9jcmVhdGVfbXNnKHN0cnVjdCBhbWRncHVfcmluZyAq
cmluZywgdWludDMyX3QgaGFuZGxlLAo+IC0JCQkgICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVu
Y2UpCj4gKwkJCQkJIHN0cnVjdCBhbWRncHVfYm8gKipibykKPiAgIHsKPiAgIAlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IHJpbmctPmFkZXY7Cj4gLQlzdHJ1Y3QgYW1kZ3B1X2JvICpibyA9
IE5VTEw7Cj4gICAJdWludDMyX3QgKm1zZzsKPiAgIAlpbnQgciwgaTsKPiAgIAo+ICsJKmJvID0g
TlVMTDsKClRoaXMgbG9va3MgdW5uZWNlc3NhcnkgdG8gbWUuCgo+ICAgCXIgPSBhbWRncHVfYm9f
Y3JlYXRlX3Jlc2VydmVkKGFkZXYsIDEwMjQsIFBBR0VfU0laRSwKPiAgIAkJCQkgICAgICBBTURH
UFVfR0VNX0RPTUFJTl9WUkFNLAo+IC0JCQkJICAgICAgJmJvLCBOVUxMLCAodm9pZCAqKikmbXNn
KTsKPiArCQkJCSAgICAgIGJvLCBOVUxMLCAodm9pZCAqKikmbXNnKTsKPiAgIAlpZiAocikKPiAg
IAkJcmV0dXJuIHI7Cj4gICAKPiBAQCAtNTQwLDIwICs1NDAsMjAgQEAgc3RhdGljIGludCBhbWRn
cHVfdmNuX2RlY19nZXRfY3JlYXRlX21zZyhzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIHVpbnQz
Ml90IGhhbmQKPiAgIAlmb3IgKGkgPSAxNDsgaSA8IDEwMjQ7ICsraSkKPiAgIAkJbXNnW2ldID0g
Y3B1X3RvX2xlMzIoMHgwKTsKPiAgIAo+IC0JcmV0dXJuIGFtZGdwdV92Y25fZGVjX3NlbmRfbXNn
KHJpbmcsIGJvLCBmZW5jZSk7Cj4gKwlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGlu
dCBhbWRncHVfdmNuX2RlY19nZXRfZGVzdHJveV9tc2coc3RydWN0IGFtZGdwdV9yaW5nICpyaW5n
LCB1aW50MzJfdCBoYW5kbGUsCj4gLQkJCSAgICAgICBzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2Up
Cj4gKwkJCQkJICBzdHJ1Y3QgYW1kZ3B1X2JvICoqYm8pCj4gICB7Cj4gICAJc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYgPSByaW5nLT5hZGV2Owo+IC0Jc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBO
VUxMOwo+ICAgCXVpbnQzMl90ICptc2c7Cj4gICAJaW50IHIsIGk7Cj4gICAKPiArCSpibyA9IE5V
TEw7CgpTYW1lIGhlcmUuCgpBcGFydCBmcm9tIHRoYXQgbG9va3MgZ29vZCB0byBtZS4KCldpdGgg
dGhhdCBmaXhlZCB0aGUgcGF0Y2ggaXMgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCjxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CgpSZWdhcmRzLApDaHJpc3RpYW4uCgo+ICAgCXIgPSBh
bWRncHVfYm9fY3JlYXRlX3Jlc2VydmVkKGFkZXYsIDEwMjQsIFBBR0VfU0laRSwKPiAgIAkJCQkg
ICAgICBBTURHUFVfR0VNX0RPTUFJTl9WUkFNLAo+IC0JCQkJICAgICAgJmJvLCBOVUxMLCAodm9p
ZCAqKikmbXNnKTsKPiArCQkJCSAgICAgIGJvLCBOVUxMLCAodm9pZCAqKikmbXNnKTsKPiAgIAlp
ZiAocikKPiAgIAkJcmV0dXJuIHI7Cj4gICAKPiBAQCAtNTY2LDE5ICs1NjYsMjcgQEAgc3RhdGlj
IGludCBhbWRncHVfdmNuX2RlY19nZXRfZGVzdHJveV9tc2coc3RydWN0IGFtZGdwdV9yaW5nICpy
aW5nLCB1aW50MzJfdCBoYW4KPiAgIAlmb3IgKGkgPSA2OyBpIDwgMTAyNDsgKytpKQo+ICAgCQlt
c2dbaV0gPSBjcHVfdG9fbGUzMigweDApOwo+ICAgCj4gLQlyZXR1cm4gYW1kZ3B1X3Zjbl9kZWNf
c2VuZF9tc2cocmluZywgYm8sIGZlbmNlKTsKPiArCXJldHVybiAwOwo+ICAgfQo+ICAgCj4gICBp
bnQgYW1kZ3B1X3Zjbl9kZWNfcmluZ190ZXN0X2liKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZywg
bG9uZyB0aW1lb3V0KQo+ICAgewo+IC0Jc3RydWN0IGRtYV9mZW5jZSAqZmVuY2U7Cj4gKwlzdHJ1
Y3QgZG1hX2ZlbmNlICpmZW5jZSA9IE5VTEw7Cj4gKwlzdHJ1Y3QgYW1kZ3B1X2JvICpibzsKPiAg
IAlsb25nIHI7Cj4gICAKPiAtCXIgPSBhbWRncHVfdmNuX2RlY19nZXRfY3JlYXRlX21zZyhyaW5n
LCAxLCBOVUxMKTsKPiArCXIgPSBhbWRncHVfdmNuX2RlY19nZXRfY3JlYXRlX21zZyhyaW5nLCAx
LCAmYm8pOwo+ICsJaWYgKHIpCj4gKwkJZ290byBlcnJvcjsKPiArCj4gKwlyID0gYW1kZ3B1X3Zj
bl9kZWNfc2VuZF9tc2cocmluZywgYm8sIE5VTEwpOwo+ICsJaWYgKHIpCj4gKwkJZ290byBlcnJv
cjsKPiArCXIgPSBhbWRncHVfdmNuX2RlY19nZXRfZGVzdHJveV9tc2cocmluZywgMSwgJmJvKTsK
PiAgIAlpZiAocikKPiAgIAkJZ290byBlcnJvcjsKPiAgIAo+IC0JciA9IGFtZGdwdV92Y25fZGVj
X2dldF9kZXN0cm95X21zZyhyaW5nLCAxLCAmZmVuY2UpOwo+ICsJciA9IGFtZGdwdV92Y25fZGVj
X3NlbmRfbXNnKHJpbmcsIGJvLCAmZmVuY2UpOwo+ICAgCWlmIChyKQo+ICAgCQlnb3RvIGVycm9y
Owo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
