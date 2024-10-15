Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1331CFC274
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9584E10E53C;
	Tue, 15 Oct 2024 08:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nsUNvOPf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24E510E53C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 08:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPSPO7jPmR/aSY/jTtoQDZ7adPhE7ISODqAKGCFlv+sG4Rqs9iDXLqKdPIzonm0HCxV2jRSoMMg41eF8AsZiSqcNYijhWhzgRDxRn3BrWgECljowbG4rS4MEbK1DXK82c/6vVgerJCyLyileGuJzo6NIKAN+CmUhX7KUTxFvnZkj7BEhtdJhJvCO1/xM+WOrvAbsR2pSOgtZIGRFearYixaxmWHzu8lIUwrcY5fwEXu4UqksaY5IJrcW6wGMIwDlsPJBTuMjPlHBlmKM1oJTc9ot/C77qWubjbHvVZvqPao6ybYJlwQJmmZIqzyHIE6K6ecmktae/J3uc6QpeAQ4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8Bz4vqlAaMqGWKechYNx9Sp6E2C+cWNZyVqBtdAI88=;
 b=IzDVho7dSR+hFTfxPoEUPZ70fpRJHANjDEgoLQT0xTHWOaWdZI1oE4YlWSlnEx/N8CfDYVQ4wKEk7f80Ga+AjV39MmcWqXGLg54w4k8L7m/aVbmN7p1g485CRMAH5rj46pQmc+AbNgAQkXc5Au22vPGOkdhVOjnr3wsf3AVg+rbfv9fzGeR9myUs006DBJICfEjnBjWWKlHCRdA2dol4Pn6BjgwGi8ROp4XBvyUXwHZpltuzYGJ9CVmdnfF6mHB7Vd/Hz3I3RhqV3LFHLIThkCnDLt6KWQx/P48Yfms2dEfpmnBcaoCXIwaVzqJMyiYV/oGOjy88wO7efJ6LSCn0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8Bz4vqlAaMqGWKechYNx9Sp6E2C+cWNZyVqBtdAI88=;
 b=nsUNvOPfqm8j7hgcRDc3uGLxQS3wAMSWnKdIVHz8FCbOIqlWbPcIjE1YlhFpUP0k6RgetKMW/h6acSOmnw4vVV+pxDQfoT3yesw6jqnwXMcPziMmo7B5rh4aoZZ1Aa2oJuwEU+JGGPcIvQLSdLKMd49f+SPRauCME1MjTiXR5QA=
Received: from DS7PR03CA0329.namprd03.prod.outlook.com (2603:10b6:8:2b::33) by
 PH7PR12MB9151.namprd12.prod.outlook.com (2603:10b6:510:2e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Tue, 15 Oct
 2024 08:18:23 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::1d) by DS7PR03CA0329.outlook.office365.com
 (2603:10b6:8:2b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Tue, 15 Oct 2024 08:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:18:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:18:22 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:18:12 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 07/10] drm/amd/display: Add a Precise Delay Routine
