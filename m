Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEB5D5C0E3
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 15:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC33110E9DF;
	Fri,  8 Nov 2024 15:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fCxS+2BK";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B81210E9DF
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 15:02:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xxe2NDJ8db2Ze+LWXf+NK1BZCFhIYmzZ0QhhQjInN2GS6grkx9pNs86hPxBiRgsNvj48jhEYeYN93VngVEuJ1KDSQjkxiUiITR7PErXr9EjfSMpqkePsIH7i8816JwZH93qlJj9j37NRBp5JniqztpqYYrOvDINsKbIZ9j+UZPsoYRNjQEejgxCjtDO33oWXNtwHHy8VyHXohTpae4UETX0Xll1nfqdavuo7P758iJdJgM0zddQqNnnDehPdTNiaMyaO/k0twroc1suNHvD16z+VKUcRQA9pBpOndcJ3CV72gl8mUW0LM2dzTL/aPGgo2oPfIT2ToKsR5xQZ40rRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeAKG5vyRuwNCM6E4XvB+PHa6unZIJiqJnVDIAdNbdg=;
 b=OWPXo3ARrO60HWjcttQIj8u9bL813NUgAnVerh/Ca6WJNkWgBADdyIIrpDiYuZDE8INoi+20wsiNSWQHgiEmUhAeK1VVrSMFxUatbV0pmQamYL3TwV9M2xS/aVr0ZHZTuytLUPLDJv6r4xnU7Bp8clc4tncwOA/LsjlGgnLSMxgKNuv0Xkf8vE1lYfPm4aT21cOPXaPBG9Sf/GJ3fj98ewRP940pLO50cR8AugORnfKGaQ33+ve3tGXVgVNpBrVLPTT23LyghUil/4A0xeSfQDrTbNbtPWkYkV4v1mYumcmDS3nxMTHxe6Gcxu4x/AKOnY0er262Dwt6rucdGZ4IgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeAKG5vyRuwNCM6E4XvB+PHa6unZIJiqJnVDIAdNbdg=;
 b=fCxS+2BKFsgkWxvkJi1yZ7I21C1QI0s7twMyQ4YYwuJNyumdF3iF+tlbWAuWnClBPha9AZg1q24i4fNege70Rvkh3YkVd59Syvwq6DAwlmE597/VEloPzXKSaJjH8biGYpWrgkXZNvdVsMwoRK793ozYkxFdKuPlVat+6pzX3uo=
Received: from SN6PR05CA0015.namprd05.prod.outlook.com (2603:10b6:805:de::28)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Fri, 8 Nov
 2024 15:02:07 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::42) by SN6PR05CA0015.outlook.office365.com
 (2603:10b6:805:de::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.11 via Frontend
 Transport; Fri, 8 Nov 2024 15:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 15:02:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 09:02:06 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hamish Claxton <hamishclaxton@gmail.com>, Alex Deucher
 <alexander.deucher@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH 1/2] drm/amd/display: Fix failure to read vram info due to
 static BP_RESULT
