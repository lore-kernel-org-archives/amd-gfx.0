Return-Path: <SRS0=AVpe=EL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3D0C55179
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 15:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB8B20867
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2020 15:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XSREkBYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB8B20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F906ED87;
	Thu,  5 Nov 2020 15:41:06 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C0396EDA0
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2020 14:52:34 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id w14so2083983wrs.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2020 06:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rv3e4lR5n3wbFt5a45993iZf/YGmwbWZWnMbXebEIvs=;
 b=XSREkBYK380J4CWNoXmcHRvUSexcxURarBudmCsFRVoIQ5vYDbDJky11tMykMICSa5
 4t9WSt6mx44I9x9YihMhfrnjm70iija84cbYr3L4NqZKBysrWKTcAV2f60BmrUPyFPBc
 uy2UBtjWg1mmBR2rV9UNTmvSNlis678WRkrwrShYsej7hOIa9wV1hL4KdbtQJtzxDpWt
 pdjB5XWNlS0fZTNFXn5zMylPY7TooJTMlFDSFAhcBEEuM3+ByEeXJGnioaHz511LVgxV
 vP5bJbK0TsnoToAaMHJdezPZ7VCMgyK37zQ060GU0rjX/IC+TOsbCJNFnwcMXfS16kho
 26yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rv3e4lR5n3wbFt5a45993iZf/YGmwbWZWnMbXebEIvs=;
 b=cxT0xuDiy1o08q4KuZFx9CJlldQLO0oiQcOF7k0Mo9y+hEEIhb4u6JfXNEt4WIWwq2
 9vqzMbf7z0zGPnXyivuvyYUSwNRYSV6A50Fn3hOmd1fw/SotJS8Fz0IwdceY1MV4kI4h
 Wof6KvBJgszlJKKcYJd/sBxkU1u1/Z6XM6OyJTtUgv/+Od4QRHZA/G9Iz6cFso7fsPIt
 sf7Gkr4O3jqljdHVqkQizVH/nmV10uwkckm+sgy/sABNWsuiDjSoEGigCnvGT/ru3wYn
 KU4Bn2u9nP4eoXVUCRG77NnZo5fQo09pa4NoaOlzrvYKnrkFzvzgbXPQLiMvOMELZNz4
 bZOw==
X-Gm-Message-State: AOAM5301Tp0pauXj5CqcEj7T4zYL8QYA5bcY+aiIZpSaJrvkeN4Hi48w
 JTVlt5sxVUJzCqgF+gWzBja3GA==
X-Google-Smtp-Source: ABdhPJyRZrB38ZvyOkJUZt6MoLWccltE1b+bbQaqzlHiYSRu4qcXO2ij1vEYl45QgtpeTpFIvxmy+Q==
X-Received: by 2002:adf:fac6:: with SMTP id a6mr3321445wrs.373.1604587953215; 
 Thu, 05 Nov 2020 06:52:33 -0800 (PST)
Received: from dell.default ([91.110.221.242])
 by smtp.gmail.com with ESMTPSA id f5sm2631243wmh.16.2020.11.05.06.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 06:52:32 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 15/19] gpu: drm: radeon: radeon_drv: Remove unused variable
 'ret'
Date: Thu,  5 Nov 2020 14:45:13 +0000
Message-Id: <20201105144517.1826692-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105144517.1826692-1-lee.jones@linaro.org>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 05 Nov 2020 15:41:05 +0000
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
 Gareth Hughes <gareth@valinux.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZHJ2LmM6IEluIGZ1bmN0aW9uIOKAmHJhZGVvbl9wbW9w
c19ydW50aW1lX3N1c3BlbmTigJk6CiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYu
Yzo0NTU6Njogd2FybmluZzogdmFyaWFibGUg4oCYcmV04oCZIHNldCBidXQgbm90IHVzZWQgWy1X
dW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFt
ZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0
dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBHYXJldGggSHVnaGVzIDxnYXJldGhAdmFsaW51eC5j
b20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jIHwgMyArLS0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kcnYuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9yYWRlb24vcmFkZW9uX2Rydi5jCmluZGV4IDY1MDYxYzk0OWFlZWEuLmY1ZjFjYjcwMGQ4NzMg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rydi5jCkBAIC00NTIsNyArNDUyLDYgQEAgc3Rh
dGljIGludCByYWRlb25fcG1vcHNfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikK
IHsKIAlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsKIAlzdHJ1Y3QgZHJt
X2RldmljZSAqZHJtX2RldiA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsKLQlpbnQgcmV0OwogCiAJ
aWYgKCFyYWRlb25faXNfcHgoZHJtX2RldikpIHsKIAkJcG1fcnVudGltZV9mb3JiaWQoZGV2KTsK
QEAgLTQ2Miw3ICs0NjEsNyBAQCBzdGF0aWMgaW50IHJhZGVvbl9wbW9wc19ydW50aW1lX3N1c3Bl
bmQoc3RydWN0IGRldmljZSAqZGV2KQogCWRybV9kZXYtPnN3aXRjaF9wb3dlcl9zdGF0ZSA9IERS
TV9TV0lUQ0hfUE9XRVJfQ0hBTkdJTkc7CiAJZHJtX2ttc19oZWxwZXJfcG9sbF9kaXNhYmxlKGRy
bV9kZXYpOwogCi0JcmV0ID0gcmFkZW9uX3N1c3BlbmRfa21zKGRybV9kZXYsIGZhbHNlLCBmYWxz
ZSwgZmFsc2UpOworCXJhZGVvbl9zdXNwZW5kX2ttcyhkcm1fZGV2LCBmYWxzZSwgZmFsc2UsIGZh
bHNlKTsKIAlwY2lfc2F2ZV9zdGF0ZShwZGV2KTsKIAlwY2lfZGlzYWJsZV9kZXZpY2UocGRldik7
CiAJcGNpX2lnbm9yZV9ob3RwbHVnKHBkZXYpOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
