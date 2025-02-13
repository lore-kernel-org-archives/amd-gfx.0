Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CCAC021A8
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 05:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69E610E9F1;
	Thu, 13 Feb 2025 05:49:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mnE8mg+z";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCE710E9F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 05:49:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPs5tMuOC+p1pnxHgcI6n/MO3OYCfX4ampZrVwVNsHrcCQ2bDWfxRWiKcxaMvBMqxfX3pk/QGNG+LUyU7tUHgKdg+fuyLVdDjTVWAyLf0v/svXFg5X/k4+zbQv/0l5Nttg3vawzgwCMHr4PtObm2KkzLXPf/9CQlBsKcnPijc3J3gfgw3iLvE/ItOKmA8orCWG6Sm6FsZf1O+G2799U2kHI/v1Amn7t28IxDqJFQv8rGCTwPyBmR0xW5CCFyAkbt70GchEemtg2RgGEhxCvRkh8nksdUx7ghEjT+9iRjvXW7X1FofOiEIMgmRprBduuLFhf8zFKjAS3Vzte5y4TFHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeN+CrPmQGJ0mVpavLIE7Y9FrTx2lp8u+XyB4QbVg6U=;
 b=ZZ/23miTwK/VyHfkHoDyQ5kWurX4mMReYW9uXDUUqVXfQtPrBLufxXe18I3Hm1JpCgni6DbCgwsI8jdsO2zwbF/MmOKT/LgVoXRXjzDwhfCxc5JDB+65dyJeHdWjk1iwjmZoiwo8TYNehfRTsZ60CarDy4j5w4B642BgNkjacc5ZrJ6O/JDr3+28Yi7K0EgRCGTdPueT57xf2FtfhdxIEP5eJS53Eghe7dwSV6iP36iuV4hr1Doez7AhJ5JLL2raEKmdKbo6q0yo60QgwpVV4A+g2uyjVL4htgOG4sijFqUmhNftKPUE/cIDaQdOXXgS8zItKVxxJFxc0TzaRjJqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeN+CrPmQGJ0mVpavLIE7Y9FrTx2lp8u+XyB4QbVg6U=;
 b=mnE8mg+zjre/l83Z6GPwouOBAkbPQ2DxyTYm1muiTsK8kjnR77DuZ9UpqU81JPnsxBFD+AQ+k4EiL8JeNeun/sN9fkdYGmoQw6leOY1iD3KbyEAOhfEuQn+wlfbnN/6qZ8LA/931ltcZbE20eA4e/Fh7FV1ZkfVTxCpr0ZOQNHM=
Received: from BYAPR06CA0008.namprd06.prod.outlook.com (2603:10b6:a03:d4::21)
 by PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 05:48:57 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::f8) by BYAPR06CA0008.outlook.office365.com
 (2603:10b6:a03:d4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.15 via Frontend Transport; Thu,
 13 Feb 2025 05:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 05:48:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Feb
 2025 23:48:56 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Feb 2025 23:48:49 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jiadong Zhu <Jiadong.Zhu@amd.com>,
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH v79/9] drm/amdgpu: Update SDMA scheduler mask handling to
 include page queue