Date: Fri, 8 Nov 2024 10:01:51 -0500
Message-ID: <20241108150152.983465-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 929f227e-645b-41d4-e1d4-08dd0006504f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/tysKT9EnemdMOAJgTydfbk+/TqEIRkCraB9bXi9IzlCrrIQhVNhN/X9Kgqh?=
 =?us-ascii?Q?kHbRIbw+L1bKHS5TvkK1DaBRCYdUy4e2xghO0DinM6Itz+pr0wH6LKhRACJ2?=
 =?us-ascii?Q?OK2d2pPl/gCZGol81N/qk2jBbz1B5VDRwSol/KR321apUqj7rH/cL1f84swq?=
 =?us-ascii?Q?pelByrVKV+tKYS/oxJK7IVvG6lOIBzahPBTzsi/Wdj+1kDnGcHgveqhfvvKQ?=
 =?us-ascii?Q?DkA/ojULr6agTD5KsarpZRM+58IN3XYP6cZ5KJ46Vabac9BnGI2xe5w6VzLe?=
 =?us-ascii?Q?24FSZcdoLkXnGZBk7WrmzXj98iLrpMuP7SBv3WeQpmTO/UsMrOBCBdfZxxHq?=
 =?us-ascii?Q?rVMKtL2JMj1OHbOkQe3BbNNbQ3iOUVqVERcQ8RrU/tn1cFS8zHNmkkQDmPUk?=
 =?us-ascii?Q?+jQY4m+KlxcCm+sUQI0MnRA8CZhSv4BEaOC6iOh4ldwrwo6rcQcqoAAmL1Tv?=
 =?us-ascii?Q?TJgUz7JS+/pEPtYR9B2A4dGEeX3KCyKWq4hLxCpKp1AXwKpEFg4tl+TYlHrX?=
 =?us-ascii?Q?sEnDbyZxXxCDpbR3AfVmB5MJCXkv9RwjWYHhtL+++Ek8pTTwRD4O9D7et4/t?=
 =?us-ascii?Q?eHQ9O0fOdDW9g/KYsPAko24YzWpnf4lzpey93RAdatGG4LL/EdIBcp9AH1sc?=
 =?us-ascii?Q?Z5ALMKOtUmJlhR2jHFNeVPg8Rub9C70YoEPNTu53bi38xmz6WGzD0jqe3tBW?=
 =?us-ascii?Q?q+2dqc2h5IP1DkUd9Yarp/s9q7ZGrGrZ21pVskLcSrcaVRm8frXdQ5ENV00j?=
 =?us-ascii?Q?u918ro8JCW3koTjmszGy3vUQTUScG8ea1tvnGmYl4Fy6h7xL9PQwY/IFl94a?=
 =?us-ascii?Q?icvXPIbU2mQ+dMzczZLNMSIgEibBOwIV58PeN2AmXaPgDQrFEmq6y2Vxb/cP?=
 =?us-ascii?Q?XJmpswanTMaMOsrK6sLuLOOyB5LIOZ0V6RIex1aDRH6E6CTL8oxRKB/ypaOt?=
 =?us-ascii?Q?NaBRZnsQbCwAZgcE6bhb4uUXXHZkpz51eW4v//5bCIktnyqKddbjwacwDL4M?=
 =?us-ascii?Q?AtUDqmFWDJI9jAQuRgd8XO70PVZO3t6bGyfU87mJ0OLPhUt6CFDsMRZMciq0?=
 =?us-ascii?Q?fyxPI9zsAhl0Or+XnVSWznTnaTatiQsWsgnzBscD0WMxNKsY09//XElA4THJ?=
 =?us-ascii?Q?dBlH4WbmCQjoyuQ+v0qEpltHNP3/5a9prLfTXjIkCdAcumQ+W0pPA/WgvCsY?=
 =?us-ascii?Q?tqsiQnJEAnie93h7csIUdllFq/PNkFmHqQ7knj85ArawNP/oIORStpQ4ZxSS?=
 =?us-ascii?Q?ExKOgvfNtNvxU971o22HVXF9blax4aU3hAK70DPZOOTWxGitzbBF7XH66Z0P?=
 =?us-ascii?Q?Bv14T/+jgY3aZ0MBRl9dgbjOJcUMm/N3q/n42RDn+Kco1JXP+imY3ncAKEFZ?=
 =?us-ascii?Q?3KZsk3g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 15:02:07.2913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 929f227e-645b-41d4-e1d4-08dd0006504f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
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

From: Hamish Claxton <hamishclaxton@gmail.com>

The static declaration causes the check to fail.  Remove it.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3678
Fixes: 00c391102abc ("drm/amd/display: Add misc DC changes for DCN401")
Signed-off-by: Hamish Claxton <hamishclaxton@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: aurabindo.pillai@amd.com
Cc: hamishclaxton@gmail.com
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index be8fbb04ad98..902491669cbc 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -3122,7 +3122,7 @@ static enum bp_result bios_parser_get_vram_info(
 		struct dc_vram_info *info)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
-	static enum bp_result result = BP_RESULT_BADBIOSTABLE;
+	enum bp_result result = BP_RESULT_BADBIOSTABLE;
 	struct atom_common_table_header *header;
 	struct atom_data_revision revision;
 
-- 
2.47.0

