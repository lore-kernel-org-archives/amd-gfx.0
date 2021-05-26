Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF95C47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A934160FD8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A934160FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB756ECDF;
	Wed, 26 May 2021 12:57:24 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE6916EC32
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:34 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id v12so203840wrq.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=G7iaDAB2ZuYVyZx68crg6QhzsOg2OHh06HlhEV13AEw=;
 b=I44CIXDqN65PoObP1/rnC7UjnZafXPh+DuBi0Kq2AWIMOpWajEcw78rMhgD/TBi7oB
 wQgH4fcGxdTk4hb1J/Z9fSCeumJdhs0xsuW5LIMQKFUtFdY6YpqGYGgty7pr46KVg5ny
 7q7Ea6E5YIAanyRZeCH40+Ipeq7NKd9LXLVQX7/ckkNe4lhcSsJTgZleDyj3sBvKcyYo
 X0Ssu4Uq4x6S4+g6/RC+pZsBe3yvR/6OjXnGTRdRkX9fK+pU9iexVjgDaBKyrtm/HJr/
 t0cXJxRJSOAnFQ9RPkc78nW8/5+Y4ZSP0fA51KvYlXl2dd/6gFl+keus84Ue65vf6oO8
 IYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G7iaDAB2ZuYVyZx68crg6QhzsOg2OHh06HlhEV13AEw=;
 b=PlWg/TB7QSHTNi34YneThx+nmDycfpuLpO8UZRxNo9QjX1nuz+MeHuXHkvTVLB2gDS
 Urinf2Q1THdltU/WQCBq4ZOk3SyCvT1V7fpMrLgWgz1TRVJCprUdL9JdVqNiXMkBCuua
 lWE1Cfnrmr8Pwj6trDTws9l7OUaMivrii6UkD8ZXQffYQfMqbwExbkjkYoWF/jSFUPwA
 wbt7bXNnIhMuXvutPRECILG4P+zO4upoBfLRAsFEch4Q+RjYbJEcozuXOdw1hDTU5RVe
 P7xzbQAkzlzDYSLp06/GYI1Z08jnhB0iqJQH44PWDhtSrh23c2xm8bOopKOp/k00VAFx
 ZIMw==
X-Gm-Message-State: AOAM530X8Nq2dCqCwhwfkv7MBl7STv1hA3gYbZtHVS2U76xOvovCEJFz
 s2FyZxV9hB9tzR/6RUbvM1y8gg==
X-Google-Smtp-Source: ABdhPJyISrVWreIUVorPlzyIi2UoKk92HM0mafCSCAAuFnhn6pcE2wxasr0XIJ9wDl0RbS9Aht9XuQ==
X-Received: by 2002:a5d:52ce:: with SMTP id r14mr17258203wrv.395.1622018853569; 
 Wed, 26 May 2021 01:47:33 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:33 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 03/34] drm/amd/pm/powerplay/hwmgr/smu7_thermal: Provide
 function name for 'smu7_fan_ctrl_set_default_mode()'
Date: Wed, 26 May 2021 09:46:55 +0100
Message-Id: <20210526084726.552052-4-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3NtdTdfdGhlcm1hbC5j
OjEzMjogd2FybmluZzogVGhpcyBjb21tZW50IHN0YXJ0cyB3aXRoICcvKionLCBidXQgaXNuJ3Qg
YSBrZXJuZWwtZG9jIGNvbW1lbnQuIFJlZmVyIERvY3VtZW50YXRpb24vZG9jLWd1aWRlL2tlcm5l
bC1kb2MucnN0CgpDYzogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4KQ2M6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4
LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2ln
bmVkLW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXU3X3RoZXJtYWwuYyB8IDggKysrKy0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3Ivc211N190aGVy
bWFsLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXU3X3RoZXJt
YWwuYwppbmRleCAwZDM4ZDQyMDY4NDhhLi42Y2ZlMTQ4ZWQ0NWJiIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXU3X3RoZXJtYWwuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL3BtL3Bvd2VycGxheS9od21nci9zbXU3X3RoZXJtYWwuYwpAQCAt
MTI5LDEwICsxMjksMTAgQEAgaW50IHNtdTdfZmFuX2N0cmxfc2V0X3N0YXRpY19tb2RlKHN0cnVj
dCBwcF9od21nciAqaHdtZ3IsIHVpbnQzMl90IG1vZGUpCiB9CiAKIC8qKgotKiBSZXNldCBGYW4g
U3BlZWQgQ29udHJvbCB0byBkZWZhdWx0IG1vZGUuCi0qIEBod21ncjogIHRoZSBhZGRyZXNzIG9m
IHRoZSBwb3dlcnBsYXkgaGFyZHdhcmUgbWFuYWdlci4KLSogRXhjZXB0aW9uOiBTaG91bGQgYWx3
YXlzIHN1Y2NlZWQuCi0qLworICogc211N19mYW5fY3RybF9zZXRfZGVmYXVsdF9tb2RlIC0gUmVz
ZXQgRmFuIFNwZWVkIENvbnRyb2wgdG8gZGVmYXVsdCBtb2RlLgorICogQGh3bWdyOiAgdGhlIGFk
ZHJlc3Mgb2YgdGhlIHBvd2VycGxheSBoYXJkd2FyZSBtYW5hZ2VyLgorICogRXhjZXB0aW9uOiBT
aG91bGQgYWx3YXlzIHN1Y2NlZWQuCisgKi8KIGludCBzbXU3X2Zhbl9jdHJsX3NldF9kZWZhdWx0
X21vZGUoc3RydWN0IHBwX2h3bWdyICpod21ncikKIHsKIAlpZiAoIWh3bWdyLT5mYW5fY3RybF9p
c19pbl9kZWZhdWx0X21vZGUpIHsKLS0gCjIuMzEuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
