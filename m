Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B1C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECC22192A
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcaJfdEb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECC22192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6EDB6F611;
	Wed,  5 Feb 2020 15:40:18 +0000 (UTC)
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com
 [IPv6:2607:f8b0:4864:20::c43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F8B89EEB;
 Wed,  5 Feb 2020 15:40:16 +0000 (UTC)
Received: by mail-yw1-xc43.google.com with SMTP id 192so2795828ywy.0;
 Wed, 05 Feb 2020 07:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bkYRQmfYepBStIDdFbUMKhxcQfkGtWaInDgOAE3QheI=;
 b=FcaJfdEbFBtxNjMOuOSLT7Iy3Bscftke9zGm4bTAj+hStl0FX/fjf/seVkfh+JldbW
 WsxZ61sl15zGteV31pHrPJVbI8zHdIMt7v0oC7IXqW25oRRPYwFU8DvBXxnlq8B9atx5
 ahfYk6Tncg8yLzkjmRUJThAJfxjqPDbDV7/Y0ZtUhoCN5NoA/Jith/t5/DiM8HJbngw5
 rs9FxhDgBr7rqUq2h66cKS+Vr/KJeIpUhT2ksNKzV38FCSeemL7l7Qbr8RU9Sinbbn2H
 839NYSmvK+4b/ORxB07UXHbJra4JhrCtgBncF7HgaAFSbFyZaMxtmG8lNRlZ6G0afA/7
 pkew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bkYRQmfYepBStIDdFbUMKhxcQfkGtWaInDgOAE3QheI=;
 b=FJa9JqgNxn7igRzGUQR6xHkR5bZcj0y/vctFQasr7boWSxrhxPRwBQSZSnSE7TBCnC
 7aVOk6ZlmXvPmKU+WotyuHC+83CqOvgAW2bToJg1rnvlrNWKEgBxwa6UbPl9Abqj9VhW
 wn90/t+I5eWWE9mC2C/dCNXytKDyBMwBe3lBfiu7kgarN0UbQj7yFn3VnSMjThA8EXYn
 JA/OKnX51QQV4hkTX0p64ubHYo4ej5YJiPpPYSW2ApBeYUbOZ1D0N7/BI6ZAMpC66lHO
 TJao1MIIW1dHCsq/yP8XFFHR5dXmS5uGIhrOCLuMubdZ6Gb2XQmsWD1fQNjsvha9Gjcd
 xA7g==
X-Gm-Message-State: APjAAAWfRpP1SwbJ4hFhsCnhSTcV4oDZP4rQj/SZohQeKXt0EnBIIbnc
 zCaXyN31C8OU7HeXEK8gnLDG9hEJ
X-Google-Smtp-Source: APXvYqykyvtAvsIDtqhme53U7k6Ed3SAv9zRptrt4IB6qc+JOo6zh9LkCPF9DFhldBH6SpSQFGTl6A==
X-Received: by 2002:a25:56:: with SMTP id 83mr21901620yba.80.1580917215801;
 Wed, 05 Feb 2020 07:40:15 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q185sm61256ywh.61.2020.02.05.07.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 07:40:15 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 07/15] drm/amdgpu/regs: move debugfs init into core amdgpu
 debugfs
Date: Wed,  5 Feb 2020 10:39:52 -0500
Message-Id: <20200205154000.536145-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205154000.536145-1-alexander.deucher@amd.com>
References: <20200205154000.536145-1-alexander.deucher@amd.com>
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
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SW4gb3JkZXIgdG8gcmVtb3ZlIHRoZSBsb2FkIGFuZCB1bmxvYWQgZHJtIGNhbGxiYWNrcywKd2Ug
bmVlZCB0byByZW9yZGVyIHRoZSBpbml0IHNlcXVlbmNlIHRvIG1vdmUgYWxsIHRoZSBkcm0KZGVi
dWdmcyBmaWxlIGhhbmRsaW5nLiAgRG8gdGhpcyBmb3IgcmVnaXN0ZXIgYWNjZXNzIGZpbGVzLgoK
QWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0K
IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgfCA0ICsrKysKIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyAgfCA0IC0tLS0KIDIgZmls
ZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2ZzLmMgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGVidWdmcy5jCmluZGV4IGNiN2RiN2VkZmMzZi4uNzcy
MWYxNDE2Y2RiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGVidWdmcy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZWJ1Z2Zz
LmMKQEAgLTEyNTIsNiArMTI1MiwxMCBAQCBpbnQgYW1kZ3B1X2RlYnVnZnNfaW5pdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZSAqYWRldikKIAlpZiAocikKIAkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyBn
ZW0gZGVidWdmcyBmYWlsZWQgKCVkKS5cbiIsIHIpOwogCisJciA9IGFtZGdwdV9kZWJ1Z2ZzX3Jl
Z3NfaW5pdChhZGV2KTsKKwlpZiAocikKKwkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyByZWdpc3Rl
ciBkZWJ1Z2ZzIGZhaWxlZCAoJWQpLlxuIiwgcik7CisKIAlyZXR1cm4gYW1kZ3B1X2RlYnVnZnNf
YWRkX2ZpbGVzKGFkZXYsIGFtZGdwdV9kZWJ1Z2ZzX2xpc3QsCiAJCQkJCUFSUkFZX1NJWkUoYW1k
Z3B1X2RlYnVnZnNfbGlzdCkpOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2RldmljZS5jCmluZGV4IDY0YTI3NTY2NGM3Mi4uZDg0YTYxZTE4YmY4IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0zMDkxLDEwICszMDkxLDYgQEAg
aW50IGFtZGdwdV9kZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl9IGVs
c2UKIAkJYWRldi0+dWNvZGVfc3lzZnNfZW4gPSB0cnVlOwogCi0JciA9IGFtZGdwdV9kZWJ1Z2Zz
X3JlZ3NfaW5pdChhZGV2KTsKLQlpZiAocikKLQkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyByZWdp
c3RlciBkZWJ1Z2ZzIGZhaWxlZCAoJWQpLlxuIiwgcik7Ci0KIAlyID0gYW1kZ3B1X2RlYnVnZnNf
ZmlybXdhcmVfaW5pdChhZGV2KTsKIAlpZiAocikKIAkJRFJNX0VSUk9SKCJyZWdpc3RlcmluZyBm
aXJtd2FyZSBkZWJ1Z2ZzIGZhaWxlZCAoJWQpLlxuIiwgcik7Ci0tIAoyLjI0LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
