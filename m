Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE21ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 18:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2570D10E388;
	Tue, 30 Aug 2022 18:40:46 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 855AA10E374
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 18:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geDI2FS69pLY5SrpD479Jum+Narwl00BmTDHEOjnWppx+Mf5AtQXqHXc8+Q/9TmMDf3e0zRRTKuShCC/ZIis397JUBVjLBC83dZGqHfcaK6iWvDOk5bSHMQDW0idpZu3kgRYTDWZkp/pAAXWoICdBig7EIpgP/uKa2SBwbofiBazWHmLuhF8NmqpGBFFGEZ+1+dnltQbupNAGA7mCtcWDwYmmBFa1E5kiMfiZ3XtmuR/YnnfnE0cBis0fCiPyai9sHXl8zoW9bj3GZg/t61smNt1KRIcxdrJxjin7hlLCKpMU4MybFOQTdLlf6SJq0tbEPvr/TcqWqRpEsu3kmxOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/kV0ba9USqcVvRLuQWLVbqvJ3Y9S+5urh2FVvllPbk=;
 b=BqfcC0oVjxJbx4NfoEOaLXBXO+xvEY1o2czzJAh3xxFZlP9lS+W4psAu+K442zCxqeoiOY8zjREE+nSSaSfP7qbgg/nOpNZDvh+lC/cASCkSVgNolIuX+inyQk/doblijmnTb1mCcDJ6RZH6fDi5TyWoK5KTQ5sa+r8Y1aGKucXU5RqUZkltjDaO0Q3A647721IQPw0ziwWBSGk8ReK5etdyyvcYaLlqHyui/3OZujMsjv7xNdiC07hfjtboWpxUWp+Sd8GoyZR1JoxOHcN5zPQty9ZTC5qL2+iQlhIgHtaGdNtiIv2kou+5Pwh8lN+V90o3Ac0WMGEB5ZtSFxIFSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/kV0ba9USqcVvRLuQWLVbqvJ3Y9S+5urh2FVvllPbk=;
 b=BJNeaowde9penZO2tj7OIqwRI0uakoLw7v8bj9DGxvRp1ZVelcTGhO0aXW5SI100K/meNNVGTKKhOo5S+fpouhpJlychvBaPh0fjll2qwdiSaM/0ifUErSZqkyRX2hM+fRAZoofV+q1aQU1t8f3xNLQg11mBonbzfZ2qs0C7OrE=
Received: from DM6PR02CA0040.namprd02.prod.outlook.com (2603:10b6:5:177::17)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 18:40:34 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::c) by DM6PR02CA0040.outlook.office365.com
 (2603:10b6:5:177::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Tue, 30 Aug 2022 18:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Tue, 30 Aug 2022 18:40:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 30 Aug
 2022 13:40:28 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/19] drm/amdgpu: Support PSP 13.0.10 on SR-IOV
