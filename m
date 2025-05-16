Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5B3C3ABDD
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 09:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E4B10E9FA;
	Fri, 16 May 2025 09:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IeicTHll";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1035C10E9FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 09:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dkzo54O+y8SNVXbjrERfqOBVrG0yVbqMGYGGFVSA9gxNaUl/QBRYuuxakRSe94Q7//43CEmc+8QVi87fxw4CxiOPVV1lL97Qg4kWwndQyEPQOw7fuZ+3w6Mnj6JVVki/0dZoYs0Fz/Ldlha77KwIDXLFJTN8yTRJEyF3tT4USMe6TKZYQ717sowW8k91hweJC7xbzyp/9UAOiD1BjsXx54WI2NGm/rMDx7afyZ0XhwR6+j4XTsT8Bl9xGdVD9VCWKKG5bV43Qr8bWedmggszeJvhSw/JAQ9Z+U1dNkDHCQXSr6S5v7v9T8P5TAqsr4JVILnrif9BiMeVi7iCYM5LVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0vvxDiYj2r+MjkO9cUsKz138/M35gHlxWn2HFtj5rs=;
 b=mQkmvvM9n8Q9n6qjHHnw/Y5sgRk5HuC5f0pdnukjJRdmzwYRP/Fr3RjegwuRHK9Mkce7Pxl+kpn1uSk3tlOu2iz9hQS3pDwHFs1TRxMr2UkmOgcCym8XjKeYsMIgxuMCwVoWBREWkzGFLm97ZCzJrC3bdHyDPbi5Jg2IZYmiPIep045kvCmjZC/IlimRv3skT/86nXgw9bUEg4dawNAeN/Je8pPkUzUAqmHljVINEytHYfni59MTjMQXrLBRGhYrf8f34sx5bpXujsCEsSx+cX2Uatn8MVlWrJz9RoXwV/YzoFUvuWAqqx6XVIg3eprQ8t8aOiEBDAcTlR29Hyp1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0vvxDiYj2r+MjkO9cUsKz138/M35gHlxWn2HFtj5rs=;
 b=IeicTHllO0aZK1OeooZ9LAxdcvAeG0PCxbX8/hr3hOWDnweDbyCsaanPsY7J8YSfo351M7cumsqcAA3uPgv0INqlSgs5ZiJg9HUKTmwsF+Mt+IKKkA4HEW8su+Qy3CkOKZisCKMzS8bHeU503DffpHA9JfxUWadRMuBzh6C7+7E=
