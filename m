Return-Path: <SRS0=mZ+C=IR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE219C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC5764EF6
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Mar 2021 14:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC5764EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E605E6EA08;
	Fri, 19 Mar 2021 14:09:01 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C470A6E056;
 Fri, 19 Mar 2021 14:09:00 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id w3so9928408ejc.4;
 Fri, 19 Mar 2021 07:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FH8/yKesFGyyRWjF6/nAIOhxZFQ+dMwT4llcZbOYxeE=;
 b=XRFQnMrCfCGvpKMIK3D9Djl0PLFe2e00//anag9FB8Fi0McXX+zphVoJkk+hH6T1j0
 nif+hsRGEN9C0u0nCZW36tQ6vD79MeFdU7QbS4V36G8stsdi46pHjc/ejIguyJ3CW3P8
 aP3vmsAi2EpwZOkVkSNRloa90UoT+1BtIPeNIVUKSDJMtl9i6A8kUlFI1hwL3hWKnijc
 oUBAYZf1oTd27YJY2n1k87ZB9Qoxy4tWmFyxHGldIridl52qk3wQQ+n6Pbp8mc+NBUzj
 hXvLiXNdJFkiJj5tX9kIXXd3Uk9WTHdsvGYnRNBxJpK8iYiq+sQ3HOBR18A8XPQU0LjA
 oXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FH8/yKesFGyyRWjF6/nAIOhxZFQ+dMwT4llcZbOYxeE=;
 b=Nkn24jj3uU3/Pd9amhzk6iKPdz3SPuF9t12JE3UqLjz1ciUmpcVM3qaoYdjLagK+On
 /gO/II3Y9h+p8gfneMHQpTfn7Gx2zfuifAPmfwU2znbjWQNGSu4cA23r57KNaAFYymxc
 BYETe6A8X6MBmCXKxcOfaIBmgXMSgs3crld7SUExgZTG+z8AYmUZlbuSsxFjyDygmGt7
 ADPwDJUEEvU+Z/PvQwsM/wMctNfD6ezRQ3sybZhCSHFKIiCGAzmKswuUDp3bXR6JVX9S
 zK9ePAeA3voXV0UM0+ggTXfoGK2negXUwlfN5KBTzXNo2X53HyR6fxt2O3iO8EX+00nj
 4bXA==
X-Gm-Message-State: AOAM532D1IxS4gX1+1QjBwdJpR+etRxqjTAqLXLCg1xHbO3dbnup5vlo
 QAnNkLIQhnVuwWA7UGNkvvQ=
X-Google-Smtp-Source: ABdhPJyoad26ECtNCvcuhKXJt+Q8AKFg1C1fsPZgpud2lfpiR+JYku5B6NZ4VpeDBxbPGdIXHMZb8A==
X-Received: by 2002:a17:906:2314:: with SMTP id
 l20mr4671790eja.178.1616162939562; 
 Fri, 19 Mar 2021 07:08:59 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:77d0:99b3:2f05:2304])
 by smtp.gmail.com with ESMTPSA id y12sm3797214ejb.104.2021.03.19.07.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Mar 2021 07:08:58 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Leo.Liu@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ttm: stop warning on TT shrinker failure
Date: Fri, 19 Mar 2021 15:08:57 +0100
Message-Id: <20210319140857.2262-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

RG9uJ3QgcHJpbnQgYSB3YXJuaW5nIHdoZW4gd2UgZmFpbCB0byBhbGxvY2F0ZSBhIHBhZ2UgZm9y
IHN3YXBwaW5nIHRoaW5ncyBvdXQuCgpBbHNvIHJlbHkgb24gbWVtYWxsb2Nfbm9mc19zYXZlL21l
bWFsbG9jX25vZnNfcmVzdG9yZSBpbnN0ZWFkIG9mIEdGUF9OT0ZTLgoKU2lnbmVkLW9mZi1ieTog
Q2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMv
Z3B1L2RybS90dG0vdHRtX3R0LmMgfCA1ICsrKystCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fdHQuYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMKaW5kZXggMmYwODMzYzk4ZDJj
Li44NmZhM2U4MmRhY2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fdHQuYwpAQCAtMzY5LDcgKzM2OSw3IEBAIHN0
YXRpYyB1bnNpZ25lZCBsb25nIHR0bV90dF9zaHJpbmtlcl9zY2FuKHN0cnVjdCBzaHJpbmtlciAq
c2hyaW5rLAogCX07CiAJaW50IHJldDsKIAotCXJldCA9IHR0bV9ib19zd2Fwb3V0KCZjdHgsIEdG
UF9OT0ZTKTsKKwlyZXQgPSB0dG1fYm9fc3dhcG91dCgmY3R4LCBHRlBfS0VSTkVMIHwgX19HRlBf
Tk9XQVJOKTsKIAlyZXR1cm4gcmV0IDwgMCA/IFNIUklOS19FTVBUWSA6IHJldDsKIH0KIApAQCAt
Mzg5LDEwICszODksMTMgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgdHRtX3R0X3Nocmlua2VyX2Nv
dW50KHN0cnVjdCBzaHJpbmtlciAqc2hyaW5rLAogc3RhdGljIGludCB0dG1fdHRfZGVidWdmc19z
aHJpbmtfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKmRhdGEpCiB7CiAJc3RydWN0IHNo
cmlua19jb250cm9sIHNjID0geyAuZ2ZwX21hc2sgPSBHRlBfS0VSTkVMIH07CisJdW5zaWduZWQg
aW50IGZsYWdzOwogCiAJZnNfcmVjbGFpbV9hY3F1aXJlKEdGUF9LRVJORUwpOworCWZsYWdzID0g
bWVtYWxsb2Nfbm9mc19zYXZlKCk7CiAJc2VxX3ByaW50ZihtLCAiJWx1LyVsdVxuIiwgdHRtX3R0
X3Nocmlua2VyX2NvdW50KCZtbV9zaHJpbmtlciwgJnNjKSwKIAkJICAgdHRtX3R0X3Nocmlua2Vy
X3NjYW4oJm1tX3Nocmlua2VyLCAmc2MpKTsKKwltZW1hbGxvY19ub2ZzX3Jlc3RvcmUoZmxhZ3Mp
OwogCWZzX3JlY2xhaW1fcmVsZWFzZShHRlBfS0VSTkVMKTsKIAogCXJldHVybiAwOwotLSAKMi4y
NS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
