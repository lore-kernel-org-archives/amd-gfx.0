Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3C0C19F4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E02611311E;
	Wed,  8 May 2024 17:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WQGSGsBE";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E62111311E
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+a6EfbwZvOtgR0hZXJyHrLhXfeixs1GFlAoIn2wPAKOitF2w18LW/tszce0Sig4gyaCubE+10dmQ92tLiisQGhJTze/f2fjrJqlT/grgEwAwQmDEpnhfUcnVCOB4R8tltUv4vK4Xvw0evIvclR3rnJ/zUODGZU6zLYGxqjPVtq83VYjM2P2IjU9jWZ6v4DpOfYD8oK3+ym4Ez9TtjagyOK3RvH/ndwmoxAHBLn6ax7noXV/UrCwGE+ouaP2nDsNE9Lm/0btgZKJFRI+b9ExAlWLtuq6e0flbaNAEmlJJdB4+ZLxRGUbd6fM4NjWgRzFfh494AZVB/QCZQ/r2MKH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mday0rxFBUt/IVtjFlYmolCdItVzcnOv9fqj86xIU6U=;
 b=SDhTIwhssyb4WsEzIWMOzvw3L+/yOGYWigKRGAvhbXUupfgNx/fx6prwcHWiqBgZM2saPJ6pbT+4D8s72PQl5rhZMFRnnznT1HL5++TSJPgrVcvhcAgBw0LRit+I/0WDrgx4ATMSPIYRVAuml3yfm4UNuzW8EQB2bOOnxoZdl5jjM88Rhq1MraQQkHLXoN5HGQN1dbrtz8s0CeBv1f6mBdmcRKs+OEP9Jicc9wqIs5sxwwc75FdHBA4vXj2339cpKtM6AbhuY+rwPKY2JsqsK/xPdknGrz14k1th3TqU+pj/HmmoMW3QxvlO4wnBO23QHbO7Al2KX7ZqNKK2psRvbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mday0rxFBUt/IVtjFlYmolCdItVzcnOv9fqj86xIU6U=;
 b=WQGSGsBEWhGScU7/SS4Fs5nDU+s/Cc/HjsjyGynKYPKd1LNASy616MN4bsfOwxAmzYwhNqWeRwZZTHodEz4JQxlULuoxCY9xOJGWcRcP7zUzqUree91n6C2QOtHc+/9oJNyDknWz2l523UVi2Ci5JP+WcNiZb9af6rvLtSUi3Is=
Received: from BN9PR03CA0512.namprd03.prod.outlook.com (2603:10b6:408:131::7)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 17:16:34 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:131:cafe::c) by BN9PR03CA0512.outlook.office365.com
 (2603:10b6:408:131::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Wed, 8 May 2024 17:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:16:34 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:16:31 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Revalla Hari Krishna
 <Harikrishna.Revalla@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 07/20] drm/amd/display: Refactor DCN401 DCCG into component
 directory
