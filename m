Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170ADC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B70FD22A83
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B70FD22A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB69D6E09A;
	Mon, 11 Jan 2021 19:54:46 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C975489E43
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:52 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id r4so278479wmh.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ygXlsea1j1ghgNQFnw1H978M537fO8hMkf4tF7c92PM=;
 b=l0mLo+tzQpWlBoBKL8Z4VS6/DvkWb/hffm4vC/r93BqpOCEZdmRsBfHgyK8eshU4Bl
 TRdKZu029FApVLQljGUcOiDQZOf2MNdy6xwE4jnB/A52Uhh12zl2WmZM8Z8FPQOPL2i4
 KZyFU89I2pMZkvclUC3cykkzxTJfVOawLn2G7MsvDRx5Lma4fT9Fa6NFfC7edyK+/Q/J
 DhA7oShBVnCM7dVCk09xik4NVAdIVAeLquxLdHHGFhfXjKhDoC5Nil5a4LWPhKYcAEuW
 Q5HlB32YtHtiUAAtlyA4pbNyBcRwRO7A2gXKyB7OAaTUvFW5vr/8nj7aBHHatEEvWhkQ
 brwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ygXlsea1j1ghgNQFnw1H978M537fO8hMkf4tF7c92PM=;
 b=CMWAxbKaEMcf3Hg/0N+xO7+etCZJEmkht79kkBTYxbqdiEqP7BS34ucBOA3t4eGbej
 Qf7QOHDiL7TwHbKRS9VPePFBSkmiaiXhInTNBACW40m2wLpHpvOVW16DR9pzQejtfbf6
 F6eS5PPc54XMFsF7Sv1oiVqAokysLhnTAL96hEPm/qCvWN7xrdl4V0+z7zU5YU28XIlb
 FlAnHdUDoLaX/KLPRWPa3GvCT2icaZtD2avxJsLLB99uGZX9Dg0spqXZ/YAoF3WwbvsN
 y2IeMI1icLBcsI8d6nZqwPdu2CiPqAlpzlh5p33p91CSNAPaZ7gcmVXqf2EZyrkTL7af
 KLOw==
X-Gm-Message-State: AOAM531KMiVOmlZ6afqoKCtWn9FbfnNUopNIhyEJrhyZl8nBVqnk5wgB
 T63te7iST68eZPQqSrDOze2lpA==
X-Google-Smtp-Source: ABdhPJzrrPnEkqyVVOgksMUOoP+NL4WzUV16TJPxHXMKFD4NTKigi8F1CQ0Gu+lQN3c09XAbusBcYw==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr281642wmb.144.1610392791539; 
 Mon, 11 Jan 2021 11:19:51 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:50 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 16/40] drm/amd/display/dc/dce120/dce120_timing_generator:
 Demote non-kerneldoc headers
Date: Mon, 11 Jan 2021 19:19:02 +0000
Message-Id: <20210111191926.3688443-17-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3RpbWluZ19n
ZW5lcmF0b3IuYzo2MDI6MTM6IHdhcm5pbmc6IOKAmGRjZTEyMF90aW1pbmdfZ2VuZXJhdG9yX2dl
dF9wb3NpdGlvbuKAmSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtZnVuY3Rpb25dCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2RjZTEyMC9kY2UxMjBfdGlt
aW5nX2dlbmVyYXRvci5jOjczOiB3YXJuaW5nOiBDYW5ub3QgdW5kZXJzdGFuZCAgKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZGNl
MTIwL2RjZTEyMF90aW1pbmdfZ2VuZXJhdG9yLmM6NTkzOiB3YXJuaW5nOiBDYW5ub3QgdW5kZXJz
dGFuZCAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioKCkNjOiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2Vu
dGxhbmRAYW1kLmNvbT4KQ2M6IExlbyBMaSA8c3VucGVuZy5saUBhbWQuY29tPgpDYzogQWxleCBE
ZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWci
IDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGlu
dXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBMZWUgSm9uZXMg
PGxlZS5qb25lc0BsaW5hcm8ub3JnPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpv
bmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2UxMjAvZGNlMTIwX3RpbWluZ19nZW5lcmF0b3IuYyAgIHwgNCArKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3RpbWluZ19nZW5lcmF0b3Iu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMjAvZGNlMTIwX3RpbWluZ19n
ZW5lcmF0b3IuYwppbmRleCBlYmM3ZDYxZThiZjM2Li5kMDJlY2I5ODNjOWNkIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTIwL2RjZTEyMF90aW1pbmdfZ2Vu
ZXJhdG9yLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEyMC9kY2Ux
MjBfdGltaW5nX2dlbmVyYXRvci5jCkBAIC02OSw3ICs2OSw3IEBACiAjZGVmaW5lIENSVENfUkVH
X1NFVF8zKHJlZywgZmllbGQxLCB2YWwxLCBmaWVsZDIsIHZhbDIsIGZpZWxkMywgdmFsMykJXAog
CQlDUlRDX1JFR19TRVRfTihyZWcsIDMsIEZEKHJlZyMjX18jI2ZpZWxkMSksIHZhbDEsIEZEKHJl
ZyMjX18jI2ZpZWxkMiksIHZhbDIsIEZEKHJlZyMjX18jI2ZpZWxkMyksIHZhbDMpCiAKLS8qKgor
LyoKICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKgogICogIEZ1bmN0aW9uOiBpc19pbl92ZXJ0aWNhbF9i
bGFuawogICoKQEAgLTU4OSw3ICs1ODksNyBAQCBzdGF0aWMgdm9pZCBkY2UxMjBfdGltaW5nX2dl
bmVyYXRvcl9zZXRfZHJyKAogCX0KIH0KIAotLyoqCisvKgogICoqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
CiAgKiAgRnVuY3Rpb246IGRjZTEyMF90aW1pbmdfZ2VuZXJhdG9yX2dldF9wb3NpdGlvbgogICoK
LS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0
cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
