Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179AEC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7F220723
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7F220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B7D6E99A;
	Fri, 15 Nov 2019 16:51:06 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFD66E996
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:51:01 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id e187so8634646qkf.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8hE3r61GdZq3+ScqgSjzwEaLKbwG45nDSlGOvpz7c5c=;
 b=dVw/8FSrnI/fY8wlxwZLHG3XaHjC1t7GCpRLej+Voh5bmBn5YXfVORLAzi6k7QBZYm
 g9qMdGy0H3boZO7B5IJBz/1TwU801OiQwnyuOdoHie12PnTHsJW2YarXOvKufTJtFCnH
 bh6DukQyo+gW8j+kVo34LCz+SwES3DyEYpGQRrb2sWdVcMrLGlBkcvo3+omOMsEMnXg2
 b5UTmgTm+naxf3K4BBu+8R/14upbG5PrDhyDtcgwWkTV1Lx4zwpudB6R6TvwBxOyaGWZ
 LrrDMHkhq6GbBIj1V1W7vp0PcTs2dC5qM1BwoMPluhhVo6XlncqhLOGaQCNil9H4DWg1
 +N4Q==
X-Gm-Message-State: APjAAAXIzm0WClkx1vH2aW5LBcuhMr6GeYyoV3dXMsoPQr1/R55Jb3Qr
 Nea44Z/bg5rQzDNX263xPkVN0dUW
X-Google-Smtp-Source: APXvYqySYcyyaQUZJxJXvrZrF21Ko2VRWHCr/XnaxaNL9ofCEirZGmWhGzTLX+Ox9PgH1kXrZW/BMw==
X-Received: by 2002:a05:620a:113a:: with SMTP id
 p26mr13471732qkk.479.1573836660812; 
 Fri, 15 Nov 2019 08:51:00 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id r29sm5610331qtb.63.2019.11.15.08.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:51:00 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 14/20] drm/amdgpu: disentangle runtime pm and vga_switcheroo
Date: Fri, 15 Nov 2019 11:50:32 -0500
Message-Id: <20191115165038.56646-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191115165038.56646-1-alexander.deucher@amd.com>
References: <20191115165038.56646-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8hE3r61GdZq3+ScqgSjzwEaLKbwG45nDSlGOvpz7c5c=;
 b=kHWeWXEftvvvKPKMITMAQDq8ikJFKQpxZMUs2RfkoaNgNxrBxh9rCWSoHHOUxuyAIK
 qvMRNrR1NZ/+9Lb5UBVxBUMOD9hHrH49nKfapc7ZtyI83i+hh7loyOpoE1Z9hC6a6Tmg
 6n3vJLbsGfGudyo3BXZk/iULSPfyrvLl2jaLTzDpEyPFOILELeofRTfuCRjcmhdXF+DX
 5fInCbw4qgblgHd91AbtXSn/EZJ/ZNWvHYBW7e4uv/G4fWF6sqemZTnUDZthtiUL7sr+
 Ohh4Jl0MCPGC+a8KC24uj0Z21ncq2pAdWsouannMrQwk3+lVhrdmMppQ3bVahRL+Zc5s
 G0lg==
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
Message-ID: <20191115165032.aLxwvOFHYMFj0Q76aYjrVkg8l-eYixROviBSlCk8rko@z>

