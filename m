Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EE8C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70CDE61163
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70CDE61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598EA6F451;
	Thu, 20 May 2021 12:49:11 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B8C66F418
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:41 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id b7so8430186wmh.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jO7V0H98Qg2tMCIwDj4FeeKzGM5dSknTEV1LYii8u8w=;
 b=W4x0Pew/IdeVOzVWOMkZldd12omXYquCVkPlxohuHIUCvZ/BWTepLzjBlhhiblpmG0
 gUJwuwhnYvyv3Q3h88pNwzZmHXBXelFCn6KJjQLnX6ztOSiKbeLA8UQ59wDQB2zY9GaL
 QLs6gEfartIy6XZI2vtzV58nNt4DztnsXEvnC40J/30hlNC2OMHkkZA3dq9TFiT/N9Mf
 dd0Bp1pJrdlAv+FGpU8Ls1aO0UGpHh4ZR66obyMP/QvI82ONSDznjEddDWl0rdVuXqLV
 C58IkWCeCV0wiruzMSD8MyGAIL0W379+i/+Dm5F23398Yl+LZOo+S2CYDUorHkHYMCty
 sF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jO7V0H98Qg2tMCIwDj4FeeKzGM5dSknTEV1LYii8u8w=;
 b=TYcIagnWrukKMVf6QTRI0Yj0u9I8dHtZoGe3zzb1NAhoLtphNgpOqx4RhL/5Wq3oPG
 eULYvokU1qtzNj7nW7okoptrNKv8xot7xEx6Watq4srtBxlb2qFzrqY6nrhty/R0NGLw
 bj4UzEM/Oz1tyKnpy1p9CyuIaeoUC1FaScfcwOn0SHZqWYAzaXvu/OVaPEATes2WAxcC
 LTgtUNPnwO/Lo3qMU49o/tgPRrNgcKrBx/K2SA2Wq8yPKObxe7AB7aLb92LhXzRSvgaV
 EsgmeQ3aW9eDc6EtPTYr3QPH1ks2oO38Dr2N7Beu62C6inIwIc0TsrT8b93zqwQ175qj
 FORg==
X-Gm-Message-State: AOAM531l8gBBuUUZ6aXpjG7bib27I5dMfjT7nEcdp1SXfAAsZaKpzGjo
 H9tUrPRBTZ1UfZHGfzxTJow2ig==
X-Google-Smtp-Source: ABdhPJyV3+TJPHVMnYSdJETlXphndM0hvCrXSlYbuhpUFkSBWFHcg1oC7Whm3urACs0DpxdCMukdUQ==
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr3238405wmb.141.1621512220189; 
 Thu, 20 May 2021 05:03:40 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:39 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 37/38] drm/amd/amdgpu/gfx_v10_0: Demote kernel-doc abuse
Date: Thu, 20 May 2021 13:02:47 +0100
Message-Id: <20210520120248.3464013-38-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmM6NTE6IHdhcm5pbmc6IFRoaXMgY29tbWVu
dCBzdGFydHMgd2l0aCAnLyoqJywgYnV0IGlzbid0IGEga2VybmVsLWRvYyBjb21tZW50LiBSZWZl
ciBEb2N1bWVudGF0aW9uL2RvYy1ndWlkZS9rZXJuZWwtZG9jLnJzdAoKQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4Lmll
PgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxz
dW1pdC5zZW13YWxAbGluYXJvLm9yZz4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
CkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBsaW51eC1tZWRpYUB2Z2Vy
Lmtlcm5lbC5vcmcKQ2M6IGxpbmFyby1tbS1zaWdAbGlzdHMubGluYXJvLm9yZwpTaWduZWQtb2Zm
LWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAu
YwppbmRleCBmYzEyZTNjM2U5Y2FlLi5jODMzYmUzMWU0YWU2IDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nZnhfdjEwXzAuYwpAQCAtNDcsNyArNDcsNyBAQAogI2luY2x1ZGUgImdmeF92MTBf
MC5oIgogI2luY2x1ZGUgIm5iaW9fdjJfMy5oIgogCi0vKioKKy8qCiAgKiBOYXZpMTAgaGFzIHR3
byBncmFwaGljIHJpbmdzIHRvIHNoYXJlIGVhY2ggZ3JhcGhpYyBwaXBlLgogICogMS4gUHJpbWFy
eSByaW5nCiAgKiAyLiBBc3luYyByaW5nCi0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
