Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24ABC55ABD
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6911420665
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZeGjKIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6911420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D28CE89C7F;
	Tue, 10 Nov 2020 19:35:45 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE01389BE8
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:27 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id w24so4331296wmi.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WSjLdlLWJSq+5kS7GDyIv4rvxAPSqu/8nkKg/bHUTUY=;
 b=wZeGjKIorbPA0c0PrlnhLlnJk1itC4n0nTzOcbguHLU7XW0VZKuUzrj6ysHsa+HgNf
 w80Z4ZeECtO1M3dSL3w3Km0+DR8inGbS+ShcfNMffu1CCsTlpt6i1jnIPaOWiagzdSsF
 KB/Qkz60IzImuWaMW9jQO2moRwFqPcXUHZALrSO8+nwWhPW4OLj9h32zxfuCObMGF9Y9
 BSaHqq6YxNO/GPXJY9vH4OokQ4Tsg4I5CXONrwyGmojixpVvyZaWI1FfECBoomawAlB3
 ERQO8NE4MsR79/f7r0YqSxeqgu1rnXeqaWlkb7gxWwisrbJppmH2hD7OItJ6C9wbbQk0
 QpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WSjLdlLWJSq+5kS7GDyIv4rvxAPSqu/8nkKg/bHUTUY=;
 b=E6nzsQs7g0HVSzREU3oVxdlmW4gUwAXAQWiKWUTkqShr90gU8iFYwlCN3ixtr9gBcq
 rmXLIK2AFczkqCVzi4haPzIkdBSH1XSKlsAbJTeMfzXIHq8AN2EOLEbXNdZs6dTK3+w0
 JXeUqHMDrp7wPvfM/By9rxNm2KLWUuAJ8JrhMqNhwiRKzeEB8ACrIfO293Fpx0PkXXpI
 KyA+/HzgoOywSep0pd309BcnjHYKDn+fxqAG/gfyS3NldES+9BqasiFIh90g1u5m3n4Q
 6wAL+mvmCAtoQDev8hjsNoRLGzHodm/zBvj9pTGRGy1BXdmHpTV317bq4xLii2ev9wk1
 YHyA==
X-Gm-Message-State: AOAM531Ibf64trosgJv4j1Hi6TU2tkcE6Nbjcrj8kaRwI6NyFSNVHThz
 5PFLpCE6PW7BELal/VEfmhxQUA==
X-Google-Smtp-Source: ABdhPJy8WfbcOgUKu6Mr5z7B464nWgTV0uVrAjvMbugVW8Im4qbasXQpfUC+3jFMjGemwfCn1sfFyw==
X-Received: by 2002:a1c:448:: with SMTP id 69mr736733wme.12.1605036686390;
 Tue, 10 Nov 2020 11:31:26 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:25 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/30] drm/radeon/ci_dpm: Remove set but unused variable
 'dpm_event_src'
