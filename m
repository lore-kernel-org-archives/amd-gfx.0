Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AE3C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C4A3207D0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sz8gl5jZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4A3207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D916E6E2A0;
	Mon,  1 Jun 2020 18:04:10 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 803C26E2A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:09 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id g7so439756qvx.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qK/bwxJ3C0DwiBSte0QFuBtxvnaWzIrUT7G2Wckhtz8=;
 b=sz8gl5jZlWmWICdkMKZcD797SPh4McqHq/pTfaM8S6tqaW4Zcey6wiAF7IBnq/YWzK
 TzJc9P+WQk7Hg+0TwyWerwX4YS/eON9Np0ai7WOpD+WSyI2+DklAAjnzt0TVFWpiGzsI
 Ir/8J42BGfd2R3b+Qo4Owp5uoMzOFvLEZtrGci+lsn7j7lmd5exVAV6DfuHn4vCRKqEH
 VMQwB78WxY2onDToc65MJRlSule3A/HZP34atq+0j01audU4s8NEohzJ5svcn1nLs0Ii
 S9riwoDYYNbMawnQNBAuOtMHjttrlxsTxYeZFgCZdPdAL4dpdfBFh8ePlUPQLf42RO7l
 hfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qK/bwxJ3C0DwiBSte0QFuBtxvnaWzIrUT7G2Wckhtz8=;
 b=oE3qq6xEcdE5t+PzxvxmlW3OU8HpAP3gmo8PBTFxIPLviWzUfH4QW3DSR8GlnX3Gv9
 xIzFVjl7VeReFD+VCf+OLMTDYLjL9c1I8LtODxQraQwrNGCbT4KBiTL+06hE1ls97lr5
 Tu92gwrnhydEpiRe+kZD4OhxmZgDBBlg6s84tQs+/8PWn6m3MO+2lI9x2xLiFZnP8V7a
 pHhhFpP4ycUTl1/i5DgUg0AK4a51vzI4fmAQk5XyHu19GNNT5rkBP3ZNohN+VnQuf6RO
 azpXi19bYi3MRSBq4h2BR/DUEVwPnmHNObcr0MKqx1mE04eGbMkCH2HE03uvbo5vBoE9
 qzzg==
X-Gm-Message-State: AOAM530HcJCVPkofz7a/koChHozWV++VQKHbFY3CJb9z34FXK9bVqa5h
 oxVzDSAZCWwmxQYXDnposoEecow3
X-Google-Smtp-Source: ABdhPJyNGc+rc0iyxb1PAoEX1e9WJvCxx7RZ3STBR2GPMWNeKo2HWnFEzeR0zC25no4gre4fWCvKnQ==
X-Received: by 2002:ad4:536a:: with SMTP id e10mr1793431qvv.246.1591034648394; 
 Mon, 01 Jun 2020 11:04:08 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:07 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 057/207] drm/amdgpu: avoid dereferencing a NULL pointer
