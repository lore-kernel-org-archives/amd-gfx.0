Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7848BC5DF60
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A3521882
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A3521882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F29236F9F4;
	Fri,  8 Nov 2019 16:18:11 +0000 (UTC)
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6746F9F4
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2019 16:18:10 +0000 (UTC)
Received: by mail-yw1-xc43.google.com with SMTP id v84so2357708ywc.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Nov 2019 08:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wX0kLGyCNS3LQMy76Mo4Xdy820Bm/ZafME/38v+AMR4=;
 b=XgBDX06lIeV1jrCMSrcWYXKk2i+HVAOKkxIXeumcVcOIqA+oUzf3NGeb4Ly3wys7TQ
 4cwf5MeRp+0xwJWQeG4xKSQHlu7AWhYLbaipTfOXfZFkQlaU/DV7ea1t4I3OuZ158OVl
 uvoPXkuSrVe+KoPUoQvrnFRJ8LipIiUFQ68Uw/P56brFEE/RwFSisyFGmjpg0/DB235T
 V1+wFGVdyFKTrQMQnDypp4F4M/RDcVTaEybSHugVvHrjJ3va3axFTQIWaokfxIgC1nb0
 WPiZmkWPgnklcuh0s9KUYksyt0xi5PIa4XzG4ILEpWnYqFZVI1/0FvO7b4tV9iKAK6iD
 xbdQ==
X-Gm-Message-State: APjAAAVjSNRI1iQTzXp9fzbGyKLd4fsZs/o00IBJU6vxsoY9jKqv5lvH
 yrEwOvoOM91K2rV9JjJmH6YRVmR9
X-Google-Smtp-Source: APXvYqyuZx9I3JIeWkJ/22HoaEqjT5UXWhBdb/HVzx/CB2KkNZ2zKrxi+hxN06NtpifohpWaqStlsA==
X-Received: by 2002:a81:3650:: with SMTP id d77mr8017056ywa.397.1573229889149; 
 Fri, 08 Nov 2019 08:18:09 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 203sm530408ywe.57.2019.11.08.08.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 08:18:08 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay/smu7: fix AVFS handling with custom
 powerplay table
Date: Fri,  8 Nov 2019 11:17:59 -0500
Message-Id: <20191108161759.2130602-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wX0kLGyCNS3LQMy76Mo4Xdy820Bm/ZafME/38v+AMR4=;
 b=BvoAN6Da/Ukw0/Ui34PGDlP8/7onn6eYuiE9ZZ+ZZM4pxt0tTvKW4kTMO0oo6vxA61
 aPPyM/qgMY7Ihx73OMQWMryGmY+YxAcVLYR/guXpL3B560D+Q5dGc5oLZ2VJ5kfMZfSK
 NACQbbCvcVCdvlV4oKKUPfIFnIWEleJip3tXdInDCe599zm9r0k8DX5FQbdxQBDAr6Kv
 ROq4kLrqWE9K3HDLo+SFh+NTs3oSMZquO7P8MI7HK+M+s3ZX9OoYASiZTzvfNHIUS3IT
 CwHMrhJU6CSlxzvMeDQ0oho2phMkH6yYETYxcizR3lHs3PFG0iuJH5tXjj0EYQwF4Psp
 iEUA==
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
Message-ID: <20191108161759.KmtRaBq57adCiqnQQE8m7ecVmAnXZWqti0uc2vqxh3s@z>

V2hlbiBhIGN1c3RvbSBwb3dlcnBsYXkgdGFibGUgaXMgcHJvdmlkZWQsIHdlIG5lZWQgdG8gdXBk
YXRlCnRoZSBPRCBWRERDIGZsYWcgdG8gYXZvaWQgQVZGUyBiZWluZyBlbmFibGVkIHdoZW4gaXQg
c2hvdWxkbid0IGJlLgoKQnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcu
Y2dpP2lkPTIwNTM5MwpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVj
aGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211
N19od21nci5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21n
ci5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCmlu
ZGV4IGM4MDVjNmZjZGJhMi4uMzkwZTc1MjRiZWY0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL3Bvd2VycGxheS9od21nci9zbXU3X2h3bWdyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9wb3dlcnBsYXkvaHdtZ3Ivc211N19od21nci5jCkBAIC0zOTY5LDYgKzM5NjksMTMgQEAg
c3RhdGljIGludCBzbXU3X3NldF9wb3dlcl9zdGF0ZV90YXNrcyhzdHJ1Y3QgcHBfaHdtZ3IgKmh3
bWdyLCBjb25zdCB2b2lkICppbnB1dCkKIAkJCSJGYWlsZWQgdG8gcG9wdWxhdGUgYW5kIHVwbG9h
ZCBTQ0xLIE1DTEsgRFBNIGxldmVscyEiLAogCQkJcmVzdWx0ID0gdG1wX3Jlc3VsdCk7CiAKKwkv
KgorCSAqIElmIGEgY3VzdG9tIHBwIHRhYmxlIGlzIGxvYWRlZCwgc2V0IERQTVRBQkxFX09EX1VQ
REFURV9WRERDIGZsYWcuCisJICogVGhhdCBlZmZlY3RpdmVseSBkaXNhYmxlcyBBVkZTIGZlYXR1
cmUuCisJICovCisJaWYgKGh3bWdyLT5oYXJkY29kZV9wcF90YWJsZSAhPSBOVUxMKQorCQlkYXRh
LT5uZWVkX3VwZGF0ZV9zbXU3X2RwbV90YWJsZSB8PSBEUE1UQUJMRV9PRF9VUERBVEVfVkREQzsK
KwogCXRtcF9yZXN1bHQgPSBzbXU3X3VwZGF0ZV9hdmZzKGh3bWdyKTsKIAlQUF9BU1NFUlRfV0lU
SF9DT0RFKCgwID09IHRtcF9yZXN1bHQpLAogCQkJIkZhaWxlZCB0byB1cGRhdGUgYXZmcyB2b2x0
YWdlcyEiLAotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
Zng=
