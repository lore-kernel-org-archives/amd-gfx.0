Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8DC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 17:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506CE214E0
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 17:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506CE214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5156E9D3;
	Tue, 12 Nov 2019 17:35:17 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD6076E951;
 Tue, 12 Nov 2019 17:35:15 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7CB18214E0;
 Tue, 12 Nov 2019 17:35:15 +0000 (UTC)
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH V3 0/3] drm: replace magic numbers
Date: Tue, 12 Nov 2019 11:35:00 -0600
Message-Id: <20191112173503.176611-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1573580115;
 bh=+4EzQSM/k1VOif0/E/W/Xzv0GPRgNyMJHG5BQwoLXVU=;
 h=From:To:Cc:Subject:Date:From;
 b=mceh4Ur/VUEpqNhsdVlcNrzbKQFA3I3i+cQuPTI008T6RWy3FC2d15H05pRpKd3BW
 jWQWNqALKkTJyK/FbmzWRaDCohiyixeo0KKI1QAU4toEhNq++YbHzZVlVjoHQeVyeT
 1bmiyZkFCmbQ0PnoDeuOgGmZUQ6HFRsRubGkHM00=
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
Cc: Frederick Lawler <fred@fredlawl.com>, linux-pci@vger.kernel.org,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 Ilia Mirkin <imirkin@alum.mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112173500.tVqK9wKxlkJYjlcj_fJTFS4l4UrXJ2J7A4og6PRMNJ4@z>

RnJvbTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KCmFtZGdwdSBhbmQgcmFk
ZW9uIGRvIGEgYml0IG9mIG11Y2tpbmcgd2l0aCB0aGUgUENJZSBMaW5rIENvbnRyb2wgMgpyZWdp
c3Rlciwgc29tZSBvZiBpdCB1c2luZyBoYXJkLWNvZGVkIG1hZ2ljIG51bWJlcnMuICBUaGUgaWRl
YSBoZXJlIGlzIHRvCnJlcGxhY2UgdGhvc2Ugd2l0aCAjZGVmaW5lcy4KClNpbmNlIHYyOgogIC0g
Rml4IGEgZ3B1X2NmZzIgY2FzZSBpbiBhbWRncHUvc2kuYyB0aGF0IEkgaGFkIG1pc3NlZAogIC0g
U2VwYXJhdGUgb3V0IHRoZSBmdW5jdGlvbmFsIGNoYW5nZXMgZm9yIGJldHRlciBiaXNlY3Rpb24g
KHRoYW5rcywKICAgIE1pY2hlbCEpCiAgLSBBZGQgI2RlZmluZXMgaW4gYSBwYXRjaCBieSB0aGVt
c2VsdmVzIChzbyBhIEdQVSByZXZlcnQgd291bGRuJ3QgYnJlYWsKICAgIG90aGVyIHBvdGVudGlh
bCB1c2VycykKICAtIFNxdWFzaCBhbGwgdGhlIG1hZ2ljIG51bWJlciAtPiAjZGVmaW5lIGNoYW5n
ZXMgaW50byBvbmUgcGF0Y2gKClNpbmNlIHYxOgogIC0gQWRkIG15IHNpZ25lZC1vZmYtYnkgYW5k
IEFsZXgncyByZXZpZXdlZC1ieS4KCkJqb3JuIEhlbGdhYXMgKDMpOgogIFBDSTogQWRkICNkZWZp
bmVzIGZvciBFbnRlciBDb21wbGlhbmNlLCBUcmFuc21pdCBNYXJnaW4KICBkcm06IGNvcnJlY3Qg
VHJhbnNtaXQgTWFyZ2luIG1hc2tzCiAgZHJtOiByZXBsYWNlIG51bWJlcnMgd2l0aCBQQ0lfRVhQ
X0xOS0NUTDIgZGVmaW5pdGlvbnMKCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9jaWsuYyB8
IDIyICsrKysrKysrKysrKysrLS0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Np
LmMgIHwgMjIgKysrKysrKysrKysrKystLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9j
aWsuYyAgICAgfCAyMiArKysrKysrKysrKysrKy0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFk
ZW9uL3NpLmMgICAgICB8IDIyICsrKysrKysrKysrKysrLS0tLS0tLS0KIGluY2x1ZGUvdWFwaS9s
aW51eC9wY2lfcmVncy5oICAgIHwgIDIgKysKIDUgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9u
cygrKSwgMzIgZGVsZXRpb25zKC0pCgotLSAKMi4yNC4wLnJjMS4zNjMuZ2IxYmNjZDNlM2QtZ29v
ZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
