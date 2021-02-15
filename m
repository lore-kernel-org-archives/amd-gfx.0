Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB1EC433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 11:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CEE64D73
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 11:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CEE64D73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292826E135;
	Mon, 15 Feb 2021 11:43:41 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C4B36E135
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 11:43:39 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id s11so7617464edd.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 03:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M7y+IiK47s8M2zv0mav4uA/IU6GOwsfw1P1SqyYTSM4=;
 b=bN4dDQwvo1RKOu479OjsJXeDAsmaGLhFUdPPpheh4YCnfQRUBcuVjVahAfLmBZD1d9
 0ebwPjGX9qdJ2GUNkxF20fkbd/b85f02RMw1kinmD4GsvhGZLWMIyFNIPXOyEHApLPPc
 Mh9nQHzkZE6snjWplMJ1rxVrqtxhuTubd3oo9uRTKUF/oSf22uaXOGEWLVy9qDljephn
 u3NAvg2EaKvLOy6WIEhlvfg9Yiyl3dugn2BSfqQt6hu5Banu5jrUXzTn0RDLtHZj4ub0
 VF0uI/h/j+2AoyFevppCusBREOXLUnmB0XDQCptetMXf5qXBv1n3MlN8OqTCh4hQBhme
 X0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=M7y+IiK47s8M2zv0mav4uA/IU6GOwsfw1P1SqyYTSM4=;
 b=c+h5M3Vzg2nTF3ViWdlmCehltQxjdboVUHmGalGb3qJZKJAvm7HKxjnW6M81HxDORF
 60mwiu/r+FTD1aOPub9bHe5OIuadZm7cbHunKsbEFQlstzQlUqex7+zd/TmDlcyoTWyz
 OnDiYL29ZUat4hxUIt59K3/F+DFgHY9aMBwQ0te9dz69CXCQ3BpRk42jI+mrtgKELHAa
 gkpjxPBI/hgBhGxhE7NZk5khbAYBWA7ABJmCOXzGg0qzJqvJ0l+y0+v4Ut62fJA81GnR
 mEi3wUatAWo0ajZiz1HB24v6xW87e9lQRrFeuWqhKTZze22KSx9VP3cr13iVBJJebCUY
 GzVQ==
X-Gm-Message-State: AOAM5323OCWt2z7vsaPOeXfNUjgWNbXV1AdhQC5w3wPq2FZOzXYDhaKB
 zSrKtfbwuIja9+g4gcawZArWEUxnenaoAw==
X-Google-Smtp-Source: ABdhPJzY3wyrMOqf/k90/KCyrWHAsHpquW+V/vFe7+wKqNnQBiNNWT9tRkWl7mvdaBa9fwucIzqDLA==
X-Received: by 2002:aa7:c5d4:: with SMTP id h20mr1706999eds.161.1613389418303; 
 Mon, 15 Feb 2021 03:43:38 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:7947:c6d1:7053:6072])
 by smtp.gmail.com with ESMTPSA id l24sm3013974edq.32.2021.02.15.03.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 03:43:37 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	shashank.sharma@amd.com
