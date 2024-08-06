Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AC5C3DA64
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 14:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73AD010E377;
	Tue,  6 Aug 2024 14:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZiRwDTqz";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64AD610E377
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 14:18:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMr6JtO+l3tJw6M74opYJjGzP6Mo7DsS2DiKRH77cg11qVZJuTsQUTAU86d7sJi6Tzl74PQn4x9IR+9WV5uVN2LyXWMFcWEs4nUbP8gYbrM05T0bDzd7Vr3W1sk5cNYdwyvnblXjXrbuCVE3UuQX/XFmM0/9j+xnWW+ksO2C4mMlVf7noM/dLBudbcqEsb+dXuob+f4NVL+9rEcR6Ro/RTnl7Nlan4JmQ5U2axMuLKH70veTT93CJ/XGu27BilDdV0k3EKRq+mKlOeWpZ+Y9i2zkIdAOGuPIdA0BQiUz1ll2jC2aeXFK2ebMtBOFZXczKfN2dNb2Ua9VWznWdSz1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0MOVV91Rj00AhN41swkC19toZ8GcA8s4Ry6xpHwDJg=;
 b=BCVQlG3UxF9tlWHUqwogrYyzfHBjYk4sWw0kGI/xHTutKKL2Yml0f+60llvoVMZQfXag+TPeue3dkdSxo+jNqhQ/jxlx3GZKtdB4GHKgpXUXs7Jz/JhRPUyS/1HApj3ie53kzMeP5yj9ZiHe4yTHE5QxL33ZNO/3dmd6d4KNEwWivTxxpGpueNhChVS5Oa/cawRVyUG8W3fBEmP9vaHRAwzIEtTzzwFmpQZ4xuEp1ANjki51wsKdNW4Zt39PoT72oWYgIZUqAOXoaQQBa2OcfrXQcDTwXzylgvg1DR3bfOvcsPeuJt6M0GJNIjxHV6lK4kLO1G7Zbhh/OroOsolVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0MOVV91Rj00AhN41swkC19toZ8GcA8s4Ry6xpHwDJg=;
 b=ZiRwDTqzLxYh1BFbzrWBkXiplbE8W2VTvdPsrb+JFPZPfMr4c//5k6cOB8PB9QB71Pxucsd8oURT7oy+cFKFClMi7iQGfwjBeHiDUi6LHPCcsRRFR2707A9xmcNU9tIlr9bmeDx6nd0luPyeNgLIxy23OtEB+JLHpORU7vqI2ww=
