Return-Path: <SRS0=IZgh=DY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8613AC433E7
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2020 12:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A732072D
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2020 12:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajfFIEru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A732072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94BE66E072;
	Sat, 17 Oct 2020 12:07:40 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2056E072
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2020 12:07:39 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t9so6345022wrq.11
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2020 05:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xvwZIDQ7/bzk4GJrKVAAQ85G3Rm8XtpRA8WiFPTXNwc=;
 b=ajfFIEru1hHaxaJTo2dqDlurZC6mALjYtayvPRnR/2w/bjEvQ/71RJz1dT/g5QoBw1
 LOu+RQaLSCdPh4m4600uqRtlz8pkA+RFT7STnLeWJSIN+KphAxj2Hw28Rk1rpmMiQGuh
 eS30yHKSvQ5Ivzf/dHYt9Xk0ziT6CzEWCr0O6QNETCx8NcHv19aGi9XZHoCsXxysSU7W
 Z9zGH9unoa/VhXA0nRxdU11V9SFhHw35uW51GHAfvXNZZhlY9NBZufAaA8gRAYga2FkS
 ve8TaVzIH/QR0ih1J2C+Y1hMEC9VCSxBd9HYbc3nAczXUSlH0dykARF8qAZiQtZqob5N
 RtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xvwZIDQ7/bzk4GJrKVAAQ85G3Rm8XtpRA8WiFPTXNwc=;
 b=eZTIK2wV6cxF7PBnuUTC3SCBdICsGgbHNFtogQpItPo/JgJrX9lmctjv3LGkpbzHco
 qlGwUGzxThZNMH2Tj827MXTIx+XWYz+kq5u5+tFhNZHXSrLyTHT0i8sZaoVipLVR61rc
 Zw0dpgVnnq0WM9ohSyeReqP4JpVVOnPYvCikoLpLtOMMaNvdoMCFHeWCV/Mkv+t7fHNl
 TcqN5PA/N02JTNaNYnffx59AqpdXVohe2uBAwb320rCm0ajM1s27Nx7XlVstI0hINvkG
 AqM+sl3MWWkKEMIrYHVrOS0cUnSqRg6f8+m9Zl/4zBM9vImMuOxrLaMgXGTUo1gIsfGT
 JB8Q==
X-Gm-Message-State: AOAM5329vpY5JNoXKBru5nZaR8DED2bcPTXLRPzEYskD0snR4JrQF+2/
 Y6SsqjLobdEVIvXnanMH0P3GNFM33TPZpUSQ
X-Google-Smtp-Source: ABdhPJwTqWE7Gy6LAYkg7fq0zK6SUCnSOqxGwiUcI+bzRg37Kg777xkyTRd+gkXbPX8cMmHrzG3blw==
X-Received: by 2002:adf:902a:: with SMTP id h39mr9874358wrh.59.1602936458373; 
 Sat, 17 Oct 2020 05:07:38 -0700 (PDT)
Received: from abel.fritz.box
 (dynamic-002-244-048-143.2.244.pool.telefonica.de. [2.244.48.143])
 by smtp.gmail.com with ESMTPSA id y4sm7957128wrp.74.2020.10.17.05.07.37
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 05:07:37 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: increase the reserved VM size to 2MB
Date: Sat, 17 Oct 2020 14:07:36 +0200
Message-Id: <20201017120737.2430-1-christian.koenig@amd.com>
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

SWRlYWxseSB0aGlzIHNob3VsZCBiZSBhIG11bHRpcGxlIG9mIHRoZSBWTSBibG9jayBzaXplLgoy
TUIgc2hvdWxkIGF0IGxlYXN0IGZpdCBmb3IgVmVnYS9OYXZpLgoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogTWFk
aGF2IENoYXVoYW4gPG1hZGhhdi5jaGF1aGFuQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmggfCA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dm0uaAppbmRleCA3YzQ2OTM3YzFjMGUuLjgxY2NkMGEwYzNkYiAxMDA2NDQKLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X3ZtLmgKQEAgLTExMiw4ICsxMTIsOCBAQCBzdHJ1Y3QgYW1kZ3B1X2Jv
X2xpc3RfZW50cnk7CiAjZGVmaW5lIEFNREdQVV9NTUhVQl8wCQkJCTEKICNkZWZpbmUgQU1ER1BV
X01NSFVCXzEJCQkJMgogCi0vKiBoYXJkY29kZSB0aGF0IGxpbWl0IGZvciBub3cgKi8KLSNkZWZp
bmUgQU1ER1BVX1ZBX1JFU0VSVkVEX1NJWkUJCQkoMVVMTCA8PCAyMCkKKy8qIFJlc2VydmUgMk1C
IGF0IHRvcC9ib3R0b20gb2YgYWRkcmVzcyBzcGFjZSBmb3Iga2VybmVsIHVzZSAqLworI2RlZmlu
ZSBBTURHUFVfVkFfUkVTRVJWRURfU0laRQkJCSgyVUxMIDw8IDIwKQogCiAvKiBtYXggdm1pZHMg
ZGVkaWNhdGVkIGZvciBwcm9jZXNzICovCiAjZGVmaW5lIEFNREdQVV9WTV9NQVhfUkVTRVJWRURf
Vk1JRAkxCi0tIAoyLjE3LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eAo=
