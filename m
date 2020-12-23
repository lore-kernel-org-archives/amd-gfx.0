Return-Path: <SRS0=7Usp=F3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A577AC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 02:17:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6963722202
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Dec 2020 02:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6963722202
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEAD86E8A3;
	Wed, 23 Dec 2020 02:17:11 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA68D6E897;
 Wed, 23 Dec 2020 02:17:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBD1823333;
 Wed, 23 Dec 2020 02:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608689823;
 bh=LzfZCtv9f0T68Y0kzTc6SDeo8zWnuF2OlmwvB5h+inQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mDz0f1VS2x9iEOee5G/OCqlgzMCCLGdiWZY8r8ITRMZa0V5g0afT81zCT8iQb2CPJ
 ijH2P4fNbwD4ciGRzBWma378UjVagg4SRN1kIhvfvAQfhwni1xPffclSchJs9Z+cEJ
 03uvmMmhKLJl7d8ho2Vh+ooo2CsrnmfDe2et/K/UPNZI3wdyOBCjDReTN0RQVtDemP
 J8auvBYf8IQ5HbuvR+E5aTp2HVQWeUMRp7TLsT9XZPBRrJk0tEK9wUBNm9OaYTbv4r
 7lZoYIue3GkHIyHNm9RXLFYXOrDMJkJkqr7U7EW0XlOR8FqGIP+FGCJNNpEHBT5FAy
 peezz2J72yvLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 028/217] drm/amdgpu: set LDS_CONFIG=0x20 on Navy
 Flounder to fix a GPU hang (v2)
Date: Tue, 22 Dec 2020 21:13:17 -0500
Message-Id: <20201223021626.2790791-28-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201223021626.2790791-1-sashal@kernel.org>
References: <20201223021626.2790791-1-sashal@kernel.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTWFyZWsgT2zFocOhayA8bWFyZWsub2xzYWtAYW1kLmNvbT4KClsgVXBzdHJlYW0gY29t
bWl0IDRiNjBiYjBkZGUxYmFmMzQ3NTQwMjUzZjg1NmM1NGJjOTA4ZTUyNWMgXQoKdjI6IHNxdWFz
aCBpbiBidWlsZCBmaXgKCkFja2VkLWJ5OiBBbGV4IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVy
QGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IE1hcmVrIE9sxaHDoWsgPG1hcmVrLm9sc2FrQGFtZC5j
b20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNv
bT4KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIHwgNSArKysrLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvZ2Z4X3YxMF8wLmMKaW5kZXggNTVmNGI4YzNiOTMzOC4uNjZiZGZiZGNkZjJiOCAxMDA2
NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMKQEAgLTMxODMsNyArMzE4MywxMCBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1X3JlZ19nb2xkZW4gZ29sZGVuX3NldHRpbmdzX2dj
XzEwXzNfMltdID0KIAlTT0MxNV9SRUdfR09MREVOX1ZBTFVFKEdDLCAwLCBtbVNRX1BFUkZDT1VO
VEVSOV9TRUxFQ1QsIDB4ZjBmMDAxZmYsIDB4MDAwMDAwMDApLAogCVNPQzE1X1JFR19HT0xERU5f
VkFMVUUoR0MsIDAsIG1tVEFfQ05UTF9BVVgsIDB4ZmZmN2ZmZmYsIDB4MDEwMzAwMDApLAogCVNP
QzE1X1JFR19HT0xERU5fVkFMVUUoR0MsIDAsIG1tVVRDTDFfQ1RSTCwgMHhmZmJmZmZmZiwgMHgw
MGEwMDAwMCksCi0JU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1WR1RfR1NfTUFYX1dB
VkVfSUQsIDB4MDAwMDBmZmYsIDB4MDAwMDAzZmYpCisJU09DMTVfUkVHX0dPTERFTl9WQUxVRShH
QywgMCwgbW1WR1RfR1NfTUFYX1dBVkVfSUQsIDB4MDAwMDBmZmYsIDB4MDAwMDAzZmYpLAorCisJ
LyogVGhpcyBpcyBub3QgaW4gR0RCIHlldC4gRG9uJ3QgcmVtb3ZlIGl0LiBJdCBmaXhlcyBhIEdQ
VSBoYW5nIG9uIE5hdnkgRmxvdW5kZXIuICovCisJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywg
MCwgbW1MRFNfQ09ORklHLCAgMHgwMDAwMDAyMCwgMHgwMDAwMDAyMCksCiB9OwogCiAjZGVmaW5l
IERFRkFVTFRfU0hfTUVNX0NPTkZJRyBcCi0tIAoyLjI3LjAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vYW1kLWdmeAo=
