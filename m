Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A787C43381
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A09C22A83
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A09C22A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09B76E077;
	Mon, 11 Jan 2021 19:54:43 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8BD89E65
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:19:57 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id y187so6320wmd.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TNrmFPwKfzO7gGVeJXgh6mlXY4soyZtk9MOKSdUAh0g=;
 b=A7rFEb0NpwwXT9gbSmNZG+K3fWQndZl2/WjJJtCYNRFqJ1Tv5oiN45STNYGV0hRA9g
 sOTSZOBjf5f0sFct4xkHdaJqBcb+L5ebEfU9S3X2cSADcM9dOx+q0ykLSzrDKZJz6PB3
 SXGFuaem8J5K8503YbkueSDTTd7ph6N07iJLZ4gvVUgqM3OPAb3n6xEu9KWELO9NeGdU
 H4QHzJeYh4w1cOJa3XG2ETOO4PD12f+zG0x101YqSHrpfBShxMwd93DVVB9jJIpACTVg
 MbZkNftYMcluX3P0MjIZoy6pKS9txIjbirf01A+kMk9jEVGao6Jp60mnhvm7S8BXPJWh
 GYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TNrmFPwKfzO7gGVeJXgh6mlXY4soyZtk9MOKSdUAh0g=;
 b=Qn5fOMhPLlyy5hGAi9TW3aIc5umOtb6zWXV4bB1ypWYbV9h+v/R8aBzO9dYBraqZQM
 TWJoGqRBGj+pBkQeGQknqsCv3jt6eceOzKglNks4LGRC9Cm9xUgdZNBSSwctmVF/deYF
 S1XgSpDAZVY7lpvgNmnyfS9sbFT8en5kLTrK8mN/KxBq+PzKGPmDR/pMGMXdkm7gv6ZD
 39eI5f0I1D4lmcDZ0/2mJ/hrPkaEgEvXd82Rjrsl8MaOWsI8KzwE+pNrgVjgSDWw5KlN
 8d+IyCO1pwbC4eGpahUTZxWHYP93993AbQXRcMqsROW7gy5Edkjz9uVj4sWl6G7japxi
 +4LQ==
X-Gm-Message-State: AOAM533K43nj4irRG23X/6Pt+IcnsfJqSBuM5cmVsVfGD7NzI+tfeHGp
 NiVntCxiaPpob7fw5Hp+G2Cvag==
X-Google-Smtp-Source: ABdhPJwRmVyOvGf3salMx7JCs/5UCKN5ZGZgaFgk22fzZglVbO7FJ8zMwOMQg13lKdj2nH4jX4wJvA==
X-Received: by 2002:a1c:6205:: with SMTP id w5mr306872wmb.26.1610392796639;
 Mon, 11 Jan 2021 11:19:56 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:19:55 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 20/40] drm/amd/display/dc/dce110/dce110_timing_generator:
 Remove unused variable 'value_crtc_vtotal'
Date: Mon, 11 Jan 2021 19:19:06 +0000
Message-Id: <20210111191926.3688443-21-lee.jones@linaro.org>
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 Tony Cheng <Tony.Cheng@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3RpbWluZ19n
ZW5lcmF0b3IuYzogSW4gZnVuY3Rpb24g4oCYZGNlMTEwX3RpbWluZ19nZW5lcmF0b3JfdGVhcl9k
b3duX2dsb2JhbF9zd2FwX2xvY2vigJk6CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS8uLi9k
aXNwbGF5L2RjL2RjZTExMC9kY2UxMTBfdGltaW5nX2dlbmVyYXRvci5jOjEzNTQ6MTI6IHdhcm5p
bmc6IHZhcmlhYmxlIOKAmHZhbHVlX2NydGNfdnRvdGFs4oCZIHNldCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpDYzogSGFycnkgV2VudGxhbmQgPGhhcnJ5LndlbnRs
YW5kQGFtZC5jb20+CkNjOiBMZW8gTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4
LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogQXJpYyBDeXIgPEFy
aWMuQ3lyQGFtZC5jb20+CkNjOiBBbnRob255IEtvbyA8QW50aG9ueS5Lb29AYW1kLmNvbT4KQ2M6
IFRvbnkgQ2hlbmcgPFRvbnkuQ2hlbmdAYW1kLmNvbT4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYt
Ynk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogLi4uL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF90aW1pbmdfZ2VuZXJhdG9yLmMgIHwgNSArLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3RpbWluZ19n
ZW5lcmF0b3IuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEw
X3RpbWluZ19nZW5lcmF0b3IuYwppbmRleCAxZWE3ZGI4ZWViOTg4Li45YTZjNDExYmI3ZmU2IDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF90
aW1pbmdfZ2VuZXJhdG9yLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2Rj
ZTExMC9kY2UxMTBfdGltaW5nX2dlbmVyYXRvci5jCkBAIC0xMzUxLDEwICsxMzUxLDcgQEAgdm9p
ZCBkY2UxMTBfdGltaW5nX2dlbmVyYXRvcl90ZWFyX2Rvd25fZ2xvYmFsX3N3YXBfbG9jaygKIAog
CS8qIFJlc3RvcmUgRENQX0dTTF9QVVJQT1NFX1NVUkZBQ0VfRkxJUCAqLwogCXsKLQkJdWludDMy
X3QgdmFsdWVfY3J0Y192dG90YWw7Ci0KLQkJdmFsdWVfY3J0Y192dG90YWwgPSBkbV9yZWFkX3Jl
Zyh0Zy0+Y3R4LAotCQkJCUNSVENfUkVHKG1tQ1JUQ19WX1RPVEFMKSk7CisJCWRtX3JlYWRfcmVn
KHRnLT5jdHgsIENSVENfUkVHKG1tQ1JUQ19WX1RPVEFMKSk7CiAKIAkJc2V0X3JlZ19maWVsZF92
YWx1ZSh2YWx1ZSwKIAkJCQkwLAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
