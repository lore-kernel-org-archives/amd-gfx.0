Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50CA4CA0EE6
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 03:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE1AA10E2C5;
	Thu, 21 Aug 2025 03:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="efr9pARC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 337FE10E2C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 03:20:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMYvweqQcqH2vlrfZ2BRkJSITKxX/3wlzbmsuXKz++RxR/h9I4/sIcM7grTiBtBYVqByaybY+M90O/eIF2eI9Skz55EtdrJqZGstCIcy68krsshRbHxB0NTWYtzMg5dak5VhbpfW0vSKRV6DTgX5U8tecLQcT5dgWcBRW5UsmD0XeP0NRWOoL8Jy4pp2MGRXIXBfRB+sqRtJNgqUdz0X1Wd4XxFI2wq6gNXiKB+Dva5RltUN3tj+yCKtU8y1R0vVWTENP5fRU6h8WIuxUGkEWXje7YBfQz4z1wiaxwNIQFVgcYJCSoDhAyUExhiOs8Pci8qP30AcN7H4JihLN58ghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hRFR96fOWtxWBmVXGo/4E0vxUfV48N7pWk7SCZ58T8=;
 b=HhFEiPjbvBpFQRiRAXGVRFH8n0agdrRYfAtGsGyerzg2RYsBkmqOVVfq7DcRTiXGkCZ5Kt37IVipZd7x1SChcynqnyXuYPgWEbHZeFamDzSMnxLd/1wYzMr/hDf4Qg69bjRZvBd6KGRtt2nUbPK2FCrSMl4jWSn2corlAYldSBKe7I/BdSash1HkFy0V40r1/iSZnJOadlHFgayRlCWOBbupv0LPj281rfqr98RafayKLBwceqpIr7PGrdbwpN2i/nA14ZM85ILxh/dZxFdbCmVBCtgEabcCL+WEcNYaUNC2C98fRkjsB2SY1q5vePekElErkrp4imSkdErT1r2h/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hRFR96fOWtxWBmVXGo/4E0vxUfV48N7pWk7SCZ58T8=;
 b=efr9pARChvFAih6MzONHibgR9hWoNG4fi8qNnMlb0AHYpGQLRQsI03xMQ0xlM2UpuGQUZXlhvojI/sujyozAsXZwZQpGByJPMxUv7pGsyUUU3IebkEYl246Vqeu5Q4aYpXBvlHuHXZvgepWU+heLutAu6mhee/4WR3jVLgL3/bc=
