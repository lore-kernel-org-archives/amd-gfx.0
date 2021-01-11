Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D037BC432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B02822B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B02822B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C6189E14;
	Mon, 11 Jan 2021 19:55:04 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09256E062
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:20:23 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id g25so477911wmh.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AejyAKESpWoI52tNZY+VpYKWtH7XjXdVdCW7Df3aTz4=;
 b=fL0A3FYKyTXR1evYTyVZcRhsAUYxUi2VIDBy/CKs5c5KAjiVP8mb4fcwcGvU+pmIOa
 85gscWuzM0iyOkj+belxv0VLkBefcLZSUTNYoFOM1NCwEsEl1eLgtA+lbMUvEl1j9FYG
 8l3Xlqq8GYvvazaKupRqFvEGlrR+MJ9Ftr5ATPw0C17fiBAw3a0RpQpmmkUcNuMEFi05
 dUwPFX3VYlBCMvwfuNQekEYCveNycqsFJQ2WMVIV+uWlsweflYJU6CVnKsWVtah8M4lb
 t703vrdVc9G9sY63wzC6c6+HrX6+hFdXpQVZgtU5RwsJnNjEcMCVOyLFl+tqzZJlR/E/
 hdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AejyAKESpWoI52tNZY+VpYKWtH7XjXdVdCW7Df3aTz4=;
 b=fjtkf4nRvEMWG8o1wTunwvvX/QpN9WcQSPV17svBzkFVQo4cuC2bC4bFHyh2Fd0ZNO
 cLiCf3Nd67lL3YYJmv7fLO9LZfMrNFXFDOmiVYRT5A80PU3AHJRVGBMsyZDGudThGWP+
 3lTRnpxKcXZ1r/mV//Z3ApxTpc9x60Wi56jgNGf2ttWkIla/Are3FbhgMP4Cq5QRA0gR
 KIbHA0j0/ZRjQBc2QwGKtJEi23JxNbPEGw1C4dAvdMaMNfojUPMshDaQFz9nwo22u7Lp
 yzn5Aa3OiyIzghgN0nfKP9Ep9B3exohxhQtFponDm+BJXlrcOQCvv41M+e11ONzxS0Jp
 D5HA==
X-Gm-Message-State: AOAM533u1b0lD+5NjvCLgUzS7NpNkvnLhz4Y5r9n4aSscLK8LIpz2DO5
 v0KSLgLZfwkezej+syosSCnOYw==
X-Google-Smtp-Source: ABdhPJwqLNKhpsvusFowjVq55d1AVbljG6jJxOvD/XIynEhDqhCVft9FdfgFL3xLk24pL+s98upOxg==
X-Received: by 2002:a1c:4489:: with SMTP id r131mr311092wma.24.1610392822455; 
 Mon, 11 Jan 2021 11:20:22 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:20:21 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 40/40] drm/amd/display/dc/core/dc_stream: Demote
 non-conformant kernel-doc headers
Date: Mon, 11 Jan 2021 19:19:26 +0000
Message-Id: <20210111191926.3688443-41-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX3N0cmVhbS5jOjI1Mzog
d2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAncFN0cmVhbScgbm90IGRlc2Ny
aWJlZCBpbiAnZGNfb3B0aW1pemVfdGltaW5nX2Zvcl9mc2Z0JwogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX3N0cmVhbS5jOjI1Mzogd2FybmluZzogRnVu
Y3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnbWF4X2lucHV0X3JhdGVfaW5fa2h6JyBub3QgZGVz
Y3JpYmVkIGluICdkY19vcHRpbWl6ZV90aW1pbmdfZm9yX2ZzZnQnCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNfc3RyZWFtLmM6MjcwOiB3YXJuaW5nOiBG
dW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdzdHJlYW0nIG5vdCBkZXNjcmliZWQgaW4gJ2Rj
X3N0cmVhbV9zZXRfY3Vyc29yX2F0dHJpYnV0ZXMnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNfc3RyZWFtLmM6MjcwOiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdhdHRyaWJ1dGVzJyBub3QgZGVzY3JpYmVkIGluICdkY19zdHJl
YW1fc2V0X2N1cnNvcl9hdHRyaWJ1dGVzJwoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50
bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51
eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfc3RyZWFtLmMgfCA1ICsrLS0tCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX3N0cmVhbS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfc3RyZWFtLmMKaW5kZXggYzEwM2Y4NTgz
NzVkMC4uMjVmYTcxMmE3ODQ3NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2NvcmUvZGNfc3RyZWFtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2NvcmUvZGNfc3RyZWFtLmMKQEAgLTI0NCw3ICsyNDQsNyBAQCBzdHJ1Y3QgZGNfc3RyZWFt
X3N0YXR1cyAqZGNfc3RyZWFtX2dldF9zdGF0dXMoCiB9CiAKICNpZm5kZWYgVFJJTV9GU0ZUCi0v
KioKKy8qCiAgKiBkY19vcHRpbWl6ZV90aW1pbmdfZm9yX2ZzZnQoKSAtIGRjIHRvIG9wdGltaXpl
IHRpbWluZwogICovCiBib29sIGRjX29wdGltaXplX3RpbWluZ19mb3JfZnNmdCgKQEAgLTI2MCw4
ICsyNjAsNyBAQCBib29sIGRjX29wdGltaXplX3RpbWluZ19mb3JfZnNmdCgKIH0KICNlbmRpZgog
Ci0KLS8qKgorLyoKICAqIGRjX3N0cmVhbV9zZXRfY3Vyc29yX2F0dHJpYnV0ZXMoKSAtIFVwZGF0
ZSBjdXJzb3IgYXR0cmlidXRlcyBhbmQgc2V0IGN1cnNvciBzdXJmYWNlIGFkZHJlc3MKICAqLwog
Ym9vbCBkY19zdHJlYW1fc2V0X2N1cnNvcl9hdHRyaWJ1dGVzKAotLSAKMi4yNS4xCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
