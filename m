Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6D8C8303C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C137D10E9D4;
	Fri, 11 Jul 2025 09:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zuSLDoue";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A1610E9D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B94KfQ++UmNyV1j1ZaQVllsIKBNXx0C0sMzrxbkvfoH6ZnnhTinhzsbpW9g/VZhirhXifWJJWeuUNIf2XfFpdyzLJIwOTY/FTnH4U7bUypUSsuAQBA0bG6beBw+As4lXyLJu0NtAuQQ7uRw9OTgDN6+SS5OQBEBD2AvZrnhFfjRFynfFt3GGF9aq6IwrBuU9L3J9y8IdtRwuLjug9HezMZRDNDZ1nw3towQMesT29yKDYEqDnH3+p51qkCAel124W7B5o6o6/lu4OKVOisplxAwqp5DLzIpdrPqt8XiLyvjEXaoHaxwbxE+fijqFVAA+xctiZswG+kDGDbmqj9zjrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=82OVbVqY1CfI0M/Eg00aHh8+NnTWactpJQwTY/1wq3I=;
 b=nMgD6Vhd3OFrgb2uYCHB4DcLmwB2TAGYUzP+Ly917fUWPOe6LksLKxMqEHWa6xykfuAAmuhfagJKG2Ryi25jaqWkL4OKL5yuucCfycYLczMAksDhxoFRyg5Ph1V8vO+zA/3mCnWijYyQKrvr0frK0dNM+A8JCmIWQKi5CZkowEKxrVaxwOB55qdfrQTQ2KRJZzKvIWkhmLIqNYFYNbEpF+CYdnzC0sHXmTY/HqwD+AveBcAwKzoYQhFmB6ERoX21zE1BeDIDeIe7hmGOMLDiP1itjBIzNxb8iXYhQXT8rXbKYt2M7/+yUNHJzNWOcZzil+I038N4LAtmrqKtRZsYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82OVbVqY1CfI0M/Eg00aHh8+NnTWactpJQwTY/1wq3I=;
 b=zuSLDouecO0CHKPd8xAV5WqVaDqplUVTkjaWxCKwNXy1K2bwMS9gkmd/xiWEBlQksVK9s+ld8Tr54JBogrTTwG3EixQralulO4bVVjNRm3dgIIwQ0eRiQWKjLqjQMyYSZHFBHNf/EUQEhBlczG9xXT3py7Er4TCcUtbVXLsa6eg=
