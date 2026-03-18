Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0C4FEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84FB10E5F4;
	Wed, 18 Mar 2026 01:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fm1nj+ym";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1831A10E5F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY9USZpR/Invc/9dhJnPKrzXdzgp2KtJmn5DtG2l4QyUUDK8tDm3S6SadKVIUFc3hJoNczv/P6ZaXz/Q62Y+mZ5CKdKgJq3+bW3pPiWXVHb/gnU+PaNqP0U7VbyB0eNIXnGt1W8+Rr4EMUczIGyNLGqjibCT7RnCT/tAA6PtlnRCrs0VnvH4z0DBu+f6HH7/LjBZ1KHLZed8vGMgPv0jp88lIGovdPCC7auyKvtJi+FSTeLJ0R+0cK5anh8dzQyOLQpjQEioU+30mohfJDa9RpMoJheXA//M1ggXIYHV1FhCy3ipnJylHvfvnc9F5YPrG5KDkRTJcD8ILWDnTTzw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nUQUvDsWY5aCNLmCbMPImEc3+iAib+3jI7J4ekY/Fc=;
 b=DjcisKw//y3SSI8InOwMsC5eNuIxGvEXuuxIT1hsByAo9TmPjYj4v45/u6ZY+fVrEy+Ij5bTHK6Umb18ApubrqJza33ba76GGL8+kWYH//Aw2njjkTxy5lftFdwxqHLBY/WUt60RNuR3zNR/WctJEiyCcjp6JzP3TNlBjQKozLOZZ2vo1k2ICWEcbIqRsasP3a77YRH8pjTizLIioPnyDsa7Iv0n6yeGniwmKkdkGOnZhPS1aI2VqJMvNdXeicAYB+yGwg2dGQtZBzy5o8oHXVr6InmVkeDWvuZHD/z+0D0SoTxOK7RZd1JwYEADP4uUtAxfvcuBCz9nZrYkGLx2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nUQUvDsWY5aCNLmCbMPImEc3+iAib+3jI7J4ekY/Fc=;
 b=Fm1nj+ym1fOZf5dBsY9Bn9MMrDA4Hr7DSKs5h/7d2HEs8bJ/gF/07x09VY1SKIiElgCxbu5M7DFrqgkbo1AkC7awpH3bsyk7qhZ6Ifc74ZluAC0IOtPfcsRnQLpWJB30iP2BCEV1jgwcAo+xY2FrZzMEVocsNP1hIWqAa4nGb8Q=
