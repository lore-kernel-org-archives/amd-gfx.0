Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9468C433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:51:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677856101E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 15:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677856101E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06B946EC05;
	Tue, 18 May 2021 15:51:03 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534236EC05
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 15:51:01 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id et19so8283493ejc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 08:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T8sX/mGfnvQh9K8a5jwY02YVt21WrKDOcojIUvvOoME=;
 b=aK0PdwG5LeoadJnjRL20gcgvj9n2htA79xpFtM+/TCvVMPXp0QV1KyOn4VuD9KVsiB
 kK5i19bzpeO/KVx85ApvEUmhzJWZ/CmLUrLawGhk9BUaI1vrr2v5mKnyFRR1Ede9VEVi
 /1PJ3xjeNFbGDHkRVa7gTgFoAIwh7pAZ51fuvB2sFNTpWVvENJXaKXph6GJu+G5VkBiu
 cag1RK0zg5XZH2lqPHAhj7dDof3+sVXGq/bgesO2wwMA1RND+X6fLM+j9zLJbtlOdvzm
 8FhMQrQvwaIBw1tOgqBxqJwmQp7hXO+UHXw0gw3B6WXGlyeN4xXXBuXCQcv5OPUas2h/
 iyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=T8sX/mGfnvQh9K8a5jwY02YVt21WrKDOcojIUvvOoME=;
 b=sDyTQ4H5bOxhU67Nfp10LAwyJMru0wURDwJPuusetYah1nUr9Zcl9Hfxe5Nn8xWl+I
 2nUD70hgiT0fVwS5R8QOuzyEwbIK7bNYmoHTjyJpHhkWL7q86Cel1szrUjS4ELcDCUsC
 6qW/BJ2o6rZ2P6MgRIWjgsIamJuMKrCZRu8d/jqsJmgZmjxeeHLhKPejJqbfhErW47Wk
 ennOIaR0dvrLw8JO5/rb2tDfqtKyyW/Zj3B+a6lJ1scpvXHRSfxrflEYKwcyHXox9HJP
 /ACPuhX/BVjBpMLkuaBjH5k6dBoVlLtUk8V2vlwaDm9HSspA/8tfoX4LDf/MAzzn8XZ8
 EWnw==
X-Gm-Message-State: AOAM532QrGN0V7fAmPCJ2JCG6SxRqIr43PAlzAad5XlfZYI/CB3eB/Cv
 l3DwJZTUYIuQLFZZxaQ4s3w=
X-Google-Smtp-Source: ABdhPJyZn/rWGP63QkMMjQEInDOuefAaB/dOS5JXc0dIEnSTpXv6cHmhCBwowESOcr0gsZHSrprViQ==
X-Received: by 2002:a17:907:2855:: with SMTP id
 el21mr6748357ejc.153.1621353060045; 
 Tue, 18 May 2021 08:51:00 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:38b:3321:5a9d:5235])
 by smtp.gmail.com with ESMTPSA id zg18sm2870439ejb.41.2021.05.18.08.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 May 2021 08:50:59 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: jamesz@amd.com
