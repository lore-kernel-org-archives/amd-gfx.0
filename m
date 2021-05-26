Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C442C4708B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC8661090
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 12:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC8661090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70A056ECED;
	Wed, 26 May 2021 12:57:28 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3183A6EC3B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 08:47:46 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 y184-20020a1ce1c10000b02901769b409001so29554wmg.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=y4rHhgO5kc8Uj3Lmp2tl7QIeeh0JqKynJlHlJf9HHsE=;
 b=pTKy7PwPYMsEXaJH7oJfEPlkKYTVzDOWLgysWs0lli66m1+1b9YZwKwKje1Y0AtAwS
 ua2YswIkDmK/6J5vymRUjqigKGrVmrx1BBlzlFjv1w9naTfx2iR2TVZvavFrVVgYj2NF
 p3wpU4dx+LyBifeZLRvnkkS3jlHEkeOyv9wKC7pAsi1jNzzzbH2kaflP0eULkRGHPwrO
 hWM5uSFAKWo+b7Eond1ho04GldbKOIP/ayNZubYoU4QXrOwHTY19FMoigoAk1nAwrm58
 JyiyOEjN+aAU0GiufMh6JFioygCs2IAbnM/T1taDb/VmHq2IfD4ZiKnC55QdQgE+YrrT
 8wdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y4rHhgO5kc8Uj3Lmp2tl7QIeeh0JqKynJlHlJf9HHsE=;
 b=i0QfM/SY48Nes+i52JAnoTGQ5IYilqkCuUZJ03ncrekY3wE9wgyLd2C89ngLHzGtQD
 7fsDAVLGwGfYH8dBYy5I1iyBu1PSp331IOWVK3IMFLMuaj2vJ72+Nqcnqc0ZpqFcPl0e
 QgkMoe/+UwBu66NFyJvqvSzwhMinpQtSMN0upVm6f19BDjxVA9B3OYxorPCWTHXZNvST
 /BegO32XIzdOFMlxH06DVAVcgivCLIOSe7rN+vKiPZS2ThFAvQ0pr6gGdJzDfzbCdONP
 6QC493TYAdGk6v4Sd8FjQEkagvPg/us00QC9rJATesyrkd0GHC4IMqZTuP3EasxoCSS6
 Oclw==
X-Gm-Message-State: AOAM5325nevyAetzmAjcDoP+1YBH9b78kTJ2JzXuimvR2VOUUNSjMcMC
 LLPVHY/MXjgOesOs0F6qCfdSFw==
X-Google-Smtp-Source: ABdhPJwmWlATieeB+cyUTNVhAlZSX2mheWuMR+R5VDc+yQmXYSlx5mLFXqmUAz2zy0vAKuMkWpotOw==
X-Received: by 2002:a05:600c:896:: with SMTP id
 l22mr28149778wmp.164.1622018864815; 
 Wed, 26 May 2021 01:47:44 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
 by smtp.gmail.com with ESMTPSA id l18sm18911918wrt.97.2021.05.26.01.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 01:47:44 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 14/34] drm/amd/display/dc/gpio/gpio_service: Pass around
 correct dce_{version, environment} types