Date: Tue, 30 Aug 2022 14:40:00 -0400
Message-ID: <20220830184012.1825313-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830184012.1825313-1-alexander.deucher@amd.com>
References: <20220830184012.1825313-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49bfff54-f1ed-45ad-791e-08da8ab71f9d
X-MS-TrafficTypeDiagnostic: PH0PR12MB5608:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: is+i7mlCdbFmn9bkMn68PkwrL0ljRlPedTRH/CxhUi0g3eEsvu9bVd7MCOLE+biL4WKwlkvgUcBWYuADihYwKUyPgPEmeu/M30ByG/hu2ZslxJqHiumD5fOdn0wtA1XnrpllXOEzBYoCSwBfbqUjH5MQDR+1fWAXIvlTSgItlJXIwFdeGn35YFYs81TMGuJXIxQE3sWgwUWMn8OT7Voc8X6tuBn9ROt9X5rZn3U3j9R+TMxB0QJtLFBGgyn5eWU2AdUsA+VIBX9wmDENSBWiiK3xaauTQxhfaMoIhJh1t07+Hkr09MoVxgFribVfiUgCO3uOzCyJGKQdigzySGXNckvO9bU29jgihtb6mOU62eQNL8qiBoo8bL3VTX5Jw/yV8orZRy46Ua7NH0Tbp+JzDfDR9OBL1RVwZcpkqXZYwnPFU0E+L0BGALqeONSzuYWYhkwKfPxpQjaJoTDyC+Fwy/MCEURrsFZg/+155a8A15e72RMmKE9qX7grii1UPVOME36hdDlsjvKsDwgUNXUbkYg10KINX8+WIV6t+2Kd8Ou4XmBRNjq8fRgSar6dM2dkOjN/VO2p92/ySdN54/XBGU0C/A+9u3bN8I1NpGShZZaVmu7VFN8zW/H0E22qOL/YYVWdrXd//bA8rnYSHdXupl/apPjGfBxBfd7TlNFoujt1hKFPVgX2PUCo0OS1JZqkIkDVHkFQPJp5tOwrMYuynf6r9Ts4830OZVgc5oIvSUyXfywco/pOgCe0K50Cp4f9PvzE0HLQ9dhnawIe8CU9ghmgcgsp6As8+3+VxRp5aNQTBk0AXWoR5r1auR1Mj8R4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(39860400002)(346002)(40470700004)(46966006)(36840700001)(81166007)(41300700001)(5660300002)(2906002)(478600001)(40460700003)(40480700001)(36860700001)(8936002)(1076003)(47076005)(86362001)(2616005)(16526019)(6666004)(336012)(26005)(83380400001)(426003)(7696005)(316002)(82740400003)(54906003)(82310400005)(6916009)(186003)(356005)(4326008)(8676002)(70586007)(70206006)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:40:33.8846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bfff54-f1ed-45ad-791e-08da8ab71f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Horace Chen <horace.chen@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Horace Chen <horace.chen@amd.com>

Add support for PSP 13.0.10 for SR-IOV VF

