Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DFEC2D0CD
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 13:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25CD910E153;
	Mon, 19 May 2025 13:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="107im6Dl";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0522D10E153
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 13:20:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAtMNWos3B0EqUrL+nneLV2K6kG1iGgYAlEDhI+p84DQ/CKbQXuXnvbVMW4tmroDZm1Qjo+9PfwN+7n9LliMl8A4rcg5poTtkLavKqSatBeYVd8b8Vkq6sbJUpP+JIbJhB2LYpov+aaM2jNCKpivbt1BJr2rQ9TadKAdSjszFrbLFpGBvnQLwL2CBIjIAYcqpq5mAYAurFtaRagQsAJC2yySdPO7rE9dDgT9DfwUAcFS3TcSTsCDmlZN1M/a92kjmbDpywCKyHRLiEG9zIELVLMvhQyhe3ho7ANFwF0fpwTOOozs86bbv52JJaTMERs1OYmGKchbZziumu7NfiAYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASr4KvdiD60WLaUG0oloj/Ni0eKdsthS4oAXaUz5mos=;
 b=U2buPneCb3E3UVDiTAgPItJoVgk3KW9xV97t2CQVVvY9mAjRKDzzHn6+M31c/oxvbfM2E1lVI1IjtwrkcO5bo20rxXyrDosuY0T0h9gFjoCuR2NO8EIoU8b7MGkSU/6IKlgiua+dZv020phf27+YsdHMLU4FsW2PUNZ7KAUG+17Ru+pvqvBauHBaHoPjhroOzJZZ4MMA3G7d+DV5mNTSGUBfGhyfuySN0gAG1z/W/NiuTk0qFjNsj6vZEtWp0QEvvOs8ojwxNVLIxGY0WC/oTEk4xYzEl3VNhXfGg5hI0nrQZIuyT04L8eUGMx2/qRVlzqgvOOKwrIs8RO3QPt0EiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASr4KvdiD60WLaUG0oloj/Ni0eKdsthS4oAXaUz5mos=;
 b=107im6DlS4jLsmh6U2F7vadphl+KMsSM844ngBqL9T4WxNFb+xyOnkI/PAQjYNVugHG/vlemd7L7wA8XYlhaezqFRlCJSW+83JHUkPMYdBv8gZo5XvE2Gveblh58Mi7nkJkqMXSVn7iori6lYozuGlwLKcruHMtvWj1KOkNv5gA=
Received: from MW2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:907:1::18)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Mon, 19 May
 2025 13:20:46 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::2c) by MW2PR16CA0041.outlook.office365.com
 (2603:10b6:907:1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Mon,
 19 May 2025 13:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 13:20:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 08:20:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH v2] drm/amd/pm: Use external link order for xgmi data
