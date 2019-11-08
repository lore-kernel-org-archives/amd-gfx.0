Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5A5FC6197
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 21:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB0792084D
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 21:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB0792084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A05326E0D7;
	Fri,  8 Nov 2019 21:28:55 +0000 (UTC)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB8496E0D7
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 21:28:53 +0000 (UTC)
Received: by mail-il1-x144.google.com with SMTP id i6so6375069ilr.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Nov 2019 13:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2k+7Fl0vaHFInv44bNbAM4R79JQ9PeS0EnLI96nC+l8=;
 b=JXG8BCJ4gKwQgj3Bdf30GXdeqxX0N10XcSz/0vnS2nhzqBeRGmniLtCrZOjeaPqRIx
 nf6/sTXYXkEuLee2JIiU61+Ybt7B808HzU/Ux8y/1UfbgCT7DZY9wsSdiuvxZ3YF4nTR
 lOrHPvi91dImCOoJhyK+jjKynIxo4u5dSbWrMIy2zCwJ3liwtEs9a2YR80nBPYJftnCF
 GilaH6oimvzOAMeZb2kxA6XhH+ikYgrB3v7vSpYwINMrQONZM+VKReMZwuxw0PInaBra
 pcrHpfQtyPQkH0Ru0OA2vUXKFm5BZQRYZ+NxHaFiSn4o/WsEp1tlIUyLqN/BtmF7pLW7
 dT+A==
X-Gm-Message-State: APjAAAX+rAwuhZuFwi3xX7tmMgiEV1E5aRpV5552fvOb10EzSl1d8JAV
 QURSKBAK3EpJAHVtYM/GkCKkiydIwRhY2w==
X-Google-Smtp-Source: APXvYqySOXLn/Vz03VSsSwNu0Kk2SdVj/IsrQzAnkMStVMfH3f3wyTQOWA3leCQ/P8oiHwN8TQOFKA==
X-Received: by 2002:a92:5e49:: with SMTP id s70mr16061635ilb.130.1573248533178; 
 Fri, 08 Nov 2019 13:28:53 -0800 (PST)
