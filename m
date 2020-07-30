Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3FEC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AC842074B
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnvXcofB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC842074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A25766E955;
	Thu, 30 Jul 2020 20:04:24 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9746E955
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:24 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id b25so21320651qto.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uRaIsD5L8q7nGayNCkaHxNaaSEFRYuLew0gMdwTP704=;
 b=RnvXcofBEVk4FXsEw0v+yoEzA1dFjvqnP1/epdGYbosbi60Rnaj9fGjoNITX8hOECO
 Wc/baHIuYaGq0CA5VoVVishn1kdkB25TlHVBstc4gX5vvCRYdyaYhS+LKNmPq+feTIyZ
 D4a3wJ6u1GaPmJFdnHpYOSoFwvAroKxjceJAJUDRKolkcLvC7GqHZjP8JfX8PPMsw3ZF
 BbqymHsUR+zXc2RnDm6OIdnOJjT7/i70MrYnk78fkcfcrqD8xM4szFkKEB3OvBduZV7x
 pTNIAcLsCMYuN/b1wUJHpAnmz9XhpsLeLk+GIwpO2imG4cx1GVmsgMEzP8A+vqxxxxqb
 iNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uRaIsD5L8q7nGayNCkaHxNaaSEFRYuLew0gMdwTP704=;
 b=OGm2mq+5wn4vK/hcU6xppzBBiNN8XFGlH+unjrKP3kqCyXRYQDfuP7NzvksTja4U6X
 yA6K1Y9zq0s9m3kLgh+tZOw981n+45ZOfylcHcE9Q3Z5a5OexMe7XHRgsAywypnorA/Z
 iJ+yX1ZXVJpIiOr/Mm5XOhhxcmvrgi63jo9MS8IRLwj/CokGov6RbtQ0wILgD0Wpeqst
 GsmCQ0Zq0uGMix7TrIx0DrdfpacYBDW8juMQtOfWX+jebanfUebed9pRTqrNvyEAkd6U
 t1NT46urR4nbP4URPQIUmiKTox+j9V25tuwXmVAkLSu+fr1Pd748evikjtHxLB57OyBN
 s/4g==
X-Gm-Message-State: AOAM5336IK6Aj7eOpRh36d1MXNViMfOlkgsSQ1tJk22AYE7SHUZkGDSw
 NOxXh79R3Vdnl0h844V2K5pdczEU
X-Google-Smtp-Source: ABdhPJymwfKNZcHyH2ontkSKqNx0n4X642nzltfsr5+xkpkRrLi1dcXwM1qPiqNvsDdiC2KPQrBaUQ==
X-Received: by 2002:ac8:450c:: with SMTP id q12mr360485qtn.292.1596139463194; 
 Thu, 30 Jul 2020 13:04:23 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:22 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/17] drm/amdgpu: handle bo size 0 in
 amdgpu_bo_create_kernel_at (v2)
Date: Thu, 30 Jul 2020 16:03:58 -0400
Message-Id: <20200730200414.40485-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200730200414.40485-1-alexander.deucher@amd.com>
References: <20200730200414.40485-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SnVzdCByZXR1cm4gZWFybHkgdG8gbWF0Y2ggb3RoZXIgYm9fY3JlYXRlIGZ1bmN0aW9ucy4KCnYy
OiBjaGVjayBpZiB0aGUgYm9fcHRyIGlzIE5VTEwgcmF0aGVyIHRoYW4gY2hlY2tpbmcgdGhlIHNp
emUuCgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+
ICh2MSkKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQu
Y29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyB8IDMg
KysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCmluZGV4IDVhYzdiNTU2MTQ3NS4uYTNjZjM4ZDI1ZmMx
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCkBAIC0zNzQs
NiArMzc0LDkgQEAgaW50IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsX2F0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2LAogCWlmIChyKQogCQlyZXR1cm4gcjsKIAorCWlmICgoKmJvX3B0cikgPT0g
TlVMTCkKKwkJcmV0dXJuIDA7CisKIAkvKgogCSAqIFJlbW92ZSB0aGUgb3JpZ2luYWwgbWVtIG5v
ZGUgYW5kIGNyZWF0ZSBhIG5ldyBvbmUgYXQgdGhlIHJlcXVlc3QKIAkgKiBwb3NpdGlvbi4KLS0g
CjIuMjUuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
