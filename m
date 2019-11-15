Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC2FC432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5517E20709
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 03:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5517E20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CA26F3D8;
	Fri, 15 Nov 2019 03:35:24 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690070.outbound.protection.outlook.com [40.107.69.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC006F3D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 03:35:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Slw7kY8tjlofG/YMPFvcKSjXEh9Lc+lc7NIpRR2uxdkuSYWcqpbfkhhYRHPP5SCIhH1MNZ2WV+EXrECga0V2r4ZPlZ6hENWgy9tvdzLISF7zmTbRiHY7GUgy2Exlcj1ZNAuDT2lXzF7h2wPDRJbpIHHow8cHK7m/Mnh8w7cHMi+oSxQr6jlNpMbtyN1RX4ZlRb4fK1i6GGqUYVyzoYUamDpws28DcvX6SyiQ/GOv0fuMwz7KjKs6+KugrP2kXUjx8Qvv6Z0GH+K51neYEf9UWOdGQSZEYFpFS7UhsSvNW/TBAJdqktGaWb7Fd41S1+xh5MUrUp2y8wniXAMqovMB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UE1q0fMoG/6855HXyrUHFtk9YsvKX7EwQar2EsCkjo=;
 b=d9g/DMfdaJH1XkqYRbSJlRBrgR9icyfxI6P8f0Ef0IGyhFJ93zDO2j8imnQGc+6w7Y2a0RpYMAO4C6XQGRQdezDWM2tRYMtJ15Uf5FzdYSL8+g+rsdfRhW0Xvz5lX7hwmTbcIfNT0mrnV9vJ5uan/4kcPUR5YKo6Uty1tZTrL4sL3UPqkhrMbXg+HX9yyp3od6X+YZsEvaEnZhr0kXZMujti7SK6hBmIOMFnb4O7H1vh135GL68qYhwCnd5Ksy5d1JOvYIkFCfRB4WysNvjIjRgJn9yoXXC8WxQ2akAlo+l/ISbm8fHpOiVCU8BorHNpCk/WApQlkHBRUq1DOIuyzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3838.namprd12.prod.outlook.com (10.255.238.203) by
 MN2PR12MB3663.namprd12.prod.outlook.com (10.255.239.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Fri, 15 Nov 2019 03:35:21 +0000
Received: from MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4]) by MN2PR12MB3838.namprd12.prod.outlook.com
 ([fe80::c98f:c517:b396:1bd4%7]) with mapi id 15.20.2451.027; Fri, 15 Nov 2019
 03:35:21 +0000
From: Aaron Liu <aaron.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/12] tests/amdgpu: add secure buffer allocation test for
 system memory
Date: Fri, 15 Nov 2019 11:34:46 +0800
Message-Id: <1573788895-3936-3-git-send-email-aaron.liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
References: <1573788895-3936-1-git-send-email-aaron.liu@amd.com>
X-ClientProxiedBy: HK0PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:36::18) To MN2PR12MB3838.namprd12.prod.outlook.com
 (2603:10b6:208:16c::11)
