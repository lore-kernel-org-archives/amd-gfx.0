Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44570C02197
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:14:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD9510E728;
	Wed,  5 Feb 2025 03:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GC1gRQO/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567F810E12C
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SI4JdWlvbcNiIX+xkQ3re+r4Dh61LRN3Xx/mT+w404KBO36gw1En9QrtkqxfhVhTf3pjvx+yxugKoFEP/8BoSATsGyY0beoTLRUhttxTXvMV7CRxSEkt6wY1jXq2KEQOT/5HzM7y7Q6Dk3s8FNxnV46CvISR+e7Mg7NJ3DChorEHj10tD9TuOTVBi10N3oJlnt0jzCjv8ijH8nS62Ilpg6YFn1usE+GPbdI0kXqbYSAQbm7k/pMmc4YIv9c/ZT0mPvnHR3kor6b7wgS8KGicHhg1Y6aiyO1ptAZaYG+et3h6xcEt3iRPOwZ0JvtITLDAnPPcxQC8voqDV8rxUs9FDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4mNiD7QJ/BgLWOZQq+OY+ii7tGopeW6Ms2r7xLA4bY=;
 b=mXVKQ8DP1Z5+UAw6ygl1WrfwF4t1qG1+ewOgBxd5kCp2+lu59/m86C6SGNyZxlzXeOpFmBWDfgcQewVcGAGKzhq2cTn/UcZZwsrsHz5GN7E2WbaNZKAWV2sAVWOjh+KvTGY9bl047lsmhjhHv77T2IziP6GHn2yB5f6FpC2aq7o9r94samBzf3yECwhmMWJIiD7cHLiRU/BUyp7Nrbo+kIrK10/bdHqVhS5kBh8RMwgg3kBTSAVRBiamfJ7S1PnQBOpsX3LGG8VAaZrl0RVK6ms2ZbCDdwrQ/aPLp172MaHVEmmkeaa8HvMB23kzqrfAJop9kxyvieSM8b5m40mDzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4mNiD7QJ/BgLWOZQq+OY+ii7tGopeW6Ms2r7xLA4bY=;
 b=GC1gRQO/hm05UlzzeBHeeZUufJ2k25AEmyx75WREOXI2Zz04MxeKUYNdzynX5TzDp2JZ3r7GGnYENR2dZn5ySQ8n8R7N/vNWd0u9PnfOwPz2W446mWGXZLT/iziRDyCXIfD6mry09XQ26532I7bY2s525eNtbqOG3GGHYBCsjiY=
