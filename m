Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEB5C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924962399C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924962399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F8C6E8F6;
	Fri,  8 Jan 2021 20:24:18 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D4336E8DF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:41 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id i9so10169356wrc.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B0vgdR8naA6iZCQ4IL55g07H1SHyqDXPDametYwo0Pg=;
 b=oLM/pC+rSUDP4ZUfp3a6s6i/HWBsHp9Du8iTI2RGZXxY1NVI07AaFBnwpdJlHwG0ri
 VQWy/Y4lQ4XMyQj7vkEB2ONHZswhsBNlxrWqZDqKyDwMCsD0tvwyuGX5oCvKMYmbJvDb
 K39uYXCmZbZuRkO4RkxnD88hGmVCmzqPdBvnFKoWaghzSw40LfLtM0F52BlernQZy5A7
 0+LUMRcbxP334bSPiCN3m1gjS8U5YoMbdS1BgCd6DO48LnFmd+Q+V4szxYZkFUmqmOix
 BGN6f5dDtv1T46Dye2RikAAdhcILtMNFQNof7yhedF7tFiwrW4S39SWbEhIwsG5JY1Mu
 bfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B0vgdR8naA6iZCQ4IL55g07H1SHyqDXPDametYwo0Pg=;
 b=Ez/fe0SoI0h3kV466dLT0VwPoWNPJza9w72b0Yw9wskAw2g2/lD2k+d0sfslmckDL4
 RzMzulNUluzKi5y3sZzCgLwLQrZvtMqT2SFpJeFLPzM6CJJ3Gs5ZKxZjQdjkgGYDjJ6g
 M5Ewaiybaj9Nj6N+bFFtJnQfGDHlJO99bHUhansjJ4+JeK/9C2bV4LiJty8GCLlDcPYd
 IfHIxdUPNTbf9RuvvL3VWdmunGfT0ZQ7xm45dBYoMsiJzozKtpRzk1bEsmG4AwV8F3s/
 0400l+knXtx1EUzBtAFwMH6NoHXsjeW2AjttzDm/1Q6TYRzHvUVTRLvahCsL863DeU/j
 j6WQ==
X-Gm-Message-State: AOAM5336wIx+LGOPJGCEpfq+uk11UStrAarGVvYrG1t4IVtbvI7MCdV3
 qxX6r40iZIyXLdr8gsvbp7QSOA==
X-Google-Smtp-Source: ABdhPJyYiKLdjQp26AmRTUh/MggUIUNkwlTVFGf1EzxWSSuGPgRj9sazR71L7iqaa5Znm27QpNWWow==
X-Received: by 2002:a5d:6751:: with SMTP id l17mr5243954wrw.73.1610136939823; 
 Fri, 08 Jan 2021 12:15:39 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:39 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 24/40] drm/amd/display/dc/dce/dce_stream_encoder: Remove
 unused variable 'regval'
Date: Fri,  8 Jan 2021 20:14:41 +0000
Message-Id: <20210108201457.3078600-25-lee.jones@linaro.org>
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
 Eric Bernstein <eric.bernstein@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, George Shen <george.shen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZGNlX3N0cmVhbV9lbmNvZGVy
LmM6IEluIGZ1bmN0aW9uIOKAmGRjZTExMF91cGRhdGVfZ2VuZXJpY19pbmZvX3BhY2tldOKAmToK
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNlL2RjZV9zdHJlYW1f
ZW5jb2Rlci5jOjcwOjExOiB3YXJuaW5nOiB2YXJpYWJsZSDigJhyZWd2YWzigJkgc2V0IGJ1dCBu
b3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KCkNjOiBIYXJyeSBXZW50bGFuZCA8
aGFycnkud2VudGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlh
biBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBH
ZW9yZ2UgU2hlbiA8Z2VvcmdlLnNoZW5AYW1kLmNvbT4KQ2M6IEVyaWMgQmVybnN0ZWluIDxlcmlj
LmJlcm5zdGVpbkBhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6
IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVz
IDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkv
ZGMvZGNlL2RjZV9zdHJlYW1fZW5jb2Rlci5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9zdHJlYW1fZW5jb2Rlci5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjZS9kY2Vfc3RyZWFtX2VuY29kZXIuYwppbmRleCBhZGE1N2Y3NDVm
ZDc2Li4yNjVlYWVmMzBhNTE5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3Bs
YXkvZGMvZGNlL2RjZV9zdHJlYW1fZW5jb2Rlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9kY2UvZGNlX3N0cmVhbV9lbmNvZGVyLmMKQEAgLTY3LDcgKzY3LDYgQEAgc3Rh
dGljIHZvaWQgZGNlMTEwX3VwZGF0ZV9nZW5lcmljX2luZm9fcGFja2V0KAogCXVpbnQzMl90IHBh
Y2tldF9pbmRleCwKIAljb25zdCBzdHJ1Y3QgZGNfaW5mb19wYWNrZXQgKmluZm9fcGFja2V0KQog
ewotCXVpbnQzMl90IHJlZ3ZhbDsKIAkvKiBUT0RPRlBHQSBGaWd1cmUgb3V0IGEgcHJvcGVyIG51
bWJlciBmb3IgbWF4X3JldHJpZXMgcG9sbGluZyBmb3IgbG9jawogCSAqIHVzZSA1MCBmb3Igbm93
LgogCSAqLwpAQCAtOTksNyArOTgsNyBAQCBzdGF0aWMgdm9pZCBkY2UxMTBfdXBkYXRlX2dlbmVy
aWNfaW5mb19wYWNrZXQoCiAJfQogCS8qIGNob29zZSB3aGljaCBnZW5lcmljIHBhY2tldCB0byB1
c2UgKi8KIAl7Ci0JCXJlZ3ZhbCA9IFJFR19SRUFEKEFGTVRfVkJJX1BBQ0tFVF9DT05UUk9MKTsK
KwkJUkVHX1JFQUQoQUZNVF9WQklfUEFDS0VUX0NPTlRST0wpOwogCQlSRUdfVVBEQVRFKEFGTVRf
VkJJX1BBQ0tFVF9DT05UUk9MLAogCQkJCUFGTVRfR0VORVJJQ19JTkRFWCwgcGFja2V0X2luZGV4
KTsKIAl9Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
