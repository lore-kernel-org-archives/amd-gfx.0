Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01530C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C413061163
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C413061163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458AD6F450;
	Thu, 20 May 2021 12:49:11 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C371789130
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:16 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id j14so15648373wrq.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aa3gg5EuMa9A5nk5o0d0T8SZ6WR+4Hli7trc1GNqVzE=;
 b=P/8FbvIM/h7Ij52WQCkLtGbmLfZt2AIUofpELl7aKx9cVVKxRhCPQWSTqLoL+D5ek0
 3e7FpGFtcDBnwmpnAo9QDgzBiqYfUul8fsWJeAdJ7gqxXWD3KfNPqhNmL0hOBgD8iCLs
 RHzl84pChy/3XbBLbG+ny0C3LSao4HP+jP1MS08fMA09Bv1MtJYVhGkCT6RL8+WsnmG6
 2IpoNRsoY7lJhmH+oP52+LkzipwOSevCUEQlu28ZqIaOJy+zUHSR8XzhYCrK4pomOiQM
 H9hu5ChdIaJPBw6CSJrYMjgHUW9+6vQGnmLJfH42Xr7yZ3VgkiBDkOTrowlpSuVIksnb
 9qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aa3gg5EuMa9A5nk5o0d0T8SZ6WR+4Hli7trc1GNqVzE=;
 b=I4oyVJ5RWVsnF09Q3MnI3bZ+C61sZjiOhHB4wpxVKUEJYXwjn7L56dIiy9/XJUlVJ6
 pHvdNrJ4uI3Iyp/8jlrUpDtRR5LZCfQOyzQeKOSYLOdeZdOQg6ZHbRunn7NQxOypdtTQ
 O/gTZM7MBAVMI7FaqREXOOoq5Cg4GMh6hLOwB49sAOLMFDzaGJcF0zwFVkPLk42DtMOM
 I+4D5d8j3eXHBUoPlYn8tzU8hH09keQQcXq0gvKULDb/IGJ8P6B8qZ+vVHeQ2k9whERc
 0S4k9UXYVtx67IxB63V+qFXOtzOqMV+B/Vj/N+jjFFfrtWzdORWYpRhh5KfnPabNGA0a
 9UIA==
X-Gm-Message-State: AOAM531r9v5vfwBR+Gg9adLV1NK5N2Ebtw0LCupQwipBw29HL4Hhp1Ub
 gHqz1iqX0xtY2ghlVGvI+te9wg==
X-Google-Smtp-Source: ABdhPJxcm94XcnPIlXpI+aoOcisifK8IL9R99fLfefdLdPJx9Qsa0SXHZUEbROwc7y4h4Dww96AGxA==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr4038472wrt.189.1621512195526; 
 Thu, 20 May 2021 05:03:15 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:15 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 23/38] drm/amd/amdgpu/gmc_v7_0: Fix potential copy/paste issue
Date: Thu, 20 May 2021 13:02:33 +0100
Message-Id: <20210520120248.3464013-24-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y3XzAuYzo1MjY6IHdhcm5pbmc6IGV4cGVjdGluZyBw
cm90b3R5cGUgZm9yIGdtY192OF8wX3NldF9mYXVsdF9lbmFibGVfZGVmYXVsdCgpLiBQcm90b3R5
cGUgd2FzIGZvciBnbWNfdjdfMF9zZXRfZmF1bHRfZW5hYmxlX2RlZmF1bHQoKSBpbnN0ZWFkCgpD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlh
biBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFp
cmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ21jX3Y3XzAuYwppbmRleCAyMTBhZGEyMjg5ZWM5Li44ZTI4MjE2OWY5OWViIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192N18wLmMKQEAgLTUxNiw3ICs1MTYsNyBAQCBzdGF0
aWMgdm9pZCBnbWNfdjdfMF9nZXRfdm1fcHRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
fQogCiAvKioKLSAqIGdtY192OF8wX3NldF9mYXVsdF9lbmFibGVfZGVmYXVsdCAtIHVwZGF0ZSBW
TSBmYXVsdCBoYW5kbGluZworICogZ21jX3Y3XzBfc2V0X2ZhdWx0X2VuYWJsZV9kZWZhdWx0IC0g
dXBkYXRlIFZNIGZhdWx0IGhhbmRsaW5nCiAgKgogICogQGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9p
bnRlcgogICogQHZhbHVlOiB0cnVlIHJlZGlyZWN0cyBWTSBmYXVsdHMgdG8gdGhlIGRlZmF1bHQg
cGFnZQotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
