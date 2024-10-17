Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C07D37485
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B11910E826;
	Thu, 17 Oct 2024 13:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gnAdcuvA";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9890710E826
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPLRQ8yuuU3NLokRKn+eLiddh/7s+xjMYYVGmkSbHNCH4M8tYbNRQ4HhiGSjRCQhBHmvHluPBOmQ2cWhUsZK6qcGSCbSjpJgNBbJbSu/bougpk/NJuT7ssPDWgNemww+ZIYj7ZocZoPdCBxMOwDsVIaWIIVIV+JUdbxYotgc72zdv+oV0ycJvAdFlVstg7chTEILiV6k4bA/peWR1EFhqFpG11GDd2coIZiq7ifL9j8V4weqOvY4pIqud4w2wsegsub3FUJjwyOfNAHvarm1g0LCio7vybDyzKygoy32u4fXdP6Vcxis30aQAMDLnAOL1JI2UDPto2LVmiokeUoVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnT3R3C62x+a6VRa24eNfqfLTlV0DNfIhNY40yR6kaw=;
 b=FFZsz3egzI0eiaQ2wx08aY5hrhDcY4C6PRnTn1JOaqU4VcPZrX+bwb2MdKR9liFDmFGbJ7f0DvGJppwIBrJ1C9yEzMA+w4Ex0Htiff6zfK4BTA5ZsPTKs5cRPp7sgfb/FO5dC5XnC1LNiD3eiABBQF8das3UYlRmeZ2mi4Zxomw67pUsG243DChPxTqpLpXS6NulMBOANrrfHjHk/aHvz8eBOaCsT/qTCtXKiAfhVGQJYhQmc68PF+qkn0iE9slXUyyNOH+jIf6WBjKvvboYOmznpX6JoMj+H1TuKJ4VdSZFURepv0yQUinYrsqxy/60yxcZUFeI7w3hFVGZ5cIE/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnT3R3C62x+a6VRa24eNfqfLTlV0DNfIhNY40yR6kaw=;
 b=gnAdcuvAcexmRtkXDsZfVKVcUP8njVykjjKzIsOQ3gmflyLmHI4zTlYoz+GZvzklOj7uabOAm+PfFug5M2RKueSUaoTONOBxUIp20fDg2oMEHYlkc/8xlX2ZKjtK4SIbUlGBHujpXwfWavIaPTW/6D0Z5DSlbI3lT4IztIx/iDA=
Received: from BN9PR03CA0897.namprd03.prod.outlook.com (2603:10b6:408:13c::32)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 13:21:20 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::3d) by BN9PR03CA0897.outlook.office365.com
 (2603:10b6:408:13c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:19 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:17 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 04/32] drm/amd/pm: add inst to set_powergating_by_smu
Date: Thu, 17 Oct 2024 09:20:25 -0400
Message-ID: <20241017132053.53214-5-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 008c2501-0ffa-4647-e3d9-08dceeae968a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pSl02q+XBKvmGrdFrRYVHfXYhDZ6lzeoehlC2PnzLheqISVHQTq+vQf1fkh2?=
 =?us-ascii?Q?uh4khIygnffbMNpocA0sHqUxQcHBhRML+bDv0iXxAKTXC4fwyiD/djzrngoy?=
 =?us-ascii?Q?/oAl54wJWyXQeeyzUAiGcRlzvT/Ptz18uLQeVv72oD0gVIe4buAySG0xYkV7?=
 =?us-ascii?Q?oT1+p6fC0zrIye89yO98NFXCKd/XL7WL7/Fn5voHg8vMrRmZqwhjkk678A4w?=
 =?us-ascii?Q?wSywzEGPH5SrTw5pzJxWEBTF6VkfUzQ3u5dTXKNn/VIQ5c0rDHNW6/DAlzmu?=
 =?us-ascii?Q?60a7dmd15Bl43mLFVJmOXj+8GIF0MFR6/yQPOuJ4+on7J0z7SjFOd2w90+1R?=
 =?us-ascii?Q?mACNjAgCZ90wqMmiSBmTu+UClzRrnm/gwe0wwZHNmfrIfMIMFyluATDR4KsA?=
 =?us-ascii?Q?HwEPFw5c78WmOJ2kZg7Wgc9lS1vyszfBWAG89k5A+Lr6wN9p6mP+7w4LyCgh?=
 =?us-ascii?Q?UnRrVdqRuJ11NBG+4Qqalt0o7Oh+D0VjdTAX4potxotFMubUXLFQUsT4d/Qo?=
 =?us-ascii?Q?35L9k4uIxWMyZnDOlTxQ0GwIlYkkKWKYs6lUeIdRjJkYL2tJVSF06aEc9rwb?=
 =?us-ascii?Q?aQ9mKti/f2nG6m8BbjvD8Gb6dEtHJCp+q5nq6rbRI8qe0CiIV7Gb5zUEr8ES?=
 =?us-ascii?Q?DUKgsuQKN41UTqjIrEie6sR917V8g1LgmSQ/xm1tmbHLgBXCysqQojq/N7rN?=
 =?us-ascii?Q?3xK4xtmN8DRsizoVqPudqXlD7r8hkZBMQmoxwq5AbXXkxvGW4bPjJCmukYz0?=
 =?us-ascii?Q?sPE7nXaTm9wPbuM75TPLT7DC7zRancgutOeMK9WdD/8tyJx6JAmHdWTuywJl?=
 =?us-ascii?Q?oeQ0qp2KljsbSzr6PeDriutSV2iyDMmu+5NL2bJK3q3DWQ7GIXxM3OfwDwTq?=
 =?us-ascii?Q?pBhqnzyOqGyAto9vdzHnEei6JxJe3GeG+TujLDva4xp9GMuWUr+ga4bgZjdt?=
 =?us-ascii?Q?s6rSwvQPmcgaagancag5/xf0iqusbnhbdM/1m7VsE60wD7md8vhQ4jZ74Zdp?=
 =?us-ascii?Q?6nPlistMA5nyPja/uz1i3OIpQX/8XAzGDZsEO4KUvBIrI0ubwsYezc+KW/+T?=
 =?us-ascii?Q?L16sr8O7+lBJWOk4mUiwfwLEiibyjZy71oQDtAUIuDaZYzWdZ8SoDwIkR9CP?=
 =?us-ascii?Q?4a/NtEwAM2eD6NRqkIFBJx1D0bktM2b9XBlyPxI93NVrgXaZRo0sEdzR0TUe?=
 =?us-ascii?Q?WskQA8/+OWEhjBV27f1t4Vya8mFnmNa2NgKyJhcEnlMHGjorisSsqjFJ+uVW?=
 =?us-ascii?Q?NvhlC6njdLpG3tIK2WZyY2rt2rY+HWXOlfcORhCWmcPoRvzI8LqAjSyhTlFo?=
 =?us-ascii?Q?i+4ENOemtZGXjkN7Wqf91OaYGyIIf3zV69wItxEn1AHGiPHTloKYgzGOxuXB?=
 =?us-ascii?Q?nZNtienMPYQLgE6TMzDsYrAanq76fLcIrPTMGkznJ3lTcFZWaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:19.6547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 008c2501-0ffa-4647-e3d9-08dceeae968a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add an instance parameter to set_powergating_by_smu() function, and