Received: from CH2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:59::25)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 09:19:15 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::81) by CH2PR03CA0015.outlook.office365.com
 (2603:10b6:610:59::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.32 via Frontend Transport; Fri,
 16 May 2025 09:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 09:19:15 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 04:19:13 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, Asad Kamal <asad.kamal@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: Fetch partition metrics on SMUv13.0.6
Date: Fri, 16 May 2025 14:48:51 +0530
Message-ID: <20250516091852.447786-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250516091852.447786-1-lijo.lazar@amd.com>
References: <20250516091852.447786-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: acc2e76d-8e66-4cd2-3394-08dd945aba6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aq1gR6Oy+ebmXi8mp/5O9YAAHRsECd5jDB/7/Qxmj6yopOLJiPh3ymSQ22LJ?=
 =?us-ascii?Q?lgiau/EE1V7im7whaQi/oR7N0Trf6bFMWh4AAzBifcAJiU+ZWRMx6dV1L36e?=
 =?us-ascii?Q?O3dHw1MPtGVKubM1ULgnKQvilRmHsKgjmOX37kCJ0Yuwzfnci4y4h4qUJuoY?=
 =?us-ascii?Q?n/Bdhs2dBouqe6/gh+pSmaiGTptR6EBz5BJ5L6Z3FDTOJIgWgudhgC/RbOuA?=
 =?us-ascii?Q?msnSnTJC+0vIj42rOfTv7bQDkysNzW6UduKnDiWbYhGglBlpdHc5RnvrEyi+?=
 =?us-ascii?Q?GXOUWmMR/wXCgtqZnRXiq4HRbR6EObwPNWv2yLojB72ADyTlIf7oJ0SxqvTj?=
 =?us-ascii?Q?6yxXtXE6Go+7M77hFH2fDX17nUwy2upeN9H+iD9UKhyaoG6R4ZvkengZUYuk?=
 =?us-ascii?Q?tfDVeaXQNg8KQLcMHZttDLNc4MJAas3hGqnpxjfVkvln4IYjxe6SSOjIV1xk?=
 =?us-ascii?Q?VyNBXHPEUIu6fNDFgqFzEBiOATRkUForVt/WrTVbnHs156U8IrS5feo3qCdQ?=
 =?us-ascii?Q?05+z1ukFcSEcPwJDh/r5ptVXJv9+LQ+UtFlCWOu+6dSrtPeRd6x8y3+4/AAn?=
 =?us-ascii?Q?9GTQry2PkhHrJUFXdhfj39+74JGvei3O6AVBaXar2LEZZ0fBSaMiZrAMkmoy?=
 =?us-ascii?Q?v9JlFI+3bdo0mXKPDdMhU89aWo5bwkKna4RovNBJrik0Wn6qvTKhqXfLK+xN?=
 =?us-ascii?Q?UG0WF4vqDVUdVe8gJBZ4/Ku214kZCKfzXmN3vQ4XGuaGvEFjxCSMIBMz/VfI?=
 =?us-ascii?Q?UrJ1m3jx8vh6phBISWViKve0EBLMM3nZhlci5WqVvcqQsgDr/59+LAvEoAMP?=
 =?us-ascii?Q?DBmtaQGZit5auUuGoD9wpoZGSf796I4/XNP91MPd+fEMcGvq3SQQ4MfGl2R+?=
 =?us-ascii?Q?d7J5wVGA2TDE2dGfYqre/J9A8jFOK4mIi7iE1Rz+7yzpWBS3ZkTPhMOcYZsx?=
 =?us-ascii?Q?+Iv+LKcKZ1OUKj9E3iOiVStfFh3QtcH2usIaJUSuIWe2elgSn9ymv5W3wVyN?=
 =?us-ascii?Q?rqP0UA2EnGUxSLgXongMOwa7k47Cqyfycsr4RwxQ1F3xA2hYPPqKhVBcr3EX?=
 =?us-ascii?Q?MijO06L97AL1E5PEEbzCT/FH+3CimNaZnhqN71/pkIg293bo6Bney7+qT9aq?=
 =?us-ascii?Q?fCp+ZE4/5IMRRq7wD/X9yJhpOcHInqbKjps5j5Qs0S69oqjjX8cpn0lCGuzf?=
 =?us-ascii?Q?INE/E3ClIubqRwJU4LPLkR7J5/zjpVisym+eeapqtTK3zPeHBx9ZV4ksfTgK?=
 =?us-ascii?Q?WkAxrOWaNV72bwF9IDzTXSqdqC/j7HZrhMXTMXCZLkrd7uHjAa8TYX3FfxPP?=
 =?us-ascii?Q?QlMn4b3bMNn/N1XxFhf1OHz94tMYkMP80q7pSss/8I6U8oe5PUrn6Vd7zSr/?=
 =?us-ascii?Q?nQr2+Vxg48XrCHgaQgWqGTgcV9lNY3TOjsa+rArNYJZ7W53KuARKBgosh/JB?=
 =?us-ascii?Q?CuieheG2BoN7qoaXqGSU1DZmLoCjSFPqdBxTPVqpX7zlSSWgiq8GxD1oFsLb?=
 =?us-ascii?Q?QKEyhSI5DkleBAt3tD5b2q5lFa7hl9aXN+ss?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:19:15.1622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acc2e76d-8e66-4cd2-3394-08dd945aba6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

Add support to fetch compute partition related metrics in SMUv13.0.6
SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 3e0820d1364f..b0997dd8e40b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2559,6 +2559,117 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 	return pcie_gen_to_speed(speed_level + 1);
 }
 
