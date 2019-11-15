Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BB6C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5450520723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5450520723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7F056E750;
	Fri, 15 Nov 2019 16:51:03 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1016C6E958
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:51:00 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id i19so8629758qki.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0MgTuC5BgKHh8g9okFWnMYj+ryxsdDpMF+psrmOrlpc=;
 b=J2pF70akuEScxqH7Dmir9TBX88vq+UcX0sOfd9ifkLpRN59DgtAhYtUoqVCrBmT77n
 kipjvAqbNeNAhebylkDnOFTHZqzUhzumO1iH9ziR1JRj5GhbyPw4TzcoI/oq66z6D+eL
 iPaZnmL82QfWg2WngEzgvL5p0Nle3Rvn/GVMtNX1ru4ItdeIIMu0eueUfs41GjpZt5kA
 Jq8l1sJE0HM5x1fEIHZpCHvnh4GaSyZOB6ZznUQ7lHdgiM95D9jJadJzTNYgotnlQGS9
 oRX5Bh8clazYdeXH78z4igj4NpnCxs2TT1Psi4rH8WJDDAPGql6bj5/5HKn4UKlin9H1
 ofZQ==
X-Gm-Message-State: APjAAAVzg0ReHQVR84AwQS261OVb+MeIZjel1Tr9SeuYTqEmCfGWN6iv
 WwGf77sTYstJn8YAxbpdb2+4w0Z4
X-Google-Smtp-Source: APXvYqyeoT309l8spittf8ytRO2+pekLf702hNJ94cEtqBbyi0eY5X9hsZWCSJwEFOpZWmUpYZqJYA==
X-Received: by 2002:a37:9585:: with SMTP id
 x127mr13692046qkd.146.1573836658926; 
 Fri, 15 Nov 2019 08:50:58 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:58 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 12/20] drm/amdgpu: add baco support to runtime suspend/resume
Date: Fri, 15 Nov 2019 11:50:30 -0500
Message-Id: <20191115165038.56646-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0MgTuC5BgKHh8g9okFWnMYj+ryxsdDpMF+psrmOrlpc=;
 b=W9lWU6bJiT0xvZaPdZUCULtlKXJkcF+7t3J9/CdUquDlbCdERiUcQXYjHQIhAPyxNF
 CVwEn8/PWOKMS4+Kdy83JRY9IDPAhc9QZt5xKm+9E26e/yj0Glfw51BjFBkR0fpOPqiD
 naSnUkBDSLtn6S8szFjKIw/Al/TwNrctfHKNnFQ4hgYTBKsdgIPWn2hwtqU0JIwsJn30
 Oxt4GazjXaDq8aXZUKTAKmXnD02FltuNSGSgK6y1mti/4WRkWratwOrgNfvzwuNjxizT
 CX2KHzeEdS+kqSaEzync0eaKpgUH5k3tj+JcGBJ3++J4vwb6cbyG2LyKz7Qa/zVNe/vC
 6F1A==
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115165030.QWa98c1E7a3TH5XgCKlxVRXT4d77SFjs6N4frnqRQ_M@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpUaGlzIGFkZHMgdGhlIG5lY2Vzc2FyeSBzdXBw
b3J0IHRvIHRoZSBydW50aW1lIHN1c3BlbmQKYW5kIHJlc3VtZSBmdW5jdGlvbnMgdG8gaGFuZGxl
IGJvYXJkcyB0aGF0IHN1cHBvcnQKYmFjby4KClJldmlld2VkLWJ5OiBFdmFuIFF1YW4gPGV2YW4u
cXVhbkBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
IHwgNyArKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jCmluZGV4IGQwNWY4YzAz
ZTU1OS4uN2I1NDM3YTg3YjAxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfZHJ2LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ry
di5jCkBAIC0xMTY2LDcgKzExNjYsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19yZXN1bWUo
c3RydWN0IGRldmljZSAqZGV2KQogCXN0cnVjdCBkcm1fZGV2aWNlICpkcm1fZGV2ID0gZGV2X2dl
dF9kcnZkYXRhKGRldik7CiAKIAkvKiBHUFUgY29tZXMgdXAgZW5hYmxlZCBieSB0aGUgYmlvcyBv
biByZXN1bWUgKi8KLQlpZiAoYW1kZ3B1X2RldmljZV9zdXBwb3J0c19ib2NvKGRybV9kZXYpKSB7
CisJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhkcm1fZGV2KSB8fAorCSAgICBhbWRn
cHVfZGV2aWNlX3N1cHBvcnRzX2JhY28oZHJtX2RldikpIHsKIAkJcG1fcnVudGltZV9kaXNhYmxl
KGRldik7CiAJCXBtX3J1bnRpbWVfc2V0X2FjdGl2ZShkZXYpOwogCQlwbV9ydW50aW1lX2VuYWJs
ZShkZXYpOwpAQCAtMTIzMyw2ICsxMjM0LDggQEAgc3RhdGljIGludCBhbWRncHVfcG1vcHNfcnVu
dGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikKIAkJZWxzZSBpZiAoIWFtZGdwdV9oYXNf
YXRweF9kZ3B1X3Bvd2VyX2NudGwoKSkKIAkJCXBjaV9zZXRfcG93ZXJfc3RhdGUocGRldiwgUENJ
X0QzaG90KTsKIAkJZHJtX2Rldi0+c3dpdGNoX3Bvd2VyX3N0YXRlID0gRFJNX1NXSVRDSF9QT1dF
Ul9EWU5BTUlDX09GRjsKKwl9IGVsc2UgaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYmFjbyhk
cm1fZGV2KSkgeworCQlhbWRncHVfZGV2aWNlX2JhY29fZW50ZXIoZHJtX2Rldik7CiAJfQogCiAJ
cmV0dXJuIDA7CkBAIC0xMjU4LDYgKzEyNjEsOCBAQCBzdGF0aWMgaW50IGFtZGdwdV9wbW9wc19y
dW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJCWlmIChyZXQpCiAJCQlyZXR1cm4g
cmV0OwogCQlwY2lfc2V0X21hc3RlcihwZGV2KTsKKwl9IGVsc2UgaWYgKGFtZGdwdV9kZXZpY2Vf
c3VwcG9ydHNfYmFjbyhkcm1fZGV2KSkgeworCQlhbWRncHVfZGV2aWNlX2JhY29fZXhpdChkcm1f
ZGV2KTsKIAl9CiAJcmV0ID0gYW1kZ3B1X2RldmljZV9yZXN1bWUoZHJtX2RldiwgZmFsc2UsIGZh
bHNlKTsKIAlkcm1fa21zX2hlbHBlcl9wb2xsX2VuYWJsZShkcm1fZGV2KTsKLS0gCjIuMjMuMAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
