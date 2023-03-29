Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27BCC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FCBB10EC0B;
	Wed, 29 Mar 2023 20:10:00 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::610])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FADB10EC36
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:09:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT++Iqo4aYeJdrVqS1cEm4kUPwOhXKQ6NDnurgzcNOBBvQFZr/JgPiMHutsVpw+6QLFycuY+bJboEP4AyMRT0Ou92lc4bmjL9vCpO9mYz6Y+NbfwbXvJRA2y+GtfDb4DeFbkVUCKQrFMKy7eNtSELI1iTQhuDuD07YHTLZV6RuBIa0Zk9nGSdSwFrE+aGmrGV6kn+ynYHkulqz+6zOUHec6t8lowoR8VZSlh28Ut4vQvhrOWQ5MBrv3kQ5v7DgLEbap9uTubu/8c73pv7i8HXNumdqRhTjNBDgxsSPA4BsRMdjXDXA41zb1BTeSqmye1WCiLFts4q8HBH59Xz6nxYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMx5mqoZvNLqySX1+wCJtetUXsGL1QAoLkgtqPhj/H8=;
 b=Q71AsFo6O3+7FNEdEFANZDpxsLsUuR8pIF7sTw8HR306Vkd/Xi1kinLgwMO39LqsjU6jWbyt24znfU6G6fCeU6e/vWt8RRDtbshYx/S63XKsot5R5u0m7zuHftE7EWQ3DosimGFY9LFpHIKJ54PCsotNhrc7ej/Z3jl3cvd/WJI5zJ4lvAHA/mBjCaYeH89TiWGovr3uQceYeOh/DK+dHjV9flL6RF7XhYfqBhugdUnw0/jb3XqF6ITJeySTTkjlQ2svKgGakLpxcBn7GRmr5/SUmf7j+RMlIJa5gVYtxPj3tldyO2A0F0rRVT+m9Z8sgwf9n9ueIQE/p5Helf3r/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMx5mqoZvNLqySX1+wCJtetUXsGL1QAoLkgtqPhj/H8=;
 b=i/OEBFdzLd64FdyNGcAtCRHOpkMgEnt0arCQ0YyxN55F1S0PxIbOHAEitjRXHQPKuTi2rOiPnQUXNpvw53NKaFZKFqW0sAcYcwxTf6984byOajlx6NJynLuI2NRsvy8cqyOZgSaYvL+PFyqftcrAiyz+MxWaePEcX16G3ygKsik=
Received: from DS7PR06CA0017.namprd06.prod.outlook.com (2603:10b6:8:2a::24) by
 CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.27; Wed, 29 Mar 2023 20:09:54 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::7d) by DS7PR06CA0017.outlook.office365.com
 (2603:10b6:8:2a::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:52 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amdgpu: configure the doorbell settings for sdma on
 non-AID0
Date: Wed, 29 Mar 2023 16:09:22 -0400
Message-ID: <20230329200930.1982035-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd06953-2374-43ff-1315-08db30918fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dizQ9ZtDRbu1HNl+0MM4vP0CeCH1kUVXyncgbsUKgdiZ6mPOJeQkcf/0bxeM4gaFvevqoxQytKmjVQOC7vCGn3VMAeCFqWU7+32VCuS4rAA8YSzntkqvJzxQKO65QOlAwP0xVxFIX0eN1IIBL1wt3HHHp/gDW2us4bWZBCsnLD0xgBU7Z8n8n6ClvLZEKV7HYRtYRFlwIpJ5yfJFNVHr33g/a44tHlTEgkZfa4eazLioeQd/AFPpLO5FOgo1yFwIBaJ11qqddNUL9pGHARqCHb11NGxZi1//jAMumCnkOFq0wi/QLprUKgfTFlCLWC2dQHLiCg3mbzYWe2rVQzipPyASbtwTtgtSOLLTVdlhuI3KPPIxJyrVzUlO+p9xaD4rElOVUvYf8nuFS5KTZ2pJSIEzb84VJQZzrwDcbr2izfmBARsg4FpCwTmMZmC0aWmR1/UVnG/j9fYmjg0XgXA06VpKA1Gow1aQAfKPDK+lXUhx0iS+kHCoR9ijXO4o+EKTZeXZ8/rsAkAcQ03WWOh2tZqlirEAptYcHFGM5mEHfxOdFN9Yrr+XrMlNvgC7MkGef7jaZ9567QKxzVmcQ/ei6KzzDdg2nJT53ENfrByhIUjYj87p+X5CVcCL8SRDJs7ekkblzvBmj8ZkbC3lk7Be8t9wjiFduuni4YKDCjTVDHiQVYzyXw+dIXamqHz7wSxnaWFKn08uevSSwYSJcCKja31r5maJniTKfvX8R8dhh5zsvGw+2Y9Sh6omHzHwNKwDP85kLEjJB3PAsmCe9d1JsA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(36840700001)(40470700004)(46966006)(26005)(47076005)(426003)(186003)(1076003)(336012)(16526019)(2616005)(316002)(70586007)(41300700001)(6916009)(8676002)(7696005)(70206006)(6666004)(83380400001)(36860700001)(86362001)(5660300002)(356005)(82740400003)(2906002)(81166007)(54906003)(8936002)(4326008)(478600001)(40460700003)(82310400005)(36756003)(40480700001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:54.1151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd06953-2374-43ff-1315-08db30918fad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Configure the sdma doorbell settings on NBIF0 and SYSHUB of each AID

v2: fetch aid_id from amdgpu_sdma_instance (Lijo)

Signed-off-by: Le Ma <le.ma@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 65 ++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index cd576b767912..9353f04c5dd9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -62,10 +62,23 @@ static u32 nbio_v7_9_get_memsize(struct amdgpu_device *adev)
 	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
 }
 
