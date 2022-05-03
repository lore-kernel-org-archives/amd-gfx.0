Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B11C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E319F10EE60;
	Tue,  3 May 2022 20:29:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A206910F3A1
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPgVzA9TvIgIN+27zg4NDWCTrXge2fRwjEP39D9fPV7ZvxuPTjiHuzZfPOk08KinjE9gBUhlu5Owvr6QU0YEO9Jk1Q2e4da7/vbMHhsGmdtfZ6bu26vN5zlT/nqBO+ajAJJ2v1XW3eJabrRRpuKc5J6mqE5zTpxvM8e4iyWS+H05+DyqVlLHj2wdzcz+55UuoLQeZIIJqmmywauRg6sT8FVQgmRnhlJx+gOQyY1sstHCIIzo9/pKBSUvqDZFTGfBczAQDERjQKwC+F8MbM1s7BW0hSPFrFnjH32epGRBiFfwYFRQ3PKZ3pSXm6wAcfNuas3oEzcriHE/44JrHxXAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLapbkOjKRBrwkhMBTlS1vanrVk7td5qPWjhxPamU+g=;
 b=lDqICoKoYd6K+Z3vDsBUghA11jEOO82wH51SSKRk8iPByzeePLsln++6sl1Q8LTTgTkVbLmv5618ytUQmcgP9pgvucpyQ29XenvaD23Xlplu7uu7yRbHIvWuloY9WBjBvWWLtjO6L5+qWel4SAmR60rMeLZrEO+6yhvfdly1HFzcYFyGLlH53WpLNLjP1GgCsSF9CANeazUqzedk+nUogs2jLmsQZDIWwTUWoQx56AAysGIwEONx350o0dxDZWTiiJBZB8eKSyQ6Xk88XJVmdBXpCwCIOCFBuAWevRNZgpv8nqAlZCYJAW1H8MJlF8S0M8WCOaUF4un5U4wofAmBOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLapbkOjKRBrwkhMBTlS1vanrVk7td5qPWjhxPamU+g=;
 b=mpdsAAaN8FfuBicd9FSn3vM4T9JYYvKckqdi96TAGpv5JpJiYbuNDnBCeISxnlIRhk1fgyv0Kgw16CDYYMVVOK2s5AzM05Juvbj8Blxh/U0sqjHGiAa7dMuVPpl00aorw95pkKVymS6dOlFiAhupoPFVCArhJNXx+VhFHuMR8Rk=
Received: from DM6PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:333::9) by
 BL0PR12MB2513.namprd12.prod.outlook.com (2603:10b6:207:4a::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.17; Tue, 3 May 2022 20:29:36 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::30) by DM6PR03CA0076.outlook.office365.com
 (2603:10b6:5:333::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:29:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: update rlc ram for gc v11_0_2
Date: Tue, 3 May 2022 16:29:09 -0400
Message-ID: <20220503202912.1211009-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf74b74d-88df-4538-3a56-08da2d43a413
X-MS-TrafficTypeDiagnostic: BL0PR12MB2513:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB25135C01A0E01BB45045DED7F7C09@BL0PR12MB2513.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPQVD1gHOVa9ZVdhoWegQXRXhTrIZYts99iYLCZnf0FO50sWxLqJAdhuDunTui8jcw7ERLtJFzTfHo75Z72hgtEzcVNER3hHX/vO92YH+7IoVeB3IH9y1svVVl09jPOZAnWUeYinrc8wG/hVHr9NREJTDgPrRkgtZwW0EGd9tdQ2zlqD1G9YoV7p3c9OBsSM3oyA/2R782JNunWImSBgoTLHCruOiO/hpd/K/mNBorv3EAeFYLGj5G+KsWdbCR5cfiJ+c80tTTMelFZFEGedIvVQtjjbWuxdu/MpKsaY/v5QXz+IbR+Iq203vUqxKaAm1aCdY5rAr32787oGdcFRqoIsjvGJJT8DZM6cdaxl85GeoQJXYxVACvAuamDg3IkmM/WLBMNqeWdJ/06wuJ+RIHRxIpf6/0T+LvvamF+yPgdreY91JhCsQsr4SOOCT5AweX8QzEKyz+hzc20RowuKii0n4kYgn9mCie4VZrI4lti8mziEGkBz0sbReCPJdW4TKeAl6rEF51IUivaxF30ideNCtrsQSITY4DMpbq/1UMPsmmAdlGroTTwNXn0CI3R+Mdfbt68ufg5xjOL2X+pcxUleoErMFiSHWr2VHm4WzsMnm7U0lQEe8/Zjw8iB0musyIo7z/gmPYScs2m/9pS3gY7ZhjHuouqYsKDXryjQKeqx95PScmLpQoc5bA8HDynPrBYFgK4IvUvmaA6K/wYLpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(8936002)(6916009)(316002)(83380400001)(5660300002)(40460700003)(82310400005)(2906002)(36860700001)(36756003)(7696005)(86362001)(4326008)(1076003)(8676002)(47076005)(186003)(426003)(16526019)(336012)(2616005)(356005)(81166007)(54906003)(508600001)(70586007)(70206006)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:36.4191 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf74b74d-88df-4538-3a56-08da2d43a413
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2513
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add imu rlc ram register settings for gc v11_0_2

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c | 85 +++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index d73d271ef81f..b1964cc26aee 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -229,6 +229,75 @@ static const struct imu_rlc_ram_golden imu_rlc_ram_golden_11[] =
         IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCPG_PSP_DEBUG, CPG_PSP_DEBUG__GPA_OVERRIDE_MASK, 0)
 };
 
