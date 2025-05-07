Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1201C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 14:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C7FD10E197;
	Wed,  7 May 2025 14:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ckuU/HhS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4442D10E197
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 14:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yudfR+SmmO7QPjCkU0TKeMifO2GtqkkObCEVkLCtKvVsj1qQTRv4WOWCpV20WjmX2yshCPCf+SHyHQOsHTLcnxKVHYV71BWYwPQ4G36uwv+h0vNTLyWGRKRlw0a+2jhL2H0MQlgmnT/TEmcQmnhuTwqHLdzgQXhqE0MO4hpSE8dAN0dqWj79vGVSOfw2dUocswXez8WsbDOmUp+ezb2keYRihLCwFWDmGCDUEDuYdcIc0PEblAYPjHCo/uW0ut8SeABKGMNd0+wWcjRQbzgEJsYOjoKKbvMAaZAMCOytGHxrhE7A7uYljBr3KvAH1faarQ4vMXJx84MvIlnkhnSZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbvf7pi+4iQjaKXWJLaDSFUjo96m43vePDumUf+hjm4=;
 b=Hw5lyHITPHy39HFccjZWI/KRdULBoAYeJ9YSr/FtNqhevepr5ooDGkC/VqFi8yoPw469XsxH2OyXinwkHp7UqxqGUvqELJvSo5BQW3000vdHOeBQOVkiubRdcKWZT7JawikgY3u/xodGL1k/qC2cRLuJJak3FeGrJKNzVbGt6Qb7LoY/oBDKR8zLIyKi0vZ8HBsGbw2f+Xa/pZpk8GFzunQJ9r2qwTF+lAL3lBzFksxrsZsGX1sZLCVoiww0vqmPZJE2xvoqz08jehlsWG18dSxbpLespLJF271VxjavW4+7P3xta7uhkuPt3vkyI/zkLhv4YXEsJ2hI21vjXDY1dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbvf7pi+4iQjaKXWJLaDSFUjo96m43vePDumUf+hjm4=;
 b=ckuU/HhS+nm3n0HtYPLl2ljBzV5QsBJEMCBSy0gabtX0sOSxk9g7Z19ppXRPvweg8CI7pqL0wUkRnR4L5yXUez95MvzbMb1Zf2UfSCgROBt64J0tyao0QxrVoAhviDkvTWxHmVgKBuWbGk81Ul4uJHof6wltBxbHBc0BIDjeW6Y=
