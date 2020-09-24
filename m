Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475D4C4363D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 19:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA920221EB
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 19:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwxA3aAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA920221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B22A66E04A;
	Thu, 24 Sep 2020 19:31:49 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE9CD6E04A
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 19:31:48 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c62so646556qke.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4R36mpoEllHmcHGn8Y99HrfXNqtA/MKGUPqsqDgj400=;
 b=KwxA3aAMxLc/XQE3QqxLqxkhKCcdbEJiTuOsWo0RKsHmqOXh7fBrIVLGSHlolS4GBk
 q0ZJLuXXZ0kxwPQfsmgYswwUcDjz/a1i1sfLmPX56mnI+DitA3O+NAr/m3/BhtimKp7c
 yNV/gsy7Jg7DgqkHifaoCuz/v1uddwly07ZBiRbgEqJLteLwfpWniJ/2gtUcxtkOyesk
 6HDMdkDHSNUTOv8RrsPntDrOjkllRHoebgcbDD0v5C0OsqAN37H2JOuenYcWaR8SEDS5
 CUoTdc3PMCDv2/7oMQoMExVEnwIrT+SMxP3xPb/7DjIPuEnxdeiIzVW8b1ZfkZT7GCew
 wP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4R36mpoEllHmcHGn8Y99HrfXNqtA/MKGUPqsqDgj400=;
 b=kbBorKx0kIfqFl97mdziJ+KEUSV8Cq+awfW/TUXWQSfWdLLfcIOL1N1KgPr7RwYvJw
 tPe12jil1oUzLl3yrJwfIJ2YGdhIjftja7rihDnksU/2V0rh99zj4gDPkqgUhy9u8zdf
 erxSq/oRyT11OXBJwRODF+L5YVl5XdWaxwfSANxjGzuKEFeqIRkJ5rLhTE94xHxJaBsY
 3huCpQgdncUm6oeRLl6R+6dgEcZeLcMFDUBJT0qRNde9gOk2wMthFKX8RKE2CRUP7OGU
 IFBwsiohvI5E+RxbYoBVBxJyEncGcMtO+4iPTHhwoet3vnTsET8Fr05R3rhuB0LFbmjv
 rymw==
X-Gm-Message-State: AOAM531Sb3Cbm5Viq6LzpUOFDPsu0qZVh22JWjLNkbvauCShK7WUxkB4
 A43Ex8BlTwWgrBHjdRdRL85hlTDn/N8=
X-Google-Smtp-Source: ABdhPJw59s2KAnwnQOFBvR1dUKYEEbGkFNUXSmHA4xxSsBIGhn/U7pHSkDZvSziTFdZDjyRd63mzBA==
X-Received: by 2002:a37:ef19:: with SMTP id j25mr605603qkk.363.1600975907743; 
 Thu, 24 Sep 2020 12:31:47 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id y7sm382485qtn.11.2020.09.24.12.31.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 12:31:47 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/virt: fix the build
