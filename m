Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5F0C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94247113953;
	Wed, 24 Apr 2024 08:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fycF0hkC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B35E113953
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:51:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cMWNnhcrigL75ocz7LUPzS3PmHxIJplxxA5KbDE/sA6exdU7cWkyXT+tXlC4qfnj8cQZ/LkHRXLVVF6HLNsWH40nKEBm7PHXuue/sWgpvLpTcxxTfc0T2i/KMF0l15BtO+7Y/cCuU9chW8wAB78n3+0MavFyRrxb4bvxILJnTDhMAmYRCO1UxeseWBoZD+fsp5l7dXJH3l5m8Ifj6g0/gsJkErpQp2IuROvcosLI2jlCk3LiJoHYtrE7MHjeiGpR7B87GDsTo+EhAV03klcI/BjVqaSQ606ytm9QwnASbn3l62H1Gf73F25hfxkFZM7IWyW87S5DA2xZ8HfkfKmkIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWOsxVAzD4XImb2s0S/h87byrhb8ODjJfR0AsI/yWI0=;
 b=dXGZzYWNNEwEc1a6oCUryO06zyRZeIZCIO/tPFT2b5knjsKSoVUY7l3bnFVqp0B/C2vk53AX54ShtANoudbqXxQdFe+QVmasGZOzs2Zh2rlXOk6Ltx4H0vUGygdpaPCiUwl2RmKKXodffuwDmEKO/+zXRNiYg8XHK0dGZErBxNdZJTjgUJsouTQxS7PizbWKlBNrLdT4Oxh/JgbMu44QalQ5E6aqbBgklIpa2IbkRgxauGGpTW82awEMo+AW+hwsz9b1pKF/5CByPABzVEP6IcYxBvo/IM11JHoAbgFWyGoFP/+Lt1d4W7nd+wawYqZlr0EnvbJ2f78SsvpE9dRCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWOsxVAzD4XImb2s0S/h87byrhb8ODjJfR0AsI/yWI0=;
 b=fycF0hkCgkVYK06uTfF/zhnNCtGMi3c/OuqzHMAIyEwcedCGc95m5ww2g48FKYWiD3M96mzJ2NCQOs1cm/CB5cS/V3eW4v61zMyxEh0iSSIsc0BQWNsotLPBuCFc7372WdkgrtFLhO03tLoIPlr055U4tMjWhZX8vFU+5eVMBXU=
Received: from BN9PR03CA0409.namprd03.prod.outlook.com (2603:10b6:408:111::24)
 by MW6PR12MB8706.namprd12.prod.outlook.com (2603:10b6:303:249::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:50:58 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::6e) by BN9PR03CA0409.outlook.office365.com
 (2603:10b6:408:111::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 08:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:50:58 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:50:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 01:50:57 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:50:47 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 07/46] drm/amd/display: Fix overlapping copy within
 dml_core_mode_programming
