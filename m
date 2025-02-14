Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB906C021A4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2025 05:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 968BF10E482;
	Fri, 14 Feb 2025 05:55:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FjDkYgrp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637FE10E474
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2025 05:55:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWHwMDF/h4fhr1Jy2Y1d8qqqFZTopJuJ+UVt4ptib+Od0ddSXDfRXHu4lQZ/Lmf79T7kj+ZSCtXrD538Rftp2ZduE6Vm3Etv6Q0S4XroWhoKENiOIh2ejEOwU/8PKanC1eCek3/HOF57mNAImX0ouRmYiHkPCS8Nw4wg1OOING41w0I86tGtM/SXKfNTTKuSGcDvhUvYcB54pTvuxCr/hsDZwVdElxiBv6zVACyuL+dYZMJtpqA4gVvKeLXl8on/kx88hhzaY5DdrccvKfJtwtKDpZ98IwFFZPA1FeP6xeUkg7k/Kw7znmyUER/z+N1yJX+AehHftgMgGvr+uKLlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXcMac6FEmlg3QqWt1bT8DC603ulgaIjfWwz+5EjXlE=;
 b=AcKe+vuehKNmvQ7L0zI4y6h20yycZXNMDkST+o2vbtuuYYSsDIHfxI3Ez/kSjwiGgkc82jLyv5bRLDqxVPIaN3Iiw5n4Xj32N0GKfw27XU9saX7D8S+QZ/qLYGa8uFx4T/dK3qtduSlmYcoP168gjtElDr6B4I+5MV6YB3rjVwbFj371JaoVr/4QTA94QiArjZJh6+P5nFQM1Nt7wFjeCtwx1ejoWxuQ9/hLqagbCyDDPXMg0FsdnVfEWlHgQULstCy9mmlQ4j2UYs5noYx8aYyPXCS2OYn0z/Diqx0tJyxF7RcbSgaLrPD1FOG+PZegHq3sRw0rl0qYh7XiuGCO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXcMac6FEmlg3QqWt1bT8DC603ulgaIjfWwz+5EjXlE=;
 b=FjDkYgrpMa0l5wRPqtSEyAxXKNT9agMaDE0P64cgQzy1LQb8vipwEwD/eLWOQHkVMg7BFy1uzEJyO4fGOAtHPptHQt9wJdZi/DivQ/1k0udroGgspd84bqE2BWBxtZ5AUxnP6cf4qx8rcxpyZeXca0VPgnu0Ak4h/r1hvFXiVE8=