+static const struct imu_rlc_ram_golden imu_rlc_ram_golden_11_0_2[] =
+{
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_MISC, 0x0c48bff0, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_CREDITS, 0x003f3fbf, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_TAG_RESERVE0, 0x10200800, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_TAG_RESERVE1, 0x00000088, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_VCC_RESERVE0, 0x1d041040, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_VCC_RESERVE1, 0x80000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_IO_PRIORITY, 0x88888888, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_MAM_CTRL, 0x0000d800, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_ARB_FINAL, 0x000007ef, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_DRAM_PAGE_BURST, 0x20080200, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCEA_SDP_ENABLE, 0x00000001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_APT_CNTL, 0x0000000c, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_CACHEABLE_DRAM_ADDRESS_END, 0x000fffff, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_IO_RD_COMBINE_FLUSH, 0x00055555, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_IO_WR_COMBINE_FLUSH, 0x00055555, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_DRAM_COMBINE_FLUSH, 0x00555555, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_MISC2, 0x00001ffe, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_CREDITS, 0x003f3fff, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_TAG_RESERVE1, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCC_RESERVE0, 0x00041000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCC_RESERVE1, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCD_RESERVE0, 0x00040000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_VCD_RESERVE1, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_MISC, 0x00000017, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGUS_SDP_ENABLE, 0x00000001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SA_UNIT_DISABLE, 0x00fffc01, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_PRIM_CONFIG, 0x000fffe1, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_RB_BACKEND_DISABLE, 0x00000f01, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCC_GC_SHADER_ARRAY_CONFIG, 0xfffe0001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL1_PIPE_STEER, 0x000000e4, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCH_PIPE_STEER, 0x000000e4, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGL2_PIPE_STEER_0, 0x01231023, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGB_ADDR_CONFIG, 0x00000243, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCUTCL2_HARVEST_BYPASS_GROUPS, 0x00000002, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL, 0x00000500, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR, 0x00000001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_SYSTEM_APERTURE_HIGH_ADDR, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_START, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_LOCAL_FB_ADDRESS_END, 0x000001ff, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_FB_LOCATION_BASE, 0x00006000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_FB_LOCATION_TOP, 0x000061ff, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT0_CNTL, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT1_CNTL, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_APT_CNTL, 0x0000000c, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_TOP_OF_DRAM_SLOT1, 0xff800000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_LOWER_TOP_OF_DRAM2, 0x00000001, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_NB_UPPER_TOP_OF_DRAM2, 0x00000fff, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_BASE, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_BOT, 0x00000002, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_AGP_TOP, 0x00000000, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL, 0x00001ffc, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, 0x00002825, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCMC_VM_MX_L1_TLB_CNTL, 0x00000501, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL, 0x00080603, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL2, 0x00000003, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL3, 0x00100003, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CNTL5, 0x00003fe0, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT0_CNTL, 0x00000001, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CONTEXT0_PER_PFVF_PTE_CACHE_FRAGMENT_SIZES, 0x00000c00, 0xe0000000),
+        IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_CONTEXT1_CNTL, 0x00000001, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regGCVM_L2_CONTEXT1_PER_PFVF_PTE_CACHE_FRAGMENT_SIZES, 0x00000c00, 0xe0000000),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regSDMA0_UCODE_SELFLOAD_CONTROL, 0x00000210, 0),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regSDMA1_UCODE_SELFLOAD_CONTROL, 0x00000210, 0),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCPC_PSP_DEBUG, CPC_PSP_DEBUG__GPA_OVERRIDE_MASK, 0),
+	IMU_RLC_RAM_GOLDEN_VALUE(GC, 0, regCPG_PSP_DEBUG, CPG_PSP_DEBUG__GPA_OVERRIDE_MASK, 0)
+};
+
 void program_imu_rlc_ram(struct amdgpu_device *adev,
 				const struct imu_rlc_ram_golden *regs,
 				const u32 array_size)
@@ -268,9 +337,19 @@ static void imu_v11_0_program_rlc_ram(struct amdgpu_device *adev)
 
 	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);
 
-	program_imu_rlc_ram(adev,
-				  imu_rlc_ram_golden_11,
-				  (const u32)ARRAY_SIZE(imu_rlc_ram_golden_11));
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(11, 0, 0):
+		program_imu_rlc_ram(adev, imu_rlc_ram_golden_11,
+				(const u32)ARRAY_SIZE(imu_rlc_ram_golden_11));
+		break;
+	case IP_VERSION(11, 0, 2):
+		program_imu_rlc_ram(adev, imu_rlc_ram_golden_11_0_2,
+				(const u32)ARRAY_SIZE(imu_rlc_ram_golden_11_0_2));
+		break;
+	default:
+		BUG();
+		break;
+	}
 
 	//Indicate the contents of the RAM are valid
 	reg_data = RREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX);
-- 
2.35.1

