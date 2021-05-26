Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D01C4708B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35BA60FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35BA60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4937D6ECF9;
	Wed, 26 May 2021 12:57:29 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18DF86EC2F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:39 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 l11-20020a05600c4f0bb029017a7cd488f5so54427wmq.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OW7W47mIWK6yublPiEJWvFrVpFjoI7qTlEhI5W3sk3g=;
 b=Q4Dzbneel0DMkx+zXQm4rfhuirMiZW0kumIdYTlWN3Rc8ONEfmPsGv5nSTgmMJMzm1
 dDVTt75sX/MR1ZLRVZN3aTgKAPW2fjnN4y4HZQMD5UJnGpbzaGx3zX/TY54CwkTpN93z
 ci3EPh0fpBN429rFH3EWjtZm/y/XmxGjjvLf/rm6l1smQ/An5IKRNRN0RO/bZnXExJD2
 Yf/0VcrD5X5GZ/W8bFogzhmqOFHRKGj64yiSr/Eoafy5yJ46O/pFb3qzPGyq1W/bjEXy
 qmrYNwBKc95Gk6tvYCz8Wc6n8OynNac2iK09tru9kJoWyxDnZIIE4BOk/y7Fl7k7Mgti
 +IGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OW7W47mIWK6yublPiEJWvFrVpFjoI7qTlEhI5W3sk3g=;
 b=pYuyQCfAbkVwCrYxHbvZHup6edLo7S3kxHdsB6mL718+jV5tUaVVdOSzHy2Rx1yThO
 5nfWAhBm2bGKL/2W7W3YWgBSZNVB4cd3G2oBQclyzx5HaBXVfTOe8FfCdiE58+Do0Eea
 3vbVRlbUBIw9Hsyjm4/iVZSNehcqMNsTjb/IhiJDfkm05i6QGfTIRCwtkcqCxYwLHA/1
 HBjczH3hEq6AdnCj9BAI6ILrWC4TWahZaWn4lVK2FOqtfJiaNDnP1ZGYBnfEHJ0OL1HA
 vSVJGMtNpgu94kCKW45W/L8QX0zbI5O+B/HhRlQLbFoj2sCe0sbOr1m5YgYBaKvdv9jG
 2i5w==
X-Gm-Message-State: AOAM532Riyr3EcmmYZ2d7V55iyvXyscPuGYNkxQHwV2ptF6fbG9umJED
 RN57Sg+uH/p/cSWuNrGH8yI/XQ==
X-Google-Smtp-Source: ABdhPJzKjOnP2FN9XbCVd5z8Nh671DlRl76pfsWhDUprJRbuK1oP+cI43ILSCrES9+8y0ekBcxVa9A==
X-Received: by 2002:a7b:c446:: with SMTP id l6mr2223901wmi.75.1622018857723;
 Wed, 26 May 2021 01:47:37 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:37 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 07/34] drm/amd/pm/powerplay/hwmgr/vega20_hwmgr: Provide
 function name 'vega20_init_smc_table()'
Date: Wed, 26 May 2021 09:46:59 +0100
Message-Id: <20210526084726.552052-8-lee.jones@linaro.org>
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9od21nci5j
Ojc4MTogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3IgSW5pdGlhbGl6ZXMgdGhlIFNN
QyB0YWJsZSBhbmQgdXBsb2FkcyBpdCgpLiBQcm90b3R5cGUgd2FzIGZvciB2ZWdhMjBfaW5pdF9z
bWNfdGFibGUoKSBpbnN0ZWFkCgpDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2M6
IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4g
S8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJs
aWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKU2lnbmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci92ZWdhMjBfaHdtZ3IuYyB8
IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2h3bWdyL3ZlZ2EyMF9o
d21nci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTIwX2h3
bWdyLmMKaW5kZXggZDMxNzdhNTM0ZmRmMC4uMDc5MTMwOTU4NmM1OCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTIwX2h3bWdyLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvdmVnYTIwX2h3bWdyLmMKQEAg
LTc3Miw3ICs3NzIsNyBAQCBzdGF0aWMgaW50IHZlZ2EyMF9zZXR1cF9kZWZhdWx0X2RwbV90YWJs
ZXMoc3RydWN0IHBwX2h3bWdyICpod21ncikKIH0KIAogLyoqCi0gKiBJbml0aWFsaXplcyB0aGUg
U01DIHRhYmxlIGFuZCB1cGxvYWRzIGl0CisgKiB2ZWdhMjBfaW5pdF9zbWNfdGFibGUgLSBJbml0
aWFsaXplcyB0aGUgU01DIHRhYmxlIGFuZCB1cGxvYWRzIGl0CiAgKgogICogQGh3bWdyOiAgdGhl
IGFkZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBoYXJkd2FyZSBtYW5hZ2VyLgogICogcmV0dXJuOiAg
YWx3YXlzIDAKLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
