Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C31C2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB20E20702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgHaHacy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB20E20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E476389F4F;
	Mon, 23 Nov 2020 13:58:15 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D5289139
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:19:27 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a65so16870970wme.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NbI9YC4DXS8pP98pclydp8H5GArZ+B3FbUQc6S4IogU=;
 b=TgHaHacyuHyhuNT4t9k91sNsSIpxd1Xx/c4tP8EIQStq0UwNaFNTtzx1inmxtzd/z+
 hTIUk4QzPFZlQbN3JeRLYKzRVM5heFaIzctXY2wjwiJa75NUFDBbhz1kBpe+fkigDbqR
 +IYvmWC8XLoidiZJ9y0u7Id3jLiYI3c4OEm2Cp4JCnG46l7ptAU2mg4M2/q/bMY5Gweq
 N4vdC9Ke3ayBde0o6e+AOkdfsN28DA8WZnDsx+d5TpMNMR9uD8muxAiqbRl3vGK1KbMR
 dVqYtPckmZad/rzSqNT2T5r0Y7dp18r2rxnD6Lv+/8dR0Xg/iiHkNHoCoACfq47nfwwv
 giyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NbI9YC4DXS8pP98pclydp8H5GArZ+B3FbUQc6S4IogU=;
 b=h3lndOc+uESPVoG9joVW3rxPkVhNJfZOsewRZiC03UypBBjXjCKc2l/lUJa9UaeDLj
 S0mt+TErJIVSd+2Ud28n3fMqqHgIYEE5QfewkgT55Xt7Q9oNRs6LVrAAJ9HFGBsNgSiV
 gqXJzMNwB4EQoyEGmbFSN8+EtXOtph1xkkT2ZiMXOHwDGuf5Eak0U/epsK1vRVMnKDbE
 CS8sCYN9zgAz1Tkk6Eg17oa6KOejygS1TTiSp3MtaEXWgTpluCa1QgfEHcxnSJBFHVeP
 cuRJZ2W7q4noGWWQyEGzJCrFHL2asNZ1yveQGQdiuYVknPJTTtU7VNk81YgT9cGllY9S
 cxaQ==
X-Gm-Message-State: AOAM533AtwfV4hHVZGv/or2yd/HokaAm5gqZHZPJ3ySrhx+gh4xMvr3j
 dBrHLURNEyYbpwrTvxyuhgc+8g==
X-Google-Smtp-Source: ABdhPJwFYFQRxnQCZl5YpA7vvWLd+lmrE+Wk8kqNjr4QREmxfXWSgfeTDKTAIzecu4Uym4yvH8R31Q==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr23291836wmb.175.1606130365809; 
 Mon, 23 Nov 2020 03:19:25 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:19:25 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 02/40] drm/amd/amdgpu/amdgpu_ttm: Add description for
 'page_flags'
Date: Mon, 23 Nov 2020 11:18:41 +0000
Message-Id: <20201123111919.233376-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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
 linaro-mm-sig@lists.linaro.org, Jerome Glisse <glisse@freedesktop.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jOjEyMTQ6IHdhcm5pbmc6IEZ1bmN0aW9u
IHBhcmFtZXRlciBvciBtZW1iZXIgJ3BhZ2VfZmxhZ3MnIG5vdCBkZXNjcmliZWQgaW4gJ2FtZGdw
dV90dG1fdHRfY3JlYXRlJwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpD
YzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFu
aWVsQGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4K
Q2M6IEplcm9tZSBHbGlzc2UgPGdsaXNzZUBmcmVlZGVza3RvcC5vcmc+CkNjOiBhbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpD
YzogbGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnCkNjOiBsaW5hcm8tbW0tc2lnQGxpc3RzLmxp
bmFyby5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgfCAxICsKIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV90dG0uYwppbmRleCA1ZmNkZDY3ZTVhOTEzLi5kZWJiY2VmOTYxZGQ1IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCkBAIC0xMTk5LDYgKzExOTksNyBAQCBzdGF0aWMg
dm9pZCBhbWRncHVfdHRtX2JhY2tlbmRfZGVzdHJveShzdHJ1Y3QgdHRtX2JvX2RldmljZSAqYmRl
diwKICAqIGFtZGdwdV90dG1fdHRfY3JlYXRlIC0gQ3JlYXRlIGEgdHRtX3R0IG9iamVjdCBmb3Ig
YSBnaXZlbiBCTwogICoKICAqIEBibzogVGhlIGJ1ZmZlciBvYmplY3QgdG8gY3JlYXRlIGEgR1RU
IHR0bV90dCBvYmplY3QgYXJvdW5kCisgKiBAcGFnZV9mbGFnczogUGFnZSBmbGFncyB0byBiZSBh
ZGRlZCB0byB0aGUgdHRtX3R0IG9iamVjdAogICoKICAqIENhbGxlZCBieSB0dG1fdHRfY3JlYXRl
KCkuCiAgKi8KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
