Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D656C3DA5D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 20:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 633AD10E183;
	Wed, 17 Jul 2024 20:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GB2zspNY";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B0710E138
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jul 2024 20:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFSX7qS15LlykpI1hrbT/lstWrxMgpofAYVJZoIIS56XYGkeSL60QPdBER12xOmRMMdMWefDf6hCOLUwnkBMP698k8PWIA6ZOJGYytv0HvxhZiOOjyYJ2urUaW6kiHTQV8EPHWDgzuhck9aZqNJK68yEbpgJv0ex1Eq2Dj6EFDj3Zithx05sDa8p41sjlJAYm9PjuSDNuvXgwrvLBsBk/A8x4gLgI1j8UaAXY72J0I667AgUrThC5nMNZAWMJU6wbCGJXOpLzcXawJFgBudQdb6Qv+HqEN0gX6wdaKOM4QcBn0JJBigxCuz4+TK7xta65X4NIWj+stgre9I3LuRLSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxcUUHKI4S7iKYUF2OWAFUK+WtMcWNcTCiaSKgGhLSw=;
 b=CV+xmgOqEEEylMcIaLthgefpQ0Fh6D7sXpARpT5CTJDgjkGBnyNrEuie6nFnysO+4tx1rjB8zptMfvifltNhL9LgEwGEpshiIFpOd3uTmnh3PHRrtxHURIw8LEay+0nYULxHifGwcVPwz2e+BEfmBQm2JylVemY0GBnAu3x6+JzMT2zfXXmzjylKyAV/zg9w5tgYsezYEV8DCrZGMjmtIXUbw6NJRekynWGRFE36Cz5Kev6/USOsOuBeOcpEsjy9NYP2PamR6qMUpUU472odyKrCuc0EAJMaFzqJaEyBSuwSsghbDnsoLxRCLaJX7IBZqvWhhD4ileHTUiwgqersgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxcUUHKI4S7iKYUF2OWAFUK+WtMcWNcTCiaSKgGhLSw=;
 b=GB2zspNYKB+kBCh698PWy+k5PtmrYsIzER/NTa9uBK8Qrf8a0vm8CE9XaM1rzNX8GDlTNvVpLhjup+ii3HMivVuVWBxgfSm1sNxwdbnwaMGUWyeJ8vKfLqii4o1WF8k0x0gjNaJYYhieahTIp+HvUgLrtZMhmVizJtwJo4tEjYU=
Received: from MN2PR18CA0015.namprd18.prod.outlook.com (2603:10b6:208:23c::20)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 20:37:56 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:23c:cafe::8e) by MN2PR18CA0015.outlook.office365.com
 (2603:10b6:208:23c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 20:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Wed, 17 Jul 2024 20:37:56 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 17 Jul
 2024 15:37:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/7] drm/amdgpu/gfx8: enable wave kill for compute queues
