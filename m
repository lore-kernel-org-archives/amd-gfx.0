Return-Path: <SRS0=MAwf=YZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE02CA9ECF
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 13:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF71217F9
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2019 13:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF71217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E6C6E22D;
	Fri,  1 Nov 2019 13:05:15 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4620B6F7CE;
 Fri,  1 Nov 2019 13:05:14 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id q70so9280305wme.1;
 Fri, 01 Nov 2019 06:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zi3i9mgv8VFMbmyTgvnufacfN7CC/6vf66SThdAH3gg=;
 b=EzIrxF4SCODaI4wN89djGHS9fa6fUKAAzxNFYNvK4Lo3SUVeuSjABgxdDTpTzEnOmO
 8T+48A2Ov1fDrygdPT6QiwQ2A4N+ngZq6bsJ1qr0TklZVexc+F5TzBOzYCnTE0oNTQyi
 /u16GMMqnWoyaqsAfvR2MU4XQGYNJtkNAuLcFU6kRBp6BPQ339vuR7UDowRPw29N3JwY
 SgS1Qv7n4E/8XTbcUEdZtbI+JMXuXP9aC1PfB1OuHephfNwGrgeMVEJwuKuec6PhLdkF
 moOeQAI9FuvBoTOTE4ho59QSbu17ijVQ0+YzGHPEYwGGVgkGn8R4FgFHJHfU8kgmYxmd
 P0XA==
X-Gm-Message-State: APjAAAWj2P99KcNcsUYbJWfp6JFgHs35tQR47Ko7X8sVAjeLyBRcJKvv
 on6kBJ7fBI23REeisDwNxkT5xeUG
X-Google-Smtp-Source: APXvYqxHh81AXEhkaU+ZJuif3t2u4n9b1mo4TV8GaOshHhflyXrrzKLGROCOWKFwqCyXZQ+4/LWXdQ==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr10501386wmq.142.1572613512233; 
 Fri, 01 Nov 2019 06:05:12 -0700 (PDT)
Received: from arch-x1c3.cbg.collabora.co.uk
 ([2a00:5f00:102:0:9665:9cff:feee:aa4d])
 by smtp.gmail.com with ESMTPSA id a15sm2450562wmm.12.2019.11.01.06.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 06:05:11 -0700 (PDT)
From: Emil Velikov <emil.l.velikov@gmail.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 5/5] drm: drop DRM_AUTH from PRIME_TO/FROM_HANDLE ioctls
Date: Fri,  1 Nov 2019 13:03:13 +0000
Message-Id: <20191101130313.8862-5-emil.l.velikov@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101130313.8862-1-emil.l.velikov@gmail.com>
References: <20191101130313.8862-1-emil.l.velikov@gmail.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zi3i9mgv8VFMbmyTgvnufacfN7CC/6vf66SThdAH3gg=;
 b=gBBYmLhzaS3mgtcaUH+0inAH/OyO7/wNqobjUminYwAKDZfdlkihuKU2YM8RR25VMg
 U2/7BJXFGnLl5TrCJ0Cb9q0k6YnbhGdGT773Pw4lrhUtHoRt3dQfbi0k7IoobxxfHBuh
 CWUJz4doYZtTdqC1l+Pqqkk0sx6EqQa7PTYLC63liJ+Ik4ynQ/ZhPSwMNuYEjRYc6w1Z
 vLqkso1GnWlLmatO3q5/R5snDiJN+hMKhW1CuVjPbNjYlZxfwGmDYiTDcGnSuvnCVEdb
 u998azT2jzTEJA3u77fc3Zq1UYRdVGaaLI8Np4VnAxb3M2BHA66Hq6aBl1i8MKN7hP7z
 pVcQ==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>,
 emil.l.velikov@gmail.com, Daniel Vetter <daniel@ffwll.ch>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191101130313.Zufok2felsfgOobnZiLAelMINBXIVaUwZ4zZPhaAU9M@z>

RnJvbTogRW1pbCBWZWxpa292IDxlbWlsLnZlbGlrb3ZAY29sbGFib3JhLmNvbT4KCkFzIG1lbnRp
b25lZCBieSBDaHJpc3RpYW4sIGZvciBkcml2ZXJzIHdoaWNoIHN1cHBvcnQgb25seSBwcmltYXJ5
IG5vZGVzCnRoaXMgY2hhbmdlcyB0aGUgcmV0dXJuZWQgZXJyb3IgZnJvbSAtRUFDQ0VTIGludG8g
LUVPUE5PVFNVUFAvLUVOT1NZUy4KCkZvciBvdGhlcnMsIHRoaXMgY2hlY2sgaW4gcGFydGljdWxh
ciB3aWxsIGJlIGEgbm9vcC4gU28gbGV0J3MgcmVtb3ZlIGl0CmFzIHN1Z2dlc3RlZCBieSBDaHJp
c3RpYW4uCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBm
ZndsbC5jaD4KQ2M6IFNlYW4gUGF1bCA8c2VhbkBwb29ybHkucnVuPgpBY2tlZC1ieTogQ2hyaXN0
aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBFbWls
IFZlbGlrb3YgPGVtaWwudmVsaWtvdkBjb2xsYWJvcmEuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9kcm1faW9jdGwuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2lvY3RsLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vZHJtX2lvY3RsLmMKaW5kZXggZmNkNzI4ZDdjZjcyLi41YWZiMzk2
ODhiNTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1faW9jdGwuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vZHJtX2lvY3RsLmMKQEAgLTY1Miw4ICs2NTIsOCBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGRybV9pb2N0bF9kZXNjIGRybV9pb2N0bHNbXSA9IHsKIAogCURSTV9JT0NUTF9ERUYo
RFJNX0lPQ1RMX01PREVfR0VUUkVTT1VSQ0VTLCBkcm1fbW9kZV9nZXRyZXNvdXJjZXMsIDApLAog
Ci0JRFJNX0lPQ1RMX0RFRihEUk1fSU9DVExfUFJJTUVfSEFORExFX1RPX0ZELCBkcm1fcHJpbWVf
aGFuZGxlX3RvX2ZkX2lvY3RsLCBEUk1fQVVUSHxEUk1fUkVOREVSX0FMTE9XKSwKLQlEUk1fSU9D
VExfREVGKERSTV9JT0NUTF9QUklNRV9GRF9UT19IQU5ETEUsIGRybV9wcmltZV9mZF90b19oYW5k
bGVfaW9jdGwsIERSTV9BVVRIfERSTV9SRU5ERVJfQUxMT1cpLAorCURSTV9JT0NUTF9ERUYoRFJN
X0lPQ1RMX1BSSU1FX0hBTkRMRV9UT19GRCwgZHJtX3ByaW1lX2hhbmRsZV90b19mZF9pb2N0bCwg
RFJNX1JFTkRFUl9BTExPVyksCisJRFJNX0lPQ1RMX0RFRihEUk1fSU9DVExfUFJJTUVfRkRfVE9f
SEFORExFLCBkcm1fcHJpbWVfZmRfdG9faGFuZGxlX2lvY3RsLCBEUk1fUkVOREVSX0FMTE9XKSwK
IAogCURSTV9JT0NUTF9ERUYoRFJNX0lPQ1RMX01PREVfR0VUUExBTkVSRVNPVVJDRVMsIGRybV9t
b2RlX2dldHBsYW5lX3JlcywgMCksCiAJRFJNX0lPQ1RMX0RFRihEUk1fSU9DVExfTU9ERV9HRVRD
UlRDLCBkcm1fbW9kZV9nZXRjcnRjLCAwKSwKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4
