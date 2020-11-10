Return-Path: <SRS0=ErGV=EQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19450C56202
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAC7C20678
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2020 19:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IWSDVKQF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAC7C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4902F89CA1;
	Tue, 10 Nov 2020 19:35:47 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A1CC89BF1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 19:31:41 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id c16so4310484wmd.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2020 11:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BSn+OXUyqlvsEb5g4HG7YJio2FrFxnG4RAzoSpJ37n4=;
 b=IWSDVKQFg3hpW8WwWnraoONM854vSPQmeNeTXUPVHV2/Mrs0NRUEKMoXn9yMH91a+B
 68ndDNvEffubTXaT7qdx8pdnKbe0bn0OWdVSy0Y4ttygX7CeW5rC91Cf7opxRCPpTZ4u
 mJ5Z88gfhGnngt/P+SIBa18MYmx+vzsnUTjS1lupg/L2S15JCAy38Szym/o6fDNcFpS8
 zspEldGMz285nlZIgF2gy0AGAGL7PAs8AxLYCSNIHCbxlVdqoD46QmdMHn4Wn7W6Xc6V
 AK9qL5k45Pr4fW60coQpZkbVQ8AHoZD6WE+mdwv3lRwL36VWbSOS/7hPW10x66D2uFiN
 qbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BSn+OXUyqlvsEb5g4HG7YJio2FrFxnG4RAzoSpJ37n4=;
 b=YlltzaK2Bz4EvsruesZqDerlUXvY92FtbSyqrnGpD2xhz+ANhItEYDhqXfpIfIEDLO
 VgoxV4vXsHmlsVoLF8Bx9p4CZemu0f8WNNneAldRvsPv+nVRPTmfAtb36J5xLqdfmHeW
 gyhqTmthGwKHhkkQDkuuCej+qMA8GHmEQlP7UHgDVfPhOG+DJ6XvZK2WxlCCDUx2+4Tm
 3+erWXKnuBt5IpymdFdiPfQAS5KYsctTv+RjJQW4BHDU/wmgvnOJbZrBNO7JbRgQ6+Xp
 6iJDFVXqGZKYknUWd/3Ba40UvzyCYsILkiPPqbNqGa591MsmBfUEBIJJwqWrY9LVvW6U
 FBOA==
X-Gm-Message-State: AOAM5324hZvVyikDrYGjc3pOghEGB1FbuwwzWP84rVBgVleNJ/WtPFwd
 i3S5yaYDt4XWDyLQQAYeYtJG5w==
X-Google-Smtp-Source: ABdhPJxZcgoA5uKFmKKTZVIW/QgalvI0vViRhWbaPgPhsBdeo0EbXOdxljHdeWjtUnGgsfAjxAHN5w==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr699617wmc.184.1605036700071; 
 Tue, 10 Nov 2020 11:31:40 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2020 11:31:39 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 19/30] drm/radeon/radeon_drv: Move 'radeon_mmap()'s prototype
 to shared header
Date: Tue, 10 Nov 2020 19:31:01 +0000
Message-Id: <20201110193112.988999-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 10 Nov 2020 19:35:44 +0000
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
 Gareth Hughes <gareth@valinux.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmM6OTMxOjU6IHdhcm5pbmc6IG5vIHByZXZpb3Vz
IHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX21tYXDigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQog
OTMxIHwgaW50IHJhZGVvbl9tbWFwKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKnZtYSkKIHwgXn5+fn5+fn5+fn4KCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBW
ZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IEdhcmV0aCBIdWdoZXMgPGdhcmV0aEB2YWxpbnV4
LmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxp
bmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmMgfCAyICst
CiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uaCB8IDEgKwogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFk
ZW9uX2Rydi5jCmluZGV4IDUzNmIyNDZiOWE2YWEuLjJiOWRlYWVhZDk5YjIgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2Rydi5jCkBAIC01MSw2ICs1MSw3IEBACiAjaW5jbHVkZSA8ZHJtL3Jh
ZGVvbl9kcm0uaD4KIAogI2luY2x1ZGUgInJhZGVvbl9kcnYuaCIKKyNpbmNsdWRlICJyYWRlb25f
dHRtLmgiCiAjaW5jbHVkZSAicmFkZW9uLmgiCiAjaW5jbHVkZSAicmFkZW9uX2RldmljZS5oIgog
CkBAIC0xMjUsNyArMTI2LDYgQEAgZXh0ZXJuIGludCByYWRlb25fZ2V0X2NydGNfc2Nhbm91dHBv
cyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgY3J0YywKIAkJCQkgICAgICBr
dGltZV90ICpzdGltZSwga3RpbWVfdCAqZXRpbWUsCiAJCQkJICAgICAgY29uc3Qgc3RydWN0IGRy
bV9kaXNwbGF5X21vZGUgKm1vZGUpOwogZXh0ZXJuIGJvb2wgcmFkZW9uX2lzX3B4KHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYpOwotaW50IHJhZGVvbl9tbWFwKHN0cnVjdCBmaWxlICpmaWxwLCBzdHJ1
Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSk7CiBpbnQgcmFkZW9uX21vZGVfZHVtYl9tbWFwKHN0cnVj
dCBkcm1fZmlsZSAqZmlscCwKIAkJCSAgc3RydWN0IGRybV9kZXZpY2UgKmRldiwKIAkJCSAgdWlu
dDMyX3QgaGFuZGxlLCB1aW50NjRfdCAqb2Zmc2V0X3ApOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmggYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl90dG0uaAppbmRleCA5MWVhNzE0MWJjODEyLi40ZDdiOTBlZTI3NzQwIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uaAorKysgYi9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL3JhZGVvbl90dG0uaApAQCAtMzIsNSArMzIsNiBAQCBzdHJ1Y3QgcmFkZW9uX2Rldmlj
ZTsKIAogaW50IHJhZGVvbl90dG1faW5pdChzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CiB2
b2lkIHJhZGVvbl90dG1fZmluaShzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldik7CitpbnQgcmFk
ZW9uX21tYXAoc3RydWN0IGZpbGUgKmZpbHAsIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKTsK
IAogI2VuZGlmCQkJCS8qIF9fUkFERU9OX1RUTV9IX18gKi8KLS0gCjIuMjUuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
