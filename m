Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6689ECAAD4
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 08:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B90510EAA4;
	Tue, 30 Aug 2022 08:10:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D265E10EAA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 08:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVlD/C1iJhFNMbtxsHfh1AYJndA05hEtkgBTAhrGn2oIgOWC1C7S60cfcNPGwLnxllagplDUxZ+IiwkgB6g/S48MTDgtRDn4/rYWJglQVLhpyl/2T3ESZzB5jR8csUlyUMC+Jv3kB+vitWtkRXfsKik68yRZz+A+kAofN4/VZQYy4fTMYg5TMOLbdmgUT/y61WRbiEt7Ly3bQuZBHe7T6WYAL47egumix9Vtht9WAou6tTfjlEuk9rNi3xs/d11FX120Jn2ifYqRre4CUGCogHddjxT0QTM3mfSKaou4EgVJd4OUVuvR7h2YHB7LjDrTAvXFLa+Y0lqbp1z3B4YS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyamZNTD/DRUQtO/yZMMa/KgadUrzntEmxYfYxQjdxM=;
 b=cJ02rqG1DzBpHgyrRPIUn5a2CoK5pQFQj/P8UJvb5hzDUVL/t3clNXKmNT61qx/+GsffBJvPuBD6WvBK8rCc7MZi/1of1Gnrf9EyTB+e9dMmwsXFlrmQG2xwlvwDqBbJTc9kf44OZm36zd3uzS8psJmiWQe2hMwB9QV1kATwkiyYV+5CQx4iCdGAuvU1w0ftOYlp1kWNY3yF7OoTu0tkkd3AteI9bLuZwaNY5LFhxZbJ2FazgmMpyKRT2qyJL7FvSegCsSWy9cAaCojTynMRIJz3a44u7yFAS46EKbwLxhmpkO1Kky4ZU25IZYCwCcEjn2GezS+02W+sKkN/jB0y9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyamZNTD/DRUQtO/yZMMa/KgadUrzntEmxYfYxQjdxM=;
 b=PVLJgt8PLmKVGgYT1sGAUjS9HVY9WQryEkODS9bI0Rq534JSqYDpfeK5bsTSVHz/oENjl9+lSF/RN/xArTDkdQhec5OFOU50zfR9sQbRZzBHzVoEkPl4l9FZ0kBrwLelyOhJyWw4rprDO7yL2Fk376sgFb1xnx8/pEm9fEDJpMg=
Received: from MW4PR04CA0277.namprd04.prod.outlook.com (2603:10b6:303:89::12)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 08:10:31 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::e2) by MW4PR04CA0277.outlook.office365.com
 (2603:10b6:303:89::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16 via Frontend
 Transport; Tue, 30 Aug 2022 08:10:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Tue, 30 Aug 2022 08:10:30 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 30 Aug 2022 03:10:24 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Chengming Gui <Jack.Gui@amd.com>
Subject: [PATCH] drm/amdgpu: only init tap_delay ucode when it's included in
 ucode binary
Date: Tue, 30 Aug 2022 16:10:00 +0800
Message-ID: <20220830081000.9500-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eacfb7f1-14d2-4ad0-ceaf-08da8a5f1b29
X-MS-TrafficTypeDiagnostic: DM6PR12MB4044:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuUMKSflNocpGt0EuP0F7jLsQFac8j+xUqhTkzpqyVRaOThiqZBRg1B2IagDal8tkUQmdy6s5l+MIPxm9NkqEKhZl9bQWRhe5HSLGFTXt5cqiMnTvahrTbN2FfSxy5rPvw2rZJdklm3g9nhy0GHhz1D8YcuFwnZ8Iym+1jq5JimDm5PG1eXE1Pvn1HF7l3yD98425uShxzf6qEmyvGildju/gXt/DP0Wm/IdPt8/MbFKdHFDeT8/+8Jk6UHcTfWZNIJiC1Fgf0UWura9HFWBY7i4EOgI0IbMU9m9uIH7bzGSpellAVa4aVL5Ygn1YaxYM0WAZykapp62yuwQ/k3atZrYNSdX7xJC1YoN+5GeUQVPkvisOXrY4UDQGmtG4ywgcGdTIbbjASsQar+NaFuOkk7qk6sABaRitmZwmcTcrr7U3TNoGaiqdvyElfKsiHLECtuaS5n5flj2SxQ2IE4p92qO7vjzL1fc3WCRLV6vkLcM6wE6ceNE+ZQeYFu4fU3YnZv/jyT0HlrhkA516rgT5v1ksxtcWviXk5uHlweMCoYiRScrwGXOfhYgbGxv2faUboUI0AOIuJ9fhPHATBEuX+Ea6Rf1KXtFInrUjq/VKURlnJHM+xsZnt5xj27MoQUaOYMR6eqNkKnajktd5vqTqrafkBfQ5fb33TxykHguIM1gKBJy9ufBtTHXqfLEYHiqUBSSrvIw1SCTjAtvHU95F8d17sD18PhxgP47BnA4akOlxCa+rN0BqvZhJMC2ubq0chZ6piGv2qE0IuHD8rtHesdnlTXp+oQA8lHnt6KzdNOloAbZZMxjX64WwFXX1MEP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(356005)(81166007)(4326008)(70206006)(70586007)(8676002)(36756003)(36860700001)(86362001)(82740400003)(83380400001)(47076005)(336012)(426003)(16526019)(478600001)(26005)(7696005)(41300700001)(6666004)(1076003)(186003)(82310400005)(110136005)(316002)(40460700003)(40480700001)(2906002)(6636002)(2616005)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 08:10:30.6722 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eacfb7f1-14d2-4ad0-ceaf-08da8a5f1b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not all the gfx10 variants need to integrate
global tap_delay and per se tap_delay firmwares

Only init tap_delay ucode when it does include in
rlc ucode binary so driver doesn't send a null buffer
to psp for firmware loading

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 60 +++++++++++++++-----------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1a915edccb92..e4dde41f2f68 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4274,35 +4274,45 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 
 		}
 
