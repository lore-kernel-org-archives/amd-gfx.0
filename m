Return-Path: <SRS0=5//3=ZA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E8DFA372C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D31F121D7F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2019 16:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31F121D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5E86FA01;
	Fri,  8 Nov 2019 16:33:33 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71EAA6F9FA;
 Fri,  8 Nov 2019 16:29:48 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1iT78s-0006ft-4s; Fri, 08 Nov 2019 16:29:46 +0000
From: Colin King <colin.king@canonical.com>
To: Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH][next] drm/amd/display: remove redundant variable status
Date: Fri,  8 Nov 2019 16:29:45 +0000
Message-Id: <20191108162945.180624-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 08 Nov 2019 16:33:32 +0000
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
Message-ID: <20191108162945.5ygohHib3Ers-1FkD12WF6O5lcPaDzUTTegR2zqEFwg@z>

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClZhcmlhYmxl
IHN0YXR1cyBpcyByZWR1bmRhbnQsIGl0IGlzIGJlaW5nIGluaXRpYWxpemVkIHdpdGggYSB2YWx1
ZQp0aGF0IGlzIG92ZXItd3JpdHRlbiBsYXRlciBhbmQgdGhpcyBpcyBiZWluZyByZXR1cm5lZCBp
bW1lZGlhdGVseQphZnRlciB0aGUgYXNzaWdubWVudC4gIENsZWFuIHVwIHRoZSBjb2RlIGJ5IHJl
bW92aW5nIHN0YXR1cyBhbmQKanVzdCByZXR1cm5pbmcgdGhlIHZhbHVlIHJldHVybmVkIGZyb20g
dGhlIGNhbGwgdG8gZnVuY3Rpb24KZGMtPmh3c3MuZG1kYXRhX3N0YXR1c19kb25lLgoKQWRkcmVz
c2VzLUNvdmVyaXR5OiAoIlVudXNlZCB2YWx1ZSIpClNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBL
aW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2NvcmUvZGNfc3RyZWFtLmMgfCA0ICstLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdHJlYW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9jb3JlL2RjX3N0cmVhbS5jCmluZGV4IDM3MWQ0OWU5Yjc0NS4uODhhODRiZmFlYTZm
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdHJl
YW0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvY29yZS9kY19zdHJlYW0u
YwpAQCAtNTY1LDcgKzU2NSw2IEBAIGJvb2wgZGNfc3RyZWFtX2dldF9zY2Fub3V0cG9zKGNvbnN0
IHN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKnN0cmVhbSwKIAogYm9vbCBkY19zdHJlYW1fZG1kYXRh
X3N0YXR1c19kb25lKHN0cnVjdCBkYyAqZGMsIHN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKnN0cmVh
bSkKIHsKLQlib29sIHN0YXR1cyA9IHRydWU7CiAJc3RydWN0IHBpcGVfY3R4ICpwaXBlID0gTlVM
TDsKIAlpbnQgaTsKIApAQCAtNTgxLDggKzU4MCw3IEBAIGJvb2wgZGNfc3RyZWFtX2RtZGF0YV9z
dGF0dXNfZG9uZShzdHJ1Y3QgZGMgKmRjLCBzdHJ1Y3QgZGNfc3RyZWFtX3N0YXRlICpzdHJlYW0p
CiAJaWYgKGkgPT0gTUFYX1BJUEVTKQogCQlyZXR1cm4gdHJ1ZTsKIAotCXN0YXR1cyA9IGRjLT5o
d3NzLmRtZGF0YV9zdGF0dXNfZG9uZShwaXBlKTsKLQlyZXR1cm4gc3RhdHVzOworCXJldHVybiBk
Yy0+aHdzcy5kbWRhdGFfc3RhdHVzX2RvbmUocGlwZSk7CiB9CiAKIGJvb2wgZGNfc3RyZWFtX3Nl
dF9keW5hbWljX21ldGFkYXRhKHN0cnVjdCBkYyAqZGMsCi0tIAoyLjIwLjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
