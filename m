Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4667C4332D
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9551A22B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9551A22B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191726E0F3;
	Mon, 11 Jan 2021 19:54:48 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1392B8972C
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:54 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id i63so236738wma.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=miXNZ6gGmj2M59EydnLO6lgExaxQkAaXuUbDezw9Q9E=;
 b=Hb3cuQsSFZ1jEyNVTfncIcsgdUxm0tHxyqEwFT7taKF22e0/Eu5lKQ989Ilii7idMz
 9CLW1Ev8wTHz8TuK3jl9HqNsH9o3eGntX4yVKCpvoQ3n9LPcbe1xiT/14UqnXMBOMuN5
 0OQrnAi/+JeA7rnWwV8kDquF4ONohcKo4jzO9bB7iYp+GbjyNMSHpGHF/UxoeeLOUqJI
 8AR80hZmwpl0/Dr1XlRzY5yx/8mnxg0Xk5cvmx1w6Zx9q+WDCtXNMOYU6DZ+ZuvaSMj/
 0ahzK0ny8XZPoq/0Eee907+PzNcxplWujury3VdSUuW1mCvTI08UveHREaYpbFl7hHbo
 2KGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=miXNZ6gGmj2M59EydnLO6lgExaxQkAaXuUbDezw9Q9E=;
 b=L3XXjwJNHp1LoDWkjN/Aw8wW6O2VT27N3EhEQA8OW8RHlGliu48B4l+6lF6fEVjDCh
 N3OHNiyXa0g89Tp9Id1RyabQWfn58peHIHGyZVFMBOFW9cACGKHbRdROVjvcdKgdZxT5
 tjS0TmTAet3j3kCrwNHr06dLS4AesrqZ3cfSDYWg6/eboxJqF4XdsOoAshVVshoUxckL
 fxW8Na91ik4EMe8DAbP1o7+YL8xqNqImncfmnTbLwlKrQheYWJ7oOHzFZpzWkHQsRY+w
 hT+roLqJilFoTyziCYjcm2Lxcae0l12teYtWkxM3X+3PeyfmJLH/F0X91V8cPT2Mz6pI
 bdXg==
X-Gm-Message-State: AOAM533AAtIha6UdmxLuqFHLEqaVLDPQCTVicKSN0gBs2tL9tRi/YPCT
 WvToJSJbf9kp0uE9m2xHkuwwbQ==
X-Google-Smtp-Source: ABdhPJyXPhJp6VPC0E/onuoITyQMrszVAt4I6xbCfI774wMzYcU7N9xpalSM1Xb2p7q/+ZcgVGNOgw==
X-Received: by 2002:a1c:356:: with SMTP id 83mr284142wmd.31.1610392792743;
 Mon, 11 Jan 2021 11:19:52 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:52 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 17/40] drm/amd/display/dc/dce/dce_aux: Remove duplicate line
 causing 'field overwritten' issue
