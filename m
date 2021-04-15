Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A865C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 08:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BC716101B
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 08:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC716101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7AB6E9FD;
	Thu, 15 Apr 2021 08:47:35 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735396E51B;
 Thu, 15 Apr 2021 08:47:34 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id g5so28952639ejx.0;
 Thu, 15 Apr 2021 01:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qWlbSSUH0gS3gW5PE2wMFHjxRCzK07uOk5ad6KVFLjc=;
 b=R+CN/vK4Rsx7x0JeF+c4qsrFj/rTMYrFb7FjTEVJluOGu+vGDAZ8fVvoEmUe0vSyf3
 tOSBjwsaVr8feZpHGoF2n0DUpRZwzm/gOQzSQK6i4jCXgy3qAIIw82gOdsxhfq0hBSYz
 UlKlAFsQBJ6KZREdFEzjc1Kqjfe/Pqkrtr/P1hBDpZeuIm8q4uYqdD0d5gqETZ1VSxa/
 WLNt25A0XD76U1vvBFq0aUo+8lF+pA2+ZO3NC2n4GCYvPySqEcR1dCduwxLEjnvL+w9T
 B2e7zR46NUQG9EGTlU7eF3m6N75rToGhyH81/l1S8T8GrDNT7lakcGH9mOjrJOI5KzvO
 LHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qWlbSSUH0gS3gW5PE2wMFHjxRCzK07uOk5ad6KVFLjc=;
 b=KnzjeMBcNpnw6NH2lxlQ6Bwz23hgrN9QBpNUtWNzg5UyQtd9bFYRQIBmjtj67LF/Cd
 WKFU4qNYNIhgNQYUfs0rnVACguIQ+NHA7UxjIdcgH9YEzQ4IZFHySyvEnVTHIg5pDqSz
 UknGuZ2VKXpoi4PRcp7Oj0Ya/qggIHeks1rG9mfVaALu1hXkFdAa4G1+OCcaX1L31CFu
 vjFblvAf3ODfcNdN7Oh/dQiXex6wzAZvk9JVZ2HI59NyJIQeKcCdpX9gDZBL2mWZXVSw
 1JGGt/LxmCZT5wzmBo6EgcvtpNBj+2tyPWMYDg+fNYdw9SGv892vIYifaKop0/vH2ePa
 Hifg==
X-Gm-Message-State: AOAM533LSRD+1LzMoohk4Z+c1QghmwsAyCvQlAvsBtWIlrtXKBrng29E
 BtBt2KjxxWvBBvhE9Bt7csv2XNBkdg4=
X-Google-Smtp-Source: ABdhPJzK4RAojy64vlp2CbaMwtbh37W3to2sqCbEV1LAQ8Ssg/ircSNleUnOF0WvTWGLolyeSIOuOA==
X-Received: by 2002:a17:906:b1d4:: with SMTP id
 bv20mr2344110ejb.46.1618476453206; 
 Thu, 15 Apr 2021 01:47:33 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3ba1:ccd9:cd93:a8ed])
 by smtp.gmail.com with ESMTPSA id a9sm1830049eds.33.2021.04.15.01.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 01:47:32 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/ttm: warn stricter about freeing pinned BOs
Date: Thu, 15 Apr 2021 10:47:30 +0200
Message-Id: <20210415084730.2057-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415084730.2057-1-christian.koenig@amd.com>
References: <20210415084730.2057-1-christian.koenig@amd.com>
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
Cc: daniel@ffwll.ch
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U28gZmFyIHdlIG9ubHkgd2FybmVkIHdoZW4gdGhlIEJPcyB3aGVyZSBwaW5uZWQgYW5kIG5vdCBp
ZGxlLgoKQWxzbyB3YXJuIGlmIHdlIHNlZSBhIHBpbm5lZCBCTyBpbiBnZW5lcmFsLgoKU2lnbmVk
LW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgfCA0ICsrKy0KIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vdHRtL3R0bV9iby5jIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm8uYwppbmRleCBjZmQw
YjkyOTIzOTcuLjgwODMxZGYwZWY2MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fYm8uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCkBAIC00MDEsNiArNDAx
LDggQEAgc3RhdGljIHZvaWQgdHRtX2JvX3JlbGVhc2Uoc3RydWN0IGtyZWYgKmtyZWYpCiAJc3Ry
dWN0IHR0bV9kZXZpY2UgKmJkZXYgPSBiby0+YmRldjsKIAlpbnQgcmV0OwogCisJV0FSTl9PTl9P
TkNFKGJvLT5waW5fY291bnQpOworCiAJaWYgKCFiby0+ZGVsZXRlZCkgewogCQlyZXQgPSB0dG1f
Ym9faW5kaXZpZHVhbGl6ZV9yZXN2KGJvKTsKIAkJaWYgKHJldCkgewpAQCAtNDM0LDcgKzQzNiw3
IEBAIHN0YXRpYyB2b2lkIHR0bV9ib19yZWxlYXNlKHN0cnVjdCBrcmVmICprcmVmKQogCQkgKiBG
SVhNRTogUVhMIGlzIHRyaWdnZXJpbmcgdGhpcy4gQ2FuIGJlIHJlbW92ZWQgd2hlbiB0aGUKIAkJ
ICogZHJpdmVyIGlzIGZpeGVkLgogCQkgKi8KLQkJaWYgKFdBUk5fT05fT05DRShiby0+cGluX2Nv
dW50KSkgeworCQlpZiAoYm8tPnBpbl9jb3VudCkgewogCQkJYm8tPnBpbl9jb3VudCA9IDA7CiAJ
CQl0dG1fYm9fbW92ZV90b19scnVfdGFpbChibywgJmJvLT5tZW0sIE5VTEwpOwogCQl9Ci0tIAoy
LjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