Date: Wed, 24 Apr 2024 16:48:52 +0800
Message-ID: <20240424084931.2656128-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW6PR12MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fcf840c-c8e0-4096-ef92-08dc643ba8f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400014|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?imLK8ywOTDIb2n8RnyY+b3icuF/qUXW6yjly0IZ7IReRzzduohmZHkyQGb8q?=
 =?us-ascii?Q?hPxbtST/BX5lRTJdX/Vq0322f498YLzbNRAzAH3oCVn5ctmniuyiDpFJUvAY?=
 =?us-ascii?Q?Oek8JgdikzcrboVn3J7DR+Rzdg8FBvW6C6it2HSLFqr8hY/EZzOMTLA078MU?=
 =?us-ascii?Q?rOLQOZ4BoMry663Ny/sIIsyiD02fUNmzreRjdGz/PSmgOl2HfA7wuaGRUyw7?=
 =?us-ascii?Q?FDdNspKy9+atlivnh2/fj6cSG+S235DtdSfijQlc2bhStPF7U/aS2jy+U3Qy?=
 =?us-ascii?Q?yNR7potBOs4MWE4/vKrIK9DmOJbfAgLsZwnbvc8a3aaHcgnhgye26d4u/cSo?=
 =?us-ascii?Q?UI8fYg+Hi1yMRr94gxd68oesY5bifznBFvIrANbWwjrqN58kw2zX01wLlU2b?=
 =?us-ascii?Q?d9Z4ztLSrpjEpmkgcYbmql0PCJioNwhB/eIrqIfhRvFZXNAkrPUQYiapFsUY?=
 =?us-ascii?Q?68n2OWQI80q6RUs+xe+TndBYw7KIXGXNV+4V67a3gaqWlbubSEmQft0ThLpy?=
 =?us-ascii?Q?attLbcag1qqxsn4OhoX6ldsTBU70HLsJlcrt02SNUxPtldJlsVnDLcBhrW73?=
 =?us-ascii?Q?LNXkFuQlNnEWCiyHWnsRCMefT2REctpm6jN+5tWQzEKFyMSJmgdNaLM715A2?=
 =?us-ascii?Q?QxvdLdT6uQzErCZaGQxic1GAUnXuHqnmxDDEoCevlZ/iwfTc5mq+yqgDvZZw?=
 =?us-ascii?Q?1nxr0Wpe+5Lx1VpVQJW4weIYR4FdE1fqmYbT/1UaCe9hrPk8KvhACQzt790T?=
 =?us-ascii?Q?v17rWYANgLf1ma3E8TZnBPRDcLVWBF63bkJteF8KOXQc3uUVKxyym9BKovdq?=
 =?us-ascii?Q?Wj1Qj5/+9FE9bFSFsS1F6Jvk54FAGOur9loi7ZKpLQu+zIa6q9iUgmUCX/to?=
 =?us-ascii?Q?Kbmpp4bxw5n7i1A+CQ5w959zv3tLFOk29uGgyxNn08s1tm+OrsPj1L0bVJv4?=
 =?us-ascii?Q?AukHShTYjgP+YK9l0kHlXsv8FrlCsSgwQRA1rMt86Do3HOXI8llvLkaUnrxL?=
 =?us-ascii?Q?u6TZ5pxw8+NOZxvZKxZ0xzILJlFUg/AjumDxSa6iaBpFa5LEgPEyjFkHOvgI?=
 =?us-ascii?Q?Iv1i+PMP6etUD9n8Bl1Z826UKO4wht+8SqzkWVeNJHeKD4MF5FXMsxntShYk?=
 =?us-ascii?Q?pfJLIav6u93JNZxr3OuO9wbNzXAnzF5r+tFgB4jktisP4IPJDLTViq2bHsVw?=
 =?us-ascii?Q?AQeZCk7t5cflhtgiTVK9ScStD3GDbL6qRgi3eLmORqTVGF+DkctSdVMy/RnG?=
 =?us-ascii?Q?An1xhoPzq5b5fvhzXrBJcMxh+c7V7VLaXx7IpxeH95tOiN6mpX/1oKEFsrdf?=
 =?us-ascii?Q?PHXjZcQPjPywxbkb4gf4aA46kRUuiCslzS2/It4RGXB5EhQQHlT8sd9cPS0s?=
 =?us-ascii?Q?/uu0WcekcLfjeEncCEqsAFPhzqQ9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:50:58.0255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcf840c-c8e0-4096-ef92-08dc643ba8f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8706
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

From: Hersen Wu <hersenxs.wu@amd.com>

[WHY]
&mode_lib->mp.Watermark and &locals->Watermark are
the same address. memcpy may lead to unexpected behavior.

[HOW]
memmove should be used.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
index 6255101737b5..3e919f5c00ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
@@ -9460,8 +9460,10 @@ void dml_core_mode_programming(struct display_mode_lib_st *mode_lib, const struc
 
 		/* Copy the calculated watermarks to mp.Watermark as the getter functions are
 		 * implemented by the DML team to copy the calculated values from the mp.Watermark interface.
+		 * &mode_lib->mp.Watermark and &locals->Watermark are the same address, memcpy may lead to
+		 * unexpected behavior. memmove should be used.
 		 */
-		memcpy(&mode_lib->mp.Watermark, CalculateWatermarks_params->Watermark, sizeof(struct Watermarks));
+		memmove(&mode_lib->mp.Watermark, CalculateWatermarks_params->Watermark, sizeof(struct Watermarks));
 
 		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
 			if (mode_lib->ms.cache_display_cfg.writeback.WritebackEnable[k] == true) {
-- 
2.37.3

