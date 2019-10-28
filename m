Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C2DCA9EC2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 694F821835
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:42:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694F821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38DD96EA9B;
	Mon, 28 Oct 2019 21:42:59 +0000 (UTC)
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B0CB6EA9B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:42:58 +0000 (UTC)
Received: by mail-yw1-xc44.google.com with SMTP id g77so4355607ywb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:42:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R9wFN5XWeyPOYY+DE8nmOrCKugyIqCGXLRd2W9DKIio=;
 b=IXAn+aJspbBQWPDIVZ+aXT2/3ZAWBrzPejHtDBKQ3xMKx8FH6HsYzZyEm2CELIaoa1
 j3lqYiWRS0OEzt/NwM2JVmOx3H8lAhXpasnNY9evUhHt2+hmK+bQ8l9pdMBAOJVFCzMY
 USGgRzVsYpSNDPrfItr+Mw5EhBj0JUTyX4niosLTM2OzZugV824kk69Akr/N184I+FlE
 cLLyQ1Fpe0d9LpkVAGzbQ5EdXD/ejDJEMz+W9fu8W833zDEubzQLgZh/bMmBHunJra7f
 qIIQxRgVWzyD9KEJr2lTN4Tpe1aDVdP4xO43sRYULZFATKcmmDO+lWHpX4XmKtKSXU/O
 H3vw==
X-Gm-Message-State: APjAAAWwZJ7BtioCfhAiM8pFdDZpiYEy7EEoB8N/jSYo5FJUUzxvpJte
 o/axKlLVvSH3oua0Nw34Pv+A6UkEhRY=
X-Google-Smtp-Source: APXvYqxVRpCCYOmQJk0wGB25ns/O9JE3IFgrRBFe50Iw2NZCAFeaVB9zqNljDE7gGAWT6HdDuU41uA==
X-Received: by 2002:a0d:dbd7:: with SMTP id d206mr14293718ywe.35.1572298977354; 
 Mon, 28 Oct 2019 14:42:57 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:42:56 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 03/21] drm/amdgpu: add supports_baco callback for soc15 asics.
 (v2)
Date: Mon, 28 Oct 2019 17:41:58 -0400
Message-Id: <20191028214216.1508370-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R9wFN5XWeyPOYY+DE8nmOrCKugyIqCGXLRd2W9DKIio=;
 b=mu3oY0azkhTG7W8r7Oxb1D8F4MMN0PsB7D7ghcdepF+jYn+s9/3fj1vActHtlUA1iq
 fynoE74n9kILvuAdngZElnIf9N2WZv3G8PLX4Os/cHZNzL6XBLVLUj0zFF71JTZIXmLA
 celPJXVI7O8gKQEcpI0koXpuR05La8evzYE7C/12dova/ZRSefcslK/AdhRnAgro6xRc
 EKxHh5PGXryQ0OTHom4Awf8xdQUkyVj+JO8lrS8RNlcDlupIY0+NUNeh2RScveJDx5ZZ
 yBohV49agAmpkIgWFU4UbaRIgQWPW1i/1qcDyXdTcCD37PHtPI17ySjqy54y7Ti0G1SS
 wb1g==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028214158.LKcdxQstT2cwwUZvP1wClGDe1qUB1wGuAB8vuZbBcfo@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpDaGVjayB0aGUgQkFDTyBjYXBhYmlsaXRpZXMg
