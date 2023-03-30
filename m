Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3D4C6FD18
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 02:33:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E2B10E049;
	Thu, 30 Mar 2023 02:33:45 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C67A10E049
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 02:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ldsMn1xEp8BMQBQdhX6cDwFCf1rbRuZiU/6c+8qal3DL4T9NHC6vNXyN57H83AN60ll2bpWw7Tdk7lrAKMPes9Bdzl73jIsQ5Uxi3Q6wC/b0CEn6tzRfHnHzHe6CiuTZ6umYPCdCIQjmIjPZHZY2Ci/1ePkqbYLAns01Xtgm9pZOmbSGvrehbU/YM5TPqEUwwjPxlTP9R3oRgJgByNtLpFOW1JNWmA3MjgX6eLy6sRcfMF0h1RtAVeII/fU0uDMWt7hYUSEsSVAqESOHrHdthzypZLFCzplGix674j9bLHncQKxMo/sLB9qovR6KFYuAEWpCX9sCLJPLadWpJLlyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4rS7bn4FWnLyYIoUKrXnPZR2kHJBJSC2d0Mw4+J9ro=;
 b=ILslL4ZIoPdVdWrUQJs5KDzGizhvO60zec6T9ooakE27zM/P+MlUe0WWMZY0pD/vfDnewDV7S5EM9mK8DYiyWmD1l4FcR9lOZzbEpRg2BYqlMpBLVczgFZkTUCLwlHKJtWjOOcHutWnONs4g8BQnpO7//N9Bsb87RxXrOuLGTnGe/AVcsWkmFb14eyfZu1cOX2F3XiSOg6kDaRIBRkpaIf1aoYLze339e39DBuUbyrnQq2LyAcHrL4/m6zMslG/fhvMhZDdUrD3ec3kHFL/suPVPNDanQ0wRWV4sgiUvOQ9SRBJ0dxAT+lIMXaqv/He69mMNrqHiQ4olG+BuP4VVkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4rS7bn4FWnLyYIoUKrXnPZR2kHJBJSC2d0Mw4+J9ro=;
 b=bZNIbkmVLX60sMV/SVh6d4aquTFGB76NglDjexcsyzbDSNxVDH+eO3lPcpwaSdRhAecJBmjZS5OmaiNEyoEHUn3q5NvcL6hidls45o5SWeLtW1nkWC6z/wsulsL+jpkZ3NWpQ3EFjvWghc1o3L9ElXrGsrsuzPfTcRFigSFKGzE=
Received: from DS7PR03CA0295.namprd03.prod.outlook.com (2603:10b6:5:3ad::30)
 by DM4PR12MB7720.namprd12.prod.outlook.com (2603:10b6:8:100::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 02:33:42 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::9c) by DS7PR03CA0295.outlook.office365.com
 (2603:10b6:5:3ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Thu, 30 Mar 2023 02:33:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Thu, 30 Mar 2023 02:33:42 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 21:33:39 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to S4
Date: Thu, 30 Mar 2023 10:33:02 +0800
Message-ID: <20230330023302.2466048-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|DM4PR12MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: c39aa0f4-ac68-4043-19ba-08db30c72db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: egHBY5LnziGAVQ/+DKHj1NTUYDMImEHknhxaZmdR2K04AmYttKs9LMNA6dcQd+H1tiVYhfGWPF+G8NyLMiqq2dXoLmCHy3h2W3qC++LOba7+OcQRsiyZIIZiwYAoJOdepy5eUFcFtIqfYOAMqzo5AfG7TggsEubvVx/l48JiQ+AwfydgjH6NPruRDeliNbrvKDa0XiWRpoRP6MSt9Z1LSvx/lmipw0+D8mhikPDnZXkQi5dPFBzTyOrGZZnotbHsPz6fXF1G76M8zve6HnWD1zc7pG8cJH13yuUwbgEv3peqWotG6j7FiJQfjKV7ECuHQmHCwxGJ4a0JP+VdRjeX+hH5volKq30VAW3xclyyLVhnvJSpi3w2sJ3AHeMqLqI445pVyIjBwZriQN3TdqmuV7D4M/nDnucktijzRlIRPeG6LtD7d9CoM7v1wLWB6wM+4p8bZ6k1AYvEifvAvVUa5IbLtrgiR0aZbZmuLY+N0eYfdcwWKHpM4Z7gck++jpkxQCF9qrLm4ePJb0MionxwE5Ox9D5qXp7KwqEVkRDSgta2uIT05r9s8faaIMjlom1E+WFduCx2HyqcPugfthXhDpbpXNgK2eqd7oyBc7esOLrIW0vNdDtAjFtPTWy5NsZuqhsgCpcAYD+6+JZmx7HSJw3O5imgyzdXH4kc8dPd1agGm9PPjVFoDnY0EYppUakQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(8936002)(44832011)(2906002)(5660300002)(316002)(40480700001)(41300700001)(40460700003)(966005)(82310400005)(70206006)(70586007)(86362001)(8676002)(7696005)(6916009)(4326008)(36756003)(54906003)(478600001)(26005)(356005)(1076003)(6666004)(16526019)(81166007)(186003)(82740400003)(2616005)(426003)(336012)(47076005)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 02:33:42.5966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c39aa0f4-ac68-4043-19ba-08db30c72db6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7720
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
Cc: Yifan1.zhang@amd.com, Xiaojian.Du@amd.com, Tim Huang <tim.huang@amd.com>,
 perry.yuan@amd.com, Mario.Limonciello@amd.com, Alexander.Deucher@amd.com,
 li.ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Skip mode2 reset only for IMU enabled APUs when do S4.

This patch is to fix the regression issue
https://gitlab.freedesktop.org/drm/amd/-/issues/2483
It is generated by patch "2bedd3f21b30 drm/amdgpu: skip ASIC reset
for APUs when go to S4".

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 0f7cd3e8e00b..edaf3ded4a04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -981,7 +981,12 @@ static bool amdgpu_atcs_pci_probe_handle(struct pci_dev *pdev)
  */
 bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
 {
-	if (adev->flags & AMD_IS_APU)
+	if ((adev->flags & AMD_IS_APU) &&
+	    adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU enabled APUs */
+		return false;
+
+	if ((adev->flags & AMD_IS_APU) &&
+	    amdgpu_acpi_is_s3_active(adev))
 		return false;
 
 	if (amdgpu_sriov_vf(adev))
-- 
2.25.1

