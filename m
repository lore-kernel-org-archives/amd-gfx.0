Return-Path: <SRS0=VQNv=YW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7939CA9EAE
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 20:10:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE222067D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2019 20:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE222067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9151B6E60A;
	Tue, 29 Oct 2019 20:10:47 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D3D46E60A
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 20:10:46 +0000 (UTC)
Received: by mail-pg1-x541.google.com with SMTP id c8so10395031pgb.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2019 13:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BbuH64SggNi2LmpEUNCC+MarzInoF5vZ7AMlguMnkEg=;
 b=ZNZ3+bGabnnv9ZBK1qGOxQkmtgGTspvqv9k+CPjcWWPIALCNx4nFqjPOrAnbdmWhfv
 HE5Lu3/s00Xwk6vNr0+1uuWSuDXJmHkK1Fqpr/+6uYfXpDvdN1OccrQeHpIIO7ilLNwJ
 0f3xP0uyBFbw74d0jPZrYJuqxuG5Cn01cNh8Dct+gCYFEjjl9ccgO9SFSJFRd6aujm29
 nq+BECPZMXSVNYGdVLXMV890l9qZ12YiBp2sCGiAA+McKKCiC5ks1PfRiVuGqCUsYOuz
 Pdp5bdh8c2TsaX3YpGNVh/6YPq5PUdjSYQRgSEWRTvkcD/cxWRnk9BvY4Wp5oXdJYq3M
 m4Jg==
X-Gm-Message-State: APjAAAXNQLhA/0b1fLJp4FDPHMBUBcS6n6na0eWdks5wyXI7QrgYUDxH
 DTMKEs5Gfjjdhzf/fiNM0QE2i1xe
X-Google-Smtp-Source: APXvYqzVOb7ZbmZ3wHrjAlutiNVhrRkBc/uKN2dRLlZqHN3oCvZXDod4PnMYvzxS3oAO4aKt8CNO/g==
X-Received: by 2002:a63:364d:: with SMTP id d74mr4966578pga.408.1572379845542; 
 Tue, 29 Oct 2019 13:10:45 -0700 (PDT)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id q26sm42041pgk.60.2019.10.29.13.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 13:10:44 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/renoir: move gfxoff handling into gfx9 module
Date: Tue, 29 Oct 2019 16:10:31 -0400
Message-Id: <20191029201031.1514210-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BbuH64SggNi2LmpEUNCC+MarzInoF5vZ7AMlguMnkEg=;
 b=CYf0Z+wgK9I/bm6miKGwkzv95dmgDsb4aCviG/uOyob+X3cd4TTOoLx7tgdUsnShFL
 rZqLu6pTSfGIwoJDe37OXlRAMdSIZcmqITX4urc+VbDVI0i0nqCZmfnkRpUYcVpo6qlS
 96i+bR2QUpk5WZbmxKb0hz4WXeQcGmoSBGYMYJWPII3cS8OeqPDCAvVr0ISlSzOwxHTb
 OwOktTINjrWO7EnO2SyPEWVEs8Vg59hPbwDtKbhNEGtt+WgJaVz+0RjvjiVRakgg/QWE
 4m55o/ZB6BwI+gm5cOWh7t83QLZYbV22L2xFAeP9LR8Ji8dZuLEimMA2jQlVMxAkA5Tk
 wjZw==
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
Message-ID: <20191029201031.9xXjROhQtzIJma_sp0bnlCuo5tDymBCp1tQp3S7AMUk@z>

VG8gcHJvcGVybHkgaGFuZGxlIHRoZSBvcHRpb24gcGFyc2luZyBvcmRlcmluZy4KClNpZ25lZC1v
ZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgNiArKysrKysKIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgICAgfCA1IC0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4
X3Y5XzAuYwppbmRleCA5ZmU5NWU3NjkzZDUuLmIyYjNlYjc1YzQ4YyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9nZnhfdjlfMC5jCkBAIC0xMDUxLDYgKzEwNTEsMTIgQEAgc3RhdGljIHZvaWQg
Z2Z4X3Y5XzBfY2hlY2tfaWZfbmVlZF9nZnhvZmYoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYp
CiAJCQkgICAgIWFkZXYtPmdmeC5ybGMuaXNfcmxjX3YyXzEpKQogCQkJYWRldi0+cG0ucHBfZmVh
dHVyZSAmPSB+UFBfR0ZYT0ZGX01BU0s7CiAKKwkJaWYgKGFkZXYtPnBtLnBwX2ZlYXR1cmUgJiBQ
UF9HRlhPRkZfTUFTSykKKwkJCWFkZXYtPnBnX2ZsYWdzIHw9IEFNRF9QR19TVVBQT1JUX0dGWF9Q
RyB8CisJCQkJQU1EX1BHX1NVUFBPUlRfQ1AgfAorCQkJCUFNRF9QR19TVVBQT1JUX1JMQ19TTVVf
SFM7CisJCWJyZWFrOworCWNhc2UgQ0hJUF9SRU5PSVI6CiAJCWlmIChhZGV2LT5wbS5wcF9mZWF0
dXJlICYgUFBfR0ZYT0ZGX01BU0spCiAJCQlhZGV2LT5wZ19mbGFncyB8PSBBTURfUEdfU1VQUE9S
VF9HRlhfUEcgfAogCQkJCUFNRF9QR19TVVBQT1JUX0NQIHwKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9z
b2MxNS5jCmluZGV4IDE2YzViYjc1ODg5Zi4uMjVlNjllYTc0YTQxIDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L3NvYzE1LmMKQEAgLTEyNjMsMTEgKzEyNjMsNiBAQCBzdGF0aWMgaW50IHNvYzE1X2Nv
bW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKIAkJCQkgQU1EX1BHX1NVUFBPUlRfVkNOIHwK
IAkJCQkgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRzsKIAkJYWRldi0+ZXh0ZXJuYWxfcmV2X2lkID0g
YWRldi0+cmV2X2lkICsgMHg5MTsKLQotCQlpZiAoYWRldi0+cG0ucHBfZmVhdHVyZSAmIFBQX0dG
WE9GRl9NQVNLKQotCQkJYWRldi0+cGdfZmxhZ3MgfD0gQU1EX1BHX1NVUFBPUlRfR0ZYX1BHIHwK
LQkJCQlBTURfUEdfU1VQUE9SVF9DUCB8Ci0JCQkJQU1EX1BHX1NVUFBPUlRfUkxDX1NNVV9IUzsK
IAkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJLyogRklYTUU6IG5vdCBzdXBwb3J0ZWQgeWV0ICovCi0t
IAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
