Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C37ECFD2F6
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Nov 2025 23:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1663310E002;
	Thu, 27 Nov 2025 23:45:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zguewomp";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E447110E002
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Nov 2025 23:45:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vd1zaldqVtapNte325CPU3J++Xlu+X/uKvSpQDjx+J+SZocdw4Q8DIOVBvODX11YF46zRaWi3dDRSAHl9xFaiA5keUqQcVDFtUBO5D94eOuNlnDnZ05J/Lc9e9nDdAa4mXdueQHSgnM/yD7Cn90Fi9H4OYQViOEknA3BAVKZqP6AV1wvvjuEZS4Ta8TWZTSh6GxH0LPiQSoRGhpOISVCPNOUt2/q1p7HwTc21ylifGHTV8nseP3nRc/TUgBoh2bmJqC10igqXj2wnStN5Ew6EuiyJ0h9z0+cRnoec9uFev9k1B2N3mQv42GRsTzntsQ6W/kJzYV8asbf3gJC5NRj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEBKJjKKDi4DI3vUy1eh3l8e+1fysNBrHLDzoS/ihSc=;
 b=YVGym7mi7UbRfnZ5dXT39G0WIQtpIE6Ga5nbWvYZOzsVvj3OxiwwrWVdvYgPWoj9bmSN9C0rve/RKjJ3430Xu41Cb+KX3yks/PFjLL32VSVoAQPsG63GXNErVqm+Xcse/tNmQhiEVBkFoGWOQdiVvdbQhsEHW6+Szz65RlUHZmcazcjPYsx1MeDiq5uWcGnBrr5GjPezgA0xLmmrVohYIs7sXjfBTArghe4EFv3o80gTORPpQgYIwbJnuPBUrTsrBVLxJfbCTU5B+t7oabKOwhIsMwmVORqpfkjc9x4QGHUtBlEwnR5c0H3TgENXx6f0MkOfYlKwCmJTwe6LX9Ze0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEBKJjKKDi4DI3vUy1eh3l8e+1fysNBrHLDzoS/ihSc=;
 b=ZguewompHZ8NbO8yUGasnJIGquDwK+WcjEwc4H86vf39Zbf9XNITzbGoYWRK20cYLyAXF2d23dvg/7I7ThIgt5PRiGe0GEcNvTllu/cnrzNUA9LARgVK+bQ3IAEAxetL2UzZZFjFGRAlnqMDQ1KuoyJtxmcQA2Xwpla+UY7Lsz4=
