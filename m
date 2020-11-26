Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456D5C64E75
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEAAE20674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqPPgyNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAAE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 159416EBB5;
	Fri, 27 Nov 2020 10:14:49 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 652276E962
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:01 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id h21so2459144wmb.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gri5Q1ZsHo+JoBxGfrJZZW9SZIInF5/xkJvef28TzCQ=;
 b=fqPPgyNW5YpmOSE71xHIKuvM+xg9IUILLUjRvO1hWX8/333x8W4QT67NPv+C8bozIy
 tFMqF9icDS0zvyTYZgWA/m1fP0mCA7OTmHoUE2MDnIiXC9C3s2c+eDGlVzXLXwjGsVe+
 IDFwppI5i0UFrRo0NZjZ70MKdLrBCl7IB8cqFEMoqacGdKqEUpy4PeNmvBdiVrp/5mXA
 AyPY1L3++JBVT/rTM+8v2z9lupnMBLt5Y+1T1592dGIa4JCSyREVc8Nf1t1JHL7NPbfL
 8xYftyKeq7YlGfWS2xkpEPVttx7SNLBqIcMnMACyPyTAB1kpH27piWLOWJ+DylNcrA9Q
 K0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gri5Q1ZsHo+JoBxGfrJZZW9SZIInF5/xkJvef28TzCQ=;
 b=pyc9UI8dm8oP0liY2b4lrqaJf7j/Rs0UfYTpeXChbWfsul817DeuHKNNsWTFRaWZ3p
 9HxQHac/wdzhpBEcQKaR0kuuxQW53raoIRe4EYiNTVJfYgGANqNx0EqyVq+jViR0QAJG
 EYF4B4cfpq+tMwM/L8ZvoiIToJI38u1G6osrmrYztIB9y0LHm9WAthvFPp9mwbiSjoTm
 Cbq/MLrioMH3vZA19fSox7+Q/nCowRfeYa2KouwTS3PMri5thedSD00jRQf4/WCE2oZ8
 vkn7E2tEA3eVCzqJLsbrSzFDAH6jhMR4XzQnJ0GGHaAtKEyB26N6b8yqVvrlLRohglig
 6+6A==
X-Gm-Message-State: AOAM533e4Yog5Vruzl4NnA3Nzci14DAzB7RZ3AHaXfqmVQ2Mpc2gBkj/
 yMVwpU9kFBJzpxW/Wk8DoCTaiw==
X-Google-Smtp-Source: ABdhPJxpsMWiO7wJ6aWp2ZBnURciNFJyzaYsTRXTQCiK/i14aN+DP5ZoGSNsIGmzdHfSZtoU5ZxP3g==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr3493478wmj.169.1606398177946; 
 Thu, 26 Nov 2020 05:42:57 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:42:57 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 09/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move
 'smu8_init_function_pointers()' prototype to shared header
Date: Thu, 26 Nov 2020 13:42:09 +0000
Message-Id: <20201126134240.3214176-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgpDYzogRXZh
biBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZl
dHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2lu
Yy9od21nci5oICAgICAgICAgICAgIHwgMSArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2Vy
cGxheS9od21nci9od21nci5jIHwgMSAtCiAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMv
aHdtZ3IuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2h3bWdyLmgKaW5kZXggMWJiMzc5
NDk4YTEyMS4uMGUyMmNiYTNjZTNhNiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9pbmMvaHdtZ3IuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9od21nci5oCkBA
IC04MjgsNSArODI4LDYgQEAgaW50IGh3bWdyX2hhbmRsZV90YXNrKHN0cnVjdCBwcF9od21nciAq
aHdtZ3IsCiAKICNkZWZpbmUgUEhNX0VOVElSRV9SRUdJU1RFUl9NQVNLIDB4RkZGRkZGRkZVCiAK
K2ludCBzbXU4X2luaXRfZnVuY3Rpb25fcG9pbnRlcnMoc3RydWN0IHBwX2h3bWdyICpod21ncik7
CiAKICNlbmRpZiAvKiBfSFdNR1JfSF8gKi8KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vcG93ZXJwbGF5L2h3bWdyL2h3bWdyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bv
d2VycGxheS9od21nci9od21nci5jCmluZGV4IDczOWUyMTVlYzhiN2YuLmVjMTdhM2U2M2VhMDIg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL2h3bWdy
LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYwpA
QCAtNDcsNyArNDcsNiBAQCBleHRlcm4gY29uc3Qgc3RydWN0IHBwX3NtdW1ncl9mdW5jIHNtdTEw
X3NtdV9mdW5jczsKIGV4dGVybiBjb25zdCBzdHJ1Y3QgcHBfc211bWdyX2Z1bmMgdmVnYTIwX3Nt
dV9mdW5jczsKIAogZXh0ZXJuIGludCBzbXU3X2luaXRfZnVuY3Rpb25fcG9pbnRlcnMoc3RydWN0
IHBwX2h3bWdyICpod21ncik7Ci1leHRlcm4gaW50IHNtdThfaW5pdF9mdW5jdGlvbl9wb2ludGVy
cyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKTsKIGV4dGVybiBpbnQgdmVnYTEwX2h3bWdyX2luaXQo
c3RydWN0IHBwX2h3bWdyICpod21ncik7CiBleHRlcm4gaW50IHZlZ2ExMl9od21ncl9pbml0KHN0
cnVjdCBwcF9od21nciAqaHdtZ3IpOwogZXh0ZXJuIGludCB2ZWdhMjBfaHdtZ3JfaW5pdChzdHJ1
Y3QgcHBfaHdtZ3IgKmh3bWdyKTsKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
