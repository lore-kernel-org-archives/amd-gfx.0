Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999DEC6379D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CC862225B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V+ElGLhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC862225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626156EA18;
	Mon, 16 Nov 2020 19:18:18 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4116E071
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:37:23 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 10so29049wml.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BSn+OXUyqlvsEb5g4HG7YJio2FrFxnG4RAzoSpJ37n4=;
 b=V+ElGLhIkl31Mb6P/M3XGUqM6iyTGUDvmxvcJhvSe07Njk+hFpmjbacneoTsjLTfSA
 sFaHyOduil4Gvo0/pfIxP9JJGg9xIs4lJ6PC/K/1BjS5gzfuKAtS4dA3U/06gExWEepW
 z34W2YW39i60AK8MaVWa5tWhHqmxnSpDAcSwTB7TvxuMDO1A6bNFQdF9k66dM1xEHqv7
 +U3CyMQ83XgpjYOueCkvHHKJV8TuCuYa8gCaCPC1qX1Ro21fGH6DH24sQ4vz9p4c35qp
 vypuRQj7FtZdT32r2KCrzyTF4ZPSx0btFEs2MYm25/t3tW94aqCkVKeabvJsqDXn9AJW
 ULeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BSn+OXUyqlvsEb5g4HG7YJio2FrFxnG4RAzoSpJ37n4=;
 b=VmAA+hrWm4h90LZV6LZ2LZ9FUIg5poxpg2g30OowyrHI9d4C6vzcEUyHcbtacnq4jq
 iOt1VHqA6y/N8dpCW6M7Cu2zyxBrU2xdMqltVAJh5rNfQbC+2zelD3v4TCvZncq0mEbu
 vybTsG6LhQ1b2VqLMX0vnix983VPYmq+vH2Kx2Ght4Zl7rcBtFMNRofybVTWs3ciO4Wg
 zpmcMLNhTpLDIbGgnka0Qn3fssljCIvAieArqwGafRj2uL2fEOvzsEZCvF+mLScp30gc
 Udb6psYt7ygJvzkiJL8FoMkTtLnjzC8ORnaG0ePf10RxQdvR6HRoNRDzG2i6hyVxo621
 z1xQ==
X-Gm-Message-State: AOAM532DuWRhn/6Q/D7Da61Ghf4Rep5HjZ3atoLtvEdu+WApTyJ195vB
 wyYSSB2QQ2RafEv8eBakBocvvw==
X-Google-Smtp-Source: ABdhPJxXTILeArQ2qdcPdd40XEL/rxA2gV1qsUMQkoZC+iy0q2saiuvG4VqLjI16yVxZ/cTxA9BrFw==
X-Received: by 2002:a1c:2b05:: with SMTP id r5mr16513667wmr.179.1605548242110; 
 Mon, 16 Nov 2020 09:37:22 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:37:21 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 13/43] drm/radeon/radeon_drv: Move 'radeon_mmap()'s prototype
 to shared header
Date: Mon, 16 Nov 2020 17:36:30 +0000
Message-Id: <20201116173700.1830487-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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
