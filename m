Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E111CF8840
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37D4A10EA8F;
	Fri,  4 Oct 2024 18:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rfv0fEpp";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33D4710EA87
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZkmvFRqU1wtdvid4HRjLvh8EfqBgCnf6cz+Sgb2FSO8pdcez3B/AOHC8vTmKRQIIPVixESfRwmAqpt4ILcxRz1nRTMZsYJDjDuaTAi8AQIolpoOUG6uaI2Ln0mSPFb8UA+3FzlqCzW289fBdSZ/hqHYA8xpFC0T5lcg3Wxl5mBFQTphjm4f9yCugxY2yltCEWMiha4dORX2kD2xYhn/xVZqQkof1Xwr7uIEXeEA3eLxs+8imeE8NFwBDS04DSCwHDRe/dBzL3M+DPT/6Vn2jPabXNLPHlOT715H4tLZ5vaMu6CTF6TDtGqtokesmyBXWboeXHZ2yYe7F1mQtBPm9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVnj4bYY9mqUYYAND3BmFIPRCoYq4i4WKow7Qn8jOc0=;
 b=MsFs1bUzzfZRtMMu8AyCuR4g9g4+pEButj4frWKF4TmGtWLVL9OT5kVl/uDAr5DwqBCxDOou4B/mrRUMmOq75Z0XB9WtkOlE5uo6q4Sp1h+I6bwjAdvBOS34jDEYKoHH9GREuoGw/ZTsLCX6zD2Kb2BST1uPc1R4RtD9cmCpjluE4n4fZDJxS2Xy1l3RR+uXAPaMpEZLnKI6NMlUgkFQHPK5dbxvYgpA/BK8/wP4Zlb6OZNXvBBbD+tdtWI9p3ajP3g7wVIL6UNX8cUrLVLkbi20QKAzcIPKM7vLQudjTdXuXflhnnaiZRScqFjz4ZnYNxoI7gOUKyBNz/9Dpk3UrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVnj4bYY9mqUYYAND3BmFIPRCoYq4i4WKow7Qn8jOc0=;
 b=rfv0fEppCZ94JYfI3HADpXpPWWGW9aGWklBh4edE2MdfJgEi/4nFo80FffMfYFXxT9HPUtM1e/7IKZFGLHJtiW/K8H2bUVtxP9rbKp31i257fioS0d7EbeVgF+TpAx+fJMR+ZHhOheq1lP3Bq9M+Ia9WAS/58XzJxaPjh7S/IhU=
Received: from MN0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::6)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 18:45:04 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::48) by MN0P220CA0014.outlook.office365.com
 (2603:10b6:208:52e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:04 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:45:01 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 04/18] drm/amd/pm: add inst to set_powergating_by_smu
Date: Fri, 4 Oct 2024 14:44:30 -0400
Message-ID: <20241004184444.435356-5-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e549ae7-4f0b-42d1-baf0-08dce4a4a92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7DTFLgalyczfnZa+tVYsoRPSIRfTsD7CmcS4xgykspsm/SDQCmWzeUHop354?=
 =?us-ascii?Q?ypusKzrh8f8Z8K0pC5aLKJrKLIkYb4iRPaVV2bo6r9z4N92+smJW3mXy2Q+M?=
 =?us-ascii?Q?/9Itc149d6a9MbSkq05AR2rzh6lu2x3cn5jrxFw2t/QWODSNi3/akE6RXrPo?=
 =?us-ascii?Q?+4KPAmp90M9yyIxuXpyVmui8zfB1bZy/bIkCi5u6S944ofDToRXNjahd6Qqk?=
 =?us-ascii?Q?RKVMHSids+9R2L0lDnbbXQZN4RO+We3nRyRCAdfKt2tyKympWyM+8J0mx7Rx?=
 =?us-ascii?Q?N4NvH0sFW5tP4jp56Vn5CMXbdf9qVjQJa1xiDTof0prOlYKNllijOAP6w+sP?=
 =?us-ascii?Q?t/z+TOWwGia8BNcr6EHjdatzmBKwa/JHa8TrnfdL38AtCZ4Yu3U7wt3ZhAnt?=
 =?us-ascii?Q?W0gwP7vGkXU44SkHoABbG6wdrUzRINa6h7JzBINYQwmyEISTYr+kMkY1Uoix?=
 =?us-ascii?Q?UtVAGylUlINtnZWG9fzDszONszLnUjmFLOdHR1DUuf8AhFaMnYc4g4VlN0e/?=
 =?us-ascii?Q?noMxOwylyqo6OIhdV5n+7exQOEAkr7+blxnmTEbuE8/87GHbDsJtWs1gUq4o?=
 =?us-ascii?Q?2doBNMEIJ8qxkQyO0anmW/JKL3Khh4zkdQJfO2WxqJDtgc00CFfkq+lHLDKP?=
 =?us-ascii?Q?fS3LN8mt2E0im6i4LpAJ9b7yk9nO8D5QKmsF39r0ZOgfiC/GObbWJormc/5f?=
 =?us-ascii?Q?AvZkoq2uaelNj6FZBhT5yg+uRxPJPCbANhEb2b+uJm9enVT5hkeuob4goF4I?=
 =?us-ascii?Q?JLIUuAtqb7n304pvqQAW/wMI32y8d8BXUsBsXqBCFSA5b2ef7YSDVByBh6zU?=
 =?us-ascii?Q?PnAarczdIuUqGrJViKkJpEgBVAqeWSi8ef2hF3EdhDr5lWqVp6NMOP1akEV/?=
 =?us-ascii?Q?qgMykXgiVQcmqQe05GuQROlEgWq0uYWdGIIsolhd3n3uErOU5hY7RnsEu7iU?=
 =?us-ascii?Q?tZS8YEl8dj6bH5QRB9MC81AC+foKrmIEMh/MZJL9w5hVg3paWoPVEYoHgvL4?=
 =?us-ascii?Q?gb0D5gwCNPufBXS6XJJoCbINWKw++01/CXnGA/gX6dxczWB2NRvrZ2Dxp8c0?=
 =?us-ascii?Q?fmZ2CN4JOfhlDFs2HXXm1rtqD8y5HMH4d8ieAzwDkoc1rPfz9l+SNxPlUNg6?=
 =?us-ascii?Q?R43uj9FWNKz/4y3pmAq2W4lB8HcCBihxKmIhJhqEXdMbckhcfjXoS3sQhYNv?=
 =?us-ascii?Q?Rz356U4L1AVyN9GGsY5kd6bsd2I0dnfJ7dbulp1SwbsG2wNgvX+9aHkAlAku?=
 =?us-ascii?Q?e8E6NVSqjmvrSrD8w+ocq5Q/0lAA+Mcbt1OBOpr0rmBtZvbcHLbGxQNNB0O9?=
 =?us-ascii?Q?R6xEvVMU0gNwOW3/1rR8fRe9r4/ttuJYQjPGdHAt5rUWnpGnWHt4RcsrxYPM?=
 =?us-ascii?Q?Nt/nu7A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:04.2921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e549ae7-4f0b-42d1-baf0-08dce4a4a92f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817
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
index 786241fa8d2c..0da84e390d0d 100644
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
-				dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
-					gate ? "gate" : "ungate");
-		}
+		ret = smu_dpm_set_vcn_enable(smu, !gate, inst);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s VCN!\n",
+				gate ? "gate" : "ungate");
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
-- 
2.34.1

