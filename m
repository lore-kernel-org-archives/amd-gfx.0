Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85CEC3DA7E
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DDC10E7C5;
	Thu, 25 Jul 2024 18:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g1umELHb";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0BE310E30E
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXUIXXD9RuGEf75LyPM2/nAtMgXhuHkfBBlfzgVJuWyRmNhmOOGfMi7zW7GvkFjmK4NLad3aP9ek7SbAM/gS5zX+BhxHILx9wvsTlLDqw4XbT01hAvl++En1utzLKjha9YLh6/PmSi8zfmHle+yXp17m4W/16lWkbbypvm6dduKj+s9YUGN9fmVTKrMFnFTF3PhJLvLIypmHB4mj3mb7I1cSAsrl3sfSyoqigrS/D4IWbsMK3kxOYd6QI6qiB9jS1jKHWK0POGUIYESbTirZ+OAryA22Q0EwrJ9EO14aJ88CjYQsdg1HuFHjdXNe9sV/q1Lok5z1f3Bd5OH3C+jpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NNKTBa0uSPRQCi5XsapFLVEib75+zxTGREShKXK27Y=;
 b=XhgdEjnr6Q2tOVV0YeCeZqZ9cEqoLOZaJQXA9gm7wzxrnZ2tVjX8g1m4A1ykbTNgNV7nc4HiChPep6JvnVl3OINnzolEZzq7czzjem/9O+HCLrtA/hWgkZmmEpt93nyzrg7kAULiACdDDP6YoxuaDKZp0NmJkllwlCBAgPcPdF0ybISk04nw3LzobH0AlzTiGLKV6O2OEfI/7VdDIetS2vRzjxMbtQnBmgSnYIsBkhxXXbmxkWeR9EAug4YoOT9TeNvWMTsIf1vrMvOCg+Irq5nLSgg24NzQBVRpgKGP8cShpO/bRu8z6oqbKW8Q/FU+znXbPSNlBxSZqg+nBygI4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NNKTBa0uSPRQCi5XsapFLVEib75+zxTGREShKXK27Y=;
 b=g1umELHbBxu5NB9Yxxy3AeOoT8twE63OX5XJZeWdp9GCq3sr/ZTNO+iN6sZlRcvd7ihhr7u9zYKs+gf625pr3mBjQFC0D3dijpAbUW1QJkjDBfsuk3gAqblTquoh1N4k6ZkDJQ+6wdcZx0nQqGq+Ib+AZhM4dgxgNjWED+J2Wck=
Received: from CH0PR03CA0181.namprd03.prod.outlook.com (2603:10b6:610:e4::6)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.27; Thu, 25 Jul
 2024 18:03:43 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::6d) by CH0PR03CA0181.outlook.office365.com
 (2603:10b6:610:e4::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:43 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:40 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Chris Park
 <chris.park@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 04/39] drm/amd/display: Add two dmmuy I2C entry for GPIO port
 mapping issue