ZnJvbSB0aGUgcG93ZXJwbGF5IHRhYmxlLgoKdjI6IGRyb3AgdW5yZWxhdGVkIHN0cnVjdCBjbGVh
bnVwCgpSZXZpZXdlZC1ieTogRXZhbiBRdWFuIDxldmFuLnF1YW5AYW1kLmNvbT4gKHYxKQpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQoK
djI6IGRyb3AgdW5yZWxhdGVkIHN0cnVjdCBjbGVhbnVwCgpkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9zb2MxNS5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdl
ZCwgMjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NvYzE1LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zb2MxNS5jCmluZGV4IGY3
MTQ2MDExYTc4Ni4uOTc2NTg0YTQ3NzU4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9zb2MxNS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NvYzE1LmMK
QEAgLTU5OSw2ICs1OTksMjggQEAgc3RhdGljIGludCBzb2MxNV9hc2ljX3Jlc2V0KHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KQogCX0KIH0KIAorc3RhdGljIGJvb2wgc29jMTVfc3VwcG9ydHNf
YmFjbyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKK3sKKwlib29sIGJhY29fc3VwcG9ydDsK
KworCXN3aXRjaCAoYWRldi0+YXNpY190eXBlKSB7CisJY2FzZSBDSElQX1ZFR0ExMDoKKwljYXNl
IENISVBfVkVHQTEyOgorCQlzb2MxNV9hc2ljX2dldF9iYWNvX2NhcGFiaWxpdHkoYWRldiwgJmJh
Y29fc3VwcG9ydCk7CisJCWJyZWFrOworCWNhc2UgQ0hJUF9WRUdBMjA6CisJCWlmIChhZGV2LT5w
c3Auc29zX2Z3X3ZlcnNpb24gPj0gMHg4MDA2NykKKwkJCXNvYzE1X2FzaWNfZ2V0X2JhY29fY2Fw
YWJpbGl0eShhZGV2LCAmYmFjb19zdXBwb3J0KTsKKwkJZWxzZQorCQkJYmFjb19zdXBwb3J0ID0g
ZmFsc2U7CisJCWJyZWFrOworCWRlZmF1bHQ6CisJCXJldHVybiBmYWxzZTsKKwl9CisKKwlyZXR1
cm4gYmFjb19zdXBwb3J0OworfQorCiAvKnN0YXRpYyBpbnQgc29jMTVfc2V0X3V2ZF9jbG9jayhz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdTMyIGNsb2NrLAogCQkJdTMyIGNudGxfcmVnLCB1
MzIgc3RhdHVzX3JlZykKIHsKQEAgLTk5OSw2ICsxMDIxLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBhbWRncHVfYXNpY19mdW5jcyBzb2MxNV9hc2ljX2Z1bmNzID0KIAkuZ2V0X3BjaWVfdXNhZ2Ug
PSAmc29jMTVfZ2V0X3BjaWVfdXNhZ2UsCiAJLm5lZWRfcmVzZXRfb25faW5pdCA9ICZzb2MxNV9u
ZWVkX3Jlc2V0X29uX2luaXQsCiAJLmdldF9wY2llX3JlcGxheV9jb3VudCA9ICZzb2MxNV9nZXRf
cGNpZV9yZXBsYXlfY291bnQsCisJLnN1cHBvcnRzX2JhY28gPSAmc29jMTVfc3VwcG9ydHNfYmFj
bywKIH07CiAKIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2FzaWNfZnVuY3MgdmVnYTIwX2Fz
aWNfZnVuY3MgPQpAQCAtMTAyMCw2ICsxMDQzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhbWRn
cHVfYXNpY19mdW5jcyB2ZWdhMjBfYXNpY19mdW5jcyA9CiAJLmdldF9wY2llX3VzYWdlID0gJnZl
Z2EyMF9nZXRfcGNpZV91c2FnZSwKIAkubmVlZF9yZXNldF9vbl9pbml0ID0gJnNvYzE1X25lZWRf
cmVzZXRfb25faW5pdCwKIAkuZ2V0X3BjaWVfcmVwbGF5X2NvdW50ID0gJnNvYzE1X2dldF9wY2ll
X3JlcGxheV9jb3VudCwKKwkuc3VwcG9ydHNfYmFjbyA9ICZzb2MxNV9zdXBwb3J0c19iYWNvLAog
fTsKIAogc3RhdGljIGludCBzb2MxNV9jb21tb25fZWFybHlfaW5pdCh2b2lkICpoYW5kbGUpCi0t
IAoyLjIzLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
