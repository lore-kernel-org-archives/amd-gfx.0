Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0ADC36011
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 08:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3665810E518;
	Tue, 25 Mar 2025 08:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.at header.i=h.judt@gmx.at header.b="uQtGkeki";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD61010E500
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 08:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.at;
 s=s31663417; t=1742889895; x=1743494695; i=h.judt@gmx.at;
 bh=aGSh8O7kkwrWcs3jwN4L7vZ/zAoA8bxUdC6omdGbNWw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
 Cc:Content-Type:cc:content-transfer-encoding:content-type:date:
 from:message-id:mime-version:reply-to:subject:to;
 b=uQtGkekiHwrpDotMcTDfTm0vMeLVduUESm8eRYEdBH2mvbaeyeHkX3w5q2jZu4IQ
 +nF69T6aldTooM4giOW7g2eyUXZVT7W6QzWGLtcs/DQApRq6COXNI9KqYTa+fuKdf
 VMnhEtjSmWji1ELY18RpS8bt/RPdHcfBZe69TTr33auyAkZS+7rTPJ74BeZ2fkflR
 p2qJuHqBIIYWoLA4MgGzq0OwyUz6pypUbllQKEbLxrnLAIMKUYbIB0bPMV9EcPKIC
 7tq9E244EWeaafBh5tH3pYA+FoPNeMlFyMtvf1aRdPz8lb4bn7gLHcZpONkJKOze2
 SP8OKOC52Uk9IGv6CQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.100] ([80.108.251.54]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTRR0-1tZnaN0T88-00VC3w; Tue, 25
 Mar 2025 09:04:55 +0100
Message-ID: <314e8563-82c6-4702-bd3a-bdc2200adfcd@gmx.at>
Date: Tue, 25 Mar 2025 09:04:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Harald Judt <h.judt@gmx.at>
Subject: [PATCH] amdgpu: Do not trigger reset_method S3 workaround for S4
To: amd-gfx@lists.freedesktop.org
Cc: Harald Judt <h.judt@gmx.at>
Content-Language: de-AT
Autocrypt: addr=h.judt@gmx.at; keydata=
 xjMEWz9DYxYJKwYBBAHaRw8BAQdAKS36MI1JSuMxtk7tkZ2/NK1C9te1XJ8bBlB9qF4blEbN
 G0hhcmFsZCBKdWR0IDxoLmp1ZHRAZ214LmF0PsKWBBMWCAA+AhsDBQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAFiEE4HNt2P9AnPIGZRHUT/+rIbhYCr0FAmStFG8FCRLT0owACgkQT/+rIbhY
 Cr1dYwEAsT/9SLGebsLz4TIuYaDY7c4ou+i7Stae6FIb62NXw7UBAPopYK3pJuyjhvK8qb3N
 FQeZyDrHeJLvOWEoj5OYsLIIzjgEWz9DYxIKKwYBBAGXVQEFAQEHQA7/uzYBE88LdCm19AaX
 q46nMKkhxM5CZ2YAa1uC5l97AwEIB8J+BBgWCAAmAhsMFiEE4HNt2P9AnPIGZRHUT/+rIbhY
 Cr0FAmStFMkFCRLT0uYACgkQT/+rIbhYCr12kAD9HnfrVNMxwa8LWtpKCiv4+zk1ujthlZZm
 G75GoPWofXEBAMQ8kqpJDk2/DH4qT0ZneIT5SnQPt5ZtAFtpX6XOa0oB
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xVKYPWLja5uHZ0krW5Zm0bpF"
X-Provags-ID: V03:K1:vHY42m5vQkzbUQqhVzqHd0WS/O3G5I9xHq9CMzBqJwsDijqbVs/
 GBsKfNsUFZ3BHUiDpOkgN2jhctybdwcBx9lbvLKQskLG8Ny32zn4RQjkeybvcAdAOcZ4wcP
 fxB1VO1oB1p5xzMvuF1MT1NU7XO5TguiSzmKzImcnwr5b4hRpzf+uEP+SnNWKDihZZT94VE
 hnpfanecJYCfmABmvZhlQ==
UI-OutboundReport: notjunk:1;M01:P0:LGtreQ4jFy4=;Tx235HCR0jDyXhpwkuQv9IbKVfy
 XLtncbiXcq6WHGLEM/oU9Yh3r8rt7LEmO75ZGT+6wff3WBDefyo0jAIRSak8UW1S+f468RIgW
 0FePHmX470dTb7BRzyJQQ9H4tzwBMGkr/xpoNZu97AaeDzgy+DwZlkli70/2WEyCc6C+Z5C4a
 j2XyB4u9IQiW2iv/d4ur6aAfJqT3+AYHvvJTUjuwzmDSNANjwEFkYPGGEf0BMvKjG3WgCpjnr
 J7rIHDmMVyaAO+2urKf4NCjFiavb7AKRhV3p9wbVVjpdqjWh9QeAgAwAloTDDhtwtZH7S+KWa
 fRB7hrzJWH3w/nPXxsWz66G2JkDG9kE0eFhTKYFn7ShlXz4oPsQK65rUVYltQFSQlRMwo4FWL
 LMaBfcAA1XXmxl+vrW7lO8MYavuTUvA3HAQSEYoS0IpungDTONpPuT/3HoNgtvjoI7qZffGK0
 S+aZLhr1f78Zalap1UVK8yiMGl6+SLpUtOgr92p5d9ioX1+h/zVCi1Eq/B2J4M/3NPg5pW+t3
 0Gopqtp3K+bSPq3MP8acFsfXTjjj7FSUfnwdnB4LtValA4qSRoIaitFilef2qm/6jddrNAcXA
 0xnarzHxE4CXG+aXCHqUqfrykJFTTNqrPXYSFFH6iWt2Q76OXLcmTgHdDU5s0nurJUhUAlH0k
 kpKZEfnTQvya9jt1xqBuMXyXOL2fX8mc8Au2qj/5xbjO28QJBMUf9211mjhbJj7QBwq9PCZay
 1iooa66oWxOryJValQbvo8GiSHsZSvdquvOBXi2yIUNG394YSwvBBUHyaHrk7c34ZW1hNbI38
 8elhI+UGQ/UboohHa/UB8mnbrWvw3uLRwDCq73ALyknsaKbfcoI5wF7G3G28btcfot+upqL5x
 v5x8/ptx52ehTjEsnsOpQnt+1qKUlhv5Kl+mnRXSyxL0LlFpH7cgmIVgp5lsI/58A5w9DBAp6
 E9Hmu4G6aC1lL2lMyW6Ap9UD5XNXXvcZflRoH7svis/CPcQr+hjz0QtjuCRJHadlSL+Kp5jCu
 zAisku7W+xWntEQjqKX9zq46cfOaF4qsKMsq1El4cFc//T4z0kOp9EcHqAWdZonoiCHC5tmrB
 TBPUhS5r0N68MuN/9Qld6drxgpVxiXxCV8cYncbUWrL6Eo4KrPTFKUli1IvwZ586X200KPIMh
 WNWDVRXuwmsrT2+5pT/dwrWlKqdP8lE3YWin62pUAmdSScYcXZQmbK9tZhYRUoMpSPukHwezd
 xo3eGjAXJkQvRmYwmHk05pAoMP6hMXSUUUc+3LWaKCX/xcUaIIEuzjD4boavVJ1wVuV/iXdde
 swiKSJEgw/CnjoQoKM1H9GavlNCSjNoPw1OnPetO0f0oLW6KQt/gLVEdLWMi2U9rwUQ+Ykdlq
 Ooe3O3gDc0tHmrMFntgDPZHZXtWt29DAbtvJVuzoGidE2SML61ioR4hdGk32KDTBQDB/ZBqeL
 RoXItndOgNUIOpVAFwlFbPpr6r/Lave22wfca9+Te2x/xgXsN
X-Mailman-Approved-At: Tue, 25 Mar 2025 08:21:39 +0000
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xVKYPWLja5uHZ0krW5Zm0bpF
Content-Type: multipart/mixed; boundary="------------yCZZYmgNnlpWewsMVHsNdl18";
 protected-headers="v1"
From: Harald Judt <h.judt@gmx.at>
To: amd-gfx@lists.freedesktop.org
Cc: Harald Judt <h.judt@gmx.at>
Message-ID: <314e8563-82c6-4702-bd3a-bdc2200adfcd@gmx.at>
Subject: [PATCH] amdgpu: Do not trigger reset_method S3 workaround for S4

--------------yCZZYmgNnlpWewsMVHsNdl18
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

IEZyb20gOWEyZjE2YTRhNDNmNDI0ZjUwMDhkNWM0YTg3ZTEzMjlmNjgyZTkxOSBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDENCkZyb206IEhhcmFsZCBKdWR0IDxoLmp1ZHRAZ214LmF0Pg0K
RGF0ZTogU2F0LCAyMiBNYXIgMjAyNSAyMzowMTo1NyArMDEwMA0KU3ViamVjdDogW1BBVENI
XSBhbWRncHU6IERvIG5vdCB0cmlnZ2VyIHJlc2V0X21ldGhvZCBTMyB3b3JrYXJvdW5kIGZv
ciBTNA0KDQpDb21taXQgM2E5NjI2YzgxNmRiICgiZHJtL2FtZDogU3RvcCBldmljdGluZyBy
ZXNvdXJjZXMgb24gQVBVcyBpbiBzdXNwZW5kIikNCmNhdXNlcyBoaWJlcm5hdGlvbiB0byBm
YWlsIG9uIFIzOTAgYmVjYXVzZSBpdCB0cmlnZ2VycyBhIHdvcmthcm91bmQgZm9yIFMzIGlu
DQphbWRncHVfZHBtX2lzX2JhY29fc3VwcG9ydGVkIHRoYXQgZGlzYWJsZXMgQkFDTy4gV2l0
aCByZXNldF9tZXRob2QgUENJIENPTkZJRywNClMzIHdvcmtzIGJ1dCBTNCBmYWlscyBvbiBy
ZXN1bWUuIFRoaXMgY29tbWl0IGZpeGVzIHRoaXMgYnkgbW9kaWZ5aW5nIHRoZQ0Kd29ya2Fy
b3VuZCB0byBvbmx5IGFwcGx5IGZvciBTMyBhbmQgbm90IFM0Lg0KDQpDbG9zZXM6IGh0dHBz
Oi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0vaXNzdWVzLzM2MzQNClNpZ25l
ZC1vZmYtYnk6IEhhcmFsZCBKdWR0IDxoLmp1ZHRAZ214LmF0Pg0KLS0tDQogICBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgfCAxMCArKysrKystLS0tDQogICBk
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYyAgICAgfCAgMiArLQ0KICAgMiBm
aWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZHJ2LmMgDQpiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kcnYuYw0KaW5kZXggOTFhODc0YmIw
ZTI0Li4wNWFjMTNmMWFhNmEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZHJ2LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kcnYuYw0KQEAgLTI1NTYsMTMgKzI1NTYsMTUgQEAgc3RhdGljIGludCBhbWRncHVf
cG1vcHNfZnJlZXplKHN0cnVjdCBkZXZpY2UgKmRldikNCg0KICAgCWFkZXYtPmluX3M0ID0g
dHJ1ZTsNCiAgIAlyID0gYW1kZ3B1X2RldmljZV9zdXNwZW5kKGRybV9kZXYsIHRydWUpOw0K
LQlhZGV2LT5pbl9zNCA9IGZhbHNlOw0KICAgCWlmIChyKQ0KLQkJcmV0dXJuIHI7DQorCQln
b3RvIG91dDsNCg0KICAgCWlmIChhbWRncHVfYWNwaV9zaG91bGRfZ3B1X3Jlc2V0KGFkZXYp
KQ0KLQkJcmV0dXJuIGFtZGdwdV9hc2ljX3Jlc2V0KGFkZXYpOw0KLQlyZXR1cm4gMDsNCisJ
CXIgPSBhbWRncHVfYXNpY19yZXNldChhZGV2KTsNCisNCitvdXQ6DQorCWFkZXYtPmluX3M0
ID0gZmFsc2U7DQorCXJldHVybiByOw0KICAgfQ0KDQogICBzdGF0aWMgaW50IGFtZGdwdV9w
bW9wc190aGF3KHN0cnVjdCBkZXZpY2UgKmRldikNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3BtL2FtZGdwdV9kcG0uYyANCmIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9h
bWRncHVfZHBtLmMNCmluZGV4IDlkYzgyZjRkN2M5My4uMWE4NjI0YjJmMzg4IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfZHBtLmMNCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X2RwbS5jDQpAQCAtMjIwLDcgKzIyMCw3IEBAIGlu
dCBhbWRncHVfZHBtX2lzX2JhY29fc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2KQ0KICAgCSAqIFBvd2VyaW5nIGRvd24vdXAgZXZlcnl0aGluZyBtYXkgYWR2ZXJzZWx5
IGFmZmVjdCB0aGVzZSBvdGhlcg0KICAgCSAqIGRldmljZXMuICBOZWVkcyBtb3JlIGludmVz
dGlnYXRpb24uDQogICAJICovDQotCWlmIChhZGV2LT5pbl9zMykNCisJaWYgKGFkZXYtPmlu
X3MzICYmICFhZGV2LT5pbl9zNCkNCiAgIAkJcmV0dXJuIDA7DQoNCiAgIAltdXRleF9sb2Nr
KCZhZGV2LT5wbS5tdXRleCk7DQotLSANCjIuNDkuMA0KDQoNCi0tIA0KYEV4cGVyaWVuY2Ug
aXMgdGhlIGJlc3QgdGVhY2hlci4nDQoNClBHUCBLZXkgSUQ6IDRGRkZBQjIxQjg1ODBBQkQN
CkZpbmdlcnByaW50OiBFMDczIDZERDggRkY0MCA5Q0YyIDA2NjUgMTFENCA0RkZGIEFCMjEg
Qjg1OCAwQUJEDQoNCg==

--------------yCZZYmgNnlpWewsMVHsNdl18--

--------------xVKYPWLja5uHZ0krW5Zm0bpF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTgc23Y/0Cc8gZlEdRP/6shuFgKvQUCZ+JjpgAKCRBP/6shuFgK
vbHxAQCddcwsIyGEp7aBj9FSZb5MsnFQSEBjZ+E4nbUbjWUFzAEAl/xmYBpv8omD
SOt9XedD1ZsyxTquLz0IuwLjaXrCXQ0=
=WBfA
-----END PGP SIGNATURE-----

--------------xVKYPWLja5uHZ0krW5Zm0bpF--
