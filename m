Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A19C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 17:30:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91DAB10E209;
	Tue,  2 Jan 2024 17:30:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75A610E235
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 17:30:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBRVt/p4iBJDrPdt0kdH6rYdpvavKHLQaazNjPsO6DoE12unreU9c2S/J5s+wXLHr6Qm0uHaM6R/kN2Zd/GNFC2Vb6YdVQSM11UHAJbwvwMP7gz7tXEzyXBgtnPg3Hk6YN5o0XQaoTU1ej55vTpKahkZIihTSScOy1HYA25j8RfCZy+i4YaIVWvnZJ9dAFST447hAOslYd/0VXtt9QA5zVW6u0NvLVKOGKDAcN6uIqQsGwiU2N4Noy+I4CWgpzaE5LKCdJoDJXo9bYWM9O1eWnzKXirBVjNNiNrQRbJqlvCa/XYRJD60D/JWwiwLM4k3nfDh744An5BSsjkK3K4xgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn6myp8MiR89bR1gl5377/BTA1jilAEA7d6J5FE7Ykk=;
 b=SnjO8bw65ca83C2svF69BnP6TOKBnLQXlkHZrDJDh31CNiNZYaefclRxwBzXqGGCDkiMWtBzh/M8kiGY6c3xL6ULmlrE8rtNj8c1pkAzgxfYO2aPSDMoqrIvB92hPnPLd+mFM11qg5iWbvoglOGheGtL6TL5mZLOexJGMbkkk131NzJzboDCZCVmGTL6TNRKvxNDh1Z3YiulbEgvtZ5d40ESPZvi8AbqfyviEKDeuC7XvXYm71R2k1za9UZnf8nW2UQLB/LwjWPqWhiz1P8FWMfZQzNmUGUAYSVOazfgVZziWP3Bq1l2iTnJoc5uSdkyCq7/UgHFbPSZNSTIgiXHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn6myp8MiR89bR1gl5377/BTA1jilAEA7d6J5FE7Ykk=;
 b=uZvtTh8RTnPYN1MVgztsBB97JWrForpqAhuS+NDnNYaTGOchECJPM03syB85Fbkr86pw3XkPy2J9kVkGu5geUn+PpHfYJCjha2Al8Ctg8cH2cVzmLLEp/hSVKfzXEF+k+/9cQoSVAtIDrg4qLDV5KJQTEO9w1UL1x4M9o/vqZYs=
