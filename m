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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986B9C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 18:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9E66518A
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 18:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9E66518A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52116E84D;
	Mon,  8 Mar 2021 18:36:48 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 116016E83A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 18:36:47 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id d13so16270874edp.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 10:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/kgNvHnKDOz9UHrWVxfjmrMyfWmMHb0dI7wpi/PbAFM=;
 b=ak1kviKo0qDxxZDKKVy5A6Rhts0N5IPnxoga4b6VHOPIiNEkwwz6JEjx1le65sMm5C
 epnSS8LZvlTfdPHCt1xPDWTMJJLoFBou0TWNl0eD5pSiLif/+hlyaw0rJOSma/e5bSgc
 FpUwiZiZty6QiLmcV/ZtD9Een16wh2nNTOJkR2QmgZf3u15Av+R+KuHBq6xUa740XFPC
 YDb/1V0gZ11zVLAnqnHYxPTF7hUkpBUYP2r5EVQM5C66XV95VIh7ASBJ6GUDDY+hJqw5
 Jd/3VoOBxVgh90sJIE7ovtLljWiAME8cZuEHIXMMjC+jq1TPoL8sJxopm3Lun7FAKSGX
 uaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/kgNvHnKDOz9UHrWVxfjmrMyfWmMHb0dI7wpi/PbAFM=;
 b=I06LrThPG8CsVCZIGjxyEawsxNc8+plp7o5825P+3w74oiDc18qmMFhJHfwpsDoRj0
 ZWsFBLBxk6GBgprl+OXLWplqdvOh9dIY2CALyfQZ7zFndYlwrE6zS6gMVUzEM7xlJz+7
 gEn6Oo4/JWZqkluN2KrlKOdMPcfFyx/ycWxM5mLLBo8Ge4YsX9wKIEXtV6om/hrc/7dr
 4p5w25leOw/3F3tj0AdmW9MmUvvJ3OkbRxTeEByHxBTcFAgyMik7HukYP77GTJxkdEN2
 nCbgR56h7lkbRv7T6aSPNJ96ji0Er8R2q5fFoMKbqfzY3XqLqmAE9ujkvwgYHA1QP5vF
 kRQg==
X-Gm-Message-State: AOAM532d0p/5dL5F5XXysAPDGJ/QSJwahVNU5Y0U3FEjyojVcg2Zlmql
 iPG8cH2fBWK6S60fxp9FjbJ7I0wro828rQ==
X-Google-Smtp-Source: ABdhPJxDRjZhYFvK93qDaeZZ9GAC1eKajMe+5rl8APSq0tS8HNnO3ZfMDA7D0IEOuqHYCvZ80dUJlw==
X-Received: by 2002:aa7:dd99:: with SMTP id g25mr23060245edv.230.1615228605804; 
 Mon, 08 Mar 2021 10:36:45 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:5f05:a903:d4af:1240])
 by smtp.gmail.com with ESMTPSA id n16sm6972029ejy.35.2021.03.08.10.36.45
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 10:36:45 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/radeon: keep __user during cast
Date: Mon,  8 Mar 2021 19:36:43 +0100
Message-Id: <20210308183643.36710-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308183643.36710-1-christian.koenig@amd.com>
References: <20210308183643.36710-1-christian.koenig@amd.com>
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

U2lsZW5jZSBzdGF0aWMgY2hlY2tlciB3YXJuaW5nLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9y
YWRlb24vcmFkZW9uX3R0bS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRl
b25fdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0uYwppbmRleCA1ZWE2
NDdmNDU0ZDMuLjgwODk0MWUzMWQzNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVv
bi9yYWRlb25fdHRtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fdHRtLmMK
QEAgLTkyMSw3ICs5MjEsNyBAQCBzdGF0aWMgc3NpemVfdCByYWRlb25fdHRtX3ZyYW1fcmVhZChz
dHJ1Y3QgZmlsZSAqZiwgY2hhciBfX3VzZXIgKmJ1ZiwKIAkJdmFsdWUgPSBSUkVHMzIoUkFERU9O
X01NX0RBVEEpOwogCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZyZGV2LT5tbWlvX2lkeF9sb2Nr
LCBmbGFncyk7CiAKLQkJciA9IHB1dF91c2VyKHZhbHVlLCAodWludDMyX3QgKilidWYpOworCQly
ID0gcHV0X3VzZXIodmFsdWUsICh1aW50MzJfdCBfX3VzZXIgKilidWYpOwogCQlpZiAocikKIAkJ
CXJldHVybiByOwogCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
