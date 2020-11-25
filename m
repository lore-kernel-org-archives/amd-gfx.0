Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAB7C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 06:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93BC220708
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 06:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZiqV2CL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93BC220708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E721D6E832;
	Wed, 25 Nov 2020 06:45:34 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630C56E832
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 06:45:33 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id w202so1386607pff.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 22:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=m3b/4yMsweF6rJpiEqiQ0DtyU1j/9BVcbHTRIXt1s5A=;
 b=IZiqV2CLpT1bfSDgZTCMJoA9lLJoG5l9ATI0uHkobJRvz7PGHDkGdq0f7pJl4mJz1w
 5DvCvcExP2jV5ar2V6upXtQv6eWwxpcb519JmkDbNbYCusnnmoiqOnIFyYA1hde84lkV
 LlYp18mJ7w95t+jcsc45pFnrm0pZZ9MXQGN6GZEud1nY4NsUxzo37IQnHikBRIy2n4bP
 c2s536dkG4dkVTGwWgQ/bgovYuf13o+CID+wDQ5M6eTIpAyJzjsUIe4eCFG5P+vr52mY
 zPX9FvB8KoIPXkdT4FX3Pzbwtk7Hi6ebmkzQkYkk/seAyls5+bD2gdwcgd5HfeqUfPJX
 wLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=m3b/4yMsweF6rJpiEqiQ0DtyU1j/9BVcbHTRIXt1s5A=;
 b=B0jbnSgi6i+ca9R5yFc5PQ9Kq9K88UjMCcG7H+TywiWy8ot6+VkNIAyQKbb7fYnoHQ
 k6MiuQwJDyC4ULAh4njay5icy51jkYKB0dSut+iK2tigo0JTVkil/cJ0V3QuMLTvz7R1
 NNhTEOoTxh3SxduwUBkQMtidGbEDRlfVL55INnn3ykLmrmA0XJqmqWU3v2VWTlE84s5a
 Bz0pw0Gl5gxalB82PyLPEi6SZIjv5hC9dTy/5dKq0zA9dO8qyt2QjNpsyYzi+nbfQNLc
 CxKNB0/GyQ5YaaJ+4SzacEmfCA80QtNtxGCQhbmsB2XF97lVNuZxxfRTY2xRRyzrIwt4
 26vA==
X-Gm-Message-State: AOAM530HzgbDnoThl3d/kR4xCq9dAUXAEb/ekUo+ntdCp/OH5llfxUu2
 6aB6z/cN8+uKmKjd4D4lWZ6TGYRy0XjY2OHR2pFfpimxMmM=
X-Google-Smtp-Source: ABdhPJxdkKPDU8c7jB3qRON2u38zouydLPXNSRNgIly0PwtGLfmAostZTD/FsxygJ+2keU5DhTNcogSjiuSUi9whW9w=
X-Received: by 2002:a17:90a:c687:: with SMTP id
 n7mr2216498pjt.75.1606286732847; 
 Tue, 24 Nov 2020 22:45:32 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 25 Nov 2020 01:44:56 -0500
Message-ID: <CAAxE2A5t2hMWMDmMZy8y20c_JOOUMcOTeHcukYOKRVriHpAjmw@mail.gmail.com>
Subject: [PATCH] drm/amdgpu: set LDS_CONFIG=0x20 on VanGogh to fix MGCG hang
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="0000000000001e8b5905b4e8c6ba"
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

--0000000000001e8b5905b4e8c6ba
Content-Type: multipart/alternative; boundary="0000000000001e8b5705b4e8c6b8"

--0000000000001e8b5705b4e8c6b8
Content-Type: text/plain; charset="UTF-8"

Please review. This fixes an LDS hang that occurs with NGG, but may occur
with other shader stages too.

Thanks,
Marek

--0000000000001e8b5705b4e8c6b8
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Please review. This fixes an LDS hang that occurs with NGG, but may occur with other shader stages too.</div><div><br></div><div>Thanks,</div><div>Marek<br></div><br></div>

--0000000000001e8b5705b4e8c6b8--

--0000000000001e8b5905b4e8c6ba
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-set-LDS_CONFIG-0x20-on-VanGogh-to-fix-MGC.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-set-LDS_CONFIG-0x20-on-VanGogh-to-fix-MGC.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_khx1lw2c0>
X-Attachment-Id: f_khx1lw2c0

RnJvbSA4OWY3ZjFmZjE3Yjg1MWI1YmQ1MTNhNmM3ZTdjMjY1NDZiNzc1ZDY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogV2VkLCAyNSBOb3YgMjAyMCAwMTo0MDo1MSAtMDUw
MApTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6IHNldCBMRFNfQ09ORklHPTB4MjAgb24gVmFu
R29naCB0byBmaXggTUdDRyBoYW5nCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTogdGV4
dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0CgpT
YW1lIGFzIFNpZW5uYSBDaWNobGlkIGFuZCBOYXZ5IEZsb3VuZGVyLgoKU2lnbmVkLW9mZi1ieTog
TWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8w
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYwppbmRleCA4NDFkMzll
YjYyZDkuLjliN2NiYThiYWY2YiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3YxMF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8w
LmMKQEAgLTMyNjIsNiArMzI2Miw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jMTVfcmVnX2dv
bGRlbiBnb2xkZW5fc2V0dGluZ3NfZ2NfMTBfM192YW5nb2doW10gPQogCVNPQzE1X1JFR19HT0xE
RU5fVkFMVUUoR0MsIDAsIG1tVEFfQ05UTF9BVVgsIDB4ZmZmN2ZmZmYsIDB4MDEwMzAwMDApLAog
CVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tVVRDTDFfQ1RSTCwgMHhmZmZmZmZmZiwg
MHgwMDQwMDAwMCksCiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1WR1RfR1NfTUFY
X1dBVkVfSUQsIDB4MDAwMDBmZmYsIDB4MDAwMDAwZmYpLAorCisJLyogVGhpcyBpcyBub3QgaW4g
R0RCIHlldC4gRG9uJ3QgcmVtb3ZlIGl0LiBJdCBmaXhlcyBhIEdQVSBoYW5nIG9uIFZhbkdvZ2gu
ICovCisJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1MRFNfQ09ORklHLCAgMHgwMDAw
MDAyMCwgMHgwMDAwMDAyMCksCiB9OwogCiBzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1X3JlZ19n
b2xkZW4gZ29sZGVuX3NldHRpbmdzX2djXzEwXzNfNFtdID0KLS0gCjIuMjUuMQoK
--0000000000001e8b5905b4e8c6ba
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--0000000000001e8b5905b4e8c6ba--
