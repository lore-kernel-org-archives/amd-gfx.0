Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9609DC55ABD
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A285206CB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ONMp+BLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A285206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AB489722;
	Mon,  9 Nov 2020 21:21:47 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9FB895B9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:31 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id h2so961712wmm.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T1sUvjuz6GhGo/eyfmlP/SOHCvkRA45s8OKsudAKYNE=;
 b=ONMp+BLP0pr8GPw4qGQ5ZafDFD+hKfVrwwI3l0QNlbUCStl/4v20Q2yKrVeUVieJ/1
 /EHEG++w11JWCuRkI6pVfbliwTpAMswOOxzKqHVOuq4dDrk74KHAaF458LgMN+/XKWAo
 SIcyz5tZ4bXs7cGR7YqPOFdKiJ0skIJ5jsFNhl7Ea5Q9szqmPq2TCH/UZxpjE3K9EV9h
 vp4QUfIDYNirEHinBWvHkQ7ZVv9RrznVs1023gtMY17oJIpvTUzdQtaJaPCJiVyVnn9g
 AX3v/5GkiAAnNlntob34lzgthtPjni35Do2nVDGWEYGZz7zDBJruQkiw8wHElCLheDdp
 LP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T1sUvjuz6GhGo/eyfmlP/SOHCvkRA45s8OKsudAKYNE=;
 b=sko4+XAaSnduMQa7YH7d9WlfO465LmAF83O64ZqGDPRwB4xzZZNijPe4qFFwjNtOmZ
 nj6AF76zgaoh0qBYtK6Oe/ypixUbgCadfCH6ivpXeq+vlJCG0qNbLg83V/GiLjTUw0rJ
 MoRBaADXOtFB7/rUPvspQFs8T0rvOivU6FpUs+8qr/8CsR7PpjLO6eFebcLqANk6nERP
 7o/q3STAQLHWQUvxIyLoH01f+eHrkxVnK3BlfwcjCTXVSr/ciVx58Iblhprh4GtYfyrz
 3xPgYO9wBL59v4Qovjgc0+VMYxy70NTlxk+E05mEFKS57X964PGBztcvygTlG4jjQgTt
 8WkA==
X-Gm-Message-State: AOAM532BOUneZR0+gjuzrTYmWHWIQq0JvZ4BRleqfKt1dAlvrIMFm8sL
 i6vjws83jSwVlfIJdjZzY+KHNw==
X-Google-Smtp-Source: ABdhPJzHnjRnvLRbbyNs0pdXowVajS1XQ2JnHaXuKTaF/Vt1oT1OPIgR3k9xHsvdt2BWOG6GPb38iw==
X-Received: by 2002:a05:600c:2110:: with SMTP id
 u16mr1168189wml.4.1604956770543; 
 Mon, 09 Nov 2020 13:19:30 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:29 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 11/20] drm/radeon/r600: Strip out set but unused 'tmp'
 variables
Date: Mon,  9 Nov 2020 21:18:46 +0000
Message-Id: <20201109211855.3340030-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:21:41 +0000
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yNjAwLmM6IEluIGZ1bmN0aW9uIOKAmHI2MDBfcGNpZV9nYXJ0X3Rs
Yl9mbHVzaOKAmToKIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5jOjEwODM6Nzogd2Fybmlu
ZzogdmFyaWFibGUg4oCYdG1w4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQt
dmFyaWFibGVdCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDAuYzogQXQgdG9wIGxldmVsOgog
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwLmM6IEluIGZ1bmN0aW9uIOKAmHI2MDBfbW1pb19o
ZHBfZmx1c2jigJk6CiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDAuYzo0MzkzOjc6IHdhcm5p
bmc6IHZhcmlhYmxlIOKAmHRtcOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0
LXZhcmlhYmxlXQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
Q2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZm
d2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdA
bGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcjYwMC5jIHwgNiArKy0tLS0KIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yNjAwLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3I2MDAuYwppbmRleCBkOWEzM2NhNzY4ZjM0Li42ZTc4MGIwMTA5OTk1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3I2MDAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3I2MDAuYwpAQCAtMTA4MCw3ICsxMDgwLDYgQEAgdm9pZCByNjAwX3BjaWVfZ2FydF90bGJfZmx1
c2goc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCiAJaWYgKChyZGV2LT5mYW1pbHkgPj0gQ0hJ
UF9SVjc3MCkgJiYgKHJkZXYtPmZhbWlseSA8PSBDSElQX1JWNzQwKSAmJgogCSAgICAhKHJkZXYt
PmZsYWdzICYgUkFERU9OX0lTX0FHUCkpIHsKIAkJdm9pZCBfX2lvbWVtICpwdHIgPSAodm9pZCAq
KXJkZXYtPmdhcnQucHRyOwotCQl1MzIgdG1wOwogCiAJCS8qIHI3eHggaHcgYnVnLiAgd3JpdGUg
dG8gSERQX0RFQlVHMSBmb2xsb3dlZCBieSBmYiByZWFkCiAJCSAqIHJhdGhlciB0aGFuIHdyaXRl
IHRvIEhEUF9SRUdfQ09IRVJFTkNZX0ZMVVNIX0NOVEwKQEAgLTEwODgsNyArMTA4Nyw3IEBAIHZv
aWQgcjYwMF9wY2llX2dhcnRfdGxiX2ZsdXNoKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2KQog
CQkgKiBtZXRob2QgZm9yIHRoZW0uCiAJCSAqLwogCQlXUkVHMzIoSERQX0RFQlVHMSwgMCk7Ci0J
CXRtcCA9IHJlYWRsKCh2b2lkIF9faW9tZW0gKilwdHIpOworCQlyZWFkbCgodm9pZCBfX2lvbWVt
ICopcHRyKTsKIAl9IGVsc2UKIAkJV1JFRzMyKFJfMDA1NDgwX0hEUF9NRU1fQ09IRVJFTkNZX0ZM
VVNIX0NOVEwsIDB4MSk7CiAKQEAgLTQzOTAsMTAgKzQzODksOSBAQCB2b2lkIHI2MDBfbW1pb19o
ZHBfZmx1c2goc3RydWN0IHJhZGVvbl9kZXZpY2UgKnJkZXYpCiAJaWYgKChyZGV2LT5mYW1pbHkg
Pj0gQ0hJUF9SVjc3MCkgJiYgKHJkZXYtPmZhbWlseSA8PSBDSElQX1JWNzQwKSAmJgogCSAgICBy
ZGV2LT52cmFtX3NjcmF0Y2gucHRyICYmICEocmRldi0+ZmxhZ3MgJiBSQURFT05fSVNfQUdQKSkg
ewogCQl2b2lkIF9faW9tZW0gKnB0ciA9ICh2b2lkICopcmRldi0+dnJhbV9zY3JhdGNoLnB0cjsK
LQkJdTMyIHRtcDsKIAogCQlXUkVHMzIoSERQX0RFQlVHMSwgMCk7Ci0JCXRtcCA9IHJlYWRsKCh2
b2lkIF9faW9tZW0gKilwdHIpOworCQlyZWFkbCgodm9pZCBfX2lvbWVtICopcHRyKTsKIAl9IGVs
c2UKIAkJV1JFRzMyKFJfMDA1NDgwX0hEUF9NRU1fQ09IRVJFTkNZX0ZMVVNIX0NOVEwsIDB4MSk7
CiB9Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
