Return-Path: <SRS0=56E2=ZQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D7CC432C3
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Nov 2019 19:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3195E20656
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Nov 2019 19:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3195E20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=raptorengineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E514C89B70;
	Sun, 24 Nov 2019 19:18:48 +0000 (UTC)
Received: from mail.rptsys.com (mail.rptsys.com [23.155.224.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB2E89B70
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Nov 2019 19:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id B02D4D7D00030
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Nov 2019 13:10:53 -0600 (CST)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id C2EJ1YCSshTH for <amd-gfx@lists.freedesktop.org>;
 Sun, 24 Nov 2019 13:10:53 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 56643D7D00029
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Nov 2019 13:10:53 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 56643D7D00029
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id UJwjwoCLmyyf for <amd-gfx@lists.freedesktop.org>;
 Sun, 24 Nov 2019 13:10:53 -0600 (CST)
Received: from vali.starlink.edu (unknown [192.168.3.2])
 by mail.rptsys.com (Postfix) with ESMTP id 3E6E4D7D00026
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Nov 2019 13:10:53 -0600 (CST)
Date: Sun, 24 Nov 2019 13:10:52 -0600 (CST)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
Message-ID:
 <443989900.1923547.1574622652551.JavaMail.zimbra@raptorengineeringinc.com>
Subject: [PATCH 1/1] amdgpu: Enable KFD on POWER systems
MIME-Version: 1.0
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC73 (Linux)/8.5.0_GA_3042)
Thread-Index: DvSodV0VNNA5bM53SIuKWIAdogdWuA==
Thread-Topic: amdgpu: Enable KFD on POWER systems
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1574622653; bh=urDhG30Qcl78jcVc8tsz7ak443ivAj1YNXLr/HyH28o=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=Ddg8RBFJYvNLRUGhkRewZ85g4dmUk+fmu3ki0zpYQqD2SPEw0BHjRFLkN0U2iVOvD
 fyl2Kzlcl6kqRmCWAFMomW5GNoVa3qfjQY79hL9RF4z12ew18d+OthMV5uHYuBP7H/
 6krWECyV3TdsvhUrKBgcXJjM5uGBFDN3NIvJSH34=
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
Message-ID: <20191124191052.ihMVULwaZLGOkuNzQ5KP3JrrzfLTDakE4sIkqFA3ml8@z>

S0ZEIGhhcyBiZWVuIHZlcmlmaWVkIHRvIGZ1bmN0aW9uIG9uIFBPV0VSIHN5c3RlbXMgKFRhbG9z
IElJIC8gVmVnYSA2NCkuCkl0IHNob3VsZCBiZSBhdmFpbGFibGUgYXMgYSBrZXJuZWwgY29uZmln
dXJhdGlvbiBvcHRpb24gb24gdGhlc2Ugc3lzdGVtcy4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGtmZC9LY29uZmlnIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2Nv
bmZpZyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL0tjb25maWcKaW5kZXggYTFhMzVkNGQ1
OTRiLi5iYTBlNjgwNTdhODkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2Zk
L0tjb25maWcKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQvS2NvbmZpZwpAQCAtNSw3
ICs1LDcgQEAKIAogY29uZmlnIEhTQV9BTUQKIAlib29sICJIU0Ega2VybmVsIGRyaXZlciBmb3Ig
QU1EIEdQVSBkZXZpY2VzIgotCWRlcGVuZHMgb24gRFJNX0FNREdQVSAmJiAoWDg2XzY0IHx8IEFS
TTY0KQorCWRlcGVuZHMgb24gRFJNX0FNREdQVSAmJiAoWDg2XzY0IHx8IEFSTTY0IHx8IFBQQzY0
KQogCWltcGx5IEFNRF9JT01NVV9WMiBpZiBYODZfNjQKIAlzZWxlY3QgTU1VX05PVElGSUVSCiAJ
aGVscAotLSAKMi4yMC4xCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
