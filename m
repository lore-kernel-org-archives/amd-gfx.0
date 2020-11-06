Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E53C55179
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E7A2087E
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 21:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVJbpGO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E7A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF0F46EB44;
	Fri,  6 Nov 2020 21:52:22 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B4C6EB25
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 21:50:02 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id w24so162592wmi.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Nov 2020 13:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E44zAySPmawq+qLbsH9q5xt7WGcYQXLEVwBfYO570wQ=;
 b=cVJbpGO0mn9PFOK6wV3RI1ztFhosLDnGLAYO4ev3T9QpIRZ2SSqsEx8FWEUkN+upm/
 HS8YHS57ONCD2IVwBKqTIIoyLLrbNFPelDe5IxCJ8PGsFiXgXqe7cLhkoTUrAoHixgZo
 KDP2patea7yG8pSvObvQ56FR4KjPr651sE8b30YFsZQO1CI2rUBjP+Jg9kQsXCsrIiYl
 kvdHKnkUFuKAF51usqRPb3FB+WAkJ3NKop0XNHNG/HonC/IukIGGjt2gWOzW3Yk3+aB6
 L0qwyZria23XEQBZ4ZV4Z9dI8tXdlsT47zwq42PF50XnSulcKL9WAjNKbSUvqekGHt4W
 z3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E44zAySPmawq+qLbsH9q5xt7WGcYQXLEVwBfYO570wQ=;
 b=CHnPU6bciGdAOvob75ltju7L/q62hlr+EtSp5GOyDcLlBHxKmJXmCTe/uA26hrgF2o
 8IVJt1KBHjhUpEJ/+SH25HPT5jjjo4aq1F5cBKTNMyUkRSTNlCH6copzgQwTvHVJ6r5W
 SMCGlVYQ1AKS7vqyHtzEszajwGBGd5fFfm44w7moqpVZ6T3i5MBMpNMV1kmQJDayITaN
 FTFc7MTwGSKaHgupoL8OCBNXTODnkxbxV3DOBIhSwcMHO/PMbVXU/Nad0aJoEJRRyB06
 AmXUcqfGjEJc2zjGYNmlDycyo4reZoHFMkfEtPFfpH7TxbQMcsXHYrxuSpoT7U36cSGL
 iQAA==
X-Gm-Message-State: AOAM5328QBr8WT+gyv+6gfF4D4aAjFVhIOhQzF+Z6tFGTb8pGXxwluCj
 gExjUz2vZEt23KCq4cCrQse1LQ==
X-Google-Smtp-Source: ABdhPJxfRN1i2cfpOCiFfFc/Pvr9V9HGsIKuzuadSde/yfja7cXq3h8iYKz20Us7PK8EV5XXi1JVGA==
X-Received: by 2002:a1c:ba0b:: with SMTP id k11mr1557572wmf.37.1604699401085; 
 Fri, 06 Nov 2020 13:50:01 -0800 (PST)
Received: from dell.default ([91.110.221.236])
 by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 13:50:00 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 06/19] drm/radeon/atom: Move prototype into shared location
Date: Fri,  6 Nov 2020 21:49:36 +0000
Message-Id: <20201106214949.2042120-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 06 Nov 2020 21:52:20 +0000
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

