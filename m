Return-Path: <SRS0=1gsM=4X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3922FC10F26
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 08:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764AC2073D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2020 08:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="p2MvK8yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764AC2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7606EC85;
	Fri,  6 Mar 2020 08:03:19 +0000 (UTC)
X-Greylist: delayed 331 seconds by postgrey-1.36 at gabe;
 Fri, 06 Mar 2020 06:31:09 UTC
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch
 [185.70.40.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA2089BCD;
 Fri,  6 Mar 2020 06:31:09 +0000 (UTC)
Date: Fri, 06 Mar 2020 06:25:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=default; t=1583475936;
 bh=FlHURuThUCG/XaGtNSdhGq8awZ3MLFHA6LRuJDlmsKo=;
 h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
 b=p2MvK8yzQsjXMIVyYOEvFaVEb7jgu01RLg3lW5hxvRt19PVVotao6F2jDO9rTefGW
 dpkr0oPDE6rm0cnnZxfhSFnnJK2fLRtsvKdhDmkZRSvTIbgMHugdpOKBxcVE5CEibF
 R1D0dCx//2c++lBaCFDL5YLHQ+dwfvneqd9L1fVk=
To: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "David1.Zhou@amd.com" <David1.Zhou@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>
From: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH] Corrected the core clock speed for AMD HAINAN
Message-ID: <8N050z-kDUI3K6yjVnSIW52u4n8Q8SdAiAlWcmlMHx83oMerf70JNWvSl20GN_5ETbg92aBksrR1bGO2f3ADv3DnI5eEWIYMGFqD8F8v7Uw=@protonmail.com>
Feedback-ID: v3gTakqywBIYXeKntrQ6yy6583pNqH_nSJEjbgzjmBjMaZTDq3nLe0D-jSYppQY2NgolnS_R3Ad-LHjkRMDnTQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="b1_bda15a5c3b3dd6a00ac9884c78f02c61"
X-Mailman-Approved-At: Fri, 06 Mar 2020 08:03:08 +0000
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
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.

--b1_bda15a5c3b3dd6a00ac9884c78f02c61
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Empty Message

--b1_bda15a5c3b3dd6a00ac9884c78f02c61
Content-Type: application/octet-stream; name="mutt-yassine-HP-1000-4480-19426451861488017513"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=mutt-yassine-HP-1000-4480-19426451861488017513

U2lnbmVkLW9mZi1ieTogWWFzc2luZSBPdWRqYW5hIDx5Lm91ZGphbmFAcHJvdG9ubWFpbC5jb20+
Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2lfZHBtLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L3NpX2RwbS5jCmluZGV4IDRjYjRjODkxMTIwYi4uYzEzNzRmZTEzY2U4IDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zaV9kcG0uYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9zaV9kcG0uYwpAQCAtMzQ0NCw3ICszNDQ0LDcgQEAgc3RhdGljIHZvaWQg
c2lfYXBwbHlfc3RhdGVfYWRqdXN0X3J1bGVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
CQkgICAgKGFkZXYtPnBkZXYtPmRldmljZSA9PSAweDY2NjQpIHx8CiAJCSAgICAoYWRldi0+cGRl
di0+ZGV2aWNlID09IDB4NjY2NSkgfHwKIAkJICAgIChhZGV2LT5wZGV2LT5kZXZpY2UgPT0gMHg2
NjY3KSkgewotCQkJbWF4X3NjbGsgPSA3NTAwMDsKKwkJCW1heF9zY2xrID0gMTAzMDAwOwogCQl9
CiAJCWlmICgoYWRldi0+cGRldi0+cmV2aXNpb24gPT0gMHhDMykgfHwKIAkJICAgIChhZGV2LT5w
ZGV2LT5kZXZpY2UgPT0gMHg2NjY1KSkgewotLSAKMi4yNS4xCgo=


--b1_bda15a5c3b3dd6a00ac9884c78f02c61
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--b1_bda15a5c3b3dd6a00ac9884c78f02c61--

