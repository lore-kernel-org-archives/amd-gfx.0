Return-Path: <SRS0=+iNy=ZD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD82C17445
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 19:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F684222BD
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Nov 2019 19:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F684222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CC56E291;
	Mon, 11 Nov 2019 19:30:04 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E673B6E283;
 Mon, 11 Nov 2019 19:30:02 +0000 (UTC)
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 470262184C;
 Mon, 11 Nov 2019 19:30:02 +0000 (UTC)
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 0/2] drm: replace magic numbers
Date: Mon, 11 Nov 2019 13:29:30 -0600
Message-Id: <20191111192932.36048-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1573500602;
 bh=/6YuVyX8+CxUq2e6F7e9g+b1C2bSx1WCkr5GbVkW9Xs=;
 h=From:To:Cc:Subject:Date:From;
 b=fafL6OYNK8Cw8CWPDakiGzTnD86oWHwarGqqueP7zWkIWHFcNjlv+Fci1aHuu0ScV
 QguxNMhurKQ9ijInqiaCmj6OtVdZqV1SezT7oUD7gJCGRrmyVaijA9KRDnqiTmwzjv
 EevmB60AD22bc6aZKsGIhqfoxEZOiV2xQKazGwn4=
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
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 Ilia Mirkin <imirkin@alum.mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191111192930.SrNL2E8yW1yopYh3cs-6pnxJchxj2_9UMdRJO7GGb20@z>

RnJvbTogQmpvcm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4KCmFtZGdwdSBhbmQgcmFk
ZW9uIGRvIGEgYml0IG9mIG11Y2tpbmcgd2l0aCB0aGUgUENJZSBMaW5rIENvbnRyb2wgMgpyZWdp
c3Rlciwgc29tZSBvZiBpdCB1c2luZyBoYXJkLWNvZGVkIG1hZ2ljIG51bWJlcnMuICBUaGUgaWRl
YSBoZXJlIGlzIHRvCnJlcGxhY2UgdGhvc2Ugd2l0aCAjZGVmaW5lcy4KCkkgZG9uJ3QgaW50ZW5k
IHRoZSBUYXJnZXQgTGluayBTcGVlZCBwYXRjaCB0byBjaGFuZ2UgYW55dGhpbmcsIHNvIGl0IHNo
b3VsZApiZSBzdHJhaWdodGZvcndhcmQgdG8gcmV2aWV3LgoKU2luY2UgdjE6CiAgLSBBZGQgbXkg
c2lnbmVkLW9mZi1ieSBhbmQgQWxleCdzIHJldmlld2VkLWJ5LgoKQmpvcm4gSGVsZ2FhcyAoMik6
CiAgZHJtOiByZXBsYWNlIGluY29ycmVjdCBDb21wbGlhbmNlL01hcmdpbiBtYWdpYyBudW1iZXJz
IHdpdGgKICAgIFBDSV9FWFBfTE5LQ1RMMiBkZWZpbml0aW9ucwogIGRybTogcmVwbGFjZSBUYXJn
ZXQgTGluayBTcGVlZCBtYWdpYyBudW1iZXJzIHdpdGggUENJX0VYUF9MTktDVEwyCiAgICBkZWZp
bml0aW9ucwoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npay5jIHwgMjIgKysrKysrKysr
KysrKystLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2kuYyAgfCAxOCArKysr
KysrKysrKy0tLS0tLS0KIGRyaXZlcnMvZ3B1L2RybS9yYWRlb24vY2lrLmMgICAgIHwgMjIgKysr
KysrKysrKysrKystLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9zaS5jICAgICAgfCAy
MiArKysrKysrKysrKysrKy0tLS0tLS0tCiBpbmNsdWRlL3VhcGkvbGludXgvcGNpX3JlZ3MuaCAg
ICB8ICAyICsrCiA1IGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9u
cygtKQoKLS0gCjIuMjQuMC5yYzEuMzYzLmdiMWJjY2QzZTNkLWdvb2cKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
