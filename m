Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FE0E77182
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Dec 2024 15:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F74310F072;
	Fri, 13 Dec 2024 15:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KynBXEfN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5450510F072
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Dec 2024 15:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyhloOGsgqs/JTLAgOMNyr2XoX8vVshW8G1sYtV6yTiHpJymS8LfuDXXPtUJ3yQnGf8ns1oWhFH6N0QA1F9WsGGNvJTTAjFnqOWFvZO7cSbxN2mz1xKJekhQqUYaL6tIOlg/33ogVF06/FfVNFn3xs4yHZBRMMkNgYDBPoopUQXODBvO2/BEwPwJIN8D43DJGEmVQg1hR+xLfbZZPmUzjaQBpP9l7N+xxm14UGJp+IlSnhGDkFnq+PmubINppl5AXpktrFC4qjt7W2Nhmh+fc85Oa/x6arNDOknyM8zgeSUzyqAA76AoPRMr9T3kqziqugcWBz1qhyMY59G2pV7pnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+hSJu4SEf5V4TyPVaRUrz/CMvapagOr4X1DdQE7XTU=;
 b=hZyBHfrg2cUnuVi9gp84rfXSLJwI8zV5hSJTm0mlqsTtrrgivm+4/RTGFfuPH/4dBm+w95rWz9K+eYtvcEu26iFaccyRKF9eTHRuHmHugV/JhVkQCB5ceEIpQzxhxh8UXYICUFCLh1dsk9n4IkteJ/OeT0HbUoMK99oe9Lp4rrF1pu7M0rkEQRm5X5hbm9GeWUdbfD1m6fYS7W/vcSemURghaLWlOqNvsi7PzYqlhl/3aqlWX9n2LdOdZXP4gEybEcJI8R8XU/6BINwtocdvx7seOWcwey12I3LPHMoxUTRAscl/GgiOhv2c6Tlj+QpUW/dQCVysPqNfb5I/FQ9REQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+hSJu4SEf5V4TyPVaRUrz/CMvapagOr4X1DdQE7XTU=;
 b=KynBXEfNblCVdsGLKB9U0vrp13AtyAPYY4Y8XBJo9NS23i4Aju+CigasE0TPQ9ry+gzt/QxwcV/pNxQQeKwMrYzLsROqcIIKBSdeaxkKQkdYdQHMZgCFl+uix/xDOeJBKYx0/DgTo7N9JQjJN1waDSdJqHee+xV1XdC0Qm6BKD4=
