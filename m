Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54040EFB7F6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 05:07:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4B710E0F0;
	Tue, 24 Feb 2026 05:07:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EUTkqkOe";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2EEC10E0F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 05:07:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8XBewSRF77fRhWV5VIJNMBUGW7Q+as+ESauwTX0oRnWf+D4dsYa1yG0GiY6NTIfiEaBoRxR5qAao2ASDdG1zCjDz0FfIm15AkR5H2GQWttFoVDEvkK0HiaTlU0NU522KpXPxitEfi8Rk4fJCpr6g54cyNqN+0omwU0/bGVow2kZI3u626zuNnihH7b6fNxCAYdf68n68KgvcZYhI5lHyYIgaWp3NAmG9Pe1zXvu0z9ffllSgyoR5oHowbd1979LPdNn9Fsn0BXo0IhKTvMO9xrPba5PDG+umX9oWAID+/gGM/gLKLpE+V6oB7tVANh3cQ0H0gAr2ntW1q69LDGAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/8+2jSvvD5uphXs+NgOQdNuPh2yfcI+NjG9svIelxQ=;
 b=f8BXPtSR94FJp1V6PUl0KCF8AYn5RCnMfYP7o5bcX++C7eKeikfODH2duV0c/HsKQgEtHHd0o/Ee1iMrnPpGJnHkXjP5P9WUnYpKVLpiFawAnK/Zw4zR6MQnlUhsnEEAcsz0yuS1TLKslprFw4bLnfO8NTl1WGrLm4V3BVSlXVTgZB++gjuh0YTpkZvKneAxkK8r0+x1AKnionL98izPNu6wjHTjqDLfFHB7XYAS3qq2NWCkjrfgqvaZleTGcdquR5cSOvQO+qHmHwP1jwsGi6VTmid8ev4/MsD/5NK/XJriGNZjYiauEkcYIuYld4Xb45FdcKOjQpjNDe8zV5jHOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/8+2jSvvD5uphXs+NgOQdNuPh2yfcI+NjG9svIelxQ=;
 b=EUTkqkOec/pMW+BhPAI0isPFNBdWTwWQDiEe/PxvX38E9mYy1dYXjFPAxAJvyS74Vl/R0GbuDtGEurWtKGiYdBwCzSJYp5rHYXAk0AWJ2Y+t6Bqc2hTnNq/mQ5rKZn2PwAsMnffJx57IfiHaNd1QXgm7VaYhG2DvhxghhMMgdbI=
