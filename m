Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F676C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E973960FF1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E973960FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83196EC7F;
	Fri, 16 Apr 2021 16:57:27 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E2E96EC0F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:38:05 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id e14so42447201ejz.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZGyBouBX1Ggemr68Q6SGgePttKsGtb3+vFBnPKj0XKk=;
 b=zjKlrXCCCLp6PJd5mtBzTp6pYWfRMDUvqt2BWn+2iebcYzB4ncO09SI9ON5trK0Mam
 CjIjMhDYpJVSXmm7/T0jadBr3NikpYMCeaOhRFojpAVKzAabEx/CVte0Gsuqae2S6xdV
 m3ofbSyWJjul6HlGEexA3HzhJU5ERte6rjduLZpYCQX0D4qDhYvh11cZADkRRa7D7mVt
 VaRx3PHxNHgjRg+6O+QBVcbacEUXpPkop3e7KMFlSAGu8MI7ygi2QSXMBTeRYbMul+4O
 INtlWgVewA6b6Z4apPq07djKAEmY/3meppvazfhHplENudSCo2rSXtEgAI631O5pEX09
 HbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZGyBouBX1Ggemr68Q6SGgePttKsGtb3+vFBnPKj0XKk=;
 b=UDfjJ1TreGiofyWrFoOJ5WOaYEDGzGnnapQuiNZ85Or6GxBSvSazQdB9ri7M6Ei/e/
 iCfeSo+Ht6wTQX+wijueikx5Ss41eN2x7evOowGlmzGbeniJ7mNIRyahtdSOfperJaHq
 Y+JISXLefMMkoKIRoIQhu4Nct0OHhY/1ddEeepxGhWubI8C7adhoXh4ITeQ7n2bLOI/Y
 2YFP6jV1hRSCaeYKzDOw/fRDP5czYTbiPzBjZgUEiNCWvVOOIrzC+9J4J/XC+aWvkVjc
 bmqONDgRV4SOuZq6w/Wn4F0GMv2QEMs4fnceAKOWAwpIFMsMS2EYUpk8o5mVcbFBQW4q
 L9rA==
X-Gm-Message-State: AOAM533F9FHvtmfDMG2nvsCTGtq/YHOHORQztTH3oK3Ix2eYuQP7gB+r
 UQXCn+HcVH2mUfQDo/r1q4v/Gw==
X-Google-Smtp-Source: ABdhPJws+FLe7plPr6Ort0gG8DuAX1ky+aZQxssJs5xmE11JaLd6HoX6Enf722QkwyFmK8phDKpX0Q==
X-Received: by 2002:a17:906:a20c:: with SMTP id
 r12mr8482174ejy.554.1618583883851; 
 Fri, 16 Apr 2021 07:38:03 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 07:38:03 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 32/40] drm/amd/amdgpu/amdgpu_ttm: Fix incorrectly documented
 function 'amdgpu_ttm_copy_mem_to_mem()'
Date: Fri, 16 Apr 2021 15:37:17 +0100
Message-Id: <20210416143725.2769053-33-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 16 Apr 2021 16:57:23 +0000
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
 linaro-mm-sig@lists.linaro.org, Jerome Glisse <glisse@freedesktop.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jOjMxMTogd2FybmluZzogZXhwZWN0aW5n
IHByb3RvdHlwZSBmb3IgYW1kZ3B1X2NvcHlfdHRtX21lbV90b19tZW0oKS4gUHJvdG90eXBlIHdh
cyBmb3IgYW1kZ3B1X3R0bV9jb3B5X21lbV90b19tZW0oKSBpbnN0ZWFkCgpDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBTdW1pdCBTZW13YWwg
PHN1bWl0LnNlbXdhbEBsaW5hcm8ub3JnPgpDYzogSmVyb21lIEdsaXNzZSA8Z2xpc3NlQGZyZWVk
ZXNrdG9wLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcK
Q2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV90dG0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwppbmRleCAz
YmVmMDQzMmNhYzJmLi44NTkzMTRjMGQ2YTM5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3R0bS5jCkBAIC0yODgsNyArMjg4LDcgQEAgc3RhdGljIGludCBhbWRncHVfdHRtX21h
cF9idWZmZXIoc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpibywKIH0KIAogLyoqCi0gKiBhbWRn
cHVfY29weV90dG1fbWVtX3RvX21lbSAtIEhlbHBlciBmdW5jdGlvbiBmb3IgY29weQorICogYW1k
Z3B1X3R0bV9jb3B5X21lbV90b19tZW0gLSBIZWxwZXIgZnVuY3Rpb24gZm9yIGNvcHkKICAqIEBh
ZGV2OiBhbWRncHUgZGV2aWNlCiAgKiBAc3JjOiBidWZmZXIvYWRkcmVzcyB3aGVyZSB0byByZWFk
IGZyb20KICAqIEBkc3Q6IGJ1ZmZlci9hZGRyZXNzIHdoZXJlIHRvIHdyaXRlIHRvCi0tIAoyLjI3
LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
