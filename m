Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A76EC43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 21:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BD672464E
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 21:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD672464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA2DF6E9AA;
	Thu,  5 Dec 2019 21:39:19 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993556E9AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 21:39:18 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id l22so1838051ywc.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2019 13:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5rPt0RFmrca8L+9uYwvjJFnnwYleb59gq0uGrMjRc4Q=;
 b=n1GC2KtjoX7wFIPuPZSvewihxJmmO6CU+C+8R0snZLvtOUkCXPRMxxSjS6bJRZwRJ+
 CCoKbQ24Zsw/kPlJnfkzwRw2JcsFC08N0uNDbAEkWp5OmbB4J1S/voYH7GdCC+n17kK9
 Kzl5j02GF2UFctHoUoLFMpEMKrD08cVdMjLRASdG/AW7rKvax04HR/vKB6nvSNcoNg7y
 GzhHypR1yd6h07iIfbJ+4cC9eXX4hP9tkiILSGIYUiIbt7O4hOBwRsvTjH872ejN+oi1
 eCmfE0A7Aes+uN+k16pG20UiP0nOQocqWp0iZTb0DBPKv7skNNsCLb4KEv1FRP8W/o+D
 xFQw==
X-Gm-Message-State: APjAAAVBmwqUZDJ4KNqsjdXaGWM12tbG95x9Op+VcbqkhC5tQSLRLkD4
 MXsEd+voAH+NUSb2JVf7CXQlRuEz
X-Google-Smtp-Source: APXvYqwAWLxq89Z8Q/Cdtd0OlbGFZwy+PHBYv+6mHoUygky1xnXuQ5F5/Skkxa5F2JJDTEyxpoGUYw==
X-Received: by 2002:a81:3c88:: with SMTP id j130mr7422731ywa.113.1575581957412; 
 Thu, 05 Dec 2019 13:39:17 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id y186sm5089922ywe.97.2019.12.05.13.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 13:39:16 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: add fallthrough comment
Date: Thu,  5 Dec 2019 16:39:04 -0500
Message-Id: <20191205213904.278244-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5rPt0RFmrca8L+9uYwvjJFnnwYleb59gq0uGrMjRc4Q=;
 b=JthDu+Q7SmJy/NuCev6yAMJh3UFcV6KtMtRcSw+h+/zfrFhxIcr+CghAiBxhEpkheL
 DgDszu443UmxXGxa/mLrVnQyRRrif8voSSBPTSr3OMKLLVBCDb4FFFJZC0E7b/1afFIZ
 GArL4As4rA56MNHuo+ta/PXWzXB+ZzD+Zd0LyoIIxxbcQY1grhZJYUmKlkpoGMkDfItz
 Q89Rs0F+gez9Z7U0BIY7/XmmmysUvFBLavsayrJPo1I4T13Ntl1xgJJLqqwEawDZFiek
 o20Vc8ZdfBnBZr7Ff+fRDqDYeyrdk3tned5x5mOv7U7I+gHbHj4g3nqUOpIMyD15eIW2
 iF9Q==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VG8gYXZvaWQgYSBjb21waWxlciB3YXJuaW5nLgoKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY2UvZGNlX2F1eC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9h
dXguYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UvZGNlX2F1eC5jCmluZGV4
IDE5MWI2OGI4MTYzYS4uZjFhNWQyYzZhYTM3IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvZGNlL2RjZV9hdXguYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvZGNlL2RjZV9hdXguYwpAQCAtNjQ1LDYgKzY0NSw3IEBAIGJvb2wgZGNlX2F1eF90
cmFuc2Zlcl93aXRoX3JldHJpZXMoc3RydWN0IGRkY19zZXJ2aWNlICpkZGMsCiAJCQljYXNlIEFV
WF9UUkFOU0FDVElPTl9SRVBMWV9BVVhfREVGRVI6CiAJCQljYXNlIEFVWF9UUkFOU0FDVElPTl9S
RVBMWV9JMkNfT1ZFUl9BVVhfREVGRVI6CiAJCQkJcmV0cnlfb25fZGVmZXIgPSB0cnVlOworCQkJ
CS8qIGZhbGwgdGhyb3VnaCAqLwogCQkJY2FzZSBBVVhfVFJBTlNBQ1RJT05fUkVQTFlfSTJDX09W
RVJfQVVYX05BQ0s6CiAJCQkJaWYgKCsrYXV4X2RlZmVyX3JldHJpZXMgPj0gQVVYX01BWF9ERUZF
Ul9SRVRSSUVTKSB7CiAJCQkJCWdvdG8gZmFpbDsKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
