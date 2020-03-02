Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32EBC3F2D2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:18:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B927D214DB
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 12:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2qWvBdW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B927D214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 853B488BE3;
	Mon,  2 Mar 2020 12:18:05 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C6C89083
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 12:18:04 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z15so12357243wrl.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 04:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=2OFjyUvpY4Ox6gULFi5cP/jGEfERblD9EGKoj79FqQw=;
 b=E2qWvBdWUYaia46MGxZcoMxFLeYlFnJftt5CTOxyW8nge6xAkH8q3LK7hrXq8QrmlD
 F38MUfrrn4DyQNRFUGwHNmiZyA0dp4wrUM39QnzjPnJ6xSWRsALgGSr5Pu/O0Q7Arhrz
 vMc4XACvgktF0w5ZJa9T3mZdwhIdzZCZJBFjJsFEPXzGUI5nKa1SYH4RdzxPWv9YEftp
 unJj79H4rC5YyqkuhPK2Rntj5JBWZ5x105zXlcFTt9PqB2zDfQs8O9CeUYEUZ5eDK09y
 i/fA/G0QrBHBkzIouinsHum9C9177sc/Kdz2rTJ+Kq6rlnfrXD3y0yOEuZnN88uX6T7q
 mzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2OFjyUvpY4Ox6gULFi5cP/jGEfERblD9EGKoj79FqQw=;
 b=C24090OM1oe2XSHsPFUhG97Cis+FFUVqYsvx0Ffk3ozWMp4LGkBVtgj2bCvwbt/ptd
 PBGxuIwmQOL1sxQNgTB4AzH+dIQ6DXfHplD5yu07eqtB02yVALw5pbg70S0utWTfI0JP
 6udeYJIcpOUcr4ciS+BG+Bwb/I6vuuEJRNna0Sv3pS/HDEAFj58YjmYQfsv0KE7bpf0x
 tEGgNqN6QQuZQ22UJ+eHEwRmQh0ZH4CIKfOuXa1MA0ONEI7YHWls8wk5SojHZQsCH896
 +AvdDrWCxKKWIWzdygXX0el3qeDhc3WWxg7TkhOSVAUu7bJPk1TEITohO8bG2TS1FLvU
 t5WA==
X-Gm-Message-State: APjAAAVc0CCXmTUQ0hzm2IpNCFpnvQ2M2fHMqCxp6EO6T5IH/fU3zyBT
 EYGsWDO6/rVu17OqcDfIVVS+c+Xe
X-Google-Smtp-Source: APXvYqw+blQN29oQe+YyEvbny8+xpxmLXJM8XIO8btC3xB1OpQaH1MwFKKR+oCStjAhvNviEjHDucA==
X-Received: by 2002:adf:fa05:: with SMTP id m5mr22577520wrr.352.1583151482427; 
 Mon, 02 Mar 2020 04:18:02 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:1cef:40a0:b16c:8c99])
 by smtp.gmail.com with ESMTPSA id b186sm15190969wmb.40.2020.03.02.04.18.01
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:18:01 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: also add the TMZ flag to GART
Date: Mon,  2 Mar 2020 13:17:57 +0100
Message-Id: <20200302121759.13003-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200302121759.13003-1-christian.koenig@amd.com>
References: <20200302121759.13003-1-christian.koenig@amd.com>
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

VGhpcyBpcyBuZWNlc3NhcnkgZm9yIFRNWiBoYW5kbGluZyBkdXJpbmcgYnVmZmVyIG1vdmVzIGFu
ZCBzY2Fub3V0LgoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtv
ZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
YyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCmluZGV4IDY2MDg2N2NmMjU5Ny4uMThmNmNhYTdiNmEy
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCkBAIC0xMDMzLDYgKzEw
MzMsOSBAQCBpbnQgYW1kZ3B1X3R0bV9nYXJ0X2JpbmQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFk
ZXYsCiAJc3RydWN0IGFtZGdwdV90dG1fdHQgKmd0dCA9ICh2b2lkICopdHRtOwogCWludCByOwog
CisJaWYgKGFtZGdwdV9ib19lbmNyeXB0ZWQoYWJvKSkKKwkJZmxhZ3MgfD0gQU1ER1BVX1BURV9U
TVo7CisKIAlpZiAoYWJvLT5mbGFncyAmIEFNREdQVV9HRU1fQ1JFQVRFX01RRF9HRlg5KSB7CiAJ
CXVpbnQ2NF90IHBhZ2VfaWR4ID0gMTsKIAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