Received: from CH5PR05CA0003.namprd05.prod.outlook.com (2603:10b6:610:1f0::16)
 by DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 09:06:15 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::1f) by CH5PR05CA0003.outlook.office365.com
 (2603:10b6:610:1f0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.8 via Frontend Transport; Fri,
 11 Jul 2025 09:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 09:06:14 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Jul
 2025 04:06:13 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add range check for RAS bad page address
Date: Fri, 11 Jul 2025 17:06:03 +0800
Message-ID: <20250711090604.9809-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DS4PR12MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: 003e7b78-ea5a-4b77-2ef0-08ddc05a3038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IXxDhU2UC4+URGvICKlimyF9caOKejgueJvNP3eZc63662rTeLh/pka/LFyZ?=
 =?us-ascii?Q?gf5/z7Fo8hjufScVAL2OxyrBB3g2B8GTVtQW/ouzhKPtVZ99//7GvCqYEEt7?=
 =?us-ascii?Q?RqGFzkcuSkl3oGOclQrX6Kv2ADH1lIYW0CgjTOS/CX7wxaVx3+SlFyDGwTlg?=
 =?us-ascii?Q?9aOyZdsv6Fh6QKX0YGGHS8pjUngpRYqQC+JRyTUsUBYni9DrHEq5mtpInLRu?=
 =?us-ascii?Q?lVSEI5nGM5ZQNql73UxYm2Ne3Ns80pQ5aCiD8gwo6WzDqttvaXRym3kYcnwI?=
 =?us-ascii?Q?8pY3p1XatveqfZGxvwJE/qVxZ/PBXE7tIfwXyVIjcqtn/9G6BkYlYK7JyySt?=
 =?us-ascii?Q?H0YqiEbikUdi93+zKdslPLR1rz4oCPn//RnE7J4Ax27Nzqi3blDVTdtlSlUt?=
 =?us-ascii?Q?gWtd3QBAAiO/ObjE3QhhGWGHN3P6D6BeLgItd+pJ+mEKhIAQN529YwzgkfWm?=
 =?us-ascii?Q?o+hcT+NYhW5eDZA4TNuUal0JBaE/a/T4+WxS7u/orR2/mu3S1XCFn/htz75F?=
 =?us-ascii?Q?bQGDpyvxbsOGG4JjN3CqujyPdeqoFB9LOsGD9Ku/mMZ2K8zax92fnO6Ki555?=
 =?us-ascii?Q?iSXYnSffbWrmDk8fVSKCb9yl31R1OZSSKbeKylFPJAHQAvfz8xs+bGaNggLL?=
 =?us-ascii?Q?ANFnE8mLJRLko8ha073TxCU+orMIXg13staxKZSsXyFipZPBKQRlExR6sUMJ?=
 =?us-ascii?Q?2oQdAtGQJasU0RzQsXVkkZVk7mtgagk0N8K883/yRcT1Q8gRJJcZh5s1mNno?=
 =?us-ascii?Q?MI6xCMh9QhWpf+b3iwa43SB7GF6mUnitUJhl0zsHVfb1QyyJZpz8a9OYZmFh?=
 =?us-ascii?Q?qKnqk4CirbE5Te5mmLincQVEjiLy657yEzCNgtAFGXlWAC6Sx6XwNE8sZ5DH?=
 =?us-ascii?Q?/PI5W4HZJXLhQDprUH6h4yni3mRh7EU0tOiZwT4edVSzudhyiUSj0jDjcTiE?=
 =?us-ascii?Q?rCrMxm94QdcrimMtJ1b7POxbIm7bUOO/HH9NkEHhjQdwWIvAtk4LmRgCN+/U?=
 =?us-ascii?Q?4HxYekxfT8o61sFBoe2hr85E3uUXPhQkCfaIqDvrHn7CEhAgaztjEZbZfo2A?=
 =?us-ascii?Q?eL/OBeLZDEybwRmb79JruxNUTBBPg0gA9+TYjBuiXMcD0BiQgvq69l980yKm?=
 =?us-ascii?Q?vcJETSdFxRBv6JaXQaag1YVP4IhBz48zibLgwW24329f0/waknXluSayLGPc?=
 =?us-ascii?Q?uo51TAODZmGeU44F3NNRxMh0gwC2GpqD/hC8ric4odWKfAgoorocNlqPL9vz?=
 =?us-ascii?Q?lFpj2IFD+l9FZ+bTy6iCG91EtYjCJbC/yuUZBdrg5Fkg6SJbYFGUVIcuR5if?=
 =?us-ascii?Q?6aoLBj9NHrF/j965dNl8AbYuKfxOUAMtMx5R+bKwa7TatrQzk4c6dcWtWtpS?=
 =?us-ascii?Q?baBjAcvHOG+jVy/mtKJzABqzSwDr5jwbIQ8Vo047XC6ClACN9PvfZuL0DqRm?=
 =?us-ascii?Q?L+QGtGDB0+O8b87kHVCkgTAhOU11giOOQl7B+BryEjQsATu6yUABKBWeKNlR?=
 =?us-ascii?Q?BnT/u1S4U6kCuitkci0HMAn1VA0YAJNiobND?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 09:06:14.4296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003e7b78-ea5a-4b77-2ef0-08ddc05a3038
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9707
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

Exclude invalid bad pages.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 58 ++++++++++++-------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a6f512293b5c..1d6d4625abb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -136,9 +136,9 @@ enum amdgpu_ras_retire_page_reservation {
 
 atomic_t amdgpu_ras_in_intr = ATOMIC_INIT(0);
 
-static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
+static int amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
 				uint64_t addr);
-static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
+static int amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 				uint64_t addr);
 #ifdef CONFIG_X86_MCE_AMD
 static void amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev);