Subject: [PATCH] drm/amdgpu: Set GTT_USWC flag to enable freesync v2
Date: Mon, 15 Feb 2021 12:43:36 +0100
Message-Id: <20210215114336.89977-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogU2hhc2hhbmsgU2hhcm1hIDxzaGFzaGFuay5zaGFybWFAYW1kLmNvbT4KClRoaXMgcGF0
Y2ggc2V0cyAnQU1ER1BVX0dFTV9DUkVBVEVfQ1BVX0dUVF9VU1dDJyBhcyBpbnB1dApwYXJhbWV0
ZXIgZmxhZywgZHVyaW5nIG9iamVjdCBjcmVhdGlvbiBvZiBhbiBpbXBvcnRlZCBETUEKYnVmZmVy
LgoKSW4gYWJzZW5jZSBvZiB0aGlzIGZsYWc6CjEuIEZ1bmN0aW9uIGFtZGdwdV9kaXNwbGF5X3N1
cHBvcnRlZF9kb21haW5zKCkgZG9lc24ndCBhZGQKICAgQU1ER1BVX0dFTV9ET01BSU5fR1RUIGFz
IHN1cHBvcnRlZCBkb21haW4uCjIuIER1ZSB0byB3aGljaCwgRnVuY3Rpb24gYW1kZ3B1X2Rpc3Bs
YXlfdXNlcl9mcmFtZWJ1ZmZlcl9jcmVhdGUoKQogICByZWZ1c2VzIHRvIGNyZWF0ZSBmcmFtZWJ1
ZmZlciBmb3IgaW1wb3J0ZWQgRE1BIGJ1ZmZlcnMuCjMuIER1ZSB0byB3aGljaCwgQWRkRkIoKSBJ
T0NUTCBmYWlscy4KNC4gRHVlIHRvIHdoaWNoLCBhbWRncHVfcHJlc2VudF9jaGVja19mbGlwKCkg
Y2hlY2sgZmFpbHMgaW4gRERYCjUuIER1ZSB0byB3aGljaCBERFggZHJpdmVyIGRvZXNuJ3QgYWxs
b3cgZmxpcHMgKGdvZXMgdG8gYmxpdHRpbmcpCjYuIER1ZSB0byB3aGljaCBzZXR0aW5nIEZyZWVz
eW5jL1ZSUiBwcm9wZXJ0eSBmYWlscyBmb3IgUFJJTUUgYnVmZmVycy4KClNvLCB0aGlzIHBhdGNo
IGZpbmFsbHkgZW5hYmxlcyBGcmVlc3luYyB3aXRoIFBSSU1FIGJ1ZmZlciBvZmZsb2FkaW5nLgoK
djIgKGNoayk6IGluc3RlYWQgb2YganVzdCBjaGVja2luZyB0aGUgZmxhZyB3ZSBjb3B5IGl0IG92
ZXIgaWYgdGhlCiAgICAgICAgICBleHBvcnRlciBpcyBhbiBhbWRncHUgZGV2aWNlIGFzIHdlbGwu
CgpTaWduZWQtb2ZmLWJ5OiBTaGFzaGFuayBTaGFybWEgPHNoYXNoYW5rLnNoYXJtYUBhbWQuY29t
PgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5j
b20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYyB8IDE0
ICsrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
ZG1hX2J1Zi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYwpp
bmRleCBkMzcyN2YzYWIyNzcuLmE1NGE4NzBmMDA2YyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2RtYV9idWYuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfZG1hX2J1Zi5jCkBAIC00MjIsMTQgKzQyMiwyMiBAQCBhbWRncHVfZG1h
X2J1Zl9jcmVhdGVfb2JqKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHN0cnVjdCBkbWFfYnVmICpk
bWFfYnVmKQogewogCXN0cnVjdCBkbWFfcmVzdiAqcmVzdiA9IGRtYV9idWYtPnJlc3Y7CiAJc3Ry
dWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBkcm1fdG9fYWRldihkZXYpOwotCXN0cnVjdCBhbWRn
cHVfYm8gKmJvOwogCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqZ29iajsKKwlzdHJ1Y3QgYW1kZ3B1
X2JvICpibzsKKwl1aW50NjRfdCBmbGFncyA9IDA7CiAJaW50IHJldDsKIAogCWRtYV9yZXN2X2xv
Y2socmVzdiwgTlVMTCk7CisKKwlpZiAoZG1hX2J1Zi0+b3BzID09ICZhbWRncHVfZG1hYnVmX29w
cykgeworCQlzdHJ1Y3QgYW1kZ3B1X2JvICpvdGhlciA9IGdlbV90b19hbWRncHVfYm8oZG1hX2J1
Zi0+cHJpdik7CisKKwkJZmxhZ3MgfD0gb3RoZXItPmZsYWdzICYgQU1ER1BVX0dFTV9DUkVBVEVf
Q1BVX0dUVF9VU1dDOworCX0KKwogCXJldCA9IGFtZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZShhZGV2
LCBkbWFfYnVmLT5zaXplLCBQQUdFX1NJWkUsCi0JCQlBTURHUFVfR0VNX0RPTUFJTl9DUFUsCi0J
CQkwLCB0dG1fYm9fdHlwZV9zZywgcmVzdiwgJmdvYmopOworCQkJCSAgICAgICBBTURHUFVfR0VN
X0RPTUFJTl9DUFUsIGZsYWdzLAorCQkJCSAgICAgICB0dG1fYm9fdHlwZV9zZywgcmVzdiwgJmdv
YmopOwogCWlmIChyZXQpCiAJCWdvdG8gZXJyb3I7CiAKLS0gCjIuMjUuMQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QK
YW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
