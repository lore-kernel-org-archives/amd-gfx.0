Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE410C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97840239A1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97840239A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1916E912;
	Fri,  8 Jan 2021 20:24:24 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F4246E8CB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:12 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id g185so9441006wmf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/ToVqtfELMjein9lDL+03lGe+1Pl1kI6Nuvl2V02OQw=;
 b=nPDEIclvcchArGWcIIvap7p0tV/Rf2lx9TgJnp2hWX/nn04pew9eH1DzQvuV0oY5dO
 uYlPu7t+/BwZmmgpIRvGBX6xDjVNdvmLl+T2XbI2y544GNEB6poJK2wXefPMvuaFj0LP
 1bCfmVawsAnd5iffgC8cCaUk23jdkFMPX+hldzpdztsaQnGn2D8TM1pnYc4PdJ6sTXk3
 P1sqHnU5kzx2HnlGpQuZsYJ+pxTCkn5kn6mPH3fPIPc1QO5y/Xrw6NNIr/Q1c7Xnw8aQ
 r9Pdv/WXBOoNMt3BNY+r7SM95gZeSzHHPx7Kev1iki8AutO6xe2Cz9US+Kdjr5TXZeoz
 MdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/ToVqtfELMjein9lDL+03lGe+1Pl1kI6Nuvl2V02OQw=;
 b=iP2ncHNo4xX87+YzTLViL3EKsRh1j80Ce0GhnXiGTE5dkBFXddy9qu+S/goEIBBEDS
 ZqW2Vi/yuphaYufQQl7Mw2ct97iT4oNQoMCwsNI9KqUoYgQQdhzXfTeklzvvnPUY5EyE
 QmMMgbNR8NQFCzeGRzT46q3SsocZZ5uO46rmwd25N8apxYTh9TOztcL2fTKT7HmA2nuL
 BvnSNjRJUGoh3qUS3YL/ljL7sQOf2S90CfJLpxn4/XVg3LB8E6txNsG8bMMSYadS0rPr
 NOX6vGkw+vEa/SVx5A8aXHBwWLFvy6jCm9xUnNp7hsOS44hnqJ/8PV2YGw0t6uLavwrY
 Xvfw==
X-Gm-Message-State: AOAM532Ge5bryrqKModX4lodxo2kAimHPWVpME4eYmAH8FQA3DYH+05M
 HL7IIkrpqo6gUtiDH1OMf1gaCw==
X-Google-Smtp-Source: ABdhPJwLriGozB2TPxioYAuJqC4MQxJsUyszHxe6cwB1QkejO+IfiqkrvkQrmnCI6WmGh/14mcUFyg==
X-Received: by 2002:a1c:1d08:: with SMTP id d8mr4586040wmd.159.1610136911373; 
 Fri, 08 Jan 2021 12:15:11 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:10 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 05/40] drm/amd/amdgpu/vega20_ih: Add missing descriptions for
 'ih' and fix spelling error
Date: Fri,  8 Jan 2021 20:14:22 +0000
Message-Id: <20210108201457.3078600-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Jan 2021 20:24:14 +0000
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
Cc: David Airlie <airlied@linux.ie>, Feifei Xu <Feifei.Xu@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmM6Mzc4OiB3YXJuaW5nOiBGdW5jdGlvbiBw
YXJhbWV0ZXIgb3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJlZCBpbiAndmVnYTIwX2loX2dldF93
cHRyJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmM6NDIxOiB3YXJuaW5n
OiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJlZCBpbiAndmVn
YTIwX2loX2lycV9yZWFybScKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9paC5j
OjQ0Nzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnaWgnIG5vdCBkZXNj
cmliZWQgaW4gJ3ZlZ2EyMF9paF9zZXRfcnB0cicKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2Vu
aWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmll
bCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IEhhd2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhh
bmdAYW1kLmNvbT4KQ2M6IEZlaWZlaSBYdSA8RmVpZmVpLlh1QGFtZC5jb20+CkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9paC5jIHwgNSArKysrLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3ZlZ2EyMF9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvdmVnYTIwX2loLmMKaW5kZXggNDIwMzJjYTM4MGNjZi4uNWEzYzg2N2Q1ODgxMSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmVnYTIwX2loLmMKQEAgLTg4LDcgKzg4LDcgQEAgc3Rh
dGljIHZvaWQgdmVnYTIwX2loX2luaXRfcmVnaXN0ZXJfb2Zmc2V0KHN0cnVjdCBhbWRncHVfZGV2
aWNlICphZGV2KQogICogdmVnYTIwX2loX3RvZ2dsZV9yaW5nX2ludGVycnVwdHMgLSB0b2dnbGUg
dGhlIGludGVycnVwdCByaW5nIGJ1ZmZlcgogICoKICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBv
aW50ZXIKLSAqIEBpaDogYW1kZ3B1X2loX3JpbmcgcG9pbnRldAorICogQGloOiBhbWRncHVfaWhf
cmluZyBwb2ludGVyCiAgKiBAZW5hYmxlOiB0cnVlIC0gZW5hYmxlIHRoZSBpbnRlcnJ1cHRzLCBm
YWxzZSAtIGRpc2FibGUgdGhlIGludGVycnVwdHMKICAqCiAgKiBUb2dnbGUgdGhlIGludGVycnVw
dCByaW5nIGJ1ZmZlciAoVkVHQTIwKQpAQCAtMzY3LDYgKzM2Nyw3IEBAIHN0YXRpYyB2b2lkIHZl
Z2EyMF9paF9pcnFfZGlzYWJsZShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKICAqIHZlZ2Ey
MF9paF9nZXRfd3B0ciAtIGdldCB0aGUgSUggcmluZyBidWZmZXIgd3B0cgogICoKICAqIEBhZGV2
OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKKyAqIEBpaDogYW1kZ3B1X2loX3JpbmcgcG9pbnRlcgog
ICoKICAqIEdldCB0aGUgSUggcmluZyBidWZmZXIgd3B0ciBmcm9tIGVpdGhlciB0aGUgcmVnaXN0
ZXIKICAqIG9yIHRoZSB3cml0ZWJhY2sgbWVtb3J5IGJ1ZmZlciAoVkVHQTIwKS4gIEFsc28gY2hl
Y2sgZm9yCkBAIC00MTQsNiArNDE1LDcgQEAgc3RhdGljIHUzMiB2ZWdhMjBfaWhfZ2V0X3dwdHIo
c3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAgKiB2ZWdhMjBfaWhfaXJxX3JlYXJtIC0gcmVh
cm0gSVJRIGlmIGxvc3QKICAqCiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisgKiBA
aWg6IGFtZGdwdV9paF9yaW5nIHBvaW50ZXIKICAqCiAgKi8KIHN0YXRpYyB2b2lkIHZlZ2EyMF9p
aF9pcnFfcmVhcm0oc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCkBAIC00MzksNiArNDQxLDcg
QEAgc3RhdGljIHZvaWQgdmVnYTIwX2loX2lycV9yZWFybShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAq
YWRldiwKICAqIHZlZ2EyMF9paF9zZXRfcnB0ciAtIHNldCB0aGUgSUggcmluZyBidWZmZXIgcnB0
cgogICoKICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKKyAqIEBpaDogYW1kZ3B1X2lo
X3JpbmcgcG9pbnRlcgogICoKICAqIFNldCB0aGUgSUggcmluZyBidWZmZXIgcnB0ci4KICAqLwot
LSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
