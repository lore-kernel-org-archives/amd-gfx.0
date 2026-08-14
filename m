Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C579C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A6910F717;
	Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e6q8lcB+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF8610F70C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHb9KL5OhUYGUSHLRkhIjI2lsCbsU8GRaThjYsKkNtP+h9XEnf9ISozr2ZNr2gceKxod4JI2vzNYgjOilkxZq8ioJkUwqZ3sAvNKtfb8/PR35fzhQ4OEIgkzAKx8Om+DR0KnnclydVR5hDexxN0c/plPLO7bWvd2zrnUOf/H/5vdNf66zdVH0DIXz7IDVslzsWtdfBAOdaCupk9Lt9PD1UTiIz7aqtfB8k9YrQNxzVR9r01OQHaH/tnRBjS3CwLEDCSiGb8s8vFnL8sTWFnHVnDoT8YqbaQHbM06OdAXomags7jAturFvi/+ls2jNgxANItdP54SNx5GFbLHh8Mqcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GT+1PqtwL2SeYJuQMz+FhYUOWLdKTVygt6+kr4Nyak=;
 b=f+QVcck8zhumL/FAr6kGc4Wyzf8sHtHWZOtbH3V6t9x0wd8O3STbqlMqnE+3hQ/bQ7yV0k1P6w77XaUT2BNjJNMm+zoDxb7Ov2/QPDNtKxd94Usel8a9HS+vGtAN3Nxf8N2whP4QXKqfroL0zkTA1rIr5B4UY2ZIP1GgnSW55PTjhz7SY07yTqcJVD3HAMmp9mF97azGmQGwj7c8IpzRWa+Dt5RYUPh6i+dyqmks4IBlwKC/u5OEemSIeDQP/z/Kb3zVIkrsu9buWWFbqBfOGOYOe8umfxFXlcfntxkeupKnD0mPqqTxihpBYU2tr/VH0XPGwaCqQfiYoWMdgFllDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GT+1PqtwL2SeYJuQMz+FhYUOWLdKTVygt6+kr4Nyak=;
 b=e6q8lcB+TbhZImSWKv8fFIgfMa5XblxoSd4VvP91aMTKosvngRimuXoMkQ6egJvx5jseXxsvLcZ8GzqMP6zvDC8p1bEmiovh4YD6iM07aHpLJXiDTNrHDMAaAEokk4LDHvoWUCwWETix/QbLYFfEYDfh2x4Tu6oRNGWvonUsylQ=
Received: from CH0PR03CA0352.namprd03.prod.outlook.com (2603:10b6:610:11a::21)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:38 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::74) by CH0PR03CA0352.outlook.office365.com
 (2603:10b6:610:11a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:38 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:35 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jiahao Li <Jiahao.Li@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 062/109] drm/amd/ras: overlap VF RAS_CMD buffer and legacy RAS
 telemetry memory regions
Date: Fri, 14 Aug 2026 17:01:59 -0400
Message-ID: <20260814210246.3067612-63-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fedb513-8fde-4b52-df8f-08defa47832e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: DSYxHYcemEriBsfwzTZZRYAuJt1/OU6Gb5qDSQFXsLUXePgykb0sfPg3aa4Z7dzat4zxQlJdp+dzmzn8XKnO9aV4aAZ/u6U9Bo3kcjLqfS90BZH0z0ugCKdLhePmAqaqJyUvymuradTXfi15VjlqbTpefi2o6qSs6N0QXP0x98si5OflmLC2svn+sXSzuZ81JFkF7mjIsrfe+TXUeHYTx7HvRIpN3+qBdLPTM5saaUh5kZgb1fIRaUA3oikqNvYDD02MZvLRte1Bye1+ejHAjRcjsRxmeyp7e+QwRFKs1i654heXUyvBt6HCwf0d2cO2bxh2PK07+xyyxo9qJZk7WNFHFzgw9jMRC/cg6U1dIsJNVX5zURvVtNuMTQHWHgbWTBJgs4rxm6IM7/N+krh1RRjMTAKWafHt8pCn1d5UKSQhxue97U/LkfIOrztmaPI9HzXrySa81LljGLzBfZZxk+yvJReWuPGL5QPcz25Z8fS3p7oIUEGV9tz8qLsH31tUCQwmvYWkp9Hh6ibDuw/7Utgd5OVZ04ItjD2jTYBMiqb29tVWpIIXPURMryqPDoRAWCLmsy+rWiQB4oxayvsVbBWZQ8vu25DQZbMM53S3nYo13Io2jZ3O0czcovLA8flB8BiUxJRbMOS6sej5DnALbk/CSaSIlZ0WDU+hDwCnvks=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T9TyVgAjCnPgFUKgq3DHF6s4s+zzC1SUv1UH+K4WYPCWfgFr0YuIgQCULcKiV2bNTaM61eifLid4jjXnNCHsDl+/nCGaW6P4ykvsAzmBefRadx7+4R5dvFn93K8F35H3g8BsGfgouF817eGcTp187S/bJ8Kyu7YUoNozfU7kFhWNcgc/Nwjks7SyfuQI59WXHcqFITi14jbot9wlmDER4G38QJmiZxkpNwExNu0m6KdI+7kUNsXuwmNJhPDEuYTrPN/sStPd6Xo9K4utOf0NDDjxUbWIlbZt96sEs8amzMNsnGSikvihSsdDb3pNGbF0pD8DlZgbvgsQB9+OUTm1IsPWCe7tfE8E9HW657O3neMH6ELnTo5caRWktNNEfhLAsGkUb01FVRBgJHZo/bhVzK6Mwg/PWee61DbdebyHG40IAzURfOxsqJseHT8RG9PR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:38.3147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fedb513-8fde-4b52-df8f-08defa47832e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
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

From: Jiahao Li <Jiahao.Li@amd.com>

Share memory region between VF RAS_CMD buffer and legacy RAS telemetry as
they are mutually exclusive based on UniRAS state

Signed-off-by: Jiahao Li <Jiahao.Li@amd.com>
Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 22 ++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index 33421ccdff04d..8cd26ba55e6c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -507,12 +507,6 @@ struct amd_sriov_ras_chk_criti {
 	uint32_t hit;
 };
 
-union amd_sriov_ras_host_push {
-	struct amd_sriov_ras_telemetry_error_count error_count;
-	struct amd_sriov_ras_cper_dump cper_dump;
-	struct amd_sriov_ras_chk_criti chk_criti;
-};
-
 #define AMD_SRIOV_UNIRAS_BLOCKS_BUF_SIZE 4096
 #define AMD_SRIOV_UNIRAS_CMD_MAX_SIZE (4096 * 13)
 struct amd_sriov_uniras_shared_mem {
@@ -521,9 +515,19 @@ struct amd_sriov_uniras_shared_mem {
 };
 
 struct amdsriov_ras_telemetry {
-	struct amd_sriov_ras_telemetry_header header;
-	union amd_sriov_ras_host_push body;
-	struct amd_sriov_uniras_shared_mem uniras_shared_mem;
+	union {
+		struct {
+			struct amd_sriov_ras_telemetry_header header;
+
+			union {
+				struct amd_sriov_ras_telemetry_error_count error_count;
+				struct amd_sriov_ras_cper_dump cper_dump;
+				struct amd_sriov_ras_chk_criti chk_criti;
+			} body;
+		};
+
+		struct amd_sriov_uniras_shared_mem uniras_shared_mem;
+	};
 };
 
 /* version data stored in MAILBOX_MSGBUF_RCV_DW1 for future expansion */
-- 
2.55.0