+#define S2A_DOORBELL_REG_LSD_OFFSET	0x40
+
+/* Temporarily add 2 macros below. Range is 0 ~ 3 as total AID number is 4.
+ * They will be obsoleted after the latest ip offset header
+ * is imported in driver in near future.
+ */
+#define AMDGPU_SMN_TARGET_AID(x)	((u64)(x) << 32)
+#define AMDGPU_SMN_CROSS_AID		(1ULL << 34)
+
 static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instance,
 			bool use_doorbell, int doorbell_index, int doorbell_size)
 {
 	u32 doorbell_range = 0, doorbell_ctrl = 0;
+	int aid_id = adev->sdma.instance[instance].aid_id;
+
+	if (use_doorbell == false)
+		return;
 
 	doorbell_range =
 		REG_SET_FIELD(doorbell_range, DOORBELL0_CTRL_ENTRY_0,
@@ -80,9 +93,10 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 		REG_SET_FIELD(doorbell_ctrl, S2A_DOORBELL_ENTRY_1_CTRL,
 			S2A_DOORBELL_PORT1_RANGE_SIZE, doorbell_size);
 
-	switch (instance) {
+	switch (instance % adev->sdma.num_inst_per_aid) {
 	case 0:
-		WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_1, doorbell_range);
+		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_1) +
+			4 * aid_id, doorbell_range);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 					S2A_DOORBELL_ENTRY_1_CTRL,
@@ -94,10 +108,15 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					S2A_DOORBELL_ENTRY_1_CTRL,
 					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
 					0x1);
-		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_1_CTRL, doorbell_ctrl);
+		WREG32_PCIE_EXT((SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_1_CTRL)
+			+ S2A_DOORBELL_REG_LSD_OFFSET) * 4
+			+ AMDGPU_SMN_TARGET_AID(aid_id)
+			+ AMDGPU_SMN_CROSS_AID * !!aid_id,
+			doorbell_ctrl);
 		break;
 	case 1:
-		WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_2, doorbell_range);
+		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_2) +
+			4 * aid_id, doorbell_range);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 					S2A_DOORBELL_ENTRY_1_CTRL,
@@ -109,10 +128,15 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					S2A_DOORBELL_ENTRY_1_CTRL,
 					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
 					0x2);
-		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_2_CTRL, doorbell_ctrl);
+		WREG32_PCIE_EXT((SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_2_CTRL)
+			+ S2A_DOORBELL_REG_LSD_OFFSET) * 4
+			+ AMDGPU_SMN_TARGET_AID(aid_id)
+			+ AMDGPU_SMN_CROSS_AID * !!aid_id,
+			doorbell_ctrl);
 		break;
 	case 2:
-		WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_3, doorbell_range);
+		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_3) +
+			4 * aid_id, doorbell_range);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 					S2A_DOORBELL_ENTRY_1_CTRL,
@@ -124,10 +148,22 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					S2A_DOORBELL_ENTRY_1_CTRL,
 					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
 					0x8);
-		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_5_CTRL, doorbell_ctrl);
+		if (aid_id != 0)
+			WREG32_PCIE_EXT((SOC15_REG_OFFSET(NBIO, 0,
+				regS2A_DOORBELL_ENTRY_3_CTRL)
+				+ S2A_DOORBELL_REG_LSD_OFFSET) * 4
+				+ AMDGPU_SMN_TARGET_AID(aid_id)
+				+ AMDGPU_SMN_CROSS_AID * !!aid_id,
+				doorbell_ctrl);
+		else
+			WREG32(SOC15_REG_OFFSET(NBIO, 0,
+				regS2A_DOORBELL_ENTRY_5_CTRL)
+				+ S2A_DOORBELL_REG_LSD_OFFSET,
+				doorbell_ctrl);
 		break;
 	case 3:
-		WREG32_SOC15(NBIO, 0, regDOORBELL0_CTRL_ENTRY_4, doorbell_range);
+		WREG32(SOC15_REG_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_4) +
+			4 * aid_id, doorbell_range);
 
 		doorbell_ctrl = REG_SET_FIELD(doorbell_ctrl,
 					S2A_DOORBELL_ENTRY_1_CTRL,
@@ -139,7 +175,18 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					S2A_DOORBELL_ENTRY_1_CTRL,
 					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
 					0x9);
-		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_6_CTRL, doorbell_ctrl);
+		if (aid_id != 0)
+			WREG32_PCIE_EXT((SOC15_REG_OFFSET(NBIO, 0,
+				regS2A_DOORBELL_ENTRY_4_CTRL)
+				+ S2A_DOORBELL_REG_LSD_OFFSET) * 4
+				+ AMDGPU_SMN_TARGET_AID(aid_id)
+				+ AMDGPU_SMN_CROSS_AID * !!aid_id,
+				doorbell_ctrl);
+		else
+			WREG32(SOC15_REG_OFFSET(NBIO, 0,
+				regS2A_DOORBELL_ENTRY_6_CTRL)
+				+ S2A_DOORBELL_REG_LSD_OFFSET,
+				doorbell_ctrl);
 		break;
 	default:
 		break;
-- 
2.39.2

