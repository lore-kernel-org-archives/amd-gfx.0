Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC232C282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 21:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3FC10E694;
	Tue, 11 Mar 2025 21:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pF5APAF6";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C4B310E694
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 21:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ke5lcQJsQC6EW1gasDM6LKVZHpS0guyqE1o2tPXrShFdG86KqqPM3Dnzn0h+dqvA4berzklC1L61lPYEbTtY/zMuvNaTuJqH+txmDK1ISv+XzV4IqNt9LyUvSACgpvDGs12fVzFcPOZJyl6smnBstXOUr/JJjQs5vsNUoUR03V6eEKgGvHXiddqqiK8fi7WQW6bXhJ4Q/wG7ehT2W1npwQ60QmveXpO95Z7e/18BPtfhcu2xavbmwUXhlmVkqJVKWm700X/uARqhlFhA+6TPlIVYLYtjIdiVCC8medBDPTVeFAIz8VGGevekrPD4hqCjmLJR2fmogDILUG3st2dhkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNvRThNBwGO/z0+S73Nd50xVwgqkBtY65NZGHkRzmxM=;
 b=Xo4refchS3uQuDOHRx6NEkkvMlWN8CTvdW+z8ROtMJ+DZ14ie6526BtzXBCJwUrODfilIBFOwT7wkvwsNVcSc3hRFL2S5uVkkv6wJEU/N/h1uA8/UmKoP1vV5NpVLDSkIbdY1nIGY+xStMCSmZJbVVRCIM7wtKXbeTzMs0D2jduN07rjTX1UYb7efhGVwpQ36mRVv4qBf8zHMuWs4Bu9+bTCe7FsZK8ZIyEYitN5WvTeAhh0hU2sml41b4dM4Wl1GWnhWGTGkGinZUzW5I4ydcjRgt71mvDDA5oowO/DbdIG4YPtenJ3aBADM4gn1TFijtD90BxJzegxem8NGOTv9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNvRThNBwGO/z0+S73Nd50xVwgqkBtY65NZGHkRzmxM=;
 b=pF5APAF67Fqn0LV41sunGuTduGEkpqxDdLZeWMRC+RbWQDXW9k1WMwvM1Q6t8GOoYe7uRoHA1J4qCBDkI1m3DI4TlrtpNu/95NOR17ibNkozn8pxprnC7xQEYZsZGRRT5HbeeVu9SiCv5z1/5Tskags1C7LDatR3G2HqsERutE8=
Received: from BN0PR04CA0161.namprd04.prod.outlook.com (2603:10b6:408:eb::16)
 by BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 21:50:43 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:408:eb:cafe::9e) by BN0PR04CA0161.outlook.office365.com
 (2603:10b6:408:eb::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 21:50:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 21:50:41 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 16:50:39 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Lo-an Chen <lo-an.chen@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 08/11] drm/amd/display: Fix incorrect fw_state address in
 dmub_srv
