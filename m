Return-Path: <SRS0=C2iJ=EP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E30C63699
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B41206ED
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2020 21:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gos6PdJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B41206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62DF08975F;
	Mon,  9 Nov 2020 21:21:50 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15810892FA
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2020 21:19:27 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id 23so10376346wrc.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2020 13:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Tr0ixvpAne6ZdwZHnMFSb4ufpkRvb3k+F4potoikpiI=;
 b=gos6PdJK9eoOZt5jAVidZVPiNSp7oMO7v/VwIq7DXK6v8BMHqbyy322XdWXNcfBWKf
 rYyWHR0GBx0IoFGoaAXbiyoTaY9cr2uiACim4xVlAVhQp/drKv8pdLkhLS/HH5Kkx5md
 tol4j4FQeDeqF37INsLFh+mswbJiu4IN7tG/6B56wbIe2ENo8DXUBHxhH/Q+KYN9N6oH
 SelA1dZwpqUDcK+AXu+wxqkKMHHFLCicP4Uu5f2aAIJHV65JPoXv5nKByQNEr4PA1sO/
 nexs/LOKUrdFkJwytG62ilL+tRypUFvudMmo0ni9onyE480ckbyN2peZV9UCw2Qys3c0
 PIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Tr0ixvpAne6ZdwZHnMFSb4ufpkRvb3k+F4potoikpiI=;
 b=fZJ+SXFA6lk0lrqi1fcLMgcdJaS65GCOBzVOC4sqG2rCtfK2QyLJOPXLmnb1cXwiC9
 uapKRBIbgImAvYxVy3LepCX7tEeRgr6oXdH2mGM1ksG1DYSrcHcIUtmTjegNil9JV3zz
 ak3LtOWB59MOQyXuM1nKN8sS3Iq43MyuJ0ZS4UHbkDePvnlCMFMTMxA2H+h+Qs+yieC2
 8XsYF6wNzSWfXEtR2R56dmqa/HfXZAEYdluBfazz8tA8H8EFws6jw/jNtcZls67ejswz
 0sX5iwuYz0CHMYfmXhpRfMUmMaA1cH0dDyGIeUKd3cHg4PyRBGpvAL7b7NFw5Foa8Oqx
 9i6Q==
X-Gm-Message-State: AOAM532kouCoF2U5VHQ+DDUz6tMLx/GfAucSAeXHRZIG+o5rH8H/0kVE
 e2FjvVE6Ek0NLtJS2zQFq4diaiVzxmqa2vZM
X-Google-Smtp-Source: ABdhPJyBmNq1JIYMn1Ln21eExIKIRlKHSenjgVq526BS9p+l/W7PscsUXFgUiNU3unXijKsSI7AghA==
X-Received: by 2002:a05:6000:1006:: with SMTP id
 a6mr11354521wrx.367.1604956765807; 
 Mon, 09 Nov 2020 13:19:25 -0800 (PST)
Received: from dell.default ([91.110.221.139])
 by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 13:19:25 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 09/20] drm/radeon/radeon_irq_kms: Demote non-conformant
 kernel-doc fix another
Date: Mon,  9 Nov 2020 21:18:44 +0000
Message-Id: <20201109211855.3340030-10-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 09 Nov 2020 21:21:41 +0000
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
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5jOjU2OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdpcnEnIG5vdCBkZXNjcmliZWQgaW4gJ3JhZGVvbl9kcml2ZXJf
aXJxX2hhbmRsZXJfa21zJwogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJxX2ttcy5j
OjU2OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdhcmcnIG5vdCBkZXNj
cmliZWQgaW4gJ3JhZGVvbl9kcml2ZXJfaXJxX2hhbmRsZXJfa21zJwogZHJpdmVycy9ncHUvZHJt
L3JhZGVvbi9yYWRlb25faXJxX2ttcy5jOjU3MTogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVy
IG9yIG1lbWJlciAnbicgbm90IGRlc2NyaWJlZCBpbiAncmFkZW9uX2lycV9rbXNfc2V0X2lycV9u
X2VuYWJsZWQnCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9pcnFfa21zLmM6NTcxOiB3
YXJuaW5nOiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdudW0nIGRlc2NyaXB0aW9uIGluICdy
YWRlb25faXJxX2ttc19zZXRfaXJxX25fZW5hYmxlZCcKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5r
b2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6
IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25faXJxX2ttcy5jIHwgNiArKy0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3Jh
ZGVvbi9yYWRlb25faXJxX2ttcy5jIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25faXJx
X2ttcy5jCmluZGV4IGI4NmJjODhhZDQzMDguLjM1MjEwODQwMzBkMjQgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2lycV9rbXMuYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vcmFkZW9uL3JhZGVvbl9pcnFfa21zLmMKQEAgLTQzLDExICs0Myw5IEBACiAKICNkZWZpbmUg
UkFERU9OX1dBSVRfSURMRV9USU1FT1VUIDIwMAogCi0vKioKKy8qCiAgKiByYWRlb25fZHJpdmVy
X2lycV9oYW5kbGVyX2ttcyAtIGlycSBoYW5kbGVyIGZvciBLTVMKICAqCi0gKiBAaW50IGlycSwg
dm9pZCAqYXJnOiBhcmdzCi0gKgogICogVGhpcyBpcyB0aGUgaXJxIGhhbmRsZXIgZm9yIHRoZSBy
YWRlb24gS01TIGRyaXZlciAoYWxsIGFzaWNzKS4KICAqIHJhZGVvbl9pcnFfcHJvY2VzcyBpcyBh
IG1hY3JvIHRoYXQgcG9pbnRzIHRvIHRoZSBwZXItYXNpYwogICogaXJxIGhhbmRsZXIgY2FsbGJh
Y2suCkBAIC01NTYsNyArNTU0LDcgQEAgdm9pZCByYWRlb25faXJxX2ttc19kaXNhYmxlX2hwZChz
dHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiwgdW5zaWduZWQgaHBkX21hc2spCiAgKiBAbWFzazog
dGhlIG1hc2sgdGhhdCBlbmFibGVzIHRoZSBpbnRlcnJ1cHRzCiAgKiBAZW5hYmxlOiB3aGV0aGVy
IHRvIGVuYWJsZSBvciBkaXNhYmxlIHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIKICAqIEBuYW1lOiB0
aGUgbmFtZSBvZiB0aGUgaW50ZXJydXB0IHJlZ2lzdGVyIHRvIHByaW50IHRvIHRoZSBrZXJuZWwg
bG9nCi0gKiBAbnVtOiB0aGUgbnVtYmVyIG9mIHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIgdG8gcHJp
bnQgdG8gdGhlIGtlcm5lbCBsb2cKKyAqIEBuOiB0aGUgbnVtYmVyIG9mIHRoZSBpbnRlcnJ1cHQg
cmVnaXN0ZXIgdG8gcHJpbnQgdG8gdGhlIGtlcm5lbCBsb2cKICAqCiAgKiBIZWxwZXIgZm9yIHVw
ZGF0aW5nIHRoZSBlbmFibGUgc3RhdGUgb2YgaW50ZXJydXB0IHJlZ2lzdGVycy4gQ2hlY2tzIHdo
ZXRoZXIKICAqIG9yIG5vdCB0aGUgaW50ZXJydXB0IG1hdGNoZXMgdGhlIGVuYWJsZSBzdGF0ZSB3
ZSB3YW50LiBJZiBpdCBkb2Vzbid0LCB0aGVuCi0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1n
ZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21h
aWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