-		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS];
-		info->ucode_id = AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS;
-		info->fw = adev->gfx.rlc_fw;
-		adev->firmware.fw_size +=
-			ALIGN(adev->gfx.rlc.global_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		if (adev->gfx.rlc.global_tap_delays_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS];
+			info->ucode_id = AMDGPU_UCODE_ID_GLOBAL_TAP_DELAYS;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(adev->gfx.rlc.global_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		}
 
-		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE0_TAP_DELAYS];
-		info->ucode_id = AMDGPU_UCODE_ID_SE0_TAP_DELAYS;
-		info->fw = adev->gfx.rlc_fw;
-		adev->firmware.fw_size +=
-			ALIGN(adev->gfx.rlc.se0_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		if (adev->gfx.rlc.se0_tap_delays_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE0_TAP_DELAYS];
+			info->ucode_id = AMDGPU_UCODE_ID_SE0_TAP_DELAYS;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(adev->gfx.rlc.se0_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		}
 
-		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE1_TAP_DELAYS];
-		info->ucode_id = AMDGPU_UCODE_ID_SE1_TAP_DELAYS;
-		info->fw = adev->gfx.rlc_fw;
-		adev->firmware.fw_size +=
-			ALIGN(adev->gfx.rlc.se1_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		if (adev->gfx.rlc.se1_tap_delays_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE1_TAP_DELAYS];
+			info->ucode_id = AMDGPU_UCODE_ID_SE1_TAP_DELAYS;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(adev->gfx.rlc.se1_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		}
 
-		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE2_TAP_DELAYS];
-		info->ucode_id = AMDGPU_UCODE_ID_SE2_TAP_DELAYS;
-		info->fw = adev->gfx.rlc_fw;
-		adev->firmware.fw_size +=
-			ALIGN(adev->gfx.rlc.se2_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		if (adev->gfx.rlc.se2_tap_delays_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE2_TAP_DELAYS];
+			info->ucode_id = AMDGPU_UCODE_ID_SE2_TAP_DELAYS;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(adev->gfx.rlc.se2_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		}
 
-		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE3_TAP_DELAYS];
-		info->ucode_id = AMDGPU_UCODE_ID_SE3_TAP_DELAYS;
-		info->fw = adev->gfx.rlc_fw;
-		adev->firmware.fw_size +=
-			ALIGN(adev->gfx.rlc.se3_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		if (adev->gfx.rlc.se3_tap_delays_ucode_size_bytes) {
+			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SE3_TAP_DELAYS];
+			info->ucode_id = AMDGPU_UCODE_ID_SE3_TAP_DELAYS;
+			info->fw = adev->gfx.rlc_fw;
+			adev->firmware.fw_size +=
+				ALIGN(adev->gfx.rlc.se3_tap_delays_ucode_size_bytes, PAGE_SIZE);
+		}
 
 		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_CP_MEC1];
 		info->ucode_id = AMDGPU_UCODE_ID_CP_MEC1;
-- 
2.34.1