Date: Tue, 11 Mar 2025 15:42:09 -0600
Message-ID: <20250311214618.3106637-9-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250311214618.3106637-1-alex.hung@amd.com>
References: <20250311214618.3106637-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: cd53b85d-3826-422f-97cf-08dd60e6c4fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/lret34USxMUu0TmcQmPaF/urzgk7lAWdXV5j3BVdA432iIF36B+ar2YDw7T?=
 =?us-ascii?Q?zmIr1jnGiVe04UoDLGOSQ322JEDcGkcMfVy933xLqQpcDfU82uuKXNAXhvYY?=
 =?us-ascii?Q?M8coTMu1HTMMgRd9dXCq4ViqB5L9t5U4Umy88A6W3lflh/aOUxGJVXXk7esC?=
 =?us-ascii?Q?UaHh3n3qg3dB6gbIO0r6nasmHN6PvZBj6s/3EowtMpq/she8rn9jcygiCreP?=
 =?us-ascii?Q?hKU8lXmgNF+sQ8vU8Lm18a8OFbSMpj79ljMvK4/QVulKQQTgGOMsZy9rUwp0?=
 =?us-ascii?Q?MYW9CJi72lpF/OjCB9tz8fxjIPmdX9d3tZI4R26BJVu65eaZOhJw6MX3OwnP?=
 =?us-ascii?Q?DhjsSejrqgR2UAoVHWh02Stba/mJXBvO30B8kUC5cD5PiYmyjmfMnd7Pq9Dc?=
 =?us-ascii?Q?eCjVrv4Hd0K39bzVfkMTqk6XynU1apuZWEZq6oyeTBScxPXrYNk01jg1WPH8?=
 =?us-ascii?Q?6ZLoOZ5ehdszjUOSrF1Bshgyyy7t3e2YVidFZVlTDDnV0niAF6D7rrEuMz59?=
 =?us-ascii?Q?xE7KlW3pHyCS3G2+RxpeHq+MNjIBs1wTqFX0qSq9Nnq7T1Us23L5519w7kJ2?=
 =?us-ascii?Q?rfvF/rf83hjZQzCL9cZbWqJRh63AlFvQfB9qVDmxDmNK3DznbVIMCMLRYp8s?=
 =?us-ascii?Q?lRazHwyLam9gsjw5eykAGNTKpltCLDQXoV/OBvSWkZ577rQHOXqIfjA0XsK1?=
 =?us-ascii?Q?yfFBLIqGNTzejnJWHWfbMz1dbWIze50yJqS+Vqt32SZDlHtpk2psopj2UTSi?=
 =?us-ascii?Q?jpMtPU/Uy0Tseq9OGKVbpyMI8JaMrrFMp/21cntQimQfyDytdXXMGXqzrFlw?=
 =?us-ascii?Q?riuS75N1NXugiaP+WT/AbWQ8hzzIWI2iN0j1bHWvfpMBU3NZdbouE19Y/Jl0?=
 =?us-ascii?Q?OMvUQSSm47Adt2ZaF+lYr0iCXxJ1T/bZ7VdN1UbOBPykULDttjrPEBv5IB/9?=
 =?us-ascii?Q?YuetflvxnAMebIUpwa1+7XfXDnyWvs0FduQEht+v1HQrnd8TE5QJBN0kdO4D?=
 =?us-ascii?Q?ZKhwSjVieNGSmggLkWLUO9P5NNehmv0TQOkKHUDAaDjl1ntitmHvuz83sOAI?=
 =?us-ascii?Q?XblNq4XvZeOH3ZFbTeJ4Nngx2j4SstrQLx8Alga0rQma8FzMr/vNt6+oqLGI?=
 =?us-ascii?Q?kFqaCTQGloUbMf7sCGD0QGf+mBFhM+pjdO1+MYYXA5g2XARWprbDEp+dHdoN?=
 =?us-ascii?Q?QySkYCABK31lghgBQ9+C7QpB9PBX/qZNi9hd3bHGr6y0OzJ25zRK27tEbbeG?=
 =?us-ascii?Q?OnxcIhNf9M/B5DZdaAjXsmLa+OVrOw3yRSQEeyABrXPEf9xetE+VriUjFUOA?=
 =?us-ascii?Q?Cs9qJYHuoloLLuNsQifH1fJjTyo3DYynweljQ0u7zMjB2aHowBLCnzw3heHE?=
 =?us-ascii?Q?ynivCk1mGzXqjDunpwLWtBz5TSIH/X8VXRblpN5dE1RC6Xmr1jaPxzn4A8ZD?=
 =?us-ascii?Q?m5pCxQTjmhpxlCyyBpNRoSXpBIvRZjdqMbyh8JxF7euiQ0NlwSjSIjYS+km0?=
 =?us-ascii?Q?ztewKSwEZH0ELi8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 21:50:41.9355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd53b85d-3826-422f-97cf-08dd60e6c4fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323
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

From: Lo-an Chen <lo-an.chen@amd.com>

[WHY]
The fw_state in dmub_srv was assigned with wrong address.
The address was pointed to the firmware region.

[HOW]
Fix the firmware state by using DMUB_DEBUG_FW_STATE_OFFSET
in dmub_cmd.h.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Lo-an Chen <lo-an.chen@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 70038f83170c..ae8133816b43 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -708,7 +708,7 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	cw6.region.base = DMUB_CW6_BASE;
 	cw6.region.top = cw6.region.base + fw_state_fb->size;
 
-	dmub->fw_state = fw_state_fb->cpu_addr;
+	dmub->fw_state = (void *)((uintptr_t)(fw_state_fb->cpu_addr) + DMUB_DEBUG_FW_STATE_OFFSET);
 
 	region6.offset.quad_part = shared_state_fb->gpu_addr;
 	region6.region.base = DMUB_CW6_BASE;
-- 
2.43.0

