Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC70FC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE0022B51
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE0022B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F656E0F0;
	Mon, 11 Jan 2021 19:54:48 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA0A89DEC
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:42 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id r7so934602wrc.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qokjD6k+LHHF78mVRlZu4OQtVVLhVZTnUnkH0SWg7U4=;
 b=Y7hRLpaw1tA7qK1gE0XMTHNgfJoJa25sR2HTvgV5c7RjonfBp0XE2iRIsnCFMtGO39
 S+NEpJl2eaEmALDQRKx8ppkwsCoVWE3be6ZZJFzOuP67Xvztt95hteobDRDSxOb/95MM
 lKRVIyo4wj/LQnNfBuNrjra9ty8cH1ugArBlzNWr6EHFKCOUdEWycKG234cNehdzJ+wP
 0QDVGyYLbpKAFH1a21yyszuVT9kl0cgGtmbtDEQiL1HpMRc+hvrgqhNAQ37t/CyQBE/L
 UwaAKv90//Snerjrws6nYy8YrKhwdfpClNDZ0IvSLAcuPPQJeDDzpFV92/gqloYExeN0
 eYzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qokjD6k+LHHF78mVRlZu4OQtVVLhVZTnUnkH0SWg7U4=;
 b=o9KDPnGh/G/H7mq4ImJUXmumeNGGiNqPXtMO0ye2Wxd63ma2RZkcKiEjiIsUYQhBUe
 HNHmE/SCscTVaQ8gojteeEELslhX5FyWx84w1+t1X4zfFARUddZd/RR80JTMsLyi5Gph
 7KITIHB8TGB+korN981UILdm/SAZYMrQwcNpOnpXKFmvrEKXlHVHEse+zTMqpi5Arouy
 8sq9tXwucZa1q+DmLwg/lbpXMLcx6pycYzxZYMG7t9bAsYzAsg2AkRFLwv1IT0fMcOtO
 o8lnKJ0EhhYLjKH2IpgGtxpg3CUbv/v77SpvaZQ4shYsUydgczGbGrdD2+b/llh4Dcpy
 3A1w==
X-Gm-Message-State: AOAM5309SGpyz/RSacs2lUMbBRbgQthOf1jrQBJlsegMjQ9u8zo6gmHI
 /auLW5T7cbZMEhsLzvNR6dwvlw==
X-Google-Smtp-Source: ABdhPJzjSnGz3m69nDkME1UYSAct3l1QQN+GkRACjqqKTZWxnotX0x9Ssham7MB2ZUEAb0ssDpTGyg==
X-Received: by 2002:adf:c449:: with SMTP id a9mr570620wrg.281.1610392780828;
 Mon, 11 Jan 2021 11:19:40 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:40 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 08/40] drm/amd/display/dc/gpio/diagnostics/hw_factory_diag:
 Fix struct declared inside parameter list error
Date: Mon, 11 Jan 2021 19:18:54 +0000
Message-Id: <20210111191926.3688443-9-lee.jones@linaro.org>
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9ncGlvL2RpYWdub3N0aWNzL2h3X2Zh
Y3RvcnlfZGlhZy5oOjMwOjQzOiB3YXJuaW5nOiDigJhzdHJ1Y3QgaHdfZmFjdG9yeeKAmSBkZWNs
YXJlZCBpbnNpZGUgcGFyYW1ldGVyIGxpc3Qgd2lsbCBub3QgYmUgdmlzaWJsZSBvdXRzaWRlIG9m
IHRoaXMgZGVmaW5pdGlvbiBvciBkZWNsYXJhdGlvbgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvLi4vZGlzcGxheS9kYy9ncGlvL2RpYWdub3N0aWNzL2h3X2ZhY3RvcnlfZGlhZy5oOjMwOjY6
IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mIOKAmGRhbF9od19mYWN0b3J5X2RpYWdfZnBn
YV9pbml04oCZIHdhcyBoZXJlCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5
L2RjL2dwaW8vZGlhZ25vc3RpY3MvaHdfZmFjdG9yeV9kaWFnLmg6MzA6NDM6IHdhcm5pbmc6IOKA
mHN0cnVjdCBod19mYWN0b3J54oCZIGRlY2xhcmVkIGluc2lkZSBwYXJhbWV0ZXIgbGlzdCB3aWxs
IG5vdCBiZSB2aXNpYmxlIG91dHNpZGUgb2YgdGhpcyBkZWZpbml0aW9uIG9yIGRlY2xhcmF0aW9u
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2dwaW8vZGlhZ25vc3Rp
Y3MvaHdfZmFjdG9yeV9kaWFnLmg6MzA6Njogbm90ZTogcHJldmlvdXMgZGVjbGFyYXRpb24gb2Yg
4oCYZGFsX2h3X2ZhY3RvcnlfZGlhZ19mcGdhX2luaXTigJkgd2FzIGhlcmUKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5
X2RpYWcuaDozMDo0Mzogd2FybmluZzog4oCYc3RydWN0IGh3X2ZhY3RvcnnigJkgZGVjbGFyZWQg
aW5zaWRlIHBhcmFtZXRlciBsaXN0IHdpbGwgbm90IGJlIHZpc2libGUgb3V0c2lkZSBvZiB0aGlz
IGRlZmluaXRpb24gb3IgZGVjbGFyYXRpb24KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4u
L2Rpc3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuaDozMDo2OiBub3Rl
OiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJhkYWxfaHdfZmFjdG9yeV9kaWFnX2ZwZ2FfaW5p
dOKAmSB3YXMgaGVyZQoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29t
PgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogLi4uL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZ3Bpby9kaWFnbm9zdGljcy9od19mYWN0b3J5X2RpYWcuaCAgIHwgMiArKwogMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9ncGlvL2RpYWdub3N0aWNzL2h3X2ZhY3RvcnlfZGlhZy5oIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vZGlhZ25vc3RpY3MvaHdfZmFjdG9yeV9k
aWFnLmgKaW5kZXggOGE3NGY2YWRiOGVlZS4uYmY2OGViMWQ5YTFkMiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vZGlhZ25vc3RpY3MvaHdfZmFjdG9yeV9k
aWFnLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vZGlhZ25vc3Rp
Y3MvaHdfZmFjdG9yeV9kaWFnLmgKQEAgLTI2LDYgKzI2LDggQEAKICNpZm5kZWYgX19EQUxfSFdf
RkFDVE9SWV9ESUFHX0ZQR0FfSF9fCiAjZGVmaW5lIF9fREFMX0hXX0ZBQ1RPUllfRElBR19GUEdB
X0hfXwogCitzdHJ1Y3QgaHdfZmFjdG9yeTsKKwogLyogSW5pdGlhbGl6ZSBIVyBmYWN0b3J5IGZ1
bmN0aW9uIHBvaW50ZXJzIGFuZCBwaW4gaW5mbyAqLwogdm9pZCBkYWxfaHdfZmFjdG9yeV9kaWFn
X2ZwZ2FfaW5pdChzdHJ1Y3QgaHdfZmFjdG9yeSAqZmFjdG9yeSk7CiAKLS0gCjIuMjUuMQoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
