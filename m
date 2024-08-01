Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D556C3DA64
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 07:04:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3825110E89F;
	Thu,  1 Aug 2024 07:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VwdOdNP6";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF6B10E89F
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 07:04:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qP5x7SJpAfGdnO+NutDnn0NEPP67kraoz8Pb7QduGTctU8+OdB7+KPCbHEARpHQ6O/oBrR1AooayIjE3gjfloAB2oh9tNtRUDyPzfynE9oGrA+NEyYTMIkrm3vCvb2rSG5l4NLwgf2sl0qsUCxMfBs9A2F+Z6HOjrjxfq1j6RsOLQTw4hdEdVyrrE+QBVHpUFRA8zThNN5kmW++G00zL5nmJ2rZSOSNUeNe2eeX77ekl/+EY8Pxun0SOfemPeTWQDlcEL5yIyjrttinJfU7i/1wg69sybtqhvX//WKNRrncBrSKAaOkJOr/eCBHf468QWsoIKKFT+UC1KsBWGh6LJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkLdtywjTmyTcgJgUFa7TvIJvUt945BZzr8K+af5fas=;
 b=DCz1jrIpGWrwEFpY3zOERl3sFv5Zj7xAJDRnOhrURkQYuAqVfN02EKl1cIJT03XKFLxHXMHx3CpLircwDlpEegr8EnUYGE/IFDSavw+yd42Ax505LtPSVOFTU2ZhCkPNh2g65d1gmqViT0nB127x/fXz5UrDgKZAkVD4wDAOf82guP7X3qs3ZhzhspSZaVe0WDY31vg1YoyoQp+5OvyBr9SueRcshlZnajIWkkgFWUE1gKxmA+rgJWHYFhII8+hELmTXi26s2u3xSpt23jdqxa3hDUHqXXzDa6Gskfqzo7rb5AIpKNP87G8aK8I2zTW1BjK4RPqbzPub1N+E7QvmUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkLdtywjTmyTcgJgUFa7TvIJvUt945BZzr8K+af5fas=;
 b=VwdOdNP6EWNBGOP7XtxUSK+MuVsqM4oDz0LXcKh/xALaSKbfnZZ3prfjQoSXQBPLnJ0z8y9RP1eNhIkBgUbz8fR2yfcAIOC5o777zAQejDaunpJ0CmcOTtT4Qp0WfNi6Ef2oaEBxlw3C+QSZMYSiiOtkhX303hZbcUbjEqGWrEU=
