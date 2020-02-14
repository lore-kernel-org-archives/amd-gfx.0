Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE65C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:59:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D963F24694
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 15:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N55R61FD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D963F24694
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D1E66FA10;
	Fri, 14 Feb 2020 15:59:34 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 855256FA0E;
 Fri, 14 Feb 2020 15:59:32 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 109C42067D;
 Fri, 14 Feb 2020 15:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581695972;
 bh=lbb8p6MEsHz1aytgvvoCCNt4UaPulBkyaxqYhVkjEcA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N55R61FDX7kuwoFuD+5HN74Gj0Xxgtf2n0OKpvMBXWBVPNc9VjGr0rG0ppIxiDxLM
 zuLdtVuE5RDBcHMXpPrEAHMXOWCr6s6WdN9FypQdI1gpdSw5fNOkvfK1ILsxAvJ7+3
 shNJ/1mH52QP/ZyklTw9lg3miTGGsP9D/ABMkBxw=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 499/542] radeon: insert 10ms sleep in
 dce5_crtc_load_lut
Date: Fri, 14 Feb 2020 10:48:11 -0500
Message-Id: <20200214154854.6746-499-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel.daenzer@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5jaD4KClsgVXBzdHJlYW0g
Y29tbWl0IGVjM2Q2NTA4MmQ3ZGFiYWQ2ZmE4ZjY2YThlZjE2NmYyZDUyMmQ2YjIgXQoKUGVyIGF0
IGxlYXN0IG9uZSB0ZXN0ZXIgdGhpcyBpcyBlbm91Z2ggbWFnaWMgdG8gcmVjb3ZlciB0aGUgcmVn
cmVzc2lvbgppbnRyb2R1Y2VkIGZvciBzb21lIHBlb3BsZSAoYnV0IG5vdCBhbGwpIGluCgpjb21t
aXQgYjhlMmIwMTk5Y2MzNzc2MTdkYzIzOGY1MTA2MzUyYzA2ZGNkM2ZhMgpBdXRob3I6IFBldGVy
IFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+CkRhdGU6ICAgVHVlIEp1bCA0IDEyOjM2OjU3IDIwMTcg
KzAyMDAKCiAgICBkcm0vZmItaGVscGVyOiBmYWN0b3Igb3V0IHBzZXVkby1wYWxldHRlCgp3aGlj
aCBmb3IgcmFkZW9uIGhhZCB0aGUgc2lkZS1lZmZlY3Qgb2YgcmVmYWN0b3Jpbmcgb3V0IGEgc2Vl
bWluZ2x5CnJlZHVkYW50IHdyaXRpbmcgb2YgdGhlIGNvbG9yIHBhbGV0dGUuCgoxMG1zIGluIGEg
ZmFpcmx5IHNsb3cgbW9kZXNldCBwYXRoIGZlZWxzIGxpa2UgYW4gYWNjZXB0YWJsZSBmb3JtIG9m
CmR1Y3QtdGFwZSwgc28gbWF5YmUgd29ydGggYSBzaG90IGFuZCBzZWUgd2hhdCBzdGlja3MuCgpD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogTWljaGVsIETD
pG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+ClJlZmVyZW5jZXM6IGh0dHBzOi8vYnVnemls
bGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTk4MTIzClNpZ25lZC1vZmYtYnk6IERhbmll
bCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAaW50ZWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4IERl
dWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExl
dmluIDxzYXNoYWxAa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVv
bl9kaXNwbGF5LmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JhZGVvbi9yYWRlb25fZGlzcGxheS5jCmluZGV4IDg0ZDNkODg1YjdhNDYuLjYw
Njk3MmM0NTkzYWEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9yYWRlb24vcmFkZW9uX2Rp
c3BsYXkuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vcmFkZW9uL3JhZGVvbl9kaXNwbGF5LmMKQEAg
LTEyNyw2ICsxMjcsOCBAQCBzdGF0aWMgdm9pZCBkY2U1X2NydGNfbG9hZF9sdXQoc3RydWN0IGRy
bV9jcnRjICpjcnRjKQogCiAJRFJNX0RFQlVHX0tNUygiJWRcbiIsIHJhZGVvbl9jcnRjLT5jcnRj
X2lkKTsKIAorCW1zbGVlcCgxMCk7CisKIAlXUkVHMzIoTklfSU5QVVRfQ1NDX0NPTlRST0wgKyBy
YWRlb25fY3J0Yy0+Y3J0Y19vZmZzZXQsCiAJICAgICAgIChOSV9JTlBVVF9DU0NfR1JQSF9NT0RF
KE5JX0lOUFVUX0NTQ19CWVBBU1MpIHwKIAkJTklfSU5QVVRfQ1NDX09WTF9NT0RFKE5JX0lOUFVU
X0NTQ19CWVBBU1MpKSk7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
