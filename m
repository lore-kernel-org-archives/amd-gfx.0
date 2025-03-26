Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2843BC3600B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 16:24:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C305B10E720;
	Wed, 26 Mar 2025 16:24:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZegEzwi";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38EBA10E720
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 16:24:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqkziGDcbHoGKFgrvnKKf/MbUEtv5S+pqouIiTgxdRa9q/zmR6/OtDtzYE7cmDBsliUVHkfLpfXZGEvZWvFJ5RKj0QPLcYXijxDTLBPNGvFxMO2yO3LYP5kqXu4/8H8esEdMKK16XkI/+CSo9ROYy0k6CqY3VkxOwaTKkpNiKSTvN5GebHBFzVLzonzfJt4Qod1JCC0CGVKvlZnqnSAM6Ap/lpIjKlqNPKO/ejeFyjEUnZ4zvO6yEYfv7mXFx9FZBGeixYaEcM3XZFpaEliVJ/hYSL6Hcw4SWcOvbvZ1ryJAqom8s04MfbIh4Y8TEBQJvtAXbyJ8aa/HCm9FYVpbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af4Y698cH4dFc0mF6kesUkp+GXGDKpiVZf8mGLhItwM=;
 b=ujJha3FoTftp+7HQzFEhF6RfwW1FTBkTxkcgyOKoKCHMbJXt/WqpVsUVf7akbGaTsfIRlDna2cOWcpmkUi1egyOTGMrU/JIX9XRfavaLCJvON6ovS25aVZQ1bg8OLGQKeVSrXMpqKLXJBe09wz1O8Thg7vCIfUSBGgKD1Wc7WxV0gGV2YKESKScY+Got1DWCLtR1VAn21l7pKuE3zD+bH9GaPTnG3rRh5uJ1MN8870MEhkPC/1lagWT2qoeoM/PsTHj3eWpqmPPJdOKOCnTf0+8MER+Gs+fIA4jlb7dxiGEYBt3mnFj8N5Ob+AS0h+JH5USy7XuO6uzfJYDxDK+gWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af4Y698cH4dFc0mF6kesUkp+GXGDKpiVZf8mGLhItwM=;
 b=TZegEzwiOZomgrDd7KXFaPJNG9zD5Klghx5UfZtoD8EZyWeza39XL6AVVDnscgbMe3rrS3tSg5jqlVPWnze+8nh0lC900ddQwqkFAOezb68Ty3tRSUvgrBVZi4dGjlhm/5f4cRZgzziUS/T1/MjOljKIloHOj0EJc7Tu3YXnMHg=
