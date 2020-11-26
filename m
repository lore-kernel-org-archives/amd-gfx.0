Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10CBC63777
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6946C20674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2cBuUey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6946C20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1633D6EBB7;
	Fri, 27 Nov 2020 10:14:49 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C66646E957
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:42:56 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id 64so2173599wra.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OVaLmyvacPrY1rDoSMt/9G1ek5c/J/kPXEt2r1H/RjI=;
 b=F2cBuUeywubkOSdIZeQQGSOkWu7bs2lvYsnoh/sMGgtoODB+x3nOzrprIw4bW+NOhC
 1HArIKXo5vW+OQ827Tml7/kmK9Q5iXrEOhIU1LTaiwJJgCo2D2VV6u/5cI3BzmzPKo8L
 dxzGm1Z5ZWfFHWMwWyIZauQV1ZDzwm6vHRVMkrXmPtyCxcsTwuBj0cUsbf9iUNkTvcbE
 xTMgeqcxaGa3H4pLwbHbD4QvzZnNl4LhAj/2rOFjLjhmxKaRTZQnBKPd7uMFlzbHuoHi
 Q2lzTkJiYhrcjM9WpL6pUdQAEwXmYDU90a5gi9HzoDIZ34X3+FTwbxugBc9iTWbywbPj
 d37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OVaLmyvacPrY1rDoSMt/9G1ek5c/J/kPXEt2r1H/RjI=;
 b=be0T6hvnmAk2MzOUvfc85ouA9XQl2G87nzdSE0kptWcOQFlCNypeUj+vPvTfcpcHPr
 kEYCZsmMA3bKkXB+9P/CzP7V+U4OBChLZnsXkgY/rCsW7G5DbRRnXJ3fG9s1wbHJGNUz
 ZL6OA/Rcri4Gt/C2+jKeZBMrq0Je9ZRwOwzgWMhoa7qs+Oj8XFz5UgOlk5nPczDa+SXw
 KoaCwkZjspr3A7tyxQ7axo0GXz+DTFrW2s5jKSaP86n9tFDO8nsXFES5YE2fKQ3w/QmT
 Z1o/Pp84kTzFZkW4yM0FBYQd++OBEoR1uo95jaAMgwpGAOdV/a1hG14OAJKZjOKwOlRn
 gBpA==
X-Gm-Message-State: AOAM5316uEmKgE68x+Vzn0HGHyCrFWLko5nlf+oNh/GQp35icrhhi9R8
 dU+jmturqflM6byPox+mnlhGEA==
X-Google-Smtp-Source: ABdhPJxfI0LU2ckWg4e0UGMMQXSTJKeWbI4Br1gKXvc+4RK9MNkeL8wdqdRuMbFSyo6qKpVFgmsJsQ==
X-Received: by 2002:adf:dd04:: with SMTP id a4mr3979594wrm.77.1606398175472;
 Thu, 26 Nov 2020 05:42:55 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:42:54 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/40] drm/amd/pm/powerplay/smumgr/fiji_smumgr: Demote
 kernel-doc format abuse
Date: Thu, 26 Nov 2020 13:42:07 +0000
Message-Id: <20201126134240.3214176-8-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5j
OjExMDc6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ21lbV9jbG9jaycg
bm90IGRlc2NyaWJlZCBpbiAnZmlqaV9nZXRfbWNsa19mcmVxdWVuY3lfcmF0aW8nCgpDYzogRXZh
biBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0Bh
bWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZl
dHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bv
d2VycGxheS9zbXVtZ3IvZmlqaV9zbXVtZ3IuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvcG0vcG93ZXJwbGF5L3NtdW1nci9maWppX3NtdW1nci5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9wb3dlcnBsYXkvc211bWdyL2Zpamlfc211bWdyLmMKaW5kZXggZmVhMDA4Y2MxZjI1NC4u
MDJjMDk0YTA2NjA1ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBs
YXkvc211bWdyL2Zpamlfc211bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dl
cnBsYXkvc211bWdyL2Zpamlfc211bWdyLmMKQEAgLTEwOTAsNyArMTA5MCw3IEBAIHN0YXRpYyBp
bnQgZmlqaV9wb3B1bGF0ZV9hbGxfZ3JhcGhpY19sZXZlbHMoc3RydWN0IHBwX2h3bWdyICpod21n
cikKIH0KIAogCi0vKioKKy8qCiAgKiBNQ0xLIEZyZXF1ZW5jeSBSYXRpbwogICogU0VRX0NHX1JF
U1AgIEJpdFszMToyNF0gLSAweDAKICAqIEJpdFsyNzoyNF0gXDk2IEREUjMgRnJlcXVlbmN5IHJh
dGlvCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
