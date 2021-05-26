Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A1AC4708A
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB1160FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB1160FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 102786ECF5;
	Wed, 26 May 2021 12:57:29 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 286886EC48
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:45 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id n2so266518wrm.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b58/b35h1ySITpV32UiH3hgADkqDQkiEXVcNLNWEueg=;
 b=lS2dDBdK3+lqs/BpdDNpVbyj4ptYsVo8RYqPRKNGSWwAX72gmfXIQtRmaqAPtS2a27
 VtwUMNtHed1uPMM4kJHGvF41ejYzstijQToVtJKeXj4Au3Xe4o+RehgjcsYOTuxsA7Wq
 AHXdyji7xPFSiksN67m9VVZbiR0XEx+MFzWgP7tOq3GT4vnTbW+LTnYVvozRJ8YJckp1
 15CLocjxNl4gGzqAYHsa0Tud7Fljic6Ockj+03OqQy4v5wU2hhyGJ4W1ORbj31C8z3gc
 +LXHOUkVrztyKpQk8k2SwIqHIxOSF0HR48NvkUB2iml7BjE8fI0Tln6vmDCVv3WSwXgr
 P3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b58/b35h1ySITpV32UiH3hgADkqDQkiEXVcNLNWEueg=;
 b=P2mYYNz5CJgZ6yM3vqLPgURpNOd88uCIrmyakKs8C7VDYZcFfELNJq8hmJV25HmmJW
 KS8FHGeYUUctVxgK8Iq0SiUKJGBH7OCkbYbjbnbMFtRKxh+ELJFqxNZ+8mlGYbfXZf/H
 nv0mNUQVmi85SbBmIEnnoGHDRKcIlOX4aROG2LPJFJaJiFRVXJRrXFJCX83LWtkXuf+x
 YBLIXKTNA/NkgY/roluqiJ55HYiBSjmvFTuB/SrwVW56ix/exVG1GDRBq5ePr5kd5fke
 que6vdfWyUc9bADkBpkV9Iy9iAcShgqUk/SykKWB5PSiLnlJQo7CMPecKj2eMCaVYRYR
 Et+A==
X-Gm-Message-State: AOAM533ndact0PyMkAKLLYmoiJjfNHWFs2F9gsKMxwcaGM04alhC1mHf
 jeM39neYElzwdcHlpyVlkejQHA==
X-Google-Smtp-Source: ABdhPJyNaLy+RiYocIz059ItZ6quUW2ShSpj8xz6ANJUGgnXUvL5SlhLPaLRy61OVzWgjhdqgUb6eA==
X-Received: by 2002:a5d:4e8c:: with SMTP id e12mr31664433wru.94.1622018863739; 
 Wed, 26 May 2021 01:47:43 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:43 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 13/34] drm/amd/display/dc/dce/dmub_outbox: Convert over to
 kernel-doc
Date: Wed, 26 May 2021 09:47:05 +0100
Message-Id: <20210526084726.552052-14-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UvZG11Yl9vdXRib3guYzozMDog
d2FybmluZzogQ2Fubm90IHVuZGVyc3RhbmQgICoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCgpDYzogSGFy
cnkgV2VudGxhbmQgPGhhcnJ5LndlbnRsYW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcu
bGlAYW1kLmNvbT4KQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4K
Q2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2
aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZm
d2xsLmNoPgpDYzogUm9kcmlnbyBTaXF1ZWlyYSA8Um9kcmlnby5TaXF1ZWlyYUBhbWQuY29tPgpD
YzogTWVlbmFrc2hpa3VtYXIgU29tYXN1bmRhcmFtIDxtZWVuYWtzaGlrdW1hci5zb21hc3VuZGFy
YW1AYW1kLmNvbT4KQ2M6IEp1biBMZWkgPEp1bi5MZWlAYW1kLmNvbT4KQ2M6IGFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNp
Z25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogLi4uL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RtdWJfb3V0Ym94LmMgICAgfCAxNyArKysrLS0tLS0t
LS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kbXViX291
dGJveC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZS9kbXViX291dGJveC5j
CmluZGV4IDI5NTU5NmQxZjQ3ZjIuLmZhYWQ4NTU1ZGRiYjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZG11Yl9vdXRib3guYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RtdWJfb3V0Ym94LmMKQEAgLTI3LDE5ICsyNywxMCBA
QAogI2luY2x1ZGUgImRtdWIvaW5jL2RtdWJfY21kLmgiCiAKIC8qKgotICoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqCi0gKiAgRnVuY3Rpb246IGRtdWJfZW5hYmxlX291dGJveF9ub3RpZmljYXRpb24KLSAq
Ci0gKiAgQGJyaWVmCi0gKgkJU2VuZHMgaW5ib3ggY21kIHRvIGRtdWIgdG8gZW5hYmxlIG91dGJv
eDEgbWVzc2FnZXMgd2l0aCBpbnRlcnJ1cHQuCi0gKgkJRG11YiBzZW5kcyBvdXRib3gxIG1lc3Nh
Z2UgYW5kIHRyaWdnZXJzIG91dGJveDEgaW50ZXJydXB0LgotICoKLSAqICBAcGFyYW0KLSAqCQlb
aW5dIGRjOiBkYyBzdHJ1Y3R1cmUKLSAqCi0gKiAgQHJldHVybgotICogICAgIE5vbmUKLSAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKgorICogIGRtdWJfZW5hYmxlX291dGJveF9ub3RpZmljYXRpb24gLSBT
ZW5kcyBpbmJveCBjbWQgdG8gZG11YiB0byBlbmFibGUgb3V0Ym94MQorICogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBtZXNzYWdlcyB3aXRoIGludGVycnVwdC4gRG11YiBzZW5k
cyBvdXRib3gxCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1lc3NhZ2Ug
YW5kIHRyaWdnZXJzIG91dGJveDEgaW50ZXJydXB0LgorICogQGRjOiBkYyBzdHJ1Y3R1cmUKICAq
Lwogdm9pZCBkbXViX2VuYWJsZV9vdXRib3hfbm90aWZpY2F0aW9uKHN0cnVjdCBkYyAqZGMpCiB7
Ci0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
