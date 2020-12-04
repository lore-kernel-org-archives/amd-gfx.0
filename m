Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1DBC4361A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 16:49:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AF0229C9
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 16:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AF0229C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C986E19C;
	Fri,  4 Dec 2020 16:49:04 +0000 (UTC)
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FECA6E19C
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 16:49:02 +0000 (UTC)
Date: Fri, 04 Dec 2020 16:48:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1607100539;
 bh=qQWHYvhyIw0G0HLacDimHfr4qDEKryY28DObF6L1Mxw=;
 h=Date:To:From:Cc:Reply-To:Subject:From;
 b=MOi/RUft65fzk+n5HwVPmRmFprfQar8vNYItlq66kAnWlcRC+jJgomONAOgrAs0Rq
 frWvUsQlFjN26rt5FPJjQPFYdJy4XjobHckzUeuQtDB8XqSCNmAODkDjVa07w5CmPE
 MpoEE3TVooGXZjrEI3tU1bcftIBofadrnSKOcv6C9prFK/Y88spTRgeTSZzSOYPP1W
 TldpaLXNWaJtVXFVNMJU8rsZ7A0I2Cq613sxyt+4qY1GF6A9EPKK+JubkLC4JbFsz+
 BDfePI85Dj/rGTlt8dIOzUJv7Iegn5BtkUqn2+tvkLoZY4nxmFX2Z2doiPHgLhW2gV
 Mt129QuP/K99Q==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH 1/2] drm/amd: use drm_dbg_kms to log addfb2 failures
Message-ID: <gpyiw8f46Ut9Rft91UBPoCsu3mLlKznqQVP1RytUIQ@cp7-web-042.plabs.ch>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QXZvaWQgcHJpbnRpbmcgYW4gZXJyb3Igd2l0aCBkZXZfZXJyLCBiZWNhdXNlIHVzZXItc3BhY2Ug
Y2FuIHRyaWdnZXIKdGhlc2UgYXQgd2lsbCBieSBpc3N1aW5nIGFuIGlvY3RsLgoKQ29udmVydCBh
IERSTV9ERUJVR19LTVMgY2FsbCB0byB0aGUgbW9yZSBtb2Rlcm4gZHJtX2RiZ19rbXMgbWFjcm8u
CgpTaWduZWQtb2ZmLWJ5OiBTaW1vbiBTZXIgPGNvbnRhY3RAZW1lcnNpb24uZnI+CkNjOiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+CkNjOiBIYXJyeSBXZW50bGFuZCA8
aHdlbnRsYW5AYW1kLmNvbT4KQ2M6IE5pY2hvbGFzIEthemxhdXNrYXMgPG5pY2hvbGFzLmthemxh
dXNrYXNAYW1kLmNvbT4KQ2M6IE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+Ci0t
LQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyB8IDEwICsrKysr
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rpc3BsYXkuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kaXNwbGF5LmMKaW5kZXggMmVmOTcz
NGViMTE5Li43M2I4NWRhMmNjYmYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV9kaXNwbGF5LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2Rpc3BsYXkuYwpAQCAtODg3LDggKzg4Nyw4IEBAIGludCBhbWRncHVfZGlzcGxheV9mcmFt
ZWJ1ZmZlcl9pbml0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCiAJICovCiAJZm9yIChpID0gMTsg
aSA8IHJmYi0+YmFzZS5mb3JtYXQtPm51bV9wbGFuZXM7ICsraSkgewogCQlpZiAobW9kZV9jbWQt
PmhhbmRsZXNbaV0gIT0gbW9kZV9jbWQtPmhhbmRsZXNbMF0pIHsKLQkJCWRldl9lcnIoJmRldi0+
cGRldi0+ZGV2LCAiUGxhbmUgMCBhbmQgJWQgaGF2ZSBkaWZmZXJlbnQgQk9zOiAldSB2cy4gJXVc
biIsCi0JCQkJaSwgbW9kZV9jbWQtPmhhbmRsZXNbMF0sIG1vZGVfY21kLT5oYW5kbGVzW2ldKTsK
KwkJCWRybV9kYmdfa21zKGRldiwgIlBsYW5lIDAgYW5kICVkIGhhdmUgZGlmZmVyZW50IEJPczog
JXUgdnMuICV1XG4iLAorCQkJCSAgICBpLCBtb2RlX2NtZC0+aGFuZGxlc1swXSwgbW9kZV9jbWQt
PmhhbmRsZXNbaV0pOwogCQkJcmV0ID0gLUVJTlZBTDsKIAkJCWdvdG8gZmFpbDsKIAkJfQpAQCAt
OTI4LDE0ICs5MjgsMTQgQEAgYW1kZ3B1X2Rpc3BsYXlfdXNlcl9mcmFtZWJ1ZmZlcl9jcmVhdGUo
c3RydWN0IGRybV9kZXZpY2UgKmRldiwKIAogCW9iaiA9IGRybV9nZW1fb2JqZWN0X2xvb2t1cChm
aWxlX3ByaXYsIG1vZGVfY21kLT5oYW5kbGVzWzBdKTsKIAlpZiAob2JqID09ICBOVUxMKSB7Ci0J
CWRldl9lcnIoJmRldi0+cGRldi0+ZGV2LCAiTm8gR0VNIG9iamVjdCBhc3NvY2lhdGVkIHRvIGhh
bmRsZSAweCUwOFgsICIKLQkJCSJjYW4ndCBjcmVhdGUgZnJhbWVidWZmZXJcbiIsIG1vZGVfY21k
LT5oYW5kbGVzWzBdKTsKKwkJZHJtX2RiZ19rbXMoZGV2LCAiTm8gR0VNIG9iamVjdCBhc3NvY2lh
dGVkIHRvIGhhbmRsZSAweCUwOFgsICIKKwkJCSAgICAiY2FuJ3QgY3JlYXRlIGZyYW1lYnVmZmVy
XG4iLCBtb2RlX2NtZC0+aGFuZGxlc1swXSk7CiAJCXJldHVybiBFUlJfUFRSKC1FTk9FTlQpOwog
CX0KIAogCS8qIEhhbmRsZSBpcyBpbXBvcnRlZCBkbWEtYnVmLCBzbyBjYW5ub3QgYmUgbWlncmF0
ZWQgdG8gVlJBTSBmb3Igc2Nhbm91dCAqLwogCWlmIChvYmotPmltcG9ydF9hdHRhY2gpIHsKLQkJ
RFJNX0RFQlVHX0tNUygiQ2Fubm90IGNyZWF0ZSBmcmFtZWJ1ZmZlciBmcm9tIGltcG9ydGVkIGRt
YV9idWZcbiIpOworCQlkcm1fZGJnX2ttcyhkZXYsICJDYW5ub3QgY3JlYXRlIGZyYW1lYnVmZmVy
IGZyb20gaW1wb3J0ZWQgZG1hX2J1ZlxuIik7CiAJCXJldHVybiBFUlJfUFRSKC1FSU5WQUwpOwog
CX0KIAotLSAKMi4yOS4yCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
Cg==
