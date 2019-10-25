Return-Path: <SRS0=YLFm=YS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B964CA9EA0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 11:04:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4429B21D71
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2019 11:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4429B21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BB946E97C;
	Fri, 25 Oct 2019 11:04:58 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3AB76E97C;
 Fri, 25 Oct 2019 11:04:56 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ADAA22084C;
 Fri, 25 Oct 2019 11:04:54 +0000 (UTC)
From: Will Deacon <will@kernel.org>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: Handle workqueue allocation failure
Date: Fri, 25 Oct 2019 12:04:50 +0100
Message-Id: <20191025110450.10474-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=default; t=1572001496;
 bh=dTvtN9K5VEVzsh5mbQEjeAPvD4c+mAT/a6OOuXXWhuM=;
 h=From:To:Cc:Subject:Date:From;
 b=BVV0Rmltbeu4aGw3zh74OGXjep5lC57B1P3op2QeC2oM1re3T+jy0T28GaFe2vliS
 QxCxb73SjIwdbUAoph5Yz+ty4KaXWOcibel5t3dvpZqYeiqPESBDJMk6cn7CLfWZRr
 EMKZ+2Bqgui5g+/0q7PW14MYUflLbl5wgPE4wVd0=
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
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Nicolas Waisman <nico@semmle.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Will Deacon <will@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191025110450.msr5zOMrkkIyVRoRI9WJcZUFHFv3GJWHHB49E2uSq2A@z>

SW4gdGhlIGhpZ2hseSB1bmxpa2VseSBldmVudCB0aGF0IHdlIGZhaWwgdG8gYWxsb2NhdGUgdGhl
ICJyYWRlb24tY3J0YyIKd29ya3F1ZXVlLCB3ZSBzaG91bGQgYmFpbCBjbGVhbmx5IHJhdGhlciB0
aGFuIGJsaW5kbHkgbWFyY2ggb24gd2l0aCBhCk5VTEwgcG9pbnRlciBpbnN0YWxsZWQgZm9yIHRo
ZSAnZmxpcF9xdWV1ZScgZmllbGQgb2YgdGhlICdyYWRlb25fY3J0YycKc3RydWN0dXJlLgoKVGhp
cyB3YXMgcmVwb3J0ZWQgcHJldmlvdXNseSBieSBOaWNvbGFzLCBidXQgSSBkb24ndCB0aGluayBo
aXMgZml4IHdhcwpjb3JyZWN0OgoKQ2M6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJA
YW1kLmNvbT4KQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgpDYzogIkRhdmlkIChDaHVuTWluZykgWmhvdSIgPERhdmlkMS5aaG91QGFtZC5jb20+CkNjOiBE
YXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+CkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+ClJlcG9ydGVkLWJ5OiBOaWNvbGFzIFdhaXNtYW4gPG5pY29Ac2VtbWxlLmNvbT4K
TGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9DQURKXzNhOFdGcnM1Tm91WE5xUzVX
WWU3cmViRlArX0E1Q2hlZXFBeURfcDdERkpKY2dAbWFpbC5nbWFpbC5jb20vClNpZ25lZC1vZmYt
Ynk6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+Ci0tLQoKQ29tcGlsZS10ZXN0ZWQgb25s
eS4KCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMgfCAxMCArKysrKysr
KystCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jCmluZGV4IGU4MWIwMWY4ZGI5MC4uM2U0
ZWYxMzgwZmNhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNw
bGF5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jCkBAIC02
NzIsMTcgKzY3MiwyNSBAQCBzdGF0aWMgdm9pZCByYWRlb25fY3J0Y19pbml0KHN0cnVjdCBkcm1f
ZGV2aWNlICpkZXYsIGludCBpbmRleCkKIHsKIAlzdHJ1Y3QgcmFkZW9uX2RldmljZSAqcmRldiA9
IGRldi0+ZGV2X3ByaXZhdGU7CiAJc3RydWN0IHJhZGVvbl9jcnRjICpyYWRlb25fY3J0YzsKKwlz
dHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqd3E7CiAJaW50IGk7CiAKIAlyYWRlb25fY3J0YyA9IGt6
YWxsb2Moc2l6ZW9mKHN0cnVjdCByYWRlb25fY3J0YykgKyAoUkFERU9ORkJfQ09OTl9MSU1JVCAq
IHNpemVvZihzdHJ1Y3QgZHJtX2Nvbm5lY3RvciAqKSksIEdGUF9LRVJORUwpOwogCWlmIChyYWRl
b25fY3J0YyA9PSBOVUxMKQogCQlyZXR1cm47CiAKKwl3cSA9IGFsbG9jX3dvcmtxdWV1ZSgicmFk
ZW9uLWNydGMiLCBXUV9ISUdIUFJJLCAwKTsKKwlpZiAodW5saWtlbHkoIXdxKSkgeworCQlrZnJl
ZShyYWRlb25fY3J0Yyk7CisJCXJldHVybjsKKwl9CisKIAlkcm1fY3J0Y19pbml0KGRldiwgJnJh
ZGVvbl9jcnRjLT5iYXNlLCAmcmFkZW9uX2NydGNfZnVuY3MpOwogCiAJZHJtX21vZGVfY3J0Y19z
ZXRfZ2FtbWFfc2l6ZSgmcmFkZW9uX2NydGMtPmJhc2UsIDI1Nik7CiAJcmFkZW9uX2NydGMtPmNy
dGNfaWQgPSBpbmRleDsKLQlyYWRlb25fY3J0Yy0+ZmxpcF9xdWV1ZSA9IGFsbG9jX3dvcmtxdWV1
ZSgicmFkZW9uLWNydGMiLCBXUV9ISUdIUFJJLCAwKTsKKwlyYWRlb25fY3J0Yy0+ZmxpcF9xdWV1
ZSA9IHdxOworCiAJcmRldi0+bW9kZV9pbmZvLmNydGNzW2luZGV4XSA9IHJhZGVvbl9jcnRjOwog
CiAJaWYgKHJkZXYtPmZhbWlseSA+PSBDSElQX0JPTkFJUkUpIHsKLS0gCjIuMjQuMC5yYzAuMzAz
Lmc5NTRhODYyNjY1LWdvb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdm
eA==