re-write all amd_pm functions accordingly. Then use the instance to
call smu_dpm_set_vcn_enable().

v2: remove duplicated functions.

remove for-loop in smu_dpm_set_power_gate(), and temporarily move it to
to amdgpu_dpm_set_powergating_by_smu(), in order to keep the exact same
logic as before, until further separation in next patch.

v3: add instance number in error message.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  4 +++-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 10 ++++++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c       |  4 +++-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 14 ++++++--------
 5 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2fa71f68205e..f24bc61df9a7 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -405,7 +405,9 @@ struct amd_pm_funcs {
 	int (*load_firmware)(void *handle);
 	int (*wait_for_fw_loading_complete)(void *handle);
 	int (*set_powergating_by_smu)(void *handle,
-				uint32_t block_type, bool gate);
+				uint32_t block_type,
+				bool gate,
+				int inst);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
 	int (*get_power_limit)(void *handle, uint32_t *limit,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9dc82f4d7c93..bcedbeec082f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -88,7 +88,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCE:
 	case AMD_IP_BLOCK_TYPE_GFX:
-	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_SDMA:
 	case AMD_IP_BLOCK_TYPE_JPEG:
 	case AMD_IP_BLOCK_TYPE_GMC:
@@ -96,7 +95,14 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_VPE:
 		if (pp_funcs && pp_funcs->set_powergating_by_smu)
 			ret = (pp_funcs->set_powergating_by_smu(
-				(adev)->powerplay.pp_handle, block_type, gate));
+				(adev)->powerplay.pp_handle, block_type, gate, 0));
+		break;
+	case AMD_IP_BLOCK_TYPE_VCN:
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+			for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+				ret = (pp_funcs->set_powergating_by_smu(
+					(adev)->powerplay.pp_handle, block_type, gate, i));
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 2cd6cb991f29..af7da780b58b 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3287,7 +3287,9 @@ static int kv_dpm_read_sensor(void *handle, int idx,
 }
 
 static int kv_set_powergating_by_smu(void *handle,
-				uint32_t block_type, bool gate)
+				uint32_t block_type,
+				bool gate,
+				int inst)
 {
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index f193c77cc141..de5ee1c5503f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1241,7 +1241,9 @@ static void pp_dpm_powergate_sdma(void *handle, bool gate)
 }
 
 static int pp_set_powergating_by_smu(void *handle,
-				uint32_t block_type, bool gate)
+				uint32_t block_type,
+				bool gate,
+				int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 639bc6d97b27..115931d1c461 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -353,10 +353,10 @@ static int smu_set_mall_enable(struct smu_context *smu)
  */
 static int smu_dpm_set_power_gate(void *handle,
 				  uint32_t block_type,
-				  bool gate)
+				  bool gate,
+				  int inst)
 {
 	struct smu_context *smu = handle;
-	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
@@ -373,12 +373,10 @@ static int smu_dpm_set_power_gate(void *handle,
 	 */
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCN:
-		for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			ret = smu_dpm_set_vcn_enable(smu, !gate, i);
-			if (ret)
-				dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
-					gate ? "gate" : "ungate", i);
-		}
+		ret = smu_dpm_set_vcn_enable(smu, !gate, inst);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
+				gate ? "gate" : "ungate", inst);
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
-- 
2.34.1

