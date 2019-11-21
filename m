Return-Path: <SRS0=kYY7=ZN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7ADC43215
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 13:29:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9752072E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2019 13:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9752072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28C626EE6D;
	Thu, 21 Nov 2019 13:29:36 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BECC6EE6D;
 Thu, 21 Nov 2019 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [118.189.143.39])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E188020708;
 Thu, 21 Nov 2019 13:29:32 +0000 (UTC)
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd: Fix Kconfig indentation
Date: Thu, 21 Nov 2019 21:29:30 +0800
Message-Id: <20191121132930.29544-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1574342975;
 bh=0aOPNq5lXI55EI7T6Z/U8tjiPKHmWfdsWlLmyY7a3Rs=;
 h=From:To:Cc:Subject:Date:From;
 b=vZ/TGfN092xHxItzh1k40rwiwOfUH8RR41oFZrUozW73w3jkMOB3rXuCRdOAIfZsf
 tZHj0xy3DLTiYeAppfN2UI574SG+rSkdRLCthqDlTkUbg4VhY2htsgnKfHHrdCyp08
 SNHZoCZPyj8TdNLeMi5hNX454ZyZqJdCZsiCsVeg=
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzk@kernel.org>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191121132930.Q6QTnftbqEhlgHxQxDhpZRQ3e01cffmAcVYr2NkRgGg@z>

QWRqdXN0IGluZGVudGF0aW9uIGZyb20gc3BhY2VzIHRvIHRhYiAoK29wdGlvbmFsIHR3byBzcGFj
ZXMpIGFzIGluCmNvZGluZyBzdHlsZSB3aXRoIGNvbW1hbmQgbGlrZToKCSQgc2VkIC1lICdzL14g
ICAgICAgIC9cdC8nIC1pICovS2NvbmZpZwoKU2lnbmVkLW9mZi1ieTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYWNwL0tjb25m
aWcgfCAxMCArKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYWNwL0tjb25maWcg
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FjcC9LY29uZmlnCmluZGV4IGQ5NjhjMjQ3MTQxMi4uMTli
YWU5MTAwZGE0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FjcC9LY29uZmlnCisr
KyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYWNwL0tjb25maWcKQEAgLTIsMTEgKzIsMTEgQEAKIG1l
bnUgIkFDUCAoQXVkaW8gQ29Qcm9jZXNzb3IpIENvbmZpZ3VyYXRpb24iCiAKIGNvbmZpZyBEUk1f
QU1EX0FDUAotICAgICAgIGJvb2wgIkVuYWJsZSBBTUQgQXVkaW8gQ29Qcm9jZXNzb3IgSVAgc3Vw
cG9ydCIKLSAgICAgICBkZXBlbmRzIG9uIERSTV9BTURHUFUKLSAgICAgICBzZWxlY3QgTUZEX0NP
UkUKLSAgICAgICBzZWxlY3QgUE1fR0VORVJJQ19ET01BSU5TIGlmIFBNCi0gICAgICAgaGVscAor
CWJvb2wgIkVuYWJsZSBBTUQgQXVkaW8gQ29Qcm9jZXNzb3IgSVAgc3VwcG9ydCIKKwlkZXBlbmRz
IG9uIERSTV9BTURHUFUKKwlzZWxlY3QgTUZEX0NPUkUKKwlzZWxlY3QgUE1fR0VORVJJQ19ET01B
SU5TIGlmIFBNCisJaGVscAogCUNob29zZSB0aGlzIG9wdGlvbiB0byBlbmFibGUgQUNQIElQIHN1
cHBvcnQgZm9yIEFNRCBTT0NzLgogCVRoaXMgYWRkcyB0aGUgQUNQIChBdWRpbyBDb1Byb2Nlc3Nv
cikgSVAgZHJpdmVyIGFuZCB3aXJlcwogCWl0IHVwIGludG8gdGhlIGFtZGdwdSBkcml2ZXIuICBU
aGUgQUNQIGJsb2NrIHByb3ZpZGVzIHRoZSBETUEKLS0gCjIuMTcuMQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
