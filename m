Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09D7C3064D
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E3610EB5C;
	Thu, 27 Jun 2024 21:14:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RjrMOzo4";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F09110EB5C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMbWcBhW5UR+RuoXRpIE4mXbcvgC0ulwJuZ+nrl207CuBFHKnHHCTSey0swZ8oiCp8jtobMARxlA35ETXtP/7Wcjv/ciZJATbIlRZJ35Rymk7CMhGtg5qunXnr/bSyz/nk2Yn1MTECQOsR++w4ca7vznStzzIUlVtDGZlA1TXUS9pQ2QpwqiScIR2bm8NcfZHrG+CLtezHQrse5mSSw3zwavlYoa29KOjZbl/cNMims2v7LpFWoTw4+EiaMVH+mtfnygLkGVUR2MXA0J5l4gmilFBj8ISla52dq671bc/YE9FvTsW1rdXTJfZuyfxnxcgRmlbTCycqALIgWSI5p/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVO2ejp5QnOPtYM2dRARH6nhJG42lBo53gg+2SZOZdM=;
 b=GJK8p0TaiE+GbfDxUi0zuskG/Ltku9iSzNYDiLLZ0+y1RFTGLsjBlo4bdqnbShTIJ/dhzwxpAkXyVMlioe0f4RfBbxG+EfVQ0URFNzKHS/b38TRaals2TUxPWRbHklRasjymUYsDFeYSsreyailEzDhwkgCcJU/pHQctvE2K9B00yhTjxbm68dygF3rG4xonN28H245NVDOubzrUBSaA/S4HjCZZGRFlD7dVUEAfjjK/m0FT7fno5bHGYGaUj5QYYTPDuhjIcQa/L1V8eyPv9yqzT70aq5oKj8uJZ73daLMDjwDcTEsPNonUJcmX1UFhzgOHo0xUPQb+jh7xJ340Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVO2ejp5QnOPtYM2dRARH6nhJG42lBo53gg+2SZOZdM=;
 b=RjrMOzo4AE9M268Qyukj6sLObEiuxSRuOKY40nmw+qdhXNubMHQRT/RKM537NIj1nO7haT7VJWzCIXwZ+UF+xozECwYDLrWoSzNZJbTj6Vz+Z+V6v9oDHR9Q8NORsX72nezMM+hC6er9+ZgAtZNFu0Yj4k6CiaJtB+on9nNyx24=
Received: from BN9PR03CA0575.namprd03.prod.outlook.com (2603:10b6:408:10d::10)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Thu, 27 Jun
 2024 21:14:31 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::78) by BN9PR03CA0575.outlook.office365.com
 (2603:10b6:408:10d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:16 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:11 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 11/26] drm/amd/display: Check denominator pbn_div before used
