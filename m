Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8953EB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jul 2023 07:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DCE10E1F0;
	Mon, 17 Jul 2023 07:24:23 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8765E10E1F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jul 2023 07:24:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOXclST6BSAdNr5cxX29SLRIptB6Z9ysoH0DgBGKnT1UL3dC8M6qqoHKsBxzlTBUELuxD5PlSQ9Rn+21vPrw3IgdMM5zzopvdPjJewKluZb7ycpusDQSPDEz3ASuBkpcRO3Ju9i+6WXsxFfh9Dtds7S8wWNnqqGbvLK5ypA9shEGYjjnPiywrii2Zcu3APhk9aaXYCw09WZBgF1StV72NsJkaxsUcZTuQxczq6hey5CFiE7B0izE0sVoAgksSTcO1NvQqSW1j+8sXioQJVo3ankTC0ZXxXkXJIn7qTWMb5IxSFPMiMOu333BlMCrMO8myC8pUfYXochaa/7ay9SGmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjxfqjubhjrTm3WaLsAY1G8a4/7TXp5DQCnSReu+1KY=;
 b=oJja92UV+3Mkc2LiiNkfbgNMtmkP7emQ8iHXKKUCJfE5anuGmH+SpJl3UUwAg90tRu0xl8U3NoUJWfBz9/ic+s4pWTixVA+WP2yxRHtbHYr0EEV1b+jONx0ZKMsc/z6shiCttR7XJL4wHOtfjn7WwNY+kRJa97LQe136V1N0LWBmsY4wldvaZWUpJlS8b+smGNa1g0MGRcGtFwSAz6qwPq2gQF1x9uwAumbCc7l9tSbl4E4gtZq6sHgFfBzGwDxmgRFo/XZmFuYxZmN6ais1KQE+OI+R9bniWbf/RbWcr7T0FXTmiMR01/seMdosXV9h6hUmFduy4BOQ6cgiaS9Jow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjxfqjubhjrTm3WaLsAY1G8a4/7TXp5DQCnSReu+1KY=;
 b=soXDfK+IdSyYjS6nqEB0C4HX9mx53QLLpDO7rbsVLpU/73Z05+TuXsIHcNnPh5W3GvdV/K+pwjcJzmEdap62G190gB9CPYMZTs3Lv6hI8+Qhn6njHjF7JcbOoJNTeJT5/qQro2PEEOmUtfSs40DpZVu7Ni5PpvB09iH48E2L7Lo=
