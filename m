Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AFDC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9827723102
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9827723102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02D56E116;
	Wed, 13 Jan 2021 08:24:28 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E4E689FF6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:08:12 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id y187so712310wmd.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ByKcZ/QO4rFJCc5FU+7eSJHbQTpm5hWIxSF+UVUytQ8=;
 b=NAq8a9+7iN3iO3+wGaICi9lECx6GuUsRdw34OqLPJd3ZnN4FlYdrKOqwub8Fk6eMfh
 5Bilb12AFMTIT63HXIBA5+LWSgS7rO3RyBoAY3n95Hlk3xVW0JgnsHHsVlj2mMd6PZFj
 LWY9sx4YPT9Qp+J9Yw6KW5C4y7Y/amKNrO0DbOBA8TI4JPuT8DOnjpeYTsqac0Kl1uln
 ATiwk9dlj8bfyv6wJayo/nqxgUtP6p5On60pWJQN4v5ZO/xC8g6ekPxEM5cSCyzE1IOe
 fUpAFplHTp2bmIC4n/oV9/ggXw96rpMlD57erX667d2A2c5jRo5GwBM1r1F9xccT2vUn
 BrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ByKcZ/QO4rFJCc5FU+7eSJHbQTpm5hWIxSF+UVUytQ8=;
 b=cTwqRnzUCI0FA9FRR1kgNzAjLx4GP4aDhoew3nOr+PGiPK5HpoIaEgud58AuuPpuwi
 iuX/AWzoJQAg6F2kOuCjsvUDEz2w/MDaV8bB8nC50S+5TM3HTKDYlM1FamE3o2Ms/ekH
 SSNzObcri5eDwV3mTEiObwXTGAnplCv8HVVf4fIDVl4a8ZcRk2CRaIv9B5tfwzV6hA0k
 ck3rVXIRHwgvnpe50NQPa37tQETTY+NllyqKG4qw34Nrl8bSHj1FZcNQj2wPRsnpeXcQ
 1Mp8eTDBbV8BRU74bl8PIjZAzWY3jzUE5XW2i+4ZbstGq3/snOetGRPmoVXs5hyKjQ2C
 +b6g==
X-Gm-Message-State: AOAM53090q+P5oynHg2ugA3qEzKoFphemOaowB/Z1tkp6OBsWepVd5bg
 1O1fWEbUtbzpba2WNXZv79bZ6A==
X-Google-Smtp-Source: ABdhPJyixOcRMntyyEbwvGMK96ScnWqBXZFNvIivHM7pJ6Fo8CExy2eDANXqae2dONdp61qCKvDjmQ==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr909483wmj.159.1610525291245;
 Wed, 13 Jan 2021 00:08:11 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:08:10 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 12/30] drm/amd/display/dc/dce100/dce100_resource: Include our
 own header containing prototypes
Date: Wed, 13 Jan 2021 08:07:34 +0000
Message-Id: <20210113080752.1003793-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 13 Jan 2021 08:24:28 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNlMTAwL2RjZTEwMF9yZXNvdXJjZS5jOjU0OgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmM6NTM3OjM6IG5vdGU6IGluIGV4
cGFuc2lvbiBvZiBtYWNybyDigJhNSV9EQ0U4X01BU0tfU0hfTElTVOKAmQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmM6NTM3
OjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhNSV9EQ0U4X01BU0tfU0hfTElTVOKA
mQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAw
X3Jlc291cmNlLmM6NTQyOjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhNSV9EQ0U4
X01BU0tfU0hfTElTVOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9k
Yy9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmM6NTQyOjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBt
YWNybyDigJhNSV9EQ0U4X01BU0tfU0hfTElTVOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvLi4vZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmM6NTQ3OjI6IG5vdGU6IGlu
IGV4cGFuc2lvbiBvZiBtYWNybyDigJhEQ0UxMF9BVVhfTUFTS19TSF9MSVNU4oCZCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTEwMC9kY2UxMDBfcmVzb3VyY2Uu
Yzo1NDc6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmERDRTEwX0FVWF9NQVNLX1NI
X0xJU1TigJkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlMTAw
L2RjZTEwMF9yZXNvdXJjZS5jOjU1MToyOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8g4oCY
RENFMTBfQVVYX01BU0tfU0hfTElTVOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmM6NTUxOjI6IG5vdGU6IGluIGV4cGFu
c2lvbiBvZiBtYWNybyDigJhEQ0UxMF9BVVhfTUFTS19TSF9MSVNU4oCZCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTEwMC9kY2UxMDBfcmVzb3VyY2UuYzo4ODk6
MTY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZGNlMTAwX2FkZF9zdHJl
YW1fdG9fY3R44oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlMTAwL2RjZTEwMF9yZXNvdXJjZS5jOjkxNjoxNjogd2Fy
bmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhkY2UxMDBfdmFsaWRhdGVfcGxhbmXi
gJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmM6OTI1OjI0OiB3YXJuaW5nOiBubyBw
cmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTEwMF9maW5kX2ZpcnN0X2ZyZWVfbWF0Y2hfc3Ry
ZWFtX2VuY19mb3JfbGlua+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTEwMC9kY2UxMDBfcmVzb3VyY2UuYzoxMTU2
OjIzOiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmGRjZTEwMF9jcmVhdGVf
cmVzb3VyY2VfcG9vbOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCgpDYzogSGFycnkgV2VudGxh
bmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNv
bT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJp
c3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGll
IDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpD
YzogQW50aG9ueSBLb28gPEFudGhvbnkuS29vQGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQt
b2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmMgfCAyICsrCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjZTEwMC9kY2UxMDBfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY2UxMDAvZGNlMTAwX3Jlc291cmNlLmMKaW5kZXggNjQ4MTY5MDg2
YmNmOC4uNjM1ZWYwZTdjNzgyNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjZTEwMC9kY2UxMDBfcmVzb3VyY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlMTAwL2RjZTEwMF9yZXNvdXJjZS5jCkBAIC01OCw2ICs1OCw4IEBACiAj
aW5jbHVkZSAiZGNlL2RjZV9hYm0uaCIKICNpbmNsdWRlICJkY2UvZGNlX2kyYy5oIgogCisjaW5j
bHVkZSAiZGNlMTAwX3Jlc291cmNlLmgiCisKICNpZm5kZWYgbW1NQ19IVUJfUkRSRVFfRE1JRl9M
SU1JVAogI2luY2x1ZGUgImdtYy9nbWNfOF8yX2QuaCIKICNpbmNsdWRlICJnbWMvZ21jXzhfMl9z
aF9tYXNrLmgiCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAo=
