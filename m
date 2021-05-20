Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF6EC43462
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A966E61001
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A966E61001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10BD56F454;
	Thu, 20 May 2021 12:49:12 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D826F409
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:02:56 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 y184-20020a1ce1c10000b02901769b409001so5074211wmg.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lGLjcLP6XbktLbs6h51Tzfo9UCd4ALnwNCABJxfHlD8=;
 b=RswVceEghKvRou9H+Y+n/4SGLr0iHCK4YwE3OtciUiXOYGX33RrcazH0XHhG0gM+FR
 gDrggVWuc+eJ1ovzgkuY+nVHRfRMrHXKxfrg+GjAq4UJ/sIPYyWgLURB/U1ydhi+rjL4
 a0gT7DPM+iyP3Hdl+CY7cNrDKLkgXD97xlVuD0YpS0TAa4vANNYC4IZAtHLY7yOiIGnZ
 TsXH7/P3K+/tLqt6ivBjAxI4vTZTF19wicEn7EeqL1MYCjzYWyLcJe3EkWuV3k4dV2u7
 WSngNPnxaWDxif2K48yALBZJ+wpI3RYui68JmuoX7vY6B1uSkUmP+m9gPbGh1rpieE3S
 mQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lGLjcLP6XbktLbs6h51Tzfo9UCd4ALnwNCABJxfHlD8=;
 b=DbNjghvNOeYYweo72xMVb+xTPys98Xw0hWO5N/PIGknISmwbwHCWXkabRCWg2fjiT2
 iZyb1e9uzothP/RF99z+T8w+O2teq1cWqTGe8IjL+t9RNi7YHI9Aarn8a9ens9l6vP/i
 r0mawpinteZ3xh5yjeh+/nw+LliqWQJorMBTKYX+mKoHQZakw2cPvMZt6T7q8ZhsbC90
 xBRqU54tvMPMtgRBrxNTBz3qz1GFppOhYOgZsXUdaM/zqxuFe8ZPa+kzMYt5EB9BeVTC
 r9ppAlNTDKxX/TVwbCpjv09Q//18ZwouI6mVT6HSjPWnF++u87MokQ7u/ww2X4kAmT3g
 qIgA==
X-Gm-Message-State: AOAM530/GkiUr7+Mz/4STZ6K5LFMGvVMJR7Lwb+4jqxG2YdlM0Qk1szo
 K4liTFEbuqXzOYLoVPG2/9tv6w==
X-Google-Smtp-Source: ABdhPJxYJE37rXT7HUjUcMLnTidaMQQQNRQYf0bEaPu9Z9ouJiVKZK37ju5F7bwa1KL/1nYfylvzFg==
X-Received: by 2002:a1c:e241:: with SMTP id z62mr3728499wmg.135.1621512175250; 
 Thu, 20 May 2021 05:02:55 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:02:54 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 03/38] drm/radeon/radeon_cs: Fix incorrectly documented
 function 'radeon_cs_parser_fini'
Date: Thu, 20 May 2021 13:02:13 +0100
Message-Id: <20210520120248.3464013-4-lee.jones@linaro.org>
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
 linaro-mm-sig@lists.linaro.org, Jerome Glisse <glisse@freedesktop.org>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYzo0MTc6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90
b3R5cGUgZm9yIGNzX3BhcnNlcl9maW5pKCkuIFByb3RvdHlwZSB3YXMgZm9yIHJhZGVvbl9jc19w
YXJzZXJfZmluaSgpIGluc3RlYWQKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIg
PGRhbmllbEBmZndsbC5jaD4KQ2M6IFN1bWl0IFNlbXdhbCA8c3VtaXQuc2Vtd2FsQGxpbmFyby5v
cmc+CkNjOiBKZXJvbWUgR2xpc3NlIDxnbGlzc2VAZnJlZWRlc2t0b3Aub3JnPgpDYzogYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKQ2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0
cy5saW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5v
cmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fY3MuYyB8IDIgKy0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9u
L3JhZGVvbl9jcy5jCmluZGV4IDQ4MTYyNTAxYzFlZTYuLjgwYTNiZWU5MzNkNmQgMTAwNjQ0Ci0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2NzLmMKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fY3MuYwpAQCAtNDA1LDcgKzQwNSw3IEBAIHN0YXRpYyBpbnQgY21w
X3NpemVfc21hbGxlcl9maXJzdCh2b2lkICpwcml2LCBjb25zdCBzdHJ1Y3QgbGlzdF9oZWFkICph
LAogfQogCiAvKioKLSAqIGNzX3BhcnNlcl9maW5pKCkgLSBjbGVhbiBwYXJzZXIgc3RhdGVzCisg
KiByYWRlb25fY3NfcGFyc2VyX2ZpbmkoKSAtIGNsZWFuIHBhcnNlciBzdGF0ZXMKICAqIEBwYXJz
ZXI6CXBhcnNlciBzdHJ1Y3R1cmUgaG9sZGluZyBwYXJzaW5nIGNvbnRleHQuCiAgKiBAZXJyb3I6
CWVycm9yIG51bWJlcgogICogQGJhY2tvZmY6CWluZGljYXRvciB0byBiYWNrb2ZmIHRoZSByZXNl
cnZhdGlvbgotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
