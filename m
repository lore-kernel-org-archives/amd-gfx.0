Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFEDCA6004
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 03:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 732B510EB87;
	Sat, 10 Oct 2026 03:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mimXHfT/";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AE510EB87
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 03:18:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDrT9ztDLtLg7UqqRY9ERyaRw5PUQQQtpcdiZB4fs7wNSPjl4TKM+WdZbmwH1wJmDK9GTn0BnrAiQl4HJX5tapfouwITbQWNt8na1UJXJp9SfGPUy459j46AHXljX1ZH50zZ+K4iV6f4Nr77z1foe10kRxVaCfgEe5xELQQJ2WqRHllJMqxfsUhEjlH8/VMq2l799IIGU8LOsp4skREf7zFE5YW+ej4ixM5wGcIMhBzpXDLE2vBfgquxq7y342LkfWBBw6A6TLczrXbK9rG720kAKQ7E+WUxcRY/g7lIrFcUFEXIFrKJ/8wSSG1QCeylcN+XBRPXDcSJCIZwQAVrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qzstc1whv9JEcA4aHoCZ9oqGM/fZhx1t5pdL9MdmSj0=;
 b=V2tILsH4P0pwgayo1R4sxNAgkBiEUkB0o8fCQBIxEmPZJmfbVBx4qshqw/vHaHrIpDGeK4cN13Sof2o/KM9DloOkacs8+FkxJ1CXxrX+wvPsUP+/Fc+g00da1k06OppzS6nK0s2KWr7DMjHiQVgzSbn11wVllL/z3Cxi5eq7gUBzW4W1peLwRUFKAQU8R9L7iIee42e0YpuBnoul52NuNS0hX5Bx3G3hkic81x9IyzFIuQZLcWVdFcsmGMtFkhZwaytGFiilawpDf3kIM9tOHPsZtLjiunrfCm6/Xfzt2JqCq3J7/xuD0A+t20+SfWW1C8uOUX8JGdlBSCdcWSzfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qzstc1whv9JEcA4aHoCZ9oqGM/fZhx1t5pdL9MdmSj0=;
 b=mimXHfT/gSmvBufp8lpnYoqVwbhv/QnyJxZeeeGg/s+C4AgM9LZg0rkpUv7M0faTwdgjQ832gcqto/oBaPYIcC13Gccx1SUr+eYc4hA8juCE+c04G0tM/CIYutPIqR6sWkf+gKjIiF4EOTGrc+6B3nN4h/eC1m4xqzo07HaZF/A=
Received: from SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26)
 by DS0PR12MB7535.namprd12.prod.outlook.com (2603:10b6:8:13a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Sat, 10 Oct
 2026 03:18:24 +0000
Received: from SJ1PEPF000037BA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::83) by SJ0PR13CA0081.outlook.office365.com
 (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Sat, 10
 Oct 2026 03:18:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037BA.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Sat, 10 Oct 2026 03:18:23 +0000
Received: from stanley-amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 22:18:16 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>,
 Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amd/ras: Add pci bif ras aca bank info
Date: Sat, 10 Oct 2026 11:18:07 +0800
Message-ID: <20261010031807.105487-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037BA:EE_|DS0PR12MB7535:EE_
X-MS-Office365-Filtering-Correlation-Id: 42743bb3-161c-4a73-dc90-08df267d246b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: S1FZFTYW2EF2Lix+4vSlukFzPnnZA9MtEMU98QcWXHD2rn5z1xndJnScrn0zHXdgDLy9Tzu5Knn2rJiYcpNEaQtsMzH/l8nJ/iWOlWAnCY1ULwzc7I4yRDfZYXir4pLKAkuLw+1FfgqonAv9FdHlxcpo8jH/HFbH4EqP4X/rDynGSrps/NyiEoHa+DdPXiKyIRQnXPTOFWMMnAAssEyjbK/ecneIMwM/B4C7ct5Nk/Jun6c99c5cshrPNs2XJS0OfuMOMZ2wM8SJ8YsJCNnwhsftafU4TAejoT1MYg/yHMQAQ263mgdmynb/2q0eTkFrxynu52GdPrX45rpkshGzgQqLUrmkkkqJJ0nnejYYElgTvFAwzzs5NmBRb68wnyjUlCK30oL5wDe9p2ksZjP/2Hhp9wd2QRMwqqQe8FUkJaQs0czb/Z2CLytRwRvFStEGtSF56msFNsGNoyzUvOwm1lz5kyH+tWxTbTmOWkEXRHAAVEUDBBoIxUAYh9OevxdRDuQtomrtAwT2UKRO7laMw9m/Vr+tyouIM+780ZZsGmNZD9DshEiM9iOcMpCuJ1NTL2XH5UX4mbcbHL9uB/R6De+bCEajbxHCbJRz6ZGsp7Y6oG0iCKHP1mwYm8qM4m6UozV0KgJ7l7pas03aIW9DbhNdltyBs2gx7p48ZICtWI3M53ocADILoqLv2Xju1hL2RTz0Alzzg64V1KNq2I4OIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +wACot2bWGImYRypNggfzRaOxlgDFOhfYQdNinfaNw/vgwX6vFBlWbLnginSp2biiZWHfVHkW+C9jFhwuO1J2ZHcOWyXyHQzT6ieza7y88TwoEthWd99og1ubHegA58hQGX3a0FJ/pzvzTZEUEooRQnlEPD+sZHuL5pL8sU8XRZlwtwo5IFuJvKVswHVUiqvrlj6Ini1SJt/KjJCaR8fdMnSXAGs7QU1ZP81lvAwXL68FWHO1qdSf/YA8dU+GDURtfv9PPQ7K0MbI8r4orCGY0w6ZwxFffMeCqTIRyAAtrDL/paHzkC5fAXoGxGnghvkt3d+JcZBbDjhU+Q9DGw4EUEJ5QLmWYxU0PFE2AS/mHqDBMzJcPYzEMGes+1ZgG8JVOkedwSwmuRglxt1eh4Y4Bt3oOjj9RHSc5suwMcSAlSQAPB3Xo1QTK9c54GtG3+h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 03:18:23.2466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42743bb3-161c-4a73-dc90-08df267d246b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7535
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

Support set pci bif feature mask to support error
injection.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca_v1_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/aca_v1_0.c b/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
index a4145f30f45f3..f4fe95a8eca33 100644
--- a/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
@@ -353,6 +353,12 @@ static const struct aca_block_info aca_v1_0_mmhub = {
 	},
 };
 
+/* used to set feature mask without parse error info */
+static const struct aca_block_info aca_v1_0_pcie_bif = {
+	.name = "pcie_bif",
+	.ras_block_id = RAS_BLOCK_ID__PCIE_BIF,
+};
+
 static const struct aca_block_info aca_v1_0_xgmi = {
 	.name = "xgmi",
 	.ras_block_id = RAS_BLOCK_ID__XGMI_WAFL,
@@ -369,6 +375,7 @@ static const struct aca_block_info *aca_block_info_v1_0[] = {
 	&aca_v1_0_gfx,
 	&aca_v1_0_sdma,
 	&aca_v1_0_mmhub,
+	&aca_v1_0_pcie_bif,
 	&aca_v1_0_xgmi,
 };
 
-- 
2.43.0

