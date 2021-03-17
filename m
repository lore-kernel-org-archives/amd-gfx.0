Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542BEC4361B
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 00:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E09C64FB4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 00:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E09C64FB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948CF6E489;
	Wed, 17 Mar 2021 00:58:40 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E749C6E489;
 Wed, 17 Mar 2021 00:58:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11F6364FF4;
 Wed, 17 Mar 2021 00:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942718;
 bh=M0Yxxg9pKy4Ew+My0qn2D8Jeghgx0EHiZjXlgpr5U44=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O0MHrHwb9Q2ER+PTht6VMXBmel8ImRmjKcSqDuUnbvGuu+lSY3MjkJwNJXApRnwwV
 DAcM7w0Lg6sm5eF47/ESpHnxILCh/ki1up56x4+vALRt/kUWyovFYRUADfdvuWzetG
 PSmk6EDWkxmGIcv2lG8gWJFeYT0v/3tC4CbblRAQWvw7Munt3gUwK1AMe1gbWh0kt2
 q9F2vUFkT//v2sBHstEoULbXSRRH+DzNcVORP93ktNoNDEa2vg8s6wOrmZe3VJkGGi
 Hks9a0UNrJdF/JYvzBhI0h2MYfJhQIaAfZ/Q7sVbSKO3Pe3JebXVyBNBIx1M4RaAeH
 Vhj3sXyPxC3GQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 29/37] drm/amdgpu: fb BO should be
 ttm_bo_type_device
Date: Tue, 16 Mar 2021 20:57:54 -0400
Message-Id: <20210317005802.725825-29-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005802.725825-1-sashal@kernel.org>
References: <20210317005802.725825-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, dri-devel@lists.freedesktop.org,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTmlybW95IERhcyA8bmlybW95LmRhc0BhbWQuY29tPgoKWyBVcHN0cmVhbSBjb21taXQg
NTIxZjA0ZjllM2ZmYzczZWY5NmM3NzYwMzVmOGEwYTMxYjRjZGQ4MSBdCgpGQiBCTyBzaG91bGQg
bm90IGJlIHR0bV9ib190eXBlX2tlcm5lbCB0eXBlIGFuZAphbWRncHVmYl9jcmVhdGVfcGlubmVk
X29iamVjdCgpIHBpbnMgdGhlIEZCIEJPIGFueXdheS4KClNpZ25lZC1vZmYtYnk6IE5pcm1veSBE
YXMgPG5pcm1veS5kYXNAYW1kLmNvbT4KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlz
dGlhbi5rb2VuaWdAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5k
ZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtl
cm5lbC5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2ZiLmMgfCAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9mYi5jCmluZGV4IGVhYTVlN2I3YzE5ZC4uZmQ5NGEx
N2ZiMmM2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIu
YworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZmIuYwpAQCAtMTQ2LDcg
KzE0Niw3IEBAIHN0YXRpYyBpbnQgYW1kZ3B1ZmJfY3JlYXRlX3Bpbm5lZF9vYmplY3Qoc3RydWN0
IGFtZGdwdV9mYmRldiAqcmZiZGV2LAogCXNpemUgPSBtb2RlX2NtZC0+cGl0Y2hlc1swXSAqIGhl
aWdodDsKIAlhbGlnbmVkX3NpemUgPSBBTElHTihzaXplLCBQQUdFX1NJWkUpOwogCXJldCA9IGFt
ZGdwdV9nZW1fb2JqZWN0X2NyZWF0ZShhZGV2LCBhbGlnbmVkX3NpemUsIDAsIGRvbWFpbiwgZmxh
Z3MsCi0JCQkJICAgICAgIHR0bV9ib190eXBlX2tlcm5lbCwgTlVMTCwgJmdvYmopOworCQkJCSAg
ICAgICB0dG1fYm9fdHlwZV9kZXZpY2UsIE5VTEwsICZnb2JqKTsKIAlpZiAocmV0KSB7CiAJCXBy
X2VycigiZmFpbGVkIHRvIGFsbG9jYXRlIGZyYW1lYnVmZmVyICglZClcbiIsIGFsaWduZWRfc2l6
ZSk7CiAJCXJldHVybiAtRU5PTUVNOwotLSAKMi4zMC4xCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2FtZC1nZngK
