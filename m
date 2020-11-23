Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9CFC56202
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14B7720702
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 13:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyD96b5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B7720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BBD89F63;
	Mon, 23 Nov 2020 13:58:03 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECDDB89861
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:19:31 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id m6so18183596wrg.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=92lYcVhCJmrBtBX57wzHE1WdwDpEBe0J2p2RduAzKmY=;
 b=tyD96b5E1MNVsARdONjKjj8lmiQOPG6HZ3J3yYA1X4O8NytzLWdgQ3BBX81GdNztUl
 MCz53tT3e5DvsGOFVHSrLS+yMgZJbL9BqRG7mblwgYdUSS6grX3F6O5StAdtIkZDKP8g
 he1etgev1uTEcr+qss2qE0ldGmea0gH2u3G5JwBLWNf8NXLw/tJ/8nP63Rji6V42Ddv0
 CTgUcts+FDVic+ESjPSXDj3UbnTuc4NRq5pR/45zmFx0tu3zVBH8WqlUSSLD1qlhvd/F
 78H+/sQ+C4P4NLchyX10tlytKAgUWja4o7e6KZTTF83WvHiKFSBFIoyKHqSvRTD/dNuv
 2dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=92lYcVhCJmrBtBX57wzHE1WdwDpEBe0J2p2RduAzKmY=;
 b=FBybzZ3GSRhqbDbFI13IIhEZ4HtlfxzSQakVXV7OOFfuRJevH8a8O4qtBc9E+vtrMY
 Ad+96rGfyI6l2aXBu/LOaTirdWyI14daCLbpXmX/NVREDiZdN7sSxPqqxfxiIAu8Lm3g
 zERB/p49V3zWpJ/o7ZA2sAtFLs127DUZemY9/4fZxAWwk1d5tZ2VH8IYAml3TQK2iUvk
 IVbm+6JMkdT/kVE+yrZsUd/tJ6HTbCa7xWuPnyU464F169TnHPNjSleADjSycoKtRIik
 FVe9Y7LUWCg9tNejddLQ5vaPhSYb9l/SwoC/UmYdd2tkYq9v6HpEymzmPPz+9Z1JOvOU
 LAng==
X-Gm-Message-State: AOAM531NxpcLebk1TyT7eq0iOQwUMfT0DPiFF//5TDdK8D2cygDNPOYs
 dsMGWVmSYGqTtnzr0jwabFyCEQ==
X-Google-Smtp-Source: ABdhPJxcFX2r+8zpTqB0xgdePYGFbP22M8rI4oqeupSBv1b98mkYBBpmFJ5H9NVGiGoalECnVCPurg==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr30883095wrm.275.1606130370615; 
 Mon, 23 Nov 2020 03:19:30 -0800 (PST)
Received: from dell.default ([91.110.221.218])
 by smtp.gmail.com with ESMTPSA id n9sm16317290wmd.4.2020.11.23.03.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2020 03:19:29 -0800 (PST)
From: Lee Jones <lee.jones@linaro.org>
To: lee.jones@linaro.org
Subject: [PATCH 06/40] drm/amd/amdgpu/uvd_v4_2: Fix some kernel-doc
 misdemeanours
