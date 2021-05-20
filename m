Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B3C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B790D61163
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B790D61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82D16E12A;
	Thu, 20 May 2021 12:49:10 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2656F414
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:03 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id d11so17358683wrw.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fcdvP1BzIl3x+PleFuz79GqrL71ya8Oj0cjWTPEe9qs=;
 b=S64+RsMhtnMW++KWmgbEqE74s+1Eun93Cetk185djJxdf9FR/w3NO0qeRSBTZAUFYU
 FB6nzj6Sxtn5klIAr4ywcIjV7hv3BgISoh2zt+tMge1UCEgmN1vWhrZoNVQeEy45T/Ql
 +0K2ZcIGbt24yqiLKYYl/cHvWnxeUjIKKWK5rvgnebNYyxCZ3Yy818gN69SCWXS7YJuO
 f+zvHzX9xgejdrJxFd8Fhs/Ct4LMGjtnM/i0KYu+XTmU+Uc09GxP0K+z5Ls8wHScKk3V
 7Jau3cb2J+9G22D/R9+h2iplsHPh+OlUNFAPPRAcC0rEi+tnIbZdVbSbjIr+xSmlbwTs
 SdHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fcdvP1BzIl3x+PleFuz79GqrL71ya8Oj0cjWTPEe9qs=;
 b=YIpDRCjJr0vOoDSq2NoL+JS+wFuBBji01sDu0qrqIJApNr+dg4x3FyUbSmkDjyVAld
 9yz4fZfyfLLl9dOyU33xE61BqW2qIe20OVVa1pRrJgbs0cQiCt8QcRsSrgUQTyWiqHHF
 dj6ZW7GWX6lNgRgMfF8VcU15DighDamb21Oho60jaXbiA0NyzrHv5rbdM5+b55YKXWNk
 CknOEIXBtuCsJN8rLlOAHl8dEgGPq5fWFhM8aFRl7WCdk48UF+sbG+ZI3tdn7lzyzSSF
 Doa4DgFKbsKq3ZQL5kmVwtns2/bMRNVllr7md56DUT5R7aVgE+eLJX3ZKWX1jDMtkFm2
 rM3Q==
X-Gm-Message-State: AOAM533ipyptox8SFMp2WZrGKRRPdYjAXyn2DUHQxwnAt20reZq6cmMw
 qG0csQv5wq7+zIrK4uZU7HX/LA==
X-Google-Smtp-Source: ABdhPJznQ+PN/ydUmSuB50IaUzPB6eOj2r2H+nAw3Wmuu+wHu51V6mwHuNY30Mxg+Z5y6k3sluHD0g==
X-Received: by 2002:a05:6000:1001:: with SMTP id
 a1mr3828637wrx.59.1621512182229; 
 Thu, 20 May 2021 05:03:02 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:01 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 10/38] drm/amd/amdgpu/amdgpu_ids: Correct some function name
 disparity
Date: Thu, 20 May 2021 13:02:20 +0100
Message-Id: <20210520120248.3464013-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120248.3464013-1-lee.jones@linaro.org>
References: <20210520120248.3464013-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 20 May 2021 12:49:10 +0000
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
 amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lkcy5jOjIwMDogd2FybmluZzogZXhwZWN0aW5n
