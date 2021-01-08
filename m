Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54248C43333
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28A52399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28A52399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C676E901;
	Fri,  8 Jan 2021 20:24:22 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 904596E8DA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:39 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id t16so10168844wra.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=J9hwKoCUKPkAVEJG7PdvhZlNWecZ9XZq8Q6EZdE3uyc=;
 b=hEJFVXCVtwgK4Ggr5Yq+CnblBWyx906VjOGVxfnc2I9GwMfjxBlYdIufR3N0PgPmBh
 XzeWu1y/95DEw+MOBpoPJmeUkjIhV59SsQ5YxzenvG+XvqtqIm9DYK5uwVwZrkNxwvaZ
 NKLeliZDCZwVeb+sL1YknAuu5Yl58Xur2WNTqAvK9qCl2Ah4T8B89/oNpVFMdiFAjujM
 4NYnKhCsW75iuMfCwW+XALsrF5a2GYVf8fileLh0IXeaofih5iiHhDxa4h9uis5rYEc1
 yloX+0Z9EgB6LqnVve8JF5u9cDXP/Ol28Ax5Xno8C5kNyHSO2N0AzqVZPpSBsMxQ7sGQ
 1YdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J9hwKoCUKPkAVEJG7PdvhZlNWecZ9XZq8Q6EZdE3uyc=;
 b=kpDVNRgkmFjyAYMfs/GRToy+B76ptrVEv/UijoyH16PAcqWxE17ZkixHjCqJYZ/zpn
 oQfQSOFvuOjacjoqXnd+BKTBjBLaA5eb7d/fqgQ1T7Yl+AQd2osQxp7dZUSzoi42CIHx
 63inhc9sFfw5o7CcYFRqYXiCbWhVeGIdGLHbc5XnIs5C8W2Xz/4y3xl4qQ2HQWDRQuMS
 kTuk1qfGIeoZDwD5TjqrG0UzjSGO5EgHIIIz+aLPbo0o7NfPG+zmMuToY2zvZ21vWJWO
 aHUrqYynEXXzsS6qqwSxPP8zSgd4Lj4X0gKqel5/95fUANS63KhMvFCTLl++7IxnFO75
 FNUw==
X-Gm-Message-State: AOAM5328peUA9Eyw1VQ9DU7bXBFw3IroXPpU38QTq9ACW9FtLvWp2Rv+
 WSsZf77v64spCyXrWdoESlJlPQ==
X-Google-Smtp-Source: ABdhPJzWWkh1l8v/XVzgOhfkoK44n4cUyCHmhMl1lDPjo2mxR+9aIqk4vVLNoAYoABBXMiS+99NELA==
X-Received: by 2002:adf:dec7:: with SMTP id i7mr5279212wrn.373.1610136938211; 
 Fri, 08 Jan 2021 12:15:38 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:37 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 23/40] drm/amd/display/dc/dce/dce_audio: Make function invoked
 by reference static
Date: Fri,  8 Jan 2021 20:14:40 +0000
Message-Id: <20210108201457.3078600-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Jan 2021 20:24:14 +0000
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
Cc: Charlene Liu <Charlene.Liu@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>, linux-kernel@vger.kernel.org,
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX2F1ZGlvLmM6ODcxOjY6
IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZGNlNjBfYXVkX3dhbGxfZHRv
X3NldHVw4oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFy
cnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzog
QWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBL
w7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxp
ZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBNYXVy
byBSb3NzaSA8aXNzb3Iub3J1YW1AZ21haWwuY29tPgpDYzogQ2hhcmxlbmUgTGl1IDxDaGFybGVu
ZS5MaXVAYW1kLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVl
LmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZS9kY2VfYXVkaW8uYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9k
Y2UvZGNlX2F1ZGlvLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9h
dWRpby5jCmluZGV4IDJhMmEwZmRiOTI1MzkuLjc4NjZjZjJhNjY4ZmEgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1ZGlvLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kY2VfYXVkaW8uYwpAQCAtODY4LDcgKzg2OCw3
IEBAIHZvaWQgZGNlX2F1ZF93YWxsX2R0b19zZXR1cCgKIH0KIAogI2lmIGRlZmluZWQoQ09ORklH
X0RSTV9BTURfRENfU0kpCi12b2lkIGRjZTYwX2F1ZF93YWxsX2R0b19zZXR1cCgKK3N0YXRpYyB2
b2lkIGRjZTYwX2F1ZF93YWxsX2R0b19zZXR1cCgKIAlzdHJ1Y3QgYXVkaW8gKmF1ZGlvLAogCWVu
dW0gc2lnbmFsX3R5cGUgc2lnbmFsLAogCWNvbnN0IHN0cnVjdCBhdWRpb19jcnRjX2luZm8gKmNy
dGNfaW5mbywKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
