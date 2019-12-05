Return-Path: <SRS0=ZBu5=Z3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313D1C43603
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 03:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E60C20661
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2019 03:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E60C20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE8EB6E977;
	Thu,  5 Dec 2019 03:09:13 +0000 (UTC)
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com
 [IPv6:2607:f8b0:4864:20::b44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 415A06E977
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2019 03:09:12 +0000 (UTC)
Received: by mail-yb1-xb44.google.com with SMTP id l129so915705ybf.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2019 19:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KkBa4tLBcFfEmSei+AFtAJzQLE0NH5ObODBRDSbfSxU=;
 b=N6Mwkm/NCptAhlXfSJIMo5UVzz28/JYqeYyZK3EwmlIEcaETH4wrDC5yA29YdY3a+z
 zbPiY9pgX8UYV/JS4p/RXgmZ32wxwDPMB3TfH+cPMJ0JAOL2eOym0asQH9/IRn1edDf2
 QiGkEZiTH0H7rx03oU8uk2AbAiolNV+oGgKJdQN3i3DpUjn4tdBG1Qm175LOwoHZy103
 a5i8lq7LGmM/lwCOYnQ3/zmfloQjk++OrrDK9dOIPXPYPkfb/xNbPq2llzgPNHfMM2lr
 CbauFqMdAoDIbRkJO2y+LQJp52PBSNgcM4/IbgpYY2iJTnO3tU1gq/iyBIjOmRXyu5In
 3hog==
X-Gm-Message-State: APjAAAW/4KBq/4U8d+WVKKS8S6hlCs8f90994vByVqaqYsqD38lSU1iD
 ZFfZZwOJOfppfDH6+hLtsN/wvxXy
X-Google-Smtp-Source: APXvYqy5QptqwFN6Z60/c7WLuz3s/TlHMmb8Nbe7sXHrxtXmY+GVlRI3uk3kef6kiiKkNpmpairlJQ==
X-Received: by 2002:a25:248c:: with SMTP id k134mr4700180ybk.184.1575515351010; 
 Wed, 04 Dec 2019 19:09:11 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id o4sm4136101ywd.5.2019.12.04.19.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2019 19:09:10 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add header line for power profile on Arcturus
Date: Wed,  4 Dec 2019 22:09:01 -0500
Message-Id: <20191205030901.1283646-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=KkBa4tLBcFfEmSei+AFtAJzQLE0NH5ObODBRDSbfSxU=;
 b=d1nnEpDvdLO72Ke3V7qBjdO5k9O3FNCRMHEL/aYLWO9fAs32V3t73fuJJ6iAW/VMAf
 P+ek5SVJP0obUI5V+7HIbRsoqKzoudobpQJzxYgZ9vFG3z5/e2CMAH4zFGP0Z8uW/+Us
 TR8Slz1VytMSO7UrqsTj8V3HsHijg6/SA8Go7pJ+Y1WQ6LnsEbmyCAEfdKfmx9r/1lzI
 19cXy8p80SpBvQjS3sNAB42cjczkZgNhvEGWXIC6lLvIl8RivXeXVzmdl6jwKyTH6vdL
 wW27g792HAwyI0hkKP507riuQ1C001Rl9OHl5cFWZVALolGgguuxnMcTNke2DEiNlelN
 iFKw==
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

U28gdGhlIG91dHB1dCBpcyBjb25zaXN0ZW50IHdpdGggb3RoZXIgYXNpY3MuCgpTaWduZWQtb2Zm
LWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgfCA1ICsrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxh
eS9hcmN0dXJ1c19wcHQuYwppbmRleCAzZjEzOTg2ZDhlNTAuLjE5OWM5NmNhYTg4MiAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvYXJjdHVydXNfcHB0LmMKQEAgLTEzMjAsMTIg
KzEzMjAsMTcgQEAgc3RhdGljIGludCBhcmN0dXJ1c19nZXRfcG93ZXJfcHJvZmlsZV9tb2RlKHN0
cnVjdCBzbXVfY29udGV4dCAqc211LAogCQkJCQkiVlIiLAogCQkJCQkiQ09NUFVURSIsCiAJCQkJ
CSJDVVNUT00ifTsKKwlzdGF0aWMgY29uc3QgY2hhciAqdGl0bGVbXSA9IHsKKwkJCSJQUk9GSUxF
X0lOREVYKE5BTUUpIn07CiAJdWludDMyX3QgaSwgc2l6ZSA9IDA7CiAJaW50MTZfdCB3b3JrbG9h
ZF90eXBlID0gMDsKIAogCWlmICghc211LT5wbV9lbmFibGVkIHx8ICFidWYpCiAJCXJldHVybiAt
RUlOVkFMOwogCisJc2l6ZSArPSBzcHJpbnRmKGJ1ZiArIHNpemUsICIlMTZzXG4iLAorCQkJdGl0
bGVbMF0pOworCiAJZm9yIChpID0gMDsgaSA8PSBQUF9TTUNfUE9XRVJfUFJPRklMRV9DVVNUT007
IGkrKykgewogCQkvKgogCQkgKiBDb252IFBQX1NNQ19QT1dFUl9QUk9GSUxFKiB0byBXT1JLTE9B
RF9QUExJQl8qX0JJVAotLSAKMi4yMy4wCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