Date: Thu, 13 Feb 2025 13:47:15 +0800
Message-ID: <20250213054715.3121445-9-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213054715.3121445-1-jesse.zhang@amd.com>
References: <20250213054715.3121445-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|PH7PR12MB5596:EE_
X-MS-Office365-Filtering-Correlation-Id: e2db1ab6-5513-4aa5-c29f-08dd4bf21b7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dXwKC7dU9op+fZwPttL+dREIVArmQG24KRKCwhYGPK8B1Aj5SZUUYej3SLMn?=
 =?us-ascii?Q?Q+dJW0GO5f8s/Cegg6piBwCBJg9eBSy6a/4/YrFiA8NNxjGR/9G3oO4Mjfyx?=
 =?us-ascii?Q?AcvngDvunho1ZsV78I0Rpl8850KPRpEI3nmlFSJ7D5s+VJMLYprPa2Z5dJQv?=
 =?us-ascii?Q?Kp3yyHGry6Mq13/GUBa1A5Vqu3LEqm7HHdDhv7evx6HQkSg2bKOSZHqE+F5G?=
 =?us-ascii?Q?Uo8dohn53taAJ2yPFttcxIQ29RX93DcKEFS//X6PQfcTsh7W+RRZ3NczSy3b?=
 =?us-ascii?Q?09/1E7FNbNlApIQ5y5WGvcilmT3ERXDsiegJEimVmDmdIqePrAq2xk6lLMal?=
 =?us-ascii?Q?QzeV2/IM4WEgiP3oloBX/VFeQmjjEPPOJdH31XdM70Bg+Iy9YJEznH4bRmPn?=
 =?us-ascii?Q?S3gPQ+oO5/QMCwutSjgbJ4ePkFYdXKMQP8aBGi4gGu7wRRKEoymKVF9FcUaA?=
 =?us-ascii?Q?9TXRD5/TXC5mUQmbynrTm01nIS3fSmn1haHHDv9MFiYvFTR4zc3pUg/dl7nK?=
 =?us-ascii?Q?7MWbAjKKCm7o4Mvqz02JbfWBFYuboH7Q+7tdNIr80oZvnpcC8DwITZvpozLS?=
 =?us-ascii?Q?XYsu77MU6mn/papgEr2DzdsI4ltZk9o2eRxEZafjzp3bGEbgsFWaiG5BJ4rE?=
 =?us-ascii?Q?8QgbPsL3qonfKK2EIrZmtqHJApQli/OxplB/FThkpKpE+hytxLJDKkLwu4OG?=
 =?us-ascii?Q?ItDAq8GTxLB1U5DoS+c88kldt8uprPYTg+MmOIk0uaD2KBaFVj8DS2KrTwOS?=
 =?us-ascii?Q?oLKV+dD6T/OkISFs2AKkZI9/M3Mh6MzEUbUy5ZOeoeQUpyxSfRF/DT/06dy8?=
 =?us-ascii?Q?pgwaDzrfPDNw7BpBk3r5HFSJLqtKLLltTwgIf6tP9Suu2GAXpfX3XJ+AINse?=
 =?us-ascii?Q?M00IFCywM6dIksIpIABWo3FJiAc2KbhZsGY88ucUBGmS/ZW9Rq1T+bkMvB10?=
 =?us-ascii?Q?h+OA5B63wHFR6NLWDCIbIvzFrnYIDury681Xj/CyaCwOwq8IZxYX1rfIa3vX?=
 =?us-ascii?Q?BRJSkNmXp1dBdnRw/Z/cBoclYYUepCFxTFYi3CJW4rQiPslsbNG55vBBLbdZ?=
 =?us-ascii?Q?GsFFmdUey1WmxS807IZ2MLBCz3N51WeGbIN335KO5S3x6dJ80WtUr/SBWnC9?=
 =?us-ascii?Q?bzbK0m4+h6u8M75mAH36v8FR8oqax87wDRw5D35nLvLXR+J3hzKiFIRtdXhS?=
 =?us-ascii?Q?oaJ/L8O0GukpZdwyaV+T40VWdXcrPZCacJmWZZVfSLiQh5K6us7x+7cyJUY/?=
 =?us-ascii?Q?XydancVsadj+XZpfM90OIgZMbmRyC2YTO7XprntYB+MlGo7ntwm01oMGk35v?=
 =?us-ascii?Q?1l6G8vR6+TFTfhnE8fPbqvWX9nwRHBJ7x7Y2cueyiECeMi8aLx+MtrlbCy+u?=
 =?us-ascii?Q?QD9+EmrIrj+BkBmGK8OUCaBaUP5YZYnEZ7BjK4e+ToXDc2xhD9lz0dA3T3RW?=
 =?us-ascii?Q?F/FI5m4tpia+mdlaL2vJFaM7KlbYNlETBSd3py7XcMQbXFP/UMbZ39q3zLdH?=
 =?us-ascii?Q?2tLAca7AYUn9mHw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 05:48:57.1223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2db1ab6-5513-4aa5-c29f-08dd4bf21b7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5596
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch updates the SDMA scheduler mask handling to include the page queue
if it exists. The scheduler mask is calculated based on the number of SDMA
instances and the presence of the page queue. The mask is updated to reflect
the state of both the SDMA gfx ring and the page queue.

