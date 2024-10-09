Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C98BCEDD89
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Oct 2024 12:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B00CE10E286;
	Wed,  9 Oct 2024 12:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cQEuIcPT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 880F310E286
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Oct 2024 12:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xG/2kNPtbsHNssnntlxnlBIX1mTmh9d0JTnPtLvsmvvlenKoAT3p54WhqUqxRBNF6he5GVg92YcidxZlADO0D+3xH6icexNof28acafTJeIxY2P4YwoFj/fRHY+IZoNDy99BkFYjZBku00h7eh9UXrpWXaR0Xjhii4Dq4phBC1VOIPZZLoq466aTDtR48VgfU4Rck09LLsaS9X28ONDNqc4CHwep2WxBCY8DtG0rSCeRrvXfyBAnWWVfELzswqeme5o2UXBF+UwzgCXQDWddtGgwlgiuOXzNEg9ZqJH3oOncOVCEyCIA6RQC+/aXaaGE1JDtN7n1HR4nU2DUVhMhMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y5mcY+keA9QFqYIi31YOmYC8RyDL6HtCMDkYokQQnk=;
 b=m5Z3gn9owXFC1hanxOCiPUNPoXKIgiX3O6BCQdWEQhCxOUr0ezRtOnnlQqhZv8QzJdjGkbU7j0p6gd/potYeRi+Nn/6tx0NeCc/qkw33nUHdZZStSIfsWO7ny4omTI3IbFW0FsIsdv9w7LMun9PFvrwTZoM3XXQut7q7BOPWmZhN4Qu+OGA5W+Vyu+OsWTdUT/Y2zMd/piB/4t+gQ7+62pU6MPi0qfx2eIeWfm7Xdh47jdO+osNPoOCtF5IRIsrKQAKgUAYJnaAMOwDgeHh3x9VGGXJtTW0E7UcB+701vP/tbMtVdGPFYEdnzToMdF/H95Mp14BcZzAyeSaf6zzOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y5mcY+keA9QFqYIi31YOmYC8RyDL6HtCMDkYokQQnk=;
 b=cQEuIcPTDRDeXfwZLZgbXTZnpiiJ9StTbosBcQk59Z2AtQ9hSxjxNOHAYkZpANhSAVuA3fMoWyaoPE1n52aYg7pd60IB2KWgK2HrdaogIXh5uPTCfFSL8wKf6/rUumjydkrQzvkbGVk6DGga8pV/RtiqricLlFOQ8LQ7f9bWHzw=
