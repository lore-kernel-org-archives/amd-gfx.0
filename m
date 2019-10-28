Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB370CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9272B217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9272B217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6377A6EA9D;
	Mon, 28 Oct 2019 21:43:07 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF946EA9D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:06 +0000 (UTC)
Received: by mail-yb1-xb44.google.com with SMTP id z125so4644536ybc.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oO2VfC8qhxADPkDyDVx31uSOTMR49nkzK5iaws33oXY=;
 b=lG1nnvBoz68wjiUMoucFwOUhCPPC8MkbvOvYep9DKvkVLQ/UDutwsWmJRfadVjMShO
 IKsp6/sIwwQRcv4MAaTYoMvrc28NvR8cWMc8bNEYNqXtTq0xQ7FZsz3az2ci1qm4NB3s
 F/nVNRg0wdWwyr091DyCnHpMey2jzQ+0bmhOESvyJrFwwivDZxp6gSwejDzgjBAkWtQF
 I0xZIZuBe7ZmNmIrZ5YJaxvG7lm55kR69g/63aqLPUaXwzWsyQatK2Vn+4i9rTVF/E4C
 scS3t8sFT79yx9xapjSHLZdkMrM2mwWa0GwT3ZhAt1nqTWamQAdVipsC+FvswJV1DH3v
 wLxA==
X-Gm-Message-State: APjAAAV7Uu5dkkfdMQls/fzamfCNEe4R8Yt9AZcPAVLtv74wQ41IaUwf
 VYHCNDabCyySOJNCTb+swrA/TCxu1KE=
X-Google-Smtp-Source: APXvYqxuZYB6YLp24fLhrslA2nUyFzZaJ9f+WGfEm3FNdTDcnG15ALi6t9c/r09asY7Bh53BWI0Ixg==
X-Received: by 2002:a25:bc04:: with SMTP id i4mr15313193ybh.427.1572298985060; 
 Mon, 28 Oct 2019 14:43:05 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:04 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 04/21] drm/amdgpu: add supports_baco callback for SI asics.
Date: Mon, 28 Oct 2019 17:41:59 -0400
Message-Id: <20191028214216.1508370-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oO2VfC8qhxADPkDyDVx31uSOTMR49nkzK5iaws33oXY=;
 b=GqSRfikcwsoUbWIBFY3nlHQgUas/rRXXLqxAQjmJNt4f0CVRfoYx/N2gnibVSO4NUw
 D4nktghmwXxEKi3U7oTJmBfqCpNpQjMK4OvtumWqc8praPWwMbZMk/aTbDBNOlfE9W7G
 NVbp9KvO8aqRK5OpBOtDRAtUlcOeVXs/jMQUwBmcPqo4YCApGahENbHn6YC9h173sxzr
 G2wdB++CJ8ycStxZNsy8EnOnSVUB4NMtHuo873w27RBjPNpAA0v47kIk22fJNNF7uF82
 uCtn+Bm+1bWYhPgbef1QbPlclbzBBnQT97UBfH0R+Hlacc8caz8riSxIXcad/Rg6PMEK
 9TvA==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028214159.sTkYFz7ufD0OPYpcr26vdIfcGZnbXOh8sNJm162vZhA@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpOb3Qgc3VwcG9ydGVkLgoKUmV2aWV3ZWQtYnk6
IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zaS5jIHwgNiArKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvc2kuYwppbmRleCAyOTAyNGU2NGM4ODYuLmNiNjgyZDQ0NzM3YSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9zaS5jCkBAIC0xMTk3LDYgKzExOTcsMTEgQEAgc3RhdGljIGludCBz
aV9hc2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCXJldHVybiAwOwogfQog
CitzdGF0aWMgYm9vbCBzaV9hc2ljX3N1cHBvcnRzX2JhY28oc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCit7CisJcmV0dXJuIGZhbHNlOworfQorCiBzdGF0aWMgZW51bSBhbWRfcmVzZXRfbWV0
aG9kCiBzaV9hc2ljX3Jlc2V0X21ldGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsK
QEAgLTE0MjUsNiArMTQzMCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2FzaWNfZnVu
Y3Mgc2lfYXNpY19mdW5jcyA9CiAJLmdldF9wY2llX3VzYWdlID0gJnNpX2dldF9wY2llX3VzYWdl
LAogCS5uZWVkX3Jlc2V0X29uX2luaXQgPSAmc2lfbmVlZF9yZXNldF9vbl9pbml0LAogCS5nZXRf
cGNpZV9yZXBsYXlfY291bnQgPSAmc2lfZ2V0X3BjaWVfcmVwbGF5X2NvdW50LAorCS5zdXBwb3J0
c19iYWNvID0gJnNpX2FzaWNfc3VwcG9ydHNfYmFjbywKIH07CiAKIHN0YXRpYyB1aW50MzJfdCBz
aV9nZXRfcmV2X2lkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQotLSAKMi4yMy4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