Received: from CH0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:610:75::27)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 03:11:56 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::1b) by CH0PR04CA0112.outlook.office365.com
 (2603:10b6:610:75::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 03:11:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:11:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:11:51 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:11:50 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:11:45 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Tom
 Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem
 Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Wayne
 Lin <Wayne.Lin@amd.com>, Martin Leung <martin.leung@amd.com>, "Taimur Hassan"
 <Syed.Hassan@amd.com>
Subject: [PATCH 11/12] drm/amd/display: Add DCN36 CORE
Date: Wed, 5 Feb 2025 11:08:56 +0800
Message-ID: <20250205030857.2608094-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250205030857.2608094-1-Wayne.Lin@amd.com>
References: <20250205030857.2608094-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aeb0c9b-275b-4759-e3a9-08dd4592d8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?faPGsEXp9KHt+I/vL+sxmp0KR0sooldGlO+tr6y20lIkuYydoX76dkBu0N+p?=
 =?us-ascii?Q?ufKVLkaY2bM1jbfi36ErV8/IdZEdgP43AKGLVfjJlbhCRPPQpbblLZMWrcZN?=
 =?us-ascii?Q?C7kK9YQsml/WZCN6U08V4pKZFS9O33S1ARm/rSLykUGG3HhaRrYWIo0sgqkX?=
 =?us-ascii?Q?9mht9RGQC6HjqjPXRU42sepgVe9rn0Yj6mTTC9xs0h5YWcJDYUcPTeHUGrjY?=
 =?us-ascii?Q?Tq9Y68s6auYxSQsM8bpX3usInUJfmDMqq6BUZRF9LibGZvbtgCsV91rcYSu5?=
 =?us-ascii?Q?h7IEDD+DyhwgY62T0czsOFViSMQBsG2r04vdwliImefnFynxjtRqpakOxwc6?=
 =?us-ascii?Q?du//8Fi0jeVUUMCoH/e2+h6dUjLqHvgktqUP3yzGDb/DrkEhrAJVVz2txue8?=
 =?us-ascii?Q?lREqpqdrVPqXpqGjm7FM/W/REY0+MTqmAmEl2kjos5rF6+3x6wUPS7Le39NS?=
 =?us-ascii?Q?9XTB0II3zk6Vsn8pdmBQX6ys4Ddeeefehgc5VB8FyKkKEpvwskloCIopduD5?=
 =?us-ascii?Q?StMl8uuA+iqbLi3eHvSqCyY1suGHJouAbk/x0F2QXVy/t5dqUpdHHCMS57/t?=
 =?us-ascii?Q?a5NkEHm5XORUA01i60W/4taJITpZSe+iJMCVYm7f7wJ2ngcVFI8Ibjha5u1X?=
 =?us-ascii?Q?SykYQcnDQQ3HeyUw4Wpo6Y8iEPWan5F1rY+/BvPZ0B2Ym5GSrq8QQbwyOQoR?=
 =?us-ascii?Q?fo3rFYjqiqh2dtC26h9ePWKUJM6H9Hnc1W0M0pixewLZqtUq2GFLXbV8dN/a?=
 =?us-ascii?Q?6O0rqTsy+7JdGWl4nr5MaO4SWu9TIEm3xTVFoFdyMG5BJ3N7SjDeyVL/C9Ek?=
 =?us-ascii?Q?ovDQeoMpQWcPYUFY+UdZ7/JJfsdXGBfiRZ6517wSuRI2/TgwFDYtV4fSXCtF?=
 =?us-ascii?Q?6TombRsFMLzNSeyqCOL6o4h3Us5TD0aoD1fbHedQ8E4vDPjS3tVPVhGnJzQv?=
 =?us-ascii?Q?lyMN/J7hFmTQ1fUE9SoE2bNUi8ZoIpMwfTm46vaXb/9xirqr6L/PPoB3OeTU?=
 =?us-ascii?Q?2eie8WHnTLhbUzwKw3OHhnN8QXf9pF1aog6RGvfBE85LI4Tn2vSmyhVZsXFF?=
 =?us-ascii?Q?J+4/UH6ML88aCUwPbnQg92ncuDnzQ0JsLJ1UZGMZg+Ot72IzyQJN+sOSW1GI?=
 =?us-ascii?Q?zHsPiMk4uL742daMpatSwYZWrOy87fupSyPAZoXYaYOsrTY1uhaNnWvG177e?=
 =?us-ascii?Q?RBe6tJTxPJwrHhi26/bc/RmdVO5vF6ltRqP+HTdcGvL2XskF8yV6JVl+i3SL?=
 =?us-ascii?Q?EqcbKUfWXfsIDSvVCMTklthW2prUgi9+ZbuaQtP6CGNpCP5PeGA/PPpXDKbM?=
 =?us-ascii?Q?JlM6sZDlzPQ2OO5zNm4VX9zgyUKeg5xB5XEkVrZVSLzOvqm7gwo+uuz1J+Ci?=
 =?us-ascii?Q?egazRq9a5FL5XE4WtbWknbkbZjrADGB1NkR2lcuwaWFaYXRaYv/bMieQN439?=
 =?us-ascii?Q?7/zQh0BXyk1MMIPDiNGNadV5+XdHCBrSV8XrsX3EZp+UdzncnHrQ5MkFWB9h?=
 =?us-ascii?Q?pb/vkcstBucBKLU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:11:55.9839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aeb0c9b-275b-4759-e3a9-08dd4592d8c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814
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

Add DCN36 support in dc_resource.c.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f59722e17abd..bf14fa1e3771 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -76,6 +76,7 @@
 #include "dcn321/dcn321_resource.h"
 #include "dcn35/dcn35_resource.h"
 #include "dcn351/dcn351_resource.h"
+#include "dcn36/dcn36_resource.h"
 #include "dcn401/dcn401_resource.h"
 #if defined(CONFIG_DRM_AMD_DC_FP)
 #include "dc_spl_translate.h"
@@ -204,6 +205,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		dc_version = DCN_VERSION_3_5;
 		if (ASICREV_IS_GC_11_0_4(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_3_51;
+		if (ASICREV_IS_DCN36(asic_id.hw_internal_rev))
+			dc_version = DCN_VERSION_3_6;
 		break;
 	case AMDGPU_FAMILY_GC_12_0_0:
 		if (ASICREV_IS_GC_12_0_1_A0(asic_id.hw_internal_rev) ||
@@ -320,6 +323,9 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	case DCN_VERSION_3_51:
 		res_pool = dcn351_create_resource_pool(init_data, dc);
 		break;
+	case DCN_VERSION_3_6:
+		res_pool = dcn36_create_resource_pool(init_data, dc);
+		break;
 	case DCN_VERSION_4_01:
 		res_pool = dcn401_create_resource_pool(init_data, dc);
 		break;
-- 
2.37.3