Date: Mon,  1 Jun 2020 14:00:09 -0400
Message-Id: <20200601180239.1267430-54-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogSmFjayBYaWFvIDxKYWNrLlhpYW9AYW1kLmNvbT4KCkNoZWNrIGlmIGlycV9zcmMgaXMg
TlVMTCB0byBhdm9pZCBkZXJlZmVyZW5jaW5nIGEgTlVMTCBwb2ludGVyLApmb3IgTUVTIHJpbmcg
aXMgdW5lY2Nlc3NhcnkgdG8gcmVjaWV2ZSBhbiBpbnRlcnJ1cHQgbm90aWZpY2F0aW9uLgoKU2ln
bmVkLW9mZi1ieTogSmFjayBYaWFvIDxKYWNrLlhpYW9AYW1kLmNvbT4KQWNrZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEhhd2tpbmcg
WmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVy
IDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9mZW5jZS5jIHwgMTkgKysrKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZmVuY2UuYwppbmRleCBkODc4ZmU3ZmVlNTEuLjM0MTRlMTE5ZjBjYiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZlbmNlLmMKQEAgLTQxNiw3ICs0
MTYsOSBAQCBpbnQgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9zdGFydF9yaW5nKHN0cnVjdCBhbWRncHVf
cmluZyAqcmluZywKIAkJcmluZy0+ZmVuY2VfZHJ2LmdwdV9hZGRyID0gYWRldi0+dXZkLmluc3Rb
cmluZy0+bWVdLmdwdV9hZGRyICsgaW5kZXg7CiAJfQogCWFtZGdwdV9mZW5jZV93cml0ZShyaW5n
LCBhdG9taWNfcmVhZCgmcmluZy0+ZmVuY2VfZHJ2Lmxhc3Rfc2VxKSk7Ci0JYW1kZ3B1X2lycV9n
ZXQoYWRldiwgaXJxX3NyYywgaXJxX3R5cGUpOworCisJaWYgKGlycV9zcmMpCisJCWFtZGdwdV9p
cnFfZ2V0KGFkZXYsIGlycV9zcmMsIGlycV90eXBlKTsKIAogCXJpbmctPmZlbmNlX2Rydi5pcnFf
c3JjID0gaXJxX3NyYzsKIAlyaW5nLT5mZW5jZV9kcnYuaXJxX3R5cGUgPSBpcnFfdHlwZTsKQEAg
LTUzNyw4ICs1MzksOSBAQCB2b2lkIGFtZGdwdV9mZW5jZV9kcml2ZXJfZmluaShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldikKIAkJCS8qIG5vIG5lZWQgdG8gdHJpZ2dlciBHUFUgcmVzZXQgYXMg
d2UgYXJlIHVubG9hZGluZyAqLwogCQkJYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0
aW9uKHJpbmcpOwogCQl9Ci0JCWFtZGdwdV9pcnFfcHV0KGFkZXYsIHJpbmctPmZlbmNlX2Rydi5p
cnFfc3JjLAotCQkJICAgICAgIHJpbmctPmZlbmNlX2Rydi5pcnFfdHlwZSk7CisJCWlmIChyaW5n
LT5mZW5jZV9kcnYuaXJxX3NyYykKKwkJCWFtZGdwdV9pcnFfcHV0KGFkZXYsIHJpbmctPmZlbmNl
X2Rydi5pcnFfc3JjLAorCQkJCSAgICAgICByaW5nLT5mZW5jZV9kcnYuaXJxX3R5cGUpOwogCQlk
cm1fc2NoZWRfZmluaSgmcmluZy0+c2NoZWQpOwogCQlkZWxfdGltZXJfc3luYygmcmluZy0+ZmVu
Y2VfZHJ2LmZhbGxiYWNrX3RpbWVyKTsKIAkJZm9yIChqID0gMDsgaiA8PSByaW5nLT5mZW5jZV9k
cnYubnVtX2ZlbmNlc19tYXNrOyArK2opCkBAIC01NzQsOCArNTc3LDkgQEAgdm9pZCBhbWRncHVf
ZmVuY2VfZHJpdmVyX3N1c3BlbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCX0KIAog
CQkvKiBkaXNhYmxlIHRoZSBpbnRlcnJ1cHQgKi8KLQkJYW1kZ3B1X2lycV9wdXQoYWRldiwgcmlu
Zy0+ZmVuY2VfZHJ2LmlycV9zcmMsCi0JCQkgICAgICAgcmluZy0+ZmVuY2VfZHJ2LmlycV90eXBl
KTsKKwkJaWYgKHJpbmctPmZlbmNlX2Rydi5pcnFfc3JjKQorCQkJYW1kZ3B1X2lycV9wdXQoYWRl
diwgcmluZy0+ZmVuY2VfZHJ2LmlycV9zcmMsCisJCQkJICAgICAgIHJpbmctPmZlbmNlX2Rydi5p
cnFfdHlwZSk7CiAJfQogfQogCkBAIC02MDEsOCArNjA1LDkgQEAgdm9pZCBhbWRncHVfZmVuY2Vf
ZHJpdmVyX3Jlc3VtZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJCWNvbnRpbnVlOwog
CiAJCS8qIGVuYWJsZSB0aGUgaW50ZXJydXB0ICovCi0JCWFtZGdwdV9pcnFfZ2V0KGFkZXYsIHJp
bmctPmZlbmNlX2Rydi5pcnFfc3JjLAotCQkJICAgICAgIHJpbmctPmZlbmNlX2Rydi5pcnFfdHlw
ZSk7CisJCWlmIChyaW5nLT5mZW5jZV9kcnYuaXJxX3NyYykKKwkJCWFtZGdwdV9pcnFfZ2V0KGFk
ZXYsIHJpbmctPmZlbmNlX2Rydi5pcnFfc3JjLAorCQkJCSAgICAgICByaW5nLT5mZW5jZV9kcnYu
aXJxX3R5cGUpOwogCX0KIH0KIAotLSAKMi4yNS40CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2FtZC1nZngK
