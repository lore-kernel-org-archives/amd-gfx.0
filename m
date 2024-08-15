Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9E6C52D7C
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 11:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98FB810E20C;
	Thu, 15 Aug 2024 11:39:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZDW6zwNg";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD48710E20C
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 11:39:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZqQ/NJ20HdZ65Gh131BwHgB9ZCGJ2fKZ/eKl1jemfv8daj+ghGK9lVJ+ly9qXKneCaiflmMzCpcwBUtYQHLD1y+1hU6GjRj5RoX2Pmg5GOdRjGcyiStQqt+AFI2ebav9c/5U35Am73b/ovYGDFiB8OHEPJ5EpGFZ/ZSAzzYX40Dqckr535hzKt6/s87Zgj4Wc1VrTELcRqTm5DMmpeNv8NJFdnbh5UgeiBbsHMIb8/g8FDYyqLXy8Q5j66DXlwIsspoS5CFEKl2DeXoTU9nOylxjF4u72ntgNIzb7yLSIJ/HmHD66Sn0QJZiAUL+bLJ7w1HbFjV3HE6Xksnq4agfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgtC4gjosnQS4jmgmCkDChBjs7wZyQcTVGh6bN6OfDk=;
 b=PeVpFzRgHXbAlNEaIL8oOYje2wAc35iwcoT59BwFf/a5dN9h1gFwkqhTLA/8+BBlIY8Kma4cIqS71TeTHlz9Vld6VxX75Q6fwOrNQF3ZZ/HxvFA7x6ijDBYKZKqcdw/Bk3YBURw7MVnGwQAIXf7IAsAh9frYzY9gy5NOOYds90gVgX/l82YFR2qHYdovJLgh9ttUq0itEO/OXi1NSjLat9larY56ZT/qneoVKxbrUzZztscHjrGX0Y7LAMrq1+WPMkRpbTL0KzBFWhxjgTeD/LZcy76QecXlXqPcOUaCPFLt5/AgJwx9NlSxYiFj5QXep7nW8WC4/Uq+buMNc4alXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgtC4gjosnQS4jmgmCkDChBjs7wZyQcTVGh6bN6OfDk=;
 b=ZDW6zwNg3yPTYMyOmxKufDAyNiKlNohVD94CKpyAiGasgO29MvKagl5HheecjF7duRn6PZrA1IcG+e0kDJplMfZt5bmQqsGyEyhGsuZH+TLF2PcJYg6n36sYTxhzu9A9rMdWqG4i+ofsuhFWdt17yNbkTyudDYF40wQSLpH3Klg=
Received: from BN9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::10)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 11:38:56 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::30) by BN9P223CA0005.outlook.office365.com
 (2603:10b6:408:10b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Thu, 15 Aug 2024 11:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 11:38:55 +0000
Received: from lps-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 06:38:53 -0500
From: <Trigger.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <sunil.khatri@amd.com>, <alexander.deucher@amd.com>, Trigger Huang
 <Trigger.Huang@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: introduce new API for GPU core dump
Date: Thu, 15 Aug 2024 19:38:35 +0800
Message-ID: <20240815113836.399377-3-Trigger.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815113836.399377-1-Trigger.Huang@amd.com>
References: <20240815113836.399377-1-Trigger.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b08a1eb-525b-4863-8ace-08dcbd1ed863
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g4r3LefcsN66tpP956KyuJuQgPqfwXvfjou+TXYuCsgcHOYvo9jEJlBwdgHL?=
 =?us-ascii?Q?FxDwddaor/vhbN60ruZsb/bfwiQKtVKBzf8hH+hPzktVA378J+ItytxsQyQ2?=
 =?us-ascii?Q?NPv6LYnupaYu7xZ8bVtRVjZVixzpNHDQUdysh0iZl95mL9TK+hfl4X07ePM+?=
 =?us-ascii?Q?inif+ryss3uV2aedqMokx5BY9emyVSDJuM0M4hBmFmVGiz3+iKoKZDNR87UY?=
 =?us-ascii?Q?5yd63/BqLusz89QOdPU1BFpZV//03gPWOvumoBJfOU7qfHiW2TVM3UcSqTeA?=
 =?us-ascii?Q?MC43BA5eVibBTRZsSrZB5HxgUOcEyivzdWlbGtIlve3AXZEeYBoyHbxieDmY?=
 =?us-ascii?Q?VSRzLCTH0jcGxt+GGMMi9jU3oc1JOQpcR+mfZwfyJsxycwqQEoOxsdvkDfV/?=
 =?us-ascii?Q?a7CQpoifZexz4V4nwvVax9P/9I6cjKk/pX/zOy92z/8qVpkCJwNMnlGipJ28?=
 =?us-ascii?Q?78Z/nl++EdSnjUN0aaTrnGUi3bwoJqgm2zLDalj3O7Ih3qlVl4m2w9twLyDV?=
 =?us-ascii?Q?sjC+QZl3JpFm6N1fcUev7rvqbXrdQmCEDRp9ei24txBDRC0sUHpLZzkZWZ5j?=
 =?us-ascii?Q?HwrpxrJIaeoiQVhWTDgQ9zXjMhHdx4XMOlgbiGLqElKr+uwimY/L8Q/4VwO1?=
 =?us-ascii?Q?bXGWDKKG92mNv4LTHhCQT5EHYNdNGeymq0J6cgYTq86gJDRFwbKBmAvb/dQF?=
 =?us-ascii?Q?2mTFIxml9VD0cbD3F8iaxIHZF3+QFDTJRnkStxd+elERWG2kNWpF1n274NUl?=
 =?us-ascii?Q?mV3IgTNMlHrDJiAc29vgS630WzM2UArHQf5XMLPTMTtcozYVwbauzb80PtRc?=
 =?us-ascii?Q?WoKY/6rLiRULKsf9QKtmFCyzBRJartBei/g5t+yfNy36vo/yXN7B0tlJL9h9?=
 =?us-ascii?Q?WI1EZr2IWupm3vVR5L2I7BJMwT8RH72doLCJZNwe/dKfBJ7YmcIARA3Vr7Dg?=
 =?us-ascii?Q?qcyAIXabl5so9DAIGFyxQHdM9QKwDRxu6n13v25ywzqm+MCxX6/+y50cYxsR?=
 =?us-ascii?Q?VC26mPs1/zyKX+1fp/xE/lmZaiJw2/rxOaGnmb06yPKr7yM/qfZUd4iPy/YP?=
 =?us-ascii?Q?svH08VIuFcLcME5iP1ijcAtCHo0s71P6bOSlGDpDaw+7+Ri1UwgxrImD4mdb?=
 =?us-ascii?Q?JCF+xZa9vhW+G+4NBMXzpxxxsjnNQJWTpEs6GZB5ueA9weK0VA14UxkRQ4l9?=
 =?us-ascii?Q?phzs0wfzBrFsXC+UGpp7bwOI0iwZwlst4Ho27kszqPqXMuQS5+q4stY0Zz42?=
 =?us-ascii?Q?WwtO4Fn/kUoEWm3CBdLgMZPlhl/d+FGbiaOug7MEKB+/V0vTTJLG2HqhuFtf?=
 =?us-ascii?Q?WjCAUYkJuwsUGVDEyAehvd2nCYMVVatAPb2FAIPAWYaCB+tDqkQHKrFXdD7a?=
 =?us-ascii?Q?ZdFlZqbpLp+u+iRCN7iCA8PsLEWxOOXACfGDmBGX4Wj4eNZpzGy3H97wk53K?=
 =?us-ascii?Q?blBAHHj8/Lb4GMf5q9WXh6iqb8Lw3rT+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 11:38:55.6213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b08a1eb-525b-4863-8ace-08dcbd1ed863
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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

From: Trigger Huang <Trigger.Huang@amd.com>

Put ip dump and register to dev_coredumpm together

Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 73 ++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4dd465ad14af..b64284324961 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1401,6 +1401,8 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
 int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			      struct amdgpu_job *job,
 			      struct amdgpu_reset_context *reset_context);
