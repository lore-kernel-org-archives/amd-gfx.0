Return-Path: <SRS0=Guv+=FB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2745C64E90
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDFA206C0
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2020 10:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KS9rezDP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDFA206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C084E6EC0C;
	Fri, 27 Nov 2020 10:15:07 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F99A6E957
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 13:43:33 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a3so2447926wmb.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2020 05:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aby0rkFSc8Z8n2GfbnJMGwcXmsbKBW3Qw486TCADV5Q=;
 b=KS9rezDPHF4lJPHeXTEzQv//j6gJAj01Y9abTsVhXJGUNfMvvq61u2fvx8NkTyvSvz
 5PNXYeVNUVn/eLVZLLaGtU2hWozWLb2zxKeozOenCwJcRMfeqPsx6RsCqIStffOPrn8w
 UjJ/fbBDLbG5uyFaoyIx/uuero3LTMuoZbifOmkIcYB78DPAogQWaLFs9/+UyaXlpJFk
 Ywd72NT2ORdTOevBH1ID3BhUV2FDC6zfpZM4fqGkwaGyZUqGZ+62+vzUOqS6IcxppsWG
 JNFRR34u0WMmm40gsVuNbO6hOjagpyiV0yCSi1OPu4gmH9jbFk2JMSuv2mBCD9zK0Cc5
 qaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aby0rkFSc8Z8n2GfbnJMGwcXmsbKBW3Qw486TCADV5Q=;
 b=Kw5hThFjPooz79bqYC53yEBnAVfzGOLvtIC4MklFJvJIRh+k2X1wvvuX1UjBnc32F6
 yMJjEr/ym6J+k7JLYu9fncENkTyQMseOnB4keUQUjqE9ECrUwigXJyptoBvYOFaz77Vw
 4/kmfkPMt4If+wU4XMjm+2XZrnO7MXSBbpuaCCsh029f55PYwHKXvzi38noo7JtNSmFG
 q0URcRdrAPHT2r5rVhasBif1zrIufbSrA1kwPPwnA26s07Ql45tN0oQYMbqANRcvlZLC
 SByTYZg0Se5JfyQOuTS4GGXu4SBySiv7seEBCVKS7diYheepFMOxbgJ0eakJWpH8YF3r
 /thQ==
X-Gm-Message-State: AOAM531Wgk1nNHsaFwQdeo7ytCBjvCcJjXSWPCCRqOj2r77rOkBRJ0U3
 o4nqhTDkpWNvfRS/u43XOuxeng==
X-Google-Smtp-Source: ABdhPJx+oPPXlVayNH6FEyJTBRJMaO5+XGDQRElESgaYHqSQjOan4W1ec4YWsQ/Th5MN6MLEsC28Nw==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr3411531wme.85.1606398211846; 
 Thu, 26 Nov 2020 05:43:31 -0800 (PST)
Received: from dell.default ([91.110.221.235])
 by smtp.gmail.com with ESMTPSA id k205sm9275738wmk.4.2020.11.26.05.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 05:43:31 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 31/40] drm/amd/pm/powerplay/kv_dpm: Remove unused variable
 'ret'
