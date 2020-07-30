Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B16C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780332074B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJ2x4v25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780332074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5576E95D;
	Thu, 30 Jul 2020 20:04:28 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801796E959
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:25 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id 6so21351391qtt.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NLk5zthlO6d53b+Iq/bI1+/FYAl6iCPNEIeDAaFmS9Y=;
 b=LJ2x4v25kCBiKLuCK8kKnKOFiBv7UYgN7hI93+xugeRSajUNobZzQto+QDKkGfmCIA
 BfUl+CoLans6yYVR9r43yXkGnLAjaG1uTWDzqtmhl08hL/gFIgY5ISV7m/aBQB7O16Hw
 yJS8oGd2V17TYXKckmK121Z6YrnVDzJiGYrvxdnndOp34hY9fxygkip2CQDhtMQXYelw
 WjQqQl5jUDzUZfPxC2rpSZmXGG0cbV/U2zkb3rNy/clnVTRtMfpyQDor6J7tEplolzo0
 YAv4Hmqd1M9ZLrqPJyCSnv+c5OywQy/e9QHWsO0iqscTpU2TGvePncZd+8eB/8z3Gvnr
 Aa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NLk5zthlO6d53b+Iq/bI1+/FYAl6iCPNEIeDAaFmS9Y=;
 b=keycblKfX28TtWIsHR8kbgOZJl1FTrnFedBP5sZ5Y27zxtCGRin21EbMZ83G8o3tST
 lGHrHGny7sFwigMBAyrhoG4CvUnYJiw9UjmJGdJBYlRf4VxVYMXSltWtdia0B/3Qrgt/
 GTkT2fBLZr56ioVmCXxeTPd6OIEozdfTJsZNGP9M/dpgyMMXaFsC1KBJmMXUCtq6rdjD
 XSjY+XiGRaBthgvM4wjR4RaLBDAalLvxVicVZ1S5m5Xjm+T9nEyBO33hJ9B/A0gnt/3R
 xemQKielr5z8e1M/7u+gVBCIFv1E7vA9b3E5qixr5FW2UzNke1rRo9BNEc4F3cqFEqNN
 vDVQ==
X-Gm-Message-State: AOAM530ipCHpef9/fBaSlwkOqGeSOBj5f7Po1VS5h6OGScIQVSVm1odh
 TJ0SWVXGTWUH2K5Q+BZCeuXaZg5p
X-Google-Smtp-Source: ABdhPJzntiifcjGtruCQuHloBxpYcOglj+35zEIECHwAxRYgUmczJmnIdOQKDhgGodt+dVSZBb8BMw==
X-Received: by 2002:ac8:1e87:: with SMTP id c7mr318201qtm.289.1596139464449;
 Thu, 30 Jul 2020 13:04:24 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:23 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/17] drm/amdgpu: use create_at for the stolen pre-OS buffer
Date: Thu, 30 Jul 2020 16:03:59 -0400
Message-Id: <20200730200414.40485-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200730200414.40485-1-alexander.deucher@amd.com>
References: <20200730200414.40485-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2hvdWxkIGJlIGZ1bmN0aW9uYWxseSB0aGUgc2FtZSBzaW5jZSBub3RoaW5nIGVsc2UgaXMKYWxs
b2NhdGVkIGF0IHRoYXQgcG9pbnQsIGJ1dCBsZXQncyBiZSBleGFjdC4KClJldmlld2VkLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClJldmlld2VkLWJ5OiBG
ZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3R0bS5jCmluZGV4IDYwNWQyNjY3NTRmNi4uYTE4ODIxNmJjY2MyIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCkBAIC0xOTc5LDEwICsxOTc5LDEwIEBAIGlu
dCBhbWRncHVfdHRtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJICogVGhpcyBp
cyB1c2VkIGZvciBWR0EgZW11bGF0aW9uIGFuZCBwcmUtT1Mgc2Nhbm91dCBidWZmZXJzIHRvCiAJ
ICogYXZvaWQgZGlzcGxheSBhcnRpZmFjdHMgd2hpbGUgdHJhbnNpdGlvbmluZyBiZXR3ZWVuIHBy
ZS1PUwogCSAqIGFuZCBkcml2ZXIuICAqLwotCXIgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChh
ZGV2LCBhZGV2LT5nbWMuc3RvbGVuX3NpemUsIFBBR0VfU0laRSwKLQkJCQkgICAgQU1ER1BVX0dF
TV9ET01BSU5fVlJBTSwKLQkJCQkgICAgJmFkZXYtPnN0b2xlbl92Z2FfbWVtb3J5LAotCQkJCSAg
ICBOVUxMLCAmc3RvbGVuX3ZnYV9idWYpOworCXIgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbF9h
dChhZGV2LCAwLCBhZGV2LT5nbWMuc3RvbGVuX3NpemUsCisJCQkJICAgICAgIEFNREdQVV9HRU1f
RE9NQUlOX1ZSQU0sCisJCQkJICAgICAgICZhZGV2LT5zdG9sZW5fdmdhX21lbW9yeSwKKwkJCQkg
ICAgICAgJnN0b2xlbl92Z2FfYnVmKTsKIAlpZiAocikKIAkJcmV0dXJuIHI7CiAKLS0gCjIuMjUu
NAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
