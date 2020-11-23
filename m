Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FFBC63798
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7BF20702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVtLw5uT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7BF20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 776E989E36;
	Mon, 23 Nov 2020 13:58:02 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4DA889DA4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:19:51 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p22so17512102wmg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T4FjG6f9bymrh4PjmAcFpuoCus4SJcn+AyFqjEZrv1I=;
 b=vVtLw5uT6obzsw8cMoY4xbKNUucmADpVYib8Njfe0EEVJAIs0FfMXC1oaf4fr2ouBA
 uBpCJ+IgKilFI5lPWPI2Rtmasmj1eHvBiS02GeGassoW1xZq+fzzvhgvM2jOlBtIm8QD
 hNxNVPUBFiqe7UXOzN34Knlk7OeyVnKRxJqpMbKIUF79T0Gg9rEedupu/GGa8mPcVcUH
 LJ5jfGxGyY/jaoqgQ1F31B48lWeWBek6XwBzueCp4Meg/RjV8gmLcgO5ZD5GlG+Uw4sp
 d5PlZxY/WVYFRUk8ZT2RP8PfIwaO1mv/OxhEqG51oexe0MCWWB65fGWFWPRkVJP7aiNS
 VFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T4FjG6f9bymrh4PjmAcFpuoCus4SJcn+AyFqjEZrv1I=;
 b=F17a5ZQdsLetPXLK6yqHWzkD3o9P+qkI3mzRdc8YPtH5+GnPV7GNTRvLJGwDZBJ6fB
 /5EIA+aBCoPQa38frSXKOTU+LuBo5NiiGxnR7Ge2pAo/MFewJW1JAsH/KMufNDD7yBsL
 Yhoxsr+P5mH//OO8AIuJiTm/1LooEDxTSjRQO/F/elJNeoMcPuqFQew9U59SNtjTlMJB
 BjS8X8H5919H3B1WEA3Qs7+B5zkTqVFN8m5MTJmb2dqzURgzgwFGSnLgHP/cs+p0F6e3
 H4jBtG1PMeSqS0L5yNwa0im4weUMpyn8Tm406tsnIEHri7wW9Qd2hMWfd+ekgChjWuds
 IdvQ==
X-Gm-Message-State: AOAM533XTu7y8KWzZS+IVfO7ElU+jcd6DgbjGtymEy5oPmQSWgGBywLg
 C81LqXp4O8krCv+j/+3qa+cbBQ==
X-Google-Smtp-Source: ABdhPJyUOXqPshe2OXY/yWW4HWBycTHOYqj9YJnlDG9mNMgCMAKhHT1jzXAB7KFzPcBCMyeSQyPeYg==
X-Received: by 2002:a05:600c:22d5:: with SMTP id
 21mr22035408wmg.33.1606130390647; 
 Mon, 23 Nov 2020 03:19:50 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:19:49 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 22/40] drm/amd/amdgpu/dce_v6_0: Fix formatting and missing
 parameter description issues
Date: Mon, 23 Nov 2020 11:19:01 +0000
Message-Id: <20201123111919.233376-23-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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
 amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y2XzAuYzoxOTI6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ2FzeW5jJyBub3QgZGVzY3JpYmVkIGluICdkY2VfdjZfMF9wYWdl
X2ZsaXAnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jOjEwNTA6IHdhcm5p
bmc6IENhbm5vdCB1bmRlcnN0YW5kICAqCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtvdkBhbWQu
Y29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jIHwgMiAr
LQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y2XzAuYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2RjZV92Nl8wLmMKaW5kZXggOTQzOTc2MzQ5MzQ2NC4uODNhODgzODVi
NzYyMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3Y2XzAuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdjZfMC5jCkBAIC0xODAsNiArMTgw
LDcgQEAgc3RhdGljIHZvaWQgZGNlX3Y2XzBfcGFnZWZsaXBfaW50ZXJydXB0X2Zpbmkoc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCiAg
KiBAY3J0Y19pZDogY3J0YyB0byBjbGVhbnVwIHBhZ2VmbGlwIG9uCiAgKiBAY3J0Y19iYXNlOiBu
ZXcgYWRkcmVzcyBvZiB0aGUgY3J0YyAoR1BVIE1DIGFkZHJlc3MpCisgKiBAYXN5bmM6IGFzeW5j
aHJvbm91cyBmbGlwCiAgKgogICogRG9lcyB0aGUgYWN0dWFsIHBhZ2VmbGlwIChldmVyZ3JlZW4r
KS4KICAqIER1cmluZyB2Ymxhbmsgd2UgdGFrZSB0aGUgY3J0YyBsb2NrIGFuZCB3YWl0IGZvciB0
aGUgdXBkYXRlX3BlbmRpbmcKQEAgLTEwNDcsNyArMTA0OCw2IEBAIHN0YXRpYyB1MzIgZGNlX3Y2
XzBfbGluZV9idWZmZXJfYWRqdXN0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCiAKIC8q
KgotICoKICAqIGRjZV92Nl8wX2JhbmR3aWR0aF91cGRhdGUgLSBwcm9ncmFtIGRpc3BsYXkgd2F0
ZXJtYXJrcwogICoKICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKLS0gCjIuMjUuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
