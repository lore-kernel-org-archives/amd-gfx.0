Return-Path: <SRS0=ffWE=ZP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D620C432C0
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Nov 2019 18:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801802068D
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Nov 2019 18:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801802068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491EC6E0E5;
	Sat, 23 Nov 2019 18:23:33 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFBAC6E119;
 Fri, 22 Nov 2019 23:04:10 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1iYHyB-0007vO-EP; Fri, 22 Nov 2019 23:04:07 +0000
From: Colin King <colin.king@canonical.com>
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: remove redundant assignment to variables
 HiSidd and LoSidd
Date: Fri, 22 Nov 2019 23:04:07 +0000
Message-Id: <20191122230407.109636-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 23 Nov 2019 18:23:25 +0000
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191122230407.s9gaw84Kqa2Nc_8CqvuVRk6wEROe22H3gb4pSRE7lgg@z>

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZSB2YXJp
YWJsZXMgSGlTaWRkIGFuZCBMb1NpZGQgYXJlIGJlaW5nIGluaXRpYWxpemVkIHdpdGggdmFsdWVz
IHRoYXQKYXJlIG5ldmVyIHJlYWQgYW5kIGFyZSBiZWluZyB1cGRhdGVkIGEgbGl0dGxlIGxhdGVy
IHdpdGggYSBuZXcgdmFsdWUuClRoZSBpbml0aWFsaXphdGlvbiBpcyByZWR1bmRhbnQgYW5kIGNh
biBiZSByZW1vdmVkLgoKQWRkcmVzc2VzLUNvdmVyaXR5OiAoIlVudXNlZCB2YWx1ZSIpClNpZ25l
ZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Ci0tLQog
ZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvc211bWdyL2NpX3NtdW1nci5jIHwgNCArKy0t
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9jaV9zbXVtZ3IuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L3NtdW1nci9jaV9zbXVtZ3IuYwppbmRleCAx
NTU5MGZkODZlZjQuLjg2OGUyZDVmNmU2MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvc211bWdyL2NpX3NtdW1nci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
cG93ZXJwbGF5L3NtdW1nci9jaV9zbXVtZ3IuYwpAQCAtNjUzLDggKzY1Myw4IEBAIHN0YXRpYyBp
bnQgY2lfbWluX21heF92X2duYmxfcG1fbGlkX2Zyb21fYmFwbV92ZGRjKHN0cnVjdCBwcF9od21n
ciAqaHdtZ3IpCiBzdGF0aWMgaW50IGNpX3BvcHVsYXRlX2JhcG1fdmRkY19iYXNlX2xlYWthZ2Vf
c2lkZChzdHJ1Y3QgcHBfaHdtZ3IgKmh3bWdyKQogewogCXN0cnVjdCBjaV9zbXVtZ3IgKnNtdV9k
YXRhID0gKHN0cnVjdCBjaV9zbXVtZ3IgKikoaHdtZ3ItPnNtdV9iYWNrZW5kKTsKLQl1aW50MTZf
dCBIaVNpZGQgPSBzbXVfZGF0YS0+cG93ZXJfdHVuZV90YWJsZS5CYXBtVmRkQ0Jhc2VMZWFrYWdl
SGlTaWRkOwotCXVpbnQxNl90IExvU2lkZCA9IHNtdV9kYXRhLT5wb3dlcl90dW5lX3RhYmxlLkJh
cG1WZGRDQmFzZUxlYWthZ2VMb1NpZGQ7CisJdWludDE2X3QgSGlTaWRkOworCXVpbnQxNl90IExv
U2lkZDsKIAlzdHJ1Y3QgcGhtX2NhY190ZHBfdGFibGUgKmNhY190YWJsZSA9IGh3bWdyLT5keW5f
c3RhdGUuY2FjX2R0cF90YWJsZTsKIAogCUhpU2lkZCA9ICh1aW50MTZfdCkoY2FjX3RhYmxlLT51
c0hpZ2hDQUNMZWFrYWdlIC8gMTAwICogMjU2KTsKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1k
LWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcv
bWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