Date: Mon, 23 Nov 2020 11:18:45 +0000
Message-Id: <20201123111919.233376-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123111919.233376-1-lee.jones@linaro.org>
References: <20201123111919.233376-1-lee.jones@linaro.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 23 Nov 2020 13:58:01 +0000
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYzoxNTc6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ2hhbmRsZScgbm90IGRlc2NyaWJlZCBpbiAndXZkX3Y0XzJfaHdf
aW5pdCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmM6MTU3OiB3YXJuaW5n
OiBFeGNlc3MgZnVuY3Rpb24gcGFyYW1ldGVyICdhZGV2JyBkZXNjcmlwdGlvbiBpbiAndXZkX3Y0
XzJfaHdfaW5pdCcKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmM6MjEyOiB3
YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdoYW5kbGUnIG5vdCBkZXNjcmli
ZWQgaW4gJ3V2ZF92NF8yX2h3X2ZpbmknCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djRfMi5jOjIxMjogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnYWRldicgZGVz
Y3JpcHRpb24gaW4gJ3V2ZF92NF8yX2h3X2ZpbmknCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS91dmRfdjRfMi5jOjQ0Njogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAn
YWRkcicgbm90IGRlc2NyaWJlZCBpbiAndXZkX3Y0XzJfcmluZ19lbWl0X2ZlbmNlJwogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYzo0NDY6IHdhcm5pbmc6IEZ1bmN0aW9uIHBh
cmFtZXRlciBvciBtZW1iZXIgJ3NlcScgbm90IGRlc2NyaWJlZCBpbiAndXZkX3Y0XzJfcmluZ19l
bWl0X2ZlbmNlJwogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZkX3Y0XzIuYzo0NDY6IHdh
cm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2ZsYWdzJyBub3QgZGVzY3JpYmVk
IGluICd1dmRfdjRfMl9yaW5nX2VtaXRfZmVuY2UnCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS91dmRfdjRfMi5jOjQ0Njogd2FybmluZzogRXhjZXNzIGZ1bmN0aW9uIHBhcmFtZXRlciAnZmVu
Y2UnIGRlc2NyaXB0aW9uIGluICd1dmRfdjRfMl9yaW5nX2VtaXRfZmVuY2UnCiBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS91dmRfdjRfMi5jOjUxMzogd2FybmluZzogRnVuY3Rpb24gcGFyYW1l
dGVyIG9yIG1lbWJlciAnam9iJyBub3QgZGVzY3JpYmVkIGluICd1dmRfdjRfMl9yaW5nX2VtaXRf
aWInCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRfdjRfMi5jOjUxMzogd2FybmluZzog
RnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAnZmxhZ3MnIG5vdCBkZXNjcmliZWQgaW4gJ3V2
ZF92NF8yX3JpbmdfZW1pdF9pYicKCkNjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+CkNjOiAiQ2hyaXN0aWFuIEvDtm5pZyIgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4KQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KQ2M6IERhbmllbCBWZXR0ZXIg
PGRhbmllbEBmZndsbC5jaD4KQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBk
cmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnClNpZ25lZC1vZmYtYnk6IExlZSBKb25lcyA8
bGVlLmpvbmVzQGxpbmFyby5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZk
X3Y0XzIuYyB8IDggKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdXZk
X3Y0XzIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3V2ZF92NF8yLmMKaW5kZXggYjBj
MGM0MzhmYzkzYy4uMmM4YzM1YzNiY2E1MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvdXZkX3Y0XzIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS91dmRf
djRfMi5jCkBAIC0xNDksNyArMTQ5LDcgQEAgc3RhdGljIHZvaWQgdXZkX3Y0XzJfZW5hYmxlX21n
Y2coc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAvKioKICAqIHV2ZF92NF8yX2h3X2luaXQg
LSBzdGFydCBhbmQgdGVzdCBVVkQgYmxvY2sKICAqCi0gKiBAYWRldjogYW1kZ3B1X2RldmljZSBw
b2ludGVyCisgKiBAaGFuZGxlOiBoYW5kbGUgdXNlZCB0byBwYXNzIGFtZGdwdV9kZXZpY2UgcG9p
bnRlcgogICoKICAqIEluaXRpYWxpemUgdGhlIGhhcmR3YXJlLCBib290IHVwIHRoZSBWQ1BVIGFu
ZCBkbyBzb21lIHRlc3RpbmcKICAqLwpAQCAtMjA0LDcgKzIwNCw3IEBAIHN0YXRpYyBpbnQgdXZk
X3Y0XzJfaHdfaW5pdCh2b2lkICpoYW5kbGUpCiAvKioKICAqIHV2ZF92NF8yX2h3X2ZpbmkgLSBz
dG9wIHRoZSBoYXJkd2FyZSBibG9jawogICoKLSAqIEBhZGV2OiBhbWRncHVfZGV2aWNlIHBvaW50
ZXIKKyAqIEBoYW5kbGU6IGhhbmRsZSB1c2VkIHRvIHBhc3MgYW1kZ3B1X2RldmljZSBwb2ludGVy
CiAgKgogICogU3RvcCB0aGUgVVZEIGJsb2NrLCBtYXJrIHJpbmcgYXMgbm90IHJlYWR5IGFueSBt
b3JlCiAgKi8KQEAgLTQzNyw2ICs0MzcsOCBAQCBzdGF0aWMgdm9pZCB1dmRfdjRfMl9zdG9wKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogICogdXZkX3Y0XzJfcmluZ19lbWl0X2ZlbmNlIC0g
ZW1pdCBhbiBmZW5jZSAmIHRyYXAgY29tbWFuZAogICoKICAqIEByaW5nOiBhbWRncHVfcmluZyBw
b2ludGVyCisgKiBAYWRkcjogYWRkcmVzcworICogQHNlcTogc2VxdWVuY2UgbnVtYmVyCiAgKiBA
ZmVuY2U6IGZlbmNlIHRvIGVtaXQKICAqCiAgKiBXcml0ZSBhIGZlbmNlIGFuZCBhIHRyYXAgY29t
bWFuZCB0byB0aGUgcmluZy4KQEAgLTUwMiw3ICs1MDQsOSBAQCBzdGF0aWMgaW50IHV2ZF92NF8y
X3JpbmdfdGVzdF9yaW5nKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKICAqIHV2ZF92NF8yX3Jp
bmdfZW1pdF9pYiAtIGV4ZWN1dGUgaW5kaXJlY3QgYnVmZmVyCiAgKgogICogQHJpbmc6IGFtZGdw
dV9yaW5nIHBvaW50ZXIKKyAqIEBqb2I6IHVudXNlZAogICogQGliOiBpbmRpcmVjdCBidWZmZXIg
dG8gZXhlY3V0ZQorICogQGZsYWdzOiB1bnVzZWQKICAqCiAgKiBXcml0ZSByaW5nIGNvbW1hbmRz
IHRvIGV4ZWN1dGUgdGhlIGluZGlyZWN0IGJ1ZmZlcgogICovCi0tIAoyLjI1LjEKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
