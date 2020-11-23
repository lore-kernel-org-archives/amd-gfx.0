Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBDDC388F9
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84A520702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFIghWFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84A520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 758426E02D;
	Mon, 23 Nov 2020 13:58:25 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2447F89F9F
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:20:19 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p19so12927809wmg.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3XzaLPcLzyh2up8e5kwP+nCHZJEB2WNWkcaV5TphNj8=;
 b=fFIghWFECT8oOj8Gu6q8wWn9L5Fsp3uSgLhqf4xoYHzANzX9dnQy+cCA25K4kRYNg7
 FZ2lQihD8sQIOAZh9U99hIjJKi/4DqiRzkm+KMU2/FoHpzwC82+M8bNqfnVvEmKrm8t/
 lfxAuN4z4hfJNTekVocscG1M+td6PQFn1y8fWKMtOULHbg1wBKDyhAcnpBFudv5YTyzS
 qeG35MgmaOjGVq5q81vUOK9ppiAYrv9JfodWa7vBEJxkBEhINB+44gRA2QXEMyj81anE
 0rZFFj6ta/VsXd6K2OtmQI7hbWA8UBuHofWGPJEiVBedvS74vena5C/SamFn+8lWjn9s
 XvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3XzaLPcLzyh2up8e5kwP+nCHZJEB2WNWkcaV5TphNj8=;
 b=VwdSsXQc3PeylkIjo5f7ysOGMF9I7Ku2Ca11jewRnE59k9e3BgFyo+CeC7s/cHX/DO
 5J+kQ3pvxXJFvlT5uD1ReBTsAAp7tfzpE5IU+6t5EwjxwnLzemmb0JI3KPXc06Qg3E8U
 l1T9DPNc5+JPGFIRK9cfxmsFFwbaKBqPF1Rn+6sEfhcBOjYlmLf/q3fGc8L+oxGNWRpg
 bzzztTtvLqjk2a+MnifxwtRPFmh6zrpJ1+VhiTSi2NvFuAdKlwE0URR8wusazwslH1xP
 MQlR8LY8+BfL3kC0QG4qsHQWilYKB6QYe1ih6tHevOmA7vwvTHg3EF1SmWym4kjaFp/Q
 xJjQ==
X-Gm-Message-State: AOAM532sD4a2WC/00nSLa4Xs0DBwOEEbZ9BbT7dQmhw7LNFxIX04Dqvh
 cLtDFIrlumu2wCNfH5F8aF0w/w==
X-Google-Smtp-Source: ABdhPJw4krFHGvCPonuYMQCc5j4oEqKwHKw6hTdw1CAKFuCsPJi/oWSZPQ18RWzyyhjvj3TopaDe2A==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr22884154wme.23.1606130417818; 
 Mon, 23 Nov 2020 03:20:17 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:20:17 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 40/40] drm/amd/amdgpu/gmc_v9_0: Suppy some missing function
 doc descriptions
Date: Mon, 23 Nov 2020 11:19:19 +0000
Message-Id: <20201123111919.233376-41-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYzozODI6MjM6IHdhcm5pbmc6IOKAmGVjY191
bWNfbWN1bWNfc3RhdHVzX2FkZHJz4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1j
b25zdC12YXJpYWJsZT1dCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jOjcy
MDogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAndm1odWInIG5vdCBkZXNj
cmliZWQgaW4gJ2dtY192OV8wX2ZsdXNoX2dwdV90bGInCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nbWNfdjlfMC5jOjgzNjogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJl
ciAnZmx1c2hfdHlwZScgbm90IGRlc2NyaWJlZCBpbiAnZ21jX3Y5XzBfZmx1c2hfZ3B1X3RsYl9w
YXNpZCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmM6ODM2OiB3YXJuaW5n
OiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdhbGxfaHViJyBub3QgZGVzY3JpYmVkIGlu
ICdnbWNfdjlfMF9mbHVzaF9ncHVfdGxiX3Bhc2lkJwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFu
aWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTog
TGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jIHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjlfMC5jIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwppbmRleCBmYmVlNDNiNGJhNjRk
Li5hODM3NDNhYjNlOGJiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKQEAg
LTY3NSw2ICs2NzUsNyBAQCBzdGF0aWMgYm9vbCBnbWNfdjlfMF9nZXRfYXRjX3ZtaWRfcGFzaWRf
bWFwcGluZ19pbmZvKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogICoKICAqIEBhZGV2OiBh
bWRncHVfZGV2aWNlIHBvaW50ZXIKICAqIEB2bWlkOiB2bSBpbnN0YW5jZSB0byBmbHVzaAorICog
QHZtaHViOiB2bWh1YiB0eXBlCiAgKiBAZmx1c2hfdHlwZTogdGhlIGZsdXNoIHR5cGUKICAqCiAg
KiBGbHVzaCB0aGUgVExCIGZvciB0aGUgcmVxdWVzdGVkIHBhZ2UgdGFibGUgdXNpbmcgY2VydGFp
biB0eXBlLgpAQCAtNzkxLDYgKzc5Miw4IEBAIHN0YXRpYyB2b2lkIGdtY192OV8wX2ZsdXNoX2dw
dV90bGIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHVpbnQzMl90IHZtaWQsCiAgKgogICog
QGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgogICogQHBhc2lkOiBwYXNpZCB0byBiZSBmbHVz
aAorICogQGZsdXNoX3R5cGU6IHRoZSBmbHVzaCB0eXBlCisgKiBAYWxsX2h1YjogVXNlZCB3aXRo
IFBBQ0tFVDNfSU5WQUxJREFURV9UTEJTX0FMTF9IVUIoKQogICoKICAqIEZsdXNoIHRoZSBUTEIg
Zm9yIHRoZSByZXF1ZXN0ZWQgcGFzaWQuCiAgKi8KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
