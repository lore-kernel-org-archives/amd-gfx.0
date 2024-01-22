Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74515C47DAF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 08:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A37F10EAF0;
	Mon, 22 Jan 2024 08:43:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA99B10EAF0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 08:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ftML6IKK00msSye6cSrteKPEpk7Oa5c8j8H4dzUbbTUvUim6UA/v8TPY7gm/C2I5dTFDGyhtFyC66tDAIItpUTR+WxoQwIlSWqEYO5v7KWPAaaUMAuMFeGsLZ8q5lFTeoAfkS6VABdhdw7etiNMYPzbWEWTHJ+Nz6AccJ0QyRDHUb3WIDqdTzaOtDr7NE97pgHdzlfK3yDvU09A+7umAGIb9CondYqqLZDbRkJNO66Nf6czL3OiiX7gUi2aiD9/xEpyse1+53VUz55Ys0c7VDBeSRrMyD0jW7yhQM1GVQwtBLe9Qi5QHNSj18v0GD+CkgUrPHfgwakGOfHMuFK27Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lTu/l3WuU3K+eE506COYTgx1S5aDgyIqEB8j1lHglg=;
 b=EuwuUipq/UzK3GZjYsrR6BMelhZibDuufdmpd0sDQc/jSumxKshzaCWfS8i1zbDBbzV6uJU+I7wWu3V0AOEf7+wt23WLdRlQ+J9V5jsg60p9neJH3Re476ZBbChOibIewA2V8nhsSp8Ga+sPnXhgfclpr/4+oStu7be7bnm6lykjnULwUiiLBwkm7TGGs9rNb0XjpTg1SOKIDpg0VvJ6tD/M8qH/OxqpHOqzGV3rx/W/ZmARepnaQx3O3dpXF/r+Wxp95ik7NoUFF6+tNdI6bIOvwcUa/fTyS6pJ23SFkxhZ2vTvEv4d5URhTmZbSkIP7iiqZTpXkSHLVtes9jXqvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lTu/l3WuU3K+eE506COYTgx1S5aDgyIqEB8j1lHglg=;
 b=u7zyw97sO/fXmv0sXXQj1w9/lvn7z64MiuNNEmtNb2bh3oVVQjRp27TD7cwmr2SGlxuSAyXXplx1qq3gJgmBXKVBFBLxv9slsfSeSyAsp8OAGTJuvtRR/O1QxZSAuDMcRxuqc1SyKkr75tIiF4WHvlIcghN0/juvyKuJ64s4Ufs=