Received: from BN0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:408:e6::27)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 07:24:18 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::f8) by BN0PR03CA0022.outlook.office365.com
 (2603:10b6:408:e6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Mon, 17 Jul 2023 07:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.32 via Frontend Transport; Mon, 17 Jul 2023 07:24:17 +0000
Received: from mao-Super-Server.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 17 Jul
 2023 02:24:16 -0500
From: YuanShang <YuanShang.Mao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: load sdma ucode in the guest machine
Date: Mon, 17 Jul 2023 15:24:05 +0800
Message-ID: <20230717072405.47912-1-YuanShang.Mao@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb98b75-f545-430e-88f0-08db8696d4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuCjgRo0i3wML3d/YD1M/SRmTcIswhaWdjSac0fxnTYkKe0n/pxfTp8pS1ouPN/vs4lzU0Kh0+66YAtAmM01IIO2Wez8JxpBFRaZ6tmHQkN03q75XIzmdGTOGyfJIhxuI3mC0RZ+6Mel/6OgeVJ1hki2cL/lxtO7JSmngM1Ok3HEQyfKhSH1suv6aFlR5OURiIW/PHSV+aTx+/hHeX2eu7DFUVCptWp2tfFsDiunWrTI8f6AVypf6pb1KiOIkjJLFhC1A6m/iH/ZAZFIpeGzH+bfqXzqkMnHtpIBHoMAbZ0TaYRYsDwhJBY7Dkja2dIlMoEj/zYRQC8NC+oIMDQm6AN6tNw9COHlpoyX5buyPVc6l3yRt43X9BTwkmfSTLsJJ/gadVWmjY21CzavDuty6DAuJYV8vvM3wnhs8ZMZvg5CU/AtPepJhtv/fxBoabKOleCAHRwyv9CvxlrZwh9wslV+H9hPnk9kThm4s2iuHPeKChxbL2aLGli/u5Mdvu8mXtJnStT1y65gu8xRXNMfOXS24XdUzG0Uip6VZQep8hUBclcIQiEc2whyKMcUBK3bFxAwocU5B6gYQB4U5GrD1wSYKpQ7+OidB7s2BEzR1zNnNPMeaXfi4lH7Xr6mWdk0E69sUnu1mgmBPkaqW0stmTD3OBwrq7sQ6MX5i0qBPbBu3LBf1nxZB3bkTrCivVcWU3aiNYoTjdzDQ+i1+CkO78e1iRNtkqibOmJ4ri0Fo2TqhxRjNpJrlGh4FqnPul+lISvs+02LJH6RcN1hDcfaIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(478600001)(70586007)(70206006)(54906003)(4326008)(5660300002)(316002)(6916009)(8676002)(8936002)(40480700001)(2906002)(41300700001)(6666004)(26005)(1076003)(40460700003)(7696005)(82740400003)(81166007)(356005)(186003)(16526019)(2616005)(47076005)(336012)(83380400001)(426003)(36756003)(36860700001)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 07:24:17.5782 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb98b75-f545-430e-88f0-08db8696d4c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398
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
Cc: yuansmao@amd.com, horace.chen@amd.com, YuanShang <YuanShang.Mao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
User mode driver need to check the sdma ucode version to
see whether the sdma engine supports a new type of PM4 packet.
In SRIOV, sdma is loaded by the host. And, there is no way
to check the sdma ucode version of CHIP_NAVI12 and
CHIP_SIENNA_CICHLID of the host in the guest machine.

[how]
Load the sdma ucode for CHIP_NAVI12 and CHIP_SIENNA_CICHLID
in the guest machine.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  8 +++-----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index dacf281d2b21..e2b9392d7f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -239,9 +239,6 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 			       sizeof(struct amdgpu_sdma_instance));
 	}
 
-	if (amdgpu_sriov_vf(adev))
-		return 0;
-
 	DRM_DEBUG("psp_load == '%s'\n",
 		  adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ? "true" : "false");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 41aa853a07d2..ab76817d94ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -845,6 +845,17 @@ bool amdgpu_virt_fw_load_skip_check(struct amdgpu_device *adev, uint32_t ucode_i
 			return false;
 		else
 			return true;
+	case IP_VERSION(13, 0, 7):
+	case IP_VERSION(13, 0, 9):
+		/* black list for CHIP_NAVI12 and CHIP_SIENNA_CICHLID */
+		if (ucode_id == AMDGPU_UCODE_ID_RLC_G
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_CNTL
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_GPM_MEM
+		    || ucode_id == AMDGPU_UCODE_ID_RLC_RESTORE_LIST_SRM_MEM
+		    || ucode_id == AMDGPU_UCODE_ID_SMC)
+			return true;
+		else
+			return false;
 	case IP_VERSION(13, 0, 10):
 		/* white list */
 		if (ucode_id == AMDGPU_UCODE_ID_CAP
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 5c4d4df9cf94..1cc34efb455b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -237,17 +237,15 @@ static void sdma_v5_0_init_golden_registers(struct amdgpu_device *adev)
 // emulation only, won't work on real chip
 // navi10 real chip need to use PSP to load firmware
 static int sdma_v5_0_init_microcode(struct amdgpu_device *adev)
-{	int ret, i;
-
-	if (amdgpu_sriov_vf(adev) && (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(5, 0, 5)))
-		return 0;
+{
+	int ret, i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ret = amdgpu_sdma_init_microcode(adev, i, false);
 		if (ret)
 			return ret;
 	}
-	
+
 	return ret;
 }
 
-- 
2.25.1

