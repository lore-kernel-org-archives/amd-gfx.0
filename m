Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6418C3ABCB
	for <amd-gfx@archiver.kernel.org>; Mon, 12 May 2025 01:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EF3F10E068;
	Mon, 12 May 2025 01:11:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iEJgoeB+";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9996E10E068
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 May 2025 01:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDf+zi5Pf/zCbSzd8wcionKeXIE7Xl3BaMCpqQ1ADpsVnF7Mlsn8IVu7x+VFq7IfK3/+5/ME/8zeE2N4gx4DDMCNHg8+woSwh8KRq2SKDX3j1IKdTGNtDLQnLUYnGZUwjDqCO8Vp9v88H+ru4UIW8pAyRfhEYHCVYoURmQE94DS3BkTndmCCZ6M6EZq76u3c/RxIHcSsq01OxfR6CTwLiwbzp3o9/qCdmBJfhjM2TL1cv7WZlkKWWpAe18I2+DRJXIlnOIStHUfX5AF284nJ6T45L22GStQGML6m4P+c/A93gAQ9D3C2mdR09yuOCRGFApN8JDENixGErjr2GZ6wFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gA4iQ4rf9qoIUnbhrn15vtVOaITce8WCJtBocakm0Lg=;
 b=wrGQgLR0jCKE+ABxOWKIijgFGdhwGDu+VRRvGykiLL8gIirD2Nx3SVMozkX/EonmRbyAe+TY3B8E8MAJyZbFBZQLAvQBKFU4lUxUSl3n0+bT4b8rNXuD96cKCyjeAEgwyLejpqGbH/a5ko1Ar91PDXU1MGz3CxPWO6ATLO4LqbVcfV3/WahgqllgzaE7ntnUTS/VV0fqw1pJf657nLF35IpRWqb+tCuMsJY4dGouFyhlEh0YctJcj4e8PrEOS14b33r80NBT+yDdXpk7EBw8sZifVesU4YucF/OeviYJ1avm4kN6RSve6h9fAZ2Lrgfbqiols8GzT/mdoD2rvMwI3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gA4iQ4rf9qoIUnbhrn15vtVOaITce8WCJtBocakm0Lg=;
 b=iEJgoeB+PmR9bFSBszaGBGEVwPf3w4kmz/zSL9RkdAbEcMVeUDOBJ9lsEx0rr1Mh2oZxdWku8PBIHX+PnG85cvFt0l8os4yurRfLzU1oiFB7luseyZ8onrhhrpn20pnyj8yEn5iOB68GFJ9fi9j6VhWjBKgmJkTfzKFWDS4Z+/w=
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.26; Mon, 12 May
 2025 01:11:42 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::99) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Mon,
 12 May 2025 01:11:41 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 01:11:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 20:11:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 11 May
 2025 20:11:38 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 11 May 2025 20:11:31 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH] Xdrm/amdgpu: Add GFX 9.5.0 support for per-queue/pipe reset
