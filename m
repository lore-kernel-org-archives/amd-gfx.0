Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB05FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 00:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6FC10E732;
	Fri,  4 Nov 2022 00:32:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B6F910E732
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 00:32:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksh4FCw34dZ9x0Mwi+qILSuKbVIgjhZHJHBebqvp2MTDnVZxyQhKGfwiKft67yVBbfzdhch3zHnheGrOjpwyGDwYnOqvpuCntnl3+8ITfTWgTsE8g/fbC9YINjwAIt+oitCT0BjABxxw3LgLDd8b3U55c3guUCWsS0G037v3HpeLezhxtKhzU3bKupaKQyWBhLU7kZXeabdNUprlcJ2B3JcIf/bQz99w2CWV2RHFt1/ERdw/oQc0kNJ3gFBaA2ghHEhd2I7W3/VF9Wyks4TUq4+545JdF5VtfGJw7pA8kEvQsVRtlo+PeNLWX9z5IgQfu+CsP5R2ev1NX/JUkO4f1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnccavg7ylQKHG6Er4TxAIxjCKTkdrnNE/EqMjgDErg=;
 b=dlR0VdM7wfliiDiFjMcbwWVkBFj/ZVJfr8yOMQX8y+KJXFE0qH6ZZlK18q0nK6OfXvvEe21+DUKXaI/YznHbumHF1OWCqM3YabVhZeSnT7uarS+C4/uOcOanUyPumpQvXsZfV5mpO8l4bavYJZRyxTZC9aXRcMlhpszLM6oku1bwLJ//tKyK/4AM/cA+BjBlpDl3x04TLI6p/HQNxf/jA3lGBbiF7BCz5f/6W/Ta7T/bLC5Dz8/Q8mY7u3zM6VdwFNuQis6G+6p7ADCr4KuSE5IljYnVW9p4fEq/UhF39pYHkZlmk4Vfe1QPdaeHiuAuCmsQCBT3qwG2yqemq1aeeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnccavg7ylQKHG6Er4TxAIxjCKTkdrnNE/EqMjgDErg=;
 b=WDFUWoCWOqO443B44HkAQ0W9g/gTlsBQ8n1FwpgC3l8ak+G1fvcWYw4agGtGWTsnutLdHoooQ0iWpBEUSPrxAduy/ZX1hm0IoYzcwBleFcOY1WfTj1AXa1uyvJA09pzyCSAKHlHl1cwGDaTPgbOqTDjSmm5F15wEFMV/YaqzWIY=
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by MW4PR12MB7238.namprd12.prod.outlook.com (2603:10b6:303:229::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 00:32:20 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::d8) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Fri, 4 Nov 2022 00:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Fri, 4 Nov 2022 00:32:19 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 19:32:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 19:32:18 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Thu, 3 Nov 2022 19:32:18 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Enable gfx pipe1 and fix related issues
Date: Fri, 4 Nov 2022 08:32:15 +0800
Message-ID: <20221104003215.296666-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|MW4PR12MB7238:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b65b295-e469-44f5-7de1-08dabdfc08a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZRyGib0jsjErbV2kDn+3naSCpe/wbGI62Z5Q7sAHZEHFqTDjKsCEa7zKn40oZwFF/FjKr7DKbWIJKyWOxZg+2ol98Ftz3Kse1CgAZcP0HyojVb3XMGAWb4bgVFEJ/9izOVWC4z2H9axGr0X7aIIUqZ1+oEKvXF7ImTnFgVJkP2a8h9Uqnnk5G4x6ha4GbsU4ICC63EYyQDiskmS0Y+rr67P+/SJ1ziPMa72YYBQ18UWrluXINPBbyEe7r30r74HC1YSk74+vt/zoCmdIsgRn6SDctVrhO7btmqks3JgxK7ulcpicfEPP0dEDwzhODmF5A6oLFKPig68+tNt0tgcoxTo0EO+Rl4/0tzLbrpcmDlI68YBMXVvekoACvJiM6cYcId3wMXsXLpygUvn5k44VlLeRrzuZE1tPYCY3bwub/8pJlV3T8YORwKzCqjFvYHAxBqapddmUPDK1nWt0qZWoda4MAhcLHT9XsjJeYzaVCwulHMpHYoAMd6i0T3Zan8KViRIvxDDBVsFTOKbBj1i5ekWnbMg8WdOaiaayCA6VRHRrt1h+yx72z/FHhtzcUnl88EmegMU0dUAM2LsFYQRE431jwlmQgq7/S/u1rkcMEDllwrJmA4TxXBV1jzTW8sXL3qk7iIkIGJz2JXqPkymJOhSUVJbGhml7CWiyPl75oTjxXYGz0Tj7PEgs2T+br0c8YvcnwRq0oIiUEH2LL8h+i3z4mnPQ8Wca1sVU1BpLbBlXDwAlHwyoST176XhEROveoXD9XwFQon6OsmkZS3nbMaGMwSiSK7t0c4yWp6fk6PE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(83380400001)(2906002)(47076005)(426003)(36860700001)(86362001)(40460700003)(40480700001)(36756003)(8676002)(26005)(4326008)(70586007)(70206006)(41300700001)(81166007)(356005)(82310400005)(6666004)(316002)(82740400003)(5660300002)(8936002)(336012)(186003)(1076003)(7696005)(6916009)(478600001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 00:32:19.9255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b65b295-e469-44f5-7de1-08dabdfc08a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7238
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Starting from SIENNA CICHLID asic supports two gfx pipes, enabling
two graphics queues for performance concern.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 43 +++++++++++++------------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 331aa191910c..0072f36b44d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -33,7 +33,7 @@
 	container_of((e), struct amdgpu_ctx_entity, entity)
 
 const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
-	[AMDGPU_HW_IP_GFX]	=	1,
+	[AMDGPU_HW_IP_GFX]	=	2,
 	[AMDGPU_HW_IP_COMPUTE]	=	4,
 	[AMDGPU_HW_IP_DMA]	=	2,
 	[AMDGPU_HW_IP_UVD]	=	1,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 49d34c7bbf20..9219cd29acd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4606,7 +4606,7 @@ static int gfx_v10_0_sw_init(void *handle)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 7):
 		adev->gfx.me.num_me = 1;
