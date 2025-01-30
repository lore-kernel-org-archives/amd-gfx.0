Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1595CC0218A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2025 09:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B836810E33A;
	Thu, 30 Jan 2025 09:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z+WMD5uM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A98A10E33A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2025 09:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEWfUbDgZrzHXUtlwZX2EOAWBhg023i8g1cZQH450qAdMvWb4yqq0S7I77vF/hDDJJb87Yym8Zm4pwptpg+W7skhlive1GxNpkbnQVkQIkKLL98H19AotuAakVH6kyQW64txQBvedBUYkzPYNAlHKAvm/Jts7XARt20Ddd09FOtvvf2ZnJ4JL5U1Nzv1xMAdHwtWbkLzX66rbiU38XOY+AF91F9FVLfvfeD+DdjzeQZnw6oSyZ26UJPznYlrcioMLGoiHEXyS/v12yIaIMpMNyCr6Vr5Ebm7ZHiNPTB5Xpe8WdZ7dzZhrG1AiPL2BvwuuJRV8OpktahcIqC0ZxJJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxSCn660AcaqesYI8n2WAOlYLw/qHZdUGXtnrc+bO/g=;
 b=Pr5pau9M1HVpHjR5mQYgh/tNVL2MOaowFKSB6HCTIZ/ucF80FiZVrLrQMUpou1TJ0u2NMpZChutHunzHJQvVVeKaLVxF1PmXlCRS5wzXY87W2wErTBgmbxZU+wQWPkl5KyZg5HQm5vVn623+9Xau7v9Ve1xFH5xmcMqY+Ghw+K88cH6OEt9yZNxLCvVZxA133C52Kk2UcYxDLUQhH4TzsZR7AsbuhI2e/UTQsDRFYdMSlapU/RJqcqaCrPTnAyPkEk1jiVmGwm6KhGUCTFSvLnKqbNDigoWTU8XFi0amLyT/4OnF2FQHsFxMMMLio/RgrfM6VnEQovoTQO0Cw5q9bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxSCn660AcaqesYI8n2WAOlYLw/qHZdUGXtnrc+bO/g=;
 b=z+WMD5uMW9RoG8qrfTLGSJzrTYHyrd271u6IzhbvdigjBPF+ozrj2ymKJQKLF57lH7/VkhGqj4XmeutX0svAF7zZyXU1n83T5IfmYvfNzgPcK7L4qB/LXdgShtJz9ycssTaPNZOyqnGIg+odDQBpgiOEa1lT/yyI3Ao4b/kN6ok=
Received: from MW4PR04CA0266.namprd04.prod.outlook.com (2603:10b6:303:88::31)
 by SA1PR12MB7296.namprd12.prod.outlook.com (2603:10b6:806:2ba::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 09:52:41 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::ec) by MW4PR04CA0266.outlook.office365.com
 (2603:10b6:303:88::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Thu,
 30 Jan 2025 09:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 30 Jan 2025 09:52:40 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 Jan 2025 03:52:38 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 04/10] drm/amdgpu: Enable devcoredump for JPEG5_0_1
