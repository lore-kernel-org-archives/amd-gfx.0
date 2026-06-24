Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9A0CDB470
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 06:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9853410ED93;
	Wed, 24 Jun 2026 06:44:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OaZdc36d";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011000.outbound.protection.outlook.com
 [40.93.194.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE52810ED34
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 06:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vh7yt7N6NZtmU5gkY7XQoOVpQOVbwRNZKoPw0Oi1V1/63/F7ZdG0HqN4J5LzyywfOt33xlVUudD/LnBxjOTCRepBO65gOdcCj8qNogy4eOiGMleOoqaqc6tGzngddeIyQikTTEWsPQRMOKhUDzaHUYRDaPyvYm2WeuHe1TXmvzqJE573d8+HO6ULRwDV2TsTsEMj7lrcZBUHfHksHIX9S7O85tV8guBU8uGe61zNuH/dBOsMIhDnOPigY1KRuTrWMVFI3Hnb/Eer8AV3EqT1//9Y6A3XonijhcyNQ3tHMqc1FdyQBsl4exH+w/Su0i5Fjtz/qmv4d1WknCAo4lMD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giFPH/JNv4B5JWilZDm0++K/C1BxSwtYScfAc6IqF/U=;
 b=esSKEwGw19FTB4LlROPQfrDlFTQ6dhBDTJ38lF2CqVqEpNXUyXvdrO4KzBGYoQqroNn8dZD+sWKD3+TOCNhP+HIrxJiKGg2WjAoXJSKS6RhbzH9gAmPjJpDCq2mD7XpyX9pEK83BJfEyn6Oe/5gV9zZyQAObh3oJWVi/AG5U6nGIED8ZWrRS9dgncWBOAHkbpCbGyaY1JvE02S3RZzMgQ8Rwfo8tz6T3INSKArSvRJ2J42zfw3SCvHBpWNqoAGZHSTXkpH5jpqgENwl3Y0WsZqBumJJ14PAkc5pSHUlPSDFwB2eFDlrR5LiQB13MVxFSk0t41izfHGW288NILcv4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giFPH/JNv4B5JWilZDm0++K/C1BxSwtYScfAc6IqF/U=;
 b=OaZdc36drwdPeJnQab5Hqhj9YOtgrTRh9ChrvaqWVi2quZhk80WpW1gfPlDOlKU5I7wgirhOFxd3dLo3klUyYbrNTaJAb/udRVDAnimRJzS9jOSzsQrwNyFE8n4SqamNuXAhI/pghFsAYLk6GYdzidS+mc0yXBgAA0NeBfWtk0o=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 06:44:46 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::aa) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Wed,
 24 Jun 2026 06:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 06:44:45 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 01:44:42 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH 4/5] drm/amdgpu/pm/powerplay: bounds-check voltage index in
 SMU7 lookup
Date: Wed, 24 Jun 2026 14:44:13 +0800
Message-ID: <20260624064414.144468-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260624064414.144468-1-asad.kamal@amd.com>
References: <20260624064414.144468-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cec9036-fde3-4e7b-dad0-08ded1bc1472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mYYulU38w7ciw/fUDLxPm7seKE5YMYST/u7hdtenZIvsg9cO/Jz8SD340V4c6KNF65rM86iMH8QYL0H3TpCWWH66IZsDOQa2fno5NLhmM5QkjF5RCYFBKDEoo9HdFrrkUBFCU64a+TWek6JunCb7GNd0tHPGyN5P62mHHJuaT95rZE5xQ+uo+F94X2UTSAgwXiygYF4oAL7PQjO3lzK5XXUGufxT6BwcvGM3vEnhj2+QwfLq5GufOy1opA6qZF1MynKL5IpleAcU3mOt60cT5uSsbMKZcoOuRKCTS6FdR6FofUcNNWbEO96ZD//RW6eiWf3FkcW8nHKHZb/9jDnYcrfiDvGDyenPmq1W607VuS46bMVCpYTfxK1MAJukKgDbucsgMU+DT3QFCxtHQZ1cwYu/Ezq05McSb4bujD5xP0ZQVZ/roeAuQC5UsfSULqp8eNSMwD1HXZ8ra7OyDDj0YElBHW2AEUtDXpA9qRqnTYq1v2FZ/l1fWdYbCAMKlfw1h4vGgRKgJgIScxaMlvHZjOQmKKxauGT2f2lpE2Bi279dcjrroMXw9hRHeNCq5RG+/+1cMAk6pwPv3ml9qX0vSZ9DzrSZPDzwmbWBeDUY91ol4lvn5F1MJiyozRJohaFGVRQcAdDKz2B7Fk/r13w0YPWVWCsiGPr5F93qLYA8V+/8pO5WfOga2Cs9mq6auqsfb1c1Zo4QA/FxFoJt1f8RPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +74+khnbmZq5uTB53te1M4Q+UQMzZNfGlhlHLu82CW5hoZErSfC9XXcAllOpsTD4HrsLHkKLg5ImUaiNM/lmJ4Eh3wT4OhzKWvECooUFsRT1iowJkQGRm2y1zz0YDFlqXOL9sGkBPNPh9xHVo9gqFAN9v8duYH9Ado3u58hw3ecXSZEoAWcK0YxJAKVPuYuV8iJmDoSHQAxoLiaLbKrrmbc76PsCh/Zp/LByMyzoxX8U86DocE2H/Oid81+TReMKdkj3OSCzbQZ73w/K0Sqe8mBxgaBvGHdJ7UnnxdfIZLiCQE+LPi8M8Qi25HuV0V/BDNRT4l2UlELSFOEhI4ZAELnqeX63ePKYGzz5/QH4gO0Ybs9RI0ZiKXJlhUshnyUhCfOddRk68IPgqNV+nnED0t8XN1sml8kBJWwh8Aa1eMO98QiND1WOiwMHIR73WrlE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:44:45.8972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cec9036-fde3-4e7b-dad0-08ded1bc1472
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
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

