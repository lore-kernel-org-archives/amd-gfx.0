Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07749C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D626620842
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 23:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnpxaVDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D626620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F886E9B1;
	Mon,  8 Jun 2020 23:17:40 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671876E9AF;
 Mon,  8 Jun 2020 23:17:39 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5D9F72083E;
 Mon,  8 Jun 2020 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591658259;
 bh=/5gUvaIeXL5/SvAcmLxJzXgwL0RfqCvuytXsSmHeWtk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nnpxaVDI8t8x9HkBOcgXjwdS1l3q5i8Q9NPknluWuTbsIBjRXdJY95Ft5u0kXXUFL
 KIgJE12gYE8DnFj1x8cZVd8MKD7uoWvv937v77yWe6Yem/MLYJ6TOaS8OFPpIWdXQ1
 YIc2AYNL68+z9yGNeQcK0nm2nuSREyRu/3Jk2wOU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 267/606] drm/amdgpu: Use GEM obj reference for KFD
 BOs
Date: Mon,  8 Jun 2020 19:06:32 -0400
Message-Id: <20200608231211.3363633-267-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
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
Cc: Alex Sierra <alex.sierra@amd.com>, Sasha Levin <sashal@kernel.org>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogRmVsaXggS3VlaGxpbmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CgpbIFVwc3RyZWFt
IGNvbW1pdCAzOWIzMTI4ZDdmZmQ0NGU0MDBlNTgxZTZmNDllODhjYjQyYmVmOWExIF0KClJlbGVh
c2luZyB0aGUgQU1ER1BVIEJPIHJlZiBkaXJlY3RseSBsZWFkcyB0byBwcm9ibGVtcyB3aGVuIEJP
cyB3ZXJlCmV4cG9ydGVkIGFzIERNQSBidWZzLiBSZWxlYXNpbmcgdGhlIEdFTSByZWZlcmVuY2Ug
bWFrZXMgc3VyZSB0aGF0IHRoZQpBTURHUFUvVFRNIEJPIGlzIG5vdCBmcmVlZCB0b28gZWFybHku
CgpBbHNvIHRha2UgYSBHRU0gcmVmZXJlbmNlIHdoZW4gaW1wb3J0aW5nIEJPcyBmcm9tIERNQUJ1
ZnMgdG8ga2VlcApyZWZlcmVuY2VzIHRvIGltcG9ydGVkIEJPcyBiYWxhbmNlcyBwcm9wZXJseS4K
ClNpZ25lZC1vZmYtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpU
ZXN0ZWQtYnk6IEFsZXggU2llcnJhIDxhbGV4LnNpZXJyYUBhbWQuY29tPgpBY2tlZC1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxl
eCBTaWVycmEgPGFsZXguc2llcnJhQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4g
PHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9hbWRrZmRfZ3B1dm0uYyB8IDUgKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2FtZGtmZF9ncHV2bS5jCmluZGV4IGZhOGFjOWQxOWE3YS4uNjMyNmMxNzkyMjcwIDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkX2dwdXZtLmMK
KysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZF9ncHV2bS5jCkBA
IC0xMzA0LDcgKzEzMDQsNyBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9v
Zl9ncHUoCiAJfQogCiAJLyogRnJlZSB0aGUgQk8qLwotCWFtZGdwdV9ib191bnJlZigmbWVtLT5i
byk7CisJZHJtX2dlbV9vYmplY3RfcHV0X3VubG9ja2VkKCZtZW0tPmJvLT50Ym8uYmFzZSk7CiAJ
bXV0ZXhfZGVzdHJveSgmbWVtLT5sb2NrKTsKIAlrZnJlZShtZW0pOwogCkBAIC0xNjQ3LDcgKzE2
NDcsOCBAQCBpbnQgYW1kZ3B1X2FtZGtmZF9ncHV2bV9pbXBvcnRfZG1hYnVmKHN0cnVjdCBrZ2Rf
ZGV2ICprZ2QsCiAJCSBBTExPQ19NRU1fRkxBR1NfVlJBTSA6IEFMTE9DX01FTV9GTEFHU19HVFQp
IHwKIAkJQUxMT0NfTUVNX0ZMQUdTX1dSSVRBQkxFIHwgQUxMT0NfTUVNX0ZMQUdTX0VYRUNVVEFC
TEU7CiAKLQkoKm1lbSktPmJvID0gYW1kZ3B1X2JvX3JlZihibyk7CisJZHJtX2dlbV9vYmplY3Rf
Z2V0KCZiby0+dGJvLmJhc2UpOworCSgqbWVtKS0+Ym8gPSBibzsKIAkoKm1lbSktPnZhID0gdmE7
CiAJKCptZW0pLT5kb21haW4gPSAoYm8tPnByZWZlcnJlZF9kb21haW5zICYgQU1ER1BVX0dFTV9E
T01BSU5fVlJBTSkgPwogCQlBTURHUFVfR0VNX0RPTUFJTl9WUkFNIDogQU1ER1BVX0dFTV9ET01B
SU5fR1RUOwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1n
ZngK