@@ -169,18 +169,16 @@ static int amdgpu_reserve_page_direct(struct amdgpu_device *adev, uint64_t addre
 	struct eeprom_table_record err_rec;
 	int ret;
 
-	if ((address >= adev->gmc.mc_vram_size) ||
-	    (address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
+	ret = amdgpu_ras_check_bad_page(adev, address);
+	if (ret == -EINVAL) {
 		dev_warn(adev->dev,
-		         "RAS WARN: input address 0x%llx is invalid.\n",
-		         address);
+			"RAS WARN: input address 0x%llx is invalid.\n",
+			address);
 		return -EINVAL;
-	}
-
-	if (amdgpu_ras_check_bad_page(adev, address)) {
+	} else if (ret == 1) {
 		dev_warn(adev->dev,
-			 "RAS WARN: 0x%llx has already been marked as bad page!\n",
-			 address);
+			"RAS WARN: 0x%llx has already been marked as bad page!\n",
+			address);
 		return 0;
 	}
 
@@ -513,22 +511,16 @@ static ssize_t amdgpu_ras_debugfs_ctrl_write(struct file *f,
 		ret = amdgpu_ras_feature_enable(adev, &data.head, 1);
 		break;
 	case 2:
-		if ((data.inject.address >= adev->gmc.mc_vram_size &&
-		    adev->gmc.mc_vram_size) ||
-		    (data.inject.address >= RAS_UMC_INJECT_ADDR_LIMIT)) {
-			dev_warn(adev->dev, "RAS WARN: input address "
-					"0x%llx is invalid.",
+		/* umc ce/ue error injection for a bad page is not allowed */
+		if (data.head.block == AMDGPU_RAS_BLOCK__UMC)
+			ret = amdgpu_ras_check_bad_page(adev, data.inject.address);
+		if (ret == -EINVAL) {
+			dev_warn(adev->dev, "RAS WARN: input address 0x%llx is invalid.",
 					data.inject.address);
-			ret = -EINVAL;
 			break;
-		}
-
-		/* umc ce/ue error injection for a bad page is not allowed */
-		if ((data.head.block == AMDGPU_RAS_BLOCK__UMC) &&
-		    amdgpu_ras_check_bad_page(adev, data.inject.address)) {
-			dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has "
-				 "already been marked as bad!\n",
-				 data.inject.address);
+		} else if (ret == 1) {
+			dev_warn(adev->dev, "RAS WARN: inject: 0x%llx has already been marked as bad!\n",
+					data.inject.address);
 			break;
 		}
 
@@ -3122,18 +3114,24 @@ static int amdgpu_ras_load_bad_pages(struct amdgpu_device *adev)
 	return ret;
 }
 
-static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
+static int amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
 				uint64_t addr)
 {
 	struct ras_err_handler_data *data = con->eh_data;
+	struct amdgpu_device *adev = con->adev;
 	int i;
 
+	if ((addr >= adev->gmc.mc_vram_size &&
+	    adev->gmc.mc_vram_size) ||
+	    (addr >= RAS_UMC_INJECT_ADDR_LIMIT))
+		return -EINVAL;
+
 	addr >>= AMDGPU_GPU_PAGE_SHIFT;
 	for (i = 0; i < data->count; i++)
 		if (addr == data->bps[i].retired_page)
-			return true;
+			return 1;
 
-	return false;
+	return 0;
 }
 
 /*
@@ -3141,11 +3139,11 @@ static bool amdgpu_ras_check_bad_page_unlock(struct amdgpu_ras *con,
  *
  * Note: this check is only for umc block
  */
-static bool amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
+static int amdgpu_ras_check_bad_page(struct amdgpu_device *adev,
 				uint64_t addr)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	bool ret = false;
+	int ret = 0;
 
 	if (!con || !con->eh_data)
 		return ret;
-- 
2.34.1

