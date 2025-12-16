Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C484DD637AE
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58D5310E2F0;
	Tue, 16 Dec 2025 21:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l5JE0Hse";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012006.outbound.protection.outlook.com
 [40.107.200.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F190610E2F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vbnfd4gSkHS/kQfnMEYKULuwjmyLOvC+WfqJM5JTrtv15GZAlnC+sdBrXYwCml6DXjIxEyhP/UrpOhaI6nCoph5eOGFnRtwKrddrQQJlpoyYl3VTL7QZcxTa9/HBqU689GaQa19lnvx/FDGdSKi2goLjO9gNsZ1qx4vj/oJN52t8AS1ATQfHU4s0zsvOmCFFNE5LnHvTjn0wmvBrzyGRhBZO71zz6lkippDG9VXqpLzopTsHaZuGQG1y23B6nN3FeppwtUGgIIIA4fR1HJ2PA+yxEs623aZ3HEs8XNX0akxMj/8vJ4z/FoirwDnhKByYJgjcu6rw94hqe3yq2v6LCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoGyvDfcpJ3bIrpgIIPZOvirGtzoDSoPtr4KsqFsmW8=;
 b=lJIhjvMiL+gLz053qYGanur7/IQWcRE3npwXEM7KkbzMhilxuhfspRa/NGqDZBEW5OlGKY5/mPxtZkcHIyQ7q2aC/y2x6Czxc4lWx5SBk0cWTd1Kj8OgJCvC+astI6lT8PZxLNneGP7/zI4lKfft2x5zlyASujKTg67rN7Zq7U05Y38m5ErURy+XAZqI4OkiFjMU7x7KNdrWYVcHPWmYEURC2EFIlVnIL8XDoxt1pDUDga9PLXi70xVhMILFYDAyYbqRJzKdqZe/TbVuBOtBRTQYqpWIZeTUIUiDAdNEKJSoLXRJi5jtxh/3qIHV+yG4eyEFJcjHJYrMLORezUZBAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoGyvDfcpJ3bIrpgIIPZOvirGtzoDSoPtr4KsqFsmW8=;
 b=l5JE0Hse482UHI8DP1vOrmi1ADyQwSlcnJsZHrtpsroKT/QpVrDbvwq/t2ppJ3R5CcmuHE7AMdfUgz4eqrZreasah6ngBtLwIt9ldha+t58ULPVCosKNuNteGTXDNTsVrluz8KRwM+KRMGyAsrYc7bkY/UDR2iygJ1ZeyROb/jE=
Received: from BL1P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::17)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 21:04:04 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::50) by BL1P223CA0012.outlook.office365.com
 (2603:10b6:208:2c4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Tue,
 16 Dec 2025 21:03:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:04 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Init mcm_addr look up table
Date: Tue, 16 Dec 2025 16:03:29 -0500
Message-ID: <20251216210349.1963466-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbcbc9d-58e9-45fd-8d4f-08de3ce6a537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Xn6f8rapbY4ztqvU5kbHpuWrWqLetAdwV2sX/Fz64/NAGQnuX5xxPCfSnpwn?=
 =?us-ascii?Q?gyGbRYyptWIHXm3W33HfKxA17pGbG3JMzyogf7DzlSLg1ahLsNdr0Lw+RvL7?=
 =?us-ascii?Q?UKKIWeDqiM9m0UwRbUgiCVxGuNIOHRKeX57Xw6xsY4qpNOcS8TKLyIeAMODa?=
 =?us-ascii?Q?CK3VF4GaR4opJQjajbEZ0gGdKlx1CkUYVUkSb5+MEBoJ0KvsboCeI5pfI8bm?=
 =?us-ascii?Q?8Jsvk6qIpitlzN7e4ew6zlQG/XcifDOiLUqvZpleCgBw2DgVfc7BitcQ7A8N?=
 =?us-ascii?Q?mllHZ7fcoQB9O4kSl/9l6OWDojccwh55Zt3m/lYnVClpQvhkNOQNxlTqNzEF?=
 =?us-ascii?Q?mdsQ43KCVklOzJclG9MFMGV1r236SWxlKClj6A29CUyPvBv8snGGTP1YeAp2?=
 =?us-ascii?Q?QxMb4skmZiURLrmlESdiwVtG2J6wXg/VgA6bp5Wge4b1+oc9FvBqkbu8suRd?=
 =?us-ascii?Q?k9URdPV3lqC6shfxfuiU11kCi3QzgUGqk4txcMGxccUPYFLlAlU1jKI5Yt8D?=
 =?us-ascii?Q?WO7PV5WQFPinPDIUnNBauUEsFeN48LS5PpbC1zftoZlileTX1p7njYoazaNh?=
 =?us-ascii?Q?srTuLqp0jxu4uIGkL1Ksh7z14f/NcSI2fOvTfKHKYdwjWlnzzCfS7JJaqldN?=
 =?us-ascii?Q?IdbABqKO7txP7ApgizdRa0A6OeS4F/t+/lfvFjk3rPs1h/A9maRoAakk5Klv?=
 =?us-ascii?Q?Fi/9Zn59xJEUf3+Kqe7wKqnkQAUpdWLxQX6wnI23zpypYuSIPoLN7VjDS4MN?=
 =?us-ascii?Q?KVeTamflR2VyOMWoH2/JiVQ6AXMNCHRzYobRFevLfffu9ZZ0fDpgNiVMLjDH?=
 =?us-ascii?Q?J9rCeH4ODN0QggixMC62NZgiCP0NqxIdX1kgrvS4m7qF5iALNwhLTAqFoIQ3?=
 =?us-ascii?Q?gStc/YtZbKRCQWaIa8vIAXxkQLIX6ak2W5uc9BAzOb6ViFcIgKcb+JuOb6f3?=
 =?us-ascii?Q?61ixboQcK9pT3T4770hLfksR/reVrLiozcKmprB+WZ/VUlig28UJhG9MOyeg?=
 =?us-ascii?Q?HZHvlXE5JJGVnyT3DpYXLb0Cm2oRCQyie8R4d+GzBfLCE18Jf8pwa8D55sYF?=
 =?us-ascii?Q?C+QCqKcnwS7qXm31CDjgEdU/vKGWU18p9xNfhk3geggdu96ny3iwkloxdZt8?=
 =?us-ascii?Q?2Fq6wHhVpewVPy1TPF1uYyjvPUZdXxOrP1FYn3awCxbNlGcCWA85mKKpwO/A?=
 =?us-ascii?Q?UsMSBLrlTTqExlz5tLNFqpW6IBo4qgk0PvLQfcmADcHI8PzleHAOf4EYEvnh?=
 =?us-ascii?Q?tyyttiO1zSuHhQ9mAbJK2IS9ipk9R6j6DIZjssKX9cwemcowOF7mJpMBrWiK?=
 =?us-ascii?Q?xE0tgaXG1axXbfg25Cu1eO4KHJ3oFF6q+M1Zo7rCZdJ+Ncfejnb1I72s2Hav?=
 =?us-ascii?Q?H+tcuCgBzjdrVx+i3g2RJQbn1HtbEjieYjio0qEt6SdT1U6OI0X/WfJWK2pk?=
 =?us-ascii?Q?S83wnUxdmLncTtxASZCN4MCzXd+47Nx2bvDRI5h75hq51Of/x5STLZsW6tD1?=
 =?us-ascii?Q?gEUUV4cmGMGLOnURDk3o8hfFzp7SQoMyr+HEi1RN3ut25N5Ybnudro69JJ2b?=
 =?us-ascii?Q?MYxce2vSS2e+UJm+5ok=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:04.4790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbcbc9d-58e9-45fd-8d4f-08de3ce6a537
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Encode mcm address look up table in SPX mode
as a temp solution.

v2: fill in when interface is ready (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h | 1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 5 +++++
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c  | 6 ++++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
index eb8537558f5fb..9c56be725ff3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
@@ -39,6 +39,7 @@ struct amdgpu_imu_funcs {
     int (*switch_compute_partition)(struct amdgpu_device *adev,
 				    int num_xccs_per_xcp,
 				    int compute_partition_mode);
+    void (*init_mcm_addr_lut)(struct amdgpu_device *adev);
 };
 
 struct imu_rlc_ram_golden {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index c2c4cb6154fb7..73ca4921ae5a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2666,6 +2666,11 @@ static void gfx_v12_1_init_golden_registers(struct amdgpu_device *adev)
 		gfx_v12_1_xcc_enable_atomics(adev, i);
 		gfx_v12_1_xcc_setup_tcp_thrashing_ctrl(adev, i);
 	}
+
+	if (adev->gfx.imu.funcs &&
+	    adev->gfx.imu.funcs->init_mcm_addr_lut &&
+	    amdgpu_emu_mode)
+		adev->gfx.imu.funcs->init_mcm_addr_lut(adev);
 }
 
 static int gfx_v12_1_hw_init(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index 8e33ffcdfa4cc..539785a51f69f 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -153,8 +153,14 @@ static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
 	return 0;
 }
 
+static void imu_v12_1_init_mcm_addr_lut(struct amdgpu_device *adev)
+{
+	/* todo: fill in when interface is ready */
+}
+
 const struct amdgpu_imu_funcs gfx_v12_1_imu_funcs = {
 	.init_microcode = imu_v12_1_init_microcode,
 	.load_microcode = imu_v12_1_load_microcode,
 	.switch_compute_partition = imu_v12_1_switch_compute_partition,
+	.init_mcm_addr_lut = imu_v12_1_init_mcm_addr_lut,
 };
-- 
2.52.0

