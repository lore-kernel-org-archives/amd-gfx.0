Return-Path: <SRS0=u850=HL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84020C433E9
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 15:22:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43FFD64EB8
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Feb 2021 15:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43FFD64EB8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065D589CD8;
	Tue,  9 Feb 2021 15:22:12 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29FA6EB09;
 Tue,  9 Feb 2021 12:44:45 +0000 (UTC)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1612874684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5ZcLme2Lp8VoN6Vx25D29o/w3vPmzWDf5AKB/+kO9ME=;
 b=sOsmuNnfJ121YNbp7s4fCzyJxQs/SocqUD9Q9ZhIZquBrSM7jcKcITzQlpdcmkEH1MmJ5M
 z6QT756YG8guhW0HF7VIe5v+8AapjDG1ozzB7vlZZ3pjbyjZg2k8+VtR/GWMCAiOduDc1s
 bEl8dKloP9bbv2NB97tWCBV4AtryYIJmCuP+LbfkA1sVB9l79zHHdrU+HFhtxftZ4k3Q56
 5eQA2zpe5EOPh0zkj4qPAw6M3mO09D2D5FMqAlhpfjAk9/9ku0fy7BYc4S52zlaS6F/5rx
 isn6r2WjwMZ4AJnMK5VggugDVhAAyAHx7HISlbGpZK0H7xnHzIyaN3eTldPX3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1612874684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5ZcLme2Lp8VoN6Vx25D29o/w3vPmzWDf5AKB/+kO9ME=;
 b=ltIbD7hM3Nvgs6Dmo1UOUfeDKhYS7R6Pm3//sl9+yJpXUmYf2IQNz4aAY5NOsL4CSz3skC
 iPrEhuyc7hZdrdDQ==
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 0/3] drm/amdgpu: Remove in_interrupt() usage.
Date: Tue,  9 Feb 2021 13:44:36 +0100
Message-Id: <20210209124439.408140-1-bigeasy@linutronix.de>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 09 Feb 2021 15:22:09 +0000
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rm9sa3MsCgppbiB0aGUgZGlzY3Vzc2lvbiBhYm91dCBwcmVlbXB0IGNvdW50IGNvbnNpc3RlbmN5
IGFjcm9zcyBrZXJuZWwKY29uZmlndXJhdGlvbnM6CgogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDIwMDkxNDIwNDIwOS4yNTYyNjYwOTNAbGludXRyb25peC5kZS8KCml0IHdhcyBjb25jbHVk
ZWQgdGhhdCB0aGUgdXNhZ2Ugb2YgaW5faW50ZXJydXB0KCkgYW5kIHJlbGF0ZWQgY29udGV4dApj
aGVja3Mgc2hvdWxkIGJlIHJlbW92ZWQgZnJvbSBub24tY29yZSBjb2RlLgoKSW4gdGhlIGxvbmcg
cnVuLCB1c2FnZSBvZiAncHJlZW1wdGlibGUsIGluXyppcnEgZXRjLicgc2hvdWxkIGJlIGJhbm5l
ZCBmcm9tCmRyaXZlciBjb2RlIGNvbXBsZXRlbHkuCgpUaGlzIHNlcmllcyBhZGRyZXNzZXMgcGFy
dHMgb2YgdGhlIGFtZGdwdSBkcml2ZXIuICBUaGVyZSBhcmUgc3RpbGwgY2FsbCBzaXRlcwpsZWZ0
IGluIGluIHRoZSBhbWRncHUgZHJpdmVyLgoKdjHigKZ2MjoKICAgLSBMaW1pdCB0byBhZG1ncHUg
b25seQogICAtIHVzZSAiYm9vbCIgaW5zdGVhZCBvZiAiYm9vbCA9PSB0cnVlIgoKU2ViYXN0aWFu
CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
