Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36200C35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0905820659
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 15:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vRw26kB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0905820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C597E6E203;
	Wed,  5 Feb 2020 15:22:42 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CB7C6E203
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 15:22:42 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p17so3292179wma.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Feb 2020 07:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AzFXRdWVBHxBtcV9B7FFGqlUZE7XnIA629ePIBgvZ+s=;
 b=vRw26kB0nxcKWDmz0aqdcRykaik/dU4JT47TfZRNeRqVzUzgFHu+1UgNBSOHUlbm4v
 wXqSWSETLIpYEJHsGeDRk8EjrDKzsxaXlfhjJQBGnekKAgA3M6bvBl9diIba0ChHKJ5j
 Fnz9mfj8tVIfjzRmHpM0GQySY+aeJ8PL5zAKIzvVYSLJ4atuR2kO7JaW6IaVOnJ+v3hP
 4QP83LDPsJy4Jk3HDVpekRUa4eytqh72mu0yARh+y33OBWWZb12wV4B/BmqbZNtlUZVo
 /dCLTv7IL0FVgWqTx2eERYA/Bcdyp/69aoyFWa28SAr+MogGVBmRYGxPnJzDL2HlQYKi
 0bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=AzFXRdWVBHxBtcV9B7FFGqlUZE7XnIA629ePIBgvZ+s=;
 b=NssFFuFIgDER7/w30d5TDGerA2bK0bkjakXM6MFCMPC8BS5Jox5n3Dtgv2KqwU6zA4
 5pNmwtQ+fuF9wU2WXr9BtlPT4C3f8osGWDjS3l1DbmYuerUrU4hQEutz62lPDr1E+EUI
 GJkd5fo4S6j0UkgFWrmUG+9GhH4xCEI70Jf/AyKwOpnkuUV2DYZWBRpsfHyzm9H1/ALs
 +ukKYE1Njf314N3w9pgD8yu3K0mx+0wfvYPu7ykc1jdzowEQ1/EcEbMezFWnXmOghO7O
 +Fe9HbH+yoOn9scGTcIniRp4uXwmLPyCT/F7iJKnUPjI5kUKLN6Hj9itVfCpWdXwRl9d
 WdLQ==
X-Gm-Message-State: APjAAAV/Y+LmFyvn3MQDDwJpi+Q+vnB2iHh6ItAHI6cFeSRwkjcpAMd4
 04axd1dBL4hBv9nFYhR2bmXMaX2w
X-Google-Smtp-Source: APXvYqyBzVKhulG1Oh8onKfy/Y7b8roRTwJW4wh38i+bFq2nXFoig+xptOKlccwJRqU4Gchdg9BCiA==
X-Received: by 2002:a05:600c:2042:: with SMTP id
 p2mr6557157wmg.79.1580916160665; 
 Wed, 05 Feb 2020 07:22:40 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7118:fd6f:1c5e:860a])
 by smtp.gmail.com with ESMTPSA id p3sm209169wrx.29.2020.02.05.07.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 07:22:40 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, Jonathan.Kim@amd.com
Subject: [PATCH 1/4] drm/amdgpu: optimize amdgpu_device_vram_access a bit.
Date: Wed,  5 Feb 2020 16:22:35 +0100
Message-Id: <20200205152238.45258-1-christian.koenig@amd.com>
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

T25seSB3cml0ZSB0aGUgX0hJIHJlZ2lzdGVyIHdoZW4gbmVjZXNzYXJ5LgoKU2lnbmVkLW9mZi1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyB8IDE3ICsrKysrKysrKysrLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggNTAzMGEwOWJh
YmI4Li5kMzk2MzBlZGRhMDEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9kZXZpY2UuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZGV2aWNlLmMKQEAgLTE4NCwyMCArMTg0LDI1IEBAIGJvb2wgYW1kZ3B1X2RldmljZV9zdXBwb3J0
c19iYWNvKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYpCiB2b2lkIGFtZGdwdV9kZXZpY2VfdnJhbV9h
Y2Nlc3Moc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIGxvZmZfdCBwb3MsCiAJCQkgICAgICAg
dWludDMyX3QgKmJ1Ziwgc2l6ZV90IHNpemUsIGJvb2wgd3JpdGUpCiB7Ci0JdWludDY0X3QgbGFz
dDsKIAl1bnNpZ25lZCBsb25nIGZsYWdzOworCXVpbnQzMl90IGhpID0gfjA7CisJdWludDY0X3Qg
bGFzdDsKKworCXNwaW5fbG9ja19pcnFzYXZlKCZhZGV2LT5tbWlvX2lkeF9sb2NrLCBmbGFncyk7
CisJZm9yIChsYXN0ID0gcG9zICsgc2l6ZTsgcG9zIDwgbGFzdDsgcG9zICs9IDQpIHsKKwkJdWlu
dDMyX3QgdG1wID0gcG9zID4+IDMxOwogCi0JbGFzdCA9IHNpemUgLSA0OwotCWZvciAobGFzdCAr
PSBwb3M7IHBvcyA8PSBsYXN0OyBwb3MgKz0gNCkgewotCQlzcGluX2xvY2tfaXJxc2F2ZSgmYWRl
di0+bW1pb19pZHhfbG9jaywgZmxhZ3MpOwogCQlXUkVHMzJfTk9fS0lRKG1tTU1fSU5ERVgsICgo
dWludDMyX3QpcG9zKSB8IDB4ODAwMDAwMDApOwotCQlXUkVHMzJfTk9fS0lRKG1tTU1fSU5ERVhf
SEksIHBvcyA+PiAzMSk7CisJCWlmICh0bXAgIT0gaGkpIHsKKwkJCVdSRUczMl9OT19LSVEobW1N
TV9JTkRFWF9ISSwgdG1wKTsKKwkJCWhpID0gdG1wOworCQl9CiAJCWlmICh3cml0ZSkKIAkJCVdS
RUczMl9OT19LSVEobW1NTV9EQVRBLCAqYnVmKyspOwogCQllbHNlCiAJCQkqYnVmKysgPSBSUkVH
MzJfTk9fS0lRKG1tTU1fREFUQSk7Ci0JCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmFkZXYtPm1t
aW9faWR4X2xvY2ssIGZsYWdzKTsKIAl9CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmYWRldi0+
bW1pb19pZHhfbG9jaywgZmxhZ3MpOwogfQogCiAvKgotLSAKMi4xNy4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAph
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
