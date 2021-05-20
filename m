Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92072C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CCB261001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CCB261001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 877CC6F453;
	Thu, 20 May 2021 12:49:11 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19206F42A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:36 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id z17so17372228wrq.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yuvzJ7XKyB2J8XQ1p95NuNGQFyxLRMRhEwI7C8RcNw8=;
 b=KyloU0Voex0hBA1Vx66+tEWWQZSCdnxYcCTC9umTlXk2zRxDTFsqFUwWYcXMI55fpw
 ENKGyXCKnhBGEV7Dp0TCokF1f7aFF3VqhQ8JHMJb8TCCO7bG5a29KxxBijKLRur7EiWk
 TxQoHuk1+XSmKHRK/beFAE08KhwcQNYY/Nh6/KbpAeHraYFF6nQIVAdVrj8qay8qdJOe
 vac1Q+oLGtJH/WukRqAUD4Dq6aKwi9vX0isP8Rhb/LuvpCeG0ju/5erm5eesC0yaV/cG
 LSBgbZrY3r05ZoFaJPbh6jdbqCB2Lhg5D2/LZD6itG6VLVoOavS+G5pLuI21bl23jZ/B
 M0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yuvzJ7XKyB2J8XQ1p95NuNGQFyxLRMRhEwI7C8RcNw8=;
 b=G7bbZVrSyF9KoSQZwie/FV0fSA3VGi9c2vqGkc3fULj5oLrpNVMErUpIAEnhQ2fqb0
 RzkmL/p0iE++iQljkfzNBiGfC91PcuzCcff11+Hss98Gcae3CcZ4kMJFB3IF8Hr17VcZ
 W1T/B7AukcViZG0bh2fakx1oawes/TyPQeJsQ9QGd8Xku6qeYmk4ZOy7/4T4i9tX16ai
 BvoV0Pr9VYgl5HrfcDFjrFAUOgyy9dHkwizH8q1apjN60HYuRJ0RKfv4Ck7+zj+PtH50
 fZhcpWB1VQXpVbC2K9Lvp36HwQQ8FyQ/ZUddG9EARJKgoo/VBgl8PBOm9RSC11lvDBm6
 CWbQ==
X-Gm-Message-State: AOAM532XzOreghGBaZK3gFAmdUXeRCukqyyct6eoZeS1Xi6lRWPvD/pM
 WWfyjGVnTFkdhSYYt3Lz+oHiLA==
X-Google-Smtp-Source: ABdhPJy0xmbVP0jsnJYQuIk/ot8CWGqLOEp/599UQ2CXy8d5CQ9PYnIIK35Er7h+2CYObNbUZS63DQ==
X-Received: by 2002:a5d:4536:: with SMTP id j22mr3889313wra.329.1621512215520; 
 Thu, 20 May 2021 05:03:35 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:34 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 33/38] drm/amd/amdgpu/sdma_v5_0: Fix typo in function name
Date: Thu, 20 May 2021 13:02:43 +0100
Message-Id: <20210520120248.3464013-34-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmM6NTYzOiB3YXJuaW5nOiBleHBlY3Rpbmcg
cHJvdG90eXBlIGZvciBzZG1hX3ZfMF9jdHhfc3dpdGNoX2VuYWJsZSgpLiBQcm90b3R5cGUgd2Fz
IGZvciBzZG1hX3Y1XzBfY3R4X3N3aXRjaF9lbmFibGUoKSBpbnN0ZWFkCgpDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwg
PHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGxpbnV4LW1lZGlhQHZn
ZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5saW5hcm8ub3JnClNpZ25lZC1v
ZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2RtYV92NV8wLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zZG1hX3Y1XzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVf
MC5jCmluZGV4IDc1ZDczMTBmODQzOTIuLjJhMmI5ZDUwYWZiNzAgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L3NkbWFfdjVfMC5jCkBAIC01NzEsNyArNTcxLDcgQEAgc3RhdGljIHZvaWQgc2Rt
YV92NV8wX3JsY19zdG9wKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogfQogCiAvKioKLSAq
IHNkbWFfdl8wX2N0eF9zd2l0Y2hfZW5hYmxlIC0gc3RvcCB0aGUgYXN5bmMgZG1hIGVuZ2luZXMg
Y29udGV4dCBzd2l0Y2gKKyAqIHNkbWFfdjVfMF9jdHhfc3dpdGNoX2VuYWJsZSAtIHN0b3AgdGhl
IGFzeW5jIGRtYSBlbmdpbmVzIGNvbnRleHQgc3dpdGNoCiAgKgogICogQGFkZXY6IGFtZGdwdV9k
ZXZpY2UgcG9pbnRlcgogICogQGVuYWJsZTogZW5hYmxlL2Rpc2FibGUgdGhlIERNQSBNRXMgY29u
dGV4dCBzd2l0Y2guCi0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
