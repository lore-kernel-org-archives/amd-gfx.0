Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51A2C43460
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 08:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61B5760241
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 08:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B5760241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 528D36ECDD;
	Wed, 19 May 2021 08:15:49 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A526ECD9;
 Wed, 19 May 2021 08:15:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DC0960241;
 Wed, 19 May 2021 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621412147;
 bh=TLTO07eCdq1orhOlOSYmgcvo49avpBaMddvAcag1RYk=;
 h=From:To:Cc:Subject:Date:From;
 b=lWKraVSXpxYlHZQ9F1B2jPEMuPOOJAyH26Z10nwEaNkhUxnDEkZn1hCYQoZnYsjbm
 3GzWv1gStcX1+E7nZ+HAo1c9BMXYSGGskS3lYu3sK1VaXPFYcHsRSxwCetmupwLhsb
 htKAtrp2YhOktI+8gPSlUmojlSiPQcG+RLNCf+QWc3UCDK4rPPQa5umgCpAhUIVC+q
 UYNcV2fIGZ5xt1uCS+8jvRnaW3dubw8VGIIPNZN1Npq1G01AmuikLWZyeMCyhOSRnI
 nrWwopAuuBwP+aGeOkcfm4pBKrMPMlgCJIbwmfbWaqpoQI9k0s5RNX3Tnmbf+Ppzaw
 XBP0qfGxzqyIw==
Received: by mail.kernel.org with local (Exim 4.94.2)
 (envelope-from <mchehab@kernel.org>)
 id 1ljHMm-007fB7-Uo; Wed, 19 May 2021 10:15:44 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: David Airlie <airlied@linux.ie>