Date: Thu, 30 Jan 2025 15:21:07 +0530
Message-ID: <20250130095113.534630-5-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
References: <20250130095113.534630-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SA1PR12MB7296:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc5ed8c-c280-457d-d6fe-08dd4113d638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnJKSDF0MFMweTNsem1ETWxYaXlpdVoxVWFJR05TLzNaMmVPMHBGdkp5R1A2?=
 =?utf-8?B?UWpzZW1uV1FqZXJWZFVUOGpnRCtINjZSZTNCRU5NREh0TTUyZkYrT2d3ZVl5?=
 =?utf-8?B?ZU1jUGMzZDU2UXl3WmpITW92MUhsSU1mYWoyOVhsOTZLK3pDUkhHZDJRcmtB?=
 =?utf-8?B?SWtCQTNhaHQwWmdLeEFCM0lDOUFKMUttdk9pVHA0ai9KbkdUUUdDdEdUQWUx?=
 =?utf-8?B?ZWtPcTN3eis2ZCtKTkVYcWhyV2RMVStHUTdENVN4L3duMjRFY3lId1dGR2dD?=
 =?utf-8?B?aGFFZTQ2RndHVHczdTBmUFNUV0lvUjZHSHVNelFTSUt4aUdBSDRLd0pSOHJm?=
 =?utf-8?B?bU1iWFFyekU3VzFYNFZqZmVoYjJBbTFvaHBwVENCMkRNYlZzRDBMRHJ6dHY1?=
 =?utf-8?B?YWE1NFJhZlVoR0ttYUk5ZjdoNDVBc0lhRlJMV0NHTmJRdS9LTUdIZjlib2gw?=
 =?utf-8?B?UTdoaENnSjdCM2VpcUpNSU1yckpWemdwVmo4OW5KTDVoYm05dEo4TkZ5UjRT?=
 =?utf-8?B?cUtiY01LUTZOSjJFbDBUc0paSzd5K1BSS2tQQzd6emdraVM4NkZjL0lJaS9u?=
 =?utf-8?B?cmExdHZ1N0wwaUs1SGEwdXRzalk5Tlo3UzBaRUJhaGZ1NHNsNnErdmxwZlBj?=
 =?utf-8?B?ZHJvZXRGM2g4QUJBbzRLb0l4ckVreVJwRjc4aFJqUDVpaHZ5eFNXRWY1cFl6?=
 =?utf-8?B?K2Y5RmR5UWczRjUvNW5xVVh5RXo1K0JkNXEvaW4wbGp1TnlDbWREazM2VEZ2?=
 =?utf-8?B?aFoyOW1wN1pQWXM1RXRZSGtlNGdzTTd2QUFtWTZCNmo4OEFLNGFFcGxBdlM4?=
 =?utf-8?B?LytIVWtGS3I5a1B2ZFhobGJjbktmUXZHRXNyS0Z0RXlVVVorZzBRaGcrTGwz?=
 =?utf-8?B?dHk3Y3NRNURIUU1kOEE2a0EwWjBwRldzK1dBNC9WMXQ2SGN3MTh6YmVKbDg3?=
 =?utf-8?B?L08yYklpUy9zaVdIeHdKMENkVzVMUUZCY1U5eDVQR2g0MEtkSW51UUpMcDlH?=
 =?utf-8?B?Sys0NDV2ejRzb1pnWkhxV1hIcEF0SS9KNVJYMFpOYXBGNTRQNkZxWXFkaXFS?=
 =?utf-8?B?b2pDbC9hNFhCOERwNEcvbTc3cUtXL0tOcERwenZkNFU2cXdVMDIrdzEyUGps?=
 =?utf-8?B?OER6NEh2UTVIMURWQmo4Umk0M2ozVjVaZXpjaHQvZm51Zmloa1pZQ0QvMXJ2?=
 =?utf-8?B?bDdNVWQ5Rm9TRlQrYko1Z0k5SzlvK1VDL3ZtM1IxY3NhUmh1UXUrZkZSYkhQ?=
 =?utf-8?B?VHlBN0pCUUREcWkxTDZyMHlIOFgrZkRDUGZhSm90Smxlc1JpaWVNRFFERFBY?=
 =?utf-8?B?aTZvVlBuelhtN1lxeVgxTUpLYVdWSTJzWEQ0bXhwWUNjc3ZOQ3o0dDdkZUJO?=
 =?utf-8?B?RzJiK2hIT3liUTAwQnFiZjdtMC8zTVllUTZnMjN4MFM5MWoxSGxTYmVQT0ox?=
 =?utf-8?B?bXF3UkRTUnJVMjFXZUZkdEsrZ1FzL0pCSUFRV0l2cnhMVGZDSlFPUVFvSTcr?=
 =?utf-8?B?TlRzMHlnTkx5QzBHTnRqRU01Q0dqMGN0WmorSWU1SzBVMENqZkN5UEZEN1lW?=
 =?utf-8?B?SzQwUG5oeFdYeGJKUVRCUVBSQzdDRHRpdHAxVEtPaG5kWWZMUUd1L2FvN0Jl?=
 =?utf-8?B?UVdoUytDTUVIOTN6WWR2dFB4YVMwNmRlQlJDSU4xTTBvSlduQzgvVGRFeTVK?=
 =?utf-8?B?Snh3SlJPMmlJYU56NVNlVnVUejRnaTUvVmlXcUZjeGhwY1J2MGREMWRBK1lq?=
 =?utf-8?B?ZE9mLzQwN3pkUE1lRmNTZWJrK25xRkZsU1hmYmtPdE9mRDRRc2MzR1pCWmJP?=
 =?utf-8?B?alk1Vmp2TUVvSCtlS0lFRHlHWFVTeE1iZG1SRTAzRFl1d2R1Ym05RC85ZzBw?=
 =?utf-8?B?TzBzZTZLWDNPcHBsSFM2cHdTbFhuOVgvYW10bENmSmM4a2tEZ3VycVJtS3ox?=
 =?utf-8?B?cmQyRHd6WVM0bGIzVGlnNXlqWXRDbnhQaWtKd1JDdXMrcC84Z21hajREZjdt?=
 =?utf-8?Q?bbCeXH7WYg2JaM5OYNB9AT/B2Ag1b4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:52:40.9149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc5ed8c-c280-457d-d6fe-08dd4113d638
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7296
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

Add register list and enable devcoredump for JPEG5_0_1

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

