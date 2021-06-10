Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2FDC48BD1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 09:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8327D613ED
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 09:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8327D613ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C9976EC94;
	Thu, 10 Jun 2021 09:18:08 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5D16EC8F;
 Thu, 10 Jun 2021 09:18:05 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id o3so1411976wri.8;
 Thu, 10 Jun 2021 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=3a/i/Xi+c5m0afcasaoynqq1ok0Yws0jZdSKhj7thXs=;
 b=Cjoz5iUAWyabHz2NF7E35GLGCd8e3pJLjEbV8g1Bnv3UJEP1XZtz5MYv74y33sBuI+
 +cH6B442Jle0S1nimKZJoy78K7eSPuzHcsnS6tMv8t/A+AFfiR5X4stx2fEPcHmuRBXC
 CZpMjznvccE8UipdUf/GgI4Ul8fRpUoMsA5AE9PRBusJpUTDWE8l/+wHfIFbSsqffFmD
 2zLwAt3wW31nV26+jBN2Amuh8TeBbf/qyWLuSYZHeVdcxKohKRzLnajCvY6d6Xn94XPm
 7rt7K5om94Y/LkxMGBfdFBsNB77wi93bVLzwtA7yXhrWyre5Mt/HjCnfQgfWufAqzt4I
 RXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3a/i/Xi+c5m0afcasaoynqq1ok0Yws0jZdSKhj7thXs=;
 b=d7d4p8peK+/TfFx8c6/7o44MXlS+unXxQ1O0mXjVD1mniBO6jNTwM8R9EEZOMElzY4
 z0/01jtNh7+ZCKkb2CfYIaCFxtG0FxrgrpQ/lQn7tSeRMmie7UiCBQa5zwYHgG0w/F+H
 Zhad5cVErMX0rf+TNeDwbV+78Tek0Gzj/aHQB35OsxNKxntX2/vzm7nTFBLNVg4YcoJI
 lgokW/gDodI7r+dklGUwnj01XoUw6gIqlLmsZ0e5kS5BiXl8ezKNDXH+79XmCtj5PmWV
 apXh13fMjtPnV0xG+oAVkUNm3etitHebzdT4VjREt8zfHdw8bDAXCvqoCHThRgt5xzoU
 Q54g==
X-Gm-Message-State: AOAM531XlXxg82JWgotxKNMoL8y2g8HNkSg8Usd8UBWEP/zTKkQ8PTun
 a4Hy5/NaculfwsJTTlMkWrtXyIRWRd0=
X-Google-Smtp-Source: ABdhPJwdrFEpaRTP3/l4f5jojr7XkftDaE9q6zzVkIPmtDfNS9UJaYkXvmJvs+CCw2cKGrOfDqbrLg==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr4182514wrv.381.1623316684384; 
 Thu, 10 Jun 2021 02:18:04 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:561f:e43a:edf5:8f95])
 by smtp.gmail.com with ESMTPSA id v8sm3087445wrc.29.2021.06.10.02.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 02:18:04 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/7] dma-buf: add dma_fence_chain_alloc/free self tests
Date: Thu, 10 Jun 2021 11:17:56 +0200
Message-Id: <20210610091800.1833-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610091800.1833-1-christian.koenig@amd.com>
References: <20210610091800.1833-1-christian.koenig@amd.com>
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

