Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561CDC28B2F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 09:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D826F10E9A8;
	Fri, 14 Mar 2025 09:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2KCQe7su";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2EF10E99E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 09:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNpBHsVqDF+UfOumkkI51Hx+s3mRapjcJN0w0yLZoxgHiECWH0d+2IWrSRMw5GSc4gNwHzKPY7ZBNDLHVrW3MT+Hdt6bkSLWXyQp987jTSa4R+rit1EyP9TYp9Xkbe6qsR7fDvvKiKx4TMyfJiqYkG86IsYcNTLC6Z1HYk0b+vhPB+yLqTlzpPtu93U06brpDqY4D6Y0xeTeDRTZ1/PociLWGjMMo9om+cL50PGoruu4x8ogY62xhAqSRcO+Z26yYF6/xjH2VKJq59OUEllBysxU4fDemmjCH1pZfGUzc+Nk1lv/If08MlliaGqVHUojzttEpcFhIhCCgWCVln+WDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukgDuOgdGnWyt3asQDjBM0CNsu75cAm0hi/eGOaq0h8=;
 b=Mm/tgroCE0ZeUUwvAsVw6dH/rIhb/6a60Gt5rerlNNRO+gRoQ064KN7d77YW18dYtvZ6v24qCrw3FBNqb2SIQCQ8jubl/QzqMVXbd8tiVQaPcfT41Sa49/Q0vg0kD6s9rGcMkD9Vgqs/xZkJoUK5zk18DdhZ/um1/HXTFGVjuo328eBexEIauREi0XLzn9AeQnbc/qWoCafvRG+sXoHfgrx0DWBZh+RHjb63uOYxbWN+MNX/Ukd7ObuPnVwAHe7gGNkAgSBcoJhRPZ6uYdc3J4kK9KFrbXe+2zajjq1yuI+NRNZXn9MpYYQTmt7n8KY/ECiL7+hq9GHkD/lr+UcnUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukgDuOgdGnWyt3asQDjBM0CNsu75cAm0hi/eGOaq0h8=;
 b=2KCQe7sucmLqkLBiz++AJaZHmaDdnOd/0NDQWx3y9hHEHfRa4g3U2mambFwwYL5nsWnIEfddW8FZ982P47zwLF5nPa+584AXk2ThKWhsRNA6zhP8wTjtE0+HA6Y3P8SBsQuyzTOk55G4MMC5WWmp6lrHQku98+yAxP0HaJNAjTw=