IHByb3RvdHlwZSBmb3IgYW1kZ3B1X3ZtX2dyYWJfaWRsZSgpLiBQcm90b3R5cGUgd2FzIGZvciBh
bWRncHVfdm1pZF9ncmFiX2lkbGUoKSBpbnN0ZWFkCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfaWRzLmM6MjcyOiB3YXJuaW5nOiBleHBlY3RpbmcgcHJvdG90eXBlIGZvciBhbWRn
cHVfdm1fZ3JhYl9yZXNlcnZlZCgpLiBQcm90b3R5cGUgd2FzIGZvciBhbWRncHVfdm1pZF9ncmFi
X3Jlc2VydmVkKCkgaW5zdGVhZAogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lk
cy5jOjMzNzogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgYW1kZ3B1X3ZtX2dyYWJf
dXNlZCgpLiBQcm90b3R5cGUgd2FzIGZvciBhbWRncHVfdm1pZF9ncmFiX3VzZWQoKSBpbnN0ZWFk
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfaWRzLmM6NDEwOiB3YXJuaW5nOiBl
eHBlY3RpbmcgcHJvdG90eXBlIGZvciBhbWRncHVfdm1fZ3JhYl9pZCgpLiBQcm90b3R5cGUgd2Fz
IGZvciBhbWRncHVfdm1pZF9ncmFiKCkgaW5zdGVhZAoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFu
ZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFu
aWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13
YWxAbGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5v
cmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUg
Sm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9pZHMuYyB8IDggKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2lkcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2lk
cy5jCmluZGV4IGI0OTcxZTkwYjk4Y2YuLmM3ZjNhYWUyM2M2MjUgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9pZHMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfaWRzLmMKQEAgLTE4Myw3ICsxODMsNyBAQCBib29sIGFtZGdwdV92
bWlkX2hhZF9ncHVfcmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiB9CiAKIC8qKgot
ICogYW1kZ3B1X3ZtX2dyYWJfaWRsZSAtIGdyYWIgaWRsZSBWTUlECisgKiBhbWRncHVfdm1pZF9n
cmFiX2lkbGUgLSBncmFiIGlkbGUgVk1JRAogICoKICAqIEB2bTogdm0gdG8gYWxsb2NhdGUgaWQg
Zm9yCiAgKiBAcmluZzogcmluZyB3ZSB3YW50IHRvIHN1Ym1pdCBqb2IgdG8KQEAgLTI1Niw3ICsy
NTYsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV92bWlkX2dyYWJfaWRsZShzdHJ1Y3QgYW1kZ3B1X3Zt
ICp2bSwKIH0KIAogLyoqCi0gKiBhbWRncHVfdm1fZ3JhYl9yZXNlcnZlZCAtIHRyeSB0byBhc3Np
Z24gcmVzZXJ2ZWQgVk1JRAorICogYW1kZ3B1X3ZtaWRfZ3JhYl9yZXNlcnZlZCAtIHRyeSB0byBh
c3NpZ24gcmVzZXJ2ZWQgVk1JRAogICoKICAqIEB2bTogdm0gdG8gYWxsb2NhdGUgaWQgZm9yCiAg
KiBAcmluZzogcmluZyB3ZSB3YW50IHRvIHN1Ym1pdCBqb2IgdG8KQEAgLTMyNSw3ICszMjUsNyBA
QCBzdGF0aWMgaW50IGFtZGdwdV92bWlkX2dyYWJfcmVzZXJ2ZWQoc3RydWN0IGFtZGdwdV92bSAq
dm0sCiB9CiAKIC8qKgotICogYW1kZ3B1X3ZtX2dyYWJfdXNlZCAtIHRyeSB0byByZXVzZSBhIFZN
SUQKKyAqIGFtZGdwdV92bWlkX2dyYWJfdXNlZCAtIHRyeSB0byByZXVzZSBhIFZNSUQKICAqCiAg
KiBAdm06IHZtIHRvIGFsbG9jYXRlIGlkIGZvcgogICogQHJpbmc6IHJpbmcgd2Ugd2FudCB0byBz
dWJtaXQgam9iIHRvCkBAIC0zOTcsNyArMzk3LDcgQEAgc3RhdGljIGludCBhbWRncHVfdm1pZF9n
cmFiX3VzZWQoc3RydWN0IGFtZGdwdV92bSAqdm0sCiB9CiAKIC8qKgotICogYW1kZ3B1X3ZtX2dy
YWJfaWQgLSBhbGxvY2F0ZSB0aGUgbmV4dCBmcmVlIFZNSUQKKyAqIGFtZGdwdV92bWlkX2dyYWIg
LSBhbGxvY2F0ZSB0aGUgbmV4dCBmcmVlIFZNSUQKICAqCiAgKiBAdm06IHZtIHRvIGFsbG9jYXRl
IGlkIGZvcgogICogQHJpbmc6IHJpbmcgd2Ugd2FudCB0byBzdWJtaXQgam9iIHRvCi0tIAoyLjMx
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
