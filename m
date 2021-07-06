Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8407FC07E9B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:14:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577DD61C2B
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577DD61C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F75389F45;
	Tue,  6 Jul 2021 11:14:19 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2923389F45;
 Tue,  6 Jul 2021 11:14:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 428EF61C22;
 Tue,  6 Jul 2021 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570057;
 bh=h50X7yqGEaTpjIyoJe/7TnUg0U13htKsKuz+qBmIFpA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ON95brRS3O4EAnbRMCfYK5Vl/SAy7HpLGPyMjd6LIIeg2pAjXsNI/bpFlV1+pNlNb
 OfeS2yT3MjDFVu0IPLWWad1h24J8f1sFU9oSHLymYp3OsK6G12KcqphK54Tjt7v+eJ
 p4bEoWyc4Dg30Sz1sO1TXgvtVUI1C4jJTDVgMc0NggmRqnlrB56XLR0nba6H9upEcb
 xTk8lCyEL0rj+UrbLifZSIL2vK8K3mdWGywF065wKvpviqtaqacoSN9iAGqvW+L7+A
 vRW68YxYljlSfU5J4uEpClhc+X/Qwh1SH+aJAkr9ny7KuagVf8xDqVcP7AAzUz5mU0
 iNCh8MjC8TfjA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 005/189] drm/amd/display: fix HDCP reset sequence
 on reinitialize
Date: Tue,  6 Jul 2021 07:11:05 -0400
Message-Id: <20210706111409.2058071-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Wenjing Liu <Wenjing.Liu@amd.com>,
 amd-gfx@lists.freedesktop.org, Daniel Wheeler <daniel.wheeler@amd.com>,
 Brandon Syu <Brandon.Syu@amd.com>, Wayne Lin <waynelin@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQnJhbmRvbiBTeXUgPEJyYW5kb24uU3l1QGFtZC5jb20+CgpbIFVwc3RyZWFtIGNvbW1p
dCA5OWMyNDhjNDFjMjE5OWJkMzQyMzJjZThlNzI5ZDE4YzRiMzQzYjY0IF0KClt3aHldCldoZW4g
c2V0dXAgaXMgY2FsbGVkIGFmdGVyIGhkY3AgaGFzIGFscmVhZHkgc2V0dXAsCml0IHdvdWxkIGNh
dXNlIHRvIGRpc2FibGUgSERDUCBmbG93IHdvbuKAmXQgZXhlY3V0ZS4KCltob3ddCkRvbid0IGNs
ZWFuIHVwIGhkY3AgY29udGVudCB0byBiZSAwLgoKU2lnbmVkLW9mZi1ieTogQnJhbmRvbiBTeXUg
PEJyYW5kb24uU3l1QGFtZC5jb20+ClJldmlld2VkLWJ5OiBXZW5qaW5nIExpdSA8V2VuamluZy5M
aXVAYW1kLmNvbT4KQWNrZWQtYnk6IFdheW5lIExpbiA8d2F5bmVsaW5AYW1kLmNvbT4KVGVzdGVk
LWJ5OiBEYW5pZWwgV2hlZWxlciA8ZGFuaWVsLndoZWVsZXJAYW1kLmNvbT4KU2lnbmVkLW9mZi1i
eTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5
OiBTYXNoYSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwLmMgfCAxIC0KIDEgZmlsZSBjaGFuZ2VkLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVs
ZXMvaGRjcC9oZGNwLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9oZGNw
L2hkY3AuYwppbmRleCA2OGE2NDgxZDdmOGYuLmI5NjMyMjZlOGFmNCAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwLmMKKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMvaGRjcC9oZGNwLmMKQEAgLTI2MCw3ICsyNjAs
NiBAQCBlbnVtIG1vZF9oZGNwX3N0YXR1cyBtb2RfaGRjcF9zZXR1cChzdHJ1Y3QgbW9kX2hkY3Ag
KmhkY3AsCiAJc3RydWN0IG1vZF9oZGNwX291dHB1dCBvdXRwdXQ7CiAJZW51bSBtb2RfaGRjcF9z
dGF0dXMgc3RhdHVzID0gTU9EX0hEQ1BfU1RBVFVTX1NVQ0NFU1M7CiAKLQltZW1zZXQoaGRjcCwg
MCwgc2l6ZW9mKHN0cnVjdCBtb2RfaGRjcCkpOwogCW1lbXNldCgmb3V0cHV0LCAwLCBzaXplb2Yo
b3V0cHV0KSk7CiAJaGRjcC0+Y29uZmlnID0gKmNvbmZpZzsKIAlIRENQX1RPUF9JTlRFUkZBQ0Vf
VFJBQ0UoaGRjcCk7Ci0tIAoyLjMwLjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
