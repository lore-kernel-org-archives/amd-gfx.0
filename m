Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E7DC624D9
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF59810EA7F;
	Mon, 31 Aug 2026 18:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2nFB3s7/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F64810EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdQpGztFKW7OOhNfbz0WcUNHWerv0poO0Cqlm/9hitMvvc0HAKTvvL89g2y/VrZWDw9SP6ygPsloqR3o8hoA1uae7pPmdlWPCLW9QjWjL2LsFwn2+bMbTGrJ8FL9EzctMw32rRkxTKFMtHuH5A/8erETSsvtT3pZbmb9ORNkZy3c35iM5Kk3qOMcuRQncJDMHGN4wKARsyWV8RGiQZ6mC0c3MEQ0ZXaVI1OACdGn7luiPWTWHafEt1u+H3QjLAZIvRd/2dmgyNiVU24LptuEz4v/fuKRYfNuIURuULgj5uWhljmbxMA/ObGw7emX3c1jUhUiY9SQEgvx9Q/Z30noKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22QPZ5Vxi3LNwf43PfldplImoFoVCvr1V8whQRtq3YM=;
 b=eCV/CzwF0mw6lxtAPMHdazKYFZGfL1Y+z2yxfNo1WNftbZvVZusnr+7mRNZIEWKqpYHA9l1aKn0vOvqERdobFJ5Koww9cYbY1x/wDg9Ln+oRuFrtHGggdiMqg8CPrmgL8amSQcaGZsvq/Q1UhSYNqngNzX4J+ujrmoiY9NaZnOvYZVK9NKmtubvjthJzYKkw9dUlYFI7J7V379Nlttfn8YBX8MUjnPnOKPglXEO+W3Xr1NKj69tPDlF4OLXESsPgpmzkjTEQk3xgyXlDv/SE4e8VKgNXKjzesuTYasYlapC9gbjZ452q5THPNHuOCOWPgr94TsRVuSreVRFovl5SxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22QPZ5Vxi3LNwf43PfldplImoFoVCvr1V8whQRtq3YM=;
 b=2nFB3s7/egqXKDRfKjgLi6F1ORABppSinBFEWlVmi4i8Y7X8yV3JAxRft1VGyEeSnvHkQFrjusJ2sUq39XeqvWcIn2B+dkaXCBhatVNWhv147jL9wsHT02B43nbyJbuPevUn2kD2h26NKI02VHsH7WaI8F6ORvcWiFW69/m2CRw=
Received: from BN9PR03CA0661.namprd03.prod.outlook.com (2603:10b6:408:10e::6)
 by MN7PR12MB288644.namprd12.prod.outlook.com (2603:10b6:208:636::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:01 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::48) by BN9PR03CA0661.outlook.office365.com
 (2603:10b6:408:10e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:01 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:49 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:49 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 67/95] drm/amdgpu: fix dma_buf leak in UALink exporter cleanup
Date: Mon, 31 Aug 2026 14:27:26 -0400
Message-ID: <20260831182754.1089811-68-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|MN7PR12MB288644:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0dec09-2eb7-46ce-7280-08df078dbae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: Hct7hsbyD1bElpOh/XQb6vCGkJb0LcZbJtaquC0YTWT1SGt6ViRuy6+mgxcjAuJ0sLAHR1x1Cao5XfouBMV7GZm2R0YQc/6MiRWtKMi2mhgM7N/Lp3dwbL8sc2iTzGTYqiy0VQEsWKsofFzJ3sVsR7bCRuZJsPGgoxu6knUI5sJ5B3oefylTrFgcT2tpk7LTxc+iqUbKhD/Htx/T0cJfRbOfyZoU6LF6IS0ZpgsLZn8xa5Xf3PiPBiJSEEUyRBkEXblc2QhxsdOr7z3cXzK8Knxpu+j4vxjOI0AEqg/oJfMlXrVSW0B57yePA5D1ujHDtbkSBsk1qKleQM2tYOuZ3stlcQ9UojO2lSgtlGPIEl4gBv8h+pb7Js9x8egwVGmJcvMq2oWg0QACTp4kVSTR2XQOr5fMN8oGCIr1FRhvOPD/GuQoZ5Uw3YniqP0XofGJEbf7ZrOoG2MzylH8Fjh3m8ZEj4wXwSte48EmDtYitHFlhTICRZWoWbY38+S8zWw5riSujPN1r0WsYUn2UDzAqwDRdc7eTu+zQ8MHM20vXYR3gxrhZWUq1wHY0rpdruDj8d9NCSEGIChQYpk69B97+NMTdD92G1u5mjM5gHf2rR/GIojCdZNYLz7ugU/o6gu+N1TQZKaRzLx1+DJ87o6PLKBhnxUPwZzfy79xn/cWsgpY0Y548z+RpZxlxpT55HL1kw/Psf7HcFBf8GT7I0YN7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UdmY5nCiQ0ryzr8CXX7Dx+yv0xc53+MH7XeFQ29WCL3tujvqwIhxfCBUkx0eBqmSyRq2VCSwVjdxx7y/pn0KrDlnkc+1ZOJozc6kKOpWCQ7xbmVAG6Oee+oCU4K5kK/CZ9OeInvrW981sTiVq9j9LhQidCJRRuo3z1ISi7Yuf79WOmSpN4sJO7xjEtq491SkxxtrOMH3gonyMP2tZsYPInpRglKMWj2HANcDJTQpNuHm3dtYc16hwzIXrzh8D+06C5EZMEb1l4q+mKb1cdzi7b2npAToBPnLKkhfcRCLYWtoSaS49s0u7tOdVzqDgGKAggNWdvyqISD0270yjdy+xifLmqbxiLG8Qxozy+Lf0YX+Qeg/aWtARJm6++PPqdaFTgcF92ArfI681DX/rc6DVP+3munXv3DDCuwxZzxV5S60qmzchejLQv9d1oVxsiwy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:01.6756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0dec09-2eb7-46ce-7280-08df078dbae4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR12MB288644
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

From: Mukul Joshi <mukul.joshi@amd.com>

At export time the driver code always builds a dma_buf for the BO
which is then shared for local imports.
During cleanup, if there are no importers, which is true for local imports,
we never free the dma_buf thus causing the memory leak.

Fix by dropping the dma_buf reference in the no-importers branch as well.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index be38e9ab47a7b..84e556e0c4d19 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2267,6 +2267,12 @@ static void amdgpu_ualink_exp_cleanup_worker(struct work_struct *work)
 	/* If there are no importers for this BO/handle */
 	if (bitmap_empty(exp_xa_node->importers_bitmap,
 			 AMDGPU_UALINK_ACCEL_MAX)) {
+		/* Release the dma_buf created at export time (used for the
+		 * local-import shortcut). The has-importers path below drops
+		 * it too; this branch must not skip it or the dma_buf and the
+		 * BO it pins are leaked.
+		 */
+		dma_buf_put(exp_xa_node->dmabuf);
 		/* Drop the BO reference so it can be freed. */
 		amdgpu_bo_unref(&bo);
 		exp_xa_node->bo = NULL;
-- 
2.55.0

