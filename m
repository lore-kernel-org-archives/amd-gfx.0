Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BCDC64E7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED1BF208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPKMUh80"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED1BF208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E32166E93E;
	Wed, 25 Nov 2020 08:23:01 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CA796E554
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:15 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a65so99999wme.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FS9YPeBS7kCrSPbUVkxYBE/KfGD+0TCEKMjrGKoj90U=;
 b=uPKMUh800nKfHaIh28pUF8SIocH8o+qrfL+QGuLUqd1kge/4Pl3XBpgRH2vT7ZMJSY
 uakHIOVbvrsrVX5vocCdEfXc4nhCqiXticos1FPTvuuwGD74+vEUTrQ77bG4krExi0Yj
 2KOTD2uvcR+0wE7EYSaX/7PE4vNy/XMZk7JBoQ3k2lzhwIXBqDY3oO1lQEHVNB8Wvi1f
 zjkWjrssK0ni8EdeoVN989g5UCWkHIWXrwwwUSka5WH7gYX5ThWerASjzmLoXGqX8QaJ
 C5CTqEy+zxMcqZWmfi/+uP+kU1QkfLIH1Cw2NQUv3dNg3u/52dC+0Jtm/hB8C6eS0Q3K
 hpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FS9YPeBS7kCrSPbUVkxYBE/KfGD+0TCEKMjrGKoj90U=;
 b=BtR7OTLW0IrVl1XMv9KUkYCtow6SHNo4IK+2QpX7mDisz25AzF8pCxKftD2uVi+4Fw
 ZNFvamlF9cc9CwVznLWvp7n267qykgWWnixuR+F55NcZYf5oP5vl2LIlCNZn3eypx7Go
 HVV9zo8mu/y/nZLO2m78NCF/fufO1TSdisHuOM9zKH9sgobmARkcq9/fyH75wV0FPqQ4
 gotKecHgi+xL/ex9l/BrTU3yN2Gwgw6h4iXMDP2bzUrHc8VExbT6bI26zQqBgKadJI/n
 i3ah8hhgowUKNb67J1FLQ7YVKwF1mS5zg8xvDE0HdWl/X6K3qMNY5AAxfwD4ZGhS7A1L
 mesg==
X-Gm-Message-State: AOAM532oVb9g1k0VHVAIILsOfaTk0VVTMIVe3edLuydZiULmqPRYYQTb
 9/3AuCHx3+v9G1KE4uWJ2CZHQA==
X-Google-Smtp-Source: ABdhPJzsE7Vx9UXN4W0umVdESe5TbA5OW0VFsT+YDpvTZyofmmt2DJ2JzZ4s9n8DupjG43ptWoyjKw==
X-Received: by 2002:a7b:cb0c:: with SMTP id u12mr166411wmj.11.1606247053955;
 Tue, 24 Nov 2020 11:44:13 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:13 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 12/40] drm/amd/amdgpu/dce_v10_0: Supply description for
 function param 'async'
Date: Tue, 24 Nov 2020 19:37:56 +0000
Message-Id: <20201124193824.1118741-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124193824.1118741-1-lee.jones@linaro.org>
References: <20201124193824.1118741-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 Nov 2020 08:22:58 +0000
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

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvZGNlX3YxMF8wLmM6MjM3OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdhc3luYycgbm90IGRlc2NyaWJlZCBpbiAnZGNlX3YxMF8wX3Bh
Z2VfZmxpcCcKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNj
OiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlk
IEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZnds
bC5jaD4KQ2M6IEx1YmVuIFR1aWtvdiA8bHViZW4udHVpa292QGFtZC5jb20+CkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTBfMC5jIHwgMSArCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9kY2VfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2RjZV92MTBfMC5jCmlu
ZGV4IGRhMjQwZjhmYWZjZjguLjc5NDQ3ODFlMTA4NmIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2RjZV92MTBfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2RjZV92MTBfMC5jCkBAIC0yMjgsNiArMjI4LDcgQEAgc3RhdGljIHZvaWQgZGNlX3YxMF8w
X3BhZ2VmbGlwX2ludGVycnVwdF9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogICog
QGFkZXY6IGFtZGdwdV9kZXZpY2UgcG9pbnRlcgogICogQGNydGNfaWQ6IGNydGMgdG8gY2xlYW51
cCBwYWdlZmxpcCBvbgogICogQGNydGNfYmFzZTogbmV3IGFkZHJlc3Mgb2YgdGhlIGNydGMgKEdQ
VSBNQyBhZGRyZXNzKQorICogQGFzeW5jOiBhc3luY2hyb25vdXMgZmxpcAogICoKICAqIFRyaWdn
ZXJzIHRoZSBhY3R1YWwgcGFnZWZsaXAgYnkgdXBkYXRpbmcgdGhlIHByaW1hcnkKICAqIHN1cmZh
Y2UgYmFzZSBhZGRyZXNzLgotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
