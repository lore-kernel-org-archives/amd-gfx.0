Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDFEFC4332B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877A022CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877A022CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73C76E117;
	Mon, 11 Jan 2021 19:54:49 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61ED589F3C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:20:08 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id g8so5253wme.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8hv513vsZp6qynCGWUcfJy9FTxPQ6BFzk4Chw3OuBy8=;
 b=WAkCuQk0F0cFNo2i2icjnLHXZu6/AtR/W+lQYDsOEbh2dKMoKQrzIMKdNt4VhY3I8Y
 R7e8CPOiIwI1Blfe6yTx5CcZogAjcn0npxVrz1LIUpZVhztWnk09z/9ZGBwCsz2wLe3R
 W0UKrpG+CLWR2APa+jbQiW/J8+CgYCMEbi+B4nr0aJ7sBsBZc/ghuhQi3RzgSO/XbQBm
 8r42F/3sR+27TWQfYPVmX5NQOivmsE//6b5cgPevI7/fG3lWh0kMam3j48SGrDPnahAp
 1zO1Tmsr1I1pCn/MxY0knai5Jtg6Uy0w3RK+BldmZngTlYdEbSPsEEINRZAfe81GyJ9V
 4kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8hv513vsZp6qynCGWUcfJy9FTxPQ6BFzk4Chw3OuBy8=;
 b=NSjnEYVKdyGkqdoWvonTj/JMLCb+PJJ0rEDo67OcFUTtOnBLZIFowsGoTmiGBKWKd9
 u/qqQKy56svpMGpKyI0boKK4CWqt3iIv6aFI7OOYuiYB49vtRQ9AIeMS5xircdKgRYcQ
 TvNZ/Tw2b9QQcpRu7yt3k5iyeFE7POueSRuEosvPo+DkCM8uHXocrPF6CjUfJSy7KvQx
 DQXxVnF06PTfl6BGFJyQa4hHKHnxsJaf5Fe1Lm41HzLG0f5m6ey5543d2YfQ9n/c/3/p
 TrrWQl+TEkuXDOnOO8CsMrM9nULdJChuTzPDmK78ED9uFeGLvbELRep76hAAig/LTnoY
 SKtg==
X-Gm-Message-State: AOAM532Oxm+MKU7vXeLUUoiHxIWISxgTsnA4YfZb7+RuqZzLGqPKHi55
 d31MaG9W0Q1yjMQMTYhWmwtGSw==
X-Google-Smtp-Source: ABdhPJzFTT/KFmCGP/Vg84ProquKzYOmuLbrbBbxtcj51mQ9tF0x9wKBH+XCb8kwArWwtqfL05yyyQ==
X-Received: by 2002:a1c:bd87:: with SMTP id n129mr304132wmf.32.1610392806958; 
 Mon, 11 Jan 2021 11:20:06 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:20:06 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 28/40] drm/amd/display/dc/calcs/dce_calcs: Demote
 non-conformant kernel-doc function headers
Date: Mon, 11 Jan 2021 19:19:14 +0000
Message-Id: <20210111191926.3688443-29-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYzoyNzUz
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICd2Ymlvcycgbm90IGRlc2Ny
aWJlZCBpbiAnaXNfZGlzcGxheV9jb25maWd1cmF0aW9uX3N1cHBvcnRlZCcKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY2FsY3MvZGNlX2NhbGNzLmM6Mjc1Mzogd2Fy
bmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnY2FsY3Nfb3V0cHV0JyBub3QgZGVz
Y3JpYmVkIGluICdpc19kaXNwbGF5X2NvbmZpZ3VyYXRpb25fc3VwcG9ydGVkJwogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYzozMDMwOiB3
YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdjdHgnIG5vdCBkZXNjcmliZWQg
aW4gJ2J3X2NhbGNzJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9j
YWxjcy9kY2VfY2FsY3MuYzozMDMwOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVt
YmVyICdkY2VpcCcgbm90IGRlc2NyaWJlZCBpbiAnYndfY2FsY3MnCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2RjZV9jYWxjcy5jOjMwMzA6IHdhcm5pbmc6
IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3ZiaW9zJyBub3QgZGVzY3JpYmVkIGluICdi
d19jYWxjcycKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY2FsY3Mv
ZGNlX2NhbGNzLmM6MzAzMDogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAn
cGlwZScgbm90IGRlc2NyaWJlZCBpbiAnYndfY2FsY3MnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9kaXNwbGF5L2RjL2NhbGNzL2RjZV9jYWxjcy5jOjMwMzA6IHdhcm5pbmc6IEZ1bmN0
aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ3BpcGVfY291bnQnIG5vdCBkZXNjcmliZWQgaW4gJ2J3
X2NhbGNzJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jYWxjcy9k
Y2VfY2FsY3MuYzozMDMwOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdj
YWxjc19vdXRwdXQnIG5vdCBkZXNjcmliZWQgaW4gJ2J3X2NhbGNzJwoKQ2M6IEhhcnJ5IFdlbnRs
YW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5j
b20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hy
aXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4K
Q2M6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQt
b2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9jYWxjcy9kY2VfY2FsY3MuYyB8IDUgKystLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL2RjZV9jYWxjcy5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NhbGNzL2RjZV9jYWxjcy5jCmluZGV4IGY2OWMyYjg0ZDQz
MmIuLjk2N2Q2ZDgwYmQzOGUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9jYWxjcy9kY2VfY2FsY3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvY2FsY3MvZGNlX2NhbGNzLmMKQEAgLTI3NDMsNyArMjc0Myw3IEBAIHZvaWQgYndfY2FsY3Nf
aW5pdChzdHJ1Y3QgYndfY2FsY3NfZGNlaXAgKmJ3X2RjZWlwLAogCWtmcmVlKHZiaW9zKTsKIH0K
IAotLyoqCisvKgogICogQ29tcGFyZSBjYWxjdWxhdGVkIChyZXF1aXJlZCkgY2xvY2tzIGFnYWlu
c3QgdGhlIGNsb2NrcyBhdmFpbGFibGUgYXQKICAqIG1heGltdW0gdm9sdGFnZSAobWF4IFBlcmZv
cm1hbmNlIExldmVsKS4KICAqLwpAQCAtMzAxNCwxMyArMzAxNCwxMiBAQCBzdGF0aWMgYm9vbCBh
bGxfZGlzcGxheXNfaW5fc3luYyhjb25zdCBzdHJ1Y3QgcGlwZV9jdHggcGlwZVtdLAogCXJldHVy
biB0cnVlOwogfQogCi0vKioKKy8qCiAgKiBSZXR1cm46CiAgKgl0cnVlIC0JRGlzcGxheShzKSBj
b25maWd1cmF0aW9uIHN1cHBvcnRlZC4KICAqCQlJbiB0aGlzIGNhc2UgJ2NhbGNzX291dHB1dCcg
Y29udGFpbnMgZGF0YSBmb3IgSFcgcHJvZ3JhbW1pbmcKICAqCWZhbHNlIC0gRGlzcGxheShzKSBj
b25maWd1cmF0aW9uIG5vdCBzdXBwb3J0ZWQgKG5vdCBlbm91Z2ggYmFuZHdpZHRoKS4KICAqLwot
CiBib29sIGJ3X2NhbGNzKHN0cnVjdCBkY19jb250ZXh0ICpjdHgsCiAJY29uc3Qgc3RydWN0IGJ3
X2NhbGNzX2RjZWlwICpkY2VpcCwKIAljb25zdCBzdHJ1Y3QgYndfY2FsY3NfdmJpb3MgKnZiaW9z
LAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