Received: from BL0PR02CA0086.namprd02.prod.outlook.com (2603:10b6:208:51::27)
 by CH1PPF2EB7CF87B.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::60b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 16:24:20 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:51:cafe::b7) by BL0PR02CA0086.outlook.office365.com
 (2603:10b6:208:51::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 16:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Wed, 26 Mar 2025 16:24:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 11:24:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/gfx12: split userq setup to a separate switch
Date: Wed, 26 Mar 2025 12:24:03 -0400
Message-ID: <20250326162403.1139259-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326162403.1139259-1-alexander.deucher@amd.com>
References: <20250326162403.1139259-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|CH1PPF2EB7CF87B:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d420e1-cd8b-465f-77ba-08dd6c82a964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/BI+PBhyAakQqKOcFrU9fiQu4/45iMRLhx0/sqvdt828Js5m1kuMa7oAhcC4?=
 =?us-ascii?Q?vHnOwti9ajf7RV2kxn2Fj9f5cjGXIsnhgMSvkZDKYMaPmlAic9WmxImFK1K3?=
 =?us-ascii?Q?NciLieUrNTuy5KVL2hme/P9He6hD2jD3k0fwfrUb8PdEhgCX7c1tObvy1WgO?=
 =?us-ascii?Q?Qb7Byzv6DX2EkRTO9xts+WxldnEuyrMqS/gPV7M8CPQElcf03Za89bgNrCiA?=
 =?us-ascii?Q?fN3067VstbqwlUYfbc0mwlvG7672+gBVcEve8jvI9AYOf/vEQkKNuHiHkj5d?=
 =?us-ascii?Q?NVIndea5Oqshuk3zHLmRa3UbI+y/MQ0jY/TYRUl+Z1O8c4+csbPI62SMXfZP?=
 =?us-ascii?Q?GcM1d8xy+/PGg8cISZ7FWYxOOfRjrSpB51FDaNBPtgZUUlHb0H5Geoq1j5mO?=
 =?us-ascii?Q?HmxMFFLTC/S2Nq0wrfpZ7DvQKYMXyUkKP0/dUglsrZBMuRnuaPXnTtSNhumD?=
 =?us-ascii?Q?TBxdRd6z2ts1azpZeZz+p3lVn7gh074GMRDhBwD2+mjaLg3Y48lVGHT+LkfD?=
 =?us-ascii?Q?8g16IbZs+IpVpmslRsAQLDI1NZzm4PVUloLw8RtAn41V+C/g2nfqZKjlVNmi?=
 =?us-ascii?Q?YvPslThnFM3Hxe7NBdQICzsslL2sMZevorP/851CCdEJsoQtT057iDAtU94k?=
 =?us-ascii?Q?Ti4tKy9MxWUJZ2U9Id1yaqRV8tNHTnCIFS0JJ85Zz8axJoNqoRKLF24PMc0h?=
 =?us-ascii?Q?ClNYD9fkue/nwacPUeR+6HlKkSJyQxhbqIoqA1lQqYfZ4JWN/UnaxBMStkj7?=
 =?us-ascii?Q?opxPE82FDIf7Q/2BM7x3ge8FBMj8wVtuB5hTyxKUu79J50cbiq2/0DbqiOKQ?=
 =?us-ascii?Q?XLezbju85K86+uJuspm4a7FwXdgXUwzgOp0BWwnRNuCNFRacxuhUCX3AV5ud?=
 =?us-ascii?Q?Lgh9DGheTc0TdtBR+Nr4Sb292BMTicy2pAn5KwWkHD8IYvJ+RYu1dscjiEBw?=
 =?us-ascii?Q?sVge9CtLjJyMNpEWmVkvIgIKlYIB9r477TROKsmverNN98nMjNw2SmOci+bX?=
 =?us-ascii?Q?RHcV46nPiaA1aDggVZb8G/afQSI80suf28SLRC86ldXL7lPiY/iXaTPFBAdP?=
 =?us-ascii?Q?DMAvIjyjQk11nU2yxFRRwryRZq+2R3dsNi7qrtmhcp+OwD8BrbE41J+zbsEv?=
 =?us-ascii?Q?W5C9NHfw4VAjfb/6oOd7ic0pSaRjvDA0yG4DgYJpPFTWo1xKBV+aCS2db7mo?=
 =?us-ascii?Q?aViD20Gfa7sBNcbYqYxmZiDykWflefUN8zew8EHhBXoB252P0fc3NdmzHN2s?=
 =?us-ascii?Q?BObWG5xvtmWcRyoskst5X9P+pvVgtT7J1LetrsHE1XE9U5fmQWRR/ZF7vjQV?=
 =?us-ascii?Q?EJ+j9sXJ8mTmYupijNjDNa5j03ebzds5PQBoOBivOpWSkNhIt7UO/MIR9tno?=
 =?us-ascii?Q?RVUerAzwYjW7t+yhReYVMjnedhfyLJc+IFf3mj/SAtwd9HE+2AvLpNFNk4Aw?=
 =?us-ascii?Q?JvJW2eUTpIDlAsWUmugX7+VjODhKCUzRLMiwq8lbOYVOCbTmRq2RYA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 16:24:19.9527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d420e1-cd8b-465f-77ba-08dd6c82a964
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF2EB7CF87B
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

Add a separate switch statement for the userq callback
assignment so that we can assign the callbacks for each
asic as the firmware becomes available.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 289fb2d62d931..e8a10897ceb26 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1402,6 +1402,20 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->gfx.mec.num_mec = 1;
 		adev->gfx.mec.num_pipe_per_mec = 2;
 		adev->gfx.mec.num_queue_per_pipe = 4;
+		break;
+	default:
+		adev->gfx.me.num_me = 1;
+		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_queue_per_pipe = 1;
+		adev->gfx.mec.num_mec = 1;
+		adev->gfx.mec.num_pipe_per_mec = 4;
+		adev->gfx.mec.num_queue_per_pipe = 8;
+		break;
+	}
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(12, 0, 0):
+	case IP_VERSION(12, 0, 1):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
 		if (0) {
@@ -1411,12 +1425,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 #endif
 		break;
 	default:
-		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
-		adev->gfx.me.num_queue_per_pipe = 1;
-		adev->gfx.mec.num_mec = 1;
-		adev->gfx.mec.num_pipe_per_mec = 4;
-		adev->gfx.mec.num_queue_per_pipe = 8;
 		break;
 	}
 
-- 
2.49.0

