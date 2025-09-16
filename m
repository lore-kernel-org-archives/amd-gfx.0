Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B000CAC59D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 19:12:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42AC10E799;
	Tue, 16 Sep 2025 19:12:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bYEIxAP2";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013071.outbound.protection.outlook.com
 [40.107.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6C0010E563
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 19:12:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpD7T/+bCsbj/SEPeJ8mMw0gtKn0Qo9Y7aF82amPLq5rTdKRyGV1s5EQ5FxDO3qsCbsCobQT4g5Gn2109f7ba/qQ20FG6cboG9r+IKaUmRgtUzc+2Sqw819VNDwCzMIOg31rLB7XUSKIYupo9bpjBJbZ0KT4FmLGpBp5KliJBD3dpMwK4POU31/OCawB/Xt2ziyRkXB932x87+zZBj8orvtYC5zVUCHjCG/A6XeauVbaciwWbCGSNKt6hA71mhYWBrcR3hn8w4PxPlSuljPQgu5noVxo+WzalzaiGa2Myh2kVY14+pSFchhYgW6liJqmVcI7uFRukuPiPj3NyJVrEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dU7jcXKjscfYC7aO/BWYuWCJ+EjqH3nHKhaGyHZ/eKM=;
 b=bP3waawwZOwlZ/1iqKRUetP6A42C6LW7gk3fJKX/c4KEAogzPwdK05ex1VRIX9uUO3tQOETA6t54ggZkEqEwtqNRcYtuIdX9vog7uvDbROrbZ3hgQnB+BkyZl9ezm7fVtNakiXAVTMPubgzs2Vuih+a6Bq5Jev+iSfM7u3B1SgBA37ZfxKWZRYxlhAoyjf+4JY/L+Ddsl0mC8civ1px6fIaOnEdGJMQzG0EnrpoU3xgJuQj+ReE4rVQvjPUyG62uF6LOcwo257mBPxaye9xsjS2Yp2vOFrpNf4fgeIrlHIA3Clt79ucow1DE90VLBQUzlnsRAZnpvxyo+ICEzGTJfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU7jcXKjscfYC7aO/BWYuWCJ+EjqH3nHKhaGyHZ/eKM=;
 b=bYEIxAP2YRo9RdFVY+Tytbq+hAwAfgWIlv4Vx1loZzhVpPjD2YdONkPCr5TSTZDN6w0Co9BC0biiNVbmL2qjxaEAcVdvjt0TxytZnTLTa3QvN1QDDl0ZHucZ3f4oOJVFKqLmG8ACKY79Pn9uc/xbp9JFpnBhknWO6JBcBvPsDsw=
Received: from BN9PR03CA0124.namprd03.prod.outlook.com (2603:10b6:408:fe::9)
 by DS7PR12MB5719.namprd12.prod.outlook.com (2603:10b6:8:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 19:12:18 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::46) by BN9PR03CA0124.outlook.office365.com
 (2603:10b6:408:fe::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 19:12:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 19:12:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:11 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 16 Sep
 2025 12:12:11 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 16 Sep 2025 12:12:10 -0700
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Sridevi Arvindekar <sarvinde@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 08/20] drm/amd/display: Fix for test crash due to power gating
Date: Tue, 16 Sep 2025 15:09:28 -0400
Message-ID: <20250916191142.3504643-9-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|DS7PR12MB5719:EE_
X-MS-Office365-Filtering-Correlation-Id: ec470312-a91c-4805-33b0-08ddf554f468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2rlRVqEvHGy4u3bazpDEtHMGn+N5IattaTkDm8H0+bNkqynkhjaIyJKgaOW3?=
 =?us-ascii?Q?WO83wm9jZfSoHNoJiMSJSOW4PPcDG/jIdKjY/mwhmUM6g8l+9FB5awSPl0zM?=
 =?us-ascii?Q?bvaKf4OFVNjS0HodWEFkgZivkYZ/gzvbkDXoFCtsHi6DoZyJ2AMO6j/TP1br?=
 =?us-ascii?Q?t1FcdV+adw6kV2yYhZPxy6p1vrJJiuIyZOIoPtkY4ROyzOQ6yNXOI32Yq01j?=
 =?us-ascii?Q?MUDFm3whYMDG6CNnsABMFH/Z2gPWmTOKg7JzyqeY1n2hAuy8QUhGJ6sxw4t2?=
 =?us-ascii?Q?oTd3iEFlwPIsM0C6C9ElfYtUmibRNkAAqV3swyNLvxzPcdcIxBKyLU0pbUZ7?=
 =?us-ascii?Q?3GBkofxpdrmHVKBWefcySR15dDPlJ4d2zkXeegAC4IK277keTk2aO+n99VvZ?=
 =?us-ascii?Q?aWWqdAV5o8ZSgkxZhaJ0kFxjx6pWIdYgGIz74RzyImhajsAoKXK9ub/qv4EB?=
 =?us-ascii?Q?81wR+mW1GddHCRd+nIKlQ23bJmEO0JTNbu+hwTPwS1nSl6QNbsHhEk47s5B5?=
 =?us-ascii?Q?q7kSGEjEXvUXNdMIYUv1y0M6wch//JNXzauqM3WQX0X543vZqo0fVLPu+7aA?=
 =?us-ascii?Q?HcZoN5Cf6GYLk+kWYzkQytz01sxTvHgUMAg+/rS2kje+UiBkQB5lL0W5kT8E?=
 =?us-ascii?Q?waueGfwOJKKXuJ8myWP4y8aRXZjws0rdnSjOLeOnwPTUY75hMV1+ls4lPeVA?=
 =?us-ascii?Q?2pRVLZfIt/qrDuWV9jhWmk8VOSlGg1eUTImLjDm/2INCZqAi9+IkbXL7wi7u?=
 =?us-ascii?Q?xl0wU/3YEfWGw5Kl64jWdcBV4R8wIYNtR9cFIqhoZubkTIzja/kvfg3UlT6h?=
 =?us-ascii?Q?wT6b+LgKyGvwPmHngc+0ENbDB8NNfyEbl9hs7khmbryEjQ0tZKy6uYcKB4gr?=
 =?us-ascii?Q?x9pcGw7UMvM9LIUbTnUSxrBwDB9TfJiuElkrDJm4Ce0sFdM3usYeHv7f837G?=
 =?us-ascii?Q?6Dx7i7OjHIQE0YXhUCcVcE7sjpMwkASPyWguEeGMrVyoiOesTC/Yikn0pmD1?=
 =?us-ascii?Q?1by9jHrIAQznJxRAY45SVyVvEm3P9FPAiGAIl0ygsc/js5t7vTUeNieWkDWD?=
 =?us-ascii?Q?feFgGcN5b+9IinaXHTuhMxiWPq933HRwwpnhK8Ze/Np90rtKcAsosxSBsBmc?=
 =?us-ascii?Q?d9ZPUk9AeZ7j05YF1z2QebUIT5I//31iLTYg84TYKFNNfL5x5zt14gAYKpFl?=
 =?us-ascii?Q?3aKFsj8Ui2maofn1f6RxWtnWj1Re4f93XQ+ksxZPrHFupolNmGlkfiEYQWBD?=
 =?us-ascii?Q?vSyVBVKEX9XHxXPCZ7lWxI4LJRRl1F6aBBSWuVrnTHKCiQqHxPIpolJ2ZZj4?=
 =?us-ascii?Q?ehEfIwdUu9ORXsYVQOpDZ/GBRMuoxX66ddBCJTXGRu88O7l+WRb5dhksJopt?=
 =?us-ascii?Q?ALqjB4wM98jUXWqJvFn3UfG538vOCl6zRe/HDqkyc53ugXJFo3TAtFQiEv8L?=
 =?us-ascii?Q?JeNBZlwUuZnOQ2cgTmVXQA+DZcKZLVPwAumzXYHJW4JrhHh7l/E5KMldR2Jt?=
 =?us-ascii?Q?ny/sB4gZ7RhH9zeKUYXXp755AJi1NO1I0a7d?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:12:18.2538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec470312-a91c-4805-33b0-08ddf554f468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5719
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

From: Sridevi Arvindekar <sarvinde@amd.com>

[Why/How]
Call power gating routine only if it is defined.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Sridevi Arvindekar <sarvinde@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 417f2679723e..95af58cbb92a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -3131,7 +3131,8 @@ void dcn20_fpga_init_hw(struct dc *dc)
 		res_pool->dccg->funcs->dccg_init(res_pool->dccg);
 
 	//Enable ability to power gate / don't force power on permanently
-	hws->funcs.enable_power_gating_plane(hws, true);
+	if (hws->funcs.enable_power_gating_plane)
+		hws->funcs.enable_power_gating_plane(hws, true);
 
 	// Specific to FPGA dccg and registers
 	REG_WRITE(RBBMIF_TIMEOUT_DIS, 0xFFFFFFFF);
-- 
2.43.0

