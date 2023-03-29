Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72670C6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:26:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC3C10EC5F;
	Wed, 29 Mar 2023 20:26:21 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 085CF10EC5C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:26:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEecNMkAlFH4LE9kcOMCHnk8+r+3WK9vuwTM20g5yP4rPrlDhBBvV5RIsvAstXIzGZylNaFEBpnwfihEbLyFEO4M2rYOG6BMJon0oV4vc7Rpbh7STqLux4n720lZGcXMVdPINa3swvXort/ECRC3tGxyHwEVk4kWITgHSksAtn3cYLNB9IVVDeCG2a0q/nZk1Yf9GMVZRGdQdy1zRIgqFupy7EjS/mC02Sc7qqrV+GLZDgt+fdA3LxIu7mOWea80o0GsvI0vFmkpFOkaL9QEM9BMMES7t8/RsiKNdLCCWV1P348WDxzAVdZf8SY4i0RLwP7y2SC2BRlzZE58vQ/EaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7ddGNR0R+scD4sV0Y7OWnmav1I8J9fWecQALhAqc88=;
 b=NwaNAwdKorUdFnM9hY8izM9FrB5oxZDwGOaLaCzDzI8TdNqsI6XFTpySY8jBbvco/M8dh0oR/h7ChB8TsDugZAumdC6sCgB95VJCFaWOhlmnFAe1qwdFhaK2nra2D+Sm3ku0mLUSwzTWrYn4JYHh5RPc3R9w28egc19hRVJazvHWuUMzGZ/KRxyXhs0plHwPrNTjJJdu/Sr/4SexIR2khgNcPmQ/faAZlVzGznaF+Yq9Jw1jEAN0qc6IvlSfOJ8p+Qmzr3PqMxXk9jdlP7x9XWHbD/y1aGLUL+j2yyN8y/zU3w5kWokj8hAObYUz+pT5Qyf9v3zex7Z/0HmrvhsY9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7ddGNR0R+scD4sV0Y7OWnmav1I8J9fWecQALhAqc88=;
 b=fXPa39CST+tue1HZW8TN+W83XM09LO1DC1LIqyE9Tc/7S1GQNQATlankPI5h0Uz9rjO4m5jVyhxKdPpv0BWB77Qrx51pEtq9FyigKhAkQn1JKYrlf7l6ZmFo4dVH0A3FAnQLyoSXrZaqrFNHSVT6QRFb3PBVyYPe/+iaS8TQsdo=
Received: from DS7PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:3bb::26)
 by MW5PR12MB5598.namprd12.prod.outlook.com (2603:10b6:303:193::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:26:06 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::14) by DS7PR03CA0081.outlook.office365.com
 (2603:10b6:5:3bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:26:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:26:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amdgpu: consolidate the access helpers in nbio v7_9
Date: Wed, 29 Mar 2023 16:25:43 -0400
Message-ID: <20230329202548.1983334-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329202548.1983334-1-alexander.deucher@amd.com>
References: <20230329202548.1983334-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|MW5PR12MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf76c53-9b3e-485c-e33e-08db3093d32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jm2F3lU/+c3Du9bVCAZGx0WztOy63z66FYhjW4uicts19zbIdWfp96wfFRtnmY+J9N/ZJZPYptrdjMnU3ZuxdZSwYPHxGxnWAwqoU286Rt3uEzW9tBpKvlv5Bl7b9w4l6C/qRq6skO0hGrW3rdtVPuLK9N02B6KjF3I0qSrzxjAY/kuf/xXdu14llxOZoUzfVmgzlb//dEMcOpOzKaVnTNVgmkoBa6y3gGgdknP4i4FUFkRHOLOluwI7HccQIYyweZUQFoQP2q0ELT+ySUo2qYU9o11nsTfSCGSaDjCheNctEuLWoCRN+qTOiWQF3L4jwSkLgFJuA6T/KzBy05poN7coSiMMEZrd58QQiK1ovX4SmxWOGrXkN1+8uTlSAwMA7F2JinWREfu5EJ8amIa6/EZgvG61Dt+20taSzCHCNXHos/rNdpm60Oqy9mLbETXBScCOxqeqq750WYo0LX3HIY+6IdIAdTMauuxKGaZRlVEARGAxjVAPb+kGJoGiEA9lJYTIwtG1Y+ErE8aXCpTirSX7O1T10QI9RkBMUcWLOsAkUSQ6XdN8lTU8ZHbwxBuJygUgZB4ihrflNGnwO4MEenE9N3QH4dSc5DZqD1FUs4SnIUgc/F45VPayhKgVWezsQbAu4s/WuoFQrqyyR8aeKg/vd8gDHMu3hMgRXISkvwvDRd/VrRJbXEye9uHfsSQa0nEUIrY2HgRXW2O1VSutS4l0cbjuiBHvTaTttSfUJOTQI6vrRvEF4F+7XKcthKtZi5DFyHhG6vgRJ+TitJzQfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(16526019)(5660300002)(186003)(426003)(336012)(8676002)(40460700003)(8936002)(41300700001)(2616005)(70586007)(70206006)(4326008)(82740400003)(6916009)(6666004)(7696005)(81166007)(356005)(36860700001)(82310400005)(86362001)(316002)(47076005)(83380400001)(1076003)(26005)(2906002)(36756003)(478600001)(54906003)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:26:06.3536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf76c53-9b3e-485c-e33e-08db3093d32c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5598
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
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

Use WREG32_SOC15_EXT to write registers with address larger than 32bit.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 45 +++++++-------------------
 1 file changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index 301d26da3716..a3220dc9a59e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -62,15 +62,6 @@ static u32 nbio_v7_9_get_memsize(struct amdgpu_device *adev)
 	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
 }
 
