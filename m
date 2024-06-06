Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AA9C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46DF010EB09;
	Thu,  6 Jun 2024 21:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bcF8fz2S";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770D110EAFE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:59:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ip4O3Q0kusJo6Mb76g9x2e6Ixyh+WpOMozHjR1MLSKJt3ObKtgLz7+U4DTPZb1qGcZ3bXLIAeESKxMMk+Mv7hHzq+t1QtDr0H9jYCRAGNaQLn1VcVAwm4N4/yz5iYwpk3U8goVKeZZodmHPugS0BZLVwJj4LzgF9CChTrQFiT947VBip0Q4+PpVayLUbdoagNBVABnI5r1Ysk2HwsHb2TY9WzUe6GnqF5UaeivKK/FmFPbI/1UzfH9qzk0NtF8/Lkc9MGugWWFVMZ9kEuFGeaGl1+8fWjSXjrHDfCNjU2A3DZquKliGOk9bl4C5rD6kw+FornBDpZM1c3S38QAWypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TroI0P0y+ms38HVOe2dAfAjt2G0acHDaJSvCdrJSutk=;
 b=f4XyzYzdWXnAbR9PnvLVT/vlor72o82MpvdC82Kv7LGGxUjuNEuToHzxuQlhpgb7pibKJuTmgjYT2pUhty/0C8LnjDCaA4MkjbBehDC6VuFw4+yE1MjSUEOszE4JSF0Wu9HGVY0EwsF6eTEyhTFKGCw8MvFrw3ZBCzQ0QVytwfL06JlVR/7JL8CTmVnD7clho8TYP1JFRTFt4YSf0u1jHWZ3TTWEN94tfwKEvlsbi7Z0TrNdXk0KM+wEdhv8CIoJmlo9PnTLRm1tpHv/jY1G7c3xo2CnY2ekgswHO8Nq04MkNOcs/uhjq/30qCvS94Q887EqEpJCBFS7itL3iXaqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TroI0P0y+ms38HVOe2dAfAjt2G0acHDaJSvCdrJSutk=;
 b=bcF8fz2SOgrkf0bYuKxoQ4raAzQuOUvs995ZsYcNeKZ64BV1F9QU9HINxQ89NfLs3wX12xbh3lq8aHuu9CjkTitskeaeuHq4DL2yYjg6XmXnEY6uZeyYdGUQ4g0rYLFDhfB0/P2sUxZhjSAGbsg4G1gjZn4zZ63HNbjH7de4bW8=
Received: from MN2PR15CA0061.namprd15.prod.outlook.com (2603:10b6:208:237::30)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:59:06 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::59) by MN2PR15CA0061.outlook.office365.com
 (2603:10b6:208:237::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:59:06 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:59:03 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 57/67] drm/amd/display: Remove NO_EFFECT self-assignment
