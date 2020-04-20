Return-Path: <SRS0=ehRF=6E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8AFC54FCC
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 06:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD902145D
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2020 06:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD902145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049366E25D;
	Mon, 20 Apr 2020 06:59:10 +0000 (UTC)
Received: from mail-m127108.qiye.163.com (mail-m127108.qiye.163.com
 [115.236.127.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61D616E11F;
 Mon, 20 Apr 2020 00:52:32 +0000 (UTC)
Received: from vivo.com (wm-13.qy.internal [127.0.0.1])
 by mail-m127108.qiye.163.com (Hmail) with ESMTP id 8C1C0842195;
 Mon, 20 Apr 2020 08:51:54 +0800 (CST)
Message-ID: <AJ6AmADaCLivAKtTLreYUqof.3.1587343914555.Hmail.bernard@vivo.com>
To: Markus Elfring <Markus.Elfring@web.de>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL2FtZGdwdTogUmVkdWNlIGEgbG9jayBzY29wZSBpbiBhbWRncHVfYW1ka2ZkX2dwdXZtX2ZyZWVfbWVtb3J5X29mX2dwdSgp?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail (
 [127.0.0.1] ) ; Mon, 20 Apr 2020 08:51:54 +0800 (GMT+08:00)
From: =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date: Mon, 20 Apr 2020 08:51:54 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVNQk9LS0tJT09KT0tNSVlXWShZQU
 hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSEtJTUlOTEJLN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
 WUc6MU06Fjo*Gjg3Eg06MA8vNwkeIi4KFB1VSFVKTkNMSE9IQkpPTUNMVTMWGhIXVRkeCRUaCR87
 DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBSE5MSTcG
X-HM-Tid: 0a719511f656986ckuuu8c1c0842195
X-Mailman-Approved-At: Mon, 20 Apr 2020 06:59:07 +0000
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
 =?UTF-8?Q?Felix_K=C3=BChling?= <Felix.Kuehling@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, kernel@vivo.com,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpGcm9tOiBNYXJrdXMgRWxmcmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPgpEYXRlOiAyMDIw
LTA0LTE5IDE3OjA1OjA3ClRvOiAgQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPixhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZyxkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
LEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4sIkNocmlzdGlhbiBLw7Zu
aWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LENodW5taW5nIFpob3UgPERhdmlkMS5aaG91
QGFtZC5jb20+LCJGZWxpeCBLw7xobGluZyIgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+CkNjOiAg
a2VybmVsQHZpdm8uY29tLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsRGFuaWVsIFZldHRl
ciA8ZGFuaWVsQGZmd2xsLmNoPixEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+ClN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRncHU6IFJlZHVjZSBhIGxvY2sgc2NvcGUgaW4gYW1kZ3B1
X2FtZGtmZF9ncHV2bV9mcmVlX21lbW9yeV9vZl9ncHUoKT4+IE1heWJlIHdlIGNvdWxkIHJlZHVj
ZSB0aGUgbXV0ZXhfbG9jaygmbWVtLT5sb2NrKWBzIHByb3RlY3RlZCBjb2RlIGFyZWEsCj4+IGFu
ZCBub25lZWQgdG8gcHJvdGVjdCBwcl9kZWJ1Zy4KPgo+SSBzdWdnZXN0IHRvIGltcHJvdmUgdGhl
IGNvbW1pdCBtZXNzYWdlLgo+V291bGQgeW91IGxpa2UgdG8gYWRqdXN0IHRoZSBwYXRjaCBzdWJq
ZWN0Pwo+Cj5EbyB5b3UgaW1hZ2luZSB0aGF0IGRhdGEgc3luY2hyb25pc2F0aW9uIHNob3VsZCBl
dm9sdmUgaW4gb3RoZXIgd2F5cz8KPgo+UmVnYXJkcywKPk1hcmt1cwoKU3VyZSwgSSB3aWxsIG1v
ZGlmeSB0aGUgY29kZSBhbmQgYWRqdXN0IHRoaXMgcGF0Y2ggc3ViamVjdC4gSSB3aWxsIHN1Ym1p
dCBpdCBhZ2Fpbi4KCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
