Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8987C3DA7F
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jul 2024 08:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CB6910E1AB;
	Wed, 31 Jul 2024 08:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a8xPLwnL";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFDB10E489
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 08:11:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQQExJvuzVIqqFg9bsGTHXJOYZX1g9mOg7X6xvPc6QxsrKhlkNZzLzyk3l4yzhX4Y4wGl3HgdRz0HCA9DwYOfT9QXhqYUud/nP2tnwiH2LE5u1a8albVnvR764g1zcxY4Z02qXu6+tN6J7luP/mbnUi2jOJKNxDXyjXoUwzHPs5rnLoGiJQ3e8zhqbAR2lqqLRpH9s/7QI4ZorhUMuLbJf0PYSWBkpLgVXNE3yh986iNqF1sWPNWRU1mS/Bf8Q53OUOYnFHvDPxmVPIJ2racg5MGwtubuyi3el7P0v/XMMQz2vrNV0OQpMUvXn6KlOE998BwHUIKTHA2EWKk8/zrwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b/9Y3Y7ODineKCmqBPkDstl5Ylz5w7LH5hjlshCXww=;
 b=x4ULWm0+oX6NghwWfkZ5B2TDsro8rjPHM183x/sbETZsJSHYP8qWcLEFph36VELHG/+OprgrU7PzU/BfPHvZjq7o0zDOQ+Y14r9tLJNqaCb0Oe9un0llGwcKGDlJHGz0zsR78Txc8DsdJvXDKvQzyVlKLZ6mgVS+TNpl3MGRJwh2Wg409AMAZANFVz7NV3dGaSZJgj6rXJjqH0sbpKy6/6JSN6d+SN+sSyho4hS2mZ14nbno/5JQ+SCVhG5RUy3jy5ehLqeFexz//zlA4UcO54ewUe0R46ZDWOm32PqHQkCGSQ4+8KtokyITaDAhSG6LgyD8CJXPOUoF7f1IM7SiQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b/9Y3Y7ODineKCmqBPkDstl5Ylz5w7LH5hjlshCXww=;
 b=a8xPLwnLJmz7XlSXNlYsHV9r2rUXKSSY/VHS9T4kyRjJ+wP+U9mmfut1diUaX8MoCGZZsJTu3n5ELsB1hwRGVRrvHuMChv7CxrIYgoZ/wPQCSiIUZBUn6IWE8k89kvW9Gv0Hf1+/UJzC7T+yvIw4chXsEcoKwhNZYc4xLHG6lZ8=