-#define S2A_DOORBELL_REG_LSD_OFFSET	0x40
-
-/* Temporarily add 2 macros below. Range is 0 ~ 3 as total AID number is 4.
- * They will be obsoleted after the latest ip offset header
- * is imported in driver in near future.
- */
-#define AMDGPU_SMN_TARGET_AID(x)	((u64)(x) << 32)
-#define AMDGPU_SMN_CROSS_AID		(1ULL << 34)
-
 static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instance,
 			bool use_doorbell, int doorbell_index, int doorbell_size)
 {
@@ -111,11 +102,8 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					S2A_DOORBELL_ENTRY_1_CTRL,
 					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
 					0x1);
-		WREG32_PCIE_EXT((SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_1_CTRL)
-			+ S2A_DOORBELL_REG_LSD_OFFSET) * 4
-			+ AMDGPU_SMN_TARGET_AID(aid_id)
-			+ AMDGPU_SMN_CROSS_AID * !!aid_id,
-			doorbell_ctrl);
+		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_1_CTRL,
+			aid_id, doorbell_ctrl);
 		break;
 	case 1:
 		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_2,
@@ -131,11 +119,8 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					S2A_DOORBELL_ENTRY_1_CTRL,
 					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
 					0x2);
-		WREG32_PCIE_EXT((SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_2_CTRL)
-			+ S2A_DOORBELL_REG_LSD_OFFSET) * 4
-			+ AMDGPU_SMN_TARGET_AID(aid_id)
-			+ AMDGPU_SMN_CROSS_AID * !!aid_id,
-			doorbell_ctrl);
+		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_2_CTRL,
+			aid_id, doorbell_ctrl);
 		break;
 	case 2:
 		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_3,
@@ -151,10 +136,8 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					S2A_DOORBELL_ENTRY_1_CTRL,
 					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
 					0x8);
-		WREG32_PCIE_EXT(SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_5_CTRL) * 4
-			+ AMDGPU_SMN_TARGET_AID(aid_id)
-			+ AMDGPU_SMN_CROSS_AID * !!aid_id,
-			doorbell_ctrl);
+		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_5_CTRL,
+			aid_id, doorbell_ctrl);
 		break;
 	case 3:
 		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_4,
@@ -170,10 +153,8 @@ static void nbio_v7_9_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					S2A_DOORBELL_ENTRY_1_CTRL,
 					S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
 					0x9);
-		WREG32_PCIE_EXT(SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_6_CTRL) * 4
-			+ AMDGPU_SMN_TARGET_AID(aid_id)
-			+ AMDGPU_SMN_CROSS_AID * !!aid_id,
-			doorbell_ctrl);
+		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_6_CTRL,
+			aid_id, doorbell_ctrl);
 		break;
 	default:
 		break;
@@ -221,10 +202,8 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 
 		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17,
 					aid_id, doorbell_range);
-		WREG32_PCIE_EXT(SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL) * 4
-				+ AMDGPU_SMN_TARGET_AID(aid_id)
-				+ AMDGPU_SMN_CROSS_AID * !!aid_id,
-				doorbell_ctrl);
+		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_4_CTRL,
+				aid_id, doorbell_ctrl);
 	} else {
 		doorbell_range = REG_SET_FIELD(doorbell_range,
 				DOORBELL0_CTRL_ENTRY_0,
@@ -235,8 +214,8 @@ static void nbio_v7_9_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 
 		WREG32_SOC15_OFFSET(NBIO, 0, regDOORBELL0_CTRL_ENTRY_17,
 					aid_id, doorbell_range);
-		WREG32(SOC15_REG_OFFSET(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL),
-						doorbell_ctrl);
+		WREG32_SOC15_EXT(NBIO, aid_id, regS2A_DOORBELL_ENTRY_4_CTRL,
+				aid_id, doorbell_ctrl);
 	}
 }
 
-- 
2.39.2

