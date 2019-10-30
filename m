Return-Path: <SRS0=Kp29=YX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A9DCA9EC5
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 18:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3347120856
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Oct 2019 18:41:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3347120856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0DAB6EB31;
	Wed, 30 Oct 2019 18:41:43 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F4A6EB16
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 18:41:42 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id a194so3821934qkg.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Oct 2019 11:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kp+PnwmQEiFQv3eY4ZGXVH/6hfHsyY6w4ldGAq/Wf34=;
 b=t7zFDm47VzziX+xCEcCPFtd4Fypyoiqp+Jho/OZsil6W9r7Z761+MRmfAoDA7hNaoa
 k7Y5v8R7/d/nU3HA9gBviv8n8bl2CpyF3TLvXhoXMk8KdLFwxd5+Vpc2iXAb6DqoWrvR
 FkDZz2IQoImNjDbJW1zMlRPi4b/ccT8vm3DnxTVj+gdr4ET4858CA0MYGOrKbCxvRUKf
 djSBhQpzC4TJKO7+XtTZ8lX8AbESGws5sC0Mtq8E+jfnYQAD3H0uqXyq6pIqKw10kFEr
 a9G4KfsN6Fof2jPeYnUDaMU5yhIln2864Ha+VJE+o+vc/sHdoOWyI0UsnExx0nv7ANPd
 +kOQ==
X-Gm-Message-State: APjAAAWqmvvMyGIYBu6DXT38g9YSripNbH7J3K9IOccvBc2eqyTcpaJY
 z0B5WHiRuCaa32vj4czgqnvM63l2
X-Google-Smtp-Source: APXvYqw7SwgvcbwrGgvY/po8tGzgYrKHWXqxhCvVktdFKu/fexQh5B8exnoD8MiQW87e9RJ8ufatdw==
X-Received: by 2002:a37:48c4:: with SMTP id v187mr1502406qka.188.1572460901523; 
 Wed, 30 Oct 2019 11:41:41 -0700 (PDT)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id i68sm516219qkb.106.2019.10.30.11.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2019 11:41:41 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gpuvm: add some additional comments in
 amdgpu_vm_update_ptes
Date: Wed, 30 Oct 2019 14:41:33 -0400
Message-Id: <20191030184134.250234-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Kp+PnwmQEiFQv3eY4ZGXVH/6hfHsyY6w4ldGAq/Wf34=;
 b=YeBJ9OIvP838BRnzCwQoicvYsLPRwXwFCux9UjHzYr7i5ztbprYb+WVav4vjJWfSyb
 GtTqdkTOJUSfUBEqyI3n8QfjywLkMLwcn3EFUCBOQIZUrpFEv2soaAOSgZgU4JCFpXso
 Me0R+TH79qJ2geNSIMrdGVIMTcawuAGZOlXwMLLBuJ4eidMtgsrJqT6TQwgFt/+v2fQY
 Grb8oxe9e1zJAWdrwtpbuleuBY8MSD1SntchzoS+EQXY5KMH09pNGD1K8ll9bbPBoF9i
 3btlg4C72okPHAFkLtfshibIkk+sr4MJYdi99YPJpEGBe2wkdSXR29kgvwzn1z8tD87j
 iIdA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191030184133.Qo45RfjatL1jhlOmsPU5c0C4G9gRAgnX2-k5E8zblDM@z>

VG8gYmV0dGVyIGNsYXJpZnkgd2hhdCBpcyBoYXBwZW5pbmcgaW4gdGhpcyBmdW5jdGlvbi4KClNp
Z25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDEwICsrKysrKysrKy0K
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCmluZGV4IGM4Y2U0MjIwMDA1OS4uM2MwYmQ2NDcy
YTQ2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtMTQxOSw2ICsx
NDE5LDkgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92
bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCiAJCXVpbnQ2NF90IGluY3IsIGVudHJ5X2VuZCwgcGVf
c3RhcnQ7CiAJCXN0cnVjdCBhbWRncHVfYm8gKnB0OwogCisJCS8qIG1ha2Ugc3VyZSB0aGF0IHRo
ZSBwYWdlIHRhYmxlcyBjb3ZlcmluZyB0aGUgYWRkcmVzcyByYW5nZSBhcmUKKwkJICogYWN0dWFs
bHkgYWxsb2NhdGVkCisJCSAqLwogCQlyID0gYW1kZ3B1X3ZtX2FsbG9jX3B0cyhwYXJhbXMtPmFk
ZXYsIHBhcmFtcy0+dm0sICZjdXJzb3IsCiAJCQkJCXBhcmFtcy0+ZGlyZWN0KTsKIAkJaWYgKHIp
CkBAIC0xNDkyLDcgKzE0OTUsMTIgQEAgc3RhdGljIGludCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMo
c3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpwYXJhbXMsCiAJCX0gd2hpbGUgKGZyYWdf
c3RhcnQgPCBlbnRyeV9lbmQpOwogCiAJCWlmIChhbWRncHVfdm1fcHRfZGVzY2VuZGFudChhZGV2
LCAmY3Vyc29yKSkgewotCQkJLyogRnJlZSBhbGwgY2hpbGQgZW50cmllcyAqLworCQkJLyogRnJl
ZSBhbGwgY2hpbGQgZW50cmllcy4KKwkJCSAqIFVwZGF0ZSB0aGUgdGFibGVzIHdpdGggdGhlIGZs
YWdzIGFuZCBhZGRyZXNzZXMgYW5kIGZyZWUgdXAgc3Vic2VxdWVudAorCQkJICogdGFibGVzIGlu
IHRoZSBjYXNlIG9mIGh1Z2UgcGFnZXMgb3IgZnJlZWQgdXAgYXJlYXMuCisJCQkgKiBUaGlzIGlz
IHRoZSBtYXhpbXVtIHlvdSBjYW4gZnJlZSwgYmVjYXVzZSBhbGwgb3RoZXIgcGFnZSB0YWJsZXMg
YXJlIG5vdAorCQkJICogY29tcGxldGVseSBjb3ZlcmVkIGJ5IHRoZSByYW5nZSBhbmQgc28gcG90
ZW50aWFsbHkgc3RpbGwgaW4gdXNlLgorCQkJICovCiAJCQl3aGlsZSAoY3Vyc29yLnBmbiA8IGZy
YWdfc3RhcnQpIHsKIAkJCQlhbWRncHVfdm1fZnJlZV9wdHMoYWRldiwgcGFyYW1zLT52bSwgJmN1
cnNvcik7CiAJCQkJYW1kZ3B1X3ZtX3B0X25leHQoYWRldiwgJmN1cnNvcik7Ci0tIAoyLjIzLjAK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
