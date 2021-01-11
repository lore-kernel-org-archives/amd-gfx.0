Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82284C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35EF222A83
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EF222A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2F496E095;
	Mon, 11 Jan 2021 19:54:43 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D7E89DCF
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:34 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id y187so5329wmd.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GBLSZTPS8qk7rY11VgJobcJSdYVa2Sl7IRQcchF4a+M=;
 b=uEgsGHtL1R1LmYWVtAlgWHzqWKe0ZR0/dvXOMx1Xo/D9OSPyNzU/zd67KNHNnXjLmU
 8O0UZGjC0CM0GHTEdGIku+WcS9c1+U5hUQSbQuQUPCxycEj3Myn+Vs38kxAq1kgCAhiD
 VHVhw7sfXF+XNDVKGVTfRfCJmDgZXho3+G9/t3Z7M4qXJ4jEQ+ubQ/OLOMiwLn9dyARp
 55Q/M5kPLPxlEbf1QZHnHJahZKiI92+p4ljKzbsWOgE4e9Rh2sf9R4dq+1nO/Uoa1zrF
 i6zsr74q+nNxm7ILEhqR/DZrAjHLJXfqnTtzjMiUPSvBGYEUMzxoclZAbim4ZL55781t
 C4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GBLSZTPS8qk7rY11VgJobcJSdYVa2Sl7IRQcchF4a+M=;
 b=CsOfLk/a+7xXogy18BkptQVE5R+cCFarwc85IJZ8hiUx07BpYTVVUmgUaPXaQfaNuk
 0qpWL8gPqqfhdGqyWoql6vfen0/A5D/EmVN0qZIfA2RYNXnmTroxJCBScMkInwznh8V3
 wz13hX9efzc0h/Od0UwrgjLQHfRaAgoQ26rT9jAzSG3wpkbpLPZEt6ppfYskt/vdSFsd
 l0Uctk3kdZ3RPM1UjlgGNIMgNQ6ICgMyo/RDwFYgLgl2Qh1BunBzonFZC0qu5Y5zL6WA
 /6vm7cBuDIo1rwHwVMgvQORtI5WfYjJtAt/yrkFbKp/0uccMktOAXDLsgNygAnWZCUP6
 YNgQ==
X-Gm-Message-State: AOAM530zqddx3Xsbk09XqC/fySSpaHPgXAfti4rZpHxcGG7mCpNT6lh2
 T9Nkya/mP72nObFy9YiKqAc1xg==
X-Google-Smtp-Source: ABdhPJwsPIewKRiPHpMKg9Dgwa6FSZEYYHKguRSX5hvl5lz1TB1qAR/0Ay4A53FcH8i1bV5abHPdPQ==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr259768wmh.123.1610392773083;
 Mon, 11 Jan 2021 11:19:33 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:32 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 02/40] drm/amd/display/dc/dce/dce_link_encoder: Remove unused
 variable 'value0'
Date: Mon, 11 Jan 2021 19:18:48 +0000
Message-Id: <20210111191926.3688443-3-lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2xpbmtfZW5jb2Rlci5j
OiBJbiBmdW5jdGlvbiDigJhkY2UxMTBfbGlua19lbmNvZGVyX3VwZGF0ZV9tc3Rfc3RyZWFtX2Fs
bG9jYXRpb25fdGFibGXigJk6CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5
L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmM6MTUwNjoxMTogd2FybmluZzogdmFyaWFibGUg4oCY
dmFsdWUw4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpD
YzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1
bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpD
YzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFu
aWVsQGZmd2xsLmNoPgpDYzogTWF1cm8gUm9zc2kgPGlzc29yLm9ydWFtQGdtYWlsLmNvbT4KQ2M6
IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNvZGVy
LmMgfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2xp
bmtfZW5jb2Rlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlu
a19lbmNvZGVyLmMKaW5kZXggMGVmMmY0ZDlkOGJmMy4uMWU3N2ZmZWU3MWIzMCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNvZGVyLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfbGlua19lbmNvZGVy
LmMKQEAgLTE1MDMsNyArMTUwMyw2IEBAIHZvaWQgZGNlMTEwX2xpbmtfZW5jb2Rlcl91cGRhdGVf
bXN0X3N0cmVhbV9hbGxvY2F0aW9uX3RhYmxlKAogCWNvbnN0IHN0cnVjdCBsaW5rX21zdF9zdHJl
YW1fYWxsb2NhdGlvbl90YWJsZSAqdGFibGUpCiB7CiAJc3RydWN0IGRjZTExMF9saW5rX2VuY29k
ZXIgKmVuYzExMCA9IFRPX0RDRTExMF9MSU5LX0VOQyhlbmMpOwotCXVpbnQzMl90IHZhbHVlMCA9
IDA7CiAJdWludDMyX3QgdmFsdWUxID0gMDsKIAl1aW50MzJfdCB2YWx1ZTIgPSAwOwogCXVpbnQz
Ml90IHNsb3RzID0gMDsKQEAgLTE2MDQsNyArMTYwMyw3IEBAIHZvaWQgZGNlMTEwX2xpbmtfZW5j
b2Rlcl91cGRhdGVfbXN0X3N0cmVhbV9hbGxvY2F0aW9uX3RhYmxlKAogCWRvIHsKIAkJdWRlbGF5
KDEwKTsKIAotCQl2YWx1ZTAgPSBSRUdfUkVBRChEUF9NU0VfU0FUX1VQREFURSk7CisJCVJFR19S
RUFEKERQX01TRV9TQVRfVVBEQVRFKTsKIAogCQlSRUdfR0VUKERQX01TRV9TQVRfVVBEQVRFLAog
CQkJCURQX01TRV9TQVRfVVBEQVRFLCAmdmFsdWUxKTsKLS0gCjIuMjUuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
