Return-Path: <SRS0=5Use=ZK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59C5C432C3
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 05:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9063620726
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2019 05:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9063620726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59DFE89B78;
	Mon, 18 Nov 2019 05:18:56 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe46::603])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4313189B78
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2019 05:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWIZ5gTxdu0dVR2WNIqUy6tAgTTKRTICl+qh64vyKciU070Kvqhe8msXaDepsMuhd8IM3PzgJQbgxFY94H1NVRzWZG4Yf0DKRR/FeUd/DSTngkUg4xFiBPTKmkyhYfFIlNrsA6E/0ALIAnf0zQbOpVxQcH1d0vosIjIcXQDOMyPZSKFT2V4tiRHocPqLQFNzQK1r2peibreQ3ptNtQt1CEtNx9frkk8PcyqIyTtV8VN8mTZ7OZlBs1JIdsW3GXnsMR151oLbPuFz9mEJBjNwHZdBVzJV4cGlxMgjxGyOEdiktVxYowvvIbDH//ok1r59Yx6Kr9toDq+BIIrhB9Qa+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwaKI6c04Y2wPkcCZDWo6S3F+NJrRu5gOn9E9eRfGiQ=;
 b=cKRtuRWldkNlZyFtFSfz/Rgvtw9piMK3SVFbzIbTDi2WCO5jr5KOFBBpEndp3aL0TpQ9nLcOtazgNyDJgD0lTn55OXu6KZsJimoOGDvBAOwRGOTb0loapqkQXS7+7uPWAxjbwOFahESprNSAYmjA73o2siXyCew/bSDdwZNK2wDJ6vHtomWJ9z8MpTRg1dww+0k0kicDKg49QXJbZ8UL2boDmEK8dAXnEHYhImf+yV6U+UPgS4WH4FfiSTCR4YJW1PIJrkLn4l5MdlMPEd8tq9jRsEs+Oe4Lb25MNLmA6gx6VW7EWH3MFacgBVA8aGMJXirAxSoHa2TnSf24B26SyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3712.namprd12.prod.outlook.com (10.255.236.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Mon, 18 Nov 2019 05:18:52 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 05:18:52 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: expand amdgpu_copy_buffer interface with tmz
 parameter
Date: Mon, 18 Nov 2019 13:18:33 +0800
Message-Id: <1574054316-2802-2-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
References: <1574054316-2802-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK2PR04CA0059.apcprd04.prod.outlook.com
 (2603:1096:202:14::27) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b26258e4-ca43-4d5b-5350-08d76be6cd1f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3712:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB371261CBDF2AE493112D34B4F04D0@MN2PR12MB3712.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0225B0D5BC
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(199004)(189003)(86362001)(486006)(44832011)(2616005)(476003)(2351001)(66476007)(11346002)(25786009)(5660300002)(446003)(386003)(6436002)(66946007)(36756003)(26005)(6512007)(50226002)(8936002)(186003)(81156014)(8676002)(81166006)(66556008)(6486002)(66066001)(478600001)(305945005)(14444005)(6506007)(2361001)(66574012)(316002)(47776003)(23676004)(6116002)(50466002)(3846002)(52116002)(4326008)(2870700001)(2906002)(99286004)(76176011)(6916009)(7736002)(14454004)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3712;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3JABfrpCcXJO+rrV3OTD7408LoffMwp8sbBEz/XBxAioNUcqAgQbDCUOcjB5YzG5g/AfzT/sUET6UmjKj/nf0tl+gSS59MlhyPzBXyxjgxWJ1fYKLgkUZQFOlqpjfkqkEV+Ni3QPbgITGDTjTvMzrA32AXoFzSyFTSfDtLiMBIf+KvxHC8/6EAa371xgvSA1H9U5JWL3TVS29tAr6n1kjeBD1ppI2oEZ9LcZC/fjarSdk0XWis9NbwXj8Ysa7gp/0DhhmIFdntTbAQkAE6PWcXEGKnOB/u7gylHOJRwrsDckUBY/fpBjrfW/r+iFpf3Wjed6uKqm7NPl6lO8HehiR4NlyJjyN8X0Q9TGiHOgdHBnpFphr/y3KIpMcVR80DONlzDeS34b7sMmfrclSpbJv3M8n+NQuzqmZqk4WUcWJTBx/kGIkewE8DgQoYbqNL/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26258e4-ca43-4d5b-5350-08d76be6cd1f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 05:18:52.6395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7VDQKpR7VslZCN0AH8iCmqVNtvPT+IfF0V5+q9Z1+vZBqj45pGBos5ft3uJbC+Kb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3712
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwaKI6c04Y2wPkcCZDWo6S3F+NJrRu5gOn9E9eRfGiQ=;
 b=lAfw4RhscNF36tvVapjaI78DfwK63O3dumlGnNG5EOhnB2czI2zfrmVAzmgSvJoylu/zXeqkL42e5f20r4tpQgdbWXa0uMjuNS0cppO25JfVZxijURQx8r18fNHWS+G1O5/kmCPyPEJgojjkF+7ENPI1Lm4buawDwVvqhHid9Vc=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
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
Cc: Alexander.Deucher@amd.com, Luben.Tuikov@amd.com, Ray.Huang@amd.com,
 Christian.Koenig@amd.com, Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191118051833.nBwqdsZh3OwC7eE3BUyujOmlC_0x-BHKPl-RRJYI5Qg@z>

VGhpcyBwYXRjaCBleHBhbmRzIGFtZGdwdV9jb3B5X2J1ZmZlciBpbnRlcmZhY2Ugd2l0aCB0bXog
cGFyYW1ldGVyLgoKU2lnbmVkLW9mZi1ieTogQWFyb24gTGl1IDxhYXJvbi5saXVAYW1kLmNvbT4K
UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
LS0tCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMgfCAyICst
CiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMgICAgfCAyICstCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdGVzdC5jICAgICAgfCA0ICsrLS0KIGRy
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyAgICAgICB8IDYgKysrLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmggICAgICAgfCAyICstCiA1IGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYmVuY2htYXJrLmMKaW5kZXggZDE0OTVlMS4uZDli
MzVkZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2JlbmNo
bWFyay5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9iZW5jaG1hcmsu
YwpAQCAtNDAsNyArNDAsNyBAQCBzdGF0aWMgaW50IGFtZGdwdV9iZW5jaG1hcmtfZG9fbW92ZShz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgdW5zaWduZWQgc2l6ZSwKIAlmb3IgKGkgPSAwOyBp
IDwgbjsgaSsrKSB7CiAJCXN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9IGFkZXYtPm1tYW4uYnVm
ZmVyX2Z1bmNzX3Jpbmc7CiAJCXIgPSBhbWRncHVfY29weV9idWZmZXIocmluZywgc2FkZHIsIGRh
ZGRyLCBzaXplLCBOVUxMLCAmZmVuY2UsCi0JCQkJICAgICAgIGZhbHNlLCBmYWxzZSk7CisJCQkJ
ICAgICAgIGZhbHNlLCBmYWxzZSwgZmFsc2UpOwogCQlpZiAocikKIAkJCWdvdG8gZXhpdF9kb19t
b3ZlOwogCQlyID0gZG1hX2ZlbmNlX3dhaXQoZmVuY2UsIGZhbHNlKTsKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYwppbmRleCBiOGU1MDc2Li5iYmEzNDg1IDEwMDY0
NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfb2JqZWN0LmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X29iamVjdC5jCkBAIC03NTIsNyArNzUy
LDcgQEAgaW50IGFtZGdwdV9ib19yZXN0b3JlX3NoYWRvdyhzdHJ1Y3QgYW1kZ3B1X2JvICpzaGFk
b3csIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSkKIAogCXJldHVybiBhbWRncHVfY29weV9idWZm
ZXIocmluZywgc2hhZG93X2FkZHIsIHBhcmVudF9hZGRyLAogCQkJCSAgYW1kZ3B1X2JvX3NpemUo
c2hhZG93KSwgTlVMTCwgZmVuY2UsCi0JCQkJICB0cnVlLCBmYWxzZSk7CisJCQkJICB0cnVlLCBm
YWxzZSwgZmFsc2UpOwogfQogCiAvKioKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90ZXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dGVzdC5jCmluZGV4IGIxNTgyMzAuLjQ3NmYxZjggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV90ZXN0LmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3Rlc3QuYwpAQCAtMTI0LDcgKzEyNCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9k
b190ZXN0X21vdmVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlhbWRncHVfYm9fa3Vu
bWFwKGd0dF9vYmpbaV0pOwogCiAJCXIgPSBhbWRncHVfY29weV9idWZmZXIocmluZywgZ2FydF9h
ZGRyLCB2cmFtX2FkZHIsCi0JCQkJICAgICAgIHNpemUsIE5VTEwsICZmZW5jZSwgZmFsc2UsIGZh
bHNlKTsKKwkJCQkgICAgICAgc2l6ZSwgTlVMTCwgJmZlbmNlLCBmYWxzZSwgZmFsc2UsIGZhbHNl
KTsKIAogCQlpZiAocikgewogCQkJRFJNX0VSUk9SKCJGYWlsZWQgR1RULT5WUkFNIGNvcHkgJWRc
biIsIGkpOwpAQCAtMTcwLDcgKzE3MCw3IEBAIHN0YXRpYyB2b2lkIGFtZGdwdV9kb190ZXN0X21v
dmVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogCQlhbWRncHVfYm9fa3VubWFwKHZyYW1f
b2JqKTsKIAogCQlyID0gYW1kZ3B1X2NvcHlfYnVmZmVyKHJpbmcsIHZyYW1fYWRkciwgZ2FydF9h
ZGRyLAotCQkJCSAgICAgICBzaXplLCBOVUxMLCAmZmVuY2UsIGZhbHNlLCBmYWxzZSk7CisJCQkJ
ICAgICAgIHNpemUsIE5VTEwsICZmZW5jZSwgZmFsc2UsIGZhbHNlLCBmYWxzZSk7CiAKIAkJaWYg
KHIpIHsKIAkJCURSTV9FUlJPUigiRmFpbGVkIFZSQU0tPkdUVCBjb3B5ICVkXG4iLCBpKTsKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYwppbmRleCBjMDhjMTVlLi4xYTE4YWFj
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdHRtLmMKKysr
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5jCkBAIC0zNzYsNyArMzc2
LDcgQEAgaW50IGFtZGdwdV90dG1fY29weV9tZW1fdG9fbWVtKHN0cnVjdCBhbWRncHVfZGV2aWNl
ICphZGV2LAogCQl9CiAKIAkJciA9IGFtZGdwdV9jb3B5X2J1ZmZlcihyaW5nLCBmcm9tLCB0bywg
Y3VyX3NpemUsCi0JCQkJICAgICAgIHJlc3YsICZuZXh0LCBmYWxzZSwgdHJ1ZSk7CisJCQkJICAg
ICAgIHJlc3YsICZuZXh0LCBmYWxzZSwgdHJ1ZSwgZmFsc2UpOwogCQlpZiAocikKIAkJCWdvdG8g
ZXJyb3I7CiAKQEAgLTIwNTIsNyArMjA1Miw3IEBAIGludCBhbWRncHVfY29weV9idWZmZXIoc3Ry
dWN0IGFtZGdwdV9yaW5nICpyaW5nLCB1aW50NjRfdCBzcmNfb2Zmc2V0LAogCQkgICAgICAgdWlu
dDY0X3QgZHN0X29mZnNldCwgdWludDMyX3QgYnl0ZV9jb3VudCwKIAkJICAgICAgIHN0cnVjdCBk
bWFfcmVzdiAqcmVzdiwKIAkJICAgICAgIHN0cnVjdCBkbWFfZmVuY2UgKipmZW5jZSwgYm9vbCBk
aXJlY3Rfc3VibWl0LAotCQkgICAgICAgYm9vbCB2bV9uZWVkc19mbHVzaCkKKwkJICAgICAgIGJv
b2wgdm1fbmVlZHNfZmx1c2gsIGJvb2wgdG16KQogewogCXN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2ID0gcmluZy0+YWRldjsKIAlzdHJ1Y3QgYW1kZ3B1X2pvYiAqam9iOwpAQCAtMjA5Myw3ICsy
MDkzLDcgQEAgaW50IGFtZGdwdV9jb3B5X2J1ZmZlcihzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmcs
IHVpbnQ2NF90IHNyY19vZmZzZXQsCiAJCXVpbnQzMl90IGN1cl9zaXplX2luX2J5dGVzID0gbWlu
KGJ5dGVfY291bnQsIG1heF9ieXRlcyk7CiAKIAkJYW1kZ3B1X2VtaXRfY29weV9idWZmZXIoYWRl
diwgJmpvYi0+aWJzWzBdLCBzcmNfb2Zmc2V0LAotCQkJCQlkc3Rfb2Zmc2V0LCBjdXJfc2l6ZV9p
bl9ieXRlcywgZmFsc2UpOworCQkJCQlkc3Rfb2Zmc2V0LCBjdXJfc2l6ZV9pbl9ieXRlcywgdG16
KTsKIAogCQlzcmNfb2Zmc2V0ICs9IGN1cl9zaXplX2luX2J5dGVzOwogCQlkc3Rfb2Zmc2V0ICs9
IGN1cl9zaXplX2luX2J5dGVzOwpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3R0bS5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3R0bS5o
CmluZGV4IDBkZGRlZGMuLmYxZWJkNDIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV90dG0uaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdHRtLmgKQEAgLTg3LDcgKzg3LDcgQEAgaW50IGFtZGdwdV9jb3B5X2J1ZmZlcihzdHJ1Y3Qg
YW1kZ3B1X3JpbmcgKnJpbmcsIHVpbnQ2NF90IHNyY19vZmZzZXQsCiAJCSAgICAgICB1aW50NjRf
dCBkc3Rfb2Zmc2V0LCB1aW50MzJfdCBieXRlX2NvdW50LAogCQkgICAgICAgc3RydWN0IGRtYV9y
ZXN2ICpyZXN2LAogCQkgICAgICAgc3RydWN0IGRtYV9mZW5jZSAqKmZlbmNlLCBib29sIGRpcmVj
dF9zdWJtaXQsCi0JCSAgICAgICBib29sIHZtX25lZWRzX2ZsdXNoKTsKKwkJICAgICAgIGJvb2wg
dm1fbmVlZHNfZmx1c2gsIGJvb2wgdG16KTsKIGludCBhbWRncHVfdHRtX2NvcHlfbWVtX3RvX21l
bShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSAgICAgICBzdHJ1Y3QgYW1kZ3B1X2Nv
cHlfbWVtICpzcmMsCiAJCQkgICAgICAgc3RydWN0IGFtZGdwdV9jb3B5X21lbSAqZHN0LAotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
