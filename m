Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062F5C5517A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3562087E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gzq3IRI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3562087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6D606EB3D;
	Fri,  6 Nov 2020 21:52:21 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4BA96EB27
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:50:03 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id 23so1771654wmg.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vkQ+EXF2yvxMQDq5My2ZO6G3Ve/ySfBy90ygkHt2VtU=;
 b=Gzq3IRI0uTFVZlLkG4qnK9tDKHmeGHf2mKcsxo5k/h1Bg2Tv8V54kdCY9AHxJgSEPs
 r+ddfC6UKgvuGktLUD0J4MeReXJRe8D9mj8jmxwpjda+Blbkmmo/NxejuMXZKnmqryPV
 tOsi1wq4BJ6Ix3M2w7sZ5r2Mq9Xk+iazjCRbiP4qCoYmVzorxIgZMMyZQ9MEgPs/9zvF
 TwCO+hl7gCCuh8YRq88MEFHPz7Te9KdEsbrLCjKGDkMsG4rypxZFbZ27YEaobgDFV4WB
 iMpXoWS9j+cBHUnPyuPpO22zo/9LPEyWSS2QNNcMyESyZYCS7f4/GglC1fKpXEZcZcwS
 5JWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vkQ+EXF2yvxMQDq5My2ZO6G3Ve/ySfBy90ygkHt2VtU=;
 b=aoZ7dvEuaYI3B8J0cB3YOApcZiCiSBRSZ6e9a3Nvqxs01UO9dBX5AzWNzzkudWJS3r
 EIDkkFQvx7jME31GSBvyjoxugtRvlh2qwRSw2+y0CWfc05yPvrOMbDX6u6Rtc8HwQgQC
 pXR6jnxLnHZMrEHsJWg8HxN0AV87leMZ6sWc8LwGxse8lzzxNzAOR3WtMwYeD7KcDave
 dsCQcrxC1iEFmIJ9CV00bHcsmIMIu9zwj4yTaVkhAtydk8Rx6utHkzejFMb5N04IY8vE
 gqHXmgTq6u6Gp/9xUtG0Dl/2JbYRLgNvWu//aw3qMPXxXXipQRvJja3fsppaaYRJsI10
 kBPw==
X-Gm-Message-State: AOAM530gAs8K8IHxz+bnNp0MJhzQLUvNa8AcjIhpqnJB/1NN1ZB0iT9h
 0pplixNiDqrslj8pg3CZE8+ETg==
X-Google-Smtp-Source: ABdhPJyU7EH8mAlQbHj5iVCt1SHByf4Au5dpPrxdGJurg0RZZ8Yrc6araI0XkYSkWnrx8DEC2UDlNQ==
X-Received: by 2002:a1c:9e93:: with SMTP id h141mr1524494wme.153.1604699402333; 
 Fri, 06 Nov 2020 13:50:02 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:50:01 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/19] drm/radeon/radeon_kms: Include header containing our
 own prototypes
Date: Fri,  6 Nov 2020 21:49:37 +0000
Message-Id: <20201106214949.2042120-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Nov 2020 21:52:20 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6NjE6Njogd2FybmluZzogbm8gcHJldmlvdXMg
cHJvdG90eXBlIGZvciDigJhyYWRlb25fZHJpdmVyX3VubG9hZF9rbXPigJkgWy1XbWlzc2luZy1w
cm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6MTA0OjU6IHdh
cm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2RyaXZlcl9sb2FkX2tt
c+KAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9rbXMuYzo2MTg6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhyYWRl
b25fZHJpdmVyX2xhc3RjbG9zZV9rbXPigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6NjMzOjU6IHdhcm5pbmc6IG5vIHByZXZpb3Vz
IHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2RyaXZlcl9vcGVuX2ttc+KAmSBbLVdtaXNzaW5nLXBy
b3RvdHlwZXNdCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYzo3MDQ6Njogd2Fy
bmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZvciDigJhyYWRlb25fZHJpdmVyX3Bvc3RjbG9z
ZV9rbXPigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9y
YWRlb25fa21zLmM6NzU1OjU6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCY
cmFkZW9uX2dldF92YmxhbmtfY291bnRlcl9rbXPigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQog
ZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmM6ODI1OjU6IHdhcm5pbmc6IG5vIHBy
ZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYcmFkZW9uX2VuYWJsZV92Ymxhbmtfa21z4oCZIFstV21p
c3NpbmctcHJvdG90eXBlc10KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2ttcy5jOjg1
Mjo2OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl9kaXNhYmxl
X3ZibGFua19rbXPigJkgWy1XbWlzc2luZy1wcm90b3R5cGVzXQoKQ2M6IEFsZXggRGV1Y2hlciA8
YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpD
YzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9m
Zi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9rbXMuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fa21zLmMgYi9k
cml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwppbmRleCA5OWVlNjBmOGI2MDRkLi4w
ZDhmYmFiZmZjZWFkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9r
bXMuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9rbXMuYwpAQCAtNDAsNiAr
NDAsNyBAQAogCiAjaW5jbHVkZSAicmFkZW9uLmgiCiAjaW5jbHVkZSAicmFkZW9uX2FzaWMuaCIK
KyNpbmNsdWRlICJyYWRlb25fZHJ2LmgiCiAKICNpZiBkZWZpbmVkKENPTkZJR19WR0FfU1dJVENI
RVJPTykKIGJvb2wgcmFkZW9uX2hhc19hdHB4KHZvaWQpOwotLSAKMi4yNS4xCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
