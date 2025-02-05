Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3DEC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 03:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA98210E15B;
	Wed,  5 Feb 2025 03:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P9//u8fe";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F9F10E722
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 03:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnHrOSZmDGybuIk2MblSzR/O8SjvZtsB/QGO5Vgq8ktoXamIuB+g7QWIivUsdUFaIQi9wRwm4sgKK+HEqm82+oV4b7k2aLH6Sz6IkHO5ukQp49n53wFe1W2l9WWOVxUqYFKuBk/9BYrc/MClnyzawICssVceKtmtjg9yw/VSJef1DtQGHvWIXtvjikruPqMb1BupzXusRPeiuuDiUSEYHPvhbU0VTQFne4ixHOrLG4i1I8k9nI3cUu/vcU1qW7bNq+857gqfNsD/ganWtFO7Z/k/9/tSK4XRRavJEfxlkPTZZorx5zo5eJHNvdpjg/LNbS8q/hJZLnQVwA+Fh9k8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ju9bXY+/YWtsyVo1qoHiaV4ttEsSeiVdOgCKQ22Z2WI=;
 b=ZvMUwtIUy0aYl1ojvVYXgv9oUkTC2DsfaMWkIAHK3r5OL5AviUx5ErGAklMTrr7SizwySzbn1CAcuyLMXt40+85akS1C2IDSj8X5KmSMF9Y4/FlZTSMcr32Z0IUbj+PgDvBrJLI0eiWuR7/xCyOxAZHlzQ9qZkC2XO9jbKIA67dUZ3Ymq9XYriHSLNTDF96AXW2uwuMzJIPQlKv/OK5/eNl2VDbVSjNakMqiMBEHPWw/mhwYjMBjAz1vCM+UnlSOpSrfZLTLJU3+yCZgq3OKFDJPSUl+KjvkVx9RwBX5MU/SPOf1DOEyIKl4vRddll0+AXoMdDCNxW565rZNbssCPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ju9bXY+/YWtsyVo1qoHiaV4ttEsSeiVdOgCKQ22Z2WI=;
 b=P9//u8fekjfdRcKsh7cqblq1zNG+7tN0VHyEc90/kPKVHAFOlakPeHQHN0l4wnf4GIh1FcUXSGWeg+G7Gw/nKIVkP2d2jotjryUWuIwXp8LqLosKb2YI9U04JVuIfZuF/z9hiopKLRP4XH1sjF+v/pVZ4dKBMkNeHPOHxOuN10w=
Received: from SJ0PR13CA0105.namprd13.prod.outlook.com (2603:10b6:a03:2c5::20)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 03:11:46 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::91) by SJ0PR13CA0105.outlook.office365.com
 (2603:10b6:a03:2c5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 03:11:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 03:11:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Feb
 2025 21:11:40 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 4 Feb 2025 21:11:25 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, "Leo
 Li" <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 "Zaeem Mohamed" <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, 
 "Wayne Lin" <Wayne.Lin@amd.com>, Martin Leung <martin.leung@amd.com>, Taimur
 Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 09/12] drm/amd/display: Support DCN36 DSC
