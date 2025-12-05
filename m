Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAB4D374A6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1598910EBC6;
	Fri,  5 Dec 2025 21:49:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ph4dVnhM";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013013.outbound.protection.outlook.com
 [40.107.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E81A10EBBF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYDxHgm4sYk8hXLJhHJ7qLyt42/4Ao6kUtqezzz5OInvqRypxl+IOcbobgHKhqIoqY6sOrKjS7kAC1DjTwvKrK0K2KlHrEskMGh64/QDPfLpFEPLtfNQBMgPyOrUlfubq52eM4gx+TckjSYY0uiRuYCbukDxYdrGiIPQpIlDly3Zn0K5sux55Asnl06egkOHw763Vn6XTecH03zQOrimS8tviVAR8zPymJI+V/RDnRK6ywcvCHs7N0zgDg+SEeWftUgMbZLpImFijJwBlGHFFfYX2gwRGaj4XDNwVeQTircPjLh7pCeELh3OWKjhE8ijz6Jcoe8hQ2rUvlwkdjEL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8LG8W4Qn0UMZVsG5P6ldyHlb1Ya3TgfvMp2+Ex6o/8o=;
 b=B6Eavzt3txjF0cUJtImKMlq3nqVdx2FzBogQxEMsXMMUgOc26EERTzE90IehsaCu4Rkr3vrRFlppy16au7jkpBqv3bkRNUAKkgla97iT9o4szNwGd+rUlrGJfaJKjBh+6Rufn6V/3n7scogotg7wQObykBMw1FSbPuOy1KJ3zZ2VUqLs+I47t2pd/bvDB4+dI6ZINkXR0TKWCkiMViIWRYgQbJLQL27yWPFSobz5lCqN9oBM6pcScmD3UWOZDCV1LoM4o//zea/HKWPC68J15g6wyr/ZkiQ6WCXZcC4d4lNLgn9dwDVUbokCo7joJba8t1I4ojT8CLQ/B9UANCbHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8LG8W4Qn0UMZVsG5P6ldyHlb1Ya3TgfvMp2+Ex6o/8o=;
 b=ph4dVnhMs6EiUwWumN7liILzlj8lokxgQ7B9/Q17Nmpxb+R/0BMixCm7tecvPKovvsP9JAwSLus9U63TjDKb1XCdbxUX9Rp9v3WNp8K44vZ7/Hqtw72LHZ+6oMeraeVnUs0Nt80DpZDMhV6xqj7jKpmZPM4MRzD52c90QS56w+E=
Received: from DM6PR03CA0027.namprd03.prod.outlook.com (2603:10b6:5:40::40) by
 SA5PPFEC2853BA9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 21:49:47 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::d2) by DM6PR03CA0027.outlook.office365.com
 (2603:10b6:5:40::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:47 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add switch_compute_partition callback for imu
 v12_1
Date: Fri, 5 Dec 2025 16:49:21 -0500
Message-ID: <20251205214926.146844-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205214926.146844-1-alexander.deucher@amd.com>
References: <20251205214926.146844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|SA5PPFEC2853BA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb7aef8-9907-4cf6-e5c2-08de3448358d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dwa3YWfbgs+88LNGvHEdB4/9xPrmsX++ZC85pRgD7gBZ4l6zesjBzsaFJF97?=
 =?us-ascii?Q?y2bPhL2UCBaKfP3+HwFl6jMOrCXLQTuq4sHB5hHg/p03w2Ty4hAYlwgHzkcU?=
 =?us-ascii?Q?Gu9/uQHMxowcYqHxocmRIRcADn57P8e8xkwvYeY3OCyTLuFAB7Bb2Iu4v3e9?=
 =?us-ascii?Q?OlWk5HVc7nf8/8wjB7uX0F0RZg7vgKmNiqfWlvYmfSVk/tsuv2vGcJt2j1AU?=
 =?us-ascii?Q?0Ng1N+eZGirtMBa7n73dmCckpVQgdG/NMnu7mvtqxVa51wIpG/KfApDv3Ag8?=
 =?us-ascii?Q?KnfA4dziCrIYWZgOo4+hbKfylZniiEz6OqQLDNkKAK8/9DIGvM8j17C8L3/i?=
 =?us-ascii?Q?GLFMJMjSqUZes7JGPuqLBodFAHcomWRJQSkYc1QYhFBHwN9hir9+RAGC3LB8?=
 =?us-ascii?Q?5ohwS2aCaHxHgN4rDmBRjGpTjET9Mg6KIlq1EQRgmzgAab8eRk99zyGt5uVw?=
 =?us-ascii?Q?1vM8In0++mQJOi5TmXqDwjMylpQe9n9LMPFWq/0y2PtIM8tchVLsi4/IGGpj?=
 =?us-ascii?Q?qrba8TCtx1lvSKW9fUXamSXlCpuQgyl+hhOZJ5wvOe9iFp6bADh520d05LZm?=
 =?us-ascii?Q?93+kAJHZDRyIss/HsJCw7aMkwhmyZ/61t5f6Z5ccXcZ2Wqn+wzob5VHjr42M?=
 =?us-ascii?Q?ze9GDn2fe8PHt6hgupuzbJ33gOTrklnntmgjUHEBroElaWT0RSDRJHxtDvJv?=
 =?us-ascii?Q?ABFSOaKaX3FnGjqBaSwWR4Zgq74wjhStKUwWLr2gpZcjhww2Qfaq/K4yZn3W?=
 =?us-ascii?Q?oQvUVopMCKNRN4O1XunEhiZa3PObDP/h1iHYEnpIoyTJKIkBnEkFF5AeOnnF?=
 =?us-ascii?Q?7W3VTbESbaKU8vNOWj3cd+tBvKNbYr34PUYuYGrx84sbgxLXbTK/X0aC9fef?=
 =?us-ascii?Q?nTxq+u1xgXBiGsL5Eyj9AIMMU6GlmVQiYWAJkYQ3pUm21/RaBgBvO1RIOBp7?=
 =?us-ascii?Q?7rOihccuXHGbltkodx1I/+IF6hwsjksGtsrxNuaqi0hE1P8BVQTKW/MAqQ+f?=
 =?us-ascii?Q?hczgG83pbTsvoxiCw2Y4p7vhGDSJS5m+YH6UTztffRCJ/ZUxYWGLdRvZHxhb?=
 =?us-ascii?Q?68/zKS6FFSsoUMeBBALWCOLvfBXYcWIjI5ixi2sAZol+E1y9i7C0Eytl9Bur?=
 =?us-ascii?Q?1+mK01S4QIReX9l52kRJ2oNI6xcXPq4Ol9iA5EtYum3GMSiiMY5KJb5NQP7g?=
 =?us-ascii?Q?y6CQHYcfBIUrXQxoME1/bydUW7CxKDxEhvnwdjdzJPGn+8Sunt3oWnSQsiVM?=
 =?us-ascii?Q?ClBsO9y78w5ERVJZ84XxfzEt5IDceHpd/xiLvJPPDoPR7BoEp/Tr8L66sXz9?=
 =?us-ascii?Q?oIj9dWs5ZuV//7XFwHo4TfP/FZEcHkBB66v/pfTuVKRZC2L3+v9O0L73c7DU?=
 =?us-ascii?Q?Kt1PsxxFpwtVNolMqETB3njk0r0J2dHHvfpXec/IvVbapGgIZ8BjlnThWFFl?=
 =?us-ascii?Q?F5QeuH2M2tN34IrxjavHxEQyVlpITj7iGlIe+zHXMO8Ogm32MEN3LbR71OJr?=
 =?us-ascii?Q?j+Q4T/Ru9LO6c/dwTSPf1DhbgV01omblKoN+nAilL37QW8VAPcIEy9JVXbMx?=
 =?us-ascii?Q?cVe9O/N+y9rWasVIc7c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:47.3183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb7aef8-9907-4cf6-e5c2-08de3448358d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFEC2853BA9
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

To enable switching compute partition mode

v2: cleanup (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c  | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
index 932976b6f391d..1a9b4b24dcc60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_imu.h
@@ -37,6 +37,8 @@ struct amdgpu_imu_funcs {
     void (*program_rlc_ram)(struct amdgpu_device *adev);
     int (*wait_for_reset_status)(struct amdgpu_device *adev);
     int (*get_xccs_per_xcp)(struct amdgpu_device *adev);
+    int (*switch_compute_partition)(struct amdgpu_device *adev,
+				    int num_xccs_per_xcp);
 };
 
 struct imu_rlc_ram_golden {
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index 13108fd4584c8..2ccc5c0793bbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -143,8 +143,27 @@ static int imu_v12_1_get_xccs_per_xcp(struct amdgpu_device *adev)
 	return REG_GET_FIELD(reg_data, GFX_IMU_PARTITION_SWITCH, TOTAL_XCCS_IN_XCP);
 }
 
+static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
+					      int num_xccs_per_xcp)
+{
+	int ret;
+
+	if (adev->psp.funcs) {
+		ret = psp_spatial_partition(&adev->psp,
+					    NUM_XCC(adev->gfx.xcc_mask) /
+						    num_xccs_per_xcp);
+		if (ret)
+			return ret;
+	}
+
+	adev->gfx.num_xcc_per_xcp = num_xccs_per_xcp;
+
+	return 0;
+}
+
 const struct amdgpu_imu_funcs gfx_v12_1_imu_funcs = {
 	.init_microcode = imu_v12_1_init_microcode,
 	.load_microcode = imu_v12_1_load_microcode,
 	.get_xccs_per_xcp = imu_v12_1_get_xccs_per_xcp,
+	.switch_compute_partition = imu_v12_1_switch_compute_partition,
 };
-- 
2.51.1