Received: from CH2PR20CA0027.namprd20.prod.outlook.com (2603:10b6:610:58::37)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 03:20:24 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::20) by CH2PR20CA0027.outlook.office365.com
 (2603:10b6:610:58::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Thu,
 21 Aug 2025 03:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 03:20:23 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 22:20:22 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Add support for dpc to a series of products
Date: Thu, 21 Aug 2025 11:20:13 +0800
Message-ID: <20250821032013.336835-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 229482fa-615d-480f-45a7-08dde061aad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uyrmSGpAs4FX6941BUw4KD2NZOcH8uJ9IurJqmFUroNV+hqj7lcct8IE1Eai?=
 =?us-ascii?Q?N4xCam42W5z54zO5f9m4pF3L7SZkXfMFSBf4ugqba15bkkAdrZAqktUTizd4?=
 =?us-ascii?Q?AQoiUlTOEiPvGdowcivqduB7v3OrF3hja5o/C10CTeM+qZa1u1nKQS+Jezvk?=
 =?us-ascii?Q?zYUgtbQbWChRdqa6LboO3kOzPTfGJljLKOIlgv74pqxx3WHOV/mxmMMC5oAo?=
 =?us-ascii?Q?vM3NMWQZjyCZleZSVoQjkb8dpwhtFPrZIqxSVAWTC4zZ2VAurk8BlysaKz8q?=
 =?us-ascii?Q?51gQIzOzigfS9RNFRmecrUpQAMZ6060XEWyR2po/YS77uVf8R5SBB5UMjHyi?=
 =?us-ascii?Q?GT5wBJ61zoIlwhXjJ7sGH/ypLIWbbnbY8ZzXT+ngNY6NZ8XEwbfinf0L3fAj?=
 =?us-ascii?Q?HtDXd20HronhJ8WXRBCra4ExwuxTLFOmAfcp8v48ndEs+lmEShpUk2pY5QCR?=
 =?us-ascii?Q?vMjZ38hiJGxzKJFt4N67qWYHF9Kx3hHjYYrV1ZgQw/NmsqJhKn3EAU3UUg6V?=
 =?us-ascii?Q?rPnYP+E2r+1LadaRI4ERT3S3h4I4JsflXnCPC3Kc4Looy7aBAVzEXH8O7vBT?=
 =?us-ascii?Q?feKtbnYjtmWsfmCt3cG+53ZAM2wbSv0qsNMwB22qfKeTlsjkN1s8Iaoqd6oD?=
 =?us-ascii?Q?JS15qYZvVNzxsb1Mw4pz764uJS70dfnxqWc2T4UANyNZ5Sfcm2SJP4S7Zepf?=
 =?us-ascii?Q?C2etD6SDA8DrtGyvw56xSrXkJE7WWVmt81oUwZgNIJGigYLxoBHlILWn7zK2?=
 =?us-ascii?Q?hgQtpnikafuCtfrb5m3iU8+HwlZNA2w0LrxzrWT2OmFxuE9WuzvL4tCSh+PF?=
 =?us-ascii?Q?+y6A4ObaWLJJTjf0eTDS+zNDxQDMKS9pOvrJtV+Tyi9k/ePTysd3JWaWfGvX?=
 =?us-ascii?Q?0BHvKXnvADJEErWRpB5u7tgm476AkY7BoSTkqnJHN9aRVPBuQ6uwN+qyy8PM?=
 =?us-ascii?Q?BTPUOHef8j5vaecDRbyJ1qeh7tF20wgmn6JIA9aJJqO7XTS98m4IGvFs5TFm?=
 =?us-ascii?Q?kszHEA0k43GknpQVMaF6CWZec5KPz/C3PRwHRvsDVdN9cVWzldj3TCzj5GxX?=
 =?us-ascii?Q?y3I02omrP0AAIeHz5JGQJOJAo2gfb+bBHHp5P6o5vc2zMjUszFONhVFVHnsj?=
 =?us-ascii?Q?pA3d8dN+8txn2CiK7FkxY5k5kWW1p3pN53wuYGUNvGg49Dxam5jCbVOdqDhS?=
 =?us-ascii?Q?9lZAW1Nk4R3CkwCAReVZbswzccJniBPRW2lOYRPvuSEOGCyLdqjA+o5epfyg?=
 =?us-ascii?Q?YHNttWuoVIFfIHQJUxtjlkDjS7WRPMScOS2I/Mdgc0KQa/asnIaql+N516jH?=
 =?us-ascii?Q?w6qeHZg61NWvfCpF/hQc7mzLaum16NpDSJIfcwEAcVqC8EwkjwqcxWcWysUQ?=
 =?us-ascii?Q?i7rdpt8ENyLDQ0uhGm1rZE86S7OneDEWBWjTJtAZQ+sv3KWeVW5i6hoLkHOL?=
 =?us-ascii?Q?v/BvZK1gnbkWx/IO1wXmQ/mk16SpI/iEweSlQHU0efHvc42syK32skSxaRJI?=
 =?us-ascii?Q?VDmLifbhLYASvgB6MynkFyzA5z6bLdjbqvHe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 03:20:23.8471 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 229482fa-615d-480f-45a7-08dde061aad5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331
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

Add support for dpc to a series of products

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 627a8188d868..a4be035fff30 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3135,7 +3135,7 @@ static inline bool smu_v13_0_6_is_link_reset_supported(struct smu_context *smu)
 	struct amdgpu_device *adev = smu->adev;
 	int var = (adev->pdev->device & 0xF);
 
-	if (var == 0x1)
+	if (var == 0x1 || var == 0x0)
 		return true;
 
 	return false;
-- 
2.34.1