Date: Mon, 12 May 2025 09:11:08 +0800
Message-ID: <20250512011130.5137-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b34aa3-1b1d-48a8-f606-08dd90f1f3a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vf33IKaJnAh+esxwBieMREHSuknFM1KbO0IkNqxdq1/pwSFcy9e0qqewYPcx?=
 =?us-ascii?Q?D6lWcVjTmwqQ9LNmmf9hwvFebgT5DTvyi+06J3CGKndZqIs95k1UW0MYibIH?=
 =?us-ascii?Q?8QUES1RZZCTpMmEmOnzn4DgDUxfA9bojqfPnCQfC33I0KjI0XIKbNW/2EScX?=
 =?us-ascii?Q?IjrDyF21l6MAXHdCl9EdcnObHtF14lZ4bX1WBAUYODXTCVELavKd9Clx9oOI?=
 =?us-ascii?Q?NAkFHM8TzYWRzEb7rMRqrjfNZ5w2quMYDQahOMlVsqzUZiF+KhE2FDulV0Mg?=
 =?us-ascii?Q?z69n4xfvdJLq3OzL1DeRTZD59RrqEwL1AQjvRzfptEJB1Yi6NyFG1JdRvJ2w?=
 =?us-ascii?Q?ONv2BCDPGXnGUYxuhmIapXNsognANZB9K5m06YRVibyaaGLzhlQXjZrH19wo?=
 =?us-ascii?Q?DtJQV4LypayBlHIwkQFvwGKRyC0EzzdWp3/WGmv/LPGlsaUDvmxqo79aH/6z?=
 =?us-ascii?Q?F4ETscYGBzj16fCS8C6XX93mUyQTRM6a18wgzw/+M0hl5RotFr4+MrhX3wRg?=
 =?us-ascii?Q?0oS5n1QcACeNsmhEdT3txtAlfORUODf7rwcEnxymraIotId6RBI6VmCp8/ho?=
 =?us-ascii?Q?P9cDa70ePdjzLtL4qwgXDZUxNODmesQXtFF2mEmZ7ZYxF4pceCB/qne2dde/?=
 =?us-ascii?Q?2eyeZlUwR/aYmcfPdFIzCIXdHYszdna2ho8ATKb/yvDbYbKuF+1G+bGZqFYQ?=
 =?us-ascii?Q?PSKICqNn7fhotWGFPvIkcJqicJThtL1lJ5dORMvfgfhgqwe1Ty6JEzirvvWA?=
 =?us-ascii?Q?XPYOl8xUQ4e2jGQsSOaGLxZ6H2/k2UV/ZTN9nBSBzfSY8pous269/3rQxKEq?=
 =?us-ascii?Q?cvGov5tJPlj898GmESHSOstykwBq9ru9VhUkx7XbwbtR870orAS5znO6h7CL?=
 =?us-ascii?Q?P9j/TsjP7/Fg1qZTo/1x43bUQqq893g1tyxgFeT0ycUNEkfcnROW+/TB5rqS?=
 =?us-ascii?Q?x03CLs0Ybqd8Hck/PeAItQjU/SoiVZfu8sYF7nnZAu1GIFzy+FFV4oglA2Bl?=
 =?us-ascii?Q?uuHSDqz60BzHbsey34PNyD1KuJ7UVPVjsFS3+fOS6SPmQJdDAHw/rm3aEO4a?=
 =?us-ascii?Q?yApHy9BXwItpkTq4WFvHfNekGCzeT8k5b6hQH4FRUBZySvFGu+NjCliTGG9q?=
 =?us-ascii?Q?0UtR5qAZ8lsB9EepwydV1E8H1YdXfMBjw4edmiu7uBHmK0HntDaSxY42N6b6?=
 =?us-ascii?Q?ZTchaJEtqKmuLR0lEK3MGiK/lJEO72h45vD76BYKfq/s9T9ndZ4D2gRDv/AM?=
 =?us-ascii?Q?nmQzDpbcGMf/LJH6nPgipTICPn7202/tyzX51wz9ubGQDQSTBcsi4vXkxqrJ?=
 =?us-ascii?Q?dU0+jpHlN0xfRep//6nNFlDBMtlsdul5N0/59HbyBDZlHlqEOZbLyUPIv0F0?=
 =?us-ascii?Q?PemJhqUIuddCfiGBm5EF9C+IZW9ysomrdjMQeAwz26hwchh54b/w5yNY+vVj?=
 =?us-ascii?Q?uGT3DS9Pp9/QWoq5+Rh8kfmv9bTAK0kxutyBhj8MxVtqNghy3tfgwQ0wekn9?=
 =?us-ascii?Q?jnubHnPi/CsWy7Op50cXbyaFgkj2hcg1P2gZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 01:11:40.4740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b34aa3-1b1d-48a8-f606-08dd90f1f3a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291
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

This patch enables per-queue and per-pipe reset functionality for
GFX IP v9.5.0 when using MEC firmware version 21 (0x15) or later.

This change:
1. Refactors the pipe reset support check in gfx_v9_4_3_pipe_reset_support()
   to use the compute_supported_reset flags instead of hardcoding
   version checks.
2. Adds support for GFX9.5.0 (IP 9.5.0) with MEC firmware version >= 21
   to enable per-queue and per-pipe reset capabilities.

v2: Replaced mec version check with !!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE) (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9db2bde5c59d..e6d516b1efd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1153,6 +1153,12 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
 		}
 		break;
+	case IP_VERSION(9, 5, 0):
+		if (adev->gfx.mec_fw_version >= 21) {
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
+		}
+		break;
 	default:
 		break;
 	}
@@ -3452,9 +3458,7 @@ static int gfx_v9_4_3_unmap_done(struct amdgpu_device *adev, uint32_t me,
 
 static bool gfx_v9_4_3_pipe_reset_support(struct amdgpu_device *adev)
 {
-	/*TODO: Need check gfx9.4.4 mec fw whether supports pipe reset as well.*/
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
-			adev->gfx.mec_fw_version >= 0x0000009b)
+	if (!!(adev->gfx.compute_supported_reset & AMDGPU_RESET_TYPE_PER_PIPE))
 		return true;
 	else
 		dev_warn_once(adev->dev, "Please use the latest MEC version to see whether support pipe reset\n");
-- 
2.49.0

