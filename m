Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A29C47089
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F401360FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F401360FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69F0B6ECEC;
	Wed, 26 May 2021 12:57:28 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D837F6EC33
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:35 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 f6-20020a1c1f060000b0290175ca89f698so15003095wmf.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Ey2XQCTHoPB7PbhRpIhhlCIFboLF4MIg90vAb+6Iw48=;
 b=L/iJmUQ1wl4h9pSToLi6ngPyg5UA7AeSWQLOEuFjYdsGt+aIJ2JW3IZyE7TyAvl9zp
 glIhu+aKxXtueYZgd2owFNE0ZH3GVlcEDRAUqpItp+X/sLU+ZR0QYqsLVt80CWoZJUk/
 8d8WNwVuJvhfQqGDn92TSIpDtUNG2tSRqfbjU47JhqUsypTbNrf101/f47GA1k352++H
 H1+XxvhmsG5nyLGBwyds2ImgQK8W/kvKF7HlRSoMRQP+UXOpqJQkYUi1HhAHi+j/Z6X3
 TtYsAajhfILOXFoKHIGLxd1yRvhSIi+4tL6F4Et9K+iLfpi8CuxPUGxU+XqxliUJ2Jdq
 FoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ey2XQCTHoPB7PbhRpIhhlCIFboLF4MIg90vAb+6Iw48=;
 b=IVd1E73+nVf+UDYF4b63XiLpRkGKe7xPKTFbVbKhybu/GwibY54zVlYYOaUouQXt1I
 vqnOuQAMndwCsU59zKzBX+Cg9BCcNI5nqxHe3DXrEYp3UZ84nuDCHWM4n1pOdL0V2SWc
 ew0U0kQNqrV89vltRmVpXeV2YZ5U6ycy7H62OtqQ0ItQpS2NmZvpeNirW/geM5HkpN1G
 c07/OQPIniAhPnGH+OpB4EeB5vrhQnWQ1Ae+UukiZR4q91r95DZ6Ct20HupuQgfVjuo7
 Aj+//Ty9D+mcnFWEFbd6ZviQOvVPPvaXoosqiWWVtsO5xB58ywEth+N/xkL/48AcLqVS
 Hidg==
X-Gm-Message-State: AOAM530GnzvIZ3/C/jdvp1po4D0DwCsx7CgU+GloTPo5pysESmW5QB/j
 26QRE+VSrq3XvMPiMMxLv9M20g==
X-Google-Smtp-Source: ABdhPJzhoEFdv2lfo6EL3yXLQSIgGr2CwhLPmszdq9ctvreMndQ6VRfnClZOGx7KUBNH8MO6zsGhOw==
X-Received: by 2002:a7b:c417:: with SMTP id k23mr11601416wmi.90.1622018854475; 
 Wed, 26 May 2021 01:47:34 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:34 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 04/34] drm/amd/pm/powerplay/hwmgr/vega12_thermal: Provide
 function name
Date: Wed, 26 May 2021 09:46:56 +0100
Message-Id: <20210526084726.552052-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl90aGVybWFs
LmM6MTcxOiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciBTZXQgdGhlIHJlcXVlc3Rl
ZCB0ZW1wZXJhdHVyZSByYW5nZSBmb3IgaGlnaCBhbmQgbG93IGFsZXJ0IHNpZ25hbHMoKS4gUHJv
dG90eXBlIHdhcyBmb3IgdmVnYTEyX3RoZXJtYWxfc2V0X3RlbXBlcmF0dXJlX3JhbmdlKCkgaW5z
dGVhZAoKQ2M6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4K
Q2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1v
ZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX3RoZXJtYWwuYyB8IDMgKystCiAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX3RoZXJtYWwuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2ExMl90aGVybWFsLmMK
aW5kZXggMGRjMTZmMjVhNDYzYi4uZWQzZGZmMGI1MmQyMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTEyX3RoZXJtYWwuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMTJfdGhlcm1hbC5jCkBAIC0x
NTksNyArMTU5LDggQEAgaW50IHZlZ2ExMl90aGVybWFsX2dldF90ZW1wZXJhdHVyZShzdHJ1Y3Qg
cHBfaHdtZ3IgKmh3bWdyKQogfQogCiAvKioKLSAqIFNldCB0aGUgcmVxdWVzdGVkIHRlbXBlcmF0
dXJlIHJhbmdlIGZvciBoaWdoIGFuZCBsb3cgYWxlcnQgc2lnbmFscworICogdmVnYTEyX3RoZXJt
YWxfc2V0X3RlbXBlcmF0dXJlX3JhbmdlIC0gU2V0IHRoZSByZXF1ZXN0ZWQgdGVtcGVyYXR1cmUg
cmFuZ2UKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZvciBoaWdo
IGFuZCBsb3cgYWxlcnQgc2lnbmFscwogICoKICAqIEBod21ncjogVGhlIGFkZHJlc3Mgb2YgdGhl
IGhhcmR3YXJlIG1hbmFnZXIuCiAgKiBAcmFuZ2U6IFRlbXBlcmF0dXJlIHJhbmdlIHRvIGJlIHBy
b2dyYW1tZWQgZm9yCi0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
