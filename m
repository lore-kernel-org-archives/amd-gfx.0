Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1CECCFA0D
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B243D10E2D9;
	Wed,  5 Nov 2025 15:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="si/dMORx";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41D1A10E2D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXMSBuY4FbPokUV9NrYiYCdDGw7W4fte9kz2MEq26rY3UiWlFKC2XbudxNBB//kZ3gg+m2TyfUBZNAln4HciIXRV+apyKWiU46ULogjznBkttgE2A2z/51KsB4UT8CMMKOeFXbY9cro1UOqIJmJIlv0sI/xiHzcvCd5HCEow0AVTdt4Q9ippE7SfAMQEhSeqeewZfJzYmyUCSvWA/EkXYpQXhU7i4oo+NXvc2QrKY8lxj127v46cjcSAp6xqxWwyPwUAjfMylozg1aC06epoEeVIiRQMtum6pj/z+oZPRRMbQuAV5VkOidRq1NIFylXIPjbAYWMFVFxsxLzXH4l+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bVKzXDIXzKGcvARxcCr2QzAapFUTECzU9g6UB8FZ/A=;
 b=lmOHm/VZ/XPy1uAdkLataRZ4zX6mN9luSfxgIA4S6AUmNYcG/MHSgAeiNygD+7uKEQIdAfa0MvEpaUKltBJMxsb8XYMinMZQ4Pd9zUmUQvkU73CHgMx90SK0qBm5ME4TUGga9ElTi1eqUjy1T6p0Q11+eN5dfcuRwzt6SOEUodXJIIpGbCkzU5JnTsRRE/BRcFfvVMKCjH1p0XQBkPW4Vhd2+kvie+d0OO5ILRiNx+yE9ZB+lIyYROp7o8IsezA04ZwIy/zdtiEcBKEk+QgQhYWmAlvIzDmgWedMDX4rF1m+aGu+TVj85rlyt5ZqJB954XdNIr5UJ914xNYfvheoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bVKzXDIXzKGcvARxcCr2QzAapFUTECzU9g6UB8FZ/A=;
 b=si/dMORxad80CMBbhOFWEoiJ35T/Wh8YHmJBPf3uDmI/uuqbIH8FR+VuzRKFg0vYowQXWdhkuZjBQlbXHArA1EKoAJA8EicXKkvzQrHxZaemq17yDIidick/2y+3BqPsY82MSVU8gnmk/GsCXjfCLC3AVazkvCSQdXs8lu16XGk=
