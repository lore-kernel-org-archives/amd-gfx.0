Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2961C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B397C22B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B397C22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC266E10E;
	Mon, 11 Jan 2021 19:54:48 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6150C89DD5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:38 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id c5so928894wrp.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wtAOwEmizSXmIkh30HKF25wTD18EAWpeWdhE7dkllNs=;
 b=fCyZq859P/dQeCyH44t2M93b+LQoVV7yA3BytWDVSHDCdpZj6czSYW8EQ493I11nZp
 TZLM8h9nbvI2ZSsDZ0F8ayzF1C0O+gVE3/ADElNiHrZ2OpcbodJ1pri3ZkxpU+ZxMz2C
 c/wfj4zzfbwk83kz3MsPJvWnnwj9kV8ZZGu/BYNeUEBCIVx/+M9UCiZytPHwoyJzOv1O
 EN8cE7QnMbiH3S7GnGgttIwXekKJseeGIsAkX6lFUjsUGz0Pk/XMypkchaaWWYtw0Pyv
 +SnwI8P7rBZIyj8cG13pJICOXd55WIo9KBphj19oSbkeD+UE3HvYdMMi9p0g/EMl349v
 V5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wtAOwEmizSXmIkh30HKF25wTD18EAWpeWdhE7dkllNs=;
 b=lAQ7tokqrH36v0SSxN0113adRcs6wNiOmLLeJbLkneGDrbCM+sKHA+T8Acp+VBuqSA
 4svRcqmEbi0cBRG0ICHWbo0AMpHFsmQgJ/WKLYoxxned3P/KZcFDa2ZHofNgC0C+aZpD
 y4m/j3mz7gothaABq9XdxGT8NXji0B37ucMkDtHkpF97y6VgKh8hdq3TtfHvQ3AeVI+q
 RVEVVld9WdZSp0bkIpAnBR+1XF7LXY2cuxc8VMRCQnZUV5Bx2OL1dwn5e4UyLGsxFW3B
 KsSd7gcw7iPTgWSLS9nOCwiN/WSeSvo8wslOJJCGvpu0yOmioeOMwp9b7H5XtCYB4Mzc
 lV3g==
X-Gm-Message-State: AOAM530lA3KWbfYd8thUPMG568nDdqUYiYGCMq7j9fD9yMsZqTWmZUU5
 xh5WbHOPzrtIY95tHRhMhhuNGw==
X-Google-Smtp-Source: ABdhPJxZvh7UGiKoLb3bQAdGOE/yM4veJW9oQ2ZzPN/cB2f7BL75dwU9v6EuG8b27l35DZYuMy6gXQ==
X-Received: by 2002:a5d:50c3:: with SMTP id f3mr555705wrt.287.1610392777131;
 Mon, 11 Jan 2021 11:19:37 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:36 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 05/40] drm/amd/display/dc/dce/dce_transform: Demote kernel-doc
 abuse
Date: Mon, 11 Jan 2021 19:18:51 +0000
Message-Id: <20210111191926.3688443-6-lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlIGhlYWRlciBkb2Vzbid0IHByb3ZpZGUgYW55IGFkZGl0aW9uYWwgcGFyYW1ldGVyIGRlc2Ny
aXB0aW9ucy4KCkZpeGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nKHMp
OgoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV90cmFu
c2Zvcm0uYzoxMTA0OiB3YXJuaW5nOiBDYW5ub3QgdW5kZXJzdGFuZCAgKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioKCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExl
byBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBNYXVybyBSb3NzaSA8aXNzb3Iub3J1YW1AZ21haWwu
Y29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV90cmFu
c2Zvcm0uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNl
X3RyYW5zZm9ybS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfdHJh
bnNmb3JtLmMKaW5kZXggNjEyMWJiN2IwMDliOC4uYWJiYWE2YjBiMmRiOSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfdHJhbnNmb3JtLmMKQEAgLTEx
MDAsNyArMTEwMCw3IEBAIHN0YXRpYyB2b2lkIHByb2dyYW1fZ2FtdXRfcmVtYXAoCiAKIH0KIAot
LyoqCisvKgogICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiAgKiAgRnVuY3Rpb246IGRhbF90cmFuc2Zv
cm1fd2lkZV9nYW11dF9zZXRfZ2FtdXRfcmVtYXAKICAqCi0tIAoyLjI1LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
