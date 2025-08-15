Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CBDCA0ED1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Aug 2025 04:11:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D57E10EA26;
	Fri, 15 Aug 2025 04:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m5xM3DDI";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5846D10EA1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Aug 2025 04:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DobBNxaiCMqOh0zajKpN8hfhn+czs8BCpaXo3g26Sx0pxedP+0YFgmlwWiMUjbMVxQpe4OBsXKy80dH4sL4gI5mSiu/4qvr/43RY+2yWHK+sA6fVKgoACLRawdBvoeXpCWDG0pbTsbsdTcAvINnpmLJAAmE+9WMWCnZCnXqMpbPmQ05+Ahqn8vfUccbzzcGX6X/n6rEdViIlMfA7mU04gEuiPb9tFkzsv+aNxwTsxw/UmnEmAOQPIs3RYGS5h+n3W0XeMzEDXc7Z1TboQiFWoKM0Ua+p3bh2Pje8vTIsn9RvxMKSgS1D5n4RRSFm1op6H3TZJANIok+ovBqtA5Q/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaRRte0x/wKi3k5eT5gfAcArrfwQFIFRD1j7BSPn9AU=;
 b=N0Ia5iRmMlTiycG5WClJ/urTSX+L15laVvvI224q+mYnmFkWqJS7uieG7fr+a841ObnA9fpgOniZ6B0idH4cSm1hZd6FHYCHxpLKgQh46Yb6UP+2M5brBdyArW7+s755czOX+RIt5cudONZ7BtqupRdImHIva0qZ6Gv+dWj+SE1EAEVfnQG6TELNsZbxpmXOBZ01u+HNnS+ktajQ4NhmhTASNDpg9a4IRQp8PhAkD1fT6grie3KvdN5bhL3SIEQXnlhUq/BWVh5w9G884f44nr9wGSq7d5R3WEheXFhK+wpiluvvxcJlFHxElBdiLm0sYTpoMZR8aCthxau6LHAaJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaRRte0x/wKi3k5eT5gfAcArrfwQFIFRD1j7BSPn9AU=;
 b=m5xM3DDI1uTF61RGnCuio9+aD+u0e+9Xvy7XaD+opoirRsKwIN4bIhF58Lt3ze9P/gPMyzlZDBt/Uibi2HpLOlsXIyJOtCrcWrLoN4R71AyUVwvXNCVbXrTwBC85XZj1EXHHAy0zq8V9PoHFz0PiKedGNbo46q6lr1bb6Vgthx8=
Received: from BY5PR13CA0006.namprd13.prod.outlook.com (2603:10b6:a03:180::19)
 by BN3PR12MB9593.namprd12.prod.outlook.com (2603:10b6:408:2cb::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 04:11:22 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:180:cafe::aa) by BY5PR13CA0006.outlook.office365.com
 (2603:10b6:a03:180::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.7 via Frontend Transport; Fri,
 15 Aug 2025 04:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Fri, 15 Aug 2025 04:11:21 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Aug
 2025 23:11:18 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <Stanley.Yang@amd.com>, <Hawking.Zhang@amd.com>,
 <kevinyang.wang@amd.com>, <YiPeng.Chai@amd.com>, Ce Sun <cesun102@amd.com>,
 Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH 2/4 v3] drm/amdgpu: Add functions to get/clear bank count
