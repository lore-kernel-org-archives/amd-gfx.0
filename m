Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B0ACAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F88D10E8C3;
	Wed,  8 Oct 2025 18:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="POY+XtRD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C75D10E8C3
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0bUuqW8besfLvFqR8c4oUaLXxnvyKEHPA1ISxmpdupiA8ky3E9i/6Pya9HR5H7WhDMAp//xoDar4+YtiJ0tI33/My4I3Unx5SGk7v14YRgy/QZ5UC+pNz08hoP0k+x6FmsBJc1WFd18HhpCA/WaLwjjYm4rSXgmgcmHKDt5WOlarvEM5Jf08HLZsDHghVmiVArkmROBoNpNjzOaUOvUKnRUIRqQ1Pc+fmizXjMt8ANAdQf+K79Xo1BMSaQYEBJVzgpupdEChSgK4VNYaQGkRck+kkPQC3mD7NssjETrWzCUJvzl4xOynz/ZL4FoJ5DgHy+yYBMnBNYlnb5oQmRFCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/LaFImad8jej9OeIDeHaiV8KrnpH4K53ZoTpN9pDeU=;
 b=gAO4TY9SW7FEaVnCuAo78rFRV6p5DXHxVlwnkeangCxQvL+L59sdMWzkSDFOs5OcxTgatJEFvgXIXeYnHMFc/wPl6NHdJtKN8ErEVhs6vzwPw4TD1j+kESXJnf/5FgP+OxteVei3CC2uoWMDRdctQ6KJ7SNMFfHy1h0AHibXuXW7VGsxR+SWbSMgFuAu5pFDZQFI3FT9i3wlwdXZ4Zj4PJW5r99aVg2TLFjAbI8i0W07uUF2RxoQ4sNHciH0DmxqngipKxqmliuGaJLf9mhe2XS0BBU4bxpVp4k0AlXBz/OL4ujKN0lGEcsGyhV3g733dZT8sqWyH2ZVL8MvqRC5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/LaFImad8jej9OeIDeHaiV8KrnpH4K53ZoTpN9pDeU=;
 b=POY+XtRDRS7ttOJINPtLaQIpAvC7+xFt6kY1zQ5OcYYxeYXpFiwiqZxAnVgE29JaB9sbk7O569ICgq0XkB3tQXtrmPLkUJAhM7n5dMEbgeGUptaWZgybgZJOT4au+ttg/nAg/VAikPiwytwhFvoUKNfiJHHw5pMZuvDKLX8kLo0=
Received: from BYAPR07CA0088.namprd07.prod.outlook.com (2603:10b6:a03:12b::29)
 by DS2PR12MB9565.namprd12.prod.outlook.com (2603:10b6:8:279::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 18:49:12 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:12b:cafe::41) by BYAPR07CA0088.outlook.office365.com
 (2603:10b6:a03:12b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 8 Oct 2025 18:49:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:49 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:49 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:48 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Yihan Zhu <Yihan.Zhu@amd.com>, "Ovidiu (Ovi) Bunea"
 <ovidiu.bunea@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 13/22] drm/amd/display: fix dppclk rcg poweron check
