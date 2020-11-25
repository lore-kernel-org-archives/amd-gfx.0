Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168ADC5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 14:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9147A2076B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 14:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4VR513G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9147A2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD9CC6E9C1;
	Wed, 25 Nov 2020 14:34:28 +0000 (UTC)
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com
 [IPv6:2a00:1450:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A12388249;
 Wed, 25 Nov 2020 14:34:27 +0000 (UTC)
Received: by mail-ed1-x541.google.com with SMTP id t9so2749699edq.8;
 Wed, 25 Nov 2020 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N71lY/MMcmHmBqgL9ul1o5klXUvwF6twDCi24qH1+8M=;
 b=Q4VR513GViCJw2LDYZeT+AMbv9h1iI1YaWgcTK5G7Ne/Hb5rDdok9BHBF2BpRKnS7m
 wtCq2JzbqA2vNpql3jAUk6pOH4BniCPNd/uGy4Hzk/5HIXZsUwKTbUBW2vDYKMgQHAUZ
 opodFIItV7kGw/bdwPoQtJATOcpAP7mhsgSUhu7Mw/CS8KKzq7vXtP2u7Rq1+gJMcpmQ
 cqvjV0z2wMC3dXFK7Qe+oP5kyzxMRd7wr3iaEGDxKTIldQl8NUNlkRnFq33aFJ+rfcEr
 nvfP1pm7YOi1PRiN9uq9ZEZQftgcGBSaQQc5FNba68bOZvDKzd8AWLr7lcLx9E5C7qkm
 AEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=N71lY/MMcmHmBqgL9ul1o5klXUvwF6twDCi24qH1+8M=;
 b=rmQ0Trq4Aiq/fp2cQLFBAw4/DqQjBeQYfQpHNUdEmP2PK1ds84apWbTDkgw48624Yj
 VkwM3pR0CQphTojoD64bn4Ufjsw50MDMuhdyy343dUa6NGE7zU3P3jK0mTcE+KbphmAF
 0DP/gbJ+8jddfFxqq0g16zanPeqTkD+GzNOt6yTjqRXRmX+rJt+JITwpJ8hN+xOltZLt
 +UT7Rqhsdg40KbK9z9EHuW+tfgtEx/pMafpeI1BT4ImnXTCBuowqR8FCN1oYxmuqCXxh
 UqCGHWUeT2Pg+xMMJM6LgztdKJ1/+ppsRhE10L5rKBlqnMrHtXslVrP9wCCwhwlfmSbf
 o3ig==
X-Gm-Message-State: AOAM533F7tVjzjMzVi+2MttCSpMQ2Z3WRhRqLr98XUnaq96d46tpQvh0
 euR3eCsaEcpFpGqkzPrTbqm3oNavJOY=
X-Google-Smtp-Source: ABdhPJzWMm//FPAaE3D1uoEDY2IpEU0b9ChpM4ECKAbTtj8Oj1wdOZMUJbxfNNH39niqVMreGDLXdg==
X-Received: by 2002:a50:cdc8:: with SMTP id h8mr3808395edj.37.1606314865618;
 Wed, 25 Nov 2020 06:34:25 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:d77:2725:3ce2:6cf0])
 by smtp.gmail.com with ESMTPSA id q15sm1376039edt.95.2020.11.25.06.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 06:34:25 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: fix check order in radeon_bo_move
