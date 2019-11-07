Return-Path: <SRS0=ouc1=Y7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22212C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 22:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09E32166E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Nov 2019 22:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09E32166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 434396F7E4;
	Thu,  7 Nov 2019 22:21:06 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F9476F7E3;
 Thu,  7 Nov 2019 22:21:05 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8DF4A206C3;
 Thu,  7 Nov 2019 22:21:04 +0000 (UTC)
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 0/2] drm: replace magic nuumbers
Date: Thu,  7 Nov 2019 16:20:45 -0600
Message-Id: <20191107222047.125496-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1573165264;
 bh=o/q0uASjJnBVaAfXrJkzJZuhoIg5oq6iWOmQ1ROAA0I=;
 h=From:To:Cc:Subject:Date:From;
 b=CgwqdvpxFsYFx12bPiJSAYNr8E+vT5BSY7bZLFBBgW79yCMnmfg8oz9CqenvyXZHT
 muvgLNiW2RIlaUpPF0niXHW/0E5DGj7maM5/Lta4Su2saJMIqfrq4LUvBcslhfalM0
 rgcPlMplJkcgKk7ZRpqxk2Q6X2wphJGkYQl4hHhg=
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
Cc: Bjorn Helgaas <bhelgaas@google.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Frederick Lawler <fred@fredlawl.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191107222045.4lM95dcizVya0mdQn_T--N4v2UhX5xnXsHOL5P7dIKQ@z>

RnJvbTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KCmFtZGdwdSBhbmQgcmFk
ZW9uIGRvIGEgYml0IG9mIG11Y2tpbmcgd2l0aCB0aGUgUENJZSBMaW5rIENvbnRyb2wgMgpyZWdp
c3Rlciwgc29tZSBvZiBpdCB1c2luZyBoYXJkLWNvZGVkIG1hZ2ljIG51bWJlcnMuICBUaGUgaWRl
YSBoZXJlIGlzIHRvCnJlcGxhY2UgdGhvc2Ugd2l0aCAjZGVmaW5lcy4KCkkgaGF2ZW4ndCBzaWdu
ZWQgb2ZmIG9uIHRoZXNlIGJlY2F1c2UgdGhlIGZpcnN0IG9uZSBhY3R1YWxseSBjaGFuZ2VzIHRo
ZQpiaXRzIGludm9sdmVkIGJlY2F1c2UgdGhlIGV4aXN0aW5nIGNvZGUgbG9va3MgbGlrZSBpdCBt
aWdodCBoYXZlIGEgdHlwby4KQnV0IEkgaGF2ZSBubyB3YXkgdG8ga25vdyBmb3Igc3VyZS4KCkkg
ZG9uJ3QgaW50ZW5kIHRoZSBUYXJnZXQgTGluayBTcGVlZCBwYXRjaCB0byBjaGFuZ2UgYW55dGhp
bmcsIHNvIGl0IHNob3VsZApiZSBzdHJhaWdodGZvcndhcmQgdG8gcmV2aWV3LgoKQmpvcm4gSGVs
Z2FhcyAoMik6CiAgZHJtOiByZXBsYWNlIENvbXBsaWFuY2UvTWFyZ2luIG1hZ2ljIG51bWJlcnMg
d2l0aCBQQ0lfRVhQX0xOS0NUTDIKICAgIGRlZmluaXRpb25zCiAgZHJtOiByZXBsYWNlIFRhcmdl
dCBMaW5rIFNwZWVkIG1hZ2ljIG51bWJlcnMgd2l0aCBQQ0lfRVhQX0xOS0NUTDIKICAgIGRlZmlu
aXRpb25zCgogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrLmMgfCAyMiArKysrKysrKysr
KysrKy0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaS5jICB8IDE4ICsrKysr
KysrKysrLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9jaWsuYyAgICAgfCAyMiArKysr
KysrKysrKysrKy0tLS0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3NpLmMgICAgICB8IDIy
ICsrKysrKysrKysrKysrLS0tLS0tLS0KIGluY2x1ZGUvdWFwaS9saW51eC9wY2lfcmVncy5oICAg
IHwgIDIgKysKIDUgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25z
KC0pCgotLSAKMi4yNC4wLnJjMS4zNjMuZ2IxYmNjZDNlM2QtZ29vZwoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
