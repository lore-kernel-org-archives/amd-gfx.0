Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37C3C7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 22:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2218910E524;
	Wed, 18 Jun 2025 22:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q8vs456W";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 629EC10E524
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 22:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIEarNHj4cu+XrU0zGKL7nh0iXzPB8EisKuypgYw4w0dq4VifG4KA1JKUBFc6P+D8PXIfI+gOAC5WcuBAWGlA1sATdU+QoMUOYEVaUAN/VDkY4SGhNIEx29egIrG+GjmHrK4cy1PDT1Pz46TLQqqXZ3qZJmVpAfY6dAlSZLlUIVuqsKz1oK5T9pTb2vcywIpbkDQ4SSeLiXsKJCnkxYD9OnFa5coizD4xYjcJ+9wa/MlQPW4hS41VwbELf2BrzQfDABpdMNzB7nkDXcqTYN88RgZB7dg/8Oa4tOH+fs0gf9BpNYEEXbNW/rMsWwOfvPSKBGi4xe1rNNV3ITZTKzAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ5DEDzd5QUkA9JGbJ5cES5uwh0GE3w5A/9d8A7AYww=;
 b=EyC2AKD/hvO1EIJHmFi6HHyXI6I9q9Hzt3O4ijrVxrRDKlH9beajKg/cIP/1L2sJKmQskb1q15c6Ur0um+KVodtqt7B14IScFuTYZcJiS/fIZ7JpAZKVh1s5mzEjBFUGjYpjA0DudMvi/hatT1VHhtd7Y/UfgyBqaz2a+gD0FqVUob2ioT/CS6nzbbqBQeM2iK8rALjlA5fNaHZyuVq3a7SKWd5z/cfnDl1ue+BHX/EnF6c9qqWEjxG/JuyQdVFeoQc36S3RrSDvfH1e4XBf5idNf716cPrzRM+deGoQaKZHjsoStFqWSCRn6sIh+5mQ2RFGUVnUG6QXWLrwsO2lhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ5DEDzd5QUkA9JGbJ5cES5uwh0GE3w5A/9d8A7AYww=;
 b=q8vs456W7L1BeiP8wt53W+f/wZON2469E8Zj4TASCNf0sR9QqRgQg/EU4TcyhsqhAVnKYo0OYKqmMRYHVq+KhNcA9K2ueAptxCDvNIv2gKg5DzNyp1KwMPCpaOeclTZ88W7wAe4YeRAQ22iYjbTUUlfEmtbkJWvuPLu5DTr8MDw=