Received: from BL0PR0102CA0009.prod.exchangelabs.com (2603:10b6:207:18::22) by
 PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 09:54:51 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:207:18:cafe::38) by BL0PR0102CA0009.outlook.office365.com
 (2603:10b6:207:18::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Fri,
 14 Mar 2025 09:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 09:54:51 +0000
Received: from flora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 04:54:49 -0500
From: Flora Cui <flora.cui@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Li.Meng@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/discovery: optionally use fw based ip discovery
Date: Fri, 14 Mar 2025 17:54:28 +0800
Message-ID: <20250314095428.2914973-3-flora.cui@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314095428.2914973-1-flora.cui@amd.com>
References: <20250314095428.2914973-1-flora.cui@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 960de333-5671-4bc3-3051-08dd62de4373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nj6DmyH73o+fVRm1hIiUZsb41zsi3XDkpEspWg6/kcGc+VctBRWSzoUTQ5Ry?=
 =?us-ascii?Q?UiZugbK73cYi8CL8y+llSs6fSLWLRzyWS9HgpdOMpcPxfy4Dyz9ciJQBE0He?=
 =?us-ascii?Q?wxO/iUBbsbAW59gCx6Dtwk2C8vQ3SL/uWfhn7uAxf9jZC2997vSK9KdMn2p7?=
 =?us-ascii?Q?toe+Hxz4vq8qjIgGaIouXonvEUmZ9euuYvGipklhw/DqI+yW80Blrr80wykH?=
 =?us-ascii?Q?LOHEWTahlVXduqwMyrdyM/zJk0iufBHBPIZsy7iTHMiHUQCA89enolgJ5f+0?=
 =?us-ascii?Q?CiDvvzyuboy6sywnN8RLj/4Wg51lam0cn+b/oHUoBGOv+xf5JkilhC4NonjS?=
 =?us-ascii?Q?DVESyr9ZIpemwHR1BLbpfrJfoiES2aC62AJTPsAN/7TBbl/jp8mqLg+LRELY?=
 =?us-ascii?Q?lX6ncdTgInpXxD7/yZNZRzdGVqEXzmfE6Zp9WSN5MUzm8RGXo+22RLU7GQe7?=
 =?us-ascii?Q?PE3DTsbtkxtZm0SaVxKtNoAQKd/yqjHlRIgs86DR9pVS2W0UGaIMdZjj51ZO?=
 =?us-ascii?Q?lASeXhu6eWnxtnnIaoAUFLkP7wJznQlSijWhAxMbjZdOFu4RQK2QwSnw2HkE?=
 =?us-ascii?Q?TziTGCxT1aRjy1x2RDoUL3TsRA+J0qn6lItQdRjRWNVaRW82S8FFuz5YfFkF?=
 =?us-ascii?Q?OnpLnJHlSxSYCUylxY5jipvJph3YDLh+Xv9NPhSiO7Y/NdKH13QO07GaA30M?=
 =?us-ascii?Q?GuAXZW1zavh8/06BxhaPkHE8qKELah2nNvWX4xZcC/SQv2bSypMYbLEAdtau?=
 =?us-ascii?Q?/Dbi5lsVpS2C2kw6wGl48DC/FNVjhwVsbnMhlRrxtKpD3eu/PJPHJgTrZiNI?=
 =?us-ascii?Q?+KfHEVZ7Si/P+nC38uY72BHLfnzAywdL5fI2vJtb6QmpO8S2coL4WGCDFQdR?=
 =?us-ascii?Q?ZdA9/3ogGweqYY6oNU9MbiazxOIv3VTCFRKd6r5oHxEXJV2Y/EgLcZ6s4zzt?=
 =?us-ascii?Q?KBIBLfKS4Trk7icddBHqiRxZvKFnWHtcMFWi1gJFROJsCpWTBUhlJIOgDRUR?=
 =?us-ascii?Q?J/4wfuIdRBIkTm/DaYIx/Xu90f6ep1QX5hoNuEN1XsgmuCk/7QDEes4mSTIe?=
 =?us-ascii?Q?z+u2sAo/vVmZEjLSYg78aGVGdAjdnIdq7lmEoYtkNxSvSHIRlSiD+9pZFhKB?=
 =?us-ascii?Q?056yKFz36Wg58/BtW3edEVd+LcpIzFgKEM7eSRVTj0dcj5b1uxpQ2LT8t8fJ?=
 =?us-ascii?Q?6UKuYFGTDACq8Mp03iDWQ0hx2NX5sijj9508hAf1JwLvkDZZBS8fZPwe1BZz?=
 =?us-ascii?Q?BhNRhft+ODgyohOPr91pZEAWpkRiedJdG0n7oXomi//pcdkMJaK5p/xKfzPP?=
 =?us-ascii?Q?uBZZ+IpWgqFcV2DLaayyxUZHd3MfxqYef/Xf0sP98BhUXcNqm8QH6GGu0P9r?=
 =?us-ascii?Q?mHjI11pU3FAUI4XCpGvnntE9631SwqwLhSAVzoe+dKW61TsVQ5KC27GZfxJP?=
 =?us-ascii?Q?EvZ+6uOkCHqcNLF7L7vKiT4QlpfvdcEgylnI9NlogKgo87j9LYSw6Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 09:54:51.0050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 960de333-5671-4bc3-3051-08dd62de4373
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
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

From: Alex Deucher <alexander.deucher@amd.com>

On chips without native IP discovery support, use the fw binary
if available, otherwise we can continue without it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 38 +++++++++++++++----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index fff438baf64b..cf286fde18d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2536,6 +2536,36 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
 
+	switch (adev->asic_type) {
+	case CHIP_VEGA10:
+	case CHIP_VEGA12:
+	case CHIP_RAVEN:
+	case CHIP_VEGA20:
+	case CHIP_ARCTURUS:
+	case CHIP_ALDEBARAN:
+		/* this is not fatal.  We have a fallback below
+		 * if the new firmwares are not present.
+		 */
+		r = amdgpu_discovery_reg_base_init(adev);
+		if (!r) {
+			amdgpu_discovery_harvest_ip(adev);
+			amdgpu_discovery_get_gfx_info(adev);
+			amdgpu_discovery_get_mall_info(adev);
+			amdgpu_discovery_get_vcn_info(adev);
+		}
+		break;
+	default:
+		r = amdgpu_discovery_reg_base_init(adev);
+		if (r)
+			return -EINVAL;
+
+		amdgpu_discovery_harvest_ip(adev);
+		amdgpu_discovery_get_gfx_info(adev);
+		amdgpu_discovery_get_mall_info(adev);
+		amdgpu_discovery_get_vcn_info(adev);
+		break;
+	}
+
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
 		vega10_reg_base_init(adev);
@@ -2700,14 +2730,6 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
 		break;
 	default:
-		r = amdgpu_discovery_reg_base_init(adev);
-		if (r)
-			return -EINVAL;
-
-		amdgpu_discovery_harvest_ip(adev);
-		amdgpu_discovery_get_gfx_info(adev);
-		amdgpu_discovery_get_mall_info(adev);
-		amdgpu_discovery_get_vcn_info(adev);
 		break;
 	}
 
-- 
2.43.0