Date: Thu, 25 Jul 2024 12:00:48 -0600
Message-ID: <20240725180309.105968-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 633df6e4-da77-44f3-6744-08dcacd41f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6dMA1FdxMVxq9DoDSdEN6e0LcR12fS2cgiwPh93fFxtD3hviYrRx5xgfmvhW?=
 =?us-ascii?Q?bOBo1FsbnfWM93+qfGb+o9JxuLAP9hb/jUFV9OLuizdO4z5C0gRJ9qkPewO3?=
 =?us-ascii?Q?Yo/QElRvdhNx5pauWPKLFOyoxjv+CAHlewZk8/2UTu/TNZxMAWtkhSZkaffZ?=
 =?us-ascii?Q?hrtA1RA1VHRI3/UR/yJYQSU+DkyRDP/XRxLXAEJGUOflHCmhnDN+lzpBY//7?=
 =?us-ascii?Q?cjbPCALWrhPPcz1Vd7KtN5fKJMHRmy8laQV/by4xLmSXgpaXblWV25eKf6/I?=
 =?us-ascii?Q?VUCG+O6jz9x1D2Kv49fEmNibzyKsi4V0h2Tn/ofAT0nVJdQkhvk8hOEhK3k0?=
 =?us-ascii?Q?JRHahl4KtmQrblGRxhyHcE1P+wa4aHlnpPXmoUiZHFTcHFv1HLGcqf34A8yk?=
 =?us-ascii?Q?PbwaqpsMWFpugXNc5AVBXQaWizQrZKJ0Dpepo8YLyKBoq4ohQnSXrh9DUctv?=
 =?us-ascii?Q?E3D916CXWcp8p1+A2Eq0PfJqka4wD1cZ6MCn+YfSKJ8ub8FFdmS6CZoUhGjc?=
 =?us-ascii?Q?J0Rl9EJmU4YSR5EQZiub33WTdtRBv046wuQ4gaMEmBdBP4UWI9Jczh0K75zo?=
 =?us-ascii?Q?KoNx78aJfxnf3aZBz4c8TX3YSSeDope2hi0zfhapWj3EbtFGa3hdfjUKtlp2?=
 =?us-ascii?Q?83G5VxsxsvBFVGluIX2Qajrz41dd3FyY1Ro/9pgQKXIuctdr2mfmBCdrS+7c?=
 =?us-ascii?Q?GkzUcqLj2q3sApAsrffCsLH4ak2HMp9ajARWkOFsqRKZy6aJL54/lPx9w8hM?=
 =?us-ascii?Q?SvS+k5pBzXpe7YuSy51XejGjYByYXVy1fR56K7o44iZ4WWeDnKPNes6DcT54?=
 =?us-ascii?Q?1C5xSXAKR5a0WVReDaOw2+fUEdFBvpLZAyqVZyOuJwYTc6zBBlT5c16EwH84?=
 =?us-ascii?Q?PsRP1ToyeBDqUXVCIB9siz9nsnva9LnwXhl7ByY1KivRay0FeQjC+YFLPLB3?=
 =?us-ascii?Q?f2xKQi9dPfsqLxKEtZuMAIYlISsEyLVTtkqdZvfzz2uY7qDTHbNWPl4xe4bP?=
 =?us-ascii?Q?UMV1TUbP8SQIWd8y2hqu0RfaaW4PgqB4EM1lr9v46AMA+9VTusnW4tR8+SiJ?=
 =?us-ascii?Q?R7rfTYFrJ/qPm7Qk32GeIP5f2UsLjoHsp86LLtKG8Xh1GK1aoUoQuQ7MOpd6?=
 =?us-ascii?Q?nW/3f720DU8TYtvIPWbFkYwyPzsGeYjCEhtWSLJV5mBYfbTsdu6+FKFCUYK8?=
 =?us-ascii?Q?vajqh/H++uJ9FTOoCFuXicAhZyvwBGzgBeKIowFkP2aobmsBagNpqP8+XP7A?=
 =?us-ascii?Q?Sz1pkNsNnGWaGgwtM6tIk2UX0nfTm3KXtX4zTXFCBHbTKNOEi5CzghOBrYV7?=
 =?us-ascii?Q?isCb1tYFFDXWiQLWQz7dcCnm/j1nl+gFtZkTiXybtERyM9pjgRgPna+js1y/?=
 =?us-ascii?Q?E0FaqYsAhjW99XNrb0XM/Se/HtPRpH6NqQZ7l3O35it/KK2fLI7VCIYCWjWK?=
 =?us-ascii?Q?Jnon4cQ7kzvDexckMMzp6UAKug2j/qch?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:43.0381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 633df6e4-da77-44f3-6744-08dcacd41f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
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

From: Chris Park <chris.park@amd.com>

[Why]
When only 4 I2C is declared, two dummies are required to correctly map
GPIO port.

[How]
Add one more I2C dummy entry to match GPIO port.

Signed-off-by: Chris Park <chris.park@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../display/dc/gpio/dcn401/hw_factory_dcn401.c   | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
index 46415cab23ab..928abca18a18 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/dcn401/hw_factory_dcn401.c
@@ -86,7 +86,13 @@ static const struct ddc_registers ddc_data_regs_dcn[] = {
 	ddc_data_regs_dcn2(2),
 	ddc_data_regs_dcn2(3),
 	ddc_data_regs_dcn2(4),
-//	ddc_data_regs_dcn2(5),
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
 	{
 		// add a dummy entry for cases no such port
 		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
@@ -107,7 +113,13 @@ static const struct ddc_registers ddc_clk_regs_dcn[] = {
 	ddc_clk_regs_dcn2(2),
 	ddc_clk_regs_dcn2(3),
 	ddc_clk_regs_dcn2(4),
-//	ddc_clk_regs_dcn2(5),
+	{
+		// add a dummy entry for cases no such port
+		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
+		.ddc_setup = 0,
+		.phy_aux_cntl = 0,
+		.dc_gpio_aux_ctrl_5 = 0
+	},
 	{
 		// add a dummy entry for cases no such port
 		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,},
-- 
2.43.0

