Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D41D637B4
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 21:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C87D10E897;
	Tue, 16 Dec 2025 21:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jA05NUvu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CCD10E897
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 21:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYi7aUHy8h3If0XQMvFMs9LUsJalBHhGp1kn8kdjmNHGFexhkmIndZ9dwpcPja7ZqM5rrt0Qa5vK2WXKlZe00xoFfMy8NWUurC66DLFMjjgYqLewp5QV4BJght1iDbYR5pXygZAEyA/G0opWBVAqf8BK3LlspsqLMd1KI5mJkEJ4tlPK9HCT75wD91+01uU8kPkSO/pqK+3GwsywxyEDuxNgfT3WDd6fps3hPvDEN/HnF5Wpz2drojTml2Uzf/QwIK05pQqBEQfDhOvrMLmVSrMyRp8OCv9QY05LvtRaWSRRVVR3gK/DQ0uVzaOCzaxyHKWBqY9WXM5d95A162w2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQHGr+guy1UdKfUNjF/nzYrUmD/XyJG06wQ/w6swbdI=;
 b=KEbpeALw6MdnKbP5VhIVcDJ1LCuY4gyl7QMAT70910DU1mFzm6uquw/pIlNPAjibxFAMRaqI3L+TZWo4O/A7IgZdAgzBW7yqoesuDZeiw0uRdoXXEC5c3AQPASEtjOwIHxEw9kk1lme2pX1GjNHALGHx/r/tM+pkGbcN0e+BO+RE6JAz6Etnrpm7jcaEniPJX/xQ0PGHPXXMJHoRE3+EDQC5sfSJtkOA3yadN6Kiqhnwd9FVNjIdo1Oxua7OszuvDAK63bfQD1GKklgtfCQWvHztDq2r6pgalwPfWvCwjY8LO/VAEBHfdYD1MeLE9OTtwFyz9DyslYn5dEddZ3ip5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQHGr+guy1UdKfUNjF/nzYrUmD/XyJG06wQ/w6swbdI=;
 b=jA05NUvuKUj5oCOHEnx6akoUS7/FTJ3stNbuHCn1NVNlEt70HU2drE7d8mqef/5kgDIVeSFYNwxPJ1FCmrwaL4kNqE4LBFqkTsZMJGt797mSjQPN46ubjwI8aIwAZP9PDEbiEiHtB8fLNlbTNYa94pMo+0/atJmZWcjF8HjD4nc=
