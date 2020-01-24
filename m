Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7481EC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 13:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D9C2072C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 13:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdk7nG5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D9C2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB04872A55;
	Fri, 24 Jan 2020 13:05:28 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8386E378
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 13:05:28 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a5so1615795wmb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 05:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jDJw9GAnX4lLZGrPkyEdIgkj7Z3+VZLajQXYj0y2QsE=;
 b=Pdk7nG5MhqoqiI736LpnS3WjmGMNs6bAFN7Ps8aDPyj0KsUPPMcfo9cooVnpYPOUrt
 Qt1x547OeD8yliGtBdt3jbZRx5/GLMuJKMVUr9E35l0GL+0gb2OePAt76HI1mjphxstb
 Vp45KbEsalHe10RpK8KVH2X3vytOIOn6XUqy4tTVf3XKgtJt6BOLN8O02UcdVPrrkUZ5
 HjgxQVo+N5T5eXlZSErtJO1WBV7zQ/Bsnvplhkl9wIFBDQOJlGFF7qXceSmmwMyCjOJE
 Dvneoroe3YNKTeL93N2aTt3IUWv3yq0g8iUtGy6VUpEs4Se7/SEVrFhS36azl+en6aNg
 xIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jDJw9GAnX4lLZGrPkyEdIgkj7Z3+VZLajQXYj0y2QsE=;
 b=gUQ9+lbsdRhQNFKnbfZSYP4wbw3CbTSW2khmanYGPRxfNs4PKAVPPs4M4FAJoDsv65
 1efxAAFdssKvcZ1dNn5oEUVUWP+EQFkwFxPDTSWLJXYIW7iRSMqrY/2y6+D9BvQAmxcc
 Uzv9yaB+yEzkY8d2EdqMjP10SlZcogrnGD3e72Dtq9ODQsb4+X1o8GNQwoy0vgrySdU4
 +8jpGZ/ml7MtT2McKl0YZyKRon1EoQ4blNVBRLt5Ux3kRIitzJVIXjsls5f1wEqK4m39
 HPNA3raqEMLV8hBOh2FnFUuQXFhXxiolLXz3nv6CMLKc5S3B+c7q3ybLN1aEG7rzTFtg
 7jyQ==
X-Gm-Message-State: APjAAAWo/TxivO5ukO6oGS+DGxsRye2+W3uNU3kOrFzxM+y0SoReLQ5h
 2GsTrIt+OBeDOzQa1ER0VCWyvsCJ
X-Google-Smtp-Source: APXvYqwgNW8f3Rs5IavxiusAAwOYCtG2lPzcyLqu4w898+wXuwScMHV3tZLxjLOOfe2ywi/UcL3YvQ==
X-Received: by 2002:a05:600c:2c01:: with SMTP id
 q1mr3248314wmg.179.1579871126886; 
 Fri, 24 Jan 2020 05:05:26 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:9c03:ec12:e225:5a75])
 by smtp.gmail.com with ESMTPSA id g9sm7393513wro.67.2020.01.24.05.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 05:05:26 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Jonathan.Kim@amd.com, felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: optimize amdgpu_device_vram_access a bit.
Date: Fri, 24 Jan 2020 14:05:24 +0100
Message-Id: <20200124130525.1800-1-christian.koenig@amd.com>
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
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKaW5kZXggMWRhMDM2NTg4
OTFjLi44ZDY3ZTYzZjg3ZGQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
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
