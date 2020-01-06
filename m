Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC872C33C9E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35D62075A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 15:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ/+fs3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35D62075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352BD6E483;
	Mon,  6 Jan 2020 15:03:45 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDA7C6E480
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 15:03:43 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id d73so15275120wmd.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 07:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=6GRb/2uvU0LDkpEan2eFVgDU/bgqoAzPjNMkm/OdpVc=;
 b=DJ/+fs3eqAhX2vGbV8d80p/jCkjJL5mXSFOAaz3cFV3Yfokac3uJ7H22scJ4nBeDxc
 Yay6KWkP9WPytKWzdkUwW+SMmjNYqKdiA6nDGOAOqslFyvuGWqg+jaQVI/3SPmS/xRxT
 83HGHfFUbRo2yaktasEzSPWmBfUNjc/CVX1LZv5JcUsx9PgVEK92NCccg6zpzfqY9unk
 ePvgyqB+E0pn0EPGjKhGAx3+QFNV8CM2NX/aUyihXT7awG08kb+wDXIrf3BVoH1dEuIo
 Cjt97dLx7aGc3LKajo6Ex+fP+/4qNzPoOs8P3V4AypyAfkNUcIpxZ/By+ZLTa82rvOsm
 h4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6GRb/2uvU0LDkpEan2eFVgDU/bgqoAzPjNMkm/OdpVc=;
 b=dgZcT86dnx+gwZj3ut4lbIkJDRXKQw8k+Y3XHhlAotMWruIpSMqq0O79pezptqRRG0
 r6mLqXFfstgn/fK1cZ/BruhfIHKGXGlxp2p89uiateVtYPZe+jQqTSHWI1057TJEnEja
 VJ4t6Unh23DyCJ/Tb1fqYCb48VSpaUYzKMwXJfe7kwCNbKbwr8y51Sp7g2s/OaPHw/Hz
 YKZZcqNF83ggv7le33bQ42guv3bFkhG1ZpUN0ipWKkcDpimSdiyGCuEjPxFeXnfc6ZjX
 M3Usam4g9TPnhtR5Xooi4qpqcM13YJrTeKdFJUPP981JEQnGycxIc90DYDMjzhLNo73K
 Hc8A==
X-Gm-Message-State: APjAAAWJ/3M52zl46CsLUvHx8u+EqFZmnO03jEMifTZ8aWNLy4NKm4RQ
 wxK2qqDI7g/mDbkh2/d8D9lMG1ga
X-Google-Smtp-Source: APXvYqwxESByEKm0bX2E4WzE680seXmpWbH+e5F2A86GGwGhMLMmKHGv6h3vnLvtqTGrjBJ4dd/ZeA==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr34583372wmq.142.1578323022617; 
 Mon, 06 Jan 2020 07:03:42 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:ece2:ff95:11ee:3e72])
 by smtp.gmail.com with ESMTPSA id b17sm70307444wrp.49.2020.01.06.07.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 07:03:42 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alex.Sierra@amd.com, Philip.Yang@amd.com, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/12] drm/amdgpu: drop amdgpu_job.owner
Date: Mon,  6 Jan 2020 16:03:27 +0100
Message-Id: <20200106150335.1738-5-christian.koenig@amd.com>
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

RW50aXJlbHkgdW51c2VkLgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0
aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jcy5jICB8IDEgLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jIHwg
MSAtCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmggfCAxIC0KIDMgZmls
ZXMgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3MuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9jcy5jCmluZGV4IDYxNDkxOWYyNjViOS4uYzRhODE0OGI5YjZmIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3MuYwpAQCAtMTIzMyw3ICsxMjMzLDYgQEAgc3RhdGljIGludCBh
bWRncHVfY3Nfc3VibWl0KHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAogCQlnb3RvIGVycm9y
X2Fib3J0OwogCX0KIAotCWpvYi0+b3duZXIgPSBwLT5maWxwOwogCXAtPmZlbmNlID0gZG1hX2Zl
bmNlX2dldCgmam9iLT5iYXNlLnNfZmVuY2UtPmZpbmlzaGVkKTsKIAogCWFtZGdwdV9jdHhfYWRk
X2ZlbmNlKHAtPmN0eCwgZW50aXR5LCBwLT5mZW5jZSwgJnNlcSk7CmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfam9iLmMKaW5kZXggNzMzMjhkMGM3NDFkLi5kNDJiZTg4MGEyMzYgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMKQEAgLTE1Myw3ICsxNTMsNiBA
QCBpbnQgYW1kZ3B1X2pvYl9zdWJtaXQoc3RydWN0IGFtZGdwdV9qb2IgKmpvYiwgc3RydWN0IGRy
bV9zY2hlZF9lbnRpdHkgKmVudGl0eSwKIAlpZiAocikKIAkJcmV0dXJuIHI7CiAKLQlqb2ItPm93
bmVyID0gb3duZXI7CiAJKmYgPSBkbWFfZmVuY2VfZ2V0KCZqb2ItPmJhc2Uuc19mZW5jZS0+Zmlu
aXNoZWQpOwogCWFtZGdwdV9qb2JfZnJlZV9yZXNvdXJjZXMoam9iKTsKIAlwcmlvcml0eSA9IGpv
Yi0+YmFzZS5zX3ByaW9yaXR5OwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2pvYi5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5o
CmluZGV4IGFhMGUzNzUwNjJmMi4uMzFjNDQ0NGIwMjAzIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2pvYi5oCkBAIC00OSw3ICs0OSw2IEBAIHN0cnVjdCBhbWRncHVfam9iIHsK
IAl1aW50MzJfdAkJcHJlYW1ibGVfc3RhdHVzOwogCXVpbnQzMl90ICAgICAgICAgICAgICAgIHBy
ZWVtcHRpb25fc3RhdHVzOwogCXVpbnQzMl90CQludW1faWJzOwotCXZvaWQJCQkqb3duZXI7CiAJ
Ym9vbCAgICAgICAgICAgICAgICAgICAgdm1fbmVlZHNfZmx1c2g7CiAJdWludDY0X3QJCXZtX3Bk
X2FkZHI7CiAJdW5zaWduZWQJCXZtaWQ7Ci0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
