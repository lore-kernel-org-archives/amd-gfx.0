Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3569C19F4F
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C75711311B;
	Wed,  8 May 2024 17:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rsldlXs7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 857F611311B
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:16:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5NWrpG13XkNwSmQIKM0A0or3hnNVaruca4BUrpTfhWTrxRo7yi8HPo43jbIl9FPp5k6HV8inSqZK01HeVOJzYzM/UQImZRjPV3oNGbBzOtxhKzl0SIOhKDZ9lO/5Qp0nHanyYJk0RRzvOWh7uF2s/JZhPdMh4RFliqE7woj+OkACN0KGsBYalTy/4Q+5GOSngfJnodT04bWZtb5erLPtA0CCy0PTR8cdB69SmPNvL0KQv9vUiXT1saLaSpUdJDEpXL3Ii6QTGggAYU7Jvn5uTNc89+pHq9ynQ+OyxNA2zjhDSxon1W1aFurD0O1DWzhwv7JzLhnvQoFKCo2ZedejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1PAPKMkL0IqBkUL9UB+XyWHylG6564ZRRsofxPlZvI=;
 b=GafIkuVthYChpincfktsIM4r8LeIV8kux+5exXbgFRBiEgEUiCbV+gJou+EiZNpNHaj3aS2w7lwy1Asm5h9p2N/yzctkCZp8glGeB7MsRSaeVem04EIpzMl0FGsZQzcnIPPpzLWn4X215jxcEnONX+Ap5Evdk97MZa8zunl+P3ZTIR17q7PxXa2bBR06DaPu2DVbRTCB1VDmltITWd269/V4vv8RpsNGXxzL1QluMUT/iqm7Rewqy1d1hD9goEPbXHEu/62yz2Pl8wq1pfyfpmAdkWBAm11JUFow5c/5GtjrEI65P7JAmGMyVrA/vaVasQnDMm2Dw7yQHFNCdsQIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1PAPKMkL0IqBkUL9UB+XyWHylG6564ZRRsofxPlZvI=;
 b=rsldlXs7Vp9pZkYPPNNEpMRYazayPuireXTUgyjGFv5r6r7PHmfZK18yasrnBHtzbIT7ZEYAxsbWsIQzKU95mqbsb0GbIvkQ3RN6+/4irNVAkpeepSfGrQb0nqufpD73yNcG4PXDrlwMCsLT21YIxTNNV+kJqV217+jPZyHq8Hs=
Received: from BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) by DS0PR12MB9273.namprd12.prod.outlook.com
 (2603:10b6:8:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Wed, 8 May
 2024 17:16:47 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::bc) by BL0PR1501CA0034.outlook.office365.com
 (2603:10b6:207:17::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 17:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:16:47 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:16:44 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Samson Tam <samson.tam@amd.com>,
 Jun Lei <jun.lei@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 08/20] drm/amd/display: Add COEF filter types for DCN401
