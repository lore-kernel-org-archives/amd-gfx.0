Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FC7C47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CCC60FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CCC60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ADBF6ECFB;
	Wed, 26 May 2021 12:57:29 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC7C56E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:51 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 s5-20020a7bc0c50000b0290147d0c21c51so27660wmh.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GJer5W/toWhPsUhogBXg4zIXSRSHg7fRSySLo0mmvxU=;
 b=c4kUnaRXN1uSNT9CNqKjLxGgwMYV5KPLAkWSyqK5DOgFijFCdPEer5ag+RhVskDw8W
 xD5Wm1G3uhkJQFCh9CEozH8HaqWRsKb3lQa6A8QKchsv4XF45F0g4L4kIRz9YnJzeM6J
 R9O4BkOK8yTJg2L9Eh3RQJB2LisUZWeHoD0TKD7j6TAOWauUevORNcMzXlaLCANb+nWS
 vhmPGu+ZC+SIosHydMuuyePzdK5IqegCQydfd8NglfJf/fOqcywr3kvB2QvDWBTF3LPY
 XXV0kLgr0qrY8mZm+YmZwRmFB/vZoQRUvj0bOzwp3/0UAd60jYd5IU8l8stUaFHUn7kj
 YJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GJer5W/toWhPsUhogBXg4zIXSRSHg7fRSySLo0mmvxU=;
 b=O67wd8MM/IzefMajURjSNFkLrwZUjgMvQeyDUMP/e3e1YJWfXr+stzoAF8Rp/J4HxE
 +MyUWzP2QiNT0fu2uGPCNPs8ZKDpxFaMziHiDahpQsuk8s+zlxara79LNFjKM2zJdJRg
 VPcjj4VOrYqEO6TlBTRy2eRYE8Ia8IZqxtMURdazcBh+rlKNuVus/Ut6itqNCSghl1y8
 cXCubiS7C7FeLLw8FN9yNUzRau/hqoy231AJ/Vxw2gNSwGN2jve0srWD+FGGUIVXIn3j
 6fgQMrISyoD4ZKyBuCIXUWdDTT3X3UjEmww3rxrcqM3gOOzVdaSZvdgYBcbITLXhbUhY
 a6xw==
X-Gm-Message-State: AOAM533zWj2o5PPy+Tan3ivZICiPwubK07ZR7qoNogh9gGY5ua87D9Kc
 QZU8t+omQkpS/TwB3RPv4TS1iA==
X-Google-Smtp-Source: ABdhPJwHBmPkTr0OwYKxXZYQj65BdllZ8Ja6Z0GE6xo0CnlLEphmyzg+9I2oJbQU8XCK/MwCALnPqg==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr1717895wmg.108.1622018870506; 
 Wed, 26 May 2021 01:47:50 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:50 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 19/34] drm/amd/amdgpu/amdgpu_device: Make local function static
Date: Wed, 26 May 2021 09:47:11 +0100
Message-Id: <20210526084726.552052-20-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jOjQ2MjQ6Njogd2FybmluZzogbm8g
cHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhhbWRncHVfZGV2aWNlX3JlY2hlY2tfZ3VpbHR5X2pv
YnPigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVs
IFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxA
bGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2
ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcK
Q2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
YwppbmRleCA0YTA0MGY4OWNhNWFhLi5mMTVlMTgwNzYyZDJlIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC00NjkyLDcgKzQ2OTIsNyBAQCBzdGF0aWMg
aW50IGFtZGdwdV9kZXZpY2Vfc3VzcGVuZF9kaXNwbGF5X2F1ZGlvKHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogCXJldHVybiAwOwogfQogCi12b2lkIGFtZGdwdV9kZXZpY2VfcmVjaGVja19n
dWlsdHlfam9icygKK3N0YXRpYyB2b2lkIGFtZGdwdV9kZXZpY2VfcmVjaGVja19ndWlsdHlfam9i
cygKIAlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGxpc3RfaGVhZCAqZGV2aWNl
X2xpc3RfaGFuZGxlLAogCXN0cnVjdCBhbWRncHVfcmVzZXRfY29udGV4dCAqcmVzZXRfY29udGV4
dCkKIHsKLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