Qm90aCBzb3VyY2UgZmlsZXMgaW5jbHVkZSBhdG9tLmgsIHdoaWNoIHNlZW1zIGxpa2UgYSByZWFz
b25hYmxlCmxvY2F0aW9uIHRvIHBsYWNlIGFuIGF0b20gYmFzZWQgZnVuY3Rpb24gaW50by4KCkZp
eGVzIHRoZSBmb2xsb3dpbmcgVz0xIGtlcm5lbCBidWlsZCB3YXJuaW5nKHMpOgoKIGRyaXZlcnMv
Z3B1L2RybS9yYWRlb24vcmFkZW9uX2F0b21iaW9zLmM6MTc5MTo2OiB3YXJuaW5nOiBubyBwcmV2
aW91cyBwcm90b3R5cGUgZm9yIOKAmHJhZGVvbl9hdG9tX2dldF90dl90aW1pbmdz4oCZIFstV21p
c3NpbmctcHJvdG90eXBlc10KIDE3OTEgfCBib29sIHJhZGVvbl9hdG9tX2dldF90dl90aW1pbmdz
KHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBpbnQgaW5kZXgsCiB8IF5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+CgpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29t
PgpDYzogIkNocmlzdGlhbiBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25l
c0BsaW5hcm8ub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbS5oICAgICAgICAg
ICAgICB8IDYgKysrKysrCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL2F0b21iaW9zX2VuY29kZXJz
LmMgfCA0IC0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbS5oIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9hdG9tLmgKaW5kZXggMWJmMDZjOTFjZDk1OS4uY2I5M2I4MzExNGRi
ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9hdG9tLmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9hdG9tLmgKQEAgLTE1NCw2ICsxNTQsMTIgQEAgYm9vbCBhdG9tX3Bh
cnNlX2RhdGFfaGVhZGVyKHN0cnVjdCBhdG9tX2NvbnRleHQgKmN0eCwgaW50IGluZGV4LCB1aW50
MTZfdCAqc2l6ZSwKIGJvb2wgYXRvbV9wYXJzZV9jbWRfaGVhZGVyKHN0cnVjdCBhdG9tX2NvbnRl
eHQgKmN0eCwgaW50IGluZGV4LAogCQkJICAgdWludDhfdCAqZnJldiwgdWludDhfdCAqY3Jldik7
CiBpbnQgYXRvbV9hbGxvY2F0ZV9mYl9zY3JhdGNoKHN0cnVjdCBhdG9tX2NvbnRleHQgKmN0eCk7
CisKK3N0cnVjdCBkcm1fZGlzcGxheV9tb2RlOworc3RydWN0IHJhZGVvbl9kZXZpY2U7Citib29s
IHJhZGVvbl9hdG9tX2dldF90dl90aW1pbmdzKHN0cnVjdCByYWRlb25fZGV2aWNlICpyZGV2LCBp
bnQgaW5kZXgsCisJCQkJc3RydWN0IGRybV9kaXNwbGF5X21vZGUgKm1vZGUpOworCiAjaW5jbHVk
ZSAiYXRvbS10eXBlcy5oIgogI2luY2x1ZGUgImF0b21iaW9zLmgiCiAjaW5jbHVkZSAiT2JqZWN0
SUQuaCIKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbWJpb3NfZW5jb2Rl
cnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vYXRvbWJpb3NfZW5jb2RlcnMuYwppbmRleCBj
YzVlZTFiM2FmODRmLi44NWY5MDNjYWYxMmUxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
cmFkZW9uL2F0b21iaW9zX2VuY29kZXJzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9h
dG9tYmlvc19lbmNvZGVycy5jCkBAIC0yOTYsMTAgKzI5Niw2IEBAIHN0YXRpYyB2b2lkIHJhZGVv
bl9hdG9tX2JhY2tsaWdodF9leGl0KHN0cnVjdCByYWRlb25fZW5jb2RlciAqZW5jb2RlcikKIAog
I2VuZGlmCiAKLS8qIGV2aWwgYnV0IGluY2x1ZGluZyBhdG9tYmlvcy5oIGlzIG11Y2ggd29yc2Ug
Ki8KLWJvb2wgcmFkZW9uX2F0b21fZ2V0X3R2X3RpbWluZ3Moc3RydWN0IHJhZGVvbl9kZXZpY2Ug
KnJkZXYsIGludCBpbmRleCwKLQkJCQlzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAqbW9kZSk7Ci0K
IHN0YXRpYyBib29sIHJhZGVvbl9hdG9tX21vZGVfZml4dXAoc3RydWN0IGRybV9lbmNvZGVyICpl
bmNvZGVyLAogCQkJCSAgIGNvbnN0IHN0cnVjdCBkcm1fZGlzcGxheV9tb2RlICptb2RlLAogCQkJ
CSAgIHN0cnVjdCBkcm1fZGlzcGxheV9tb2RlICphZGp1c3RlZF9tb2RlKQotLSAKMi4yNS4xCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
