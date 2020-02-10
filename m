Return-Path: <SRS0=VWwp=36=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACE8C352A4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D6D720661
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2020 15:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWeOpH93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D6D720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C0A6EC86;
	Mon, 10 Feb 2020 15:09:22 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84B436EC7F;
 Mon, 10 Feb 2020 15:09:19 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id a9so743008wmj.3;
 Mon, 10 Feb 2020 07:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5Wf9pW/W5YCKSySy2jo5lIzXzpazjir34bxpBBDXj2A=;
 b=VWeOpH93jhnTY6dqJhXeJSHHznstQNZ0opOiJ3fwnFx5s16cHp1iRkFlvo4bbDSdIF
 5b44/PT9Vy89YDMfMEb03uO1ALg0GDPHahdLd+Zta0aaf3fmXsoPQrLmJkQomVrAAnvp
 diAdH3VYkeSSFHVEP6E2F3vivkRl+uBs+mYBcQgIX/1BJVzMFnglIUoT2iDfrSoJr4Wk
 cmATAs/mf3LA84sYVypS0OjfPgyFMnw1n438EL4m1C27EfZPrBZXWRTYo7LSxFZ3y5nd
 4z33ObMe+O5UEISMDex3zaUbIqnQQbxpxpFRnRlDWawJdXlRQS7YFt5NuxhTR4XL0lT9
 sD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5Wf9pW/W5YCKSySy2jo5lIzXzpazjir34bxpBBDXj2A=;
 b=a0j2cqLwsJCm2FbZOSDakjcfXQ/O45hf+BAsv7j31kX7TWgqEYw/l7q8Yr+ieWPCOU
 UQvyRbltvwIgx8MT5f26q7x8zXXz1gn9hf99k8NTmdQFAnfhZ8aTvfiR73QkO0v0YCBd
 bPnkbvwbvLR9IobOt8zl0zA2wwGQUZsZ5mUR86PysujuFjG4byFcLKnqtA+fYgA4VTbr
 XejMpKInf5ES5hc6/3GKzklMENQdIRx6hCwWFtx4nwrdeeQmV6Z+42c+dsz2By0R/kK1
 gFqCStNLbzTkuEthHwTtj9bKZLX1nAgAyPUdaRWC7StWqwRPwlIpq0MUm3wY4lJ2BRnG
 GFZw==
X-Gm-Message-State: APjAAAVQ78AlN14yx0sSiHVZs6TSCEja3aujD0mQLHKzp+zf+ZSUc6ej
 1v7xmFBp8pd8agpNhelXaWM=
X-Google-Smtp-Source: APXvYqznw73XIKorSrsPesWtnNbklg3Bwyhjuh6gyQduj9z37UmueNtPxlblXrG/1t/CdyPEOUpRpQ==
X-Received: by 2002:a05:600c:2254:: with SMTP id
 a20mr15409627wmm.97.1581347358312; 
 Mon, 10 Feb 2020 07:09:18 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7d3b:a71c:475c:1e99])
 by smtp.gmail.com with ESMTPSA id q10sm1021996wme.16.2020.02.10.07.09.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2020 07:09:17 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH 6/6] drm/ttm: individualize resv objects before calling
 release_notify
Date: Mon, 10 Feb 2020 16:09:07 +0100
Message-Id: <20200210150907.20616-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200210150907.20616-1-christian.koenig@amd.com>
References: <20200210150907.20616-1-christian.koenig@amd.com>
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

VGhpcyBhbGxvd3MgcmVsZWFzZV9ub3RpZnkgdG8gYWRkIGFuZCByZW1vdmUgZmVuY2VzIGZyb20g
ZGVsZXRlZCBvYmplY3RzLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgfCAx
NiArKysrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX2JvLmMgYi9k
cml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCmluZGV4IDRkMTYxMDM4ZGU5OC4uNDIxNzdjY2Q3
MDM1IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV9iby5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS90dG0vdHRtX2JvLmMKQEAgLTU2OCwxNCArNTY4LDYgQEAgc3RhdGljIHZvaWQg
dHRtX2JvX3JlbGVhc2Uoc3RydWN0IGtyZWYgKmtyZWYpCiAJaW50IHJldDsKIAogCWlmICghYm8t
PmRlbGV0ZWQpIHsKLQkJaWYgKGJvLT5iZGV2LT5kcml2ZXItPnJlbGVhc2Vfbm90aWZ5KQotCQkJ
Ym8tPmJkZXYtPmRyaXZlci0+cmVsZWFzZV9ub3RpZnkoYm8pOwotCi0JCWRybV92bWFfb2Zmc2V0
X3JlbW92ZShiZGV2LT52bWFfbWFuYWdlciwgJmJvLT5iYXNlLnZtYV9ub2RlKTsKLQkJdHRtX21l
bV9pb19sb2NrKG1hbiwgZmFsc2UpOwotCQl0dG1fbWVtX2lvX2ZyZWVfdm0oYm8pOwotCQl0dG1f
bWVtX2lvX3VubG9jayhtYW4pOwotCiAJCXJldCA9IHR0bV9ib19pbmRpdmlkdWFsaXplX3Jlc3Yo
Ym8pOwogCQlpZiAocmV0KSB7CiAJCQkvKiBMYXN0IHJlc29ydCwgaWYgd2UgZmFpbCB0byBhbGxv
Y2F0ZSBtZW1vcnkgZm9yIHRoZQpAQCAtNTg0LDYgKzU3NiwxNCBAQCBzdGF0aWMgdm9pZCB0dG1f
Ym9fcmVsZWFzZShzdHJ1Y3Qga3JlZiAqa3JlZikKIAkJCWRtYV9yZXN2X3dhaXRfdGltZW91dF9y
Y3UoYm8tPmJhc2UucmVzdiwgdHJ1ZSwgZmFsc2UsCiAJCQkJCQkgIDMwICogSFopOwogCQl9CisK
KwkJaWYgKGJvLT5iZGV2LT5kcml2ZXItPnJlbGVhc2Vfbm90aWZ5KQorCQkJYm8tPmJkZXYtPmRy
aXZlci0+cmVsZWFzZV9ub3RpZnkoYm8pOworCisJCWRybV92bWFfb2Zmc2V0X3JlbW92ZShiZGV2
LT52bWFfbWFuYWdlciwgJmJvLT5iYXNlLnZtYV9ub2RlKTsKKwkJdHRtX21lbV9pb19sb2NrKG1h
biwgZmFsc2UpOworCQl0dG1fbWVtX2lvX2ZyZWVfdm0oYm8pOworCQl0dG1fbWVtX2lvX3VubG9j
ayhtYW4pOwogCX0KIAogCWlmICghZG1hX3Jlc3ZfdGVzdF9zaWduYWxlZF9yY3UoYm8tPmJhc2Uu
cmVzdiwgdHJ1ZSkpIHsKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
