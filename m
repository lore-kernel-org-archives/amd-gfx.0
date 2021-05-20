Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A3EC43460
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B9861163
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 12:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B9861163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709D46F452;
	Thu, 20 May 2021 12:49:11 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F036F421
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 12:03:13 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id i17so17365059wrq.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dzEKHJu7OFwu6XLDUaDLxDd4w/v+Udk50uYERKk06w8=;
 b=akXNjOoWI+hd9MtdjEd3PDOoyWFJFQqHYHLes7Q/ANFm6XOCR8E5Cujfd2BlPcBXCJ
 C3YQiJErJHlF0iiCtQSDwYs4ICfqx8+8BRPLBFZnIoPK3c0o/YXhMgTid38JyROYm/Vo
 teMr/RuOODaLYuS6h3C46IBLgzrTnsodcGqrjjrXvOrTzmRU6NoLhk6W3BhXiVTACjp8
 jyK92zW0AYM7tqwKFCElGatYODSlzWHsVPJIox4VcBOVAKulRUxCE1MhQwL16a6CszDD
 7yoZj+SHj4mtjkv1Id4QNGOSta7CCCLMZ9DdAYN154UEh2+GSkR27h/PMlGz9jv3heXo
 P0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dzEKHJu7OFwu6XLDUaDLxDd4w/v+Udk50uYERKk06w8=;
 b=M3JsS+hcMmKtiq8JyYoItF4LElQpqWTDxoOySk51bofdI4YzlAQCIxVii/F4VP0/mC
 XunL1j8ycSPWGTf8yb62wkXFBisuoohkF4EqwvyHAjNE5j6Qj3Cduzj/45c9fPxFwAMP
 AdwUpWjz4evD2ZtQSI4WkVTOvHNGII1xI0Tz6uFMxfh2kkUI6ITKlJTprQKuQxw4aQ8V
 OU4repz6YDThDAXoO5492y4qlSiVKxqVbVhUQnsw5MkdyX18XDDuGvyPz3oUlxcPNRIT
 6ZXw5Gqhe8C9g/fzdDBfCBoxhyjqSjX6revRzL2bBRfMiXkOS+rSul5YQ++hNbiMhlh+
 mKPw==
X-Gm-Message-State: AOAM533qvk2yS33awmWwM5De+RmnxL5dJWOwV37qqL0QvsAdXTj1zyMq
 3BwCdqUIM8VJCPZV/Jb0Sju7mQ==
X-Google-Smtp-Source: ABdhPJxIY7yv+rgs4XU+BqyHdRbSGkXegiiRFWqmNpb2diUp8p6mFeKESLGtV9djEkTEbXFrm/ADbQ==
X-Received: by 2002:a5d:4408:: with SMTP id z8mr4009264wrq.2.1621512192604;
 Thu, 20 May 2021 05:03:12 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm2886332wrt.32.2021.05.20.05.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 May 2021 05:03:12 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 20/38] drm/radeon/radeon_vm: Fix function naming disparities
Date: Thu, 20 May 2021 13:02:30 +0100
Message-Id: <20210520120248.3464013-21-lee.jones@linaro.org>
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdm0uYzo2MTogd2FybmluZzogZXhwZWN0aW5nIHByb3Rv
dHlwZSBmb3IgcmFkZW9uX3ZtX251bV9wZGUoKS4gUHJvdG90eXBlIHdhcyBmb3IgcmFkZW9uX3Zt
X251bV9wZGVzKCkgaW5zdGVhZAogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdm0uYzo2
NDI6IHdhcm5pbmc6IGV4cGVjdGluZyBwcm90b3R5cGUgZm9yIHJhZGVvbl92bV91cGRhdGVfcGRl
cygpLiBQcm90b3R5cGUgd2FzIGZvciByYWRlb25fdm1fdXBkYXRlX3BhZ2VfZGlyZWN0b3J5KCkg
aW5zdGVhZAoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6
ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQg
QWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xs
LmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGlu
YXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl92bS5jIHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ZtLmMgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl92bS5jCmluZGV4IDJkYzljOWY5ODA0OWIuLjM2YTM4YWRhYWVhOTYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3ZtLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdm0uYwpAQCAtNTEsNyArNTEsNyBAQAogICovCiAK
IC8qKgotICogcmFkZW9uX3ZtX251bV9wZGUgLSByZXR1cm4gdGhlIG51bWJlciBvZiBwYWdlIGRp
cmVjdG9yeSBlbnRyaWVzCisgKiByYWRlb25fdm1fbnVtX3BkZXMgLSByZXR1cm4gdGhlIG51bWJl
ciBvZiBwYWdlIGRpcmVjdG9yeSBlbnRyaWVzCiAgKgogICogQHJkZXY6IHJhZGVvbl9kZXZpY2Ug
cG9pbnRlcgogICoKQEAgLTYyNiw3ICs2MjYsNyBAQCBzdGF0aWMgdWludDMyX3QgcmFkZW9uX3Zt
X3BhZ2VfZmxhZ3ModWludDMyX3QgZmxhZ3MpCiB9CiAKIC8qKgotICogcmFkZW9uX3ZtX3VwZGF0
ZV9wZGVzIC0gbWFrZSBzdXJlIHRoYXQgcGFnZSBkaXJlY3RvcnkgaXMgdmFsaWQKKyAqIHJhZGVv
bl92bV91cGRhdGVfcGFnZV9kaXJlY3RvcnkgLSBtYWtlIHN1cmUgdGhhdCBwYWdlIGRpcmVjdG9y
eSBpcyB2YWxpZAogICoKICAqIEByZGV2OiByYWRlb25fZGV2aWNlIHBvaW50ZXIKICAqIEB2bTog
cmVxdWVzdGVkIHZtCi0tIAoyLjMxLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
