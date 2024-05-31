Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F00C25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35FE710E3B9;
	Fri, 31 May 2024 16:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gfMYfcYw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 847ED10E583
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7Fxi30LBaKTpsv1I5InOUlRZU/yZLLLF9PHePuWHAxAWmRaGkh38Fc8GroiohVzx+oiP72En3XsPIxRCUL/L8wzHNGM51y7P04Ov+V4jxEG39Nft26tpajhkMRfISeVDzd/MliWtclqy5xlLFKDRWKd/aewmz+P9NDb872t+tD4MvXhsdqJhjzc8xetQlwJwk7EBN/B9biTewMR9vwwrBXaw3lFOZ2MYjLETGQUmDewMVk4UQ7keFEsuAvqy7mSCP6szyFEsLV0RTLswAeeOTBmlA52xzdokVKXzyFLx7LJ/zps0mlluYYtiyBslmsRmmkp8Ptgy9n3CRRoCD57nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHrVKzZVmBFJiB11dwKts5VPasGkbadvrbYFown2mL0=;
 b=NRl9teJnQmqVAgHZ66eO6hLmE6xiqgkdTZWqQr+9a0yEcDdz71xuZUe6GwnUWEvY32yxFTXJudA7mBAsMw3vModBY6LeTWRF3NzS+tBo3SEwY/GCtF0pLym9e5esoqSSSn7VfWjvR/qryNyBmqQu4Gz1hL1RR2BmoNs7FU2HjtDXfoeIJovzeZNTgubDLCmd5aioldwA29iWeSzpJArQk+3Y03zL9mWwMvGDAyaMfFBvnfJExlWspRPE9k4Q5ZP82psUGoM5A7pqPD07eHrd/jjAs5q7hYfGhBj5vIOE2PI/8yFg9G+CLD2ZTMo5bX4JAgxNrLbmGFEE4POHk2MkSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHrVKzZVmBFJiB11dwKts5VPasGkbadvrbYFown2mL0=;
 b=gfMYfcYwuRxJ71p4HBdrBIPWZdBkCbAkYyJoDW13GfKQmcV04JiVGwRC93VWmtCjCFlsqJVKUqN/ADMPq5UX9WrY9gQCFPiqpNGsm6D0frBEq281Kpp2q/09vwUx9FWlaZs1Yrkbx+EmV03C7gj+uIwAiA4pwd2i/L08dI4LYmI=
Received: from PH7PR10CA0002.namprd10.prod.outlook.com (2603:10b6:510:23d::28)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:52:39 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::4) by PH7PR10CA0002.outlook.office365.com
 (2603:10b6:510:23d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 16:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:38 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:34 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Relja Vojvodic <relja.vojvodic@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 14/32] drm/amd/display: Updated optc401_set_drr to use dcn401
 functions
