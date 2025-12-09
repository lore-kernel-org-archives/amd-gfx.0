Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52746D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 08:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E87BA10E4C9;
	Tue,  9 Dec 2025 08:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y+Gugm9I";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010050.outbound.protection.outlook.com [52.101.85.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D74F10E4CC
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 08:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gG00I6RgPhiGwkllekXdIQ/JGOvXecJG5nlm7OIrId7yQK5Hzo7OeQxUXUt+/r0eQMdFyZZ8PTIA/xkP/xaqP0x8x+Jb6lE6A86etT/mjXl6Ye7D7xPrx2Wrs6PlTyEARNK6G3HMIAvpu3Q2mUoWhKREvMGdfsaIQBItu/qqRuAPrbkitkRCqI27iV3z8gkVwgDIdzqmsUa3nBsVdUz5hwUXEvg7Za9y3zr/4CEqQRzlqEddHD3PAJJL6SkPSn4j5A/0qpN2xJ6XuW4m0bMB3r1T9WyJXBAK/qnU6R+CXOJ+gkBxLfHaeuuhV18JLLHVqiRXuILrdkcEcWq7+UhFjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ki2FzIwkirqd24E+32KekjyZG1oLl4fvWGIBB7Yx9Eo=;
 b=sE9Jpi/PXHB5Ry3TZQ4QdQtreOSFY2zOhYUSHWMTNkXC5n4GdXYr3ECHcgbl5bnl1NdMg09xoUCfGs3nLovZHqXsfYFphCymw4RosgNvLxL4F5uGZtcGZKlMvuIZg6PEvglPnUF9m0ZLSTee++b1K8cyxNQp1VxqQYtY8TMa9gmOgNmKBqwWxaf9xgKrUeP42ujKaxiSfwnfxxNM4WBDiNbVqeXN4Gt5j08h7NrOLXsrI5GVGZqnb0IT6R6wWVye7/8RQXLdS85CqldpF2tWcjVSW+TruBDjGUMILy5eo/L0KlNl+J61JAvghuCXoKLwvHPTrG8e1h3Urw0IHQX5uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ki2FzIwkirqd24E+32KekjyZG1oLl4fvWGIBB7Yx9Eo=;
 b=Y+Gugm9Ir/ob/cNVwALEyA1ZK/rkLB/wjzg2CroRHWFhgYkMx87Awq1Nobj7X0acYbrDW2zkxp9ocHTXwPPrY2YLhEzXVNeBibZ2X2v1kvxm3+PfSsWinB4zfd10sm7SfLdsgB6JR5Tou+8g6YDP+DKiCnpcaT8HdHilCNkthIE=
Received: from SA1P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::15)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 08:57:45 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:22c:cafe::87) by SA1P222CA0023.outlook.office365.com
 (2603:10b6:806:22c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 08:57:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 08:57:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 02:57:44 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 00:57:43 -0800
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Dec 2025 00:57:35 -0800
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ray Wu <ray.wu@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 <stable@vger.kernel.org>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 03/15] drm/amd/display: Fix scratch registers offsets for
 DCN351
