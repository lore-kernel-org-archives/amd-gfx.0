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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9793C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C5CB65100
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5CB65100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA036E3D8;
	Mon,  8 Mar 2021 13:40:53 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FDBD6E3D8
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 13:40:51 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id r17so20421220ejy.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 05:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=mvHXsuUkJI4KYoHSKlNpTC8xVEvwFLY1tCdvwdkVCxw=;
 b=Xl+otjY1Yxl23K/fCAheQp9wA4XB8aMb/SAfS2Q6ZkmolbAZJjnSOY7AhkmJAW/a9F
 Yv9AJMqWap7mKCHC28rcW2jvSQZww4fItscyZAqjaH4L4vFohnQXguL/7I2U7A1aqKlp
 b+CJxXHXq/AJpsuL3J7HsTROZVZ0RmL+mOMTNVLn1/yCR73jUULxOKzx2DcBi5x+pIZh
 XqcT3LWiNott0NVTAy/YPz6Se0le4kIoJ5bWlh73ly1wN4Xb1iXr55YAMo09ln3BLuY8
 aFstFg2v4ArjYeQvjkAgArg2BIp0AvqIHgzE1L4nZE+Sr5M0Sl6Wz3baMZKnMfjFc9DI
 xDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mvHXsuUkJI4KYoHSKlNpTC8xVEvwFLY1tCdvwdkVCxw=;
 b=OjM7NpXWoI2Is1yVjFOsf9pJl7MDDuEvEmoQY78UMrsveWgKfD/qg/E5owMqdRhcD2
 mNd3tda0bvPe8Fcw5OjSok6gP0ARHeG9d8o4ITbGYuYTXanOmW/F2TyxeXOCm6SeDmAb
 ElleWzgp6hHSUE18o2TJtJlioFz8017R2E5hyKuJYEcpamuXTeE0yxN0nRTk5s7g/WB3
 mvgGUC0h8AHzmvZqqkDiWzdfxf56xNLlnqA4xDFdbN8pS0VFl2gRV43nrbJ6iVOe9H5Z
 TpsH96dRjsaCqJaPXKYVqyUDVW5olr8HtyBX9Sj1V87gunY+Tojdxh/BuyvAvimCaefZ
 Q1cw==
X-Gm-Message-State: AOAM533IrGk7CDeys0XA4Gu8shEEIjOrvQDD8EjjpYlI7StET0FnMDtX
 i68M01/QvQLqUDhivN2zcuS1L59MysU/0w==
X-Google-Smtp-Source: ABdhPJznesr1+DIGhlrtsNLFBdDUG8cvpK2TZ5VzdvEWMw5OurR5VBLUR3VX0SfKQUkXDdi+H9/SRA==
X-Received: by 2002:a17:906:9714:: with SMTP id
 k20mr15002569ejx.519.1615210850300; 
 Mon, 08 Mar 2021 05:40:50 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f480:31ac:e949:bf58])
 by smtp.gmail.com with ESMTPSA id s18sm6655701ejc.79.2021.03.08.05.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 05:40:49 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Arunpravin.PaneerSelvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/8] drm/amdgpu: use the new cursor in
 amdgpu_ttm_bo_eviction_valuable
Date: Mon,  8 Mar 2021 14:40:43 +0100
Message-Id: <20210308134044.133658-7-christian.koenig@amd.com>
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
Z3B1L2FtZGdwdV90dG0uYyB8IDE0ICsrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV90dG0uYwppbmRleCBkNDY5YmE1ZmVmMmMuLjVkODhkMTg1MDc4MSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwpAQCAtMTM5OCw3ICsxMzk4LDcgQEAgc3RhdGlj
IGJvb2wgYW1kZ3B1X3R0bV9ib19ldmljdGlvbl92YWx1YWJsZShzdHJ1Y3QgdHRtX2J1ZmZlcl9v
YmplY3QgKmJvLAogCQkJCQkgICAgY29uc3Qgc3RydWN0IHR0bV9wbGFjZSAqcGxhY2UpCiB7CiAJ
dW5zaWduZWQgbG9uZyBudW1fcGFnZXMgPSBiby0+bWVtLm51bV9wYWdlczsKLQlzdHJ1Y3QgZHJt
X21tX25vZGUgKm5vZGUgPSBiby0+bWVtLm1tX25vZGU7CisJc3RydWN0IGFtZGdwdV9yZXNfY3Vy
c29yIGN1cnNvcjsKIAlzdHJ1Y3QgZG1hX3Jlc3ZfbGlzdCAqZmxpc3Q7CiAJc3RydWN0IGRtYV9m
ZW5jZSAqZjsKIAlpbnQgaTsKQEAgLTE0MzAsMTMgKzE0MzAsMTUgQEAgc3RhdGljIGJvb2wgYW1k
Z3B1X3R0bV9ib19ldmljdGlvbl92YWx1YWJsZShzdHJ1Y3QgdHRtX2J1ZmZlcl9vYmplY3QgKmJv
LAogCiAJY2FzZSBUVE1fUExfVlJBTToKIAkJLyogQ2hlY2sgZWFjaCBkcm0gTU0gbm9kZSBpbmRp
dmlkdWFsbHkgKi8KLQkJd2hpbGUgKG51bV9wYWdlcykgewotCQkJaWYgKHBsYWNlLT5mcGZuIDwg
KG5vZGUtPnN0YXJ0ICsgbm9kZS0+c2l6ZSkgJiYKLQkJCSAgICAhKHBsYWNlLT5scGZuICYmIHBs
YWNlLT5scGZuIDw9IG5vZGUtPnN0YXJ0KSkKKwkJYW1kZ3B1X3Jlc19maXJzdCgmYm8tPm1lbSwg
MCwgKHU2NCludW1fcGFnZXMgPDwgUEFHRV9TSElGVCwKKwkJCQkgJmN1cnNvcik7CisJCXdoaWxl
IChjdXJzb3IucmVtYWluaW5nKSB7CisJCQlpZiAocGxhY2UtPmZwZm4gPCBQRk5fRE9XTihjdXJz
b3Iuc3RhcnQgKyBjdXJzb3Iuc2l6ZSkKKwkJCSAgICAmJiAhKHBsYWNlLT5scGZuICYmCisJCQkJ
IHBsYWNlLT5scGZuIDw9IFBGTl9ET1dOKGN1cnNvci5zdGFydCkpKQogCQkJCXJldHVybiB0cnVl
OwogCi0JCQludW1fcGFnZXMgLT0gbm9kZS0+c2l6ZTsKLQkJCSsrbm9kZTsKKwkJCWFtZGdwdV9y
ZXNfbmV4dCgmY3Vyc29yLCBjdXJzb3Iuc2l6ZSk7CiAJCX0KIAkJcmV0dXJuIGZhbHNlOwogCi0t
IAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
