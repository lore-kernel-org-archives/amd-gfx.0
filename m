Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988F3C71145
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9FE310E5E2;
	Thu, 24 Aug 2023 21:58:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F3610E5DF
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WK0M2XA/FQaF0uEVeMxl4ZmPQQfFbJNh5iKaTFC0kPWQeOuQV1fUeL1EaK/7gHliJGnQKMGMl8OjXeUGj39Ll2/x9/WQDHLFQj+yjQLhw2rKS47vrAUEapsIxB4r0H49Xrp1JaEFiZcTr4iLL4usrBUvlKxVZP0WS+gUeEYYbIa25RLlO75FfNNOL/qbw2r8TCk6N4qF6/oi4ZQJLWQhAf0zCvS+9COIziJ7rfdth7SghMgFkK1zYYvmjjNNdA5tvel3Zpv1npCce93DhuK2hHvrYMO916cA3D1R5yoWExWpdZNNXf6M3KNGoeL6vfvLbgFoB8dPvNA4esxuIJW6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sd9av1+jlS3tAhTUw4WkjKJeUw0hZxpUoDOZL++tPVg=;
 b=iwMmDtoh4DP5xYQ0viLfdF60MV+eSRhuZIWJPkwUfZ8u9iwDJREjV4vsLUfTAkVhkOm1MAdJgDtuLicNSQFXO5iN0e+VUcpcju9S4FfbAP4kzLmtcovBIt/fKE3LTt0kSNKer9jCaG1CQI+j9BYuy0IH/Vc+o/EX/42Q999/E4kgBLA910SIk4riMNjqXZ0d0qTjGg2telmCaX/ZsKveHzfYk4H9ytDkrzc3vGEZ0oQgvw2vxBMavqj0tqOHMsg0Mb9M6xN+0PF3kXoxvDvmTdnUi4MHBz7EgTsP2e02e8X0QgF2gtMaFO4ja9FLFgcdEN5ZEmqxQUnmuv7x+2xotg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sd9av1+jlS3tAhTUw4WkjKJeUw0hZxpUoDOZL++tPVg=;
 b=gBMa6iYt6YRT4IY4jOQsbdR4+c0n92xruli60wEvqAaFyuYim0I+x16+0omgP4aGurhxAGA/yEmS/cJeyz4dUPETHT19kffcCpq/r0IVZB+ETVV1iAv8Gz5XOWqK1aF9S7GQgyXVcmOoCsvZnZj71GqCXlbmsWpw9stccBX5FyY=
