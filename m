Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C8CC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 14:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7F92084F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 14:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7F92084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BF38944A;
	Mon, 11 Nov 2019 14:58:36 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2C86E223;
 Mon, 11 Nov 2019 14:58:35 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id f2so14926805wrs.11;
 Mon, 11 Nov 2019 06:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UOKMXl1v/cdQ85AtU5u2QsWEeOdXlwQ0JOYVlGA0JJY=;
 b=i66Gaid3dfvWyGaiknL3Q5jP3R8kwBe8xegDW2Ob2iFdMNnFKIfGQK8S+VCc3STv8P
 Sb3PQkzyqRQPQJZcAH45c0bDSIANVJ/IlRjwhm+RoPt9HJ5qbGkgmJImgdzMt6RoSDBs
 YJ5H3EylMQi4NRSefyivMHXtbDVCCVuieqNuoh7ySWgAgLvV3+df3gYCwYigcS9kTOf7
 XVP37E2ItPYWXQeLymkXfb86kqajv6Jn0WjYY0U6ZPO8Z5q15wKPYu7ovPl0HDs4aVjw
 4V6V3j8enzhYS14/BkHGhd15NzO5jQ5bGqmKLfZWGGLOsDPYY06ExaGVJzcKAB3kEN97
 O/+w==
X-Gm-Message-State: APjAAAUctK49/6qHmcTkMuYZxs38imorxzUJ2xUt0gBVfK9VTedBxDjK
 Pvho5vDobxGQKokSfVGOJny2Fc8j
X-Google-Smtp-Source: APXvYqy753W1OdlFw3oKdNXQzhE88xlEuTfDRnkpLc604aFJTCjMA680ErvrDk8FcehKhs8O8D9Q9Q==
X-Received: by 2002:a5d:538d:: with SMTP id d13mr19692485wrv.304.1573484314234; 
 Mon, 11 Nov 2019 06:58:34 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:5d5a:1834:5ed:1958])
 by smtp.gmail.com with ESMTPSA id t185sm22967069wmf.45.2019.11.11.06.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 06:58:33 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Kevin1.Wang@amd.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/ttm: refine ghost BO resv criteria
Date: Mon, 11 Nov 2019 15:58:29 +0100
Message-Id: <20191111145832.37320-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=UOKMXl1v/cdQ85AtU5u2QsWEeOdXlwQ0JOYVlGA0JJY=;
 b=VaqMLtzGuYkG5ncnp9W8eM6AAAIzGB6LssvTskRUC5h7BDgZEufo/gdJJAQSbzESV/
 rvyM6vPthhc/LOmGqfA+TX1UV6I5yxGNI6s6XGs7w3EcRHdrZL92l1tQoAwwi85eAgFn
 vb9qF7wX+Czmxotqn3WmNt8wHi2ZpYl4LIm56i7z7AgDmiKd94H4joF//TD58nvbLblA
 O9uv4WbMxbpLyi7gix4FaPbKk8NAhOgLAfssVJ3MLVbxuYFt4qRKAYYCBA6idnctPnTZ
 e4Z9HisKvp/zF7UZMIr1T6Xci1X3mG+Yjf1+poOPCWvV7IZ/eJEs+BaATOnRT/0u5AEq
 DXEg==
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
Message-ID: <20191111145829.npLKRyx84JPJeX6Ahly17ROUOnKOKwhN_bfU-iPp7Vk@z>

R2hvc3QgQk9zIG5lZWQgdG8gc3RpY2sgd2l0aCB0aGUgcmVzdiBvYmplY3Qgb25seSB3aGVuIHRo
ZSBvcmlnaW4gaXMgaW1wb3J0ZWQuCgpUaGlzIGlzIGEgbG93IGhhbmdpbmcgZnJ1aXQgdG8gYXZv
aWQgT09NIHNpdHVhdGlvbnMgb24gZXZpY3Rpb25zLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFu
IEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX2JvX3V0aWwuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0
aWwuYyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYwppbmRleCAyYjBlNWEwODhk
YTAuLjg2ZDE1MjQ3MmYzOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fYm9f
dXRpbC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvX3V0aWwuYwpAQCAtNTExLDcg
KzUxMSw3IEBAIHN0YXRpYyBpbnQgdHRtX2J1ZmZlcl9vYmplY3RfdHJhbnNmZXIoc3RydWN0IHR0
bV9idWZmZXJfb2JqZWN0ICpibywKIAlrcmVmX2luaXQoJmZiby0+YmFzZS5rcmVmKTsKIAlmYm8t
PmJhc2UuZGVzdHJveSA9ICZ0dG1fdHJhbnNmZXJlZF9kZXN0cm95OwogCWZiby0+YmFzZS5hY2Nf
c2l6ZSA9IDA7Ci0JaWYgKGJvLT5iYXNlLnJlc3YgPT0gJmJvLT5iYXNlLl9yZXN2KQorCWlmIChi
by0+dHlwZSAhPSB0dG1fYm9fdHlwZV9zZykKIAkJZmJvLT5iYXNlLmJhc2UucmVzdiA9ICZmYm8t
PmJhc2UuYmFzZS5fcmVzdjsKIAogCWRtYV9yZXN2X2luaXQoJmZiby0+YmFzZS5iYXNlLl9yZXN2
KTsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
aHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
