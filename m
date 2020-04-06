Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824B1C2BA80
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 19:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 632BD206F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 19:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAWrTQpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632BD206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1144589B97;
	Mon,  6 Apr 2020 19:42:12 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A685B89B97
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 19:42:10 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id l25so9482429qkk.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Apr 2020 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DVcVw2+XyarjLliJhsWbk6Q+A4rEQZQLlrQ6mwENqLU=;
 b=NAWrTQpU9z1FzQHFypjlpm0r6nUpn4uhOvlOMqh0GMp5CY+40xEfFABK6mtg44ZVaN
 Z+4QJdrEBUAak/momf4dsXLDaz5hn9xWFORkfPAw/c43f51WEwLkK34uJ3gdNapsnQFI
 WfDCnwk7b1mPfgyU3iLOovyOcwUIEAvIDAx8EuEV55mNnJ9mNASFq/dFIcKq5/FV0xvI
 vhvX/mTmLsoVTOyTErHrrh2Hb1nZolCoGTaD1eBOQTO++T/6PZDsUC8xCv3z3mvMfnli
 nlXp5g4y2XNnyxPqe8sopxJmo/vai3bQangq00OLrjyM4lTKYdb31VYy/9xgChQK1BH0
 1vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DVcVw2+XyarjLliJhsWbk6Q+A4rEQZQLlrQ6mwENqLU=;
 b=dZLvlyuo8mIssjl6k22/uHzsvfvGmWEe7E1JfPoBwnHrQcWob30Zyn0Vzb5fnjkkYV
 3rt9/nApPKZfF18re6Nb2Sdo2ejOynZLCzmWz2Zz7GrvZ0mo4Ovs4YqPfveaIOQ6r8XN
 mlBiAFqs9qNXpCdNi9jS6SwmPwarb/1wXoUmbJWjLw63ST3JU6I6GMuXHutgAzc0I2Zj
 zxwfLzAYd0iC4BaybT/RFFydIRm0LLVeFe8xGghkdRo7yQQuEkprzqkqdST2am4rsTKk
 9WlgPncH66ahTwM1mKyBxepkMVsQqR5g9QFsV8Pa3s7d7R8rpyCLe4yR8hgPLUVsflVu
 ggMQ==
X-Gm-Message-State: AGi0PubeRZUJKuZTAxJgEAMaQ7zjqKxWnpj6jCwt/3XyWXaq02g1dyy5
 aMFakthivqRQtoAby8akuGNb2/ke
X-Google-Smtp-Source: APiQypIWVjqg/SrJqtr1Az8CQIC+itQCYKBI+NiaqwBhkUbAt8MgrMTrSiUTv+DVAzj05q+ewNFzfg==
X-Received: by 2002:a37:9544:: with SMTP id x65mr21445577qkd.48.1586202129416; 
 Mon, 06 Apr 2020 12:42:09 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id z6sm11246360qkl.95.2020.04.06.12.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 12:42:08 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/P2PDMA: Add additional AMD ZEN root ports to the whitelist
Date: Mon,  6 Apr 2020 15:42:01 -0400
Message-Id: <20200406194201.846411-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNjb3JkaW5nIHRvIHRoZSBodyBhcmNoaXRlY3QsIHByZS1aRU4gcGFydHMgc3VwcG9ydApwMnAg
d3JpdGVzIGFuZCBaRU4gcGFydHMgc3VwcG9ydCBib3RoIHAycCByZWFkcyBhbmQgd3JpdGVzLgoK
QWRkIGVudHJpZXMgZm9yIFplbiBwYXJ0cyBSYXZlbiAoMHgxNWQwKSBhbmQgUmVub2lyICgweDE2
MzApLgoKQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQWNr
ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRy
aXZlcnMvcGNpL3AycGRtYS5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3AycGRtYS5jIGIvZHJpdmVycy9wY2kvcDJwZG1h
LmMKaW5kZXggOWE4YTM4Mzg0MTIxLi45MWE0Yzk4NzM5OWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
cGNpL3AycGRtYS5jCisrKyBiL2RyaXZlcnMvcGNpL3AycGRtYS5jCkBAIC0yODIsNiArMjgyLDgg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfcDJwZG1hX3doaXRlbGlzdF9lbnRyeSB7CiB9IHBj
aV9wMnBkbWFfd2hpdGVsaXN0W10gPSB7CiAJLyogQU1EIFpFTiAqLwogCXtQQ0lfVkVORE9SX0lE
X0FNRCwJMHgxNDUwLAkwfSwKKwl7UENJX1ZFTkRPUl9JRF9BTUQsCTB4MTVkMCwJMH0sCisJe1BD
SV9WRU5ET1JfSURfQU1ELAkweDE2MzAsCTB9LAogCiAJLyogSW50ZWwgWGVvbiBFNS9Db3JlIGk3
ICovCiAJe1BDSV9WRU5ET1JfSURfSU5URUwsCTB4M2MwMCwgUkVRX1NBTUVfSE9TVF9CUklER0V9
LAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