Received: from localhost.localdomain ([2602:47:da84:5600:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id
 g11sm961732ilq.39.2019.11.08.13.28.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 13:28:52 -0800 (PST)
From: Matt Coffin <mcoffin13@gmail.com>
To: amd-gfx@lists.freedesktop.org,
	Evan.Quan@amd.com
Subject: [PATCH v2 2/3] drm/amdgpu/navi10: implement GFXCLK_CURVE overdrive
Date: Fri,  8 Nov 2019 14:28:07 -0700
Message-Id:
 <2f55627b8f739cf183c5cbc91ac19fcd5b5c924a.1573248368.git.mcoffin13@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1573248368.git.mcoffin13@gmail.com>
References: <cover.1573248368.git.mcoffin13@gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2k+7Fl0vaHFInv44bNbAM4R79JQ9PeS0EnLI96nC+l8=;
 b=VHD4XM5G5KHvQ+1N1/9pN/HNpzZMXYNQpsIxH6DjdC5EH2DdMKe/DCtWuTkkfappFB
 RerNuBH35k1G2wIR8ay8TOLjdVxguvIq3SFWBm/dp5GYtMoT1SPVbARs28k7YSw2oe13
 8uLsCtfvA+GRH9FzjGw6ZQ9HbgzEeeH6X2n7TlmG+qheIxNMHzyKt/rh4Voxw8fo5eTu
 yUPmjDpa9ulSBR7CeNDAHyIsr7PZwYXG/ZlWMlhws4MZOipDAEyi7bT8UnVMKSNFzxWv
 fxIITS2JYultAgRNte/GqEVWJOJ9eiPcQ/toQnBeeoPHVxcQOtaiHfuCE56upxx2YIt/
 B4Lw==
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
Cc: Alexander.Deucher@amd.com, Matt Coffin <mcoffin13@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191108212807.0gRnNoM0m0B10OhMEtquTjpADxUzl88OqK54QXGBoWE@z>

W1doeV0KQmVmb3JlIHRoaXMgcGF0Y2gsIHRoZXJlIHdhcyBubyB3YXkgdG8gc2V0IHRoZSBnZnhj
bGsgdm9sdGFnZSBjdXJ2ZSBpbgp0aGUgb3ZlcmRyaXZlIHNldHRpbmdzIGZvciBuYXZpMTAgdGhy
b3VnaCBwcF9vZF9jbGtfdm9sdGFnZQoKW0hvd10KQWRkIHRoZSByZXF1aXJlZCBpbXBsZW1lbnRh
dGlvbiB0byBuYXZpMTAncyBwcHQgZHBtIHRhYmxlIGVkaXRpbmcKaW1wbGVtZW50YXRpb24sIHNp
bWlsYXIgdG8gdGhlIHZlZ2EyMCBpbXBsZW1lbnRhdGlvbiBhbmQgaW50ZXJmYWNlLgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuYyB8IDYwICsrKysrKysrKysr
KysrKysrKysrKy0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuaCB8
ICAyICsKIDIgZmlsZXMgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9uYXZpMTBfcHB0LmMKaW5kZXggMzU0ZjYz
MTAzMzA4Li4zZTI2YzAzZDVlZWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93
ZXJwbGF5L25hdmkxMF9wcHQuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9u
YXZpMTBfcHB0LmMKQEAgLTE3MjgsNiArMTcyOCw4IEBAIHN0YXRpYyBpbnQgbmF2aTEwX29kX2Vk
aXRfZHBtX3RhYmxlKHN0cnVjdCBzbXVfY29udGV4dCAqc211LCBlbnVtIFBQX09EX0RQTV9UQUJM
CiAJc3RydWN0IHNtdV90YWJsZV9jb250ZXh0ICp0YWJsZV9jb250ZXh0ID0gJnNtdS0+c211X3Rh
YmxlOwogCU92ZXJEcml2ZVRhYmxlX3QgKm9kX3RhYmxlOwogCXN0cnVjdCBzbXVfMTFfMF9vdmVy
ZHJpdmVfdGFibGUgKm9kX3NldHRpbmdzOworCWVudW0gU01VXzExXzBfT0RTRVRUSU5HX0lEIGZy
ZXFfc2V0dGluZywgdm9sdGFnZV9zZXR0aW5nOworCXVpbnQxNl90ICpmcmVxX3B0ciwgKnZvbHRh
Z2VfcHRyOwogCW9kX3RhYmxlID0gKE92ZXJEcml2ZVRhYmxlX3QgKil0YWJsZV9jb250ZXh0LT5v
dmVyZHJpdmVfdGFibGU7CiAKIAlpZiAoIXNtdS0+b2RfZW5hYmxlZCkgewpAQCAtMTgyNCw4ICsx
ODI2LDYyIEBAIHN0YXRpYyBpbnQgbmF2aTEwX29kX2VkaXRfZHBtX3RhYmxlKHN0cnVjdCBzbXVf
Y29udGV4dCAqc211LCBlbnVtIFBQX09EX0RQTV9UQUJMCiAJCX0KIAkJYnJlYWs7CiAJY2FzZSBQ
UF9PRF9FRElUX1ZERENfQ1VSVkU6Ci0JCS8vIFRPRE86IGltcGxlbWVudAotCQlyZXR1cm4gLUVO
T1NZUzsKKwkJaWYgKCFuYXZpMTBfb2RfZmVhdHVyZV9pc19zdXBwb3J0ZWQob2Rfc2V0dGluZ3Ms
IFNNVV8xMV8wX09ERkVBVFVSRV9HRlhDTEtfQ1VSVkUpKSB7CisJCQlwcl93YXJuKCJHRlhDTEtf
Q1VSVkUgbm90IHN1cHBvcnRlZCFcbiIpOworCQkJcmV0dXJuIC1FTk9UU1VQUDsKKwkJfQorCQlp
ZiAoc2l6ZSA8IDMpIHsKKwkJCXByX2luZm8oImludmFsaWQgbnVtYmVyIG9mIHBhcmFtZXRlcnM6
ICVkXG4iLCBzaXplKTsKKwkJCXJldHVybiAtRUlOVkFMOworCQl9CisJCWlmICghb2RfdGFibGUp
IHsKKwkJCXByX2luZm8oIk92ZXJkcml2ZSBpcyBub3QgaW5pdGlhbGl6ZWRcbiIpOworCQkJcmV0
dXJuIC1FSU5WQUw7CisJCX0KKworCQlzd2l0Y2ggKGlucHV0WzBdKSB7CisJCWNhc2UgMDoKKwkJ
CWZyZXFfc2V0dGluZyA9IFNNVV8xMV8wX09EU0VUVElOR19WRERHRlhDVVJWRUZSRVFfUDE7CisJ
CQl2b2x0YWdlX3NldHRpbmcgPSBTTVVfMTFfMF9PRFNFVFRJTkdfVkRER0ZYQ1VSVkVWT0xUQUdF
X1AxOworCQkJZnJlcV9wdHIgPSAmb2RfdGFibGUtPkdmeGNsa0ZyZXExOworCQkJdm9sdGFnZV9w
dHIgPSAmb2RfdGFibGUtPkdmeGNsa1ZvbHQxOworCQkJYnJlYWs7CisJCWNhc2UgMToKKwkJCWZy
ZXFfc2V0dGluZyA9IFNNVV8xMV8wX09EU0VUVElOR19WRERHRlhDVVJWRUZSRVFfUDI7CisJCQl2
b2x0YWdlX3NldHRpbmcgPSBTTVVfMTFfMF9PRFNFVFRJTkdfVkRER0ZYQ1VSVkVWT0xUQUdFX1Ay
OworCQkJZnJlcV9wdHIgPSAmb2RfdGFibGUtPkdmeGNsa0ZyZXEyOworCQkJdm9sdGFnZV9wdHIg
PSAmb2RfdGFibGUtPkdmeGNsa1ZvbHQyOworCQkJYnJlYWs7CisJCWNhc2UgMjoKKwkJCWZyZXFf
c2V0dGluZyA9IFNNVV8xMV8wX09EU0VUVElOR19WRERHRlhDVVJWRUZSRVFfUDM7CisJCQl2b2x0
YWdlX3NldHRpbmcgPSBTTVVfMTFfMF9PRFNFVFRJTkdfVkRER0ZYQ1VSVkVWT0xUQUdFX1AzOwor
CQkJZnJlcV9wdHIgPSAmb2RfdGFibGUtPkdmeGNsa0ZyZXEzOworCQkJdm9sdGFnZV9wdHIgPSAm
b2RfdGFibGUtPkdmeGNsa1ZvbHQzOworCQkJYnJlYWs7CisJCWRlZmF1bHQ6CisJCQlwcl9pbmZv
KCJJbnZhbGlkIFZERENfQ1VSVkUgaW5kZXg6ICVsZFxuIiwgaW5wdXRbMF0pOworCQkJcHJfaW5m
bygiU3VwcG9ydGVkIGluZGljZXM6IFswLCAxLCAyXVxuIik7CisJCQlyZXR1cm4gLUVJTlZBTDsK
KwkJfQorCQlyZXQgPSBuYXZpMTBfb2Rfc2V0dGluZ19jaGVja19yYW5nZShvZF9zZXR0aW5ncywg
ZnJlcV9zZXR0aW5nLCBpbnB1dFsxXSk7CisJCWlmIChyZXQpCisJCQlyZXR1cm4gcmV0OworCQkv
LyBBbGxvdyBzZXR0aW5nIHplcm8gdG8gZGlzYWJsZSB0aGUgT3ZlckRyaXZlIFZEREMgY3VydmUK
KwkJaWYgKGlucHV0WzJdICE9IDApIHsKKwkJCXJldCA9IG5hdmkxMF9vZF9zZXR0aW5nX2NoZWNr
X3JhbmdlKG9kX3NldHRpbmdzLCB2b2x0YWdlX3NldHRpbmcsIGlucHV0WzJdKTsKKwkJCWlmIChy
ZXQpCisJCQkJcmV0dXJuIHJldDsKKwkJCSpmcmVxX3B0ciA9IGlucHV0WzFdOworCQkJKnZvbHRh
Z2VfcHRyID0gKCh1aW50MTZfdClpbnB1dFsyXSkgKiBOQVZJMTBfVk9MVEFHRV9TQ0FMRTsKKwkJ
CXByX2RlYnVnKCJPRDogc2V0IGN1cnZlICVsZDogKCVkLCAlZClcbiIsIGlucHV0WzBdLCAqZnJl
cV9wdHIsICp2b2x0YWdlX3B0cik7CisJCX0gZWxzZSB7CisJCQkvLyBJZiBzZXR0aW5nIDAsIGRp
c2FibGUgYWxsIHZvbHRhZ2UgY3VydmUgc2V0dGluZ3MKKwkJCW9kX3RhYmxlLT5HZnhjbGtWb2x0
MSA9IDA7CisJCQlvZF90YWJsZS0+R2Z4Y2xrVm9sdDIgPSAwOworCQkJb2RfdGFibGUtPkdmeGNs
a1ZvbHQzID0gMDsKKwkJfQorCQluYXZpMTBfZHVtcF9vZF90YWJsZShvZF90YWJsZSk7CisJCWJy
ZWFrOwogCWRlZmF1bHQ6CiAJCXJldHVybiAtRU5PU1lTOwogCX0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuaCBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuaAppbmRleCBhMzdlMzdjNWYxMDUuLmZkNmRkYTFhNjdh
MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvbmF2aTEwX3BwdC5o
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L25hdmkxMF9wcHQuaApAQCAtMzMs
NiArMzMsOCBAQAogI2RlZmluZSBOQVZJMTRfVU1EX1BTVEFURV9QRUFLX1hUWF9HRlhDTEsgICAg
ICgxNzE3KQogI2RlZmluZSBOQVZJMTRfVU1EX1BTVEFURV9QRUFLX1hMX0dGWENMSyAgICAgICgx
NDQ4KQogCisjZGVmaW5lIE5BVkkxMF9WT0xUQUdFX1NDQUxFICg0KQorCiBleHRlcm4gdm9pZCBu
YXZpMTBfc2V0X3BwdF9mdW5jcyhzdHJ1Y3Qgc211X2NvbnRleHQgKnNtdSk7CiAKICNlbmRpZgot
LSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