Received: from SA1P222CA0114.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::21)
 by SN7PR12MB7299.namprd12.prod.outlook.com (2603:10b6:806:2af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 22:19:46 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::3f) by SA1P222CA0114.outlook.office365.com
 (2603:10b6:806:3c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Wed,
 18 Jun 2025 22:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 22:19:46 +0000
Received: from maple-stxh-linux-10.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 18 Jun 2025 17:19:45 -0500
From: Pratap Nirujogi <pratap.nirujogi@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <mlimonci@amd.com>, <lijo.lazar@amd.com>, 
 <xiaojian.du@amd.com>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <benjamin.chan@amd.com>, <bin.du@amd.com>, <gjorgji.rosikopulos@amd.com>, 
 <king.li@amd.com>, <dantony@amd.com>, <Phil.Jawich@amd.com>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: Add support to set ISP Power
Date: Wed, 18 Jun 2025 18:17:22 -0400
Message-ID: <20250618221923.3944751-2-pratap.nirujogi@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
References: <20250618221923.3944751-1-pratap.nirujogi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|SN7PR12MB7299:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b72a69-5ae6-466c-ba52-08ddaeb63bdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bIKyiC8CQ6V2bTFveGlynuCRZIhxjP6CuBq12A/VwUjQFgMen7rKpdFxhc+U?=
 =?us-ascii?Q?fwmA37qURD2E0Pu/YMP3dupqN9a5geERo/rt9Tttx1O5yWMxO8CuJ8k+3k6+?=
 =?us-ascii?Q?g2HX7wlGzL4k0u+7xgrJl3bHCw6eip7aha7tCQg7LFiFbiYFM2tvIfF8BoNa?=
 =?us-ascii?Q?uR9o/XSAsoz8vtBJnELtJYDB6e1ieKJn0Zpu5g/GRBcPkEoiWvj7ipC5LZOL?=
 =?us-ascii?Q?mRT4xoFqjx4Wi4CxrvFRbZ8CBNRDYp+4ghTnlO0Ng7TR07BAvsso6gQiz/0J?=
 =?us-ascii?Q?pDCMZ5s9K4IkCtl8HPtZko0p+zebgzMUaG+b+XQtFylyvmrEdygvC7Yccrp1?=
 =?us-ascii?Q?pjpwNAq9sHX2ovpH1ERxEWh/+G+GYcAZLT1BGUNTMB7XG/oi5CIkHTvmDmqH?=
 =?us-ascii?Q?pRXDqeSpG4mKp6gw4xg1NAQUOVdKV6tnAfJZlqpYeVu2WigyFngLm0ql+bD5?=
 =?us-ascii?Q?/Gr4Pkt48xfyG+ZNlSNupbk3fBQQrhdg3xLRp+c5VW/bz5UJpoGIGr+L6WlU?=
 =?us-ascii?Q?z1+/zdVhB65GC1fhpu0gcVlXl70j5tFvaqSs0SSBROYHFjvnc/favFriW3mE?=
 =?us-ascii?Q?a0rTcbJH1iljR2o4bN1GbfPjf/Kvt0NboTo8hjj2anio3tZW6hgpBclvuDQL?=
 =?us-ascii?Q?t3h8lLOgR3jwy0VWRCEt71PybZtQku5AAPPN5bzevGoYVluUX8Vxe6qA8TaY?=
 =?us-ascii?Q?w6395oBYxiTa+x3M4a+dvec+FRJThZzH6n3Yr9FsQikyOCOJRDEgy3F1iCWC?=
 =?us-ascii?Q?uVqkY00t2A83tlTkO9scaEdJ+81Y93zoIoUql6jZRncqnhayWZVKIpesTktK?=
 =?us-ascii?Q?OP2sNpGRkGBzWE/I8BlQNjQKWy0DbvmkN5tJnHjsJafRQiglQWpJRXTtaVEY?=
 =?us-ascii?Q?btO0yDbxEoRSxVPYcRZFH3tb/ZtdyhLl1XJ0CJDv0SmizHrtx7MH56QI9Ayh?=
 =?us-ascii?Q?gsh2eSj3Fi2DhwK1toQ/zrnkMVS0lE83AX3s7ODn8NeuKbTUI6563b6RQBMj?=
 =?us-ascii?Q?AhNAu+0SWDxRorxUsrHbLKf60AwBH1NOPCaUV24W6RrADl9EpBNKMYU/fDr/?=
 =?us-ascii?Q?qFxdVTCETyK7i6UeEnkh8Wl41uSbIzXw7dpqYdEXVMZ2++TIbfDmLDIJ9Bn+?=
 =?us-ascii?Q?dwZksHWMlvjmbr5vHP4N/WIVMul8t0MVEXTfNVrHc8f0exlVsWEG7hZ1JeFl?=
 =?us-ascii?Q?myLZQLvT33z8Pyc1zb+l0nqD/MqtBzanuGa+LBSKj5MVmc/8pAjdpvCsYtoB?=
 =?us-ascii?Q?2WTWFZgtFYKdW39k6obd9QfhhLM1DPzmKc492CRhpC9FZ8Xwxc8H4Ma1exqo?=
 =?us-ascii?Q?x9AQPRimx/sSLJVppckX29YAp+fxYk7ILhxH+kVWaxFhM+0lM3XILhDcZsB3?=
 =?us-ascii?Q?ZYLOnVYYw/2bQwn9VHGicSV0yQihh7nsVJa6itfi/Z9fAnq+HrMN8Z+dYoW2?=
 =?us-ascii?Q?N7EMfXAqeFW7npmL7DxynNf1kkZ0of1UKJvy8SBX3xyQkuhitDBg2Um3YWIM?=
 =?us-ascii?Q?YwHnrQzm6WfOHozDatRVsGVJ1BNJaRihSZLY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 22:19:46.7397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b72a69-5ae6-466c-ba52-08ddaeb63bdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7299
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

Add support to set ISP power for SMU v14.0.0. ISP driver
uses amdgpu_dpm_set_powergating_by_smu() API to
enable / disable power via SMU interface than communicating
with PMFW directly.

Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 27 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++++
 .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     |  1 +
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  |  9 +++++++
 5 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 5c1cbdc122d2..95f1fff442cb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -98,6 +98,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
 	case AMD_IP_BLOCK_TYPE_GMC:
 	case AMD_IP_BLOCK_TYPE_ACP:
 	case AMD_IP_BLOCK_TYPE_VPE:
+	case AMD_IP_BLOCK_TYPE_ISP:
 		if (pp_funcs && pp_funcs->set_powergating_by_smu)
 			ret = (pp_funcs->set_powergating_by_smu(
 				(adev)->powerplay.pp_handle, block_type, gate, 0));
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 0c9232009da9..97572fe26ddf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -307,6 +307,26 @@ static int smu_dpm_set_vpe_enable(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_dpm_set_isp_enable(struct smu_context *smu,
+				  bool enable)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int ret;
+
+	if (!smu->ppt_funcs->dpm_set_isp_enable)
+		return 0;
+
+	if (atomic_read(&power_gate->isp_gated) ^ enable)
+		return 0;
+
+	ret = smu->ppt_funcs->dpm_set_isp_enable(smu, enable);
+	if (!ret)
+		atomic_set(&power_gate->isp_gated, !enable);
+
+	return ret;
+}
+
 static int smu_dpm_set_umsch_mm_enable(struct smu_context *smu,
 				   bool enable)
 {
@@ -408,6 +428,12 @@ static int smu_dpm_set_power_gate(void *handle,
 			dev_err(smu->adev->dev, "Failed to power %s VPE!\n",
 				gate ? "gate" : "ungate");
 		break;
+	case AMD_IP_BLOCK_TYPE_ISP:
+		ret = smu_dpm_set_isp_enable(smu, !gate);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s ISP!\n",
+				gate ? "gate" : "ungate");
+		break;
 	default:
 		dev_err(smu->adev->dev, "Unsupported block type!\n");
 		return -EINVAL;
@@ -1300,6 +1326,7 @@ static int smu_sw_init(struct amdgpu_ip_block *ip_block)
 		atomic_set(&smu->smu_power.power_gate.vcn_gated[i], 1);
 	atomic_set(&smu->smu_power.power_gate.jpeg_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.vpe_gated, 1);
+	atomic_set(&smu->smu_power.power_gate.isp_gated, 1);
 	atomic_set(&smu->smu_power.power_gate.umsch_mm_gated, 1);
 
 	smu_init_power_profile(smu);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 9aacc7bc1c69..41d4a7f93660 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -402,6 +402,7 @@ struct smu_power_gate {
 	atomic_t vcn_gated[AMDGPU_MAX_VCN_INSTANCES];
 	atomic_t jpeg_gated;
 	atomic_t vpe_gated;
+	atomic_t isp_gated;
 	atomic_t umsch_mm_gated;
 };
 
@@ -1435,6 +1436,12 @@ struct pptable_funcs {
 	 */
 	int (*dpm_set_vpe_enable)(struct smu_context *smu, bool enable);
 
+	/**
+	 * @dpm_set_isp_enable: Enable/disable ISP engine dynamic power
+	 *                       management.
+	 */
+	int (*dpm_set_isp_enable)(struct smu_context *smu, bool enable);
+
 	/**
 	 * @dpm_set_umsch_mm_enable: Enable/disable UMSCH engine dynamic power
 	 *                       management.
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index 1bc30db22f9c..cd44f4254134 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -106,6 +106,7 @@ typedef struct {
 #define NUM_FCLK_DPM_LEVELS       8
 #define NUM_MEM_PSTATE_LEVELS     4
 
+#define  ISP_ALL_TILES_MASK       0x7FF
 
 typedef struct {
   uint32_t UClk;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 84f9b007b59f..fe4735d5ebd4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1533,6 +1533,14 @@ static int smu_v14_0_0_set_vpe_enable(struct smu_context *smu,
 					       0, NULL);
 }
 
+static int smu_v14_0_0_set_isp_enable(struct smu_context *smu,
+				      bool enable)
+{
+	return smu_cmn_send_smc_msg_with_param(smu, enable ?
+				      SMU_MSG_PowerUpIspByTile : SMU_MSG_PowerDownIspByTile,
+				      ISP_ALL_TILES_MASK, NULL);
+}
+
 static int smu_v14_0_0_set_umsch_mm_enable(struct smu_context *smu,
 			      bool enable)
 {
@@ -1669,6 +1677,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.set_fine_grain_gfx_freq_parameters = smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
 	.set_gfx_power_up_by_imu = smu_v14_0_set_gfx_power_up_by_imu,
 	.dpm_set_vpe_enable = smu_v14_0_0_set_vpe_enable,
+	.dpm_set_isp_enable = smu_v14_0_0_set_isp_enable,
 	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
 	.get_dpm_clock_table = smu_v14_0_common_get_dpm_table,
 	.set_mall_enable = smu_v14_0_common_set_mall_enable,
-- 
2.43.0

