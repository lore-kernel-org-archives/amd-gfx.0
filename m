Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891E6C47089
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566FF60FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566FF60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 099436ECF4;
	Wed, 26 May 2021 12:57:29 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2DD76E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:53 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id b191so250692wmd.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qhZgrAainLjec7+hq499eXjP+VFgJtwYW3msrbGd3QA=;
 b=e/cES6WXNf9+ZpY2D4VLQY1tDCYiL+YmBb4TxjZ2Yg7Tqivde+ECExm/VjRqhPnSwP
 pF8Dg4H6EuHK4qbZbPO+DGRTYWw4TuhME6GXJsqxUD9gzvrooDgB5lB8x9xiKzGig67T
 N8NBqVRkw51z8HuTtm2qK+cELNmbWunRFkBF6EJNSbgv7ANarLKuUJxEP+7/qMIYa+of
 HFTWFAqci9XzxxOxAndpAr5puhN1ats8ehvfyxupcGhc+COIFf7zIjylco2BMp0a5E+T
 WMrfVMcOJM1+t4t2yLfbGAPFUfRKjdwV6HG4pMnW90cWxOBzU2w//zjuoMjZbJ+iFBf5
 /dOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qhZgrAainLjec7+hq499eXjP+VFgJtwYW3msrbGd3QA=;
 b=qKpP3YvEFdy3Dn9v4sNoHNFly9h+JyS9Oq6KDawdnMZCnNSh73N05PZYGK+gle4Jxw
 1XWTw9UZ8K8rPgGOVR5vsp7C56oONztbtvVyslWtRu3T9MlDg7DmXtULUTLR8Gga4DDQ
 NG3xU+FvhVc+FEP8Ynmhq24l/V0L4OfBD05t0u2/Fc0yD/8Ak05IjASBIdxNQtZmxM18
 8C7LbPmNowytZeF/mVVrQFH+Z3haVvzAACHAk6zlFA8S3qjKWoIxG0ZIAP03xc4qGkuM
 mx1e5jdVP5xW12vfZk37Xj6mvhnu5LHkwL0JHRqyre3tUTN2W88qf2MEMfMZpYWU81+G
 sMCA==
X-Gm-Message-State: AOAM533xyZTIVpu75lv/WGhcUQZdfmcsNrOHLvlpwgMQBiXz/fFl7gun
 1SQrs3A5lFLzAIZVY7nlEmxMhQ==
X-Google-Smtp-Source: ABdhPJydthfwy6pyhiwfSi4Vw978YT5WPdxv2u67ek+4Ky6PZ2aPSphUROb7xbK91WYE7mAK79UCfQ==
X-Received: by 2002:a1c:c911:: with SMTP id f17mr28332218wmb.45.1622018872593; 
 Wed, 26 May 2021 01:47:52 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:52 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 21/34] drm/amd/display/dc/dce110/dce110_hw_sequencer: Include
 header containing our prototypes
Date: Wed, 26 May 2021 09:47:13 +0100
Message-Id: <20210526084726.552052-22-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3X3NlcXVl
bmNlci5jOjkyOTo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTEx
MF9lZHBfd2FpdF9mb3JfVDEy4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KCkNjOiBIYXJyeSBX
ZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBh
bWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzog
IkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBB
aXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEw
X2h3X3NlcXVlbmNlci5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9o
d19zZXF1ZW5jZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNl
MTEwX2h3X3NlcXVlbmNlci5jCmluZGV4IDkyMTlkYjc5ZjMyYjYuLjFlZjFiMWIzM2ZiMDkgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX2h3
X3NlcXVlbmNlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAv
ZGNlMTEwX2h3X3NlcXVlbmNlci5jCkBAIC02NCw2ICs2NCw3IEBACiAjaW5jbHVkZSAiYXRvbWZp
cm13YXJlLmgiCiAKICNpbmNsdWRlICJkY2UxMTBfaHdfc2VxdWVuY2VyLmgiCisjaW5jbHVkZSAi
ZGNuMTAvZGNuMTBfaHdfc2VxdWVuY2VyLmgiCiAKICNkZWZpbmUgR0FNTUFfSFdfUE9JTlRTX05V
TSAyNTYKIAotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
