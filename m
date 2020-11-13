Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3743EC388F7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F1820715
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XgoN5URO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F1820715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499506E5A3;
	Fri, 13 Nov 2020 14:28:21 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 628C56E520
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:50:16 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id 23so9965912wrc.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q9ZMy9yV2j61eWz6SjAdF0UqQLfaNl51XLKZiRseNxA=;
 b=XgoN5UROCU74VPm0D6Gls7Y1ukWa5LQzEWehKotsuQV5kktrJh+HttfN1sHyw4l5/g
 07v8zOyhGYA21GAy3RlWbSHEisIPtE2LF/+VLLhtjSmvQb9dsNSMY8L2xN66Zlf1K7d8
 6RF4WZoD0y0TB3RoLJURUnsMHyS2azk2aYXQZxPAquIrGnFIviJ3lIttEqdiQpCFFgRM
 lWoNVox2yrau1SurBJYU+y2EscCGmhnVbuO15ymULXP0EtxutOTj1R90QiCX96UWYX1g
 32HpSCBEM3I6h15HD6MxmSj/7jJP+vEtL6UHjfQKpbWwHuzPJrvM59B9DjLlElzF+Wim
 CX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q9ZMy9yV2j61eWz6SjAdF0UqQLfaNl51XLKZiRseNxA=;
 b=WBZhd9xArkY6R4eawxv/juB7j8HrTs0SlkUWbItMnowPNPpiPbPnU9j0cC7Z0LVPtk
 xQ2Lo75acV1aI1CVsRmrxW5Zi/Rt3bYn4sJP0p/nGLGvzeXyCo5v/DAV0f4GSJ3FJSS2
 +ADty5gNFdOZbWwjnQsVJZYt1toDjYNhZt6b9eN1c94hr8oerneJrq3vTOAeSbV4aKjN
 +zGpcX4/7gfV8DxSj6ehOHmaLraLL1ISVbb6BpnNLLNVbJsDzCwKgek+op9Wk1gS67/g
 ZCsp4FzXU0FiY5qj3Tj0rO3ogvGiV/dGoZvTwRMloAY50jjzyiAdTyzJIiROhQ/SYuOU
 pA5g==
X-Gm-Message-State: AOAM531XZVd7OAVIGheI3qd60bbSl80texp1mFdUkN8fn0dmma3xhLa4
 3LUEdCtaEO1/Xvm2KbKnBRLFAw==
X-Google-Smtp-Source: ABdhPJyt3UaqN0DY3PXZIq/9W20F0CsxHUADWPQiQ1mTODJ4G8vQQUO48TILVZYfO5zUlhQ++MrN6Q==
X-Received: by 2002:adf:e945:: with SMTP id m5mr3445312wrn.98.1605275414993;
 Fri, 13 Nov 2020 05:50:14 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:50:14 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 27/40] drm/amd/amdgpu/amdgpu_ras: Remove unused function
 'amdgpu_ras_error_cure'
Date: Fri, 13 Nov 2020 13:49:25 +0000
Message-Id: <20201113134938.4004947-28-lee.jones@linaro.org>
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jOjkwODo1OiB3YXJuaW5nOiBubyBwcmV2
aW91cyBwcm90b3R5cGUgZm9yIOKAmGFtZGdwdV9yYXNfZXJyb3JfY3VyZeKAmSBbLVdtaXNzaW5n
LXByb3RvdHlwZXNdCgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25l
c0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YyB8IDcgLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCmluZGV4IGI5NjI2NzA2OGE3MmQuLmY4OWE5OTE5
OTk0MjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKQEAgLTkwNSwx
MyArOTA1LDYgQEAgaW50IGFtZGdwdV9yYXNfZXJyb3JfaW5qZWN0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2LAogCXJldHVybiByZXQ7CiB9CiAKLWludCBhbWRncHVfcmFzX2Vycm9yX2N1cmUo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0JCXN0cnVjdCByYXNfY3VyZV9pZiAqaW5mbykK
LXsKLQkvKiBwc3AgZncgaGFzIG5vIGN1cmUgaW50ZXJmYWNlIGZvciBub3cuICovCi0JcmV0dXJu
IDA7Ci19Ci0KIC8qIGdldCB0aGUgdG90YWwgZXJyb3IgY291bnRzIG9uIGFsbCBJUHMgKi8KIHVu
c2lnbmVkIGxvbmcgYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3VudChzdHJ1Y3QgYW1kZ3B1X2Rl
dmljZSAqYWRldiwKIAkJYm9vbCBpc19jZSkKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFp
bG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