Changes:
- Add handling for the SDMA page queue in `amdgpu_debugfs_sdma_sched_mask_set`.
- Update scheduler mask calculations to include the page queue.
- Modify `amdgpu_debugfs_sdma_sched_mask_get` to return the correct mask value.

This change is necessary to verify multiple queues (SDMA gfx queue + page queue)
and ensure proper scheduling and state management for SDMA instances.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 55 +++++++++++++++++++++---
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index b9f0c78a6d77..8de214a8ba6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -356,23 +356,44 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 static int amdgpu_debugfs_sdma_sched_mask_set(void *data, u64 val)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
-	u32 i;
+	u32 i, num_ring;
 	u64 mask = 0;
-	struct amdgpu_ring *ring;
+	struct amdgpu_ring *ring, *page = NULL;
 
 	if (!adev)
 		return -ENODEV;
 
-	mask = BIT_ULL(adev->sdma.num_instances) - 1;
+	/* Determine the number of rings per SDMA instance
+	 * (1 for sdma gfx ring, 2 if page queue exists)
+	 */
+	if (adev->sdma.has_page_queue)
+		num_ring = 2;
+	else
+		num_ring = 1;
+
+	/* Calculate the maximum possible mask value
+	 * based on the number of SDMA instances and rings
+	*/
+	mask = BIT_ULL(adev->sdma.num_instances * num_ring) - 1;
+
 	if ((val & mask) == 0)
 		return -EINVAL;
 
 	for (i = 0; i < adev->sdma.num_instances; ++i) {
 		ring = &adev->sdma.instance[i].ring;
-		if (val & BIT_ULL(i))
+		if (adev->sdma.has_page_queue)
+			page = &adev->sdma.instance[i].page;
+		if (val & BIT_ULL(i * num_ring))
 			ring->sched.ready = true;
 		else
 			ring->sched.ready = false;
+
+		if (page) {
+			if (val & BIT_ULL(i * num_ring + 1))
+				page->sched.ready = true;
+			else
+				page->sched.ready = false;
+		}
 	}
 	/* publish sched.ready flag update effective immediately across smp */
 	smp_rmb();
@@ -382,16 +403,36 @@ static int amdgpu_debugfs_sdma_sched_mask_set(void *data, u64 val)
 static int amdgpu_debugfs_sdma_sched_mask_get(void *data, u64 *val)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
-	u32 i;
+	u32 i, num_ring;
 	u64 mask = 0;
-	struct amdgpu_ring *ring;
+	struct amdgpu_ring *ring, *page = NULL;
 
 	if (!adev)
 		return -ENODEV;
+
+	/* Determine the number of rings per SDMA instance
+	 * (1 for sdma gfx ring, 2 if page queue exists)
+	 */
+	if (adev->sdma.has_page_queue)
+		num_ring = 2;
+	else
+		num_ring = 1;
+
 	for (i = 0; i < adev->sdma.num_instances; ++i) {
 		ring = &adev->sdma.instance[i].ring;
+		if (adev->sdma.has_page_queue)
+			page = &adev->sdma.instance[i].page;
+
 		if (ring->sched.ready)
-			mask |= 1 << i;
+			mask |= 1 << (i * num_ring);
+		else
+			mask &= ~(1 << (i * num_ring));
+
+		if (page && page->sched.ready) {
+			mask |= 1 << (i * num_ring + 1);
+		} else {
+			mask &= ~(1 << (i * num_ring + 1));
+		}
 	}
 
 	*val = mask;
-- 
2.25.1