Received: from BL1PR13CA0340.namprd13.prod.outlook.com (2603:10b6:208:2c6::15)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 08:43:22 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::40) by BL1PR13CA0340.outlook.office365.com
 (2603:10b6:208:2c6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.16 via Frontend
 Transport; Mon, 22 Jan 2024 08:43:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 08:43:22 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 02:43:20 -0600
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/pm: Use macro definitions in the smu IH
 process function
Date: Mon, 22 Jan 2024 16:42:40 +0800
Message-ID: <20240122084240.1053190-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122084240.1053190-1-Jun.Ma2@amd.com>
References: <20240122084240.1053190-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM6PR12MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a46b14b-06e8-41c3-6138-08dc1b2630c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUBWJup4ZQ5cQeILhQdC6qOJ8Ej+YQeRqg4yrqfFgIGHwQRg8MVNDnDScsxOLijxLd0dMw1MjpYq8S6VuDaaBC+TdVi3Kyu1+tFS8/o4k98BacBjlg8VWtZlo8izl53N3hG3jXVM0TlVmRk7OSjB0omlLP2u1qhlACd3KJfF0gU4gI0bbmQuouo5IVODPPvbh7G/AgZLbFYiSV5IauAIf5DjLVaUx/+GNPcqgh7XqqB2v0Shm3MVyLH03aPaOyDP3GAPiA70jvCd5CHkuOmEtPu4N+DYQ2c5nZM56IoHH4LP2YFUxda0fMSCrONqoKaDz0xcvXglMT7GvKQtp8IOqWu8AZNGQQtHQMisIojdn+POxf68VJ5Y0OIOI/2uFzO7VuyYraMcyx94y/hfkqgkIbBiFKQWLcYCKyFKdkZMlkhPt/YYN1MjktTdogL3N0iNeYPLJyQ2KbVp2/a8e83Fepo7WUW52/I1ekgDfpEoHHnGR0+o3BmIqpOW507WCqmnQlY3Yx46DjF/tJVGQjOKIrdny68OCMGvmzcmsxLjgj3Gbdn4C8jCo9U3Fbb+c+rVRp2KXsGxhO2687jYvUNQCQ19gzzkCEsECzwlmJ/ObhxbGzhIaBMEEeebHdQpPMBYgjSuzz9Sn5lQDqmfo1/jl/BGhavtc6yI1lE0Cg8P5BC++S6tJVjrQO5U0Y+hlQ9pWF5hUxkCeBflSo44L23f1KQ9hC668XXbh1oy1vWJZQCyF7SOSz6pUsP+mWULL8EE40oGmtV/nO3wg3MYV6SGxw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(6666004)(336012)(36860700001)(7696005)(426003)(26005)(1076003)(2616005)(16526019)(36756003)(356005)(86362001)(81166007)(82740400003)(41300700001)(8936002)(8676002)(4326008)(2906002)(47076005)(83380400001)(5660300002)(478600001)(70586007)(316002)(70206006)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 08:43:22.0117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a46b14b-06e8-41c3-6138-08dc1b2630c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>, lijo.lazar@amd.com,
 Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace the hard-coded numbers with macro definition

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 11 +----------
 .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h | 11 -----------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       |  5 +++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       | 10 ++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 10 +++++-----
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 14 +++++++-------
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  2 +-
 8 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index b114d14fc053..c6b7f904e742 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -1618,15 +1618,6 @@ typedef struct {
 #define TABLE_WIFIBAND                12
 #define TABLE_COUNT                   13
 
-//IH Interupt ID
-#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
-#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
-#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
-#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
-#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
-#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
-#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
+
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index 8b1496f8ce58..33937c1d984f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -1608,15 +1608,4 @@ typedef struct {
 #define TABLE_WIFIBAND                12
 #define TABLE_COUNT                   13
 
-//IH Interupt ID
-#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
-#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
-#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
-#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
-#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
-#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
-#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
-#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
-
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index a0e5ad0381d6..9fe26497e75e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -63,6 +63,11 @@
 #define LINK_WIDTH_MAX			6
 #define LINK_SPEED_MAX			3
 
+#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
+#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
+#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
+#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
+
 static const __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
 
 static const
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 46b972f36666..436705a18e99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -59,6 +59,16 @@ extern const int pmfw_decoded_link_width[7];
 #define DECODE_GEN_SPEED(gen_speed_idx)		(pmfw_decoded_link_speed[gen_speed_idx])
 #define DECODE_LANE_WIDTH(lane_width_idx)	(pmfw_decoded_link_width[lane_width_idx])
 
+#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
+#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
+#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
+#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
+#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
+#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
+#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
+#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
+#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
+
 struct smu_13_0_max_sustainable_clocks {
 	uint32_t display_clock;
 	uint32_t phy_clock;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 3f7463c1c1a9..c92ad3f533c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -44,6 +44,8 @@
 #define MAX_DPM_LEVELS 16
 #define MAX_PCIE_CONF 3
 
+#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
+
 struct smu_14_0_max_sustainable_clocks {
 	uint32_t display_clock;
 	uint32_t phy_clock;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index d74343adaa5f..232e9b1ea006 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -1432,24 +1432,24 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
 		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
 		orderly_poweroff(true);
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
-		if (src_id == 0xfe) {
+		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
 			/* ACK SMUToHost interrupt */
 			data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
 			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
 			WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
 
 			switch (ctxid) {
-			case 0x3:
+			case IH_INTERRUPT_CONTEXT_ID_AC:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
 				schedule_work(&smu->interrupt_work);
 				adev->pm.ac_power = true;
 				break;
-			case 0x4:
+			case IH_INTERRUPT_CONTEXT_ID_DC:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
 				schedule_work(&smu->interrupt_work);
 				adev->pm.ac_power = false;
 				break;
-			case 0x7:
+			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
 				/*
 				 * Increment the throttle interrupt counter
 				 */
@@ -1508,7 +1508,7 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
 		return ret;
 
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				0xfe,
+				IH_INTERRUPT_ID_TO_DRIVER,
 				irq_src);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index fc7c04e19b18..c8fc7eccab06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1368,24 +1368,24 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
 		orderly_poweroff(true);
 	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
-		if (src_id == 0xfe) {
+		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
 			/* ACK SMUToHost interrupt */
 			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
 			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
 			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
 
 			switch (ctxid) {
-			case 0x3:
+			case IH_INTERRUPT_CONTEXT_ID_AC:
 				dev_dbg(adev->dev, "Switched to AC mode!\n");
 				smu_v13_0_ack_ac_dc_interrupt(smu);
 				adev->pm.ac_power = true;
 				break;
-			case 0x4:
+			case IH_INTERRUPT_CONTEXT_ID_DC:
 				dev_dbg(adev->dev, "Switched to DC mode!\n");
 				smu_v13_0_ack_ac_dc_interrupt(smu);
 				adev->pm.ac_power = false;
 				break;
-			case 0x7:
+			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
 				/*
 				 * Increment the throttle interrupt counter
 				 */
@@ -1398,7 +1398,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 					schedule_work(&smu->throttling_logging_work);
 
 				break;
-			case 0x8:
+			case IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
 				high = smu->thermal_range.software_shutdown_temp +
 					smu->thermal_range.software_shutdown_temp_offset;
 				high = min_t(typeof(high),
@@ -1415,7 +1415,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
 				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
 				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
 				break;
-			case 0x9:
+			case IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
 				high = min_t(typeof(high),
 					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
 					     smu->thermal_range.software_shutdown_temp);
@@ -1476,7 +1476,7 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
 		return ret;
 
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				0xfe,
+				IH_INTERRUPT_ID_TO_DRIVER,
 				irq_src);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 4894f7ee737b..9a8b7fd6995d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -892,7 +892,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu)
 	// TODO: THM related
 
 	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
-				0xfe,
+				IH_INTERRUPT_ID_TO_DRIVER,
 				irq_src);
 	if (ret)
 		return ret;
-- 
2.34.1

