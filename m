Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC6CC54FB3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 07:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 893D310E1A9;
	Mon,  2 Jun 2025 07:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEAvJwzD";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDEB610E1A9
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 07:32:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSIBij7lczx1qJrSP1uauchbztYYeJ+UH8rVLV+7lJQW60aPjrWkPUZiGCKd/ru5x9Tsc+fZPFQxiYEa2dVnavkOhTzxNxKFsogv3LoHuXR3spJ8UpdhqpjEr+s+uiGcn7TdELV9aKqmFv+xZJGymoEM1RxBTjIgPnmv9p/6SFYkovIjlFl39eeOrvkXU4eurXbqrIgusgn+lJ70ag8qkHXB90mjHTTN0oJbXkblkVVhDm8V7e9TkJ+uEmmMjZ9vMiJkKzCFQesSPMZ1paaaW5OqxgQirBRLj+HaLpKKv0fhmjPbyNMZeHmNCCOYwIEvkWEfAx+rObXmgr9h1lCuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fW2WLG9gYYOU8r6cpGLqC4GPEBRcduRUMtnzPEZtQdc=;
 b=Q1hlGgKVGeuso7JQm2vCIj9INIWip7piyJEFDko/9X9bKiCsiLuq13ub3vGsbk5feiNGbbkZqsI5BbG3TJQGq5TOfEwsqcpkKLSMA5OCdYBFYz1Ovfqnnn2eQ7T4HGqwgXzVY0faAOR9QRm/qTCzZVH5M3dTh3OgH/TCX5AHpGYPo/Mz2ID8Lb2JHQrCXWHnRn72t3VzZqf/PLZti52G7x6teegBNVaHvWY314LG2rsmZ+/U3y7F5MPzv1E23oXIBYCf655uH/kTPLaMoxIUVeTve/PfPA0PZyhMs10SAbbM27JtW8k2DxOVr71vjf+af3fN1ZrhSnfqAkmSDXhZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fW2WLG9gYYOU8r6cpGLqC4GPEBRcduRUMtnzPEZtQdc=;
 b=bEAvJwzDD9lNE7sg5ec33mN9X/2jH2zM2Y9cSvfq5A1AjwKFnSjxGvM8y56TqI6MvsdI1Fopv++FqW+FJtrKcYUOhWXzFXUlbXSVCPR9gEbs2JIZzJNefJ7Qp0mh1Z/EANSmg+yrZA+FA4+Wir+05OMswPJoujbMfNJ2GlUBnsk=
