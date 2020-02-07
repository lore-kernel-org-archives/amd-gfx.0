Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAD2C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009FC21741
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 19:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcvGazhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009FC21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC026FD81;
	Fri,  7 Feb 2020 19:51:16 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3E86FD7F;
 Fri,  7 Feb 2020 19:51:15 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id d9so270015qte.12;
 Fri, 07 Feb 2020 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a/BMDiqhoEnI0+MK5kOQbygtLUupSGYKuie/3X93O2U=;
 b=gcvGazhIJHtvRAG65KH84s2DnIP+lIBKG2rmRvuJMwYbcPFNLqXTB7jxQvJhETtjna
 kbWbwFguMI5JLL2XzJGSMvfTjJixJrBKNy65rO1w4jIfTPcC5hLnQ4xQRSH01sXhJOnL
 gECpYe69qXq82M/feRnKHBhmtuM0fx198JWoPSA4dZLPO3mQy+l3qKuqOcT4uCUybDRh
 iT1MMRS2TPa67ERcuju4wh1ZHBD8gVylrEtv6crlpCLLACHj7H/R/SB/QGlY7oKgEw8i
 /gugSqcElvYIylVESqvwCShvKoQ57qEv76McJhntlfkPdfHvcw6aG3mVIjKD7JPHxAzj
 rm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a/BMDiqhoEnI0+MK5kOQbygtLUupSGYKuie/3X93O2U=;
 b=eiF3iSvr4LyAAEFM/ka1AMgrvlJa7946z3dT/NIwb2PCG9mL6b36p+RACf84BD/rLR
 F3kS+d7OgsHC4Nsojfec32gvZbRPSPudl4qbuHqXCDfMPH8mSfpRoFL1LtjHSgYpw2H7
 O/u/nSq7PuOkCQx/mInMC+9rSFmttKAM+CzppkYralGP0JHAHcwRSnYpDiJhOlyyZu2R
 KEmLRJQ/9mgF97FNLxcQzbnymmC3zJMFEJRCYO7uGcx7pLe3YAlXKCjciMlp+zlkm06S
 nAMz0+FoTCDg6poly5BhZ+rff2vtQ0Df9NbXSM9dbyrtqRC/0Ld5Jgm2Icgeqhjma2T8
 +T6Q==
X-Gm-Message-State: APjAAAXvlKofoetWwRCic0/GNPHL7i0NGF5chu+Zcai+zKy/K6smKNF8
 BkHzR7qunWlZR8O4N7ABkuFSGfka
X-Google-Smtp-Source: APXvYqx4lNwPhHjvDgbyj0a1AEG6sY5YOl5VqwwYKHkRePM2oddWriRhDYWdB1p9Y4ImixWRE1B4yg==
X-Received: by 2002:ac8:1e08:: with SMTP id n8mr462183qtl.175.1581105074423;
 Fri, 07 Feb 2020 11:51:14 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id w16sm1752226qkj.135.2020.02.07.11.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 11:51:13 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 09/15] drm/amdgpu: don't call drm_connector_register for
 non-MST ports
Date: Fri,  7 Feb 2020 14:50:52 -0500
Message-Id: <20200207195058.2354-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200207195058.2354-1-alexander.deucher@amd.com>
References: <20200207195058.2354-1-alexander.deucher@amd.com>
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

VGhlIGNvcmUgZG9lcyB0aGlzIGZvciB1cyBub3cuCgpBY2tlZC1ieTogQ2hyaXN0aWFuIEvDtm5p
ZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIg
PGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2Nvbm5lY3RvcnMuYyAgICB8IDEgLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZGNlX3ZpcnR1YWwuYyAgICAgICAgICB8IDEgLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDEgLQogMyBmaWxlcyBjaGFuZ2VkLCAzIGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9j
b25uZWN0b3JzLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY29ubmVjdG9y
cy5jCmluZGV4IGE2MmNiYzgxOTlkZS4uZWMxNTAxZTNhNjNhIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY29ubmVjdG9ycy5jCisrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jb25uZWN0b3JzLmMKQEAgLTE5MzEsNyArMTkzMSw2IEBA
IGFtZGdwdV9jb25uZWN0b3JfYWRkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAogCQljb25u
ZWN0b3ItPnBvbGxlZCA9IERSTV9DT05ORUNUT1JfUE9MTF9IUEQ7CiAKIAljb25uZWN0b3ItPmRp
c3BsYXlfaW5mby5zdWJwaXhlbF9vcmRlciA9IHN1YnBpeGVsX29yZGVyOwotCWRybV9jb25uZWN0
b3JfcmVnaXN0ZXIoY29ubmVjdG9yKTsKIAogCWlmIChoYXNfYXV4KQogCQlhbWRncHVfYXRvbWJp
b3NfZHBfYXV4X2luaXQoYW1kZ3B1X2Nvbm5lY3Rvcik7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9kY2VfdmlydHVhbC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZGNlX3ZpcnR1YWwuYwppbmRleCBlNGY5NDg2MzMzMmMuLjNjOWYyZDI0OTBhNSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3ZpcnR1YWwuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9kY2VfdmlydHVhbC5jCkBAIC02MDksNyArNjA5LDYgQEAg
c3RhdGljIGludCBkY2VfdmlydHVhbF9jb25uZWN0b3JfZW5jb2Rlcl9pbml0KHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2LAogCWNvbm5lY3Rvci0+ZGlzcGxheV9pbmZvLnN1YnBpeGVsX29yZGVy
ID0gU3ViUGl4ZWxIb3Jpem9udGFsUkdCOwogCWNvbm5lY3Rvci0+aW50ZXJsYWNlX2FsbG93ZWQg
PSBmYWxzZTsKIAljb25uZWN0b3ItPmRvdWJsZXNjYW5fYWxsb3dlZCA9IGZhbHNlOwotCWRybV9j
b25uZWN0b3JfcmVnaXN0ZXIoY29ubmVjdG9yKTsKIAogCS8qIGxpbmsgdGhlbSAqLwogCWRybV9j
b25uZWN0b3JfYXR0YWNoX2VuY29kZXIoY29ubmVjdG9yLCBlbmNvZGVyKTsKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCmluZGV4IGJkNzk4
YjZiZGYwZi4uNTAxMzdkZjljZGFkIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKQEAgLTU4MzksNyArNTgzOSw2IEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X2RtX2Nvbm5lY3Rvcl9pbml0KHN0cnVjdCBhbWRncHVfZGlzcGxheV9tYW5hZ2Vy
ICpkbSwKIAlkcm1fY29ubmVjdG9yX2F0dGFjaF9lbmNvZGVyKAogCQkmYWNvbm5lY3Rvci0+YmFz
ZSwgJmFlbmNvZGVyLT5iYXNlKTsKIAotCWRybV9jb25uZWN0b3JfcmVnaXN0ZXIoJmFjb25uZWN0
b3ItPmJhc2UpOwogI2lmIGRlZmluZWQoQ09ORklHX0RFQlVHX0ZTKQogCWNvbm5lY3Rvcl9kZWJ1
Z2ZzX2luaXQoYWNvbm5lY3Rvcik7CiAJYWNvbm5lY3Rvci0+ZGVidWdmc19kcGNkX2FkZHJlc3Mg
PSAwOwotLSAKMi4yNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