Date: Thu, 26 Nov 2020 13:42:31 +0000
Message-Id: <20201126134240.3214176-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126134240.3214176-1-lee.jones@linaro.org>
References: <20201126134240.3214176-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Nov 2020 10:14:32 +0000
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
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2t2X2RwbS5jOiBJbiBmdW5jdGlv
biDigJhrdl9kcG1fcG93ZXJnYXRlX3V2ZOKAmToKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL3BtL3Bvd2VycGxheS9rdl9kcG0uYzoxNjc4OjY6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHJl
dOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2t2X2RwbS5jOiBJbiBmdW5jdGlv
biDigJhrdl9kcG1fcG93ZXJnYXRlX3ZjZeKAmToKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
Ly4uL3BtL3Bvd2VycGxheS9rdl9kcG0uYzoxNzA2OjY6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmHJl
dOKAmSBzZXQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQoKQ2M6IEV2
YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5k
ZXVjaGVyQGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdA
YW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBW
ZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
CkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBK
b25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9w
b3dlcnBsYXkva3ZfZHBtLmMgfCAxOCArKysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2Vk
LCA4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvcG0vcG93ZXJwbGF5L2t2X2RwbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9w
bS9wb3dlcnBsYXkva3ZfZHBtLmMKaW5kZXggNGIzZmFhY2NlY2I5NC4uNjZkYWFiZWJlZTM1OCAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkva3ZfZHBtLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9wb3dlcnBsYXkva3ZfZHBtLmMKQEAgLTE2NzUsMTQg
KzE2NzUsMTMgQEAgc3RhdGljIHZvaWQga3ZfZHBtX3Bvd2VyZ2F0ZV91dmQodm9pZCAqaGFuZGxl
LCBib29sIGdhdGUpCiB7CiAJc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSAoc3RydWN0IGFt
ZGdwdV9kZXZpY2UgKiloYW5kbGU7CiAJc3RydWN0IGt2X3Bvd2VyX2luZm8gKnBpID0ga3ZfZ2V0
X3BpKGFkZXYpOwotCWludCByZXQ7CiAKIAlwaS0+dXZkX3Bvd2VyX2dhdGVkID0gZ2F0ZTsKIAog
CWlmIChnYXRlKSB7CiAJCS8qIHN0b3AgdGhlIFVWRCBibG9jayAqLwotCQlyZXQgPSBhbWRncHVf
ZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9V
VkQsCi0JCQkJCQkJICAgICBBTURfUEdfU1RBVEVfR0FURSk7CisJCWFtZGdwdV9kZXZpY2VfaXBf
c2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFNRF9JUF9CTE9DS19UWVBFX1VWRCwKKwkJCQkJ
CSAgICAgICBBTURfUEdfU1RBVEVfR0FURSk7CiAJCWt2X3VwZGF0ZV91dmRfZHBtKGFkZXYsIGdh
dGUpOwogCQlpZiAocGktPmNhcHNfdXZkX3BnKQogCQkJLyogcG93ZXIgb2ZmIHRoZSBVVkQgYmxv
Y2sgKi8KQEAgLTE2OTQsOCArMTY5Myw4IEBAIHN0YXRpYyB2b2lkIGt2X2RwbV9wb3dlcmdhdGVf
dXZkKHZvaWQgKmhhbmRsZSwgYm9vbCBnYXRlKQogCQkJLyogcmUtaW5pdCB0aGUgVVZEIGJsb2Nr
ICovCiAJCWt2X3VwZGF0ZV91dmRfZHBtKGFkZXYsIGdhdGUpOwogCi0JCXJldCA9IGFtZGdwdV9k
ZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFNRF9JUF9CTE9DS19UWVBFX1VW
RCwKLQkJCQkJCQkgICAgIEFNRF9QR19TVEFURV9VTkdBVEUpOworCQlhbWRncHVfZGV2aWNlX2lw
X3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9VVkQsCisJCQkJ
CQkgICAgICAgQU1EX1BHX1NUQVRFX1VOR0FURSk7CiAJfQogfQogCkBAIC0xNzAzLDE0ICsxNzAy
LDEzIEBAIHN0YXRpYyB2b2lkIGt2X2RwbV9wb3dlcmdhdGVfdmNlKHZvaWQgKmhhbmRsZSwgYm9v
bCBnYXRlKQogewogCXN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVf
ZGV2aWNlICopaGFuZGxlOwogCXN0cnVjdCBrdl9wb3dlcl9pbmZvICpwaSA9IGt2X2dldF9waShh
ZGV2KTsKLQlpbnQgcmV0OwogCiAJcGktPnZjZV9wb3dlcl9nYXRlZCA9IGdhdGU7CiAKIAlpZiAo
Z2F0ZSkgewogCQkvKiBzdG9wIHRoZSBWQ0UgYmxvY2sgKi8KLQkJcmV0ID0gYW1kZ3B1X2Rldmlj
ZV9pcF9zZXRfcG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgQU1EX0lQX0JMT0NLX1RZUEVfVkNFLAot
CQkJCQkJCSAgICAgQU1EX1BHX1NUQVRFX0dBVEUpOworCQlhbWRncHVfZGV2aWNlX2lwX3NldF9w
b3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9WQ0UsCisJCQkJCQkgICAg
ICAgQU1EX1BHX1NUQVRFX0dBVEUpOwogCQlrdl9lbmFibGVfdmNlX2RwbShhZGV2LCBmYWxzZSk7
CiAJCWlmIChwaS0+Y2Fwc192Y2VfcGcpIC8qIHBvd2VyIG9mZiB0aGUgVkNFIGJsb2NrICovCiAJ
CQlhbWRncHVfa3Zfbm90aWZ5X21lc3NhZ2VfdG9fc211KGFkZXYsIFBQU01DX01TR19WQ0VQb3dl
ck9GRik7CkBAIC0xNzE5LDggKzE3MTcsOCBAQCBzdGF0aWMgdm9pZCBrdl9kcG1fcG93ZXJnYXRl
X3ZjZSh2b2lkICpoYW5kbGUsIGJvb2wgZ2F0ZSkKIAkJCWFtZGdwdV9rdl9ub3RpZnlfbWVzc2Fn
ZV90b19zbXUoYWRldiwgUFBTTUNfTVNHX1ZDRVBvd2VyT04pOwogCQlrdl9lbmFibGVfdmNlX2Rw
bShhZGV2LCB0cnVlKTsKIAkJLyogcmUtaW5pdCB0aGUgVkNFIGJsb2NrICovCi0JCXJldCA9IGFt
ZGdwdV9kZXZpY2VfaXBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFNRF9JUF9CTE9DS19U
WVBFX1ZDRSwKLQkJCQkJCQkgICAgIEFNRF9QR19TVEFURV9VTkdBVEUpOworCQlhbWRncHVfZGV2
aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9WQ0Us
CisJCQkJCQkgICAgICAgQU1EX1BHX1NUQVRFX1VOR0FURSk7CiAJfQogfQogCi0tIAoyLjI1LjEK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