Received: from BN9PR03CA0038.namprd03.prod.outlook.com (2603:10b6:408:fb::13)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 14:06:46 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::f6) by BN9PR03CA0038.outlook.office365.com
 (2603:10b6:408:fb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Wed,
 7 May 2025 14:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 14:06:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 09:06:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: drop warning in event_interrupt_isr_v1*()
Date: Wed, 7 May 2025 10:06:30 -0400
Message-ID: <20250507140631.200770-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a2e0695-ea29-4f7c-d77f-08dd8d70671b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wti7mhZE9V7ceD9EC1sCRbmw9qIiEK2GTEIvOv04cjfQC7T2w60f1JaSisib?=
 =?us-ascii?Q?YAP6AMBsxRxuV+kp4dyMCKyHEHW5C2X81FGcakB4ixnk67AhNU2hDgiiiTEK?=
 =?us-ascii?Q?0WfueDeghpo9yIC16OpWDHOPyNZGswcUSRAgIjGcXs85m4T+PlV+IdTdJvCk?=
 =?us-ascii?Q?nSGFKmkiK8OvhxDDixeUjC20Mbnj8L7Owre8vrzNzmhllDHWymnKFyag6FU0?=
 =?us-ascii?Q?nVy8YMHlxfzNYxrFWvLEdjNr7N+VGqW02V+oxKbhJrnJtmBPNlQsVPlN5+A3?=
 =?us-ascii?Q?20/Xoe5T9/R7MSlzWsVSKkr6huYPMeUcGw610Zth/FQ6qPuYHSS4riP3Yf69?=
 =?us-ascii?Q?hpFYTlv/0EjYg75lyPKtK4DhYVl/HOHFiTnH4P9A9jtvkK+F2KB4axdKlL8w?=
 =?us-ascii?Q?Ps3F90LyaFXiYsoK8Bh83+IKZGLH5DNrTXKgeobRA5SpfaeuQOLLtkeukas5?=
 =?us-ascii?Q?asGx5BHpEHQnr5Y/L5pnwQXsTWzo/QuuNmscLPVA0EZmZJyg4x4ay0VPzsXe?=
 =?us-ascii?Q?ZHOzMK9/IRnWuM4cTjh13yqm5yZV5vo6b0/IeY7M9ok6vBwXUDj2S2z80l8L?=
 =?us-ascii?Q?MxhSs7Zat6qjc++sODnkoVEpi6H583DQuGcln5ppq/uQmhcKXU38RTojFOme?=
 =?us-ascii?Q?TOXJ1j6ic1EcgNuNu1m74nTR4MBTMes9IPUlXjWRbqkiYGYrTG3J1DNkk7FC?=
 =?us-ascii?Q?9HFvg9aM0raa41zZDXjHS2boxr2STgki6LNdKqEIfAJp5C45oKpxHcAC2hq7?=
 =?us-ascii?Q?8yA6NaxvmtvOoODTzGCIc4qttSxUERoTVE8SqftMKcevAuCnXuTLKo1Klt3p?=
 =?us-ascii?Q?76WN60+LYqLmZo5oPSMwLLxKtiCIOVDPrYPsWdr+4QL9I4Mst7auJhflcLoh?=
 =?us-ascii?Q?Ax1Wg2XjZ0WuMHTl4qEftsC45nrCYBB/S27itwYAIbCEhFM71kl2S6BAmlk3?=
 =?us-ascii?Q?BoHqFlpEyCeurBRwEsntXTjTctjUCzVnWji7AusrOIlHVSD/XdfIhwPu3yaq?=
 =?us-ascii?Q?cxhFzZo1T5BlfgCK2Ow+rCkipGi2HT5ItPM2smjm+APQ80hMsrvNGGr0TNv5?=
 =?us-ascii?Q?cgF6R3pAJdXUXVBjiCkZ40Aovj975q/G03jB2v3UYuaQY5uaYYa9DP9vhufk?=
 =?us-ascii?Q?8ptabxO2P3MagETEIPo4bXO1HLmrdVK33yGR92mk/SOiP+lMoI2hvFkZJ7Dx?=
 =?us-ascii?Q?SX/qeleQNq4+CW+eJTf5snvkegnhiHatJ9kHAsfq/XoMq6z4ldpWhGCkIKeq?=
 =?us-ascii?Q?A0tCPojvtUDSdgOMpOKAn1kB//aRlEhoik/WxvmLkcXQHGbyl/bUZT2w3h+D?=
 =?us-ascii?Q?TWg05wxGlKgYuAWEsbTieGSJ8Djtkij4W20p28eA4YI/00aNhvFa52PtbSbB?=
 =?us-ascii?Q?3eLCcp8wk8oHe84ux55UvAIh4XNRBDa1j8HpDIFFgGIgrpuWChiF/gwUg8XD?=
 =?us-ascii?Q?k6DRFDwSLe/4DwZUXa93XZb73RUrbSHzhCjQHz0scZC26UfigBb9xHpdP8kO?=
 =?us-ascii?Q?mQYd8lnXWNsW1mZGcCFaH+qwwzsugBY+SSfG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 14:06:46.1742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2e0695-ea29-4f7c-d77f-08dd8d70671b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414
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

Commit ded8b3c36f17 ("drm/amdgpu: properly handle GC vs MM in amdgpu_vmid_mgr_init()")
enables all 16 vmids for MMHUB on GC 10 and newer for KGD since
there are no KFD resources using MMHUB.  With this change, KFD
starts seeing MMHUB vmids in it's range with no pasid set.  As
such there is no need to warn, we can just ignore those interrupts.

Fixes: ded8b3c36f17 ("drm/amdgpu: properly handle GC vs MM in amdgpu_vmid_mgr_init()")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c | 3 +--
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
index 54870b4c50000..3e1ad89747979 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -175,8 +175,7 @@ static bool event_interrupt_isr_v10(struct kfd_node *dev,
 		data[0], data[1], data[2], data[3], data[4], data[5], data[6],
 		data[7]);
 
-	/* If there is no valid PASID, it's likely a bug */
-	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
+	if (pasid == 0)
 		return 0;
 
 	/* Interrupt types we care about: various signals and faults.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index eb88ba8d8b012..2788a52714d10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -287,8 +287,7 @@ static bool event_interrupt_isr_v11(struct kfd_node *dev,
 		data[0], data[1], data[2], data[3], data[4], data[5], data[6],
 		data[7]);
 
-	/* If there is no valid PASID, it's likely a bug */
-	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
+	if (pasid == 0)
 		return false;
 
 	/* Interrupt types we care about: various signals and faults.
-- 
2.49.0

