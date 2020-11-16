Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B11BC64E75
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0665C2225E
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 19:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPtujtuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0665C2225E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626006E0DA;
	Mon, 16 Nov 2020 19:18:18 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2397A6E03B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 17:34:05 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id u12so12404760wrt.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 09:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qEyPNgqrCvgW7yAtw6B6vQyE222bBpFcTf7vHkr21Ko=;
 b=OPtujtuUIiaHPXrwEHhBFdgesbmCfs+lQzSA9SMtgIcwEdph0SW0wllmS/L3kUHbce
 Y24r/TzNwhqkpzekveoWb2t/h8FdnLBdgOlMPfvBjCMe8Jm6tixGksZAvVCDSNvZllNX
 Awv7Cl117cA02/Z5UmFgwEmfpwAq22KGcXm07IXFwhz5WMOBfD1wfNjs1S31Sb5Sk4WT
 egyPpwERRQ/nrOL0xiS7btKXz53rGfcr/yv6NK8GkUlxkkvZ1jjLphtmn8iqqVCH9QkQ
 IxUTqhA9CNRLEmHcxm8l3EE8sPji/wzUvnULxrXfhBd3BS97mQjTD01EQKD4MprDzcPn
 m4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qEyPNgqrCvgW7yAtw6B6vQyE222bBpFcTf7vHkr21Ko=;
 b=CRJ1ULtu7iOWkHe2uJaLzW8YIIZHAUN0XA2ny2gt4psCb5GxvDST6HSAJURPszFAWb
 NGr4nc6KBD1IE7vTFTtCPPyzvq2OxM8oyrLys29SqfPCICA2IQwguMMXLyTWZZpCO3Wo
 2M3tsXhPA8K61LslQKwMY4yLQV8TUJozM8y/wHhNdsBJGhUut3S1cTUpKRrh5nEhd6gE
 8vG5Or2JlkGNX1DWqONdRPma/J5RkDwxcItkkmerYyoMx1OsZs44IchiYwBqzDUR3nfH
 W1ua/mcYgKBwe0Qpl0DoO8XjE+q9K1BUPynyffx7vzkqpAGCI5K+8s+GF93I7Ikf7ku3
 psQw==
X-Gm-Message-State: AOAM531P72JQ+4+B1kb+GwwC8+8CA9uT7/duJF3qu+HF4zYMb90SfxDJ
 o1bx/5v0XNajGlprPYt4EjOtnw==
X-Google-Smtp-Source: ABdhPJw5cdJSme1gFB4p1vRURW8tGgzc+PR1zOkEEnozjGPApXdvviPVdnHkmMFtk08Wc3vjnElPbA==
X-Received: by 2002:adf:9e48:: with SMTP id v8mr21978405wre.55.1605548043787; 
 Mon, 16 Nov 2020 09:34:03 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id k22sm20178562wmi.34.2020.11.16.09.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:34:03 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 01/42] drm/amd/amdgpu/atombios_encoders: Remove set but unused
 variable 'backlight_level'
Date: Mon, 16 Nov 2020 17:33:15 +0000
Message-Id: <20201116173356.1828478-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173356.1828478-1-lee.jones@linaro.org>
References: <20201116173356.1828478-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 16 Nov 2020 19:18:13 +0000
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
Cc: David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWxzbyByZW1vdmluZyB0aGUgY2FsbCB0byBhbWRncHVfYXRvbWJpb3NfZW5jb2Rlcl9nZXRfYmFj
a2xpZ2h0X2xldmVsX2Zyb21fcmVnKCkKc2luY2UsIGFjY29yZGluZyB0byBBbGV4IERldWNoZXIs
ICJXZSBjYWxsIGl0IGFnYWluIGJlbG93IGluZGlyZWN0bHkiLgoKRml4ZXMgdGhlIGZvbGxvd2lu
ZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYXRvbWJpb3NfZW5jb2RlcnMuYzogSW4gZnVuY3Rpb24g4oCYYW1kZ3B1X2F0b21iaW9zX2Vu
Y29kZXJfaW5pdF9iYWNrbGlnaHTigJk6CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9t
Ymlvc19lbmNvZGVycy5jOjE3NDo1OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhiYWNrbGlnaHRfbGV2
ZWzigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0KCkNjOiBB
bGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvD
tm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGll
ZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IEx1YmVu
IFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5
OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2F0b21iaW9zX2VuY29kZXJzLmMgfCAzIC0tLQogMSBmaWxlIGNoYW5nZWQsIDMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRv
bWJpb3NfZW5jb2RlcnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2F0b21iaW9zX2Vu
Y29kZXJzLmMKaW5kZXggZmE4MTdlYmZmOTgwNC4uNjEzNGVkOTY0MDI3OSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbWJpb3NfZW5jb2RlcnMuYworKysgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hdG9tYmlvc19lbmNvZGVycy5jCkBAIC0xNzEsNyArMTcx
LDYgQEAgdm9pZCBhbWRncHVfYXRvbWJpb3NfZW5jb2Rlcl9pbml0X2JhY2tsaWdodChzdHJ1Y3Qg
YW1kZ3B1X2VuY29kZXIgKmFtZGdwdV9lbmNvZGUKIAlzdHJ1Y3QgYmFja2xpZ2h0X3Byb3BlcnRp
ZXMgcHJvcHM7CiAJc3RydWN0IGFtZGdwdV9iYWNrbGlnaHRfcHJpdmRhdGEgKnBkYXRhOwogCXN0
cnVjdCBhbWRncHVfZW5jb2Rlcl9hdG9tX2RpZyAqZGlnOwotCXU4IGJhY2tsaWdodF9sZXZlbDsK
IAljaGFyIGJsX25hbWVbMTZdOwogCiAJLyogTWFjIGxhcHRvcHMgd2l0aCBtdWx0aXBsZSBHUFVz
IHVzZSB0aGUgZ211eCBkcml2ZXIgZm9yIGJhY2tsaWdodApAQCAtMjA3LDggKzIwNiw2IEBAIHZv
aWQgYW1kZ3B1X2F0b21iaW9zX2VuY29kZXJfaW5pdF9iYWNrbGlnaHQoc3RydWN0IGFtZGdwdV9l
bmNvZGVyICphbWRncHVfZW5jb2RlCiAKIAlwZGF0YS0+ZW5jb2RlciA9IGFtZGdwdV9lbmNvZGVy
OwogCi0JYmFja2xpZ2h0X2xldmVsID0gYW1kZ3B1X2F0b21iaW9zX2VuY29kZXJfZ2V0X2JhY2ts
aWdodF9sZXZlbF9mcm9tX3JlZyhhZGV2KTsKLQogCWRpZyA9IGFtZGdwdV9lbmNvZGVyLT5lbmNf
cHJpdjsKIAlkaWctPmJsX2RldiA9IGJkOwogCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
