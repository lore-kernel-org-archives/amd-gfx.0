Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D31C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89BF920872
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8ZjPue8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89BF920872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 525226E2D3;
	Mon,  1 Jun 2020 18:04:39 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378786E2D1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:38 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c185so9948774qke.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HjMnJy+ati37QpQWLt0clWBht6q8w6glyi3Szv0ACHQ=;
 b=Q8ZjPue8TSbjE0wTyPIzDahqvqy3GvdQztX+8OkRtmKbg8L5m8CsOXSDMfRZwQBbNB
 BEIbtl8dZV9iC93w+Xu8bHl5wjRIuXCeGWmrFHdYcuiH4bTWuml7KNaDA+wtuSZxOHEH
 NNDk9KZrp2vMVjtkvhcEbQUDXGfCL5OWN3+nx/gP6QmvAjJV0mWUAJJ8uguJYfu4lnlH
 69JRXMNru2u7zVvo2haQVU0sdYntxX19hb1UiEuqC83Ql8PLRGSRjwxPz1mK8I1HAxjb
 ce56XBoFzalCLE3cpCgMbcfMnWcEll3XU56QbFEeVMB30QwfVYBaUXky6WNLiElhMhAv
 +QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HjMnJy+ati37QpQWLt0clWBht6q8w6glyi3Szv0ACHQ=;
 b=abaj5SdK5eSp207BWngbHu4LoOSMkSKjhVViIkzQY1dRfFIIDlq18SVnXpVPR5WBmi
 KMcbnvZRK4H0WKoN5GoNkOwueU/bD2jAv2H08GWFTGDUKGJ1I1rV0ZSopyAo9q9SWBVa
 LOaB56YMwqdvDeA2wFnSTe3rcb6vkWfb1PKN5wXneyisTNYADhHEn+pzTAUmO6+RnMAM
 WtaN0yY3f3ak5KShXUqjyh0xd+bVlQc+zpYF0vxtlXCShEYiCwQzQOSYHwZbqbxBrPcW
 gFhnSden0MCibfdkv4Idi4qm/ZxV4O8jUXtxmtVUZZ1H3i7929ZrilLFPHGfM2sAl5Qe
 jGrg==
X-Gm-Message-State: AOAM530r1b5lJCxkdMEUMDiIwuXQNU82Pkq3MQiou75l0l5JfRq/K+K3
 wiDYIzgDk/RBvujbAiJP/wANesx7
X-Google-Smtp-Source: ABdhPJyprJSu4AHKkw3hznkFz5hvGQkVaHGsaI8JwErqpXFflUg+0u29APv3VmTAmCJj94aMDdMrUQ==
X-Received: by 2002:a37:7f42:: with SMTP id a63mr21976879qkd.265.1591034677201; 
 Mon, 01 Jun 2020 11:04:37 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 077/207] drm/amdgpu: no need to set up GPU scheduler for mes
 ring
Date: Mon,  1 Jun 2020 14:00:29 -0400
Message-Id: <20200601180239.1267430-74-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSmFjayBYaWFvIDxKYWNrLlhpYW9AYW1kLmNvbT4KCkFzIG1lcyByaW5nIGRpcmVjdGx5
IHN1Ym1pdHMgdG8gaGFyZHdhcmVkLAppdCdzIG5vIG5lZWQgdG8gc2V0IHVwIEdQVSBzY2hlZHVs
ZXIgZm9yIG1lcyByaW5nLgoKU2lnbmVkLW9mZi1ieTogSmFjayBYaWFvIDxKYWNrLlhpYW9AYW1k
LmNvbT4KQWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
UmV2aWV3ZWQtYnk6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KUmV2aWV3
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jIHwgNSArKystLQogMSBmaWxl
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9mZW5jZS5jCmluZGV4IDM0MTRlMTE5ZjBjYi4uODcxMmEyZTFi
ODY5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2Uu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmVuY2UuYwpAQCAtNDY5
LDggKzQ2OSw5IEBAIGludCBhbWRncHVfZmVuY2VfZHJpdmVyX2luaXRfcmluZyhzdHJ1Y3QgYW1k
Z3B1X3JpbmcgKnJpbmcsCiAJaWYgKCFyaW5nLT5mZW5jZV9kcnYuZmVuY2VzKQogCQlyZXR1cm4g
LUVOT01FTTsKIAotCS8qIE5vIG5lZWQgdG8gc2V0dXAgdGhlIEdQVSBzY2hlZHVsZXIgZm9yIEtJ
USByaW5nICovCi0JaWYgKHJpbmctPmZ1bmNzLT50eXBlICE9IEFNREdQVV9SSU5HX1RZUEVfS0lR
KSB7CisJLyogTm8gbmVlZCB0byBzZXR1cCB0aGUgR1BVIHNjaGVkdWxlciBmb3IgS0lRIGFuZCBN
RVMgcmluZyAqLworCWlmIChyaW5nLT5mdW5jcy0+dHlwZSAhPSBBTURHUFVfUklOR19UWVBFX0tJ
USB8fAorCSAgICByaW5nLT5mdW5jcy0+dHlwZSAhPSBBTURHUFVfUklOR19UWVBFX01FUykgewog
CQlzd2l0Y2ggKHJpbmctPmZ1bmNzLT50eXBlKSB7CiAJCWNhc2UgQU1ER1BVX1JJTkdfVFlQRV9H
Rlg6CiAJCQl0aW1lb3V0ID0gYWRldi0+Z2Z4X3RpbWVvdXQ7Ci0tIAoyLjI1LjQKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
