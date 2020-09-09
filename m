Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CEDC43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 11:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026A721D7A
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 11:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elq6F5B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026A721D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5406EE39;
	Wed,  9 Sep 2020 11:16:59 +0000 (UTC)
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com
 [IPv6:2a00:1450:4864:20::644])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB7AA6EE39
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 11:16:57 +0000 (UTC)
Received: by mail-ej1-x644.google.com with SMTP id gr14so2996829ejb.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Sep 2020 04:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6vCT69XW4r1qiEe7By+NqDnIDtqhGxNZo/lm72whq+4=;
 b=elq6F5B4ypxHDGJ8jyJkCSLFzpEGxrgzCkzbkhP3tultZW2anK7EbXr4sZfe37KTA3
 madlKIviqzu8mzr81bSvRKPatDZy/CvrlKOvgJ3IFo7cjt5QowmIHa+0pVK0pUdDbs7k
 Qe7E1tyuiFMn+UCvR1Kb/JyFtyO3VnW2Amls4YEP2XmFXIH3Dj3V4sPWs6w1eEvGIstk
 CV9POfz2z2JTCEUjdICagWl0STMq2tIuvzkwa52pFnuqCl4mnB+H5tt3S4YezsGboT1N
 x0X0cdFKPfJ3gMsEFNvVdKsqp96ScZY0pdeYpiW967zVXlq/xonAXAldkBp++OWey9PQ
 XyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6vCT69XW4r1qiEe7By+NqDnIDtqhGxNZo/lm72whq+4=;
 b=J2b9bRMnShAJhMPlP5FuPo227kHwok7EymThpCp13pRXjCd7AiHKeVqfWRLVYHeKlH
 IcMxxndJlAKu+nILS/cMAWZx8j1cnV3p7KVvDK4iaZyFazNVupZh0ugSnMrf8AVc8JcD
 NHhY1XFy0YrJQ+jvIZF4gzZfitWBNU7iwDg3teZYAYtqVEcBGxKgA1r8TxL7+7ODqtCN
 MZwvItkAh9keLpzUD8gXPrf+9WRJvNCT1ZD+esQeFniBkJpd3bQWRLa2uaqgzwGd8WiR
 Go+fDK9OSIK54aGbeCEuvqJfU8iIB225GTSIKpGqQopVvPoIkwxXmD3C7DZdBy7paTqc
 L9fA==
X-Gm-Message-State: AOAM533C/xm20VIcOuM+L6t2NSumMy9J2UZicnKuu+anfn3CRy4OV14d
 91FrJLlRu7PT8NvL+SRy/0A=
X-Google-Smtp-Source: ABdhPJw3WoNd4JhiJDBDAa+cwroBhkSwOYYpx8koXOrCyALEsogcevFZcm+HJehHs4RyuTsWZdQ1ig==
X-Received: by 2002:a17:906:aecb:: with SMTP id
 me11mr3243865ejb.217.1599650216652; 
 Wed, 09 Sep 2020 04:16:56 -0700 (PDT)
Received: from baker.fritz.box ([2a02:908:1252:fb60:5fdc:b66d:b691:bfd5])
 by smtp.gmail.com with ESMTPSA id re19sm1774374ejb.86.2020.09.09.04.16.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Sep 2020 04:16:56 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: kai.heng.feng@canonical.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: revert "Prefer lower feedback dividers"
Date: Wed,  9 Sep 2020 13:16:55 +0200
Message-Id: <20200909111655.1102-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.14.1
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

VHVybnMgb3V0IHRoaXMgYnJlYWtzIGEgbG90IG9mIGRpZmZlcmVudCBoYXJkd2FyZS4KClRoaXMg
cmV2ZXJ0cyBjb21taXQgNTIyZmYzYThiNmQ3M2EzMTA4NGI0YjA4N2I0NThmN2ZhMGFjMWUxNC4K
ClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKaW5kZXggN2I2OWQ2ZGZlNDRhLi5lMGFlOTExZWY0
MjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rpc3BsYXkuYwor
KysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKQEAgLTkzMyw3ICs5
MzMsNyBAQCBzdGF0aWMgdm9pZCBhdml2b19nZXRfZmJfcmVmX2Rpdih1bnNpZ25lZCBub20sIHVu
c2lnbmVkIGRlbiwgdW5zaWduZWQgcG9zdF9kaXYsCiAKIAkvKiBnZXQgbWF0Y2hpbmcgcmVmZXJl
bmNlIGFuZCBmZWVkYmFjayBkaXZpZGVyICovCiAJKnJlZl9kaXYgPSBtaW4obWF4KGRlbi9wb3N0
X2RpdiwgMXUpLCByZWZfZGl2X21heCk7Ci0JKmZiX2RpdiA9IG1heChub20gKiAqcmVmX2RpdiAq
IHBvc3RfZGl2IC8gZGVuLCAxdSk7CisJKmZiX2RpdiA9IERJVl9ST1VORF9DTE9TRVNUKG5vbSAq
ICpyZWZfZGl2ICogcG9zdF9kaXYsIGRlbik7CiAKIAkvKiBsaW1pdCBmYiBkaXZpZGVyIHRvIGl0
cyBtYXhpbXVtICovCiAJaWYgKCpmYl9kaXYgPiBmYl9kaXZfbWF4KSB7Ci0tIAoyLjE0LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFp
bGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
