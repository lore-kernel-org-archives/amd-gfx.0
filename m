Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA29C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 21:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E3B10E227;
	Tue, 30 Apr 2024 21:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gfE7pPPI";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B22010E227
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 21:12:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gydND8Bib37/xiFkq6Wr8RUSPN0qSZ7X0ycU1BJxZTm3mlWR5L5eTCE9F9qjrs+MzUxmnILMtLahFoxiw7HlYwIQgNJCg3ICxtp5QYodsagtNSIYsc36DbH+y6oc6Z/fc2xSXRuNim2j+4pTa516uMH4bFr7KvGC0avYKtHfirkR5L0rqVKDpYnsH4nhpXCU4c/Yl6zROygoYJoZCt9XZIw0Ar55ywnzOvtLJ5oOpG+URgXfqoNNSlI2OQWjL2soZa4Aj/krQgPRCfUpJ2pa39Z5xX4D8sMsC2hSeLWPXDIXGlMtJuyLclsxvuECsgv7VeIc+A2/fPLzo3s/m0BmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cXNZDU+OLVZUGXsSzcbumJ9VcMB1t1c1DU7+LbXK88=;
 b=JYDWzx4fjVWoyix1y7Iwot06wdzN1Zj2t7wmlZvhzWCfQtMTCCB60cUjrm8LGt83fYl6hUuJiIjr3WdvfqmFbz+8/0c3MxMrsHgYhfV2ukzwhXjmIZC7b1A6stH5MP/f5FOcNv91KUhyHQWSctOS/ClUeS6spr/kBc6EJB2TD9lLGCpGAeIcTml13MLGRQWB8mbhTZgzXJ5ohtN9R6U12WcF/shtsaK0tmluA+0Bn/pI8wma9RgVsiECjRYQtGE0Q7ez/+ibAWlDbM+QeLA5AFhEq44ovn/RaF4lPBWXVhIh+DvEVQM2ji4XfL4AaMv/FBWPtCEoCq//jFyptuj2IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cXNZDU+OLVZUGXsSzcbumJ9VcMB1t1c1DU7+LbXK88=;
 b=gfE7pPPIaD4PjEHXwemrqjyadyxLGcnkAtzbXFxOjXKaBlIU019V2Xo7W0oYZdxFDEem0tJfK95XuAkVO5faHOLN/vt5efaZnk4ii3D5vZfkZ2O4foAImnN9CmTADCvMJFKUYzUQQWkahywJrGSbnBipU7ph8ugf5rE0jiIFYnc=