Date: Wed, 8 Oct 2025 14:47:07 -0400
Message-ID: <20251008184839.78916-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|DS2PR12MB9565:EE_
X-MS-Office365-Filtering-Correlation-Id: 141ad946-090c-47de-651f-08de069b5f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V8C3pqBUNGURwUqO7D+EZw64k2oQGVOgKOJU8LdabF+oolQa4QWIFzL8KO4L?=
 =?us-ascii?Q?XzmFM1+dWjWNsctqwEAvHqxXNQrYV7LqopFyxwF1qtCiSZYH4MTDITZsaEqO?=
 =?us-ascii?Q?UF/IzjDFrz6RhdfkQuwCzjfPZOFLybkdPL0W0TY6vlOZJQuZxN2wSPX9ZaEK?=
 =?us-ascii?Q?yO7yP7HuRzmuSH/3PSqbGSrmkq2d/l5aWFY9c8HHnF1llJwRfmvxYglyLGro?=
 =?us-ascii?Q?FT9FsJTB66s6zcg8enaqHsCPzyj5N4VeO6WT0RCyUXxEimqwZw9uOjPf4jyR?=
 =?us-ascii?Q?b9v7+ZNqOQ/QmU/ToMEqyOtl4cxHN+QzS5Ftl+0uSf2iwdfU6jMk7P6FbkEo?=
 =?us-ascii?Q?3q1mBpkdaFJ2SuIKAfVaR1cfRWrT92wEqWeSuKF5K/pgw4EebIONAQSiObrc?=
 =?us-ascii?Q?Ndwb/fFXGPIQ30JFR9eb/7HY7zd2nvqdnqDs0ii93B5Ff6cH7M6JCNwtqHPq?=
 =?us-ascii?Q?PcGdnxe4eIA1JlMLImDgHkdmf+mmdJjKcq+T2bTgDVv/GUB+6bJ/GHACiM/v?=
 =?us-ascii?Q?x2lH6b91fEAooHMWPq7igriUNyEW3ouJa0/eToJxqfkYSvY+/qgWXpRUwnAs?=
 =?us-ascii?Q?nOb4slRYZqqXEapLOEuht7NV4aZIGkhxck9L1UkupeBq3tA5OO2uLW3Dnbve?=
 =?us-ascii?Q?Xv7Xx8A0SPFkOjTlNFR8ar4HW9AeVfkYH2PVZQJdLkRay4Ma98jPL+2KW+Lb?=
 =?us-ascii?Q?+jxcWusIRWJjzhPAs3bmtBNe14KZPDGYQZ7F2pgxcPyL0G/tk5eVChASmTjU?=
 =?us-ascii?Q?QXlKuOe6z5fc+D2nIthRqOv/ZquUXzBvulsSvl9SFpN+/Az4tR1twqJmVDBz?=
 =?us-ascii?Q?YKwOd/hw3ChazFH9OYq8dw5Dq6xJoblnjX2G/KedX96rjQ2BofRlIP+oCQ/D?=
 =?us-ascii?Q?L4wQMQowe40fo5I61oANJLUba2QnTYCqkEEV9FlI8eQZCH2O/sByVt8Rd6dt?=
 =?us-ascii?Q?pXxfAksaLiSz04yNOGhS0eNSJr+J9m1h0Gp9azPi0lziQQE9K6sBiiI/4pvm?=
 =?us-ascii?Q?FJfix6Gi6/jLBRbSsc4PQRNZqLaU1I4YLX3vPUTM35rZ5iABAAY0XaTgYxkU?=
 =?us-ascii?Q?6bgIyFWwxCKreUVsrC0xXfL9YtUAsb1YIQl12zkpHcRlVc6KSSb08imUaNar?=
 =?us-ascii?Q?mFOfC/GwdJwhivV77x7Fj5aw5qq1a9XZw8q19f8Ta8Ra71dwME6KEngI6B3s?=
 =?us-ascii?Q?SMFaQHzHXGiYPMUklGoIaz/C/Pt3UD+IfpKymvsIsRpW7VI5pGC9lRtAJogy?=
 =?us-ascii?Q?tuBH+4ZVoBKheVtF42peQxDIdSnuCKND5OKalnMbwZ19Laf0I3QVsr0gn/Mr?=
 =?us-ascii?Q?Opgm1E+C2erxJWHHHhMQwFjUlurE05s56/s3+EaSnaGFvxFzM8Xd2eEvet5V?=
 =?us-ascii?Q?qMWMa223qGFwMyf0Q9aOhTycKSpzcdBNkRRWiOGdUlzVt/dmnO2mWimwogF/?=
 =?us-ascii?Q?GEEwx5//9EnAMSeVfIe+CV557HRHHW5/BfowJAnSKDyJ0wdfVKdg49YTownm?=
 =?us-ascii?Q?9VNDMxKCZooW3nmw+Dan165Xoh3v51+GkOgKI906ML+q7ZeZJAt/WORBotNy?=
 =?us-ascii?Q?MiL9qmVH+sKa1bDG3hI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:49:12.1362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 141ad946-090c-47de-651f-08de069b5f5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9565
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

From: Yihan Zhu <Yihan.Zhu@amd.com>

[WHY & HOW]
dppclk rcg power down will flip the poweron flag in the cache to cause dppclk rcg will never
run the rcg ungate sequence in some condition. Wait 10us to let dpp dto fully ramp.

Reviewed-by: Ovidiu (Ovi) Bunea <ovidiu.bunea@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Yihan Zhu <Yihan.Zhu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index e097d52956b6..856615e7648b 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1187,6 +1187,7 @@ static void dccg35_update_dpp_dto(struct dccg *dccg, int dpp_inst,
 		/*we have this in hwss: disable_plane*/
 		//dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
 	}
+	udelay(10);
 	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
 }
 
@@ -1676,7 +1677,7 @@ static void dccg35_dpp_root_clock_control(
 {
 	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
 
-	if (dccg->dpp_clock_gated[dpp_inst] == clock_on)
+	if (dccg->dpp_clock_gated[dpp_inst] != clock_on)
 		return;
 
 	if (clock_on) {
@@ -1697,6 +1698,9 @@ static void dccg35_dpp_root_clock_control(
 		//dccg35_set_dppclk_rcg(dccg, dpp_inst, true);
 	}
 
+	// wait for clock to fully ramp
+	udelay(10);
+
 	dccg->dpp_clock_gated[dpp_inst] = !clock_on;
 	DC_LOG_DEBUG("%s: dpp_inst(%d) clock_on = %d\n", __func__, dpp_inst, clock_on);
 }
-- 
2.51.0

