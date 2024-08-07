Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0349C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938DA10E42B;
	Wed,  7 Aug 2024 07:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZCL1ToYR";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48AE710E42B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTMaLxGZDxJyBEljErkBWSmb1SaIBTrxnSgdglYd948JYsXQVO5fHC+3paeszq1CkOh8OVvgGjzpvoK8ugtBMzI3qgMCzP9ewZwXR1VcdHvFgkXIdidz6FwR7kwHRxRf7Ck3vYSZQ6AfiweBZrhQpNuEiK1mOarqj+3syqlmPlWuObae1IBO0jXjZJ8lLW238A3NMIvjlHAW013eaT3vzaURJ1OXjaSt+MMq1C+nwNiz5bKW5L6aVrM3Ox5SycWIaqHTbt+podlYKrq1zE9e1E6kq9RX3cHpoa2vxszfQxUkYx+kmL1vdsFY2Cq45+FVeqKGaU2oXoY5PM9LEynDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zg53vNg5YG4L8e4eum9jarXPpvCqquK5JuwoGVuinA=;
 b=yvhogeGnQ8wTRxcPQkMzHKlgs+rpzQ8gJl0g4v2Qoyz12K8p4K5/Yt82Mj+2pl+4ziWl+gMQqbphvv2gvpOFIES0QwZCssKxXnhJ8XE2+1mUlz922HHZIr+1lpvismXn2S7/fhXkCnXtQdTNcEEO9VxLrE49rIoyUw5NqD5gbGhJY7cXHruvHhS/L+kH+fFPASNJ4j4WChxBzIWIPhmaGYKHpxP/3WxatIaksqZbt22zWso55dp24vrbBeipS9Mq3h7uqpPqM6X1/fsnKGcoi43UNtTA6y4lPKNXNqvl8OIG7SqLIYbr2m2kqDns/pZ/3Er5BAE8fpnz84QgCS5klQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zg53vNg5YG4L8e4eum9jarXPpvCqquK5JuwoGVuinA=;
 b=ZCL1ToYRRikmcsyEDFMr/Yb720Do5bCQIAC438ROqaFrcKA0FTHGczzZno09uJRjTaAx5rvhh0f9fVAdhXeqoQBiTKfraMRTDqEl0gilNAvY7EjRfqnvid7gPYEFDPfldVzGZDQleujF3mLoabG3KwiTdCgx3NMJHha/VJH83BM=
