Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3213DC433E9
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC3FC65100
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3FC65100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 966FB6E3DB;
	Mon,  8 Mar 2021 13:40:51 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96EF689EBB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 13:40:49 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id x9so14781271edd.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 05:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TjntnK3UGXI0q3xMTfJPKDhpKvMlYNTOaB7pF8KjgyU=;
 b=AxpwN64NlUTSChMYb0H4imagosXZNNCj+5uEKLa1G1Ez45W5TLbcnRgybs8PczmYiB
 yofT7eZRboyzLMfxQZyvXC8OkgdPZeocFYhLUtZDppTGGgNbn194PvRMURfzd2C1nVZG
 rCSJU4GkfZaVxdSvs5ngEmgTn34jFiAr3S3/rHEfDGWlhVukzN9sfksE9stX3OGEomcg
 C3QLhDbOmjNd7Qodya/afPiUr/uzV1/QC+0cB5v765gPpwYTOjfWyeb6sF7y75QR9U/N
 FuwvhKfK+tAqgVrfa6G3K6FUu3dQvLsLUwrikNTaKbtTYUVA5oFsmwD2IQy2raah3Ltm
 orMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TjntnK3UGXI0q3xMTfJPKDhpKvMlYNTOaB7pF8KjgyU=;
 b=ncLWTrOIVKR8ZcQ2+jzmuObsmVGriqV2qOhlKvUVX3zx5fs4SWcPa4Wbl+fuN9nNBK
 lkRbXPFclI4oyt1/TNRaBqOrk4Jjm30nUPrpOL5/EE8eWqi6SpGLy/aihjT7ttByU8Lh
 5ZxE/76ayaCqEAn00kR2ChhcXy1I6KX8gHHIfSoBqq+5uo4r4K/wADwBGOrnghtZ0sgV
 kWM9PmMtVIAOF72qP8pCfsE91o33cIeABJ+yMMX5wOWIXpVP8MfqrtKqdAxqqhgb2Q9j
 U58pqZWVDNxfIVCBOvG4B/SCee1sZAavu2hgpKILCr+Xmmr5xRu1uq0QPdnlS7+pPmo/
 Ds4g==
X-Gm-Message-State: AOAM530QbMPkknh02DFyje3EkN6wTn9zNq1ZiJJ/wMKNDobtFv283uUf
 5TjPqoLRIJqmr6CnXSb70tfAjpsvPdr9mQ==
X-Google-Smtp-Source: ABdhPJyJdCb3C/5Zdqiqru4edXMlxVzlp3ut2wGiucuXzIRz7OPSPuYk98MXTfVjdrz88/nH7F0OIw==
X-Received: by 2002:a05:6402:10c9:: with SMTP id
 p9mr7006940edu.268.1615210848357; 
 Mon, 08 Mar 2021 05:40:48 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f480:31ac:e949:bf58])
 by smtp.gmail.com with ESMTPSA id s18sm6655701ejc.79.2021.03.08.05.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 05:40:48 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Arunpravin.PaneerSelvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu: use new cursor in amdgpu_ttm_io_mem_pfn
Date: Mon,  8 Mar 2021 14:40:40 +0100
Message-Id: <20210308134044.133658-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308134044.133658-1-christian.koenig@amd.com>
References: <20210308134044.133658-1-christian.koenig@amd.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VwYXJhdGUgdGhlIGRybV9tbV9ub2RlIHdhbGtpbmcgZnJvbSB0aGUgYWN0dWFsIGhhbmRsaW5n
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgpBY2tlZC1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+ClRlc3RlZC1ieTogTmly
bW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYyB8IDggKysrLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0
bS5jCmluZGV4IDM2NWQ1NjkzZjVmMC4uNTE3NjExYjcwOWZhIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3R0bS5jCkBAIC02MzEsMTIgKzYzMSwxMCBAQCBzdGF0aWMgdW5zaWdu
ZWQgbG9uZyBhbWRncHVfdHRtX2lvX21lbV9wZm4oc3RydWN0IHR0bV9idWZmZXJfb2JqZWN0ICpi
bywKIAkJCQkJICAgdW5zaWduZWQgbG9uZyBwYWdlX29mZnNldCkKIHsKIAlzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IGFtZGdwdV90dG1fYWRldihiby0+YmRldik7Ci0JdWludDY0X3Qgb2Zm
c2V0ID0gKHBhZ2Vfb2Zmc2V0IDw8IFBBR0VfU0hJRlQpOwotCXN0cnVjdCBkcm1fbW1fbm9kZSAq
bW07CisJc3RydWN0IGFtZGdwdV9yZXNfY3Vyc29yIGN1cnNvcjsKIAotCW1tID0gYW1kZ3B1X2Zp
bmRfbW1fbm9kZSgmYm8tPm1lbSwgJm9mZnNldCk7Ci0Jb2Zmc2V0ICs9IGFkZXYtPmdtYy5hcGVy
X2Jhc2U7Ci0JcmV0dXJuIG1tLT5zdGFydCArIChvZmZzZXQgPj4gUEFHRV9TSElGVCk7CisJYW1k
Z3B1X3Jlc19maXJzdCgmYm8tPm1lbSwgKHU2NClwYWdlX29mZnNldCA8PCBQQUdFX1NISUZULCAw
LCAmY3Vyc29yKTsKKwlyZXR1cm4gKGFkZXYtPmdtYy5hcGVyX2Jhc2UgKyBjdXJzb3Iuc3RhcnQp
ID4+IFBBR0VfU0hJRlQ7CiB9CiAKIC8qKgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