MIME-Version: 1.0
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e0e3e7e-cf92-4485-433b-08d7697cd7b5
X-MS-TrafficTypeDiagnostic: MN2PR12MB3663:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3663E45A8CB83B608609A415F0700@MN2PR12MB3663.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 02229A4115
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(51416003)(52116002)(6512007)(76176011)(7736002)(386003)(26005)(11346002)(44832011)(486006)(4326008)(2616005)(25786009)(6506007)(6436002)(6486002)(5660300002)(478600001)(66556008)(446003)(4744005)(186003)(86362001)(3846002)(6116002)(14454004)(48376002)(50466002)(66946007)(8936002)(50226002)(305945005)(66476007)(476003)(81156014)(81166006)(8676002)(2906002)(6916009)(16586007)(66066001)(14444005)(316002)(2351001)(2361001)(47776003)(6666004)(36756003)(99286004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3663;
 H:MN2PR12MB3838.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZVExIKwaPcZn9ZGDM7cMsrRCE88FvQtcvyBcOiOaxQ6v0oz4mzDiFnMynp2X6lcRmwssTdq8Y8QmIYBAJCQzbBHTjZX4l5VuNf8AqSPH0gJ7ri+zMr2iQ0zwgPCQ+n6g3mCAf61GpeQN+NCDbrhue2xfAuz2ZjRNWEDlSkrQwaejc0vaRp1I97f3nUPg844EbFLOuLQ9z5tH5h+6R5AoiqdPtWzzXMoTOuPNY+YxD0Skp26B/5Bk5ks7Mrc3GruYKzTHRDRmnsviP/B7FgoyVK/JZ/qV7k6MkC9cYD/fCPvl3tUiqiv7PJ0ozQhctOK6m4QFmvGn2++vQjVqi/jgzC6az3E9Yzw6nar13bFC3fpekj0+oKlLPb3oEvTbHcO164ld9gnPR604VN8oFpoZDl/doWRVQ/sPo8n3DcT7AD5x7IvfL0+8K3/Jp4zHARd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0e3e7e-cf92-4485-433b-08d7697cd7b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 03:35:21.6433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejvTE2Or4Z+ieoAWYTAAVQyNuCdnnAS9A+pvXRHW/UmX3WXKOF5SfVdrEH/0zlM0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3663
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UE1q0fMoG/6855HXyrUHFtk9YsvKX7EwQar2EsCkjo=;
 b=D5MbGUYdvOW36vpzi6lg+6VGHRUB5e91qR/wvPUe3l/yxYvrphsLPH9NSXMqITEVcF9ArmBGss/zD1jZpa2sBYMIBgkspXatCknpOxCnXQs6Tb1ODspl9EvyQoujDIvmdU8wpeNxBZ3QsyjayVsrz5XBrRW52EL6f4mjp3x7Xo4=
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
Cc: Marek.Olsak@amd.com, Huang Rui <ray.huang@amd.com>, Luben.Tuikov@amd.com,
 Alexander.Deucher@amd.com, Leo.Liu@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191115033446.jS6wtiYp0EwVvk3SQzi1zpM-Y9PY_xcSqq34WlzOHw8@z>

RnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KClRoaXMgcGF0Y2ggaXMgdG8gYWRk
IHNlY3VyZSBidWZmZXIgYWxsb2NhdGlvbiB0ZXN0IGZvciBzeXN0ZW0gbWVtb3J5LgoKU2lnbmVk
LW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4KUmV2aWV3ZWQtYnk6IEFsZXgg
RGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KLS0tCiB0ZXN0cy9hbWRncHUvc2Vj
dXJpdHlfdGVzdHMuYyB8IDkgKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvYW1kZ3B1L3NlY3VyaXR5X3Rlc3RzLmMgYi90ZXN0cy9h
bWRncHUvc2VjdXJpdHlfdGVzdHMuYwppbmRleCAxODJiMDNkLi5hZmU3OWU1IDEwMDY0NAotLS0g
YS90ZXN0cy9hbWRncHUvc2VjdXJpdHlfdGVzdHMuYworKysgYi90ZXN0cy9hbWRncHUvc2VjdXJp
dHlfdGVzdHMuYwpAQCAtOTMsNCArOTMsMTMgQEAgc3RhdGljIHZvaWQgYW1kZ3B1X3NlY3VyaXR5
X2FsbG9jX2J1Zl90ZXN0KHZvaWQpCiAKIAlyID0gZ3B1X21lbV9mcmVlKGJvLCB2YV9oYW5kbGUs
IGJvX21jLCA0MDk2KTsKIAlDVV9BU1NFUlRfRVFVQUwociwgMCk7CisKKwkvKiBUZXN0IHNlY3Vy
ZSBidWZmZXIgYWxsb2NhdGlvbiBpbiBzeXN0ZW0gbWVtb3J5ICovCisJYm8gPSBncHVfbWVtX2Fs
bG9jKGRldmljZV9oYW5kbGUsIDQwOTYsIDQwOTYsCisJCQkgICBBTURHUFVfR0VNX0RPTUFJTl9H
VFQsCisJCQkgICBBTURHUFVfR0VNX0NSRUFURV9FTkNSWVBURUQsCisJCQkgICAmYm9fbWMsICZ2
YV9oYW5kbGUpOworCisJciA9IGdwdV9tZW1fZnJlZShibywgdmFfaGFuZGxlLCBib19tYywgNDA5
Nik7CisJQ1VfQVNTRVJUX0VRVUFMKHIsIDApOwogfQotLSAKMi43LjQKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vYW1kLWdmeA==
