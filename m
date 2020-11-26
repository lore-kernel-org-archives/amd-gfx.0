Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA1AC64E7A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D71206C0
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YVnwZsrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D71206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104FF6EBC4;
	Fri, 27 Nov 2020 10:14:50 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E846E96F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:26 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id x22so2181734wmc.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zMzTR5vhzo4BdnrJCmrInB6ds6XJwPsog3Z9fF6R2ds=;
 b=YVnwZsrr7sG3BHYwtr4MQW0aFJrpyD1AMT0vIyWvKcE71Md7uD7/R1HGxpYrZ+mLGc
 LeFTtH/ouu+XRI7m5k3wKbRSAWdT5hheLq1/QuRnxmNDiTlgIFJrrhudBnl8EV/RLAMr
 wWnX0ysGFBkhWiW/dGtbfC21e0xIXHmByq6e5otpAD420wMf+55cFJRcDnp6qajBpAZ4
 n87ywLwxtWbV8AiwIdfNBlpxykEfpASJ5MNiA0hqqd4t602Rt0Xo//VKfwTDbymFhPd0
 1144Nr5rim3Iu8GIBe+FjKnKVgabvyK9pIRGoq0tYp4NYkA5aZApC60sSMGcrkzNUDuU
 TKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zMzTR5vhzo4BdnrJCmrInB6ds6XJwPsog3Z9fF6R2ds=;
 b=cXp9OukIaGqhHDiNsVCeD3Xj8Y/RkeIZHK/taEzvg3ueLtXcnI97gliq7W1uxryi0N
 iSeSxONFfzkNicFEh+5+7o+JNITbktpZ/CoW10Ey6rZa+D/w17fJLbj1cTCLGE1+N1MV
 kA7uMD2J3hNzMm+9VwyYs/BsWoVIDHNNKrARECLTvh66QGtt3pnExvqUGD3NCrR16ihn
 rBEFvZsRmUrW7mERyu76b8nqD/vOfJ45xuM2015qwIgUC8ysw0dM3Wb/SnJ/NoqKRVKH
 SmcC4FZgzDtdZbxOSJ0C7QdLVKu6236kaMHjtrZErNye4QJJK8VCXBjZ8wtOEFn/6hVp
 LSZQ==
X-Gm-Message-State: AOAM531YujvbhQN89M8vA++hYOegHfA2j5P/cr9JZIBb1pvKJBSqbLU1
 mDjWFtfpRBQHH3wNKzHs4Ba9UA==
X-Google-Smtp-Source: ABdhPJyhtdnIH1ikDDVg8piHiBypOWo1mfmoQmPid3U6du/K6yVg2piBxR5ziT9lEe57b37KzCa5WQ==
X-Received: by 2002:a7b:c950:: with SMTP id i16mr3536392wml.136.1606398204018; 
 Thu, 26 Nov 2020 05:43:24 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:23 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 26/40] drm/amd/pm/powerplay/hwmgr/hwmgr: Move
 'vega12_hwmgr_init()'s prototype to shared header
Date: Thu, 26 Nov 2020 13:42:26 +0000
Message-Id: <20201126134240.3214176-27-lee.jones@linaro.org>
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl9od21nci5j
OjI4NjI6NTogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJh2ZWdhMTJfaHdt
Z3JfaW5pdOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiAyODYyIHwgaW50IHZlZ2ExMl9od21n
cl9pbml0KHN0cnVjdCBwcF9od21nciAqaHdtZ3IpCiB8IF5+fn5+fn5+fn5+fn5+fn5+CgpDYzog
RXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVs
IFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVl
IEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L2luYy9od21nci5oICAgICAgICAgICAgIHwgMSArCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bv
d2VycGxheS9od21nci9od21nci5jIHwgMSAtCiAyIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9p
bmMvaHdtZ3IuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2h3bWdyLmgKaW5kZXggMzkz
ZTRlNzZhODk2MS4uNDk5ZjI1MjBiMWFhMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9pbmMvaHdtZ3IuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL2luYy9od21nci5o
CkBAIC04MzAsNSArODMwLDYgQEAgaW50IGh3bWdyX2hhbmRsZV90YXNrKHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IsCiAKIGludCBzbXU3X2luaXRfZnVuY3Rpb25fcG9pbnRlcnMoc3RydWN0IHBwX2h3
bWdyICpod21ncik7CiBpbnQgc211OF9pbml0X2Z1bmN0aW9uX3BvaW50ZXJzKHN0cnVjdCBwcF9o
d21nciAqaHdtZ3IpOworaW50IHZlZ2ExMl9od21ncl9pbml0KHN0cnVjdCBwcF9od21nciAqaHdt
Z3IpOwogCiAjZW5kaWYgLyogX0hXTUdSX0hfICovCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9od21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3IuYwppbmRleCA3OTk5MDkxY2NhMTZlLi40OWY4YTMzMWVi
MDJlIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9o
d21nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL2h3bWdy
LmMKQEAgLTQ3LDcgKzQ3LDYgQEAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBwcF9zbXVtZ3JfZnVuYyBz
bXUxMF9zbXVfZnVuY3M7CiBleHRlcm4gY29uc3Qgc3RydWN0IHBwX3NtdW1ncl9mdW5jIHZlZ2Ey
MF9zbXVfZnVuY3M7CiAKIGV4dGVybiBpbnQgdmVnYTEwX2h3bWdyX2luaXQoc3RydWN0IHBwX2h3
bWdyICpod21ncik7Ci1leHRlcm4gaW50IHZlZ2ExMl9od21ncl9pbml0KHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IpOwogZXh0ZXJuIGludCB2ZWdhMjBfaHdtZ3JfaW5pdChzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyKTsKIGV4dGVybiBpbnQgc211MTBfaW5pdF9mdW5jdGlvbl9wb2ludGVycyhzdHJ1Y3Qg
cHBfaHdtZ3IgKmh3bWdyKTsKIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
