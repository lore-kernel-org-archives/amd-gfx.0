Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82DEC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9562720787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8Tn3IZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9562720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37CD36ECE9;
	Thu, 16 Jul 2020 21:23:25 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F576ECF6
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:23 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id b6so8601150wrs.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pSTzc7Ydxf/R7f17glUom9EWnVscCOVB2Tc/H4N0yGo=;
 b=V8Tn3IZ33M4QVTLW7OXJXpxNrQWAaXzxdIC9XM4r9Kb/ofvtf/zDXNqszvAaV2Ijc2
 KE/axcAgfWNelVz3JZTsxz+2tAgBFuuHFo0D+sTJwUDtryejJ4xir+e8BAHRN/GaTGqH
 jsi73d1xSDYRHQkp+PY4nFIW6lIF2nLr2uVtTnnLxLD+qJGvzxOhLYxBe/tSc2KqHLkV
 5Z/COl+3M/KwU5JEzVtRL9JkB20VDTQWoSSfa64lGotle2crgPCUbGOoVGZGFxppRf3w
 MYiXhW9MM1gJVEMozwGyyl0Z1BQwyTb9vRDowvPTlbxNb4j8Yk81EuApAJ+8VTk7I90j
 4GJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pSTzc7Ydxf/R7f17glUom9EWnVscCOVB2Tc/H4N0yGo=;
 b=AghnbIuYfTFnPjaYnNq9YlggLUApmlGtsA/Y0MfUH2Z/2NnvIVteeDHM/Edl5XObZY
 jI8Kj5wx8qRwjBZ3o2fq1E33N2IEymcmsYFfoKJgIwJM9OmcddFZRBh2nA/kxhuMsYAx
 ga12QRm4fooeB5WmjQ/VazooqTZ7j4o38r/eE0hjhpkz2iNsAfIRNrA/JQXpqjpU3Kr9
 MpHVeuBMC0gfn30NH2veuZKlWMrvXBlosZ92jMb9VtuFLZeBpDe4HXyg+OEQ9o87iPnz
 BQdFLiMvj14vGMlnjAfBXGFePiGn4rtLCMX7e7fCvferk6BPLYoTH9oOLN7R0mxQ6Mfl
 UQOw==
X-Gm-Message-State: AOAM533b6EC5Dw7C+ffkmR6l3vbuzbfO2NFfEFOzRm40yQVXMklNU2HO
 3suWJ2w/auL29ASvma68B8IMU3K37E0=
X-Google-Smtp-Source: ABdhPJzrR6E/M9eyqEgKQUN9hHB0YwmlvB/PrMce8aqBVpsOwEiJQIhGqq24Z+TqfZzr+KYSrqDoVw==
X-Received: by 2002:adf:dc90:: with SMTP id r16mr6862733wrj.264.1594934601472; 
 Thu, 16 Jul 2020 14:23:21 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:21 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 13/27] drm/amd/display: dce_hwseq: add DCE6 specific macros,
 functions