Subject: [PATCH] drm/amdgpu: stop touching sched.ready in the backend
Date: Tue, 18 May 2021 17:50:58 +0200
Message-Id: <20210518155058.5646-1-christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhpcyB1bmZvcnR1bmF0ZWx5IGNvbWVzIHVwIGluIHJlZ3VsYXIgaW50ZXJ2YWxzIGFuZCBicmVh
a3MKR1BVIHJlc2V0IGZvciB0aGUgZW5naW5lIGluIHF1ZXN0aW9uLgoKVGhlIHNjaGVkLnJlYWR5
IGZsYWcgY29udHJvbHMgaWYgYW4gZW5naW5lIGNhbid0IGdldCB3b3JraW5nCmR1cmluZyBod19p
bml0LCBidXQgc2hvdWxkIG5ldmVyIGJlIHNldCB0byBmYWxzZSBkdXJpbmcgaHdfZmluaS4KClNp
Z25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9qcGVnX3YyXzUuYyB8IDIgLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjNfMC5jIHwgMiAtLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvc2RtYV92NV8yLmMgfCA1IC0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjNfMC5jICB8IDYgLS0tLS0tCiA0IGZpbGVzIGNoYW5nZWQsIDE1IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfNS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml81LmMKaW5kZXggODM1MzE5OTdh
ZWJhLi45MzhlZjRjZTViNzYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2pwZWdfdjJfNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfNS5j
CkBAIC0xOTgsOCArMTk4LDYgQEAgc3RhdGljIGludCBqcGVnX3YyXzVfaHdfZmluaSh2b2lkICpo
YW5kbGUpCiAJCWlmIChhZGV2LT5qcGVnLmN1cl9zdGF0ZSAhPSBBTURfUEdfU1RBVEVfR0FURSAm
JgogCQkgICAgICBSUkVHMzJfU09DMTUoSlBFRywgaSwgbW1VVkRfSlJCQ19TVEFUVVMpKQogCQkJ
anBlZ192Ml81X3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfUEdfU1RBVEVfR0FURSk7
Ci0KLQkJcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKIAl9CiAKIAlyZXR1cm4gMDsKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjNfMC5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvanBlZ192M18wLmMKaW5kZXggZGU1ZGZjZmIzODU5Li45NGJlMzUz
NTdmN2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjNfMC5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjNfMC5jCkBAIC0xNjYsOCAr
MTY2LDYgQEAgc3RhdGljIGludCBqcGVnX3YzXzBfaHdfZmluaSh2b2lkICpoYW5kbGUpCiAJICAg
ICAgUlJFRzMyX1NPQzE1KEpQRUcsIDAsIG1tVVZEX0pSQkNfU1RBVFVTKSkKIAkJanBlZ192M18w
X3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfUEdfU1RBVEVfR0FURSk7CiAKLQlyaW5n
LT5zY2hlZC5yZWFkeSA9IGZhbHNlOwotCiAJcmV0dXJuIDA7CiB9CiAKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvc2RtYV92NV8yLmMKaW5kZXggN2M0ZTA1ODZlMjZkLi4yZDVkMDdjODAzMDcgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCkBAIC00OTcsMTEgKzQ5Nyw2IEBA
IHN0YXRpYyB2b2lkIHNkbWFfdjVfMl9nZnhfc3RvcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIAkJaWJfY250bCA9IFJFR19TRVRfRklFTEQoaWJfY250bCwgU0RNQTBfR0ZYX0lCX0NOVEws
IElCX0VOQUJMRSwgMCk7CiAJCVdSRUczMihzZG1hX3Y1XzJfZ2V0X3JlZ19vZmZzZXQoYWRldiwg
aSwgbW1TRE1BMF9HRlhfSUJfQ05UTCksIGliX2NudGwpOwogCX0KLQotCXNkbWEwLT5zY2hlZC5y
ZWFkeSA9IGZhbHNlOwotCXNkbWExLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwotCXNkbWEyLT5zY2hl
ZC5yZWFkeSA9IGZhbHNlOwotCXNkbWEzLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwogfQogCiAvKioK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jCmluZGV4IGNmMTY1YWI1ZGQyNi4uYjUx
MmFjZjBlOTVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNf
MC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMKQEAgLTM4OCwx
MiArMzg4LDYgQEAgc3RhdGljIGludCB2Y25fdjNfMF9od19maW5pKHZvaWQgKmhhbmRsZSkKIAkJ
CQl2Y25fdjNfMF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgQU1EX1BHX1NUQVRFX0dBVEUp
OwogCQkJfQogCQl9Ci0JCXJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Ci0KLQkJZm9yIChqID0g
MDsgaiA8IGFkZXYtPnZjbi5udW1fZW5jX3JpbmdzOyArK2opIHsKLQkJCXJpbmcgPSAmYWRldi0+
dmNuLmluc3RbaV0ucmluZ19lbmNbal07Ci0JCQlyaW5nLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwot
CQl9CiAJfQogCiAJcmV0dXJuIDA7Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeAo=