+static ssize_t smu_v13_0_6_get_xcp_metrics(struct smu_context *smu, int xcp_id,
+					   void *table)
+{
+	const u8 num_jpeg_rings = AMDGPU_MAX_JPEG_RINGS_4_0_3;
+	int version = smu_v13_0_6_get_metrics_version(smu);
+	struct amdgpu_partition_metrics_v1_0 *xcp_metrics;
+	struct amdgpu_device *adev = smu->adev;
+	int ret, inst, i, j, k, idx;
+	MetricsTableV0_t *metrics_v0;
+	MetricsTableV1_t *metrics_v1;
+	MetricsTableV2_t *metrics_v2;
+	struct amdgpu_xcp *xcp;
+	u32 inst_mask;
+	bool per_inst;
+
+	if (!table)
+		return sizeof(*xcp_metrics);
+
+	for_each_xcp(adev->xcp_mgr, xcp, i) {
+		if (xcp->id == xcp_id)
+			break;
+	}
+	if (i == adev->xcp_mgr->num_xcps)
+		return -EINVAL;
+
+	xcp_metrics = (struct amdgpu_partition_metrics_v1_0 *)table;
+	smu_cmn_init_partition_metrics(xcp_metrics, 1, 0);
+
+	metrics_v0 = kzalloc(METRICS_TABLE_SIZE, GFP_KERNEL);
+	if (!metrics_v0)
+		return -ENOMEM;
+
+	ret = smu_v13_0_6_get_metrics_table(smu, metrics_v0, false);
+	if (ret) {
+		kfree(metrics_v0);
+		return ret;
+	}
+	metrics_v1 = (MetricsTableV1_t *)metrics_v0;
+	metrics_v2 = (MetricsTableV2_t *)metrics_v0;
+
+	per_inst = smu_v13_0_6_cap_supported(smu, SMU_CAP(PER_INST_METRICS));
+
+	amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+	idx = 0;
+	for_each_inst(k, inst_mask) {
+		/* Both JPEG and VCN has same instances */
+		inst = GET_INST(VCN, k);
+
+		for (j = 0; j < num_jpeg_rings; ++j) {
+			xcp_metrics->jpeg_busy[(idx * num_jpeg_rings) + j] =
+				SMUQ10_ROUND(GET_METRIC_FIELD(
+					JpegBusy,
+					version)[(inst * num_jpeg_rings) + j]);
+		}
+		xcp_metrics->vcn_busy[idx] =
+			SMUQ10_ROUND(GET_METRIC_FIELD(VcnBusy, version)[inst]);
+
+		xcp_metrics->current_vclk0[idx] = SMUQ10_ROUND(
+			GET_METRIC_FIELD(VclkFrequency, version)[inst]);
+		xcp_metrics->current_dclk0[idx] = SMUQ10_ROUND(
+			GET_METRIC_FIELD(DclkFrequency, version)[inst]);
+		xcp_metrics->current_socclk[idx] = SMUQ10_ROUND(
+			GET_METRIC_FIELD(SocclkFrequency, version)[inst]);
+
+		idx++;
+	}
+
+	xcp_metrics->current_uclk =
+		SMUQ10_ROUND(GET_METRIC_FIELD(UclkFrequency, version));
+
+	if (per_inst) {
+		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
+		idx = 0;
+		for_each_inst(k, inst_mask) {
+			inst = GET_INST(GC, k);
+			xcp_metrics->current_gfxclk[idx] =
+				SMUQ10_ROUND(GET_METRIC_FIELD(GfxclkFrequency,
+							      version)[inst]);
+
+			xcp_metrics->gfx_busy_inst[idx] = SMUQ10_ROUND(
+				GET_GPU_METRIC_FIELD(GfxBusy, version)[inst]);
+			xcp_metrics->gfx_busy_acc[idx] = SMUQ10_ROUND(
+				GET_GPU_METRIC_FIELD(GfxBusyAcc,
+						     version)[inst]);
+			if (smu_v13_0_6_cap_supported(
+				    smu, SMU_CAP(HST_LIMIT_METRICS))) {
+				xcp_metrics->gfx_below_host_limit_ppt_acc
+					[idx] = SMUQ10_ROUND(
+					metrics_v0->GfxclkBelowHostLimitPptAcc
+						[inst]);
+				xcp_metrics->gfx_below_host_limit_thm_acc
+					[idx] = SMUQ10_ROUND(
+					metrics_v0->GfxclkBelowHostLimitThmAcc
+						[inst]);
+				xcp_metrics->gfx_low_utilization_acc
+					[idx] = SMUQ10_ROUND(
+					metrics_v0
+						->GfxclkLowUtilizationAcc[inst]);
+				xcp_metrics->gfx_below_host_limit_total_acc
+					[idx] = SMUQ10_ROUND(
+					metrics_v0->GfxclkBelowHostLimitTotalAcc
+						[inst]);
+			}
+			idx++;
+		}
+	}
+	kfree(metrics_v0);
+
+	return sizeof(*xcp_metrics);
+}
+
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -3703,6 +3814,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.get_gpu_metrics = smu_v13_0_6_get_gpu_metrics,
 	.get_pm_metrics = smu_v13_0_6_get_pm_metrics,
+	.get_xcp_metrics = smu_v13_0_6_get_xcp_metrics,
 	.get_thermal_temperature_range = smu_v13_0_6_get_thermal_temperature_range,
 	.mode1_reset_is_support = smu_v13_0_6_is_mode1_reset_supported,
 	.link_reset_is_support = smu_v13_0_6_is_link_reset_supported,
-- 
2.25.1