+void amdgpu_device_gpu_coredump(struct amdgpu_device *adev,
+				struct amdgpu_job *job);
 void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
 int amdgpu_device_pci_reset(struct amdgpu_device *adev);
 bool amdgpu_device_need_post(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a6b8d0ba4758..69d6a5b7ca34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -145,6 +145,8 @@ const char *amdgpu_asic_name[] = {
 };
 
 static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
+static void amdgpu_device_gpu_coredump_single(struct amdgpu_device *adev,
+					      struct amdgpu_job *job);
 
 /**
  * DOC: pcie_replay_count
@@ -5965,6 +5967,77 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
 	}
 }
 
+static void amdgpu_device_gpu_coredump_single(struct amdgpu_device *adev,
+				struct amdgpu_job *job)
+{
+	struct amdgpu_reset_context reset_context;
+	bool vram_lost;
+	int i = 0;
+
+	dev_info(adev->dev, "Dumping IP State\n");
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (adev->ip_blocks[i].version->funcs->dump_ip_state)
+			adev->ip_blocks[i].version->funcs
+				->dump_ip_state((void *)adev);
+		dev_info(adev->dev, "Dumping IP State Completed\n");
+	}
+
+	vram_lost = amdgpu_device_check_vram_lost(adev);
+
+	memset(&reset_context, 0, sizeof(reset_context));
+	reset_context.job = job;
+
+	amdgpu_coredump(adev, vram_lost, &reset_context);
+}
+
+/**
+ * amdgpu_device_gpu_coredump - Dump GPU status
+ *
+ * @adev: amdgpu_device pointer
+ * @job:  dump for specific job
+ *
+ * Attempt to dump all the current GPU status, like registers, ring buffer, etc.
+ * This function is mostly invoked when something goes wrong on the GPU,
+ * for example, job timeout.
+ */
+void amdgpu_device_gpu_coredump(struct amdgpu_device *adev,
+				struct amdgpu_job *job)
+{
+	struct list_head device_list, *device_list_handle =  NULL;
+	struct amdgpu_device *tmp_adev = NULL;
+	struct amdgpu_hive_info *hive = NULL;
+
+	if (!amdgpu_sriov_vf(adev))
+		hive = amdgpu_get_xgmi_hive(adev);
+	if (hive)
+		mutex_lock(&hive->hive_lock);
+
+	/*
+	 * Reuse the logic in amdgpu_device_gpu_recover() to build list of
+	 * devices for code dump
+	 */
+	INIT_LIST_HEAD(&device_list);
+	if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > 1) && hive) {
+		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head)
+			list_add_tail(&tmp_adev->reset_list, &device_list);
+		if (!list_is_first(&adev->reset_list, &device_list))
+			list_rotate_to_front(&adev->reset_list, &device_list);
+		device_list_handle = &device_list;
+	} else {
+		list_add_tail(&adev->reset_list, &device_list);
+		device_list_handle = &device_list;
+	}
+
+	/* Do the coredump for each device */
+	list_for_each_entry(tmp_adev, device_list_handle, reset_list)
+		amdgpu_device_gpu_coredump_single(tmp_adev, job);
+
+	if (hive) {
+		mutex_unlock(&hive->hive_lock);
+		amdgpu_put_xgmi_hive(hive);
+	}
+}
+
 /**
  * amdgpu_device_get_pcie_info - fence pcie info about the PCIE slot
  *
-- 
2.34.1

