Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1F5CF9C71
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 05:57:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD2F710E4CB;
	Tue, 24 Sep 2024 05:57:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cAzuuvVn";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E33310E4CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 05:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLXufL8hLTDNnuYcX9nEB8cB9UfvXWvWvjdCHMfuK+lE82POwfoJN4nbiYvymBdNvJu/45q7ZPFX5KKUK4WY4QJWhDaCESVrpemf93nvNjlgaye50emcu4H57b1ItoizUJsmnK2LLVZNOhVhhUK6hQxr2faPt9b5bcrP78HWQhAYG28MkyI4TLNuFdqQRfc5cQJwGLtSWvDdz6QZwjwF67Y/z/lFQnGoKDjosvMacXl2GIGJSXeXzB2wsMZpCbMzNeT6PxltrC0qzE2NtLscItzZdYahmKBLS2zo4S6FZ+T7x+1Ors5Yrwq7sFHR2LUf5+xvxnIqvATKm1W9zc6PqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxdG6UnSjAA9iwFV041Z2OWM1ksQdgXUmMFiPoSFzKM=;
 b=TcRMvEteXVh8NLY/xFfwv5U/Mc5RpHNoI6zMF8Df1iDVUEoFr+O8IRAxhFcQ5YyRaZATL4B+q0t9RWB1KvoC3/eKwdZWQZiWGkf6bkHu6svJKPDBCLZbwHMmXDQWQrBRpu11cBAdQmOXPuTrnmeiT8x59gOJqV/egNiB+N+X78/G968IQlHVEEB93TZ0jSKrAKAFaxIdxDCfqF4DEwmNM+/VONsBi6HcbzjSBcK5qHDKZFQ7MpZ5zyMt2y6r92moanEG9jElWYwoocAXVkzEqpLuFbQhbOzQcTZJ4xM2yMPpbZsuEMEQfjmxvTcndOBAIs6LKY06Uf4IxK2s5mexBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxdG6UnSjAA9iwFV041Z2OWM1ksQdgXUmMFiPoSFzKM=;
 b=cAzuuvVnZCP/sCpuw26AWHiAh4wR3j6Z0nfC6z4+49uIHAMS9z4JrHHAOoGRh9w6dBf4X/GFP9r+6wOlr78VJ0QfysMuSDg2ISLzZ5Zx+L9SOI/epMtHXKso3Mz6tZmweawJOV5odAbQCMC3B89psjQ0nWuISrpWWVR3zqJWDII=
Received: from DS7PR05CA0101.namprd05.prod.outlook.com (2603:10b6:8:56::21) by
 MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Tue, 24 Sep 2024 05:57:20 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::a3) by DS7PR05CA0101.outlook.office365.com
 (2603:10b6:8:56::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.14 via Frontend
 Transport; Tue, 24 Sep 2024 05:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 05:57:20 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 00:57:17 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Christian.Koenig@amd.com>, <rajneesh.bhardwaj@amd.com>,
 <Ramesh.Errabolu@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: Add gmc interface to request NPS mode
Date: Tue, 24 Sep 2024 11:26:48 +0530
Message-ID: <20240924055652.2678433-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924055652.2678433-1-lijo.lazar@amd.com>
References: <20240924055652.2678433-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c202e0b-7e23-40bf-fd7e-08dcdc5dc0e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w41ZOOCczgPHN2RKEEXfXmc75tm8T74o0a7CXYXlquiEyCrgMuz+uunuqY9l?=
 =?us-ascii?Q?N6neVM+GWUdVpSbmdVPPPy8oG1m7KV1AX6J+5rc5AlZGRpW2qQeUiprGK4gR?=
 =?us-ascii?Q?n03bV/U/g7VU3O9tLtTu5al01FHwMVLPm19obV4kUWRrhKX3YqD0/o/txSkq?=
 =?us-ascii?Q?f8VmKjFPdC95F03ahAp8uArJlprB/FPwoZXiWOkXs+1N3u0M6L5uy/g3W5Mr?=
 =?us-ascii?Q?mD6uaCbClR7XpTvN+MVBQxYxUOc6H3IjbIBoZupRWr0Ye2eoA6bjZWHm2uX9?=
 =?us-ascii?Q?XSsdLD2HeZq7GskH8H3tSmU/rUiHwISHcmVmgHmvU6trGUhWtumUyfA6zcfq?=
 =?us-ascii?Q?iXjvAROdxkHgBiWCcGDA3o/fk9WBsf94IUZ/3F0dQPEBxlD3km+3m4dFQwnK?=
 =?us-ascii?Q?5vGFLLUDWmZi4jwjqQKMOS2hP2h9CdCPPj6Mwyj9+9WkCrpLzObw5xCsu/PF?=
 =?us-ascii?Q?9u4IPcCeqi+ugvEatrfVxMyH9SZHsIAsUJepmbzAvBzAn6ME6sa8JjKuDklz?=
 =?us-ascii?Q?dn+tIzrc7S0YeMnQnEClQrDzLtG6bgrFYb/EcIkxTLFIOqxmO3VUbroxiBPZ?=
 =?us-ascii?Q?m5Vgm+IaeaMG0VVUzLSfpRUbqKYd46LjviW/FYjlWdYz/5INtLQMKLEkqjHx?=
 =?us-ascii?Q?j4c/t5cYBFtyDWD1fTbzmcXn0V5tYmbGyApmRnG0hK76Qf13w2S7llSIpT4e?=
 =?us-ascii?Q?mPHD0RhXORGGIzCGcP6GRo+DO+f+4197HsFZO+WnsRlp0MgGzSZnv1yAl3Sv?=
 =?us-ascii?Q?kp5EYnqky5xT7T+lAbYSVHp3NlTzau7vx/ncaz3edictIwerSQPOi0Cl7JzB?=
 =?us-ascii?Q?GtIHZKXBqDhq5vnzfO/aBsOhm9vxtXjG7OPtukmAqtdl751KDJCLxTQdGei2?=
 =?us-ascii?Q?nYpqfZDYU2thasAo1H1uPjcYDlunAHe7E3OwKMGKF2HMtdsvaw/PI5+k58xg?=
 =?us-ascii?Q?RWYz7oFM8rzmziZ3qPzb5oZvS3z2oOXvgYMB6BCXw1sxYmI2uLdvauJ+qbSs?=
 =?us-ascii?Q?tzg/2HoZWTfCsN+lxTxRBT7WyQKX7Um49bw/cVeaRPWxEnpHcDvikfirvant?=
 =?us-ascii?Q?DX2dFGVjW6iUGrjYFBKFRYAPSYD5/8GXIeovHDLEAZuex7qv6Fpv0NHZoJYv?=
 =?us-ascii?Q?Q28Xui2XwoXA87cncaoMe7pRfQQkVZYV1NrdIG3eySkhLGsE7P9EEhWoSoi0?=
 =?us-ascii?Q?wGSxXZMCYFXhdsU6KATPkLZmjphW0M5UnfCTYxDpPMew4NMV6oU5CbnkiBNA?=
 =?us-ascii?Q?DP270egJ7zdVH4d1LpkSXqBXt5udWoQW0c2vV+Q/l9jNgNVxNE4oBvbgzkD7?=
 =?us-ascii?Q?b6X+XnwIw4XpUlURuNb+0UhXdN2ZnoVSR5AcQH7ceTxyVcw41RgDqsxkhCO2?=
 =?us-ascii?Q?DP6WTCFaCDXB0qKXoXNF9Omji9pJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 05:57:20.4819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c202e0b-7e23-40bf-fd7e-08dcdc5dc0e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
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

Add a common interface in GMC to request NPS mode through PSP. Also add
a variable in hive and gmc control to track the last requested mode.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h |  1 +
 4 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 4f088a5368d8..758fda4e628f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1247,3 +1247,19 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 
 	return ret;
 }
