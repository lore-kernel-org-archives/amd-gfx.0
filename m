Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE9EC48BC1
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 21:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAD0210E528;
	Wed, 14 Feb 2024 21:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XvOCbDmY";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 117E210E3CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 21:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcEAVKPzbglAOKRgNyuVvZ99nsCCWroIHOpy4YLxkk0zmvGz/NSq2F8Q5WMpUdUllbFJYfhbOL9S8nCUbhodiMi5FLMaUOPgK1QvBdt3RO6gwyOZtFQNatpPEtczyq2Jf7BNV5NwVvME+P7xUs/iKXm9169P20MOJ2dfZYIrpR77OBLqYW68ElLKJ+sonHxVZ/t5MgbkjMZ6p6g8u2ffDXsQdaUx7xGW0oBMWIgiF8RHp640JZxIVECax0m2ahZJkWy6vKNWwMJ/7uJGWZMDkxZqYLmkvCs/Kmwiug4aPUdiT/I66wkvhCwk8fb6IWUKM2jHVeF26xBdsibUKJzeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5zZYY0ysjuB/wYsEIs3FTv95dY26rsdtfqebem1LCU=;
 b=UrznmgFD3Iew6jAvxG1Mix/5ASyg47fqqUaeJXAztQjp6sE0MG+Xr7zA1wNxybQdVHad+oSVtx0okm3f5HdyI3IxucFAOJgW7aHRStS7eM5qIz3jIy+thlW7njEjre9TPO5V85dN3d9/ZNtH9W+U7ldIatFlCgJu4dZl7MLxfMPThhx/vx3Sh/4xBWkY6ApyH4uBzVfmTadTDWgRShjHY8XZIQvW/fRcxhPdBINLl/UE9LkzK/Q+8O1ibFPXJdM3GdacdShGXc4G79bSgy7dafclKLCo3noaFTiq8otjnUHbi5dIQQpP1o3KzqB1xvnEmwy6aPbrl58fDRQLjFipQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5zZYY0ysjuB/wYsEIs3FTv95dY26rsdtfqebem1LCU=;
 b=XvOCbDmYcsZcjR28sJOshibYpSm4skAr6m6ME3VqHnSkbXIziMd9qNvp6kwq38SmxLh9RSGr8iAk/BqfFdvy4OeoX/5cJed278l0m01ncc+rMeHx1W/jIzt1QSyJPbK/QiHVuMq6LlK6g+kgYHvSpaqdwtwuVlK46QLgSuXPT2Y=