Date: Tue, 9 Dec 2025 16:55:06 +0800
Message-ID: <20251209085702.293682-4-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251209085702.293682-1-chen-yu.chen@amd.com>
References: <20251209085702.293682-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: ad329338-19e0-486d-f740-08de370104b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e8jCMH9p4NuGVqN+l6R8tgAD/zOz1aBXZ9SSCdlowfXhsfjHAvqNlgbgnOOC?=
 =?us-ascii?Q?dmvZKSMRwumTXaeKGrPqomcmvY+l18SuIsWniEpR+xVJeji9JQm6FSL4pQIT?=
 =?us-ascii?Q?M/T4QVC7b/ruXyPjP0niDGidkDQffk+iwbj8XjWYAjjBHXPNa7C7YA5nKpcd?=
 =?us-ascii?Q?07NH2o+ACbGwl7TFs8AO6x4w/WszyKju+5/0GHGp0P1OM4L811+ujeKSs7/q?=
 =?us-ascii?Q?+RKXlFOV6Oufb5wLEmzJMeX5WifLL6n8IlAy9v5/2ifKQVdiNOIBLI23iIle?=
 =?us-ascii?Q?1EJR7LbmD30mvH1p64X+gbkXCUBusVSmcw+nMRPrX82unzWk+6EKKY/jLvqd?=
 =?us-ascii?Q?Ok/CtNRXyn/S4bYHt7CLK6U8UyWN4ZBESoEHxdqIGWp5YQJDyBBHEHoeiBcr?=
 =?us-ascii?Q?ULh+soy80BvUBeRCond+BIFsFJvsz4ZXt2gcd3s3puVTS0NHbe5outpGB8xw?=
 =?us-ascii?Q?PitL4K7TGDoKiHvyO2AT/M4Ho4TG2ciuqZRtSh9nmKJytvV/Y7QE91fFFic1?=
 =?us-ascii?Q?BZrMPiNzCmiehzdLWRU0SkmnV/wXRmNpNMVM6LZ8EQ87w5koPd+yrStD9Lkt?=
 =?us-ascii?Q?EwYvKvas8XaByfFV2z3+6AnASdAkQ2gd6ObImKxhffub55CKeTCITuAOJ834?=
 =?us-ascii?Q?+UlioGCk5yI7hRI+tuzmR8ty+GsTSaumRARJQjAC542Hd1RBHbY1142PPbNG?=
 =?us-ascii?Q?fXtQgAxn/2Sy8UFQewZ7ugbGnDqUXTX+1kXvjqaZcQpZzcjguwYo0y6Spt+b?=
 =?us-ascii?Q?4d8KvcAh9b5qtOxTbHRPSa4FDUzjP7B4lRCAn8Trc6X8vqdHB1cDqLHAvMBh?=
 =?us-ascii?Q?LOumv8FpKCoRKy86tcjpRd54zKA3W7Frgyp0cUHXsaRLMHQ93dGlxqFPAtYp?=
 =?us-ascii?Q?nfr9R3DCbuto0pE/d8UE0D+RfSmj4TmZXs9ClQwHIWFU4K62lhwgBhOKzxBw?=
 =?us-ascii?Q?bmQNjkSxxO0uuFNCZ/hkkALD0AgMSBFoNTH2XBBwU8NSYIxnpbiKPClbSLTj?=
 =?us-ascii?Q?+gDh3z4FBGjZhm+YrTC/TU/HKAohsEjQLp+dVldDaXF+W1Q77RyoXJGrd1dv?=
 =?us-ascii?Q?t2lGAIJC99R1t15tqNF5eNtKZWeux5Y5VxuBnzDOqjCSZ7ZjBJICktQ0K+sZ?=
 =?us-ascii?Q?ZwxjFm+jiYhiSkFIBxjZwSZfHZagc72J6lCJ5YNZF7uCf2jjy8cvcOAVNepL?=
 =?us-ascii?Q?lRogOk7gY0uEvcSyUAFKMTQqbnSYP/3NwWo+jola2+BEwCYzwuFa94yRs1Wp?=
 =?us-ascii?Q?W3O7qOZiT2Gb0EhrdvNiNVC+Ja7xopNGpLHJECxxyBm3JPLk+T7AUZbkDBRj?=
 =?us-ascii?Q?QCADuh6cvAjBpjKaXdsoLy8IyfQRfpdsiQEyzOlQryilQF8gkhZZ1kKoZLua?=
 =?us-ascii?Q?IM03bpbLd5NWlGctY1Oelei2ikee6txlRUuA09y1+172gY9NMHYTuXZLnoYg?=
 =?us-ascii?Q?2W9MDhm+ZuSgV8sMGEPa4nuXJk+UF/ZFeyxuxB3LYGL2ajS48CggxWJN+768?=
 =?us-ascii?Q?12XZA0yUM/cNUUBsP3t2Q1sS7Z1W1ll3RxaXisV9VEFo0K8ds12QkLYyHVHy?=
 =?us-ascii?Q?Tob5pyyZS0BBun4wH4k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:57:44.5817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad329338-19e0-486d-f740-08de370104b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
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

From: Ray Wu <ray.wu@amd.com>

[Why]
Different platforms use different NBIO header files,
causing display code to use differnt offset and read
wrong accelerated status.

[How]
- Unified NBIO offset header file across platform.
- Correct scratch registers offsets to proper locations.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4667
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/resource/dcn351/dcn351_resource.c  | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index f3c614c4490c..9fab3169069c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -183,12 +183,12 @@ enum dcn351_clk_src_array_id {
 	NBIO_BASE_INNER(seg)
 
 #define NBIO_SR(reg_name)\
-	REG_STRUCT.reg_name = NBIO_BASE(regBIF_BX2_ ## reg_name ## _BASE_IDX) + \
-				regBIF_BX2_ ## reg_name
+	REG_STRUCT.reg_name = NBIO_BASE(regBIF_BX1_ ## reg_name ## _BASE_IDX) + \
+				regBIF_BX1_ ## reg_name
 
 #define NBIO_SR_ARR(reg_name, id)\
-	REG_STRUCT[id].reg_name = NBIO_BASE(regBIF_BX2_ ## reg_name ## _BASE_IDX) + \
-		regBIF_BX2_ ## reg_name
+	REG_STRUCT[id].reg_name = NBIO_BASE(regBIF_BX1_ ## reg_name ## _BASE_IDX) + \
+		regBIF_BX1_ ## reg_name
 
 #define bios_regs_init() \
 		( \
-- 
2.43.0