Received: from BYAPR08CA0002.namprd08.prod.outlook.com (2603:10b6:a03:100::15)
 by DM4PR12MB8571.namprd12.prod.outlook.com (2603:10b6:8:187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 07:04:50 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::25) by BYAPR08CA0002.outlook.office365.com
 (2603:10b6:a03:100::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Thu, 1 Aug 2024 07:04:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 07:04:49 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 02:04:45 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <jesse.zhang@amd.com>, <bob.zhou@amd.com>, Tim Huang <tim.huang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: fix unchecked return value warning for
 amdgpu_atombios
Date: Thu, 1 Aug 2024 15:03:32 +0800
Message-ID: <20240801070333.423881-3-tim.huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801070333.423881-1-tim.huang@amd.com>
References: <20240801070333.423881-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|DM4PR12MB8571:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b803537-cb9f-466b-6ffb-08dcb1f83c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YBZLS3sa+HWiucjiv7pMVFGQIr6CrskGmsPJxN3od15SQ21TDwB78ikPt4Wn?=
 =?us-ascii?Q?5Z5xALjnpzItr8K0tf6KxqZrMg0AqifQwxatv9D0y8nx0R19S/w7vqJTJfp5?=
 =?us-ascii?Q?wC7TiBZGLSJxT/EUqL4ACKdAVr94Q1XClEQ4D5bkzD4UZi6rivsl6qQ+4ed1?=
 =?us-ascii?Q?Tt/aw+F08NtGppanycz4O+VCRuYVuHg1ff+JKs5BCe2KpChizWttX2LqnKCj?=
 =?us-ascii?Q?kiJkdDgDOuOGvQvhewIKZ5OZ1jXO9zcb1GDiqcyXQMwc1cFy3K0eIWRlKpv+?=
 =?us-ascii?Q?ipHe0R/lSPUSRpOT8tr9dZ0jfEJ90qT9PKDLLtJBjYItEADgwki93CFCHJt9?=
 =?us-ascii?Q?ctBgVXJEy6j6VlaiKKMo73pqc2lGXsakftxLx6EVKqrgsDKpFTfNWGaTnOQt?=
 =?us-ascii?Q?WiagsMTOcpUo4bIkCYrz8x1eqEcGwvsF5WL/6nUr6L14lpvTUpe8nOCV1Rvy?=
 =?us-ascii?Q?j489xyfgGUDb+CIPYIoTbZkF8tKUCoDwAeKuzAZNZ+zRcPc4rakTkL5/eZoa?=
 =?us-ascii?Q?jTd9AyBO1AyVw4CAOgxhQY1ggpioBUf1aqYxoeigE/JkM5BefAa2dZ9bVOBK?=
 =?us-ascii?Q?4QrhOkoKij6UeKi0UIcNcvN6TMK9CsQqnfJnu5MFExcCHbETqpr51sDK29Fn?=
 =?us-ascii?Q?98QdDlVUgk94reqwpma88y+gDnbZZ6ZNPQEasVWKYZy+Vx+bOlpMmUBHyubN?=
 =?us-ascii?Q?4VumEXxHdj3bhhZG8Pr3d2EZDQfEiHxzVLKH5D6qZWABDtw/BC1NhGkXyn45?=
 =?us-ascii?Q?WLKdg3sAEiEJH1Q1EqkjHQczaa43q9c7HpfjMPBcEiRI5t3OcLk53fwnanXz?=
 =?us-ascii?Q?wlHI++U/MTE76cR3zhs1cI9oibxIsI+aeiBlGGifxecN/Eoth2BLE49Ve8Do?=
 =?us-ascii?Q?PGS9ThoxkiM7Yl2N0A2F2dhMyAXllmlm1PEJclJ920dtu+UiPsWCqqMFeHUk?=
 =?us-ascii?Q?5E40A6QF+fsS6kvJ0Gbq6Iura2cmMnDR92hMfhzyjI9MvfKB7VIOKnKBVmYF?=
 =?us-ascii?Q?SjL+o9NboQSKIHB5ZoDktd8KNWV28fFntsiPYEVCycHKyWI0AoL1gJnQZEOH?=
 =?us-ascii?Q?yXFooLgPRkknh+vgrDkeHJf5C5zbglKsbZ8WzD+sKKGyPmnpsgXLYjN46Tvi?=
 =?us-ascii?Q?W4v6JfruIceoDCSq/xDwKCf7woqYxnXnaBSGQt2B8Uamo+GAlEbNR6rCaHt4?=
 =?us-ascii?Q?OVhTDcR+R1oQLf7l8vPZjDu+HLQUdq6BxPgEPWdirM6WTIYnVpSrx9v1MqAe?=
 =?us-ascii?Q?9sljUchTVgAvOqIvWF9ESVujG8QKGeqDuoknZnSuSxXZfXcSE/+MHt3JgWcr?=
 =?us-ascii?Q?B01H9loG32yALLSFTR/d5dRcZ7NGI0wWv84DV4dgR/mjkASp91wknNyr6XxJ?=
 =?us-ascii?Q?QTEMeft9PBGQaBCo51wuyOOkDdhEaD25RQGU8+vAP6fXChGGBFjDZ3LubkTS?=
 =?us-ascii?Q?/Upq24qDGyynbrXUpQeozZ1czZ8ft9Xu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 07:04:49.6994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b803537-cb9f-466b-6ffb-08dcb1f83c1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8571
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

This resolves the unchecded return value warning reported by Coverity.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 35 ++++++++++++--------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 7dc102f0bc1d..0c8975ac5af9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1018,8 +1018,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		if (clock_type == COMPUTE_ENGINE_PLL_PARAM) {
 			args.v3.ulClockParams = cpu_to_le32((clock_type << 24) | clock);
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-				sizeof(args));
+			if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+			    index, (uint32_t *)&args, sizeof(args)))
+				return -EINVAL;
 
 			dividers->post_div = args.v3.ucPostDiv;
 			dividers->enable_post_div = (args.v3.ucCntlFlag &
@@ -1039,8 +1040,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 			if (strobe_mode)
 				args.v5.ucInputFlag = ATOM_PLL_INPUT_FLAG_PLL_STROBE_MODE_EN;
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-				sizeof(args));
+			if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+			    index, (uint32_t *)&args, sizeof(args)))
+				return -EINVAL;
 
 			dividers->post_div = args.v5.ucPostDiv;
 			dividers->enable_post_div = (args.v5.ucCntlFlag &
@@ -1058,8 +1060,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		/* fusion */
 		args.v4.ulClock = cpu_to_le32(clock);	/* 10 khz */
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		dividers->post_divider = dividers->post_div = args.v4.ucPostDiv;
 		dividers->real_clock = le32_to_cpu(args.v4.ulClock);
@@ -1070,8 +1073,9 @@ int amdgpu_atombios_get_clock_dividers(struct amdgpu_device *adev,
 		args.v6_in.ulClock.ulComputeClockFlag = clock_type;
 		args.v6_in.ulClock.ulClockFreq = cpu_to_le32(clock);	/* 10 khz */
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		dividers->whole_fb_div = le16_to_cpu(args.v6_out.ulFbDiv.usFbDiv);
 		dividers->frac_fb_div = le16_to_cpu(args.v6_out.ulFbDiv.usFbDivFrac);
@@ -1113,8 +1117,9 @@ int amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
 			if (strobe_mode)
 				args.ucInputFlag |= MPLL_INPUT_FLAG_STROBE_MODE_EN;
 
-			amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-				sizeof(args));
+			if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+			    index, (uint32_t *)&args, sizeof(args)))
+				return -EINVAL;
 
 			mpll_param->clkfrac = le16_to_cpu(args.ulFbDiv.usFbDivFrac);
 			mpll_param->clkf = le16_to_cpu(args.ulFbDiv.usFbDiv);
@@ -1211,8 +1216,9 @@ int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
 		args.v2.ucVoltageMode = 0;
 		args.v2.usVoltageLevel = 0;
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		*voltage = le16_to_cpu(args.v2.usVoltageLevel);
 		break;
@@ -1221,8 +1227,9 @@ int amdgpu_atombios_get_max_vddc(struct amdgpu_device *adev, u8 voltage_type,
 		args.v3.ucVoltageMode = ATOM_GET_VOLTAGE_LEVEL;
 		args.v3.usVoltageLevel = cpu_to_le16(voltage_id);
 
-		amdgpu_atom_execute_table(adev->mode_info.atom_context, index, (uint32_t *)&args,
-			sizeof(args));
+		if (amdgpu_atom_execute_table(adev->mode_info.atom_context,
+		    index, (uint32_t *)&args, sizeof(args)))
+			return -EINVAL;
 
 		*voltage = le16_to_cpu(args.v3.usVoltageLevel);
 		break;
-- 
2.43.0