Date: Fri, 31 May 2024 12:51:27 -0400
Message-ID: <20240531165145.1874966-15-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 8994b755-bb21-4acc-3565-08dc81921497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|1800799015|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4GrWEIt/w7TIbacReAPCGV0s8LkK5f+cdWWZNii23NYyxNpL2znDF+N1cn6D?=
 =?us-ascii?Q?0Bk5KhzcjGdXsuayvDDSNyokFYIJx+2HM/07A2Jf87Rut5jQH6Gfpvq52NqQ?=
 =?us-ascii?Q?48BGb8SbhgvetKp57p8LC5s+rKhoO5D3+KWz5BqpgFnRKPP7xeO2e5SKqHya?=
 =?us-ascii?Q?qdq4WmPEh6c5ICK2TAY92ugvMp7w1yftXIrrtgFpetMGN1sQUJWZ1VzzTHNE?=
 =?us-ascii?Q?m5w8jPJ/JPbI2fDgWUWuifvwEm+nA67CyA1vSDzafG/2oe2Mrh2JnufqpVhB?=
 =?us-ascii?Q?NYss4bk8VCxoAIJAw5VdAMSuT8UhNwB5iAyocx1X9ZFneXMsSvZw/GaHQAal?=
 =?us-ascii?Q?vFtaaTunkeyybXYAceFriGSlb+T30BY1s0MrtCbSMcGTYaFhxqqr2rknksTL?=
 =?us-ascii?Q?zGsMrZQapxxKmhTB6MGRdu5SkOFQtO20yklv23kVv2CeYec4Fdx/wQSm7g3+?=
 =?us-ascii?Q?NS0nE26w2lOwWi6kPILE0ftrFV+9D0iDPnaczuKQFjHe8s9XDmDEEyImmBAE?=
 =?us-ascii?Q?ugHsMkpsUhnRP2WDCY9oGKgdqZ/HAfXMkNdqBIlza6CWHkO3GnC/HAg1E0Q/?=
 =?us-ascii?Q?4jxclSNeMFDMkDqEXlRV91SvrWr1ZRQko7bKKNY+ZlhNtXVQKNyEknIGuXdf?=
 =?us-ascii?Q?dmmqAUiP9DJP6m0RagzQATksSylNQ8nvX1AgRJ75ehZwwGpPOo/SqaE5FoTc?=
 =?us-ascii?Q?IU/Oq4buMNB328Y5QUPUmpSdQLugQftZDfcvWdl1So6CA+BSjMyGtDI0WFPK?=
 =?us-ascii?Q?pOLxAC7bd4ucAP027lNLV9Red+XwUadOtL0s+3Rj0mPgBaX7dm0XfS8qNLYl?=
 =?us-ascii?Q?k12zBE9QLYKqKp+oW3VCTaCvVy3/m4f9d5ysujVu8GdEzGUGwfsUMeGFZkQX?=
 =?us-ascii?Q?arDWX96GNV2MebWEu5Lg6NoTwplTCUDsYni7F/rh3HG+asl/Y4gxa9BYw/Gs?=
 =?us-ascii?Q?2wj2VUtvFOlzQgWYgRq4syMiC+7yuc8TPbwZtn446j4/oRy282M+W4bXNtuv?=
 =?us-ascii?Q?C19zAi3kxQo3qcWguL4l/BhvMBGWBJze07TpklGFV4rnsAyphG0kAnb8xyY4?=
 =?us-ascii?Q?6TKmxnWyyIIx3jK4c3BBj7JDCtVTFdZX3O9P0Vu0dlrL9iae0yFV54zXZZx3?=
 =?us-ascii?Q?WImoKzP3faWZvT5tHXakNJ7IzwFZuEsE0kMxdL2IWNQocrS2P/Bew5qizqIT?=
 =?us-ascii?Q?/3t1BETVXaNEVoobYemOmSZHcwdunMIgvqI8/q82ZVNUHyE6aCq8sZ8VXjUE?=
 =?us-ascii?Q?/dKvo8FOng9LvqUal/Eidl+ib2eKc7cJj9wOBj17wBDimcuGber7zumXmkMm?=
 =?us-ascii?Q?QXuFmxi5O1T3Nge7V2jJz5jDRmrzCBtJVjnykZH5rkVfdrEpQi1UvgRlPw77?=
 =?us-ascii?Q?Sv1MRvllTUcs2jHZs0l0UUDfAwTz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:38.9492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8994b755-bb21-4acc-3565-08dc81921497
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
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

From: Relja Vojvodic <relja.vojvodic@amd.com>

why:
optc_401_set_drr was using an old optc3 function to update vtotal min and max,
causing crashes when disabling FAMS2

how:
Updated dcn401 to point to opt401 function for vtotal updates. This version of
the function has FAMS2 logic that allows for FAMS2 to be disabled.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Relja Vojvodic <relja.vojvodic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
index 8ab788b6e6c1..fd1c8b45c40e 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn401/dcn401_optc.c
@@ -430,7 +430,7 @@ static struct timing_generator_funcs dcn401_tg_funcs = {
 		.enable_optc_clock = optc1_enable_optc_clock,
 		.set_drr = optc401_set_drr,
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
-		.set_vtotal_min_max = optc3_set_vtotal_min_max,
+		.set_vtotal_min_max = optc401_set_vtotal_min_max,
 		.set_static_screen_control = optc1_set_static_screen_control,
 		.program_stereo = optc1_program_stereo,
 		.is_stereo_left_eye = optc1_is_stereo_left_eye,
-- 
2.34.1

