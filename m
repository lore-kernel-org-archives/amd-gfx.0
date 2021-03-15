Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48EDC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 12:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3627764EB3
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 12:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3627764EB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4B5589EB8;
	Mon, 15 Mar 2021 12:58:25 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1D689EB8
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 12:58:24 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id ox4so50388433ejb.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jbX4X4jQPvQA2bSHsxicLA8mv+mxpopcWGvV83lbRzc=;
 b=FkVgoeg1EIVCY4UGit1jH986FdzDB9qEUIRkY9Rv/44VgCTWgYmfqF4qh6J3MU4GQK
 zvnGvnbuCu+P3YBunIfncsxwF5kqrq+JvVGaLL4CkCbluosuMaUGyHkBLwORMtJiivHf
 IghKM2N+KeRF2izujiMCZDF1vtVJdyC8xbNt8y4KcJGxXYtAUDiDIWI5tWqm3POU8zN4
 ZzHIgFIcR6ggwDliJYs3DN2gczPxyMftqZYLdgdAjNVDB/SGkXbI6jLpxez++yS1Z37/
 gLvJvH+E0BNOiIuRntMMfkSU7Oix00x+QQYhkCqwcO6YhWA3JTyVbZ4Hga/uCYD5tf8R
 Fx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jbX4X4jQPvQA2bSHsxicLA8mv+mxpopcWGvV83lbRzc=;
 b=WSoNAVzVDqLW0RcDrE1F6j+H+s5ai7RaooKxrXB0QdEELZu4ZwSWwFFEfj/HOJNFLJ
 GFVns5m951mvF6wo/oYptKDUdaIOtRwSp0lCIHz9XPAc7EdtG19ffXhzlcPNV/YnlXBY
 vPnjpnenupf/9mZ5Oer5JGBohZRB1YV/Ui2ux4rHbLnWk75u7wvZNI/jJv35HmaQX2JX
 Kyoso7Uh0tLjTj3rtSxY5Fwy5oNbFT+cVw1Kp8RCnN4wbWihvaEyzXrys41NOedinAG4
 PLcKlUyoD1VAqL54IIeYilt8hEpkij0u5RhfCTUAfdPONmwOV1MVqL+7W1R9Qz6HQiJG
 htjA==
X-Gm-Message-State: AOAM5329sP9LwpSaBcfhg+PHZmnB5UHl62WF3KM5BUoVKFVWPNoH7cug
 la9bRO4UfFjN5FCp1Zilf3fF/0wwPI8=
X-Google-Smtp-Source: ABdhPJyDqFzfF8zJsRLdrxXo1Bshmu80Ob6Ijixk5Me+FG338Ajitx+PZ6U6YuZu69rmYJJsJ6JQDw==
X-Received: by 2002:a17:906:86c1:: with SMTP id
 j1mr24167705ejy.373.1615813103310; 
 Mon, 15 Mar 2021 05:58:23 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:dffe:4819:8ad9:f8bd])
 by smtp.gmail.com with ESMTPSA id a12sm8037620edx.91.2021.03.15.05.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 05:58:22 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Felix.Kuehling@amd.com, Guchun.Chen@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: make sure to only process the remaining VM range
Date: Mon, 15 Mar 2021 13:58:21 +0100
Message-Id: <20210315125821.80688-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2Ugc2hvdWxkIG9ubHkgbWFwIHRoZSByZW1haW5pbmcgc2l6ZSBoZXJlIGFuZCBub3QgdGhlIHdo
b2xlIHNlZ21lbnQuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+CkZpeGVzOiAzYWYwYTAxOGE3MjggKCJkcm0vYW1kZ3B1OiBuZXcgcmVz
b3VyY2UgY3Vyc29yIikKLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0u
YyB8IDMgKystCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwppbmRleCAzMThlZWVhNTc3YjUu
LmFkMTY5OGJkNmIyNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKQEAg
LTE2NDYsNyArMTY0Niw4IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX2JvX3VwZGF0ZV9tYXBwaW5n
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCXdoaWxlIChjdXJzb3IucmVtYWluaW5nKSB7
CiAJCXVpbnQ2NF90IHRtcCwgbnVtX2VudHJpZXMsIGFkZHI7CiAKLQkJbnVtX2VudHJpZXMgPSBj
dXJzb3Iuc2l6ZSA+PiBBTURHUFVfR1BVX1BBR0VfU0hJRlQ7CisJCW51bV9lbnRyaWVzID0gbWlu
KGN1cnNvci5zaXplLCBjdXJzb3IucmVtYWluaW5nKQorCQkJPj4gQU1ER1BVX0dQVV9QQUdFX1NI
SUZUOwogCQlpZiAocGFnZXNfYWRkcikgewogCQkJYm9vbCBjb250aWd1b3VzID0gdHJ1ZTsKIAot
LSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
