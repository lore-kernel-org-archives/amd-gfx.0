Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7286DC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 08:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9C1611F1
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 08:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9C1611F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA826E9F8;
	Thu, 15 Apr 2021 08:47:34 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BAE16E51B;
 Thu, 15 Apr 2021 08:47:33 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id r12so35669221ejr.5;
 Thu, 15 Apr 2021 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uTEJvMIv6d5A6NGqm3rSMipXKkQ55K2hXyICccxQwVI=;
 b=ajReyd7VtZ91wArsxhJdpdK+W4hILYqtvBbDKb8MXcEX//+kJFD9VS/Gpf5c5fq0E5
 WNuV8TQK1/CEjwUtIsafRxJVtdu6bn+gF9HX6PboyxfyE/UG0CLRY8Czm4B3QylLwP9r
 1yrjUlkLzrttk9qFaBbLB2kBJAomNMmCtMD2sTvjzjzC2sFbngM2CjnbSCbTDCRg/eWE
 Vve0IxIXZlL3DUcIaIP/fy+G7vBCK41BmiHiCWCfn68ilSln9V+sU+xOv5AcKXZ9xt0d
 fH0ZMAZEwNHxeT+iXad2k+KDxQMYyVoleftxT6w9pfmGH13TO6hhZGE2lmNxhUG9hAjq
 zjzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uTEJvMIv6d5A6NGqm3rSMipXKkQ55K2hXyICccxQwVI=;
 b=AFWjzu2/K7e7nSNjLHb8t6chXFHdNamLAWoFVouLtqczFPZ7DyvxMl8lpW49NXCNAF
 gjnAXA4aXYL1r+2Vc8eV+W+5OMZ7Qg2QedwqsqfePXMCq3KEpSYs2k03rP1XYYLFlnyu
 TH1HfGeFFdMDMQW12mKegNs7HZq/5D0VoCK73hfETuQPGa6tqf+mFYZeXKZkK6DtC6cV
 80uz7xXS1YE6G6MsGaOfNjW1kig7S0DJZCz6fjtbandcf4TZz0nk7H4Ba3xlZ+VPofDf
 wrPRLGs6pyItJ1oHVmvmglaB08osho8YC9xfxHf4mCmDr8ZLOFQqqKNFk1y1noYQDRlC
 d/Rw==
X-Gm-Message-State: AOAM532ktZLV0iLiWQ8WTgdvkZZMN5LPnixq32YsgaSKHv06wXNSHU2T
 nayCEV9qmqmtqrf3yuOwrZdGpa+rNiU=
X-Google-Smtp-Source: ABdhPJzgVFp/d5MVI1NVW7cjdN2d4q76ZQDjeBtydW/NyfQr/4ok2pbEy1dDILwQOxgIUDt0oZnMVw==
X-Received: by 2002:a17:907:d1b:: with SMTP id
 gn27mr2310113ejc.227.1618476451942; 
 Thu, 15 Apr 2021 01:47:31 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:3ba1:ccd9:cd93:a8ed])
 by smtp.gmail.com with ESMTPSA id a9sm1830049eds.33.2021.04.15.01.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 01:47:31 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: make sure we unpin the UVD BO
Date: Thu, 15 Apr 2021 10:47:28 +0200
Message-Id: <20210415084730.2057-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: daniel@ffwll.ch
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

UmVsZWFzaW5nIHBpbm5lZCBCT3MgaXMgaWxsZWdhbCBub3cuCgpTaWduZWQtb2ZmLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdXZkX3Y3XzAuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y3XzAu
YyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92N18wLmMKaW5kZXggN2NkNjdjYjJh
YzVmLi4xYTJiZjJjYTFiZTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L3V2ZF92N18wLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y3XzAuYwpA
QCAtMzYzLDYgKzM2Myw3IEBAIHN0YXRpYyBpbnQgdXZkX3Y3XzBfZW5jX3JpbmdfdGVzdF9pYihz
dHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcsIGxvbmcgdGltZW91dCkKIAogZXJyb3I6CiAJZG1hX2Zl
bmNlX3B1dChmZW5jZSk7CisJYW1kZ3B1X2JvX3VucGluKGJvKTsKIAlhbWRncHVfYm9fdW5yZXNl
cnZlKGJvKTsKIAlhbWRncHVfYm9fdW5yZWYoJmJvKTsKIAlyZXR1cm4gcjsKLS0gCjIuMjUuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
