Return-Path: <SRS0=Di3h=ZM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A775C432C0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 16:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 081B120718
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Nov 2019 16:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081B120718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F5C6E784;
	Wed, 20 Nov 2019 16:38:32 +0000 (UTC)
Received: from NAM01-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr740072.outbound.protection.outlook.com [40.107.74.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86C3E6E784
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Nov 2019 16:38:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzS671I0xFP+TAnd06PsSV6Q7LXd64BCs4WYQ9bD1E1R5f831RlXdBG9AC1zxd0DHH1vk4PIqfgrhX5PrAsuu6QlATFZu27dm8+L5l/DnnF+LBGqiFULjr3G4lRnhBOeCUfazD77C6LwH2UbMbZ1CWYBO2vYSG2Jn+jlBQ9jyr9W1t3U1bBdV9epO8OazGw4WwgWVx7GNIDeTKOmFsNkmEhD5YEpcA69GeHHrmCQpNJk6Xh/yc2OLy/153UspcmMN7bIBoEdmbpTx9RcfumGnWf9MJFRC60r5fOPxodLml92wi6aFJ0HHT1OSg2pCG0NFotE5kVt1x0gb0nAUlrKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN6hCH05W52EP9I1gfqVjkkUf6RonUo1sib3ZyIDyOI=;
 b=QscGMmRZvqu5Guz5txjfaoVRCKpt07CZjkja53pWqFWCggcgX+/h5u/t8uHdMIWEqdToZVeslBCYzoA8nnlOoGhr/xE3ut3uaDSSgIa3N6YkKSMO8DjuV8moKthHl5FN36bIlcnpOn4v22E57Z8S7eCLb1BjkMCwXOvBz56+uGvUnbOXg3r0NneHTu5CidwVpZSk0Zct6QTX3wUwjTCRnKA+rRqjsM1bORR0g1LdRrheYiBCuy2vGXsgrTdzrq9jVjxkxBLQx+1RRokHpTAIYzV+B9UDYZoAp1lPIjP3JYnPZ6sXMiNTGN6Qu5H7/viL81tlddF0LN1rzDpZi5Ox/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB3305.namprd12.prod.outlook.com (20.179.106.93) by
 DM6PR12MB3915.namprd12.prod.outlook.com (10.255.174.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Wed, 20 Nov 2019 16:38:29 +0000
Received: from DM6PR12MB3305.namprd12.prod.outlook.com
 ([fe80::c011:ca1b:5955:e518]) by DM6PR12MB3305.namprd12.prod.outlook.com
 ([fe80::c011:ca1b:5955:e518%7]) with mapi id 15.20.2474.018; Wed, 20 Nov 2019
 16:38:29 +0000
From: Jay Cornwall <jay.cornwall@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Update Arcturus golden registers
Date: Wed, 20 Nov 2019 10:38:11 -0600
Message-Id: <1574267891-25174-1-git-send-email-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: DM3PR08CA0024.namprd08.prod.outlook.com
 (2603:10b6:0:52::34) To DM6PR12MB3305.namprd12.prod.outlook.com
 (2603:10b6:5:189::29)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 47305d44-a35a-4265-70b2-08d76dd81287
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3915588CC06D8308BEE96E4D874F0@DM6PR12MB3915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(199004)(189003)(2906002)(6436002)(16586007)(6666004)(316002)(6486002)(66556008)(66476007)(186003)(44832011)(36756003)(48376002)(26005)(50466002)(6116002)(3846002)(4326008)(486006)(52116002)(14454004)(51416003)(6506007)(386003)(305945005)(66946007)(86362001)(476003)(2351001)(8936002)(2616005)(81166006)(81156014)(478600001)(5660300002)(7736002)(6916009)(4744005)(99286004)(2361001)(8676002)(66066001)(47776003)(25786009)(6512007)(50226002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3915;
 H:DM6PR12MB3305.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8mttChujrCjhuPUMfyXNhh/IN8rE3Zw1mTi8K0Uaeh0ZUO66Yivtp+T15Mv+jPL9NLZXY5j34ylvKCQMymSxE2kQazwPbqGzZ0loogolStW01rak0EPOkWalEUHsTrMADqegjDBrl7SK3f8laRa6hqEIj7Wl3mAY0KC6/6mYU4UTlI8fPuD9CDPCGkyau0/5AQXdkebIhZkz3MryhZzGR1R5OGM8xnkE7wrc4V5rklWItRk08qtArZNv1a62NiLYd1mdUws+Ol8gN/xhayFXNHbgyZOT16z7jmuBuWLPg66QlK+qQuQWMCsXaNDood72Q2oJwA31NKXOfGfwJrP+BhrO4EzcvKg+C97xTDIMXVPvpW1I3htU39zqVMilZKWxTqxidfRBE1kwJr6Xoy4eSq6fq80SJ+H/KNT9xLWII9v85rQH5PeNrMxMejIXYi8t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47305d44-a35a-4265-70b2-08d76dd81287
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 16:38:29.0042 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vANVDmGuYLVohP6D83XuuY8+RY8Yb2rOC8gflExZAec0IRm8iqInLEtJDD6Yej/iStO/bMlqKJ7S4VnZW8uiEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EN6hCH05W52EP9I1gfqVjkkUf6RonUo1sib3ZyIDyOI=;
 b=lZ1dxtueh7mrZf1Qkb0Mjqg0+TxIITWAuQSfnO2zvfbFcbSE5rGAq9J+1mEcIym40krsCwxeu0E3c+dKjgmOcH0ty2kyZT1+RnimOdnrU4Nnuq4kwsq80p/Vb0M/eBUGA7LJnP75Ldnd6VuW2d0roym6EKpoIBuwhpJ8iYN7CG8=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jay.Cornwall@amd.com; 
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
Cc: Jay Cornwall <jay.cornwall@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191120163811.HHClKseSRU5eFWtLDWuYwYUghsprlrEASsU2q5JGmDs@z>

U2lnbmVkLW9mZi1ieTogSmF5IENvcm53YWxsIDxqYXkuY29ybndhbGxAYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjlfMC5jIHwgMSArCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3Y5XzAuYwppbmRl
eCA4MDczZmNkLi45ZjkwNDQ4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9nZnhfdjlfMC5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMK
QEAgLTY5Miw2ICs2OTIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNvYzE1X3JlZ19nb2xkZW4g
Z29sZGVuX3NldHRpbmdzX2djXzlfNF8xX2FyY3RbXSA9CiAJU09DMTVfUkVHX0dPTERFTl9WQUxV
RShHQywgMCwgbW1UQ1BfQ0hBTl9TVEVFUl80X0FSQ1QsIDB4M2ZmZmZmZmYsIDB4YjkwZjViMSks
CiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1UQ1BfQ0hBTl9TVEVFUl81X0FSQ1Qs
IDB4M2ZmLCAweDEzNSksCiAJU09DMTVfUkVHX0dPTERFTl9WQUxVRShHQywgMCwgbW1TUV9DT05G
SUcsIDB4ZmZmZmZmZmYsIDB4MDExQTAwMDApLAorCVNPQzE1X1JFR19HT0xERU5fVkFMVUUoR0Ms
IDAsIG1tU1FfRklGT19TSVpFUywgMHhmZmZmZmZmZiwgMHgwMDAwMGYwMCksCiB9OwogCiBzdGF0
aWMgY29uc3QgdTMyIEdGWF9STENfU1JNX0lOREVYX0NOVExfQUREUl9PRkZTRVRTW10gPQotLSAK
Mi43LjQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
