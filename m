Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD56C3600C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 09:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA0A110E22C;
	Mon, 24 Mar 2025 09:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FUW63erS";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7C7810E0AC
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 21:24:10 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so18590035e9.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742678649; x=1743283449; darn=lists.freedesktop.org;
 h=to:content-language:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xZeW8Ld9RLw6BDUBkDbh4+i9LTToSTTGkf9nANzd7hw=;
 b=FUW63erSt6Z286lrvp9bAcOU0tSgvcZgpAAEAZ6ZomcBWKnexgmRJuCh8a6zmUkR0t
 iBc/zVx3HxbpBWwqjtvWhg10hGloerjmxxaB48tVavF+uHQqNWTXbofAsYtYyVjv29KP
 5H8D0BXdUTUKoA+59Cd89xg/hypcQeeot4l7QlNAf4f1lGb2xArOqB6eh5t383NaeZzD
 6pFfWegFpo5CYVn8HinrcmWKgXDuK7M/MBY/WD/w1mhHl0DO+TKatioD6RSB20ZHTVqg
 slqWS28ghPrYq6w6IvoKgS+F2TwNBTM214Fz2o+dtZX21ZDN7xmWMrRPTz6BTQ9bH6O5
 rZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742678649; x=1743283449;
 h=to:content-language:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xZeW8Ld9RLw6BDUBkDbh4+i9LTToSTTGkf9nANzd7hw=;
 b=BCtB4U4Cj0UPIcXzvtrsfVOn4AV3CLcIp8QRCv6YRNbI821c+v375RgyYrCSzydhY3
 x8kfRrKHnbtbktZfVZkJbs94nqjHnxzsvI3zxNIJjMw+vwsvtN5cs85vNnPOaOFGknR5
 rBd/ySH2lrBr7v2dlo3JbgyaxFm28JW1LHpTFYyzKSnBESSMAmhj6BMjIsR6i/+zF9GV
 fa9zsl9OOLFWC4I6a/++QKNIqIgHR32clyyRTwuWdLHOtgaAQy+AbXsDAImIOsmMMBFt
 hrx5SWHmgEkeWMPEviUKr4BL4sVlzIfueZgu5qy9kJlLn4szyFUUMZe7+JTOxdCaZZUu
 mfuA==
X-Gm-Message-State: AOJu0YzXMtkKSq1HYPhu7ZhuC/u95PcOkXtQUwWjiRu8jQKTARTytg/5
 ddsu0S3yzWG6zLY0+5PouPJ/Daw7HVLNXgiS0Kp84J/QMLjeJ36+Ds8A4Q==
X-Gm-Gg: ASbGncvQkdrvSKTShCehrQRIHJWggkpbL5/nHScE20sSDMG5KmVMENjcI8GjSQRJuB+
 UG3Em0Of7r9KefmKLUJ8iV3/M+ykXaU7kiy4UBlzRhD83psE//2vzSlx962N9SV/n/NSQqt1Z8p
 XoYIjcauxIFUdv0mmsvPLtccBrZOuwMPM+x600LBTgYr0THYX34JIhMk2WiHewh+qTgnA/uMAln
 XHd7bhNzYKOsoST3RPksoy7ka6oHBJhNctV7V0ngxO64tTBU/Z9KTrV6h9nNiO/avRV2dcIV4wF
 k0+0iKlO2BZVEWVNIFyr9TUCK/1hDhqq7iCEUTfgkpWK2pPJISuVPwarqkQV8kLCwK0g96qnYcI
 amtHn+B5h4t6fYoTY
X-Google-Smtp-Source: AGHT+IFEh4qlsqBmhe1XpNUxDtt6kY3HEMPBI7CP+kOdjCCOX6DWCdsQHnsm7ICxmxAJdHSTCDi2Sw==
X-Received: by 2002:a05:600c:3591:b0:43c:f3e1:a729 with SMTP id
 5b1f17b1804b1-43d491b708dmr98396495e9.12.1742678648996; 
 Sat, 22 Mar 2025 14:24:08 -0700 (PDT)