RXhlcmNpc2UgdGhlIG5ld2x5IGFkZGVkIGZ1bmN0aW9ucy4KClNpZ25lZC1vZmYtYnk6IENocmlz
dGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2RtYS1i
dWYvc3QtZG1hLWZlbmNlLWNoYWluLmMgfCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
ZG1hLWJ1Zi9zdC1kbWEtZmVuY2UtY2hhaW4uYyBiL2RyaXZlcnMvZG1hLWJ1Zi9zdC1kbWEtZmVu
Y2UtY2hhaW4uYwppbmRleCA4Y2UxZWE1OWQzMWIuLjg1NWMxMjljNjA5MyAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9kbWEtYnVmL3N0LWRtYS1mZW5jZS1jaGFpbi5jCisrKyBiL2RyaXZlcnMvZG1hLWJ1
Zi9zdC1kbWEtZmVuY2UtY2hhaW4uYwpAQCAtOTUsNiArOTUsNTMgQEAgc3RhdGljIGludCBzYW5p
dHljaGVjayh2b2lkICphcmcpCiAJcmV0dXJuIGVycjsKIH0KIAorc3RhdGljIGludCBfX2FsbG9j
X2ZyZWUodm9pZCAqYXJnKQoreworCWF0b21pY190ICpjb3VudGVyID0gYXJnOworCWludCBpLCBq
OworCisJZm9yIChpID0gMDsgaSA8IDEwMjQ7ICsraSkgeworCQlzdHJ1Y3QgZG1hX2ZlbmNlX2No
YWluICpjaGFpbnNbNjRdOworCisJCWZvciAoaiA9IDA7IGogPCBBUlJBWV9TSVpFKGNoYWlucyk7
ICsraikKKwkJCWNoYWluc1tqXSA9IGRtYV9mZW5jZV9jaGFpbl9hbGxvYygpOworCisJCWZvciAo
aiA9IDA7IGogPCBBUlJBWV9TSVpFKGNoYWlucyk7ICsraikKKwkJCWRtYV9mZW5jZV9jaGFpbl9m
cmVlKGNoYWluc1tqXSk7CisKKwkJYXRvbWljX2FkZChBUlJBWV9TSVpFKGNoYWlucyksIGNvdW50
ZXIpOworCX0KKwlyZXR1cm4gMDsKK30KKworc3RhdGljIGludCBhbGxvY19mcmVlKHZvaWQgKmFy
ZykKK3sKKwlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRocmVhZHNbOF07CisJYXRvbWljX3QgY291bnRl
ciA9IEFUT01JQ19JTklUKDApOworCWludCBpLCBlcnIgPSAwOworCisJZm9yIChpID0gMDsgaSA8
IEFSUkFZX1NJWkUodGhyZWFkcyk7IGkrKykgeworCQl0aHJlYWRzW2ldID0ga3RocmVhZF9ydW4o
X19hbGxvY19mcmVlLCAmY291bnRlciwgImRtYWJ1Zi8lZCIsCisJCQkJCSBpKTsKKwkJaWYgKElT
X0VSUih0aHJlYWRzW2ldKSkgeworCQkJZXJyID0gUFRSX0VSUih0aHJlYWRzW2ldKTsKKwkJCWJy
ZWFrOworCQl9CisJfQorCisJd2hpbGUgKGktLSkgeworCQlpbnQgcmV0OworCisJCXJldCA9IGt0
aHJlYWRfc3RvcCh0aHJlYWRzW2ldKTsKKwkJaWYgKHJldCAmJiAhZXJyKQorCQkJZXJyID0gcmV0
OworCX0KKworCXByX2luZm8oIkNvbXBsZXRlZCAldSBjeWNsZXNcbiIsIGF0b21pY19yZWFkKCZj
b3VudGVyKSk7CisKKwlyZXR1cm4gZXJyOworfQorCiBzdHJ1Y3QgZmVuY2VfY2hhaW5zIHsKIAl1
bnNpZ25lZCBpbnQgY2hhaW5fbGVuZ3RoOwogCXN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZXM7CkBA
IC02NzcsNiArNzI0LDcgQEAgaW50IGRtYV9mZW5jZV9jaGFpbih2b2lkKQogewogCXN0YXRpYyBj
b25zdCBzdHJ1Y3Qgc3VidGVzdCB0ZXN0c1tdID0gewogCQlTVUJURVNUKHNhbml0eWNoZWNrKSwK
KwkJU1VCVEVTVChhbGxvY19mcmVlKSwKIAkJU1VCVEVTVChmaW5kX3NlcW5vKSwKIAkJU1VCVEVT
VChmaW5kX3NpZ25hbGVkKSwKIAkJU1VCVEVTVChmaW5kX291dF9vZl9vcmRlciksCi0tIAoyLjI1
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