Received: from PH7P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::21)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 14:18:08 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:510:33a:cafe::48) by PH7P222CA0002.outlook.office365.com
 (2603:10b6:510:33a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27 via Frontend
 Transport; Tue, 6 Aug 2024 14:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 6 Aug 2024 14:18:07 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 Aug
 2024 09:18:05 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, Roman Li <roman.li@amd.com>, Li Ma <li.ma@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: fix s2idle entry for DCN3.5+
Date: Tue, 6 Aug 2024 10:17:43 -0400
Message-ID: <20240806141743.219673-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: f38c7b49-95e8-4e5d-e905-08dcb622982b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?08CUl6EZfRuuE9nYpoMbvzkZZtTBSR2sdq5tPslBRay87h/HJuq8XCABcrRR?=
 =?us-ascii?Q?/NeDCJlKMOx2NWE7PIPsm4dq128o7ijhHEqKnDiQddUMGtu14jvlGg5eVNfF?=
 =?us-ascii?Q?LPRidh+UCAYUNoKwvIcPVxCKSyKk1z/X8Fp41sfjQE97uh/OLS9XVcUyqY0k?=
 =?us-ascii?Q?Nzw2v8lGjVU/21nBTZlIuL5Qug7XqQfyD6FiaVXFavPDm5J4LBSW0b4n2pPX?=
 =?us-ascii?Q?4gw6Au96DfJgZbbigZOxMHESg6wLcsFpSfdIo8aaPRqn+ycSKV4WHsSNxzt+?=
 =?us-ascii?Q?e2eLH12JuWM2L7kVvNC2OXSsnc1kR+TcoqPGPzsFIZZM+CprGtt0RirmGfQD?=
 =?us-ascii?Q?8ip/MA4XjWK5z+CJ+ixEg1/61RpiKOoTOGze3PfJlgy8lyeel72gE/DSjnrd?=
 =?us-ascii?Q?UNjGCZE6P73N/aJ2rzRIykqP4Nt19IPYY+AFxnaI/As0dtovdEpF/fJuaPIB?=
 =?us-ascii?Q?gVtdqYQV3dcYZAsAc44Cl5ONPFci+CGbygyOsZreHijZrnY6ElGf89UeVDTZ?=
 =?us-ascii?Q?VtwRK4QIA2ur0bwXuTdAzno2VEcDoMeR1Dt6/WlVlPlX2zSdAIurDX2eq4Ve?=
 =?us-ascii?Q?AgiJbIYS+LXmD/JxvZHdR7TE8btzEaJIPkdBbRyvAhcL+3fIKXQ5XqlZ/G9t?=
 =?us-ascii?Q?xC3i4UKI1DjgpROSqL7Gan3jg3yjoRnR1VUJN7kDOHwrxu2EURaUEdCpsSoi?=
 =?us-ascii?Q?D9KTnGrw4GpnuFdx/onVrUkgvr1qARwx2qy9HKEcWP/5SVZdeR53ILZCaDXO?=
 =?us-ascii?Q?6QgUZClB3xywQzbRSk6rkMyNs8kgdDGDXgZSN0Q8fwYrtmJA5ilWbCP8BAYF?=
 =?us-ascii?Q?R3cVIAFxbE/q8pVZ5Lt8dysKihch3NOtYOPD3BS5ECAK1frqQ/uWbFGuw0EC?=
 =?us-ascii?Q?+uk2cmAow2G9SWgY1BuMsnfJRFFk3LlIRd0BSLB0clYOuTe1HoVbcX27zSA/?=
 =?us-ascii?Q?FET2ftC6An1m9+8LQH2DpE8PaJzrOzpbymFVHVPNAEwitAfMdOJLUDu1q8eJ?=
 =?us-ascii?Q?HQDHA6TDkkCNr59Uz8j02/zKcFy2fg6sGk6QdBrp9IQts9LhON0mzg9zUkuJ?=
 =?us-ascii?Q?s12eLIdw6vW7CogZ/jDvGMPy6kHURGX15PSlTWuH1Kmj7McalgqLQ36fr9Lw?=
 =?us-ascii?Q?FkND4JO89SbkrJI5bot+fwjIC5PstOj2pwzwpAfx7jZBjeXRc1Gb+m1DB93i?=
 =?us-ascii?Q?1Vdj9DA8uE1GfQBJim3bA46YU9gbDlXhK306hBcB7yyYM14xFJyzH1IYhST8?=
 =?us-ascii?Q?NVDNrYA1PG0h+VnKeX8dYe+PyDC0yj2d7D/HUFGTP0kAtZAj5M/vMo6PVmwI?=
 =?us-ascii?Q?gGjRzMw5kdJ5faXbTtORM37Vskz6rGHmsFvh1BKjgnwzQs6wC7fXDnlvEJc+?=
 =?us-ascii?Q?F3NkwNoRl1mkuZ+1AwqmPEIwPmyhEsJV/YyNFrnNGIca+Az8jLrSNrSYKf8c?=
 =?us-ascii?Q?jtk/sqCfHnahEfKVPk5ixrh0mAINeUDy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:18:07.6206 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f38c7b49-95e8-4e5d-e905-08dcb622982b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327
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

To be able to get to the lowest power state when suspending systems with
DCN3.5+, we must be in IPS before the display hardware is put into
D3cold. So, to ensure that the system always reaches the lowest power
state while suspending force systems that support IPS to enter idle
optimizations before entering D3cold.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a312c74f1e81..1169b0de7760 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2904,6 +2904,9 @@ static int dm_suspend(void *handle)
 
 	hpd_rx_irq_work_suspend(dm);
 
+	if (adev->dm.dc->caps.ips_support)
+		dc_allow_idle_optimizations(adev->dm.dc, true);
+
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 	dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D3);
 
-- 
2.45.2

