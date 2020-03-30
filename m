Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF19C43331
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C7D220780
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 13:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDa6zM9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C7D220780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44C26E37C;
	Mon, 30 Mar 2020 13:55:39 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C37DB6E37C;
 Mon, 30 Mar 2020 13:55:38 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id a25so21790280wrd.0;
 Mon, 30 Mar 2020 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kTeqaiyCWZY+thusThODpJJysJcyTUotX8DRb+rDV4k=;
 b=BDa6zM9v6srpOCnw0SCjhfn8tmhynuCn7KLZPCzW/rcGP/0R5/PZ0dTNsSeLfA5B7r
 QQ4trYEoyka+Mfc0KOfm9TIxV/MfSuvqxDWMpW5dVDwL/5BwvvbmH5LFE0xFOxP/+zFI
 aoDz91YakmWTQfJzIIrsFf49EHeG52UdeiSETGwLVXYDSPtJDuSzznvic3gvNh8SAHyN
 xlcX427Qk0yTLyfN9dVwcfj+ZuA2d5Ba0b6f3LCqRKnd2G9D3B2tcdhvTX30RxxthXNM
 l/tTs7Dmxg+4L+NHQHmYQBGtR29VAMICHZHnxWLH+sNBgvPu8qtZoaiycdkigzG/1Y2h
 2ibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kTeqaiyCWZY+thusThODpJJysJcyTUotX8DRb+rDV4k=;
 b=bYC+crwC4qdJyLyUn7Y9hozjyhlDCeDtGiX632VRuI/+Gbxik6M1dINDIS+FUuwbwC
 tQ/7gqwpWULsKF5gLKYwqTGXVnrAkJHmHhvcgmMFrf2dEEv6scYwNAUOTfC2xduQNWwZ
 YnNPgi9d3KRW6Trv5PkiTibd+iJx6DN95Nl9waapmklenVjP5h6dTzGWIaqsgbXhTYCn
 MyJIk7wpJbRRUznjPTr7peZZK5mnEcKujr7h61RhFtoDA1FtKGuuSfIkgck1LvYrLpH0
 g8nemgPrv6TpQL8OHzLQIzz+Z2qt5xgks6zo/wPy1thaZQ+ewVzjvz/pI97KxtdVzJJk
 n3XA==
X-Gm-Message-State: ANhLgQ2G3wWeP6PhPE2as3XfLzZU57iTDmGWHy7iE4jHeHoVzX+2sAoD
 rWulU2APn4050/PpmhFl1huf9CbA
X-Google-Smtp-Source: ADFU+vs+Ur+n66fkzBbeRSW4sDWu4dPNaCr7m+9swB1rQTXcNii/MWdqlvF11cGPjyve1DRhb6tYIw==
X-Received: by 2002:a5d:65c4:: with SMTP id e4mr14166138wrw.147.1585576537244; 
 Mon, 30 Mar 2020 06:55:37 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:f999:5819:bfe0:10e8])
 by smtp.gmail.com with ESMTPSA id z16sm22267660wrr.56.2020.03.30.06.55.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2020 06:55:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch
Subject: [PATCH 1/6] dma-buf: add peer2peer flag
Date: Mon, 30 Mar 2020 15:55:31 +0200
Message-Id: <20200330135536.2997-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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

