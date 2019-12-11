Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35890C2D0CA
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D992077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vpBBlsq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D992077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA9296EB8A;
	Wed, 11 Dec 2019 15:33:36 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760051.outbound.protection.outlook.com [40.107.76.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E7436EB88
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELETTeUGWpy12YY6/LkcM8GMdAqj/4rNmLmTnIz5XI6fe0xFPGyJjE/4azVTJzJnwXQvOE/nJgm0qPiFXr4b5nNHpWsAbeBNU1TE3gwWuS5Z13gCMHCLGqnzzXmRvJTqcvt+0o6h5s0sz4oypSN/UK/Y2wyKNMntbzT//qL5G9qiP0M/ORFWFcewEC3HFTYiKDAHdQbBuW4y7+iDQ/Y7wxTUJ1cGXCTb6lp4serKjFPZ/MTZQiBiqSTvRP8SVs3Ti2RJVHfO92Ugg8vZ1FSLGpQVcUe/WQLPuhDQCWq1wFjKL0lWi1e0Tn0LVnuqelPq+J2gY7Og/bNbloQ2mKnyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Bh7Sjo/A87PrQsbcUJngfgz0wD+LudqsezI4DSvcw=;
 b=gLhsltRc1qEtgGgiUPe86CK22bt6C6ui9jMOZeISMBzKYlwGBDNvLfPHhFJWGA51jYSX7l/xeRCqVJACfbckv3fUlH21KNrnSInxAKqRcT+VzyslAB+ZFTq5lC/51+vzy5ySPVTJestgF8K3e0ZqLESSwJKYQwvvzLynCAd+kMxiWu0mIdkRRIsb9zAVtvRH/8Zj3vyJRIbXytV217+z1XcC8wDz1sQNzQ4tBL4Cfm0A2PS+/LxTQgGBNrGcNePzQ2cCB4y7t6jxaafIjUaYaXKIdMIWkPsjreFpINDqtds6pV0r3D+LOOJX80bFoNnfAl4JOyDZVh5fjWOST4ujTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Bh7Sjo/A87PrQsbcUJngfgz0wD+LudqsezI4DSvcw=;
 b=vpBBlsq6/CnhI6gOu0/5m/rB7NYjxecl3+/J0W60L+zUp/5SkdqGXVDB+Z6/+kvmp2aOa4tHbXtEPAEp8P3GvLj+i4HKEP8l6Y7UbyOb7FgGdhGHrBV5e/s89toWUk2eSRHYBI1/7vU/PVUONZCBXGUzqeX8pIbvTp3VxILjk1c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:33 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:33 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/39] drm/amd/display: scaling changes should also be a full
 update
Date: Wed, 11 Dec 2019 10:32:32 -0500
Message-Id: <20191211153253.2291112-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 038593d8-669b-422f-b22f-08d77e4f7aea
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24913F79AD37F50D5A9B0437985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(15650500001)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J99ivzPCma9xOksdfuhOtVmAqB0iw3w2PS2dr6+ZSI1iwov1/qc71dq56f4YoNY9pksaMhr/+JIihX0GfUJ3vkchCE24gxnI0XQ8gEtc1CV1++oobU/qOcNy2rmrWesw4nSEKC4UUonlingDt5shlDbz626d3C/3OkTbqBYWBedBL5oBGVF763TZTCyuLir+P7UyMKNIK0KW2JQ438UQUNBHch7Noc/9nUEASdSzcFUZVqT10tAfIVIzM6zx6x2/7AFWpG3owqW8ok3HbkO9rZVSGXcLiCdxm63UV1REA2rBjkoc5SEiRVddWgyw3+UFJ5s7jwZtVkKiEMsVltStobMY3bd96dB2MKisJFYcfFeFiPKQs0brqvBl6v1r6lyi3R4XJwydGZYtsm4vVGlssSJvrNVfwTxYghCgOkyt9IcZvXKna4Bg8P00A5Mfcul2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038593d8-669b-422f-b22f-08d77e4f7aea
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:32.7870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is/1dWxsCbsdRPnLtu3iW/rDmW34YLb5FKuAyZZkJSFIdM/3p7nsE2JOqBtRUXFBitivldC7HQWJgILBZg2jFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Aric Cyr <aric.cyr@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2cb31f403b74..c13480685853 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1577,7 +1577,7 @@ static enum surface_update_type get_scaling_info_update_type(
 
 		update_flags->bits.scaling_change = 1;
 		if (u->scaling_info->src_rect.width > u->surface->src_rect.width
-				&& u->scaling_info->src_rect.height > u->surface->src_rect.height)
+				|| u->scaling_info->src_rect.height > u->surface->src_rect.height)
 			/* Making src rect bigger requires a bandwidth change */
 			update_flags->bits.clock_change = 1;
 	}
@@ -1591,11 +1591,11 @@ static enum surface_update_type get_scaling_info_update_type(
 		update_flags->bits.position_change = 1;
 
 	if (update_flags->bits.clock_change
-			|| update_flags->bits.bandwidth_change)
+			|| update_flags->bits.bandwidth_change
+			|| update_flags->bits.scaling_change)
 		return UPDATE_TYPE_FULL;
 
-	if (update_flags->bits.scaling_change
-			|| update_flags->bits.position_change)
+	if (update_flags->bits.position_change)
 		return UPDATE_TYPE_MED;
 
 	return UPDATE_TYPE_FAST;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