Date: Mon, 11 Jan 2021 19:19:03 +0000
Message-Id: <20210111191926.3688443-18-lee.jones@linaro.org>
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMv
ZGNlMTEyL2RjZTExMl9yZXNvdXJjZS5jOjU5OgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vaW5jbHVkZS9hc2ljX3JlZy9kY2UvZGNlXzExXzJfc2hfbWFzay5oOjEwMDE0OjU4OiB3YXJu
aW5nOiBpbml0aWFsaXplZCBmaWVsZCBvdmVyd3JpdHRlbiBbLVdvdmVycmlkZS1pbml0XQogZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5oOjIxNDox
Njogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmEFVWF9TV19EQVRBX19BVVhfU1dfQVVU
T0lOQ1JFTUVOVF9ESVNBQkxFX19TSElGVOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Li4vZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5oOjEyNzoyOiBub3RlOiBpbiBleHBhbnNpb24gb2Yg
bWFjcm8g4oCYQVVYX1NG4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5
L2RjL2RjZTExMi9kY2UxMTJfcmVzb3VyY2UuYzoxNzc6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9m
IG1hY3JvIOKAmERDRV9BVVhfTUFTS19TSF9MSVNU4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS8uLi9pbmNsdWRlL2FzaWNfcmVnL2RjZS9kY2VfMTFfMl9zaF9tYXNrLmg6MTAwMTQ6NTg6
IG5vdGU6IChuZWFyIGluaXRpYWxpemF0aW9uIGZvciDigJhhdXhfc2hpZnQuQVVYX1NXX0FVVE9J
TkNSRU1FTlRfRElTQUJMReKAmSkKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3Bs
YXkvZGMvZGNlL2RjZV9hdXguaDoyMTQ6MTY6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDi
gJhBVVhfU1dfREFUQV9fQVVYX1NXX0FVVE9JTkNSRU1FTlRfRElTQUJMRV9fU0hJRlTigJkKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguaDoxMjc6
Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmEFVWF9TRuKAmQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTIvZGNlMTEyX3Jlc291cmNlLmM6MTc3
OjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhEQ0VfQVVYX01BU0tfU0hfTElTVOKA
mQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hc2ljX3JlZy9kY2UvZGNl
XzExXzJfc2hfbWFzay5oOjEwMDEzOjU2OiB3YXJuaW5nOiBpbml0aWFsaXplZCBmaWVsZCBvdmVy
d3JpdHRlbiBbLVdvdmVycmlkZS1pbml0XQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4v
ZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5oOjIxNDoxNjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1h
Y3JvIOKAmEFVWF9TV19EQVRBX19BVVhfU1dfQVVUT0lOQ1JFTUVOVF9ESVNBQkxFX01BU0vigJkK
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguaDox
Mjc6Mjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvIOKAmEFVWF9TRuKAmQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTIvZGNlMTEyX3Jlc291cmNlLmM6
MTgxOjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhEQ0VfQVVYX01BU0tfU0hfTElT
VOKAmQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vaW5jbHVkZS9hc2ljX3JlZy9kY2Uv
ZGNlXzExXzJfc2hfbWFzay5oOjEwMDEzOjU2OiBub3RlOiAobmVhciBpbml0aWFsaXphdGlvbiBm
b3Ig4oCYYXV4X21hc2suQVVYX1NXX0FVVE9JTkNSRU1FTlRfRElTQUJMReKAmSkKIGRyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguaDoyMTQ6MTY6IG5v
dGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhBVVhfU1dfREFUQV9fQVVYX1NXX0FVVE9JTkNS
RU1FTlRfRElTQUJMRV9NQVNL4oCZCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNw
bGF5L2RjL2RjZS9kY2VfYXV4Lmg6MTI3OjI6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDi
gJhBVVhfU0bigJkKCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4K
Q2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29l
bmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5p
ZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBM
ZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5oIHwgMSAtCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlv
bigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNl
X2F1eC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmgKaW5k
ZXggMzgyNDY1ODYyZjI5Ny4uMjc3NDg0Y2Y4NTNlNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXV4LmgKQEAgLTEyNCw3ICsxMjQsNiBAQCBzdHJ1Y3QgZGNl
MTEwX2F1eF9yZWdpc3RlcnMgewogCUFVWF9TRihBVVhfU1dfQ09OVFJPTCwgQVVYX1NXX0dPLCBt
YXNrX3NoKSxcCiAJQVVYX1NGKEFVWF9TV19EQVRBLCBBVVhfU1dfQVVUT0lOQ1JFTUVOVF9ESVNB
QkxFLCBtYXNrX3NoKSxcCiAJQVVYX1NGKEFVWF9TV19EQVRBLCBBVVhfU1dfREFUQV9SVywgbWFz
a19zaCksXAotCUFVWF9TRihBVVhfU1dfREFUQSwgQVVYX1NXX0FVVE9JTkNSRU1FTlRfRElTQUJM
RSwgbWFza19zaCksXAogCUFVWF9TRihBVVhfU1dfREFUQSwgQVVYX1NXX0lOREVYLCBtYXNrX3No
KSxcCiAJQVVYX1NGKEFVWF9TV19EQVRBLCBBVVhfU1dfREFUQSwgbWFza19zaCksXAogCUFVWF9T
RihBVVhfU1dfU1RBVFVTLCBBVVhfU1dfUkVQTFlfQllURV9DT1VOVCwgbWFza19zaCksXAotLSAK
Mi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
