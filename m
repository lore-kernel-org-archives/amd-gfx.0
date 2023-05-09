Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C97AC7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F7210E415;
	Tue,  9 May 2023 22:14:36 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8B910E3F0
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey6RCy5a7cR8AgK0lFV2KqaPoMSEBqLp06GsXO2koIDZe1cHoKDmSPpm4OnmYJNs8ZquAsmF+DEdjx3vVnNnNmIv82ebUGqrFoAf2LcZOb7lCzpF9emNApPuabbyRY2s9iqurnQCbN/UGoIExfHSUlE5mfF6SMbnqp0rIbAgmXqIqyoYCPCWmplsKEV2HoPT/UNJnD/seHkqqf7kMEFWrMyPHGu+De6Oj1ZIdQvrbq56kS4ZbrohqDW7G0GbeyrQSRXMvzWZ6cMw8S3fXMB7NW7Za33Y6Xqe4W94fHe/CyW5ZsrzJnFT5M7AslAvE/VS6hf9DWOtdVnFYSs1eyMCmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUS8cFagWp/+nFrqMgh2OLjSx1Wnv6ofoo9rQi7259s=;
 b=ZN+TdS4WpIM5wC0LnZwGsbiqlWobE+AHhdbSXYIMKNbtSuyag8WvtI/BGuVp9Tt0KrSQxM3tbqN78vL/ToLTohjsJntPAH6efSswDflhfDp9ixAle7I9j5SF5C6wJ2E2givlfgDIOYpKhAcZK8XNmBE4+GIIfSNIs8ScKLkJRcaflNCno07tb3Ixb9NIPcMlckvQYxE8buSwXJxs6MZB5EfjHmqbt0rAnuAbNiQW41kvdiwoRJh54XodPo4D5mPssYWpX7Cn2hOKeJFlmSVj4NRQFA+092febCxetDpf/l2sBFDv/oMC9ND0BNQask/eM0nZusGSnFH2n4q19sTjow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUS8cFagWp/+nFrqMgh2OLjSx1Wnv6ofoo9rQi7259s=;
 b=OKAXhsPFnv5O/whpEGAcEtjz3crFrJTBrqriaSimcn2qCbs0eP8KwC2ALdsn9Qd4zckDLnHy7xcdO1YzxLfZMLS/JEuh+0ZxhXXHh16wt99UBF+IFV1Km0d08GWg+0fEywHOhoiH/jbm9RhL20lgzBGl1os+6FltVTEl/lzTNMQ=
Received: from BN9PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:fb::29)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:14:30 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::fd) by BN9PR03CA0054.outlook.office365.com
 (2603:10b6:408:fb::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:14:30 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amdgpu: Check memory ranges for valid xcp mode
Date: Tue, 9 May 2023 18:14:07 -0400
Message-ID: <20230509221408.476829-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT041:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b507fe-7e59-43a5-6c54-08db50dac2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5hpBxWBdWnFAGmewB36B+biR8RZi/xlGO7ZdxTDh3DItzksmP9RMml94//1DGR/YxDAA0oWGEs82errwzM9iyE5lH2ymClM9wtPABY9qYOreobpNwOCEilguVMGifjaf6qqTAm0qsaShh+DSFGsLJo6PiJFZ9dnUX5FbVIIw6UirYVazA+XuIrv0cs3PXO7guiEIn8cwBEgQieVmPFpQh3BUGL1c7SodnT6LxhAIy6J5tgCSfD8nKA/U3wB3ZfOAuJrs6Ilc6YO9zusWn9EpMKK5Ih8KpdRUV7KF7ET6wcHHjmbUP4qBmLzXhMZKuDvQNEwPwx7VA0r7mqP08R0QUxHWz2uX5/cJxdr8+WcbXpFo6OL2r1ft+NF3A2luAJBsArBrQ1l+U8hFKC3jBqttkrhLkn6mf9P02HjwsS7TW55U2oB8jH1zKx74M0oEmLaxIqz7StHIJUMe35VjStEPjGhwKf3ITvx3/twpydkxYoYQ74a4lb3eSmSgP7MXNM/rOp34A+5+BgkixCVqVuVwHlSMR1PcMQ7eEP9PmDGEZlJeNMlr5JXOCPk4Z4UUWOfeDc6lBX0WRDjDbT5MnQTgVb7Ag3jOolG5WX7VkbSAtJhPPaL+FMxNJTT1/MQNp7fFXniTRh0AlNm09dJe9rbFnC3kG1xFjd5rNTONX1bn370E5fQFOG61D1120X8CUTNGF17PPHJyo+0fZSIcQSy/XJ59FrDCEE3TSA9e6nCwya4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(4326008)(8676002)(6916009)(54906003)(16526019)(5660300002)(8936002)(478600001)(70206006)(2906002)(70586007)(316002)(41300700001)(6666004)(7696005)(1076003)(26005)(186003)(83380400001)(82740400003)(47076005)(40460700003)(36756003)(2616005)(336012)(426003)(40480700001)(36860700001)(82310400005)(86362001)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:30.3923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b507fe-7e59-43a5-6c54-08db50dac2cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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
 Lijo Lazar <lijo.lazar@amd.com>, Philip Yang <philip.yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Check the memory ranges available to the device also for deciding a
valid partition mode. Only select combinations are valid for a
particular mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Philip Yang <philip.yang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdgpu/aqua_vanjaram_reg_init.c   | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index 004400fb89b0..7469de3fd6fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -238,21 +238,28 @@ int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 static bool __aqua_vanjaram_is_valid_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 					  enum amdgpu_gfx_partition mode)
 {
+	struct amdgpu_device *adev = xcp_mgr->adev;
 	int num_xcc, num_xccs_per_xcp;
 
-	num_xcc = NUM_XCC(xcp_mgr->adev->gfx.xcc_mask);
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
-		return num_xcc > 0;
+		return adev->gmc.num_mem_partitions == 1 && num_xcc > 0;
 	case AMDGPU_DPX_PARTITION_MODE:
-		return (num_xcc % 4) == 0;
+		return adev->gmc.num_mem_partitions != 8 && (num_xcc % 4) == 0;
 	case AMDGPU_TPX_PARTITION_MODE:
-		return (num_xcc % 3) == 0;
+		return (adev->gmc.num_mem_partitions == 1 ||
+			adev->gmc.num_mem_partitions == 3) &&
+		       ((num_xcc % 3) == 0);
 	case AMDGPU_QPX_PARTITION_MODE:
 		num_xccs_per_xcp = num_xcc / 4;
-		return (num_xccs_per_xcp >= 2);
+		return (adev->gmc.num_mem_partitions == 1 ||
+			adev->gmc.num_mem_partitions == 4) &&
+		       (num_xccs_per_xcp >= 2);
 	case AMDGPU_CPX_PARTITION_MODE:
-		return (num_xcc > 1);
+		return (num_xcc > 1) &&
+		       (adev->gmc.num_mem_partitions == 1 ||
+			adev->gmc.num_mem_partitions == num_xcc);
 	default:
 		return false;
 	}
-- 
2.40.1

