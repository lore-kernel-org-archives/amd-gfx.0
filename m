Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6FDC64E7A
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10B70206C0
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rz+Vn8n1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10B70206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E53F6EB97;
	Fri, 27 Nov 2020 10:14:34 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1AA96E993
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:40 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t4so2169540wrr.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wTlQph4T9x2clQDWFRQKUxH5e24azy8BuVSYzp5lBkU=;
 b=Rz+Vn8n1GJmQ/rxsl/asCB4OMfEleQg7MQ7bd6+UCqkmm74BIESn/bQbICzXd8MhjA
 QuNQ4O4dVDJ6LSLLa5dkqVQvWlr9KRQbjeT2N3rOGGVAxe1qZjzmiu/Ix+dTg0/srPE0
 kzde8m10jLEIPnZeUuIQv4H+GX0bSwc3iQGh8KHXvAP6sOp+abDZeHDY+eOa7Fqy1vJd
 WvIxy4ElqE4NzC45RHvb+UftFhN8PtHHYGLc5UKM76FNhLdb7CRbZbUQuq4IoMxMmS5R
 Jda+Kc6IQMS3qx3X0gNu4CDnxZlLrVVplJsduhtZzyo6uI1PfQ6E23pRQdT9Rg4WMhO3
 5xLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wTlQph4T9x2clQDWFRQKUxH5e24azy8BuVSYzp5lBkU=;
 b=t7biNiSIdo5Qmh6JD9G+DeqvJk+OdxN2jpJoQE3es/1k4o7ixr4IWwXB9pMhx70lRB
 4bAMd/582dizj3nVVTfoLazL7R2Ca5OiSHdSdG5kRw8EWaiwTNLqDtHEyPlQvezIAvZ0
 +mWxPELO1zNOyh57ujV01MYsDK+mN9rXwI00mIyfoQtpJjCPT5ImU5GoLVl23LynzTNS
 PgQF2PeHcNn1K1MINU6EB0XKIsv8/wdliPaO/jE2Zb6WpYQkW06eV6/yrfraY3kKmArd
 RbHpKGURVXrFmlwPc3SXRNlWC6sB/zVA1Alugph7WAN0DE5hvJzgfcQblgdwHyeV1OR1
 K1qA==
X-Gm-Message-State: AOAM5335+VpIv96mqwmF9uTzM4FvKJzreQj14EkZQe3O2R25uZaCl0a3
 Xj3mSbw2Q++vLWh6bj47MYwbag==
X-Google-Smtp-Source: ABdhPJyjFZb/CZGkNbJquN6qeOeEmF3gQUTLtH3m5Nlq0vmYqCf2gV6hQrse5Mhswj35yLTHU2zP6w==
X-Received: by 2002:a5d:6186:: with SMTP id j6mr4005475wru.359.1606398219495; 
 Thu, 26 Nov 2020 05:43:39 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:38 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 37/40] drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu: Remove
 unused function 'pp_nv_set_pme_wa_enable()'
Date: Thu, 26 Nov 2020 13:42:37 +0000
Message-Id: <20201126134240.3214176-38-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX3BwX3Nt
dS5jOjY2NDoyMDogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhwcF9udl9z
ZXRfcG1lX3dhX2VuYWJsZeKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCgpDYzogSGFycnkgV2Vu
dGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1k
LmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
PgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJv
Lm9yZz4KLS0tCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG1fcHBfc211
LmMgfCAxNiAtLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTYgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG1fcHBfc211LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2Ft
ZGdwdV9kbV9wcF9zbXUuYwppbmRleCBhYzBhMDUzOTg1NGVmLi42MDdlYzA5OTk0NDU2IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbV9w
cF9zbXUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbV9wcF9zbXUuYwpAQCAtNjYxLDIyICs2NjEsNiBAQCBzdGF0aWMgZW51bSBwcF9zbXVfc3Rh
dHVzIHBwX252X3NldF93bV9yYW5nZXMoc3RydWN0IHBwX3NtdSAqcHAsCiAJcmV0dXJuIFBQX1NN
VV9SRVNVTFRfT0s7CiB9CiAKLXN0YXRpYyBlbnVtIHBwX3NtdV9zdGF0dXMgcHBfbnZfc2V0X3Bt
ZV93YV9lbmFibGUoc3RydWN0IHBwX3NtdSAqcHApCi17Ci0JY29uc3Qgc3RydWN0IGRjX2NvbnRl
eHQgKmN0eCA9IHBwLT5kbTsKLQlzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IGN0eC0+ZHJp
dmVyX2NvbnRleHQ7Ci0Jc3RydWN0IHNtdV9jb250ZXh0ICpzbXUgPSAmYWRldi0+c211OwotCi0J
aWYgKCFzbXUtPnBwdF9mdW5jcykKLQkJcmV0dXJuIFBQX1NNVV9SRVNVTFRfVU5TVVBQT1JURUQ7
Ci0KLQkvKiAwOiBzdWNjZXNzZnVsIG9yIHNtdS5wcHRfZnVuY3MtPnNldF9hemFsaWFfZDNfcG1l
ID0gTlVMTDsgIDE6IGZhaWwgKi8KLQlpZiAoc211X3NldF9hemFsaWFfZDNfcG1lKHNtdSkpCi0J
CXJldHVybiBQUF9TTVVfUkVTVUxUX0ZBSUw7Ci0KLQlyZXR1cm4gUFBfU01VX1JFU1VMVF9PSzsK
LX0KLQogc3RhdGljIGVudW0gcHBfc211X3N0YXR1cyBwcF9udl9zZXRfZGlzcGxheV9jb3VudChz
dHJ1Y3QgcHBfc211ICpwcCwgaW50IGNvdW50KQogewogCWNvbnN0IHN0cnVjdCBkY19jb250ZXh0
ICpjdHggPSBwcC0+ZG07Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
