Return-Path: <SRS0=HGq7=Z5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8247C2D0C2
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Dec 2019 22:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E9F24677
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Dec 2019 22:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E9F24677
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=raptorengineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C5C26E27C;
	Sat,  7 Dec 2019 22:48:12 +0000 (UTC)
Received: from mail.rptsys.com (mail.rptsys.com [23.155.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D523A6E27C
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Dec 2019 22:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 54A02EDCAE3DF
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Dec 2019 16:48:10 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id w6hSmYN1GdQ6 for <amd-gfx@lists.freedesktop.org>;
 Sat,  7 Dec 2019 16:48:09 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id C9BC8EDCAE2DB
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Dec 2019 16:48:09 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com C9BC8EDCAE2DB
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id iMW_UYKEjAZc for <amd-gfx@lists.freedesktop.org>;
 Sat,  7 Dec 2019 16:48:09 -0600 (CST)
Received: from vali.starlink.edu (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id AAF43EDCAE295
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Dec 2019 16:48:09 -0600 (CST)
Date: Sat, 7 Dec 2019 16:48:09 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
Message-ID: <134608179.4246772.1575758889655.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <1954348516.4246771.1575758866574.JavaMail.zimbra@raptorengineeringinc.com>
References: <1468620701.4246768.1575758833243.JavaMail.zimbra@raptorengineeringinc.com>
 <1954348516.4246771.1575758866574.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 3/3] amdgpu: Wrap FPU dependent functions in dc20
MIME-Version: 1.0
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC65 (Linux)/8.5.0_GA_3042)
Thread-Topic: amdgpu: Wrap FPU dependent functions in dc20
Thread-Index: zcjIxuIryBK79ugUHvQzoHixfO6R+BUxE0EScLWeg9w=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1575758889; bh=D/njOk6ddemUV0p1ER6Vp4iofT/jutsAPwTpPsUJwt4=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=k8wfdkgdRHobsk81Ph7Zc5k7Huo0QI5oOlPDSv4T7uMbw6b3F/iznWRJgFde5cZ/u
 oDymzahdwjP5m4/S2d3XzP0Swki/zHn13A+157mW5nk7ajromLwkoNJrGXR/sV8vO8
 OpwW6oSfOiu456TEDHIXOubTYLQ2H9p5rza28fQM=
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

ZGMyMCBjb250YWluZXMgc2V2ZXJhbCBGUFUtZGVwZW5kZW50IGZ1bmN0aW9ucyB3aXRob3V0IHBy
b3BlciBGUFUKa2VybmVsIG1vZGUgZW5hYmxlL2Rpc2FibGUgd3JhcHBlcnMuICBBZGQgdGhlIHJl
cXVpcmVkIHdyYXBwZXJzCmZvciBib3RoIHg4NiBhbmQgUE9XRVIuCgpUaGlzIGVuYWJsZXMgTmF2
aSBEQzIwIHN1cHBvcnQgZm9yIFBPV0VSIHN5c3RlbXMuCgpTaWduZWQtb2ZmLWJ5OiBUaW1vdGh5
IFBlYXJzb24gPHRwZWFyc29uQHJhcHRvcmVuZ2luZWVyaW5nLmNvbT4KLS0tCiAuLi4vZ3B1L2Ry
bS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNvdXJjZS5jICB8IDE0ICsrKysrKysrKysr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVz
b3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24yMC9kY24yMF9yZXNv
dXJjZS5jCmluZGV4IDI1NDk3Mzc1MTczMi4uOTUzMDNiNzdiZmQ2IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNuMjAvZGNuMjBfcmVzb3VyY2UuYwpAQCAt
MjkxNywxNCArMjkxNywxOSBAQCBzdGF0aWMgYm9vbCBkY24yMF92YWxpZGF0ZV9iYW5kd2lkdGhf
aW50ZXJuYWwoc3RydWN0IGRjICpkYywgc3RydWN0IGRjX3N0YXRlICpjbwogYm9vbCBkY24yMF92
YWxpZGF0ZV9iYW5kd2lkdGgoc3RydWN0IGRjICpkYywgc3RydWN0IGRjX3N0YXRlICpjb250ZXh0
LAogCQlib29sIGZhc3RfdmFsaWRhdGUpCiB7CisJRENfRlBfU1RBUlQoKQorCiAJYm9vbCB2b2x0
YWdlX3N1cHBvcnRlZCA9IGZhbHNlOwogCWJvb2wgZnVsbF9wc3RhdGVfc3VwcG9ydGVkID0gZmFs
c2U7CiAJYm9vbCBkdW1teV9wc3RhdGVfc3VwcG9ydGVkID0gZmFsc2U7CiAJZG91YmxlIHBfc3Rh
dGVfbGF0ZW5jeV91cyA9IGNvbnRleHQtPmJ3X2N0eC5kbWwuc29jLmRyYW1fY2xvY2tfY2hhbmdl
X2xhdGVuY3lfdXM7CiAKLQlpZiAoZmFzdF92YWxpZGF0ZSkKLQkJcmV0dXJuIGRjbjIwX3ZhbGlk
YXRlX2JhbmR3aWR0aF9pbnRlcm5hbChkYywgY29udGV4dCwgdHJ1ZSk7CisJaWYgKGZhc3RfdmFs
aWRhdGUpIHsKKwkJdm9sdGFnZV9zdXBwb3J0ZWQgPSBkY24yMF92YWxpZGF0ZV9iYW5kd2lkdGhf
aW50ZXJuYWwoZGMsIGNvbnRleHQsIHRydWUpOwogCisJCURDX0ZQX0VORCgpCisJCXJldHVybiB2
b2x0YWdlX3N1cHBvcnRlZDsKKwl9CiAKIAkvLyBCZXN0IGNhc2UsIHdlIHN1cHBvcnQgZnVsbCBV
Q0xLIHN3aXRjaCBsYXRlbmN5CiAJdm9sdGFnZV9zdXBwb3J0ZWQgPSBkY24yMF92YWxpZGF0ZV9i
YW5kd2lkdGhfaW50ZXJuYWwoZGMsIGNvbnRleHQsIGZhbHNlKTsKQEAgLTI5NTMsNiArMjk1OCw3
IEBAIGJvb2wgZGNuMjBfdmFsaWRhdGVfYmFuZHdpZHRoKHN0cnVjdCBkYyAqZGMsIHN0cnVjdCBk
Y19zdGF0ZSAqY29udGV4dCwKIHJlc3RvcmVfZG1sX3N0YXRlOgogCWNvbnRleHQtPmJ3X2N0eC5k
bWwuc29jLmRyYW1fY2xvY2tfY2hhbmdlX2xhdGVuY3lfdXMgPSBwX3N0YXRlX2xhdGVuY3lfdXM7
CiAKKwlEQ19GUF9FTkQoKQogCXJldHVybiB2b2x0YWdlX3N1cHBvcnRlZDsKIH0KIApAQCAtMzQ3
Miw2ICszNDc4LDggQEAgc3RhdGljIGJvb2wgY29uc3RydWN0KAogCWVudW0gZG1sX3Byb2plY3Qg
ZG1sX3Byb2plY3RfdmVyc2lvbiA9CiAJCQlnZXRfZG1sX3Byb2plY3RfdmVyc2lvbihjdHgtPmFz
aWNfaWQuaHdfaW50ZXJuYWxfcmV2KTsKIAorCURDX0ZQX1NUQVJUKCkKKwogCWN0eC0+ZGNfYmlv
cy0+cmVncyA9ICZiaW9zX3JlZ3M7CiAJcG9vbC0+YmFzZS5mdW5jcyA9ICZkY24yMF9yZXNfcG9v
bF9mdW5jczsKIApAQCAtMzc2MCwxMCArMzc2OCwxMiBAQCBzdGF0aWMgYm9vbCBjb25zdHJ1Y3Qo
CiAKIAlkYy0+Y2FwX2Z1bmNzID0gY2FwX2Z1bmNzOwogCisJRENfRlBfRU5EKCkKIAlyZXR1cm4g
dHJ1ZTsKIAogY3JlYXRlX2ZhaWw6CiAKKwlEQ19GUF9FTkQoKQogCWRlc3RydWN0KHBvb2wpOwog
CiAJcmV0dXJuIGZhbHNlOwotLSAKMi4yMC4xCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeA==
