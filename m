Return-Path: <SRS0=VJnr=GY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21210C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 15:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0CD23A1C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jan 2021 15:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0CD23A1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B2D6E900;
	Thu, 21 Jan 2021 15:30:11 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E06156E8FB
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 15:30:08 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id a1so2150081wrq.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jan 2021 07:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cO1IkKPUOVwRn1crpsdxPu7FkoF7p+ucW3GbJhM3e14=;
 b=jhC25ghF/XaqC35+yLTxVb7Wu3JLRJXw2J2hDlMlBegM1HgvqArOVwueF+WlNe1LK0
 iAxoO75LoZrCTVQkpHH8oySG5WCiFgXObeuTlNMlP86RWNc969Ycv/BYdMOvA8ZurmTu
 IPauh1ssYJZERfONi1YMonwWMecl3j/Y7Jjz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cO1IkKPUOVwRn1crpsdxPu7FkoF7p+ucW3GbJhM3e14=;
 b=pdvm9hYU+Ww2UURGriBZNXDZHkKsFzL3vVtWNsBGuYvJlIzrgfDoqqlZ80afrgWBEk
 /b62a8ys1PzwNqwCKd5EBM8G/1B26oLzFcZTiqKwwMcX41JmlO3ExNsrmMuDfPjv2qMk
 o55/u3tAXUgYg9XBLH36PWJydTsckb6kZDRP658MUZBHqpS5wC6BcQfx+6EJerv0jawg
 /C0WW5EKPXb4f9t/N6M9U0bkOSTVLYVCp4hBH32ADjsbrJyGA33o2oSmQkPAeYRvviGk
 7mVZgRaY0wBtVmNzBgbAA3Tslx4Xv1ASeWFbY6t/HwQlL11If1HhMiGN9Li4XUDXFJlT
 uqrQ==
X-Gm-Message-State: AOAM531Yxc4cwGi343KdeZAxTmK4iizXrLa395+CZZWQFtekC/KtkKQu
 vkXQCekPvwZMOVPAFXg+6a58WA==
X-Google-Smtp-Source: ABdhPJzW179r+95gTC9AApAezahGncz7nZxmZZU6SylexVR2TnthZyEScn1yu5DpB9svGDcS52Nyxg==
X-Received: by 2002:a5d:49c1:: with SMTP id t1mr33276wrs.56.1611243007580;
 Thu, 21 Jan 2021 07:30:07 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f14sm8269866wre.69.2021.01.21.07.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 07:30:06 -0800 (PST)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 02/11] drm/vkms: Annotate vblank timer
Date: Thu, 21 Jan 2021 16:29:50 +0100
Message-Id: <20210121152959.1725404-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121152959.1725404-1-daniel.vetter@ffwll.ch>
References: <20210121152959.1725404-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
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
Cc: linaro-mm-sig@lists.linaro.org,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, linux-rdma@vger.kernel.org,
 Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, Chris Wilson <chris@chris-wilson.co.uk>,
 Melissa Wen <melissa.srw@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Daniel Vetter <daniel.vetter@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyBpcyBuZWVkZWQgdG8gc2lnbmFsIHRoZSBmZW5jZXMgZnJvbSBwYWdlIGZsaXBzLCBhbm5v