Date: Mon, 19 May 2025 18:50:27 +0530
Message-ID: <20250519132027.513023-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfa467e-6821-43a3-29d6-08dd96d7f633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UBeOpgzkIfBGLkS7KDonvysJKS4lDe3lLzOTj3ev2do7c2BJd6fXVjeA2cwu?=
 =?us-ascii?Q?OMwMrKWSqRzgRcaRc8iCc/J7qsjGsbC47/IUTMJ+14XMKFJrf11KkJ7rT4vo?=
 =?us-ascii?Q?CuIYMF27k9j3LLuOqZayGlybRPh3EgB746TnxjBoMrGgBx66k6kwPpQn/vbp?=
 =?us-ascii?Q?/l83cPR5k6FYT7C9YGergVH7conmN+OzFNpOd0P3a5dSzxkRaKBdIw/CDo0k?=
 =?us-ascii?Q?g5kAD6rejntfo5oNePoXF4XK0sX8UNizTci7NjdTtd6r9hG2S98cxLhYB3qH?=
 =?us-ascii?Q?ONe4opSWix+/gcko09qwha+uVOZ3JburHIIW1y3Gj2lgh/Q2rvCVRlXdPPDy?=
 =?us-ascii?Q?0ByZiUFy6E0olmyWNoxbpH3oTQrldogSsVqsod+x2K8XiZLsv0PVUkq1joxk?=
 =?us-ascii?Q?zYQoGIIcVcIfuW1xYIhc/xniqkC/1OoBy+WuAy0mxNQJzWCwppQaQoqohGU8?=
 =?us-ascii?Q?zhJQ5zeD593QSOr+gWUCK5KnT+RSMC+9lVqi2A4R/l5cpq6Fit6fRMqap0rY?=
 =?us-ascii?Q?1xrlMAYW6wCOVgDi8a9DtvhcqAYJY3kyuz8j94NVRNkiXKAZiIu6CVSbqPRH?=
 =?us-ascii?Q?tzezuPJD4SqkBXh40tHibnxmSahaT+yqHa/VEdCjKNbzyIM/PBklR1ZZv/wa?=
 =?us-ascii?Q?5fmNQWXplBu7UpmsD2UtEjFMhQWDOALvXRfLglcq2PywggZ+yeOHXDHMe9qo?=
 =?us-ascii?Q?Rla/CIpXQX6hCfTo9eKZEpwPMnvFSVZwl6vKi9zLfYhdVrNEClVSDRDxYDLo?=
 =?us-ascii?Q?eH/fRPirr26Axnzg9BoVyxY6OWczKfRKtk8PLVX1lf2ur6PzRMrWDYXtx/4/?=
 =?us-ascii?Q?BazwERdcRJDkRR3W8dhouXBPWnLcLwjSpqz0TJB+ieSunbiyRECQ0XroXO/W?=
 =?us-ascii?Q?0djcimamZcSYF7gojdrcQ3RnATajHTDQ/HDqsPqYRRfcHNCaDU2j3Mld3FP3?=
 =?us-ascii?Q?73WERtK31CxbJ/1+T+fQpWtGU5bFh0jvwPu7ehrVmPXgAKOC6Nyzo9yXt3Sq?=
 =?us-ascii?Q?9gzZqxfWxL1pGQngv3JoAYs9tqgp1d3RUFxOeV6vTyOXQZB9aAH0D/e8gK8+?=
 =?us-ascii?Q?mtn4746ZwI/6c019rNJbRwa31Ze7rjHOLHxTTnk4cvp65H0eoTDdxyBI+hSN?=
 =?us-ascii?Q?cd4bXi4gPPdlsmiOR6Sy7IygZ7gAqLNPZ/+YOWvyl56AkqolGlcDPkJO7xZA?=
 =?us-ascii?Q?otYUFq6ehvGzmULaHLxITZsS4j1A2acRagqMj11NnOHugCvBR1eSLu8T4yfz?=
 =?us-ascii?Q?/dT4Vq4BcaTWm2ZbRhJ1rR13g76yDsKwGLMygMi3fwLmbnJyNwNsDKVcYbB6?=
 =?us-ascii?Q?neY6jR0CHQ7vmvjo9zsF6O+Ff8d+empyGIX+JQctG1Hm3PPiRnz0q+po0vyx?=
 =?us-ascii?Q?9Xn7o8EyxTHK4TsV0MhgHbGjuigr4dYLqGXav9xL7RlUkz7tPRJqBh4m93LU?=
 =?us-ascii?Q?vYyz28ySrYHRNPJlv9FFzoq26v4iBXmHz16heaDaipnxsNYMExzEqPaA7Pv7?=
 =?us-ascii?Q?OJDP2E9pRSIt/tAyqitVfMNaaZaQ2eh2je6C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:20:44.7915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfa467e-6821-43a3-29d6-08dd96d7f633
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611
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

xgmi_port_num interface reports external link number for port number. To
be consistent, use the external link number for reporting other XGMI
link data also.