T3JpZ2luYWxseSB3ZSBvbmx5IHN1cHBvcnRlZCBydW50aW1lIHBtIG9uIFBYL0hHIGxhcHRvcHMK
c28gdmdhX3N3aXRjaGVyb28gYW5kIHJ1bnRpbWUgcG0gYXJlIHNvcnQgb2YgZW50YW5nbGVkLgoK
QXR0ZW1wdCB0byBsb2dpY2FsbHkgc2VwYXJhdGUgdGhlbS4KClJldmlld2VkLWJ5OiBFdmFuIFF1
YW4gPGV2YW4ucXVhbkBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhh
bmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgMjIgKysrKysrKysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X2RldmljZS5jCmluZGV4IDcxOTVlZjgzZGRiYS4uZjQ4YzQ4OThlMzFhIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZGV2aWNlLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RldmljZS5jCkBAIC0yNzQ0LDcg
KzI3NDQsNyBAQCBpbnQgYW1kZ3B1X2RldmljZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAogCQkgICAgICAgdWludDMyX3QgZmxhZ3MpCiB7CiAJaW50IHIsIGk7Ci0JYm9vbCBydW50
aW1lID0gZmFsc2U7CisJYm9vbCBib2NvID0gZmFsc2U7CiAJdTMyIG1heF9NQnBzOwogCiAJYWRl
di0+c2h1dGRvd24gPSBmYWxzZTsKQEAgLTI5MTUsMTEgKzI5MTUsMTQgQEAgaW50IGFtZGdwdV9k
ZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAl2Z2FfY2xpZW50X3JlZ2lz
dGVyKGFkZXYtPnBkZXYsIGFkZXYsIE5VTEwsIGFtZGdwdV9kZXZpY2VfdmdhX3NldF9kZWNvZGUp
OwogCiAJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhkZGV2KSkKLQkJcnVudGltZSA9
IHRydWU7Ci0JaWYgKCFwY2lfaXNfdGh1bmRlcmJvbHRfYXR0YWNoZWQoYWRldi0+cGRldikpCisJ
CWJvY28gPSB0cnVlOworCWlmIChhbWRncHVfaGFzX2F0cHgoKSAmJgorCSAgICAoYW1kZ3B1X2lz
X2F0cHhfaHlicmlkKCkgfHwKKwkgICAgIGFtZGdwdV9oYXNfYXRweF9kZ3B1X3Bvd2VyX2NudGwo
KSkgJiYKKwkgICAgIXBjaV9pc190aHVuZGVyYm9sdF9hdHRhY2hlZChhZGV2LT5wZGV2KSkKIAkJ
dmdhX3N3aXRjaGVyb29fcmVnaXN0ZXJfY2xpZW50KGFkZXYtPnBkZXYsCi0JCQkJCSAgICAgICAm
YW1kZ3B1X3N3aXRjaGVyb29fb3BzLCBydW50aW1lKTsKLQlpZiAocnVudGltZSkKKwkJCQkJICAg
ICAgICZhbWRncHVfc3dpdGNoZXJvb19vcHMsIGJvY28pOworCWlmIChib2NvKQogCQl2Z2Ffc3dp
dGNoZXJvb19pbml0X2RvbWFpbl9wbV9vcHMoYWRldi0+ZGV2LCAmYWRldi0+dmdhX3BtX2RvbWFp
bik7CiAKIAlpZiAoYW1kZ3B1X2VtdV9tb2RlID09IDEpIHsKQEAgLTMxMDMsNyArMzEwNiw3IEBA
IGludCBhbWRncHVfZGV2aWNlX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCiAKIGZh
aWxlZDoKIAlhbWRncHVfdmZfZXJyb3JfdHJhbnNfYWxsKGFkZXYpOwotCWlmIChydW50aW1lKQor
CWlmIChib2NvKQogCQl2Z2Ffc3dpdGNoZXJvb19maW5pX2RvbWFpbl9wbV9vcHMoYWRldi0+ZGV2
KTsKIAogCXJldHVybiByOwpAQCAtMzE1Myw5ICszMTU2LDEyIEBAIHZvaWQgYW1kZ3B1X2Rldmlj
ZV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCiAJa2ZyZWUoYWRldi0+Ymlvcyk7
CiAJYWRldi0+YmlvcyA9IE5VTEw7Ci0JaWYgKCFwY2lfaXNfdGh1bmRlcmJvbHRfYXR0YWNoZWQo
YWRldi0+cGRldikpCisJaWYgKGFtZGdwdV9oYXNfYXRweCgpICYmCisJICAgIChhbWRncHVfaXNf
YXRweF9oeWJyaWQoKSB8fAorCSAgICAgYW1kZ3B1X2hhc19hdHB4X2RncHVfcG93ZXJfY250bCgp
KSAmJgorCSAgICAhcGNpX2lzX3RodW5kZXJib2x0X2F0dGFjaGVkKGFkZXYtPnBkZXYpKQogCQl2
Z2Ffc3dpdGNoZXJvb191bnJlZ2lzdGVyX2NsaWVudChhZGV2LT5wZGV2KTsKLQlpZiAoYWRldi0+
ZmxhZ3MgJiBBTURfSVNfUFgpCisJaWYgKGFtZGdwdV9kZXZpY2Vfc3VwcG9ydHNfYm9jbyhhZGV2
LT5kZGV2KSkKIAkJdmdhX3N3aXRjaGVyb29fZmluaV9kb21haW5fcG1fb3BzKGFkZXYtPmRldik7
CiAJdmdhX2NsaWVudF9yZWdpc3RlcihhZGV2LT5wZGV2LCBOVUxMLCBOVUxMLCBOVUxMKTsKIAlp
ZiAoYWRldi0+cmlvX21lbSkKLS0gCjIuMjMuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4
