Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CEF2E8304D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 04:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375D310E4F7;
	Tue,  3 Feb 2026 04:13:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OvrX4lHS";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE68410E4F7
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 04:13:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIoKTUpVLFoIWeT0ti1DZAYbROzjVuPK0TO1p1sEW2gjQbAtm5zzge0KFc2Y74h6/n3XJJuOrzuEfP7XPTn7cj77yJcZgbo3MjuhJJzXM26y6nbld48wb3hEAQfjmyDIYcgTyWGnzXL1kBF44/xhAAzwIOwMyOSWp6uNppFSI6YDDjw4BgnPVlHlHrcqWUFoSaBr71jrkydC9N6YjjXRC1eB0j+Hx3ihc/3BDtSzzr34P466NhJG046FKTm5mAA7Bf+3LnYYlIAcDZTHE5HBIZfnQgvHRnptLGeJN09EYN/zemHJWabgZrz42cGhEJaY8O0z0YZnNNAM/NccYv2Pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muR7KSmav49HHIFsYosuDvl0wgiefTQpqsjED14TsS0=;
 b=n3I2oYRL3CCshniMID+gTDtyAHxl9nwKJtfgbLQGo3q1jjfABBRu5/Aw5EC7u/Fgozvy6+gipYMDn8LSszdFl4Mp6oGtEKFoBrqxJgFKyPjXoyjhz0j+xyUtcYB2XC1aEEdEOoH2QYnV8ZnGxJtySbLbuiPy5hc7oUWHVyhL0Rf/nms6noTyUaXvW3WjJexjTUU9HiCBsBtdp59Ude9txjujsZoEYS3ueI/XhCozj/6O3Ran4Lr+tP4Vx52giQgfU7Wz16O9w3CFmvHjCMCgx7EPW7cuTVVYQcMo0r7gmMWmXTHTVX7I4KHMyosJEBRBMPi7nW+dRi9+bvmmHxWfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muR7KSmav49HHIFsYosuDvl0wgiefTQpqsjED14TsS0=;
 b=OvrX4lHS95sAcsIwuwD94K328IjSCp5bh208TqLH98Ss2gv6frhHdByld/wZbS5YA8VkMbej0+qN5ZiqLprfN3Dt2t/py+skOTIyMtgH8EshNKKy8fl5XcRv26B2lLTbmtK686ECUmNlQi8Zga4LSTKMKXyo8e8lom2yY4V3KWA=