Date: Tue, 10 Nov 2020 19:30:50 +0000
Message-Id: <20201110193112.988999-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW5kIHRoZSBwaWVjZSBvZiBjb2RlIHRoYXQgaGFzIG5ldmVyIGJlZW4gZXhlY3V0ZWQuCgpGaXhl
cyB0aGUgZm9sbG93aW5nIFc9MSBrZXJuZWwgYnVpbGQgd2FybmluZyhzKToKCiBkcml2ZXJzL2dw
dS9kcm0vcmFkZW9uL2NpX2RwbS5jOiBJbiBmdW5jdGlvbiDigJhjaV9zZXRfZHBtX2V2ZW50X3Nv
dXJjZXPigJk6CiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2NpX2RwbS5jOjEzNjk6Mjg6IHdhcm5p
bmc6IHZhcmlhYmxlIOKAmGRwbV9ldmVudF9zcmPigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVz
ZWQtYnV0LXNldC12YXJpYWJsZV0KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIg
PGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8
bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaV9kcG0u
YyB8IDEyIC0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lfZHBtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL2NpX2RwbS5jCmluZGV4IDg4NmU5OTU5NDk2ZmUuLjgzMjRhY2E1ZmQwMDYgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lfZHBtLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9jaV9kcG0uYwpAQCAtMTM2Niw3ICsxMzY2LDYgQEAgc3RhdGljIHZvaWQg
Y2lfc2V0X2RwbV9ldmVudF9zb3VyY2VzKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCB1MzIg
c291cmNlcykKIHsKIAlzdHJ1Y3QgY2lfcG93ZXJfaW5mbyAqcGkgPSBjaV9nZXRfcGkocmRldik7
CiAJYm9vbCB3YW50X3RoZXJtYWxfcHJvdGVjdGlvbjsKLQllbnVtIHJhZGVvbl9kcG1fZXZlbnRf
c3JjIGRwbV9ldmVudF9zcmM7CiAJdTMyIHRtcDsKIAogCXN3aXRjaCAoc291cmNlcykgewpAQCAt
MTM3NiwyOCArMTM3NSwxNyBAQCBzdGF0aWMgdm9pZCBjaV9zZXRfZHBtX2V2ZW50X3NvdXJjZXMo
c3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYsIHUzMiBzb3VyY2VzKQogCQlicmVhazsKIAljYXNl
ICgxIDw8IFJBREVPTl9EUE1fQVVUT19USFJPVFRMRV9TUkNfVEhFUk1BTCk6CiAJCXdhbnRfdGhl
cm1hbF9wcm90ZWN0aW9uID0gdHJ1ZTsKLQkJZHBtX2V2ZW50X3NyYyA9IFJBREVPTl9EUE1fRVZF
TlRfU1JDX0RJR0lUQUw7CiAJCWJyZWFrOwogCWNhc2UgKDEgPDwgUkFERU9OX0RQTV9BVVRPX1RI
Uk9UVExFX1NSQ19FWFRFUk5BTCk6CiAJCXdhbnRfdGhlcm1hbF9wcm90ZWN0aW9uID0gdHJ1ZTsK
LQkJZHBtX2V2ZW50X3NyYyA9IFJBREVPTl9EUE1fRVZFTlRfU1JDX0VYVEVSTkFMOwogCQlicmVh
azsKIAljYXNlICgoMSA8PCBSQURFT05fRFBNX0FVVE9fVEhST1RUTEVfU1JDX0VYVEVSTkFMKSB8
CiAJICAgICAgKDEgPDwgUkFERU9OX0RQTV9BVVRPX1RIUk9UVExFX1NSQ19USEVSTUFMKSk6CiAJ
CXdhbnRfdGhlcm1hbF9wcm90ZWN0aW9uID0gdHJ1ZTsKLQkJZHBtX2V2ZW50X3NyYyA9IFJBREVP
Tl9EUE1fRVZFTlRfU1JDX0RJR0lBTF9PUl9FWFRFUk5BTDsKIAkJYnJlYWs7CiAJfQogCiAJaWYg
KHdhbnRfdGhlcm1hbF9wcm90ZWN0aW9uKSB7Ci0jaWYgMAotCQkvKiBYWFg6IG5lZWQgdG8gZmln
dXJlIG91dCBob3cgdG8gaGFuZGxlIHRoaXMgcHJvcGVybHkgKi8KLQkJdG1wID0gUlJFRzMyX1NN
QyhDR19USEVSTUFMX0NUUkwpOwotCQl0bXAgJj0gRFBNX0VWRU5UX1NSQ19NQVNLOwotCQl0bXAg
fD0gRFBNX0VWRU5UX1NSQyhkcG1fZXZlbnRfc3JjKTsKLQkJV1JFRzMyX1NNQyhDR19USEVSTUFM
X0NUUkwsIHRtcCk7Ci0jZW5kaWYKLQogCQl0bXAgPSBSUkVHMzJfU01DKEdFTkVSQUxfUFdSTUdU
KTsKIAkJaWYgKHBpLT50aGVybWFsX3Byb3RlY3Rpb24pCiAJCQl0bXAgJj0gflRIRVJNQUxfUFJP
VEVDVElPTl9ESVM7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
