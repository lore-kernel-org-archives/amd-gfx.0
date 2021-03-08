Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8790C433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4066513A
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 13:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE4066513A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0479F89FD3;
	Mon,  8 Mar 2021 13:40:53 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC6C389FD3
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 13:40:50 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id ci14so20407084ejc.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Mar 2021 05:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=dUjz/j6vjejBLONPECEWJBuv3ldW3+qSSEhHTCoLbiw=;
 b=JkSKfwWmvPsNQFCqW3cbWTTGBm50duSP789u1VUWBDOzJ9XUMW+aK+wrGQ/AOJ2lLf
 NxQOBDfOaGB0r1FUkuZGONWsfs7oIEasuzjf66kjMkA0LhJwjsU94CmZ7TA9hmDJN7Im
 1PZNBh4XomPTgvwo1/0UD0dIpHV2/OfDAOrTzVGXrXAYHGFJc+ytAAb8oGBfXIQBzbaa
 hUXzAM8mJVIpPvoS8XiimnqYlIkshDgpw49M6R/n5v1lHVskAlbjb6/0/wxho4ElIeZU
 WE4h7p1ksLwvsFzljvzAnKp4hch++l/7/mzjy2oI2TgnUdLQ6a1L9T1rSVYPq949TRsq
 FFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dUjz/j6vjejBLONPECEWJBuv3ldW3+qSSEhHTCoLbiw=;
 b=k38RugGTLlTQBHGAYN7tvA9mSxH7GdqGoTdsqbkeuo1xWKme3GmjABVsrWHjJbXgxk
 qO9w2v+8kXPpRJ2I+vlNElXRr72aBxohhCsB4ZzLJPDSrVSYQEf4r4SDy/d+IEIh6khh
 fqN4Ev0ZpZVBtckpdlJCiWYaktC5q42rduhgkZpao/Ij6XVstWh8wt6jhn+6KnXuuUbg
 9/CCZZNih/L6D2Dh+sa4MTF5ujDJ2uCV6lXW7qXCMSwqyooKEHt7bb3wWH/tippXLWCK
 HorvIBBTuq2IvhFNG6zz07ypdM85N5l5cd7vwnnq7hg7lelMhXpfKCqtpICGA0RV78G7
 7iSQ==
X-Gm-Message-State: AOAM531XuJD5FZaaGPywp5gGUQY/C95SQlOV6nM5YwX/XdVrkHgiqKxM
 bvbvRTvmsPHHWAMEWWu7hY4JU7itQ7tHEA==
X-Google-Smtp-Source: ABdhPJw5XJadgdB+4o/8unA0rKmSKyU/xX5aDIc7ebh1P3Yy542spUrg48CVavqk8fmXd2fPZ1Ci2w==
X-Received: by 2002:a17:906:2e45:: with SMTP id
 r5mr12768681eji.380.1615210849635; 
 Mon, 08 Mar 2021 05:40:49 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f480:31ac:e949:bf58])
 by smtp.gmail.com with ESMTPSA id s18sm6655701ejc.79.2021.03.08.05.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 05:40:49 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Arunpravin.PaneerSelvam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: use new cursor in amdgpu_mem_visible
Date: Mon,  8 Mar 2021 14:40:42 +0100
Message-Id: <20210308134044.133658-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308134044.133658-1-christian.koenig@amd.com>
References: <20210308134044.133658-1-christian.koenig@amd.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U2VwYXJhdGUgdGhlIGRybV9tbV9ub2RlIHdhbGtpbmcgZnJvbSB0aGUgYWN0dWFsIGhhbmRsaW5n
LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQu
Y29tPgpBY2tlZC1ieTogT2FrIFplbmcgPE9hay5aZW5nQGFtZC5jb20+ClRlc3RlZC1ieTogTmly
bW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYyB8IDEwICsrKysrKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3R0bS5jCmluZGV4IDJjYmU0YWNlNTkxZi4uZDQ2OWJhNWZlZjJjIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCkBAIC00NDEsNyArNDQxLDggQEAgc3RhdGljIGludCBh
bWRncHVfbW92ZV9ibGl0KHN0cnVjdCB0dG1fYnVmZmVyX29iamVjdCAqYm8sCiBzdGF0aWMgYm9v
bCBhbWRncHVfbWVtX3Zpc2libGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJCQkgICAg
ICAgc3RydWN0IHR0bV9yZXNvdXJjZSAqbWVtKQogewotCXN0cnVjdCBkcm1fbW1fbm9kZSAqbm9k
ZXMgPSBtZW0tPm1tX25vZGU7CisJdWludDY0X3QgbWVtX3NpemUgPSAodTY0KW1lbS0+bnVtX3Bh
Z2VzIDw8IFBBR0VfU0hJRlQ7CisJc3RydWN0IGFtZGdwdV9yZXNfY3Vyc29yIGN1cnNvcjsKIAog
CWlmIChtZW0tPm1lbV90eXBlID09IFRUTV9QTF9TWVNURU0gfHwKIAkgICAgbWVtLT5tZW1fdHlw
ZSA9PSBUVE1fUExfVFQpCkBAIC00NDksMTIgKzQ1MCwxMyBAQCBzdGF0aWMgYm9vbCBhbWRncHVf
bWVtX3Zpc2libGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAJaWYgKG1lbS0+bWVtX3R5
cGUgIT0gVFRNX1BMX1ZSQU0pCiAJCXJldHVybiBmYWxzZTsKIAorCWFtZGdwdV9yZXNfZmlyc3Qo
bWVtLCAwLCBtZW1fc2l6ZSwgJmN1cnNvcik7CisKIAkvKiB0dG1fcmVzb3VyY2VfaW9yZW1hcCBv
bmx5IHN1cHBvcnRzIGNvbnRpZ3VvdXMgbWVtb3J5ICovCi0JaWYgKG5vZGVzLT5zaXplICE9IG1l
bS0+bnVtX3BhZ2VzKQorCWlmIChjdXJzb3Iuc2l6ZSAhPSBtZW1fc2l6ZSkKIAkJcmV0dXJuIGZh
bHNlOwogCi0JcmV0dXJuICgobm9kZXMtPnN0YXJ0ICsgbm9kZXMtPnNpemUpIDw8IFBBR0VfU0hJ
RlQpCi0JCTw9IGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6ZTsKKwlyZXR1cm4gY3Vyc29yLnN0
YXJ0ICsgY3Vyc29yLnNpemUgPD0gYWRldi0+Z21jLnZpc2libGVfdnJhbV9zaXplOwogfQogCiAv
KgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
