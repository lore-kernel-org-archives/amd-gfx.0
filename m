Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D848EC388F7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7503622243
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 13:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7nk7r//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7503622243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 184796ECAC;
	Tue,  3 Nov 2020 13:58:44 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263E26ECAC
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 13:58:42 +0000 (UTC)
Received: by mail-ej1-x642.google.com with SMTP id k3so24174313ejj.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2020 05:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=OKDpIcl9fqcRY6i09WuR7uCU7jIsyEkrkJOSLbD5NaI=;
 b=R7nk7r//9ftf4NKLrYpx9E6LcW+XW6Gdh0j2bcjUmXA1zUgnUunCJkaZ4I9K5Fjt2U
 WW+M16KQAMJ7LSNfiPvje/2T4rY5FIumg5ZtovfqqRyXAriLQHdcykEtt3Rg5y6FqOiD
 o5z4fThP82IWYr6uTV2BemNPnqIJ2mPUezGID80xUqWAAdVxBvrGih/vAb0VLulP7Wif
 1tn4zvzLZTPzZDVtQVSiFWv0dmtoGOb2gwBYTZ1/bcQFcUT2h7AUiGiThBOVkvIs9J3z
 U2tRA0MK4Y7KLInGnB6jEVeae5WJDv+sMrjHA0yGmxG1Cd7M8DJWZ37yhqKjcWLMHkJX
 TPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OKDpIcl9fqcRY6i09WuR7uCU7jIsyEkrkJOSLbD5NaI=;
 b=lhUNfTSj4agEtpmnCGJnXhgfkBnXhAWvbRARzpLHQS20qtw5lECoUmx8kSWzxaUOFX
 IeGfcLL0+YImuYnut4vxNI7UgkgdwZrVfHxNpv4VvaC2ERu9FkPdK/6G65sZbKMGTcrJ
 bheImnupkRyNQRN7zC0shgEYNQXZTIhxSnx8IH/Kla2E6DQsVBs32Q4z/H+VV/G3ZpRw
 3iMp6s6Mk0mP8ZDpeCEiZ5BjgOXYBBKGTFCik/q8kr34+OcjmHU9PJAT5f9chZ1IuGxk
 2YHOH5Yxv6IndRghLkZX5wWcqLXbRx3PIcygGUp49UgkigZ1fkwQfeesqdzGS7+j6C2t
 0FpA==
X-Gm-Message-State: AOAM530Y9Y9gznZhSYw+ZR9b6KSR0YqXImLoTyQFtTS/5h6L+h9/du3h
 S0/iXI4k0+oV8Z1vt0CBRQSMJZEqfjE=
X-Google-Smtp-Source: ABdhPJzGoQi03YXwmY9M9OzRNSfYLPVW9bHYRnidMtx9pET/R46E/aODJuHmcjmWeYKNUVEkx20Q8w==
X-Received: by 2002:a17:906:5402:: with SMTP id
 q2mr19764683ejo.316.1604411920498; 
 Tue, 03 Nov 2020 05:58:40 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f3a2:b920:33f3:da11])
 by smtp.gmail.com with ESMTPSA id j6sm7903263edy.87.2020.11.03.05.58.39
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 05:58:40 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: cleanup gmc_v10_0_process_interrupt a bit
Date: Tue,  3 Nov 2020 14:58:32 +0100
Message-Id: <20201103135837.39693-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103135837.39693-1-christian.koenig@amd.com>
References: <20201103135837.39693-1-christian.koenig@amd.com>
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