Received: from SN7PR04CA0200.namprd04.prod.outlook.com (2603:10b6:806:126::25)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 01:01:41 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::4c) by SN7PR04CA0200.outlook.office365.com
 (2603:10b6:806:126::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Wed,
 18 Mar 2026 01:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:41 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:38 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, Chuanyu Tseng
 <Chuanyu.Tseng@amd.com>
Subject: [PATCH 11/31] drm/amd/display: Update underflow detection for DCN42
Date: Wed, 18 Mar 2026 08:59:20 +0800
Message-ID: <20260318010224.513094-12-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d2c8e3-0af9-4ae6-2916-08de8489eaae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ggtFK8qSMm490CFkAOX4LeYbiPSVhLBcZjUbppZj5xnSj7wwkh0WgGIhijOuzy//0jHezy9V9NX0vz4mgv4GD76ugWMMjIkibWX1TGkIow41zr4CKoBRxjGWuxHkb8mIS5gBzH/i1GFwWlBzsXPd3LbtsRBjVGL1ricVq2BJ5rAamotSX1NTal/w+ZTf/eBTkCsb5fKTtyYKSj22h1FH01K0bn1sLr9Ip8M6xC/6nfiZZC2WkPSPzTUACBvBMCfZbbry/8PvP2yPRVEShh2HFqqCWTXU9l4HKIpIIaCms0WgomRfBmKfyE2xSEKllxcI7rEIsVowqhjvRyJZcpib8r2LKe5fdbbNvF9uNKx2QZAo/P1jseP6h3Buc7fepUo/2q++rFEKZz/pg/6EYcVgWutJUb2vKPiLKQ+D2StNrnzRw2pqsfo6dtnPGeJ88RbBVggmZEeXRKGwoNBTzMfNGIqPwrWFJOyd5b/BGKz4DetG+MJ9CWdSQCgOdZqLyAfwDYUtw+g+vtLi7vXXsQaJVvEMGalShvAcxfGF6OD7kBDpjIjxf8AK8fTNQVWpyF9r+MXCK5Bt0IR2gjJKcOj8E64rZzOPZ7i7iEYN7PnFEtCekYV0vV0/mH01ecQCuqtdfUc6M07kWMVPwzyvwB7xyyxkjuTn+tpYZNyF/+mt/glhF+UQkgRblvuuKJfClJArjcZwuUfoOANAOF8Zu8WI/U8YieJpRwclWA6XVoNy7i4KNmAkE8ESaw1x2n7SIarGHJMqlOZnqDOsDeuLFiX1ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7b3vHjNVuFanI2J1mQRbGq7GkBLaXZzw4dlShd/E3wWzhovtLcq3uLopMgseSti0Voj+S2QUAVtzcJjwxIpxUE6Q+s7l6kxqEX9lEGWh+JoMdno4T7CZBe9xjGn0X6SSmh9WlA5rP6tZTDulMl6ebEWOGO95ol4pevFOKAKUAtecfR0PR+38U6lerphS5taV7keNY1YtyXEznd9DtJXyE7NsKT+ZpiQ0Jut0dO1pZeK/ufMB6zYiR8Vt8ZjD96nmpAA9k109GLhDghpmQzvZxyy+nS4Xlxq1cKuoEPKeawPVEeNfKj4kDsOKf8BDDSVF9Eq99bPv+lElHl+WpDyduDn9s+uldAU+kmwitasyWLa0EXJ/6a1KKa489c1JAiRXB8nFaOMvyH5wP/Brwb7tI05NQOEbF1YFWuNOf0Ujzxj4E865C0UWQvTcHS86xNS9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:41.5534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d2c8e3-0af9-4ae6-2916-08de8489eaae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
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

From: Roman Li <Roman.Li@amd.com>

[Why]
The DCN42 underflow detection functions in dcn42_optc.c use
OPTC_RSMU_UNDERFLOW register but the register offset definitions
were missing from dcn_4_2_0_offset.h and dcn42_resource.h.

[How]
Add missing register definitions.

Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h  | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offset.h | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
index a9b26df14520..8e7a09402de5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.h
@@ -481,6 +481,8 @@
 		SRI_ARR(OPTC_INPUT_CLOCK_CONTROL, ODM, inst),                            \
 		SRI_ARR(OPTC_DATA_SOURCE_SELECT, ODM, inst),                             \
 		SRI_ARR(OPTC_INPUT_GLOBAL_CONTROL, ODM, inst),                           \
+		SRI_ARR(OPTC_RSMU_UNDERFLOW, ODM, inst),                                 \
+		SRI_ARR(OPTC_UNDERFLOW_THRESHOLD, ODM, inst),                            \
 		SRI_ARR(CONTROL, VTG, inst), \
 		SRI_ARR(OTG_VERT_SYNC_CONTROL, OTG, inst),  \
 		SRI_ARR(OTG_GSL_CONTROL, OTG, inst), \
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offset.h
index 52fbf2dc1899..3755a984681a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_0_offset.h
@@ -9036,6 +9036,8 @@
 // base address: 0x40
 #define regODM1_OPTC_INPUT_GLOBAL_CONTROL                                                               0x1ada
 #define regODM1_OPTC_INPUT_GLOBAL_CONTROL_BASE_IDX                                                      2
+#define regODM1_OPTC_RSMU_UNDERFLOW                                                                     0x1adb
+#define regODM1_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
 #define regODM1_OPTC_UNDERFLOW_THRESHOLD                                                                0x1adc
 #define regODM1_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
 #define regODM1_OPTC_DATA_SOURCE_SELECT                                                                 0x1add
@@ -9060,6 +9062,8 @@
 // base address: 0x80
 #define regODM2_OPTC_INPUT_GLOBAL_CONTROL                                                               0x1aea
 #define regODM2_OPTC_INPUT_GLOBAL_CONTROL_BASE_IDX                                                      2
+#define regODM2_OPTC_RSMU_UNDERFLOW                                                                     0x1aeb
+#define regODM2_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
 #define regODM2_OPTC_UNDERFLOW_THRESHOLD                                                                0x1aec
 #define regODM2_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
 #define regODM2_OPTC_DATA_SOURCE_SELECT                                                                 0x1aed
@@ -9084,6 +9088,8 @@
 // base address: 0xc0
 #define regODM3_OPTC_INPUT_GLOBAL_CONTROL                                                               0x1afa
 #define regODM3_OPTC_INPUT_GLOBAL_CONTROL_BASE_IDX                                                      2
+#define regODM3_OPTC_RSMU_UNDERFLOW                                                                     0x1afb
+#define regODM3_OPTC_RSMU_UNDERFLOW_BASE_IDX                                                            2
 #define regODM3_OPTC_UNDERFLOW_THRESHOLD                                                                0x1afc
 #define regODM3_OPTC_UNDERFLOW_THRESHOLD_BASE_IDX                                                       2
 #define regODM3_OPTC_DATA_SOURCE_SELECT                                                                 0x1afd
-- 
2.43.0

