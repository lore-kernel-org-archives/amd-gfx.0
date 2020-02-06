Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0629CC33CAC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 14:31:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1CE521741
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 14:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwFIy4QE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1CE521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF486FA71;
	Thu,  6 Feb 2020 14:30:57 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D2E6EA89
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 14:30:56 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id q9so185685wmj.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Feb 2020 06:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=oGsc+fmyCnwUgikLXe2AxF8R9iZlQuOoQ5vKACRcLEg=;
 b=IwFIy4QEuQQ9j0StYn+GpQo3SubAVfwld4LLcR6FKrelcslrH/b3nf1CCDXSQzNnkd
 g+UEBczl+qCKNUOLALqQ1HaUMpMsZDRQVQXPQGKoYrZM0PsrOqcXSMqb/Gk78olUDzuQ
 91M/mPchvR8bO0tXoSWPJaCxa3E1ExykBMkWmwqQ7Kg0YuRh0jfDTBI9lzsHKWYA1Q2E
 /0SsKdebSqMsUvc2H5Tfo6mOE82lh6e2yXT2cbW4OTfVzjmVNyzBtvA7dPPXorA7hIUD
 dWDRSrAjz0N62dmDyslbDku80pdLV8xjEWBajR1gplYasky786a5ENpwif9nLL9tZomB
 EQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oGsc+fmyCnwUgikLXe2AxF8R9iZlQuOoQ5vKACRcLEg=;
 b=b/xACKy5FqlFdSF0pL6I5OQVwxTGqfSKFPpFLDy1oiofBeHzwysBfTzHrB7bu6Hpzs
 jj8WzD2/PtZKg27RB5i7ingH0YmEr6fPO3PSMxt4d1eB+1fbIvgfKKGeyKjLDenNuDqS
 3t6+4SwikkE9eOdnYdAAR1cXXBWZZ11k6bcUazv4pt07qaRfaqTkNnrTXLRuwskBfJyS
 QuNBGLZYBuWvTQz9oWCV26/z+ctZUPtxTJ7c/kOq0guiNBWAugVkgU1HETnyFtV4UpRB
 pgd8T3znLhXxzi5DaXeyjkfthnQ+gHjMWUkAekakMtlODhfwElOzxRP7K4ic+FdC+1ZS
 fGoA==
X-Gm-Message-State: APjAAAWO3Vc5HkvhlApf8nRrfjNpIPoM0aFnNmkGX1WCX+0hY1S1ZIwP
 JsZXXnxWdIAalxymdixokglmVsT0
X-Google-Smtp-Source: APXvYqzM60cRGUdJmgKBl/BiG7Ve8pl7L2YwHIBsdxVZKxsMFRfywsq7m25Aw8APrxc72Gkew5aDVg==
X-Received: by 2002:a05:600c:2290:: with SMTP id
 16mr4619978wmf.184.1580999454410; 
 Thu, 06 Feb 2020 06:30:54 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:28f7:e4aa:841b:b35])
 by smtp.gmail.com with ESMTPSA id a198sm3878344wme.12.2020.02.06.06.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 06:30:54 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, Jonathan.Kim@amd.com
Subject: [PATCH 3/4] drm/amdgpu: use amdgpu_device_vram_access in
 amdgpu_ttm_vram_read
Date: Thu,  6 Feb 2020 15:30:50 +0100
Message-Id: <20200206143051.25809-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206143051.25809-1-christian.koenig@amd.com>
References: <20200206143051.25809-1-christian.koenig@amd.com>
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

