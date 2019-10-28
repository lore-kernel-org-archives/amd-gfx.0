Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5012CA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1C5217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1C5217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93AEA6EAAA;
	Mon, 28 Oct 2019 21:43:40 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E686EAAA
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:39 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id w5so4393517ybs.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GJZAPAB9TzHoxM5Wh1v3IEaEGA/8F0zj5r6AgfYhfEs=;
 b=H3QG/CNrZp1sVaog+B9GeAYHnh4gLAzM7n66Tdq4IVT6qKcnXsa/fwgFxRI6dODZc4
 anSPJGr3+ZaxIm4LvEIjvr8tAgCJ/Ysi5ouMMNA6x4DvSvMJIKv3A7qREoduDeHwM9zn
 v8uJ5FneSq+qRMf5OoiYcFIyGhnmtb5jHMUhKyHFpJmwggQ+uS7zCDwKAPTuOfDTfBox
 SxrbimWBt9Z0NKPZybkCy0YwOIRrYUomrBSSVod6axEWKYhHK5zpnEcAtMEqMiAj+FJJ
 IHL0NSbzgpEAsgrQmR+QrpePmOinizi/J+cJgwQPlTe1GztW3NqWEylOhAeTDyz1hAJr
 ekzg==
X-Gm-Message-State: APjAAAXu4NmXpt4AmvOucJgXdDq8E8jLDsBKXG9fMailfgRfKHQtHcVV
 oC51jZd32tJD2gQa0z7Eof0wY81BEpA=
X-Google-Smtp-Source: APXvYqwISLLy2E0UUjwlfDLL2xxVlWWh9Gs5O5w8L2UXtcqu9Hvc3NrziwdR8Xo8DvRCWWhkPnzY0Q==
X-Received: by 2002:a25:7c7:: with SMTP id 190mr15918296ybh.24.1572299018037; 
 Mon, 28 Oct 2019 14:43:38 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 13/21] drm/amdgpu: add baco support to runtime suspend/resume
Date: Mon, 28 Oct 2019 17:42:08 -0400
Message-Id: <20191028214216.1508370-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=GJZAPAB9TzHoxM5Wh1v3IEaEGA/8F0zj5r6AgfYhfEs=;
 b=qET5lgYjfUo4xmVbpEMi/WTVGBgq/MjwXyLCGrzRWCaBU0eNJFg3fnLSYeCi6DDZnT
 m4XTvfe1aCH23/PCfdrhBbcGs4PXz7Qa4FCpffRzOSOM6/U+CnvGpAKEKqYqUU7mGP9J
 3/pfHEQLyPtFSFuYlWojFL71vpqK3SIaBG4rxjaapSEIq5aVRIV44xz0BDbUbd5I78qU
 2r710M8+gfApoB+8Q8qvZsOi2nU98h11zaaOYnbcHCMc6N+Aypl436d6WbNM9ZHnD9Bz
 t9WG3SWoKR7hCiVNCNIT6ES7VPnqrK7gDTjkdnTBn7/Vop9oTUxvhdaWPQu0/EXEZ7Np
 P2qA==
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
Message-ID: <20191028214208.H02BmUJyt_y5bQ1u4BGfoz9c-mFIAONRZKytveYgQ6I@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpUaGlzIGFkZHMgdGhlIG5lY2Vzc2FyeSBzdXBw
b3J0IHRvIHRoZSBydW50aW1lIHN1c3BlbmQKYW5kIHJlc3VtZSBmdW5jdGlvbnMgdG8gaGFuZGxl
IGJvYXJkcyB0aGF0IHN1cHBvcnQKYmFjby4KClJldmlld2VkLWJ5OiBFdmFuIFF1YW4gPGV2YW4u
cXVhbkBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
IHwgNyArKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCmluZGV4IDdiODQ3OGQw
OGIyYi4uODQ5Nzg0ZTI3YTk4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jCkBAIC0xMTY0LDcgKzExNjQsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2KQogCXN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2ID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7CiAKIAkvKiBHUFUgY29tZXMgdXAgZW5hYmxlZCBieSB0aGUgYmlvcyBv
biByZXN1bWUgKi8KLQlpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGRybV9kZXYpKSB7
CisJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhkcm1fZGV2KSB8fAorCSAgICBhbWRn
cHVfZGV2aWNlX3N1cHBvcnRzX2JhY28oZHJtX2RldikpIHsKIAkJcG1fcnVudGltZV9kaXNhYmxl
KGRldik7CiAJCXBtX3J1bnRpbWVfc2V0X2FjdGl2ZShkZXYpOwogCQlwbV9ydW50aW1lX2VuYWJs
ZShkZXYpOwpAQCAtMTIzMSw2ICsxMjMyLDggQEAgc3RhdGljIGludCBhbWRncHVfcG1vcHNfcnVu
dGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKIAkJZWxzZSBpZiAoIWFtZGdwdV9oYXNf
YXRweF9kZ3B1X3Bvd2VyX2NudGwoKSkKIAkJCXBjaV9zZXRfcG93ZXJfc3RhdGUocGRldiwgUENJ
X0QzaG90KTsKIAkJZHJtX2Rldi0+c3dpdGNoX3Bvd2VyX3N0YXRlID0gRFJNX1NXSVRDSF9QT1dF
Ul9EWU5BTUlDX09GRjsKKwl9IGVsc2UgaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYmFjbyhk
cm1fZGV2KSkgeworCQlhbWRncHVfZGV2aWNlX2JhY29fZW50ZXIoZHJtX2Rldik7CiAJfQogCiAJ
cmV0dXJuIDA7CkBAIC0xMjU2LDYgKzEyNTksOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19y
dW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJCWlmIChyZXQpCiAJCQlyZXR1cm4g
cmV0OwogCQlwY2lfc2V0X21hc3RlcihwZGV2KTsKKwl9IGVsc2UgaWYgKGFtZGdwdV9kZXZpY2Vf
c3VwcG9ydHNfYmFjbyhkcm1fZGV2KSkgeworCQlhbWRncHVfZGV2aWNlX2JhY29fZXhpdChkcm1f
ZGV2KTsKIAl9CiAJcmV0ID0gYW1kZ3B1X2RldmljZV9yZXN1bWUoZHJtX2RldiwgZmFsc2UsIGZh
bHNlKTsKIAlkcm1fa21zX2hlbHBlcl9wb2xsX2VuYWJsZShkcm1fZGV2KTsKLS0gCjIuMjMuMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
