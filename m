Return-Path: <SRS0=8kND=ZE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6E3C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 01:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D56DF206C3
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2019 01:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56DF206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE4089BA1;
	Tue, 12 Nov 2019 01:47:25 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690060.outbound.protection.outlook.com [40.107.69.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5672E89249
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2019 01:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnSTf1Bvk+QXwtJmi7L8QPoE7mY9XY/edgedMUwLeBO/icnN2P8SFnlH2/f17rGaOqjRhjhAy6PnkPrbcvPLY+7jZFHx8SDl2CHbqsHlLLZ333pExdeWJI/ckTiD1K2md/vnvD43k/nVhMHt7UGXCJ0xtDiZrd/8k7B+z52OPuOCzUhaHzVl8Ep1WY3rylQ5+1kdpxyDIk3lNykzaLvwTcNA1qFz4RvgxZzAr9mxL3gWa1u3aIxYTmJ8O+g570zVPKk5/Wx7pCSQW0xzivPss5gzqWBmQSbA2fHWHU3GygXFD4FlN6mVUHBMZujW8iu1u1Uj7jv/PamF5pJqM7crVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiaEpB9uhQnEF+zYrFoqj/4ogOUx8gvxBOUNz88wOYA=;
 b=MQDEMFLcRtGCXe+oSmTZOMdLUyZUr6o4zMwoMeSV3EbPuIPHxnhkOWz5ckolpU5/yYeH8h6vUXwsUdTsWH0QcJRBKBz9gbaimkInxL8C+Udle2a2vheqK2KNLrabCNNaVuZfr9InSAqccdfCDiYvm90W6FG1ZG386nTps2gRVU3tcAqJzByCgxR5Fbm/CWdKxtuv0ImNIYGM6Pbyzpt00G/upEoJcenF55oXLdNylTt76VbTslEEOIiZY+p5vjb9khmFUN7OjA7JQPAOqfwGSPwCMhdRkzyV/zYIXJGYNmv9aQjBUxwVzPCsrWskbZoUMGMvLy24wF2Y7u+lTaP/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3822.namprd12.prod.outlook.com (10.255.237.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.24; Tue, 12 Nov 2019 01:47:21 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::5895:bbd8:c1d6:1587%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 01:47:20 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: avoid DPM reenable process on Navi1x ASICs
 V2
Date: Tue, 12 Nov 2019 09:46:53 +0800
Message-Id: <20191112014653.21325-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.24.0
X-ClientProxiedBy: HK0P153CA0026.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::14) To MN2PR12MB3344.namprd12.prod.outlook.com
 (2603:10b6:208:c5::10)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e756315-2637-48bd-7aa5-08d7671241b1
X-MS-TrafficTypeDiagnostic: MN2PR12MB3822:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB382287FCC01881A25EE81396E4770@MN2PR12MB3822.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-Forefront-PRVS: 021975AE46
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(6512007)(48376002)(52116002)(51416003)(6486002)(6506007)(6436002)(14454004)(36756003)(478600001)(25786009)(6666004)(1076003)(5660300002)(86362001)(99286004)(47776003)(50226002)(2906002)(8676002)(81166006)(386003)(8936002)(81156014)(4326008)(54906003)(50466002)(2361001)(2351001)(316002)(26005)(186003)(7736002)(3846002)(486006)(6916009)(6116002)(66066001)(2870700001)(66476007)(66946007)(66556008)(305945005)(2616005)(476003)(44832011)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3822;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvGZQqKrmnDh/+a5ZSW9t0K0s7C7d14TNGD5sS30xSTcJQGf3SnSSZQX8gUjQIOra1Zk/aHUEoQsg1aExpAQisJUT1NMWQqHqgYumcNnWqYhcXeZfFgxTwb6dsAiHc5JSeVCZhz8JW2oSnQv5YlFFbWP2eY/82KxPMf5fMBy4OvUKgH2xrnG7ZEHgmHOvFBAMHxGKwB/Rp1b9c/iztYlVKM6d/t3w+tFpIljm3Bbn+DfDn1gjcBODPURmT6+oebVatQ2s8rkQ7MygedLlMICcGG6069xKA58oa6myOgFAjUmN4xJRvmwOZWfhhxx6OfHJuISd0zBW5GXqF97h6/VXrxFvJ1TJMIUZqSFg9/cLRAii/43WL4Tt4vfodG4RHNvrti/Vrs38aqXs9UcFsLl+AdNSYxYNZOgeD3vR1hlDw4GAlQ1TwARTRcg9yWtVW2y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e756315-2637-48bd-7aa5-08d7671241b1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2019 01:47:20.8945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhrPMhb2fCHuUJZZZzrzQDugexfpJ1SKDSlDJDBGERuzEAYUf6ihmr4tDdZ7l62b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3822
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiaEpB9uhQnEF+zYrFoqj/4ogOUx8gvxBOUNz88wOYA=;
 b=pI7dLbVjBw76a/AL7Po4wJl1R2jvUocjljO9PCEhtAjrAWeUiZL7xeWroBKcszoDYqOKLZQloej5ugUdhLEFBj+iHWHYhuRA3lhZ/n9hrLezHATU+37sVEht/US8p/lt+XvLI0/71ymDpeJ5xo670o5EZC3Fg+k50lpSHJ8IaIs=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
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
Cc: alexdeucher@gmail.com, Matt Coffin <mcoffin13@gmail.com>,
 Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191112014653.97qgGE2UrV9RKBMEO6KBSpK6ODtu8I-7Atgven3GLE0@z>

T3RoZXJ3aXNlLCB3aXRob3V0IFJMQyByZWluaXRpYWxpemF0aW9uLCB0aGUgRFBNIHJlZW5hYmxl
bWVudAp3aWxsIGZhaWwuIFRoYXQgYWZmZWN0cyB0aGUgY3VzdG9tIHBwdGFibGUgdXBsb2FkaW5n
LgoKVjI6IHNldHRpbmcvY2xlYXJpbmcgdXBsb2FkaW5nX2N1c3RvbV9wcF90YWJsZSBpbgogICAg
c211X3N5c19zZXRfcHBfdGFibGUoKQoKQ2hhbmdlLUlkOiBJNmZlMmVkNWNlMjNmMmE1YjY2ZjM3
MWMwYjZkMWY5MjQ4MzdlNWFmNgpSZXBvcnRlZC1ieTogTWF0dCBDb2ZmaW4gPG1jb2ZmaW4xM0Bn
bWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEV2YW4gUXVhbiA8ZXZhbi5xdWFuQGFtZC5jb20+ClRl
c3RlZC1ieTogTWF0dCBDb2ZmaW4gPG1jb2ZmaW4xM0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9wb3dlcnBsYXkvYW1kZ3B1X3NtdS5jICAgIHwgMzEgKysrKysrKysrKysrKysr
Ky0tLQogLi4uL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oICAgIHwgIDEg
KwogMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdwdV9zbXUuYwppbmRleCA3NmE0MTU0YjNi
ZTIuLjU0YzIxZjVhMTg2MSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBs
YXkvYW1kZ3B1X3NtdS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG93ZXJwbGF5L2FtZGdw
dV9zbXUuYwpAQCAtNTkxLDEwICs1OTEsMTggQEAgaW50IHNtdV9zeXNfc2V0X3BwX3RhYmxlKHN0
cnVjdCBzbXVfY29udGV4dCAqc211LCAgdm9pZCAqYnVmLCBzaXplX3Qgc2l6ZSkKIAlzbXVfdGFi
bGUtPnBvd2VyX3BsYXlfdGFibGUgPSBzbXVfdGFibGUtPmhhcmRjb2RlX3BwdGFibGU7CiAJc211
X3RhYmxlLT5wb3dlcl9wbGF5X3RhYmxlX3NpemUgPSBzaXplOwogCisJLyoKKwkgKiBTcGVjaWFs
IGh3X2ZpbmkgYWN0aW9uKGZvciBOYXZpMXgsIHRoZSBEUE1zIGRpc2FibGVtZW50IHdpbGwgYmUK
KwkgKiBza2lwcGVkKSBtYXkgYmUgbmVlZGVkIGZvciBjdXN0b20gcHB0YWJsZSB1cGxvYWRpbmcu
CisJICovCisJc211LT51cGxvYWRpbmdfY3VzdG9tX3BwX3RhYmxlID0gdHJ1ZTsKKwogCXJldCA9
IHNtdV9yZXNldChzbXUpOwogCWlmIChyZXQpCiAJCXByX2luZm8oInNtdSByZXNldCBmYWlsZWQs
IHJldCA9ICVkXG4iLCByZXQpOwogCisJc211LT51cGxvYWRpbmdfY3VzdG9tX3BwX3RhYmxlID0g
ZmFsc2U7CisKIGZhaWxlZDoKIAltdXRleF91bmxvY2soJnNtdS0+bXV0ZXgpOwogCXJldHVybiBy
ZXQ7CkBAIC0xMjkzLDEwICsxMzAxLDI1IEBAIHN0YXRpYyBpbnQgc211X2h3X2Zpbmkodm9pZCAq
aGFuZGxlKQogCQlyZXR1cm4gcmV0OwogCX0KIAotCXJldCA9IHNtdV9zdG9wX2RwbXMoc211KTsK
LQlpZiAocmV0KSB7Ci0JCXByX3dhcm4oIkZhaWwgdG8gc3RvcCBEcG1zIVxuIik7Ci0JCXJldHVy
biByZXQ7CisJLyoKKwkgKiBGb3IgY3VzdG9tIHBwdGFibGUgdXBsb2FkaW5nLCBza2lwIHRoZSBE
UE0gZmVhdHVyZXMKKwkgKiBkaXNhYmxlIHByb2Nlc3Mgb24gTmF2aTF4IEFTSUNzLgorCSAqICAg
LSBBcyB0aGUgZ2Z4IHJlbGF0ZWQgZmVhdHVyZXMgYXJlIHVuZGVyIGNvbnRyb2wgb2YKKwkgKiAg
ICAgUkxDIG9uIHRob3NlIEFTSUNzLiBSTEMgcmVpbml0aWFsaXphdGlvbiB3aWxsIGJlCisJICog
ICAgIG5lZWRlZCB0byByZWVuYWJsZSB0aGVtLiBUaGF0IHdpbGwgY29zdCBtdWNoIG1vcmUKKwkg
KiAgICAgZWZmb3J0cy4KKwkgKgorCSAqICAgLSBTTVUgZmlybXdhcmUgY2FuIGhhbmRsZSB0aGUg
RFBNIHJlZW5hYmxlbWVudAorCSAqICAgICBwcm9wZXJseS4KKwkgKi8KKwlpZiAoIXNtdS0+dXBs
b2FkaW5nX2N1c3RvbV9wcF90YWJsZSB8fAorCSAgICAhKChhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJ
UF9OQVZJMTApICYmCisJICAgICAgKGFkZXYtPmFzaWNfdHlwZSA8PSBDSElQX05BVkkxMikpKSB7
CisJCXJldCA9IHNtdV9zdG9wX2RwbXMoc211KTsKKwkJaWYgKHJldCkgeworCQkJcHJfd2Fybigi
RmFpbCB0byBzdG9wIERwbXMhXG4iKTsKKwkJCXJldHVybiByZXQ7CisJCX0KIAl9CiAKIAlrZnJl
ZSh0YWJsZV9jb250ZXh0LT5kcml2ZXJfcHB0YWJsZSk7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3NtdS5oIGIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9wb3dlcnBsYXkvaW5jL2FtZGdwdV9zbXUuaAppbmRleCA4MTIwZTc1ODc1ODUuLjIxNTg0MWY1
ZmI5MyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wb3dlcnBsYXkvaW5jL2FtZGdw
dV9zbXUuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3Bvd2VycGxheS9pbmMvYW1kZ3B1X3Nt
dS5oCkBAIC0zOTEsNiArMzkxLDcgQEAgc3RydWN0IHNtdV9jb250ZXh0CiAKIAl1aW50MzJfdCBz
bWNfaWZfdmVyc2lvbjsKIAorCWJvb2wgdXBsb2FkaW5nX2N1c3RvbV9wcF90YWJsZTsKIH07CiAK
IHN0cnVjdCBpMmNfYWRhcHRlcjsKLS0gCjIuMjQuMAoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4