Date: Wed, 25 Nov 2020 15:34:24 +0100
Message-Id: <20201125143424.1434-1-christian.koenig@amd.com>
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
Cc: airlied@linux.ie
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmVvcmRlciB0aGUgY29kZSB0byBmaXggY2hlY2tpbmcgaWYgYmxpdHRpbmcgaXMgYXZhaWxhYmxl
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jIHwgNTQgKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCsp
LCAzMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3Jh
ZGVvbl90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX3R0bS5jCmluZGV4IDBj
YTM4MWI5NWQzZC4uMmI1OTgxNDEyMjVmIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3JhZGVvbl90dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl90dG0u
YwpAQCAtMjE2LDI3ICsyMTYsMTUgQEAgc3RhdGljIGludCByYWRlb25fYm9fbW92ZShzdHJ1Y3Qg
dHRtX2J1ZmZlcl9vYmplY3QgKmJvLCBib29sIGV2aWN0LAogCXN0cnVjdCB0dG1fcmVzb3VyY2Ug
Km9sZF9tZW0gPSAmYm8tPm1lbTsKIAlpbnQgcjsKIAotCWlmICgob2xkX21lbS0+bWVtX3R5cGUg
PT0gVFRNX1BMX1NZU1RFTSAmJgotCSAgICAgbmV3X21lbS0+bWVtX3R5cGUgPT0gVFRNX1BMX1ZS
QU0pIHx8Ci0JICAgIChvbGRfbWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfVlJBTSAmJgotCSAgICAg
bmV3X21lbS0+bWVtX3R5cGUgPT0gVFRNX1BMX1NZU1RFTSkpIHsKLQkJaG9wLT5mcGZuID0gMDsK
LQkJaG9wLT5scGZuID0gMDsKLQkJaG9wLT5tZW1fdHlwZSA9IFRUTV9QTF9UVDsKLQkJaG9wLT5m
bGFncyA9IDA7Ci0JCXJldHVybiAtRU1VTFRJSE9QOwotCX0KLQogCWlmIChuZXdfbWVtLT5tZW1f
dHlwZSA9PSBUVE1fUExfVFQpIHsKIAkJciA9IHJhZGVvbl90dG1fdHRfYmluZChiby0+YmRldiwg
Ym8tPnR0bSwgbmV3X21lbSk7CiAJCWlmIChyKQogCQkJcmV0dXJuIHI7CiAJfQotCXJhZGVvbl9i
b19tb3ZlX25vdGlmeShibywgZXZpY3QsIG5ld19tZW0pOwogCiAJciA9IHR0bV9ib193YWl0X2N0
eChibywgY3R4KTsKIAlpZiAocikKLQkJZ290byBmYWlsOworCQlyZXR1cm4gcjsKIAogCS8qIENh
bid0IG1vdmUgYSBwaW5uZWQgQk8gKi8KIAlyYm8gPSBjb250YWluZXJfb2YoYm8sIHN0cnVjdCBy
YWRlb25fYm8sIHRibyk7CkBAIC0yNDYsMTIgKzIzNCwxMiBAQCBzdGF0aWMgaW50IHJhZGVvbl9i
b19tb3ZlKHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sIGJvb2wgZXZpY3QsCiAJcmRldiA9
IHJhZGVvbl9nZXRfcmRldihiby0+YmRldik7CiAJaWYgKG9sZF9tZW0tPm1lbV90eXBlID09IFRU
TV9QTF9TWVNURU0gJiYgYm8tPnR0bSA9PSBOVUxMKSB7CiAJCXR0bV9ib19tb3ZlX251bGwoYm8s
IG5ld19tZW0pOwotCQlyZXR1cm4gMDsKKwkJZ290byBvdXQ7CiAJfQogCWlmIChvbGRfbWVtLT5t
ZW1fdHlwZSA9PSBUVE1fUExfU1lTVEVNICYmCiAJICAgIG5ld19tZW0tPm1lbV90eXBlID09IFRU
TV9QTF9UVCkgewogCQl0dG1fYm9fbW92ZV9udWxsKGJvLCBuZXdfbWVtKTsKLQkJcmV0dXJuIDA7
CisJCWdvdG8gb3V0OwogCX0KIAogCWlmIChvbGRfbWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfVFQg
JiYKQEAgLTI1OSwzMSArMjQ3LDM3IEBAIHN0YXRpYyBpbnQgcmFkZW9uX2JvX21vdmUoc3RydWN0
IHR0bV9idWZmZXJfb2JqZWN0ICpibywgYm9vbCBldmljdCwKIAkJcmFkZW9uX3R0bV90dF91bmJp
bmQoYm8tPmJkZXYsIGJvLT50dG0pOwogCQl0dG1fcmVzb3VyY2VfZnJlZShibywgJmJvLT5tZW0p
OwogCQl0dG1fYm9fYXNzaWduX21lbShibywgbmV3X21lbSk7Ci0JCXJldHVybiAwOworCQlnb3Rv
IG91dDsKIAl9Ci0JaWYgKCFyZGV2LT5yaW5nW3JhZGVvbl9jb3B5X3JpbmdfaW5kZXgocmRldild
LnJlYWR5IHx8Ci0JICAgIHJkZXYtPmFzaWMtPmNvcHkuY29weSA9PSBOVUxMKSB7Ci0JCS8qIHVz
ZSBtZW1jcHkgKi8KLQkJZ290byBtZW1jcHk7CisJaWYgKHJkZXYtPnJpbmdbcmFkZW9uX2NvcHlf
cmluZ19pbmRleChyZGV2KV0ucmVhZHkgJiYKKwkgICAgcmRldi0+YXNpYy0+Y29weS5jb3B5ICE9
IE5VTEwpIHsKKwkJaWYgKChvbGRfbWVtLT5tZW1fdHlwZSA9PSBUVE1fUExfU1lTVEVNICYmCisJ
CSAgICAgbmV3X21lbS0+bWVtX3R5cGUgPT0gVFRNX1BMX1ZSQU0pIHx8CisJCSAgICAob2xkX21l
bS0+bWVtX3R5cGUgPT0gVFRNX1BMX1ZSQU0gJiYKKwkJICAgICBuZXdfbWVtLT5tZW1fdHlwZSA9
PSBUVE1fUExfU1lTVEVNKSkgeworCQkJaG9wLT5mcGZuID0gMDsKKwkJCWhvcC0+bHBmbiA9IDA7
CisJCQlob3AtPm1lbV90eXBlID0gVFRNX1BMX1RUOworCQkJaG9wLT5mbGFncyA9IDA7CisJCQly
ZXR1cm4gLUVNVUxUSUhPUDsKKwkJfQorCisJCXIgPSByYWRlb25fbW92ZV9ibGl0KGJvLCBldmlj
dCwgbmV3X21lbSwgb2xkX21lbSk7CisJfSBlbHNlIHsKKwkJciA9IC1FTk9ERVY7CiAJfQogCi0J
ciA9IHJhZGVvbl9tb3ZlX2JsaXQoYm8sIGV2aWN0LCBuZXdfbWVtLCBvbGRfbWVtKTsKIAlpZiAo
cikgewotbWVtY3B5OgogCQlyID0gdHRtX2JvX21vdmVfbWVtY3B5KGJvLCBjdHgsIG5ld19tZW0p
OwotCQlpZiAocikgewotCQkJZ290byBmYWlsOwotCQl9CisJCWlmIChyKQorCQkJcmV0dXJuIHI7
CiAJfQogCitvdXQ6CiAJLyogdXBkYXRlIHN0YXRpc3RpY3MgKi8KIAlhdG9taWM2NF9hZGQoKHU2
NCliby0+bnVtX3BhZ2VzIDw8IFBBR0VfU0hJRlQsICZyZGV2LT5udW1fYnl0ZXNfbW92ZWQpOwor
CXJhZGVvbl9ib19tb3ZlX25vdGlmeShibywgZXZpY3QsIG5ld19tZW0pOwogCXJldHVybiAwOwot
ZmFpbDoKLQlzd2FwKCpuZXdfbWVtLCBiby0+bWVtKTsKLQlyYWRlb25fYm9fbW92ZV9ub3RpZnko
Ym8sIGZhbHNlLCBuZXdfbWVtKTsKLQlzd2FwKCpuZXdfbWVtLCBiby0+bWVtKTsKLQlyZXR1cm4g
cjsKIH0KIAogc3RhdGljIGludCByYWRlb25fdHRtX2lvX21lbV9yZXNlcnZlKHN0cnVjdCB0dG1f
Ym9fZGV2aWNlICpiZGV2LCBzdHJ1Y3QgdHRtX3Jlc291cmNlICptZW0pCi0tIAoyLjI1LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
