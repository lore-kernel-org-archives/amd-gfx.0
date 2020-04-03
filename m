Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F40C2BA12
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 19:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63242077D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 19:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCeAYogd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63242077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D96F6E97A;
	Fri,  3 Apr 2020 19:39:32 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5382A6E97A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 19:39:31 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id 14so7268224qtp.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2020 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YbrsaLLLRjbDJgwfWeugSnYOEiShDcY8X72WHlOuTPk=;
 b=DCeAYogdI87MANA1h3xpOzT6LpTJoJLqoyipT7KkvBinzIiZzRwztvf5ZH6q2HuoHV
 SQZPAPAgKDJiIWbiIAwXqNy+F50Gdo+laYZJF52kMWO3kyuGIY47/+5EihEGv8H7DLuj
 Z6brKi6CP2/BUL2I50rIylSSVDJtOVLcdpNIciudN31BSfsz1FDUkLct1FHw2wD6XS6W
 /PoJejT4vsM8RYHBrd5UoboToNf/pu2K4VjYo85xzTC2Y6KgjlwDA4vHb14OanfRMCmC
 4GTfjnriKot+UZb//f9VYpqwBYwLV/+xuvm1/U7LrkyzJZp6dcgpvDRTlQOKArs6pEG9
 VplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YbrsaLLLRjbDJgwfWeugSnYOEiShDcY8X72WHlOuTPk=;
 b=eH8yBCILZJVjBnsPsEkG5QRqS8qhm39P7rn291eh4UWnZjADsvpWNODFY1FZ1iMTn0
 3AJszZywE9FCj5jC12bywrfLf9xm/e/UtoZ2GqctODJ6UzsgUzetixSsOFJpMSC5B67l
 Jc4OKrNPnq/ypV4rV5Qjp/X+kVhHZ0Mdo9OPVahxdSzkGEg9OVvFDE5mcK0TmwLwNCbi
 rjNT6bE51T05MiovljLWoQQCx+z8QQsdBOILkXz52L06nCb2mwAktO0U0HJBO0ave8pX
 OC9GwjzvI+rHTS6xaXfPG2QgSLVhvtN5CHJXuduR/tjhwVdArBa0rZQGEG3H4Z9AxIPo
 2ynA==
X-Gm-Message-State: AGi0PuZdTJJ3w9A8kkh/0v2y3lsXtKfrkuCI8OfLchU/f8HJpXI8Tlj1
 UXSN/UAg52bgUmminqdZwTA2OrbP
X-Google-Smtp-Source: APiQypJcXc/Gf/ZtunqNnIqww8kTfrYCWevcNPPqQljDwrMlkDpbj0LG2EcW6K4LjdF92kSCUuwguA==
X-Received: by 2002:ac8:6c5d:: with SMTP id z29mr10299731qtu.176.1585942770270; 
 Fri, 03 Apr 2020 12:39:30 -0700 (PDT)
Received: from localhost.localdomain ([71.219.40.23])
 by smtp.gmail.com with ESMTPSA id r3sm7180070qkd.3.2020.04.03.12.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 12:39:29 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] PCI/P2PDMA: Add additional AMD ZEN root ports to the whitelist
Date: Fri,  3 Apr 2020 15:38:59 -0400
Message-Id: <20200403193859.81971-1-alexander.deucher@amd.com>
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
MzApLgoKQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KU2ln
bmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0K
IGRyaXZlcnMvcGNpL3AycGRtYS5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3AycGRtYS5jIGIvZHJpdmVycy9wY2kvcDJw
ZG1hLmMKaW5kZXggOWE4YTM4Mzg0MTIxLi45MWE0Yzk4NzM5OWQgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvcGNpL3AycGRtYS5jCisrKyBiL2RyaXZlcnMvcGNpL3AycGRtYS5jCkBAIC0yODIsNiArMjgy
LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfcDJwZG1hX3doaXRlbGlzdF9lbnRyeSB7CiB9
IHBjaV9wMnBkbWFfd2hpdGVsaXN0W10gPSB7CiAJLyogQU1EIFpFTiAqLwogCXtQQ0lfVkVORE9S
X0lEX0FNRCwJMHgxNDUwLAkwfSwKKwl7UENJX1ZFTkRPUl9JRF9BTUQsCTB4MTVkMCwJMH0sCisJ
e1BDSV9WRU5ET1JfSURfQU1ELAkweDE2MzAsCTB9LAogCiAJLyogSW50ZWwgWGVvbiBFNS9Db3Jl
IGk3ICovCiAJe1BDSV9WRU5ET1JfSURfSU5URUwsCTB4M2MwMCwgUkVRX1NBTUVfSE9TVF9CUklE
R0V9LAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
