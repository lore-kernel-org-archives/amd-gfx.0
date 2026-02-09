Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2063DE81BBE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911E010E2B8;
	Mon,  9 Feb 2026 13:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ych18faC";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010004.outbound.protection.outlook.com [52.101.46.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C76F10E3E9
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqggE1/MbHsUK+YYMVr8X0tCLhz250SA5PzImx9iTBi99DINjQAchnzXPAxIL06DjuhUqp/3l8n8reKrz+5dK3bWhXMOUNratlvleWmu8glsqoo9sXLMpdH+0WT7gudLrYZGMSqaaM2LTzn0dt0QaGF1ql1NdJQhOGVsL0rPxxnL5eMoS61I9jQhs4qK3MPckfctyU/gS4kPhiOwkykDYJiZ08t5LpJ5g8rpV8c3yP4tSqUS/6QeVdSGo844ruqcVD6IiCcpGG8bC3Ik/DKSSEJLZT847QoIUt06bXGiukUr/e94UAHgsGBH0rJHeWloZdIJT/t+9Vjmd2If6ScI2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdGBfM/XAbB6NC0deKXaytlgzTGiDyluB0cJyAfaXBk=;
 b=Hgg3rPct/aOni50XrmpP/ww4eBbKhRbM2OxwWHX/e8rLaF2ku3eTTB3FzR3Xtlm+8T/vB1MK7yi3cGxPp5rEko8N5gOJqOGWLvSKMmdXScU6qKTHiL+k8YgNYDiNlxB9WML7vGGj6cVUkzPEYP2sYiwSaiEF1NOnxWgQ66p2TZ7q7XzTF0Cy/8Jn0XrjEex3zyleaPY4lhtS9p7fAJFADS8dukI5UwcSompLCIBr8MXVsoTTW9Kow33d28kW+DvW7WAW3G/6UN7ejEO+Iu7RfGGObisxPX+nWAI2kOb0YCcyzEy4y7s47maesmctAJh58FWVn6qixGqLcATDsETrSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdGBfM/XAbB6NC0deKXaytlgzTGiDyluB0cJyAfaXBk=;
 b=Ych18faCVVdglphyUg1+2MnmzWH9LJiU9WISmarIKr4kbUxHcuJ2YRpOCz1S02oe6V+hovWVCir4fkvjg64z+9KwAqDdUbLqu9tO23RysSVy9gr7QdcdM+OXC6Br84o5j8mfPnjBFDra61keWEk5lq7baEtU9v5Xwdp16I40auQ=
Received: from CH5PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:1f1::7)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 13:04:53 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::9f) by CH5PR03CA0006.outlook.office365.com
 (2603:10b6:610:1f1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 13:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:52 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:50 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 08/11] drm/amd: Drop MALL
