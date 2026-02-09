Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF37E81BBE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 13:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD2110E3E0;
	Mon,  9 Feb 2026 13:04:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FYG3iYNG";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011057.outbound.protection.outlook.com [52.101.62.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C5C10E2B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 13:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ96dB0VoKdgt3x0EiMqj1RpvCzW1X+g3dvJ4xvXNdETF+kD/yukHWAaORfc5f3CFwploZceYPQTqlhF2ukfU835PGX0xrnPo6wjx7G4umNCRO1ZlpH1a8YcDQU4+X6qlqDhMLOPbO/3dm5k+k9KL5O+FBop5/XTmeqlyabQ34kKu8Z0sd8pAfVP6wwpfCHoL2ncTP2D8TWprgAg5Jk+q64DDRICy05Iv71vplyCFO5aPBDjBJMTopiA0GbxcKNw5JmQDqdWU0NyS6thZ+THoW62Vmhu60YIZvVAzhWbXLFOXEGRhqhWPLbGXxS40llFGM5aFPHu/zVGVGkT1SvzmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4veaApGfvRN14+T7E+fhYEMJEo5lwqmjnMz5b9Xw6SU=;
 b=WOcaYT4LGdD65qQzU4ptzV/deS1NNeNrZvE6W7YxJYIe3EPvLg+BBH1qF7mQtRJUL5XWFiCdWhgcLq5kCViygYsoNKLSSvpQka+hqBkjm3Kv5E1neMJ28i73HCiVrirlxFcyD6XfPJa0ddUyLnYeTHJW2sAKJNXhltzjHY8Z6fKJG8n7AzXzYhgHt9Jko4M9LwaFQOm0QuNWrcVU0SNZWp7Y5PG5spvTs0JabZ/Hq/bxYcwrYg26cTAGlbvax7eUO6rVZZNnL/scn/+fSDUYFloWMTttVH3jYrR1z6W7KmPdFr8A3szxJfK3EtU/kffhYePEXO/Vxx2aUwU9KBLNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4veaApGfvRN14+T7E+fhYEMJEo5lwqmjnMz5b9Xw6SU=;
 b=FYG3iYNGiHBdmsy35pK3mTDNZexfmArfBehnyZVUGrOx6ukYSM1F1HNnzlCDoDoj+j+sdnApNEW/EdLbMBcD+JAJJlpjNTEYmefCp0WsYYC7TSyiIrWJULlzQpzSwuYvFI1PriEVQs1yjdpzpG4M9dULnPYOkGQZh1o92F0OSdU=
Received: from CH0PR03CA0441.namprd03.prod.outlook.com (2603:10b6:610:10e::34)
 by IA1PR12MB9530.namprd12.prod.outlook.com (2603:10b6:208:593::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 13:04:50 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::1) by CH0PR03CA0441.outlook.office365.com
 (2603:10b6:610:10e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend Transport; Mon,
 9 Feb 2026 13:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:04:49 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Feb
 2026 07:04:47 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v7 07/11] drm/amdgpu: Drop unsupported function