Date: Wed, 26 May 2021 09:47:06 +0100
Message-Id: <20210526084726.552052-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526084726.552052-1-lee.jones@linaro.org>
References: <20210526084726.552052-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 26 May 2021 12:57:23 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9ncGlvL2dwaW9fc2VydmljZS5jOiBJ
biBmdW5jdGlvbiDigJhkYWxfZ3Bpb19zZXJ2aWNlX2NyZWF0ZeKAmToKIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1Ly4uL2Rpc3BsYXkvZGMvZ3Bpby9ncGlvX3NlcnZpY2UuYzo3MTo0OiB3YXJu
aW5nOiBpbXBsaWNpdCBjb252ZXJzaW9uIGZyb20g4oCYZW51bSBkY2VfdmVyc2lvbuKAmSB0byDi
gJhlbnVtIGRjZV9lbnZpcm9ubWVudOKAmSBbLVdlbnVtLWNvbnZlcnNpb25dCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS8uLi9kaXNwbGF5L2RjL2dwaW8vZ3Bpb19zZXJ2aWNlLmM6Nzc6NDog
d2FybmluZzogaW1wbGljaXQgY29udmVyc2lvbiBmcm9tIOKAmGVudW0gZGNlX3ZlcnNpb27igJkg
dG8g4oCYZW51bSBkY2VfZW52aXJvbm1lbnTigJkgWy1XZW51bS1jb252ZXJzaW9uXQoKQ2M6IEhh
cnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5n
LmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERh
dmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBm
ZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVz
QGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2dwaW8vZ3Bp
b19zZXJ2aWNlLmMgICB8IDEyICsrKysrKy0tLS0tLQogLi4uL2RybS9hbWQvZGlzcGxheS9pbmNs
dWRlL2dwaW9fc2VydmljZV9pbnRlcmZhY2UuaCB8ICA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwg
OCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kYy9ncGlvL2dwaW9fc2VydmljZS5jIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2dwaW8vZ3Bpb19zZXJ2aWNlLmMKaW5kZXggOTIyODBjYzA1ZTJkYi4u
ZGFlOGU0ODljOGNmNCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2dwaW8vZ3Bpb19zZXJ2aWNlLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2dwaW8vZ3Bpb19zZXJ2aWNlLmMKQEAgLTUzLDggKzUzLDggQEAKICAqLwogCiBzdHJ1Y3QgZ3Bp
b19zZXJ2aWNlICpkYWxfZ3Bpb19zZXJ2aWNlX2NyZWF0ZSgKLQllbnVtIGRjZV92ZXJzaW9uIGRj
ZV92ZXJzaW9uX21ham9yLAotCWVudW0gZGNlX3ZlcnNpb24gZGNlX3ZlcnNpb25fbWlub3IsCisJ
ZW51bSBkY2VfdmVyc2lvbiBkY2VfdmVyc2lvbiwKKwllbnVtIGRjZV9lbnZpcm9ubWVudCBkY2Vf
ZW52aXJvbm1lbnQsCiAJc3RydWN0IGRjX2NvbnRleHQgKmN0eCkKIHsKIAlzdHJ1Y3QgZ3Bpb19z
ZXJ2aWNlICpzZXJ2aWNlOwpAQCAtNjcsMTQgKzY3LDE0IEBAIHN0cnVjdCBncGlvX3NlcnZpY2Ug
KmRhbF9ncGlvX3NlcnZpY2VfY3JlYXRlKAogCQlyZXR1cm4gTlVMTDsKIAl9CiAKLQlpZiAoIWRh
bF9od190cmFuc2xhdGVfaW5pdCgmc2VydmljZS0+dHJhbnNsYXRlLCBkY2VfdmVyc2lvbl9tYWpv
ciwKLQkJCWRjZV92ZXJzaW9uX21pbm9yKSkgeworCWlmICghZGFsX2h3X3RyYW5zbGF0ZV9pbml0
KCZzZXJ2aWNlLT50cmFuc2xhdGUsIGRjZV92ZXJzaW9uLAorCQkJZGNlX2Vudmlyb25tZW50KSkg
ewogCQlCUkVBS19UT19ERUJVR0dFUigpOwogCQlnb3RvIGZhaWx1cmVfMTsKIAl9CiAKLQlpZiAo
IWRhbF9od19mYWN0b3J5X2luaXQoJnNlcnZpY2UtPmZhY3RvcnksIGRjZV92ZXJzaW9uX21ham9y
LAotCQkJZGNlX3ZlcnNpb25fbWlub3IpKSB7CisJaWYgKCFkYWxfaHdfZmFjdG9yeV9pbml0KCZz
ZXJ2aWNlLT5mYWN0b3J5LCBkY2VfdmVyc2lvbiwKKwkJCWRjZV9lbnZpcm9ubWVudCkpIHsKIAkJ
QlJFQUtfVE9fREVCVUdHRVIoKTsKIAkJZ290byBmYWlsdXJlXzE7CiAJfQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZ3Bpb19zZXJ2aWNlX2ludGVyZmFj
ZS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2luY2x1ZGUvZ3Bpb19zZXJ2aWNlX2lu
dGVyZmFjZS5oCmluZGV4IDljNTVkMjQ3MjI3ZWEuLjdlMzI0MGU3M2MxZmMgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9pbmNsdWRlL2dwaW9fc2VydmljZV9pbnRlcmZh
Y2UuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvaW5jbHVkZS9ncGlvX3NlcnZp
Y2VfaW50ZXJmYWNlLmgKQEAgLTQyLDggKzQyLDggQEAgdm9pZCBkYWxfZ3Bpb19kZXN0cm95KAog
CXN0cnVjdCBncGlvICoqcHRyKTsKIAogc3RydWN0IGdwaW9fc2VydmljZSAqZGFsX2dwaW9fc2Vy
dmljZV9jcmVhdGUoCi0JZW51bSBkY2VfdmVyc2lvbiBkY2VfdmVyc2lvbl9tYWpvciwKLQllbnVt
IGRjZV92ZXJzaW9uIGRjZV92ZXJzaW9uX21pbm9yLAorCWVudW0gZGNlX3ZlcnNpb24gZGNlX3Zl
cnNpb24sCisJZW51bSBkY2VfZW52aXJvbm1lbnQgZGNlX2Vudmlyb25tZW50LAogCXN0cnVjdCBk
Y19jb250ZXh0ICpjdHgpOwogCiBzdHJ1Y3QgZ3BpbyAqZGFsX2dwaW9fc2VydmljZV9jcmVhdGVf
aXJxKAotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