V3: (Lijo)
- move amdgpu_jpeg_reg_dump_fini() to sw_fini() and avoid the call here

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 49 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h | 61 ++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index 40d4c32a8c2a..6e3f522e9133 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -52,6 +52,47 @@ static int amdgpu_ih_srcid_jpeg[] = {
 	VCN_5_0__SRCID__JPEG9_DECODE,
 };
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_5_0_1[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC1_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC2_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC3_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC4_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC5_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC6_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC7_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC8_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC8_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC8_UVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC9_UVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC9_UVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC9_UVD_JRBC_STATUS),
+};
+
 static int jpeg_v5_0_1_core_reg_offset(u32 pipe)
 {
 	if (pipe <= AMDGPU_MAX_JPEG_RINGS_4_0_3)
@@ -145,6 +186,10 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_5_0_1, ARRAY_SIZE(jpeg_reg_list_5_0_1));
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -635,8 +680,8 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 	.post_soft_reset = NULL,
 	.set_clockgating_state = jpeg_v5_0_1_set_clockgating_state,
 	.set_powergating_state = jpeg_v5_0_1_set_powergating_state,
-	.dump_ip_state = NULL,
-	.print_ip_state = NULL,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v5_0_1_dec_ring_vm_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
index 8ce146c00bb6..9de3272ef47f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -26,4 +26,65 @@
 
 extern const struct amdgpu_ip_block_version jpeg_v5_0_1_ip_block;
 
+#define regUVD_JRBC0_UVD_JRBC_RB_WPTR             0x0640
+#define regUVD_JRBC0_UVD_JRBC_RB_WPTR_BASE_IDX    1
+#define regUVD_JRBC0_UVD_JRBC_STATUS              0x0649
+#define regUVD_JRBC0_UVD_JRBC_STATUS_BASE_IDX     1
+#define regUVD_JRBC0_UVD_JRBC_RB_RPTR             0x064a
+#define regUVD_JRBC0_UVD_JRBC_RB_RPTR_BASE_IDX    1
+#define regUVD_JRBC1_UVD_JRBC_RB_WPTR             0x0000
+#define regUVD_JRBC1_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC1_UVD_JRBC_STATUS              0x0009
+#define regUVD_JRBC1_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC1_UVD_JRBC_RB_RPTR             0x000a
+#define regUVD_JRBC1_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC2_UVD_JRBC_RB_WPTR             0x0040
+#define regUVD_JRBC2_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC2_UVD_JRBC_STATUS              0x0049
+#define regUVD_JRBC2_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC2_UVD_JRBC_RB_RPTR             0x004a
+#define regUVD_JRBC2_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC3_UVD_JRBC_RB_WPTR             0x0080
+#define regUVD_JRBC3_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC3_UVD_JRBC_STATUS              0x0089
+#define regUVD_JRBC3_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC3_UVD_JRBC_RB_RPTR             0x008a
+#define regUVD_JRBC3_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC4_UVD_JRBC_RB_WPTR             0x00c0
+#define regUVD_JRBC4_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC4_UVD_JRBC_STATUS              0x00c9
+#define regUVD_JRBC4_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC4_UVD_JRBC_RB_RPTR             0x00ca
+#define regUVD_JRBC4_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC5_UVD_JRBC_RB_WPTR             0x0100
+#define regUVD_JRBC5_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC5_UVD_JRBC_STATUS              0x0109
+#define regUVD_JRBC5_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC5_UVD_JRBC_RB_RPTR             0x010a
+#define regUVD_JRBC5_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC6_UVD_JRBC_RB_WPTR             0x0140
+#define regUVD_JRBC6_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC6_UVD_JRBC_STATUS              0x0149
+#define regUVD_JRBC6_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC6_UVD_JRBC_RB_RPTR             0x014a
+#define regUVD_JRBC6_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC7_UVD_JRBC_RB_WPTR             0x0180
+#define regUVD_JRBC7_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC7_UVD_JRBC_STATUS              0x0189
+#define regUVD_JRBC7_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC7_UVD_JRBC_RB_RPTR             0x018a
+#define regUVD_JRBC7_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC8_UVD_JRBC_RB_WPTR             0x01c0
+#define regUVD_JRBC8_UVD_JRBC_RB_WPTR_BASE_IDX    0
+#define regUVD_JRBC8_UVD_JRBC_STATUS              0x01c9
+#define regUVD_JRBC8_UVD_JRBC_STATUS_BASE_IDX     0
+#define regUVD_JRBC8_UVD_JRBC_RB_RPTR             0x01ca
+#define regUVD_JRBC8_UVD_JRBC_RB_RPTR_BASE_IDX    0
+#define regUVD_JRBC9_UVD_JRBC_RB_WPTR             0x0440
+#define regUVD_JRBC9_UVD_JRBC_RB_WPTR_BASE_IDX    1
+#define regUVD_JRBC9_UVD_JRBC_STATUS              0x0449
+#define regUVD_JRBC9_UVD_JRBC_STATUS_BASE_IDX     1
+#define regUVD_JRBC9_UVD_JRBC_RB_RPTR             0x044a
+#define regUVD_JRBC9_UVD_JRBC_RB_RPTR_BASE_IDX    1
+
 #endif /* __JPEG_V5_0_0_H__ */
-- 
2.25.1