Received: from MW4PR04CA0168.namprd04.prod.outlook.com (2603:10b6:303:85::23)
 by CH3PR12MB8401.namprd12.prod.outlook.com (2603:10b6:610:130::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 23:45:48 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:85:cafe::f6) by MW4PR04CA0168.outlook.office365.com
 (2603:10b6:303:85::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.13 via Frontend Transport; Thu,
 27 Nov 2025 23:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 23:45:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 27 Nov
 2025 17:45:46 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 27 Nov
 2025 15:45:46 -0800
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 27 Nov 2025 15:45:46 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aditya Gollamudi <adigollamudi@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>, Roman Li <roman.li@amd.com>
Subject: [PATCH 1/1] drm/amd/display: fix typo in display_mode_core_structs.h
Date: Thu, 27 Nov 2025 18:45:42 -0500
Message-ID: <20251127234542.19547-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251127234542.19547-1-Roman.Li@amd.com>
References: <20251127234542.19547-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CH3PR12MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 605fd90d-88aa-453c-cf73-08de2e0f16e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZENsqdGMhC+ko5q2M7tCY3vBKB7Yomi8hvQ53R1MBdWzyTf132qOWFvhYJZh?=
 =?us-ascii?Q?/FsELlD08kH9f0O4k0tmOh0Y1dMeH3ZrW6MSktIQXbTwBIohy8WGhKCaH9eW?=
 =?us-ascii?Q?u6ShvF/R/M1Ywhf7yVBiFNDpj+4Qlw2Sr3DJEfdapibyQS+1SxhVQ9cwCJX9?=
 =?us-ascii?Q?uVfeLtIrmeQpTRThAr/6GNN39ZPawKFS0K6ox9TkTSbWAmv7yvUlfe375m2X?=
 =?us-ascii?Q?byBVTDkeih96HJGM0N8zgZOO0rpJ21URDRAHAYrLBazqCP7UbCYTK7UoZ0hU?=
 =?us-ascii?Q?kVFChy3ovd1K6NE/AB9xSJ20hUMV6DW/gW8MnRNRQ0nvUDt4DxcFD4s5m7fv?=
 =?us-ascii?Q?b6wMBcLRcWlsQgy1qv2hR6FdFHKcdBSGzV7n9OtoS1/DQ1K5jU3VlkxVnYoZ?=
 =?us-ascii?Q?bY7MjYLrUso/Rdn+LTR8zxczcb4N+jEywysnlJzRsWRRc+zy2EpFtdtd/h/I?=
 =?us-ascii?Q?U0P9CZiq83gtSOGWtQa2I2hNz3CZgqMMyPZwZzDQcUoxur0xl8O29f9ku553?=
 =?us-ascii?Q?bKQLkdzVGb7x/m8UgS3pS9ItxA9Xim8O8RiPwCGAODXKHmzvYu+04VlereWv?=
 =?us-ascii?Q?NmxpLUX2GpzxG/pg6hZtixNIoCZGw5QDW1BeBL144BSVVJ2DQONly7B8Djw5?=
 =?us-ascii?Q?YxRAnfCajgknzSorP9kwGH5QvimUzDoMR1tSBFfBY6KQAAha/qrdiMzY29Vx?=
 =?us-ascii?Q?PCqJdYHYKAYvtATcP6I7LHmuolIvUUWU0To6+vqXfXdWF9cQdZrkQl3B25vQ?=
 =?us-ascii?Q?D12q49RwkuHERHK2zEZ+Qy2HfFRrk24oOAb3ZwpgORrVlVYtTF5xcfXHjB7b?=
 =?us-ascii?Q?GWFQS4nFfAoo/1U59mnhvdSF+62hHdKaoxVN5/pTUGy+suU4JNe3CCwY8sSN?=
 =?us-ascii?Q?dY9sDpJrQPefJxBxDV7QJj5bZx/95DmLTziAgF5jfVYOst1pej479qPxJnZv?=
 =?us-ascii?Q?I/RE5fEEs607G4QHTSDO6UMAVIVHwiviMi4UysYhOuNqA1ssDpy1JNsbIWby?=
 =?us-ascii?Q?QMf2eaAHsa+o3YBzJ8uuF5bdtCBfDzQ/udZ94SeZVDDgNLE/o/mLwBiK9ZYO?=
 =?us-ascii?Q?91Sm7o/WteoJfK5pS/721GxmSEKv7Afg94KWfme998FgLjCrOEWz624uMquX?=
 =?us-ascii?Q?HFYuG8HCxLlJ72ue6084swlbqR32OyDIyUpT3fsoKHnknl3a/f+BXm+HCsIz?=
 =?us-ascii?Q?RXPk7Q73FD1l/vUAXuzDTzv/ZT7XvMUjrkBhfjQCO7qQVE70rEmh4oIgsR7/?=
 =?us-ascii?Q?j1YwTClKt6omhyFlpSLB8Z8BBpyDVkzHaY0FihK2yvA/R32FJsAnstm4Mxrk?=
 =?us-ascii?Q?1u7VtZw2HqeqllMe5hxOceDdWLMppLK0HxdzSQR4pY/RhXqRc2mMUkwTB5kn?=
 =?us-ascii?Q?yp+RlMJN4qaozZtVVboq4hcTjHxNtJ8dhjnzPz2JujHi7YweQxPlDzaGsWzW?=
 =?us-ascii?Q?tDdcrirO+wys/cYlQW/45tUf0hcYfzc/2LLAyBe1+up5Taj2r4ULPQV18fEl?=
 =?us-ascii?Q?swHT7WJphnOM0zgdqd7YkvThM14qSPSO6OwaxFAmaLKzI7NSpTWvM+BdkAyN?=
 =?us-ascii?Q?SM8ph9Vr8RFm8sevSsE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 23:45:47.5413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 605fd90d-88aa-453c-cf73-08de2e0f16e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8401
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

From: Aditya Gollamudi <adigollamudi@gmail.com>

Fix a typo in a comment, change "enviroment" to "environment" in
drivers/gpu/drm/amd/display/dc/dml2/display_mode_core_structs.h

Fixes: be741b1539fd ("drm/amd/display: Rename dml2 to dml2_0 folder")

Signed-off-by: Aditya Gollamudi <adigollamudi@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/display_mode_core_structs.h   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core_structs.h b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core_structs.h
index 3b1d92e7697f..5b40dcdc4406 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/display_mode_core_structs.h
@@ -1893,7 +1893,7 @@ struct display_mode_lib_scratch_st {
 	struct CalculatePrefetchSchedule_params_st CalculatePrefetchSchedule_params;
 };
 
-/// @brief Represent the overall soc/ip enviroment. It contains data structure represent the soc/ip characteristic and also structures that hold calculation output
+/// @brief Represent the overall soc/ip environment. It contains data structure represent the soc/ip characteristic and also structures that hold calculation output
 struct display_mode_lib_st {
 	dml_uint_t project;
 
-- 
2.34.1

