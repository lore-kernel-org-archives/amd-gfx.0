Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F87C56201
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E2D20872
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 08:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXlVUxy6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E2D20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C3816E878;
	Wed, 25 Nov 2020 08:22:59 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 760746E536
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 19:44:05 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a186so87791wme.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 11:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=L1J0FZrjGGbUvQrx4IUztzi5KvWWyU4p9mOY8CTJ3cA=;
 b=QXlVUxy6zeD7fG03DNRKZjOqWu/z5RftRerC7Nod0O6W82BFawtqlxypHgaR1y9cfS
 k4JVEcy4z2Sokjv0yUDlvFXL5rq2nVg+yG/XbM1ihly/c3pBUyKJBBqvWsEU772LQEJi
 IWtiAhdZe3S/MYFSU926bn1kXQwdlXGWXdZ+XUY5cN4hL72ZhijYDA/HDl1sh1wAwNu5
 XHyg/zNL2MIRxkfwfrh8n2HtZZohtLXDT9KfKPmgENUntqkpNScWvK+SWC/Pfwfq38MM
 P4fDdeodGJmFfOFLqHbuJ62dssNCTGpSfSnlew6jTU30F5HKWC0TY1t5QwaH7HwKEP+v
 vhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=L1J0FZrjGGbUvQrx4IUztzi5KvWWyU4p9mOY8CTJ3cA=;
 b=K281X3i334zGuFebr0jrrfIWmHjwF71B/tUAp5qpJFytkd94l6W1/eXAvnFuX91hyB
 vexg1h4CBzm5/wgvsGDuy3uqMQjN7TyuxKyQLe/upBr5uDBl0bGrmLrPbZxIF9cv6c+V
 Jrr4jOVEvc2I+d5c69IbMZ2EtLRzUXut6jiCEvpvcbr9EZhkk1rX4L9z8AB/N8SvsF4u
 r8ybwZbqE2kp4LAgbiyHwWVpyyzpTXJfHlT03lJ2VJV3+A3f857Rd0PVV3XGS7uDRu3z
 TjMt9K+OKRQs/F+5iSvp32QDkoErHZzhLISY1IwNA11Gzgz2O0YJUFtFxyoPjSrRMjQN
 6URA==
X-Gm-Message-State: AOAM533Ddtfzr6P/ExybGw7vBYXBPZMrg1pSgGPXS0pGlq8mpgrdH5i5
 SsYooR0ZBeVYA0m2Nlis1p0mEg==
X-Google-Smtp-Source: ABdhPJxc2TNfGqS0ggO4k/it/goFudlMzzl3LPT5tEdGbregUV4F60QAMLaiU8tsX9d38vnfFQcSEw==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr134617wmg.163.1606247044173; 
 Tue, 24 Nov 2020 11:44:04 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id d134sm200511wmd.8.2020.11.24.11.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 11:44:03 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 04/40] drm/amd/amdgpu/iceland_ih: Add missing function param
 descriptions for 'ih' and 'entry'
Date: Tue, 24 Nov 2020 19:37:48 +0000
Message-Id: <20201124193824.1118741-5-lee.jones@linaro.org>
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
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvaWNlbGFuZF9paC5jOjE5MTogd2FybmluZzogRnVuY3Rpb24g
cGFyYW1ldGVyIG9yIG1lbWJlciAnaWgnIG5vdCBkZXNjcmliZWQgaW4gJ2ljZWxhbmRfaWhfZ2V0
X3dwdHInCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pY2VsYW5kX2loLmM6MjIzOiB3YXJu
aW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJlZCBpbiAn
aWNlbGFuZF9paF9kZWNvZGVfaXYnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9pY2VsYW5k
X2loLmM6MjIzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdlbnRyeScg
bm90IGRlc2NyaWJlZCBpbiAnaWNlbGFuZF9paF9kZWNvZGVfaXYnCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9pY2VsYW5kX2loLmM6MjUzOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIg
b3IgbWVtYmVyICdpaCcgbm90IGRlc2NyaWJlZCBpbiAnaWNlbGFuZF9paF9zZXRfcnB0cicKCkNj
OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFu
IEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWly
bGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWNlbGFuZF9paC5jIHwgNCArKysrCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvaWNlbGFuZF9paC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaWNl
bGFuZF9paC5jCmluZGV4IGExM2RkOWE1MTE0OWEuLjM3ZDhiNmNhNGRhYjggMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2ljZWxhbmRfaWguYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9pY2VsYW5kX2loLmMKQEAgLTE3OSw2ICsxNzksNyBAQCBzdGF0aWMg
dm9pZCBpY2VsYW5kX2loX2lycV9kaXNhYmxlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQog
ICogaWNlbGFuZF9paF9nZXRfd3B0ciAtIGdldCB0aGUgSUggcmluZyBidWZmZXIgd3B0cgogICoK
ICAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50ZXIKKyAqIEBpaDogSUggcmluZyBidWZmZXIg
dG8gZmV0Y2ggd3B0cgogICoKICAqIEdldCB0aGUgSUggcmluZyBidWZmZXIgd3B0ciBmcm9tIGVp
dGhlciB0aGUgcmVnaXN0ZXIKICAqIG9yIHRoZSB3cml0ZWJhY2sgbWVtb3J5IGJ1ZmZlciAoVkkp
LiAgQWxzbyBjaGVjayBmb3IKQEAgLTIxMyw2ICsyMTQsOCBAQCBzdGF0aWMgdTMyIGljZWxhbmRf
aWhfZ2V0X3dwdHIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAgKiBpY2VsYW5kX2loX2Rl
Y29kZV9pdiAtIGRlY29kZSBhbiBpbnRlcnJ1cHQgdmVjdG9yCiAgKgogICogQGFkZXY6IGFtZGdw
dV9kZXZpY2UgcG9pbnRlcgorICogQGloOiBJSCByaW5nIGJ1ZmZlciB0byBkZWNvZGUKKyAqIEBl
bnRyeTogSVYgZW50cnkgdG8gcGxhY2UgZGVjb2RlZCBpbmZvcm1hdGlvbiBpbnRvCiAgKgogICog
RGVjb2RlcyB0aGUgaW50ZXJydXB0IHZlY3RvciBhdCB0aGUgY3VycmVudCBycHRyCiAgKiBwb3Np
dGlvbiBhbmQgYWxzbyBhZHZhbmNlIHRoZSBwb3NpdGlvbi4KQEAgLTI0NSw2ICsyNDgsNyBAQCBz
dGF0aWMgdm9pZCBpY2VsYW5kX2loX2RlY29kZV9pdihzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
diwKICAqIGljZWxhbmRfaWhfc2V0X3JwdHIgLSBzZXQgdGhlIElIIHJpbmcgYnVmZmVyIHJwdHIK
ICAqCiAgKiBAYWRldjogYW1kZ3B1X2RldmljZSBwb2ludGVyCisgKiBAaWg6IElIIHJpbmcgYnVm
ZmVyIHRvIHNldCBycHRyCiAgKgogICogU2V0IHRoZSBJSCByaW5nIGJ1ZmZlciBycHRyLgogICov
Ci0tIAoyLjI1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