Received: from SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) by DM6PR12MB4041.namprd12.prod.outlook.com
 (2603:10b6:5:210::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 12:14:38 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:805:106:cafe::ae) by SN6PR2101CA0017.outlook.office365.com
 (2603:10b6:805:106::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.6 via Frontend
 Transport; Wed, 9 Oct 2024 12:14:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:14:38 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 07:14:35 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Date: Wed, 9 Oct 2024 20:14:16 +0800
Message-ID: <20241009121417.346166-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|DM6PR12MB4041:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6d45c4-52b9-4fb4-bca0-08dce85bf251
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WIsRwLcWPDJ8qI1MjP2e1cZmq272eGUdNBuGMM36saqX7nMgTQP32Jxukad/?=
 =?us-ascii?Q?W7E0HBDnJD5+umFNwKSJr8Mgp7EgPzTpJEiAhJJlLy4AllhFae4mVo+7JAnN?=
 =?us-ascii?Q?9sPzjfiW5oSpmO03X5XReAV8DVgKmy2GZzcJOqcfkVLCY5FHqqysAsWuGtf4?=
 =?us-ascii?Q?HH5vcevr/R+Kb2SqDYcPmgqPggvHjLUXfyGak69q1xjPpxM+U+URv1AQdyLz?=
 =?us-ascii?Q?r+1qfYPxBX6dFE3rG4H4alLxXBBDlurhf+dQx/mTNVivtDwno5j8+YShejmJ?=
 =?us-ascii?Q?c8E4HDNDGrsXnfPXDWZQEyY6qPG1Wwo7rUXUKmCXIWcpjTZY9gzdsg9o4bx3?=
 =?us-ascii?Q?IRDKijqz90gZMM+W7XqO3NozLiu4WTfrUWr7LWaoa+ZoTbyxQjbETTMc1fKr?=
 =?us-ascii?Q?J3HlDbRZmEkCOD0qCAdYexHNFh3bU0KSc2zCyOCOTWhda4eKHwnw7pjpEZ7a?=
 =?us-ascii?Q?yXykm3R4dDTBcMxZGypcMFaPqLFBJ5N9Kl6bSpJ1yhN/0IfSC1LLp+V98VTF?=
 =?us-ascii?Q?3Wyz4cJ60ax+ZqkYzSQHCW13YzwkioGDI+wHJbzIjtFGvv22WloBHprNpcav?=
 =?us-ascii?Q?B7zfvaw0eONOh7sIAK3eiW9NzLJFJZLfspPsX5NBcJNAo2xhlMf+vVBaEkG2?=
 =?us-ascii?Q?mEV6dXlh0Oley6SBGjkIs1LOEi3s5FVdN/uJdvMWPgVbQ6L1vp0BHxp9zyw3?=
 =?us-ascii?Q?kkL8Mlz5w4B1P60SfUIXRkjthufoj9J1Ni6QdfSwYK2n368L404wcur2gnUV?=
 =?us-ascii?Q?6kh+w+KbectrI7O25Jxu9z7ImmDIkz77cGOdzOrdPI8+yRCsXHjEaLrnLDpW?=
 =?us-ascii?Q?6LNKhb1r2gGAQDYMmdsi/KwQP7zVfZp9fJCvXdi0wB2DMMgv4+OLeDbjXjsU?=
 =?us-ascii?Q?RqtRQt19Q1+/12kzLG0R4PxwyNCueS/PTLBuOQkeK4Pu+latd2kqPHitwZKV?=
 =?us-ascii?Q?g0VDx3NkMMUrBo/5QMLucuu0QIFhOGmX+nAVXmTzXoB/68iNo6yZE5zcoL3g?=
 =?us-ascii?Q?dwZgkRJQsxOkQMNavF8J8KNJ3WKV7SoIWo/dQS2awefBwI1tmPqgf/Y+bNRs?=
 =?us-ascii?Q?e0wf4YuyJV17NaBFhTD9dqMquTAp03GpPIWa2rnQKHfDnOrXzHwcQrRLloQA?=
 =?us-ascii?Q?7H5UkuGuhTl837ZbFZxHzOD0vIbuBZ9ydPTJYVh43BQbr5vxbb72qhCIwLFs?=
 =?us-ascii?Q?gufzDuNX39AAaQNbNZvaAds2LPIdo91uspXG/7Ih+XAkVMgS+lifQ6GPwmFJ?=
 =?us-ascii?Q?xh0u84pMVCtQtJTbHgXkaT61/Vq0gc9MU2q9o+oMFcaUNCeGeZDsYs5kMJk0?=
 =?us-ascii?Q?mXhs79gPWNWCUix6TE9PqGXt6BPFrmUUfenmig/RcA1NOREUIUHPlqQ4qWXs?=
 =?us-ascii?Q?5VWlFnAHHyzusVbs+zr/IJz51DeN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:14:38.4097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6d45c4-52b9-4fb4-bca0-08dce85bf251
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4041
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

Update pmfw headers for smuv13.0.6 to version 0xE

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 822c6425d90e..0f96b8c59a0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0xD
+#define SMU_METRICS_TABLE_VERSION 0xE
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -231,6 +231,9 @@ typedef struct __attribute__((packed, aligned(4))) {
   // PER XCD ACTIVITY
   uint32_t GfxBusy[8];
   uint64_t GfxBusyAcc[8];
+
+  //PCIE BW Data and error count
+  uint32_t PCIeOtherEndRecoveryAcc;       // The Pcie counter itself is accumulated
 } MetricsTableX_t;
 
 typedef struct __attribute__((packed, aligned(4))) {
-- 
2.46.0

