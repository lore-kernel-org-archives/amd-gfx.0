Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7B0E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 16:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E0810E725;
	Tue,  7 Jan 2025 16:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JAIDvjd4";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B0F10E725
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 16:10:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVKAYb/AeKsVElgBw77HnZW+DT91arj3fuRGH5ebdfOWY6YiHwv0osP/GpHwnAMogIFat3/fa/YnopwxEDLTge9ZZHCra0W0a+KiLfaZwRZuRqOmUY+7U+rP/j6dCUdgB/NEI0AkE6yOo2TnnJwbOn3L6rCPFAWek2vo5P3KR3rN5G943v8UjKUnrGRW4STrfX+K1pIU7jMyhHe5OaqOFctyLFrntIUtsuDeACkcm8DhWrH35672ChMBJSLfyX8TT6kvGL/vD6EIbRvwWqd3lGdCi5g8nsflF81TsDRGB2x0YBitKl778T0Xslq/T2a4+oAYbG4uyatNTxrOUGl/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M36e29E495gwh0BvxmjurSihsg+4jQoGxyhilJTwyC4=;
 b=YKRth4dZUZ3iohVTRSrm9/3upqKvkvClb9IFmpYB4O04U2VKSPnrv3rpdMiAp0jFQM9pL53cQK9LXF2yPGzVB4T99qEHCSY2k2neGhIWjFhGKhbscLuNkAT7+WA7/D2y85L3PcdNarjgqY9NXuJQ89cHJ5sjagX6I2UsOOT362Ev2AHccWd9s4mG3IQIkc6F8u7V9dZ2dhfqMkq0Ugw+mrFx1YHLhzp6woBNmZrayvizUwQkeDwDr5/sff36IE0Y2xYBY72o9p5zERsY/vJZ975WX9s8EZih0u8c7AOvDcSaJ8wRDZtMi0X6qy2kzV+flZVhz3XS5dHLKOBeW6YvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M36e29E495gwh0BvxmjurSihsg+4jQoGxyhilJTwyC4=;
 b=JAIDvjd4oXo+Pqz+en6JZmRYfo1RgCjoncXQyEwy56Ljpk+Z2yJFzIIcV1tK1cqtG6GMa4gEd2krZNK3OYQ29G5ssp0Xc7FxxDxPe2VQi5A38Olfo0U2wjAc+moxpdPegjDlrnTUW7lY7srjFhTSDm6J70E7T6+ugq19GRfdqKo=
