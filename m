Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62597C63798
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2705220715
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ox7jf1lZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2705220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF0BF6E5B4;
	Fri, 13 Nov 2020 14:28:29 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 352A76E4EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:50:15 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id p8so10001133wrx.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BzoA0/p90w69kCv3e5Q2d2JhA6KtEucuiNdT/rFnC4I=;
 b=ox7jf1lZwfwZsOGGRxrgIuDFmMt/t3EA9CY44da6nxv97y3o6P6e3V3SK8STEuDHTx
 uieKR6jD3bQvVud1bFo69dW/kuNx60kde6emW4UAetcflcKaRTsuDtMcDWUlmxyaJwT9
 wOuJ42ZmsGwUk5Cd9hwHMfR2knehgRRvTAfmqo2DDU33pgXSrhJGPEx40GUvbRPorBxG
 jAt3PWNRMXwOxUkY6KekxOtr8lyHSCT3eTVnL+MlKsbvcZDU4Zmn9ZRUCW01FI1S8fNc
 pFScRBfMNP9nq7H3qm4Zz/b7hlbWIg336mGnECdKl9XfzjDeWdTBlXyjqjYCZftHhCP/
 ReoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BzoA0/p90w69kCv3e5Q2d2JhA6KtEucuiNdT/rFnC4I=;
 b=mNKnSd9gqxeNJDgZ5A9JsgUAI+QXjPXDPRYJzTZgGt2fPnpa7HcOn5XwO0Oy3WjeBL
 NkS1pWh7pTHovmYnjTZPft1F0B7h5KdjlByD2BbIF+6hm8F+Nc2Tvt/FIhOJxqH1nXUZ
 S8tDt7g+lbkJijows3W+xy/aURoDo1PM1nRQfdw5BEhztVm9Vo5BMuBfhAiHgGuKhXka
 X+QdAm3YKMd98s13lLUSSAoRMFgk4I3bUTUQDgDpistHk+5CCkKF6jjcX7ywKPblq2yO
 SWReZKHppxJmi1/+7y7A31A0gQKOMaH+4Wd/iwh+cXO5/T+pn9MnMwbsIdVIok1Ot2qc
 u9Xw==
X-Gm-Message-State: AOAM5300VVatKg34sRnHYtVBQN8i95iJsNF1nYuurlFXfRCaAzDJibtN
 JylYu2uEbWY4OC5lL+AmrDonrw==
X-Google-Smtp-Source: ABdhPJyM0RmlKSiadoyRmHxlgxkTDo9JK/uvB3fY0ok0WHJM9+gvf3MjB4rxoAncUj/U16DHjVwYaQ==
X-Received: by 2002:a5d:5752:: with SMTP id q18mr3531340wrw.176.1605275413797; 
 Fri, 13 Nov 2020 05:50:13 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:50:13 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 26/40] drm/amd/amdgpu/amdgpu_gmc: Demote one and fix another
 function header
Date: Fri, 13 Nov 2020 13:49:24 +0000
Message-Id: <20201113134938.4004947-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113134938.4004947-1-lee.jones@linaro.org>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 13 Nov 2020 14:28:19 +0000
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jOjY5OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdibycgbm90IGRlc2NyaWJlZCBpbiAnYW1kZ3B1X2dtY19wZF9h
ZGRyJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dtYy5jOjEyMTogd2Fybmlu
ZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnYm8nIG5vdCBkZXNjcmliZWQgaW4gJ2Ft
ZGdwdV9nbWNfYWdwX2FkZHInCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21j
LmM6MTIxOiB3YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICd0Ym8nIGRlc2NyaXB0
aW9uIGluICdhbWRncHVfZ21jX2FncF9hZGRyJwoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVy
LmRldWNoZXJAYW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5p
Z0BhbWQuY29tPgpDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVs
IFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzogYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVkLW9mZi1ieTogTGVl
IEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfZ21jLmMgfCA1ICsrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9nbWMuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nbWMu
YwppbmRleCAwNTZjYjg3ZDA5ZWEzLi5mZWRlODQ1MDlkYmNhIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZ21jLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2dtYy5jCkBAIC02MSw5ICs2MSw4IEBAIHZvaWQgYW1kZ3B1X2dtY19n
ZXRfcGRlX2Zvcl9ibyhzdHJ1Y3QgYW1kZ3B1X2JvICpibywgaW50IGxldmVsLAogCWFtZGdwdV9n
bWNfZ2V0X3ZtX3BkZShhZGV2LCBsZXZlbCwgYWRkciwgZmxhZ3MpOwogfQogCi0vKioKKy8qCiAg
KiBhbWRncHVfZ21jX3BkX2FkZHIgLSByZXR1cm4gdGhlIGFkZHJlc3Mgb2YgdGhlIHJvb3QgZGly
ZWN0b3J5Ci0gKgogICovCiB1aW50NjRfdCBhbWRncHVfZ21jX3BkX2FkZHIoc3RydWN0IGFtZGdw
dV9ibyAqYm8pCiB7CkBAIC0xMTIsNyArMTExLDcgQEAgaW50IGFtZGdwdV9nbWNfc2V0X3B0ZV9w
ZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsIHZvaWQgKmNwdV9wdF9hZGRyLAogLyoqCiAg
KiBhbWRncHVfZ21jX2FncF9hZGRyIC0gcmV0dXJuIHRoZSBhZGRyZXNzIGluIHRoZSBBR1AgYWRk
cmVzcyBzcGFjZQogICoKLSAqIEB0Ym86IFRUTSBCTyB3aGljaCBuZWVkcyB0aGUgYWRkcmVzcywg
bXVzdCBiZSBpbiBHVFQgZG9tYWluCisgKiBAYm86IFRUTSBCTyB3aGljaCBuZWVkcyB0aGUgYWRk
cmVzcywgbXVzdCBiZSBpbiBHVFQgZG9tYWluCiAgKgogICogVHJpZXMgdG8gZmlndXJlIG91dCBo
b3cgdG8gYWNjZXNzIHRoZSBCTyB0aHJvdWdoIHRoZSBBR1AgYXBlcnR1cmUuIFJldHVybnMKICAq
IEFNREdQVV9CT19JTlZBTElEX09GRlNFVCBpZiB0aGF0IGlzIG5vdCBwb3NzaWJsZS4KLS0gCjIu
MjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