Received: from BN0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:408:e7::28)
 by LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 04:13:03 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::50) by BN0PR03CA0053.outlook.office365.com
 (2603:10b6:408:e7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 04:13:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 04:13:03 +0000
Received: from gangliang-mlse-vm.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 2 Feb 2026 22:13:02 -0600
From: Gangliang Xie <ganglxie@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <tao.zhou1@amd.com>, <YiPeng.Chai@amd.com>, <KevinYang.Wang@amd.com>,
 Gangliang Xie <ganglxie@amd.com>
Subject: [PATCH V2 11/14] drm/amd/ras: adapt page retirement process for pmfw
 eeprom
Date: Tue, 3 Feb 2026 12:12:03 +0800
Message-ID: <20260203041206.1299104-11-ganglxie@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260203041206.1299104-1-ganglxie@amd.com>
References: <20260203041206.1299104-1-ganglxie@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: b8085650-4b64-43bf-a0f5-08de62da86e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2nCWgKn0fvJTpYJ6NMvcTVc0Sl+rGFycPTrfZOMguWyOJlCap7gYag3WqevB?=
 =?us-ascii?Q?2u728HE63eCyCt33LfoEYmKlwUqnFLbokgDyR4GNsNkwaMt4aQZsa4s1SuWg?=
 =?us-ascii?Q?Sg2MjWMLwPFlnW/NNOgVqyYO7KMVf15p5nhVD5k26U1InWu2WEyBVeO0ei5n?=
 =?us-ascii?Q?c+jflC6lTjjG+J8EB2uolCAvHFPCsvEIb2hM3MOcwwna/t19TiWuZjlmHq5m?=
 =?us-ascii?Q?+V2v9W8q9EQMtVHWApGlFgwcAMd3h/tLCfB3GIsBrgy4OEX9u7HuuGBx3/I+?=
 =?us-ascii?Q?p2L81Bir6+6boq9w7HsHlBfVWbOkjE4wDSICHkzZrXA35o5ef/EYhWF+oL46?=
 =?us-ascii?Q?2VKq+axU6DnW/2j9+pepnDcX5mRoIKR6FuBzX3+sm1EJnFsIa6c4xhz/kD0x?=
 =?us-ascii?Q?B2RdGR5yi5rCpbOQaelL9zNvWo4g/+V6WMnlLqC6ZqCokYGkzGKEYuZp0LYO?=
 =?us-ascii?Q?hZO+PpgkLCxFh4F0N3tn8aOGddnRwyggx3bCNvBYeCYywA8xpUehAbRZEMxE?=
 =?us-ascii?Q?3s3kdjWgk/1RaIStM/CVap6NV5GQORHzwJevoVBqB7ydi1P1WzaXOISSuSbC?=
 =?us-ascii?Q?XrbGLn8JAAsdpyYu5rHQlFidhRS+8DXmrhqUwaOqF/HhnXJB5072SPt1UGr0?=
 =?us-ascii?Q?SGr/YAdKJQbv1InTfDTY2ECkAW5kMyvZGf1gcNfyThyXKN0V+FaP68jb3EEu?=
 =?us-ascii?Q?ypo7L9XFTPSuaiL+BUItA/teqMpXxVwsGgcb2o2O8gmexVodsNaCfqJGUhe7?=
 =?us-ascii?Q?PAdTmaCPDtODm5UJP0Fd9c4XgPOtBIk21AmTCnCOkS8cyjcv3J2BallMVlom?=
 =?us-ascii?Q?69AgG5m+1eD5cdeu+5FBCdfH/p7x5wAb3trDOgd5GsEJDp0P5f9p4PGSiN3Z?=
 =?us-ascii?Q?lvXi2jIN8h8nDXGx/jl/ppHNFq9zTZsSq4xO//pqWO7t4OJSfddnXTBdxGH2?=
 =?us-ascii?Q?1diwRmWPaIWBi6BT2+UTML3R895N0JZxrqJsTeT1JiPvGKrP45USo+7Jn63l?=
 =?us-ascii?Q?JHoEbsPkgB5awMMwd2hHpbqgD/u0aCme+EFcaFotomw9onv6mSh6fkNztXY8?=
 =?us-ascii?Q?GCU2B9W721P7+k6SaAqw9W329k8Z+vB75FqP8xbRizW6bKcYCs2Me5u4FGcd?=
 =?us-ascii?Q?3LYnSRIimrHLCtEQAt8Ms+18TGrcmrF/jGd4pEJBojgOEQ7vDG/b4dbwsipJ?=
 =?us-ascii?Q?kiAHTPN1AW0i/95zRt/ldZw4Pa7Qd+l69BIyZTBVkcL3PBR6bRHGvcsInj7k?=
 =?us-ascii?Q?AzXenJvW2Bo+XDQ4HHvpAfU9agUB/m5LBozKjS8b4E5SpIB89BXn8ALR05HF?=
 =?us-ascii?Q?H0Ybf9n6wWdesxs5eldyZufT9xbJ/XKtVLUgAFNe3gD7nA2G3ckQi3gC/NYT?=
 =?us-ascii?Q?iXdCa1dLww5Qq/GgQK4/bUs9RL58pLO6XOtXI+8muARQwohwKP00LhAX2HIs?=
 =?us-ascii?Q?n4XcCUa/Ag/a6d0ehU6AO4bjQTgYhxSzD1VY6j5TfrUVQvNOgYclxlKuwq4Y?=
 =?us-ascii?Q?smEwD7MKwgrl0SgHm17EiWvrJFzqXbfp9C3bgekuk+JOuDuoXgWRQsE355W8?=
 =?us-ascii?Q?J158vCWkG3yc5Z6rUXEAfILt+Cr5Vc7YwHwABWSARTfYD/N9ojcwxe5uxFYk?=
 =?us-ascii?Q?fKuVv006L6pttTsGRxZZ4KUZF3QAj9S0fAgPiQgasd5mmlMkfmBuW3eKViob?=
 =?us-ascii?Q?C5UHgw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KDKqhsO/wxGQg7RpdnKGqhaehnFug0aUffzhp13uUHDTlMWAKLno7Rp1b3Dnkip2np75sVEc8Cd94Y9fEjXR6LkrB937QEM21k7mm6zrK8c5ly7kouZgxusr9p5YXvGz1BVvrP8yO7y287zqZMy6PxcWDD5Gr4JD4iTiqsvJJDs8LGs+5Sww/NbnHoplVBClOpGJAvbIxcvicwSjyYimyChftGyxrkGWbpTysUjxrxvZ7K4K3tdC7HIf1dAKqjE8F40p3bHNTzdNwNDY41uD/XUnI/yZV59E1LGPA9ERWo4KKA6mAeoBIRB2Jy2wvqwki2073cmxa77CUAQs8S3OOQxse8rHXAqDkg0HKxQiauJpe3KnkGUwEWRgOM8WNA9gUA+yqVl34VDns+zu2vhMwdtrbSmATwv3MgqGT/wXz1F5VUCdxW4Gfu63lgriCJQz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 04:13:03.8159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8085650-4b64-43bf-a0f5-08de62da86e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869
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

read bad page data from pmfw eeprom when retirement
is triggered, use timestamp read from eeprom

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 drivers/gpu/drm/amd/ras/rascore/ras_aca.c     | 31 +++++++++-----
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.c   | 40 +++++++++++++++++++
 .../gpu/drm/amd/ras/rascore/ras_eeprom_fw.h   |  2 +
 .../gpu/drm/amd/ras/rascore/ras_umc_v12_0.c   |  3 ++
 4 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
index e433c70d2989..67a35409ff0e 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_aca.c
@@ -234,16 +234,27 @@ static int aca_log_bad_bank(struct ras_core_context *ras_core,
 	    bank_ecc->de_count) {
 		struct ras_bank_ecc  ras_ecc = {0};
 
-		ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
-		ras_ecc.addr = bank_ecc->bank_info.addr;
-		ras_ecc.ipid = bank_ecc->bank_info.ipid;
-		ras_ecc.status = bank_ecc->bank_info.status;
-		ras_ecc.seq_no = bank->seq_no;
-
-		if (ras_core_gpu_in_reset(ras_core))
-			ras_umc_log_bad_bank_pending(ras_core, &ras_ecc);
-		else
-			ras_umc_log_bad_bank(ras_core, &ras_ecc);
+		if (ras_fw_eeprom_supported(ras_core)) {
+			ret = ras_fw_eeprom_update_record(ras_core, &ras_ecc);
+			if (!ret) {
+				ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
+				ras_ecc.status = bank_ecc->bank_info.status;
+				ras_ecc.seq_no = bank->seq_no;
+			}
+		} else {
+			ras_ecc.nps = ras_core_get_curr_nps_mode(ras_core);
+			ras_ecc.addr = bank_ecc->bank_info.addr;
+			ras_ecc.ipid = bank_ecc->bank_info.ipid;
+			ras_ecc.status = bank_ecc->bank_info.status;
+			ras_ecc.seq_no = bank->seq_no;
+		}
+
+		if (!ret) {
+			if (ras_core_gpu_in_reset(ras_core))
+				ras_umc_log_bad_bank_pending(ras_core, &ras_ecc);
+			else
+				ras_umc_log_bad_bank(ras_core, &ras_ecc);
+		}
 	}
 
 	aca_report_ecc_info(ras_core,
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
index 79494ad16ee5..4a1b966d22fa 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.c
@@ -24,6 +24,8 @@
 
 #include "ras.h"
 
+#define RAS_SMU_MESSAGE_TIMEOUT_MS 1000 /* 1s */
+
 void ras_fw_init_feature_flags(struct ras_core_context *ras_core)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
@@ -329,3 +331,41 @@ uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core)
 
 	return ras_core->ras_fw_eeprom.ras_num_recs;
 }