Date: Thu, 24 Sep 2020 15:31:39 -0400
Message-Id: <20200924193139.1550564-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Bokun Zhang <Bokun.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYzogSW4gZnVuY3Rpb24g4oCY
YW1kZ3B1X3ZpcnRfaW5pdF9kYXRhX2V4Y2hhbmdl4oCZOgpkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdmlydC5jOjU4NjoxMDogZXJyb3I6IOKAmHN0cnVjdCBhbWRncHVfZGV2aWNl
4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYZndfdnJhbV91c2FnZeKAmQogIDU4NiB8ICBpZiAo
YWRldi0+ZndfdnJhbV91c2FnZS52YSAhPSBOVUxMKSB7CiAgICAgIHwgICAgICAgICAgXn4KZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZpcnQuYzo1OTE6OTogZXJyb3I6IOKAmHN0
cnVjdCBhbWRncHVfZGV2aWNl4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYZndfdnJhbV91c2Fn
ZeKAmQogIDU5MSB8ICAgIChhZGV2LT5md192cmFtX3VzYWdlLnZhICsgKEFNRF9TUklPVl9NU0df
UEYyVkZfT0ZGU0VUX0tCIDw8IDEwKSk7CiAgICAgIHwgICAgICAgICBefgpkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jOjU5NDo5OiBlcnJvcjog4oCYc3RydWN0IGFtZGdw
dV9kZXZpY2XigJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJhmd192cmFtX3VzYWdl4oCZCiAgNTk0
IHwgICAgKGFkZXYtPmZ3X3ZyYW1fdXNhZ2UudmEgKyAoQU1EX1NSSU9WX01TR19WRjJQRl9PRkZT
RVRfS0IgPDwgMTApKTsKICAgICAgfCAgICAgICAgIF5+Cm1ha2VbNF06ICoqKiBbc2NyaXB0cy9N
YWtlZmlsZS5idWlsZDoyODM6IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92aXJ0
Lm9dIEVycm9yIDEKbWFrZVs0XTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4K
bWFrZVszXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjUwMDogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHVdIEVycm9yIDIKbWFrZVszXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQg
am9icy4uLi4KbWFrZVsyXTogKioqIFtzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjUwMDogZHJpdmVy
cy9ncHUvZHJtXSBFcnJvciAyCm1ha2VbMV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1
MDA6IGRyaXZlcnMvZ3B1XSBFcnJvciAyCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTc4ODogZHJpdmVy
c10gRXJyb3IgMgoKQ2M6IEJva3VuIFpoYW5nIDxCb2t1bi5aaGFuZ0BhbWQuY29tPgpGaXhlczog
NjE0ZTdhYzkyOTc5ICgiZHJtL2FtZGdwdTogSW1wbGVtZW50IG5ldyBndWVzdCBzaWRlIFZGMlBG
IG1lc3NhZ2UgdHJhbnNhY3Rpb24iKQpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3ZpcnQuYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92aXJ0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jCmlu
ZGV4IDFmMTE3MTgxMmUzNS4uODM2ZDc4NDQ1NmU1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92aXJ0LmMKQEAgLTU4MywxNSArNTgzLDE1IEBAIHZvaWQgYW1kZ3B1X3ZpcnRf
aW5pdF9kYXRhX2V4Y2hhbmdlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCWFkZXYtPnZp
cnQuZndfcmVzZXJ2ZS5wX3ZmMnBmID0gTlVMTDsKIAlhZGV2LT52aXJ0LnZmMnBmX3VwZGF0ZV9p
bnRlcnZhbF9tcyA9IDA7CiAKLQlpZiAoYWRldi0+ZndfdnJhbV91c2FnZS52YSAhPSBOVUxMKSB7
CisJaWYgKGFkZXYtPm1tYW4uZndfdnJhbV91c2FnZV92YSAhPSBOVUxMKSB7CiAJCWFkZXYtPnZp
cnQudmYycGZfdXBkYXRlX2ludGVydmFsX21zID0gMjAwMDsKIAogCQlhZGV2LT52aXJ0LmZ3X3Jl
c2VydmUucF9wZjJ2ZiA9CiAJCQkoc3RydWN0IGFtZF9zcmlvdl9tc2dfcGYydmZfaW5mb19oZWFk
ZXIgKikKLQkJCShhZGV2LT5md192cmFtX3VzYWdlLnZhICsgKEFNRF9TUklPVl9NU0dfUEYyVkZf
T0ZGU0VUX0tCIDw8IDEwKSk7CisJCQkoYWRldi0+bW1hbi5md192cmFtX3VzYWdlX3ZhICsgKEFN
RF9TUklPVl9NU0dfUEYyVkZfT0ZGU0VUX0tCIDw8IDEwKSk7CiAJCWFkZXYtPnZpcnQuZndfcmVz
ZXJ2ZS5wX3ZmMnBmID0KIAkJCShzdHJ1Y3QgYW1kX3NyaW92X21zZ192ZjJwZl9pbmZvX2hlYWRl
ciAqKQotCQkJKGFkZXYtPmZ3X3ZyYW1fdXNhZ2UudmEgKyAoQU1EX1NSSU9WX01TR19WRjJQRl9P
RkZTRVRfS0IgPDwgMTApKTsKKwkJCShhZGV2LT5tbWFuLmZ3X3ZyYW1fdXNhZ2VfdmEgKyAoQU1E
X1NSSU9WX01TR19WRjJQRl9PRkZTRVRfS0IgPDwgMTApKTsKIAogCQlhbWRncHVfdmlydF9yZWFk
X3BmMnZmX2RhdGEoYWRldik7CiAJCWFtZGdwdV92aXJ0X3dyaXRlX3ZmMnBmX2RhdGEoYWRldik7
Ci0tIAoyLjI1LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