Received: from MW4PR04CA0302.namprd04.prod.outlook.com (2603:10b6:303:82::7)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 07:31:55 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:303:82:cafe::94) by MW4PR04CA0302.outlook.office365.com
 (2603:10b6:303:82::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Mon,
 2 Jun 2025 07:31:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 07:31:55 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 02:31:52 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add more checks to PSP mailbox
Date: Mon, 2 Jun 2025 13:01:36 +0530
Message-ID: <20250602073136.634742-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca71416-29e4-4765-4354-08dda1a78ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WQC3ayxPrFIyk41uctYpizuoHohS/QlTtbAzLzFae/WLGzg1UG68Q6iJUDVV?=
 =?us-ascii?Q?YvnuykLezXiYemACGgDHlauI4CskUrsnCAA9l6Oe05uaVaaF2nrqay6ZEMeo?=
 =?us-ascii?Q?CbPp4Y06yrEH4eByWPnapdVEZqoOWr/23SJGM6te1KeMPmdoG59ty9MOIh5O?=
 =?us-ascii?Q?kPnPFnF7JpTm5bMYFwFAJHq25yI+rDheiR0Corfhhu7kYwBQkNDom8cO0ec7?=
 =?us-ascii?Q?eWP7eF5WE4a7CYpNrosCF2li0mI/R8xrXSjtz+KIRLYXbAFbMzJPtFyx/2gh?=
 =?us-ascii?Q?kt5mXeHv7KJMfkrSmhnszHaE/YAg+eoGJSivJ0yaSq1Ze+NsVbaeM5MNNZQD?=
 =?us-ascii?Q?GEaTtun3MMa5Ym6kUz4v8uMKo1BI3yaxkVFQcoHja33HvACykkrODrQ+CITN?=
 =?us-ascii?Q?7EhaE3RNq/2P0JGcgkmBltQzCXRUKeThYjy8p8XYk9bHi60T0djY8H1k40pu?=
 =?us-ascii?Q?zXbgOY2yoFTlKDcclxRW+D1YxuXzWZt7seUvtaC817JzEDoCsv0cs7CwFD3q?=
 =?us-ascii?Q?+vGBeZVz+UyVqkjJFuZfXmzmVC3UB+u5My2TcEd4man717TU7QGa8K0jDBjU?=
 =?us-ascii?Q?HVsUOxr87gQlpcdWAnEMMbhWjH3uV/+PE0BUe7m9wPeITQW7c4XoVIgEt+Dr?=
 =?us-ascii?Q?XWqFSMXuYyoMXWUNW7NmYXUZVGwaiv21oD4pfyj4A8OKhdFm3uUn2g7DkmMF?=
 =?us-ascii?Q?x9h8K/gkFURNTUZdbJxvQGLIarno5dWSB+g9YfT1gokUY5C7UBoHR0/+/sS1?=
 =?us-ascii?Q?zVsFHeVI+rHqxYtJZHgBSjL6o8S9uENKQ0IWGqPcyH1eQ9C6rLjlrCCLvhLs?=
 =?us-ascii?Q?xG0x3aDBHnlt8jENz+BdoZtC+ufNQKIE6mOYApdKCTFYR6CbYZdxsA6g29vj?=
 =?us-ascii?Q?txcjbvqOXcIWak50J+o+Gk3OeWKO59RINC0ZWyg6DCANki7QKSFYrvkK+6TW?=
 =?us-ascii?Q?rcUITWCgjFJD8CKgK8EF5tHWS42e++2EogAYqUT8VeNrwM2vvBoZPz3Jh80m?=
 =?us-ascii?Q?wYBf8wyEy63+IZf7ji9xPcuHQsEpkwO/SUgYaTWFdDUQa/FH7mIydxteZJt8?=
 =?us-ascii?Q?+nnyDnJinqRJ673it/O5Smtifu4zeJki/7P0K0za3ERXQi94uXnDN92vzGWC?=
 =?us-ascii?Q?ooUFYnXYm+F05jHsKvMbdCyU18Ny2DgkvTbXtePWf4wydVuF/h87y2Jg+UxR?=
 =?us-ascii?Q?BFkR+eT8PvlL7ivfQJ4tPSHwO3IW8l93bP3Zm00d6yAzSaAN2MVLjfNS7Z7Z?=
 =?us-ascii?Q?oGwzrVovLdBzA4djVRbZt8q+Qp6Ijpmv5/yJiu76j6e0t40CJkvVphMJQV42?=
 =?us-ascii?Q?XJQ8mR8L4505fsxXxy+RGO7PP6uMwsPjN2nTrwqFrj0qgyRfhdaVixT7Wht4?=
 =?us-ascii?Q?r+g3zi3B+5pm7j9P1Jdf/MMw7ombzqtkXUVVBK9/Y//58i0AvK8u4TytAakf?=
 =?us-ascii?Q?aZP8qFnRL6LWBu/SGxBnzz+BxqUTv1dCDzpyGiFKFCrz14w6PpmcfMQSQYR1?=
 =?us-ascii?Q?paaFLDk3j5DccilAwXQZlFAEXMp0Xcu31Nhs?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 07:31:55.0656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca71416-29e4-4765-4354-08dda1a78ce5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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

Instead of checking the response flag, use status mask also to check
against any unexpected failures like a device drop. Also, log error if
waiting if waiting on a psp response fails/times out.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  |  4 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  | 11 +++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c   |  4 +--
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c   | 31 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c | 25 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c   | 18 ++++++++------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c   | 25 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c | 25 +++++++++++--------
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c   | 25 +++++++++++--------
 9 files changed, 107 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 9e64f478d9f2..5ee913780780 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -596,6 +596,10 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 		udelay(1);
 	}
 
+	dev_err(adev->dev,
+		"psp reg (0x%x) wait timed out, mask: %x, read: %x exp: %x",
+		reg_index, mask, val, reg_val);
+
 	return -ETIME;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 428adc7f741d..a4a00855d0b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -51,6 +51,17 @@
 #define C2PMSG_CMD_SPI_GET_ROM_IMAGE_ADDR_HI 0x10
 #define C2PMSG_CMD_SPI_GET_FLASH_IMAGE 0x11
 
+/* Command register bit 31 set to indicate readiness */
+#define MBOX_TOS_READY_FLAG (GFX_FLAG_RESPONSE)
+#define MBOX_TOS_READY_MASK (GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
+
+/* Values to check for a successful GFX_CMD response wait. Check against
+ * both status bits and response state - helps to detect a command failure
+ * or other unexpected cases like a device drop reading all 0xFFs
+ */
+#define MBOX_TOS_RESP_FLAG (GFX_FLAG_RESPONSE)
+#define MBOX_TOS_RESP_MASK (GFX_CMD_RESPONSE_MASK | GFX_CMD_STATUS_MASK)
+
 extern const struct attribute_group amdgpu_flash_attr_group;
 
 enum psp_shared_mem_size {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 145186a1e48f..2c4ebd98927f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -94,7 +94,7 @@ static int psp_v10_0_ring_create(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) in C2PMSG_64 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			   0x80000000, 0x8000FFFF, false);