Received: from MW4PR04CA0343.namprd04.prod.outlook.com (2603:10b6:303:8a::18)
 by SJ2PR12MB8783.namprd12.prod.outlook.com (2603:10b6:a03:4d0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:07:19 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:303:8a:cafe::6f) by MW4PR04CA0343.outlook.office365.com
 (2603:10b6:303:8a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 05:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 05:07:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Feb
 2026 23:07:16 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Ce.Sun@amd.com>
Subject: [PATCH] drm/amdgpu: Fix error handling in slot reset
Date: Tue, 24 Feb 2026 10:36:57 +0530
Message-ID: <20260224050657.1775564-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|SJ2PR12MB8783:EE_
X-MS-Office365-Filtering-Correlation-Id: 22cbf08f-12ff-483e-648c-08de73629586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m+6ak1gmCuStzyGfqGs91XuBWu83ORMXiarWbJ8gEN91pj2MhWmgXrfKU6z9?=
 =?us-ascii?Q?NKP3pvzOpdwCtREiAH0YI7aC/j9KfygOFxiPOzbR987572RY7KAcLjsX28au?=
 =?us-ascii?Q?VQMABgk8h5cz1WwFBaIiWs+1t5W6Hs7WmFBWMKUcGLJPBCIOKxj5dDhOaFFb?=
 =?us-ascii?Q?jc+iIIYEQ5WnW35IyixNHT6VpJmnOb2yUqrwBJf/xISOnRTINO2deTZHzsPE?=
 =?us-ascii?Q?JpfIVgAIKMr462FFYWH8VHGPABD5Dl9PUDxC8vZZQ9CZurNNdoO/MQbpxIh6?=
 =?us-ascii?Q?nABX6ylF4rlxHLyAob2hV3Md3dvRHVYg6W6QRO8DxTTxX7caJPLUbs/aw3fK?=
 =?us-ascii?Q?Os6mg8IFvGUVcpzYz7qmyFW1Q60EvRyQ3FTqLjwwwxvIiJ5zPkz6ir/6eRAT?=
 =?us-ascii?Q?waME4CltMsfblDGsypWud7/xS7toHLupqtTtIo6/PO1XX5H8Ni0PKp+hQShs?=
 =?us-ascii?Q?xY7okDhcuAC+1IO0kncF9ywvclZV7/WmUDtlhr+dKwGZ96OiU8lF+Gz4vJMV?=
 =?us-ascii?Q?T9a0xd0Thu9iNqLS1uQ2MjxKWLppijHGTGH2jL9xTYvE93aPJdarPZiSUgaQ?=
 =?us-ascii?Q?YxCY9Rd1NB7i6sRbB/Nzhm3wcjf4RhUzmkdQntzwM6hMnDcWwnEFv6d22W0e?=
 =?us-ascii?Q?Pbe7DHzxvWw7nxzYxyIDvibqiDJHcTUGhuD3/FySFJZCNzowQ0CELPy926uy?=
 =?us-ascii?Q?mJqv0wFyxCIMLgxrRqOmcrgpOem7/hqTNhDfFE6erFZS3BnN0pompGV1ppib?=
 =?us-ascii?Q?mquRDuPax0y7Mi3AX64nLcgPwPPy8SXsj63UHdchasa0va1BwENcKdxLJDfc?=
 =?us-ascii?Q?QGzYhQWhL7WhXQTom5E6sVfV1garD3DBqwmzCcyTqcPIYJLEV+YWoJHI3AFO?=
 =?us-ascii?Q?AVLtI1gO3IBRF8xVD7vwazLx1WTtgz9iGH1nApeEg2hR7qmB9T4NXJBElggE?=
 =?us-ascii?Q?87/1zQ9DEBeD+FacQKwjcoxL8jNUGcZ/VrQOq3/PWVLqhlH6ghAor0U0l9/D?=
 =?us-ascii?Q?1d2fRF3qHEsqBElqe9W2yqlmo7NIDjx7wnzVK7ZrhMMC7pXRZ4+uWfF6Q2SA?=
 =?us-ascii?Q?2mzIPqTKGfAqacH0Qv0FJ+aBov2EfTHwEeI8k8pEaWoyJQ/CnpY9t38THX6Y?=
 =?us-ascii?Q?rjiF8EikQyMtuYBQ5Xf5DhkkchWPA50LN8LZQUSAZERX/AZc0JvxLEyuvj8r?=
 =?us-ascii?Q?y5+S8Vdv7FMkeyu+aXPSyvt+I5eGgb0xv+1j9gR5xSMul5MS4DMSLipsjhRu?=
 =?us-ascii?Q?NTvK1R9m9z9nCxEXclMiyBELRfdn7sFIXFTXgUJmm8LbaACqfiVr1RL3im34?=
 =?us-ascii?Q?7l4gjkDxGOd3eWCczFXgP+7bJj2qvwNqMhi9dxF5i7sGDc9LimHWjrsKe/k6?=
 =?us-ascii?Q?lARWwKGdSgbwBVCbFFpOsqkNJgojkGIFwuoxTwE6yUb+0LBFuPJr2CBpK/8p?=
 =?us-ascii?Q?jj0agcQOlpCbgMa0VXZq084yslCHplCF4lMWWnQeZTDKtyycC73euvw//if3?=
 =?us-ascii?Q?KndH1pgDRjvg9CZrkScf0smufL2CZX8l5kJDUq1fZ4TH84A0UyjB//0QKKXc?=
 =?us-ascii?Q?lNl/nAAm0Uy3zUbDhxuy0MRbjH3cHcmhyiUaOYdAHH9lNKb+EI4GhiJ7/Yci?=
 =?us-ascii?Q?CwwJbqQbtAOJk5H45W2XpNwsar/6lkaF2mIdV227cZNrpPupi9b8rloKNl8v?=
 =?us-ascii?Q?jCzyIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n58bXVrd8MPLFyypbV9hApCgy+mLVfWw0DrYhX0aT8Yv7P0rg3MarVO1tO1HMn0RqqC62VoYfM/j5KE5+LOtEjhtOlumvt9hXDUC7i9IdrO05YoQaovyLvFTYumaDq41uoZCTEJwdDVn9zQ27X4sVVS6MRmSzsU8PCV6yqtrOnyqGjmo0Cv2ASjXrtlrwwKm5OrlmO/LqIr50WL1VLKqYh0VCQmxwhKl8hFxfcdJ/9aw2qc1x2eoPGFbgbKjqNQz91fFTQ2teCTwAYJTAhYjERet0gsZIYzRA3Q7O5JPaQJPq9Jk7UnXewgnlRUH9aTi0rGX76s+8Gho6AA2d5PUB4cX0VOfTYq9nnTLA+1pNcXlmIoOY2z9vjNf73eAohk5dqVbz5RFn0bOVK/5ijU0kvKlozd3A0lJp9ULE5DMTpPYsIYSiWDrcNIfIs9jjU2L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 05:07:18.5063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22cbf08f-12ff-483e-648c-08de73629586
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8783
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

If the device has not recovered after slot reset is called, it goes to
out label for error handling. There it could make decision based on
uninitialized hive pointer and could result in accessing an uninitialized
list.

Initialize the list and hive properly so that it handles the error
situation and also releases the reset domain lock which is acquired
during error_detected callback.

Fixes: 732c6cefc1ec ("drm/amdgpu: Replace tmp_adev with hive in amdgpu_pci_slot_reset")

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3020cd2493f7..05362f262726 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7045,6 +7045,15 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	dev_info(adev->dev, "PCI error: slot reset callback!!\n");
 
 	memset(&reset_context, 0, sizeof(reset_context));
+	INIT_LIST_HEAD(&device_list);
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		mutex_lock(&hive->hive_lock);
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list, &device_list);
+	} else {
+		list_add_tail(&adev->reset_list, &device_list);
+	}
 
 	if (adev->pcie_reset_ctx.swus)
 		link_dev = adev->pcie_reset_ctx.swus;
@@ -7085,19 +7094,13 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 	reset_context.reset_req_dev = adev;
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 	set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
-	INIT_LIST_HEAD(&device_list);
 
-	hive = amdgpu_get_xgmi_hive(adev);
 	if (hive) {
-		mutex_lock(&hive->hive_lock);
 		reset_context.hive = hive;
-		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
 			tmp_adev->pcie_reset_ctx.in_link_reset = true;
-			list_add_tail(&tmp_adev->reset_list, &device_list);
-		}
 	} else {
 		set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
-		list_add_tail(&adev->reset_list, &device_list);
 	}
 
 	r = amdgpu_device_asic_reset(adev, &device_list, &reset_context);
-- 
2.49.0

