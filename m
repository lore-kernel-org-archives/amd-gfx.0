Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A6C47089
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353E261090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353E261090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9783A6ECE0;
	Wed, 26 May 2021 12:57:24 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217B26E4C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:42 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id z17so198331wrq.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S7Vhy55irc0KIRnoY1AtIhd7OdR89vjnmNeVszJAECQ=;
 b=eOgEFPmvC30HjVNA4Cq3235ugvwODQjfTMEVmYHNrTdvhnuoAsJejtxVRd3f8oj5Wi
 oRQQEFGbC4NXCz0QMPmwIR9qxYU8DlpvdkfUMHtBfcdLhB4yMFUMnzwNIY9CtmqCJTHl
 O+HbpzWWWcraBqJj1gRG9fQMp6wrPlO13d0Bi4B96ycuqw9dL+o0N7dsrc6tiDzncxrL
 HsIEr8NJ/tttK8hTKWsYTDcPjNF/E2lrmYRacRhA6AgqtomdIxPuOSSeTso+7plsZXSX
 OwoSpcUV7EtXkzV5ljXXYXBGzsjWUHAErFwWrwqJ44PkNDBRO9w9EIZjfw5teG+aul48
 hnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S7Vhy55irc0KIRnoY1AtIhd7OdR89vjnmNeVszJAECQ=;
 b=to3W0z1fRUyJ6BkoJkT+LS3iSEojIH5mAnJVh9CSOEFvmn+/7M6yZN07qyKZin/cYS
 Me0SpnClGDSK7gQ7ZERZ8b203M2uLvJ8gtjq+j1KTZr4GtGIP4EbBv5KK9MDZfW72pM/
 jp6FDSLIRBc4n55yKRhyFfwZabobduCo9CajtwgTMacDoN9sm6kK3zOtrlANFRzgVYfW
 zjVWP7WNLvja/Jf9P5b3YA4v4GA1p5XYV125FR5X9NN5DOFbRroiDrDOfDSlv8x/0Mxf
 IAD5cWpgj+FBFe7QVmxStMZFvfZtYxEufB39o65/AY2vW9Duw2GWB6v17aXUOfRsejI+
 q7+A==
X-Gm-Message-State: AOAM530GZ/0P7YU805kMGNkBs24VyjiLRGp6r54TCWge2wqPr2BM1ZNc
 Si2zBfSEh9jlv6pufV5m+4ZVlA==
X-Google-Smtp-Source: ABdhPJxE0BtwOIYQjuYn6Y7+Q6ACbzICk5aAr0XXdSoA3yVkfOmmF2TnwfLbYcp+4PimxnS4+0XwlA==
X-Received: by 2002:adf:a2de:: with SMTP id t30mr16243809wra.104.1622018860628; 
 Wed, 26 May 2021 01:47:40 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:40 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 10/34] drm/amd/display/dc/bios/bios_parser: Fix formatting and
 misnaming issues