UmV0dXJuIGVhcmx5IGluIGNhc2Ugb2YgYSByYXRlbGltaXQgYW5kIGRvbid0IHByaW50IGxlYWRp
bmcgemVyb3MgZm9yCnRoZSBhZGRyZXNzLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2dtY192MTBfMC5jIHwgMzggKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2dtY192MTBfMC5jCmluZGV4IGQ5Mzk5MzI0YmU0Ny4uY2ZmYzNjYThmY2RlIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjEwXzAuYwpAQCAtOTUsNiArOTUsNyBAQCBz
dGF0aWMgaW50IGdtY192MTBfMF9wcm9jZXNzX2ludGVycnVwdChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqYWRldiwKIAkJCQkgICAgICAgc3RydWN0IGFtZGdwdV9pdl9lbnRyeSAqZW50cnkpCiB7CiAJ
c3RydWN0IGFtZGdwdV92bWh1YiAqaHViID0gJmFkZXYtPnZtaHViW2VudHJ5LT52bWlkX3NyY107
CisJc3RydWN0IGFtZGdwdV90YXNrX2luZm8gdGFza19pbmZvOwogCXVpbnQzMl90IHN0YXR1cyA9
IDA7CiAJdTY0IGFkZHI7CiAKQEAgLTExNSwyNCArMTE2LDI1IEBAIHN0YXRpYyBpbnQgZ21jX3Yx
MF8wX3Byb2Nlc3NfaW50ZXJydXB0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQlXUkVH
MzJfUChodWItPnZtX2wyX3Byb19mYXVsdF9jbnRsLCAxLCB+MSk7CiAJfQogCi0JaWYgKHByaW50
a19yYXRlbGltaXQoKSkgewotCQlzdHJ1Y3QgYW1kZ3B1X3Rhc2tfaW5mbyB0YXNrX2luZm87Ci0K
LQkJbWVtc2V0KCZ0YXNrX2luZm8sIDAsIHNpemVvZihzdHJ1Y3QgYW1kZ3B1X3Rhc2tfaW5mbykp
OwotCQlhbWRncHVfdm1fZ2V0X3Rhc2tfaW5mbyhhZGV2LCBlbnRyeS0+cGFzaWQsICZ0YXNrX2lu
Zm8pOwotCi0JCWRldl9lcnIoYWRldi0+ZGV2LAotCQkJIlslc10gcGFnZSBmYXVsdCAoc3JjX2lk
OiV1IHJpbmc6JXUgdm1pZDoldSBwYXNpZDoldSwgIgotCQkJImZvciBwcm9jZXNzICVzIHBpZCAl
ZCB0aHJlYWQgJXMgcGlkICVkKVxuIiwKLQkJCWVudHJ5LT52bWlkX3NyYyA/ICJtbWh1YiIgOiAi
Z2Z4aHViIiwKLQkJCWVudHJ5LT5zcmNfaWQsIGVudHJ5LT5yaW5nX2lkLCBlbnRyeS0+dm1pZCwK
LQkJCWVudHJ5LT5wYXNpZCwgdGFza19pbmZvLnByb2Nlc3NfbmFtZSwgdGFza19pbmZvLnRnaWQs
Ci0JCQl0YXNrX2luZm8udGFza19uYW1lLCB0YXNrX2luZm8ucGlkKTsKLQkJZGV2X2VycihhZGV2
LT5kZXYsICIgIGluIHBhZ2Ugc3RhcnRpbmcgYXQgYWRkcmVzcyAweCUwMTZsbHggZnJvbSBjbGll
bnQgJWRcbiIsCi0JCQlhZGRyLCBlbnRyeS0+Y2xpZW50X2lkKTsKLQkJaWYgKCFhbWRncHVfc3Jp
b3ZfdmYoYWRldikpCi0JCQlodWItPnZtaHViX2Z1bmNzLT5wcmludF9sMl9wcm90ZWN0aW9uX2Zh
dWx0X3N0YXR1cyhhZGV2LCBzdGF0dXMpOwotCX0KKwlpZiAoIXByaW50a19yYXRlbGltaXQoKSkK
KwkJcmV0dXJuIDA7CisKKwltZW1zZXQoJnRhc2tfaW5mbywgMCwgc2l6ZW9mKHN0cnVjdCBhbWRn
cHVfdGFza19pbmZvKSk7CisJYW1kZ3B1X3ZtX2dldF90YXNrX2luZm8oYWRldiwgZW50cnktPnBh
c2lkLCAmdGFza19pbmZvKTsKKworCWRldl9lcnIoYWRldi0+ZGV2LAorCQkiWyVzXSBwYWdlIGZh
dWx0IChzcmNfaWQ6JXUgcmluZzoldSB2bWlkOiV1IHBhc2lkOiV1LCAiCisJCSJmb3IgcHJvY2Vz
cyAlcyBwaWQgJWQgdGhyZWFkICVzIHBpZCAlZClcbiIsCisJCWVudHJ5LT52bWlkX3NyYyA/ICJt
bWh1YiIgOiAiZ2Z4aHViIiwKKwkJZW50cnktPnNyY19pZCwgZW50cnktPnJpbmdfaWQsIGVudHJ5
LT52bWlkLAorCQllbnRyeS0+cGFzaWQsIHRhc2tfaW5mby5wcm9jZXNzX25hbWUsIHRhc2tfaW5m
by50Z2lkLAorCQl0YXNrX2luZm8udGFza19uYW1lLCB0YXNrX2luZm8ucGlkKTsKKwlkZXZfZXJy
KGFkZXYtPmRldiwgIiAgaW4gcGFnZSBzdGFydGluZyBhdCBhZGRyZXNzIDB4JTAxMmxseCBmcm9t
IGNsaWVudCAlZFxuIiwKKwkJYWRkciwgZW50cnktPmNsaWVudF9pZCk7CisKKwlpZiAoIWFtZGdw
dV9zcmlvdl92ZihhZGV2KSkKKwkJaHViLT52bWh1Yl9mdW5jcy0+cHJpbnRfbDJfcHJvdGVjdGlv
bl9mYXVsdF9zdGF0dXMoYWRldiwKKwkJCQkJCQkJICAgc3RhdHVzKTsKIAogCXJldHVybiAwOwog
fQotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