Date: Fri, 15 Aug 2025 12:11:09 +0800
Message-ID: <20250815041109.301001-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|BN3PR12MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: bb73f70b-8d90-4b56-0045-08dddbb1cae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?28Vd2UnYcOfRkSfJY/XZmUSh8vOO7NuNkV7q27pi6emipNPqfmKdfPBX9gPE?=
 =?us-ascii?Q?sUSZwrHRlIW+F2AuIPR1L6acGmn3kHo3aXk6x/aM1g0D1JK6e/NXwQSe05Gm?=
 =?us-ascii?Q?UyqJuc49XRuW4RjHfmrDXmGYbHy3cjm+37g0kc7le1WTFMrYBrYHl5Jj4YSr?=
 =?us-ascii?Q?Q0dsw/qL2xuIge0cnGtgbpqsMOofAlb3AAt7+PF3Vgi7ddIeYB+XaMOSOpyJ?=
 =?us-ascii?Q?WvG3mzSsdvkR9N5DL5sBlNOtX7+kCEbDAkMqI2dGUFOs7csNa50r3wWh2uT6?=
 =?us-ascii?Q?sMx4sJawG73PjmZYMtClCsiMU7/yU1XoFzSxHre2g+vbKWU+vti2a4kZ9opy?=
 =?us-ascii?Q?16D5ljTZfXuCALoxwQAk4sCsumW+4dLFDQjNw8UCxEKru/rXVhb84xwLupUv?=
 =?us-ascii?Q?hrzJkQ0xLUWWS3hp4fYFYNG/14VtCS9KWeTKMUVnigcvhT6dN3tQyRghbGDX?=
 =?us-ascii?Q?fxIx+YVY6qeC24XgOm5oPbB6YyM+4EgsocanyoS3Mjh7WsXMalBWPHX12rBU?=
 =?us-ascii?Q?5ERyjAq/NWujLxl4N/pFPDqC4GNJ1egSpcX0HtVl5rq7EZoc98SgB/RT3ViN?=
 =?us-ascii?Q?ObwGfUokfAcmxVqnNn1btun91dvjfIyGzKF1VHTdkjuZaNsXmQ68GL+fACM6?=
 =?us-ascii?Q?0gM5+bvbZ93Gq5ZBgft+cDBX3bVucIHfX+Jdm6AhNl4esEhPGfVzdU02jKay?=
 =?us-ascii?Q?EvEgXJIrQcYdCywpKLEQowojaUjgFVIeYQhTYIXNd7mnxJyQ5nXWNg1A6YDh?=
 =?us-ascii?Q?DbNalE82zWkv9SRVA1RtsnBG/9w3bRjeQh9fv30XC9wuwDpy5qDq0nPFh1En?=
 =?us-ascii?Q?t7LDPMY/9jMlsv6cK0XeF2UUT6Y+IE2guZHUI7YVPUmCMLScVRdLFtkpdqWF?=
 =?us-ascii?Q?I2HTI7PKZZg/9IIufxIZHKYK7mMhMw6Isp/lcOBKaJwzdKVfVEscZF6p1Bp9?=
 =?us-ascii?Q?Xiak1fDqSg2YrbZHkseVJb8tcZx0G8PqRs+efdlzPlzMrKl1dPaWZv9obfwZ?=
 =?us-ascii?Q?gn6jdSdlO6fzjiNCxrHmfclMMb5AH9lucfZJUIkBMWDDvfutmb9mndw9Mcih?=
 =?us-ascii?Q?IQtgieXcj/diHhLUHaVRrwROYqDL+lw0jEEOvakzPnnRpp2/83Np+E3p+zbD?=
 =?us-ascii?Q?ZFk6Z3QQEJomodUERyZPrwg7Umlo7tcABv6HffqkLnPD8+BNIEGgjTzYAG5w?=
 =?us-ascii?Q?a4ph4J8vxJEGMU8uxD8/MaHhqWFU3/hLzUNXI0j/CmFTVzGNQRlo4ii93Rnv?=
 =?us-ascii?Q?8sEO72u9ikc3rJOcLbJQukdcmVgFQX1DJZW2OIbsu0ssVQX13YQ0tE2wUm6u?=
 =?us-ascii?Q?QOL65/DVw/nxkxeoVCu1ZcLES5gW7OFTgjtRTSOrRHebGJeoeAZZFKPc91Wz?=
 =?us-ascii?Q?uiV9XMAB8ugiPGADdUSZeDTIoYmS+CO2fxNxLb4GKF995R80ENDSch72Pdht?=
 =?us-ascii?Q?YtGVZbiRazcjM2MHZRVYUclFf3BS9UshQEaX68SHSomNcU2CJIXYrjh3Jybn?=
 =?us-ascii?Q?G5j0QxI9pY/F7dPyKPgcWe8968D08/D2tBIe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 04:11:21.4914 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb73f70b-8d90-4b56-0045-08dddbb1cae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9593
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

Add the amdgpu_aca_get_bank_count/amdgpu_aca_clear_bank_count interface

Signed-off-by: Ce Sun <cesun102@amd.com>
Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 090bf6cf1b91..92c2370831b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -480,6 +480,8 @@ static int aca_banks_update(struct amdgpu_device *adev, enum aca_smu_type type,
 		goto err_release_banks;
 	}
 
+	atomic64_add(banks.nr_banks, &aca->bank_count);
+
 	ret = aca_dispatch_banks(&aca->mgr, &banks, type,
 				 handler, data);
 	if (ret)
@@ -766,6 +768,7 @@ int amdgpu_aca_init(struct amdgpu_device *adev)
 	int ret;
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 
 	ret = aca_manager_init(&aca->mgr);
 	if (ret)
@@ -781,6 +784,7 @@ void amdgpu_aca_fini(struct amdgpu_device *adev)
 	aca_manager_fini(&aca->mgr);
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 }
 
 int amdgpu_aca_reset(struct amdgpu_device *adev)
@@ -788,6 +792,7 @@ int amdgpu_aca_reset(struct amdgpu_device *adev)
 	struct amdgpu_aca *aca = &adev->aca;
 
 	atomic_set(&aca->ue_update_flag, 0);
+	atomic64_set(&aca->bank_count, 0);
 
 	return 0;
 }
@@ -865,6 +870,15 @@ int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en)
 	return smu_funcs->set_debug_mode(adev, en);
 }
 
+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev)
+{
+	return atomic64_read(&adev->aca.bank_count);
+}
+
+void amdgpu_aca_clear_bank_count(struct amdgpu_device *adev)
+{
+	atomic64_set(&aca->bank_count, 0);
+}
 #if defined(CONFIG_DEBUG_FS)
 static int amdgpu_aca_smu_debug_mode_set(void *data, u64 val)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
index 38c88897e1ec..e9acfbf57a44 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.h
@@ -202,6 +202,7 @@ struct amdgpu_aca {
 	const struct aca_smu_funcs *smu_funcs;
 	atomic_t ue_update_flag;
 	bool is_enabled;
+	atomic64_t bank_count;
 };
 
 struct aca_info {
@@ -225,6 +226,8 @@ void amdgpu_aca_remove_handle(struct aca_handle *handle);
 int amdgpu_aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *handle,
 			      enum aca_error_type type, struct ras_err_data *err_data,
 			      struct ras_query_context *qctx);
+size_t amdgpu_aca_get_bank_count(struct amdgpu_device *adev);
+void amdgpu_aca_clear_bank_count(struct amdgpu_device *adev);
 int amdgpu_aca_smu_set_debug_mode(struct amdgpu_device *adev, bool en);
 void amdgpu_aca_smu_debugfs_init(struct amdgpu_device *adev, struct dentry *root);
 int aca_error_cache_log_bank_error(struct aca_handle *handle, struct aca_bank_info *info,
-- 
2.34.1