Date: Wed, 26 May 2021 09:47:02 +0100
Message-Id: <20210526084726.552052-11-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmM6OTk3
OiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciBnZXRfc3NfaW5mb19mcm9tX3RhYmxl
KCkuIFByb3RvdHlwZSB3YXMgZm9yIGdldF9zc19pbmZvX2Zyb21fdGJsKCkgaW5zdGVhZAogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmM6
MTU2Mjogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgQmlvc1BhcnNlck9iamVjdCgp
LiBQcm90b3R5cGUgd2FzIGZvciBiaW9zX3BhcnNlcl9nZXRfc3NfZW50cnlfbnVtYmVyKCkgaW5z
dGVhZAogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2Jpb3Nf
cGFyc2VyLmM6MTczOTogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgZ2V0X3NzX2Vu
dHJ5X251bWJlcl9mcm9tX2ludGVybmFsX3NzX2luZm9fdGFibGVfVjNfMSgpLiBQcm90b3R5cGUg
d2FzIGZvciBnZXRfc3NfZW50cnlfbnVtYmVyX2Zyb21faW50ZXJuYWxfc3NfaW5mb190YmxfVjNf
MSgpIGluc3RlYWQKCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4K
Q2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5p
ZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNA
bGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9z
X3BhcnNlci5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2Jpb3MvYmlvc19wYXJzZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9z
L2Jpb3NfcGFyc2VyLmMKaW5kZXggYzY3ZDIxYTVlZTUyZi4uOWI4ZWE2ZTlhMmI5NiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19wYXJzZXIuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlci5jCkBA
IC05NzksNyArOTc5LDcgQEAgc3RhdGljIGVudW0gYnBfcmVzdWx0IGdldF9zc19pbmZvX2Zyb21f
aW50ZXJuYWxfc3NfaW5mb190YmxfVjJfMSgKIAlzdHJ1Y3Qgc3ByZWFkX3NwZWN0cnVtX2luZm8g
KmluZm8pOwogCiAvKioKLSAqIGdldF9zc19pbmZvX2Zyb21fdGFibGUKKyAqIGdldF9zc19pbmZv
X2Zyb21fdGJsCiAgKiBHZXQgc3ByZWFkIHNwcmVjdHJ1bSBpbmZvcm1hdGlvbiBmcm9tIHRoZSBB
U0lDX0ludGVybmFsU1NfSW5mbyBWZXIgMi4xIG9yCiAgKiBTU19JbmZvIHRhYmxlIGZyb20gdGhl
IFZCSU9TCiAgKiBUaGVyZSBjYW4gbm90IGJlIG1vcmUgdGhhbiAxIGVudHJ5IGZvciAgQVNJQ19J
bnRlcm5hbFNTX0luZm8gVmVyIDIuMSBvcgpAQCAtMTU0OCw3ICsxNTQ4LDcgQEAgc3RhdGljIHVp
bnQzMl90IGdldF9zc19lbnRyeV9udW1iZXJfZnJvbV9zc19pbmZvX3RibCgKIAl1aW50MzJfdCBp
ZCk7CiAKIC8qKgotICogQmlvc1BhcnNlck9iamVjdDo6R2V0TnVtYmVyb2ZTcHJlYWRTcGVjdHJ1
bUVudHJ5CisgKiBiaW9zX3BhcnNlcl9nZXRfc3NfZW50cnlfbnVtYmVyCiAgKiBHZXQgTnVtYmVy
IG9mIFNwcmVhZFNwZWN0cnVtIEVudHJ5IGZyb20gdGhlIEFTSUNfSW50ZXJuYWxTU19JbmZvIHRh
YmxlIGZyb20KICAqIHRoZSBWQklPUyB0aGF0IG1hdGNoIHRoZSBTU2lkICh0byBiZSBjb252ZXJ0
ZWQgZnJvbSBzaWduYWwpCiAgKgpAQCAtMTcyNSw3ICsxNzI1LDcgQEAgc3RhdGljIHVpbnQzMl90
IGdldF9zc19lbnRyeV9udW1iZXJfZnJvbV9pbnRlcm5hbF9zc19pbmZvX3RibF92Ml8xKAogCXJl
dHVybiAwOwogfQogLyoqCi0gKiBnZXRfc3NfZW50cnlfbnVtYmVyX2Zyb21faW50ZXJuYWxfc3Nf
aW5mb190YWJsZV9WM18xCisgKiBnZXRfc3NfZW50cnlfbnVtYmVyX2Zyb21faW50ZXJuYWxfc3Nf
aW5mb190YmxfVjNfMQogICogR2V0IE51bWJlciBvZiBTcHJlYWRTcGVjdHJ1bSBFbnRyeSBmcm9t
IHRoZSBBU0lDX0ludGVybmFsU1NfSW5mbyB0YWJsZSBvZgogICogdGhlIFZCSU9TIHRoYXQgbWF0
Y2hlcyBpZAogICoKLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
