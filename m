Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F7C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF37923998
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 20:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF37923998
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08FE66E8F3;
	Fri,  8 Jan 2021 20:24:18 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D97626E8D5
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 20:15:27 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id k10so8749182wmi.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 12:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mGH9J7vG9w88diVL7S4q4GpxhT0ewyJTldBss+diQXU=;
 b=PoNsSs56+BhMbOp3HWwYXgMD2QalVIqugoJIccivvlUXtTK6KydRosDvXV2ZMuK/j6
 V6deq3qJNwDrJvTtxb7rjmxTFTbONrxIeNL/zfclyDWG6Fn3P7ALgSPgu3EF4Cs7h1gO
 QZxb/a0xh4i64xWfdI1wyCJhnaWHq7gvEWk5XBusIVSbcBRJeaVcaKPSyAjQcin6JAsX
 e3aD9yBqliYSPffaP0lhXjbatKqzhsO3cZn/JuwGPbJUBYgkcGg9pspsR7XYLAjAezOQ
 trOtfe1OF81CcTOBCg2m0rxWecucTjnZDHJ1PtOw0qT/qF9F4x0mLHsKgtc6B4gxw12G
 HsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mGH9J7vG9w88diVL7S4q4GpxhT0ewyJTldBss+diQXU=;
 b=AyndB89tUy8TPv9MoXifbX6n/NM1yMKum1LtB+RqkvHhS/97zSzKLwvOj2kgcStDf0
 iDH0B0QIJpSJGdBALn+51YB4/VBPwo2KaYw1MqV3pJEniRhtFOVnz/0Pn7I8MTpRHTB7
 dJPtOuvhLUqoQFcKiAf+LNeeC8byTB0SYyU9OH9dtbP/caMoUT1Jjt2kAcr2atMYxwbu
 gQj4PXn8b5Wqr/7uwIA1+j4PO0KhNJvbQuluVAKpBnMChzmsRoglOx7DW0esNJ6OmeV2
 hrOnJyP6ZVif+siu7dj+dEZUFZCHxOkqmQkByzXwjqKzMvLP7hYMJH3IZKkQmWTngpYt
 WG3g==
X-Gm-Message-State: AOAM532r7wtJeJyEdOpnIC3TnhB5RHVCALOLEQ9ZcCTXi/aR1B4OwiQJ
 i4r/Tb0cNpXq92FUXWo7A9YZHQ==
X-Google-Smtp-Source: ABdhPJwK8AFiXaFBtq8APb9s+USZEr9/YOKlixvoWl/dOKnQX99kel0RW2cLzwRidX++r0XSx7n0KA==
X-Received: by 2002:a1c:1d08:: with SMTP id d8mr4586785wmd.159.1610136926583; 
 Fri, 08 Jan 2021 12:15:26 -0800 (PST)
Received: from dell.default ([91.110.221.229])
 by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 12:15:25 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 15/40] drm/amd/display/dc/bios/command_table_helper: Fix
 kernel-doc formatting
Date: Fri,  8 Jan 2021 20:14:32 +0000
Message-Id: <20210108201457.3078600-16-lee.jones@linaro.org>
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
Cc: Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2VybmVsIGJ1aWxkIHdhcm5pbmcocyk6CgogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvLi4vZGlzcGxheS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVs
cGVyLmM6MTMxOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICd0JyBub3Qg
ZGVzY3JpYmVkIGluICdkYWxfY21kX3RhYmxlX2hlbHBlcl90cmFuc21pdHRlcl9icF90b19hdG9t
JwoKQ2M6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPgpDYzogTGVvIExp
IDxzdW5wZW5nLmxpQGFtZC5jb20+CkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIg
PGRhbmllbEBmZndsbC5jaD4KQ2M6IE1hdXJvIFJvc3NpIDxpc3Nvci5vcnVhbUBnbWFpbC5jb20+
CkNjOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8u
b3JnPgotLS0KIC4uLi9kaXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90YWJsZV9oZWxwZXIuYyAgICB8
IDIwICsrKysrKysrLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyks
IDEyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9iaW9zL2NvbW1hbmRfdGFibGVfaGVscGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rp
c3BsYXkvZGMvYmlvcy9jb21tYW5kX3RhYmxlX2hlbHBlci5jCmluZGV4IDQ4YjRlZjAzZmM4Zjgu
LjViNzcyNTFlMDU5MDkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9iaW9zL2NvbW1hbmRfdGFibGVfaGVscGVyLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2Jpb3MvY29tbWFuZF90YWJsZV9oZWxwZXIuYwpAQCAtMTE0LDE4ICsxMTQsMTQg
QEAgYm9vbCBkYWxfY21kX3RhYmxlX2hlbHBlcl9jb250cm9sbGVyX2lkX3RvX2F0b20oCiB9CiAK
IC8qKgotKiB0cmFuc2xhdGVfdHJhbnNtaXR0ZXJfYnBfdG9fYXRvbQotKgotKiBAYnJpZWYKLSog
IFRyYW5zbGF0ZSB0aGUgVHJhbnNtaXR0ZXIgdG8gdGhlIGNvcnJlc3BvbmRpbmcgQVRPTSBCSU9T
IHZhbHVlCi0qCi0qIEBwYXJhbQotKiAgIGlucHV0IHRyYW5zbWl0dGVyCi0qICAgb3V0cHV0IGRp
Z2l0YWxUcmFuc21pdHRlcgotKiAgICAvLyA9MDA6IERpZ2l0YWwgVHJhbnNtaXR0ZXIxICggVU5J
UEhZIGxpbmtBQiApCi0qICAgIC8vID0wMTogRGlnaXRhbCBUcmFuc21pdHRlcjIgKCBVTklQSFkg
bGlua0NEICkKLSogICAgLy8gPTAyOiBEaWdpdGFsIFRyYW5zbWl0dGVyMyAoIFVOSVBIWSBsaW5r
RUYgKQotKi8KKyAqIHRyYW5zbGF0ZV90cmFuc21pdHRlcl9icF90b19hdG9tIC0gVHJhbnNsYXRl
IHRoZSBUcmFuc21pdHRlciB0byB0aGUKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29ycmVzcG9uZGluZyBBVE9NIEJJT1MgdmFsdWUKKyAqIEB0OiB0cmFuc21pdHRlcgor
ICogcmV0dXJuczogb3V0cHV0IGRpZ2l0YWxUcmFuc21pdHRlcgorICogICAgLy8gPTAwOiBEaWdp
dGFsIFRyYW5zbWl0dGVyMSAoIFVOSVBIWSBsaW5rQUIgKQorICogICAgLy8gPTAxOiBEaWdpdGFs
IFRyYW5zbWl0dGVyMiAoIFVOSVBIWSBsaW5rQ0QgKQorICogICAgLy8gPTAyOiBEaWdpdGFsIFRy
YW5zbWl0dGVyMyAoIFVOSVBIWSBsaW5rRUYgKQorICovCiB1aW50OF90IGRhbF9jbWRfdGFibGVf
aGVscGVyX3RyYW5zbWl0dGVyX2JwX3RvX2F0b20oCiAJZW51bSB0cmFuc21pdHRlciB0KQogewot
LSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