Received: from [192.168.2.21] (cable-static-213-203.rsnweb.ch.
 [89.186.213.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed4d9sm118701285e9.33.2025.03.22.14.24.07
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Mar 2025 14:24:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Y0C7VwRAfMVrona43ZUvI0dB"
Message-ID: <e74d57c8-60e7-4ea8-9f72-bc2d8cdb9767@gmail.com>
Date: Sat, 22 Mar 2025 22:24:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Malte Dronskowski <malted.dev@gmail.com>
Subject: [RFC] GTT added to preferred domain (?)
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Mon, 24 Mar 2025 09:06:25 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------Y0C7VwRAfMVrona43ZUvI0dB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I want to prepend that I've never done kernel programming and am not familiar 
with the amdgpu driver. That said, I read through the issues on Mesa regarding 
its behavior when RADV runs out of VRAM [1] and the related information.

Thereby I stumbled upon Christian König mentioning that it would be buggy 
behavior if the preferred domain included GTT when the initial domain was 
updated [2]. I read some of the related code in the kernel driver, trying to 
understand it, and got the impression that this is actually the case. When 
amdgpu_gem_object_create() fails in amdgpu_gem_create_ioctl(), 
"AMDGPU_GEM_DOMAIN_GTT" is added to "initial_domain" which during the retry 
gets written into both, "domain" and "preferred_domain" in 
amdgpu_gem_object_create(). Is this intended or a bug?

I've attached a minimal proof-of-concept patch (applied to kernel 6.14-rc7) 
that runs fine for me. I don't know though if this has any real effect on the 
driver's memory management. So please excuse me if this is a dumb 
question/patch and I did steal your time. Any insight would still be 
appreciated.

Thanks and best regards
Malte

[1] https://gitlab.freedesktop.org/mesa/mesa/-/issues/8763
[2] https://lists.freedesktop.org/archives/amd-gfx/2024-April/107401.html
______________________________________________________________________________
--------------Y0C7VwRAfMVrona43ZUvI0dB
Content-Type: text/x-patch; charset=UTF-8;
 name="amdgpu_gem_preferred_domain.patch"
Content-Disposition: attachment; filename="amdgpu_gem_preferred_domain.patch"
Content-Transfer-Encoding: base64

LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jCTIwMjUtMDMt
MTYgMjM6NTU6MTcuMDAwMDAwMDAwICswMTAwCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9nZW0uYwkyMDI1LTAzLTIwIDIyOjU4OjU5Ljg0OTE5NTY0NSArMDEw
MApAQCAtOTMsNyArOTMsNyBAQAogfQogCiBpbnQgYW1kZ3B1X2dlbV9vYmplY3RfY3JlYXRl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBsb25nIHNpemUsCi0JCQkg
ICAgIGludCBhbGlnbm1lbnQsIHUzMiBpbml0aWFsX2RvbWFpbiwKKwkJCSAgICAgaW50IGFs
aWdubWVudCwgdTMyIGluaXRpYWxfZG9tYWluLCB1MzIgZG9tYWluLAogCQkJICAgICB1NjQg
ZmxhZ3MsIGVudW0gdHRtX2JvX3R5cGUgdHlwZSwKIAkJCSAgICAgc3RydWN0IGRtYV9yZXN2
ICpyZXN2LAogCQkJICAgICBzdHJ1Y3QgZHJtX2dlbV9vYmplY3QgKipvYmosIGludDhfdCB4
Y3BfaWRfcGx1czEpCkBAIC0xMTMsNyArMTEzLDcgQEAKIAlicC5yZXN2ID0gcmVzdjsKIAli
cC5wcmVmZXJyZWRfZG9tYWluID0gaW5pdGlhbF9kb21haW47CiAJYnAuZmxhZ3MgPSBmbGFn
czsKLQlicC5kb21haW4gPSBpbml0aWFsX2RvbWFpbjsKKwlicC5kb21haW4gPSBkb21haW47
CiAJYnAuYm9fcHRyX3NpemUgPSBzaXplb2Yoc3RydWN0IGFtZGdwdV9ibyk7CiAJYnAueGNw
X2lkX3BsdXMxID0geGNwX2lkX3BsdXMxOwogCkBAIC0zMTgsNyArMzE4LDcgQEAKIAl1aW50
NjRfdCBzaXplID0gYXJncy0+aW4uYm9fc2l6ZTsKIAlzdHJ1Y3QgZG1hX3Jlc3YgKnJlc3Yg
PSBOVUxMOwogCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ29iajsKLQl1aW50MzJfdCBoYW5k
bGUsIGluaXRpYWxfZG9tYWluOworCXVpbnQzMl90IGhhbmRsZSwgaW5pdGlhbF9kb21haW4s
IGRvbWFpbjsKIAlpbnQgcjsKIAogCS8qIHJlamVjdCBET09SQkVMTHMgdW50aWwgdXNlcnNw
YWNlIGNvZGUgdG8gdXNlIGl0IGlzIGF2YWlsYWJsZSAqLwpAQCAtMzcxLDkgKzM3MSw5IEBA
CiAJfQogCi0JaW5pdGlhbF9kb21haW4gPSAodTMyKSgweGZmZmZmZmZmICYgYXJncy0+aW4u
ZG9tYWlucyk7CisJZG9tYWluID0gaW5pdGlhbF9kb21haW4gPSAodTMyKSgweGZmZmZmZmZm
ICYgYXJncy0+aW4uZG9tYWlucyk7CiByZXRyeToKIAlyID0gYW1kZ3B1X2dlbV9vYmplY3Rf
Y3JlYXRlKGFkZXYsIHNpemUsIGFyZ3MtPmluLmFsaWdubWVudCwKLQkJCQkgICAgIGluaXRp
YWxfZG9tYWluLAorCQkJCSAgICAgaW5pdGlhbF9kb21haW4sIGRvbWFpbiwKIAkJCQkgICAg
IGZsYWdzLCB0dG1fYm9fdHlwZV9kZXZpY2UsIHJlc3YsICZnb2JqLCBmcHJpdi0+eGNwX2lk
ICsgMSk7CiAJaWYgKHIgJiYgciAhPSAtRVJFU1RBUlRTWVMpIHsKIAkJaWYgKGZsYWdzICYg
QU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0FDQ0VTU19SRVFVSVJFRCkgewpAQCAtMzgxLDggKzM4
Miw4IEBACiAJCQlnb3RvIHJldHJ5OwogCQl9CiAKLQkJaWYgKGluaXRpYWxfZG9tYWluID09
IEFNREdQVV9HRU1fRE9NQUlOX1ZSQU0pIHsKLQkJCWluaXRpYWxfZG9tYWluIHw9IEFNREdQ
VV9HRU1fRE9NQUlOX0dUVDsKKwkJaWYgKGRvbWFpbiA9PSBBTURHUFVfR0VNX0RPTUFJTl9W
UkFNKSB7CisJCQlkb21haW4gfD0gQU1ER1BVX0dFTV9ET01BSU5fR1RUOwogCQkJZ290byBy
ZXRyeTsKIAkJfQogCQlEUk1fREVCVUcoIkZhaWxlZCB0byBhbGxvY2F0ZSBHRU0gb2JqZWN0
ICglbGx1LCAlZCwgJWxsdSwgJWQpXG4iLApAQCAtNDQzLDcgKzQ0NCw3IEBACiAJfQogCiAJ
LyogY3JlYXRlIGEgZ2VtIG9iamVjdCB0byBjb250YWluIHRoaXMgb2JqZWN0IGluICovCi0J
ciA9IGFtZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZShhZGV2LCBhcmdzLT5zaXplLCAwLCBBTURH
UFVfR0VNX0RPTUFJTl9DUFUsCisJciA9IGFtZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZShhZGV2
LCBhcmdzLT5zaXplLCAwLCBBTURHUFVfR0VNX0RPTUFJTl9DUFUsIEFNREdQVV9HRU1fRE9N
QUlOX0NQVSwKIAkJCQkgICAgIDAsIHR0bV9ib190eXBlX2RldmljZSwgTlVMTCwgJmdvYmos
IGZwcml2LT54Y3BfaWQgKyAxKTsKIAlpZiAocikKIAkJcmV0dXJuIHI7CkBAIC05NjcsNyAr
OTY4LDcgQEAKIAlhcmdzLT5zaXplID0gQUxJR04oYXJncy0+c2l6ZSwgUEFHRV9TSVpFKTsK
IAlkb21haW4gPSBhbWRncHVfYm9fZ2V0X3ByZWZlcnJlZF9kb21haW4oYWRldiwKIAkJCQlh
bWRncHVfZGlzcGxheV9zdXBwb3J0ZWRfZG9tYWlucyhhZGV2LCBmbGFncykpOwotCXIgPSBh
bWRncHVfZ2VtX29iamVjdF9jcmVhdGUoYWRldiwgYXJncy0+c2l6ZSwgMCwgZG9tYWluLCBm
bGFncywKKwlyID0gYW1kZ3B1X2dlbV9vYmplY3RfY3JlYXRlKGFkZXYsIGFyZ3MtPnNpemUs
IDAsIGRvbWFpbiwgZG9tYWluLCBmbGFncywKIAkJCQkgICAgIHR0bV9ib190eXBlX2Rldmlj
ZSwgTlVMTCwgJmdvYmosIGZwcml2LT54Y3BfaWQgKyAxKTsKIAlpZiAocikKIAkJcmV0dXJu
IC1FTk9NRU07Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0u
aAkyMDI1LTAzLTE2IDIzOjU1OjE3LjAwMDAwMDAwMCArMDEwMAorKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ2VtLmgJMjAyNS0wMy0yMCAyMTo0ODo0NC40MTY3
MzgyMTEgKzAxMDAKQEAgLTQyLDcgKzQyLDcgQEAKICAqLwogdm9pZCBhbWRncHVfZ2VtX2Zv
cmNlX3JlbGVhc2Uoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpOwogaW50IGFtZGdwdV9n
ZW1fb2JqZWN0X2NyZWF0ZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQg
bG9uZyBzaXplLAotCQkJICAgICBpbnQgYWxpZ25tZW50LCB1MzIgaW5pdGlhbF9kb21haW4s
CisJCQkgICAgIGludCBhbGlnbm1lbnQsIHUzMiBpbml0aWFsX2RvbWFpbiwgdTMyIGRvbWFp
biwKIAkJCSAgICAgdTY0IGZsYWdzLCBlbnVtIHR0bV9ib190eXBlIHR5cGUsCiAJCQkgICAg
IHN0cnVjdCBkbWFfcmVzdiAqcmVzdiwKIAkJCSAgICAgc3RydWN0IGRybV9nZW1fb2JqZWN0
ICoqb2JqLCBpbnQ4X3QgeGNwX2lkX3BsdXMxKTsKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCTIwMjUtMDMtMTYgMjM6NTU6MTcuMDAw
MDAwMDAwICswMTAwCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYwkyMDI1LTAzLTIwIDIyOjMyOjUzLjA1NzcwOTA4MCArMDEwMApAQCAt
MzI4LDcgKzMyOCw3IEBACiAJCQkJCUFNREdQVV9HRU1fQ1JFQVRFX1VOQ0FDSEVEKTsKIAog
CXJldCA9IGFtZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZShhZGV2LCBtZW0tPmJvLT50Ym8uYmFz
ZS5zaXplLCAxLAotCQkJQU1ER1BVX0dFTV9ET01BSU5fQ1BVLCBBTURHUFVfR0VNX0NSRUFU
RV9QUkVFTVBUSUJMRSB8IGZsYWdzLAorCQkJQU1ER1BVX0dFTV9ET01BSU5fQ1BVLCBBTURH
UFVfR0VNX0RPTUFJTl9DUFUsIEFNREdQVV9HRU1fQ1JFQVRFX1BSRUVNUFRJQkxFIHwgZmxh
Z3MsCiAJCQl0dG1fYm9fdHlwZV9zZywgbWVtLT5iby0+dGJvLmJhc2UucmVzdiwgJmdlbV9v
YmosIDApOwogCiAJYW1kZ3B1X2JvX3VucmVzZXJ2ZShtZW0tPmJvKTsKQEAgLTE4MTUsNyAr
MTgxNSw3IEBACiAJCSB2YSwgKCptZW0pLT5hcWxfcXVldWUgPyBzaXplIDw8IDEgOiBzaXpl
LAogCQkgZG9tYWluX3N0cmluZyhhbGxvY19kb21haW4pLCB4Y3BfaWQpOwogCi0JcmV0ID0g
YW1kZ3B1X2dlbV9vYmplY3RfY3JlYXRlKGFkZXYsIGFsaWduZWRfc2l6ZSwgMSwgYWxsb2Nf
ZG9tYWluLCBhbGxvY19mbGFncywKKwlyZXQgPSBhbWRncHVfZ2VtX29iamVjdF9jcmVhdGUo
YWRldiwgYWxpZ25lZF9zaXplLCAxLCBhbGxvY19kb21haW4sIGFsbG9jX2RvbWFpbiwgYWxs
b2NfZmxhZ3MsCiAJCQkJICAgICAgIGJvX3R5cGUsIE5VTEwsICZnb2JqLCB4Y3BfaWQgKyAx
KTsKIAlpZiAocmV0KSB7CiAJCXByX2RlYnVnKCJGYWlsZWQgdG8gY3JlYXRlIEJPIG9uIGRv
bWFpbiAlcy4gcmV0ICVkXG4iLAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfZG1hX2J1Zi5jCTIwMjUtMDMtMjAgMjI6MzE6MzguNzcwNjAzMzM1ICswMTAwCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kbWFfYnVmLmMJMjAyNS0w
My0yMCAyMjozMTo1MS44NjY1MDk1MDIgKzAxMDAKQEAgLTMwOCw3ICszMDgsNyBAQAogCX0K
IAogCXJldCA9IGFtZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZShhZGV2LCBkbWFfYnVmLT5zaXpl
LCBQQUdFX1NJWkUsCi0JCQkJICAgICAgIEFNREdQVV9HRU1fRE9NQUlOX0NQVSwgZmxhZ3Ms
CisJCQkJICAgICAgIEFNREdQVV9HRU1fRE9NQUlOX0NQVSwgQU1ER1BVX0dFTV9ET01BSU5f
Q1BVLCBmbGFncywKIAkJCQkgICAgICAgdHRtX2JvX3R5cGVfc2csIHJlc3YsICZnb2JqLCAw
KTsKIAlpZiAocmV0KQogCQlnb3RvIGVycm9yOwo=

--------------Y0C7VwRAfMVrona43ZUvI0dB--
