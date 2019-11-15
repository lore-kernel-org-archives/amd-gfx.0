Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E74C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1FDE2073B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 15:29:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1FDE2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989AD6E082;
	Fri, 15 Nov 2019 15:29:01 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 732DE6E082
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 15:28:59 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id m4so8366357qke.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 07:28:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ivT2rk+6yB1I4M+KMTsFOf7T7srL0/oHd3STVcWTJvY=;
 b=SHUo4hTbMjraRckJGNpgkV5C6D3OvgUMTedp6u3gO4Ce25oeG05Ym2ab1CvwVyT8gm
 FfzBXEVrDgc479BiSju+Wz3CbQNUti+xFUO8fOH/9p/Xb7qqY0SZ5IVfJoXvzRdx7REV
 iR101RK9q8C++XSLSZrAGodsL3U5gP07iV4gwgrW4kWt+qrA92UD6MxmYrf47sKqtum+
 weNs0cuXOA1aKQHyhdsddQiVae6pXDBRR1haCzR9XwKP/16xcPukFJ16+bDGk533PoBa
 kLeJLG47PoLG3JrxAOS4wLEONia3xB1qwkyVXXuH121VT3RNfOkUxNajSUWYo80tyPPS
 S9dA==
X-Gm-Message-State: APjAAAUUern99y49jyGV9Bbl8FUFSEe2qmEiHhoGX8SYLJwyHq1mZKeE
 ZPbhPTrtvCf0ckSi7Mk0oE5fCV+H
X-Google-Smtp-Source: APXvYqxyQ0jormJmOf67L0PKrpJC7xRFL6doWacJ4mRuCTV4iuDuwqMjxGyOzYZIGmul9HgLPvd/dQ==
X-Received: by 2002:a37:7c83:: with SMTP id
 x125mr13175873qkc.409.1573831738204; 
 Fri, 15 Nov 2019 07:28:58 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id n66sm4466227qkb.72.2019.11.15.07.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 07:28:57 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: disable gfxoff on original raven
Date: Fri, 15 Nov 2019 10:28:49 -0500
Message-Id: <20191115152850.618879-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ivT2rk+6yB1I4M+KMTsFOf7T7srL0/oHd3STVcWTJvY=;
 b=jHbRf88NlLiUpHmPotltuws9sjkmAKfAk1fIpXQciQdsUnJLPJW0A5H1jI9hmYLJpS
 fP2BDRyYAOoARjKDWQKTnaWT6dWlXekjUNV8P4phpD86BPSi+6iO33tWkCC/V3UQoj1K
 nI1dS+AePe7z4MpboX+g8Em/QC9rIejGhnEEeajOnjrdQJIjo6avz4rlZlPo4cyGh7yl
 v9IR7m7erBQv9KZAJ92lgL6MUlWnKUi0Mb0ONvCh9Zp4K9MaFM2nADb/j6R3AVfVXPrX
 H83PQo2/QdVWem3J9U7GJLh7evu274jma1w4Mohk4Z4zz8aJMIW+SjUtTpKM28LH5wyw
 Ie9Q==
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
Message-ID: <20191115152849.JInBSwMXWYkllrhKj05JnDbSlkpz3qqzR_IIIcjVX6c@z>

VGhlcmUgYXJlIHN0aWxsIGNvbWJpbmF0aW9ucyBvZiBzYmlvcyBhbmQgZmlybXdhcmUgdGhhdAph
cmUgbm90IHN0YWJsZS4KCkJ1ZzogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVn
LmNnaT9pZD0yMDQ2ODkKU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMg
fCA5ICsrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRleCBjN2FlNjg1ZDZm
NzQuLmE3MDM0YWYxYzQxZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
Z2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBA
IC0xMDUxLDggKzEwNTEsMTMgQEAgc3RhdGljIHZvaWQgZ2Z4X3Y5XzBfY2hlY2tfaWZfbmVlZF9n
ZnhvZmYoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJY2FzZSBDSElQX1ZFR0EyMDoKIAkJ
YnJlYWs7CiAJY2FzZSBDSElQX1JBVkVOOgotCQlpZiAoIShhZGV2LT5yZXZfaWQgPj0gMHg4IHx8
IGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDE1ZDgpCi0JCQkmJigoYWRldi0+Z2Z4LnJsY19md192
ZXJzaW9uICE9IDEwNiAmJgorCQkvKiBEaXNhYmxlIEdGWE9GRiBvbiBvcmlnaW5hbCByYXZlbi4g
IFRoZXJlIGFyZSBjb21iaW5hdGlvbnMKKwkJICogb2Ygc2Jpb3MgYW5kIHBsYXRmb3JtcyB0aGF0
IGFyZSBub3Qgc3RhYmxlLgorCQkgKi8KKwkJaWYgKCEoYWRldi0+cmV2X2lkID49IDB4OCB8fCBh
ZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHgxNWQ4KSkKKwkJCWFkZXYtPnBtLnBwX2ZlYXR1cmUgJj0g
flBQX0dGWE9GRl9NQVNLOworCQllbHNlIGlmICghKGFkZXYtPnJldl9pZCA+PSAweDggfHwgYWRl
di0+cGRldi0+ZGV2aWNlID09IDB4MTVkOCkKKwkJCSAmJigoYWRldi0+Z2Z4LnJsY19md192ZXJz
aW9uICE9IDEwNiAmJgogCQkJICAgICBhZGV2LT5nZngucmxjX2Z3X3ZlcnNpb24gPCA1MzEpIHx8
CiAJCQkgICAgKGFkZXYtPmdmeC5ybGNfZndfdmVyc2lvbiA9PSA1MzgxNSkgfHwKIAkJCSAgICAo
YWRldi0+Z2Z4LnJsY19mZWF0dXJlX3ZlcnNpb24gPCAxKSB8fAotLSAKMi4yMy4wCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcg
bGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