Subject: [PATCH 1/3] gpu: drm: replace occurrences of invalid character
Date: Wed, 19 May 2021 10:15:35 +0200
Message-Id: <e606930c73029f16673849c57acac061dd923866.1621412009.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
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
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 dri-devel@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Chris Wilson <chris@chris-wilson.co.uk>, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 intel-gfx@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlcmUgYXJlIHNvbWUgcGxhY2VzIGF0IGRybSB0aGF0IGVuZGVkIHJlY2VpdmluZyBhClJFUExB
Q0VNRU5UIENIQVJBQ1RFUiBVK2ZmZmQgKCfvv70nKSwgcHJvYmFibHkgYmVjYXVzZSBvZgpzb21l
IGJhZCBjaGFyc2V0IGNvbnZlcnNpb24uCgpGaXggdGhlbSBieSB1c2luZyB3aGF0IGl0IHNlZW1z
CXRvIGJlIHRoZSBwcm9wZXIKY2hhcmFjdGVyLgoKU2lnbmVkLW9mZi1ieTogTWF1cm8gQ2FydmFs
aG8gQ2hlaGFiIDxtY2hlaGFiK2h1YXdlaUBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS9hbWQvaW5jbHVkZS9hdG9tYmlvcy5oICAgICAgIHwgMTAgKysrKystLS0tLQogZHJpdmVycy9n
cHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3B1X2NvbW1hbmRzLmggfCAgMiArLQogZHJpdmVycy9ncHUv
ZHJtL2k5MTUvaTkxNV9ncHVfZXJyb3IuaCAgICAgICAgfCAgMiArLQogZHJpdmVycy9ncHUvZHJt
L3IxMjgvcjEyOF9kcnYuaCAgICAgICAgICAgICAgfCAgMiArLQogNCBmaWxlcyBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL2FtZC9pbmNsdWRlL2F0b21iaW9zLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUv
YXRvbWJpb3MuaAppbmRleCA0N2ViODQ1OThiOTYuLjZhNTA1ZDFiODJhNSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2F0b21iaW9zLmgKKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9pbmNsdWRlL2F0b21iaW9zLmgKQEAgLTUxNzgsMTEgKzUxNzgsMTEgQEAgdHlwZWRl
ZiBzdHJ1Y3QgIF9BVE9NX0xFQUtBR0VfVk9MVEFHRV9PQkpFQ1RfVjMKIHR5cGVkZWYgc3RydWN0
ICBfQVRPTV9TVklEMl9WT0xUQUdFX09CSkVDVF9WMwogewogICAgQVRPTV9WT0xUQUdFX09CSkVD
VF9IRUFERVJfVjMgc0hlYWRlcjsgICAgLy8gdm9sdGFnZSBtb2RlID0gVk9MVEFHRV9PQkpfU1ZJ
RDIKLS8vIDE0Ojcg77+9IFBTSTBfVklECi0vLyA2IO+/vSBQU0kwX0VOCi0vLyA1IO+/vSBQU0kx
Ci0vLyA0OjIg77+9IGxvYWQgbGluZSBzbG9wZSB0cmltLgotLy8gMTowIO+/vSBvZmZzZXQgdHJp
bSwKKy8vIDE0OjcgLSBQU0kwX1ZJRAorLy8gNiAtIFBTSTBfRU4KKy8vIDUgLSBQU0kxCisvLyA0
OjIgLSBsb2FkIGxpbmUgc2xvcGUgdHJpbS4KKy8vIDE6MCAtIG9mZnNldCB0cmltLAogICAgVVNI
T1JUICAgdXNMb2FkTGluZV9QU0k7CiAvLyBHUFUgR1BJTyBwaW4gSWQgdG8gU1ZJRDIgcmVndWxh
dG9yIFZSSG90IHBpbi4gcG9zc2libGUgdmFsdWUgMH4zMS4gMCBtZWFucyBHUElPMCwgMzEgbWVh
bnMgR1BJTzMxCiAgICBVQ0hBUiAgICB1Y1NWREdwaW9JZDsgICAgIC8vMH4zMSBpbmRpY2F0ZSBH
UElPMH4zMQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3QvaW50ZWxfZ3B1X2Nv
bW1hbmRzLmggYi9kcml2ZXJzL2dwdS9kcm0vaTkxNS9ndC9pbnRlbF9ncHVfY29tbWFuZHMuaApp
bmRleCAxNGUyZmZiNmMwZTUuLjI2OTRkYmI5OTY3ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2k5MTUvZ3QvaW50ZWxfZ3B1X2NvbW1hbmRzLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2k5
MTUvZ3QvaW50ZWxfZ3B1X2NvbW1hbmRzLmgKQEAgLTEsNiArMSw2IEBACiAvKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogTUlUKi8KIC8qCi0gKiBDb3B5cmlnaHQg77+9IDIwMDMtMjAxOCBJbnRl
bCBDb3Jwb3JhdGlvbgorICogQ29weXJpZ2h0IMKpIDIwMDMtMjAxOCBJbnRlbCBDb3Jwb3JhdGlv
bgogICovCiAKICNpZm5kZWYgX0lOVEVMX0dQVV9DT01NQU5EU19IXwpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2k5MTUvaTkxNV9ncHVfZXJyb3IuaCBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1
L2k5MTVfZ3B1X2Vycm9yLmgKaW5kZXggMTZiYzQyZGU0Yjg0Li40ZGYyNGM3MzdlMTMgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfZ3B1X2Vycm9yLmgKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2k5MTUvaTkxNV9ncHVfZXJyb3IuaApAQCAtMSw3ICsxLDcgQEAKIC8qCiAgKiBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTUlUCiAgKgotICogQ29weXJpZ2h0IO+/vSAyMDA4LTIw
MTggSW50ZWwgQ29ycG9yYXRpb24KKyAqIENvcHlyaWdodCDCqSAyMDA4LTIwMTggSW50ZWwgQ29y
cG9yYXRpb24KICAqLwogCiAjaWZuZGVmIF9JOTE1X0dQVV9FUlJPUl9IXwpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL3IxMjgvcjEyOF9kcnYuaCBiL2RyaXZlcnMvZ3B1L2RybS9yMTI4L3Ix
MjhfZHJ2LmgKaW5kZXggOGIyNTYxMjNjZjJiLi5jNGQwZTIxMjgwYjkgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9yMTI4L3IxMjhfZHJ2LmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL3IxMjgv
cjEyOF9kcnYuaApAQCAtMjksNyArMjksNyBAQAogICogICAgUmlja2FyZCBFLiAoUmlrKSBGYWl0
aCA8ZmFpdGhAdmFsaW51eC5jb20+CiAgKiAgICBLZXZpbiBFLiBNYXJ0aW4gPG1hcnRpbkB2YWxp
bnV4LmNvbT4KICAqICAgIEdhcmV0aCBIdWdoZXMgPGdhcmV0aEB2YWxpbnV4LmNvbT4KLSAqICAg
IE1pY2hlbCBE77+9emVyIDxkYWVuemVybUBzdHVkZW50LmV0aHouY2g+CisgKiAgICBNaWNoZWwg
RMOkemVyIDxkYWVuemVybUBzdHVkZW50LmV0aHouY2g+CiAgKi8KIAogI2lmbmRlZiBfX1IxMjhf
RFJWX0hfXwotLSAKMi4zMS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
