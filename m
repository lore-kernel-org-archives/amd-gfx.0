Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E952C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D262075A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0KZuEr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D262075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BACAC6E48C;
	Mon,  6 Jan 2020 15:03:51 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A066E48B
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 15:03:48 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id q6so49864867wro.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 07:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=l4Jpb6yOWVD0O5G3kF4ZyEt2TgsxrWcVZ5IhWK34/C0=;
 b=J0KZuEr/65EekqdnezGkyBOe7nSZeq4JNWzfCf9Tvvx6UiVRQEFapjYbk6ZiSYH1rj
 eKoaNIJ1OBsYyIC8EOdgV+A4eTIwE/dZi2XVKkp6YlfJ2eLioz5Ws7qo3FXKYoyCuhDh
 qR4J51ZvvtqMaUKho8qVfLmby8qp2OUH7o+4PnR5U2tzTcJyL4Fns55DHWcj93+6Xaw5
 liZekRiZ+5N8YKbdbU9ChpsKjcK0Kspo4oOeQgctUTMhXwiJd+y+fdpDF1UecCLVZue8
 CbD7cLQwqmOTKHVJ7m288ARLpFr4Mr7KUlRIPL79hCk9+gQoIxOMIcrHfu5BeVJqrIKY
 adjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l4Jpb6yOWVD0O5G3kF4ZyEt2TgsxrWcVZ5IhWK34/C0=;
 b=GhF9WxDiJnR7sWY4gTgMgccPeakJNFDBDCWNWi3FgGLT6rLpUyXZeYE4fko3BBLvob
 TmPma4cPlmPCDvkOaJy5CICwpQ1484+9AJchc17POtF1YFCgxwcc8FkOss8ib5x3ffAx
 EIFBt0TYdCDCBhW1n2LdiOL/MdnN0iPjiJ6OQTCYdoB0iVKe2nn+raCtFqMZfKSMhg6r
 Ph9P7bxdF8zaT0bxDTjqQO3MgT8tTQHvvKkyVPNfHXSwFiyigxuvttp8YPSCWNHv/6EY
 It8v88IgS9oKDq0w0AaK7e/5mvjaJdLU8KTBf7Jk0o/VeS8kW/bhhEHfMiaEeDGHKxQV
 fLQQ==
X-Gm-Message-State: APjAAAU3/E0REoNd2IZeEO+B2u5f90HbuBa/+aPOEEb3znuEbGKDfcIE
 IBCHacWH3ENXQg0cTzJnOyvohAXA
X-Google-Smtp-Source: APXvYqxOYE8XlY3Bh0W7cs12vPK9s1HT+Q8sZbJhEIeGzg31XB2WJ3h/4WeoTmwM0ZWWDz+ibjLlZQ==
X-Received: by 2002:a5d:4c8c:: with SMTP id z12mr73367726wrs.222.1578323027771; 
 Mon, 06 Jan 2020 07:03:47 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:ece2:ff95:11ee:3e72])
 by smtp.gmail.com with ESMTPSA id b17sm70307444wrp.49.2020.01.06.07.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 07:03:47 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alex.Sierra@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/12] drm/amdgpu: immedially invalidate PTEs
Date: Mon,  6 Jan 2020 16:03:33 +0100
Message-Id: <20200106150335.1738-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106150335.1738-1-christian.koenig@amd.com>
References: <20200106150335.1738-1-christian.koenig@amd.com>
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

V2hlbiBhIEJPIGlzIGV2aWN0ZWQgaW1tZWRpYWxseSBpbnZhbGlkYXRlIHRoZSBtYXBwZWQgUFRF
cy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDE3ICsr
KysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggYTAzY2Zi
ZTY3MGM0Li42ODQ0YmE3NDY3YTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCkBAIC0yNTY5LDYgKzI1NjksNyBAQCB2b2lkIGFtZGdwdV92bV9ib19pbnZhbGlkYXRlKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICpibywg
Ym9vbCBldmljdGVkKQogewogCXN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqYm9fYmFzZTsKKwlp
bnQgcjsKIAogCS8qIHNoYWRvdyBibyBkb2Vzbid0IGhhdmUgYm8gYmFzZSwgaXRzIHZhbGlkYXRp
b24gbmVlZHMgaXRzIHBhcmVudCAqLwogCWlmIChiby0+cGFyZW50ICYmIGJvLT5wYXJlbnQtPnNo
YWRvdyA9PSBibykKQEAgLTI1NzYsOCArMjU3NywyMiBAQCB2b2lkIGFtZGdwdV92bV9ib19pbnZh
bGlkYXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCiAJZm9yIChib19iYXNlID0gYm8t
PnZtX2JvOyBib19iYXNlOyBib19iYXNlID0gYm9fYmFzZS0+bmV4dCkgewogCQlzdHJ1Y3QgYW1k
Z3B1X3ZtICp2bSA9IGJvX2Jhc2UtPnZtOworCQlzdHJ1Y3QgZG1hX3Jlc3YgKnJlc3YgPSB2bS0+
cm9vdC5iYXNlLmJvLT50Ym8uYmFzZS5yZXN2OworCisJCWlmIChiby0+dGJvLnR5cGUgIT0gdHRt
X2JvX3R5cGVfa2VybmVsKSB7CisJCQlzdHJ1Y3QgYW1kZ3B1X2JvX3ZhICpib192YTsKKworCQkJ
Ym9fdmEgPSBjb250YWluZXJfb2YoYm9fYmFzZSwgc3RydWN0IGFtZGdwdV9ib192YSwKKwkJCQkJ
ICAgICBiYXNlKTsKKwkJCXIgPSBhbWRncHVfdm1fYm9fdXBkYXRlKGFkZXYsIGJvX3ZhLAorCQkJ
CQkJYm8tPnRiby5iYXNlLnJlc3YgIT0gcmVzdik7CisJCQlpZiAoIXIpIHsKKwkJCQlhbWRncHVf
dm1fYm9faWRsZShib19iYXNlKTsKKwkJCQljb250aW51ZTsKKwkJCX0KKwkJfQogCi0JCWlmIChl
dmljdGVkICYmIGJvLT50Ym8uYmFzZS5yZXN2ID09IHZtLT5yb290LmJhc2UuYm8tPnRiby5iYXNl
LnJlc3YpIHsKKwkJaWYgKGV2aWN0ZWQgJiYgYm8tPnRiby5iYXNlLnJlc3YgPT0gcmVzdikgewog
CQkJYW1kZ3B1X3ZtX2JvX2V2aWN0ZWQoYm9fYmFzZSk7CiAJCQljb250aW51ZTsKIAkJfQotLSAK
Mi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
