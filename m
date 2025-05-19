Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226E2C3ABD8
	for <amd-gfx@archiver.kernel.org>; Mon, 19 May 2025 11:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1B7910E02D;
	Mon, 19 May 2025 11:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lD1CHCEO";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9F110E02D
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 May 2025 11:02:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWiZHJ3WpXve25UND/b7MtgMNgAexB/YVjBPX+80+4iSr/uGgLQrB2P1HFy83GzEbYxCFLgnZ+/VnDWCN9II4pwldeVGHIP6L3ZFoobuhFb+KX/IIVF14AzmvUfMxgNs4RcKgTaGt8LTPp8ft1hzDXfbp8HVDMQOpcVicUinOxnJf517toZCxz+875XOfP2h/i0lVLYtqi+9fVGTMR8clbKpBhVqeKw9WmflPhAEtZrmhwy58DMbNFmXzGfqVZxqhHBrx6BCOS/RmpM4Cxl+3CBlDtQMWAL1J8Tls4KmwjIFlTWS5vdZIA5ta1bc7YH7VQgyVRgJvOXhSbibe/o5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix/bHXWtl67Mg8BUUgrLWVEgkHWe3r6/2exrVppT+Cc=;
 b=UcPbU4ob5FlxbiZE1KjAWat3rAAoKqjMsudP04WD1jwT8i6La0K14oHun/0ElptVttTYhr9VzO2hPzRQoZ+KUOC/rVJGq5TfeScJZzSnV6fj34jPUXUVG7astmt/JJOYvx0Ld9zCzRCwIhA5qSzIHIdYLRUlGZ6rHE3Dq1FumlpdZDBZLKn8KEmT2nyvJ32E56FwgAlX2VIWfiDwCLLx5oUs7DEZrcIDTYWsItHPs3K/iI5x6sxUbGJsP8d2WEQlCYz7phUQWapbh07Wxpuy0TGiSlbI5iIJrk6rew0ctVmosfk7BklEr3MYodMT+2c3tD2vV4VuGEUTodjW6yjYIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix/bHXWtl67Mg8BUUgrLWVEgkHWe3r6/2exrVppT+Cc=;
 b=lD1CHCEOjYVfGxklIBleg9jt+JLkG75Vl+SWOD3AJJyjolX0skdthcOhxTgynEXiU1MuwM+7zCtkZCKFG7pAQoyS0He0s1PY7PQRtCyp25BzFjhNBJPCgWjeDdg+qpCIuO5ldbjYrQpxko+42KQMmb5aaGZ2h7dBOBS8CT2tL9g=