Received: from BYAPR06CA0021.namprd06.prod.outlook.com (2603:10b6:a03:d4::34)
 by PH8PR12MB6819.namprd12.prod.outlook.com (2603:10b6:510:1ca::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 21:12:45 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:d4:cafe::72) by BYAPR06CA0021.outlook.office365.com
 (2603:10b6:a03:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.25 via Frontend
 Transport; Tue, 30 Apr 2024 21:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 21:12:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 16:12:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add psp v13_0_14 ip block
Date: Tue, 30 Apr 2024 17:12:10 -0400
Message-ID: <20240430211212.814162-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430211212.814162-1-alexander.deucher@amd.com>
References: <20240430211212.814162-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH8PR12MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 7102a034-df5f-43df-68be-08dc695a47a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PJRWJAjqQ/SgTuz+PXYMHdUAu0UHiopwdz0GVQ2iyHnMsKoC0gHNP3dyI7PG?=
 =?us-ascii?Q?nR2eY3gfpU+vCY2al8MauGLnbssR0RhS8QGwlOdQn8wXDDqYKtZg79b1iYfB?=
 =?us-ascii?Q?jzjDid856W4BF7zLVKmYXh9ChEpemNDU85ePiw+mi0NzOfJ+V3uMWZ5oNBhO?=
 =?us-ascii?Q?OPVtAcrWDnyB05TYCPFH8H14g+vaS5fhfcIwR0Wu4TL3CQNG/49bWmTb4yVO?=
 =?us-ascii?Q?ND3tfycnttEMyNgUSoQOOq7hPGmj/avqWWiRRereZk+ei8oQOOofMVd8yvJ4?=
 =?us-ascii?Q?FKEA/cxLjR4tsxyvr5wcQhUezt6Tw6JhZTnhAIUNNbSAmEBHgeVR3BUgOCB6?=
 =?us-ascii?Q?k9hB7U5X3gx1ET3qXFRg3ysgMX177Rguc+YOz1WPb/xttUw6A4lHWpRSlmud?=
 =?us-ascii?Q?4B2nXR10BeHtM4kYiIPeMEkTnrqX4dOGqOxbFHwWC4BUxswoBU1wpw2smUVQ?=
 =?us-ascii?Q?wP5L1UqTWLU25x6gQsucmd1YpcduJse/Ob0Qqal+7WbLOdXC0I1Yoe+Lk7l7?=
 =?us-ascii?Q?yuVhAO+i9x/6FGlQuxUnaVIiyUAiuTz9AuX0yxaieW/nX76zOLLViJAf86/f?=
 =?us-ascii?Q?bmAc76OdjWML17ZLhOOiyGl/YhxZQJNySmyS7E/IsTYJzeVGd3d3MCj7zRbX?=
 =?us-ascii?Q?vW3cuI0uv759e6v/JaBYdzjDxNHju3CTvqjem6vBTR3TtsGGX+WqXm7CVFjg?=
 =?us-ascii?Q?n2Bb0c7nFBOWmcMz0LEXn5jT0VO85LhTb+l8o+6kOjnZAAG56gFfrQ9el+1O?=
 =?us-ascii?Q?+6QzGoKyHrbGSG+W3TVvDS8h2+CP9u8d+VqkwkVoxaIf8ySDLovLADq/5AaG?=
 =?us-ascii?Q?tzkFN3CUurFguyX1+Fqd5DNsam+tgYvGrygHE269qaxazyRTN7F5HqbpurBC?=
 =?us-ascii?Q?I/wohlSjhar/QdcjW1v3/Pi1/oXr0JLqqXqXQSxrw7+zK8RXZyPl8kZEas85?=
 =?us-ascii?Q?K8eY9nk/nAyuzVZNi8qPZL9G4H8h1+vM6GGRg/hOx34kaGk5mwBshpBMjB1Y?=
 =?us-ascii?Q?SuzNQtK55OJbm2C/OetqLjYFkTsezUwl+YxsTPvUluKIEwzM9iZjzjSkK8wt?=
 =?us-ascii?Q?GqyhaPEsuBUGJOOAhSQa5MAyHhuij7VcuBE+iyJwn7rviQsBT6AUDRZsmgCk?=
 =?us-ascii?Q?QPjA2aDwpB3fZeXsH57UiywuREJXNbFWZrmeJ1J9XYY65fnQQBii06y4k1r2?=
 =?us-ascii?Q?H0CiUPwo47nFQqz1hWMVIjwNQTmVvLDjDd9YwQM22m8Uu/jmblYhYHyWAIny?=
 =?us-ascii?Q?rUn/qcvdLzh8mJZG5+pAW0d69QY8cB35fz8exwqQRcfjAlspVSZsYwXOylnv?=
 =?us-ascii?Q?Pc+pPcQW8HOTFbP8/dJ3WKr17TE2byUSG+kAx2kq4rmip058oTeSyNW+JXO/?=
 =?us-ascii?Q?/ucWVNi6vedwbCi0vPW+IBMcQEt4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 21:12:44.8422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7102a034-df5f-43df-68be-08dc695a47a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6819
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

Add psp v13_0_14 ip block support.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 13 ++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 ++
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c        | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  3 ++-
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 83bc80f517fe1..b68cd3b9d60ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1851,6 +1851,7 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 8):
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 11):
+	case IP_VERSION(13, 0, 14):
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
 		amdgpu_device_ip_block_add(adev, &psp_v13_0_ip_block);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index a551c5b67fdd1..37820dd03cabd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -145,6 +145,7 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 		adev->virt.autoload_ucode_id = 0;
 		break;
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
 		ret = psp_init_cap_microcode(psp, ucode_prefix);
 		ret &= psp_init_ta_microcode(psp, ucode_prefix);
 		break;
@@ -207,6 +208,7 @@ static int psp_early_init(void *handle)
 		psp->boot_time_tmr = false;
 		fallthrough;
 	case IP_VERSION(13, 0, 6):
