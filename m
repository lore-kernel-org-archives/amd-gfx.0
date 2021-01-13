Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E25C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC76E23102
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC76E23102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A056E158;
	Wed, 13 Jan 2021 08:24:30 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D0326E06D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:08:16 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id y187so712455wmd.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YtdAaEqJ+OgUUPAXBPbeBnhYUUGO94r1mRrUVzyKNqw=;
 b=J4u9O4QqJw9NZ0jVvvAMdTcHDKR5DdnXk3Ob0X7W0XjXytVoKhQFQmf5V177HDeaw6
 DqwzEq0kkEhGD+eaLkMORoIjCqrj+FznQMQ1+ocLIg7w8IIdKP+L2AgJH7jnt2HMLAEY
 AfvdBRThpE1B+QBu7eOFPYevp1TjEjyey0WgZD3O7XSAOZzsXHK+oJNH4GcVoa7ujph3
 vET4kj0k272eJplJyWKqGojwAmFg/YuM4prRhb7l2cKjj8dDHFw6wqM/okNdk2Ftv/FL
 WePS7sAZPVPTArf/yf2wYdKCqzTeB+MyjCuzBqmZnZBDbQ3QMr5vJrvDieTyNRVTXn2d
 RQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YtdAaEqJ+OgUUPAXBPbeBnhYUUGO94r1mRrUVzyKNqw=;
 b=qpW+LQnu8JlAgK7P4scPcNAffiHBajn9Z9gqO1VEir6yLaa0fh4MqTprCGXMNBQmjb
 7sBtgDJrr1cnA+IHtVmn5nKLEvh3aPaTCK0hbAzGpeGkzsEyNE0MqRS6gOP4a0JTaymS
 EHdY1orj5dmP8fd9KidTkiLKY8oFxCoU0KhFOj94w/47FK5dySbpK327VkjtJPFVjck2
 uAQVbGY/aTB8JKFce5LqgINORCAnqefDsMpPuXsSPGTXEJecDhlab2cmSzjDpzQxcMrI
 I5gwSzVQO49q+V5whtTbQFESPC3eU18GzRrBVrZlUwvFgfWxt6DDTs2ge+9n3qllyEpU
 jvoQ==
X-Gm-Message-State: AOAM532JcuimVr3LMY1Rz7ySzhEQCxEUcKw76uQEXBzI52cLNePPUTNV
 8uNA4fOs9sYYZ9eo7JFQWvvsFg==
X-Google-Smtp-Source: ABdhPJwCvYxaM2sHo0QhAxW+Mm5PK5lmxhLKKwKNhoXwmQg+a/L2rTXiNEg6zDYQlv3SjpfxITC8jQ==
X-Received: by 2002:a05:600c:4101:: with SMTP id
 j1mr935004wmi.55.1610525294937; 
 Wed, 13 Jan 2021 00:08:14 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:08:14 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 15/30] drm/amd/display/dc/dce80/dce80_resource: Include our
 own header containing prototypes
Date: Wed, 13 Jan 2021 08:07:37 +0000
Message-Id: <20210113080752.1003793-16-lee.jones@linaro.org>
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U4MC9kY2U4MF9yZXNvdXJjZS5j
OjExMjY6MjM6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZGNlODBfY3Jl
YXRlX3Jlc291cmNlX3Bvb2zigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U4MC9kY2U4MF9yZXNvdXJjZS5jOjEzMjU6
MjM6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZGNlODFfY3JlYXRlX3Jl
c291cmNlX3Bvb2zigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U4MC9kY2U4MF9yZXNvdXJjZS5jOjE1MjA6MjM6IHdh
cm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZGNlODNfY3JlYXRlX3Jlc291cmNl
X3Bvb2zigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJy
eS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvD
tm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGll
ZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IEFudGhv
bnkgS29vIDxBbnRob255Lktvb0BhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTog
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlODAvZGNlODBfcmVzb3VyY2UuYyB8IDIgKysKIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNlODAvZGNlODBfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY2U4MC9kY2U4MF9yZXNvdXJjZS5jCmluZGV4IGZlNWQ3MTYwODQzNjMuLjcyNWQ5MmU0
MGNkMzAgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U4MC9k
Y2U4MF9yZXNvdXJjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2U4
MC9kY2U4MF9yZXNvdXJjZS5jCkBAIC02MCw2ICs2MCw4IEBACiAjaW5jbHVkZSAiZGNlL2RjZV9p
MmMuaCIKIC8qIFRPRE8gcmVtb3ZlIHRoaXMgaW5jbHVkZSAqLwogCisjaW5jbHVkZSAiZGNlODBf
cmVzb3VyY2UuaCIKKwogI2lmbmRlZiBtbU1DX0hVQl9SRFJFUV9ETUlGX0xJTUlUCiAjaW5jbHVk
ZSAiZ21jL2dtY183XzFfZC5oIgogI2luY2x1ZGUgImdtYy9nbWNfN18xX3NoX21hc2suaCIKLS0g
CjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
