Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E03C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AA62184C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 00:33:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AA62184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31A9B6EA2D;
	Tue, 12 Nov 2019 00:33:55 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800059.outbound.protection.outlook.com [40.107.80.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63716EA27
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 00:33:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0pXhiSCJoIBSepgofE+cpjIDST6tttpdsfK7YR63mjjKEIaRXD/NSYKuOBap/+svWjQlag5yJlZ3Ik4wUJpzidJxeU5Qjtgfy5qd7sNotAfVApKlW2ALxyuWVzQ7DGD4Z0qYUiaiy2+67pt6ayXd6W/JLlg8syoAIJS+aGUK2OrH//vhz+ZQHN69SjWik7Bl3fuz9mJk6LQ7Zp9wisVvxqIyzAFs4PYB9oEdsljZTpVSxCBmZqn7P/KtZweWgVHw0y4OYIF5jkCjb5uOe0z5fjKEhlodfBgFa5KIBaiip43M+nNmIWcNLbHHfHaLVzA++ugq7nT2VR2blxLLg2NOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bluBI+Cwp3h70cDiCQgxBT/b8kdlfy2+H3oz0F/HDs=;
 b=HcRyU3CDOF+DwRfxcWJIGw/3Pm98VOKroGI+0O6YJWcbbpQ8FE+JjvFh9sR+DOmrRxgyGP7tADEfuHunjm9PUxs6yAbUirRF0lKHQqTyvqePmznLcpdRQlfqUNM2F5BAcuo6YHYyedFby7JniZnyRcJiaK2nCM1vlOnjKzJdgGnDg2N+i1wYWIXNc8qF0TobCQ27viGQnLhE/l6Rkd/2nnPahiJ69CgqaFAVcDtjf1lFqRTjoq4fD5yMrf1lH6A86kk5PFSjw5NZnlKrd0ZpzAv7jJN5mhZm+A06ek8mQIa9y7lPlIwdsKFSDD8lLXB58g0BozkxGXv6/Xof5M5m3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2554.namprd12.prod.outlook.com (52.132.180.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Tue, 12 Nov 2019 00:33:53 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:33:53 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/30] drm/amd/display: Add DMUB param to load inst const from
 driver
Date: Mon, 11 Nov 2019 19:33:05 -0500
Message-Id: <20191112003324.8419-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
References: <20191112003324.8419-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 75a92e9e-d140-4cae-294e-08d76707fe6a
X-MS-TrafficTypeDiagnostic: MW2PR12MB2554:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB25545984C1B414881BD8F4DA98770@MW2PR12MB2554.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(189003)(199004)(76176011)(6916009)(81166006)(81156014)(386003)(8676002)(478600001)(6506007)(51416003)(52116002)(2870700001)(25786009)(14444005)(2906002)(186003)(2361001)(3846002)(316002)(66066001)(47776003)(50466002)(4326008)(26005)(66946007)(6116002)(36756003)(1076003)(8936002)(48376002)(50226002)(54906003)(2616005)(305945005)(486006)(5660300002)(6512007)(14454004)(2351001)(446003)(6486002)(6666004)(99286004)(66556008)(476003)(66476007)(11346002)(86362001)(6436002)(7736002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2554;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZC+A3FB2uEWKsMlglCkQfh9TSjDZs2YjzWkI8CCSnCxCX6TYCTr4OCFX7J5r5voOMniforqNIofS13bMwYgnr/V0rJ/VgH4IXHtrUEGAgUiuloJjSFJNPyBGHmUpuUueIergm341IBGy4S+KnwSlqISUcZqJiyJD+KGqD/tBvZcaSD5SIlxSqxvPPBy6fo92uFR4iN71axW2L7glUhFXm9nulUVGfN47VqocQqvKVGRmUucRi15se23EBZLCdKuPyPq/aMwcQiAQT6rguHoQgEw9v6Hvin0Pf/yif0JySQ0eRN4A6eaNm+7Q9qiYv181XlvwMy+GdzuB8Kfx/UF/Om47yZjPKeRcYg0iTcf7JkLOfC4qimPeTMAtgVIjr84pDvM80gVPo0JLwlUvy89Gy0EDr8XaUHOY/Q18j+Um+7aDwY+ZTshSCnwuCgVVP9pp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75a92e9e-d140-4cae-294e-08d76707fe6a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 00:33:52.8675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jy5JB2DETDLSIKbdbf6exCqY3u/ajLv7MVOayZwWxkehnZYlhDLFGgdZFDNIqYIEJjm2LzEOWKgITunEAzx33g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2554
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bluBI+Cwp3h70cDiCQgxBT/b8kdlfy2+H3oz0F/HDs=;
 b=j7GB14Rx2gmh6jw5sdzjAf960wzKCkxELrldpOmCpcEpxU725sfT8TOAVin8l8EETWX045CpMfyDlwmnMHt7UP52LYxL6YB+GijjX6XZCG+dtYXVzJjZsRCtFkqGUN4nElCXRe2UY1AZT3TMJ2bYuDmSRfIqlFk/WVNfnXVae/c=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
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
Cc: Tony Cheng <Tony.Cheng@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112003305.h9nH8lynzWLg7fxCs4pbqppjkuQJhuPGMSylu6o952c@z>

RnJvbTogTmljaG9sYXMgS2F6bGF1c2thcyA8bmljaG9sYXMua2F6bGF1c2thc0BhbWQuY29tPgoK
W1doeV0KQnkgZGVmYXVsdCB3ZSBzaG91bGRuJ3QgYmUgdHJ5aW5nIHRvIHdyaXRlIHNlY3VyZSBy
ZWdpc3RlcnMgZHVyaW5nCkRNVUIgaGFyZHdhcmUgaW5pdC4KCltIb3ddCkFkZCBhIHBhcmFtZXRl
ciB0byBjb250cm9sIHdoZXRoZXIgd2UgcHV0IHRoZSBETUNVQiBpbnRvIHNlY3VyZSByZXNldAph
bmQgYXR0ZW1wdCB0byBsb2FkIENXMC9DVzEuCgpTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBLYXps
YXVza2FzIDxuaWNob2xhcy5rYXpsYXVza2FzQGFtZC5jb20+ClJldmlld2VkLWJ5OiBUb255IENo
ZW5nIDxUb255LkNoZW5nQGFtZC5jb20+CkFja2VkLWJ5OiBSb2RyaWdvIFNpcXVlaXJhIDxSb2Ry
aWdvLlNpcXVlaXJhQGFtZC5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rt
dWIvaW5jL2RtdWJfc3J2LmggfCAyICsrCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11
Yi9zcmMvZG11Yl9zcnYuYyB8IDIgKy0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RtdWIvaW5jL2RtdWJfc3J2LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZG11Yi9p
bmMvZG11Yl9zcnYuaAppbmRleCA3NmU4MDEzODMwM2IuLjA0Njg4NTk0MGRiYSAxMDA2NDQKLS0t
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfc3J2LmgKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RtdWIvaW5jL2RtdWJfc3J2LmgKQEAgLTI4MSwx
MiArMjgxLDE0IEBAIHN0cnVjdCBkbXViX3Nydl9jcmVhdGVfcGFyYW1zIHsKICAqIEBmYl9iYXNl
OiBiYXNlIG9mIHRoZSBmcmFtZWJ1ZmZlciBhcGVydHVyZQogICogQGZiX29mZnNldDogb2Zmc2V0
IG9mIHRoZSBmcmFtZWJ1ZmZlciBhcGVydHVyZQogICogQHBzcF92ZXJzaW9uOiBwc3AgdmVyc2lv
biB0byBwYXNzIGZvciBETUNVIGluaXQKKyAqIEBsb2FkX2luc3RfY29uc3Q6IHRydWUgaWYgRE1V
QiBzaG91bGQgbG9hZCBpbnN0IGNvbnN0IGZ3CiAgKi8KIHN0cnVjdCBkbXViX3Nydl9od19wYXJh
bXMgewogCXN0cnVjdCBkbXViX2ZiICpmYltETVVCX1dJTkRPV19UT1RBTF07CiAJdWludDY0X3Qg
ZmJfYmFzZTsKIAl1aW50NjRfdCBmYl9vZmZzZXQ7CiAJdWludDMyX3QgcHNwX3ZlcnNpb247CisJ
Ym9vbCBsb2FkX2luc3RfY29uc3Q7CiB9OwogCiAvKioKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXViX3Nydi5jIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RtdWIvc3JjL2RtdWJfc3J2LmMKaW5kZXggMmQ2M2FlODBiZGE5Li4wZGQzMmVk
YmJjYjMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9k
bXViX3Nydi5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kbXViL3NyYy9kbXVi
X3Nydi5jCkBAIC0yNzgsNyArMjc4LDcgQEAgZW51bSBkbXViX3N0YXR1cyBkbXViX3Nydl9od19p
bml0KHN0cnVjdCBkbXViX3NydiAqZG11YiwKIAkJY3cxLnJlZ2lvbi5iYXNlID0gRE1VQl9DVzFf
QkFTRTsKIAkJY3cxLnJlZ2lvbi50b3AgPSBjdzEucmVnaW9uLmJhc2UgKyBzdGFja19mYi0+c2l6
ZSAtIDE7CiAKLQkJaWYgKGRtdWItPmh3X2Z1bmNzLmJhY2tkb29yX2xvYWQpCisJCWlmIChwYXJh
bXMtPmxvYWRfaW5zdF9jb25zdCAmJiBkbXViLT5od19mdW5jcy5iYWNrZG9vcl9sb2FkKQogCQkJ
ZG11Yi0+aHdfZnVuY3MuYmFja2Rvb3JfbG9hZChkbXViLCAmY3cwLCAmY3cxKTsKIAl9CiAKLS0g
CjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
YW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
