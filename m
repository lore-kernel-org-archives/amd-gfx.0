Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055F8C388F9
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 16:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD8B223AB
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 16:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnciBQBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD8B223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61F3D6ECBF;
	Tue,  3 Nov 2020 16:10:49 +0000 (UTC)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA5E6ECBF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 16:10:48 +0000 (UTC)
Received: by mail-pg1-x536.google.com with SMTP id r10so14019030pgb.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ZE5gTdUnJRuWmeFyTCDprNZ2b75nStM8JtYertk0Bps=;
 b=dnciBQBV4iRwYIgd2pCp+q0zbO9y4Vklj1djN9d1Q4n6O0bHf3zM1duoKcquL1O8rn
 /kFfmLvoDXDaGSm3U/ZcROysdrJMd0wkNQS5o2kYGjFPMc1Ci3BAMaNPNoeSJEKk/Mdd
 +deGISyPUMKWTTlZn+MlFnUcvHzksgbW0yTTYv1RdSPhOdFTZOgSPJkO4e6VjgLmJcJ4
 SjfmvAEQgwqgQWJ6tgor4sl4CVy/i0sehhPCjU1+Gw5/BlO9IzjMrfki/CLGMPNzDMXi
 zkQFDqUxlCCw9H+Nfg2F0ggtcE+bC6RJbi+ub+Mtg4GpLBmjYt1GOxLx0viBL/+Ql0rR
 Z6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ZE5gTdUnJRuWmeFyTCDprNZ2b75nStM8JtYertk0Bps=;
 b=npsfwz7tLqX62FYGSa/jl92BEnSpWef8R/is6r+iF/UqGFK3pd3s6lxpiNQrCbUSjF
 2DDVxzsq/MostxK44TJ810WXGeHvf2PInbgy4DF1lYxGNcn5psA8H6+98nMxqL0Lg+Fi
 aRtJBaBf0ogiT7EYMNzyA2DnPLc3uQ8E88UzAzMynQy04pW++Kc4y2xjHyMoy8UBQ1Fo
 9zAwis7OqnWv6R02Z52/bSeVPFqMhXbpnn+Y02asL5jVPw6uXPxqZ60sqZJO7+70s1mj
 ECIuYp7E4iCIwBRMNjRqnGownlsQODNqDMRk3buzuRoVqtP6ZC9Lx3NXt67GFN4F7bLq
 wlRw==
X-Gm-Message-State: AOAM531/SY//ybgoCJTc1Dq4YjNWGRoPhLOSMIfSOFNrhKUO664Cww3g
 NSN4I8cRXw+i6d5cdBHk6voSXJHLaIyooPYbRwGsaGS/WPU=
X-Google-Smtp-Source: ABdhPJzvzXlWsIXq48Mtpl3VOyOOJ9x3X0Ti2HKLlljTrJeJJuZaLAUZPSilua5TeZ1r0O+qXyxcXstbXT7906Kua/0=
X-Received: by 2002:a17:90a:aa91:: with SMTP id
 l17mr508720pjq.198.1604419847777; 
 Tue, 03 Nov 2020 08:10:47 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 3 Nov 2020 11:10:11 -0500
Message-ID: <CAAxE2A7dVst6RpB-cD_SOkkC89jVH1vp6WMv=_KkOEWJKqY_aA@mail.gmail.com>
Subject: [PATCH] drm/amdgpu: set LDS_CONFIG=0x20 on Navy Flounder to fix a GPU
 hang
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="00000000000019188005b3361b95"
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

--00000000000019188005b3361b95
Content-Type: multipart/alternative; boundary="00000000000019187e05b3361b93"

--00000000000019187e05b3361b93
Content-Type: text/plain; charset="UTF-8"

Please review.

Thanks,
Marek

--00000000000019187e05b3361b93
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>Please review.</div><div><br></div><div>Thanks,</div><div>Marek<br></div></div>

--00000000000019187e05b3361b93--

--00000000000019188005b3361b95
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-drm-amdgpu-set-LDS_CONFIG-0x20-on-Navy-Flounder-to-f.patch"
Content-Disposition: attachment; 
	filename="0001-drm-amdgpu-set-LDS_CONFIG-0x20-on-Navy-Flounder-to-f.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kh264bw00>
X-Attachment-Id: f_kh264bw00

RnJvbSA3Njg5YTY2Y2FiNjNlYTlhZGJmY2Q0YzU4ZDliMjcxYjVkZjA4Mjk3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/TWFyZWs9MjBPbD1DNT1BMT1DMz1BMWs/PSA8
bWFyZWsub2xzYWtAYW1kLmNvbT4KRGF0ZTogVHVlLCAzIE5vdiAyMDIwIDExOjA1OjI1IC0wNTAw
ClN1YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogc2V0IExEU19DT05GSUc9MHgyMCBvbiBOYXZ5
IEZsb3VuZGVyIHRvIGZpeCBhIEdQVQogaGFuZwpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5
cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzog
OGJpdAoKU2lnbmVkLW9mZi1ieTogTWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDMgKysrCiAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhf
djEwXzAuYwppbmRleCBmN2QyMTdkZTU4NTkuLmM3OGM2MTU4OTdmOCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKQEAgLTMyMTYsNiArMzIxNiw5IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3Qgc29jMTVfcmVnX2dvbGRlbiBnb2xkZW5fc2V0dGluZ3NfZ2NfMTBfM18yW10gPQog
CVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tVEFfQ05UTF9BVVgsIDB4ZmZmN2ZmZmYs
IDB4MDEwMzAwMDApLAogCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tVVRDTDFfQ1RS
TCwgMHhmZmJmZmZmZiwgMHgwMGEwMDAwMCksCiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywg
MCwgbW1WR1RfR1NfTUFYX1dBVkVfSUQsIDB4MDAwMDBmZmYsIDB4MDAwMDAzZmYpCisKKwkvKiBU
aGlzIGlzIG5vdCBpbiBHREIgeWV0LiBEb24ndCByZW1vdmUgaXQuIEl0IGZpeGVzIGEgR1BVIGhh
bmcgb24gTmF2aTIyLiAqLworCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tTERTX0NP
TkZJRywgIDB4MDAwMDAwMjAsIDB4MDAwMDAwMjApLAogfTsKIAogc3RhdGljIGNvbnN0IHN0cnVj
dCBzb2MxNV9yZWdfZ29sZGVuIGdvbGRlbl9zZXR0aW5nc19nY18xMF8zX3ZhbmdvZ2hbXSA9Ci0t
IAoyLjE3LjEKCg==
--00000000000019188005b3361b95
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--00000000000019188005b3361b95--
