Return-Path: <SRS0=Iydh=KT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D1CC04FF3
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 14:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A2761435
	for <amd-gfx@archiver.kernel.org>; Mon, 24 May 2021 14:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A2761435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FE56E866;
	Mon, 24 May 2021 14:48:59 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7686E866;
 Mon, 24 May 2021 14:48:57 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBF1161430;
 Mon, 24 May 2021 14:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621867737;
 bh=o19B04rDSAAxX/tFaxndazizN7mBByLIkn3rVKEeiCs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mjuTiqyzadpvajVMyYrkhRSKT3rLwuUFWdeMA5FGNJ4s4lZ/RdUtSfOcv8FpCf5Qc
 eFU1GireSlOIX+08Ok2DErKdNGfVJR9uvwij9n9KfzXewKT2efcXBuXKGQu5dTcQzz
 x+MempL+YVxB+SdscHSgbd9fIxc1eZ5XgZ8SOzLpO8FXaSWqY4BVcO8Kf8EB1J7slA
 6CJm5AoE2qB0MRlAR4lha+0Ko0/fxo1kZj0SU17FP8o+dvn34uU4GSFFmGe4C3nYro
 I9qae0D8mTFsaOCOlszgIulc6ud6bIdIFLhfiWVuRCyw3kVwhYramQMOzexavWkuFF
 wmh7woswd0Mfw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 59/62] drm/amdgpu: stop touching sched.ready in
 the backend
Date: Mon, 24 May 2021 10:47:40 -0400
Message-Id: <20210524144744.2497894-59-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524144744.2497894-1-sashal@kernel.org>
References: <20210524144744.2497894-1-sashal@kernel.org>
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
 dri-devel@lists.freedesktop.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RnJvbTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgoKWyBVcHN0
