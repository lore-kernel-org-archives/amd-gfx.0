Return-Path: <SRS0=2jl+=GO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0FAC4332E
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396C722CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jan 2021 19:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396C722CA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DA9F6E106;
	Mon, 11 Jan 2021 19:54:48 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AE1289FDE
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 19:20:22 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id y23so303509wmi.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jan 2021 11:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ibELFDbc+rU5KzM1TXI9030Gw8Nefp3Muywz/D1PCVQ=;
 b=X/A0BMqukT025ywWBP6402TmF9xYzKVtwcepbD+sRqr3dYbz9bjse+SWUcfaTjW0pr
 qJTtAQmOqDtekaE5N+7ON8TVe6h3wNQ48g4QW2sT2kuG+jdlWJj011xqQFq2AcK0iZR/
 CNGUYa5lKgSW57Qj5YJS7D7dbAVdYirp7zmE+TqJbqEl5qmLIY9skYjXz9lmrQEZ9vTb
 GuknaG74tmKA3q1YA0KIwPD+1lXAnDgKPFZvT/XAwlsuhhMHD0bYo2xXHpf/50vE/APy
 l1kUmFCRRlhWatFgHHo3Hev2TLeLnhRI49SdE7gwEIZHfWQRj71KeMuALvnNf4ZE29IG
 PmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ibELFDbc+rU5KzM1TXI9030Gw8Nefp3Muywz/D1PCVQ=;
 b=iHI9s4Dmv/l1SZv5hk2TUzByoMcG1sxgTNjG7L0J4IdC/hSSegkpwlIeFNIUhh4KKI
 kEtNoNn//mFhsJLR2awfWjZXp21qt/KCHHB6mFNWWG1fxp8+GOVsqPaa37PyuBI5vBnB
 PExsWR/ux+Ikkvr1ad7zfNWzzqLSkXhck1YxQItJHfo6JvSn/NKUgOOqFmpuhkPo9YHg
 rIfGK2dggK+e1RdB9xMkXfpvZ7jn25vlXTkjFHG4Fo90Zh86G4WrNeiOJrm36rgCwZvT
 OD1clz5t4p4p/kA1hUGs+I7RFN/T56q69ACP00GHNSYtNkDjhyzhghCIq41h4ol/E+b9
 C2KQ==
X-Gm-Message-State: AOAM5327PO3r/2c2qrpmCrb18r0/o0cUzeUVv7g5vwYKg2oI9tC481gC
 wZw0gDD3HEi878qJLqp9WtLJAQ==
X-Google-Smtp-Source: ABdhPJw5pKXVGtKU5/0T6G4y0EaXSn4tXsz5RwR4PV4c8N8pkhKVEJNKTjStdBxA+xGzmYPpQ/TYAw==
X-Received: by 2002:a05:600c:4154:: with SMTP id
 h20mr293177wmm.72.1610392821103; 
 Mon, 11 Jan 2021 11:20:21 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 11:20:20 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 39/40] drm/amd/display/dc/core/dc_surface: Demote kernel-doc
 abuse
Date: Mon, 11 Jan 2021 19:19:25 +0000
Message-Id: <20210111191926.3688443-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 11 Jan 2021 19:54:43 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Josip Pavic <Josip.Pavic@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9jb3JlL2RjX3N1cmZhY2UuYzoxMTk6
IHdhcm5pbmc6IENhbm5vdCB1bmRlcnN0YW5kICAqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgoKQ2M6IEhh
cnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExpIDxzdW5wZW5n
LmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+
CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERh
dmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIgPGRhbmllbEBm
ZndsbC5jaD4KQ2M6IEF1cmFiaW5kbyBQaWxsYWkgPGF1cmFiaW5kby5waWxsYWlAYW1kLmNvbT4K
Q2M6IEpvc2lwIFBhdmljIDxKb3NpcC5QYXZpY0BhbWQuY29tPgpDYzogYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKU2lnbmVk
LW9mZi1ieTogTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdXJmYWNlLmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdXJmYWNlLmMgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdXJmYWNlLmMKaW5kZXggM2Q3ZDI3NDM1ZjE1ZS4u
ZTZiOWM2YTcxODQxMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2NvcmUvZGNfc3VyZmFjZS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9j
b3JlL2RjX3N1cmZhY2UuYwpAQCAtMTE1LDcgKzExNSw3IEBAIHN0cnVjdCBkY19wbGFuZV9zdGF0
ZSAqZGNfY3JlYXRlX3BsYW5lX3N0YXRlKHN0cnVjdCBkYyAqZGMpCiAJcmV0dXJuIHBsYW5lX3N0
YXRlOwogfQogCi0vKioKKy8qCiAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKICAqICBGdW5jdGlvbjog
ZGNfcGxhbmVfZ2V0X3N0YXR1cwogICoKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9hbWQtZ2Z4Cg==
