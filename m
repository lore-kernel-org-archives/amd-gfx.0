Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7659C4363D
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D6D208A9
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWvFF1wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D6D208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E99376ECEA;
	Fri, 25 Sep 2020 14:31:39 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C423F6ECEA
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:31:38 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id b13so1455966qvl.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 07:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SiwFHOyymdeCAQ3fTPIUUYuDWR7mDSTFUTC8XlVpCBA=;
 b=pWvFF1wqEc9dzppIDarR4DUfN3ISWH3CMCe7t2jgf3RF9S77atGFM8tPKJFI42iMto
 ffJeBb/4z8Tnvc8JKhsl7KYqqpJKrIJrii2fo1nO2/hAKf3TkFRzK7I0FWgeNikPHUVT
 3HbXygZWRJQlc/aphhPmmTkS3yfis+8c5yG271Cl/VXtOMOz6IPBCqeUVAxnfhHBQs7B
 FP6EhwqrXCbZzkC4LDg8/ykCnjEirSG8ZS4odWcFHZ5+e5vvc2gQOcue6J0oWChg4JVT
 fTUTduVd8fVIP3r9WSpg2quQKEC4/IUIIBWOyvV9tpQ4MInM2qEwX//3ZkD3a+4H234m
 ID7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SiwFHOyymdeCAQ3fTPIUUYuDWR7mDSTFUTC8XlVpCBA=;
 b=o5+NLzd2/281G/hCQNoCMo2OZnf2J7GZc5DImWcNFLtchgqVcG7XW1ljJCEKlOpYC/
 +9wqq0LJR9pTAftL/4KR5ftjMGvICYFKTvtNe5jfVs0PWM3P51odtU8HjVZ1Lq0qDW1w
 gTd0tazJeVtlwGW4Ex8QqZSnElrcp0gWK4TWnXZU2V2yvqWOBobA9yJoPv9HbyR4sjRo
 RUbZOo/efN+SGzE6Tcfq/B+3KUlajel+flWEaJTrzsmgEBGs9kCTrgtdEdY8zeJ8bf0O
 EFnpMz7p9b5JZs+jwTvnrLgMaBKwEHOngya7XVxvbogu3RzB0F+GRQwNKrL5yvzQoFLH
 jqwg==
X-Gm-Message-State: AOAM5315waFctKInxYgZWO7ffO8wwcMdu8RIV4+YRs2Z51aCtojTdF1u
 CrhX0ryaKiR30XyAJ4B6LgoT3TE8CXU=
X-Google-Smtp-Source: ABdhPJxj2mjM6cuzcpfiSVhOPZaAjCZij9BDiUH9TtNNdnaUdP7SfVXtlrvmL61kDhkH2fr7xc8SMw==
X-Received: by 2002:ad4:544a:: with SMTP id h10mr4848860qvt.35.1601044297417; 
 Fri, 25 Sep 2020 07:31:37 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id k5sm1734077qkc.45.2020.09.25.07.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 07:31:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix a warning in amdgpu_ras.c
Date: Fri, 25 Sep 2020 10:31:27 -0400
Message-Id: <20200925143127.1588029-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOiBJbiBmdW5jdGlvbiDigJhh
bWRncHVfcmFzX2ZzX2luaXTigJk6CmRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9y
YXMuYzoxMjg0OjI6IHdhcm5pbmc6IGlnbm9yaW5nIHJldHVybiB2YWx1ZSBvZiDigJhzeXNmc19j
cmVhdGVfZ3JvdXDigJksIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIHdhcm5fdW51c2VkX3Jlc3Vs
dCBbLVd1bnVzZWQtcmVzdWx0XQogMTI4NCB8ICBzeXNmc19jcmVhdGVfZ3JvdXAoJmFkZXYtPmRl
di0+a29iaiwgJmdyb3VwKTsKICAgICAgfCAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4KClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KLS0tCgpEbyB3ZSBjYXJlIHdoZXRoZXIgdGhpcyBmYWlscyBvciBub3Q/
CgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIHwgNCArLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCmluZGV4IDQ5ZDEwMzMwYmY2NC4uNjc3MjQwNDlhMGZj
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCkBAIC0xMjgxLDkgKzEy
ODEsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9yYXNfZnNfaW5pdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldikKIAkJc3lzZnNfYmluX2F0dHJfaW5pdChiaW5fYXR0cnNbMF0pOwogCX0KIAotCXN5
c2ZzX2NyZWF0ZV9ncm91cCgmYWRldi0+ZGV2LT5rb2JqLCAmZ3JvdXApOwotCi0JcmV0dXJuIDA7
CisJcmV0dXJuIHN5c2ZzX2NyZWF0ZV9ncm91cCgmYWRldi0+ZGV2LT5rb2JqLCAmZ3JvdXApOwog
fQogCiBzdGF0aWMgaW50IGFtZGdwdV9yYXNfZnNfZmluaShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldikKLS0gCjIuMjUuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
