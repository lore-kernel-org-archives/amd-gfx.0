Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A13C43333
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0223C22CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0223C22CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B2289E0C;
	Mon, 11 Jan 2021 19:55:04 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6FB89FAC
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:20:15 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id c124so233897wma.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WUI8zMKN7GlYJMYgpQ8BoEDGt3wAB5ccQaGwQCdPONQ=;
 b=ODjNCowqY28FhbIanlnU07cUII0VkYfzg2ra7UmLI3aacqHbD0K1Vk44vSU95Z5fLH
 zfFdShsLLUd1zQFNt3YzOT4rcMUqceJRBLMgLZgpl04IUDNnVGck9gjzC7jXD0hY6qPt
 AVvjTKdeqhe0bWb/DLgbx3VV5uoBUIuyy9nKCPZm2Fge9i3KyMidHNVSEidEhNju5z8N
 +50A5OsmIj5kQlDAP/Rh91qV/3GwvzTA8LzQYQLMFFVB54fN2CfvjZP32CN3T0ayWJ88
 q79zE1ws9LyaQLYqcao8F3sX3SbMZzwB2nBH3AOYy6hLcsy6BC4A/Vf/9mOk2vNPXy7W
 +liQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WUI8zMKN7GlYJMYgpQ8BoEDGt3wAB5ccQaGwQCdPONQ=;
 b=Ur02S5HHxzJAu1bviEF76tPgK5NXjJpnOCB5fbn9OYsqdmSVkiMU3GTqRvITkohgNS
 yeNg+0f5cSu0yu/U4ls7fXlCAjL3PFqRfh1pMW4GQnyU56TVwNVgiMz/R2S089H/qzem
 KwbEnLDKvFDf5nWath3xJRA28/WqplF6ejT2wTSWh77xW5ZITmO9Ae3wfP88LfsOL2yd
 jKi3d6boDf2ulwz9Fh8LS1WQuh7wq4r0S57ei9R1HxDIZsBLHEz6wVdDT/4GyNJAiVLu
 ib5U0w1KpxD3l1ZaPmMtCyqF+69V1eB7r8OpX7EiBcOuPWlcK9zBfpYGwMffYcbjlZ6W
 JKyg==
X-Gm-Message-State: AOAM533qBCdslc6XPBnPEvR6XHuVcN7Q8PeMuyGskB0A/wcBzcwh8lSs
 wiha1Hb4EMAmDQmy3V7BXnFx7Q==
X-Google-Smtp-Source: ABdhPJz8tM5Xs/MNa8ZtK7I5QhoB0S+VaI3xXWPEjjhTmvqmg32J+h5D8Sve6UMd0TzFj9pGiOHvOw==
X-Received: by 2002:a7b:cb54:: with SMTP id v20mr290685wmj.148.1610392814445; 
 Mon, 11 Jan 2021 11:20:14 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:20:13 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 34/40] drm/amd/display/dc/dce110/dce110_transform_v: Demote
 kernel-doc abuse
Date: Mon, 11 Jan 2021 19:19:20 +0000
Message-Id: <20210111191926.3688443-35-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3RyYW5zZm9y
bV92LmM6MjI4OiB3YXJuaW5nOiBiYWQgbGluZTogICAgdm9pZAogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3RyYW5zZm9ybV92LmM6MjMzOiB3
YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICd4Zm1fZGNlJyBub3QgZGVzY3Jp
YmVkIGluICdwcm9ncmFtX292ZXJzY2FuJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3RyYW5zZm9ybV92LmM6MjMzOiB3YXJuaW5nOiBGdW5j
dGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdkYXRhJyBub3QgZGVzY3JpYmVkIGluICdwcm9ncmFt
X292ZXJzY2FuJwoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpD
YzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmll
bCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExl
ZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogLi4uL2Rpc3BsYXkvZGMvZGNlMTEw
L2RjZTExMF90cmFuc2Zvcm1fdi5jICAgIHwgMTkgKysrKysrKysrLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfdHJhbnNmb3JtX3Yu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3RyYW5zZm9y
bV92LmMKaW5kZXggYjFhYWFiNTU5MGNjNi4uMjk0MzhjNjA1MGRiYiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfdHJhbnNmb3JtX3YuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF90cmFuc2Zv
cm1fdi5jCkBAIC0yMTcsMTYgKzIxNywxNSBAQCBzdGF0aWMgYm9vbCBzZXR1cF9zY2FsaW5nX2Nv
bmZpZ3VyYXRpb24oCiAJcmV0dXJuIGlzX3NjYWxpbmdfbmVlZGVkOwogfQogCi0vKioKLSogRnVu
Y3Rpb246Ci0qIHZvaWQgcHJvZ3JhbV9vdmVyc2NhbgotKgotKiBQdXJwb3NlOiBQcm9ncmFtcyBv
dmVyc2NhbiBib3JkZXIKLSogSW5wdXQ6ICAgb3ZlcnNjYW4KLSoKLSogT3V0cHV0OgotICAgdm9p
ZAotKi8KKy8qCisgKiBGdW5jdGlvbjoKKyAqIHZvaWQgcHJvZ3JhbV9vdmVyc2NhbgorICoKKyAq
IFB1cnBvc2U6IFByb2dyYW1zIG92ZXJzY2FuIGJvcmRlcgorICogSW5wdXQ6ICAgb3ZlcnNjYW4K
KyAqCisgKiBPdXRwdXQ6IHZvaWQKKyAqLwogc3RhdGljIHZvaWQgcHJvZ3JhbV9vdmVyc2NhbigK
IAkJc3RydWN0IGRjZV90cmFuc2Zvcm0gKnhmbV9kY2UsCiAJCWNvbnN0IHN0cnVjdCBzY2FsZXJf
ZGF0YSAqZGF0YSkKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