Date: Thu, 27 Jun 2024 17:13:14 -0400
Message-ID: <20240627211329.26386-12-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: c3864c93-ccf7-44c6-8476-08dc96ee228e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PbB+0kxWi1x2K5B07zOYo51p5+VV4sY/eFgfHqCs/KxRb9jZbuMNgjAnATuc?=
 =?us-ascii?Q?V9FYZeY9qx62LSUNr4vFq+lDRsp6P2w+jVHQY8AsN7xfFBOGuCD1jwJ/VBsH?=
 =?us-ascii?Q?3OH83GXwlrXNrwnJsaAoON3oaL3BITfo2vlQD+1IlKJgxgKtUBDGQoscmQzA?=
 =?us-ascii?Q?wZHOKLd4Y/kNswB8H38ftTC8r25P8T5pVMLo3gXX0kaJruA9nEIcaT+WJJ8Z?=
 =?us-ascii?Q?VkskxDTJq2RWRX3ox8TPqC2lzSxu+wRZ84znB0vKPv9UUg7BJOy5VEbmUuSL?=
 =?us-ascii?Q?CK7o1dqwJbgZavRbkuDWMwgmbk7Y4RegnsSfbTRYvEbO2Ej3eTU/zK/qhqT+?=
 =?us-ascii?Q?52Ru29JxqC9batf9QzZV2535HSsajRzHGTObNKiFvxcG6ewW1nDUVSP2P+eh?=
 =?us-ascii?Q?83zB9FmBZ2n+plZ3ruAWSqLgMvABKngv0MWsoarkqttkS2HOla2AekGCmVm2?=
 =?us-ascii?Q?GTPenEySNVdYKAjI4Zl2OnZ/IBt8mINUKWxxgov2LTEZiSEuPSJphlPL9XOc?=
 =?us-ascii?Q?4OE1Qo3fvuJtdZD/YZtAzlhUSqm6steefcROedafN5pdlmuaAvdfbUPEHBai?=
 =?us-ascii?Q?qFokGRnsBHVg+Sm+muQP4He4RCkcDeYEA4rDKknKnQHu4qQgP65FudvMczux?=
 =?us-ascii?Q?pVcuo7Hd17At7Rhc8vZpWItv0OWDKUBAUPsvQqeUcPHVI2z4eBx+F5OqtOPB?=
 =?us-ascii?Q?VAU00WsMRYmEv30HeQjhRla8R9QjcsIiWhNsTMsZvNMECUBSSIjgz4HGgoex?=
 =?us-ascii?Q?tQC4R3YALYPfCa+DtPiGQgNd+znzWu4J2QMOxt9AS0QM2wMzd6+uM2/5VsS/?=
 =?us-ascii?Q?P5aUzrRUH6JJTcWrfa872hf/URWnFj6SJ/IZGAtKekfIz0P74iEQDXq6DVfh?=
 =?us-ascii?Q?ZPN6ryrA8nstvznbWjgB78SKuSQPkJmA6LtmqvNjmvUM8YL2wA8csb9oD8Wd?=
 =?us-ascii?Q?9J+5/Z2VsaUs29swuvxsWRhIE4aEqBxYaCwhnbvB7HypEXmHyZSnzC1NjxZ3?=
 =?us-ascii?Q?AlDXfaKqDH9ZoYV7wF5ygldNM44XQVtr1oeAtE8GDBSSVGGFvJbxsvpCZuUr?=
 =?us-ascii?Q?2rehCrqAiF44QsDWKJB5fzgqBL0wBXUmFu0rx2Zdkrm89xvHH9t09MnEfSOU?=
 =?us-ascii?Q?fAy3uh1HllXfT8be1O643PL2lpvN5j1W/zKn3r+zcZLfQMgTPX5+5g4A85oL?=
 =?us-ascii?Q?eipUeboVL5ctKGNXwY8ii9NdoEphh4ynGSshdPXy4LuYisi4o1UvEB/Jnkp5?=
 =?us-ascii?Q?qYwTYGalOzwO/Ihy+/angqE5P2OnrzzBfAMRGKk3a2d49m7mKVc5TV2YVUST?=
 =?us-ascii?Q?5UG0jltfLdnYYS6SMCn0Gg6HG5zUsDPzBmEWsuEXT4ISvdf+kPwTeJgE5d/0?=
 =?us-ascii?Q?womRoyxw5wPJBV6HWocTikZd8QyFXk57E852948c/eQOW+Ie7aNR9bFM5uZn?=
 =?us-ascii?Q?dp4zHYWJVHNnQWCmZmuunIs878vMZe50?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:30.3728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3864c93-ccf7-44c6-8476-08dc96ee228e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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
A denominator cannot be 0, and is checked before used.

This fixes 1 DIVIDE_BY_ZERO issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 11441c1a998c..995dfd690da2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7570,7 +7570,7 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 			}
 		}
 
-		if (j == dc_state->stream_count)
+		if (j == dc_state->stream_count || pbn_div == 0)
 			continue;
 
 		slot_num = DIV_ROUND_UP(pbn, pbn_div);
-- 
2.34.1

