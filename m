Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909D6CCD187
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343CE10E8BE;
	Wed,  8 Oct 2025 18:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EkpmJl/d";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47EDF10E8A7
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+sFv0UDD8s+F84DThOA1rxSTRoNq883R8Qs+zQ+7Na141BZKU205xD7ni194YqH94zt7qMYLClVUP5bXhGw2W0l2bBqJaI1cg1LVO4JPSj/aD1zzGz3NcItICn2ZQNz5sHTjWh4M6beDRsJIQUJJPJOVdG+/XpuZ0/DzeZ2Hq4gJLVfDOyso86Hn7EZSwFE0UBCYUU0iIseBBYw3FPdc9p+xsHQneWIYwyk59++9P4GPRcuQNm2rO9/uHZUfT3fWZ/TQuPUpofYIr2ehE3hg19JffHbubd4qkTliN/cBrPuitMymoDTMa2ib7aDvClG2jDLxmS9PbWy7GSsFXWy1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDi7zM7BsHlZfUnopH5ibIPragmCglg6YitZUOVZ/+U=;
 b=QwbcvZooEiboSAoKc5s6x47kQlR40tTR8ArmAzGqHUxUwxfGNiKvED+qAxiTyhkrYm9JJ8wWTQjzvkfFcAOtr+woFrMHXTuan/rXcPWj6v1CETcTl2Mf6ur787EGRhl+hfvCNYHXEUqWJeN+w4cIpQ17To90OAi9SX7abHdEIPyyu0M7bTpQDYxlo1aHAafkNV0OgHuh2F1UTqkKJ0G6BDNJTGm2v0QuVtuwz3/GvO6wcn5uGo07AAlXjaY4EiZv/xPXTRlwPqc9zk2MYLHj539zXTixS5MYL+fUd1d+kdcnfyQyUH897oSeGIvb/HTPDL5vNkDU5F5k6q2t0Jan1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDi7zM7BsHlZfUnopH5ibIPragmCglg6YitZUOVZ/+U=;
 b=EkpmJl/dDZzn8c52PqejYc0kNdjlJg/ts5cNL3BlKAR6KfiiFjTKKxLhFru+O/kifZwc6fPYFTNHPijpGwRlZ+YcGorqDFq/azVCNKPRijoe4sbFQ9O2Mydz16dUMM71xHHSIdmHT5Te56ArgQVnsVFOsN0FN7fC/KCSReXg95M=