Date: Wed, 5 Feb 2025 11:08:54 +0800
Message-ID: <20250205030857.2608094-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250205030857.2608094-1-Wayne.Lin@amd.com>
References: <20250205030857.2608094-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4d2fcf-c108-401f-3c61-08dd4592d339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hF5eHGXHFgYPkxCze9XUjZT+LpT1UOUq6zvb7ghcrIA0fTCEPRsaVtC0Y4k/?=
 =?us-ascii?Q?vCQ4S2x6DOfEfSRwaGXAXrajcznM5RDTSiWFO5+DwAbJDRcifBQz6bz5xSRQ?=
 =?us-ascii?Q?VK7l7I7XknOA/xA/9F55B5MQqSeF5f6nQooOZFYTS2dkmXs09iUkKGaJ45Kh?=
 =?us-ascii?Q?krhmupwJdeuhvtkV3A1zhXij4uPBY4WY69cnmCQlquT9TOskGYsCrCt6coX4?=
 =?us-ascii?Q?HgSe1972Cslwmye5QwoJiTHuQWBDiiCl2AepVgWQt/LubSK7Pqua5bG2Txyd?=
 =?us-ascii?Q?ITV8UQymvXL2s82xeyfd3af2YXoPxh15v4I7Q8A4znJpLMRAaqGFX6z7InR9?=
 =?us-ascii?Q?quKMuosaDitjkP2lY9eVd30EX0XzR0Oo+KKNKW6ljBL83/xLIDf0eG6XsstI?=
 =?us-ascii?Q?OaLvg5ncsq04Bb+910kGFFUZ49nGVadD5irZ+ZzDcf5KdlAjO3S511x16kvt?=
 =?us-ascii?Q?NlxwDqBMXqK1IOt22spP6VRdyjLgthW6tHlbt6ZOCXb5qvMmYFyNtMJ9yzA8?=
 =?us-ascii?Q?bobHwR4HuB3rvJZxzpbypxyeK2w5ZcN5BwN0gfISlTmSqo9Bk0ujDGMCY3Ts?=
 =?us-ascii?Q?n4Dc6UvIuumXhQr36n4xrMMPHyXpAslcHGX3oQwRhVFtKfp+rPY8Ql4sNzzU?=
 =?us-ascii?Q?6QLrHtUW+E7al7rXdohT31yNXBxUpZjON2ZMfkFvFOAGx4vzKUB3Nqc0PJwi?=
 =?us-ascii?Q?Sc+ZFurS1a6d5TpAa8SoyFdQkxHZvVi9ayedDpm/Om5gfYcXJkLZ2swhC5hx?=
 =?us-ascii?Q?Z6IGcsc+aI4w2frETOUKE3Y0BMBf2xrXVUmNa1JTzV6FtFbuTE+nEywPOGK8?=
 =?us-ascii?Q?e7CG7wULQ8oqe0j8zODYCEeQwynreTeonwXa5IkOOA/F0Vi66ZpUQhqV/4vo?=
 =?us-ascii?Q?TI6KCcC3P1VyJ8VgzPx7d33b3B/z2DSTvyGlz96QDRnpwYT96cGzt72wiNi8?=
 =?us-ascii?Q?Thxfx2E+X0Le+2rYioqBIA/xHYUAuoTyZpWbUAgZfMZ4EXXS+7qdcn3KDx0G?=
 =?us-ascii?Q?vwtYjrfYai9G+oYbDKGSFCfFctO+J9XQq2n0IngyTbipZ0zWIvT96u7AHnFP?=
 =?us-ascii?Q?h8Gi0KZvyswCZBQ/wQ0NDY1nmxRi8pwqpxVcwwl/dTysT6jAvZzCS8o7+Zsg?=
 =?us-ascii?Q?94o8xHCcgYMQW9S0taGhV45KZJXmkBb0prvuQewgjJ1wjHha7qHARQ9V7vtj?=
 =?us-ascii?Q?Hkk3gacojPhvn39Cwms9NYniwnFwkCWKFNjx61KDDLBRey3iVFRRrJUAW3Zx?=
 =?us-ascii?Q?OiBB0gSCj0vqZzWWaBW610s7aXJe2+5C6AXZz8PwW4vRkeQacsP74zUOk1Hr?=
 =?us-ascii?Q?84YFbW/KmzCr/TEm+c6ramnltli4YJF4z0swzXxnNeIG0m+gSm4EryUuV/40?=
 =?us-ascii?Q?s36umfaax0cU3GlRkk6Hgu0OxvByxPplXWitxDo3CxfmI1r1fEeUaWnoKxMw?=
 =?us-ascii?Q?9Zi0uit3xOWcD+4q5EcKJNoorBvKZwaDCUneHYE5WWUMSarFZRTok/fRQG9Z?=
 =?us-ascii?Q?3hqap/WQOB0ODpw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 03:11:46.6201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4d2fcf-c108-401f-3c61-08dd4592d339
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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

Add case on clean_up_dsc_blocks() to support DCN36 as well.

Acked-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index e033e6476fe5..7572448e5b9f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1835,6 +1835,7 @@ static void clean_up_dsc_blocks(struct dc *dc)
 	int i;
 
 	if (dc->ctx->dce_version != DCN_VERSION_3_5 &&
+		dc->ctx->dce_version != DCN_VERSION_3_6 &&
 		dc->ctx->dce_version != DCN_VERSION_3_51)
 		return;
 
-- 
2.37.3

