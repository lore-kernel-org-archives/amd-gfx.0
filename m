Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B6CCF34D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF4E10E9B2;
	Thu,  3 Oct 2024 23:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xTFzznwJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFFCF10E9B3
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUD2bAiPhYpN67ApU5VhYdPC7ZiReU6FwMig+p9nRkZmdY4jud3ciF18RnE74M4hGpd+OXLc9TYqvR/aj5vaUDvgceupigG6mILsf9YylzDOq74XN1O+PezpqsVi+/Alfj5ndXGlkIe5ca5AciQm9Isa6dPz6GhgpRnV6N1hADSulrcWZUsoyDHCAapsb9/E4/7DDTTozVVCBCUTVIUzCKjQpugoHotD95nfgUt8CsSGqjZwwDaAXbz6GeB6cTY5mYSJ98GJVhfgmswQtKb/JJwluvtsP3CYpmYF/mRIWtmxNrTImimKvTKMjSfuy2NEPPrUjoYW82H2ibyDz7uTQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWsgE1I2J5NaKVizOx+dYIFxI3m+Mi06g/F4PxWxTkQ=;
 b=GgA7+SSPSqtyl7r/9OVnvpUXBcrV/dhbwGuMQlsFG3S/9V/MyUzMWyyPk8puwkwTd+4RZcf8zg7UXqK7UwZYEyBdZiO1BFppV4oayI9Vd83yW5DNWpiTUU+JZDA4tL4z+UTzJHCzoJ117twsZ5RgrBFMFhRaVK2Zsm2skByyRZSaNheM0oEPagu8bhHZcyIRk5VV2ORCFXi1hbtN6v8NVydAz/qQjQmSGeclV/E7cN34U/RZsboTHN2bFhFYmldugWJ9Yw3p7bmqkRw/deyd5KfbmcPXkADdX7GIYScAlrwK1oVNtq0647R54j5B9Pom+UdddmU/fKS0zeXfii1Hhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWsgE1I2J5NaKVizOx+dYIFxI3m+Mi06g/F4PxWxTkQ=;
 b=xTFzznwJPZIEY6a6COe2GybSLTffv7BLKe6r7SBglqrosU4wgPH4hP1Us8Go3UxmlrT12UrpVmgIj74ohJmPM6DRofnTjx9nwSSuAp4quS0ZvK65W+riq4fEBKkjhGZcbAZXDanOClmQvP4DuuMXkqVfhXDcPbVniPL82LSdNdI=
Received: from DM5PR07CA0093.namprd07.prod.outlook.com (2603:10b6:4:ae::22) by
 SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Thu, 3 Oct
 2024 23:36:14 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::2) by DM5PR07CA0093.outlook.office365.com
 (2603:10b6:4:ae::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:07 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:05 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 18/26] drm/amd/display: Allow Latency Increase For Last
 Strategy
