Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A9BCD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E8410E234;
	Thu, 28 Mar 2024 19:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CAIcrUuy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52934112536
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiOs8UIarAnWAmSGmeeqrbenJlDYwWSinunG+ymwpartd9CNUjiw7+LaHxnW0d/hjn/JfTRyAwg4tOvACgESZwd9cJTcRsNmbBE+F5SYUMkM7wtBMR/i5fn9elXozLWLVnsCiuXq1A/QiRVFq6wWk9BDYrwgHf3hN8CKLAq06ElFC0TnKeFrL1pP7Hf6lQsbHowvy9Ut29AOqAtkUUGxmQlavku145Me+TrXzQksW4YUpBtAR1EBgL3pnw6OYdIRKxPLqLflRzJ95qXls1BVFKuysA5GJ2hikjcPb/IO4NY/IcPcgzZEEedF9nSSbyeDI6x6Z2Vvjlkp3zXNp7Vb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIohanc6U97dsdnzQShIgdvgK4PtlNWvqUHXjKOIzC4=;
 b=VHx/600U+8sKBzF/420fFKTy7ayqKFqhxdWlMFmZCG/WaVcATy8GA29Q2ET6Bj/sBs0LVMBL3ctM/xXR/H+4p+10bhUJSxGxNMYYN60vhb62lfObia1lqFM86kQQMJDJPur5Z/o8U+TtB1bpbAoLfi2Y4uFYwTaxpW0KNKfB74IPqNZKo/Iy0dwEJnYnFSOfDdvjrEHw8vUlf4IHQ8pufy+zLHJYcOsHET3os+9rUK/2/oxQ7gNLExahbegTdVL+WfsTDFex3ZeQfpeWRJ6AcLklrSCfef1a07C3IensVLTNYbMCFTGZC+v26UX8rDhbUnVUWRxY07widD0LPwbFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIohanc6U97dsdnzQShIgdvgK4PtlNWvqUHXjKOIzC4=;
 b=CAIcrUuyzthDuOXyjfi+WjEtMR/1AUiAPZPy0YTwReIGsYKQ1khWlz7tG4obnEXnVLfNKQvBubFjcLxORAs3/yyufdqcsNlnqMqCM13Jo2DyWAp8rWTXO7XvjGbsviX0cN6jpsTV39Sj66kpESMn/IZo9DfNihbWXOerWecCQi0=
Received: from DM6PR21CA0008.namprd21.prod.outlook.com (2603:10b6:5:174::18)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:52:14 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::cd) by DM6PR21CA0008.outlook.office365.com
 (2603:10b6:5:174::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.8 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:12 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:11 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 43/43] drm/amd/display: Enable FGCG for DCN351
Date: Thu, 28 Mar 2024 15:50:47 -0400
Message-ID: <20240328195047.2843715-44-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3e2ced-a041-4d6e-116f-08dc4f609090
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gma2tWfIraBkINnuYNhW8Ju7e33gPoEyzLoqayKT3xtbnQxXYFGUu2gOpi1eaj9H4keUWcmvDQ7BoRJ4c6hUKjInm9vZjNnTw87REEOpqdTFowXNFcUBLXdgmbYkIWlFZ1RNHv/ZZnurCd38YPh4A1rEwHg42VkJ2bzBZ23Ie7RK5PcDqdQaTfvNx/2D+aaTgrvznGoOnTOMQ8OXepL+921ZKT/EZ5gp2E0bIZFgczIhJ1DtFWGMH3hci4RBrMSamGMAkaVv6MxDUv2dp/orK4sIjH4CYAg+RauXVQh96Q5ttcBcn1GeR3jxx2BzpG0C1opMYHEiRRdNq80WIMxOtahBlt3xOQalts23mKmgHL8AEcq+3VB039nmANFdbzskTnoXK+05dOwPT4nsRN58on2HJVFpmzFFK//cxKml73MsCfuuJDzMTqcSbWcdBpqSyTP4+JFlHh8Tx7gvnIIOXXiMOIEPhEVp9D1sf+s3waDVWAtafnECFiD4qy9W8iZBBJfS/iPOJuc6uyYV9DX5p1etsGGM7lnMeuVqH4M/hLWmCIlKuL+y+cl/w+YOcyG1K1kML2tpuTWg5P2N1WLIgRIHnId/FXav9XUdwytGw2wrkLpjvRvtqpAWFUeFY8qf0tbm10B+hKv5NZ3E+Q3V1j6q4PYoKDbx0H6O4eg8lFq+ka1t1VIC8RXan7S1ffGLl9gkXzbpUQj9YE0qwzdfYCocXDdc0W0YAme/sFKz07JcN8f1Zq0pmDzESrJV19dp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:13.9177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3e2ced-a041-4d6e-116f-08dc4f609090
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 66ab6aba26aa..8a57adb27264 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1893,6 +1893,8 @@ static bool dcn351_resource_construct(
 	if (dc->ctx->dce_environment == DCE_ENV_PRODUCTION_DRV)
 		dc->debug = debug_defaults_drv;
 
+	/*HW default is to have all the FGCG enabled, SW no need to program them*/
+	dc->debug.enable_fine_grain_clock_gating.u32All = 0xFFFF;
 	// Init the vm_helper
 	if (dc->vm_helper)
 		vm_helper_init(dc->vm_helper, 16);
-- 
2.34.1