Received: from BYAPR07CA0093.namprd07.prod.outlook.com (2603:10b6:a03:12b::34)
 by DM4PR12MB8560.namprd12.prod.outlook.com (2603:10b6:8:189::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:49:01 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::df) by BYAPR07CA0093.outlook.office365.com
 (2603:10b6:a03:12b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 18:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 8 Oct 2025 18:49:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:43 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:43 -0700
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:42 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Austin Zheng
 <austin.zheng@amd.com>
Subject: [PATCH 05/22] drm/amd/display: Remove unused field in DML
Date: Wed, 8 Oct 2025 14:46:59 -0400
Message-ID: <20251008184839.78916-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DM4PR12MB8560:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab56640-f1db-4f4b-392b-08de069b5872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?48Y3uXfXN2KT8imJYDFNwuQdFVCaVuSXL0kdW7qMDPzR0qmRxITngCInGrzU?=
 =?us-ascii?Q?MlmhMcI/AGGZ7s9NacnVdg9P1waEV3NHu/lOGgS13cvSv5npYNvN7YrDrXnY?=
 =?us-ascii?Q?1II43ounT5kfKLDB9Dpdh0q23WbaRSsgzz/YFTSSRaRh14zHYzr7MRbOef6n?=
 =?us-ascii?Q?PtMExdHsv4W4HgrZD2LZ4sYQxSMBJgYIxAut514exO5kBnREEtDjpP1OUNAR?=
 =?us-ascii?Q?/9hA0DPkKq6oumags5Ww3TVz0fkJ0nkWe4CV+1wuoC3eEEFsAWf+bd06R5kB?=
 =?us-ascii?Q?Cn8bzYPaF15Zyk1zn8M8+wAoSZjHhGYZQHYGrxZNXvXxK1hLiHvyelevCMfq?=
 =?us-ascii?Q?wkdrDDJRvhx1aKIUPw8xbvpYb9xrpOj4JshxyfJXqc/7yQFljJbvJE0HO6p7?=
 =?us-ascii?Q?pffhhsC5EtImHbWiN2qcZSJfnE2ZdnoZbFEyZ16HtJkwLyA7v0mQIh1u6nzn?=
 =?us-ascii?Q?o4B/+w0rxOjLMIjhHBYyDgUsRvOSWlYFZREBR9K0XRRc4OjCFaHAnjcWyaI3?=
 =?us-ascii?Q?HZRnmJ17b4V82etuLOZAWcXlvdpylMbFyHck2wp61t1blZe8ASAXWVmRE1xd?=
 =?us-ascii?Q?QxtDPOWmnV/9iP8vdR0J99kfXgkQcXgkblAWNC9UmCyKLExZ84sZwSxzuRbY?=
 =?us-ascii?Q?OIPWsS/MhrHhiUrMGxm3NWgu6KvF8oGcwiXl17osFfN0poK3tTNjzIjdFWmZ?=
 =?us-ascii?Q?tRS97rLyG+41u6/vB1u+c9aVt7pMeZ3/mq+MlPqJu43mchei9HjwpUVWtzB/?=
 =?us-ascii?Q?uO99U32DeI59hy7cQztvTdcpbLlsbz0h+t/RVThYbC/If1OtSDdkbQ9BQO7u?=
 =?us-ascii?Q?8gBikeGMYPymHaiuUlH4xy8+41LDwWRmWlNVgStd89702kljRau3X7O1IP/O?=
 =?us-ascii?Q?tJb2XsViGCdSlV0jp95N3WuqQILk5jxL0DBOf6twsDSUNQAgKFFh9zIz4C0u?=
 =?us-ascii?Q?LxyH2K5I16Kv2mui/ZoYItoEosJN6X4Sp6LytGT1LbwUDxjzhmxKiXrFGfgL?=
 =?us-ascii?Q?XYK2tbaSLQUFCO+Y2h/jR3qzyWbPK6AJev9DdRXkZtTPif3taz1Zm6p8J489?=
 =?us-ascii?Q?+XQ+HsZnRVVYl8GfYrqJP3LKulk9cdeLfDzTgBdjXXr5jxT1EyR2Uc8C5+Ay?=
 =?us-ascii?Q?tsbmA82lAh+9nns/uIBs+wBddV54Dimvjns7yLPnholOOMhaeQNHgYBpumX+?=
 =?us-ascii?Q?usbKMol+K3pVdh+UW6RBwgRykBOus4Vyf08EsxUZ0YPTwa9XT/3WKkiw88bP?=
 =?us-ascii?Q?xO0ssnlW1gfgcMmudHQdcS5Tz0ddDy4pPC/faVzrqfNpamszGKwrN732vK8P?=
 =?us-ascii?Q?r+I2h4q2VBld8fC68zMAJd+jK5TB9su8+/HmIW0O/LO8i/rmuaX3HQSs1Dhh?=
 =?us-ascii?Q?GFj9tOZELTWM2/KN4r2iZnyY3B1NPFCtkviV0wUGWFj6qQSuZSztTpTVZSoN?=
 =?us-ascii?Q?UI5JOk7KGiHF3wmvBKp8evkYh6SLDt0rA+PLZgOQLJtZ08WkqHY1aDc46Pne?=
 =?us-ascii?Q?0fcJ59MYr6pJQOPW19mzgy4PKGcAcMFd5GzECqR3d1hc8Nyxm+Bpvnxfe+pC?=
 =?us-ascii?Q?bkVbdellKI8w+c5Ny1s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:00.5423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab56640-f1db-4f4b-392b-08de069b5872
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8560
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

From: Alvin Lee <Alvin.Lee2@amd.com>

Remove unused fields.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h  | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
index 91955bbe24b8..8e5a30287220 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
@@ -46,7 +46,6 @@ struct dml2_display_dlg_regs {
 	uint32_t dst_y_delta_drq_limit;
 	uint32_t refcyc_per_vm_dmdata;
 	uint32_t dmdata_dl_delta;
-	uint32_t dst_y_svp_drq_limit;
 
 	// MRQ
 	uint32_t refcyc_per_meta_chunk_vblank_l;
-- 
2.51.0

