Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF68C6379D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E04020872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAjDd7pm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E04020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A761D6E90A;
	Wed, 25 Nov 2020 08:23:01 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7FB6E544
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:24 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id e7so6012827wrv.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mq7PbL6cgpxSOWqLpcSVIbGFAt/shGYJ2nDJJPb1ufM=;
 b=QAjDd7pmP9wSTKQGaUOswEXbxCamu68E+cgIDCWwIrdnY0TW1G88r+c9TTWlZxqPLu
 7zv57v0Szlbn1mpzLQt4tsC/2toJ6vwn/sSzjRXrD1qEbZT4/Wly/JbfeTn2S8Onw8mm
 wafWqtAt1WOMYWSwYeYnbnER09/6WLcU+HY/BruiZW5oXEq2u3SnvrTMAnvvloBCMAsO
 F1ZeEw24FGMFgL6LV8uNQyeg0Wj7lCIE9w3Il2U5NuAW84yje7bLFC8vlLIyg7NF63gh
 OnBw2tMVefWwP6rI4Cgnvl15GE79M3rLSQtm3G41mlKKofO+MUlFxyrET/gENNtjmohn
 7adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mq7PbL6cgpxSOWqLpcSVIbGFAt/shGYJ2nDJJPb1ufM=;
 b=HjxcDcW1iSMn+JSp2vJsTLvUfLXNpApxxutb4F5Su58V1mmT2DzDb4bTdUQamxyQR/
 nX7EMwkk8kidDuXdTTtn6LY3o7ECkliPrMyy/tl0QLoEAWztC6QQVgm3YhT1UxV9/VWK
 IbmQcuR/A8pPUPCuFlfDm/HfJEcwCh80mKquUXqDRCE3vMC/vitzVZOMj412M9OTE/Dm
 cmpNUTeoMpXT1DJ4IhJidk7DbEcza1leolOIwhuOfVC2ol8mNtXT18e0B+I21HI2Tt4d
 BUMBPkessTpZKi2+W0dMViZJn+Rnmih5eNVJ7qxngCaUR3rlefC/CEZsmyLV4+Ig0TLF
 yRqA==
X-Gm-Message-State: AOAM533pBXH2IHy2g/gKfUCmHCKZF9G069j6ZKrW9KzZhznfooD+yHtx
 2vBuKosMc951Od1eBvgtskxcBA==
X-Google-Smtp-Source: ABdhPJw+kv1MDrGjFiOkLD0UZAOdz/00Mi3zE68PVR52zrFv9heQrl/sQOeaGCT/uADkZl+if9+Srw==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr77440wru.45.1606247062896;
 Tue, 24 Nov 2020 11:44:22 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:22 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 19/40] drm/amd/amdgpu/sdma_v3_0: Fix incorrect param doc-rot
 issue
Date: Tue, 24 Nov 2020 19:38:03 +0000
Message-Id: <20201124193824.1118741-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Nov 2020 08:22:58 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92M18wLmM6MTY1MTogd2FybmluZzogRnVuY3Rpb24g
cGFyYW1ldGVyIG9yIG1lbWJlciAnaWInIG5vdCBkZXNjcmliZWQgaW4gJ3NkbWFfdjNfMF9lbWl0
X2NvcHlfYnVmZmVyJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92M18wLmM6MTY1
MTogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAncmluZycgZGVzY3JpcHRpb24g
aW4gJ3NkbWFfdjNfMF9lbWl0X2NvcHlfYnVmZmVyJwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFu
aWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13
YWxAbGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5v
cmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NkbWFfdjNfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3YzXzAuYwppbmRleCA0
MzQxMGE3YmNjYzI1Li44Y2E3ZmJhOWMwMzVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9zZG1hX3YzXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
ZG1hX3YzXzAuYwpAQCAtMTYzMyw3ICsxNjMzLDcgQEAgc3RhdGljIHZvaWQgc2RtYV92M18wX3Nl
dF9pcnFfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAvKioKICAqIHNkbWFfdjNf
MF9lbWl0X2NvcHlfYnVmZmVyIC0gY29weSBidWZmZXIgdXNpbmcgdGhlIHNETUEgZW5naW5lCiAg
KgotICogQHJpbmc6IGFtZGdwdV9yaW5nIHN0cnVjdHVyZSBob2xkaW5nIHJpbmcgaW5mb3JtYXRp
b24KKyAqIEBpYjogaW5kaXJlY3QgYnVmZmVyIHRvIGNvcHkgdG8KICAqIEBzcmNfb2Zmc2V0OiBz
cmMgR1BVIGFkZHJlc3MKICAqIEBkc3Rfb2Zmc2V0OiBkc3QgR1BVIGFkZHJlc3MKICAqIEBieXRl
X2NvdW50OiBudW1iZXIgb2YgYnl0ZXMgdG8geGZlcgotLSAKMi4yNS4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
