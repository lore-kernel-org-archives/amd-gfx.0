Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8864C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 11:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97C6961984
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 11:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C6961984
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924B56E43C;
	Mon, 22 Mar 2021 11:22:10 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C446E43C;
 Mon, 22 Mar 2021 11:22:09 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id e14so2379921ejz.11;
 Mon, 22 Mar 2021 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g9CYU8ph0vDP0UpidKlZ96Df95ABUGKLwENhljDyRxc=;
 b=q9wd1SlO0hu+0Zp/IXf58xRiY0FL42D5GrnMw4/nce74kEHeTSibcO0DO0LBv4yZua
 geGPUuk15BRAC5RrrO50Dmyg+tznDwp6Wn5UZ2xnss51mn8eQXFYzriONrJlioNt9Y7P
 G3g5ezECGCdIC9eik908h/ok9e0feX4mDzyR6dcx6rG3v+tmYGgEaiq9uCE2iAzPWvhJ
 5TZh9ViinCYrh5L/D5Fr4piKn4NvbXF2RazmSfaIPWTrKjZsJ8EWFVGAFuc0ibFSC5wD
 +64+PWdYh8sqox8nnPEqTRBzlXeiis6Yn4Pc4RmIYt38C9fJrB3xAzQWKKktc9I06xhc
 hWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g9CYU8ph0vDP0UpidKlZ96Df95ABUGKLwENhljDyRxc=;
 b=Fi99sqseH+qBI9brtO7hLTa6SfoK4jjSwA4llTVCKl57cGq0Sn5JdsfrItq3H0zNpz
 +BhK/fkxj6J153W53ILmS40DBtPFhnroatGN7gxX6woVGoPb19foHOHUIpQb6nAjqjJB
 Zu2lvif3QwDH4v/qrzq//kJdLplwc9lvZEvfY/K+IjRhqOX8TwA1YfndC2eJhyxzo7fk
 zzCHrUiWNdk4CBg1vwgZDJefoEnti3q4fJVlW4N9LvIEVO97eFsr6TAJVU8UhFFWG4oo
 37i46/v2159APgcddy0JiEQU3nqmg88lL4t24H47JS3J4U6liKP2La3b3jUXw8QQmRP8
 EjhA==
X-Gm-Message-State: AOAM532Yyl/sK9ncJlmDGNzjPGOmD8SNJ5hpO+BEiGAgZTh+2laMgJS3
 G+cEKGozghqtrstWAR1Pu6qc6WlQaCk=
X-Google-Smtp-Source: ABdhPJy2++XZNY8lWbmzOXxG4x3DsN2g7IGZadDlk+dD1NYQ27/BTObov+K1bEpf5EJnkqF7IIL4wQ==
X-Received: by 2002:a17:906:c143:: with SMTP id
 dp3mr16922605ejc.499.1616412128529; 
 Mon, 22 Mar 2021 04:22:08 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:9d51:daf9:5d58:3f40])
 by smtp.gmail.com with ESMTPSA id f19sm11296349edu.12.2021.03.22.04.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Mar 2021 04:22:07 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/ttm: stop warning on TT shrinker failure v2
Date: Mon, 22 Mar 2021 12:22:06 +0100
Message-Id: <20210322112206.4574-1-christian.koenig@amd.com>
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
Cc: Liang.Liang@amd.com, daniel@ffwll.ch
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RG9uJ3QgcHJpbnQgYSB3YXJuaW5nIHdoZW4gd2UgZmFpbCB0byBhbGxvY2F0ZSBhIHBhZ2UgZm9y
IHN3YXBwaW5nIHRoaW5ncyBvdXQuCgp2Mjogb25seSBzdG9wIHRoZSB3YXJuaW5nCgpTaWduZWQt
b2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fdHQuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90
dG0vdHRtX3R0LmMgYi9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90dC5jCmluZGV4IDJmMDgzM2M5
OGQyYy4uNDhiOWE2NTA2MzBiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdHRtL3R0bV90
dC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3R0LmMKQEAgLTM2OSw3ICszNjksNyBA
QCBzdGF0aWMgdW5zaWduZWQgbG9uZyB0dG1fdHRfc2hyaW5rZXJfc2NhbihzdHJ1Y3Qgc2hyaW5r
ZXIgKnNocmluaywKIAl9OwogCWludCByZXQ7CiAKLQlyZXQgPSB0dG1fYm9fc3dhcG91dCgmY3R4
LCBHRlBfTk9GUyk7CisJcmV0ID0gdHRtX2JvX3N3YXBvdXQoJmN0eCwgR0ZQX05PRlMgfCBfX0dG
UF9OT1dBUk4pOwogCXJldHVybiByZXQgPCAwID8gU0hSSU5LX0VNUFRZIDogcmV0OwogfQogCi0t
IAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
