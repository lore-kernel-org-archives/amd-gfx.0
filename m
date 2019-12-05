Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3711DC2D0C2
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177B322525
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 13:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177B322525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD3DF6F8A3;
	Thu,  5 Dec 2019 13:39:48 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F23FF6E84C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 13:39:46 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id a15so3609096wrf.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Dec 2019 05:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rXokNPLUZstfKfGYIpcgoXXRhfyGXjZYMOhIAoMghJs=;
 b=UtWFqaPxl3xQKwKGIK/BZnR3BQ02YvZ73oJfKScHlNqaKcwmQgzWUMnta/e/f5QTSq
 NWCLip6W/P1oCex+6yTuS2Prb0Nfq806uqvHiNA6BvnriOFAEFXESgXKaCbP0LFmvFIt
 WKA3+ug8Im1tKcnTU7LIcXwhoym2oVksIg89J460/tPQ/ao1SLuajkyhOOPwasxU/Yk5
 E2Ta4YUEGdSK1C84U+g2dL7woC2p79+d4OltT2RcLvWvQt6dyZLbgL9IVcD6q0tLZXZi
 7+6tflnmv1PA3H8PiOeLhZQMonO97KU+uX2WTVJ4wGsIRuUyuXKiWS4wl/hrSCz8imJb
 qLng==
X-Gm-Message-State: APjAAAXGETqmACAfMccUghl+DuQQJMMvRbDlmJm/D7Z2dzdfLo9f+3sh
 YlXEzqzmD3Oe8ZU9jXLJ2gfc9ECC
X-Google-Smtp-Source: APXvYqxZ/f39M1P1xDVu/JsiCJOR/sb+FUpW97AZbCmcRsaI53uXj5Jm6e2tIS+GEWqBsq9mqkoouQ==
X-Received: by 2002:adf:ea05:: with SMTP id q5mr10382956wrm.48.1575553185571; 
 Thu, 05 Dec 2019 05:39:45 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:cd79:9e7:bab3:4698])
 by smtp.gmail.com with ESMTPSA id z189sm11219565wmc.2.2019.12.05.05.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 05:39:45 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, philip.yang@amd.com, Alex.Sierra@amd.com,
 felix.kuehling@amd.com
Subject: [PATCH 5/5] drm/amdgpu: immedially invalidate PTEs
Date: Thu,  5 Dec 2019 14:39:40 +0100
Message-Id: <20191205133940.3865-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205133940.3865-1-christian.koenig@amd.com>
References: <20191205133940.3865-1-christian.koenig@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rXokNPLUZstfKfGYIpcgoXXRhfyGXjZYMOhIAoMghJs=;
 b=hnsVm3ZXK1ogqU15DDmRW0BbNFnpfDooI+XNm/jc9hyk/AP7acIrzXPlIubBh+00Pe
 6wr71jgoLk29lNcZ1LDEfWuq+8VCnLB7bzEzl+fZhfeQs/f2kilcNuPtcMjZDZ/hYTrU
 YAPtm6xVtJPY7LXtAQZ866BfxBbc/bRX5iKSzWbIKDZmAsTcz6wVny/sLPjpSD18q4Sq
 KdZD38tEX9H1WyRHlixG0ONFvNNhOp65qbPDr/dIGBxZVWVQuEiPd8cdidiQbYWaxOd2
 8w6EBoiugED+Q2HHH9iIFAlQrnyCjRmTvs6agK0EpcuX6LO7hDB1pOpqt1L+g+AkGNqI
 Xlxw==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

V2hlbiBhIEJPIGlzIGV2aWN0ZWQgaW1tZWRpYWxseSBpbnZhbGlkYXRlIHRoZSBtYXBwZWQgUFRF
cy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1k
LmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyB8IDE3ICsr
KysrKysrKysrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMKaW5kZXggODM5ZDZk
ZjM5NGZjLi5lNTc4MTEzYmZkNTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV92bS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
bS5jCkBAIC0yNTY1LDYgKzI1NjUsNyBAQCB2b2lkIGFtZGdwdV92bV9ib19pbnZhbGlkYXRlKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQkJICAgICBzdHJ1Y3QgYW1kZ3B1X2JvICpibywg
Ym9vbCBldmljdGVkKQogewogCXN0cnVjdCBhbWRncHVfdm1fYm9fYmFzZSAqYm9fYmFzZTsKKwlp
bnQgcjsKIAogCS8qIHNoYWRvdyBibyBkb2Vzbid0IGhhdmUgYm8gYmFzZSwgaXRzIHZhbGlkYXRp
b24gbmVlZHMgaXRzIHBhcmVudCAqLwogCWlmIChiby0+cGFyZW50ICYmIGJvLT5wYXJlbnQtPnNo
YWRvdyA9PSBibykKQEAgLTI1NzIsOCArMjU3MywyMiBAQCB2b2lkIGFtZGdwdV92bV9ib19pbnZh
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
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
