Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BCBD3F28A
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 20:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD25510E1BA;
	Fri, 18 Oct 2024 20:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="umC58xdC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F10910E387
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 20:21:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyFyh4/j2DK2jN+kWnHoYVrlYXsfycuYLh4W/KXTNRjd7nWq8MO9ZljKcBhJRA2cef+LHwIt72SaChg+9NnDosfUq3mgNF7LAPCLGUCQJ8CgABnTjU2B/LTWScqa3mwOm0KxKPjHs8YgcNCMarwuVv5LuuIwot7egKp9izVZxNBAUhQhsC0QbHPr2HUIHFgji1i+buEVgcYsBL00QZJA3Hpgd1cCJfAJUgXvB1nSIgCrEKMo6f3kJtEXrQokrgbEeKbsu8fcRp4AIAUJ/TqHW+ywzY+siSTTUcPBQJPFnk5F+fCHh4UGWkKUbZU9mkQLFhbzUqVw5pWVWVjz4Blkbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPSUdNt+tGZ1t4WhRlm7+Z/NZE23V7Ua0vjf/d2tsR8=;
 b=nxfybYpXidsSh/BNbrpyShd1oPvC5gD8S9ZPWMcq3o00Zw92aCITivvLLsftmmdgA6mtE5HienUFlev3rxsYooD/aOnXuqNFrk4DyuVVDW2EAd9TYBzPmzzBoVrwZCULD72bySakABsw6R9JThHY3xluHrUeHyEIWeeluwA3nVf3NU1fQDPucdvuZxFjfN7zzYj/6h+JYasluI/fBJW3e8sBpAOvAPnjE4niAA0XgQ3jsTeaeh4WgSP7YFOFxcm99h0ACfVUOcHWjKzXLCF/ACmFqzBOtRxjQcv8yahAPXILx47opq329E/V4cQ08fHO5Q5ywqn2FNyeKzi4hYnOXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPSUdNt+tGZ1t4WhRlm7+Z/NZE23V7Ua0vjf/d2tsR8=;
 b=umC58xdCTkQ/0qoBI+/xjDUxTjlzH4hWvilcRP4st4hUnu7Nr71NkLDlYLw168SI57C7KQIZ5bT9YN57uB0zk2g8cjiNPEjmADpiRmdg0JeWQJ80PawFUAbm7XukBABKpzmUhGwDH0AIryXFx3Okposk6MMrB6b391Wf3CV//vk=