Signed-off-by: Horace Chen <horace.chen@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 12 ++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 62 ++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  3 ++
 3 files changed, 55 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index d00a9fe542bf..bae4154455cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -328,19 +328,27 @@ static int psp_init_sriov_microcode(struct psp_context *psp)
 
 	switch (adev->ip_versions[MP0_HWIP][0]) {
 	case IP_VERSION(9, 0, 0):
+		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MEC2;
 		ret = psp_init_cap_microcode(psp, "vega10");
 		break;
 	case IP_VERSION(11, 0, 9):
+		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MEC2;
 		ret = psp_init_cap_microcode(psp, "navi12");
 		break;
 	case IP_VERSION(11, 0, 7):
+		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MEC2;
 		ret = psp_init_cap_microcode(psp, "sienna_cichlid");
 		break;
 	case IP_VERSION(13, 0, 2):
+		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MEC2;
 		ret = psp_init_cap_microcode(psp, "aldebaran");
 		ret &= psp_init_ta_microcode(psp, "aldebaran");
 		break;
 	case IP_VERSION(13, 0, 0):
+		adev->virt.autoload_ucode_id = 0;
+		break;
+	case IP_VERSION(13, 0, 10):
+		adev->virt.autoload_ucode_id = AMDGPU_UCODE_ID_CP_MES1_DATA;
 		break;
 	default:
 		BUG();
@@ -768,6 +776,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
 	case IP_VERSION(11, 0, 9):
 	case IP_VERSION(11, 0, 7):
 	case IP_VERSION(13, 0, 2):
+	case IP_VERSION(13, 0, 10):
 		return true;
 	default:
 		return false;
@@ -2414,7 +2423,6 @@ static bool fw_load_skip_check(struct psp_context *psp,
 
 	if (amdgpu_sriov_vf(psp->adev) &&
 	    amdgpu_virt_fw_load_skip_check(psp->adev, ucode->ucode_id))
-		/*skip ucode loading in SRIOV VF */
 		return true;
 
 	if (psp->autoload_supported &&
@@ -2488,7 +2496,7 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 
 		/* Start rlc autoload after psp recieved all the gfx firmware */
 		if (psp->autoload_supported && ucode->ucode_id == (amdgpu_sriov_vf(adev) ?
-		    AMDGPU_UCODE_ID_CP_MEC2 : AMDGPU_UCODE_ID_RLC_G)) {
+		    adev->virt.autoload_ucode_id : AMDGPU_UCODE_ID_RLC_G)) {
 			ret = psp_rlc_autoload_start(psp);
 			if (ret) {
 				DRM_ERROR("Failed to start rlc autoload\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 79f1e37caaec..a7de2c2b0cae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -690,7 +690,6 @@ void amdgpu_virt_exchange_data(struct amdgpu_device *adev)
 	}
 }
 
-
 void amdgpu_detect_virtualization(struct amdgpu_device *adev)
 {
 	uint32_t reg;
@@ -811,31 +810,54 @@ enum amdgpu_sriov_vf_mode amdgpu_virt_get_sriov_vf_mode(struct amdgpu_device *ad
 
 bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_id)
 {
-	/* this version doesn't support sriov autoload */
-	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(13, 0, 0)) {
+	switch (adev->ip_versions[MP0_HWIP][0]) {
+	case IP_VERSION(13, 0, 0):
+		/* no vf autoload, white list */
 		if (ucode_id == AMDGPU_UCODE_ID_VCN1 ||
 		    ucode_id == AMDGPU_UCODE_ID_VCN)
 			return false;
 		else
 			return true;
+	case IP_VERSION(13, 0, 10):
+		/* white list */
+		if (ucode_id == AMDGPU_UCODE_ID_CAP
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_PFP
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_ME
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_PFP_P1_STACK
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_ME_P0_STACK
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_ME_P1_STACK
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK
+		|| ucode_id == AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK
+		|| ucode_id == AMDGPU_UCODE_ID_CP_MES
+		|| ucode_id == AMDGPU_UCODE_ID_CP_MES_DATA
+		|| ucode_id == AMDGPU_UCODE_ID_CP_MES1
+		|| ucode_id == AMDGPU_UCODE_ID_CP_MES1_DATA)
+			return false;
+		else
+			return true;
+	default:
+		/* lagacy black list */
+		if (ucode_id == AMDGPU_UCODE_ID_SDMA0
+		    || ucode_id == AMDGPU_UCODE_ID_SDMA1
+		    || ucode_id == AMDGPU_UCODE_ID_SDMA2
+		    || ucode_id == AMDGPU_UCODE_ID_SDMA3
+		    || ucode_id == AMDGPU_UCODE_ID_SDMA4
+		    || ucode_id == AMDGPU_UCODE_ID_SDMA5
+		    || ucode_id == AMDGPU_UCODE_ID_SDMA6
+		    || ucode_id == AMDGPU_UCODE_ID_SDMA7
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_G
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
+		    || ucode_id == AMDGPU_UCODE_ID_SMC)
+			return true;
+		else
+			return false;
 	}
-
-	if (ucode_id == AMDGPU_UCODE_ID_SDMA0
-	    || ucode_id == AMDGPU_UCODE_ID_SDMA1
-	    || ucode_id == AMDGPU_UCODE_ID_SDMA2
-	    || ucode_id == AMDGPU_UCODE_ID_SDMA3
-	    || ucode_id == AMDGPU_UCODE_ID_SDMA4
-	    || ucode_id == AMDGPU_UCODE_ID_SDMA5
-	    || ucode_id == AMDGPU_UCODE_ID_SDMA6
-	    || ucode_id == AMDGPU_UCODE_ID_SDMA7
-	    || ucode_id == AMDGPU_UCODE_ID_RLC_G
-	    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
-	    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
-	    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
-	    || ucode_id == AMDGPU_UCODE_ID_SMC)
-		return true;
-
-	return false;
 }
 
 void amdgpu_virt_update_sriov_video_codec(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index cd6fce05978f..d94c31e68a14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -253,6 +253,9 @@ struct amdgpu_virt {
 	uint32_t decode_max_frame_pixels;
 	uint32_t encode_max_dimension_pixels;
 	uint32_t encode_max_frame_pixels;
+
+	/* the ucode id to signal the autoload */
+	uint32_t autoload_ucode_id;
 };
 
 struct amdgpu_video_codec_info;
-- 
2.37.1