Received: from MN2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:208:236::28)
 by SA3PR12MB7879.namprd12.prod.outlook.com (2603:10b6:806:306::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 11:02:10 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::a9) by MN2PR05CA0059.outlook.office365.com
 (2603:10b6:208:236::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.17 via Frontend Transport; Mon,
 19 May 2025 11:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Mon, 19 May 2025 11:02:10 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 06:02:07 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Use external link order for xgmi data
Date: Mon, 19 May 2025 16:31:51 +0530
Message-ID: <20250519110151.507729-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SA3PR12MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf6b7db-2776-4888-7e59-08dd96c49a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o+KTJB8zx2qwz9Z36VfCQiU+tcBJ6Vzcou/yfOmnPkvnMTRKOPkQrvjRDlpL?=
 =?us-ascii?Q?47aZfwb+IE5LQmGevrOAIJw+kiBGmuXwpxsL79EuNxiTvmqkbg9YwuF72sFO?=
 =?us-ascii?Q?+zUBrdwmlaKaSaC9yPHh9ndNOKMhwJSHTq3qNLhbSegs4xgzFT3cVUGcHB/n?=
 =?us-ascii?Q?HLZGu5zu9+7ydSXKooEvy16g8Dz+qPQ02TDYPzGvTHL1bHTWtQffnu87kevk?=
 =?us-ascii?Q?myFVF8Brp++gk7hKUHNLgsqnQMIz8Db3jO5fHvI/Jo9YuhZIoh/Thps4WYwp?=
 =?us-ascii?Q?9NxBavHGj997r2qMT4dj5VYsZ399XLfJSaJ2UxBXVC4TmQeNiFXJd6IQfiOK?=
 =?us-ascii?Q?w4VSTJem/8Fu7/nEunY3/tRWrX20GHEiPdR/s1+v3ywC0EcOyCumRPamrZ1K?=
 =?us-ascii?Q?GChuTlXE99wU1Nzs3ABx9FdaL0Y1wT+quS6fWg6psw1J6dlOeEKhwoQslpy7?=
 =?us-ascii?Q?s+uvoAnOHbCTiwNcJbG/OJNHohUHpTm7maSLqbkJUNm09ZZogcVePLDLkQ2W?=
 =?us-ascii?Q?qBDsnNOsBstrTdnbn+3NJVYPBYNTv0o7I3/xMcEQT/ZkndfZ6RYyU4JmwjU8?=
 =?us-ascii?Q?SuBCvLeuBtZc3KcD4BHXlkP0HCLnyxFoQvyIu8EFjZqWxB+jgaOCDub48Vib?=
 =?us-ascii?Q?c49zpSU220mmgk5yHr2eZjAszXdBVMpY6o2I/QnKCc8LlMHl6PoqgBdu471I?=
 =?us-ascii?Q?NhyjZd4ONFswMGDwxbHjS7I0aCHYjwM4xMA7NO/octs5GNEaOVNOuy3K39yq?=
 =?us-ascii?Q?SEG8AOsTBAXwMSlGhSf3EoI/FbXmH686AOxjSOIgdCmqp0DNHLR4Psog9sMZ?=
 =?us-ascii?Q?p0rZNHByKiInq0oyxUjrPJN7AK0YkHKHojC2uu9adn7hftCoFdc2q5KBMxke?=
 =?us-ascii?Q?HNCp2wqX+UPnzBudlTgsYxfGIp5DPJFAImi+OIHeIw6OSU7EFU1v9owY/uem?=
 =?us-ascii?Q?Oc+sEANWoToVNdBpWqJZuNlqiRaE3oVf6Iz+SDZlhpU4AvZyUA/ggO6twQd1?=
 =?us-ascii?Q?usfXUhrlIRUiW0RFsG8777RP245SwuSNIYUrPizljmZNISzbGXgm0/gVkLax?=
 =?us-ascii?Q?5NUxs6oyHxnRhMFg9q5ZdMb2AML4YvMdSR+6be/u/rqkQVR3nvOP9YuBP7Xp?=
 =?us-ascii?Q?xFegEEcgx8d0pQZHe7NhAgjRcwdAmFaW5pHRrC2t3aAfattaxVFaZ701JC3U?=
 =?us-ascii?Q?j+vCXuK1pMjhRnEOaBHVZSDKkSJ9RMF7cfcbKMlLhoC+t7CdRgEQc30mppCE?=
 =?us-ascii?Q?HP9LE70v7ZdFvJn5DVJmJMH6TxBzPDSFqUyx8BFTj7aeD/zn0rYrr5xbs/gQ?=
 =?us-ascii?Q?uJCXJdmeRNWa9f71Wkjrwsn5LeOuRix62Eynrtpok26JVsfoMXRYShIae/Xx?=
 =?us-ascii?Q?2QTxNMBwHYCk++dd+azDd79Ox8zzbCsjRKBCYMiHzx2FCY9i8Y+oS5FliS59?=
 =?us-ascii?Q?KLmB2eZxahObfu1D8YaDWaXNo8x/gEMjjCU/fvRGJEqntEGdmmwLJuIIcGXg?=
 =?us-ascii?Q?RLLi0ixYWryLZxszybjJMwHVvDHIKNFhCaeX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 11:02:10.0537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf6b7db-2776-4888-7e59-08dd96c49a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7879
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

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c        | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h        |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c   |  9 ++++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 13 ++++++++-----
 4 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index f51ef4cf16e0..b3006ca7fd28 100644
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
+		return -1;
+	}
+
+	return -1;
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

