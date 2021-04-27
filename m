Return-Path: <SRS0=7Ry8=JY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62318C43461
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 10:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5DF60720
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Apr 2021 10:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5DF60720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EA26E06E;
	Tue, 27 Apr 2021 10:54:14 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F1486E046
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 10:54:13 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id y3so33118578eds.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Apr 2021 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=KPAaTSLqvWrWrPPh8DYldH9aK7qPvuu1LCQV8cZ7kVU=;
 b=A48iy3w9VUDIEaFc9Ae23iJ93Ok51yinLXcUSuf7FDaRTRp2W4Vz7afUJYz85ZIF+N
 d4i4v8L/jjYnMWnT//7pjv85LN2tc7zDUYyj+UwUq+E/fQbtYT93Tc3zO1rgGWJc3vi4
 A/Grm/UoRDolF+hg3HZORkZvOtBzvoqIk1VY0xcw0k9G2mVm6Fqr9iTsg2OJbAg4u8YZ
 DRmjT2N2ZfVp6nmOSS49YqxViupb15RomxlXSvhORlWEYmZlhCzsSoD1ODYkyq3lsQVN
 mGILFIuVHzBrhsQC7BU+uJWZs6mJNk0JGYk/ycFYu6zXtoIIRHQBW2CLwCd9FZNwp7mm
 wi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KPAaTSLqvWrWrPPh8DYldH9aK7qPvuu1LCQV8cZ7kVU=;
 b=VDSU2VFc4CCK5fn4uGSsBqnKOHentMvpQx6De7GGvpR1Ong7bmQKoC+Jh2SZZtuPut
 V74sRuHsEH5TpcqgbmJKoGb9f8oZl5M7/IMbeS7Jni29jY5VIVi7bidZj2L8DlOIEp8N
 5boGMr++IJOwULhQV9vdLD5OjOBZ7Lso5R7l3vtjCnu/l6EuouQcHOwD7YN5r71b2fNC
 9i/x2rxLo2yPUo31IB/gVM3fwTaqjGGp1FGZbsPskN1SZmmi3Bwn5YIGyAgTfnrMiW3Y
 3/nasCNxuXBcFmSbEb2evYtonWTput5/yn+3WkhwJUzjcD4YbN3EoFbpiEkvXVaJY0QH
 Jtcw==
X-Gm-Message-State: AOAM53010QKJ5nsqPH7Cq2UIQAzcPBH2IJUY1AE1GIB4qsPT9QPHqC3U
 hPYlye8SE7bdLq9FLPtP4DfDbyF1pHc=
X-Google-Smtp-Source: ABdhPJyR6lejPJrFxXRWC785kqrNaoJrLjwRKMaXtFa/Dn+DCxJEYBlSgoPFVtnPM0/L3ghbeCXZ4g==
X-Received: by 2002:a05:6402:1907:: with SMTP id
 e7mr3512419edz.313.1619520852159; 
 Tue, 27 Apr 2021 03:54:12 -0700 (PDT)
Received: from abel.fritz.box ([2a02:908:1252:fb60:cc40:13c1:6c51:27cd])
 by smtp.gmail.com with ESMTPSA id o8sm12995411ejm.18.2021.04.27.03.54.11
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Apr 2021 03:54:11 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: use cursor functions in
 amdgpu_bo_in_cpu_visible_vram
Date: Tue, 27 Apr 2021 12:54:07 +0200
Message-Id: <20210427105410.2700-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210427105410.2700-1-christian.koenig@amd.com>
References: <20210427105410.2700-1-christian.koenig@amd.com>
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

T25lIG9mIHRoZSBsYXN0IHJlbWFpbmluZyB1c2VzIG9mIGRybV9tbV9ub2RlLgoKU2lnbmVkLW9m
Zi1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuaCB8IDE1ICsrKysrKysrKy0t
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmggYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmgKaW5kZXggZTBlYzQ4ZDZh
M2ZkLi4xY2ViZTI0Y2NhNzEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9vYmplY3QuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
b2JqZWN0LmgKQEAgLTMwLDYgKzMwLDggQEAKIAogI2luY2x1ZGUgPGRybS9hbWRncHVfZHJtLmg+
CiAjaW5jbHVkZSAiYW1kZ3B1LmgiCisjaW5jbHVkZSAiYW1kZ3B1X3Jlc19jdXJzb3IuaCIKKwog
I2lmZGVmIENPTkZJR19NTVVfTk9USUZJRVIKICNpbmNsdWRlIDxsaW51eC9tbXVfbm90aWZpZXIu
aD4KICNlbmRpZgpAQCAtMjE1LDE4ICsyMTcsMTkgQEAgc3RhdGljIGlubGluZSB1NjQgYW1kZ3B1
X2JvX21tYXBfb2Zmc2V0KHN0cnVjdCBhbWRncHVfYm8gKmJvKQogc3RhdGljIGlubGluZSBib29s
IGFtZGdwdV9ib19pbl9jcHVfdmlzaWJsZV92cmFtKHN0cnVjdCBhbWRncHVfYm8gKmJvKQogewog
CXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gYW1kZ3B1X3R0bV9hZGV2KGJvLT50Ym8uYmRl
dik7Ci0JdW5zaWduZWQgZnBmbiA9IGFkZXYtPmdtYy52aXNpYmxlX3ZyYW1fc2l6ZSA+PiBQQUdF
X1NISUZUOwotCXN0cnVjdCBkcm1fbW1fbm9kZSAqbm9kZSA9IGJvLT50Ym8ubWVtLm1tX25vZGU7
Ci0JdW5zaWduZWQgbG9uZyBwYWdlc19sZWZ0OworCXN0cnVjdCBhbWRncHVfcmVzX2N1cnNvciBj
dXJzb3I7CiAKIAlpZiAoYm8tPnRiby5tZW0ubWVtX3R5cGUgIT0gVFRNX1BMX1ZSQU0pCiAJCXJl
dHVybiBmYWxzZTsKIAotCWZvciAocGFnZXNfbGVmdCA9IGJvLT50Ym8ubWVtLm51bV9wYWdlczsg
cGFnZXNfbGVmdDsKLQkgICAgIHBhZ2VzX2xlZnQgLT0gbm9kZS0+c2l6ZSwgbm9kZSsrKQotCQlp
ZiAobm9kZS0+c3RhcnQgPCBmcGZuKQorCWFtZGdwdV9yZXNfZmlyc3QoJmJvLT50Ym8ubWVtLCAw
LCBhbWRncHVfYm9fc2l6ZShibyksICZjdXJzb3IpOworCXdoaWxlIChjdXJzb3IucmVtYWluaW5n
KSB7CisJCWlmIChjdXJzb3Iuc3RhcnQgPCBhZGV2LT5nbWMudmlzaWJsZV92cmFtX3NpemUpCiAJ
CQlyZXR1cm4gdHJ1ZTsKIAorCQlhbWRncHVfcmVzX25leHQoJmN1cnNvciwgY3Vyc29yLnNpemUp
OworCX0KKwogCXJldHVybiBmYWxzZTsKIH0KIAotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
