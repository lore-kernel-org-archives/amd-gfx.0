Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C400C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29C322A83
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29C322A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213236E096;
	Mon, 11 Jan 2021 19:54:44 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2460E89DCF
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:33 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id d26so885836wrb.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RuOitA3aMnrp8CglwtShTzzn7jDAI9y/ji+mu/BKLpU=;
 b=FHGS3Yz4+1uqLaYb51IUybjr25DwHxn1LcCJZAw4g9amf/enmcfg+DhtQu8GqokZvd
 bDFkCeC4jt80rWilLOaSekS/ChX6BJgQBMXV0oKw57dzcusfRhsmLBxSqlDnqxm+FW32
 pHB7qQWTfaCxgNNQIM25xK+ga20o2fgDYfu5ed5Mz0vmCd8ZxWEwo/tVRYMUgkx841kE
 RAqQLZd4dmSTHYAEVuJMgSnOCJI8bCU9jORkq7sogYyYD2+mw/h7s51KSuIWtIf31tVm
 BamR5VUzQNm9cTnCJkfVSUD3oGWvdBUFwKe3yWpLxI6pv9zC4enlxSoaogztlqTzEf8Z
 jcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RuOitA3aMnrp8CglwtShTzzn7jDAI9y/ji+mu/BKLpU=;
 b=bSz2eKTVWcclAQFem2vzvTYr+Q6U1D2diDE8mZ78TLvUunRrbLkKWa9gR4TJk7HUEH
 ErPIOcw+9svUCc0pZ4crL7bpSMoXevkDduqbD2rKKYKs5XDANrKNi38v3LF6++0VWMvn
 ft+0J4c958y/9/1ENYdnFbcHZobGCfiyntYrOkxs10VduyBLgSRBExjt/953WhtG+mtS
 8JUKN/rbz4ekXMMkah8ldb+8/RnwVx0uyfYwxlXlysFSQrs41u2x8JucCZ4CqwHIzSRV
 5AlmvZpMvIMRsaszAis8Vm/PFyHd8YxedwcrsyNcJi5HT0sQBHN6BfCwnBjFXbfHNT6a
 XDlA==
X-Gm-Message-State: AOAM531pQabr6DZw5LfoySu12Yh2dv1LVta2u9Cb/j8lF3kQRtTl2YsX
 t4urga5Kx+Mzfkh0eygUNFQbMQ==
X-Google-Smtp-Source: ABdhPJy5k5eTrlHXOd41/BzzmGq1UKuzMUpQHvfEJQfMsk1I4ii8bHCBtOi5cka5gfRVT5eRzU1n2A==
X-Received: by 2002:adf:c454:: with SMTP id a20mr594473wrg.314.1610392771765; 
 Mon, 11 Jan 2021 11:19:31 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:31 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 01/40] drm/amd/display/dc/dce/dce_aux: Mark
 'dce_aux_transfer_raw' as __maybe_unused
Date: Mon, 11 Jan 2021 19:18:47 +0000
Message-Id: <20210111191926.3688443-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Jan 2021 19:54:43 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5jOiBJbiBmdW5j
dGlvbiDigJhkY2VfYXV4X3RyYW5zZmVyX3Jhd+KAmToKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguYzo1Nzk6Nzogd2FybmluZzogdmFyaWFibGUg
4oCYYnl0ZXNfcmVwbGllZOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZh
cmlhYmxlXQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzog
TGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBW
ZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
CkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjZS9kY2VfYXV4LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNlL2RjZV9hdXguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2Uv
ZGNlX2F1eC5jCmluZGV4IDMyMDQyOTJhNWFlYWUuLmQ1MWI1ZmU5MTI4N2QgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5jCkBAIC01NzYsNyArNTc2LDcg
QEAgaW50IGRjZV9hdXhfdHJhbnNmZXJfcmF3KHN0cnVjdCBkZGNfc2VydmljZSAqZGRjLAogCSpv
cGVyYXRpb25fcmVzdWx0ID0gZ2V0X2NoYW5uZWxfc3RhdHVzKGF1eF9lbmdpbmUsICZyZXR1cm5l
ZF9ieXRlcyk7CiAKIAlpZiAoKm9wZXJhdGlvbl9yZXN1bHQgPT0gQVVYX0NIQU5ORUxfT1BFUkFU
SU9OX1NVQ0NFRURFRCkgewotCQlpbnQgYnl0ZXNfcmVwbGllZCA9IDA7CisJCWludCBfX21heWJl
X3VudXNlZCBieXRlc19yZXBsaWVkID0gMDsKIAkJYnl0ZXNfcmVwbGllZCA9IHJlYWRfY2hhbm5l
bF9yZXBseShhdXhfZW5naW5lLCBwYXlsb2FkLT5sZW5ndGgsCiAJCQkJCSBwYXlsb2FkLT5kYXRh
LCBwYXlsb2FkLT5yZXBseSwKIAkJCQkJICZzdGF0dXMpOwotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
