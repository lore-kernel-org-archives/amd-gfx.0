Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29764C33C9E
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 12:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF739206D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 12:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rHNi93Ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF739206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72FDF6EE75;
	Thu, 30 Jan 2020 12:49:45 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAC06EE75
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 12:49:44 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id a9so4073179wmj.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 04:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WOb0D+22TK1krWvEd08C/a0BS5n1CzFSGMwoeC2CZ6g=;
 b=rHNi93LnH0t5kxCS1uSC83iR2Q1QYp8SyZ7d4YNvxycdMKM9A6Z5yGDYjnV6pgq4sj
 By/+LJwA8lVGe8Wg6CyqLCNd63+Q+E6p0M82HOjj7upSk1YCVFIYybszU4htGI1EVgos
 l1hx+5KPx8KCb5PQdu9Kvk8A2bEXw1HJS38v2dGlIdovVirCmW44/PrxM/AGJtwXItKa
 +HG9JeeRrp410jI2gnYmnordCexSbhbwFyJxCCOGBNv5gSnYrYzLRde9mks57b8PaZI9
 S/kYJAFg2JtMJ+O45A55JKuFwi5mnLXESVTSb9TAQ+q+pIlCjiqBMiwPcBdpKFJ21puJ
 QOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WOb0D+22TK1krWvEd08C/a0BS5n1CzFSGMwoeC2CZ6g=;
 b=UMWzy+zCJIT4145O0wQGD9LeTmOWUitC7+wWR1EZw/HMC4DUjDlySH9ruDsVAo9Axq
 vqRoQi/mvgmUDg9/R9LDifA4KWEdJnFnvU0cH+nwYbi5MHKBjaOC5pru135CAxXDy0fU
 fJxJtx25HYhVE/yKUF2KjkOuMJ2BB7pnr+vKr6NozbnTHz6vyXAE7Ti1uoTaDKvL0Byr
 K/K8mAlEe87/Hf0E7dk1RVUpnNeFFnQgYEGX8x5A3y3fflMcupeB0M0K3KT+APg4RdmG
 4ROYWUl89u9V8oJGIPBcOxfOxRQP1+c+FBE2FYweVKkeJkkFcIzBfremgdmHJ4RXkFuY
 hI0A==
X-Gm-Message-State: APjAAAVvCTUuXlTOnNebzDqPDG3bk2M7gbZoOk0A6fi0K4GAbBfr3uu5
 QIzeqsnpZhKY6M3St7s92RlWoEnp
X-Google-Smtp-Source: APXvYqyTwxGR9/asYHPOpmoM2uTKWYW0ACBDQBQZRRZspyBMGJwCRwGoZqR6p54+KjaXUyljysoeVQ==
X-Received: by 2002:a1c:4c5:: with SMTP id 188mr5472908wme.82.1580388583123;
 Thu, 30 Jan 2020 04:49:43 -0800 (PST)
Received: from abel.fritz.box ([2a02:908:1252:fb60:dc0f:106a:b4b9:c241])
 by smtp.gmail.com with ESMTPSA id i2sm6496912wmb.28.2020.01.30.04.49.41
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2020 04:49:42 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/5] drm/amdgpu: fix braces in amdgpu_vm_update_ptes
Date: Thu, 30 Jan 2020 13:49:36 +0100
Message-Id: <20200130124940.30380-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.17.1
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

Rm9yIHRoZSByb290IFBEIG1hc2sgY2FuIGJlIDB4ZmZmZmZmZmYgYXMgd2VsbCB3aGljaCB3b3Vs
ZApvdmVycnVuIHRvIDAgaWYgd2UgZG9uJ3QgY2FzdCBpdCBiZWZvcmUgd2UgYWRkIG9uZS4KClNp
Z25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
VGVzdGVkLWJ5OiBUb20gU3QgRGVuaXMgPHRvbS5zdGRlbmlzQGFtZC5jb20+Ci0tLQogZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV92bS5jCmluZGV4IDVjYjE4MjIzMWY1ZC4uNGJhNmE1ZTVkMDk0IDEwMDY0NAotLS0gYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdm0uYwpAQCAtMTQ4Nyw3ICsxNDg3LDcgQEAgc3RhdGljIGlu
dCBhbWRncHVfdm1fdXBkYXRlX3B0ZXMoc3RydWN0IGFtZGdwdV92bV91cGRhdGVfcGFyYW1zICpw
YXJhbXMsCiAJCWluY3IgPSAodWludDY0X3QpQU1ER1BVX0dQVV9QQUdFX1NJWkUgPDwgc2hpZnQ7
CiAJCW1hc2sgPSBhbWRncHVfdm1fZW50cmllc19tYXNrKGFkZXYsIGN1cnNvci5sZXZlbCk7CiAJ
CXBlX3N0YXJ0ID0gKChjdXJzb3IucGZuID4+IHNoaWZ0KSAmIG1hc2spICogODsKLQkJZW50cnlf
ZW5kID0gKHVpbnQ2NF90KShtYXNrICsgMSkgPDwgc2hpZnQ7CisJCWVudHJ5X2VuZCA9ICgodWlu
dDY0X3QpbWFzayArIDEpIDw8IHNoaWZ0OwogCQllbnRyeV9lbmQgKz0gY3Vyc29yLnBmbiAmIH4o
ZW50cnlfZW5kIC0gMSk7CiAJCWVudHJ5X2VuZCA9IG1pbihlbnRyeV9lbmQsIGVuZCk7CiAKLS0g
CjIuMTcuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