Date: Tue, 15 Oct 2024 16:17:10 +0800
Message-ID: <20241015081713.3042665-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH7PR12MB9151:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f0e2a8-ce2f-414d-5252-08dcecf1efc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F2j7tdJpa562zm42uy5utIFpNhEiZ5jEiPS2djtUmOmEBLwx6Un0Jkn0sUxD?=
 =?us-ascii?Q?FQORuZaTRJdjfCwg5PA/az2wavexSIKt+SOunyMXyabbFTx/OT00yrz3ccQo?=
 =?us-ascii?Q?2kiOCQQ/ET8g0qhRi5uId54bGh0swMAwqBKXMw73pcoaH2Q2qYD/mFE22oU7?=
 =?us-ascii?Q?gKHz8KHXmcheEfdNHIFKhGigWMdK9GQxJtQ8kV+2Vu+QLf3l3gq6VhiQN/Sc?=
 =?us-ascii?Q?iJegknXBaPSpQJ7jgLtvEbAZzQwvYnKVkr4nCUVRcjx1j8HmxmdbraH7Q5Zq?=
 =?us-ascii?Q?MMLbu6jl3NyDbLozotfo0MOjBub2j6qvm9PpdXwAAMgfTmZ+hKQW/m6l2cVE?=
 =?us-ascii?Q?k2u4rhr6VNZVoFYVabXWTCqKeEw+EvGtXzwsr/o0AbAfVT0/zGsBQeyVX/fM?=
 =?us-ascii?Q?2RUG/2isrvHllMNMroiSxWG5GVRhuyqJQejM5D9nzhuOnN9BgBCJGkkZaHjT?=
 =?us-ascii?Q?GVwmpZb506FnhIcKc2TCqsT+J6ctqfX+SoVFvoDEz/vobl0bxPcL/sJyDHNo?=
 =?us-ascii?Q?jkxtY9qqAjk53RGfblQHIpJhI+r1lc1mygpOAZ6ajil9k3jxy2sVv2NCmHDJ?=
 =?us-ascii?Q?YPDj8P9iIKJrISaWSdRiXLD6P98b4/DpAVLtJNCy1cT5ZdKVbiUkC/CfQtzJ?=
 =?us-ascii?Q?wmL7cxOQ13bkC8AJ4t0V3c8eKo18Hmpnill0cRLS8c59ATBjUuExnfsc1jaS?=
 =?us-ascii?Q?tYx39jAhGQb6oajw4YejLF/0RFyvdHWUEPMtbHTtsggenZpGgle7QpgtRpNh?=
 =?us-ascii?Q?be0zaZOv+TBV/Sj8AKWtvGsSgEBuWaRtNoJhL+lxmb1vB6m9P7jaZo8/8Cli?=
 =?us-ascii?Q?z7eXT8D8Z75BzWMIav9+i6wOnZrYfU5g1W8X4+DT8xJpL3hhzJgsXzVJ3YD9?=
 =?us-ascii?Q?4lzwwJ/lD5bPGA79Yi/FlKYHGmOP4R7OUGEnf/LCaM8tsC1Za53BH118oMm4?=
 =?us-ascii?Q?HHVzg9e1t4U/L5ILVi1ZpdNGK62BYr+aGboQHDG4NdLIjWyupBHMg4AduWWr?=
 =?us-ascii?Q?eAs2GTZljmc9bd2W1TTMZUXVbw8Qoew4TS13/w2/H7Yb500oOpAiYyuGqovV?=
 =?us-ascii?Q?kEQC5ySD7DIBdEoU9F6C5lzZ41JZv1/3xD98o+nQ2d+1Hg7KEryB+kDlAiZd?=
 =?us-ascii?Q?OBcjlmXejbiCbVID2lePKbFMwLviN/HKW4pa/NA6t9M4EzDBIBrgFIOMCJOV?=
 =?us-ascii?Q?fnigW/kKUtaKEaYZ0pPKp6iE2hwTsjXOkawqOMHN/IKhR67Lb0vICbm8TPXw?=
 =?us-ascii?Q?xQypGCssCMMj1JWJ+oz9x+6XrW+3vI75QNQCfVV0dynwNp0KUw+5Cn8qvz60?=
 =?us-ascii?Q?Ec3Ol45bAn54tavh2XglFV4U2l4K2aUATLTLqf6qrwzE+jQ0plLSYvTDw22J?=
 =?us-ascii?Q?9VpXdJB+yx4Z/Dkkgn57Hh7s8fCe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:18:23.2568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f0e2a8-ce2f-414d-5252-08dcecf1efc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9151
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

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Fix DP compliance failures 4.2.2.12, 4.3.1.21, 4.9.1.19
caused by imprecise delay on fsleep().

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index a42c56a57253..754c895e1bfb 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -272,7 +272,7 @@ void dp_wait_for_training_aux_rd_interval(
 	struct dc_link *link,
 	uint32_t wait_in_micro_secs)
 {
-	fsleep(wait_in_micro_secs);
+	usleep_range_state(wait_in_micro_secs, wait_in_micro_secs, TASK_UNINTERRUPTIBLE);
 
 	DC_LOG_HW_LINK_TRAINING("%s:\n wait = %d\n",
 		__func__,
-- 
2.37.3