Received: from MN0P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::34)
 by SN7PR12MB7370.namprd12.prod.outlook.com (2603:10b6:806:299::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 16 Dec
 2025 21:04:15 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:52b:cafe::bc) by MN0P223CA0019.outlook.office365.com
 (2603:10b6:208:52b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Tue,
 16 Dec 2025 21:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Tue, 16 Dec 2025 21:04:14 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Dec
 2025 15:04:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Lancelot Six <lancelot.six@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Fix VGPR bank state save in gfx12.1 trap handler
Date: Tue, 16 Dec 2025 16:03:43 -0500
Message-ID: <20251216210349.1963466-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216210349.1963466-1-alexander.deucher@amd.com>
References: <20251216210349.1963466-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SN7PR12MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d3f690-02d7-4ffd-5979-08de3ce6ab44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uBCH7TaXMwho2sVlKfJpagMMhiyb/WFFhThIiWkregs7XIxOuuvzQXjYWTRK?=
 =?us-ascii?Q?zLoaCDhCZzPkbh8MnKVSQy+lGwU/sX4i8KrIX4I0s6PzC22/jxCMhczTNuKR?=
 =?us-ascii?Q?wKZIp4aLq/g4WAzWefexwBQW6/blALozFu64/joAQ/xMIQjWP+0UJx8WlPdN?=
 =?us-ascii?Q?JOEKsmkGLPHnWca1176TVS3vVwgpy0gN5+k/ACK+2jnZvS0s5AqAQQiDOoDf?=
 =?us-ascii?Q?dKINBov+KdSXpP2uqw4i/AOjoPVrUTTfUs6m5IhL+4XFycOYtymECw1ZWffA?=
 =?us-ascii?Q?UzGOoSCvtXrr4R6tvYWV91b3WTQBjOOOxqorHPdyLtLAXBhy8k9wibgDiXkd?=
 =?us-ascii?Q?8n+oEChxT25vig6/ZqBVm4CmLWP3xiIXqKqNYf1mBte9J3TPaoTDNCHgNWBp?=
 =?us-ascii?Q?EcKnwEWFarj1YhQcUTpHprZfOlrg20GVrNUMSRTa83Z0fwgx1APMBH3NZSr8?=
 =?us-ascii?Q?bXXjbIPzq5ZDvbcxABJC5Q/Cf3X76cVNG5Q4FlNaQUI9YxJh4f4iWkiCsGLw?=
 =?us-ascii?Q?wLGoLbhca714F7wwECToR9gxWgJNUnD74hrUzZTZQ1fybczXBG7sBB7XW95t?=
 =?us-ascii?Q?2EG1owc1sPD3JIaHutWvLTsHFFYs2KL17rivJvNy+9s6PbbEWx08sLbUencf?=
 =?us-ascii?Q?Rc4l0mz5htB5ZZKdLppZuuBL+0i1cMqpbNrNiemOTeQcVp/403sVVL/LgMbW?=
 =?us-ascii?Q?toxpfN9SPNiwN3dXi6z+LcO8PcrenqjA6jeVWYNp+GGtl980ODmheImgO6vt?=
 =?us-ascii?Q?q3vFogZGFiP+IbsGHDjmh9cYrjdaRWrMkgOZ0Z+5qHZdfvXSSv7EBerax12Z?=
 =?us-ascii?Q?8gdOPV81OzrubFzt8RqkNVXtu6JILmVXXBl45BAeeytyAwQ3GaXDEPHk8tBf?=
 =?us-ascii?Q?wVe8oZkmSjUHDYJqP8fOSS2ylzfzl2Q4eEBo6hwaYZ6C3MxU/V2+Q5Do6tIM?=
 =?us-ascii?Q?znVs7rL5DXVUv6biLYPofocA4bipMzLczBtnys1O9m8FDVS3wTT8eQBSj0DT?=
 =?us-ascii?Q?Ucz+BFI6OWwLOaHTU4cgSOlIhio+RlWy6UzLgOD+LnOdW73v45lYfT0NGYPu?=
 =?us-ascii?Q?lURAJ3pLzHfxZ1eGV/5R9bSRlYdi27cZDW6FZrSj/siDSzADEBSKmXcP0XWo?=
 =?us-ascii?Q?8nU1w2+eUlwD9V+TW1LbazC92Q0AlRekw74UT0YCxX26vb2553K/SvA+G+bV?=
 =?us-ascii?Q?MONHReQxV/wlm9anNHLv+zqLYo5bu1AWESkAzcmJRYo5zL3lT9h591rwtX4z?=
 =?us-ascii?Q?CjoJLCnBmIGCf7+GglAVnI5/2/v8IzHk6KtFZ1fClY9eSa4kGW/GVfi2YhOZ?=
 =?us-ascii?Q?PgLE3I9apqEa2v7FJ06oPeWJbVVMedmsH1+fEdcW/0C8lIsn0M9FEP366CWs?=
 =?us-ascii?Q?LtnumZcu8pKwvWRPOkzJ+J8oa37VKivzgo7DNjOVQH+eAXmTu4ynp3Lp9NKO?=
 =?us-ascii?Q?AuWKixoIEiLSnhiyTyNTXh6OjizlicgqsL5GcTfj2qaiEpIsh3N72tF4ONbV?=
 =?us-ascii?Q?RBmPZb60EzLkIpODxTjjDTwOpQ3B4rnyGq9YwiQzwiKyD3hsMdi3LNTpUC5t?=
 =?us-ascii?Q?9bDVpNe9t0BFu+TzkgE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 21:04:14.6362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d3f690-02d7-4ffd-5979-08de3ce6ab44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7370
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

From: Jay Cornwall <jay.cornwall@amd.com>

S_SETREG_IMM32_B32 does not apply a mask to the MODE bank bits.
SRC2 is consequently unconditonally cleared during context save.

Use S_SETREG_B32 instead to preserve SRC2.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Reviewed-by: Lancelot Six <lancelot.six@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h         | 2 +-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
index 5c6d533a59562..d82ce2f1e9b92 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
@@ -4731,7 +4731,7 @@ static const uint32_t cwsr_trap_gfx12_1_0_hex[] = {
 	0xb8eff822, 0xb980f822,
 	0x00000000, 0xb8fa2b01,
 	0x847a997a, 0x8c6d7a6d,
-	0xb9802b01, 0x00000000,
+	0xbefa0080, 0xb97a2b01,
 	0xbefa007e, 0x8b7bff7f,
 	0x01ffffff, 0xbefe00c1,
 	0xbeff00c1, 0xee0a407a,
diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
index a807e7557e93f..d59400d242d19 100644
--- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
+++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx12.asm
@@ -414,7 +414,8 @@ L_HAVE_VGPRS:
 	s_getreg_b32	s_save_tmp, hwreg(HW_REG_WAVE_MODE, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SHIFT, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SIZE)
 	s_lshl_b32	s_save_tmp, s_save_tmp, S_SAVE_PC_HI_DST_SRC0_SRC1_VGPR_MSB_SHIFT
 	s_or_b32	s_save_pc_hi, s_save_pc_hi, s_save_tmp
-	s_setreg_imm32_b32	hwreg(HW_REG_WAVE_MODE, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SHIFT, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SIZE), 0
+	s_mov_b32	s_save_tmp, 0
+	s_setreg_b32	hwreg(HW_REG_WAVE_MODE, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SHIFT, SQ_WAVE_MODE_DST_SRC0_SRC1_VGPR_MSB_SIZE), s_save_tmp
 #endif
 
 	// Trap temporaries must be saved via VGPR but all VGPRs are in use.
-- 
2.52.0