Received: from CH0PR03CA0296.namprd03.prod.outlook.com (2603:10b6:610:e6::31)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 16:10:42 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::ca) by CH0PR03CA0296.outlook.office365.com
 (2603:10b6:610:e6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 16:10:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 16:10:41 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 10:10:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: fix the PCIe lanes reporting in the INFO IOCTL
Date: Tue, 7 Jan 2025 11:10:23 -0500
Message-ID: <20250107161024.73371-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107161024.73371-1-alexander.deucher@amd.com>
References: <20250107161024.73371-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: f836beb4-0f9c-4c86-05de-08dd2f35d589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sTwHlMIYvooL2hgTWy3d2IstaVJ9djiO24Ca6WokyGklRF+lBeiePYb+qM2M?=
 =?us-ascii?Q?/OTw8j9v/euSEcEsfXci77+eqUjb2KYolGAXLEcU3bzi+q3CMG63FqKgeGBX?=
 =?us-ascii?Q?qYl8fZ0WC4XecKSIhq6bVs3iYOoWh5hixDouQ77wQbWuSZ2kuCfNHFGzRNQM?=
 =?us-ascii?Q?EthT/jtX0lklbH3coLnixWrE0IWEwSQO9QfySEPDcGE6uClwkoVD4PQ+63YA?=
 =?us-ascii?Q?zbGSgUtdIJb/wjmzxgz5wo1+PvHqjJ14/4emeL8qqSwUPwxiDnis6PpaSjHW?=
 =?us-ascii?Q?bdrOvSHqLNebq9zJ4+t3KKVYB17AWTpe/8060562DMFs7fFNB+OwHzG4v6dA?=
 =?us-ascii?Q?4/sGmoZp/OGq6Ln/P7O1Iqp2B4Qb0+1n42vOFbKdQBlgSNsgJuEmMg7FRA0S?=
 =?us-ascii?Q?1ymu4lQk0LQjiXeqNmwqMOIuWssukIMhHZqpJVoxTG05lNV44LSHqywdacsG?=
 =?us-ascii?Q?SIHlyWKS7BuCOrTnHgeVC4lyuK8nMi/ke/eoi2AWeYfhB/n0RhcwGig3vgFU?=
 =?us-ascii?Q?EYC6XzE+ZE31X/6UfvXM0EmQ+lNQt6X+1RHbchFx6IsQgZiI261s38l2Uvqm?=
 =?us-ascii?Q?T7Q2IqIxhe5cPbZAxy080zzTvifq2pvhk95g9T5KjXVGmZ2ELF2F2LuRhUXz?=
 =?us-ascii?Q?m0s0Y+B9Qz8Lgi2eMkByKmBKfCkQscF/Np12jwWALDevDDAo8XV278IfqZY7?=
 =?us-ascii?Q?rNuP5J3XqPBpMiqImCzcHueCVsb3OCSujvpT3HWPHEtvTZlRMeyv/1jpyyur?=
 =?us-ascii?Q?+im7UaGwFp3JWkZFjvZLWkVybITxpUu8fZMIztxqdGWyt8XBtrOBpMMCCTB8?=
 =?us-ascii?Q?GOrWextpnKTnsr6jcPzaRWAYtxz4jncG4o8JsJJvz9xpKsZxh7ID/5wVyWoN?=
 =?us-ascii?Q?eQWczwMldu3eagMpU+xquTdoP+KtZVsNufnkluq2G8hC9n/o7c6XGGBY0GuQ?=
 =?us-ascii?Q?dH/H0pAa5wKH3wIBX3+N6aCbYtzKHfIUuLUJlA4ZjvRFULyO88hCWZMVeJR3?=
 =?us-ascii?Q?1uTpp5gzTp3/H8/eQ+ne9f7ARybvZnjxj8ttuw/Z3fXEMdLQrn1tSDpvg6O2?=
 =?us-ascii?Q?Y/x5gMaOf0pnktNpDeLDNu/5ERzeV88Hg5FLHQna8jTe1KSSb4grfjfS+FLz?=
 =?us-ascii?Q?WQFa0usXh7ElSCHtyFXoJLmHjetU4ceXc+f07gYz3eAtvtaEXoNMs5v+Sg52?=
 =?us-ascii?Q?ckEskxbv3GMERye5QwWHs0VSmLCgNRQVBqEL/twGPoISGxYwBIGFS6hhXCjf?=
 =?us-ascii?Q?aQ/AqluL3MC0xAzfZ4Qm6DyRrGyqQWhLzjQTzMxGK1ulyI8QOr88gW0yNYfM?=
 =?us-ascii?Q?KwGcJtqr6dLXZs2z5rtGvPxG5nHFV/VUd/rYEACnFLQPp7tXcpeBNfCM+x9c?=
 =?us-ascii?Q?7+kKltTXnI8zS/EM8Lj454aDSzS0OgfEJOWWznIpAhIkMLPuvBf1PLaGA3ex?=
 =?us-ascii?Q?Wo4DH87QCH4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:10:41.7996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f836beb4-0f9c-4c86-05de-08dd2f35d589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020
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

Combine the platform and GPU caps like we do for PCIe Gen.
This aligns properly with expectations and documentation
for the interface.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3820
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index f908355df07c2..2c76bc5e25d92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -867,7 +867,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	case AMDGPU_INFO_DEV_INFO: {
 		struct drm_amdgpu_info_device *dev_info;
 		uint64_t vm_size;
-		uint32_t pcie_gen_mask;
+		uint32_t pcie_gen_mask, pcie_width_mask;
 
 		dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
 		if (!dev_info)
@@ -955,15 +955,18 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		dev_info->tcc_disabled_mask = adev->gfx.config.tcc_disabled_mask;
 
 		/* Combine the chip gen mask with the platform (CPU/mobo) mask. */
-		pcie_gen_mask = adev->pm.pcie_gen_mask & (adev->pm.pcie_gen_mask >> 16);
+		pcie_gen_mask = adev->pm.pcie_gen_mask &
+			(adev->pm.pcie_gen_mask >> CAIL_PCIE_LINK_SPEED_SUPPORT_SHIFT);
+		pcie_width_mask = adev->pm.pcie_mlw_mask &
+			(adev->pm.pcie_mlw_mask >> CAIL_PCIE_LINK_WIDTH_SUPPORT_SHIFT);
 		dev_info->pcie_gen = fls(pcie_gen_mask);
 		dev_info->pcie_num_lanes =
-			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X32 ? 32 :
-			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16 ? 16 :
-			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12 ? 12 :
-			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8 ? 8 :
-			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4 ? 4 :
-			adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2 ? 2 : 1;
+			pcie_width_mask & CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X32 ? 32 :
+			pcie_width_mask & CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X16 ? 16 :
+			pcie_width_mask & CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X12 ? 12 :
+			pcie_width_mask & CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X8 ? 8 :
+			pcie_width_mask & CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X4 ? 4 :
+			pcie_width_mask & CAIL_ASIC_PCIE_LINK_WIDTH_SUPPORT_X2 ? 2 : 1;
 
 		dev_info->tcp_cache_size = adev->gfx.config.gc_tcp_l1_size;
 		dev_info->num_sqc_per_wgp = adev->gfx.config.gc_num_sqc_per_wgp;
-- 
2.47.1