-		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 1;
 		adev->gfx.mec.num_mec = 2;
 		adev->gfx.mec.num_pipe_per_mec = 4;
@@ -6008,6 +6008,25 @@ static int gfx_v10_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int gfx_v10_0_wait_for_idle(void *handle)
+{
+	unsigned i;
+	u32 tmp;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		/* read MC_STATUS */
+		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS) &
+			GRBM_STATUS__GUI_ACTIVE_MASK;
+
+		if (!REG_GET_FIELD(tmp, GRBM_STATUS, GUI_ACTIVE))
+			return 0;
+		udelay(1);
+	}
+	printk("Emily:gfx_v10_0_wait_for_idle\n");
+	return -ETIMEDOUT;
+}
+
 static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
@@ -6069,7 +6088,7 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	amdgpu_ring_write(ring, 0x8000);
 
 	amdgpu_ring_commit(ring);
-
+	gfx_v10_0_wait_for_idle(adev);
 	/* submit cs packet to copy state 0 to next available state */
 	if (adev->gfx.num_gfx_rings > 1) {
 		/* maximum supported gfx ring is 2 */
@@ -7404,24 +7423,6 @@ static bool gfx_v10_0_is_idle(void *handle)
 		return true;
 }
 
-static int gfx_v10_0_wait_for_idle(void *handle)
-{
-	unsigned i;
-	u32 tmp;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-
-	for (i = 0; i < adev->usec_timeout; i++) {
-		/* read MC_STATUS */
-		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS) &
-			GRBM_STATUS__GUI_ACTIVE_MASK;
-
-		if (!REG_GET_FIELD(tmp, GRBM_STATUS, GUI_ACTIVE))
-			return 0;
-		udelay(1);
-	}
-	return -ETIMEDOUT;
-}
-
 static int gfx_v10_0_soft_reset(void *handle)
 {
 	u32 grbm_soft_reset = 0;
@@ -8466,7 +8467,7 @@ static void gfx_v10_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 		}
 		reg_mem_engine = 0;
 	} else {
-		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0;
+		ref_and_mask = nbio_hf_reg->ref_and_mask_cp0 << ring->pipe;
 		reg_mem_engine = 1; /* pfp */
 	}
 
-- 
2.36.1