dGF0ZSBpdAphY2NvcmRpbmdseS4gV2UgbmVlZCB0byBhbm5vdGF0ZSBlbnRpcmUgdGltZXIgY2Fs
bGJhY2sgc2luY2UgaWYgd2UgZ2V0CnN0dWNrIGFueXdoZXJlIGluIHRoZXJlLCB0aGVuIHRoZSB0
aW1lciBzdG9wcywgYW5kIGhlbmNlIGZlbmNlcyBzdG9wLgpKdXN0IGFubm90YXRpbmcgdGhlIHRv
cCBwYXJ0IHRoYXQgZG9lcyB0aGUgdmJsYW5rIGhhbmRsaW5nIGlzbid0CmVub3VnaC4KClRlc3Rl
ZC1ieTogTWVsaXNzYSBXZW4gPG1lbGlzc2Euc3J3QGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFJv
ZHJpZ28gU2lxdWVpcmEgPHJvZHJpZ29zaXF1ZWlyYW1lbG9AZ21haWwuY29tPgpDYzogbGludXgt
bWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxpbmFyby5vcmcK
Q2M6IGxpbnV4LXJkbWFAdmdlci5rZXJuZWwub3JnCkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogaW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogQ2hyaXMgV2ls
c29uIDxjaHJpc0BjaHJpcy13aWxzb24uY28udWs+CkNjOiBNYWFydGVuIExhbmtob3JzdCA8bWFh
cnRlbi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPgpDYzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgVmV0dGVyIDxkYW5p
ZWwudmV0dGVyQGludGVsLmNvbT4KQ2M6IFJvZHJpZ28gU2lxdWVpcmEgPHJvZHJpZ29zaXF1ZWly
YW1lbG9AZ21haWwuY29tPgpDYzogSGFuZWVuIE1vaGFtbWVkIDxoYW1vaGFtbWVkLnNhQGdtYWls
LmNvbT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vdmttcy92a21zX2NydGMuYyB8IDggKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
dmttcy92a21zX2NydGMuYyBiL2RyaXZlcnMvZ3B1L2RybS92a21zL3ZrbXNfY3J0Yy5jCmluZGV4
IDA0NDNiN2RlZWFlZi4uNjE2NDM0OWNkZjExIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
dmttcy92a21zX2NydGMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdmttcy92a21zX2NydGMuYwpA
QCAtMSw1ICsxLDcgQEAKIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKwogCisj
aW5jbHVkZSA8bGludXgvZG1hLWZlbmNlLmg+CisKICNpbmNsdWRlIDxkcm0vZHJtX2F0b21pYy5o
PgogI2luY2x1ZGUgPGRybS9kcm1fYXRvbWljX2hlbHBlci5oPgogI2luY2x1ZGUgPGRybS9kcm1f
cHJvYmVfaGVscGVyLmg+CkBAIC0xNCw3ICsxNiw5IEBAIHN0YXRpYyBlbnVtIGhydGltZXJfcmVz
dGFydCB2a21zX3ZibGFua19zaW11bGF0ZShzdHJ1Y3QgaHJ0aW1lciAqdGltZXIpCiAJc3RydWN0
IGRybV9jcnRjICpjcnRjID0gJm91dHB1dC0+Y3J0YzsKIAlzdHJ1Y3Qgdmttc19jcnRjX3N0YXRl
ICpzdGF0ZTsKIAl1NjQgcmV0X292ZXJydW47Ci0JYm9vbCByZXQ7CisJYm9vbCByZXQsIGZlbmNl
X2Nvb2tpZTsKKworCWZlbmNlX2Nvb2tpZSA9IGRtYV9mZW5jZV9iZWdpbl9zaWduYWxsaW5nKCk7
CiAKIAlyZXRfb3ZlcnJ1biA9IGhydGltZXJfZm9yd2FyZF9ub3coJm91dHB1dC0+dmJsYW5rX2hy
dGltZXIsCiAJCQkJCSAgb3V0cHV0LT5wZXJpb2RfbnMpOwpAQCAtNDksNiArNTMsOCBAQCBzdGF0
aWMgZW51bSBocnRpbWVyX3Jlc3RhcnQgdmttc192Ymxhbmtfc2ltdWxhdGUoc3RydWN0IGhydGlt
ZXIgKnRpbWVyKQogCQkJRFJNX0RFQlVHX0RSSVZFUigiQ29tcG9zZXIgd29ya2VyIGFscmVhZHkg
cXVldWVkXG4iKTsKIAl9CiAKKwlkbWFfZmVuY2VfZW5kX3NpZ25hbGxpbmcoZmVuY2VfY29va2ll
KTsKKwogCXJldHVybiBIUlRJTUVSX1JFU1RBUlQ7CiB9CiAKLS0gCjIuMzAuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
