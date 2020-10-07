Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4CAC41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 15:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC8D21707
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 15:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDVqpVfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC8D21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3712D6E91A;
	Wed,  7 Oct 2020 15:55:29 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697D36E91A;
 Wed,  7 Oct 2020 15:55:28 +0000 (UTC)
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 00F4320789;
 Wed,  7 Oct 2020 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602086128;
 bh=DnGfCBaWseLBM8TVFoELwrQRAC5MuHq6bqVMisC2Yvo=;
 h=Date:From:To:Cc:Subject:From;
 b=mDVqpVfuFWeeaFRs/tBZmwj1GKg0uFJM+VvcUSBodBR9xt4w6UTErIkNxSF73hD2L
 jkR+jcqRKww35nmLeV8JBRPgoXP5GLKAYXEzm9XzC/CuQxGZN8pG0tqTw0srpYbIEl
 6QVElnqaRXGMkNHQQyo6DmmbPXe6sqOPgRilXY60=
Date: Wed, 7 Oct 2020 11:01:28 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 00/14] drm/amd/pm: Replace one-element arrays with
 flexible-array members
Message-ID: <cover.1602020074.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
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

SGkgYWxsLAoKVGhpcyBzZXJpZXMgYWltcyB0byByZXBsYWNlIG9uZS1lbGVtZW50IGFycmF5cyB3
aXRoIGZsZXhpYmxlLWFycmF5Cm1lbWJlcnMuCgpUaGVyZSBpcyBhIHJlZ3VsYXIgbmVlZCBpbiB0
aGUga2VybmVsIHRvIHByb3ZpZGUgYSB3YXkgdG8gZGVjbGFyZSBoYXZpbmcKYSBkeW5hbWljYWxs
eSBzaXplZCBzZXQgb2YgdHJhaWxpbmcgZWxlbWVudHMgaW4gYSBzdHJ1Y3R1cmUuIEtlcm5lbCBj
b2RlCnNob3VsZCBhbHdheXMgdXNlIOKAnGZsZXhpYmxlIGFycmF5IG1lbWJlcnPigJ1bMV0gZm9y
IHRoZXNlIGNhc2VzLiBUaGUgb2xkZXIKc3R5bGUgb2Ygb25lLWVsZW1lbnQgb3IgemVyby1sZW5n
dGggYXJyYXlzIHNob3VsZCBubyBsb25nZXIgYmUgdXNlZFsyXS4KClJlZmFjdG9yIHRoZSBjb2Rl
IGFjY29yZGluZyB0byB0aGUgdXNlIG9mIGZsZXhpYmxlLWFycmF5IG1lbWJlcnMsIGluc3RlYWQK
b2Ygb25lLWVsZW1lbnQgYXJyYXlzLCBhbmQgdXNlIHRoZSBzdHJ1Y3Rfc2l6ZSgpIGhlbHBlciB0
byBjYWxjdWxhdGUgdGhlCnNpemUgZm9yIHRoZSBkeW5hbWljIG1lbW9yeSBhbGxvY2F0aW9uLgoK
QWxzbywgc2F2ZSBzb21lIGhlYXAgc3BhY2UgaW4gdGhlIHByb2Nlc3MuIE1vcmUgb24gdGhpcyBv
biBlYWNoIGluZGl2aWR1YWwKcGF0Y2guCgpUaGlzIHNlcmllcyBhbHNvIGFkZHJlc3NlcyBtdWx0
aXBsZSBvZiB0aGUgZm9sbG93aW5nIHNvcnRzIG9mIHdhcm5pbmdzOgoKZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvLi4vcG0vcG93ZXJwbGF5L2h3bWdyL3NtdThfaHdtZ3IuYzoxNTE1OjM3Ogp3
YXJuaW5nOiBhcnJheSBzdWJzY3JpcHQgMSBpcyBhYm92ZSBhcnJheSBib3VuZHMgb2Yg4oCYY29u
c3Qgc3RydWN0CnBobV9jbG9ja192b2x0YWdlX2RlcGVuZGVuY3lfcmVjb3JkWzFd4oCZIFstV2Fy
cmF5LWJvdW5kc10KCndoaWNoLCBpbiB0aGlzIGNhc2UsIHRoZXkgYXJlIGZhbHNlIHBvc2l0aXZl
cywgYnV0IG5lcnZlcnRoZWxlc3Mgc2hvdWxkIGJlCmZpeGVkIGluIG9yZGVyIHRvIGVuYWJsZSAt
V2FycmF5LWJvdW5kc1szXVs0XS4KClsxXSBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9G
bGV4aWJsZV9hcnJheV9tZW1iZXIKWzJdIGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwv
djUuOS1yYzEvcHJvY2Vzcy9kZXByZWNhdGVkLmh0bWwjemVyby1sZW5ndGgtYW5kLW9uZS1lbGVt
ZW50LWFycmF5cwpbM10gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9saW51cy80NDcyMDk5NmUyZDc5
ZTQ3ZDUwOGIwYWJlOTliOTMxYTcyNmEzMTk3Cls0XSBodHRwczovL2dpdGh1Yi5jb20vS1NQUC9s
aW51eC9pc3N1ZXMvMTA5CgpHdXN0YXZvIEEuIFIuIFNpbHZhICgxNCk6CiAgZHJtL2FtZC9wbTog
UmVwbGFjZSBvbmUtZWxlbWVudCBhcnJheSB3aXRoIGZsZXhpYmxlLWFycmF5IG1lbWJlcgogIGRy
bS9hbWQvcG06IFJlcGxhY2Ugb25lLWVsZW1lbnQgYXJyYXkgd2l0aCBmbGV4aWJsZS1hcnJheSBt
ZW1iZXIgaW4KICAgIHN0cnVjdCB2aV9kcG1fdGFibGUKICBkcm0vYW1kL3BtOiBSZXBsYWNlIG9u
ZS1lbGVtZW50IGFycmF5IHdpdGggZmxleGlibGUtYXJyYXkgaW4gc3RydWN0CiAgICBwaG1fY2xv
Y2tfYXJyYXkKICBkcm0vYW1kL3BtOiBSZXBsYWNlIG9uZS1lbGVtZW50IGFycmF5IHdpdGggZmxl
eGlibGUtYXJyYXkgaW4gc3RydWN0CiAgICBwaG1fdXZkX2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5j
eV90YWJsZQogIGRybS9hbWQvcG06IFJlcGxhY2Ugb25lLWVsZW1lbnQgYXJyYXkgd2l0aCBmbGV4
aWJsZS1hcnJheSBpbiBzdHJ1Y3QKICAgIHBobV9hY3BfY2xvY2tfdm9sdGFnZV9kZXBlbmRlbmN5
X3RhYmxlCiAgZHJtL2FtZC9wbTogUmVwbGFjZSBvbmUtZWxlbWVudCBhcnJheSB3aXRoIGZsZXhp
YmxlLWFycmF5IGluIHN0cnVjdAogICAgcGhtX3BoYXNlX3NoZWRkaW5nX2xpbWl0c190YWJsZQog
IGRybS9hbWQvcG06IFJlcGxhY2Ugb25lLWVsZW1lbnQgYXJyYXkgd2l0aCBmbGV4aWJsZS1hcnJh
eSBpbiBzdHJ1Y3QKICAgIHBobV92Y2VfY2xvY2tfdm9sdGFnZV9kZXBlbmRlbmN5X3RhYmxlCiAg
ZHJtL2FtZC9wbTogUmVwbGFjZSBvbmUtZWxlbWVudCBhcnJheSB3aXRoIGZsZXhpYmxlLWFycmF5
IGluIHN0cnVjdAogICAgcGhtX2NhY19sZWFrYWdlX3RhYmxlCiAgZHJtL2FtZC9wbTogUmVwbGFj
ZSBvbmUtZWxlbWVudCBhcnJheSB3aXRoIGZsZXhpYmxlLWFycmF5IGluIHN0cnVjdAogICAgcGht
X3NhbXVfY2xvY2tfdm9sdGFnZV9kZXBlbmRlbmN5X3RhYmxlCiAgZHJtL2FtZC9wbTogUmVwbGFj
ZSBvbmUtZWxlbWVudCBhcnJheSB3aXRoIGZsZXhpYmxlLWFycmF5IGluIHN0cnVjdAogICAgcGht
X3BwdF92MV9jbG9ja192b2x0YWdlX2RlcGVuZGVuY3lfdGFibGUKICBkcm0vYW1kL3BtOiBSZXBs
YWNlIG9uZS1lbGVtZW50IGFycmF5IHdpdGggZmxleGlibGUtYXJyYXkgaW4gc3RydWN0CiAgICBw
aG1fcHB0X3YxX21tX2Nsb2NrX3ZvbHRhZ2VfZGVwZW5kZW5jeV90YWJsZQogIGRybS9hbWQvcG06
IFJlcGxhY2Ugb25lLWVsZW1lbnQgYXJyYXkgd2l0aCBmbGV4aWJsZS1hcnJheSBpbiBzdHJ1Y3QK
ICAgIHBobV9wcHRfdjFfdm9sdGFnZV9sb29rdXBfdGFibGUKICBkcm0vYW1kL3BtOiBSZXBsYWNl
IG9uZS1lbGVtZW50IGFycmF5IHdpdGggZmxleGlibGUtYXJyYXkgaW4gc3RydWN0CiAgICBwaG1f
cHB0X3YxX3BjaWVfdGFibGUKICBkcm0vYW1kL3BtOiBSZXBsYWNlIG9uZS1lbGVtZW50IGFycmF5
IHdpdGggZmxleGlibGUtYXJyYXkgaW4gc3RydWN0CiAgICBBVE9NX1ZlZ2ExMF9HRlhDTEtfRGVw
ZW5kZW5jeV9UYWJsZQoKIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vaW5jL2h3bWdyLmggICAgICAg
ICAgICB8IDIwICsrLS0tCiAuLi4vZHJtL2FtZC9wbS9wb3dlcnBsYXkvaHdtZ3IvaHdtZ3JfcHB0
LmggICAgfCAgOCArLQogLi4uL3Bvd2VycGxheS9od21nci9wcm9jZXNzX3BwdGFibGVzX3YxXzAu
YyAgIHwgODUgKysrKysrKy0tLS0tLS0tLS0tCiAuLi4vYW1kL3BtL3Bvd2VycGxheS9od21nci9w
cm9jZXNzcHB0YWJsZXMuYyAgfCA4NSArKysrKysrLS0tLS0tLS0tLS0KIC4uLi9kcm0vYW1kL3Bt
L3Bvd2VycGxheS9od21nci9zbXU4X2h3bWdyLmMgICB8ICAyICstCiAuLi4vZHJtL2FtZC9wbS9w
b3dlcnBsYXkvaHdtZ3Ivc211X2hlbHBlci5jICAgfCAgNSArLQogLi4uL2FtZC9wbS9wb3dlcnBs
YXkvaHdtZ3IvdmVnYTEwX3BwdGFibGUuaCAgIHwgIDIgKy0KIC4uLi9wb3dlcnBsYXkvaHdtZ3Iv
dmVnYTEwX3Byb2Nlc3NwcHRhYmxlcy5jICB8IDg4ICsrKysrKy0tLS0tLS0tLS0tLS0KIDggZmls
ZXMgY2hhbmdlZCwgMTA3IGluc2VydGlvbnMoKyksIDE4OCBkZWxldGlvbnMoLSkKCi0tIAoyLjI3
LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
