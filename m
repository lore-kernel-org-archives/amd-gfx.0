Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C977FD116F3
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Nov 2025 12:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C34E10E143;
	Fri, 28 Nov 2025 12:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WU0t4fyy";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012068.outbound.protection.outlook.com [52.101.48.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F5B10E143
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Nov 2025 12:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOEUz9+JJOErg362Smrd+jYr0wDI1V9620PLKjDtFoo6Ihf3a9U1Xjbl454bUcMluLPujQw2CuybkViIsjaEsPH9Jo5Yp+hGVZh/Tiku/UTA4ouU8gKU3gQbG8E04NFTKd4aJxVpD8P5dDZ9yA3ABhXtOOlBoK4Sv+43xeiZIKICO9yHrFgseYilXB//SjvoB1X174LFCLBJJWknLFL+WgXbJyx0K6oZpMq5aFWk1W94CbnbsH5oKEYJqm+vj7eRSHmse81hctFvbedaKj+qeXjiAtRWMFxyJMxAle6uhVUc7lZKrabMTVjGApbthu7FxR/a+V7LT20O2f3gPfDnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJwY4sKjAh83EUAmzy1284auBBWzhUln/BBHEmYOqOQ=;
 b=LMWzyexrjbx6LDybYskfYhC0C3OP7f2bD4Izy8SUTeUDu1p3eky8z2iaaTvBksiMf+zB45Hz+dlQvLS4xRKdUJC5V+n+YC7AzQ2487TRHkxz5sdi/3PTcT5NDeL9MtoMkFqMD7BEbtA4qU9JWcaYITnGYqly+FI4Ur/jv/Rc0B4dMC0ex/nxZLFOJ+BmA/e6A93VZVOhTIEf5+WbVaWzeOG1I0NfsR6MGTLXWjl8tObEeq/BJ358GojoNQ+OJMcWtFj2qSSDGiO549yKxlSfU8/eKTGJfgHa3dF7ymS5uIcuzImB6pYPTRRgvcHrgUb9sQnbQxzJO8vP56AuAjPBgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJwY4sKjAh83EUAmzy1284auBBWzhUln/BBHEmYOqOQ=;
 b=WU0t4fyyTwLWk5YxiVS3cMMbQuVno12aBRSXcRIW0zANQPtXi0dYWS+tr0yMxkPqLIAn+DmtYt4ttbuXo83POMtE0QYaL8C2NvEyKdvWrV3AgLtv60F8o9SeL4JldYYeuYOmoRiNXQLcXIFVp6/f5egDlCLs8y+xROz3UoIZ1Fc=
