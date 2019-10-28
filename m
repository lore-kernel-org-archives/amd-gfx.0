Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BADBCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3553217D6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 21:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3553217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17B46E154;
	Mon, 28 Oct 2019 21:42:53 +0000 (UTC)
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00DB26E154
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 21:42:51 +0000 (UTC)
Received: by mail-yw1-xc44.google.com with SMTP id k127so4369180ywc.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 14:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WZYzWQ3n+K05Ss/icenk5EXv4sIlQ5/+aONtA537Z7A=;
 b=AvhHnEUioGByG8sWYotEZLsSQwJqBtIRHkNZ88S1lvgfQtKfirWBRgkyrQrJIcTDyV
 ORqQq+q3+M53AXBYoTn+S73NWNqw604sO6WyxWuzok9ettNfZvS50pK7M6sAaox+RtQM
 DKbVR4OwnWKJIIwydAvYccLPQnnMDtVYfRHQWkZiBgraUx/Nn5IsWixFWGLV15vEABQf
 ReoOsW9osmU7oAxV/U6KQKosU+udLL7hHqyUGGoImw3fFrCQ9zTu0Cs1hj64R3z1eaS1
 /iHpAPNIGnxTFpJmvFnVVKgvsCGjCo1TbfR3WF47TjeldA0hwk+0UJO8sFEKw4SSFiNe
 gG5g==
X-Gm-Message-State: APjAAAU/RQ0WO9+W9Hdae7+lZdhw3AXMs7GHr2b8kwtkxzvCE9jjPs7h
 OmRne+23ocQtX+AhfVfLCTs7Fkq05KQ=
X-Google-Smtp-Source: APXvYqysZpDomzWe5ORzZyVW6CUjfGqNW5Lm/pL6r+wwLGARUEpIsFYDkkvb/+FAj7/LhNV+l8KiYg==
X-Received: by 2002:a81:5ed4:: with SMTP id
 s203mr14106281ywb.427.1572298970745; 
 Mon, 28 Oct 2019 14:42:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l68sm3421090ywf.95.2019.10.28.14.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 14:42:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, tiwai@suse.de,
 lukas@wunner.de
Subject: [PATCH 01/21] drm/amdgpu: add asic callback for BACO support
Date: Mon, 28 Oct 2019 17:41:56 -0400
Message-Id: <20191028214216.1508370-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028214216.1508370-1-alexander.deucher@amd.com>
References: <20191028214216.1508370-1-alexander.deucher@amd.com>
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WZYzWQ3n+K05Ss/icenk5EXv4sIlQ5/+aONtA537Z7A=;
 b=nW8aVH2PE/nue4Y4UxnJoeivzfEPZp5E8MbS6SCFGju2zTwzz3BfH/vx5KMDU/3Cm2
 pzNXvr8wZhlmRIrbAjW2R7gdXq/tvVyVok8lpBbfXnmUfqFwHWxbg8gsR/8L6yWPWEv/
 OH9KnnVqm6gjS1sACSoL6xJ1gYOnoxB1jSCmLCNkQFtJCFEXODBUTmVeDkqJhbokTTC/
 v5pm5gF8c8SqhGPEvPArYkB/jMyw40dXNTQRuThyyE527X2t1Z0ktdKVUITmhctlA08K
 9TZF6QUnqtppGoriOP5FNgePMCFdHj9f/czN4DJ7LismVrrZQmIHDRYJj355bYFQrGYW
 g4Xw==
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
Message-ID: <20191028214156.PV5EtnasxN0EzmPKm07AwpDMzPROdLLZlZprazlcEso@z>

QkFDTyAtIEJ1cyBBY3RpdmUsIENoaXAgT2ZmCgpVc2VkIHRvIGNoZWNrIHdoZXRoZXIgdGhlIGRl
dmljZSBzdXBwb3J0cyBCQUNPLiAgVGhpcyB3aWxsCmJlIHVzZWQgdG8gZW5hYmxlIHJ1bnRpbWUg
cG0gb24gZGV2aWNlcyB3aGljaCBzdXBwb3J0IEJBQ08uCgpSZXZpZXdlZC1ieTogRXZhbiBRdWFu
IDxldmFuLnF1YW5AYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dS5oIHwgNCArKysrCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmggYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHUuaAppbmRleCBmZmE3YmUxYjkxMjUuLjAwY2M0M2Y3NGJlMSAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1LmgKQEAgLTU5MSw2ICs1OTEsOCBAQCBzdHJ1Y3Qg
YW1kZ3B1X2FzaWNfZnVuY3MgewogCWJvb2wgKCpuZWVkX3Jlc2V0X29uX2luaXQpKHN0cnVjdCBh
bWRncHVfZGV2aWNlICphZGV2KTsKIAkvKiBQQ0llIHJlcGxheSBjb3VudGVyICovCiAJdWludDY0
X3QgKCpnZXRfcGNpZV9yZXBsYXlfY291bnQpKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsK
KwkvKiBkZXZpY2Ugc3VwcG9ydHMgQkFDTyAqLworCWJvb2wgKCpzdXBwb3J0c19iYWNvKShzdHJ1
Y3QgYW1kZ3B1X2RldmljZSAqYWRldik7CiB9OwogCiAvKgpAQCAtMTExOCw2ICsxMTIwLDggQEAg
aW50IGVtdV9zb2NfYXNpY19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KTsKICNkZWZp
bmUgYW1kZ3B1X2FzaWNfZ2V0X3BjaWVfdXNhZ2UoYWRldiwgY250MCwgY250MSkgKChhZGV2KS0+
YXNpY19mdW5jcy0+Z2V0X3BjaWVfdXNhZ2UoKGFkZXYpLCAoY250MCksIChjbnQxKSkpCiAjZGVm
aW5lIGFtZGdwdV9hc2ljX25lZWRfcmVzZXRfb25faW5pdChhZGV2KSAoYWRldiktPmFzaWNfZnVu
Y3MtPm5lZWRfcmVzZXRfb25faW5pdCgoYWRldikpCiAjZGVmaW5lIGFtZGdwdV9hc2ljX2dldF9w
Y2llX3JlcGxheV9jb3VudChhZGV2KSAoKGFkZXYpLT5hc2ljX2Z1bmNzLT5nZXRfcGNpZV9yZXBs
YXlfY291bnQoKGFkZXYpKSkKKyNkZWZpbmUgYW1kZ3B1X2FzaWNfc3VwcG9ydHNfYmFjbyhhZGV2
KSAoYWRldiktPmFzaWNfZnVuY3MtPnN1cHBvcnRzX2JhY28oKGFkZXYpKQorCiAjZGVmaW5lIGFt
ZGdwdV9pbmNfdnJhbV9sb3N0KGFkZXYpIGF0b21pY19pbmMoJigoYWRldiktPnZyYW1fbG9zdF9j
b3VudGVyKSk7CiAKIC8qIENvbW1vbiBmdW5jdGlvbnMgKi8KLS0gCjIuMjMuMAoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxp
c3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3Rv
cC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
