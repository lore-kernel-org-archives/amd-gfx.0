Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B471FC4332E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B0E2399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B0E2399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5796E913;
	Fri,  8 Jan 2021 20:24:24 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99D56E8EC
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:54 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id y17so10130379wrr.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ltlvlK446O5/kBCmREtmpcuBIIBe0mrhh4gHbZyrmLA=;
 b=eR0e+bPTMpDaQ5oVw+vorFfL18IIvsq9WMtJycz42nqe7lxrgpYAG+NnSqXEbvEPi8
 VS8S6QvbmXY4DPgbH94+g8zc924maSiO9NmbgYltoBkVxN1f2D9fpIwVo7iGozb/ic86
 R3wNL6C+wYq21lo0a6RGpG/We0wBq/no3/33xHyZ0I5G9cBZ10CDxQNUkE7nrutviyoX
 g6nEgtqpjZM7Fei3hvQDT2w7dyEFEmxPNoDLO2Oo9Qjd0XacLjqQBA5gJXQerw8m8LoY
 k3pMqPeXeo6pPh7ItawXSn1KL07TrqeD7nEcVbxfJs9/EJ0g5lBh96lDFF0oFIL7u9xv
 bb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ltlvlK446O5/kBCmREtmpcuBIIBe0mrhh4gHbZyrmLA=;
 b=XpNucvuH58ADL6ZLHFM1nlsANMdWAgPPyDnw07L5gFimTF8+8hIZcwLxpwF7VgJPTY
 Rjk7IkGViRaCFiMoWM74Mm96wOz1mybFXbCnVWLxAboWsPrykgehR4uxbOsR16eGANpQ
 ExaF/AuWIZzmCvHS85C2KytsidUGL9btFSJdM9JELeSQABKX8uBnklwz+CaFUn03S3xN
 iPNcpZGrw/tP0dkkg3beOkc2yKtU4gywNWQ1UgMW5jG5F5VgRxudKiMfJbv0y5sb/uyX
 t2GM3ZW42GGQV/x9c9w5WOo08VHrmoVEt99BT4jqZ+mbpMXK5G8/p2pS2dLB6i5XDXkY
 Jo+Q==
X-Gm-Message-State: AOAM532ArSYJZPgdqrf4+ZrJM8lpGAyEVcoaFDYz5gBd1w2Q24pkQaVZ
 +K+Ave0nvKjm9Tj0LoukUjnc/Q==
X-Google-Smtp-Source: ABdhPJywcpuW4qCShj6qOQWKOuISnPJDe556gUEO7+5pFKdb3vqCRrQBt55/KNmX2vM7BU51pX03EA==
X-Received: by 2002:adf:9467:: with SMTP id 94mr5370698wrq.235.1610136953419; 
 Fri, 08 Jan 2021 12:15:53 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:52 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 34/40] drm/amd/display/dc/bios/bios_parser: Fix misspelling of
 function parameter
Date: Fri,  8 Jan 2021 20:14:51 +0000
Message-Id: <20210108201457.3078600-35-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmM6OTk3
OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdzc19pbmZvJyBub3QgZGVz
Y3JpYmVkIGluICdnZXRfc3NfaW5mb19mcm9tX3RibCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1Ly4uL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlci5jOjk5Nzogd2FybmluZzogRXhjZXNz
IGZ1bmN0aW9uIHBhcmFtZXRlciAnc3NpbmZvJyBkZXNjcmlwdGlvbiBpbiAnZ2V0X3NzX2luZm9f
ZnJvbV90YmwnCgpDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNj
OiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVs
IFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlvc19w
YXJzZXIuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlv
cy9iaW9zX3BhcnNlci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Jpb3MvYmlv
c19wYXJzZXIuYwppbmRleCBkMjY1NGM1MGIwYjIwLi5jNjdkMjFhNWVlNTJmIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvYmlvcy9iaW9zX3BhcnNlci5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9iaW9zL2Jpb3NfcGFyc2VyLmMKQEAgLTk4
Nyw4ICs5ODcsOCBAQCBzdGF0aWMgZW51bSBicF9yZXN1bHQgZ2V0X3NzX2luZm9fZnJvbV9pbnRl
cm5hbF9zc19pbmZvX3RibF9WMl8xKAogICoKICAqIEBicDogICAgICBwb2ludGVyIHRvIHRoZSBC
SU9TIHBhcnNlcgogICogQGlkOiAgICAgIHNwcmVhZCBzcHJlY3RydW0gaW5mbyBpbmRleAotICog
QHNzaW5mbzogIHNwcmVjdHJ1bSBpbmZvcm1hdGlvbiBzdHJ1Y3R1cmUsCi0gKiByZXR1cm46OiAg
QklPUyBwYXJzZXIgcmVzdWx0IGNvZGUKKyAqIEBzc19pbmZvOiBzcHJlY3RydW0gaW5mb3JtYXRp
b24gc3RydWN0dXJlLAorICogcmV0dXJuOiAgIEJJT1MgcGFyc2VyIHJlc3VsdCBjb2RlCiAgKi8K
IHN0YXRpYyBlbnVtIGJwX3Jlc3VsdCBnZXRfc3NfaW5mb19mcm9tX3RibCgKIAlzdHJ1Y3QgYmlv
c19wYXJzZXIgKmJwLAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