Date: Thu, 6 Jun 2024 17:56:22 -0400
Message-ID: <20240606215632.4061204-58-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: c216a410-1988-42d0-d56b-08dc8673e2f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nHKvWlZAA/e/j2qbaDowrrwsfYgOyVEaeLJXK2CK63a8cPbSgECKQHwWqrNa?=
 =?us-ascii?Q?ShL7U+pfl/7iJBZe2Qum/Ri+RmItLjbGTC2BbJVW+DuxWPFOyfxmLM7f0K5F?=
 =?us-ascii?Q?JfWY1/2ZeoIax6e8Aq6LtSkHQTEiCMcGJp82kttLxrxYV+Wu1JVG/HAj31XF?=
 =?us-ascii?Q?U4Vdy3/+cfmC0oxttn8qFVF263Oy/9kD7YgB/WJ6W6dvkqsAVCNym23kyQeZ?=
 =?us-ascii?Q?2YeZO4K8DgIZTDsizp+8EK0kowlxOzQyARWDybfnUX06q7on65BJHacosMvy?=
 =?us-ascii?Q?Oy2BFMJKGHQW3stp3R4v+canxc3SSaMOBKmW/VyCarv5MRFBeUB5kGiQcdcm?=
 =?us-ascii?Q?CEZqLd/fz99WsmSu8fB7Liv6BDC8A2k4iXUzZFCCprbCn2IpEs7Nq0EkssJx?=
 =?us-ascii?Q?E4GnTDnrCM8MoV/wCrZLGxM83IrxX2zOD8VNRCfSUVMLWT+u7SICY0PcdhRT?=
 =?us-ascii?Q?Mqt9SuH05lQHti7aFKewtyOokoN5kiZKQCjIrnLL0KwC3b4DeuqStaV4COPP?=
 =?us-ascii?Q?GUpofu9xgS8abQe31Aya9T5iX37ZdUeZPSEWr7qFcmjHB22senUMdP2W79jn?=
 =?us-ascii?Q?p6qEW4yACSyPoOFPhTOI+4aSC51KK8linNQAexsmf9YcIRjJZNDtM4XMKRED?=
 =?us-ascii?Q?xP1pw/2wkzed6exepN3PtXq44SHywcJwgPwesp/h9iFm/4LUhCPG6WEbyIvv?=
 =?us-ascii?Q?EHbGnd2MOM67X8z3kQn9KKDrO0IZ9Lgyd4VJmNgHP1lYEO5MxD7U+XH4VjTS?=
 =?us-ascii?Q?PqZD1dFf/BMJU24fqZ2veHHiz31YqpV/XvkBXEaeMnwWbIIujo2YTr9KOTON?=
 =?us-ascii?Q?lgY7RQtJpJ/MrfC/+r86wMo80KyApJDzAjTqT8ms9sUQpJEcHb2KXCQNd7qv?=
 =?us-ascii?Q?FBzzxWNhIct7xou8ThgTzonekmdCWAeFAaWFSK+GeYh/+VMzbTOyW7GYeAoN?=
 =?us-ascii?Q?jtf4r/gXV8m4zyUK6eEfDMUsxaMvalSwhNXJounhnLFvynWd0CyWfV4zw/rQ?=
 =?us-ascii?Q?hA+++M7dJvui0v2yXf/tGfg1pQwnw66YDgg0BlfKoPsGBnXgtqbrq2ynnXRA?=
 =?us-ascii?Q?uwpB6bVacCRHIGWGPbrjVkdDhJ/hpToEBLt+d75WvRqWZVKitKYt5jdvUidO?=
 =?us-ascii?Q?/hkV8No/zBCY4TwESWOTs+r2fiPLhvjKY7vw0jG58c/ia00/61f1al+y7/y7?=
 =?us-ascii?Q?aHua2GCvTi55Rb0v9WCMxXn4HCn/G7WvAZ1aQdRAHKOzGRzSKlpgiPuw0kDp?=
 =?us-ascii?Q?71b6OIVT+eeXUG2iWxPL4BwldXMd7bNoD7VYZzqFo3BJRq+ju1EjRbo9edLq?=
 =?us-ascii?Q?eViKDl/RKPQ0CXPxHPqaQ0SYN1f40ja9wq3KorUHvFPypiWFaiPDE9scO0wH?=
 =?us-ascii?Q?ZPM/6I8z809Q9diOWNnanjkOsFpY8+eDMq3+I4DMivBIWhAckg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:59:06.5847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c216a410-1988-42d0-d56b-08dc8673e2f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
The self-assignments have no effects and thus are removed.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 4 ----
 .../display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c    | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 2b240a30d2ec..eceef0fcb316 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -8919,10 +8919,6 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			} // prefetch schedule
 		}
 
-		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
-			mode_lib->ms.use_one_row_for_frame[k] = mode_lib->ms.use_one_row_for_frame[k];
-		}
-
 		s->mSOCParameters.UrgentLatency = mode_lib->ms.UrgLatency;
 		s->mSOCParameters.ExtraLatency = mode_lib->ms.ExtraLatency;
 		s->mSOCParameters.ExtraLatency_sr = mode_lib->ms.ExtraLatency_sr;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
index 6eb3fec87ec1..cfa4c4475821 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared.c
@@ -2647,10 +2647,6 @@ bool dml2_core_shared_mode_support(struct dml2_core_calcs_mode_support_ex *in_ou
 			} // prefetch schedule
 		}
 
-		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
-			mode_lib->ms.use_one_row_for_frame[k] = mode_lib->ms.use_one_row_for_frame[k];
-		}
-
 		s->mSOCParameters.UrgentLatency = mode_lib->ms.UrgLatency;
 		s->mSOCParameters.ExtraLatency = mode_lib->ms.ExtraLatency;
 		s->mSOCParameters.ExtraLatency_sr = mode_lib->ms.ExtraLatency_sr;
-- 
2.34.1

