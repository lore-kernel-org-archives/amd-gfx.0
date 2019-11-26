Return-Path: <SRS0=NdEU=ZS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AABC432C3
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 09:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528C220684
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Nov 2019 09:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528C220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5406D6E2B0;
	Tue, 26 Nov 2019 09:44:00 +0000 (UTC)
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-eopbgr800051.outbound.protection.outlook.com [40.107.80.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E13716E2B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Nov 2019 09:43:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+P06c1aLzvQjT7LH5yPmoVd6/XQF6gH3LqZ+QLDYdZL+qKobzAFeCd5/YocrH50B3vF4IyZUoE49cfbcLDa5VzoKfXFhy9FWmBKv9JYjRh9qcCwNdjqt5XxGYAiMCKxd9VPtsLgOy7ENx1AXtJdhNX0yPa7XbiPZfF/8/ldRqvdedR+okFcLRBGhgDuh5zskPo9KXl8p+Sp2iD8W5Bip+0c5gOwvktSA4UsAz5FmBkvU34np4ieRDXwV0oaLjJ4aO1IbTYRHpl+U7/imD91zvJuO4zSTVbbdn7qWzjAuwKTR1p89kvvJ0LyjdgGL+hlQEEM8DDzxxMR/wmEHtgiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/s3NE0aEVKBiW1OfY6YLPpATvQsiwL0TjNqYa+E2oo=;
 b=YhaL5Ey4Ap3kyreSZNyQD7/KqIjKPp/7qg43STK7FtXg3+YTPx6+hDmmNsg63O9RYwOlF/shBvpgMILlRx3rz4ErgCIbLG0zt12SJJy0NrCHGYo7xCCv8QdQAE4QkMFy1U760xlnP3X3iZnT/7J7B+jlXwGfVkQSfc70MqSO3pgcykgIfRez08udwXchqFp8R3dIRQMAmm/RUvbRHrlkJl2g9G9x2F2nMjnNRnMQUboFJa+CuurmXfFvq96is0+VZtudNl3SLS0H9CEQIIAaAdmff6fvGRUGxSsDMuhpK2meQKOOqFzErkLHOurUrR6dbt9vStt6WrvpRKRYjuT7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB3022.namprd12.prod.outlook.com (20.178.243.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Tue, 26 Nov 2019 09:43:54 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::cccb:bf15:7930:7a15%5]) with mapi id 15.20.2474.023; Tue, 26 Nov 2019
 09:43:54 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/gfx10: remove outdated comments
Date: Tue, 26 Nov 2019 17:43:38 +0800
Message-Id: <20191126094338.32695-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK0PR01CA0072.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::36) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ee31d92-4bdb-4fbc-47ea-08d772552582
X-MS-TrafficTypeDiagnostic: MN2PR12MB3022:|MN2PR12MB3022:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3022B847F21B4F47A0FA8A0B89450@MN2PR12MB3022.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-Forefront-PRVS: 0233768B38
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(189003)(199004)(186003)(26005)(2616005)(44832011)(386003)(50226002)(8936002)(2906002)(305945005)(6436002)(52116002)(51416003)(2870700001)(6486002)(6506007)(7736002)(2361001)(6512007)(4326008)(50466002)(48376002)(86362001)(25786009)(66476007)(4744005)(5660300002)(66946007)(66556008)(14454004)(3846002)(8676002)(6116002)(47776003)(81166006)(81156014)(99286004)(6916009)(316002)(66066001)(1076003)(6666004)(478600001)(36756003)(2351001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3022;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdaJ0y37+L6v2jen95z84GAR5mwwNiQoUWM6fwPW4a1Ax+Z7KHtTymCejPdDuUdjUQ3hSqebEcSsuOO8HWC2W0eixP0l9dJ/WQ0x9245e7U/Erge7GWLWXwpJ2jCK5aT2C4RVHxjA58Oq738rIOwkOQKFePAvFrmvhmy7WBkjJFNGSdGx5wZsZFKakG6w/DxUn4cNfRli7TU/dxPpfB88aJ72OvxsnZUzqwQREiy7EfYPD+BG1voZaR6t3Ms5rpKPt0bLq/y8ZoY7b02PwVCDzJF2G3w1WNPtxbbbyVhqn8wYQCzwA+BroFXSr5VQqi202PigHqG+Ya/zZzOgOTOpX5ODmdzzP7sYTKwBTAwBxy7g7CwuDpeXvOPEdXfi6arKhozv5WvciuSDSN/nDw5bo/zp67DOTVfLg/lH9lTLCTzcVmJb3ga/Pjetc+xatbi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee31d92-4bdb-4fbc-47ea-08d772552582
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2019 09:43:54.0556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSh9VjKT619R37elKrGmnVY+ehUtTTJzqWqDHLAAyCJYhzHcVGwgvGBr6YMJGfff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3022
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/s3NE0aEVKBiW1OfY6YLPpATvQsiwL0TjNqYa+E2oo=;
 b=dEB58gn7CSWnfO42tO/uMiknKwmR3fhLZ+cMdiTx+BCu8duJJprvsr+GtM14fms/vhZJvl3mEObKfpQABGs2zuBSFYDhI/rcWrV3d5N1UNWxESBAXa10+l2NKLhjpMq/uSNPWbtEQU+BNH2QT4miSKQImnS3Wzz0FAvsU/HsOF4=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
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
Cc: jack.xiao@amd.com, Xiaojie Yuan <xiaojie.yuan@amd.com>,
 hawking.zhang@amd.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191126094338.n0GzMAxPJsj_HGbW5uRVagAKDS6JtSyxXmFDM-JEcPI@z>

U2lnbmVkLW9mZi1ieTogWGlhb2ppZSBZdWFuIDx4aWFvamllLnl1YW5AYW1kLmNvbT4KLS0tCiBk
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYyB8IDMgLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEwXzAuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTBfMC5j
CmluZGV4IDJjNWRjOWI1OGUyMy4uNmJkOGQwNmRiZGU5IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEwXzAuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9nZnhfdjEwXzAuYwpAQCAtNDYsOSArNDYsNiBAQAogICogTmF2aTEwIGhhcyB0d28gZ3Jh
cGhpYyByaW5ncyB0byBzaGFyZSBlYWNoIGdyYXBoaWMgcGlwZS4KICAqIDEuIFByaW1hcnkgcmlu
ZwogICogMi4gQXN5bmMgcmluZwotICoKLSAqIEluIGJyaW5nLXVwIHBoYXNlLCBpdCBqdXN0IHVz
ZWQgcHJpbWFyeSByaW5nIHNvIHNldCBnZnggcmluZyBudW1iZXIgYXMgMSBhdAotICogZmlyc3Qu
CiAgKi8KICNkZWZpbmUgR0ZYMTBfTlVNX0dGWF9SSU5HUwkyCiAjZGVmaW5lIEdGWDEwX01FQ19I
UERfU0laRQkyMDQ4Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeA==
