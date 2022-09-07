Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D522EECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 04:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D15D10E213;
	Wed,  7 Sep 2022 04:54:06 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A43C410E1B8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 04:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mjur5mAxiuKkh+N9VkkzGe91wP7KDhZg981lMTs7XMpk9NpluS4lb6KCPV763hdM1HlzEkO5Zm2j3pJ71nvX/mN48fZBHIwGVZJqSoMC1sxbPNbh3yHQVsx89kFiWSGaGmAVWRzAxDYSjyxSOcJpRFtBRZ51gQR0UhnwWQ3K7Zk2ig0XRXB5l9EMaZ9+elUgbfV7d4jLsNePUjQ9SSUv59nO8Y2PzQpV/4tt/1Wkv0khBKR09evJ92LydBhouBhlYXNysiT0hnjdQhX1/P0/Wrl+GsTjfbXIyfnFSseDCmFOXwR065MY4koURDcFx86vCBO4B+cdbC9T2QXDgi2eEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4k6FTDD97tMDIucFCNpmrCMW4L/PSsxeuWN8P/HRAjc=;
 b=Bu4mQ9iaN1UuT064pmvUJdPXB846M6W59jqb1aeQY4TWQw3zkFyO7TUI7ANhzh+781V52FnSWdyWVVuid7ayOJp+MTnANn+4PlzpVvCcNFuzZtT9iOi1wREEubMkuedKDO0/IJOUdQJx3WEjKSvRfEikNhCNw9dDpOIw3xGarXpJLCrBVjTmdyDXJMoQnqKtOYIXrbR34zgjH8NbaL3nxzHQW5hW5wxJmQFfNMeOU1aLgPP1AIXym/EZJKqpwGhifFAiWKPAVlYTxQx4BxK/VAxmpGmynNcof7HzW3vKcyTSk64PaXgkEYARvlKavXizV8HVSvqMnZUWT1CUSjtGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4k6FTDD97tMDIucFCNpmrCMW4L/PSsxeuWN8P/HRAjc=;
 b=CYdowMxBMsPPw65wPo6e12nwfpYISI6D2DphKh7Jy2NBy8+v2CTWfy6lfYaRx7PndK+cywAy5qJ/kxx5uLxpmYFdfBP2SrpcsBAwovMYnLnfuAjyOIBfQynPnH00lDO84uY+lx6y5kntPPy1MJzTN4MUaM33LOPwgfvnXgLsAww=
Received: from BYAPR02CA0070.namprd02.prod.outlook.com (2603:10b6:a03:54::47)
 by SJ0PR12MB5472.namprd12.prod.outlook.com (2603:10b6:a03:3bb::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 7 Sep
 2022 04:53:57 +0000
Received: from CO1PEPF00001A5E.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::af) by BYAPR02CA0070.outlook.office365.com
 (2603:10b6:a03:54::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 04:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5E.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.11 via Frontend Transport; Wed, 7 Sep 2022 04:53:43 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 6 Sep 2022 23:53:40 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <lijo.lazar@amd.com>, <evan.quan@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: drop runtime pm disablement quirk on
 several sienna cichlid cards"
Date: Wed, 7 Sep 2022 12:53:26 +0800
Message-ID: <20220907045326.2881218-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5E:EE_|SJ0PR12MB5472:EE_
X-MS-Office365-Filtering-Correlation-Id: 24674db4-e656-4c92-1603-08da908cf8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0XZsS1oLKILpjLuLF7soZHdqj+XXZMNwn1NyCjC6zLayucb0LQyDQHtCU/pykAzh7lNprhZIiH4OFZhVf06xrvc/A3SSsvxydCwVTte3WmcUJYBl2E1eGtI84Z81f6hVj4F4UTpvERGeUyybMHcepuEb/xxSPMDWPzihOArzldOBoIDw+YsYHw+h62rfkA2Q+VrMXWDbxtpqAEMRESp5gHPvjorg664/+2K9VVHyf8HG9e7Q+0Ql3RObCotdL3iPbNsRddRw1daWzN7Zx7f6s5QbqjDuz4yHPhFki2AW8HvwA/+F359fmQ/QpLOITjETHJ3RIzUQgscqwJZmderI+5/8fqDfh7rHSQsdr4LV3qbWIuNFpylwGVE7I8To0d+n7Rhn3C4OEb7nBHKeGDEj19h3UioP2Qm0ibG/4cizTsGMwCuuOYtNbQ3dV2RKyG1AwEWeYDaQwiNaNcz9Js8gJncM8QcSobYLxChTAnyrG6RAWDfSrflenkCT5PVN9C45ffxpeTyU+lE58JT8S0wRpvWaDRRc5up8cmfPRdL86z2dQjY5zjhUoH5ziDVjD2lMnWRcQB/NcXt3PMFy0xH86x0L39KqRkWXLBFzbjV2oT9uxIcnb8rqV74J3lo8+nHg9MxycJ3f1wXam2lJBFbdSQIjdh7lEDFy3Jy8l2U2CVwP71SUVZ12bBKAwLqXnvBF89lU7+5KKsGumSLoop5ao671zekymddqr346EprD8qt+CzX8XDATk+7ba7fza+h+wywX9BsNCdx3MbeCJwNfecZxLN3SDYB0tFQm+/jAsEjRucQGHqOljJXcBveP/rXeeyQ0Cnti7Bxvf0o8RwLcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(40470700004)(7696005)(36860700001)(426003)(47076005)(86362001)(4326008)(8676002)(70206006)(70586007)(478600001)(82310400005)(186003)(1076003)(44832011)(41300700001)(8936002)(2616005)(6666004)(16526019)(336012)(5660300002)(356005)(82740400003)(2906002)(316002)(6636002)(36756003)(40460700003)(110136005)(26005)(83380400001)(40480700001)(81166007)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 04:53:43.4974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24674db4-e656-4c92-1603-08da908cf8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5472
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

This reverts commit e2994d23d8afa2fb465fdb8cf544b736f67ab8ba.

Frequent BACO enter/exit will cause EMI failure, so disable runtime PM
on these server SKUs.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1369c25448dc..4f6473faaf24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -43,6 +43,17 @@
 #include "amdgpu_display.h"
 #include "amdgpu_ras.h"
 
+static void amdgpu_runtime_pm_quirk(struct amdgpu_device *adev)
+{
+	/*
+	 * Add below quirk on several sienna_cichlid cards to disable
+	 * runtime pm to fix EMI failures.
+	 */
+	if (((adev->pdev->device == 0x73A1) && (adev->pdev->revision == 0x00)) ||
+	    ((adev->pdev->device == 0x73BF) && (adev->pdev->revision == 0xCF)))
+		adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
+}
+
 void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
 {
 	struct amdgpu_gpu_instance *gpu_instance;
@@ -176,6 +187,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 			break;
 		}
 
+		amdgpu_runtime_pm_quirk(adev);
+
 		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
 			dev_info(adev->dev, "Using BACO for runtime pm\n");
 	}
-- 
2.25.1

