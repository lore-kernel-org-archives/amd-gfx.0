Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B50CC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB89323102
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 08:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB89323102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A6E06E10F;
	Wed, 13 Jan 2021 08:24:28 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE50F6E06D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 08:08:20 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id i9so1074323wrc.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 00:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r8/kdy25+oZx/uNDbhJDkZDT1TyOhQzo6tdoqzLeeYY=;
 b=Ix8nCYPNU/XT2iKvtKsMgQ6u2nvUKoXhtnv93uPzBrkS2d2uGV9+bwSpITZtp9gTQs
 0eqF5B+SFLW4DK9OrR2pzTeYuDKm+kIBaAYJpZjEJ4Y60fTOnEA/W7vsFFF3JmS9GRXz
 A9o9oFjFuWv/yFFb0kdM7jhQQi9YR4MaeugPWUKowTlo0ntyIEa8DV4a1wcRqNptjmHz
 5e2If+kl8VfjN/gxc9yfWSeHE1qug+jcQpHuWcM8USdkbvsDlYIeCK3bKtJgW5/FhYeJ
 HSLlIG1NpoNr7yhYIIrqePDccEjCRRt6lWY86cwGYSf8HUsXUIUxfNsun6Wxtf2b9ShN
 4iHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r8/kdy25+oZx/uNDbhJDkZDT1TyOhQzo6tdoqzLeeYY=;
 b=p1Hyb3s04cWR74RLi0+vYy/+LQQyKRnHKp7KgYzHN7J1s0D0qO7vXDaHVykkRHJRMy
 drQTQBdVVIqzOdq7QnrK67gUTkwx0d1ER7u6zfCJofr1nzwLPuywTZN6mbx1Spc8lepa
 xWpa5H4dz3jU8QrnE5ckMfiiGMEXS7HBdZTgvg7VK5UTnMR3U4TsHxmmX1oL7VyrvrlP
 WWDbhvBFJSz9HVd4s5P2ekaIIMFYpCtPmR7J5CHQZrhXxlWYHUvMSlQbZkG/nikT8/by
 fZqYBTcyHLwqsSAa8q4zFRYmJwHpXYNTMtzBohQz7ckQPducdusEGKtwelYSCqvALr7D
 uOsw==
X-Gm-Message-State: AOAM530rgmNJGnXtgTt/Icp96npQM3r6KzilG/ym2ZUwVd9uhmKrEfPU
 +nasTyzCq+oUbKxjgepJlBarzQ==
X-Google-Smtp-Source: ABdhPJyLPmAhEV8RkLWymbYSLvsMBDf3ChVGj/PjJVirElcB8p0dwnq88kAr/EkDEIB0wS4OYtyzDg==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr1178774wrq.75.1610525299664;
 Wed, 13 Jan 2021 00:08:19 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 00:08:18 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 19/30] drm/amd/display/dc/core/dc_link_dp: Mark
 'result_write_min_hblank' as __maybe_unused
Date: Wed, 13 Jan 2021 08:07:41 +0000
Message-Id: <20210113080752.1003793-20-lee.jones@linaro.org>
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

SXQgbG9va3MgbGlrZSBpdCBjb3VsZCBiZSB1c2VkIGluc2lkZSB0aGUgRENfVFJBQ0VfTEVWRUxf
TUVTU0FHRSgpIG1hY3JvLgoKRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdh
cm5pbmcocyk6CgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3Jl
L2RjX2xpbmtfZHAuYzogSW4gZnVuY3Rpb24g4oCYZHBjZF9zZXRfc291cmNlX3NwZWNpZmljX2Rh
dGHigJk6CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGNf
bGlua19kcC5jOjQ0MDM6MTg6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHJlc3VsdF93cml0ZV9taW5f
aGJsYW5r4oCZIHNldCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpD
YzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1
bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpD
YzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFu
aWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUu
am9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29y
ZS9kY19saW5rX2RwLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMv
Y29yZS9kY19saW5rX2RwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9k
Y19saW5rX2RwLmMKaW5kZXggM2MzM2I4ZmUyMThlNS4uYjllNWUwZWVlM2QyNCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGNfbGlua19kcC5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2RjX2xpbmtfZHAuYwpAQCAtNDQw
MCw3ICs0NDAwLDcgQEAgdm9pZCBkcF9zZXRfZmVjX2VuYWJsZShzdHJ1Y3QgZGNfbGluayAqbGlu
aywgYm9vbCBlbmFibGUpCiB2b2lkIGRwY2Rfc2V0X3NvdXJjZV9zcGVjaWZpY19kYXRhKHN0cnVj
dCBkY19saW5rICpsaW5rKQogewogCWlmICghbGluay0+ZGMtPnZlbmRvcl9zaWduYXR1cmUuaXNf
dmFsaWQpIHsKLQkJZW51bSBkY19zdGF0dXMgcmVzdWx0X3dyaXRlX21pbl9oYmxhbmsgPSBEQ19O
T1RfU1VQUE9SVEVEOworCQllbnVtIGRjX3N0YXR1cyBfX21heWJlX3VudXNlZCByZXN1bHRfd3Jp
dGVfbWluX2hibGFuayA9IERDX05PVF9TVVBQT1JURUQ7CiAJCXN0cnVjdCBkcGNkX2FtZF9zaWdu
YXR1cmUgYW1kX3NpZ25hdHVyZTsKIAkJYW1kX3NpZ25hdHVyZS5BTURfSUVFRV9UeFNpZ25hdHVy
ZV9ieXRlMSA9IDB4MDsKIAkJYW1kX3NpZ25hdHVyZS5BTURfSUVFRV9UeFNpZ25hdHVyZV9ieXRl
MiA9IDB4MDsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
