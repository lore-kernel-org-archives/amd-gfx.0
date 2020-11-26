Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ACAC2D0E4
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210B120674
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZrrrsDoz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210B120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBE16EBA2;
	Fri, 27 Nov 2020 10:14:48 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2E36E957
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:42:58 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id c198so2210530wmd.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NHPe3Mn8cbArsPPQt69rySCnIbjXwyEYsPDbwO3FTTg=;
 b=ZrrrsDoz87EZgy+M2aL51jy5fVNnRT9Ooj/mOazxarq50HhmO8uE9haPCFapX0NTg9
 x6bITVxxMy2ceyMIwwlvVmfWhLohKVIHaifZYvD564ABfgOPiHpkcZAbNCqT3gCiBxRH
 imzJ74y7rbX2hhwcFh9PdH9ckSdhgs9smHWe8Tx/tFs4BfKX7eww65fmFdde3p7JFBTQ
 ry69c8PoPC0zzTqFcvuG7NWha5f4adD59UdUYcyH7Yn6EZ8wG8/T5Smq0V+PfDRSZvlZ
 Z2SczZBNrlqd51wVoJ/qGri9TQGx9wCE+/ihHS3qMxVbsFChNME1JW6ADJCox2oValvD
 4kYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NHPe3Mn8cbArsPPQt69rySCnIbjXwyEYsPDbwO3FTTg=;
 b=tXqnHgronLcXO08O81MZr0+Q19fXs5epSZPZML0JqpS0v+J8NChSh73+gfqlPL4uxg
 v48TgdQfhyE1gd4vR16dbewGOZdN9mQ5ckBbH8BgVVLeSeiW6FctQ/R2D7Ntpd+DsMB9
 5cQdWPJok19OSGB83G92G13Cl7k9dsgmnlbJqP06KhORaNWe9VqfzVWv/I5a9WqU4/MF
 xRqVc3eTG+c5bc4K2sqcPdbI2aaiEcF4yfK2xCRziV6hQnOakYU0eLzpy+QF7y2gSBy1
 hEX06/g0Ld0eyCf4PLG8G8qdW1FM0i5a4K33HE08OGyOrDCBTrHkqe5Ncx1eWOtRv+Rn
 xhvw==
X-Gm-Message-State: AOAM531zURfh1Hl6fq5HJh9DAC5zp+NsfY2bGirldTtcSYz+bQctDvTd
 H2X88e1IyOATZuMGKne7+O+h3Q==
X-Google-Smtp-Source: ABdhPJxByRK1Q8cdllulc14iL3DZ69ssy3TPiMpLDs4KGV5DAkCdW1u+aGwsGVDu2jftEfHpDkPoDA==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr3512224wmc.130.1606398176747; 
 Thu, 26 Nov 2020 05:42:56 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:42:56 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/40] drm/amd/pm/powerplay/hwmgr/hardwaremanager: Remove
 unused 'phm_set_*()' functions
Date: Thu, 26 Nov 2020 13:42:08 +0000
Message-Id: <20201126134240.3214176-9-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdl
ci5jOjUxODo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHBobV9zZXRf
bWluX2RlZXBfc2xlZXBfZGNlZmNsa+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9wbS9wb3dlcnBsYXkvaHdtZ3IvaGFyZHdhcmVtYW5hZ2Vy
LmM6NTI4OjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcGhtX3NldF9o
YXJkX21pbl9kY2VmY2xrX2J5X2ZyZXHigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdl
ci5jOjUzODo1OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHBobV9zZXRf
aGFyZF9taW5fZmNsa19ieV9mcmVx4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KCkNjOiBFdmFu
IFF1YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpD
YzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIC4uLi9hbWQvcG0vcG93ZXJwbGF5L2h3bWdy
L2hhcmR3YXJlbWFuYWdlci5jICB8IDMxIC0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bt
L3Bvd2VycGxheS9od21nci9oYXJkd2FyZW1hbmFnZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG0vcG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdlci5jCmluZGV4IDFmOWI5ZmFjZGYxZjQu
LjQ1ZGRlM2U3NGI1NzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJw
bGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0v
cG93ZXJwbGF5L2h3bWdyL2hhcmR3YXJlbWFuYWdlci5jCkBAIC01MTQsMzQgKzUxNCwzIEBAIGlu
dCBwaG1fc2V0X2FjdGl2ZV9kaXNwbGF5X2NvdW50KHN0cnVjdCBwcF9od21nciAqaHdtZ3IsIHVp
bnQzMl90IGNvdW50KQogCiAJcmV0dXJuIGh3bWdyLT5od21ncl9mdW5jLT5zZXRfYWN0aXZlX2Rp
c3BsYXlfY291bnQoaHdtZ3IsIGNvdW50KTsKIH0KLQotaW50IHBobV9zZXRfbWluX2RlZXBfc2xl
ZXBfZGNlZmNsayhzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyLCB1aW50MzJfdCBjbG9jaykKLXsKLQlQ
SE1fRlVOQ19DSEVDSyhod21ncik7Ci0KLQlpZiAoIWh3bWdyLT5od21ncl9mdW5jLT5zZXRfbWlu
X2RlZXBfc2xlZXBfZGNlZmNsaykKLQkJcmV0dXJuIC1FSU5WQUw7Ci0KLQlyZXR1cm4gaHdtZ3It
Pmh3bWdyX2Z1bmMtPnNldF9taW5fZGVlcF9zbGVlcF9kY2VmY2xrKGh3bWdyLCBjbG9jayk7Ci19
Ci0KLWludCBwaG1fc2V0X2hhcmRfbWluX2RjZWZjbGtfYnlfZnJlcShzdHJ1Y3QgcHBfaHdtZ3Ig
Kmh3bWdyLCB1aW50MzJfdCBjbG9jaykKLXsKLQlQSE1fRlVOQ19DSEVDSyhod21ncik7Ci0KLQlp
ZiAoIWh3bWdyLT5od21ncl9mdW5jLT5zZXRfaGFyZF9taW5fZGNlZmNsa19ieV9mcmVxKQotCQly
ZXR1cm4gLUVJTlZBTDsKLQotCXJldHVybiBod21nci0+aHdtZ3JfZnVuYy0+c2V0X2hhcmRfbWlu
X2RjZWZjbGtfYnlfZnJlcShod21nciwgY2xvY2spOwotfQotCi1pbnQgcGhtX3NldF9oYXJkX21p
bl9mY2xrX2J5X2ZyZXEoc3RydWN0IHBwX2h3bWdyICpod21nciwgdWludDMyX3QgY2xvY2spCi17
Ci0JUEhNX0ZVTkNfQ0hFQ0soaHdtZ3IpOwotCi0JaWYgKCFod21nci0+aHdtZ3JfZnVuYy0+c2V0
X2hhcmRfbWluX2ZjbGtfYnlfZnJlcSkKLQkJcmV0dXJuIC1FSU5WQUw7Ci0KLQlyZXR1cm4gaHdt
Z3ItPmh3bWdyX2Z1bmMtPnNldF9oYXJkX21pbl9mY2xrX2J5X2ZyZXEoaHdtZ3IsIGNsb2NrKTsK
LX0KLQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
