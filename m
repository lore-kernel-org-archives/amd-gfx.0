Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75A4C77B73
	for <amd-gfx@archiver.kernel.org>; Sat,  6 May 2023 03:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 316A410E093;
	Sat,  6 May 2023 03:48:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F179510E093
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 May 2023 03:48:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVk/PylFrYfluk22ymtyk3F1GXjURWO9tu1FwEcS78tGMysMouXcR/d7FKdlAwnGIeiWiJjsm4mcbFQR3O27B7Y2fWxjgQK8RWl1v/jRoMgKnseDLzcQJh0b4rrSvq9AFET4YyDOlmkPud9yVLaUPOu0wFdDTtUZ72d/tt1QLqXddx/m6z6wp+ZgjWQPkvb/QATj30MFnSCNvlATalDgadSX47eA82UcxXJLFF5wuEjDdv/meLASRNHRFLdpu0jv006lUCGWhEQ/oaitSy/17A944MmRGqwbyg7NoPUruMav0A55uEZiusaAqhzAa9NldlAxHEpIvIb1fdqGedr0/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFqkVnZu5WDLDBN2XdKxDC5Xyok+kXNAMuWtFN9ZvBM=;
 b=CqzVtD0nofP1ElpPCjdewoiLMPclhbzX0pHw3RdstCARfttyybJXskc9AkEJDCrxjSvro+KcHQcDfNmLbCIutDdyOTMoD4Rmk5vAQaDAq85RgX5sX+8pQLUzGzZ4vW9ECKbCrzU6SNLGdFKU7BqcFJGJNd3a2vJUaCX+kvIZV1v7c/AIWkqTPATMMa7ozgHQ41QgeRb7aVJAUwgExGM2soOmozZGgivFwPZHH6MxFFKCQrLJsKvIgaboYG/CxrCq9FGUIfwcVra3E/OWoYfzjHdp8UsLvWt2OMdUM3LSvR7t44cJtD9f9mcPJMO/5XN+ToN7IPU53vM1eBBOJycExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFqkVnZu5WDLDBN2XdKxDC5Xyok+kXNAMuWtFN9ZvBM=;
 b=qJzHzaGCKMbtBo7QpTRLB8VRnDcP9a8ALyx09DU4PMWgDtjNzPB5bVZOECdr4mxDcx3dX86CDgh2wOzrSpjXqiy0Eal0EDqccvC5/bc7lLca/eL/2iECAKP5CJ+HVcirHPlOtjxm42eFNfYcTCOy6Yn0OFP06ogrSemgtNd2DEc=
Received: from DS7PR03CA0233.namprd03.prod.outlook.com (2603:10b6:5:3ba::28)
 by MW5PR12MB5600.namprd12.prod.outlook.com (2603:10b6:303:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Sat, 6 May
 2023 03:48:37 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::22) by DS7PR03CA0233.outlook.office365.com
 (2603:10b6:5:3ba::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Sat, 6 May 2023 03:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.27 via Frontend Transport; Sat, 6 May 2023 03:48:36 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 5 May 2023 22:48:33 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <mario.limonciello@amd.com>
Subject: [PATCH v3] drm/amd/pm: parse pp_handle under appropriate conditions
Date: Sat, 6 May 2023 11:48:19 +0800
Message-ID: <20230506034819.1777919-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|MW5PR12MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8f7c10-a87e-417f-6d93-08db4de4c5b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ecSdOhEBpRwIGyct58Sn1rYSFPGjS6/JDgKejzYTPXMT9S83GUOPLwMip3fOA217VcfHGZBp9pCn4DEpKO0B1vQyjEO8vjWGkfSCIBVCu9dQNbSBsjh23KFQc71RLHRsAZ2Rv3Xeg423ZkUQ8VNtsM3yULXHxtptyzgFzBcddZWSbxiYAsrDqb6Q7SfBqpldGf0VkeroA1zbh2Edbv/odlPzAhH/+rcoLDIZ6hqtTCV8RkvRBC7NAPoBzbl+1XZ3+U7TEVeVb+8sd5ojQg98sbq+V66gV//77t9I8XMiJgusdeUTpDBxhp2QOK31AF50OpYaLLnPNtrKKNIbxB4Xbj0JNB+vFPiFxfz62joiBMA3ivGh3WknR8RzvIziHIkgKs8i75rYzxVYt2GIKk1WCfF2/ccXR7fzbHQohhw3V/b1ZfI2tPCnekdWBXTNV7+8PVx4aaDPXDbsvE5ZvYPme2+IlDwYrbnelDrNx1L2LpOsCsIddybUjnhhIvmBPZ5ntlOAFw/D7P23QJz4qjNwF74snRFmbNbP/T7uUt2/ZmFaE0508TLswYhS3IF+s4ucav2F1kexVMmC1HlmLpkhaWO5AZMulFYv5aET403VA1tu4OJ1XUsRrQ0GYX0moj/pg5sir3dxg/Xb88j/gBr34McwLIKjOPv7PANtlNZaOyUGq4N7SBVZ8OJRZ+dgjOzgxn15gZC63Z6c1A+A6gbDFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(82310400005)(8936002)(8676002)(40480700001)(966005)(426003)(336012)(1076003)(26005)(2616005)(2906002)(83380400001)(44832011)(47076005)(4326008)(70586007)(7696005)(478600001)(356005)(6636002)(5660300002)(316002)(186003)(70206006)(6666004)(110136005)(41300700001)(36860700001)(86362001)(36756003)(82740400003)(81166007)(16526019)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 03:48:36.7094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8f7c10-a87e-417f-6d93-08db4de4c5b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5600
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_dpm_is_overdrive_supported is a common API across all
asics, so we should cast pp_handle into correct structure
under different power frameworks.

v2: using return directly to simplify code
v3: SI asic does not carry od_enabled member in pp_handle, and update Fixes tag

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2541
Fixes: eb4900aa4c49("drm/amdgpu: Fix kernel NULL pointer dereference in dpm functions")
Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 300e156b924f..86246f69dbe1 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1460,15 +1460,21 @@ int amdgpu_dpm_get_smu_prv_buf_details(struct amdgpu_device *adev,
 
 int amdgpu_dpm_is_overdrive_supported(struct amdgpu_device *adev)
 {
-	struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
-	struct smu_context *smu = adev->powerplay.pp_handle;
+	if (is_support_sw_smu(adev)) {
+		struct smu_context *smu = adev->powerplay.pp_handle;
+
+		return (smu->od_enabled || smu->is_apu);
+	} else {
+		struct pp_hwmgr *hwmgr;
 
-	if ((is_support_sw_smu(adev) && smu->od_enabled) ||
-	    (is_support_sw_smu(adev) && smu->is_apu) ||
-		(!is_support_sw_smu(adev) && hwmgr->od_enabled))
-		return true;
+		/* SI asic does not carry od_enabled */
+		if (adev->family == AMDGPU_FAMILY_SI)
+			return false;
 
-	return false;
+		hwmgr = (struct pp_hwmgr *)adev->powerplay.pp_handle;
+
+		return hwmgr->od_enabled;
+	}
 }
 
 int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
-- 
2.25.1