Received: from MN2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:208:1b4::21)
 by BY5PR12MB5000.namprd12.prod.outlook.com (2603:10b6:a03:1d7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 21:32:06 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::da) by MN2PR15CA0008.outlook.office365.com
 (2603:10b6:208:1b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39 via Frontend
 Transport; Wed, 14 Feb 2024 21:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 21:32:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 15:32:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/nbio: Add NBIO 7.11.1 Support
Date: Wed, 14 Feb 2024 16:31:48 -0500
Message-ID: <20240214213149.2591914-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|BY5PR12MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: dcec7965-ca2e-4e02-cbff-08dc2da4641e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RqY/jvjACFYZgYaOkWskssnhN4XCccJDk3U0KZ/fl8SiyQu7rJ9ItU87u6IcawMmsJgFtGLKcpfEcifcT0kHC1cs4mOlqkh7MCh+ScmpcziKafZi29KNAlVTQtLxdQA0zBO4F11ydyamzrMAtsrAydQ63iOigX7tNBF3lZTtQ0U3oCPnulxHPffxtuVOqeigrVzhv6YVAqPjYlVJN0B0+q7Tkvw3ZXIPEcx6Cwt8kjfYpQarr6ZwMIggyU275QbWI1LuXeVwujZdicGoMRmmwJUMuporlgIHJurByx3KBjbpzgBC6qIsbKaKq8UIAmtG9R/FGnK98wEo9icBsqZ7qV1ot6OEDIBlVKNgpz0tJnt8yqAwTwtg5XBSeKAOE2rbDyAUqORsUBwNUmcCCca78qndhYqnyRRrKD+vimPWGhQLogdxzkexuNBGZAJ186wIfqm7DYpdajMQilsNHBoFQpapdEAjtUPhzs9hsVMujADiot5bYiHhdJXdYDtN2SNytWBSyfHdFHcmzON06G4VhSaS95kbc2GjlQhTbtAorcGc+SJ6D3htTKdVzctDu551nBqNuLZPu2MfE9Vp2m3ExVELsTjqg62cgpWUNVBg3qzhd/1DlHIa4fQRG4Pgz+1A0nUIcFABH9pwLvumo/RBUvfWHgRfn7EMYbGVusMIvDQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39850400004)(230922051799003)(64100799003)(451199024)(36860700004)(82310400011)(186009)(1800799012)(46966006)(40470700004)(2906002)(41300700001)(1076003)(478600001)(26005)(83380400001)(5660300002)(8936002)(6916009)(8676002)(70586007)(426003)(336012)(7696005)(36756003)(16526019)(70206006)(4326008)(2616005)(81166007)(316002)(54906003)(6666004)(356005)(82740400003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:32:05.6925 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcec7965-ca2e-4e02-cbff-08dc2da4641e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5000
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

From: Yifan Zhang <yifan1.zhang@amd.com>

Fix up doorbell setup and clockgating.

v2: squash in fixes (Alex)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Veerabadhran Gopalakrishnan <veerabadhran.gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c                  | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/soc21.c                       | 1 +
 .../drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h   | 2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
index 1f52b4b1db03..05020141c0ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_11.c
@@ -89,7 +89,9 @@ static void nbio_v7_11_vpe_doorbell_range(struct amdgpu_device *adev, int instan
 					  bool use_doorbell, int doorbell_index,
 					  int doorbell_size)
 {
-	u32 reg = SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_VPE_DOORBELL_RANGE);
+	u32 reg = instance == 0 ?
+		  SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_VPE_DOORBELL_RANGE) :
+		  SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_VPE1_DOORBELL_RANGE);
 	u32 doorbell_range = RREG32_PCIE_PORT(reg);
 
 	if (use_doorbell) {
@@ -112,7 +114,10 @@ static void nbio_v7_11_vcn_doorbell_range(struct amdgpu_device *adev,
 					  bool use_doorbell,
 					  int doorbell_index, int instance)
 {
-	u32 reg = SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_VCN0_DOORBELL_RANGE);
+	u32 reg = instance == 0 ?
+		SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_VCN0_DOORBELL_RANGE):
+		SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_VCN1_DOORBELL_RANGE);
+
 	u32 doorbell_range = RREG32_PCIE_PORT(reg);
 
 	if (use_doorbell) {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 917292df55a5..5f81c264e310 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -866,6 +866,7 @@ static int soc21_common_set_clockgating_state(void *handle,
 	case IP_VERSION(7, 7, 0):
 	case IP_VERSION(7, 7, 1):
 	case IP_VERSION(7, 11, 0):
+	case IP_VERSION(7, 11, 1):
 		adev->nbio.funcs->update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		adev->nbio.funcs->update_medium_grain_light_sleep(adev,
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
index 6f80bfa7e41a..5ebe4cb40f9d 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_11_0_offset.h
@@ -8900,6 +8900,8 @@
 #define regGDC0_BIF_IH_DOORBELL_RANGE_BASE_IDX                                                          3
 #define regGDC0_BIF_VCN0_DOORBELL_RANGE                                                                 0x4f0af3
 #define regGDC0_BIF_VCN0_DOORBELL_RANGE_BASE_IDX                                                        3
+#define regGDC0_BIF_VPE1_DOORBELL_RANGE                                                                 0x4f0af4
+#define regGDC0_BIF_VPE1_DOORBELL_RANGE_BASE_IDX                                                        3
 #define regGDC0_BIF_RLC_DOORBELL_RANGE                                                                  0x4f0af5
 #define regGDC0_BIF_RLC_DOORBELL_RANGE_BASE_IDX                                                         3
 #define regGDC0_BIF_SDMA2_DOORBELL_RANGE                                                                0x4f0af6
-- 
2.42.0

