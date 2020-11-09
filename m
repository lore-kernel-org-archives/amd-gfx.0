Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617DBC5517A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFC1206CB
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9yOQdMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFC1206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B025896A3;
	Mon,  9 Nov 2020 21:21:44 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7BA8913D
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:22 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id w24so929767wmi.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mzXhCpiCwfXhn5UZVrUN8y55iF7Guz7qLR0QXW6Magc=;
 b=E9yOQdMhotNG/FmE2dQJiD0qZR2wVPwJ5vehlHuLTLfjg1jR9o5wsvjApIc0HsAoaZ
 8qkna1nD8pDl/vM/3OBHtp/FmUb2nst5uLUBWgGS6fKuFHw/7kaia+s30iU85HXrgJ2d
 W+AsyMp7+7a2eiwEY49kWaRTKHSfjRPq/fnNRWjEYHm29TrLP53ZF7vB0FubYev+Fb2b
 Zh7m6Bpat6KyzNntvJ5HdJsheSg03sQOSHUslkzMUOhFnBsVIscuSdJVUrqOivIRbb21
 wGeWuPmoWkWfZSKBsErebYJ/J5S6cHJnNh+7AOgnAtr0I/PNy+e4jUw2i/WQqXZ1HpP8
 BmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mzXhCpiCwfXhn5UZVrUN8y55iF7Guz7qLR0QXW6Magc=;
 b=b/G3ziM/5fci/AEW/93vmNVHVT36oSKStAjS7uxlmsbe799dHRV/iBbx/IO5rayzi1
 GAvOhov7qj6RTNv2J9orcoqbCK7KfltD4tKKqOihILJsNwkLs0e2XHLC99757dvZoC33
 wGFExYhbSCQ23MxN55x6AAWf6INbkzpGkLIpCNPiD5goUPEkJgItRsDBMIWkzjbQ8rI+
 Or3XmQSh1CebJQLEJECwI2DncCOqaPwOVbkeAdrD429p0+zqacqjqFyU0QayvGwfrsw6
 Gkq03mMLRzW+k9o/tf8SBQpLvvx+PlveTBLpRMPuZ8DUSnwehAlQgjT4sfSta4vEDyih
 rGVQ==
X-Gm-Message-State: AOAM533tyCOpabz4ebQ69l/muh0dAXBCsuZ+EOX6bWV+xICrYfh4NqCE
 EHLPHWXjgY4u/yUVwGqsE6ueLA==
X-Google-Smtp-Source: ABdhPJz7gosq03zFigv4Og0US7gk4Sex1qokBiUld+OMUY44DLZUxJaFKrfBrf69+FZ+3dQiMYRZLQ==
X-Received: by 2002:a7b:c5c3:: with SMTP id n3mr1133832wmk.44.1604956761276;
 Mon, 09 Nov 2020 13:19:21 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:20 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/20] drm/radeon/radeon_display: Remove unused variable 'mod'
Date: Mon,  9 Nov 2020 21:18:42 +0000
Message-Id: <20201109211855.3340030-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:21:41 +0000
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
 linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 report to <xorg-driver-ati@lists.x.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jOiBJbiBmdW5jdGlvbiDigJhyYWRlb25f
ZGl24oCZOgogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jOjEwOTQ6MTE6
IHdhcm5pbmc6IHZhcmlhYmxlIOKAmG1vZOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1i
dXQtc2V0LXZhcmlhYmxlXQoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1k
LmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpD
YzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFu
aWVsQGZmd2xsLmNoPgpDYzogU3VtaXQgU2Vtd2FsIDxzdW1pdC5zZW13YWxAbGluYXJvLm9yZz4K
Q2M6IHJlcG9ydCB0byA8eG9yZy1kcml2ZXItYXRpQGxpc3RzLngub3JnPgpDYzogYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IGxpbnV4LW1lZGlhQHZnZXIua2VybmVsLm9yZwpDYzogbGluYXJvLW1tLXNpZ0BsaXN0cy5s
aW5hcm8ub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jIHwgNCArLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jIGIvZHJpdmVycy9ncHUv
ZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jCmluZGV4IGJkNjBmMTZmZDBkNzguLjc4ZmNlZWRm
ZDkyNTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXku
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKQEAgLTEwOTEs
MTEgKzEwOTEsOSBAQCB2b2lkIHJhZGVvbl9jb21wdXRlX3BsbF9hdml2byhzdHJ1Y3QgcmFkZW9u
X3BsbCAqcGxsLAogLyogcHJlLWF2aXZvICovCiBzdGF0aWMgaW5saW5lIHVpbnQzMl90IHJhZGVv
bl9kaXYodWludDY0X3QgbiwgdWludDMyX3QgZCkKIHsKLQl1aW50NjRfdCBtb2Q7Ci0KIAluICs9
IGQgLyAyOwogCi0JbW9kID0gZG9fZGl2KG4sIGQpOworCWRvX2RpdihuLCBkKTsKIAlyZXR1cm4g
bjsKIH0KIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