Received: from BN9PR03CA0066.namprd03.prod.outlook.com (2603:10b6:408:fc::11)
 by SJ2PR12MB8881.namprd12.prod.outlook.com (2603:10b6:a03:546::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 05:55:50 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::bb) by BN9PR03CA0066.outlook.office365.com
 (2603:10b6:408:fc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Fri,
 14 Feb 2025 05:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 05:55:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 23:55:48 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 13 Feb 2025 23:55:41 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, "Jiadong
 Zhu" <Jiadong.Zhu@amd.com>, "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enable per-queue reset support
Date: Fri, 14 Feb 2025 13:55:34 +0800
Message-ID: <20250214055534.3249909-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250214055534.3249909-1-jesse.zhang@amd.com>
References: <20250214055534.3249909-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SJ2PR12MB8881:EE_
X-MS-Office365-Filtering-Correlation-Id: 817d3e08-9a0c-4c30-b992-08dd4cbc3bff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yddd3byJN+ek88DlQfxjx3Joo83yOXIgKiH4AdvlvubV+JfWON30NP8vRVVR?=
 =?us-ascii?Q?9Gdyrmc3NhVQRUdzIK5SZc1fJIRPcdBD38FYwJLGM3O/KhIACbf6dNoIu91o?=
 =?us-ascii?Q?325aIgC06qeM+m/43zqzTD1dDNSLcT6L5d1AOH4s4mnH6sWOYU0TiDsfOz+o?=
 =?us-ascii?Q?fqNCENRgvYcFw5GT8JbdmdJ2+4+GPDgoLzBkBpaj/p9ynbPDIURfIje6xrxq?=
 =?us-ascii?Q?EHRqaDVGynBQQqzJdGIY6GJi356LiX2PIK3pVE4m5MeI0OXfBclGEWFtei2N?=
 =?us-ascii?Q?ku8N0OfI/vrgx1/hRuregFKGSWjIx12acAWTmtZY7vqEDXUZ84OE0f3VBIX7?=
 =?us-ascii?Q?YRuZG+lkHRh9aenP5m0Y2SnIq2ooLw+gRG+0PIorf6uF+MWBr/FLefahgUH7?=
 =?us-ascii?Q?+2nz+/rOvqTWzp9501ZgF9WyDgXZ4RTp8ytG1H4F18auhNmARPSND5iBoj93?=
 =?us-ascii?Q?tE7XP84Pih5BdOUh9cjjT8GWU/e5ZlluZiuxbTsQsm4V7H2xXxu4hIuZRwPE?=
 =?us-ascii?Q?hbCai5FR27mTecqvR0wTYc9OFValBZFWY/g4R11SMgmruuDkTmtPRMQGXAsR?=
 =?us-ascii?Q?j8hZ7OzwFK/wUVBn8rsixqSKgjhMGfFO5jhE46baRf2uwLk+ztBqJLhG7UbX?=
 =?us-ascii?Q?i155lE+/9quUUA9vOUVerxiVlbSEyjiO5SKmt8lqC3VhQJ16eUOaeJdzyLVQ?=
 =?us-ascii?Q?TNSdInzsGKfoL9CvBQCr+1PHQ6Lcjhk81D2lKEPOMJyCZoHaPGkfQazxIWRd?=
 =?us-ascii?Q?cTf1QrvZZ6sU22OsRzX6tZ5B21QIabUF3zZfan3qHf+gjDZiASjhNjB6S85P?=
 =?us-ascii?Q?AMAF0FesvaCeaDX/JiQuEluv3lV/5rZEr/sxlu2HNgJl5aAsDPmSGKTiTBLQ?=
 =?us-ascii?Q?45VEkwx6cWR2Ug85q6CIXSja6TghGm0P9x/Aegjnib9UvVNRhb7wdvjeTScr?=
 =?us-ascii?Q?fEmHI4di5v8joP1T3ObpyPQE4LhB4xj+WrLMn5J/Ahtx1CYbES/tIivlD3l7?=
 =?us-ascii?Q?mSTiWRyFZr2TQO6rFex7aXlfo9fSWTOxO92+y4VWuerMhM5b0gwbGiB8GEHK?=
 =?us-ascii?Q?YwTaxAlPG06fhMqZWHWkv1IAvps7y4+0EpLbic1vtqdtUSnx4mDn+j7ZCD9I?=
 =?us-ascii?Q?yF3utCLfdyNvK3SMTman7+hom5NQVilqeQ/bgcqIfPzjy2GTfxeV0I17cT+i?=
 =?us-ascii?Q?4ZRL4XMbxU0SuAsmgSurdPZB/68GHecVyJl0C+tQQhj/Lrxp2EwRzUmqdRWH?=
 =?us-ascii?Q?xR/CkLlGy5u/ZdWtebz2Ogo7Q2wmJmqgFr9+2qgWxDEhxYc0W3clzGMrQuPO?=
 =?us-ascii?Q?4iAEz9Q1F26XZsDwfy1VQArIkrsxiY2eIrwuedQlJ4SgqII4qoFEPQv//UFw?=
 =?us-ascii?Q?7U/8qHglQxlMNZX32/e5f5sEiz5QlWyR8lrlHMJynlp+BINB0y8G8Xx2oJ2U?=
 =?us-ascii?Q?hEszurO+7WAR6njK5GChGgvaVam0OyBzPIwGOh31ZP4PfCBeXkIBJ0CF3/hi?=
 =?us-ascii?Q?+jYQl99V8KF6u0w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 05:55:50.0030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817d3e08-9a0c-4c30-b992-08dd4cbc3bff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8881
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

This patch updates the SDMA v4.4.2 software initialization to enable per-queue
reset support when the MEC firmware version is 0xb0 or higher and the PMFW
supports SDMA reset.

The following changes are included:
- Added a condition to check if the MEC firmware version is at least 0xb0 and if
  the PMFW supports SDMA reset using `amdgpu_dpm_reset_sdma_is_supported`.
- If both conditions are met, the `AMDGPU_RESET_TYPE_PER_QUEUE` flag is set in
  `adev->sdma.supported_reset`.

Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index b24a1ff5d743..e01d97b96655 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1481,9 +1481,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->sdma.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+	if (adev->gfx.mec_fw_version >= 0xb0 && amdgpu_dpm_reset_sdma_is_supported(adev))
+		adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	if (amdgpu_sdma_ras_sw_init(adev)) {
 		dev_err(adev->dev, "fail to initialize sdma ras block\n");
-- 
2.25.1