Received: from DS0PR17CA0003.namprd17.prod.outlook.com (2603:10b6:8:191::17)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Thu, 24 Aug
 2023 21:58:50 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::7e) by DS0PR17CA0003.outlook.office365.com
 (2603:10b6:8:191::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amdgpu: add UMSCH 4.0 register headers
Date: Thu, 24 Aug 2023 17:58:22 -0400
Message-ID: <20230824215835.2740115-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ0PR12MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f511e04-a6c6-4108-2c6f-08dba4ed4c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSk9s/YOsX5kF+uSyRhrcX+wDI66H2rdmZEo/JszKYsOoQIxlIh92BIGsLQX/DXUU64Hmqdw29aWen2g8Y6RLvYtioK0ZxroAPgY46c7EvJ4d6K7Wro68GpexAocA+vAaVgYvqZbl3+qJqVDroYBOlCI1HQX1UzUDQG9bwpZa4QVjXaXfCZzfNXixPQN61N4Pco9vjjZ88aYsn+H2vShtszHqwF6jsH0Jh48CSA9B8+cesDWawsfrberGkBu2CSmC5Ynn8x8dVVMImSyl4JZdLP2Ab/oUnLCoy95s516j1rQ/nCKx3Lb8hqIiue4yWed0kyX4rRlbZCe6gF47k8kIM30FjfEVDvYhU4O69rZLsLYDIag9Vyj+EwLf5MqB0AD0nD188tcWbxZYA6tCyKjUwVnE05sO9LlYvbx/5nibaj0ttL+WDL8JTM8jAIaQR6wC8MPtQ1gg4cY1/RKFHce4+PZhYHOar12DCab2F5dQFGMfvka9UTT6k+AOx5q9XjLWnhQDx/5c57620TLGUQ4dG/6F/IG6Wi2f5VHEEyeRSeEugBjOOqwqWezPRrT+Ho6Fdxgzrqv5w6mKpNeyHl/8BAnipahebFS6dCR2Pbe1HPdMrOtwMkAkDi96G+1GjTJ2sg4enGax/6citBFT3r0CRpTl0M1cQKehRf22RL7kX+s2VQ7N4nhe1vmAN2dSBM3yLpbCJLaopjlwj0S2Vk2WTVvjKOipCyaCe7m6gmjJrkDWidkaOFkEz+uJNz8REwDJjsgc+Y0obeU6xiC1yzYyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(1800799009)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(6666004)(70586007)(8936002)(8676002)(4326008)(7696005)(70206006)(36860700001)(19627235002)(26005)(16526019)(2616005)(478600001)(316002)(1076003)(41300700001)(5660300002)(6916009)(426003)(336012)(83380400001)(40460700003)(30864003)(2906002)(47076005)(40480700001)(36756003)(356005)(81166007)(82740400003)(86362001)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:49.7055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f511e04-a6c6-4108-2c6f-08dba4ed4c5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Add headers for UMSCH 4.0.

v2: updates (Alex)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../include/asic_reg/vcn/vcn_4_0_0_offset.h   | 422 +++++++++
 .../include/asic_reg/vcn/vcn_4_0_0_sh_mask.h  | 882 ++++++++++++++++++
 2 files changed, 1304 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_0_offset.h
index 4dd44b910a30..63b79745d537 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_0_offset.h
@@ -1305,6 +1305,32 @@
 #define regVCN_RB3_DB_CTRL_BASE_IDX                                                                     1
 #define regVCN_RB4_DB_CTRL                                                                              0x0075
 #define regVCN_RB4_DB_CTRL_BASE_IDX                                                                     1
+#define regVCN_UMSCH_RB_DB_CTRL                                                                         0x0076
+#define regVCN_UMSCH_RB_DB_CTRL_BASE_IDX                                                                1
+#define regVCN_AGDB_CTRL0                                                                               0x0079
+#define regVCN_AGDB_CTRL0_BASE_IDX                                                                      1
+#define regVCN_AGDB_CTRL1                                                                               0x007a
+#define regVCN_AGDB_CTRL1_BASE_IDX                                                                      1
+#define regVCN_AGDB_CTRL2                                                                               0x007b
+#define regVCN_AGDB_CTRL2_BASE_IDX                                                                      1
+#define regVCN_AGDB_CTRL3                                                                               0x007c
+#define regVCN_AGDB_CTRL3_BASE_IDX                                                                      1
+#define regVCN_AGDB_CTRL4                                                                               0x007d
+#define regVCN_AGDB_CTRL4_BASE_IDX                                                                      1
+#define regVCN_AGDB_CTRL5                                                                               0x007e
+#define regVCN_AGDB_CTRL5_BASE_IDX                                                                      1
+#define regVCN_AGDB_MASK0                                                                               0x007f
+#define regVCN_AGDB_MASK0_BASE_IDX                                                                      1
+#define regVCN_AGDB_MASK1                                                                               0x0080
+#define regVCN_AGDB_MASK1_BASE_IDX                                                                      1
+#define regVCN_AGDB_MASK2                                                                               0x0081
+#define regVCN_AGDB_MASK2_BASE_IDX                                                                      1
+#define regVCN_AGDB_MASK3                                                                               0x0082
+#define regVCN_AGDB_MASK3_BASE_IDX                                                                      1
+#define regVCN_AGDB_MASK4                                                                               0x0083
+#define regVCN_AGDB_MASK4_BASE_IDX                                                                      1
+#define regVCN_AGDB_MASK5                                                                               0x0084
+#define regVCN_AGDB_MASK5_BASE_IDX                                                                      1
 #define regVCN_RB_ENABLE                                                                                0x0085
 #define regVCN_RB_ENABLE_BASE_IDX                                                                       1
 #define regVCN_RB_WPTR_CTRL                                                                             0x0086
@@ -1556,6 +1582,402 @@
 #define regVCN_RAS_CNTL_MMSCH                                                                           0x0914
 #define regVCN_RAS_CNTL_MMSCH_BASE_IDX                                                                  1
 
+#define regVCN_UMSCH_MES_UTCL1_CNTL                                                                     0x0759
+#define regVCN_UMSCH_MES_UTCL1_CNTL_BASE_IDX                                                            1
+#define regVCN_UMSCH_MES_BUSY                                                                           0x075a
+#define regVCN_UMSCH_MES_BUSY_BASE_IDX                                                                  1
+#define regVCN_UMSCH_RB_BASE_LO                                                                         0x075b
+#define regVCN_UMSCH_RB_BASE_LO_BASE_IDX                                                                1
+#define regVCN_UMSCH_RB_BASE_HI                                                                         0x075c
+#define regVCN_UMSCH_RB_BASE_HI_BASE_IDX                                                                1
+#define regVCN_UMSCH_RB_SIZE                                                                            0x075d
+#define regVCN_UMSCH_RB_SIZE_BASE_IDX                                                                   1
+#define regVCN_UMSCH_RB_RPTR                                                                            0x075e
+#define regVCN_UMSCH_RB_RPTR_BASE_IDX                                                                   1
+#define regVCN_UMSCH_RB_WPTR                                                                            0x075f
+#define regVCN_UMSCH_RB_WPTR_BASE_IDX                                                                   1
+#define regVCN_UMSCH_MASTINT_EN                                                                         0x0760
+#define regVCN_UMSCH_MASTINT_EN_BASE_IDX                                                                1
+#define regVCN_UMSCH_IH_CTRL                                                                            0x0761
+#define regVCN_UMSCH_IH_CTRL_BASE_IDX                                                                   1
+#define regVCN_UMSCH_SYS_INT_EN                                                                         0x0762
+#define regVCN_UMSCH_SYS_INT_EN_BASE_IDX                                                                1
+#define regVCN_UMSCH_SYS_INT_STATUS                                                                     0x0763
+#define regVCN_UMSCH_SYS_INT_STATUS_BASE_IDX                                                            1
+#define regVCN_UMSCH_SYS_INT_ACK                                                                        0x0764
+#define regVCN_UMSCH_SYS_INT_ACK_BASE_IDX                                                               1
+#define regVCN_UMSCH_SYS_INT_SRC                                                                        0x0765
+#define regVCN_UMSCH_SYS_INT_SRC_BASE_IDX                                                               1
+#define regVCN_UMSCH_IH_CTX_CTRL                                                                        0x0766
+#define regVCN_UMSCH_IH_CTX_CTRL_BASE_IDX                                                               1
+#define regVCN_UMSCH_CGC_CTRL                                                                           0x0767
+#define regVCN_UMSCH_CGC_CTRL_BASE_IDX                                                                  1
+#define regVCN_UMSCH_CGC_STATUS                                                                         0x0768
+#define regVCN_UMSCH_CGC_STATUS_BASE_IDX                                                                1
+#define regVCN_UMSCH_CGC_MEM_CTRL                                                                       0x0769
+#define regVCN_UMSCH_CGC_MEM_CTRL_BASE_IDX                                                              1
+#define regUVD_INTERNAL_REG_VIOLATION_8                                                                 0x076a
+#define regUVD_INTERNAL_REG_VIOLATION_8_BASE_IDX                                                        1
+#define regUVD_UMSCH_FORCE                                                                              0x076b
+#define regUVD_UMSCH_FORCE_BASE_IDX                                                                     1
+#define regUVD_UMSCH_DEBUG_INDEX                                                                        0x076c
+#define regUVD_UMSCH_DEBUG_INDEX_BASE_IDX                                                               1
+#define regUVD_UMSCH_DEBUG_DATA_LO                                                                      0x076d
+#define regUVD_UMSCH_DEBUG_DATA_LO_BASE_IDX                                                             1
+#define regUVD_UMSCH_DEBUG_DATA_HI                                                                      0x076e
+#define regUVD_UMSCH_DEBUG_DATA_HI_BASE_IDX                                                             1
+#define regUVD_UMSCH_DEBUG_UTCL2_TCIU_IF                                                                0x076f
+#define regUVD_UMSCH_DEBUG_UTCL2_TCIU_IF_BASE_IDX                                                       1
+#define regUMSCH_MES_RESET_CTRL                                                                         0x0770
+#define regUMSCH_MES_RESET_CTRL_BASE_IDX                                                                1
+
+#define regVCN_MES_PRGRM_CNTR_START                                                                     0x0780
+#define regVCN_MES_PRGRM_CNTR_START_BASE_IDX                                                            1
+#define regVCN_MES_INTR_ROUTINE_START                                                                   0x0781
+#define regVCN_MES_INTR_ROUTINE_START_BASE_IDX                                                          1
+#define regVCN_MES_MTVEC_LO                                                                             0x0781
+#define regVCN_MES_MTVEC_LO_BASE_IDX                                                                    1
+#define regVCN_MES_INTR_ROUTINE_START_HI                                                                0x0782
+#define regVCN_MES_INTR_ROUTINE_START_HI_BASE_IDX                                                       1
+#define regVCN_MES_MTVEC_HI                                                                             0x0782
+#define regVCN_MES_MTVEC_HI_BASE_IDX                                                                    1
+#define regVCN_MES_CNTL                                                                                 0x0787
+#define regVCN_MES_CNTL_BASE_IDX                                                                        1
+#define regVCN_MES_PIPE_PRIORITY_CNTS                                                                   0x0788
+#define regVCN_MES_PIPE_PRIORITY_CNTS_BASE_IDX                                                          1
+#define regVCN_MES_PIPE0_PRIORITY                                                                       0x0789
+#define regVCN_MES_PIPE0_PRIORITY_BASE_IDX                                                              1
+#define regVCN_MES_PIPE1_PRIORITY                                                                       0x078a
+#define regVCN_MES_PIPE1_PRIORITY_BASE_IDX                                                              1
+#define regVCN_MES_PIPE2_PRIORITY                                                                       0x078b
+#define regVCN_MES_PIPE2_PRIORITY_BASE_IDX                                                              1
+#define regVCN_MES_PIPE3_PRIORITY                                                                       0x078c
+#define regVCN_MES_PIPE3_PRIORITY_BASE_IDX                                                              1
+#define regVCN_MES_HEADER_DUMP                                                                          0x078d
+#define regVCN_MES_HEADER_DUMP_BASE_IDX                                                                 1
+#define regVCN_MES_MIE_LO                                                                               0x078e
+#define regVCN_MES_MIE_LO_BASE_IDX                                                                      1
+#define regVCN_MES_MIE_HI                                                                               0x078f
+#define regVCN_MES_MIE_HI_BASE_IDX                                                                      1
+#define regVCN_MES_INTERRUPT                                                                            0x0790
+#define regVCN_MES_INTERRUPT_BASE_IDX                                                                   1
+#define regVCN_MES_SCRATCH_INDEX                                                                        0x0791
+#define regVCN_MES_SCRATCH_INDEX_BASE_IDX                                                               1
+#define regVCN_MES_SCRATCH_DATA                                                                         0x0792
+#define regVCN_MES_SCRATCH_DATA_BASE_IDX                                                                1
+#define regVCN_MES_INSTR_PNTR                                                                           0x0793
+#define regVCN_MES_INSTR_PNTR_BASE_IDX                                                                  1
+#define regVCN_MES_MSCRATCH_HI                                                                          0x0794
+#define regVCN_MES_MSCRATCH_HI_BASE_IDX                                                                 1
+#define regVCN_MES_MSCRATCH_LO                                                                          0x0795
+#define regVCN_MES_MSCRATCH_LO_BASE_IDX                                                                 1
+#define regVCN_MES_MSTATUS_LO                                                                           0x0796
+#define regVCN_MES_MSTATUS_LO_BASE_IDX                                                                  1
+#define regVCN_MES_MSTATUS_HI                                                                           0x0797
+#define regVCN_MES_MSTATUS_HI_BASE_IDX                                                                  1
+#define regVCN_MES_MEPC_LO                                                                              0x0798
+#define regVCN_MES_MEPC_LO_BASE_IDX                                                                     1
+#define regVCN_MES_MEPC_HI                                                                              0x0799
+#define regVCN_MES_MEPC_HI_BASE_IDX                                                                     1
+#define regVCN_MES_MCAUSE_LO                                                                            0x079a
+#define regVCN_MES_MCAUSE_LO_BASE_IDX                                                                   1
+#define regVCN_MES_MCAUSE_HI                                                                            0x079b
+#define regVCN_MES_MCAUSE_HI_BASE_IDX                                                                   1
+#define regVCN_MES_MBADADDR_LO                                                                          0x079c
+#define regVCN_MES_MBADADDR_LO_BASE_IDX                                                                 1
+#define regVCN_MES_MBADADDR_HI                                                                          0x079d
+#define regVCN_MES_MBADADDR_HI_BASE_IDX                                                                 1
+#define regVCN_MES_MIP_LO                                                                               0x079e
+#define regVCN_MES_MIP_LO_BASE_IDX                                                                      1
+#define regVCN_MES_MIP_HI                                                                               0x079f
+#define regVCN_MES_MIP_HI_BASE_IDX                                                                      1
+#define regVCN_MES_IC_OP_CNTL                                                                           0x07a0
+#define regVCN_MES_IC_OP_CNTL_BASE_IDX                                                                  1
+#define regVCN_MES_MCYCLE_LO                                                                            0x07a6
+#define regVCN_MES_MCYCLE_LO_BASE_IDX                                                                   1
+#define regVCN_MES_MCYCLE_HI                                                                            0x07a7
+#define regVCN_MES_MCYCLE_HI_BASE_IDX                                                                   1
+#define regVCN_MES_MTIME_LO                                                                             0x07a8
+#define regVCN_MES_MTIME_LO_BASE_IDX                                                                    1
+#define regVCN_MES_MTIME_HI                                                                             0x07a9
+#define regVCN_MES_MTIME_HI_BASE_IDX                                                                    1
+#define regVCN_MES_MINSTRET_LO                                                                          0x07aa
+#define regVCN_MES_MINSTRET_LO_BASE_IDX                                                                 1
+#define regVCN_MES_MINSTRET_HI                                                                          0x07ab
+#define regVCN_MES_MINSTRET_HI_BASE_IDX                                                                 1
+#define regVCN_MES_MISA_LO                                                                              0x07ac
+#define regVCN_MES_MISA_LO_BASE_IDX                                                                     1
+#define regVCN_MES_MISA_HI                                                                              0x07ad
+#define regVCN_MES_MISA_HI_BASE_IDX                                                                     1
+#define regVCN_MES_MVENDORID_LO                                                                         0x07ae
+#define regVCN_MES_MVENDORID_LO_BASE_IDX                                                                1
+#define regVCN_MES_MVENDORID_HI                                                                         0x07af
+#define regVCN_MES_MVENDORID_HI_BASE_IDX                                                                1
+#define regVCN_MES_MARCHID_LO                                                                           0x07b0
+#define regVCN_MES_MARCHID_LO_BASE_IDX                                                                  1
+#define regVCN_MES_MARCHID_HI                                                                           0x07b1
+#define regVCN_MES_MARCHID_HI_BASE_IDX                                                                  1
+#define regVCN_MES_MIMPID_LO                                                                            0x07b2
+#define regVCN_MES_MIMPID_LO_BASE_IDX                                                                   1
+#define regVCN_MES_MIMPID_HI                                                                            0x07b3
+#define regVCN_MES_MIMPID_HI_BASE_IDX                                                                   1
+#define regVCN_MES_MHARTID_LO                                                                           0x07b4
+#define regVCN_MES_MHARTID_LO_BASE_IDX                                                                  1
+#define regVCN_MES_MHARTID_HI                                                                           0x07b5
+#define regVCN_MES_MHARTID_HI_BASE_IDX                                                                  1
+#define regVCN_MES_DC_BASE_CNTL                                                                         0x07b6
+#define regVCN_MES_DC_BASE_CNTL_BASE_IDX                                                                1
+#define regVCN_MES_DC_OP_CNTL                                                                           0x07b7
+#define regVCN_MES_DC_OP_CNTL_BASE_IDX                                                                  1
+#define regVCN_MES_MTIMECMP_LO                                                                          0x07b8
+#define regVCN_MES_MTIMECMP_LO_BASE_IDX                                                                 1
+#define regVCN_MES_MTIMECMP_HI                                                                          0x07b9
+#define regVCN_MES_MTIMECMP_HI_BASE_IDX                                                                 1
+#define regVCN_MES_DEBUG_INTERRUPT_INSTR_PNTR                                                           0x07c2
+#define regVCN_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                                                  1
+#define regVCN_MES_GP0_LO                                                                               0x07c3
+#define regVCN_MES_GP0_LO_BASE_IDX                                                                      1
+#define regVCN_MES_GP0_HI                                                                               0x07c4
+#define regVCN_MES_GP0_HI_BASE_IDX                                                                      1
+#define regVCN_MES_GP1_LO                                                                               0x07c5
+#define regVCN_MES_GP1_LO_BASE_IDX                                                                      1
+#define regVCN_MES_GP1_HI                                                                               0x07c6
+#define regVCN_MES_GP1_HI_BASE_IDX                                                                      1
+#define regVCN_MES_GP2_LO                                                                               0x07c7
+#define regVCN_MES_GP2_LO_BASE_IDX                                                                      1
+#define regVCN_MES_GP2_HI                                                                               0x07c8
+#define regVCN_MES_GP2_HI_BASE_IDX                                                                      1
+#define regVCN_MES_GP3_LO                                                                               0x07c9
+#define regVCN_MES_GP3_LO_BASE_IDX                                                                      1
+#define regVCN_MES_GP3_HI                                                                               0x07ca
+#define regVCN_MES_GP3_HI_BASE_IDX                                                                      1
+#define regVCN_MES_GP4_LO                                                                               0x07cb
+#define regVCN_MES_GP4_LO_BASE_IDX                                                                      1
+#define regVCN_MES_GP4_HI                                                                               0x07cc
+#define regVCN_MES_GP4_HI_BASE_IDX                                                                      1
+#define regVCN_MES_GP5_LO                                                                               0x07cd
+#define regVCN_MES_GP5_LO_BASE_IDX                                                                      1
+#define regVCN_MES_GP5_HI                                                                               0x07ce
+#define regVCN_MES_GP5_HI_BASE_IDX                                                                      1
+#define regVCN_MES_GP6_LO                                                                               0x07cf
+#define regVCN_MES_GP6_LO_BASE_IDX                                                                      1
+#define regVCN_MES_GP6_HI                                                                               0x07d0
+#define regVCN_MES_GP6_HI_BASE_IDX                                                                      1
+#define regVCN_MES_GP7_LO                                                                               0x07d1
+#define regVCN_MES_GP7_LO_BASE_IDX                                                                      1
+#define regVCN_MES_GP7_HI                                                                               0x07d2
+#define regVCN_MES_GP7_HI_BASE_IDX                                                                      1
+#define regVCN_MES_GP8_LO                                                                               0x07d3
+#define regVCN_MES_GP8_LO_BASE_IDX                                                                      1
+#define regVCN_MES_GP8_HI                                                                               0x07d4
+#define regVCN_MES_GP8_HI_BASE_IDX                                                                      1
+#define regVCN_MES_GP9_LO                                                                               0x07d5
+#define regVCN_MES_GP9_LO_BASE_IDX                                                                      1
+#define regVCN_MES_GP9_HI                                                                               0x07d6
+#define regVCN_MES_GP9_HI_BASE_IDX                                                                      1
+#define regVCN_MES_DM_INDEX_ADDR                                                                        0x0800
+#define regVCN_MES_DM_INDEX_ADDR_BASE_IDX                                                               1
+#define regVCN_MES_DM_INDEX_DATA                                                                        0x0801
+#define regVCN_MES_DM_INDEX_DATA_BASE_IDX                                                               1
+#define regVCN_MES_DBG_FROM_RST                                                                         0x0802
+#define regVCN_MES_DBG_FROM_RST_BASE_IDX                                                                1
+#define regVCN_MES_LOCAL_BASE0_LO                                                                       0x0803
+#define regVCN_MES_LOCAL_BASE0_LO_BASE_IDX                                                              1
+#define regVCN_MES_LOCAL_BASE0_HI                                                                       0x0804
+#define regVCN_MES_LOCAL_BASE0_HI_BASE_IDX                                                              1
+#define regVCN_MES_LOCAL_MASK0_LO                                                                       0x0805
+#define regVCN_MES_LOCAL_MASK0_LO_BASE_IDX                                                              1
+#define regVCN_MES_LOCAL_MASK0_HI                                                                       0x0806
+#define regVCN_MES_LOCAL_MASK0_HI_BASE_IDX                                                              1
+#define regVCN_MES_LOCAL_APERTURE                                                                       0x0807
+#define regVCN_MES_LOCAL_APERTURE_BASE_IDX                                                              1
+#define regVCN_MES_LOCAL_INSTR_BASE_LO                                                                  0x0808
+#define regVCN_MES_LOCAL_INSTR_BASE_LO_BASE_IDX                                                         1
+#define regVCN_MES_LOCAL_INSTR_BASE_HI                                                                  0x0809
+#define regVCN_MES_LOCAL_INSTR_BASE_HI_BASE_IDX                                                         1
+#define regVCN_MES_LOCAL_INSTR_MASK_LO                                                                  0x080a
+#define regVCN_MES_LOCAL_INSTR_MASK_LO_BASE_IDX                                                         1
+#define regVCN_MES_LOCAL_INSTR_MASK_HI                                                                  0x080b
+#define regVCN_MES_LOCAL_INSTR_MASK_HI_BASE_IDX                                                         1
+#define regVCN_MES_LOCAL_INSTR_APERTURE                                                                 0x080c
+#define regVCN_MES_LOCAL_INSTR_APERTURE_BASE_IDX                                                        1
+#define regVCN_MES_LOCAL_SCRATCH_APERTURE                                                               0x080d
+#define regVCN_MES_LOCAL_SCRATCH_APERTURE_BASE_IDX                                                      1
+#define regVCN_MES_LOCAL_SCRATCH_BASE_LO                                                                0x080e
+#define regVCN_MES_LOCAL_SCRATCH_BASE_LO_BASE_IDX                                                       1
+#define regVCN_MES_LOCAL_SCRATCH_BASE_HI                                                                0x080f
+#define regVCN_MES_LOCAL_SCRATCH_BASE_HI_BASE_IDX                                                       1
+#define regVCN_MES_PERFCOUNT_CNTL                                                                       0x0819
+#define regVCN_MES_PERFCOUNT_CNTL_BASE_IDX                                                              1
+#define regVCN_MES_PENDING_INTERRUPT                                                                    0x081a
+#define regVCN_MES_PENDING_INTERRUPT_BASE_IDX                                                           1
+#define regVCN_MES_PRIV_LEVEL                                                                           0x081b
+#define regVCN_MES_PRIV_LEVEL_BASE_IDX                                                                  1
+#define regVCN_MES_PRIV_LEVEL_VIOLATION_STATUS                                                          0x081c
+#define regVCN_MES_PRIV_LEVEL_VIOLATION_STATUS_BASE_IDX                                                 1
+#define regVCN_MES_PRGRM_CNTR_START_HI                                                                  0x081d
+#define regVCN_MES_PRGRM_CNTR_START_HI_BASE_IDX                                                         1
+#define regVCN_MES_DEBUG_INTERRUPT_INSTR_PNTR_HI                                                        0x081e
+#define regVCN_MES_DEBUG_INTERRUPT_INSTR_PNTR_HI_BASE_IDX                                               1
+#define regVCN_MES_INTERRUPT_DATA_16                                                                    0x081f
+#define regVCN_MES_INTERRUPT_DATA_16_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_17                                                                    0x0820
+#define regVCN_MES_INTERRUPT_DATA_17_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_18                                                                    0x0821
+#define regVCN_MES_INTERRUPT_DATA_18_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_19                                                                    0x0822
+#define regVCN_MES_INTERRUPT_DATA_19_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_20                                                                    0x0823
+#define regVCN_MES_INTERRUPT_DATA_20_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_21                                                                    0x0824
+#define regVCN_MES_INTERRUPT_DATA_21_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_22                                                                    0x0825
+#define regVCN_MES_INTERRUPT_DATA_22_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_23                                                                    0x0826
+#define regVCN_MES_INTERRUPT_DATA_23_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_24                                                                    0x0827
+#define regVCN_MES_INTERRUPT_DATA_24_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_25                                                                    0x0828
+#define regVCN_MES_INTERRUPT_DATA_25_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_26                                                                    0x0829
+#define regVCN_MES_INTERRUPT_DATA_26_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_27                                                                    0x082a
+#define regVCN_MES_INTERRUPT_DATA_27_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_28                                                                    0x082b
+#define regVCN_MES_INTERRUPT_DATA_28_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_29                                                                    0x082c
+#define regVCN_MES_INTERRUPT_DATA_29_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_30                                                                    0x082d
+#define regVCN_MES_INTERRUPT_DATA_30_BASE_IDX                                                           1
+#define regVCN_MES_INTERRUPT_DATA_31                                                                    0x082e
+#define regVCN_MES_INTERRUPT_DATA_31_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE0_BASE                                                                    0x082f
+#define regVCN_MES_DC_APERTURE0_BASE_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE0_MASK                                                                    0x0830
+#define regVCN_MES_DC_APERTURE0_MASK_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE0_CNTL                                                                    0x0831
+#define regVCN_MES_DC_APERTURE0_CNTL_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE1_BASE                                                                    0x0832
+#define regVCN_MES_DC_APERTURE1_BASE_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE1_MASK                                                                    0x0833
+#define regVCN_MES_DC_APERTURE1_MASK_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE1_CNTL                                                                    0x0834
+#define regVCN_MES_DC_APERTURE1_CNTL_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE2_BASE                                                                    0x0835
+#define regVCN_MES_DC_APERTURE2_BASE_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE2_MASK                                                                    0x0836
+#define regVCN_MES_DC_APERTURE2_MASK_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE2_CNTL                                                                    0x0837
+#define regVCN_MES_DC_APERTURE2_CNTL_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE3_BASE                                                                    0x0838
+#define regVCN_MES_DC_APERTURE3_BASE_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE3_MASK                                                                    0x0839
+#define regVCN_MES_DC_APERTURE3_MASK_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE3_CNTL                                                                    0x083a
+#define regVCN_MES_DC_APERTURE3_CNTL_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE4_BASE                                                                    0x083b
+#define regVCN_MES_DC_APERTURE4_BASE_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE4_MASK                                                                    0x083c
+#define regVCN_MES_DC_APERTURE4_MASK_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE4_CNTL                                                                    0x083d
+#define regVCN_MES_DC_APERTURE4_CNTL_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE5_BASE                                                                    0x083e
+#define regVCN_MES_DC_APERTURE5_BASE_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE5_MASK                                                                    0x083f
+#define regVCN_MES_DC_APERTURE5_MASK_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE5_CNTL                                                                    0x0840
+#define regVCN_MES_DC_APERTURE5_CNTL_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE6_BASE                                                                    0x0841
+#define regVCN_MES_DC_APERTURE6_BASE_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE6_MASK                                                                    0x0842
+#define regVCN_MES_DC_APERTURE6_MASK_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE6_CNTL                                                                    0x0843
+#define regVCN_MES_DC_APERTURE6_CNTL_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE7_BASE                                                                    0x0844
+#define regVCN_MES_DC_APERTURE7_BASE_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE7_MASK                                                                    0x0845
+#define regVCN_MES_DC_APERTURE7_MASK_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE7_CNTL                                                                    0x0846
+#define regVCN_MES_DC_APERTURE7_CNTL_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE8_BASE                                                                    0x0847
+#define regVCN_MES_DC_APERTURE8_BASE_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE8_MASK                                                                    0x0848
+#define regVCN_MES_DC_APERTURE8_MASK_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE8_CNTL                                                                    0x0849
+#define regVCN_MES_DC_APERTURE8_CNTL_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE9_BASE                                                                    0x084a
+#define regVCN_MES_DC_APERTURE9_BASE_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE9_MASK                                                                    0x084b
+#define regVCN_MES_DC_APERTURE9_MASK_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE9_CNTL                                                                    0x084c
+#define regVCN_MES_DC_APERTURE9_CNTL_BASE_IDX                                                           1
+#define regVCN_MES_DC_APERTURE10_BASE                                                                   0x084d
+#define regVCN_MES_DC_APERTURE10_BASE_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE10_MASK                                                                   0x084e
+#define regVCN_MES_DC_APERTURE10_MASK_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE10_CNTL                                                                   0x084f
+#define regVCN_MES_DC_APERTURE10_CNTL_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE11_BASE                                                                   0x0850
+#define regVCN_MES_DC_APERTURE11_BASE_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE11_MASK                                                                   0x0851
+#define regVCN_MES_DC_APERTURE11_MASK_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE11_CNTL                                                                   0x0852
+#define regVCN_MES_DC_APERTURE11_CNTL_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE12_BASE                                                                   0x0853
+#define regVCN_MES_DC_APERTURE12_BASE_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE12_MASK                                                                   0x0854
+#define regVCN_MES_DC_APERTURE12_MASK_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE12_CNTL                                                                   0x0855
+#define regVCN_MES_DC_APERTURE12_CNTL_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE13_BASE                                                                   0x0856
+#define regVCN_MES_DC_APERTURE13_BASE_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE13_MASK                                                                   0x0857
+#define regVCN_MES_DC_APERTURE13_MASK_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE13_CNTL                                                                   0x0858
+#define regVCN_MES_DC_APERTURE13_CNTL_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE14_BASE                                                                   0x0859
+#define regVCN_MES_DC_APERTURE14_BASE_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE14_MASK                                                                   0x085a
+#define regVCN_MES_DC_APERTURE14_MASK_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE14_CNTL                                                                   0x085b
+#define regVCN_MES_DC_APERTURE14_CNTL_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE15_BASE                                                                   0x085c
+#define regVCN_MES_DC_APERTURE15_BASE_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE15_MASK                                                                   0x085d
+#define regVCN_MES_DC_APERTURE15_MASK_BASE_IDX                                                          1
+#define regVCN_MES_DC_APERTURE15_CNTL                                                                   0x085e
+#define regVCN_MES_DC_APERTURE15_CNTL_BASE_IDX                                                          1
+
+#define regVCN_HYP_ME1_PIPE0_VMID_CNTL                                                                  0x0890
+#define regVCN_HYP_ME1_PIPE0_VMID_CNTL_BASE_IDX                                                         1
+#define regVCN_HYP_ME1_PIPE1_VMID_CNTL                                                                  0x0891
+#define regVCN_HYP_ME1_PIPE1_VMID_CNTL_BASE_IDX                                                         1
+#define regVCN_MES_IC_BASE_LO                                                                           0x08d0
+#define regVCN_MES_IC_BASE_LO_BASE_IDX                                                                  1
+#define regVCN_MES_MIBASE_LO                                                                            0x08d0
+#define regVCN_MES_MIBASE_LO_BASE_IDX                                                                   1
+#define regVCN_MES_IC_BASE_HI                                                                           0x08d1
+#define regVCN_MES_IC_BASE_HI_BASE_IDX                                                                  1
+#define regVCN_MES_MIBASE_HI                                                                            0x08d1
+#define regVCN_MES_MIBASE_HI_BASE_IDX                                                                   1
+#define regVCN_MES_IC_BASE_CNTL                                                                         0x08d2
+#define regVCN_MES_IC_BASE_CNTL_BASE_IDX                                                                1
+#define regVCN_MES_DC_BASE_LO                                                                           0x08d4
+#define regVCN_MES_DC_BASE_LO_BASE_IDX                                                                  1
+#define regVCN_MES_MDBASE_LO                                                                            0x08d4
+#define regVCN_MES_MDBASE_LO_BASE_IDX                                                                   1
+#define regVCN_MES_DC_BASE_HI                                                                           0x08d5
+#define regVCN_MES_DC_BASE_HI_BASE_IDX                                                                  1
+#define regVCN_MES_MDBASE_HI                                                                            0x08d5
+#define regVCN_MES_MDBASE_HI_BASE_IDX                                                                   1
+#define regVCN_MES_MIBOUND_LO                                                                           0x08db
+#define regVCN_MES_MIBOUND_LO_BASE_IDX                                                                  1
+#define regVCN_MES_MIBOUND_HI                                                                           0x08dc
+#define regVCN_MES_MIBOUND_HI_BASE_IDX                                                                  1
+#define regVCN_MES_MDBOUND_LO                                                                           0x08dd
+#define regVCN_MES_MDBOUND_LO_BASE_IDX                                                                  1
+#define regVCN_MES_MDBOUND_HI                                                                           0x08de
+#define regVCN_MES_MDBOUND_HI_BASE_IDX                                                                  1
 
 // addressBlock: uvdctxind
 // base address: 0x0
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_0_sh_mask.h
index c33d07b690b6..251090d126d1 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_4_0_0_sh_mask.h
@@ -6769,6 +6769,73 @@
 #define VCN_RB4_DB_CTRL__OFFSET_MASK                                                                          0x0FFFFFFCL
 #define VCN_RB4_DB_CTRL__EN_MASK                                                                              0x40000000L
 #define VCN_RB4_DB_CTRL__HIT_MASK                                                                             0x80000000L
+//VCN_UMSCH_RB_DB_CTRL
+#define VCN_UMSCH_RB_DB_CTRL__OFFSET__SHIFT                                                                   0x2
+#define VCN_UMSCH_RB_DB_CTRL__EN__SHIFT                                                                       0x1e
+#define VCN_UMSCH_RB_DB_CTRL__HIT__SHIFT                                                                      0x1f
+#define VCN_UMSCH_RB_DB_CTRL__OFFSET_MASK                                                                     0x0FFFFFFCL
+#define VCN_UMSCH_RB_DB_CTRL__EN_MASK                                                                         0x40000000L
+#define VCN_UMSCH_RB_DB_CTRL__HIT_MASK                                                                        0x80000000L
+//VCN_AGDB_CTRL0
+#define VCN_AGDB_CTRL0__OFFSET__SHIFT                                                                         0x2
+#define VCN_AGDB_CTRL0__EN__SHIFT                                                                             0x1e
+#define VCN_AGDB_CTRL0__HIT__SHIFT                                                                            0x1f
+#define VCN_AGDB_CTRL0__OFFSET_MASK                                                                           0x0FFFFFFCL
+#define VCN_AGDB_CTRL0__EN_MASK                                                                               0x40000000L
+#define VCN_AGDB_CTRL0__HIT_MASK                                                                              0x80000000L
+//VCN_AGDB_CTRL1
+#define VCN_AGDB_CTRL1__OFFSET__SHIFT                                                                         0x2
+#define VCN_AGDB_CTRL1__EN__SHIFT                                                                             0x1e
+#define VCN_AGDB_CTRL1__HIT__SHIFT                                                                            0x1f
+#define VCN_AGDB_CTRL1__OFFSET_MASK                                                                           0x0FFFFFFCL
+#define VCN_AGDB_CTRL1__EN_MASK                                                                               0x40000000L
+#define VCN_AGDB_CTRL1__HIT_MASK                                                                              0x80000000L
+//VCN_AGDB_CTRL2
+#define VCN_AGDB_CTRL2__OFFSET__SHIFT                                                                         0x2
+#define VCN_AGDB_CTRL2__EN__SHIFT                                                                             0x1e
+#define VCN_AGDB_CTRL2__HIT__SHIFT                                                                            0x1f
+#define VCN_AGDB_CTRL2__OFFSET_MASK                                                                           0x0FFFFFFCL
+#define VCN_AGDB_CTRL2__EN_MASK                                                                               0x40000000L
+#define VCN_AGDB_CTRL2__HIT_MASK                                                                              0x80000000L
+//VCN_AGDB_CTRL3
+#define VCN_AGDB_CTRL3__OFFSET__SHIFT                                                                         0x2
+#define VCN_AGDB_CTRL3__EN__SHIFT                                                                             0x1e
+#define VCN_AGDB_CTRL3__HIT__SHIFT                                                                            0x1f
+#define VCN_AGDB_CTRL3__OFFSET_MASK                                                                           0x0FFFFFFCL
+#define VCN_AGDB_CTRL3__EN_MASK                                                                               0x40000000L
+#define VCN_AGDB_CTRL3__HIT_MASK                                                                              0x80000000L
+//VCN_AGDB_CTRL4
+#define VCN_AGDB_CTRL4__OFFSET__SHIFT                                                                         0x2
+#define VCN_AGDB_CTRL4__EN__SHIFT                                                                             0x1e
+#define VCN_AGDB_CTRL4__HIT__SHIFT                                                                            0x1f
+#define VCN_AGDB_CTRL4__OFFSET_MASK                                                                           0x0FFFFFFCL
+#define VCN_AGDB_CTRL4__EN_MASK                                                                               0x40000000L
+#define VCN_AGDB_CTRL4__HIT_MASK                                                                              0x80000000L
+//VCN_AGDB_CTRL5
+#define VCN_AGDB_CTRL5__OFFSET__SHIFT                                                                         0x2
+#define VCN_AGDB_CTRL5__EN__SHIFT                                                                             0x1e
+#define VCN_AGDB_CTRL5__HIT__SHIFT                                                                            0x1f
+#define VCN_AGDB_CTRL5__OFFSET_MASK                                                                           0x0FFFFFFCL
+#define VCN_AGDB_CTRL5__EN_MASK                                                                               0x40000000L
+#define VCN_AGDB_CTRL5__HIT_MASK                                                                              0x80000000L
+//VCN_AGDB_MASK0
+#define VCN_AGDB_MASK0__MASK__SHIFT                                                                           0x2
+#define VCN_AGDB_MASK0__MASK_MASK                                                                             0x0FFFFFFCL
+//VCN_AGDB_MASK1
+#define VCN_AGDB_MASK1__MASK__SHIFT                                                                           0x2
+#define VCN_AGDB_MASK1__MASK_MASK                                                                             0x0FFFFFFCL
+//VCN_AGDB_MASK2
+#define VCN_AGDB_MASK2__MASK__SHIFT                                                                           0x2
+#define VCN_AGDB_MASK2__MASK_MASK                                                                             0x0FFFFFFCL
+//VCN_AGDB_MASK3
+#define VCN_AGDB_MASK3__MASK__SHIFT                                                                           0x2
+#define VCN_AGDB_MASK3__MASK_MASK                                                                             0x0FFFFFFCL
+//VCN_AGDB_MASK4
+#define VCN_AGDB_MASK4__MASK__SHIFT                                                                           0x2
+#define VCN_AGDB_MASK4__MASK_MASK                                                                             0x0FFFFFFCL
+//VCN_AGDB_MASK5
+#define VCN_AGDB_MASK5__MASK__SHIFT                                                                           0x2
+#define VCN_AGDB_MASK5__MASK_MASK                                                                             0x0FFFFFFCL
 //VCN_RB_ENABLE
 #define VCN_RB_ENABLE__RB_EN__SHIFT                                                                           0x0
 #define VCN_RB_ENABLE__JPEG_RB_EN__SHIFT                                                                      0x1
@@ -8051,5 +8118,820 @@
 #define UVD_MEMCHECK2_VCPU_INT_ACK__PREF_LO_ACK_MASK                                                          0x04000000L
 #define UVD_MEMCHECK2_VCPU_INT_ACK__PREF_HI_ACK_MASK                                                          0x08000000L
 
+//VCN_UMSCH_MES_UTCL1_CNTL
+#define VCN_UMSCH_MES_UTCL1_CNTL__REDO_LATENCY__SHIFT                                                         0x0
+#define VCN_UMSCH_MES_UTCL1_CNTL__ForceSnoop__SHIFT                                                           0x14
+#define VCN_UMSCH_MES_UTCL1_CNTL__FragLimitMode__SHIFT                                                        0x15
+#define VCN_UMSCH_MES_UTCL1_CNTL__DropMode__SHIFT                                                             0x16
+#define VCN_UMSCH_MES_UTCL1_CNTL__Invalidate__SHIFT                                                           0x17
+#define VCN_UMSCH_MES_UTCL1_CNTL__REDO_LATENCY_MASK                                                           0x000FFFFFL
+#define VCN_UMSCH_MES_UTCL1_CNTL__ForceSnoop_MASK                                                             0x00100000L
+#define VCN_UMSCH_MES_UTCL1_CNTL__FragLimitMode_MASK                                                          0x00200000L
+#define VCN_UMSCH_MES_UTCL1_CNTL__DropMode_MASK                                                               0x00400000L
+#define VCN_UMSCH_MES_UTCL1_CNTL__Invalidate_MASK                                                             0x00800000L
+//VCN_UMSCH_MES_BUSY
+#define VCN_UMSCH_MES_BUSY__MesScratchRamBusy__SHIFT                                                          0x0
+#define VCN_UMSCH_MES_BUSY__MesInstrCacheBusy__SHIFT                                                          0x1
+#define VCN_UMSCH_MES_BUSY__MesDataCacheBusy__SHIFT                                                           0x2
+#define VCN_UMSCH_MES_BUSY__MesBusy__SHIFT                                                                    0x3
+#define VCN_UMSCH_MES_BUSY__MesLoadBusy__SHIFT                                                                0x4
+#define VCN_UMSCH_MES_BUSY__MesMutexBusy__SHIFT                                                               0x5
+#define VCN_UMSCH_MES_BUSY__MesThreadBusy__SHIFT                                                              0x6
+#define VCN_UMSCH_MES_BUSY__MesMessageBusy__SHIFT                                                             0x8
+#define VCN_UMSCH_MES_BUSY__MesTcBusy__SHIFT                                                                  0xa
+#define VCN_UMSCH_MES_BUSY__MesDmaPending__SHIFT                                                              0xc
+#define VCN_UMSCH_MES_BUSY__MesScratchRamBusy_MASK                                                            0x00000001L
+#define VCN_UMSCH_MES_BUSY__MesInstrCacheBusy_MASK                                                            0x00000002L
+#define VCN_UMSCH_MES_BUSY__MesDataCacheBusy_MASK                                                             0x00000004L
+#define VCN_UMSCH_MES_BUSY__MesBusy_MASK                                                                      0x00000008L
+#define VCN_UMSCH_MES_BUSY__MesLoadBusy_MASK                                                                  0x00000010L
+#define VCN_UMSCH_MES_BUSY__MesMutexBusy_MASK                                                                 0x00000020L
+#define VCN_UMSCH_MES_BUSY__MesThreadBusy_MASK                                                                0x000000C0L
+#define VCN_UMSCH_MES_BUSY__MesMessageBusy_MASK                                                               0x00000300L
+#define VCN_UMSCH_MES_BUSY__MesTcBusy_MASK                                                                    0x00000C00L
+#define VCN_UMSCH_MES_BUSY__MesDmaPending_MASK                                                                0x00003000L
+//VCN_UMSCH_RB_BASE_LO
+#define VCN_UMSCH_RB_BASE_LO__RB_BASE_LO__SHIFT                                                               0x6
+#define VCN_UMSCH_RB_BASE_LO__RB_BASE_LO_MASK                                                                 0xFFFFFFC0L
+//VCN_UMSCH_RB_BASE_HI
+#define VCN_UMSCH_RB_BASE_HI__RB_BASE_HI__SHIFT                                                               0x0
+#define VCN_UMSCH_RB_BASE_HI__RB_BASE_HI_MASK                                                                 0xFFFFFFFFL
+//VCN_UMSCH_RB_SIZE
+#define VCN_UMSCH_RB_SIZE__WPTR__SHIFT                                                                        0x4
+#define VCN_UMSCH_RB_SIZE__WPTR_MASK                                                                          0x007FFFF0L
+//VCN_UMSCH_RB_RPTR
+#define VCN_UMSCH_RB_RPTR__WPTR__SHIFT                                                                        0x4
+#define VCN_UMSCH_RB_RPTR__WPTR_MASK                                                                          0x007FFFF0L
+//VCN_UMSCH_RB_WPTR
+#define VCN_UMSCH_RB_WPTR__WPTR__SHIFT                                                                        0x4
+#define VCN_UMSCH_RB_WPTR__WPTR_MASK                                                                          0x007FFFF0L
+//VCN_UMSCH_MASTINT_EN
+#define VCN_UMSCH_MASTINT_EN__OVERRUN_RST__SHIFT                                                              0x0
+#define VCN_UMSCH_MASTINT_EN__SYS_EN__SHIFT                                                                   0x2
+#define VCN_UMSCH_MASTINT_EN__INT_OVERRUN__SHIFT                                                              0x4
+#define VCN_UMSCH_MASTINT_EN__OVERRUN_RST_MASK                                                                0x00000001L
+#define VCN_UMSCH_MASTINT_EN__SYS_EN_MASK                                                                     0x00000004L
+#define VCN_UMSCH_MASTINT_EN__INT_OVERRUN_MASK                                                                0x007FFFF0L
+//VCN_UMSCH_IH_CTRL
+#define VCN_UMSCH_IH_CTRL__IH_SOFT_RESET__SHIFT                                                               0x0
+#define VCN_UMSCH_IH_CTRL__IH_STALL_EN__SHIFT                                                                 0x1
+#define VCN_UMSCH_IH_CTRL__IH_STATUS_CLEAN__SHIFT                                                             0x2
+#define VCN_UMSCH_IH_CTRL__IH_VMID__SHIFT                                                                     0x3
+#define VCN_UMSCH_IH_CTRL__IH_USER_DATA__SHIFT                                                                0x7
+#define VCN_UMSCH_IH_CTRL__IH_RINGID__SHIFT                                                                   0x13
+#define VCN_UMSCH_IH_CTRL__IH_SOFT_RESET_MASK                                                                 0x00000001L
+#define VCN_UMSCH_IH_CTRL__IH_STALL_EN_MASK                                                                   0x00000002L
+#define VCN_UMSCH_IH_CTRL__IH_STATUS_CLEAN_MASK                                                               0x00000004L
+#define VCN_UMSCH_IH_CTRL__IH_VMID_MASK                                                                       0x00000078L
+#define VCN_UMSCH_IH_CTRL__IH_USER_DATA_MASK                                                                  0x0007FF80L
+#define VCN_UMSCH_IH_CTRL__IH_RINGID_MASK                                                                     0x07F80000L
+//VCN_UMSCH_SYS_INT_EN
+#define VCN_UMSCH_SYS_INT_EN__INT0__SHIFT                                                                     0x0
+#define VCN_UMSCH_SYS_INT_EN__INT1__SHIFT                                                                     0x1
+#define VCN_UMSCH_SYS_INT_EN__INT2__SHIFT                                                                     0x2
+#define VCN_UMSCH_SYS_INT_EN__INT3__SHIFT                                                                     0x3
+#define VCN_UMSCH_SYS_INT_EN__INT4__SHIFT                                                                     0x4
+#define VCN_UMSCH_SYS_INT_EN__INT5__SHIFT                                                                     0x5
+#define VCN_UMSCH_SYS_INT_EN__INT6__SHIFT                                                                     0x6
+#define VCN_UMSCH_SYS_INT_EN__INT7__SHIFT                                                                     0x7
+#define VCN_UMSCH_SYS_INT_EN__INT0_MASK                                                                       0x00000001L
+#define VCN_UMSCH_SYS_INT_EN__INT1_MASK                                                                       0x00000002L
+#define VCN_UMSCH_SYS_INT_EN__INT2_MASK                                                                       0x00000004L
+#define VCN_UMSCH_SYS_INT_EN__INT3_MASK                                                                       0x00000008L
+#define VCN_UMSCH_SYS_INT_EN__INT4_MASK                                                                       0x00000010L
+#define VCN_UMSCH_SYS_INT_EN__INT5_MASK                                                                       0x00000020L
+#define VCN_UMSCH_SYS_INT_EN__INT6_MASK                                                                       0x00000040L
+#define VCN_UMSCH_SYS_INT_EN__INT7_MASK                                                                       0x00000080L
+//VCN_UMSCH_SYS_INT_STATUS
+#define VCN_UMSCH_SYS_INT_STATUS__INT0__SHIFT                                                                 0x0
+#define VCN_UMSCH_SYS_INT_STATUS__INT1__SHIFT                                                                 0x1
+#define VCN_UMSCH_SYS_INT_STATUS__INT2__SHIFT                                                                 0x2
+#define VCN_UMSCH_SYS_INT_STATUS__INT3__SHIFT                                                                 0x3
+#define VCN_UMSCH_SYS_INT_STATUS__INT4__SHIFT                                                                 0x4
+#define VCN_UMSCH_SYS_INT_STATUS__INT5__SHIFT                                                                 0x5
+#define VCN_UMSCH_SYS_INT_STATUS__INT6__SHIFT                                                                 0x6
+#define VCN_UMSCH_SYS_INT_STATUS__INT7__SHIFT                                                                 0x7
+#define VCN_UMSCH_SYS_INT_STATUS__INT0_MASK                                                                   0x00000001L
+#define VCN_UMSCH_SYS_INT_STATUS__INT1_MASK                                                                   0x00000002L
+#define VCN_UMSCH_SYS_INT_STATUS__INT2_MASK                                                                   0x00000004L
+#define VCN_UMSCH_SYS_INT_STATUS__INT3_MASK                                                                   0x00000008L
+#define VCN_UMSCH_SYS_INT_STATUS__INT4_MASK                                                                   0x00000010L
+#define VCN_UMSCH_SYS_INT_STATUS__INT5_MASK                                                                   0x00000020L
+#define VCN_UMSCH_SYS_INT_STATUS__INT6_MASK                                                                   0x00000040L
+#define VCN_UMSCH_SYS_INT_STATUS__INT7_MASK                                                                   0x00000080L
+//VCN_UMSCH_SYS_INT_ACK
+#define VCN_UMSCH_SYS_INT_ACK__INT0__SHIFT                                                                    0x0
+#define VCN_UMSCH_SYS_INT_ACK__INT1__SHIFT                                                                    0x1
+#define VCN_UMSCH_SYS_INT_ACK__INT2__SHIFT                                                                    0x2
+#define VCN_UMSCH_SYS_INT_ACK__INT3__SHIFT                                                                    0x3
+#define VCN_UMSCH_SYS_INT_ACK__INT4__SHIFT                                                                    0x4
+#define VCN_UMSCH_SYS_INT_ACK__INT5__SHIFT                                                                    0x5
+#define VCN_UMSCH_SYS_INT_ACK__INT6__SHIFT                                                                    0x6
+#define VCN_UMSCH_SYS_INT_ACK__INT7__SHIFT                                                                    0x7
+#define VCN_UMSCH_SYS_INT_ACK__INT0_MASK                                                                      0x00000001L
+#define VCN_UMSCH_SYS_INT_ACK__INT1_MASK                                                                      0x00000002L
+#define VCN_UMSCH_SYS_INT_ACK__INT2_MASK                                                                      0x00000004L
+#define VCN_UMSCH_SYS_INT_ACK__INT3_MASK                                                                      0x00000008L
+#define VCN_UMSCH_SYS_INT_ACK__INT4_MASK                                                                      0x00000010L
+#define VCN_UMSCH_SYS_INT_ACK__INT5_MASK                                                                      0x00000020L
+#define VCN_UMSCH_SYS_INT_ACK__INT6_MASK                                                                      0x00000040L
+#define VCN_UMSCH_SYS_INT_ACK__INT7_MASK                                                                      0x00000080L
+//VCN_UMSCH_SYS_INT_SRC
+#define VCN_UMSCH_SYS_INT_SRC__INT0__SHIFT                                                                    0x0
+#define VCN_UMSCH_SYS_INT_SRC__INT1__SHIFT                                                                    0x1
+#define VCN_UMSCH_SYS_INT_SRC__INT2__SHIFT                                                                    0x2
+#define VCN_UMSCH_SYS_INT_SRC__INT3__SHIFT                                                                    0x3
+#define VCN_UMSCH_SYS_INT_SRC__INT4__SHIFT                                                                    0x4
+#define VCN_UMSCH_SYS_INT_SRC__INT5__SHIFT                                                                    0x5
+#define VCN_UMSCH_SYS_INT_SRC__INT6__SHIFT                                                                    0x6
+#define VCN_UMSCH_SYS_INT_SRC__INT7__SHIFT                                                                    0x7
+#define VCN_UMSCH_SYS_INT_SRC__INT0_MASK                                                                      0x00000001L
+#define VCN_UMSCH_SYS_INT_SRC__INT1_MASK                                                                      0x00000002L
+#define VCN_UMSCH_SYS_INT_SRC__INT2_MASK                                                                      0x00000004L
+#define VCN_UMSCH_SYS_INT_SRC__INT3_MASK                                                                      0x00000008L
+#define VCN_UMSCH_SYS_INT_SRC__INT4_MASK                                                                      0x00000010L
+#define VCN_UMSCH_SYS_INT_SRC__INT5_MASK                                                                      0x00000020L
+#define VCN_UMSCH_SYS_INT_SRC__INT6_MASK                                                                      0x00000040L
+#define VCN_UMSCH_SYS_INT_SRC__INT7_MASK                                                                      0x00000080L
+//VCN_UMSCH_IH_CTX_CTRL
+#define VCN_UMSCH_IH_CTX_CTRL__IH_CTX_ID__SHIFT                                                               0x0
+#define VCN_UMSCH_IH_CTX_CTRL__IH_CTX_ID_MASK                                                                 0x0FFFFFFFL
+//VCN_UMSCH_CGC_CTRL
+#define VCN_UMSCH_CGC_CTRL__UMSCH_MODE__SHIFT                                                                 0x0
+#define VCN_UMSCH_CGC_CTRL__UMSCH__SHIFT                                                                      0x1
+#define VCN_UMSCH_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT                                                         0x2
+#define VCN_UMSCH_CGC_CTRL__CLK_OFF_DELAY__SHIFT                                                              0x6
+#define VCN_UMSCH_CGC_CTRL__UMSCH_REG_CG_MODE__SHIFT                                                          0xe
+#define VCN_UMSCH_CGC_CTRL__UMSCH_MODE_MASK                                                                   0x00000001L
+#define VCN_UMSCH_CGC_CTRL__UMSCH_MASK                                                                        0x00000002L
+#define VCN_UMSCH_CGC_CTRL__CLK_GATE_DLY_TIMER_MASK                                                           0x0000003CL
+#define VCN_UMSCH_CGC_CTRL__CLK_OFF_DELAY_MASK                                                                0x00003FC0L
+#define VCN_UMSCH_CGC_CTRL__UMSCH_REG_CG_MODE_MASK                                                            0x00004000L
+//VCN_UMSCH_CGC_STATUS
+#define VCN_UMSCH_CGC_STATUS__UMSCH_CORE_ACTIVE__SHIFT                                                        0x0
+#define VCN_UMSCH_CGC_STATUS__UMSCH_CORE_ACTIVE_MASK                                                          0x00000001L
+//VCN_UMSCH_CGC_MEM_CTRL
+#define VCN_UMSCH_CGC_MEM_CTRL__UMSCH_LS_EN_HW_ON__SHIFT                                                      0x0
+#define VCN_UMSCH_CGC_MEM_CTRL__UMSCH_LS_EN_SW_ON__SHIFT                                                      0x1
+#define VCN_UMSCH_CGC_MEM_CTRL__UMSCH_DS_EN__SHIFT                                                            0x2
+#define VCN_UMSCH_CGC_MEM_CTRL__UMSCH_SD_EN__SHIFT                                                            0x3
+#define VCN_UMSCH_CGC_MEM_CTRL__UMSCH_LS_EN_HW_ON_MASK                                                        0x00000001L
+#define VCN_UMSCH_CGC_MEM_CTRL__UMSCH_LS_EN_SW_ON_MASK                                                        0x00000002L
+#define VCN_UMSCH_CGC_MEM_CTRL__UMSCH_DS_EN_MASK                                                              0x00000004L
+#define VCN_UMSCH_CGC_MEM_CTRL__UMSCH_SD_EN_MASK                                                              0x00000008L
+//UVD_INTERNAL_REG_VIOLATION_8
+#define UVD_INTERNAL_REG_VIOLATION_8__UVD_INTERNAL_REG_VIOLATION_8_ADDR__SHIFT                                0x2
+#define UVD_INTERNAL_REG_VIOLATION_8__UVD_INTERNAL_REG_VIOLATION_8_MASTER_ID__SHIFT                           0x14
+#define UVD_INTERNAL_REG_VIOLATION_8__UVD_INTERNAL_REG_VIOLATION_8_OP__SHIFT                                  0x18
+#define UVD_INTERNAL_REG_VIOLATION_8__UVD_INTERNAL_REG_VIOLATION_8_ADDR_MASK                                  0x000FFFFCL
+#define UVD_INTERNAL_REG_VIOLATION_8__UVD_INTERNAL_REG_VIOLATION_8_MASTER_ID_MASK                             0x00F00000L
+#define UVD_INTERNAL_REG_VIOLATION_8__UVD_INTERNAL_REG_VIOLATION_8_OP_MASK                                    0x01000000L
+//UVD_UMSCH_FORCE
+#define UVD_UMSCH_FORCE__IC_FORCE_GPUVM__SHIFT                                                                0x0
+#define UVD_UMSCH_FORCE__DC_FORCE_GPUVM__SHIFT                                                                0x1
+#define UVD_UMSCH_FORCE__FORCE_DROP_DISABLE__SHIFT                                                            0x2
+#define UVD_UMSCH_FORCE__IC_FORCE_GPUVM_MASK                                                                  0x00000001L
+#define UVD_UMSCH_FORCE__DC_FORCE_GPUVM_MASK                                                                  0x00000002L
+#define UVD_UMSCH_FORCE__FORCE_DROP_DISABLE_MASK                                                              0x00000004L
+//UVD_UMSCH_DEBUG_INDEX
+#define UVD_UMSCH_DEBUG_INDEX__DEBUG_READ_ADDR__SHIFT                                                         0x0
+#define UVD_UMSCH_DEBUG_INDEX__DEBUG_ADDR_FREE_STR_DIS__SHIFT                                                 0x1e
+#define UVD_UMSCH_DEBUG_INDEX__DEBUG_RESET__SHIFT                                                             0x1f
+#define UVD_UMSCH_DEBUG_INDEX__DEBUG_READ_ADDR_MASK                                                           0x0000001FL
+#define UVD_UMSCH_DEBUG_INDEX__DEBUG_ADDR_FREE_STR_DIS_MASK                                                   0x40000000L
+#define UVD_UMSCH_DEBUG_INDEX__DEBUG_RESET_MASK                                                               0x80000000L
+//UVD_UMSCH_DEBUG_DATA_LO
+#define UVD_UMSCH_DEBUG_DATA_LO__DEBUG_DATA_LO__SHIFT                                                         0x0
+#define UVD_UMSCH_DEBUG_DATA_LO__DEBUG_DATA_LO_MASK                                                           0xFFFFFFFFL
+//UVD_UMSCH_DEBUG_DATA_HI
+#define UVD_UMSCH_DEBUG_DATA_HI__DEBUG_DATA_HI__SHIFT                                                         0x0
+#define UVD_UMSCH_DEBUG_DATA_HI__DEBUG_DATA_HI_MASK                                                           0xFFFFFFFFL
+//UVD_UMSCH_DEBUG_UTCL2_TCIU_IF
+#define UVD_UMSCH_DEBUG_UTCL2_TCIU_IF__UTCL2_IC_NACK__SHIFT                                                   0x0
+#define UVD_UMSCH_DEBUG_UTCL2_TCIU_IF__UTCL2_DC_NACK__SHIFT                                                   0x2
+#define UVD_UMSCH_DEBUG_UTCL2_TCIU_IF__TCIU_IC_DROP__SHIFT                                                    0x4
+#define UVD_UMSCH_DEBUG_UTCL2_TCIU_IF__TCIU_DC_DROP__SHIFT                                                    0x5
+#define UVD_UMSCH_DEBUG_UTCL2_TCIU_IF__UTCL2_IC_NACK_MASK                                                     0x00000003L
+#define UVD_UMSCH_DEBUG_UTCL2_TCIU_IF__UTCL2_DC_NACK_MASK                                                     0x0000000CL
+#define UVD_UMSCH_DEBUG_UTCL2_TCIU_IF__TCIU_IC_DROP_MASK                                                      0x00000010L
+#define UVD_UMSCH_DEBUG_UTCL2_TCIU_IF__TCIU_DC_DROP_MASK                                                      0x00000020L
+//UMSCH_MES_RESET_CTRL
+#define UMSCH_MES_RESET_CTRL__MES_CORE_SOFT_RESET__SHIFT                                                      0x0
+#define UMSCH_MES_RESET_CTRL__MES_CORE_SOFT_RESET_MASK                                                        0x00000001L
+
+//VCN_MES_PRGRM_CNTR_START
+#define VCN_MES_PRGRM_CNTR_START__IP_START__SHIFT                                                             0x0
+#define VCN_MES_PRGRM_CNTR_START__IP_START_MASK                                                               0xFFFFFFFFL
+//VCN_MES_INTR_ROUTINE_START
+#define VCN_MES_INTR_ROUTINE_START__IR_START__SHIFT                                                           0x0
+#define VCN_MES_INTR_ROUTINE_START__IR_START_MASK                                                             0xFFFFFFFFL
+//VCN_MES_MTVEC_LO
+#define VCN_MES_MTVEC_LO__ADDR_LO__SHIFT                                                                      0x0
+#define VCN_MES_MTVEC_LO__ADDR_LO_MASK                                                                        0xFFFFFFFFL
+//VCN_MES_INTR_ROUTINE_START_HI
+#define VCN_MES_INTR_ROUTINE_START_HI__IR_START__SHIFT                                                        0x0
+#define VCN_MES_INTR_ROUTINE_START_HI__IR_START_MASK                                                          0xFFFFFFFFL
+//VCN_MES_MTVEC_HI
+#define VCN_MES_MTVEC_HI__ADDR_LO__SHIFT                                                                      0x0
+#define VCN_MES_MTVEC_HI__ADDR_LO_MASK                                                                        0xFFFFFFFFL
+//VCN_MES_CNTL
+#define VCN_MES_CNTL__MES_INVALIDATE_ICACHE__SHIFT                                                            0x4
+#define VCN_MES_CNTL__MES_PIPE0_RESET__SHIFT                                                                  0x10
+#define VCN_MES_CNTL__MES_PIPE1_RESET__SHIFT                                                                  0x11
+#define VCN_MES_CNTL__MES_PIPE2_RESET__SHIFT                                                                  0x12
+#define VCN_MES_CNTL__MES_PIPE3_RESET__SHIFT                                                                  0x13
+#define VCN_MES_CNTL__MES_PIPE0_ACTIVE__SHIFT                                                                 0x1a
+#define VCN_MES_CNTL__MES_PIPE1_ACTIVE__SHIFT                                                                 0x1b
+#define VCN_MES_CNTL__MES_PIPE2_ACTIVE__SHIFT                                                                 0x1c
+#define VCN_MES_CNTL__MES_PIPE3_ACTIVE__SHIFT                                                                 0x1d
+#define VCN_MES_CNTL__MES_HALT__SHIFT                                                                         0x1e
+#define VCN_MES_CNTL__MES_STEP__SHIFT                                                                         0x1f
+#define VCN_MES_CNTL__MES_INVALIDATE_ICACHE_MASK                                                              0x00000010L
+#define VCN_MES_CNTL__MES_PIPE0_RESET_MASK                                                                    0x00010000L
+#define VCN_MES_CNTL__MES_PIPE1_RESET_MASK                                                                    0x00020000L
+#define VCN_MES_CNTL__MES_PIPE2_RESET_MASK                                                                    0x00040000L
+#define VCN_MES_CNTL__MES_PIPE3_RESET_MASK                                                                    0x00080000L
+#define VCN_MES_CNTL__MES_PIPE0_ACTIVE_MASK                                                                   0x04000000L
+#define VCN_MES_CNTL__MES_PIPE1_ACTIVE_MASK                                                                   0x08000000L
+#define VCN_MES_CNTL__MES_PIPE2_ACTIVE_MASK                                                                   0x10000000L
+#define VCN_MES_CNTL__MES_PIPE3_ACTIVE_MASK                                                                   0x20000000L
+#define VCN_MES_CNTL__MES_HALT_MASK                                                                           0x40000000L
+#define VCN_MES_CNTL__MES_STEP_MASK                                                                           0x80000000L
+//VCN_MES_PIPE_PRIORITY_CNTS
+#define VCN_MES_PIPE_PRIORITY_CNTS__PRIORITY1_CNT__SHIFT                                                      0x0
+#define VCN_MES_PIPE_PRIORITY_CNTS__PRIORITY2A_CNT__SHIFT                                                     0x8
+#define VCN_MES_PIPE_PRIORITY_CNTS__PRIORITY2B_CNT__SHIFT                                                     0x10
+#define VCN_MES_PIPE_PRIORITY_CNTS__PRIORITY3_CNT__SHIFT                                                      0x18
+#define VCN_MES_PIPE_PRIORITY_CNTS__PRIORITY1_CNT_MASK                                                        0x000000FFL
+#define VCN_MES_PIPE_PRIORITY_CNTS__PRIORITY2A_CNT_MASK                                                       0x0000FF00L
+#define VCN_MES_PIPE_PRIORITY_CNTS__PRIORITY2B_CNT_MASK                                                       0x00FF0000L
+#define VCN_MES_PIPE_PRIORITY_CNTS__PRIORITY3_CNT_MASK                                                        0xFF000000L
+//VCN_MES_PIPE0_PRIORITY
+#define VCN_MES_PIPE0_PRIORITY__PRIORITY__SHIFT                                                               0x0
+#define VCN_MES_PIPE0_PRIORITY__PRIORITY_MASK                                                                 0x00000003L
+//VCN_MES_PIPE1_PRIORITY
+#define VCN_MES_PIPE1_PRIORITY__PRIORITY__SHIFT                                                               0x0
+#define VCN_MES_PIPE1_PRIORITY__PRIORITY_MASK                                                                 0x00000003L
+//VCN_MES_PIPE2_PRIORITY
+#define VCN_MES_PIPE2_PRIORITY__PRIORITY__SHIFT                                                               0x0
+#define VCN_MES_PIPE2_PRIORITY__PRIORITY_MASK                                                                 0x00000003L
+//VCN_MES_PIPE3_PRIORITY
+#define VCN_MES_PIPE3_PRIORITY__PRIORITY__SHIFT                                                               0x0
+#define VCN_MES_PIPE3_PRIORITY__PRIORITY_MASK                                                                 0x00000003L
+//VCN_MES_HEADER_DUMP
+#define VCN_MES_HEADER_DUMP__HEADER_DUMP__SHIFT                                                               0x0
+#define VCN_MES_HEADER_DUMP__HEADER_DUMP_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_MIE_LO
+#define VCN_MES_MIE_LO__MES_INT__SHIFT                                                                        0x0
+#define VCN_MES_MIE_LO__MES_INT_MASK                                                                          0xFFFFFFFFL
+//VCN_MES_MIE_HI
+#define VCN_MES_MIE_HI__MES_INT__SHIFT                                                                        0x0
+#define VCN_MES_MIE_HI__MES_INT_MASK                                                                          0xFFFFFFFFL
+//VCN_MES_INTERRUPT
+#define VCN_MES_INTERRUPT__MES_INT__SHIFT                                                                     0x0
+#define VCN_MES_INTERRUPT__MES_INT_MASK                                                                       0xFFFFFFFFL
+//VCN_MES_SCRATCH_INDEX
+#define VCN_MES_SCRATCH_INDEX__SCRATCH_INDEX__SHIFT                                                           0x0
+#define VCN_MES_SCRATCH_INDEX__SCRATCH_INDEX_64BIT_MODE__SHIFT                                                0x1f
+#define VCN_MES_SCRATCH_INDEX__SCRATCH_INDEX_MASK                                                             0x000001FFL
+#define VCN_MES_SCRATCH_INDEX__SCRATCH_INDEX_64BIT_MODE_MASK                                                  0x80000000L
+//VCN_MES_SCRATCH_DATA
+#define VCN_MES_SCRATCH_DATA__SCRATCH_DATA__SHIFT                                                             0x0
+#define VCN_MES_SCRATCH_DATA__SCRATCH_DATA_MASK                                                               0xFFFFFFFFL
+//VCN_MES_INSTR_PNTR
+#define VCN_MES_INSTR_PNTR__INSTR_PNTR__SHIFT                                                                 0x0
+#define VCN_MES_INSTR_PNTR__INSTR_PNTR_MASK                                                                   0x000FFFFFL
+//VCN_MES_MSCRATCH_HI
+#define VCN_MES_MSCRATCH_HI__DATA__SHIFT                                                                      0x0
+#define VCN_MES_MSCRATCH_HI__DATA_MASK                                                                        0xFFFFFFFFL
+//VCN_MES_MSCRATCH_LO
+#define VCN_MES_MSCRATCH_LO__DATA__SHIFT                                                                      0x0
+#define VCN_MES_MSCRATCH_LO__DATA_MASK                                                                        0xFFFFFFFFL
+//VCN_MES_MSTATUS_LO
+#define VCN_MES_MSTATUS_LO__STATUS_LO__SHIFT                                                                  0x0
+#define VCN_MES_MSTATUS_LO__STATUS_LO_MASK                                                                    0xFFFFFFFFL
+//VCN_MES_MSTATUS_HI
+#define VCN_MES_MSTATUS_HI__STATUS_HI__SHIFT                                                                  0x0
+#define VCN_MES_MSTATUS_HI__STATUS_HI_MASK                                                                    0xFFFFFFFFL
+//VCN_MES_MEPC_LO
+#define VCN_MES_MEPC_LO__MEPC_LO__SHIFT                                                                       0x0
+#define VCN_MES_MEPC_LO__MEPC_LO_MASK                                                                         0xFFFFFFFFL
+//VCN_MES_MEPC_HI
+#define VCN_MES_MEPC_HI__MEPC_HI__SHIFT                                                                       0x0
+#define VCN_MES_MEPC_HI__MEPC_HI_MASK                                                                         0xFFFFFFFFL
+//VCN_MES_MCAUSE_LO
+#define VCN_MES_MCAUSE_LO__CAUSE_LO__SHIFT                                                                    0x0
+#define VCN_MES_MCAUSE_LO__CAUSE_LO_MASK                                                                      0xFFFFFFFFL
+//VCN_MES_MCAUSE_HI
+#define VCN_MES_MCAUSE_HI__CAUSE_HI__SHIFT                                                                    0x0
+#define VCN_MES_MCAUSE_HI__CAUSE_HI_MASK                                                                      0xFFFFFFFFL
+//VCN_MES_MBADADDR_LO
+#define VCN_MES_MBADADDR_LO__ADDR_LO__SHIFT                                                                   0x0
+#define VCN_MES_MBADADDR_LO__ADDR_LO_MASK                                                                     0xFFFFFFFFL
+//VCN_MES_MBADADDR_HI
+#define VCN_MES_MBADADDR_HI__ADDR_HI__SHIFT                                                                   0x0
+#define VCN_MES_MBADADDR_HI__ADDR_HI_MASK                                                                     0xFFFFFFFFL
+//VCN_MES_MIP_LO
+#define VCN_MES_MIP_LO__MIP_LO__SHIFT                                                                         0x0
+#define VCN_MES_MIP_LO__MIP_LO_MASK                                                                           0xFFFFFFFFL
+//VCN_MES_MIP_HI
+#define VCN_MES_MIP_HI__MIP_HI__SHIFT                                                                         0x0
+#define VCN_MES_MIP_HI__MIP_HI_MASK                                                                           0xFFFFFFFFL
+//VCN_MES_IC_OP_CNTL
+#define VCN_MES_IC_OP_CNTL__INVALIDATE_CACHE__SHIFT                                                           0x0
+#define VCN_MES_IC_OP_CNTL__PRIME_ICACHE__SHIFT                                                               0x4
+#define VCN_MES_IC_OP_CNTL__ICACHE_PRIMED__SHIFT                                                              0x5
+#define VCN_MES_IC_OP_CNTL__INVALIDATE_CACHE_MASK                                                             0x00000001L
+#define VCN_MES_IC_OP_CNTL__PRIME_ICACHE_MASK                                                                 0x00000010L
+#define VCN_MES_IC_OP_CNTL__ICACHE_PRIMED_MASK                                                                0x00000020L
+//VCN_MES_MCYCLE_LO
+#define VCN_MES_MCYCLE_LO__CYCLE_LO__SHIFT                                                                    0x0
+#define VCN_MES_MCYCLE_LO__CYCLE_LO_MASK                                                                      0xFFFFFFFFL
+//VCN_MES_MCYCLE_HI
+#define VCN_MES_MCYCLE_HI__CYCLE_HI__SHIFT                                                                    0x0
+#define VCN_MES_MCYCLE_HI__CYCLE_HI_MASK                                                                      0xFFFFFFFFL
+//VCN_MES_MTIME_LO
+#define VCN_MES_MTIME_LO__TIME_LO__SHIFT                                                                      0x0
+#define VCN_MES_MTIME_LO__TIME_LO_MASK                                                                        0xFFFFFFFFL
+//VCN_MES_MTIME_HI
+#define VCN_MES_MTIME_HI__TIME_HI__SHIFT                                                                      0x0
+#define VCN_MES_MTIME_HI__TIME_HI_MASK                                                                        0xFFFFFFFFL
+//VCN_MES_MINSTRET_LO
+#define VCN_MES_MINSTRET_LO__INSTRET_LO__SHIFT                                                                0x0
+#define VCN_MES_MINSTRET_LO__INSTRET_LO_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_MINSTRET_HI
+#define VCN_MES_MINSTRET_HI__INSTRET_HI__SHIFT                                                                0x0
+#define VCN_MES_MINSTRET_HI__INSTRET_HI_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_MISA_LO
+#define VCN_MES_MISA_LO__MISA_LO__SHIFT                                                                       0x0
+#define VCN_MES_MISA_LO__MISA_LO_MASK                                                                         0xFFFFFFFFL
+//VCN_MES_MISA_HI
+#define VCN_MES_MISA_HI__MISA_HI__SHIFT                                                                       0x0
+#define VCN_MES_MISA_HI__MISA_HI_MASK                                                                         0xFFFFFFFFL
+//VCN_MES_MVENDORID_LO
+#define VCN_MES_MVENDORID_LO__MVENDORID_LO__SHIFT                                                             0x0
+#define VCN_MES_MVENDORID_LO__MVENDORID_LO_MASK                                                               0xFFFFFFFFL
+//VCN_MES_MVENDORID_HI
+#define VCN_MES_MVENDORID_HI__MVENDORID_HI__SHIFT                                                             0x0
+#define VCN_MES_MVENDORID_HI__MVENDORID_HI_MASK                                                               0xFFFFFFFFL
+//VCN_MES_MARCHID_LO
+#define VCN_MES_MARCHID_LO__MARCHID_LO__SHIFT                                                                 0x0
+#define VCN_MES_MARCHID_LO__MARCHID_LO_MASK                                                                   0xFFFFFFFFL
+//VCN_MES_MARCHID_HI
+#define VCN_MES_MARCHID_HI__MARCHID_HI__SHIFT                                                                 0x0
+#define VCN_MES_MARCHID_HI__MARCHID_HI_MASK                                                                   0xFFFFFFFFL
+//VCN_MES_MIMPID_LO
+#define VCN_MES_MIMPID_LO__MIMPID_LO__SHIFT                                                                   0x0
+#define VCN_MES_MIMPID_LO__MIMPID_LO_MASK                                                                     0xFFFFFFFFL
+//VCN_MES_MIMPID_HI
+#define VCN_MES_MIMPID_HI__MIMPID_HI__SHIFT                                                                   0x0
+#define VCN_MES_MIMPID_HI__MIMPID_HI_MASK                                                                     0xFFFFFFFFL
+//VCN_MES_MHARTID_LO
+#define VCN_MES_MHARTID_LO__MHARTID_LO__SHIFT                                                                 0x0
+#define VCN_MES_MHARTID_LO__MHARTID_LO_MASK                                                                   0xFFFFFFFFL
+//VCN_MES_MHARTID_HI
+#define VCN_MES_MHARTID_HI__MHARTID_HI__SHIFT                                                                 0x0
+#define VCN_MES_MHARTID_HI__MHARTID_HI_MASK                                                                   0xFFFFFFFFL
+//VCN_MES_DC_BASE_CNTL
+#define VCN_MES_DC_BASE_CNTL__VMID__SHIFT                                                                     0x0
+#define VCN_MES_DC_BASE_CNTL__CACHE_POLICY__SHIFT                                                             0x18
+#define VCN_MES_DC_BASE_CNTL__VMID_MASK                                                                       0x0000000FL
+#define VCN_MES_DC_BASE_CNTL__CACHE_POLICY_MASK                                                               0x03000000L
+//VCN_MES_DC_OP_CNTL
+#define VCN_MES_DC_OP_CNTL__INVALIDATE_DCACHE__SHIFT                                                          0x0
+#define VCN_MES_DC_OP_CNTL__INVALIDATE_DCACHE_COMPLETE__SHIFT                                                 0x1
+#define VCN_MES_DC_OP_CNTL__BYPASS_ALL__SHIFT                                                                 0x2
+#define VCN_MES_DC_OP_CNTL__DEPRECATED__SHIFT                                                                 0x3
+#define VCN_MES_DC_OP_CNTL__DEPRACATED__SHIFT                                                                 0x4
+#define VCN_MES_DC_OP_CNTL__INVALIDATE_DCACHE_MASK                                                            0x00000001L
+#define VCN_MES_DC_OP_CNTL__INVALIDATE_DCACHE_COMPLETE_MASK                                                   0x00000002L
+#define VCN_MES_DC_OP_CNTL__BYPASS_ALL_MASK                                                                   0x00000004L
+#define VCN_MES_DC_OP_CNTL__DEPRECATED_MASK                                                                   0x00000008L
+#define VCN_MES_DC_OP_CNTL__DEPRACATED_MASK                                                                   0x00000010L
+//VCN_MES_MTIMECMP_LO
+#define VCN_MES_MTIMECMP_LO__TIME_LO__SHIFT                                                                   0x0
+#define VCN_MES_MTIMECMP_LO__TIME_LO_MASK                                                                     0xFFFFFFFFL
+//VCN_MES_MTIMECMP_HI
+#define VCN_MES_MTIMECMP_HI__TIME_HI__SHIFT                                                                   0x0
+#define VCN_MES_MTIMECMP_HI__TIME_HI_MASK                                                                     0xFFFFFFFFL
+//VCN_MES_DEBUG_INTERRUPT_INSTR_PNTR
+#define VCN_MES_DEBUG_INTERRUPT_INSTR_PNTR__INSTR_PNTR__SHIFT                                                 0x0
+#define VCN_MES_DEBUG_INTERRUPT_INSTR_PNTR__INSTR_PNTR_MASK                                                   0xFFFFFFFFL
+//VCN_MES_GP0_LO
+#define VCN_MES_GP0_LO__PG_VIRT_HALTED__SHIFT                                                                 0x0
+#define VCN_MES_GP0_LO__DATA__SHIFT                                                                           0x1
+#define VCN_MES_GP0_LO__PG_VIRT_HALTED_MASK                                                                   0x00000001L
+#define VCN_MES_GP0_LO__DATA_MASK                                                                             0xFFFFFFFEL
+//VCN_MES_GP0_HI
+#define VCN_MES_GP0_HI__M_RET_ADDR__SHIFT                                                                     0x0
+#define VCN_MES_GP0_HI__M_RET_ADDR_MASK                                                                       0xFFFFFFFFL
+//VCN_MES_GP1_LO
+#define VCN_MES_GP1_LO__RD_WR_SELECT_LO__SHIFT                                                                0x0
+#define VCN_MES_GP1_LO__RD_WR_SELECT_LO_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_GP1_HI
+#define VCN_MES_GP1_HI__RD_WR_SELECT_HI__SHIFT                                                                0x0
+#define VCN_MES_GP1_HI__RD_WR_SELECT_HI_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_GP2_LO
+#define VCN_MES_GP2_LO__STACK_PNTR_LO__SHIFT                                                                  0x0
+#define VCN_MES_GP2_LO__STACK_PNTR_LO_MASK                                                                    0xFFFFFFFFL
+//VCN_MES_GP2_HI
+#define VCN_MES_GP2_HI__STACK_PNTR_HI__SHIFT                                                                  0x0
+#define VCN_MES_GP2_HI__STACK_PNTR_HI_MASK                                                                    0xFFFFFFFFL
+//VCN_MES_GP3_LO
+#define VCN_MES_GP3_LO__DATA__SHIFT                                                                           0x0
+#define VCN_MES_GP3_LO__DATA_MASK                                                                             0xFFFFFFFFL
+//VCN_MES_GP3_HI
+#define VCN_MES_GP3_HI__DATA__SHIFT                                                                           0x0
+#define VCN_MES_GP3_HI__DATA_MASK                                                                             0xFFFFFFFFL
+//VCN_MES_GP4_LO
+#define VCN_MES_GP4_LO__DATA__SHIFT                                                                           0x0
+#define VCN_MES_GP4_LO__DATA_MASK                                                                             0xFFFFFFFFL
+//VCN_MES_GP4_HI
+#define VCN_MES_GP4_HI__DATA__SHIFT                                                                           0x0
+#define VCN_MES_GP4_HI__DATA_MASK                                                                             0xFFFFFFFFL
+//VCN_MES_GP5_LO
+#define VCN_MES_GP5_LO__PG_VIRT_HALTED__SHIFT                                                                 0x0
+#define VCN_MES_GP5_LO__DATA__SHIFT                                                                           0x1
+#define VCN_MES_GP5_LO__PG_VIRT_HALTED_MASK                                                                   0x00000001L
+#define VCN_MES_GP5_LO__DATA_MASK                                                                             0xFFFFFFFEL
+//VCN_MES_GP5_HI
+#define VCN_MES_GP5_HI__M_RET_ADDR__SHIFT                                                                     0x0
+#define VCN_MES_GP5_HI__M_RET_ADDR_MASK                                                                       0xFFFFFFFFL
+//VCN_MES_GP6_LO
+#define VCN_MES_GP6_LO__RD_WR_SELECT_LO__SHIFT                                                                0x0
+#define VCN_MES_GP6_LO__RD_WR_SELECT_LO_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_GP6_HI
+#define VCN_MES_GP6_HI__RD_WR_SELECT_HI__SHIFT                                                                0x0
+#define VCN_MES_GP6_HI__RD_WR_SELECT_HI_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_GP7_LO
+#define VCN_MES_GP7_LO__STACK_PNTR_LO__SHIFT                                                                  0x0
+#define VCN_MES_GP7_LO__STACK_PNTR_LO_MASK                                                                    0xFFFFFFFFL
+//VCN_MES_GP7_HI
+#define VCN_MES_GP7_HI__STACK_PNTR_HI__SHIFT                                                                  0x0
+#define VCN_MES_GP7_HI__STACK_PNTR_HI_MASK                                                                    0xFFFFFFFFL
+//VCN_MES_GP8_LO
+#define VCN_MES_GP8_LO__DATA__SHIFT                                                                           0x0
+#define VCN_MES_GP8_LO__DATA_MASK                                                                             0xFFFFFFFFL
+//VCN_MES_GP8_HI
+#define VCN_MES_GP8_HI__DATA__SHIFT                                                                           0x0
+#define VCN_MES_GP8_HI__DATA_MASK                                                                             0xFFFFFFFFL
+//VCN_MES_GP9_LO
+#define VCN_MES_GP9_LO__DATA__SHIFT                                                                           0x0
+#define VCN_MES_GP9_LO__DATA_MASK                                                                             0xFFFFFFFFL
+//VCN_MES_GP9_HI
+#define VCN_MES_GP9_HI__DATA__SHIFT                                                                           0x0
+#define VCN_MES_GP9_HI__DATA_MASK                                                                             0xFFFFFFFFL
+//VCN_MES_DM_INDEX_ADDR
+#define VCN_MES_DM_INDEX_ADDR__ADDR__SHIFT                                                                    0x0
+#define VCN_MES_DM_INDEX_ADDR__ADDR_MASK                                                                      0xFFFFFFFFL
+//VCN_MES_DM_INDEX_DATA
+#define VCN_MES_DM_INDEX_DATA__DATA__SHIFT                                                                    0x0
+#define VCN_MES_DM_INDEX_DATA__DATA_MASK                                                                      0xFFFFFFFFL
+//VCN_MES_DBG_FROM_RST
+#define VCN_MES_DBG_FROM_RST__CONTROL__SHIFT                                                                  0x0
+#define VCN_MES_DBG_FROM_RST__CONTROL_MASK                                                                    0x00000001L
+//VCN_MES_LOCAL_BASE0_LO
+#define VCN_MES_LOCAL_BASE0_LO__BASE0_LO__SHIFT                                                               0x10
+#define VCN_MES_LOCAL_BASE0_LO__BASE0_LO_MASK                                                                 0xFFFF0000L
+//VCN_MES_LOCAL_BASE0_HI
+#define VCN_MES_LOCAL_BASE0_HI__BASE0_HI__SHIFT                                                               0x0
+#define VCN_MES_LOCAL_BASE0_HI__BASE0_HI_MASK                                                                 0x0000FFFFL
+//VCN_MES_LOCAL_MASK0_LO
+#define VCN_MES_LOCAL_MASK0_LO__MASK0_LO__SHIFT                                                               0x10
+#define VCN_MES_LOCAL_MASK0_LO__MASK0_LO_MASK                                                                 0xFFFF0000L
+//VCN_MES_LOCAL_MASK0_HI
+#define VCN_MES_LOCAL_MASK0_HI__MASK0_HI__SHIFT                                                               0x0
+#define VCN_MES_LOCAL_MASK0_HI__MASK0_HI_MASK                                                                 0x0000FFFFL
+//VCN_MES_LOCAL_APERTURE
+#define VCN_MES_LOCAL_APERTURE__APERTURE__SHIFT                                                               0x0
+#define VCN_MES_LOCAL_APERTURE__APERTURE_MASK                                                                 0x00000007L
+//VCN_MES_LOCAL_INSTR_BASE_LO
+#define VCN_MES_LOCAL_INSTR_BASE_LO__BASE_LO__SHIFT                                                           0x10
+#define VCN_MES_LOCAL_INSTR_BASE_LO__BASE_LO_MASK                                                             0xFFFF0000L
+//VCN_MES_LOCAL_INSTR_BASE_HI
+#define VCN_MES_LOCAL_INSTR_BASE_HI__BASE_HI__SHIFT                                                           0x0
+#define VCN_MES_LOCAL_INSTR_BASE_HI__BASE_HI_MASK                                                             0x0000FFFFL
+//VCN_MES_LOCAL_INSTR_MASK_LO
+#define VCN_MES_LOCAL_INSTR_MASK_LO__MASK_LO__SHIFT                                                           0x10
+#define VCN_MES_LOCAL_INSTR_MASK_LO__MASK_LO_MASK                                                             0xFFFF0000L
+//VCN_MES_LOCAL_INSTR_MASK_HI
+#define VCN_MES_LOCAL_INSTR_MASK_HI__MASK_HI__SHIFT                                                           0x0
+#define VCN_MES_LOCAL_INSTR_MASK_HI__MASK_HI_MASK                                                             0x0000FFFFL
+//VCN_MES_LOCAL_INSTR_APERTURE
+#define VCN_MES_LOCAL_INSTR_APERTURE__APERTURE__SHIFT                                                         0x0
+#define VCN_MES_LOCAL_INSTR_APERTURE__APERTURE_MASK                                                           0x00000007L
+//VCN_MES_LOCAL_SCRATCH_APERTURE
+#define VCN_MES_LOCAL_SCRATCH_APERTURE__APERTURE__SHIFT                                                       0x0
+#define VCN_MES_LOCAL_SCRATCH_APERTURE__APERTURE_MASK                                                         0x00000007L
+//VCN_MES_LOCAL_SCRATCH_BASE_LO
+#define VCN_MES_LOCAL_SCRATCH_BASE_LO__BASE_LO__SHIFT                                                         0x10
+#define VCN_MES_LOCAL_SCRATCH_BASE_LO__BASE_LO_MASK                                                           0xFFFF0000L
+//VCN_MES_LOCAL_SCRATCH_BASE_HI
+#define VCN_MES_LOCAL_SCRATCH_BASE_HI__BASE_HI__SHIFT                                                         0x0
+#define VCN_MES_LOCAL_SCRATCH_BASE_HI__BASE_HI_MASK                                                           0x0000FFFFL
+//VCN_MES_PERFCOUNT_CNTL
+#define VCN_MES_PERFCOUNT_CNTL__EVENT_SEL__SHIFT                                                              0x0
+#define VCN_MES_PERFCOUNT_CNTL__EVENT_SEL_MASK                                                                0x0000001FL
+//VCN_MES_PENDING_INTERRUPT
+#define VCN_MES_PENDING_INTERRUPT__PENDING_INTERRUPT__SHIFT                                                   0x0
+#define VCN_MES_PENDING_INTERRUPT__PENDING_INTERRUPT_MASK                                                     0xFFFFFFFFL
+//VCN_MES_PRIV_LEVEL
+#define VCN_MES_PRIV_LEVEL__PRIV_LEVEL__SHIFT                                                                 0x0
+#define VCN_MES_PRIV_LEVEL__GRBM_PRIV_LEVEL__SHIFT                                                            0x1
+#define VCN_MES_PRIV_LEVEL__PRIV_LEVEL_MASK                                                                   0x00000001L
+#define VCN_MES_PRIV_LEVEL__GRBM_PRIV_LEVEL_MASK                                                              0x00000002L
+//VCN_MES_PRIV_LEVEL_VIOLATION_STATUS
+#define VCN_MES_PRIV_LEVEL_VIOLATION_STATUS__PRIV_LEVEL_VIOLATION_OCCURRED__SHIFT                             0x0
+#define VCN_MES_PRIV_LEVEL_VIOLATION_STATUS__PRIV_LEVEL_VIOLATION_OP__SHIFT                                   0x1
+#define VCN_MES_PRIV_LEVEL_VIOLATION_STATUS__PRIV_LEVEL_VIOLATION_ADDR__SHIFT                                 0x2
+#define VCN_MES_PRIV_LEVEL_VIOLATION_STATUS__PRIV_LEVEL_VIOLATION_APERTURE__SHIFT                             0x16
+#define VCN_MES_PRIV_LEVEL_VIOLATION_STATUS__PRIV_LEVEL_VIOLATION_OCCURRED_MASK                               0x00000001L
+#define VCN_MES_PRIV_LEVEL_VIOLATION_STATUS__PRIV_LEVEL_VIOLATION_OP_MASK                                     0x00000002L
+#define VCN_MES_PRIV_LEVEL_VIOLATION_STATUS__PRIV_LEVEL_VIOLATION_ADDR_MASK                                   0x003FFFFCL
+#define VCN_MES_PRIV_LEVEL_VIOLATION_STATUS__PRIV_LEVEL_VIOLATION_APERTURE_MASK                               0x01C00000L
+//VCN_MES_PRGRM_CNTR_START_HI
+#define VCN_MES_PRGRM_CNTR_START_HI__IP_START__SHIFT                                                          0x0
+#define VCN_MES_PRGRM_CNTR_START_HI__IP_START_MASK                                                            0x3FFFFFFFL
+//VCN_MES_DEBUG_INTERRUPT_INSTR_PNTR_HI
+#define VCN_MES_DEBUG_INTERRUPT_INSTR_PNTR_HI__INSTR_PNTR__SHIFT                                              0x0
+#define VCN_MES_DEBUG_INTERRUPT_INSTR_PNTR_HI__INSTR_PNTR_MASK                                                0x3FFFFFFFL
+//VCN_MES_INTERRUPT_DATA_16
+#define VCN_MES_INTERRUPT_DATA_16__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_16__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_17
+#define VCN_MES_INTERRUPT_DATA_17__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_17__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_18
+#define VCN_MES_INTERRUPT_DATA_18__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_18__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_19
+#define VCN_MES_INTERRUPT_DATA_19__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_19__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_20
+#define VCN_MES_INTERRUPT_DATA_20__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_20__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_21
+#define VCN_MES_INTERRUPT_DATA_21__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_21__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_22
+#define VCN_MES_INTERRUPT_DATA_22__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_22__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_23
+#define VCN_MES_INTERRUPT_DATA_23__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_23__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_24
+#define VCN_MES_INTERRUPT_DATA_24__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_24__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_25
+#define VCN_MES_INTERRUPT_DATA_25__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_25__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_26
+#define VCN_MES_INTERRUPT_DATA_26__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_26__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_27
+#define VCN_MES_INTERRUPT_DATA_27__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_27__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_28
+#define VCN_MES_INTERRUPT_DATA_28__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_28__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_29
+#define VCN_MES_INTERRUPT_DATA_29__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_29__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_30
+#define VCN_MES_INTERRUPT_DATA_30__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_30__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_INTERRUPT_DATA_31
+#define VCN_MES_INTERRUPT_DATA_31__DATA__SHIFT                                                                0x0
+#define VCN_MES_INTERRUPT_DATA_31__DATA_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE0_BASE
+#define VCN_MES_DC_APERTURE0_BASE__BASE__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE0_BASE__BASE_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE0_MASK
+#define VCN_MES_DC_APERTURE0_MASK__MASK__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE0_MASK__MASK_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE0_CNTL
+#define VCN_MES_DC_APERTURE0_CNTL__VMID__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE0_CNTL__BYPASS_MODE__SHIFT                                                         0x4
+#define VCN_MES_DC_APERTURE0_CNTL__VMID_MASK                                                                  0x0000000FL
+#define VCN_MES_DC_APERTURE0_CNTL__BYPASS_MODE_MASK                                                           0x00000010L
+//VCN_MES_DC_APERTURE1_BASE
+#define VCN_MES_DC_APERTURE1_BASE__BASE__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE1_BASE__BASE_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE1_MASK
+#define VCN_MES_DC_APERTURE1_MASK__MASK__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE1_MASK__MASK_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE1_CNTL
+#define VCN_MES_DC_APERTURE1_CNTL__VMID__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE1_CNTL__BYPASS_MODE__SHIFT                                                         0x4
+#define VCN_MES_DC_APERTURE1_CNTL__VMID_MASK                                                                  0x0000000FL
+#define VCN_MES_DC_APERTURE1_CNTL__BYPASS_MODE_MASK                                                           0x00000010L
+//VCN_MES_DC_APERTURE2_BASE
+#define VCN_MES_DC_APERTURE2_BASE__BASE__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE2_BASE__BASE_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE2_MASK
+#define VCN_MES_DC_APERTURE2_MASK__MASK__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE2_MASK__MASK_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE2_CNTL
+#define VCN_MES_DC_APERTURE2_CNTL__VMID__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE2_CNTL__BYPASS_MODE__SHIFT                                                         0x4
+#define VCN_MES_DC_APERTURE2_CNTL__VMID_MASK                                                                  0x0000000FL
+#define VCN_MES_DC_APERTURE2_CNTL__BYPASS_MODE_MASK                                                           0x00000010L
+//VCN_MES_DC_APERTURE3_BASE
+#define VCN_MES_DC_APERTURE3_BASE__BASE__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE3_BASE__BASE_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE3_MASK
+#define VCN_MES_DC_APERTURE3_MASK__MASK__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE3_MASK__MASK_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE3_CNTL
+#define VCN_MES_DC_APERTURE3_CNTL__VMID__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE3_CNTL__BYPASS_MODE__SHIFT                                                         0x4
+#define VCN_MES_DC_APERTURE3_CNTL__VMID_MASK                                                                  0x0000000FL
+#define VCN_MES_DC_APERTURE3_CNTL__BYPASS_MODE_MASK                                                           0x00000010L
+//VCN_MES_DC_APERTURE4_BASE
+#define VCN_MES_DC_APERTURE4_BASE__BASE__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE4_BASE__BASE_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE4_MASK
+#define VCN_MES_DC_APERTURE4_MASK__MASK__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE4_MASK__MASK_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE4_CNTL
+#define VCN_MES_DC_APERTURE4_CNTL__VMID__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE4_CNTL__BYPASS_MODE__SHIFT                                                         0x4
+#define VCN_MES_DC_APERTURE4_CNTL__VMID_MASK                                                                  0x0000000FL
+#define VCN_MES_DC_APERTURE4_CNTL__BYPASS_MODE_MASK                                                           0x00000010L
+//VCN_MES_DC_APERTURE5_BASE
+#define VCN_MES_DC_APERTURE5_BASE__BASE__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE5_BASE__BASE_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE5_MASK
+#define VCN_MES_DC_APERTURE5_MASK__MASK__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE5_MASK__MASK_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE5_CNTL
+#define VCN_MES_DC_APERTURE5_CNTL__VMID__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE5_CNTL__BYPASS_MODE__SHIFT                                                         0x4
+#define VCN_MES_DC_APERTURE5_CNTL__VMID_MASK                                                                  0x0000000FL
+#define VCN_MES_DC_APERTURE5_CNTL__BYPASS_MODE_MASK                                                           0x00000010L
+//VCN_MES_DC_APERTURE6_BASE
+#define VCN_MES_DC_APERTURE6_BASE__BASE__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE6_BASE__BASE_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE6_MASK
+#define VCN_MES_DC_APERTURE6_MASK__MASK__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE6_MASK__MASK_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE6_CNTL
+#define VCN_MES_DC_APERTURE6_CNTL__VMID__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE6_CNTL__BYPASS_MODE__SHIFT                                                         0x4
+#define VCN_MES_DC_APERTURE6_CNTL__VMID_MASK                                                                  0x0000000FL
+#define VCN_MES_DC_APERTURE6_CNTL__BYPASS_MODE_MASK                                                           0x00000010L
+//VCN_MES_DC_APERTURE7_BASE
+#define VCN_MES_DC_APERTURE7_BASE__BASE__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE7_BASE__BASE_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE7_MASK
+#define VCN_MES_DC_APERTURE7_MASK__MASK__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE7_MASK__MASK_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE7_CNTL
+#define VCN_MES_DC_APERTURE7_CNTL__VMID__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE7_CNTL__BYPASS_MODE__SHIFT                                                         0x4
+#define VCN_MES_DC_APERTURE7_CNTL__VMID_MASK                                                                  0x0000000FL
+#define VCN_MES_DC_APERTURE7_CNTL__BYPASS_MODE_MASK                                                           0x00000010L
+//VCN_MES_DC_APERTURE8_BASE
+#define VCN_MES_DC_APERTURE8_BASE__BASE__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE8_BASE__BASE_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE8_MASK
+#define VCN_MES_DC_APERTURE8_MASK__MASK__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE8_MASK__MASK_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE8_CNTL
+#define VCN_MES_DC_APERTURE8_CNTL__VMID__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE8_CNTL__BYPASS_MODE__SHIFT                                                         0x4
+#define VCN_MES_DC_APERTURE8_CNTL__VMID_MASK                                                                  0x0000000FL
+#define VCN_MES_DC_APERTURE8_CNTL__BYPASS_MODE_MASK                                                           0x00000010L
+//VCN_MES_DC_APERTURE9_BASE
+#define VCN_MES_DC_APERTURE9_BASE__BASE__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE9_BASE__BASE_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE9_MASK
+#define VCN_MES_DC_APERTURE9_MASK__MASK__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE9_MASK__MASK_MASK                                                                  0xFFFFFFFFL
+//VCN_MES_DC_APERTURE9_CNTL
+#define VCN_MES_DC_APERTURE9_CNTL__VMID__SHIFT                                                                0x0
+#define VCN_MES_DC_APERTURE9_CNTL__BYPASS_MODE__SHIFT                                                         0x4
+#define VCN_MES_DC_APERTURE9_CNTL__VMID_MASK                                                                  0x0000000FL
+#define VCN_MES_DC_APERTURE9_CNTL__BYPASS_MODE_MASK                                                           0x00000010L
+//VCN_MES_DC_APERTURE10_BASE
+#define VCN_MES_DC_APERTURE10_BASE__BASE__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE10_BASE__BASE_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE10_MASK
+#define VCN_MES_DC_APERTURE10_MASK__MASK__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE10_MASK__MASK_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE10_CNTL
+#define VCN_MES_DC_APERTURE10_CNTL__VMID__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE10_CNTL__BYPASS_MODE__SHIFT                                                        0x4
+#define VCN_MES_DC_APERTURE10_CNTL__VMID_MASK                                                                 0x0000000FL
+#define VCN_MES_DC_APERTURE10_CNTL__BYPASS_MODE_MASK                                                          0x00000010L
+//VCN_MES_DC_APERTURE11_BASE
+#define VCN_MES_DC_APERTURE11_BASE__BASE__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE11_BASE__BASE_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE11_MASK
+#define VCN_MES_DC_APERTURE11_MASK__MASK__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE11_MASK__MASK_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE11_CNTL
+#define VCN_MES_DC_APERTURE11_CNTL__VMID__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE11_CNTL__BYPASS_MODE__SHIFT                                                        0x4
+#define VCN_MES_DC_APERTURE11_CNTL__VMID_MASK                                                                 0x0000000FL
+#define VCN_MES_DC_APERTURE11_CNTL__BYPASS_MODE_MASK                                                          0x00000010L
+//VCN_MES_DC_APERTURE12_BASE
+#define VCN_MES_DC_APERTURE12_BASE__BASE__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE12_BASE__BASE_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE12_MASK
+#define VCN_MES_DC_APERTURE12_MASK__MASK__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE12_MASK__MASK_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE12_CNTL
+#define VCN_MES_DC_APERTURE12_CNTL__VMID__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE12_CNTL__BYPASS_MODE__SHIFT                                                        0x4
+#define VCN_MES_DC_APERTURE12_CNTL__VMID_MASK                                                                 0x0000000FL
+#define VCN_MES_DC_APERTURE12_CNTL__BYPASS_MODE_MASK                                                          0x00000010L
+//VCN_MES_DC_APERTURE13_BASE
+#define VCN_MES_DC_APERTURE13_BASE__BASE__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE13_BASE__BASE_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE13_MASK
+#define VCN_MES_DC_APERTURE13_MASK__MASK__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE13_MASK__MASK_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE13_CNTL
+#define VCN_MES_DC_APERTURE13_CNTL__VMID__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE13_CNTL__BYPASS_MODE__SHIFT                                                        0x4
+#define VCN_MES_DC_APERTURE13_CNTL__VMID_MASK                                                                 0x0000000FL
+#define VCN_MES_DC_APERTURE13_CNTL__BYPASS_MODE_MASK                                                          0x00000010L
+//VCN_MES_DC_APERTURE14_BASE
+#define VCN_MES_DC_APERTURE14_BASE__BASE__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE14_BASE__BASE_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE14_MASK
+#define VCN_MES_DC_APERTURE14_MASK__MASK__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE14_MASK__MASK_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE14_CNTL
+#define VCN_MES_DC_APERTURE14_CNTL__VMID__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE14_CNTL__BYPASS_MODE__SHIFT                                                        0x4
+#define VCN_MES_DC_APERTURE14_CNTL__VMID_MASK                                                                 0x0000000FL
+#define VCN_MES_DC_APERTURE14_CNTL__BYPASS_MODE_MASK                                                          0x00000010L
+//VCN_MES_DC_APERTURE15_BASE
+#define VCN_MES_DC_APERTURE15_BASE__BASE__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE15_BASE__BASE_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE15_MASK
+#define VCN_MES_DC_APERTURE15_MASK__MASK__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE15_MASK__MASK_MASK                                                                 0xFFFFFFFFL
+//VCN_MES_DC_APERTURE15_CNTL
+#define VCN_MES_DC_APERTURE15_CNTL__VMID__SHIFT                                                               0x0
+#define VCN_MES_DC_APERTURE15_CNTL__BYPASS_MODE__SHIFT                                                        0x4
+#define VCN_MES_DC_APERTURE15_CNTL__VMID_MASK                                                                 0x0000000FL
+#define VCN_MES_DC_APERTURE15_CNTL__BYPASS_MODE_MASK                                                          0x00000010L
+
+//VCN_HYP_ME1_PIPE0_VMID_CNTL
+#define VCN_HYP_ME1_PIPE0_VMID_CNTL__VMID_ALLOWED_MASK__SHIFT                                                 0x0
+#define VCN_HYP_ME1_PIPE0_VMID_CNTL__VMID_DEFAULT__SHIFT                                                      0x10
+#define VCN_HYP_ME1_PIPE0_VMID_CNTL__VMID_ALLOWED_MASK_MASK                                                   0x0000FFFFL
+#define VCN_HYP_ME1_PIPE0_VMID_CNTL__VMID_DEFAULT_MASK                                                        0x000F0000L
+//VCN_HYP_ME1_PIPE1_VMID_CNTL
+#define VCN_HYP_ME1_PIPE1_VMID_CNTL__VMID_ALLOWED_MASK__SHIFT                                                 0x0
+#define VCN_HYP_ME1_PIPE1_VMID_CNTL__VMID_DEFAULT__SHIFT                                                      0x10
+#define VCN_HYP_ME1_PIPE1_VMID_CNTL__VMID_ALLOWED_MASK_MASK                                                   0x0000FFFFL
+#define VCN_HYP_ME1_PIPE1_VMID_CNTL__VMID_DEFAULT_MASK                                                        0x000F0000L
+//VCN_MES_IC_BASE_LO
+#define VCN_MES_IC_BASE_LO__IC_BASE_LO__SHIFT                                                                 0xc
+#define VCN_MES_IC_BASE_LO__IC_BASE_LO_MASK                                                                   0xFFFFF000L
+//VCN_MES_MIBASE_LO
+#define VCN_MES_MIBASE_LO__IC_BASE_LO__SHIFT                                                                  0xc
+#define VCN_MES_MIBASE_LO__IC_BASE_LO_MASK                                                                    0xFFFFF000L
+//VCN_MES_IC_BASE_HI
+#define VCN_MES_IC_BASE_HI__IC_BASE_HI__SHIFT                                                                 0x0
+#define VCN_MES_IC_BASE_HI__IC_BASE_HI_MASK                                                                   0x0000FFFFL
+//VCN_MES_MIBASE_HI
+#define VCN_MES_MIBASE_HI__IC_BASE_HI__SHIFT                                                                  0x0
+#define VCN_MES_MIBASE_HI__IC_BASE_HI_MASK                                                                    0x0000FFFFL
+//VCN_MES_IC_BASE_CNTL
+#define VCN_MES_IC_BASE_CNTL__VMID__SHIFT                                                                     0x0
+#define VCN_MES_IC_BASE_CNTL__EXE_DISABLE__SHIFT                                                              0x17
+#define VCN_MES_IC_BASE_CNTL__CACHE_POLICY__SHIFT                                                             0x18
+#define VCN_MES_IC_BASE_CNTL__VMID_MASK                                                                       0x0000000FL
+#define VCN_MES_IC_BASE_CNTL__EXE_DISABLE_MASK                                                                0x00800000L
+#define VCN_MES_IC_BASE_CNTL__CACHE_POLICY_MASK                                                               0x03000000L
+//VCN_MES_DC_BASE_LO
+#define VCN_MES_DC_BASE_LO__DC_BASE_LO__SHIFT                                                                 0x10
+#define VCN_MES_DC_BASE_LO__DC_BASE_LO_MASK                                                                   0xFFFF0000L
+//VCN_MES_MDBASE_LO
+#define VCN_MES_MDBASE_LO__BASE_LO__SHIFT                                                                     0x10
+#define VCN_MES_MDBASE_LO__BASE_LO_MASK                                                                       0xFFFF0000L
+//VCN_MES_DC_BASE_HI
+#define VCN_MES_DC_BASE_HI__DC_BASE_HI__SHIFT                                                                 0x0
+#define VCN_MES_DC_BASE_HI__DC_BASE_HI_MASK                                                                   0x0000FFFFL
+//VCN_MES_MDBASE_HI
+#define VCN_MES_MDBASE_HI__BASE_HI__SHIFT                                                                     0x0
+#define VCN_MES_MDBASE_HI__BASE_HI_MASK                                                                       0x0000FFFFL
+//VCN_MES_MIBOUND_LO
+#define VCN_MES_MIBOUND_LO__BOUND_LO__SHIFT                                                                   0x0
+#define VCN_MES_MIBOUND_LO__BOUND_LO_MASK                                                                     0xFFFFFFFFL
+//VCN_MES_MIBOUND_HI
+#define VCN_MES_MIBOUND_HI__BOUND_HI__SHIFT                                                                   0x0
+#define VCN_MES_MIBOUND_HI__BOUND_HI_MASK                                                                     0xFFFFFFFFL
+//VCN_MES_MDBOUND_LO
+#define VCN_MES_MDBOUND_LO__BOUND_LO__SHIFT                                                                   0x0
+#define VCN_MES_MDBOUND_LO__BOUND_LO_MASK                                                                     0xFFFFFFFFL
+//VCN_MES_MDBOUND_HI
+#define VCN_MES_MDBOUND_HI__BOUND_HI__SHIFT                                                                   0x0
+#define VCN_MES_MDBOUND_HI__BOUND_HI_MASK                                                                     0xFFFFFFFFL
 
 #endif
-- 
2.41.0

