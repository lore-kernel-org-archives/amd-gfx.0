Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F2BC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:01:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6685206D3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 16:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6685206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AFCB6E90B;
	Fri, 15 Nov 2019 16:01:36 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29BFA6E90B
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 16:01:35 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id d3so3942187qvs.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 08:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gS85lvWIqk0u+6TjdaXM/w4wZMwJRwRzNwmhSZ06xNE=;
 b=F9+CmC/TDCm2ltawYw+9Bl8rMjWuikIKr4nkRh1dyhksjfbvXnAZSm3M8tUXTMHKWL
 StnZYUupBUJkO6npuA7Y+/Rt13ECfYwl5XczzRnvdmEviq33Gpbchvga60KSTW4bVw35
 St31iUSQ+FMOt+Y2yzH74odnNKS53yIXsClpPEExp8GQVfUzZjA9ZSvPSmnhYYvinHvy
 2kKPTHcFPmR3xfoHPLZwNWlIDJ3IPArR0B8MDERJfJWmksYweObzQW02SJ4AdHD993V/
 K/tFYXjGdT648y6nWozdgiw+OcTvunQRVklnJmGhSQdgh21pVUBFC5Kk9mRmOmrJwXNa
 gr5w==
X-Gm-Message-State: APjAAAWlNMmK4E1LAZ1W++4KRQTvhXrIoDrJm243s0iHXhsHpUlX481j
 NlhCIbAQCb91u4TwnTBepvJC0+iP
X-Google-Smtp-Source: APXvYqz7MNC27laVRaVXVBY00e4uvQjDJU23WsEtgbkW85Y9pUPxrJJBJVL/MANvxklWv7za2vKL0g==
X-Received: by 2002:a0c:e4c2:: with SMTP id g2mr13277670qvm.183.1573833693929; 
 Fri, 15 Nov 2019 08:01:33 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id d13sm5241815qta.67.2019.11.15.08.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2019 08:01:33 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: re-enable wait in pipelock, but add timeout
Date: Fri, 15 Nov 2019 11:01:19 -0500
Message-Id: <20191115160119.658620-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gS85lvWIqk0u+6TjdaXM/w4wZMwJRwRzNwmhSZ06xNE=;
 b=VRLEAPc44djheUpKiRyt3gkkGEMR3K+VgcFgamr1UFZROmobuX+DbsFgNz4M4yzmsd
 yMJll1iXUV3O1vG4+XWoK883a+GXOlfL7lbWrb3f4tmWvczwEMnaNcayQd1hsG8HI/6h
 4j0qzQGCEfz8QH8I3Sb1EotUb++HP0pjHBoN5YmmCbyNx2V2dhG2x+wRmlKEg02BIXJu
 a+YWg6jSI9X6GsyttG9sovoYjBvZuhydfDwzKN3MxzS79OVKRtddnvwO+wN5Ffg23txO
 jT5t6Kup+9ir9yCm+ynlxV/mEZXLpNuPz3XE3dvxFJ4Kd37Oas+UmuqJoi5HcywGd81b
 QHnw==
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
Message-ID: <20191115160119.hBloNNRO-SRQX4GfqC-2-K7MgQNRJ_0zPfHe_H4cmeI@z>

UmVtb3ZpbmcgdGhpcyBjYXVzZXMgaGFuZ3MgaW4gc29tZSBnYW1lcywgc28gcmUtYWRkIGl0LCBi
dXQgYWRkCmEgdGltZW91dCBzbyB3ZSBkb24ndCBoYW5nIHdoaWxlIHN3aXRjaGluZyBmbGlwIHR5
cGVzLgoKQnVnOiBodHRwczovL2J1Z3ppbGxhLmtlcm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIw
NTE2OQpCdWc6IGh0dHBzOi8vYnVncy5mcmVlZGVza3RvcC5vcmcvc2hvd19idWcuY2dpP2lkPTEx
MjI2NgpCdWc6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjA1
MTY5ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KLS0tCiAuLi4vZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h3c2VxLmMgICAgfCAx
OSArKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9o
d3NlcS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjIwL2RjbjIwX2h3c2Vx
LmMKaW5kZXggMDA0NmEwOTljOWU5Li4xMjBlNjJjNTE5M2MgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCisrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9od3NlcS5jCkBAIC0xMDMzLDYgKzEw
MzMsMjUgQEAgdm9pZCBkY24yMF9waXBlX2NvbnRyb2xfbG9jaygKIAlpZiAocGlwZS0+cGxhbmVf
c3RhdGUgIT0gTlVMTCkKIAkJZmxpcF9pbW1lZGlhdGUgPSBwaXBlLT5wbGFuZV9zdGF0ZS0+Zmxp
cF9pbW1lZGlhdGU7CiAKKwlpZiAoZmxpcF9pbW1lZGlhdGUgJiYgbG9jaykgeworCQljb25zdCBp
bnQgVElNRU9VVF9GT1JfRkxJUF9QRU5ESU5HID0gMTAwMDAwOworCQlpbnQgaTsKKworCQlmb3Ig
KGkgPSAwOyBpIDwgVElNRU9VVF9GT1JfRkxJUF9QRU5ESU5HOyArK2kpIHsKKwkJCWlmICghcGlw
ZS0+cGxhbmVfcmVzLmh1YnAtPmZ1bmNzLT5odWJwX2lzX2ZsaXBfcGVuZGluZyhwaXBlLT5wbGFu
ZV9yZXMuaHVicCkpCisJCQkJYnJlYWs7CisJCQl1ZGVsYXkoMSk7CisJCX0KKworCQlpZiAocGlw
ZS0+Ym90dG9tX3BpcGUgIT0gTlVMTCkgeworCQkJZm9yIChpID0gMDsgaSA8IFRJTUVPVVRfRk9S
X0ZMSVBfUEVORElORzsgKytpKSB7CisJCQkJaWYgKCFwaXBlLT5ib3R0b21fcGlwZS0+cGxhbmVf
cmVzLmh1YnAtPmZ1bmNzLT5odWJwX2lzX2ZsaXBfcGVuZGluZyhwaXBlLT5ib3R0b21fcGlwZS0+
cGxhbmVfcmVzLmh1YnApKQorCQkJCQlicmVhazsKKwkJCQl1ZGVsYXkoMSk7CisJCQl9CisJCX0K
Kwl9CisKIAkvKiBJbiBmbGlwIGltbWVkaWF0ZSBhbmQgcGlwZSBzcGxpdHRpbmcgY2FzZSwgd2Ug
bmVlZCB0byB1c2UgR1NMCiAJICogZm9yIHN5bmNocm9uaXphdGlvbi4gT25seSBkbyBzZXR1cCBv
biBsb2NraW5nIGFuZCBvbiBmbGlwIHR5cGUgY2hhbmdlLgogCSAqLwotLSAKMi4yMy4wCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZng=