cmVhbSBjb21taXQgYTJiNDc4NWYwMTI4MGE0MjkxZWRiOWZkYTY5MDMyZmMyZTRiZmQzZiBdCgpU
aGlzIHVuZm9ydHVuYXRlbHkgY29tZXMgdXAgaW4gcmVndWxhciBpbnRlcnZhbHMgYW5kIGJyZWFr
cwpHUFUgcmVzZXQgZm9yIHRoZSBlbmdpbmUgaW4gcXVlc3Rpb24uCgpUaGUgc2NoZWQucmVhZHkg
ZmxhZyBjb250cm9scyBpZiBhbiBlbmdpbmUgY2FuJ3QgZ2V0IHdvcmtpbmcKZHVyaW5nIGh3X2lu
aXQsIGJ1dCBzaG91bGQgbmV2ZXIgYmUgc2V0IHRvIGZhbHNlIGR1cmluZyBod19maW5pLgoKdjI6
IHNxdWFzaCBpbiB1bnVzZWQgdmFyaWFibGUgZml4IChBbGV4KQoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1ieTogQWxl
eCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBBbGV4
IERldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+ClNpZ25lZC1vZmYtYnk6IFNhc2hh
IExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9qcGVnX3YyXzUuYyB8IDIgLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjNf
MC5jIHwgMiAtLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NV8yLmMgfCA1IC0t
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jICB8IDggKy0tLS0tLS0K
IDQgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE2IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfNS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvanBlZ192Ml81LmMKaW5kZXggODQ1MzA2ZjYzY2RiLi42M2IzNTAx
ODIzODkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfNS5j
CisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjJfNS5jCkBAIC0xOTgsOCAr
MTk4LDYgQEAgc3RhdGljIGludCBqcGVnX3YyXzVfaHdfZmluaSh2b2lkICpoYW5kbGUpCiAJCWlm
IChhZGV2LT5qcGVnLmN1cl9zdGF0ZSAhPSBBTURfUEdfU1RBVEVfR0FURSAmJgogCQkgICAgICBS
UkVHMzJfU09DMTUoSlBFRywgaSwgbW1VVkRfSlJCQ19TVEFUVVMpKQogCQkJanBlZ192Ml81X3Nl
dF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2LCBBTURfUEdfU1RBVEVfR0FURSk7Ci0KLQkJcmluZy0+
c2NoZWQucmVhZHkgPSBmYWxzZTsKIAl9CiAKIAlyZXR1cm4gMDsKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjNfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvanBlZ192M18wLmMKaW5kZXggM2EwZGZmNTM2NTRkLi45MjU5ZTM1ZjBmNTUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjNfMC5jCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2pwZWdfdjNfMC5jCkBAIC0xNjYsOCArMTY2LDYgQEAgc3Rh
dGljIGludCBqcGVnX3YzXzBfaHdfZmluaSh2b2lkICpoYW5kbGUpCiAJICAgICAgUlJFRzMyX1NP
QzE1KEpQRUcsIDAsIG1tVVZEX0pSQkNfU1RBVFVTKSkKIAkJanBlZ192M18wX3NldF9wb3dlcmdh
dGluZ19zdGF0ZShhZGV2LCBBTURfUEdfU1RBVEVfR0FURSk7CiAKLQlyaW5nLT5zY2hlZC5yZWFk
eSA9IGZhbHNlOwotCiAJcmV0dXJuIDA7CiB9CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92NV8yLmMKaW5kZXggMmE0ODUwNTJlM2FiLi4xYmQzMzBkNDMxNDcgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L3NkbWFfdjVfMi5jCkBAIC00NzYsMTEgKzQ3Niw2IEBAIHN0YXRpYyB2b2lk
IHNkbWFfdjVfMl9nZnhfc3RvcChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKIAkJaWJfY250
bCA9IFJFR19TRVRfRklFTEQoaWJfY250bCwgU0RNQTBfR0ZYX0lCX0NOVEwsIElCX0VOQUJMRSwg
MCk7CiAJCVdSRUczMihzZG1hX3Y1XzJfZ2V0X3JlZ19vZmZzZXQoYWRldiwgaSwgbW1TRE1BMF9H
RlhfSUJfQ05UTCksIGliX2NudGwpOwogCX0KLQotCXNkbWEwLT5zY2hlZC5yZWFkeSA9IGZhbHNl
OwotCXNkbWExLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwotCXNkbWEyLT5zY2hlZC5yZWFkeSA9IGZh
bHNlOwotCXNkbWEzLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwogfQogCiAvKioKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS92Y25fdjNfMC5jCmluZGV4IGI1ZjhmM2Q3MzFjYi4uNzAwNjIxZGRjMDJlIDEw
MDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjNfMC5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92M18wLmMKQEAgLTM0Niw3ICszNDYsNyBAQCBz
dGF0aWMgaW50IHZjbl92M18wX2h3X2Zpbmkodm9pZCAqaGFuZGxlKQogewogCXN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFuZGxlOwogCXN0cnVj
dCBhbWRncHVfcmluZyAqcmluZzsKLQlpbnQgaSwgajsKKwlpbnQgaTsKIAogCWZvciAoaSA9IDA7
IGkgPCBhZGV2LT52Y24ubnVtX3Zjbl9pbnN0OyArK2kpIHsKIAkJaWYgKGFkZXYtPnZjbi5oYXJ2
ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQpAQCAtMzYxLDEyICszNjEsNiBAQCBzdGF0aWMgaW50IHZj
bl92M18wX2h3X2Zpbmkodm9pZCAqaGFuZGxlKQogCQkJCXZjbl92M18wX3NldF9wb3dlcmdhdGlu
Z19zdGF0ZShhZGV2LCBBTURfUEdfU1RBVEVfR0FURSk7CiAJCQl9CiAJCX0KLQkJcmluZy0+c2No
ZWQucmVhZHkgPSBmYWxzZTsKLQotCQlmb3IgKGogPSAwOyBqIDwgYWRldi0+dmNuLm51bV9lbmNf
cmluZ3M7ICsraikgewotCQkJcmluZyA9ICZhZGV2LT52Y24uaW5zdFtpXS5yaW5nX2VuY1tqXTsK
LQkJCXJpbmctPnNjaGVkLnJlYWR5ID0gZmFsc2U7Ci0JCX0KIAl9CiAKIAlyZXR1cm4gMDsKLS0g
CjIuMzAuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
