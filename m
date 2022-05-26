Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB915C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 17:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35A8610E2A0;
	Thu, 26 May 2022 17:58:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CB6110E2A0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 17:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmRE92aCMG5yLPhzoI8r3KLYMzaPEnjJEajVKp51TBQPmjlQQjB2gtmtE+NergimCYDsXec/lN/4hL2lfiLc4NinJDVsnWSxrrJ5HlYGjXhZOzdKBQ32oQku5SxIVFzmv/UZnQYy1pXCDb2wMcq4URYbUoj1qNjbXQlfZ1KE4amR6/jsNnlFYrpzTg3h+pBq278GWnnn2WsKNa+J4l1rTl39U65znwHg/HrIrJl1lPlIfSksQh4INk9bg/lLqkOALL+d7Kef3AVHlgnhoKoa++1i1HckR7wFEc9AEwyAPBOZ1Hzi3Z7R2PaKcZu/XJsUyhEGnpOF22WT8lIWBYzGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAVW3Im0dlRoR/YXF1ryI3/L05BB/AaCQPNyrhJqZMQ=;
 b=YsMsYVgoddz7smPzTm4Kqts9WpDLqIXrKfxQWYfYr2KL/H++1lHbANSoTt1nFG1nFUaCE0INuFFUSW56ppb6PnN3ZXvbuoJv49UZS7/LEqcSStYylXksipCXgRNsmBdcU5uzlK2EIO8Twd4Tau83pdrpqUYZ4w6UtVq4W7AhdlnXIqk+o1tqw5F3IZ/tJjxwAa4Tq0wrFKJvfBGmFMwWXIoJqOZZnvBccMD8r8Y01ytSJggq0OOdRKLNF/94CniWW6bb3Me8SsoLgObJDZ1MSKifwm9P/FRk7+DQzee4C5pLiF7GpvhsxGkhO+gLY+jZv3Ecl2lRPIt5zqjwkKFUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAVW3Im0dlRoR/YXF1ryI3/L05BB/AaCQPNyrhJqZMQ=;
 b=JBkD5VfOxyCc3zsgCFv+QRk/Lzff+m9ACUpoWPNts25rVt8i+PL4jFFEJwNvJ/y+IBrDp4cQT66aOUHnn1Me4ZoVJ5Kpxx2SmPchuZKtXm0ueikc6tal8LFqUn3SRCtwVIAHxRnXINAtRyrTXpD2n9Ga3WonOXeCY2j44uYKPFk=
Received: from BN6PR20CA0061.namprd20.prod.outlook.com (2603:10b6:404:151::23)
 by BYAPR12MB3094.namprd12.prod.outlook.com (2603:10b6:a03:db::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 17:58:00 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::82) by BN6PR20CA0061.outlook.office365.com
 (2603:10b6:404:151::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 17:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 17:58:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 26 May
 2022 12:57:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v13.0.4
Date: Thu, 26 May 2022 13:57:47 -0400
Message-ID: <20220526175747.3044318-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 718f306b-f30c-4757-c81a-08da3f4145e9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3094:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30945F3A131CFEBECB2A170FF7D99@BYAPR12MB3094.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l5aYWhmVzKO2c1n4c+wZZiOEmjCcCuTLe8ckpCaSFn7NSwaCOwQdKd3q5YH+LzT7qF0okS5lYVMlXGOZtipc/ZYMjeKR4XceirG0P1WQl10kej9+QnDQsnymNMWF6UyMQVWxh11xLE9dPFpucgkS/aFefnsEEyXDedyfwgApPyMYl4qLb7Sp2JeLor4b3GJoBhTPBbZEM7Nz1fHqDyt1XG0gUISvu9ZWylUz3onb8wTauGtYgcEGuqYH9WNNg/ED96Fkxp5OwQLpomx1iCcE3rXtxKN669yCJrF9+NCRPHVHNYWgdCe9fLBK5fZpjss256xOm6/6zStgRaCcYV5aed04XtwvbJDtaMeCxoh0fQbZFpfkGw+HjoiCk524CZsMOzOOH97DFSrTqJAGkvqvYjmBgibHFnDn3uYCZFQDx9GSzZ2XJaejMRAX1MkVFH+dr6wVdBiZ5M+sRPxJzY49UvFmZSlaflUIwK8XVgouK/7A5v30Cgy7T7LBFtvas2tCebt3kL4OPLbczOxYJtRpwfsu/B83BRPxEwiBH8oJE8wUgYJz6NV28FWG4OG+uv0IDsZpT/3/n27nILzHo1YeLONm3f3QwHqdie4Q9eTi55ZG+WT/nJ1TkuJMWzZ8eY1TffcOWKga0fm0FCPSVXeA0EwTPOE66SnKIw7fJ4Zs7bfEEb7DubCdljoJ+GM9jl0Ab+S0xQsqlcX8NYTwNs/oxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(70586007)(70206006)(6916009)(508600001)(26005)(316002)(7696005)(2616005)(40460700003)(2906002)(82310400005)(8676002)(4326008)(36860700001)(47076005)(16526019)(86362001)(36756003)(6666004)(5660300002)(356005)(54906003)(426003)(186003)(336012)(8936002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 17:58:00.4094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 718f306b-f30c-4757-c81a-08da3f4145e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3094
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set the default reset method to mode2 for SMU IP v13.0.4

Signed-off-by: Tim Huang <tim.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 9e18a2b22607..a400f5273343 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -310,6 +310,7 @@ static enum amd_reset_method
 soc21_asic_reset_method(struct amdgpu_device *adev)
 {
 	if (amdgpu_reset_method == AMD_RESET_METHOD_MODE1 ||
+	    amdgpu_reset_method == AMD_RESET_METHOD_MODE2 ||
 	    amdgpu_reset_method == AMD_RESET_METHOD_BACO)
 		return amdgpu_reset_method;
 
@@ -320,6 +321,8 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 	switch (adev->ip_versions[MP1_HWIP][0]) {
 	case IP_VERSION(13, 0, 0):
 		return AMD_RESET_METHOD_MODE1;
+	case IP_VERSION(13, 0, 4):
+		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
 			return AMD_RESET_METHOD_BACO;
@@ -341,6 +344,10 @@ static int soc21_asic_reset(struct amdgpu_device *adev)
 		dev_info(adev->dev, "BACO reset\n");
 		ret = amdgpu_dpm_baco_reset(adev);
 		break;
+	case AMD_RESET_METHOD_MODE2:
+		dev_info(adev->dev, "MODE2 reset\n");
+		ret = amdgpu_dpm_mode2_reset(adev);
+		break;
 	default:
 		dev_info(adev->dev, "MODE1 reset\n");
 		ret = amdgpu_device_mode1_reset(adev);
-- 
2.35.3