+	case IP_VERSION(13, 0, 14):
 		psp_v13_0_set_psp_funcs(psp);
 		psp->autoload_supported = false;
 		break;
@@ -355,7 +357,8 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 	bool ret = false;
 	int i;
 
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6))
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14))
 		return false;
 
 	db_header_pos = adev->gmc.mc_vram_size - PSP_RUNTIME_DB_OFFSET;
@@ -847,6 +850,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 14):
 		return true;
 	default:
 		return false;
@@ -1450,7 +1454,9 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 			(psp->xgmi_context.supports_extended_data &&
 			 get_extended_data) ||
 			amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
-				IP_VERSION(13, 0, 6);
+				IP_VERSION(13, 0, 6) ||
+			amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
+				IP_VERSION(13, 0, 14);
 		bool ta_port_num_support = amdgpu_sriov_vf(psp->adev) ? 0 :
 				psp->xgmi_context.xgmi_ta_caps & EXTEND_PEER_LINK_INFO_CMD_FLAG;
 
@@ -2636,7 +2642,8 @@ static int psp_load_p2s_table(struct psp_context *psp)
 				(adev->pm.rpm_mode == AMDGPU_RUNPM_BAMACO)))
 		return 0;
 
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14)) {
 		uint32_t supp_vers = adev->flags & AMD_IS_APU ? 0x0036013D :
 								0x0036003C;
 		if (psp->sos.fw_version < supp_vers)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index a037e8fba29f1..7b30f448eab63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3053,6 +3053,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
 		case IP_VERSION(13, 0, 2):
 		case IP_VERSION(13, 0, 6):
+		case IP_VERSION(13, 0, 14):
 			return true;
 		default:
 			return false;
@@ -3064,6 +3065,7 @@ static bool amdgpu_ras_asic_supported(struct amdgpu_device *adev)
 		case IP_VERSION(13, 0, 0):
 		case IP_VERSION(13, 0, 6):
 		case IP_VERSION(13, 0, 10):
+		case IP_VERSION(13, 0, 14):
 			return true;
 		default:
 			return false;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 0da50ea46eafb..b52e15e2dcc7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -51,6 +51,8 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_11_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_6_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_14_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_14_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_1_toc.bin");
@@ -115,6 +117,7 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 10):
+	case IP_VERSION(13, 0, 14):
 		err = psp_init_sos_microcode(psp, ucode_prefix);
 		if (err)
 			return err;
@@ -168,7 +171,8 @@ static int psp_v13_0_wait_for_bootloader(struct psp_context *psp)
 	int retry_loop, retry_cnt, ret;
 
 	retry_cnt =
-		(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) ?
+		((amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+		  amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14))) ?
 			PSP_VMBX_POLLING_LIMIT :
 			10;
 	/* Wait for bootloader to signify that it is ready having bit 31 of
@@ -193,7 +197,8 @@ static int psp_v13_0_wait_for_bootloader_steady_state(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 	int ret;
 
-	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
+	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14)) {
 		ret = psp_v13_0_wait_for_vmbx_ready(psp);
 		if (ret)
 			amdgpu_ras_query_boot_status(adev, 4);
@@ -787,7 +792,8 @@ static bool psp_v13_0_get_ras_capability(struct psp_context *psp)
 	if (!con)
 		return false;
 
-	if ((amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) &&
+	if ((amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+	     amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14)) &&
 	    (!(adev->flags & AMD_IS_APU))) {
 		reg_data = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_127);
 		adev->ras_hw_enabled = (reg_data & GENMASK_ULL(23, 0));
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 170f02e967176..55ee5ac828794 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1458,7 +1458,8 @@ static void soc15_common_get_clockgating_state(void *handle, u64 *flags)
 		adev->hdp.funcs->get_clock_gating_state(adev, flags);
 
 	if ((amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 2)) &&
-	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6))) {
+	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 6)) &&
+	    (amdgpu_ip_version(adev, MP0_HWIP, 0) != IP_VERSION(13, 0, 14))) {
 		/* AMD_CG_SUPPORT_DRM_MGCG */
 		data = RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_CTRL0));
 		if (!(data & 0x01000000))
-- 
2.44.0