v2: For invalid link number return -EINVAL (Kevin)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Acked-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c        | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h        |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c   |  9 ++++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 ++++++++-----
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index f51ef4cf16e0..d9ad37711c3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -294,6 +294,23 @@ static const struct amdgpu_pcs_ras_field xgmi3x16_pcs_ras_fields[] = {
 	 SOC15_REG_FIELD(PCS_XGMI3X16_PCS_ERROR_STATUS, RxCMDPktErr)},
 };
 
+int amdgpu_xgmi_get_ext_link(struct amdgpu_device *adev, int link_num)
+{
+	int link_map_6_4_x[8] = { 0, 3, 1, 2, 7, 6, 4, 5 };
+
+	switch (amdgpu_ip_version(adev, XGMI_HWIP, 0)) {
+	case IP_VERSION(6, 4, 0):
+	case IP_VERSION(6, 4, 1):
+		if (link_num < ARRAY_SIZE(link_map_6_4_x))
+			return link_map_6_4_x[link_num];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
 static u32 xgmi_v6_4_get_link_status(struct amdgpu_device *adev, int global_link_num)
 {
 	const u32 smn_xgmi_6_4_pcs_state_hist1[2] = { 0x11a00070, 0x11b00070 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index 32dabba4062f..f994be985f42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -125,6 +125,7 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_device *adev,
 				   int req_nps_mode);
 int amdgpu_get_xgmi_link_status(struct amdgpu_device *adev,
 				int global_link_num);
+int amdgpu_xgmi_get_ext_link(struct amdgpu_device *adev, int link_num);
 
 void amdgpu_xgmi_early_init(struct amdgpu_device *adev);
 uint32_t amdgpu_xgmi_get_max_bandwidth(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index ac172b21f803..69f92bd35bf2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -472,13 +472,16 @@ ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
 	gpu_metrics->mem_activity_acc = SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
 
 	for (i = 0; i < NUM_XGMI_LINKS; i++) {
-		gpu_metrics->xgmi_read_data_acc[i] =
+		j = amdgpu_xgmi_get_ext_link(adev, i);
+		if (j < 0 || j >= NUM_XGMI_LINKS)
+			continue;
+		gpu_metrics->xgmi_read_data_acc[j] =
 			SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
-		gpu_metrics->xgmi_write_data_acc[i] =
+		gpu_metrics->xgmi_write_data_acc[j] =
 			SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
 		ret = amdgpu_get_xgmi_link_status(adev, i);
 		if (ret >= 0)
-			gpu_metrics->xgmi_link_status[i] = ret;
+			gpu_metrics->xgmi_link_status[j] = ret;
 	}
 
 	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 645c2bff3e5f..179b1b16edd1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2819,13 +2819,16 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 		SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilizationAcc, version));
 
 	for (i = 0; i < NUM_XGMI_LINKS; i++) {
-		gpu_metrics->xgmi_read_data_acc[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiReadDataSizeAcc, version)[i]);
-		gpu_metrics->xgmi_write_data_acc[i] =
-			SMUQ10_ROUND(GET_METRIC_FIELD(XgmiWriteDataSizeAcc, version)[i]);
+		j = amdgpu_xgmi_get_ext_link(adev, i);
+		if (j < 0 || j >= NUM_XGMI_LINKS)
+			continue;
+		gpu_metrics->xgmi_read_data_acc[j] = SMUQ10_ROUND(
+			GET_METRIC_FIELD(XgmiReadDataSizeAcc, version)[i]);
+		gpu_metrics->xgmi_write_data_acc[j] = SMUQ10_ROUND(
+			GET_METRIC_FIELD(XgmiWriteDataSizeAcc, version)[i]);
 		ret = amdgpu_get_xgmi_link_status(adev, i);
 		if (ret >= 0)
-			gpu_metrics->xgmi_link_status[i] = ret;
+			gpu_metrics->xgmi_link_status[j] = ret;
 	}
 
 	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
-- 
2.25.1