+			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 
 	return ret;
 }
@@ -115,7 +115,7 @@ static int psp_v10_0_ring_stop(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) in C2PMSG_64 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			   0x80000000, 0x80000000, false);
+			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 215543575f47..1a4a26e6ffd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -277,11 +277,13 @@ static int psp_v11_0_ring_stop(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) */
 	if (amdgpu_sriov_vf(adev))
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	else
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 
 	return ret;
 }
@@ -317,13 +319,15 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for sOS ready for ring creation\n");
 			return ret;
@@ -347,8 +351,9 @@ static int psp_v11_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	}
 
 	return ret;
@@ -381,7 +386,8 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
 
-	ret = psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
+	ret = psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
+			   MBOX_TOS_READY_MASK, false);
 
 	if (ret) {
 		DRM_INFO("psp is not working correctly before mode1 reset!\n");
@@ -395,7 +401,8 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
 
-	ret = psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
+	ret = psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
+			   false);
 
 	if (ret) {
 		DRM_INFO("psp mode 1 reset failed!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
index 5697760a819b..338d015c0f2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0_8.c
@@ -41,8 +41,9 @@ static int psp_v11_0_8_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_64,
@@ -50,8 +51,9 @@ static int psp_v11_0_8_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	}
 
 	return ret;
@@ -87,13 +89,15 @@ static int psp_v11_0_8_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -117,8 +121,9 @@ static int psp_v11_0_8_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index 80153f837470..d54b3e0fabaf 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -163,7 +163,7 @@ static int psp_v12_0_ring_create(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) in C2PMSG_64 */
 	ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-			   0x80000000, 0x8000FFFF, false);
+			   MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 
 	return ret;
 }
@@ -184,11 +184,13 @@ static int psp_v12_0_ring_stop(struct psp_context *psp,
 
 	/* Wait for response flag (bit 31) */
 	if (amdgpu_sriov_vf(adev))
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	else
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 
 	return ret;
 }
@@ -219,7 +221,8 @@ static int psp_v12_0_mode1_reset(struct psp_context *psp)
 
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_64);
 
-	ret = psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, false);
+	ret = psp_wait_for(psp, offset, MBOX_TOS_READY_FLAG,
+			   MBOX_TOS_READY_MASK, false);
 
 	if (ret) {
 		DRM_INFO("psp is not working correctly before mode1 reset!\n");
@@ -233,7 +236,8 @@ static int psp_v12_0_mode1_reset(struct psp_context *psp)
 
 	offset = SOC15_REG_OFFSET(MP0, 0, mmMP0_SMN_C2PMSG_33);
 
-	ret = psp_wait_for(psp, offset, 0x80000000, 0x80000000, false);
+	ret = psp_wait_for(psp, offset, MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
+			   false);
 
 	if (ret) {
 		DRM_INFO("psp mode 1 reset failed!\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index df612fd9cc50..08ec69d6a137 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -382,8 +382,9 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64,
@@ -391,8 +392,9 @@ static int psp_v13_0_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	}
 
 	return ret;
@@ -428,13 +430,15 @@ static int psp_v13_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -458,8 +462,9 @@ static int psp_v13_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
index eaa5512a21da..f65af52c1c19 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0_4.c
@@ -204,8 +204,9 @@ static int psp_v13_0_4_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_64,
@@ -213,8 +214,9 @@ static int psp_v13_0_4_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	}
 
 	return ret;
@@ -250,13 +252,15 @@ static int psp_v13_0_4_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
-				   0x80000000, 0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -280,8 +284,9 @@ static int psp_v13_0_4_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
-				   0x80000000, 0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMP0_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 256288c6cd78..ffa47c7d24c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -248,8 +248,9 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	} else {
 		/* Write the ring destroy command*/
 		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64,
@@ -257,8 +258,9 @@ static int psp_v14_0_ring_stop(struct psp_context *psp,
 		/* there might be handshake issue with hardware which needs delay */
 		mdelay(20);
 		/* Wait for response flag (bit 31) */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	}
 
 	return ret;
@@ -294,13 +296,15 @@ static int psp_v14_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_101 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
-				   0x80000000, 0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 
 	} else {
 		/* Wait for sOS ready for ring creation */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
-				   0x80000000, 0x80000000, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+			MBOX_TOS_READY_FLAG, MBOX_TOS_READY_MASK, false);
 		if (ret) {
 			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
 			return ret;
@@ -324,8 +328,9 @@ static int psp_v14_0_ring_create(struct psp_context *psp,
 		mdelay(20);
 
 		/* Wait for response flag (bit 31) in C2PMSG_64 */
-		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
-				   0x80000000, 0x8000FFFF, false);
+		ret = psp_wait_for(
+			psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+			MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK, false);
 	}
 
 	return ret;
-- 
2.25.1

