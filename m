Return-Path: <SRS0=1d99=JN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D23AC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D50D60FF1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Apr 2021 16:57:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D50D60FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BB56EC81;
	Fri, 16 Apr 2021 16:57:29 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE39C6EC16
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 14:37:57 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id x4so32590662edd.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Apr 2021 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nl9Ia26K/OXp5QH7iR+CbZa0T1DkwvGhAbdA6rubQXU=;
 b=oRdDDVJnzU3oMYTdwqGq9oXyUcUTdpDa1cOLOtcv0eXH+IRscfrSxyE41XMoKgAynl
 ymX3w3afs7fC3P3KgCkr/gH01+c3nkSfjS0tJAv9h7srrtpvdGbujaFCQuzYffzvjJR6
 AYBhsbaS03ELNdlRIGdVO2wm/yA6LLFAujh4O3RUcl+pIhLax9HkuhTycdAsJK5Rh7Qb
 4NcL9vZZuLNrgSVcoPsDaw64oAa4gqBf+FwDOJepaoBBaxgAvFdEntsSh1aGplh0bKgt
 kZ7ytIwCvAADgk32eYBabFmahqZvK3qX5L7bFuh7Z01D2pTsDY+n4wUrcN6+JC7tGEoZ
 G84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nl9Ia26K/OXp5QH7iR+CbZa0T1DkwvGhAbdA6rubQXU=;
 b=k2yHh9vhxPcwAhzPjsW+6g79b2y/zZawRpaIArTigdmOxZUqzmcuu8WwmG8YDZfnI0
 XwhCgm4RJQAqPgZc7VDg8gN5pOErOiK/R9Usllb2YlWesu+x9xYkt+qVetyDAGMq1YaA
 qGmDy6rZqVgZep/7nm3YHnoXLv56vChtVpTtCGKGUerUP+7+yWF13aqNF4CxPAMnGh+Q
 NdNMspqH4x1uqrAjes9bn0rihte+Qs5hYcqTE23mFC8p0B+Zz6MbHquztu05Pc2qp1i2
 hjm6Yz0HeW5GyYlfmWCzh1JyFjJC26e/dqhdPuSugd1pmTaQbCz5iUbI/A9kz2T0CjYB
 G+Ug==
X-Gm-Message-State: AOAM5317CAD59orx8RzuLVm0gEaHCMMZ3LFKl9WI4awsLUSnkl9gyVNF
 i3w4KkIAFxwSs76ZRXOsRa0VbQ==
X-Google-Smtp-Source: ABdhPJwPgmM7wgMTNVvKHslB4VCGOhOKe5VlAyEqYISlgKU0gq2jXg+T/USowGVX/n309irhgUvG+g==
X-Received: by 2002:a05:6402:3506:: with SMTP id
 b6mr10702102edd.175.1618583876478; 
 Fri, 16 Apr 2021 07:37:56 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
 by smtp.gmail.com with ESMTPSA id j10sm1326523ejk.93.2021.04.16.07.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 07:37:55 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 25/40] drm/radeon/radeon_device: Provide function name in
 kernel-doc header
Date: Fri, 16 Apr 2021 15:37:10 +0100
Message-Id: <20210416143725.2769053-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210416143725.2769053-1-lee.jones@linaro.org>
References: <20210416143725.2769053-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 16 Apr 2021 16:57:23 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGV2aWNlLmM6MTEwMTogd2FybmluZzogVGhpcyBjb21t
ZW50IHN0YXJ0cyB3aXRoICcvKionLCBidXQgaXNuJ3QgYSBrZXJuZWwtZG9jIGNvbW1lbnQuIFJl
ZmVyIERvY3VtZW50YXRpb24vZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0CgpDYzogQWxleCBEZXVj
aGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXgu
aWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWdu
ZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2RldmljZS5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9u
X2RldmljZS5jCmluZGV4IGNjNDQ1YzRjYmEyZTMuLjQ2ZWVhMDE5NTBjYjEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2RldmljZS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9yYWRlb24vcmFkZW9uX2RldmljZS5jCkBAIC0xMDk4LDcgKzEwOTgsOCBAQCBzdGF0aWMg
Ym9vbCByYWRlb25fY2hlY2tfcG90X2FyZ3VtZW50KGludCBhcmcpCiB9CiAKIC8qKgotICogRGV0
ZXJtaW5lIGEgc2Vuc2libGUgZGVmYXVsdCBHQVJUIHNpemUgYWNjb3JkaW5nIHRvIEFTSUMgZmFt
aWx5LgorICogcmFkZW9uX2dhcnRfc2l6ZV9hdXRvIC0gRGV0ZXJtaW5lIGEgc2Vuc2libGUgZGVm
YXVsdCBHQVJUIHNpemUKKyAqICAgICAgICAgICAgICAgICAgICAgICAgIGFjY29yZGluZyB0byBB
U0lDIGZhbWlseS4KICAqCiAgKiBAZmFtaWx5OiBBU0lDIGZhbWlseSBuYW1lCiAgKi8KLS0gCjIu
MjcuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
