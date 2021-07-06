Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4607C07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9267A61DF1
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9267A61DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24F816E3C1;
	Tue,  6 Jul 2021 11:22:11 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80CC6E3C1;
 Tue,  6 Jul 2021 11:22:10 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B124161DF2;
 Tue,  6 Jul 2021 11:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570530;
 bh=0I6sraG7t8CfgmD4CJhp+GC2kCQuB1+mEYLSPFGqnhs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cxUit1XTti+l9VJm4q02FtuWggqPxswj/MCBzj08Oz8S0J1F3D9l8xwVa4YKyLgDW
 ih/mOz2QJbK5WkazB9cnxHxDD3X9s+uDbBPJQllrxAFecwJegl3OMhg10/VktoLmHA
 gJ8H5wy/MbQW4+bsBh5oPE941kWz/bbf9fNaHXv+LPHM/yBS+Mal07QOXoZMKsuLA7
 miJ0xkDGChuDUL9cbi/BSwbE+2/n32nJTd18lu6Z6qroIZkWnvJ2eqg0fvkMZNg5vo
 e0QhzjL0CyZxO16cykrkrOP5dIdBP4r8+VJV3Os0x+e+6Q+BIhUtA3KaB0Kh7bAdMx
 vWrNyZ3WRtjdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 005/137] drm/amd/display: fix HDCP reset sequence
 on reinitialize
Date: Tue,  6 Jul 2021 07:19:51 -0400
Message-Id: <20210706112203.2062605-5-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112203.2062605-1-sashal@kernel.org>
References: <20210706112203.2062605-1-sashal@kernel.org>
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
L2hkY3AuYwppbmRleCAyMGU1NTRlNzcxZDEuLmZhOGFlZWMzMDRlZiAxMDA2NDQKLS0tIGEvZHJp
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
