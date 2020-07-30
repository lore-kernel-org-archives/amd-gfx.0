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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0ECC433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2EB207F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 20:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8vPWeAf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2EB207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3DD6E967;
	Thu, 30 Jul 2020 20:04:40 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B11B6E960
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 20:04:38 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id w9so21312391qts.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IMX0bbaXjdhitPmkT39qtDB4M3iFe31KWAtRm6msT4c=;
 b=C8vPWeAf4L6q39wsywO2C4xXJk1G5vNsOqBNfvRJym2jCeQ134YQg0EwJ0QR1AJmXO
 0yl9AzJsqnC69RSoG38UGgDnZwiIuy+qeOg+5/7CBLambE+ZL7+nltiL4YIDLqofyOJI
 jaeC2629baw7nryOryNhIMjqxRJ4J2LaBGl3+zFm2k9vXOJjDH/wmhde8uo8bhJF1UcE
 2NwvgqnLn5Msmtt6hU4tAvYSMVTA0kYwquFBQG0H7/9fqiwmltgjkc4dTBDOuy20tlOI
 Im5Ms7UPTRRil1Q6u8O/k8/d48XYNQgzA+wHGRYMElFZOmD9JbAJDtBoDJQ1fUwGH8gl
 gMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IMX0bbaXjdhitPmkT39qtDB4M3iFe31KWAtRm6msT4c=;
 b=Z5EHuHwh55Gxhwhju/bZGRZRtmL8VrOzXaBPQDJVnQq44bJ8kNdlSlSfH/B7MBJSkg
 z1RKxCWAkdTHHbQaF4NAEucXXxSP6YmVS1iO5lfQ3DhP4rTXTDt5sjwkta0Jb44tbNAb
 raHLi3QdDRly6aORA2zjeCrgkZeCX+e7F72RTOVudi8daAlXITydd9llODAjr0FGlDXc
 qxBDuS8zke4a2V8VnKDGPDJc+CBxvyzG+1NS0nBMI74N1MNX0mcH9Wlw/lbq7o13PWmM
 8mhIQ7Li1vxVmcn7HPsUrgamK2fGxRo2hplIRvqYl++9EDwJ1VPXvvaTW0F+RnvmE1KT
 zxMg==
X-Gm-Message-State: AOAM533hEIlq9+tkVGQStXXrUQEU12o225JPCS7ip4lOSw5/5HkqPxQm
 sQyNxfe0TrVv04+4b8WT9So/QKmK
X-Google-Smtp-Source: ABdhPJxdzAc9KUTopuNy3/vf9gknbP+OM/mCb0h0VsuAPbtHmBCLKLza/e4vcRoGtE8n2M8N8T5ubg==
X-Received: by 2002:ac8:1e82:: with SMTP id c2mr321806qtm.315.1596139476745;
 Thu, 30 Jul 2020 13:04:36 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d8sm5652757qtr.12.2020.07.30.13.04.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 13:04:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/17] drm/amdgpu: drop the CPU pointers for the stolen vga bos
Date: Thu, 30 Jul 2020 16:04:10 -0400
Message-Id: <20200730200414.40485-14-alexander.deucher@amd.com>
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

