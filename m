Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5D5C3DA60
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 19:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4809E10E3AE;
	Wed, 17 Jul 2024 19:40:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lfK/J4p6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973C410E3AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 19:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCRccpyPfswDWm6LaPj/LKfa7eA5o55iaFXqC+lEnu5FNu7P2KKilW+GmycVa/UdowB8guP5Ml9SnW8jtVcLMFBu7yP0fRwOzzXl46TkB2ysWl7AgrrXY4M504FYJsrUlkZOEn8OtmgIIp0RCdrbOq5qfSsaca5anfd0VeQAHkcCfJIeIG2bj8qiFL1JWPMtPTlRe0qmEqs8L5tz3aCep9HA5SjXUHr2KFU9lk+ELhKNaVSd15C1FllpcIFoY17mL5WPLlLZVXQUusSdTXq8Nerhwk+e7G1N004ejJ075SM6+ewre8quxaDeI/BbhSpYdvElZDX7/Y/2kNi5q3N/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlQfFDDjxZBtK9zZ6faNWT+JutiHh72dFV5r37UKt5M=;
 b=fd6lOikZXCpmNvHo21QdUkoqD4210xg0blcPIgzhHt4lCwK8iksjQEQOcuAWsXUV93R2cnUxum43lBhkMw5NfUC3xIPgZNu2+o/aSKmIXTuCrtW1du58bKSyHOgdzpcOx+7kylPw3IdsYOH7NtjHkcInGc5kg7Mhk2r40PDex7Iv0gOPjV/gOacVevybQ6h0BeWPGHALX/j4PBk76EuR+WcXn0ngnuhimqvkPymGhBpJEcDMCI87ItWlFd+dTCUZVqDA1Vcc/M3Jgedv3EWRUZ6s1KDP9UDfeI3hrPeYDqANTKuMlNHySN3J3QtlFaDDICknJrf8LLKvdRiRIe+X1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlQfFDDjxZBtK9zZ6faNWT+JutiHh72dFV5r37UKt5M=;
 b=lfK/J4p6Hh9q6HeSoKcmLYwYCSVM6/xrEUp/sWh9QwuWtSfoUt/q9e+JWbbTELHG91krgNkmfzIsJzoesWWqDfPAt1hVu4XreAaQcODcSFRTUSnX7ZJpKS8EAOdWS8JKk+8FzWhGmV3HWmfViZJLBUbWKXtZuIotCVWHv7C7rV8=
