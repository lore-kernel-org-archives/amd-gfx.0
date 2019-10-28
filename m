Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9CDCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03981217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03981217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B345C6EAA4;
	Mon, 28 Oct 2019 21:43:14 +0000 (UTC)
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com
 [IPv6:2607:f8b0:4864:20::b41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CECD6EAA4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:43:13 +0000 (UTC)
Received: by mail-yb1-xb41.google.com with SMTP id d12so4628647ybn.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:43:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rprWGJs3yp+w8s82f6jq59UV3+l2Mkoh9FDMc2FAwa0=;
 b=HI+hHb4iaYm32SdVpH7Lnfe1ydwPnT+Lh988JwcpabBP0uql+p2oj3Mn1f3n7qK/gO
 682qQfZKT2IZLxJzjTSCZM8kOfy5I6KZ7e5S6KbFWHXK/KYLSDG1rH3xsovd08m+jRLH
 kC2tZgejJk7vUHO5VmimuDPfcERlKCZgOUQfPGKnAzUPbikuFLWSugpztou7rsjLF//6
 CAIr7vhi+2Y5N0ep0L0Nme+jJT4aEHunX04TckkZ04W9lLQuADF9WyifQRk8KO4LvVlA
 5ik8GsDJEzW0ANr4NYeBcE5IwXQZrI9x8n51MGnNYjL/0Ewcrocm6U56Irgnub6SkQOK
 GSSw==
X-Gm-Message-State: APjAAAW7QCi+Cz8yQg6NiWwsN7w7s0Ed/pIQ6l+otFrw3+V8nXduqKU+
 tamdqPZE272yIUDWwljmfPJ3Zh/ZMPE=
X-Google-Smtp-Source: APXvYqzu4mse9nPWFKstSbzRiho6Pf0v9Bn7E5tZanNuAKAG2qI32EYBeZDrzwmZCle06tZmYfUu9A==
X-Received: by 2002:a25:7ac4:: with SMTP id v187mr6202171ybc.118.1572298992073; 
 Mon, 28 Oct 2019 14:43:12 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:43:11 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 07/21] drm/amdgpu: add supports_baco callback for NV asics.
Date: Mon, 28 Oct 2019 17:42:02 -0400
Message-Id: <20191028214216.1508370-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rprWGJs3yp+w8s82f6jq59UV3+l2Mkoh9FDMc2FAwa0=;
 b=m3c7FBxKY7e49MCTFyt0Zt271irgsmiMOT957bhbOTiJ2rzATG3SqP5FeFOjUYr8Qs
 oBfyY+HgYddJHRbD7PCGiFCJWAAyqwUOcQ+AeMyhLKIM/9xPWg8FG/O3DdfJqdFK2z0M
 o+qFp7iyTNfw69bPdFsOluP+d8tIv+TzsVivVM3Li8SoN+lJu/mu3eCwJUvmGhTVZGyZ
 ULmGuuo4sCC4J94uFQrFplivyAfVmpuTfL+5AQdpsktxmGfz6ib9QWaD0JD1/Hr+Bkxb
 oiOssvITlc7XYvoIQ34MDLEH4UPwlT4klTQosyQryBJVF+IWywLy6RsdbxbXdL5yC42C
 HhSw==
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
Message-ID: <20191028214202.zDq_yWmw__tsq2tdRc7s94aEZ1fkNATqh113JrvI5DI@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpDaGVjayB0aGUgQkFDTyBjYXBhYmlsaXRpZXMg
ZnJvbSB0aGUgcG93ZXJwbGF5IHRhYmxlLgoKUmV2aWV3ZWQtYnk6IEV2YW4gUXVhbiA8ZXZhbi5x
dWFuQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9udi5jIHwgMTEgKysr
KysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvbnYuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L252LmMKaW5kZXggMjJhYjE5NTViOTIzLi5lODhlOWI5ZWRjYmIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L252LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvbnYuYwpAQCAtMjk0LDYgKzI5NCwxNiBAQCBzdGF0aWMgaW50IG52X2FzaWNfbW9kZTFf
cmVzZXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJcmV0dXJuIHJldDsKIH0KIAorc3Rh
dGljIGJvb2wgbnZfYXNpY19zdXBwb3J0c19iYWNvKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2
KQoreworCXN0cnVjdCBzbXVfY29udGV4dCAqc211ID0gJmFkZXYtPnNtdTsKKworCWlmIChzbXVf
YmFjb19pc19zdXBwb3J0KHNtdSkpCisJCXJldHVybiB0cnVlOworCWVsc2UKKwkJcmV0dXJuIGZh
bHNlOworfQorCiBzdGF0aWMgZW51bSBhbWRfcmVzZXRfbWV0aG9kCiBudl9hc2ljX3Jlc2V0X21l
dGhvZChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIHsKQEAgLTU4Niw2ICs1OTYsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9hc2ljX2Z1bmNzIG52X2FzaWNfZnVuY3MgPQogCS5u
ZWVkX2Z1bGxfcmVzZXQgPSAmbnZfbmVlZF9mdWxsX3Jlc2V0LAogCS5nZXRfcGNpZV91c2FnZSA9
ICZudl9nZXRfcGNpZV91c2FnZSwKIAkubmVlZF9yZXNldF9vbl9pbml0ID0gJm52X25lZWRfcmVz
ZXRfb25faW5pdCwKKwkuc3VwcG9ydHNfYmFjbyA9ICZudl9hc2ljX3N1cHBvcnRzX2JhY28sCiB9
OwogCiBzdGF0aWMgaW50IG52X2NvbW1vbl9lYXJseV9pbml0KHZvaWQgKmhhbmRsZSkKLS0gCjIu
MjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
