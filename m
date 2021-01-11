Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEEBC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F6722CAF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F6722CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7AC06E108;
	Mon, 11 Jan 2021 19:54:48 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53E5D89FEA
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:20:17 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id r3so960403wrt.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BIbmEvfzHXehTUhCMEmMZrSzDyf/FShSUv7k6W8xO0I=;
 b=zMzZ4xE5NKZ9zZzeixi0EshIlbVM+Oqc0rHAXlxuiA9B1gxQh79nQVjQEYiHwQn18H
 TcgstRKaBJCcs24Vnyg12yQBMOqOiXw+LDrjMF/1a1ovufxRBx4X0bVRwKrdtog/+Wej
 2vADHgeCtfaD2aqGnfDnm9yDyUyhN7YuBF2lFtel/9aXRCptMNSoSYHmkPtHUtlotPWJ
 gPchL821+gq/eH/44RW1MySEpowk94XjDdOQFpFL8fjtHXIscERdaIlPNpnMEXCHE4gc
 bIrv9WhxJF9movrz1mrhKWYmj74JkSx5LUGUR+oVb/CNTDkZX+xS3gwb+fcPeIqVfWvC
 JmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BIbmEvfzHXehTUhCMEmMZrSzDyf/FShSUv7k6W8xO0I=;
 b=DpIUECQStxJAt5bdUC5+qIU2PpYAcLWBp8g+PslHADgWWKm9yurUtH7uWKyTIbcVAF
 ebk7B9E5MQ1s4YHopngSnf9ZifDandIx4w/HEvfUgQgoqE6bAQ+jeiKyYcTkmwxl5QfZ
 9Uj+KI0zOuryvgUfYp8AikJk7TUBYt3YQlkktkpfAfihnTJzKKbpNMgTydJOz/Lsq+rb
 xZqcH58pOPOS6INV25ZDLV74yjdWv+CYCyUrXiAl33QM6fFw3iJA4MMKPROxUxFgfo34
 Xln7XVYofJbvLdNlZ6+00ARflLGhNbY6vn2tOBLO7vVf3qpKNZQZXPPN//o2XfRYCdQ3
 Y3SA==
X-Gm-Message-State: AOAM532q6Eu1JKmUM517h95qecOFkrxPNSGfbOpKovTSoeiRSdj7yjW1
 iNf/FCJF/5XvoKoQ0qIjZ0Rwdg==
X-Google-Smtp-Source: ABdhPJwPslRBTQryX8hbTrdbI2rKljD9/OIme1u+tGVt0jX+nOO8mXoWjIqC+0cfZdcnshAkR/UwpA==
X-Received: by 2002:adf:8185:: with SMTP id 5mr615286wra.44.1610392816068;
 Mon, 11 Jan 2021 11:20:16 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:20:15 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 35/40] drm/amd/display/dc/dce60/dce60_timing_generator: Make
 'dce60_configure_crc' invoked by reference static
Date: Mon, 11 Jan 2021 19:19:21 +0000
Message-Id: <20210111191926.3688443-36-lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2U2MC9kY2U2MF90aW1pbmdfZ2Vu
ZXJhdG9yLmM6MTkyOjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYZGNl
NjBfY29uZmlndXJlX2NyY+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCgpDYzogSGFycnkgV2Vu
dGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1k
LmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJD
aHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
PgpDYzogTWF1cm8gUm9zc2kgPGlzc29yLm9ydWFtQGdtYWlsLmNvbT4KQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTYwL2RjZTYwX3RpbWluZ19nZW5lcmF0b3IuYyB8
IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlNjAvZGNlNjBf
dGltaW5nX2dlbmVyYXRvci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTYw
L2RjZTYwX3RpbWluZ19nZW5lcmF0b3IuYwppbmRleCBmYzFhZjBmZjBjYTRjLi5jMWE4NWVlMzc0
ZDlkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlNjAvZGNl
NjBfdGltaW5nX2dlbmVyYXRvci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2U2MC9kY2U2MF90aW1pbmdfZ2VuZXJhdG9yLmMKQEAgLTE4OSw4ICsxODksOCBAQCBzdGF0
aWMgYm9vbCBkY2U2MF9pc190Z19lbmFibGVkKHN0cnVjdCB0aW1pbmdfZ2VuZXJhdG9yICp0ZykK
IAlyZXR1cm4gZmllbGQgPT0gMTsKIH0KIAotYm9vbCBkY2U2MF9jb25maWd1cmVfY3JjKHN0cnVj
dCB0aW1pbmdfZ2VuZXJhdG9yICp0ZywKLQkJCSAgY29uc3Qgc3RydWN0IGNyY19wYXJhbXMgKnBh
cmFtcykKK3N0YXRpYyBib29sIGRjZTYwX2NvbmZpZ3VyZV9jcmMoc3RydWN0IHRpbWluZ19nZW5l
cmF0b3IgKnRnLAorCQkJCWNvbnN0IHN0cnVjdCBjcmNfcGFyYW1zICpwYXJhbXMpCiB7CiAJLyog
Q2Fubm90IGNvbmZpZ3VyZSBjcmMgb24gYSBDUlRDIHRoYXQgaXMgZGlzYWJsZWQgKi8KIAlpZiAo
IWRjZTYwX2lzX3RnX2VuYWJsZWQodGcpKQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