Received: from BN9PR03CA0772.namprd03.prod.outlook.com (2603:10b6:408:13a::27)
 by SA1PR12MB8947.namprd12.prod.outlook.com (2603:10b6:806:386::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Wed, 7 Aug
 2024 07:56:18 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:13a:cafe::83) by BN9PR03CA0772.outlook.office365.com
 (2603:10b6:408:13a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Wed, 7 Aug 2024 07:56:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:56:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:56:17 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:56:14 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Hansen Dsouza
 <Hansen.Dsouza@amd.com>, Chris Park <chris.park@amd.com>
Subject: [PATCH 06/24] drm/amd/display: Update to using new dccg callbacks
Date: Wed, 7 Aug 2024 15:55:28 +0800
Message-ID: <20240807075546.831208-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|SA1PR12MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: e046a173-414a-4e06-e0eb-08dcb6b66b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sWf4kthCzb3195gL7oQbU1BFo9n61u0dnGNVzkMesk0kgsiDs0ZcJ2te5pqD?=
 =?us-ascii?Q?3ot8ZZXMyPTSZGBhTqSbzsbGKHEYXVBsnLmFIRRaPlrrywhv89dwwrroLyue?=
 =?us-ascii?Q?eiqcWQ89mAfcdT1/mGS3ZBU7m+9mFzDKjQkt5OqgXO5BL6UPY9HwdazFhm9e?=
 =?us-ascii?Q?/rfxXvxcIEuawNiPHgzxRf46QQ8ZDXZnrBFoRaUUu2V8SPga/B22HKf7EADQ?=
 =?us-ascii?Q?pCQgvASNhcVsfzwdjkcTltVFkfN5jm9x4SwoLS2MfvnszpoMAuT2jD9xGm77?=
 =?us-ascii?Q?qN1rIOnuThfC+GyUBa7I7dl+4suuK94vnAzXC1lsPia/Rh5lKlS/5R1KevfM?=
 =?us-ascii?Q?T/9bpUdLfocpeVbBTczTd4RdO6eQd1owgw7d4UztJCkHH+D4MpXPghw5keGR?=
 =?us-ascii?Q?CdJ7RgHeEaIYuStSt80cNQb3ecBqodu+Fe1VGpEA16zQpQGFDyc6eKN0Z28t?=
 =?us-ascii?Q?UpadEO60Y/lVfeCcQ+EG0+2n/LrJulbqgnaeQxXSaHAXIP/TYF2I67wPByZ1?=
 =?us-ascii?Q?HYQfg04h/sYOeSbCxKEiR0ujif1NUw+kme60M0T4nqw7JeWRlpnfHLlXm9WG?=
 =?us-ascii?Q?vBJ720qNu5HM7cfEggpt8JG7eXNtCCXpxmgHVm31Cg1tyJNwRd8TJcwvOPIq?=
 =?us-ascii?Q?zaVtT2dk50v0iOewMsyjIrMGiD1s8XsRUa7OXncwXBcK6r0EQ+sLmVzJDiL3?=
 =?us-ascii?Q?f7wo5J95e1vfdP/dfglNLKudBRDjXc7WtSs1NNouvm05F1HHQq+7owsBSE1/?=
 =?us-ascii?Q?wwMVM6DPtA3Em78X3WXDiqIldEJaGtaNJrttvxSAlckWF2T+yAr3jCFF3rbA?=
 =?us-ascii?Q?Y/C3d0Iph8UIJN8S5Fj0nSGpf/x6X/nWA06jVvVDEcX6wXeK8d4DTtwqoFu1?=
 =?us-ascii?Q?bKZ5AUN5APvWdjF4uUSnJx1N2Z/9y6LcLkxvoJSwB+b+iR/HO9iV4xd7ZdZV?=
 =?us-ascii?Q?a0BM2gGGt0ChLz9Hr3D0crIKoyxsdG9PDkXxciHE0GVWy/tiJdl0jEwaWdih?=
 =?us-ascii?Q?U3tBUz161+8LjJAbQwGR1MCmky2VXlSIeIAApw8FwhIZyZa8gsKLwG6Eb+Nr?=
 =?us-ascii?Q?bsmsYcggQ0Fp+kCQxp+7jvOJkfJhGzDZRUFSHXzhYSF5+rQxEZ/cKWrcdkfX?=
 =?us-ascii?Q?nRqIgL7JUFOzz38AzProuV+fydH6UDadKPtC/ta92F9P7ESuvpkLTJbJRkDy?=
 =?us-ascii?Q?+CTaBui8vdE5uhUdkX/RUa3dYZQVyY2P3Ol16RfpYhbNfMzvAcM1VZ729D3d?=
 =?us-ascii?Q?Ul2e3XBFWgPBnk9mogvbyZVwo4vxUyKY2Or9wJZGVcWC+IUy6W5hc54S8rMI?=
 =?us-ascii?Q?wVpMeFAIxfcu4LFdutE/dPvYgjAE+grEmAjGoW4ZZqQUM7ZHiMilH+VxFu4B?=
 =?us-ascii?Q?60Ewv8RY+i9r1TxyBsTCXXHnI7KHTcPbfW0G6bS11X9CjyD/ysnaiGrNxLY4?=
 =?us-ascii?Q?vC3Bp7V7TETVA7joZEK+GaFaZXSzErbo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:56:17.9293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e046a173-414a-4e06-e0eb-08dcb6b66b49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8947
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

From: Hansen Dsouza <Hansen.Dsouza@amd.com>

[Why and how]
Update to using new dccg callbacks

Reviewed-by: Chris Park <chris.park@amd.com>
Signed-off-by: Hansen Dsouza <Hansen.Dsouza@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index 7f91e48902e2..004c4fe3ddfc 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -2396,11 +2396,11 @@ struct dccg *dccg35_create(
 	(void)&dccg35_disable_symclk_be_new;
 	(void)&dccg35_set_symclk32_le_root_clock_gating;
 	(void)&dccg35_set_smclk32_se_rcg;
-	(void)&dccg35_funcs_new;
+	(void)&dccg35_funcs;
 
 	base = &dccg_dcn->base;
 	base->ctx = ctx;
-	base->funcs = &dccg35_funcs;
+	base->funcs = &dccg35_funcs_new;
 
 	dccg_dcn->regs = regs;
 	dccg_dcn->dccg_shift = dccg_shift;
-- 
2.34.1