V2UgbmV2ZXIgdXNlIHRoZW0uCgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1
ZWhsaW5nQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRt
LmMgfCAxNiArKysrKy0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
LCAxMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdHRtLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMK
aW5kZXggZWM5NzUyNTFiMTcxLi4zZGY5ZDVhNTM3NDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfdHRtLmMKQEAgLTE5MTUsNyArMTkxNSw2IEBAIGludCBhbWRncHVfdHRtX2lu
aXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJdWludDY0X3QgZ3R0X3NpemU7CiAJaW50
IHI7CiAJdTY0IHZpc192cmFtX2xpbWl0OwotCXZvaWQgKnN0b2xlbl92Z2FfYnVmLCAqc3RvbGVu
X2V4dGVuZGVkX2J1ZjsKIAogCW11dGV4X2luaXQoJmFkZXYtPm1tYW4uZ3R0X3dpbmRvd19sb2Nr
KTsKIApAQCAtMTk4MiwxNCArMTk4MSwxNCBAQCBpbnQgYW1kZ3B1X3R0bV9pbml0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQogCXIgPSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbF9hdChhZGV2
LCAwLCBhZGV2LT5nbWMuc3RvbGVuX3ZnYV9zaXplLAogCQkJCSAgICAgICBBTURHUFVfR0VNX0RP
TUFJTl9WUkFNLAogCQkJCSAgICAgICAmYWRldi0+Z21jLnN0b2xlbl92Z2FfbWVtb3J5LAotCQkJ
CSAgICAgICAmc3RvbGVuX3ZnYV9idWYpOworCQkJCSAgICAgICBOVUxMKTsKIAlpZiAocikKIAkJ
cmV0dXJuIHI7CiAJciA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsX2F0KGFkZXYsIGFkZXYtPmdt
Yy5zdG9sZW5fdmdhX3NpemUsCiAJCQkJICAgICAgIGFkZXYtPmdtYy5zdG9sZW5fZXh0ZW5kZWRf
c2l6ZSwKIAkJCQkgICAgICAgQU1ER1BVX0dFTV9ET01BSU5fVlJBTSwKIAkJCQkgICAgICAgJmFk
ZXYtPmdtYy5zdG9sZW5fZXh0ZW5kZWRfbWVtb3J5LAotCQkJCSAgICAgICAmc3RvbGVuX2V4dGVu
ZGVkX2J1Zik7CisJCQkJICAgICAgIE5VTEwpOwogCWlmIChyKQogCQlyZXR1cm4gcjsKIApAQCAt
MjA0OCwxMyArMjA0NywxMCBAQCBpbnQgYW1kZ3B1X3R0bV9pbml0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogICovCiB2b2lkIGFtZGdwdV90dG1fbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVf
ZGV2aWNlICphZGV2KQogewotCXZvaWQgKnN0b2xlbl92Z2FfYnVmLCAqc3RvbGVuX2V4dGVuZGVk
X2J1ZjsKLQogCS8qIHJldHVybiB0aGUgVkdBIHN0b2xlbiBtZW1vcnkgKGlmIGFueSkgYmFjayB0
byBWUkFNICovCiAJaWYgKCFhZGV2LT5nbWMua2VlcF9zdG9sZW5fdmdhX21lbW9yeSkKLQkJYW1k
Z3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5nbWMuc3RvbGVuX3ZnYV9tZW1vcnksIE5VTEwsICZz
dG9sZW5fdmdhX2J1Zik7Ci0JYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5nbWMuc3RvbGVu
X2V4dGVuZGVkX21lbW9yeSwgTlVMTCwKLQkJCSAgICAgICZzdG9sZW5fZXh0ZW5kZWRfYnVmKTsK
KwkJYW1kZ3B1X2JvX2ZyZWVfa2VybmVsKCZhZGV2LT5nbWMuc3RvbGVuX3ZnYV9tZW1vcnksIE5V
TEwsIE5VTEwpOworCWFtZGdwdV9ib19mcmVlX2tlcm5lbCgmYWRldi0+Z21jLnN0b2xlbl9leHRl
bmRlZF9tZW1vcnksIE5VTEwsIE5VTEwpOwogfQogCiAvKioKQEAgLTIwNjIsMTUgKzIwNTgsMTMg
QEAgdm9pZCBhbWRncHVfdHRtX2xhdGVfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikK
ICAqLwogdm9pZCBhbWRncHVfdHRtX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiB7
Ci0Jdm9pZCAqc3RvbGVuX3ZnYV9idWY7Ci0KIAlpZiAoIWFkZXYtPm1tYW4uaW5pdGlhbGl6ZWQp
CiAJCXJldHVybjsKIAogCWFtZGdwdV90dG1fdHJhaW5pbmdfcmVzZXJ2ZV92cmFtX2ZpbmkoYWRl
dik7CiAJLyogcmV0dXJuIHRoZSBzdG9sZW4gdmdhIG1lbW9yeSBiYWNrIHRvIFZSQU0gKi8KIAlp
ZiAoYWRldi0+Z21jLmtlZXBfc3RvbGVuX3ZnYV9tZW1vcnkpCi0JCWFtZGdwdV9ib19mcmVlX2tl
cm5lbCgmYWRldi0+Z21jLnN0b2xlbl92Z2FfbWVtb3J5LCBOVUxMLCAmc3RvbGVuX3ZnYV9idWYp
OworCQlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPmdtYy5zdG9sZW5fdmdhX21lbW9yeSwg
TlVMTCwgTlVMTCk7CiAJLyogcmV0dXJuIHRoZSBJUCBEaXNjb3ZlcnkgVE1SIG1lbW9yeSBiYWNr
IHRvIFZSQU0gKi8KIAlhbWRncHVfYm9fZnJlZV9rZXJuZWwoJmFkZXYtPmRpc2NvdmVyeV9tZW1v
cnksIE5VTEwsIE5VTEwpOwogCWFtZGdwdV90dG1fZndfcmVzZXJ2ZV92cmFtX2ZpbmkoYWRldik7
Ci0tIAoyLjI1LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