Date: Thu, 16 Jul 2020 23:22:37 +0200
Message-Id: <20200716212251.1539094-14-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1doeV0KRENFNiBoYXMgbm8gQkxORF9DT05UUk9MwqByZWdpc3RlciBmb3IgQmxlbmRlciBIVyBw
cm9ncmFtbWluZwpEQ0U2IGhhcyBub8KgQkxORF9WX1VQREFURV9MT0NLwqByZWdpc3RlciBmb3Ig
UGlwZSBMb2NraW5nCgpbSG93XQpBZGQgRENFNiBzcGVjaWZpYyBtYWNyb3MgZGVmaW5pdGlvbnMg
Zm9yIEhXU0VRIHJlZ2lzdGVycyBhbmQgbWFza3MKRENFNiBIV1NFUSBtYWNyb3Mgd2lsbCBhdm9p
ZCBidWlkaW5nIGVycm9ycyB3aGVuIHVzaW5nIERDRTYgaGVhZGVycwpBZGQgZGNlNjBfcGlwZV9j
b250cm9sX2xvY2soKSBzdHViIHdpdGggbm8gb3AKClNpZ25lZC1vZmYtYnk6IE1hdXJvIFJvc3Np
IDxpc3Nvci5vcnVhbUBnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjZS9kY2VfaHdzZXEuYyB8ICA5ICsrKysrKysrKwogZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjZS9kY2VfaHdzZXEuaCB8IDE4ICsrKysrKysrKysrKysrKysrKwogMiBmaWxl
cyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfaHdzZXEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY2UvZGNlX2h3c2VxLmMKaW5kZXggZTFjNTgzOWE4MGRjLi40MjAyZmFkYjJjMGUg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2h3c2Vx
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfaHdzZXEuYwpA
QCAtODUsNiArODUsMTUgQEAgdm9pZCBkY2VfcGlwZV9jb250cm9sX2xvY2soc3RydWN0IGRjICpk
YywKIAl9CiB9CiAKKyNpZiBkZWZpbmVkKENPTkZJR19EUk1fQU1EX0RDX1NJKQordm9pZCBkY2U2
MF9waXBlX2NvbnRyb2xfbG9jayhzdHJ1Y3QgZGMgKmRjLAorCQlzdHJ1Y3QgcGlwZV9jdHggKnBp
cGUsCisJCWJvb2wgbG9jaykKK3sKKwkvKiBEQ0U2IGhhcyBub8KgQkxORF9WX1VQREFURV9MT0NL
wqByZWdpc3RlcsKgKi8KK30KKyNlbmRpZgorCiB2b2lkIGRjZV9zZXRfYmxlbmRlcl9tb2RlKHN0
cnVjdCBkY2VfaHdzZXEgKmh3cywKIAl1bnNpZ25lZCBpbnQgYmxuZF9pbnN0LAogCWVudW0gYmxu
ZF9tb2RlIG1vZGUpCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
ZGNlL2RjZV9od3NlcS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2Vf
aHdzZXEuaAppbmRleCA2NmI4OGQ2YmEzOTguLjcwYmJjMTMxMTMyNyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfaHdzZXEuaAorKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9od3NlcS5oCkBAIC0xMTAsNiArMTEwLDEy
IEBACiAJU1IoQkxORFZfQ09OVFJPTCksXAogCUhXU0VRX1BJWEVMX1JBVEVfUkVHX0xJU1QoQ1JU
QykKIAorI2lmIGRlZmluZWQoQ09ORklHX0RSTV9BTURfRENfU0kpCisjZGVmaW5lIEhXU0VRX0RD
RTZfUkVHX0xJU1QoKSBcCisJSFdTRVFfRENFRl9SRUdfTElTVF9EQ0U4KCksIFwKKwlIV1NFUV9Q
SVhFTF9SQVRFX1JFR19MSVNUKENSVEMpCisjZW5kaWYKKwogI2RlZmluZSBIV1NFUV9EQ0U4X1JF
R19MSVNUKCkgXAogCUhXU0VRX0RDRUZfUkVHX0xJU1RfRENFOCgpLCBcCiAJSFdTRVFfQkxORF9S
RUdfTElTVCgpLCBcCkBAIC00ODgsNiArNDk0LDEyIEBAIHN0cnVjdCBkY2VfaHdzZXFfcmVnaXN0
ZXJzIHsKIAlIV1NfU0YxKGJsaywgUEhZUExMX1BJWEVMX1JBVEVfQ05UTCwgUEhZUExMX1BJWEVM
X1JBVEVfU09VUkNFLCBtYXNrX3NoKSxcCiAJSFdTX1NGMShibGssIFBIWVBMTF9QSVhFTF9SQVRF
X0NOVEwsIFBJWEVMX1JBVEVfUExMX1NPVVJDRSwgbWFza19zaCkKIAorI2lmIGRlZmluZWQoQ09O
RklHX0RSTV9BTURfRENfU0kpCisjZGVmaW5lIEhXU0VRX0RDRTZfTUFTS19TSF9MSVNUKG1hc2tf
c2gpXAorCS5EQ0ZFX0NMT0NLX0VOQUJMRSA9IENSVENfRENGRV9DTE9DS19DT05UUk9MX19DUlRD
X0RDRkVfQ0xPQ0tfRU5BQkxFICMjIG1hc2tfc2gsIFwKKwlIV1NFUV9QSVhFTF9SQVRFX01BU0tf
U0hfTElTVChtYXNrX3NoLCBDUlRDMF8pCisjZW5kaWYKKwogI2RlZmluZSBIV1NFUV9EQ0U4X01B
U0tfU0hfTElTVChtYXNrX3NoKVwKIAkuRENGRV9DTE9DS19FTkFCTEUgPSBDUlRDX0RDRkVfQ0xP
Q0tfQ09OVFJPTF9fQ1JUQ19EQ0ZFX0NMT0NLX0VOQUJMRSAjIyBtYXNrX3NoLCBcCiAJSFdTX1NG
KEJMTkRfLCBWX1VQREFURV9MT0NLLCBCTE5EX0RDUF9HUlBIX1ZfVVBEQVRFX0xPQ0ssIG1hc2tf
c2gpLFwKQEAgLTgzNiw2ICs4NDgsMTIgQEAgdm9pZCBkY2VfcGlwZV9jb250cm9sX2xvY2soc3Ry
dWN0IGRjICpkYywKIHZvaWQgZGNlX3NldF9ibGVuZGVyX21vZGUoc3RydWN0IGRjZV9od3NlcSAq
aHdzLAogCXVuc2lnbmVkIGludCBibG5kX2luc3QsIGVudW0gYmxuZF9tb2RlIG1vZGUpOwogCisj
aWYgZGVmaW5lZChDT05GSUdfRFJNX0FNRF9EQ19TSSkKK3ZvaWQgZGNlNjBfcGlwZV9jb250cm9s
X2xvY2soc3RydWN0IGRjICpkYywKKwkJc3RydWN0IHBpcGVfY3R4ICpwaXBlLAorCQlib29sIGxv
Y2spOworI2VuZGlmCisKIHZvaWQgZGNlX2Nsb2NrX2dhdGluZ19wb3dlcl91cChzdHJ1Y3QgZGNl
X2h3c2VxICpod3MsCiAJCWJvb2wgZW5hYmxlKTsKIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
