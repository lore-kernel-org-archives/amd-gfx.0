Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B795CC47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5725861090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5725861090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B335B6ECE1;
	Wed, 26 May 2021 12:57:24 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AB26EC2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:54 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id x7so167871wrt.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=7zQBHzs8bUaTq312vSS5VlkiBcTZpiBpI37cda1Zuvw=;
 b=UYtZk9Vp8FVe1rY6Ub1SdN2wtVTZoiQfb1OhbnN4uLhKytekELKH71HLthvfaEEBMv
 wBIa/HxlnMC/sO10tzKeNoWt/ywjW06knZiDtCEVvOJXP3GjgFeCGsU+g9bXcJsaQn//
 Vc1DynqHbRBauWzVeIg1c5RZOgmjN9sfZv6lrByDjqxkdtSi169CuIVPeGtXEdLospw6
 SwPcfZgQAz6smSpgvagmsFqAQwuZMUUhNAH4TGMj+Ee1bPlv7RADSi3mlU56zfRspTCD
 s/HwXup2wyf51Vbr455hzBeyzl6GzjAbR3I4/eIyvyWQ9iCzvPPFgN+trC6H456n4pdt
 4UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7zQBHzs8bUaTq312vSS5VlkiBcTZpiBpI37cda1Zuvw=;
 b=QvOX7WvKabswEKoM2cgCXcKrVmwpz/MJjPtUbltQjXwbPRYIsvbOlra55G9Lj+x0If
 wSHfUpbv6ftGSIR1rniLARC+96KfILiP9ExgN+UZNldcDvv6wh0tPAHdg2dC6VmD4cam
 OQdj7D7+6KFzYM/Hqn7jJTNNKIErVncB3Bas3hZUTAbPbzg0GqszPhmbiAhLgEXomeXx
 hwqDMz4FrE/S5xgYIJqzLXlHd6Wx2DxkY5IOj+yoTlGEQDXBBgG+GqDs2312NV7/Khdy
 rsRcUpmmL3op+E19//jKIqBseDR0CEYZDQ0D51oW5QDdazPIkvGkBCwhnmXxc2KGUlms
 pg+w==
X-Gm-Message-State: AOAM533AwUnfJYZBnhPc2dSNZ+f1/aFOJahUCoXbGLTPeRGf1W1R6vdG
 KgGjJo9LGPwd96lXPQz0zguTqw==
X-Google-Smtp-Source: ABdhPJwyM9q2L9wpp27S/zlBOBO4M2Oi04r375BiI90Tc7cDBIN5mL6gA3bcyKIjSdVdtrVg29ksqQ==
X-Received: by 2002:a5d:45c6:: with SMTP id b6mr31627763wrs.333.1622018873564; 
 Wed, 26 May 2021 01:47:53 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:53 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 22/34] drm/amd/display/dc/core/dc: Convert function headers to
 kernel-doc
