Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5921C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B75E61184
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B75E61184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CA46E10B;
	Thu, 20 May 2021 12:49:10 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491386F41B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:35 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id v12so17387474wrq.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=X9eczHip+J0dwqD8Nynlf0SQVH9uQ9i0PT+0Vah0Gl0=;
 b=EBBm/BAj9BTJp956f9eBv+yUCERX2gUNVAM6K/5E4csMp3i8GsP0qbgOm0BU51QRPT
 6nZwAPPp4tiz1c50sSMPznww3MHbW2TC23YqcXaF+HTp7ZnZ9HSGMonK8a1ZKw5SrLH5
 oJpnp4A7uLGuhrKjG6xl92kK2l3WXZ9+gU6bOrPj+wQ1mvnabg1GgtQs7S7B30Y19HIE
 MCTWxGCtlQMnK/H+JaYrycrc2+WEVxcDH//S1RDdP5XUC7hL8qakz0B2Bpve4HW+1qd5
 tu8gFTy3HGzvAwq/DnIU51mjniWNYmOd2pDlwG3048bxvSJ0F4DAUgCO+tlb+dlgUz9Y
 6ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=X9eczHip+J0dwqD8Nynlf0SQVH9uQ9i0PT+0Vah0Gl0=;
 b=NiCD/hGM1fzVh9w79z1nY1cXy3h5lIazqCozKCwResGCB7hGv/j3Pqd3mHaNdtaphn
 Q7ZdqFH4ZDD1O8v6mUcLeN6IrfQas6XAOgN7TJ7O39IH3lJkYBUyrxtXIQ1UUeSUi5+E
 GoIh8ZZWnwfq4Xopqp15M4otAkTrZEfs6ljx8JX55WEHZ/PSWmVrS48ZY0sbNCBbyfO2
 E//0A30jTD3X9Gnq1oc/ZpQS9oRpuLAvUmJtKldPCHZkulATMyhA+8czwz4LFhaEye5S
 z3WhoHLmyTvBheZGDZ5TddoZZQz5zMv2/TyVIuaN1FYOcyAgjYrIZvCcXjD9oQXPteQW
 l0ng==
X-Gm-Message-State: AOAM533WaSPRNeV7aWQQFqUNwAPdp0SB8o2qQpENWJbt8Q5Uifu5fmh8
 1x7VymwARxRREvinIHVeSNRy6Q==
X-Google-Smtp-Source: ABdhPJyRIxha+2unj4GubwBfRPOO/kKMbHctRfrTKSCS4y70HgOgR3Rv8Bl0IBQd/a0bAg1psWp//Q==
X-Received: by 2002:adf:ed47:: with SMTP id u7mr3957954wro.254.1621512214037; 
 Thu, 20 May 2021 05:03:34 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:33 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 32/38] drm/amd/amdgpu/sdma_v4_0: Realign functions with their
 headers
Date: Thu, 20 May 2021 13:02:42 +0100
Message-Id: <20210520120248.3464013-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmM6NzY0OiB3YXJuaW5nOiBleHBlY3Rpbmcg
cHJvdG90eXBlIGZvciBzZG1hX3Y0XzBfcGFnZV9yaW5nX3NldF93cHRyKCkuIFByb3RvdHlwZSB3
YXMgZm9yIHNkbWFfdjRfMF9yaW5nX3NldF93cHRyKCkgaW5zdGVhZAogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92NF8wLmM6ODMwOiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBl
IGZvciBzZG1hX3Y0XzBfcmluZ19zZXRfd3B0cigpLiBQcm90b3R5cGUgd2FzIGZvciBzZG1hX3Y0
XzBfcGFnZV9yaW5nX3NldF93cHRyKCkgaW5zdGVhZAoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFu
aWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13
YWxAbGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5v
cmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NkbWFfdjRfMC5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3NkbWFfdjRfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKaW5k
ZXggZDE5NzE4NWY3Nzg5MC4uYWU1NDY0ZTI1MzVhOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92NF8wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvc2RtYV92NF8wLmMKQEAgLTc1NCw3ICs3NTQsNyBAQCBzdGF0aWMgdWludDY0X3Qgc2RtYV92
NF8wX3JpbmdfZ2V0X3dwdHIoc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nKQogfQogCiAvKioKLSAq
IHNkbWFfdjRfMF9wYWdlX3Jpbmdfc2V0X3dwdHIgLSBjb21taXQgdGhlIHdyaXRlIHBvaW50ZXIK
KyAqIHNkbWFfdjRfMF9yaW5nX3NldF93cHRyIC0gY29tbWl0IHRoZSB3cml0ZSBwb2ludGVyCiAg
KgogICogQHJpbmc6IGFtZGdwdSByaW5nIHBvaW50ZXIKICAqCkBAIC04MjAsNyArODIwLDcgQEAg
c3RhdGljIHVpbnQ2NF90IHNkbWFfdjRfMF9wYWdlX3JpbmdfZ2V0X3dwdHIoc3RydWN0IGFtZGdw
dV9yaW5nICpyaW5nKQogfQogCiAvKioKLSAqIHNkbWFfdjRfMF9yaW5nX3NldF93cHRyIC0gY29t
bWl0IHRoZSB3cml0ZSBwb2ludGVyCisgKiBzZG1hX3Y0XzBfcGFnZV9yaW5nX3NldF93cHRyIC0g
Y29tbWl0IHRoZSB3cml0ZSBwb2ludGVyCiAgKgogICogQHJpbmc6IGFtZGdwdSByaW5nIHBvaW50
ZXIKICAqCi0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