Received: from DM6PR02CA0080.namprd02.prod.outlook.com (2603:10b6:5:1f4::21)
 by DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 17:30:26 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::28) by DM6PR02CA0080.outlook.office365.com
 (2603:10b6:5:1f4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24 via Frontend
 Transport; Tue, 2 Jan 2024 17:30:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 17:30:26 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 11:30:25 -0600
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Improve error checking in
 amdgpu_virt_rlcg_reg_rw
Date: Tue, 2 Jan 2024 12:30:10 -0500
Message-ID: <20240102173013.5543-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DS0PR12MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2f45e9-32fd-4a1e-281f-08dc0bb88230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBKIU9soHZF4skizma10iaRWvPt9LwmAgOVoSk6NDJbx2tziWgM/X0W0rZtIuAgwh51Ld5k+UU4Ffh4ou09qPHyO+53ILzl6V/GDggix7Uw6k38SU+jGsiopouSJTmAqMVs6hwZVlATBPJsPQst1uA5knhLaFdeFa70gnqWNfx8NNW3ChJtVG4h+ymJqKwJxdtwxGPaBxv6aesx03VVtcOPpCbwqvlRebOiaBZuhviTRXNaxrc6xSj/Y28TfIRRBvSnIEogAQkjNIW0T6lJvHb5bGNCEKYwKRjWRX28JVZD72hNitvnpYDM1YQxqjr5TuwOyS8fAFF5H6BXAEfITdk3mn8wyMjxjzVOIaqBTSTbWCLAnO2gCm2dtYMGh95B2YhPegH04bZPnxm3C+UMUpxf6m1QTr6udAHcRcl4/QnmcMjF7VmA7mx1vVrC12h7TR72c2A0y12gHbaxUWx652jaF/ymvU+mbYlWbysXG9tRKLiZQ8r62EkQzzO07FJBatAYN42EaMuyqIHCrvwIAML6d52NykuTF0YRJmVeu2lqjWqTPHUoC6X5nfEmeWmj+wBvRbLueAAvMqqQDCGO1RZwX+BYAVqKBT6Aq0NgkLWLu08y9oKMy27VJIsvXaRTSKTZzQ2qrZEqKMnjW5ZFMJtDgbk661p19hHknOSOJxAcjOQgqTIZoHuVE/Q++HKULJy1a4bnJumdRWsSPz7Qc6mu4vvG8Hx8lteJpH8fWqq+JL5bxU7oT7zuPlPPnlrGN3JBRQWkvPMX0E9Go5ow/FA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(84040400005)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(36756003)(40480700001)(40460700003)(70586007)(7696005)(6916009)(70206006)(86362001)(426003)(336012)(83380400001)(41300700001)(82740400003)(81166007)(356005)(2616005)(26005)(1076003)(47076005)(16526019)(4326008)(2906002)(6666004)(478600001)(36860700001)(8936002)(8676002)(5660300002)(316002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 17:30:26.5068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2f45e9-32fd-4a1e-281f-08dc0bb88230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8199
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
Cc: Vignesh.Chander@amd.com, Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The current error detection only looks for a timeout.
This should be changed to also check scratch_reg1 for any errors
returned from RLCG.

Also add a new error value.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 0dcff2889e25..3cd085569515 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1022,7 +1022,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 		 * SCRATCH_REG0 	= read/write value
 		 * SCRATCH_REG1[30:28]	= command
 		 * SCRATCH_REG1[19:0]	= address in dword
-		 * SCRATCH_REG1[26:24]	= Error reporting
+		 * SCRATCH_REG1[27:24]	= Error reporting
 		 */
 		writel(v, scratch_reg0);
 		writel((offset | flag), scratch_reg1);
@@ -1036,7 +1036,8 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 			udelay(10);
 		}
 
-		if (i >= timeout) {
+		tmp = readl(scratch_reg1);
+		if (i >= timeout || (tmp & AMDGPU_RLCG_SCRATCH1_ERROR_MASK) != 0) {
 			if (amdgpu_sriov_rlcg_error_report_enabled(adev)) {
 				if (tmp & AMDGPU_RLCG_VFGATE_DISABLED) {
 					dev_err(adev->dev,
@@ -1047,6 +1048,9 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 				} else if (tmp & AMDGPU_RLCG_REG_NOT_IN_RANGE) {
 					dev_err(adev->dev,
 						"register is not in range, rlcg failed to program reg: 0x%05x\n", offset);
+				} else if (tmp & AMDGPU_RLCG_INVALID_XCD_ACCESS) {
+					dev_err(adev->dev,
+						"invalid xcd access, rlcg failed to program reg: 0x%05x\n", offset);
 				} else {
 					dev_err(adev->dev,
 						"unknown error type, rlcg failed to program reg: 0x%05x\n", offset);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d4207e44141f..447af2e4aef0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -40,11 +40,13 @@
 #define AMDGPU_RLCG_MMHUB_WRITE        (0x2 << 28)
 
 /* error code for indirect register access path supported by rlcg for sriov */
+#define AMDGPU_RLCG_INVALID_XCD_ACCESS		0x8000000
 #define AMDGPU_RLCG_VFGATE_DISABLED		0x4000000
 #define AMDGPU_RLCG_WRONG_OPERATION_TYPE	0x2000000
 #define AMDGPU_RLCG_REG_NOT_IN_RANGE		0x1000000
 
 #define AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK	0xFFFFF
+#define AMDGPU_RLCG_SCRATCH1_ERROR_MASK	0xF000000
 
 /* all asic after AI use this offset */
 #define mmRCC_IOV_FUNC_IDENTIFIER 0xDE5
-- 
2.34.1

