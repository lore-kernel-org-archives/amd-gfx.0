Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC08C432C0
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 14:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0289A20656
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 14:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0289A20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFCF96E40D;
	Tue, 26 Nov 2019 14:47:00 +0000 (UTC)
X-Greylist: delayed 58533 seconds by postgrey-1.36 at gabe;
 Tue, 26 Nov 2019 14:46:59 UTC
Received: from mac1807s-mbp.amd.com (unknown [165.204.55.250])
 by gabe.freedesktop.org (Postfix) with ESMTP id AF2176E40D
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 14:46:59 +0000 (UTC)
Received: by mac1807s-mbp.amd.com (Postfix, from userid 501)
 id EA1E2E39238; Mon, 25 Nov 2019 17:31:25 -0500 (EST)
From: Zhan liu <zhan.liu@amd.com>
To: amd-gfx@lists.freedesktop.org,
	zhan.liu@amd.com
Subject: [PATCH v2] drm/amd/display: Modify comments to match the code
Date: Mon, 25 Nov 2019 17:31:23 -0500
Message-Id: <20191125223123.51204-1-zhan.liu@amd.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125223123.MIHKJeRPmvmgnD-WFako6d24R2EXPvu777Ay3LQAqho@z>

W1doeV0KVGhpcyBsaW5lIG9mIGNvZGUgd2FzIG1vZGlmaWVkLiBIb3dldmVyLCBjb21tZW50cwpy
ZW1haW5lZCB1bmNoYW5nZWQuIEFzIGEgcmVzdWx0LCBjb21tZW50cyBhbmQgY29kZSBhcmUKbWlz
bWF0Y2hpbmcuCgpbSG93XQpNb2RpZnlpbmcgY29tbWVudHMgdG8gcmVmbGVjdCBjb2RlLiBBdCB0
aGUgc2FtZSB0aW1lLApleHBsYWluaW5nIHdoeSB0aGUgdmFsdWUgd2FzIGNoYW5nZWQgZnJvbSAy
MDBtcyB0bwozMDAwbXMuCgpTaWduZWQtb2ZmLWJ5OiBaaGFuIExpdSA8emhhbi5saXVAYW1kLmNv
bT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfaGVscGVyLmMgfCA3ICsr
KysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfaGVscGVyLmMgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNfaGVscGVyLmMKaW5kZXggOGRhNDU3NmUy
OTA4Li5lNDFiZWZhMDY3Y2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9kYy9kY19oZWxwZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNf
aGVscGVyLmMKQEAgLTQ4NSw3ICs0ODUsMTIgQEAgdm9pZCBnZW5lcmljX3JlZ193YWl0KGNvbnN0
IHN0cnVjdCBkY19jb250ZXh0ICpjdHgsCiAJCXJldHVybjsKIAl9CiAKLQkvKiBzb21ldGhpbmcg
aXMgdGVycmlibHkgd3JvbmcgaWYgdGltZSBvdXQgaXMgPiAyMDBtcy4gKDVIeikgKi8KKwkvKgor
CSAqIFNvbWV0aGluZyBpcyB0ZXJyaWJseSB3cm9uZyBpZiB0aW1lIG91dCBpcyA+IDMwMDBtcy4K
KwkgKiAzMDAwbXMgaXMgdGhlIG1heGltdW0gdGltZSBuZWVkZWQgZm9yIFNNVSB0byBwYXNzIHZh
bHVlcyBiYWNrLgorCSAqIFRoaXMgdmFsdWUgY29tZXMgZnJvbSBleHBlcmltZW50cy4KKwkgKgor
CSAqLwogCUFTU0VSVChkZWxheV9iZXR3ZWVuX3BvbGxfdXMgKiB0aW1lX291dF9udW1fdHJpZXMg
PD0gMzAwMDAwMCk7CiAKIAlmb3IgKGkgPSAwOyBpIDw9IHRpbWVfb3V0X251bV90cmllczsgaSsr
KSB7Ci0tIAoyLjIxLjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
