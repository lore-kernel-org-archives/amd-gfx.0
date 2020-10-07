Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E130C4727F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 15:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A312176B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 15:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLK1rIEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A312176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8E176E936;
	Wed,  7 Oct 2020 15:57:27 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CB796E936;
 Wed,  7 Oct 2020 15:57:27 +0000 (UTC)
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 02FE520789;
 Wed,  7 Oct 2020 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602086247;
 bh=G0lgH6he/DahzFqP5FRpqz/WY6rYK4qxxqp6/q4ygxk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vLK1rIEQ31Dxq3kj3L07dUw6bF7o4F6aLSLq8v7grzY4RqA2P9ZAZZaGETC41vSRC
 /IUbAntDwdlho+44fbct2gXqcEyfaPFy+g8H5qjYqB5eUp+JxZKyjIvJ1dLPiLPkDP
 aL1TkMNAYUDAmqTujHdh9EGn/mt87necPjCVlJRY=
Date: Wed, 7 Oct 2020 11:03:27 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 02/14] drm/amd/pm: Replace one-element array with
 flexible-array member in struct vi_dpm_table
Message-ID: <d8308a38b7ea35db027f7e2099360d06baa85bbb.1602020074.git.gustavoars@kernel.org>
References: <cover.1602020074.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1602020074.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, amd-gfx@lists.freedesktop.org,
 linux-hardening@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

VGhlcmUgaXMgYSByZWd1bGFyIG5lZWQgaW4gdGhlIGtlcm5lbCB0byBwcm92aWRlIGEgd2F5IHRv
IGRlY2xhcmUgaGF2aW5nCmEgZHluYW1pY2FsbHkgc2l6ZWQgc2V0IG9mIHRyYWlsaW5nIGVsZW1l
bnRzIGluIGEgc3RydWN0dXJlLiBLZXJuZWwgY29kZQpzaG91bGQgYWx3YXlzIHVzZSDigJxmbGV4
aWJsZSBhcnJheSBtZW1iZXJz4oCdWzFdIGZvciB0aGVzZSBjYXNlcy4gVGhlIG9sZGVyCnN0eWxl
IG9mIG9uZS1lbGVtZW50IG9yIHplcm8tbGVuZ3RoIGFycmF5cyBzaG91bGQgbm8gbG9uZ2VyIGJl
IHVzZWRbMl0uCgpVc2UgYSBmbGV4aWJsZS1hcnJheSBtZW1iZXIgaW4gc3RydWN0IHZpX2RwbV90
YWJsZSBpbnN0ZWFkIG9mIGEKb25lLWVsZW1lbnQgYXJyYXkuCgpbMV0gaHR0cHM6Ly9lbi53aWtp
cGVkaWEub3JnL3dpa2kvRmxleGlibGVfYXJyYXlfbWVtYmVyClsyXSBodHRwczovL3d3dy5rZXJu
ZWwub3JnL2RvYy9odG1sL3Y1LjktcmMxL3Byb2Nlc3MvZGVwcmVjYXRlZC5odG1sI3plcm8tbGVu
Z3RoLWFuZC1vbmUtZWxlbWVudC1hcnJheXMKCkJ1aWxkLXRlc3RlZC1ieToga2VybmVsIHRlc3Qg
cm9ib3QgPGxrcEBpbnRlbC5jb20+Ckxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
NWY3YzQzM2MuVFRrOXJuQStGNThreURVeSUyNWxrcEBpbnRlbC5jb20vClNpZ25lZC1vZmYtYnk6
IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL3BtL2luYy9od21nci5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wbS9pbmMvaHdtZ3IuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2h3bWdyLmgKaW5k
ZXggYTFkYmZkNTYzNmU2Li5kNjhiNTQ3NzQzZTYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvcG0vaW5jL2h3bWdyLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9pbmMvaHdt
Z3IuaApAQCAtNjAsNyArNjAsNyBAQCBzdHJ1Y3QgdmlfZHBtX2xldmVsIHsKIAogc3RydWN0IHZp
X2RwbV90YWJsZSB7CiAJdWludDMyX3QgY291bnQ7Ci0Jc3RydWN0IHZpX2RwbV9sZXZlbCBkcG1f
bGV2ZWxbMV07CisJc3RydWN0IHZpX2RwbV9sZXZlbCBkcG1fbGV2ZWxbXTsKIH07CiAKICNkZWZp
bmUgUENJRV9QRVJGX1JFUV9SRU1PVkVfUkVHSVNUUlkgICAwCi0tIAoyLjI3LjAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBs
aXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0
b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