Received: from CH2PR11CA0007.namprd11.prod.outlook.com (2603:10b6:610:54::17)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 19:40:33 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::ee) by CH2PR11CA0007.outlook.office365.com
 (2603:10b6:610:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30 via Frontend
 Transport; Wed, 17 Jul 2024 19:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 19:40:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:40:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 14:40:32 -0500
Received: from debian.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 17 Jul 2024 14:40:22 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 12/22] drm/amd/display: rename dcn401_soc to dcn4_variant_a_soc
Date: Wed, 17 Jul 2024 19:38:51 +0000
Message-ID: <20240717193901.8821-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240717193901.8821-1-aurabindo.pillai@amd.com>
References: <20240717193901.8821-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: 28570d6c-c6cb-4aac-8c89-08dca69852e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?01CB17g5HkvakE/S1Awj8PUwCN+fRxlN19i+saLJDeY9S1tkgHxjw5Ik6wyr?=
 =?us-ascii?Q?usyXGNZ9P6TxjLHoJR1Vi3jQ5ASxXzucAPAiQGjL4flkbpZNUVXaWYevoZLm?=
 =?us-ascii?Q?Ed+ZZgmzvJfMtpP1B9LRaLWl0gUVVuoSIg6uXcNnarhrT331oP3FbXVgVKk1?=
 =?us-ascii?Q?Mtx5937jWABSG3qwrv1DurPLd4rOfqaQAiKIj5GZ5TSAWFRRvtBUzP582oI5?=
 =?us-ascii?Q?yNLJqATGG/4S984ITR297ubIEOMkyQZXVrJnOQzwTX8gwI0T/b1K7XpjbwNb?=
 =?us-ascii?Q?4e13v+n8c4Fu2WannraZr0VKsai8zYorhRA3vqao6cooBOCjUV+WUqrrl6pm?=
 =?us-ascii?Q?fX27ROvw2AVMcmBoC99uDTRdLrOKgvuVdrv7c9RQdwpJoct95U383EKKAOLg?=
 =?us-ascii?Q?HO2p9P+P8J/D+4hRB7pNkUPD9hFnGzaLx/3a78/9IY7y1DZOYSLQ1ANZ2KiR?=
 =?us-ascii?Q?3ttyXRD65st+8LmIdebWdj+qvDCWy6+tfptalV/T5F+71tXS1m/qwAz1WYUT?=
 =?us-ascii?Q?ImEJg9WWnXiafEaumxYi174rns2cOiUOTAJoGAS6We7fmXjiRhgD/etN/ffs?=
 =?us-ascii?Q?O5fpcCaUM0lySja4+JKfDZIViBBrnK3/kzkE+fO65sjMQD1Npsd5ss3wIvai?=
 =?us-ascii?Q?pQRaRNxqDgHM+u5Kgx2BR6/9XfqtLBqZOkzBFhMYPeECQXk1Igqn1v8c+cL2?=
 =?us-ascii?Q?Y5j1UA5AWmZKPchL3fbWg6vazX27JDauPlc+mE4on21irWALDkX/RITmCv18?=
 =?us-ascii?Q?ua2VI396hsxonaVwp93KTIOc7iO9xnAr29Qp8IQrbQif0r2GFzjUHtk+w8uq?=
 =?us-ascii?Q?mEH5MwhMg4UFKt/krvchiNd2/BefGsTRTH/dIxwbEU+TDiI1fdu8uU5QkrPO?=
 =?us-ascii?Q?HX9B1dCBJnxvV1MBIW0yHHERwVQWQOveBHAdgxYiIhK9Pr8tV3Cfeeac0O6b?=
 =?us-ascii?Q?qsSZhKsJOXpJNaxZ6DUJXvAOdiutO1whIYP28XtA1jKbbtEIXKQLKI2AmcKl?=
 =?us-ascii?Q?HTgUVPiVP1a/FYByrYAXZgNjQoTXwygP/FBG2VAuWvzK0QdYfK2wvUegJV4F?=
 =?us-ascii?Q?zSpbyuqqKsb+jqzRZ/PsYPGy5cIT0r+QApdZEADPWj//e3Tgw57uztYvKb4i?=
 =?us-ascii?Q?YZ8/K2Ml1LeJt+jTWKyfZaefnRj9Wg/YJW95VzcjTQPi7dFDbdAfsFKGO6kG?=
 =?us-ascii?Q?79H41+QCXcvKuZ7l20bCWeMU+dDoV9E2P0G5jMJLz3OXS/Pp5vcNaeoYegJk?=
 =?us-ascii?Q?YhSecGl71bzraHKFH8StxLai7sSFxrkKmz7c79oAyDD9wEnlaW4iOUS0FW5l?=
 =?us-ascii?Q?qGMI20E0z6JZSDiIZQ4zyha51vm9rRIgm55co84469mWyN+VCFnwApX4BOut?=
 =?us-ascii?Q?lIqfebJn7u+6Vz3qCcfd1BJDQN3NxpjzuEqY76QOOrENgS6uKuBKHWA7f0WW?=
 =?us-ascii?Q?N0NZf+HIml3BWPmOuwbHYNQcgIeyMxJE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 19:40:33.4820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28570d6c-c6cb-4aac-8c89-08dca69852e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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

To distinguish between different soc with same DCN IP, use variants
starting with alphabets

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c    | 2 +-
 .../amd/display/dc/dml2/dml21/inc/bounding_boxes/dcn4_soc_bb.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index ec663c7442e5..4164cda90b2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -31,7 +31,7 @@ static void dml21_init_socbb_params(struct dml2_initialize_instance_in_out *dml_
 		else
 			soc_bb = &dml2_socbb_dcn401;
 
-		qos_params = &dml_dcn401_soc_qos_params;
+		qos_params = &dml_dcn4_variant_a_soc_qos_params;
 	}
 
 	/* patch soc bb */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/bounding_boxes/dcn4_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/bounding_boxes/dcn4_soc_bb.h
index 0fe70bd0dbac..898b1dd69edd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/bounding_boxes/dcn4_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/bounding_boxes/dcn4_soc_bb.h
@@ -8,7 +8,7 @@
 
 #include "dml_top_soc_parameter_types.h"
 
-static const struct dml2_soc_qos_parameters dml_dcn401_soc_qos_params = {
+static const struct dml2_soc_qos_parameters dml_dcn4_variant_a_soc_qos_params = {
 	.derate_table = {
 		.system_active_urgent = {
 			.dram_derate_percent_pixel = 22,
-- 
2.39.2

