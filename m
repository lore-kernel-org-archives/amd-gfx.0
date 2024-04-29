Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28A1C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 14:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 635AD10E70C;
	Mon, 29 Apr 2024 14:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IuiXavyz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA3B6112C95
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 14:34:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQjgfltC6viJwttWkQU4hzUFNYuiLPZiUm7wTCBVr8dmLMc3xLd36mC+hiAV+uh+qqtCGPon4tUTY1Eo5gyW7Xb/thmRcE6hKswwAe1CBN2OvTzk27ZFNk5cZg1nudfUyhVaBoEWYTCh3gEEAgSsdXQqZGR/tqFXp+xGwbZeC//4kGESJnsFtAUDZiJmIkg3w8Sj1KtKgXPMThbsjmIn8EGmbsBnQHd/nla8NVOtFjNYt9cNejkbRtUsGNHIuw0LerZvcNmBVndS48mlVD8YbV8MFyoNwB7e1SByDaN+itULglU71YUYaB+8R+DfgvLpQ7iAGOIfadGmyetfxmWBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtRXGU0IkXEN3iHqZOmii6Xmcii76dLnqOLmQ7+vkuc=;
 b=Viocngba67laJ9mdhLVUiVSLzpItTBzdXIfPFDHSMO8ghZIpf5QtV4oJrgev+vnnMaBDaCvzpOUzihnhZ74Ku8a7pnrhnhTzDN0ZoXTkg7op3tzui4Q5bnOHjb1+rGFROAp39+aDRn9S6TyoJ82SIaSmXe5RNgSXINrlsoPejaZ6pTuFq5l9qJDXn5xYtsG2BgIcK2uVQmgvjFHD2JhzgugmdTSRUfkKLPDEtRk/v1QzlBeib14y6WkwUlemOyk/zMMmhcf/x/2DX2PC8PaMG+bYHGhp0MaApw1m4bROKGkXim0RfFOLveSnBmC/c4Jx/1y/Rtucxb9F7DbiFDkSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtRXGU0IkXEN3iHqZOmii6Xmcii76dLnqOLmQ7+vkuc=;
 b=IuiXavyztSdoyE8KAdQCe2IcnRtzWJXbGm8tw8gm70SbZhg7nUANTGSHwQCJhrnQ8X0m04oQcUV2tF0pfu6FjyTML9FJ+CEPyRUbc0Yv/98yWj2OqUnZklFqkNRBm3R4Jd898elmNNEl2L88wFamQ16icADMetZhAAGg+R9HXhQ=
Received: from SJ0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:a03:39c::17)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:34:14 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::fd) by SJ0PR03CA0342.outlook.office365.com
 (2603:10b6:a03:39c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 14:34:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 14:34:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 09:34:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/31] drm/amdgpu: fix trap enablement for gfx12