Date: Mon, 9 Feb 2026 13:04:09 +0000
Message-ID: <20260209130413.118291-7-Pratik.Vishwakarma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|IA1PR12MB9530:EE_
X-MS-Office365-Filtering-Correlation-Id: ac48ec5a-e8b0-4a5f-b2ec-08de67dbcee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8ygn55GHZ8bo2qrTpQx9JRsiGBY7dM0nNtO5rlOz6FZltvdkQpPG0ME/mqwM?=
 =?us-ascii?Q?piJUDXf+zmb6B4ffOE2tBiMZ2SiRBqdFtL1xRCGgMDe+gdOt2h/lAwLtfd4U?=
 =?us-ascii?Q?cszWsrbdtlympG2ErOBsmfRT1gaDBjZZ8HoMpqaMQrpjCTzWxKS4mSwRAVtJ?=
 =?us-ascii?Q?8jDn+bDK55BQXNFI5nWuLqh2esIobmkV/vqA+2mV9ffB//y0PAQUVuEz8Kmm?=
 =?us-ascii?Q?12RpqgfROG08Gqzr2Nyy++p08m34cISfxMEva8oWrpj0AJS271v3lCE4bmto?=
 =?us-ascii?Q?4z5wvmlZt1+wsPsBpX+ihoJrVUzgkZpUaFiRBuNiQa83xA8SYs2CqiZgknmd?=
 =?us-ascii?Q?akQe+s4Fk2GW/WeHHpRPvGEaMDMOlox1Ux0UZknWDVUDk+MrCzepTwrJJeDv?=
 =?us-ascii?Q?S1buk1PH5kqIsmGemMvyiwYa/UZigaBOlLBciBkU+f3WjnUAZtBO4ZHNqWwo?=
 =?us-ascii?Q?rcYJFkfShuHQKy62VafB1fTHBjsKLeqfPIVv+Xm+xbDCEGRCZIQFAQpBp5Np?=
 =?us-ascii?Q?bAcgyJYcTbHZUL3+SWSIv5949jgz7qlPFnO5IcS8zfsrBex9G64xDNPJ0xvv?=
 =?us-ascii?Q?BtzbLzGvBrQ3PAuX6mKZl8MeOgEyACuGdij0CVm3qjJHLY+asmseV+w4RrUo?=
 =?us-ascii?Q?sPwX1t01LchKJvzOzeMxE9ccpEthsBRMvWu51fpCwQbX/AAL3xXNfpammtMy?=
 =?us-ascii?Q?/Nzh5q0cDlBJNV4F1IyB8peIQ2BzkTRyAz1B2SnVnCz0j9yvOl88+nNT7TmY?=
 =?us-ascii?Q?VqA38T/qx+8De6cM7CltU7YdouS3tBYIkI4hb6bSBMSx2IbhR+UIGpM55fQy?=
 =?us-ascii?Q?pccu22fze7/kJPRPARzV5zWNmJh4aWG2BJpk8JYVChX7lIsTSWj+SgyxpVYV?=
 =?us-ascii?Q?Sm9oAaI51qL51oTEkul2rRpy6MXIMYnddeiIM8zexthU6gSVLe8t/9jOU6rl?=
 =?us-ascii?Q?N5o/1LGFOTrET6HIiK3GfVzqe23b5CeWByts4vqsUKC0UPZqhI5ncVguEyG5?=
 =?us-ascii?Q?rwdLM1vDLcpSOuFp4wWVzdkwhQfYud4StwtHx17UcsrkCvcQE7gLdT5L3WGg?=
 =?us-ascii?Q?phb8KZFmSYMZ/2eWuto8lSyU9uT/fKTf1Uzy3CNRil1MFhLfc+DsgDcwthH+?=
 =?us-ascii?Q?CVa3B6lpZEAFr7I4vRuf9qGmZBoPNjKMKHZYadvK79zahr6RzhZd1KOqdcsN?=
 =?us-ascii?Q?7S0pJQIWGlpbfxDwjjtIUxCd66rWN5trGdHM7suwQbuCSg/Mbgpg0TJthH47?=
 =?us-ascii?Q?eC6DlQCE2N3vsBkXLvjjM3fbxb5+Vr5sUB//6LCTvNcXL69DdihlESSVhLPx?=
 =?us-ascii?Q?xpumSk19TZOBOL2y1pa6nyG4/W8lVrZlkwPPy/EDxkRGshysvvHfCl5XWQf0?=
 =?us-ascii?Q?mHoUFC2bsT6+QHr55gCyQ7VQFl9oRmx/EpzeUe4gVQl+1GSjkvchjTx+DyEV?=
 =?us-ascii?Q?Y3DOvhDtLbVfazFLrTw85s6n76tb0yICRVXszaCAkBzOGeoV/ZxmnAqQTRq3?=
 =?us-ascii?Q?4zBweg4gW5CkNqgWgKXPOpXIR+4Ojt86weOY/5fc+Uyxgi/uz3/6h65hF8MG?=
 =?us-ascii?Q?dgQ8GM2HCuFs+kWUezd88rG1P01NG8pOGk7dQYAJKghA+/JrlBrkhrDydwEM?=
 =?us-ascii?Q?dEcp8196CuVwHsggcTrcMSxGF1EnZU+Q1+RhCvEPmnJmerRVJneigGCcQyfa?=
 =?us-ascii?Q?7wGn2w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NT0ms9z5mcDkXR49+gZuRxFRGgO+gVqxX1JteHtv606tdpC6n3M5a4JsGDMwBGfAoCswRHZ+R9j1YPKWVPhPsjTQDBFOoma03YK2xNseatawpgZq8r3P+4xyPYcCFFQzUJe5lLtEThUDetbN24fFYA7O7iC6r4kBx4u769PNXNHXs3epc3qdUJUItjVsiQzaJeTM9WnFRGZ0bLGsFZymoZ5SH9gFPXT3ntoX3wA4rsIjUnb/WthEn3LXH1mo9FqAZHatFaA+P08zdwzAkP/T5+KwRwf1CjMb9R/8mb7Spr8EgmxFRDB1JKnRJRPYf+aaaZ/24yrlL1xgxN1CGyhQ4FrvdXubOlxW4ws05jiDQHM7A8sNTcibbZmvsQ72nUy5s209H659N+qqaFPK7TPjChbelaa5afO+srNow5bERCnv3edgUewQlJg5Z1kDu30K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:04:49.9495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac48ec5a-e8b0-4a5f-b2ec-08de67dbcee4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9530
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

drop set_driver_table_location

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index c1ce603fcdd1..5260de5344ae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1382,7 +1382,6 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.get_gpu_metrics = smu_v15_0_0_get_gpu_metrics,
 	.get_enabled_mask = smu_v15_0_0_get_enabled_mask,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
-	.set_driver_table_location = smu_v15_0_set_driver_table_location,
 	.gfx_off_control = smu_v15_0_gfx_off_control,
 	.mode2_reset = smu_v15_0_0_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v15_0_common_get_dpm_ultimate_freq,
-- 
2.43.0

