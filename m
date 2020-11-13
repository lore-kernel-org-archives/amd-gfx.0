Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B49C6379F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3036322245
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 14:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mY/s0pYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3036322245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDC26E5C1;
	Fri, 13 Nov 2020 14:28:30 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 074136E513
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 13:50:28 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p19so8099327wmg.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 05:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TmFIQSl/IxBdBhsOtG9qrJEA42yvhnGh386TMGMyma8=;
 b=mY/s0pYDEoGhbLaQa/mv0EUVIX+EyJgNnog2bItqV1cG1dEk25StILdGwjZJr5xxih
 FN8D6trlrMabKXBVahRxImsO1cUh5U0yCpMjVlRhdC7f2lwIilN0wEAbaIZVmkudgOew
 6U5Phpb6rM9IxfRwf29E5HtkETLUe3GZL3Rly56wL6E0lRQKZWxLyHDOXhpwvhX+fj6q
 FEL27rKQFfLhxVjg47ANuOyvEoxc16GxFG8cNbQlTMNtocun5CR0V6VQ/3qUNnA/bw9j
 Y7mGAUDGEPDLA8vzFcQWNafqTLmlW4tRKhtxLbzc2CBi5ozxwtW3JirbIFn271BoCVV+
 XETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TmFIQSl/IxBdBhsOtG9qrJEA42yvhnGh386TMGMyma8=;
 b=AI0W3lgycQn3DoBFmc3k5EcaP4uHmxInDGvYYPua/z5vFNRdD3jHH6w6eFy0UQiE2p
 5NPjbtDxXGksuFs7uM4G4cZLehAN6gGDYix/YnTsyRR695JQ5FhMkouDG/zweS7T/uGy
 JO0jhV4yXwSZolPBf+OcU4BR1Admb8zCTS3Ouy5l1hRoWclR7K3T8p6oCIH5zLJr8oAA
 7+YqwjAFiyYyHrc1U99OhUOJztZJvCQXoKh0WRfc6P5whrczYFjje92BZOTrW4iMACIV
 EWi6FHs0S8ZbPpqlqSQaXBZ2i6lX068pl2XTaPxi/Ab8w3l9EAWfp0nUAptj9YXNBxjv
 wUow==
X-Gm-Message-State: AOAM531OMBZQhUP8tdFfIgoYvgI74p5LSS/iVhbnxnIHjR7Ugqp+mApg
 xG10T3ZRTKBvQtPERYjgFJieox+HJG+r8mAP
X-Google-Smtp-Source: ABdhPJzsd+Ru1JA3QyUUZZ09hbsVbGu88ARk0E7Q8iGeLhCIiOkJZYAxunX6gQT2AgjsanxOIzz/SA==
X-Received: by 2002:a1c:f405:: with SMTP id z5mr2617695wma.126.1605275426666; 
 Fri, 13 Nov 2020 05:50:26 -0800 (PST)
Received: from dell.default ([91.110.221.159])
 by smtp.gmail.com with ESMTPSA id t11sm4561614wrm.8.2020.11.13.05.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 05:50:26 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 36/40] drm/amd/amdgpu/amdgpu_fw_attestation: Consume our own
 header containing prototypes
Date: Fri, 13 Nov 2020 13:49:34 +0000
Message-Id: <20201113134938.4004947-37-lee.jones@linaro.org>
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
 John Clements <john.clements@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Z3X2F0dGVzdGF0aW9uLmM6MTMwOjY6IHdhcm5p
bmc6IG5vIHByZXZpb3VzIHByb3RvdHlwZSBmb3Ig4oCYYW1kZ3B1X2Z3X2F0dGVzdGF0aW9uX2Rl
YnVnZnNfaW5pdOKAmSBbLVdtaXNzaW5nLXByb3RvdHlwZXNdCgpDYzogQWxleCBEZXVjaGVyIDxh
bGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3Rp
YW4ua29lbmlnQGFtZC5jb20+CkNjOiBEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNj
OiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+CkNjOiBIYXdraW5nIFpoYW5nIDxIYXdr
aW5nLlpoYW5nQGFtZC5jb20+CkNjOiBKb2huIENsZW1lbnRzIDxqb2huLmNsZW1lbnRzQGFtZC5j
b20+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5h
cm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9md19hdHRlc3Rh
dGlvbi5jIHwgMyArKy0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZndf
YXR0ZXN0YXRpb24uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9md19hdHRl
c3RhdGlvbi5jCmluZGV4IGM2OTQ3ZDZjN2ZmNTEuLmU0N2JjYTFjNzYzNTkgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9md19hdHRlc3RhdGlvbi5jCisrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9md19hdHRlc3RhdGlvbi5jCkBAIC0y
Niw2ICsyNiw3IEBACiAjaW5jbHVkZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KIAogI2luY2x1ZGUg
ImFtZGdwdS5oIgorI2luY2x1ZGUgImFtZGdwdV9md19hdHRlc3RhdGlvbi5oIgogI2luY2x1ZGUg
ImFtZGdwdV9wc3AuaCIKICNpbmNsdWRlICJhbWRncHVfdWNvZGUuaCIKICNpbmNsdWRlICJzb2Mx
NV9jb21tb24uaCIKQEAgLTEzOSw0ICsxNDAsNCBAQCB2b2lkIGFtZGdwdV9md19hdHRlc3RhdGlv
bl9kZWJ1Z2ZzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJCQkgICAgYWRldiwK
IAkJCSAgICAmYW1kZ3B1X2Z3X2F0dGVzdGF0aW9uX2RlYnVnZnNfb3BzKTsKICNlbmRpZgotfQpc
IE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKK30KLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