Received: from PH7P221CA0090.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::25)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 12:29:13 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:510:328:cafe::49) by PH7P221CA0090.outlook.office365.com
 (2603:10b6:510:328::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.16 via Frontend Transport; Fri,
 28 Nov 2025 12:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Fri, 28 Nov 2025 12:29:12 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 28 Nov
 2025 06:29:09 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <tom.stdenis@amd.com>, <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Move enum for VDD board
Date: Fri, 28 Nov 2025 20:28:54 +0800
Message-ID: <20251128122854.715773-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 06759a31-9be9-4423-ba8c-08de2e79bce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XqEQO7UHbcN3pXCxbqO2suhMc9RFJlwSL8XLe4ZkTNlm9tQ66DuzypqOXDyb?=
 =?us-ascii?Q?WDiUcz2GR8+1WKqt+zZMNdCz1cmOB2G5RPLqX1f6LWPLvbtVLxFO2ZB8sY6b?=
 =?us-ascii?Q?PDwwxM/wm1QO9jc280x7HnA2xfZz5lB4ApMKdHGKo7nLc++7OGld2ghqO3uf?=
 =?us-ascii?Q?p/+7XdNhytUDImgJTkUTWmtW1RjbwRns0xfCFMbhH2tuP/7m0LDlVtncCwi1?=
 =?us-ascii?Q?dtrJbn5y5hMIb54BCdHQ8jEuNACT93yCAA4tvNyOmzYK8cC6QPJHHPf6EVEE?=
 =?us-ascii?Q?RbHDrjIMsCyPT64XB2YBMFa6SJnr0WROquL72ZsG1QU6Gd71fbEswJumG3IB?=
 =?us-ascii?Q?Y0GQVa5VX8BhdkUALfHVeGRst75BOkF5iwc79YtFz4ywr79yEy/Ih8+TP/7b?=
 =?us-ascii?Q?P7EvkoTGrMSGrHCK2Pg+yQ/D3BaipRTuX6Z9pD+ek4q6CTUXTN+D11nnvBHj?=
 =?us-ascii?Q?Efg4oEAbQnZPd+jBA+zSOmDw9Rh2N6fXcylHR4biD1vm9OSdOrKmg/rmhIu8?=
 =?us-ascii?Q?/uuCgsyonWUn3AcOuHcjzeD0FGjm/iRtrWMDxAxcP7b6xkoeo4DDN0m2zzHd?=
 =?us-ascii?Q?7bKPeMWrAPmZYa7q6Qjvp0FMJnhAx4OI8CMIy72lHmvKDYPhCu0z68HJIejo?=
 =?us-ascii?Q?X9ZQiJ2oO9XDUyLhyLR+1lzF4IBD/ylWWY4zdMem6+KpoUEyfLbUTktk44dR?=
 =?us-ascii?Q?4X45Mpmkl1qfSjke9xyPTOGPYm02pAIhCAEoGOlr2Y3U9houeX/Mp+gX1qZU?=
 =?us-ascii?Q?igxzMKZMwE5nJpBYCRVT2qAPm751B1m99jMGes0fOX9hkCx8VUila55PJ/cQ?=
 =?us-ascii?Q?w1QJb8zMLQ3vAuadLBWOBVPcb1418L889Jet+OyhhCdOZtoR+pu9XEF9g+Fb?=
 =?us-ascii?Q?pWWSyX0OWq5WQPbc8YQYaqwD/+8zaHdgQne3xYu5MtA9j+0X3IAjZNVe3TvF?=
 =?us-ascii?Q?OnglfAtAZPoqH886LnhtATxN0Ohfut9unR4ESonCT7ydciTw7SXDVnhsNl6y?=
 =?us-ascii?Q?BIdKFZY8aEY1uoi8n6OZTxwQx9ayGXxSgiPWczDhcdZ7fdKU8AY46G2cx+4a?=
 =?us-ascii?Q?8mrpQduf6V2CyeE3dyQcidENpwS3Qth+Rsjs8X6DBaCeFSlOmWjD1mZHyOoe?=
 =?us-ascii?Q?bWyTu1TOtlPdvqA94dCD9R1tl8yUojt4+VfVriP8+KddXtmLKDyBERKRcBKw?=
 =?us-ascii?Q?MrHtG47nBpd/cHXD/BjsFQphE7Ktfux5gmogWyZ6wqm0mTTT4a932Ya8F07p?=
 =?us-ascii?Q?Jl/iF8uTmNxkVxaNwuAiw+GljZdFiwRctqSGG7N/Ri2rfQihpAdpChqnu2lD?=
 =?us-ascii?Q?U6Y0K7SPvnrnLVV0ae8g5pZQlcYMBBkleL47CW6gl6JLTp1a7diVSNYWYV5P?=
 =?us-ascii?Q?sq/6NivfjfT2aKcMnEKVZ97TpIjOjE43vKf+9/Nbqismdnqth7ZiKFohijfY?=
 =?us-ascii?Q?PpkNyjaxzrr3t24vz3TAI9IQ4Xg5IrLpN5p5HQa+tr9FKPEfGiT/F8sb3+Jh?=
 =?us-ascii?Q?IU4oZROkG7qquMA3FUfGZ0F9Je+o7KzRvz4XCqkKvRrzDGTltlKgAUvzFmS2?=
 =?us-ascii?Q?VvjFSQObzLjbUNuye+4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 12:29:12.7138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06759a31-9be9-4423-ba8c-08de2e79bce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
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

Move AMDGPU_PP_SENSOR_VDDBOARD below already existing
members to maintain backward compatibility

Fixes: 96ac487c1200 ("drm/amd/pm: Add board voltage node to hwmon")

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 92477120c28d..2a454f06c022 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -136,7 +136,6 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_CPU_CLK,
 	AMDGPU_PP_SENSOR_VDDNB,
 	AMDGPU_PP_SENSOR_VDDGFX,
-	AMDGPU_PP_SENSOR_VDDBOARD,
 	AMDGPU_PP_SENSOR_UVD_VCLK,
 	AMDGPU_PP_SENSOR_UVD_DCLK,
 	AMDGPU_PP_SENSOR_VCE_ECCLK,
@@ -162,6 +161,7 @@ enum amd_pp_sensors {
 	AMDGPU_PP_SENSOR_PEAK_PSTATE_SCLK,
 	AMDGPU_PP_SENSOR_PEAK_PSTATE_MCLK,
 	AMDGPU_PP_SENSOR_VCN_LOAD,
+	AMDGPU_PP_SENSOR_VDDBOARD,
 	AMDGPU_PP_SENSOR_NODEPOWERLIMIT,
 	AMDGPU_PP_SENSOR_NODEPOWER,
 	AMDGPU_PP_SENSOR_GPPTRESIDENCY,
-- 
2.46.0

