Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B620FC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 16:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D0F920732
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 16:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0F920732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CF46EB11;
	Fri, 21 Aug 2020 16:58:02 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.178])
 by gabe.freedesktop.org (Postfix) with ESMTP id D88EB6E996;
 Fri, 21 Aug 2020 16:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 4426F2A6042;
 Fri, 21 Aug 2020 18:58:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id xgD5c84TYvP4; Fri, 21 Aug 2020 18:57:59 +0200 (CEST)
Received: from kaveri (212.174.63.188.dynamic.wline.res.cust.swisscom.ch
 [188.63.174.212])
 by netline-mail3.netline.ch (Postfix) with ESMTPSA id A959B2A6016;
 Fri, 21 Aug 2020 18:57:59 +0200 (CEST)
Received: from daenzer by kaveri with local (Exim 4.94)
 (envelope-from <michel@daenzer.net>)
 id 1k9AMY-004dmr-T6; Fri, 21 Aug 2020 18:57:58 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Leo Li <sunpeng.li@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH] drm/amdgpu/dc: Require primary plane to be enabled whenever
 the CRTC is
Date: Fri, 21 Aug 2020 18:57:58 +0200
Message-Id: <20200821165758.1106210-1-michel@daenzer.net>
X-Mailer: git-send-email 2.28.0
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogTWljaGVsIETDpG56ZXIgPG1kYWVuemVyQHJlZGhhdC5jb20+CgpEb24ndCBjaGVjayBk
cm1fY3J0Y19zdGF0ZTo6YWN0aXZlIGZvciB0aGlzIGVpdGhlciwgcGVyIGl0cwpkb2N1bWVudGF0
aW9uIGluIGluY2x1ZGUvZHJtL2RybV9jcnRjLmg6CgogKiBIZW5jZSBkcml2ZXJzIG11c3Qgbm90
IGNvbnN1bHQgQGFjdGl2ZSBpbiB0aGVpciB2YXJpb3VzCiAqICZkcm1fbW9kZV9jb25maWdfZnVu
Y3MuYXRvbWljX2NoZWNrIGNhbGxiYWNrIHRvIHJlamVjdCBhbiBhdG9taWMKICogY29tbWl0LgoK
VGhlIGF0b21pYyBoZWxwZXJzIGRpc2FibGUgdGhlIENSVEMgYXMgbmVlZGVkIGZvciBkaXNhYmxp
bmcgdGhlIHByaW1hcnkKcGxhbmUuCgpUaGlzIHByZXZlbnRzIGF0IGxlYXN0IHRoZSBmb2xsb3dp
bmcgcHJvYmxlbXMgaWYgdGhlIHByaW1hcnkgcGxhbmUgZ2V0cwpkaXNhYmxlZCAoZS5nLiBkdWUg
dG8gZGVzdHJveWluZyB0aGUgRkIgYXNzaWduZWQgdG8gdGhlIHByaW1hcnkgcGxhbmUsCmFzIGhh
cHBlbnMgZS5nLiB3aXRoIG11dHRlciBpbiBXYXlsYW5kIG1vZGUpOgoKKiBUb2dnbGluZyBDUlRD
IGFjdGl2ZSB0byAxIGZhaWxlZCBpZiB0aGUgY3Vyc29yIHBsYW5lIHdhcyBlbmFibGVkCiAgKGUu
Zy4gdmlhIGxlZ2FjeSBEUE1TIHByb3BlcnR5ICYgY3Vyc29yIGlvY3RsKS4KKiBFbmFibGluZyB0
aGUgY3Vyc29yIHBsYW5lIGZhaWxlZCwgZS5nLiB2aWEgdGhlIGxlZ2FjeSBjdXJzb3IgaW9jdGwu
CgpHaXRMYWI6IGh0dHBzOi8vZ2l0bGFiLmdub21lLm9yZy9HTk9NRS9tdXR0ZXIvLS9pc3N1ZXMv
MTEwOApHaXRMYWI6IGh0dHBzOi8vZ2l0bGFiLmdub21lLm9yZy9HTk9NRS9tdXR0ZXIvLS9pc3N1
ZXMvMTE2NQpHaXRMYWI6IGh0dHBzOi8vZ2l0bGFiLmdub21lLm9yZy9HTk9NRS9tdXR0ZXIvLS9p
c3N1ZXMvMTM0NApTdWdnZXN0ZWQtYnk6IERhbmllbCBWZXR0ZXIgPGRhbmllbC52ZXR0ZXJAZmZ3
bGwuY2g+ClNpZ25lZC1vZmYtYnk6IE1pY2hlbCBEw6RuemVyIDxtZGFlbnplckByZWRoYXQuY29t
PgotLS0KCk5vdGUgdGhhdCB0aGlzIHdpbGwgY2F1c2Ugc29tZSBJR1QgdGVzdHMgdG8gZmFpbCB3
aXRob3V0Cmh0dHBzOi8vcGF0Y2h3b3JrLmZyZWVkZXNrdG9wLm9yZy9zZXJpZXMvODA5MDQvIC4K
CiAuLi4vZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzMyArKysr
KysrLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMjIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdw
dV9kbS9hbWRncHVfZG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0v
YW1kZ3B1X2RtLmMKaW5kZXggODk3ZDYwYWRlMWU0Li4zM2M1NzM5ZTIyMWIgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwpAQCAtNTI2
MiwxOSArNTI2Miw2IEBAIHN0YXRpYyB2b2lkIGRtX2NydGNfaGVscGVyX2Rpc2FibGUoc3RydWN0
IGRybV9jcnRjICpjcnRjKQogewogfQogCi1zdGF0aWMgYm9vbCBkb2VzX2NydGNfaGF2ZV9hY3Rp
dmVfY3Vyc29yKHN0cnVjdCBkcm1fY3J0Y19zdGF0ZSAqbmV3X2NydGNfc3RhdGUpCi17Ci0Jc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiA9IG5ld19jcnRjX3N0YXRlLT5jcnRjLT5kZXY7Ci0Jc3RydWN0
IGRybV9wbGFuZSAqcGxhbmU7Ci0KLQlkcm1fZm9yX2VhY2hfcGxhbmVfbWFzayhwbGFuZSwgZGV2
LCBuZXdfY3J0Y19zdGF0ZS0+cGxhbmVfbWFzaykgewotCQlpZiAocGxhbmUtPnR5cGUgPT0gRFJN
X1BMQU5FX1RZUEVfQ1VSU09SKQotCQkJcmV0dXJuIHRydWU7Ci0JfQotCi0JcmV0dXJuIGZhbHNl
OwotfQotCiBzdGF0aWMgaW50IGNvdW50X2NydGNfYWN0aXZlX3BsYW5lcyhzdHJ1Y3QgZHJtX2Ny
dGNfc3RhdGUgKm5ld19jcnRjX3N0YXRlKQogewogCXN0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpz
dGF0ZSA9IG5ld19jcnRjX3N0YXRlLT5zdGF0ZTsKQEAgLTUzMzgsMTkgKzUzMjUsMjEgQEAgc3Rh
dGljIGludCBkbV9jcnRjX2hlbHBlcl9hdG9taWNfY2hlY2soc3RydWN0IGRybV9jcnRjICpjcnRj
LAogCQlyZXR1cm4gcmV0OwogCX0KIAotCS8qIEluIHNvbWUgdXNlIGNhc2VzLCBsaWtlIHJlc2V0
LCBubyBzdHJlYW0gaXMgYXR0YWNoZWQgKi8KLQlpZiAoIWRtX2NydGNfc3RhdGUtPnN0cmVhbSkK
LQkJcmV0dXJuIDA7Ci0KIAkvKgotCSAqIFdlIHdhbnQgYXQgbGVhc3Qgb25lIGhhcmR3YXJlIHBs
YW5lIGVuYWJsZWQgdG8gdXNlCi0JICogdGhlIHN0cmVhbSB3aXRoIGEgY3Vyc29yIGVuYWJsZWQu
CisJICogV2UgcmVxdWlyZSB0aGUgcHJpbWFyeSBwbGFuZSB0byBiZSBlbmFibGVkIHdoZW5ldmVy
IHRoZSBDUlRDIGlzLAorCSAqIG90aGVyd2lzZSB0aGUgbGVnYWN5IGN1cnNvciBpb2N0bCBoZWxw
ZXIgbWF5IGVuZCB1cCB0cnlpbmcgdG8gZW5hYmxlCisJICogdGhlIGN1cnNvciBwbGFuZSB3aGls
ZSB0aGUgcHJpbWFyeSBwbGFuZSBpcyBkaXNhYmxlZCwgd2hpY2ggaXMgbm90CisJICogc3VwcG9y
dGVkIGJ5IHRoZSBoYXJkd2FyZS4gQW5kIHRoZXJlIGlzIGxlZ2FjeSB1c2Vyc3BhY2Ugd2hpY2gg
c3RvcHMKKwkgKiB1c2luZyB0aGUgSFcgY3Vyc29yIGFsdG9nZXRoZXIgaW4gcmVzcG9uc2UgdG8g
dGhlIHJlc3VsdGluZyBFSU5WQUwuCiAJICovCi0JaWYgKHN0YXRlLT5lbmFibGUgJiYgc3RhdGUt
PmFjdGl2ZSAmJgotCSAgICBkb2VzX2NydGNfaGF2ZV9hY3RpdmVfY3Vyc29yKHN0YXRlKSAmJgot
CSAgICBkbV9jcnRjX3N0YXRlLT5hY3RpdmVfcGxhbmVzID09IDApCisJaWYgKHN0YXRlLT5lbmFi
bGUgJiYKKwkgICAgIShzdGF0ZS0+cGxhbmVfbWFzayAmIGRybV9wbGFuZV9tYXNrKGNydGMtPnBy
aW1hcnkpKSkKIAkJcmV0dXJuIC1FSU5WQUw7CiAKKwkvKiBJbiBzb21lIHVzZSBjYXNlcywgbGlr
ZSByZXNldCwgbm8gc3RyZWFtIGlzIGF0dGFjaGVkICovCisJaWYgKCFkbV9jcnRjX3N0YXRlLT5z
dHJlYW0pCisJCXJldHVybiAwOworCiAJaWYgKGRjX3ZhbGlkYXRlX3N0cmVhbShkYywgZG1fY3J0
Y19zdGF0ZS0+c3RyZWFtKSA9PSBEQ19PSykKIAkJcmV0dXJuIDA7CiAKLS0gCjIuMjguMAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