Date: Thu, 3 Oct 2024 17:33:36 -0600
Message-ID: <20241003233509.210919-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e2aab7-13e2-4c12-b439-08dce40427cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gFm8jdd4fZnSMbWBSKVP4fnyQr+NzMwmj46a8gsSC/+TaxKffzlsVDnoeAZ9?=
 =?us-ascii?Q?mknTW7gIdCEpzba4zvoEhZ54QkbF3ajoAGE1ug/MkvDKzQi9p/44ckgTALd3?=
 =?us-ascii?Q?pqpY350Kkds6kVWmWaSd9cCM5LBJkFSBbz40lVWDAW1qdu5IhX6IZJe1/FOx?=
 =?us-ascii?Q?KoaafNk+QUT3nGMEPxhiZQOaiD9bkvjohQHwaCiHIpfZcsLPzWyRgzVgDD2c?=
 =?us-ascii?Q?/MI32yriJmrG9rVprTy+DGcaIV7khwwq78U4OQntsbO5WeOV4IieOStfxJLY?=
 =?us-ascii?Q?ZH6djJSKRKtGXbN2lTQrdHY2XUAtyeON/HiyxgqXPaO4cTVqfsxZyBgNpXWF?=
 =?us-ascii?Q?VabxrbVSjKmTuqk5xI7woB+2BsYX2l798uRnjrCzKQIF3sly6mM6us2MW5AO?=
 =?us-ascii?Q?25Q/YZq/YfTXe1kiNibLk+Ma2kUIgmnugrTMZugZxnoKU3L/zf8IQ3QmKfHv?=
 =?us-ascii?Q?WVRTiKuHNSkmuwChR+hzLxISzA8DvUhlRnhyCwNX045ncZXjHNQH5XokW/15?=
 =?us-ascii?Q?Uvfpu0x2t7e26TaLwGvw7JVHKFXzM6EsBeeGjSXy2+HyKe/QWdy/wbVkuau4?=
 =?us-ascii?Q?dJPpM2akLsVlS4sHhPhns8i6WqOuP9bau1+xK2C51a6aXLJF9LMOqTdiXmrS?=
 =?us-ascii?Q?+L2V/f3cpAaaZhPLpBhLWoSwin2btg63dcqmJykUWABub+UwwumnS0Rcao45?=
 =?us-ascii?Q?c9KuD96Wri2zCERJvCEzAyZLTjxgUR12CWvJheO3WmisyK+UZj8jAWwdtWqf?=
 =?us-ascii?Q?JEDSzBugpFRhOEC7GkGMU5bbCHGECqgaLHB8nL+2+FKOw8SsFNg0uSFbYIs1?=
 =?us-ascii?Q?jzdhnMZtLxuKRVFD84Q6VfdUd4bkaSE1yKquyIjKD4/iDmZviP8hrCxuEv4D?=
 =?us-ascii?Q?obG74lGzEHwXUxVRyjAMNj9YXeIzyFDYkFqfg1Jyn8Kn/QBeVN8O3pHEAs0W?=
 =?us-ascii?Q?ZURjaOV93lc8wC+g1AhRD3ok1FLE6yc8mjsHfBOTQchxOn+eQgyxFBdb4a6/?=
 =?us-ascii?Q?THPMYMONrapRdD1UeuaJ3GIbLW0PdDB7bdLsZd4zBHwNt5xh8gWcAqx+Ziez?=
 =?us-ascii?Q?gvAv0sgk5sEwAJZs7R860ofSBYuQZzmx2Q3lzOKwW5UMdaMolatbY+MDuPMW?=
 =?us-ascii?Q?Q6elorQXucqnNg5jWv6CJWxVhtc1GZStfLveh9tT4uDJUilKCPUKCWO5Ni/U?=
 =?us-ascii?Q?MavzL4UTDzXzhLIzZgLnJn6iJzTk3GGWR8wRhSxiQYg1cD9rXh0YyEnB5vyv?=
 =?us-ascii?Q?OP4tSRqDJw3jt6tzzHdGaorMBOvYiUyQOCSR6TugjnpNJXLcnZ4ysRsocchq?=
 =?us-ascii?Q?LElnyqhoOWOnhwTlh4AbM2pB4dJqNsFl2+9VfUsBKVXAm5Og4VUCLfAmRQfc?=
 =?us-ascii?Q?dURYJMcvCSsunkZ/oXiTqWMl/rbE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:07.6556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e2aab7-13e2-4c12-b439-08dce40427cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
Playing 1080p video on 4k60 timing uses UCLK DPM5 and mode support
determines that p-state switching is not supported.

[How]
Allow DML to increase latency as the last strategy so strategies such
as VBlank p-state switching may become possible

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 1cf9015e854a..5a09dd298e6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1798,6 +1798,7 @@ bool pmo_dcn4_fams2_init_for_pstate_support(struct dml2_pmo_init_for_pstate_supp
 	}
 
 	if (s->pmo_dcn4.num_pstate_candidates > 0) {
+		s->pmo_dcn4.pstate_strategy_candidates[s->pmo_dcn4.num_pstate_candidates - 1].allow_state_increase = true;
 		s->pmo_dcn4.cur_pstate_candidate = -1;
 		return true;
 	} else {
-- 
2.45.2

