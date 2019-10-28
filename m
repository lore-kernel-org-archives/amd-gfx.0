Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E293CCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8898217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8898217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F456EA46;
	Mon, 28 Oct 2019 21:42:57 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CE36EA46
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:42:56 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id t11so1883652ybk.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yV5ocChfB15i3h3vkFYf66EH5nCtL8JXl6no9YXSWAw=;
 b=QcHplynZhHeAzaGPnPVrKotAaWuEiJ1yrAnvkpjnbx27r8aspdpKSh5Ud/8NLTFWKY
 043+5JqHIGk+uH/R0M9+FCDBxf0jFWTGdYceFP7iC+q6BJtqRBpr3PxwpgEW/6rEcmpU
 F0dHWn8tn0keqW1ZaMSZCNAlSwx8eHUAqhryF21rFCAcmspbzq/crGbe8j8vq7ZQuzWo
 FN1mYcTzNeE9rzEKNB4ocbEasCc4U7NUwsnlUx2KxdF0j4zLgEkaVjj/p4JFfz0Ndea+
 eZO9HQiX3Q6jhgWzoM6dDE7MAzt9XY2otuz86oHPo3siwF+zlcC56drVFPs32Mb2X8hD
 Ob6Q==
X-Gm-Message-State: APjAAAVe993qOcxRMYvByjRpuPap3VXlwksCq4QyvdhXIJ93vBlfo6Jv
 5ZEDR4O6DAWodaLJnNdMeRZsZBy1WU0=
X-Google-Smtp-Source: APXvYqxvUfVjc28XtRXei4FM9SMxthPc7Dx0Zjj/Y7yXvHCOlW2RH0UKlGcBVlGq8AgYLj63MhHMdg==
X-Received: by 2002:a25:2506:: with SMTP id l6mr16148266ybl.220.1572298974876; 
 Mon, 28 Oct 2019 14:42:54 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:42:54 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 02/21] drm/amdgpu/soc15: move struct definition around to
 align with other soc15 asics
Date: Mon, 28 Oct 2019 17:41:57 -0400
Message-Id: <20191028214216.1508370-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yV5ocChfB15i3h3vkFYf66EH5nCtL8JXl6no9YXSWAw=;
 b=EQgZ4y+sSISdWFXBRoVfOS0GDcxErtQKQdrusskioPHXlNOImH7XN/1j7cfyvfwxWW
 NheQOIHdKAbrkumsycQVnfA8w9MJ2yXAA4mDQG763bwUa4w7BQ4m+BBGl5fhdTNR3Cdo
 fcueMP86FXPTiEWPizWqJhWQh6UW/OGSSFgh3DFA9Og1KDPc2Ya+XLnRjslCREvXIryo
 MpEvu7WvSazWzXRqr5zr1HiheWZlIqAV57AqyL+e3mdbnhOS5JEwzcjQBqhad6H66Udr
 DskbcIlDSGLdFj8379xwd5b6vSSdQkrZmqH7H8NltMUYISIzp47ZAhJfQWgXbuHj4/fJ
 ZtUA==
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
Message-ID: <20191028214157.hAugJy2Pjb6NLSTrYwE3ZVhCr9saJe7fHth-QSK4avU@z>

TW92ZSByZXNldF9tZXRob2QgbmV4dCB0byByZXNldCBjYWxsYmFjayB0byBtYXRjaCB0aGUgc3Ry
dWN0IGxheW91dCBhbmQKdGhlIG90aGVyIGRlZmluaXRpb24gaW4gdGhpcyBmaWxlLgoKU2lnbmVk
LW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zb2MxNS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc29jMTUu
YwppbmRleCA3NDFiNTY0YjRhYTUuLmY3MTQ2MDExYTc4NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9n
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
