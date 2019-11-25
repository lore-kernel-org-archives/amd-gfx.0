Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E2DC432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 16:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBFB2068F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 16:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBFB2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 181D789C6B;
	Mon, 25 Nov 2019 16:12:55 +0000 (UTC)
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com
 [IPv6:2607:f8b0:4864:20::b42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BCA489C6B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 16:12:53 +0000 (UTC)
Received: by mail-yb1-xb42.google.com with SMTP id q7so6203886ybk.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 08:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lM2/6daKh30h/8qEtghZNzb7nUnADQhuxfFZjti+Q+M=;
 b=eBVcS4H8VkidR2xnyjxOEHQZsvR3M70DAuHD2nKBk36akOO7qLgg2RwOZ6bcZjjmIs
 +PcNTNQPlUMSYipogXlmLUltu9vHhafumgdLeaNcpGtpHSFETuAgk09rZ9TiBxCZ8kRw
 /M9axbqF1V8xisJIjXrP/BqH/6dO1/gTCzCixQn+z1ROF6Aw4wRgzCWklzcI0PZot7jD
 RAof+BCa1lKfEpvT/gN7EVLnzZ7YZhCdEesYpMFPLIVcB/pJFxSLE/t1hDR+RPAMfXtU
 /xeuBhm9RRatNoLwkzw5JLtoHQMuHy/3vWnziGedF1IjmQRUO6jCFDc8PuYeDs8+hpyO
 eDIQ==
X-Gm-Message-State: APjAAAW4M+TRGfnKZZTgTO6eERDFEH6llvWRSdRLGVf+jgwwJ5W749sH
 yNSn2mQnCmL9+Cy2rz0pSPCRpESK
X-Google-Smtp-Source: APXvYqww50CJNLOOg47Q6zmppHoAEYfa3MmzoaaquV+UqKhu9Dx2RUOUKFBBc0kt7sXHOazAOp7tbg==
X-Received: by 2002:a25:758a:: with SMTP id
 q132mr24019626ybc.459.1574698371998; 
 Mon, 25 Nov 2019 08:12:51 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id y186sm3778107ywe.97.2019.11.25.08.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 08:12:51 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: flag vram lost on baco reset for VI/CIK
Date: Mon, 25 Nov 2019 11:12:39 -0500
Message-Id: <20191125161239.347655-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lM2/6daKh30h/8qEtghZNzb7nUnADQhuxfFZjti+Q+M=;
 b=Z7oqFxZtt1FzSp1zz7BUwzh/R/+mtAUBXHId8jRg67Ah76cThH1PI86ByCj9b4vua5
 8QulkiqiE7ax2SseisV7aJeh3HxwW+nE0cp+QqqY8x0aERGZ9bAQEeOL4WF2tV3DpHIo
 rd2lMaYuC0IYb3ZNwos/bNJjdrzAkOS8sQvi2UyQza46vn6nYk8PYVJsi/KVxEj4M4v9
 BqIOhOmgAc46KydEN+1TFiVDBaeS9+yAw5PVI2NXJ8YR54Ww020pc/Ec2CV91wmc1IRH
 sucdnLXKamXU7fZstGTjDZW14lKDADgl9qc3mv34yfIJw3PMX/gD9PQFmwKvRn64A3Hn
 8xUQ==
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
Message-ID: <20191125161239.4neuThoobISzjSkCPpB2ATBYU0NKFB4RJZMsmAa1Udc@z>

VkkvQ0lLIEJBQ08gd2FzIGluZmxpZ2h0IHdoZW4gdGhpcyBmaXggbGFuZGVkIGZvciBTT0MxNS9O
Vi4KQWRkIHRoZSBmaXggdG8gVkkvQ0lLIGFzIHdlbGwuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvY2lrLmMgfCA3ICsrKysrLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zp
LmMgIHwgNyArKysrKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYwppbmRleCA5NjhiYzcwNmI5NGQuLjFk
ZmU0YTEzMzdjZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMKQEAgLTEzNjMsMTAgKzEzNjMs
MTMgQEAgc3RhdGljIGludCBjaWtfYXNpY19yZXNldChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKIHsKIAlpbnQgcjsKIAotCWlmIChjaWtfYXNpY19yZXNldF9tZXRob2QoYWRldikgPT0gQU1E
X1JFU0VUX01FVEhPRF9CQUNPKQorCWlmIChjaWtfYXNpY19yZXNldF9tZXRob2QoYWRldikgPT0g
QU1EX1JFU0VUX01FVEhPRF9CQUNPKSB7CisJCWlmICghYWRldi0+aW5fc3VzcGVuZCkKKwkJCWFt
ZGdwdV9pbmNfdnJhbV9sb3N0KGFkZXYpOwogCQlyID0gc211N19hc2ljX2JhY29fcmVzZXQoYWRl
dik7Ci0JZWxzZQorCX0gZWxzZSB7CiAJCXIgPSBjaWtfYXNpY19wY2lfY29uZmlnX3Jlc2V0KGFk
ZXYpOworCX0KIAogCXJldHVybiByOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdmkuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZpLmMKaW5kZXggODcx
YzBiOGM2YjBiLi5lNGY0MjAxYjNjMzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3ZpLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmkuYwpAQCAtODA0
LDEwICs4MDQsMTMgQEAgc3RhdGljIGludCB2aV9hc2ljX3Jlc2V0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogewogCWludCByOwogCi0JaWYgKHZpX2FzaWNfcmVzZXRfbWV0aG9kKGFkZXYp
ID09IEFNRF9SRVNFVF9NRVRIT0RfQkFDTykKKwlpZiAodmlfYXNpY19yZXNldF9tZXRob2QoYWRl
dikgPT0gQU1EX1JFU0VUX01FVEhPRF9CQUNPKSB7CisJCWlmICghYWRldi0+aW5fc3VzcGVuZCkK
KwkJCWFtZGdwdV9pbmNfdnJhbV9sb3N0KGFkZXYpOwogCQlyID0gc211N19hc2ljX2JhY29fcmVz
ZXQoYWRldik7Ci0JZWxzZQorCX0gZWxzZSB7CiAJCXIgPSB2aV9hc2ljX3BjaV9jb25maWdfcmVz
ZXQoYWRldik7CisJfQogCiAJcmV0dXJuIHI7CiB9Ci0tIAoyLjIzLjAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