Date: Wed, 26 May 2021 09:47:14 +0100
Message-Id: <20210526084726.552052-23-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjLmM6MzMyNDogd2Fybmlu
ZzogQ2Fubm90IHVuZGVyc3RhbmQgICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2NvcmUvZGMuYzozMzQ0OiB3YXJuaW5nOiBDYW5u
b3QgdW5kZXJzdGFuZCAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvY29yZS9kYy5jOjM0MTc6IHdhcm5pbmc6IENhbm5vdCB1bmRl
cnN0YW5kICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKgoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53
ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5p
ZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBs
aW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
ClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2NvcmUvZGMuYyB8IDQ2ICsrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDM1IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9jb3JlL2Rj
LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kYy5jCmluZGV4IGVmMTU3
YjgzYmFjZDIuLjM0YzIwN2Y5MmRmOTggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9kYy9jb3JlL2RjLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGMuYwpAQCAtMzMzNSwxOCArMzMzNSwxMCBAQCB2b2lkIGRjX2hhcmR3YXJlX3JlbGVh
c2Uoc3RydWN0IGRjICpkYykKICNlbmRpZgogCiAvKioKLSAqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgot
ICogIEZ1bmN0aW9uOiBkY19lbmFibGVfZG11Yl9ub3RpZmljYXRpb25zCisgKiBkY19lbmFibGVf
ZG11Yl9ub3RpZmljYXRpb25zIC0gUmV0dXJucyB3aGV0aGVyIGRtdWIgbm90aWZpY2F0aW9uIGNh
biBiZSBlbmFibGVkCisgKiBAZGM6IGRjIHN0cnVjdHVyZQogICoKLSAqICBAYnJpZWYKLSAqCQlS
ZXR1cm5zIHdoZXRoZXIgZG11YiBub3RpZmljYXRpb24gY2FuIGJlIGVuYWJsZWQKLSAqCi0gKiAg
QHBhcmFtCi0gKgkJW2luXSBkYzogZGMgc3RydWN0dXJlCi0gKgotICoJQHJldHVybgotICoJCVRy
dWUgdG8gZW5hYmxlIGRtdWIgbm90aWZpY2F0aW9ucywgRmFsc2Ugb3RoZXJ3aXNlCi0gKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioKKyAqIFJldHVybnM6IFRydWUgdG8gZW5hYmxlIGRtdWIgbm90aWZpY2F0
aW9ucywgRmFsc2Ugb3RoZXJ3aXNlCiAgKi8KIGJvb2wgZGNfZW5hYmxlX2RtdWJfbm90aWZpY2F0
aW9ucyhzdHJ1Y3QgZGMgKmRjKQogewpAQCAtMzM1NSwyMSArMzM0NywxMyBAQCBib29sIGRjX2Vu
YWJsZV9kbXViX25vdGlmaWNhdGlvbnMoc3RydWN0IGRjICpkYykKIH0KIAogLyoqCi0gKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioKLSAqICBGdW5jdGlvbjogZGNfcHJvY2Vzc19kbXViX2F1eF90cmFuc2Zl
cl9hc3luYwotICoKLSAqICBAYnJpZWYKLSAqCQlTdWJtaXRzIGF1eCBjb21tYW5kIHRvIGRtdWIg
dmlhIGluYm94IG1lc3NhZ2UKLSAqCQlTZXRzIHBvcnQgaW5kZXggYXBwcm9wcmlhdGVseSBmb3Ig
bGVnYWN5IEREQwotICoKLSAqICBAcGFyYW0KLSAqCQlbaW5dIGRjOiBkYyBzdHJ1Y3R1cmUKLSAq
CQlbaW5dIGxpbmtfaW5kZXg6IGxpbmsgaW5kZXgKLSAqCQlbaW5dIHBheWxvYWQ6IGF1eCBwYXls
b2FkCisgKiBkY19wcm9jZXNzX2RtdWJfYXV4X3RyYW5zZmVyX2FzeW5jIC0gU3VibWl0cyBhdXgg
Y29tbWFuZCB0byBkbXViIHZpYSBpbmJveCBtZXNzYWdlCisgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU2V0cyBwb3J0IGluZGV4IGFwcHJvcHJpYXRlbHkgZm9yIGxlZ2Fj
eSBEREMKKyAqIEBkYzogZGMgc3RydWN0dXJlCisgKiBAbGlua19pbmRleDogbGluayBpbmRleAor
ICogQHBheWxvYWQ6IGF1eCBwYXlsb2FkCiAgKgotICoJQHJldHVybgotICoJCVRydWUgaWYgc3Vj
Y2Vzc2Z1bCwgRmFsc2UgaWYgZmFpbHVyZQotICoqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCisgKiBSZXR1
cm5zOiBUcnVlIGlmIHN1Y2Nlc3NmdWwsIEZhbHNlIGlmIGZhaWx1cmUKICAqLwogYm9vbCBkY19w
cm9jZXNzX2RtdWJfYXV4X3RyYW5zZmVyX2FzeW5jKHN0cnVjdCBkYyAqZGMsCiAJCQkJdWludDMy
X3QgbGlua19pbmRleCwKQEAgLTM0MjgsMTYgKzM0MTIsOCBAQCBib29sIGRjX3Byb2Nlc3NfZG11
Yl9hdXhfdHJhbnNmZXJfYXN5bmMoc3RydWN0IGRjICpkYywKIH0KIAogLyoqCi0gKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioKLSAqICBGdW5jdGlvbjogZGNfZGlzYWJsZV9hY2NlbGVyYXRlZF9tb2RlCi0g
KgotICogIEBicmllZgotICoJCWRpc2FibGUgYWNjZWxlcmF0ZWQgbW9kZQotICoKLSAqICBAcGFy
YW0KLSAqCQlbaW5dIGRjOiBkYyBzdHJ1Y3R1cmUKLSAqCi0gKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioK
KyAqIGRjX2Rpc2FibGVfYWNjZWxlcmF0ZWRfbW9kZSAtIGRpc2FibGUgYWNjZWxlcmF0ZWQgbW9k
ZQorICogQGRjOiBkYyBzdHJ1Y3R1cmUKICAqLwogdm9pZCBkY19kaXNhYmxlX2FjY2VsZXJhdGVk
X21vZGUoc3RydWN0IGRjICpkYykKIHsKLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
