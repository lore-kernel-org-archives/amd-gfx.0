Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9BC43331
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 22:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E19CB2173B
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 22:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E19CB2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 945E46E2D8;
	Mon, 11 Nov 2019 22:21:12 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C3F6E2D8
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 22:21:11 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id v15so1461676ybp.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Nov 2019 14:21:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v6YKiI8OUi9d8R7xAnTsFV7qDuTZbkaPewn2hvTN0qM=;
 b=Szx0KyEJxMCkQeCQN05Dk180n7LATDIguFBXgpNKDGqTsKcx9cmdnUwsYlaKpa4EV3
 inXkfHbolVkZW+0R6TK6hFxX7dQyknUTZDomqvSS3xIW4G+RZ9lQANlqfrFCl8dHzVNj
 5NN9LDcopgajYZwL/bvPDkjum6LKmXJXNmcZWiD4zRVGcornlsSuDDbbCQogCk5DzlWR
 Tq07qSQcEWjCZyosvXfjyi+XRzdg3HcfMMuUOnfG1jEKWMmN7aiTxFP51PJy6Y/cHWXx
 tZwLssFZpcJOEL1MyYe24sTox7SSZpQSFLQQ+2I1LAIlB8CIOXILIlL9EkbxGArIMxG/
 jbfw==
X-Gm-Message-State: APjAAAVkZT8JtN8PIH+/OJwDrEUWRPIc7a4H7/71QTMFdmeikvGZJ/Et
 Nn82rvSPfJfHcRYhhgKjMfPli9fe
X-Google-Smtp-Source: APXvYqwnM9UJGs7XgqDRfP/T8Relki2yRSw36r9bCLvvt2clXgKa6StWpDjuB801wnv0HBr+UdlySA==
X-Received: by 2002:a25:a0d3:: with SMTP id i19mr21630952ybm.14.1573510870754; 
 Mon, 11 Nov 2019 14:21:10 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id j144sm5223493ywg.77.2019.11.11.14.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 14:21:10 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/soc15: move struct definition around to align with
 other soc15 asics
Date: Mon, 11 Nov 2019 17:21:02 -0500
Message-Id: <20191111222102.876704-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=v6YKiI8OUi9d8R7xAnTsFV7qDuTZbkaPewn2hvTN0qM=;
 b=tdyKfxqWEC4fP8RwbqZ4MT4OGQMYIRrg3NirTqsQYPtKyPll37Xup1XbZbf7XnOO7L
 hDNQTI6NIbRcJUOBWBnusSuGBkdc0OH4ioKSmM1BJ0Mtv3G9l1v6+XLNES9wp553hcrh
 S6nqggygOMzgw+kBNSQcfEMGfUa5+2snraeWHlSqrW4Ljb507FXl28Fb/scF9XsnbADc
 khFWV67iUGl3AaUjgW9Q+3zAg7Lt922lPzGEkKgUoKDhRM+1wZ5Vz3qncrcI2Yezx36I
 xs2DBZf9FOvMc2gs7H3gHGY53jzCwbRWFyRc3QJPxrkFgRTbc5HwvEOVElfrsf+9gI/+
 EGlA==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111222102.Yro3lMvrsu6TqLWdClJ9_UzC3_V3ycBrjYrmFbDJ5-4@z>

TW92ZSByZXNldF9tZXRob2QgbmV4dCB0byByZXNldCBjYWxsYmFjayB0byBtYXRjaCB0aGUgc3Ry
dWN0IGxheW91dCBhbmQKdGhlIG90aGVyIGRlZmluaXRpb24gaW4gdGhpcyBmaWxlLgoKU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUu
YwppbmRleCA4ZTE2NDBiYzA3YWYuLjMwNWFkM2VlYzk4NyAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvc29jMTUuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9zb2MxNS5jCkBAIC0xMDA3LDYgKzEwMDcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdw
dV9hc2ljX2Z1bmNzIHZlZ2EyMF9hc2ljX2Z1bmNzID0KIAkucmVhZF9iaW9zX2Zyb21fcm9tID0g
JnNvYzE1X3JlYWRfYmlvc19mcm9tX3JvbSwKIAkucmVhZF9yZWdpc3RlciA9ICZzb2MxNV9yZWFk
X3JlZ2lzdGVyLAogCS5yZXNldCA9ICZzb2MxNV9hc2ljX3Jlc2V0LAorCS5yZXNldF9tZXRob2Qg
PSAmc29jMTVfYXNpY19yZXNldF9tZXRob2QsCiAJLnNldF92Z2Ffc3RhdGUgPSAmc29jMTVfdmdh
X3NldF9zdGF0ZSwKIAkuZ2V0X3hjbGsgPSAmc29jMTVfZ2V0X3hjbGssCiAJLnNldF91dmRfY2xv
Y2tzID0gJnNvYzE1X3NldF91dmRfY2xvY2tzLApAQCAtMTAxOSw3ICsxMDIwLDYgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBhbWRncHVfYXNpY19mdW5jcyB2ZWdhMjBfYXNpY19mdW5jcyA9CiAJLmdl
dF9wY2llX3VzYWdlID0gJnZlZ2EyMF9nZXRfcGNpZV91c2FnZSwKIAkubmVlZF9yZXNldF9vbl9p
bml0ID0gJnNvYzE1X25lZWRfcmVzZXRfb25faW5pdCwKIAkuZ2V0X3BjaWVfcmVwbGF5X2NvdW50
ID0gJnNvYzE1X2dldF9wY2llX3JlcGxheV9jb3VudCwKLQkucmVzZXRfbWV0aG9kID0gJnNvYzE1
X2FzaWNfcmVzZXRfbWV0aG9kCiB9OwogCiBzdGF0aWMgaW50IHNvYzE1X2NvbW1vbl9lYXJseV9p
bml0KHZvaWQgKmhhbmRsZSkKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