+
+int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
+				struct ras_bank_ecc *ras_ecc)
+{
+	struct ras_fw_eeprom_control *control = &ras_core->ras_fw_eeprom;
+	int ret, retry = 20;
+	u32 recs_num_new = control->ras_num_recs;
+
+	do {
+		/* 1000ms timeout is long enough, smu_get_badpage_count won't
+		 * return -EBUSY before timeout.
+		 */
+		ret = ras_fw_get_badpage_count(ras_core,
+			&recs_num_new, RAS_SMU_MESSAGE_TIMEOUT_MS);
+		if (!ret &&
+		    (recs_num_new == control->ras_num_recs)) {
+			/* record number update in PMFW needs some time,
+			 * smu_get_badpage_count may return immediately without
+			 * count update, sleep for a while and retry again.
+			 */
+			msleep(50);
+			retry--;
+		} else {
+			break;
+		}
+	} while (retry);
+
+	if (ret)
+		return ret;
+
+	if (recs_num_new > control->ras_num_recs)
+		ret = ras_fw_eeprom_read_idx(ras_core, 0,
+					ras_ecc, control->ras_num_recs, 1);
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
index 353977a2371e..18d6548e2151 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_eeprom_fw.h
@@ -75,5 +75,7 @@ int ras_fw_eeprom_read_idx(struct ras_core_context *ras_core,
 			 struct ras_bank_ecc *ras_ecc,
 			 u32 rec_idx, const u32 num);
 uint32_t ras_fw_eeprom_get_record_count(struct ras_core_context *ras_core);
+int ras_fw_eeprom_update_record(struct ras_core_context *ras_core,
+				struct ras_bank_ecc *ras_ecc);
 
 #endif
diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
index 53dc59e4de0c..b809a2f21d73 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc_v12_0.c
@@ -373,6 +373,9 @@ static int umc_v12_0_bank_to_eeprom_record(struct ras_core_context *ras_core,
 		ACA_ADDR_2_ERR_ADDR(bank->addr), ACA_IPID_2_UMC_INST(bank->ipid),
 		&nps_addr, bank->nps, record);
 
+	if (ras_fw_eeprom_supported(ras_core) && bank->ts)
+		record->ts = bank->ts;
+
 	lookup_bad_pages_in_a_row(ras_core, record,
 		bank->nps, NULL, 0, bank->seq_no, true);
 
-- 
2.34.1

