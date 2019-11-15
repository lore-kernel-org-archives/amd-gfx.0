Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5994EC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A0020723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A0020723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97CA96E77F;
	Fri, 15 Nov 2019 16:50:56 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 469E56E789
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:50:54 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id x14so4028190qvu.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YFNdZiRBH47JJt3PV/k6JXdY/UBci9TMzjiB91Hah6Q=;
 b=ewTHecViqqdosTHUUE75EUybUh+y3DUchDcV3tcT7vku8ChGgqUcB062imPWH9SHw+
 MpjbIwaW5cmHtYgL+VmMH9HRmN5atRKp1Rwne+2L6fF3EM6ea+tpub3bhB75cBW76Jor
 feUXxEbpVDiGZZUsRinuknR/5msBuog9wcPRuBeXBQhJ6ujn7rqeazkKcS0qCI09JxU4
 bhOd5cFI6MJbojNrY23mX7Na+4lY6RqRBO9id5nAAUrz37D8+Du9EaTCTuPyTNKrCGzL
 K+xoBEZziODi7bvZG33i4Nw5DMhlSHt4MSYz2LsCVkEL9KZLeHLzBF9Z66kGafloWynK
 MfKQ==
X-Gm-Message-State: APjAAAUDjecOjg+0TU7b3RWQLvEahYAPlofqMAZsIXW/PIc1OSzB9tH+
 4d5YxNGyWubN6vKCH54XYqFrxyGU
X-Google-Smtp-Source: APXvYqwvz4kqKZe6zrjTPBGMJYJepFu1QqBw8MQt5Bv0C3r72WF5lVuUp/auNtzOQBLUrd7Huz07pg==
X-Received: by 2002:a05:6214:11a9:: with SMTP id
 u9mr14430458qvv.126.1573836653174; 
 Fri, 15 Nov 2019 08:50:53 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:50:52 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 06/20] drm/amdgpu: add supports_baco callback for NV asics.
Date: Fri, 15 Nov 2019 11:50:24 -0500
Message-Id: <20191115165038.56646-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YFNdZiRBH47JJt3PV/k6JXdY/UBci9TMzjiB91Hah6Q=;
 b=m6ehfTKqfIc8NVyjTALcLOchgkFOLjS+IY8p75qtHy1LcW5BRsOudAtKopwZ2HQve5
 Bp4kQv0SbdL2qhfxDMn6PsI8f6FRr9bqYqQe9KrhqC+Wu2FGFvkX2dQG8xolUi5IF4PS
 /S97Tb9Nm9BDChSttfdrlHqsBxmCkZh9YrnXoAHmjgU565Jns3j1JSc99xmgQxejKnWV
 ps1J/iV4kTV8OLdRFe/z8ngDDgKK84EUTNuPIkdK/wtqihtRTc428+Ap1MPodeRE0rx2
 9SXvSSuazGr/gYcEebbqjjgH0Ofpm4NirSn0H0pWUOJHyD1DbxcF5SBrGcT07z1jR0/a
 lg5Q==
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
Message-ID: <20191115165024.5txc8vMz83pfn1ANSuxQgo38Aur-wyBe859Didh1ips@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpDaGVjayB0aGUgQkFDTyBjYXBhYmlsaXRpZXMg
ZnJvbSB0aGUgcG93ZXJwbGF5IHRhYmxlLgoKUmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5x
dWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIHwgMTEgKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L252LmMKaW5kZXggMGJhNjZiZWY1NzQ2Li5iMjViNzJhNzMwNDggMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbnYuYwpAQCAtMzE0LDYgKzMxNCwxNiBAQCBzdGF0aWMgaW50IG52X2FzaWNfbW9kZTFf
cmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJcmV0dXJuIHJldDsKIH0KIAorc3Rh
dGljIGJvb2wgbnZfYXNpY19zdXBwb3J0c19iYWNvKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQoreworCXN0cnVjdCBzbXVfY29udGV4dCAqc211ID0gJmFkZXYtPnNtdTsKKworCWlmIChzbXVf
YmFjb19pc19zdXBwb3J0KHNtdSkpCisJCXJldHVybiB0cnVlOworCWVsc2UKKwkJcmV0dXJuIGZh
bHNlOworfQorCiBzdGF0aWMgZW51bSBhbWRfcmVzZXRfbWV0aG9kCiBudl9hc2ljX3Jlc2V0X21l
dGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKQEAgLTYxNyw2ICs2MjcsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9hc2ljX2Z1bmNzIG52X2FzaWNfZnVuY3MgPQogCS5n
ZXRfcGNpZV91c2FnZSA9ICZudl9nZXRfcGNpZV91c2FnZSwKIAkubmVlZF9yZXNldF9vbl9pbml0
ID0gJm52X25lZWRfcmVzZXRfb25faW5pdCwKIAkuZ2V0X3BjaWVfcmVwbGF5X2NvdW50ID0gJm52
X2dldF9wY2llX3JlcGxheV9jb3VudCwKKwkuc3VwcG9ydHNfYmFjbyA9ICZudl9hc2ljX3N1cHBv
cnRzX2JhY28sCiB9OwogCiBzdGF0aWMgaW50IG52X2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhh
bmRsZSkKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
