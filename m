Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D35C76196
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Apr 2023 08:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0355110EB0E;
	Thu,  6 Apr 2023 08:11:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE80310EB0E
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Apr 2023 08:11:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB/u1U3IQsoTp73gfXFGPnW9sul4nrIH63yYBzqqRSFOiO3FvcSNNLp0Deg9cimds8ea61p3p2LXMA2LuJdl8c+7CCAimSDM2/DOlqUlWjDVhacDasEI3VrV59YOm1votw4+kBJcxmJBzd619EVDAhvSiFxYd1Uj4f+1l9KOoIsf3hM4+DbFN545x8xZVTi2RF7to2HMwWCa/D/mW646B3j5ahetI3hqOqQlfV+efAq9mI3YE5vv8I39Fr/e3kAL/qMCH5M6gF/HiJdHUFO+XMy8cHTT3dKdihmpHVju9pualcnlC2YvER54KswWdcq29LzHc9MtUoAsyeQq4MtyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vGRgSsW+TKrikqsq9bJiVe5F2P7VwykXL6Qy3Rbshnw=;
 b=CciqhbuP38jLUaua6xrKhWSiLC2sWT3Y75ngLHTWLc+lFMw8gH+sSzMyVkWQLXm3XBFy3yXYw6qkAPD/51gL9S6GQVtDf4Ux7c9+VKUMhma0/U7hxT/wqRn/u2D6mhG3RRS64+F4Oe5Khchl/CXQT/+6zIqTIH92C/LTv+PuIi0EhExv0tZ8XE0GTmMGKE3hwjBV7NPsqheWLHDDTnU2tyzUrg5UcojWlYkkritXd2YMB8x6fTWnL4/HYwU45PJFZ54e4VwYjc6s2TNdyxr6nj8y9eQWYeNmrs3CccRXDOnCT6FccBlr+ZAIydsq8ULHXe0tBs7W9QN3R1/09pWq1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGRgSsW+TKrikqsq9bJiVe5F2P7VwykXL6Qy3Rbshnw=;
 b=ss+2gvzAlWglNNEuqdUBiNU5iJSWUh26W1LV+jXziCtCxjrfLVjItKuG1L0mJIncD8Xx7HQ5SsiPmxDwxfMqy/6AXtcfnmwGrcb+g+AxBNxWe84DdD0WQxDAs4xisP7yquQWZuaRjlgjFmZ1GAaC8p7zFLXHm5u5ngwW/426TdI=
Received: from DS7PR05CA0058.namprd05.prod.outlook.com (2603:10b6:8:2f::11) by
 SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Thu, 6 Apr
 2023 08:11:51 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::d5) by DS7PR05CA0058.outlook.office365.com
 (2603:10b6:8:2f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.14 via Frontend
 Transport; Thu, 6 Apr 2023 08:11:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.30 via Frontend Transport; Thu, 6 Apr 2023 08:11:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 03:11:50 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 6 Apr
 2023 03:11:49 -0500
Received: from lyndon-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 6 Apr 2023 03:11:48 -0500
From: lyndonli <Lyndon.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix sdma v4 sw fini error
Date: Thu, 6 Apr 2023 16:11:42 +0800
Message-ID: <20230406081142.1426354-1-Lyndon.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: c47dbc1f-1dda-44ac-e4e9-08db3676934d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJ96e1+danG5WSQs015Cgge3Lf5gIIrxAW/+yFABuzRSNmusWIOd4ZyXvIdGHhinVDYyfTMTyb/40/dKfuZKgqYvGwiZGioYnszky1g7b39bwvr4gksOG4698EKuiNae733g3ETkrhVROCTLIUDhhON8Y1iwDHIgH5YBP/60Xc3EzB+CwIaITjira+FEQjpniuk0rpU3kWL6edZFpEIXVqbQn+snYf4dkZ7AteTrSTcG9yhhSoaqgnnU1bU2O55HkqxbdxZulln78cAjPooH0gjT235wTYkeTs6SGiH+2jIPtV3y0nTKRkMEal0Q9+lJat90aOYSAtUhQU20poCK5YXyP4scVVsV/Ye68CvVV5qXzma/u86fQ9gZXDHswDYutop7yl4/6QECmrz3zBjHKh/evNj/YQ4phfgRjFpCk75XsGnw3Jnc5n+spDfdU8f+jjaZ4knB3evoYf18wc5Bv4tH5c2yLteUSuwBNp/h7SUVCZn5uaIvb+ybget2BcMuBmRMBbwp3VlujdfLN6S5xxq7IyWjB5EUAOFDhKOA3i4K0PPhK5ZNGbKH0eu00LB2H2hwJFKq+F+JKxFD/asKzFz77ULP3gzZjpXJnCbRG3lplHUEdIU/O6VSNpEYm30lNVuWg+zSDXd1Q7ZLC7thLZNtyRvLsleIGvsBmp6E9JpOT5O/gUUGCsF0zR4SCN/Kqh1+QljzfHYviuqJ4UmprFdMT/q9qGc1TBf6x5FxnBFAyeJcn3BOcft5Gxb1pdsfqYRarTt+oInhiJtV3CYoMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(7696005)(6666004)(478600001)(40480700001)(83380400001)(86362001)(36756003)(40460700003)(47076005)(82740400003)(81166007)(356005)(36860700001)(2616005)(336012)(426003)(2906002)(186003)(316002)(54906003)(26005)(1076003)(4326008)(8676002)(8936002)(5660300002)(82310400005)(6916009)(41300700001)(70586007)(70206006)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 08:11:50.7672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47dbc1f-1dda-44ac-e4e9-08db3676934d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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
Cc: feifei.xu@amd.com, Likun.Gao@amd.com, lyndonli <Lyndon.Li@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix sdma v4 sw fini error for sdma 4.2.2 to
solve the following general protection fault

[  +0.108196] general protection fault, probably for non-canonical
address 0xd5e5a4ae79d24a32: 0000 [#1] PREEMPT SMP PTI
[  +0.000018] RIP: 0010:free_fw_priv+0xd/0x70
[  +0.000022] Call Trace:
[  +0.000012]  <TASK>
[  +0.000011]  release_firmware+0x55/0x80
[  +0.000021]  amdgpu_ucode_release+0x11/0x20 [amdgpu]
[  +0.000415]  amdgpu_sdma_destroy_inst_ctx+0x4f/0x90 [amdgpu]
[  +0.000360]  sdma_v4_0_sw_fini+0xce/0x110 [amdgpu]

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index b5affba22156..96b0c3d42346 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1870,7 +1870,7 @@ static int sdma_v4_0_sw_fini(void *handle)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
 
-	if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 0) ||
+	if (adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 2, 2) ||
             adev->ip_versions[SDMA0_HWIP][0] == IP_VERSION(4, 4, 0))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
 	else
-- 
2.34.1

