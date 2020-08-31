Return-Path: <SRS0=7vr2=CJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E149CC433E7
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B91E7207EA
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2020 15:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IIcRWYKr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91E7207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4FA6E317;
	Mon, 31 Aug 2020 15:30:28 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB36E6E317;
 Mon, 31 Aug 2020 15:30:27 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9AEE3214D8;
 Mon, 31 Aug 2020 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598887827;
 bh=J6LyLE97LKjW1LwdUlkXO5WQuh0pOgwW+p/41/a3jWM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IIcRWYKryZFefF836oUBu2zazDLwtRwOtFowIfcoj+KeNZFAHfrrg+p6xzSbqUWSD
 LmpNY8JfFxZgrNqj54y2JtWEydnWkmMg9fi6N6PFSNU8VSykVGUJjTSfv/IMogUvV+
 18o9yleRNPe1Dl30NjGrFrxOmxGYRJ09Y+aaLGBQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 35/42] drivers: gpu: amd: Initialize
 amdgpu_dm_backlight_caps object to 0 in amdgpu_dm_update_backlight_caps
Date: Mon, 31 Aug 2020 11:29:27 -0400
Message-Id: <20200831152934.1023912-35-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831152934.1023912-1-sashal@kernel.org>
References: <20200831152934.1023912-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Furquan Shaikh <furquan@google.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRnVycXVhbiBTaGFpa2ggPGZ1cnF1YW5AZ29vZ2xlLmNvbT4KClsgVXBzdHJlYW0gY29t
bWl0IDU4OTY1ODU1MTJlNTE1NjQ4MjMzNWU5MDJmN2M3MzkzYjk0MGRhNTEgXQoKSW4gYGFtZGdw
dV9kbV91cGRhdGVfYmFja2xpZ2h0X2NhcHMoKWAsIHRoZXJlIGlzIGEgbG9jYWwKYGFtZGdwdV9k
bV9iYWNrbGlnaHRfY2Fwc2Agb2JqZWN0IHRoYXQgaXMgZmlsbGVkIGluIGJ5CmBhbWRncHVfYWNw
aV9nZXRfYmFja2xpZ2h0X2NhcHMoKWAuIEhvd2V2ZXIsIHRoaXMgb2JqZWN0IGlzCnVuaW5pdGlh
bGl6ZWQgYmVmb3JlIHRoZSBjYWxsIGFuZCBoZW5jZSB0aGUgc3Vic2VxdWVudCBjaGVjayBmb3IK
YXV4X3N1cHBvcnQgY2FuIGZhaWwgc2luY2UgaXQgaXMgbm90IGluaXRpYWxpemVkIGJ5CmBhbWRn
cHVfYWNwaV9nZXRfYmFja2xpZ2h0X2NhcHMoKWAgYXMgd2VsbC4gVGhpcyBjaGFuZ2UgaW5pdGlh
bGl6ZXMKdGhpcyBsb2NhbCBgYW1kZ3B1X2RtX2JhY2tsaWdodF9jYXBzYCBvYmplY3QgdG8gMC4K
ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
ClNpZ25lZC1vZmYtYnk6IEZ1cnF1YW4gU2hhaWtoIDxmdXJxdWFuQGdvb2dsZS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVk
LW9mZi1ieTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAyICsrCiAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKaW5kZXggMGEzOWE4NTU4YjI5NC4uMDY4MmZkMzYzY2I1
MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRn
cHVfZG0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdw
dV9kbS5jCkBAIC0yODQ0LDYgKzI4NDQsOCBAQCBzdGF0aWMgdm9pZCBhbWRncHVfZG1fdXBkYXRl
X2JhY2tsaWdodF9jYXBzKHN0cnVjdCBhbWRncHVfZGlzcGxheV9tYW5hZ2VyICpkbSkKICNpZiBk
ZWZpbmVkKENPTkZJR19BQ1BJKQogCXN0cnVjdCBhbWRncHVfZG1fYmFja2xpZ2h0X2NhcHMgY2Fw
czsKIAorCW1lbXNldCgmY2FwcywgMCwgc2l6ZW9mKGNhcHMpKTsKKwogCWlmIChkbS0+YmFja2xp
Z2h0X2NhcHMuY2Fwc192YWxpZCkKIAkJcmV0dXJuOwogCi0tIAoyLjI1LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