Received: from BN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:ee::7)
 by CYYPR12MB8856.namprd12.prod.outlook.com (2603:10b6:930:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 5 Nov
 2025 15:41:08 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:ee:cafe::45) by BN0PR04CA0002.outlook.office365.com
 (2603:10b6:408:ee::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Wed, 5
 Nov 2025 15:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 15:41:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:56 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Nov
 2025 09:40:56 -0600
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:56 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 09/13] drm/amd/display: Revert in_transfer_func_change to MED
Date: Wed, 5 Nov 2025 10:36:24 -0500
Message-ID: <20251105154035.883188-10-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251105154035.883188-1-Jerry.Zuo@amd.com>
References: <20251105154035.883188-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CYYPR12MB8856:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e14eb7-b408-4b35-78f1-08de1c81bce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?24RUd7/NrzkYeNcIbglDw8/ItawHJrUQUzsrLYD/jaBZ1rEmyEdaRUNf5LxE?=
 =?us-ascii?Q?ss3UpiBg5z0QFoGQhNNN2ZWHy5nk/Ih2j5m5oC4c0POEcupB4j7ZEEZZAiWh?=
 =?us-ascii?Q?8b+O12auqkcyp/OeaTl8FXtmDmcaWTDDYv3wMcBzJApqUNymC1/9CpQ4fFCo?=
 =?us-ascii?Q?uV4+FVdM3TBZqOmmifWvwvgm/lQA0liKlyjy3qknyxImnu5yAcS98vffHmTK?=
 =?us-ascii?Q?swe3OzsnX5c8CQXI9a4N+J0u7GinFov6qcRJ5ft0eOEVKG3/M8EKe+NkCP22?=
 =?us-ascii?Q?6mqA8pbOAk7e1dUNjYOm0y0tsGEFSsBPedAnb/kYGMHtqJZuiIwF9kuyeukk?=
 =?us-ascii?Q?ave13NsTi/tTSfqW2jQlekR2IXi+AdpHSs0LDEnaYfSxXnearnnl2MCz1vqG?=
 =?us-ascii?Q?U7giug01JfJpejuMoHpuNeXAz4QDYxc+aOP4ItSUY5F/YNZr4fFxNa/DBTn/?=
 =?us-ascii?Q?JchtQJ7rRe0gbGC+Gka8V08upe71gjN7xSLBuJFg5GsUgBwp+W3dXR7EdFsI?=
 =?us-ascii?Q?ePD/dOR0eUDvVZTrFCliKkrrq4iyknkiYb95KS46Shj3PLau0BifrS0M6yVf?=
 =?us-ascii?Q?IIJSpK6FfAkUKI4y1B/RZ4lhZP9AOyjsko/X9pXidjeoTzfKiJ7oN3Uhau6K?=
 =?us-ascii?Q?X/em472f1t9CcRbioxQN5EXPpcofnzLewxY4sYn83ute9tSESmXdefe5AF3s?=
 =?us-ascii?Q?Sz7a5zEJrrp41igTVafXff3wY7Zfe8jP/tre43rHq/o6UdLvbv3m8TF3jt/3?=
 =?us-ascii?Q?RmvnLwvdYVanchp1kUzXz7voChEwvx2hka1y+rRkglKbA5UHEOdwD4UuuJ3H?=
 =?us-ascii?Q?aEPjAlKkkhodZKze2lxlb67YsKw0RD4FvCCKMplAtaCW1wKUOMXa8Dqa/gL1?=
 =?us-ascii?Q?XG+D7HR8A6rDeN0Gs8tON7dfVgwIYgDvUNWTRNGZYUUJdJElt4WtytPnR7fx?=
 =?us-ascii?Q?sfs5oGDdH4BBOY7Ue1DOxVxKb+2RuVJcV8a7uRE//TFhmXBIrj1BoXRkrQSv?=
 =?us-ascii?Q?zF4vczl552RH7+ybTdcrCgqtaM4pw5e7jZJ24mvyvKmZlq6q5sUa1PApBAue?=
 =?us-ascii?Q?ij16s3C5UIRHTmrGMbUIifjWZGuWZRHY6SRCFK1mq9iRwCsQm05pVxOabFD5?=
 =?us-ascii?Q?5FVguIT8SQmpfS4xdKbEr3EpF+6MUn3ZG+0umK1wFu4oK4sPC3XKcUSXvLPN?=
 =?us-ascii?Q?fJ5n9uB9Njvr/zp22WOxN3spyEmQkFH5yqD9o9PNrMxCBvjwZOayBXV2QCcH?=
 =?us-ascii?Q?v3k/0xhH6N0Fl1cPmocjnPqOSAcF6e7A8SNj3u90Kr7Wtz+3ooi18e3y+ecS?=
 =?us-ascii?Q?9Kj/WafZQ2fU3XGvG2kH3alFT29k5L3AmV9XqPXoOx5gXlN1mkDoEWpTfBEl?=
 =?us-ascii?Q?WZdgghKA8Y0nMSA+7Ws8q079J790T6/mt35kpuulLdZ8TyWsYfP/Tb+sRV2y?=
 =?us-ascii?Q?HK2I1uY3XwOttDEJgnfruAwYlLYaQTqADpgzQCMVZ0CWnyRRMPB/rNVeV1/w?=
 =?us-ascii?Q?0fnWdcC1CHeNiecbMq28hRgtWvD4ZToTbEjQ5ib5ra7O1Fc/nV7A3p7fwlwI?=
 =?us-ascii?Q?DZAey1xSJCdlkN+tyyk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:41:07.8279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e14eb7-b408-4b35-78f1-08de1c81bce5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8856
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

From: Dominik Kaszewski <dominik.kaszewski@amd.com>

[Why]
Last commit accidentally changed handling of in_transfer_func_change
from MED to FAST.

[How]
* Revert the line.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 819c08b59d4e..5764f15c16b7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2857,7 +2857,7 @@ static struct surface_update_descriptor det_surface_update(
 	}
 	if (u->in_transfer_func) {
 		update_flags->bits.in_transfer_func_change = 1;
-		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		elevate_update_type(&overall_type, UPDATE_TYPE_MED, LOCK_DESCRIPTOR_STREAM);
 	}
 
 	if (u->input_csc_color_matrix) {
-- 
2.43.0

