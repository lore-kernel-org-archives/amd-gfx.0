Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAC5C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 21:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B6B2071F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 21:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B6B2071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674106E0FD;
	Mon,  2 Dec 2019 21:48:54 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A9A895E7;
 Mon,  2 Dec 2019 15:47:41 +0000 (UTC)
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1ibnvG-00032m-IF; Mon, 02 Dec 2019 15:47:38 +0000
From: Colin King <colin.king@canonical.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: remove redundant assignment to variable
 v_total
Date: Mon,  2 Dec 2019 15:47:38 +0000
Message-Id: <20191202154738.56812-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 02 Dec 2019 21:48:53 +0000
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

RnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4KClRoZSB2YXJp
YWJsZSB2X3RvdGFsIGlzIGJlaW5nIGluaXRpYWxpemVkIHdpdGggYSB2YWx1ZSB0aGF0IGlzIG5l
dmVyCnJlYWQgYW5kIGl0IGlzIGJlaW5nIHVwZGF0ZWQgbGF0ZXIgd2l0aCBhIG5ldyB2YWx1ZS4g
IFRoZSBpbml0aWFsaXphdGlvbgppcyByZWR1bmRhbnQgYW5kIGNhbiBiZSByZW1vdmVkLgoKQWRk
cmVzc2VzLUNvdmVyaXR5OiAoIlVudXNlZCB2YWx1ZSIpClNpZ25lZC1vZmYtYnk6IENvbGluIElh
biBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L21vZHVsZXMvZnJlZXN5bmMvZnJlZXN5bmMuYyB8IDIgKy0KIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvZGlzcGxheS9tb2R1bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9mcmVlc3luYy9mcmVlc3luYy5jCmluZGV4IDE2
ZTY5YmJjNjlhYS4uZmE1Nzg4NTUwM2Q0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2Rpc3BsYXkvbW9kdWxlcy9mcmVlc3luYy9mcmVlc3luYy5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvZGlzcGxheS9tb2R1bGVzL2ZyZWVzeW5jL2ZyZWVzeW5jLmMKQEAgLTEyMiw3ICsxMjIs
NyBAQCBzdGF0aWMgdW5zaWduZWQgaW50IGNhbGNfdl90b3RhbF9mcm9tX3JlZnJlc2goCiAJCWNv
bnN0IHN0cnVjdCBkY19zdHJlYW1fc3RhdGUgKnN0cmVhbSwKIAkJdW5zaWduZWQgaW50IHJlZnJl
c2hfaW5fdWh6KQogewotCXVuc2lnbmVkIGludCB2X3RvdGFsID0gc3RyZWFtLT50aW1pbmcudl90
b3RhbDsKKwl1bnNpZ25lZCBpbnQgdl90b3RhbDsKIAl1bnNpZ25lZCBpbnQgZnJhbWVfZHVyYXRp
b25faW5fbnM7CiAKIAlmcmFtZV9kdXJhdGlvbl9pbl9ucyA9Ci0tIAoyLjI0LjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
