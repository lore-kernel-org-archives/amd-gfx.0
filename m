Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01291C71155
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jun 2025 15:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9844910E054;
	Fri, 20 Jun 2025 15:41:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B0tYvc1F";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BCBB10E0F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jun 2025 15:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfatj0ToZN+P7Pn5bOiAQVslbEbwui3w7ldhj2B77JL+0mtgFYlwGNhgu7GuWJt92h3stYPJIQ2+SSHCrHz18WzLkAPBgK3wFBx1VrOYbzq63lX5cagGeAz0jjmy51e1wzylZ3Fkx7U+vYPDEh8NQZMsgZoI0ipFvv0kGo2vA/dc31zMdTBoy1UDmHvxxN882y0PjG9l4V+trl+UtXvwTYM4ZKiBRIcaS90nAnMeuz2FHswecF52aV9BHHDyqlgPu1+ghbt1S3X8A/1Ejtzb1m2xZgrfveY9A19CU79BBTJNSQyYHALN+9DshCKPq4WD1LS+HpE6BoVMHvvjolOJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iNQYhAJwxthcdvzFctcKyRMTrJ/sWoERRyuOXiZiZA=;
 b=njbvyGSOc3Gzmh0VJ52EGrkPynv2jk8WYNz6AKXPg8dTxcb1U4O12h556bUgSU5WQ016Il7hWSnVjTeF2ghDlAzEaoHcMVYfF0ih+yxcOJRkRvSbjzAfMsep8e5zLBok6P9KcW380Xf2shRvMOA9RYg5arfsHPN8n7S5TEq+l+1EB74lokH/uCk3pk6QvwWba5NbRWRDLs1mhMbMkwmWyN/ALkmv51LAbCKZpD9bBAO+QKN88WRpc4FuTTQeDEDQYhNh+DUHMcma/yyEVMJ4nkKQaEjp2zE4YN46QXoLM5hxZ5wxMGGIxyECPbp6nGEM0RG+wM7xJ9DDuKn+DborGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iNQYhAJwxthcdvzFctcKyRMTrJ/sWoERRyuOXiZiZA=;
 b=B0tYvc1Fcwe2w5iKAjnl/M06nvK0XwZWGhaGURgeNpEtd23Ae1PV6zknUFg13A4Vl2zMmaIzO1ilA58u3DGMo+AoZ0HdrsDRxKwp7pds2f8LML5Q1FhC5JxzSgbAw52kk3Q9XCBw16DCDVTnrPrlJf/CfP4SmJ7eh/48g1u0Fhg=