Received: from DS7PR03CA0069.namprd03.prod.outlook.com (2603:10b6:5:3bb::14)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 15:55:01 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::a9) by DS7PR03CA0069.outlook.office365.com
 (2603:10b6:5:3bb::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 15:55:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 13 Dec 2024 15:55:00 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 13 Dec
 2024 09:54:56 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Shunlu Zhang
 <Shunlu.Zhang@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: [PATCH 09/17] drm/amd/display: delete legacy code
Date: Fri, 13 Dec 2024 08:52:41 -0700
Message-ID: <20241213155405.393252-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
References: <20241213155405.393252-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ae0803-3869-401a-089e-08dd1b8e7fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Trq6kNojHHfYpf1TOQqxG8hF4j2XnBLL0Jb/Piogfu4oJUzKxDz19QuEsUqS?=
 =?us-ascii?Q?0qhzltzH8IyNATv9ykyyd9Mv2Pg2Ky8ZlNCQNb5tbpYNjFYeMAXna+obEom8?=
 =?us-ascii?Q?Q5VDeGOCQ0ElwF63szt37axglkmz5/xQ/Wy5HWpcCqTtZsBBHjscpqq+nnCl?=
 =?us-ascii?Q?iR9FokoqkJTBvQKsCwHV9JuMovNFQ4dNNyUy5pGzSee0QxlsU4gZnyxYoLLO?=
 =?us-ascii?Q?5bt5gQ+19hdbrE2aBgUHeJwVMuaaZfWMM1Cxmhpp4HI0hy8jdpPPGJplaPCE?=
 =?us-ascii?Q?z0tlFS1wpDM5jLzXfxlYr/Kpalp08j6BP+yeE79iBR5fC/eQRPM3cCQTDfA4?=
 =?us-ascii?Q?6NypaDPvhU1qSGxZPfobOI6nN3TOi6XI7dzBn/m+LE+wT8s3gKnNGKsG0wHZ?=
 =?us-ascii?Q?Xc0U5f46pLAfbFr7sS8SEDHkXsfdwvYuMfkVh3ZR9TwlzNqiGvcRYnCmdOa0?=
 =?us-ascii?Q?9tTvh3tIloP2x7Ga66KYkXg2tA4mdSjWgR397oLP0vailY9l+h4jP+N8yZE6?=
 =?us-ascii?Q?s3EfHi76GqHwfYbKtnLl10TxyptkKpFLzYm+cAuIXdMdugJWKao1lMrLtUpl?=
 =?us-ascii?Q?lTsa0VhWGPf6EFfVoOq2+leq9GI1auFR+8MZV2CLWSVwOO0sJhEgBk5AH6ma?=
 =?us-ascii?Q?PbDJaysapeDAyqyrbYWUHPaXJltQfcf1DrITW/wrrh7Bq12g25z0yjpDyWN+?=
 =?us-ascii?Q?xJl61I/OC0rGGnataXj8D7nSD+RrHN5z4VfBrIxRnu85420jhvWlRrgu8flm?=
 =?us-ascii?Q?Lj2OM1xhWiO0faDvErLgcceqKPEG/m2zj/PP72FgDKE9JDJlwmaN0fU1k9If?=
 =?us-ascii?Q?dMAwzFndS1anNBQfGnUbG72eL1tKu38o5feZKN/mHK2oe36nfbQX40ErPgUK?=
 =?us-ascii?Q?b7Kn3vnzeihDLSLpStShQI1KkBP3LUvuocw74i7Z12p78I/6vH4fuj7jr4Hy?=
 =?us-ascii?Q?xB8ho/A5KOYR/9Zp6am8panDPt6v7jW0Uz8xMzZYe1aji+zPTO8FM/QvccNk?=
 =?us-ascii?Q?ZeBty44kp+NdMSyic44l6nDQF+vuuKgAHHajeCTkMEMMhLyrsZde++xqc668?=
 =?us-ascii?Q?mtxkn5uuhfvcC9CysrZaQLnyY4xSHmJ7JjNHr75/1KXxcXbGkkGz/Ue5bs8h?=
 =?us-ascii?Q?SDOrwpLVIlueBH3fIV2yG6Pm9JEhu3yZRb5aLbhMIUctcCKufvuRCEbrT7bK?=
 =?us-ascii?Q?vgOCYVBrrUq3YMPcSzsy+G3y6lXIBLJWGeIhf3o2L8BbVqILnUY4f+kexSMt?=
 =?us-ascii?Q?pHfgp/LlswTBnFrhHzzDERedNaNXjsX2gw8u/uIIH9V9PmuycyH3JQk9xEOQ?=
 =?us-ascii?Q?24sZbFLT9eITnF3NOH7f6Wyx4wbB2uaZCPLna2gX39m30iamwCJZGXbrGTtd?=
 =?us-ascii?Q?GY3rdHyDuwVpWNn6f0dPAi7MGbA78xFh5nUaqHYKy5BlvSMIQsDv4zno55mD?=
 =?us-ascii?Q?j7xl4JVcrimZptMPF0Jilm6TWbs7VAYp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 15:55:00.0341 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ae0803-3869-401a-089e-08dd1b8e7fe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
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

From: Shunlu Zhang <Shunlu.Zhang@amd.com>

Delete unused code.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Shunlu Zhang <Shunlu.Zhang@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c    |  1 +
 .../amd/display/dc/dml2/dml_display_rq_dlg_calc.c    | 12 ------------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 76d3bb3c9155..8d4873f80df0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -1562,6 +1562,7 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
 	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_row_vblank = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_row_vblank);
 	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_vm_flip    = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_vm_flip);
 	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_row_flip   = 0x%x\n", __func__, disp_dlg_regs->dst_y_per_row_flip);
+
 	disp_dlg_regs->refcyc_per_pte_group_vblank_l =
 		(unsigned int)(dst_y_per_row_vblank * (double)htotal
 			* ref_freq_to_pix_freq / (double)dpte_groups_per_row_ub_l);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.c b/drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.c
index 377ef6d01ae5..00d22e542469 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml_display_rq_dlg_calc.c
@@ -427,18 +427,6 @@ void dml_rq_dlg_get_dlg_reg(dml_display_dlg_regs_st		   *disp_dlg_regs,
 	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_vm_flip	= 0x%x\n", __func__, disp_dlg_regs->dst_y_per_vm_flip);
 	dml_print("DML_DLG: %s: disp_dlg_regs->dst_y_per_row_flip	= 0x%x\n", __func__, disp_dlg_regs->dst_y_per_row_flip);
 
-	// hack for FPGA
-	/* NOTE: We dont have getenv defined in driver and it does not make any sense in the driver */
-	/*char* fpga_env = getenv("FPGA_FPDIV");
-	if(fpga_env !=NULL)
-	{
-		if(disp_dlg_regs->vratio_prefetch >= (dml_uint_t)dml_pow(2, 22))
-		{
-			disp_dlg_regs->vratio_prefetch = (dml_uint_t)dml_pow(2, 22)-1;
-			dml_print("FPGA msg: vratio_prefetch exceed the max value, the register field is [21:0]\n");
-		}
-	}*/
-
 	disp_dlg_regs->refcyc_per_vm_group_vblank		= (dml_uint_t)(dml_get_refcyc_per_vm_group_vblank_in_us(mode_lib, pipe_idx) * refclk_freq_in_mhz);
 	disp_dlg_regs->refcyc_per_vm_group_flip			= (dml_uint_t)(dml_get_refcyc_per_vm_group_flip_in_us(mode_lib, pipe_idx) * refclk_freq_in_mhz);
 	disp_dlg_regs->refcyc_per_vm_req_vblank			= (dml_uint_t)(dml_get_refcyc_per_vm_req_vblank_in_us(mode_lib, pipe_idx) * refclk_freq_in_mhz * dml_pow(2, 10));
-- 
2.45.2