VGhpcyBzcGVlZHMgdXAgdGhlIGFjY2VzcyBxdWl0ZSBhIGJpdCBmcm9tIDIuMiBNQi9zIHRvCjIu
OSBNQi9zIG9uIDMyYml0IGFuZCAxMiw4IE1CL3Mgb24gNjRiaXQuCgpTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+ClJldmlld2VkLWJ5OiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkFja2VkLWJ5OiBKb25hdGhh
biBLaW0gPEpvbmF0aGFuLktpbUBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYyB8IDI3ICsrKysrKysrKystLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKaW5kZXggYWUxYjAwZGVmNWQ4Li41OGQxNDNiMjRiYTAg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKQEAgLTU5LDYgKzU5LDgg
QEAKICNpbmNsdWRlICJhbWRncHVfcmFzLmgiCiAjaW5jbHVkZSAiYmlmL2JpZl80XzFfZC5oIgog
CisjZGVmaW5lIEFNREdQVV9UVE1fVlJBTV9NQVhfRFdfUkVBRAkoc2l6ZV90KTEyOAorCiBzdGF0
aWMgaW50IGFtZGdwdV9tYXBfYnVmZmVyKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCiAJ
CQkgICAgIHN0cnVjdCB0dG1fbWVtX3JlZyAqbWVtLCB1bnNpZ25lZCBudW1fcGFnZXMsCiAJCQkg
ICAgIHVpbnQ2NF90IG9mZnNldCwgdW5zaWduZWQgd2luZG93LApAQCAtMjI1NSwyNyArMjI1Nywy
MCBAQCBzdGF0aWMgc3NpemVfdCBhbWRncHVfdHRtX3ZyYW1fcmVhZChzdHJ1Y3QgZmlsZSAqZiwg
Y2hhciBfX3VzZXIgKmJ1ZiwKIAlpZiAoKnBvcyA+PSBhZGV2LT5nbWMubWNfdnJhbV9zaXplKQog
CQlyZXR1cm4gLUVOWElPOwogCisJc2l6ZSA9IG1pbihzaXplLCAoc2l6ZV90KShhZGV2LT5nbWMu
bWNfdnJhbV9zaXplIC0gKnBvcykpOwogCXdoaWxlIChzaXplKSB7Ci0JCXVuc2lnbmVkIGxvbmcg
ZmxhZ3M7Ci0JCXVpbnQzMl90IHZhbHVlOwotCi0JCWlmICgqcG9zID49IGFkZXYtPmdtYy5tY192
cmFtX3NpemUpCi0JCQlyZXR1cm4gcmVzdWx0OwotCi0JCXNwaW5fbG9ja19pcnFzYXZlKCZhZGV2
LT5tbWlvX2lkeF9sb2NrLCBmbGFncyk7Ci0JCVdSRUczMl9OT19LSVEobW1NTV9JTkRFWCwgKCh1
aW50MzJfdCkqcG9zKSB8IDB4ODAwMDAwMDApOwotCQlXUkVHMzJfTk9fS0lRKG1tTU1fSU5ERVhf
SEksICpwb3MgPj4gMzEpOwotCQl2YWx1ZSA9IFJSRUczMl9OT19LSVEobW1NTV9EQVRBKTsKLQkJ
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYWRldi0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOworCQlz
aXplX3QgYnl0ZXMgPSBtaW4oc2l6ZSwgQU1ER1BVX1RUTV9WUkFNX01BWF9EV19SRUFEICogNCk7
CisJCXVpbnQzMl90IHZhbHVlW0FNREdQVV9UVE1fVlJBTV9NQVhfRFdfUkVBRF07CiAKLQkJciA9
IHB1dF91c2VyKHZhbHVlLCAodWludDMyX3QgKilidWYpOworCQlhbWRncHVfZGV2aWNlX3ZyYW1f
YWNjZXNzKGFkZXYsICpwb3MsIHZhbHVlLCBieXRlcywgZmFsc2UpOworCQlyID0gY29weV90b191
c2VyKGJ1ZiwgdmFsdWUsIGJ5dGVzKTsKIAkJaWYgKHIpCiAJCQlyZXR1cm4gcjsKIAotCQlyZXN1
bHQgKz0gNDsKLQkJYnVmICs9IDQ7Ci0JCSpwb3MgKz0gNDsKLQkJc2l6ZSAtPSA0OworCQlyZXN1
bHQgKz0gYnl0ZXM7CisJCWJ1ZiArPSBieXRlczsKKwkJKnBvcyArPSBieXRlczsKKwkJc2l6ZSAt
PSBieXRlczsKIAl9CiAKIAlyZXR1cm4gcmVzdWx0OwotLSAKMi4xNy4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