Received: from MN2PR16CA0063.namprd16.prod.outlook.com (2603:10b6:208:234::32)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 08:11:07 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::8e) by MN2PR16CA0063.outlook.office365.com
 (2603:10b6:208:234::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Wed, 31 Jul 2024 08:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 08:11:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 03:11:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 03:11:06 -0500
Received: from shikangserver.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 31 Jul 2024 03:11:05 -0500
From: Shikang Fan <shikang.fan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shikang Fan <shikang.fan@amd.com>
Subject: [PATCH] drm/amdgpu: change kgd2kfd_init_zone sequence during
 device_init
Date: Wed, 31 Jul 2024 16:10:59 +0800
Message-ID: <20240731081059.312219-1-shikang.fan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: bce8be92-7087-4182-b8f7-08dcb138546b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wFd2sgvnr/andRhbUERN204KRa6F+wA9h5fDo4f0xB3RfevZ2lZDGndyc/bq?=
 =?us-ascii?Q?Kzw8m8j06dQE3JoyKK+wUy++anWcXHs8SXL14vMsgKgC74ywR78UafgGTOKd?=
 =?us-ascii?Q?ZBXYOyap7wNmyds7UH8hwJS0UO4sncRMV+EXhjzs+SlUIFpjP2n/GbCPpiYh?=
 =?us-ascii?Q?des+3+Glnr38PJzF/0JPg1DnWMgLv7xTzLVy03g0YMwZ+r9nicMWZWJyNLTb?=
 =?us-ascii?Q?DSq58rq4+HP/iH+hEeyf4Zs/rekyzPJbYZcKmaOQMIuqK7XwykZKEVlzsmki?=
 =?us-ascii?Q?0/sQCeZh2Md2tJ/x4D28MlR27n7ZPU8Bbr4poYvDHkG31C3KTVgAX3OGeWuE?=
 =?us-ascii?Q?mI+Ubs4YScjGrvgXPVr7mDoYbRG6K3j7S7qWtm+s9ZuHA1NN0ldH5ANT0zVf?=
 =?us-ascii?Q?pmRh1GcNORR5vIZFDS3L9nOEJglgHJkmGv8Jq1FUVpDeGLcxwoY57ALmFU2v?=
 =?us-ascii?Q?UABo2pjoBYmHr58VyO7GQRG009GfX6/Pe693YSgHhb1GJw+k31YTSbXMlwDl?=
 =?us-ascii?Q?X4xGIjDhELyorgMJKeifKbNWkV9a81L1ywpncULzXTqZ7ok0LuUAl22cDfCY?=
 =?us-ascii?Q?2mDiHWg4ubs0rbdyvngupIhLIifZZmM2WpCucJG5GAfWI45wLgna3TIOWrPA?=
 =?us-ascii?Q?ajvxh+r8m3RfU1MhqAGW+xz/N+g119Dt14Bkjd6ejUhL+WGLvTXcGpZVJhwv?=
 =?us-ascii?Q?xKz8ywf+9vj9spF5hb37JT0IaPPd+pdxPan75YfJ5qWgNsoslcVeKLvXckIA?=
 =?us-ascii?Q?BwCD1aA9dNSz1ezqnhn5Auf1QY8AQUpCUv+SJj3O6dpGzZtbeFy18mzfkd5u?=
 =?us-ascii?Q?beQksi8AxdbJCLa2fe6jzUbk5b0A5o1TubmqDzIyRXZoOLJK8Wxb7krBNFym?=
 =?us-ascii?Q?Pr6pTTIYD4HeQLhBmlXoypNLpczIw6e5py/eUXFaC5gX7q6pEFbfEoNEShxM?=
 =?us-ascii?Q?b2eHp8COMI2k3MVh713LHJsS1TZo4QyqSzDXKpBnxFiSAwcZr0hzb2d9uLhj?=
 =?us-ascii?Q?e+/it0WsJafFZazaIhPB8y2TpuAJntgsw0VR1/ueoNZYDszyDQHXFDWz7HuF?=
 =?us-ascii?Q?ToIgehbxQ3M1aEecvnYDKwH47AJ/iAn4hfohSkOTh7/q3PmfKjspAyj0wdtD?=
 =?us-ascii?Q?tU/CkKLiG2xnHnDSeR4DBv11gWYU2S6PVNQz885ErrzVtvy0E5zG8qx0t/is?=
 =?us-ascii?Q?P/5FmSdoTpLPdnvxizPULrX5jCIxRHXvswEzimUD0mWghecgqZw2KweR1QKm?=
 =?us-ascii?Q?+afqyMtwEnOCfbHhJyYxFMAJw9ivCX+cjplKjjLdCsqOsuER36DE0l9rgYST?=
 =?us-ascii?Q?4ze2TRczYjUP7aITEusM4GjzZ3ff+KEUIQqJjLvtOPUHCjUPxvEOTLfmwWsT?=
 =?us-ascii?Q?cUdukmzELOVmf9M7db5qPuUV/tpRMDzxImVCpRaEao5KoMQAUHLLcSyO3mJ4?=
 =?us-ascii?Q?d8YbLhAT4XVaTYEwkOVdNsn7j2XTV6re?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 08:11:07.1617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bce8be92-7087-4182-b8f7-08dcb138546b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
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

Move kgd2kfd_init _zone_device() after release_full_gpu()
as it takes long time for asics with huge bar size and it could
potentially hit full access timeout for SRIOV during init.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3a43754e7f10..4494fa7ae70f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2930,10 +2930,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
 	/* Don't init kfd if whole hive need to be reset during init */
-	if (!adev->gmc.xgmi.pending_reset) {
-		kgd2kfd_init_zone_device(adev);
+	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
-	}
 
 	amdgpu_fru_get_product_info(adev);
 
@@ -4362,6 +4360,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		flush_delayed_work(&adev->delayed_init_work);
 	}
 
+	/* On asics with huge bar size, memremap_pages can take long time
+	 * and potentially leading to full access timeout for SRIOV. Move
+	 * init_zone_device() after exit full gpu
+	 */
+	if (!adev->gmc.xgmi.pending_reset)
+		kgd2kfd_init_zone_device(adev);
+
 	/*
 	 * Place those sysfs registering after `late_init`. As some of those
 	 * operations performed in `late_init` might affect the sysfs
-- 
2.34.1