+
+int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
+					int nps_mode)
+{
+	/* Not supported on VF devices and APUs */
+	if (amdgpu_sriov_vf(adev) || (adev->flags & AMD_IS_APU))
+		return -EOPNOTSUPP;
+
+	if (!adev->psp.funcs) {
+		dev_err(adev->dev,
+			"PSP interface not available for nps mode change request");
+		return -EINVAL;
+	}
+
+	return psp_memory_partition(&adev->psp, nps_mode);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 33b2adffd58b..f5be5112b742 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -161,6 +161,9 @@ struct amdgpu_gmc_funcs {
 
 	enum amdgpu_memory_partition (*query_mem_partition_mode)(
 		struct amdgpu_device *adev);
+	/* Request NPS mode */
+	int (*request_mem_partition_mode)(struct amdgpu_device *adev,
+					  int nps_mode);
 };
 
 struct amdgpu_xgmi_ras {
@@ -304,6 +307,7 @@ struct amdgpu_gmc {
 	struct amdgpu_mem_partition_info *mem_partitions;
 	uint8_t num_mem_partitions;
 	const struct amdgpu_gmc_funcs	*gmc_funcs;
+	enum amdgpu_memory_partition	requested_nps_mode;
 
 	struct amdgpu_xgmi xgmi;
 	struct amdgpu_irq_src	ecc_irq;
@@ -455,4 +459,6 @@ int amdgpu_gmc_get_nps_memranges(struct amdgpu_device *adev,
 				 struct amdgpu_mem_partition_info *mem_ranges,
 				 int exp_ranges);
 
+int amdgpu_gmc_request_memory_partition(struct amdgpu_device *adev,
+					int nps_mode);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index b17e63c98a99..5d721ccb9dfd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -667,6 +667,7 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 	task_barrier_init(&hive->tb);
 	hive->pstate = AMDGPU_XGMI_PSTATE_UNKNOWN;
 	hive->hi_req_gpu = NULL;
+	atomic_set(&hive->requested_nps_mode, UNKNOWN_MEMORY_PARTITION_MODE);
 
 	/*
 	 * hive pstate on boot is high in vega20 so we have to go to low
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index d652727ca565..67abadb4f298 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -46,6 +46,7 @@ struct amdgpu_hive_info {
 	atomic_t ras_recovery;
 	struct ras_event_manager event_mgr;
 	struct work_struct reset_on_init_work;
+	atomic_t requested_nps_mode;
 };
 
 struct amdgpu_pcs_ras_field {
-- 
2.25.1