vddInd and vddcInd fields from VBIOS-parsed tables are used to index into
voltage lookup tables without a bounds check. Return -EINVAL when any
index is out of range.

Fixes: c82baa281843 ("drm/amd/powerplay: add Tonga dpm support (v3)")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index aac6a0fa5d7b..be824e3d276b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2216,12 +2216,24 @@ static int smu7_patch_voltage_dependency_tables_with_lookup_table(
 	if (data->vdd_gfx_control == SMU7_VOLTAGE_CONTROL_BY_SVID2) {
 		for (entry_id = 0; entry_id < sclk_table->count; ++entry_id) {
 			voltage_id = sclk_table->entries[entry_id].vddInd;
+			if (voltage_id >= table_info->vddgfx_lookup_table->count) {
+				pr_err("amdgpu: sclk[%u] vddgfx index %u out of bounds (%u)\n",
+				       entry_id, voltage_id,
+				       table_info->vddgfx_lookup_table->count);
+				return -EINVAL;
+			}
 			sclk_table->entries[entry_id].vddgfx =
 				table_info->vddgfx_lookup_table->entries[voltage_id].us_vdd;
 		}
 	} else {
 		for (entry_id = 0; entry_id < sclk_table->count; ++entry_id) {
 			voltage_id = sclk_table->entries[entry_id].vddInd;
+			if (voltage_id >= table_info->vddc_lookup_table->count) {
+				pr_err("amdgpu: sclk[%u] vddc index %u out of bounds (%u)\n",
+				       entry_id, voltage_id,
+				       table_info->vddc_lookup_table->count);
+				return -EINVAL;
+			}
 			sclk_table->entries[entry_id].vddc =
 				table_info->vddc_lookup_table->entries[voltage_id].us_vdd;
 		}
@@ -2229,12 +2241,24 @@ static int smu7_patch_voltage_dependency_tables_with_lookup_table(
 
 	for (entry_id = 0; entry_id < mclk_table->count; ++entry_id) {
 		voltage_id = mclk_table->entries[entry_id].vddInd;
+		if (voltage_id >= table_info->vddc_lookup_table->count) {
+			pr_err("amdgpu: mclk[%u] vddc index %u out of bounds (%u)\n",
+			       entry_id, voltage_id,
+			       table_info->vddc_lookup_table->count);
+			return -EINVAL;
+		}
 		mclk_table->entries[entry_id].vddc =
 			table_info->vddc_lookup_table->entries[voltage_id].us_vdd;
 	}
 
 	for (entry_id = 0; entry_id < mm_table->count; ++entry_id) {
 		voltage_id = mm_table->entries[entry_id].vddcInd;
+		if (voltage_id >= table_info->vddc_lookup_table->count) {
+			pr_err("amdgpu: mm[%u] vddc index %u out of bounds (%u)\n",
+			       entry_id, voltage_id,
+			       table_info->vddc_lookup_table->count);
+			return -EINVAL;
+		}
 		mm_table->entries[entry_id].vddc =
 			table_info->vddc_lookup_table->entries[voltage_id].us_vdd;
 	}
-- 
2.46.0