QWRkIGEgcGVlcjJwZWVyIGZsYWcgbm90aW5nIHRoYXQgdGhlIGltcG9ydGVyIGNhbiBkZWFsIHdp
dGggZGV2aWNlCnJlc291cmNlcyB3aGljaCBhcmUgbm90IGJhY2tlZCBieSBwYWdlcy4KClNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0t
CiBkcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jIHwgIDIgKysKIGluY2x1ZGUvbGludXgvZG1hLWJ1
Zi5oICAgfCAxMCArKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jIGIvZHJpdmVycy9kbWEtYnVm
L2RtYS1idWYuYwppbmRleCBjY2M5ZWRhMWJjMjguLjU3MGM5MjMwMjNlNiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYworKysgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5j
CkBAIC02OTAsNiArNjkwLDggQEAgZG1hX2J1Zl9keW5hbWljX2F0dGFjaChzdHJ1Y3QgZG1hX2J1
ZiAqZG1hYnVmLCBzdHJ1Y3QgZGV2aWNlICpkZXYsCiAKIAlhdHRhY2gtPmRldiA9IGRldjsKIAlh
dHRhY2gtPmRtYWJ1ZiA9IGRtYWJ1ZjsKKwlpZiAoaW1wb3J0ZXJfb3BzKQorCQlhdHRhY2gtPnBl
ZXIycGVlciA9IGltcG9ydGVyX29wcy0+YWxsb3dfcGVlcjJwZWVyOwogCWF0dGFjaC0+aW1wb3J0
ZXJfb3BzID0gaW1wb3J0ZXJfb3BzOwogCWF0dGFjaC0+aW1wb3J0ZXJfcHJpdiA9IGltcG9ydGVy
X3ByaXY7CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5oIGIvaW5jbHVkZS9s
aW51eC9kbWEtYnVmLmgKaW5kZXggMWFkZTQ4NmZjMmJiLi44MmUwYTRhNjQ2MDEgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5oCisrKyBiL2luY2x1ZGUvbGludXgvZG1hLWJ1Zi5o
CkBAIC0zMzQsNiArMzM0LDE0IEBAIHN0cnVjdCBkbWFfYnVmIHsKICAqIEF0dGFjaG1lbnQgb3Bl
cmF0aW9ucyBpbXBsZW1lbnRlZCBieSB0aGUgaW1wb3J0ZXIuCiAgKi8KIHN0cnVjdCBkbWFfYnVm
X2F0dGFjaF9vcHMgeworCS8qKgorCSAqIEBhbGxvd19wZWVyMnBlZXI6CisJICoKKwkgKiBJZiB0
aGlzIGlzIHNldCB0byB0cnVlIHRoZSBpbXBvcnRlciBtdXN0IGJlIGFibGUgdG8gaGFuZGxlIHBl
ZXIKKwkgKiByZXNvdXJjZXMgd2l0aG91dCBzdHJ1Y3QgcGFnZXMuCisJICovCisJYm9vbCBhbGxv
d19wZWVyMnBlZXI7CisKIAkvKioKIAkgKiBAbW92ZV9ub3RpZnkKIAkgKgpAQCAtMzYyLDYgKzM3
MCw3IEBAIHN0cnVjdCBkbWFfYnVmX2F0dGFjaF9vcHMgewogICogQG5vZGU6IGxpc3Qgb2YgZG1h
X2J1Zl9hdHRhY2htZW50LCBwcm90ZWN0ZWQgYnkgZG1hX3Jlc3YgbG9jayBvZiB0aGUgZG1hYnVm
LgogICogQHNndDogY2FjaGVkIG1hcHBpbmcuCiAgKiBAZGlyOiBkaXJlY3Rpb24gb2YgY2FjaGVk
IG1hcHBpbmcuCisgKiBAcGVlcjJwZWVyOiB0cnVlIGlmIHRoZSBpbXBvcnRlciBjYW4gaGFuZGxl
IHBlZXIgcmVzb3VyY2VzIHdpdGhvdXQgcGFnZXMuCiAgKiBAcHJpdjogZXhwb3J0ZXIgc3BlY2lm
aWMgYXR0YWNobWVudCBkYXRhLgogICogQGltcG9ydGVyX29wczogaW1wb3J0ZXIgb3BlcmF0aW9u
cyBmb3IgdGhpcyBhdHRhY2htZW50LCBpZiBwcm92aWRlZAogICogZG1hX2J1Zl9tYXAvdW5tYXBf
YXR0YWNobWVudCgpIG11c3QgYmUgY2FsbGVkIHdpdGggdGhlIGRtYV9yZXN2IGxvY2sgaGVsZC4K
QEAgLTM4Miw2ICszOTEsNyBAQCBzdHJ1Y3QgZG1hX2J1Zl9hdHRhY2htZW50IHsKIAlzdHJ1Y3Qg
bGlzdF9oZWFkIG5vZGU7CiAJc3RydWN0IHNnX3RhYmxlICpzZ3Q7CiAJZW51bSBkbWFfZGF0YV9k
aXJlY3Rpb24gZGlyOworCWJvb2wgcGVlcjJwZWVyOwogCWNvbnN0IHN0cnVjdCBkbWFfYnVmX2F0
dGFjaF9vcHMgKmltcG9ydGVyX29wczsKIAl2b2lkICppbXBvcnRlcl9wcml2OwogCXZvaWQgKnBy
aXY7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