Date: Mon, 29 Apr 2024 10:33:20 -0400
Message-ID: <20240429143339.3450256-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429143339.3450256-1-alexander.deucher@amd.com>
References: <20240429143339.3450256-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 620d524d-6843-4a5f-89aa-08dc685970e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6+kBBV5JuWchsto2WBqDn9jCovYxKV/oC0Ybp2LQKkWgQK65VqIubGDkdBuM?=
 =?us-ascii?Q?yzBTG5ulWGhuOJdYnpp95Au/2hriw6Eg5YBJYf72MMavWR8L+Yi/bHiTxO2B?=
 =?us-ascii?Q?wY94zC7qfCX8JzojnV83sjP3RA/0lEpfpPcNZQqkWzRRAWsy+xNdInlBuPP3?=
 =?us-ascii?Q?NBsaJ0jYZ+m3p0TahKelfTFymsa3KylD/wnvVuOwNa9wKgzAvCZsDaZj/xgT?=
 =?us-ascii?Q?cu19jgTXg8rmxxKUwasmIAkk6M+DJwpd2hr8OGkd2IjsSClj0kopNXJRUAgB?=
 =?us-ascii?Q?o2PIcpk8biZFVj0NPsJReDiomTs+Tk0p7km5krdLWgJetg0LsG2Vq7gupWnm?=
 =?us-ascii?Q?hQXLdmtyIUMNyAT0eRfrDK+GoYTcdLK8kLnC51ndLC2o+p2IOwn46/8oFA4W?=
 =?us-ascii?Q?qqNo5Ft1Po8m/bYjCzvEF12xGJJN8jwn9zsJWms9p9C5RsJYq6gED2Sp4w4C?=
 =?us-ascii?Q?mR2Vcf7S0gDGO2vnFo1qA0Jzm67C0jeFBYUPnBZwn/vERIb6C3jVsM+gLXef?=
 =?us-ascii?Q?U20qYy8nhlId1gnsTm0Hli1mEvlhqdB0+p61WH90ffaX9jK7fJv8G1pPamkl?=
 =?us-ascii?Q?/XJa7DoE2pLcYCXRkehfOM38j1k4y9w7b2bJrit61fk32xSMf4P0OYvzmK1j?=
 =?us-ascii?Q?1DjKb/g5sjdL60+q1voVbyqh2OUJLDI7fzRhkDq32l8zqq7Bp28LJjjEA/AA?=
 =?us-ascii?Q?nmjFRLR7U9t0s0yo+ab7E7oiHyvs7dqKBVT2J0DT37PrUCcV+7ZA/KC/O87R?=
 =?us-ascii?Q?/JH6sFLtGoudTr3QXI+A5kUVzAezHoHF9PhLZtRBZG2zZYlsyW1scuohnDoq?=
 =?us-ascii?Q?xCpNzVDkoQcUzwfrP3X+LiGxSiO3Irwnu1YOSR11FKRrO91lTomM/ECDu30K?=
 =?us-ascii?Q?g8fTBeNEVFD76TEaMAUYJUdOODnsN7cGdwCrOcU8HcQtWMW6+OJiaxIiEEde?=
 =?us-ascii?Q?l3jYikMVvRJ19Ki4mWYUvm0IH0s/UT0tCyBjLFtf8hDpOZON35Rx+t+HmM2B?=
 =?us-ascii?Q?JQkDJD9gSnAlsmRrcb3QpcshPBK121EgXPWh+UPVKPCJfU6gWNb76AeioyGR?=
 =?us-ascii?Q?fzGCXncI3/nJfAELAnAq927i3zeqntmWv7o68fKUMnVyN4snTgEeicELwAxa?=
 =?us-ascii?Q?BKAAcNrSNXXF74NWJXkKRCtTvjqzMDbNhIfXippyi2TeIrLr2BXZspPwD0gM?=
 =?us-ascii?Q?KaBOHQf6eXKHzRxxYXPm+1RxlZ6oO8ownMbNM9iGd1Z62ICY7NVfDaT8WAT1?=
 =?us-ascii?Q?zzFcASi5G7leQPu97rt+ckay/S/pCezmmmUYvFnBbzM0i+BX99W74rJzZfY6?=
 =?us-ascii?Q?kC8EEm2IT/JYRSAB3CvgxFKHrKfLLixviZQ2nqKr6K/OT3v4/lnmq0epNA0c?=
 =?us-ascii?Q?sznfko/ns5HlorJBlfuSDJTJKfVz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:34:13.4183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 620d524d-6843-4a5f-89aa-08dc685970e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234
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

From: Jonathan Kim <Jonathan.Kim@amd.com>

Fix request to MES to set SQ_SHADER_TBA_HI.trap_en for GFX12.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index d8ccf580bcf4b..8ab85e6231922 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -336,6 +336,7 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		memcpy(misc_pkt.set_shader_debugger.tcp_watch_cntl,
 				input->set_shader_debugger.tcp_watch_cntl,
 				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
+		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
 		break;
 	default:
 		DRM_ERROR("unsupported misc op (%d) \n", input->op);
-- 
2.44.0