Received: from SJ0PR13CA0106.namprd13.prod.outlook.com (2603:10b6:a03:2c5::21)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 20 Jun
 2025 15:41:22 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::24) by SJ0PR13CA0106.outlook.office365.com
 (2603:10b6:a03:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Fri,
 20 Jun 2025 15:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 15:41:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Jun
 2025 10:41:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/sdma7: add ucode version checks for userq
 support
Date: Fri, 20 Jun 2025 11:41:02 -0400
Message-ID: <20250620154102.49652-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620154102.49652-1-alexander.deucher@amd.com>
References: <20250620154102.49652-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 922a30b4-6599-4cd7-9bd5-08ddb010e818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r2PpnuIinmbpMSuxD/RQ8CnTIs3UZZI/vBRFSdxwpqR674TDNnc8amlFfv2Z?=
 =?us-ascii?Q?zLGKwElo81qCFYvtFd5TafYeZ75ZXIkPGNDfnQuUDtXb53xN9IoHaMG0l2yS?=
 =?us-ascii?Q?z6uHDnquJM0/baq4/0cOik2SgbXiBwJ/ODugpyhcni8Xzfd9AqzOCYqBt/1Q?=
 =?us-ascii?Q?fCTF7+fNJdtHKkFfGr6nIp1n8903CrLelL3v2JIDnSL/5NarKEd+cRw09i09?=
 =?us-ascii?Q?t2gLi8v4ihu+mc2sAgZ17XmBarM+mLfOsWa/wBqdA5LqOd21ID4qIVw3kcUz?=
 =?us-ascii?Q?ZfHqAPFi1+LAFCnRwIbzdioMHSQFuBIjtHiwtjV3AiPOuCaA3hH8Pd16G/cf?=
 =?us-ascii?Q?l0hufFRBxlFNIQZglaTQmmXo/WrkfpQFLIrqsnLZ9tPkDfDX8zPWKclmvIYq?=
 =?us-ascii?Q?VLTY9G4a+//BPIE5kYDL982f74paW3uj/LcXH3qP/0YMVMzKj2xfVa3YBrmV?=
 =?us-ascii?Q?uugTNP/BcXLUht4+5FKH7NBoAhzxHKatFc2oPSag78I1e4sIVYnB+b92fZ7J?=
 =?us-ascii?Q?I4fscR23k6/cF61cLdS85gU7FeUQUzI3Z0JVn+erOVHfndHQDhkXlyK/Zt4m?=
 =?us-ascii?Q?8KRj7GHg56nQqW1BfKOFADHCy8fRCoAhqAegQbqP/baDpX8nofGclrwzkfYL?=
 =?us-ascii?Q?B6hhieXx2kaSkjy7342/m9yl0qKUTRbTeBhLiGdbJCtNCwqpgJTEQxw8WVKb?=
 =?us-ascii?Q?4wCgJb4eE7WlV0UzMLMU2T2OEanYZpT0KPkmWbI2V2ol6JhlNzu4RA8tCphb?=
 =?us-ascii?Q?nF02DkB+ogfG8gF+z+rdmTnkX0FfTQo7ve21yHh5bbHDZcGjT1X/0/bEDqEc?=
 =?us-ascii?Q?ejtG7tBkQ3A3zqfSfs5l0ubpZ1559h7GrBgPDgl2TCg6ljO/dH5ssegsZO4f?=
 =?us-ascii?Q?R1vdjw9EbJhE6zQZUkHjns51GCV/L4+oVdbkztj4+iHIyTVac+h42q8owK3L?=
 =?us-ascii?Q?khjCSUc3hnC3VFNyfJqiJzZpT2m1Wd7w/rdI/LRY3gLCfB63y3Mrf4wRn4aa?=
 =?us-ascii?Q?OY19WLIiVfQfUpRtiDmo3qtceifdhmlSHQX1/rKZD3tgKp1S4pRzkAAwrK+h?=
 =?us-ascii?Q?PHH53ZnCXkhkPUH4fN50RsbKb2P25TQZYgUS2S3W+iU2a3DtFNYTtSgLCa4j?=
 =?us-ascii?Q?Dt2t5k4usCP/kWET/XytrI/MHwKO4EkbpTYM0NddTOfmAWX8tshcB4dLebUj?=
 =?us-ascii?Q?pZcbojl81JPJe/JEGntycODmmQ6+Ix06cO9rr3RjyQGzv2ukGmRAwvgcQPL/?=
 =?us-ascii?Q?apIFe8m6swip7hVjwvTPOQkP63hPUVDOO/g8anrZ9LniCc0tYOfXU5A2gfX1?=
 =?us-ascii?Q?MhBW3oMEqb2Y6mvNMjxpQKQYA7Ixw1t2Q56W+0KWqlOvSvcufJMDSYYJEfAC?=
 =?us-ascii?Q?8HB2YYw92w4he5pZWVy3PtCjLS6yVQQlAnNWrI+cN05hy8oOpY+/y1sXWrSx?=
 =?us-ascii?Q?kj3xde0S6zpwWDtAFy+eiPrU65UfDARXxdbSm+CYPTMP3Zbd25oFoMxfGRAV?=
 =?us-ascii?Q?dxNDm1y9M3yyFAApuB7D09LkaOzrgX+ZLRD6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 15:41:21.5032 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922a30b4-6599-4cd7-9bd5-08ddb010e818
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA 7.0.0/1: 7836028

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index ad47d0bdf7775..86903eccbd4e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1349,9 +1349,15 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-	/* add firmware version checks here */
-	if (0 && !adev->sdma.disable_uq)
-		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(7, 0, 0):
+	case IP_VERSION(7, 0, 1):
+		if ((adev->sdma.instance[0].fw_version >= 7836028) && !adev->sdma.disable_uq)
+			adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
+		break;
+	default:
+		break;
+	}
 
 	return r;
 }
-- 
2.49.0