Date: Wed, 8 May 2024 11:13:08 -0600
Message-ID: <20240508171320.3292065-9-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: 586ca6cd-1cbb-4f11-bdac-08dc6f82a434
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zc2yQnjd6UIRdbvVgmZbN81Ts54f0PQeqeGg5ISanU+ZYpHgOlUAYkiMCLPu?=
 =?us-ascii?Q?VLvX2hkk8VZG3f77hLRSl97002Hs/AlolEf+3wdsY16Na2QSX/erGdtgBWIX?=
 =?us-ascii?Q?/dDtzbzqmwxLCdavRqpg1SY73OIoRW11E+1ByHq7px+s/SjIYlyGTU4SwrYV?=
 =?us-ascii?Q?dBck1WrLl/4Br4IPEakvjPGu5FlrO1gBnxQBA2ORnojywkao+EajffKkWcUQ?=
 =?us-ascii?Q?UPA0g3yqVkToAdFbBYkmFZUL5gA6Y/Tr4Sa1nLF1/R8kY0eb56ibyUVncZ+6?=
 =?us-ascii?Q?ttyJd4QdsK6FvkjfllJSetorrEfzI8RnOR8Yd+lmvqzyy4RJVbpQG0nr65fn?=
 =?us-ascii?Q?Nso/vqiT8wLAu8/9iptf0pWK7cCzMkcWDy0qSn8cksbOH43+PrQtk2TsVQGH?=
 =?us-ascii?Q?jpNdBHgnA29CAsN/ZYIV9eUklXBvHFJhFJa0Cq+Q0y4exgXHN2J1nSeHcKW5?=
 =?us-ascii?Q?R3rEZqHtCMKmfASK3jhxkcVs0eMOaxZmDr7oIwp/jJ2YGwGGNBBXUwYlFSAH?=
 =?us-ascii?Q?2xXXcdh8bOS/y/UYSQEyhcu/4OV0ySwvLXwgdtiIQzpyKkRnIyfeArPwrCWl?=
 =?us-ascii?Q?z5qrz2SN8nF577zBjRVk+Ra0ztLUgkMpfYvY8VlSnwoz/qZAkUv+yibDP4IQ?=
 =?us-ascii?Q?H4z+8F0Qcr4OwgL7+tTMjTxyHEl+2e0VM5UrLWzmMyV7wuFeGWq6xeZ/NNx/?=
 =?us-ascii?Q?Za8zjCAjX8nqLoknyj7bNfE3Ew1E7slHnC8vGvyntpf3TdTDPMR0tZcfpeDS?=
 =?us-ascii?Q?qW/KQnsCmCjmvMpm2Nx2oJiAF9ldvICJ4PpZkaGBFyIVScxUaR5MoQz8/lZu?=
 =?us-ascii?Q?cwUuK2k4ZJ18Vny1fC9Oyljao/wMkDW4zGistA3dApV107atb4PnYd47RmK6?=
 =?us-ascii?Q?nvvYswLg8GLH1or3MHhjYOtgPHcHxKvKNyf1DpPe7E2+HFBqhA1soquSi5fR?=
 =?us-ascii?Q?9kAmGMqfdOlOhVfSFfe9t9/prl2QzW1+GUbtjt0VwCvcPiIATkLOA2iQvSBf?=
 =?us-ascii?Q?nWKfI/IJEV1gfzLLgQ5XM/BUiERwfqm+P+pUyBEYRiAPA3JQ9lTfWIpPHBfL?=
 =?us-ascii?Q?4i7IJgQMB/F+yKsSp1MR7q6Esagqr+5qggNC1pS3n9tNC6eVpphDOO7XuTOc?=
 =?us-ascii?Q?Q4INY2YTkOzX4H5pRRxxOtfmUCTT1ZYmYZDNNP9zRLIWJf+CGiI++MjG/3Sm?=
 =?us-ascii?Q?jDMBG+5cuLN/Qk2+me6wlKTZ/TpTBsjCfxLaSTSRl3KRkJg9ATOBhIEs4Y2b?=
 =?us-ascii?Q?7rqTUSZEn6lQGwb3I4gBmZbbKwjSEaJ0qFWsppTmMtM5fMOxWuznHmx/6WDg?=
 =?us-ascii?Q?BAZVVFArXFx9TxiMwcQJ9kUywHU7/csVAKrRDpgbIy3lm15BgYoPgcN19biv?=
 =?us-ascii?Q?vJaBtLHwIZY/T47m31ZUxNBIgCY4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:16:47.0650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586ca6cd-1cbb-4f11-bdac-08dc6f82a434
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273
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

From: Samson Tam <samson.tam@amd.com>

Add VERTICAL_BLUR_SCALE & HORIZONTAL_BLUR_SCALE types.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
index 696ccf96b847..d9a08cd160b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_dscl.c
@@ -56,7 +56,9 @@ enum dcn401_coef_filter_type_sel {
 	SCL_COEF_CHROMA_VERT_FILTER = 2,
 	SCL_COEF_CHROMA_HORZ_FILTER = 3,
 	SCL_COEF_ALPHA_VERT_FILTER = 4,
-	SCL_COEF_ALPHA_HORZ_FILTER = 5
+	SCL_COEF_ALPHA_HORZ_FILTER = 5,
+	SCL_COEF_VERTICAL_BLUR_SCALE = SCL_COEF_ALPHA_VERT_FILTER,
+	SCL_COEF_HORIZONTAL_BLUR_SCALE = SCL_COEF_ALPHA_HORZ_FILTER
 };
 
 enum dscl_autocal_mode {
-- 
2.34.1