Date: Wed, 17 Jul 2024 16:37:35 -0400
Message-ID: <20240717203740.14059-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240717203740.14059-1-alexander.deucher@amd.com>
References: <20240717203740.14059-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: d1efd4b5-262e-462c-9c6a-08dca6a05706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?05rAxHKIWh5XSfII0JJYQWk5j1jE/PpifHnORJhTWg86Iexf1p70TgWGb9Bb?=
 =?us-ascii?Q?3sRYTmhrtfAJ+q+gIwu+JrmrdAkHeNslfJWubu2jcrpRaFagWAau9mq5ZYMR?=
 =?us-ascii?Q?54vM3Chvzsc4xKqCk9MV3Sltwomb7ScuTfvtNktmCK03cnU7PK7ErTuP73DJ?=
 =?us-ascii?Q?tX2trkPkWO9lhlAlLDepjcBX01CLmbF9M/fFhTIMsSrtGh9x7Iu1uD0JG2bS?=
 =?us-ascii?Q?aRKLxfngnRRKibRRY5lY0e0we5jtKC1YQ/UQSIFAjXxueai6yKGrGPHrYzYR?=
 =?us-ascii?Q?S7TG6KETBQq2LaWU4nlKZJsVhEVSCQ3jolqArEX5A6E10oO9Iy9bwEyrm3LI?=
 =?us-ascii?Q?LmEECXexhWfs1SjJqq5s+UZgyM9pgKB8uj3a3RPvt4+orHFtw2Q77nj2lm28?=
 =?us-ascii?Q?jrWVGetFSgi+nId3wVswyCzMJWpA8PTmn2fbB5+yWhzHk3pswymgJWW4D4dA?=
 =?us-ascii?Q?eOTIh3prriAVI32TdjTUbn4JB5eCRj+W9CPPbx5M9h5A9smDRXpLKdrvsH/8?=
 =?us-ascii?Q?zTYNA3V+NyBrCaTOrrZR1WxfA71Xyx7EFNeHukoMdFvPsz9KLBugKKMP3Fqb?=
 =?us-ascii?Q?qLvP8IAWLD+AI7giXnwL4vBkh1TEyIK1l9+bKZg0obQ5bXkuNl/4f1eby8F4?=
 =?us-ascii?Q?oZ357sEij7/yf6k4Cb1ZRG0yJIgGDgpMT0LENW3pi1wvwx1cCqOGQ9dH0G64?=
 =?us-ascii?Q?+qVo7n9+hIuvNiMgb8oLZCRYMmnSND1MwiHhR8D7NFZI/qPsNI3uhGwHnRyI?=
 =?us-ascii?Q?98NAUtxNR+GU+DnC1dhNVeM2HNYwU6wkN5npLniiOt99b8fWXoYrXuqZFbS/?=
 =?us-ascii?Q?6MwjVKB4ChZsshaw5+LCkN3BSrwp748LMxodRs8y8s4UwcKDBa6C/diuCNCS?=
 =?us-ascii?Q?+XFbXpRFXue+esMHuvHFT2FpZn/1MYfbBDlYiGD50l+PGCPW4QVr6933AlPE?=
 =?us-ascii?Q?qasC3iPP+CZCRBWvoerzQK1hQiq+kMuD+795hjqo1y/TaNn8aF5+etDpHSt7?=
 =?us-ascii?Q?wWObeHHmTgh09oykqQQ/ELiGotYMJWLy27yTYQSblw7XL0Mm0GVYeenuTD/t?=
 =?us-ascii?Q?blCz11uEimrXOp0JhD5ywnmxswcSARZ1W519Pw9sDcOpYMlgNixXT72sqCWk?=
 =?us-ascii?Q?p4hPD4H3BWaBTKB4e+emWTAz8X27lOhe0m2DHEO058lJ1z0zA3HbjRk/nkBS?=
 =?us-ascii?Q?V8r6kKuMAUOVZpyzlWVMIlKLX0LjCDPd00/hpnAx3FVOsT2u3MdzfPg+QrwG?=
 =?us-ascii?Q?F5/jBksefN0Q2opLT3QeTN4b9pNPq7mStPIwn2q9detsLbFmAfomlzEMQptZ?=
 =?us-ascii?Q?gAy/V64hJqMKGi+et0YN50U7q9PSrHjVmO2VjVSKOdx7zZNA8Bd1bU0vjuWk?=
 =?us-ascii?Q?ktkE/ZxeIQYrTY6xbpAhReHnl1BHA3Hd6seZTI+TovYmDmes9u6zyKKWox4p?=
 =?us-ascii?Q?f53TY+fHrGkubBcKWRG7/nskJK4/fTH0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 20:37:56.4172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1efd4b5-262e-462c-9c6a-08dca6a05706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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

It should work the same for compute as well as gfx.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index b4658c7db0e1..a1963e6c5cab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6955,6 +6955,7 @@ static const struct amdgpu_ring_funcs gfx_v8_0_ring_funcs_compute = {
 	.insert_nop = amdgpu_ring_insert_nop,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.emit_wreg = gfx_v8_0_ring_emit_wreg,
+	.soft_recovery = gfx_v8_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v8_0_emit_mem_sync_compute,
 	.emit_wave_limit = gfx_v8_0_emit_wave_limit,
 };
-- 
2.45.2

