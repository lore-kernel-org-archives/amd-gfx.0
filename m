Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C01AC4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 09:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A902B20874
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 09:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7dftUnS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A902B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F5406E9F1;
	Mon, 26 Oct 2020 09:29:16 +0000 (UTC)
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com
 [IPv6:2a00:1450:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4D96E9F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 09:29:15 +0000 (UTC)
Received: by mail-ed1-x543.google.com with SMTP id dn5so8505461edb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TxTG9TGuQ6b0HaLMP7A25GqUeJNeYZPGitrHjICwli4=;
 b=k7dftUnSyPjagPAgY9iYS2x3mjsO4FT7vbaLMJVb07cIa0IZVRq5elNmT5EyFjDfzG
 D7BLFQuKE/LXz7zk3E4kOdxrdJLIJLtE9mWvvpdsKFyPKjecA8BZPn2IHr4xscT2Gbxb
 0bvTwo6TPpUO18vXFNXtDYwiN/1IuHTTydcTpgdgHARvHHn3zz6wYpaWiSDx4G/MQBtv
 jtjc15M+icwVxEc3jvxCWmjbufd64gCv7QAhuBjuud+GstGx52QjWsGsSE72URpWqE/W
 Q4rI7DlvJx8Z2eHyD8GzGe0LvfWQ5C3zIxKWn8WWyd8IZflvC7podFkPpUMABC+1n4dZ
 7muA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=TxTG9TGuQ6b0HaLMP7A25GqUeJNeYZPGitrHjICwli4=;
 b=t0HpKpcx69S+cGLN9k5JDD/d4j1UjRvtko+YnK4T1pkwmjX7EYm4aHYMC9i6fGVXlG
 wVYub8QEB63hdaR2jWhgIG69ur7y5sasl5jlwnf7lBFtrStlYNBSmbkwmVLeV2vUFFJn
 afbVXTp4Stz+Vpl88HyVUWXPXgNzv+nxeK9pnwwp/SoZeU4N1tf+htPF0KfNaBFT0q8K
 dY5YHP+R2tTwb7FK0LV4ESwEkX4mF30131T1Xc0OogpcWF4y20NsyA6guTGjy9JhB5FI
 t3ZMP8Uf3aO1ADbuB0/y5tFTHAlolUS1FvzwBd3jBWDUyj5jmYqFDGDq40a9eA6R66nU
 L3vA==
X-Gm-Message-State: AOAM530lKsiBjokcoR07kiDb46mA7QsKv0hGVRGktOHc1KL9es9VsEf6
 oiNvYj05sv/QMcnRGUBHvtgbL1HEDP4=
X-Google-Smtp-Source: ABdhPJxYlwAg2SzGpQO7dUR6Lkj2dqqRipS5rJveft2BIK7zX3Eqs2nRU5OEvB+PlaBH1R2KIP48Rw==
X-Received: by 2002:aa7:d64e:: with SMTP id v14mr15195227edr.66.1603704553734; 
 Mon, 26 Oct 2020 02:29:13 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:a0fc:acef:65a8:66b2])
 by smtp.gmail.com with ESMTPSA id i14sm5422460ejy.110.2020.10.26.02.29.12
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 02:29:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: drop mem_global_referenced
Date: Mon, 26 Oct 2020 10:29:12 +0100
Message-Id: <20201026092912.2488-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Tm90IHVzZWQgYW55IG1vcmUuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3R0bS5oIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uaCBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uaAppbmRleCA2OGM1ZTM2NjJiODcuLmQ4MDhiMmE1
OGIyOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5o
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uaApAQCAtNTgsNyAr
NTgsNiBAQCBzdHJ1Y3QgYW1kZ3B1X2d0dF9tZ3IgewogCiBzdHJ1Y3QgYW1kZ3B1X21tYW4gewog
CXN0cnVjdCB0dG1fYm9fZGV2aWNlCQliZGV2OwotCWJvb2wJCQkJbWVtX2dsb2JhbF9yZWZlcmVu
Y2VkOwogCWJvb2wJCQkJaW5pdGlhbGl6ZWQ7CiAJdm9pZCBfX2lvbWVtCQkJKmFwZXJfYmFzZV9r
YWRkcjsKIAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