Date: Mon, 9 Feb 2026 13:04:10 +0000
Message-ID: <20260209130413.118291-8-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
References: <20260209130413.118291-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4a04ba-d430-4261-f93b-08de67dbd060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7ZnkdbfDY3ucQSTqBaBpozJV2bja7VApC0In5QdG1zg2tYIr/sc43CLBM0wx?=
 =?us-ascii?Q?RdisiAH6GPsffva5dQkeGM9T/YIeWGuCKAWP4E+COG7tep+p2aCAxkbcZnxV?=
 =?us-ascii?Q?/dDFd3id577ty2K2+/6bCoj5R+SYJVrUJA1zvrwlrhLDRgGW78oI5B+ZDqIl?=
 =?us-ascii?Q?X2KV0/rlUylTo9QCA4gVLzwbi3WVsQzesoxKW9VqOdVXZaUrQnKR/0xY7uGQ?=
 =?us-ascii?Q?9NRL8p/YkEYFpHBZhYRoHb3dAl0a8KCTaQ7xhRkt0bVCbZH5EnRlQL01qG/w?=
 =?us-ascii?Q?ia0zFmbSxbSTs/M9tG/tXcExPreGZSEXAetRvBB6c5mrBGdKvVk9YBphYijN?=
 =?us-ascii?Q?8ZWMIssBzlU3ri1g3NwFMG1R6n3Lz7RpCbgn2Z15vUbHKnKyMOnDzeWe8ihU?=
 =?us-ascii?Q?b0KAKkOWbliScI12gku+ztSY65gvN5ewOk2lzbj6zyX2/hsTyc01fCcR8Q/o?=
 =?us-ascii?Q?nujTaVqV2zgbQwZeomTeVZGxRC6K+yWSQwi2iaHxHv8P7b+5xATC/A9W1pDU?=
 =?us-ascii?Q?dxPUBKi9E07pW7YCWqzcWguGEkCD70NwsV1TRNcf518DFACwpXWL+nJEXxFR?=
 =?us-ascii?Q?msOI1fph3+na6ukb4QpREVKFfp7MO1+I3mKvj/bXrtjXumgeE/s9jWNOCRwg?=
 =?us-ascii?Q?v5sPCFKzqKVzzavXrKbVAQ6Y2dcJhjVTcumamqkzYnsspPp39YjZSCjOyHHq?=
 =?us-ascii?Q?yL3mAK/D09mfXHx1UB+EjbGEkKaBaVswr5W29sYspN+QZ4msjH+SDH0e4BJY?=
 =?us-ascii?Q?mx3PIixmWtOptBKUeLnvzdvep+q626fLK2TTc/RFqcZZps6bF/dQ80rt+VD+?=
 =?us-ascii?Q?esKjgthXhA9iz9qLVtQEh7UXbQE5uEGKLXU0zlyiRAo8pwIQaWOsaA4z2YHc?=
 =?us-ascii?Q?wGcMm2xbkd7yxGJtClfXOJRgHBcNAkw2bISrdn2dDSEVXkkHv+PD+4p/2ayc?=
 =?us-ascii?Q?1EkeEFUwjPvVFbFimQWeQ3Maf2EpeHKo4qNtb0rHq3ad+8iC5ad+B1f3CstJ?=
 =?us-ascii?Q?IEgivBcRtZJDIL0bZ94BO7gX/wVV+3MBwqkAq10qq252/vcBoLrUQd0qdp5B?=
 =?us-ascii?Q?2BqvxTrULfq8y6/+Vu2NyYhq7njS7euliO7n6M8zyCkiasufQ0ZXUHJAkk2G?=
 =?us-ascii?Q?3abWX7m0dY87R9M4mYZBArnV0p2XDXbrqiJBFriTZBm/YGoCqUwEmuh2qi6r?=
 =?us-ascii?Q?+ZWDlOKJCWo/zpTUeqdcg4H+/m8opGPQnQXnWcVP+nI6bPGvjq0kIQKrJW5S?=
 =?us-ascii?Q?hM21Jp51hA06GeQNaRH5NEVzED8M6quFlf6ox+UO9H+EOvyecmp8Thv0VmH1?=
 =?us-ascii?Q?6eIgaykecsfNcWS6n5GgvmWbZU0/8GowWVM0Dsp7f8wV24yeQsq1tzWF811F?=
 =?us-ascii?Q?TiGpCOdcDwnFJROZmFHV8s51BH5R3zqWa+cpWyYImUkr4O4S7Ut7tPc8cQDO?=
 =?us-ascii?Q?onlzXUnyKEDWYM1f2QAloU4+cLWCkUdDoPkBgsdU9UlywjKR0DAq1xuYZqxo?=
 =?us-ascii?Q?ODocqdg+qA3eFXZArE5CxU3JkdMY7CCPMv/PwU0b+LGRGQDIGuZltbp47ARi?=
 =?us-ascii?Q?5+8NTkGP/2ppyCElvgcE3DLXazBUd4wfYo1ROmWEOGIgV9O6Gxgn2Z0YXuwC?=
 =?us-ascii?Q?aOouc7tEHm0q1Jp6xrrI+RssLZpK46RSSPUTOPJ4HKGOOTAECgYOK4+9L9+4?=
 =?us-ascii?Q?zC53YQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RmoIccbFTOG4oqxVKYpfOmEYQrdFVFWUIhGj+GVXWWzsn1aciSvQTgkCcTWTOBbMRul7CjeZhZdSz7ZLN048gRoJDwYu6WYBd3RrZ/hq3XUqcEjSA3BhyWs9xq+rT/4syuEdB+zXURASxXbMxxWGodJ894ONAmnSLz/dChWH7zREtysLLFlZCSfbLRIybcC//VFuqybf9evPAOs5YX3HgdufBA1ZLIvlUYNHJVlZxS/2yUrlB2RNRzfdAviggcBCMLE0HHi8h9rOBJ4/MSaDeClWCjTk1QQprUtrPlT0rxbfsjveE+EDOxCtxayzihQ4x0iZZg6HtNE8/01jAou0qvKhVy7+8+xTQ1ITYPCPTEaOeCv76CxktooQe/3uKfebz4m8iQTa/FJQKGwQThED1stFhVpld+RZqs98CFHoX6277j/cDKATFDZoFlDUFhHD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:52.4164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4a04ba-d430-4261-f93b-08de67dbd060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1
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

Not supported on SMU 15_0_0

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c    | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 5260de5344ae..72a78fc5c827 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -58,19 +58,6 @@
 #define mmMP1_SMN_C2PMSG_34                   0x0062
 #define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
 
-/* MALLPowerController message arguments (Defines for the Cache mode control) */
-#define SMU_MALL_PMFW_CONTROL 0
-#define SMU_MALL_DRIVER_CONTROL 1
-
-/*
- * MALLPowerState message arguments
- * (Defines for the Allocate/Release Cache mode if in driver mode)
- */
-#define SMU_MALL_EXIT_PG 0
-#define SMU_MALL_ENTER_PG 1
-
-#define SMU_MALL_PG_CONFIG_DEFAULT SMU_MALL_PG_CONFIG_DRIVER_CONTROL_ALWAYS_ON
-
 #define SMU_15_0_UMD_PSTATE_GFXCLK 700
 #define SMU_15_0_UMD_PSTATE_SOCCLK 678
 #define SMU_15_0_UMD_PSTATE_FCLK 1800
-- 
2.43.0