Date: Wed, 8 May 2024 11:13:07 -0600
Message-ID: <20240508171320.3292065-8-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e43a65-6047-48b5-69d9-08dc6f829c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cmyK+yT64blaoGtfO0bZJUlplr8ZnCJkhsVp0OwU7LrGGb5zf+/woaUq+lbI?=
 =?us-ascii?Q?sQD6rJCKtgAwNFxdc7Yutq0Jt+5LSAr3p93sNtu7mYSGYBBh32SKLpcLxApu?=
 =?us-ascii?Q?SIjLegHpvKshOK6WOHC1eUTTuLcqKusndyNdNmY2wu+KSIH3nSglUGO8PGgO?=
 =?us-ascii?Q?H52T6VMm+XZ+91dyPkp1oPTC9NgvF+Ve26wi1XTTd7syr0i2C2EGv6S7iq3N?=
 =?us-ascii?Q?GhnnT5Hb0u4lYoPTs7l6auNTpFxSUkq7wa5DHOAiK4sNhWVN3cCdKKm0brnl?=
 =?us-ascii?Q?FpHnXKlEZ0I/zPKoxzrYLOsFZaK9kZZzmPEP2cSmcLVm1XXp2K/6sqTRuvFZ?=
 =?us-ascii?Q?57Inlx2HH0FzUHTK7720bg40z30nCD4jQJzPPAn2Dqc0jckajaYvhmt+UqrL?=
 =?us-ascii?Q?vMstFg7GqkELygTiOfbxqmn/F1tXsY3l90XEOAQJZld1sQfapvu1Onrcz5G0?=
 =?us-ascii?Q?Vy/qvxPJ/gg0IBQvAQrEptT+yLeQEx1Tyqko5Em71qkeQbDWZMjymuKFe8Sv?=
 =?us-ascii?Q?UK6m+v46ci05OAD0A/jW2pWrlpvmk5bLZ33dhJcReVMETf2lATaVnocZpDdy?=
 =?us-ascii?Q?EpGup/aw1LbIFMswIQIuWrPjNs/tYZWkMCZ9xfN3vS0WnFDuAOwR+WK/GWHf?=
 =?us-ascii?Q?AXGzMEI7uLtJbwIRXWK3qffamPPlx4lDkP2+Fhpw8zYlzYvK+ErrhksVXql+?=
 =?us-ascii?Q?sHPaTUQQSWSs7CfU1c4GTqMOYVLKmF1w+2Zb7Sm8tnALWtBvObY2KvDkbXkh?=
 =?us-ascii?Q?g3EjKHW4U1NdgulT0bMcsEu0hHq754pomY0iBXnW/hWOAbM/1b59jul+rvtb?=
 =?us-ascii?Q?FS3tiH4iHzkwusdHHYsVlyU5nQOw7PQlFPt+2AGPg0CXbKytsjUT1JUMA/yE?=
 =?us-ascii?Q?QqK4nkVLD8cQmucgfCBojuyzzHKjaC27sVx5bOD4s05eXZV7aGcDGsFnZEMt?=
 =?us-ascii?Q?pYVqGkh8b3G/3dEhcoCf2iRn7m460seJ98V4BYkCcUsUWHiP8x2717bTYiia?=
 =?us-ascii?Q?zdOa9SZWeqxqU2pKL3rP1ciVnFVd9SUisNcTDiHsYM3rlp0GXTDwmDRmI3o5?=
 =?us-ascii?Q?fycoK+fFKGJsEkhfz1psp833wEMw6kyHAmswBkTbnZ10jQkYwjg5b+/KFCO0?=
 =?us-ascii?Q?cS3VXRpGugfsp0ateppc6+ifaG+lrAPuRjxw5GoA+zt/A2MdfEXGF+TYk6PT?=
 =?us-ascii?Q?NPd81/w6S+RJNYBHoCY9U46KMfK/mBB0LF3OHXg4N7h8P8JM8DRzfINtMsPF?=
 =?us-ascii?Q?SK7K/qQl2piOt2rVed9nkntwVZ0O1OnVIIs5nflEYCdME1igT/kB/dqqmRfa?=
 =?us-ascii?Q?uCXEGLZrbY2VR9tO3Np1M1yA706gWpOd9Ngkh5x0q2sANFawg+09FFBV01Dz?=
 =?us-ascii?Q?sZoqK8GX2worCCDyNmK7FbfPHWxp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:16:34.1457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e43a65-6047-48b5-69d9-08dc6f829c81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
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

From: Revalla Hari Krishna <Harikrishna.Revalla@amd.com>

[WHY]
Clean up the code that requires dccg to be in its own component.

[HOW]
Move all files under newly created dccg dir and fix the makefiles.

Acked-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Revalla Hari Krishna <Harikrishna.Revalla@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/Makefile               | 7 ++++++-
 .../gpu/drm/amd/display/dc/{ => dccg}/dcn401/dcn401_dccg.c | 0
 .../gpu/drm/amd/display/dc/{ => dccg}/dcn401/dcn401_dccg.h | 0
 drivers/gpu/drm/amd/display/dc/dcn401/Makefile             | 1 -
 4 files changed, 6 insertions(+), 2 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn401/dcn401_dccg.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dccg}/dcn401/dcn401_dccg.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/Makefile b/drivers/gpu/drm/amd/display/dc/dccg/Makefile
index bfdce98768f1..1d5cf0f8e79d 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dccg/Makefile
@@ -95,4 +95,9 @@ AMD_DAL_DCCG_DCN35 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn35/,$(DCCG_DCN35))
 AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN35)
 
 ###############################################################################
-endif
\ No newline at end of file
+DCCG_DCN401 = dcn401_dccg.o
+
+AMD_DAL_DCCG_DCN401 = $(addprefix $(AMDDALPATH)/dc/dccg/dcn401/,$(DCCG_DCN401))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCCG_DCN401)
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dccg.c
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dccg.h b/drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn401/dcn401_dccg.h
rename to drivers/gpu/drm/amd/display/dc/dccg/dcn401/dcn401_dccg.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
index 2e15e639194d..73544559f41f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
@@ -6,7 +6,6 @@ DCN401 += dcn401_dio_link_encoder.o
 DCN401 += dcn401_dio_stream_encoder.o
 DCN401 += dcn401_hubp.o
 DCN401 += dcn401_mpc.o
-DCN401 += dcn401_dccg.o
 DCN401 += dcn401_hubbub.o
 
 AMD_DAL_DCN401 = $(addprefix $(AMDDALPATH)/dc/dcn401/,$(DCN401))
-- 
2.34.1