Received: from BN9PR03CA0137.namprd03.prod.outlook.com (2603:10b6:408:fe::22)
 by PH7PR12MB9126.namprd12.prod.outlook.com (2603:10b6:510:2f0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 20:21:39 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::53) by BN9PR03CA0137.outlook.office365.com
 (2603:10b6:408:fe::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Fri, 18 Oct 2024 20:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 20:21:38 +0000
Received: from krussell.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 15:21:37 -0500
From: Kent Russell <kent.russell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] amdgpu: Don't print L2 status if there's nothing to print
Date: Fri, 18 Oct 2024 16:21:28 -0400
Message-ID: <20241018202128.97719-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH7PR12MB9126:EE_
X-MS-Office365-Filtering-Correlation-Id: e54cbd01-c81d-4d62-3f79-08dcefb27876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qn2LY9qHMKj5BXmsvLGdtd6eglFm/cSRH8zHwQorkNOBf7wno+YyhnmdmSR2?=
 =?us-ascii?Q?iFkB6Sd8AUXf23GqCScXuK3DtqCsUFfnbctMhBtStvXjxzD1kPKLnOvr0+v1?=
 =?us-ascii?Q?ftyQCyeAG8z0YTkJgtxX2IkL7j1PC01yu8eAHnH9AHKOwEbagcyF/JTx3/Q2?=
 =?us-ascii?Q?eEC2DZL/tpL245AqXu46iuZsjPI8x+v+cpZot5gac3LkfqMDGRyZmnblN7Ks?=
 =?us-ascii?Q?rlCDIiRvl+iYdVnGMG29KcZDq6k8/JpcN+GHZ9FCa0N8nCE1CqF3JqxW11c3?=
 =?us-ascii?Q?TtTZACy5M5apMop57OaJbPPPkynjUcXRb2eH9CeGi3ub0Tw0jRaljqkrqvNY?=
 =?us-ascii?Q?JtK08KKggb5CBOiJEfuvHwBasHD8TfK+/EHkCEfThkAknFi3uje8H+ijD0I7?=
 =?us-ascii?Q?ThV3KLdnl5QpYSTFoT8J5UbPj4+70zA1K3q+fORN0wr7DXhb9gXFiZz12hBl?=
 =?us-ascii?Q?HQHC4Vt8cR4noWnnFC9YmKpc5VwJqa3Rz5IAJ7DivoK3t3c6UP8Q/vv2jzsR?=
 =?us-ascii?Q?JjSG7ycg9aEEDbNM8fzZKIt7A2iUIb4tECelri6WK1GlDIFErCxFRMUIfyy3?=
 =?us-ascii?Q?+x1NAUkmoAwhYbCem9gYH505YZkv6gmNESASxP4jSKfhIPg/wFk+aLu2EH9e?=
 =?us-ascii?Q?pyvd0oMQbb3P0pU0yEf5Qf+p23+PymehhjrMthSLHRiIRcVe5kCo0ND29KkR?=
 =?us-ascii?Q?dAoz28SeV5WIeX0cTGJO/0Ad75r0bLhjzH3YNp79CiMc4apAXe2b7RMy3qVR?=
 =?us-ascii?Q?8zki6tY05a9EwN/rKRl06Tl1EA+tIWPWQk/HM7kTpK5NYO0sJBNL3uzPoL0+?=
 =?us-ascii?Q?QuokKsUfX+SnV6Jo7hRRqSuwX/M8kFUbX1g83ijWMNDXnZBBai+lRWqLjhLy?=
 =?us-ascii?Q?zvje5g1TGr4qv8XAlKJ0uszvi8u7zc5nTZGeusx9JbiYQqBIcju7yUf9ZsXl?=
 =?us-ascii?Q?jf87mINAZ3icGJ2aedjExBmGBvt6v4HUPajH5bzESQC/tEzcxMFacaIoE2Sh?=
 =?us-ascii?Q?ARrEFpmwrq1g2hNPPjNz1ey9KUJ61W0wgI/qY9RfThxeDyntPXAkOXBzX/O+?=
 =?us-ascii?Q?yeFeEY2WHMmuAKvHfW41pj4QSKvEtJIBVLkAcl3el6WMo4/G3RalsRlRX9Ji?=
 =?us-ascii?Q?bM0Jnk9Mm3WHHwYAIzBSeXsQT3Tl+c2wCvy0p6RSY0l2ytXhTiK5PzTGjvs8?=
 =?us-ascii?Q?+sKBjRtteLhsvcGf0UmZUlLQU/kjDLrIa2nEDFbpg2TSkCPvVw1WV0yVOL3I?=
 =?us-ascii?Q?GLdws+t0j3Er5kH5a3ZZt3ISXPMVlZ0XDOkEsc9xSOTcBPLPjgn/8pOfQwQX?=
 =?us-ascii?Q?mrfAzh+Uo1RwoeGuCL7LuJ8ZyMIl41GvbYgYW3XffqzITOD7aAW1lIGsKgU0?=
 =?us-ascii?Q?nJw7bPqMISgYGXir8eVdg6ItwWlV07N8GS0f1SIm6oEzaStpYQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 20:21:38.3375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54cbd01-c81d-4d62-3f79-08dcefb27876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9126
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

If a 2nd fault comes in before the 1st is handled, the 1st fault will
clear out the FAULT STATUS registers before the 2nd fault is handled.
Thus we get a lot of zeroes. If status=0, just skip the L2 fault status
information, to avoid confusion of why some VM fault status prints in
dmesg are all zeroes.

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 ++++++
 4 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5cf2002fcba8..5fe7a1c74ff1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -175,7 +175,10 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 			addr, entry->client_id,
 			soc15_ih_clientid_name[entry->client_id]);
 
-	if (!amdgpu_sriov_vf(adev))
+	/* Only print L2 fault status if the status register could be read and
+	 * contains useful information
+	 */
+	if (status != 0)
 		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
 								   status);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 4df4d73038f8..25a3dee27d81 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -144,7 +144,10 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
 				addr, entry->client_id);
 
-		if (!amdgpu_sriov_vf(adev))
+		/* Only print L2 fault status if the status register could be read and
+		 * contains useful information
+		 */
+		if (status != 0)
 			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index e33f9e9058cc..3dee7474c06d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -137,7 +137,10 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
 				addr, entry->client_id);
 
-		if (!amdgpu_sriov_vf(adev))
+		/* Only print L2 fault status if the status register could be read and
+		 * contains useful information
+		 */
+		if (status != 0)
 			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 010db0e58650..f43ded8a0aab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -672,6 +672,12 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 2)))
 		return 0;
 
+	/* Only print L2 fault status if the status register could be read and
+	 * contains useful information
+	 */
+	if (!status)
+		return 0;
+
 	if (!amdgpu_sriov_vf(adev))
 		WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
 
-- 
2.43.0

