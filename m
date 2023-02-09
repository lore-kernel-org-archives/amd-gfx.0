Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8999BC05027
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 14:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F64C10E228;
	Thu,  9 Feb 2023 14:12:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD57010EAFB
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 14:12:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTB5aSBZFm+m2YwUOOQ4oaqgwLbZgWrgEHy9CH8UMGqaUR49QAzQC31x9KrY4GgHgRwc1YVdhYABnHPWxJINd0wxxKG72uBt9Q03aL2DEamA1KbzxP7VwPmjTfLdKBKb70vw4RnI1Ob16kcrHlmXupquF+ZgWKuLi7oV0gOoebNZc/7GQxrFMnBLlK7T1wVZVJSnD0EfsaYHUh17KrwGzVs7y/xNM7j+CPYzRW9QuDk+ifXiqGSX0DQAUVIPTcrXn7XaXSK7cKNoX7McS66vmrTxmbwq1Pjzb9lDOjJPtWEsAy2r5LCqsPa9NlUTnsohb3K0X/xIQ+1OGQVj/pXO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcaE1/bjwn/h7wNhgfCxDe/NMA+2w0HzmYA7Y9j8yh8=;
 b=NqLbtZ4Br7qPuxwx2UBT+dPXxUMDG/JNmGK8/8jamRr3QqQw6+r0SrtvJsexLpIi/bK2fSdtLNq6kvHQeiFy9V9C7W78xxsnpK8buDMAniW+TMjRR/coTPS0pObTu7WcX3Okr1z0iJfJexm+rornVZ7+/eyGy1HbR47xEcNxQ34x6wXJRfDf1CWs3NgzPqRe3nvYDfy+8Rh/lzKNdk2jF6IWhi6BDdvBFQ52gPQI0sSnPmP5Tri4hBKtA3bU5kyTuGj7jTTOk9jqY4NwSUxJLSpWWc9XPFVoYF7WIyfLRrUJgK2DmwUy5nJ2oqPy2FXI48IWjRSIoplG2rDTqYbhaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcaE1/bjwn/h7wNhgfCxDe/NMA+2w0HzmYA7Y9j8yh8=;
 b=cQSgi321v8ER7A7HCQXXc03ZzkAxz1yBY7mcHjTZmTe0khYjsVlJ3dkBTAvX1nBzQlpFdKGtyMDI7WjqOv3WN6rBa4bxxOQwDtuk4Dgb1eyS0AYh/gRvut72dawq8VozJuVPlr6Qfa0Zeu94advM56JiSu4fSV+dkcp3U5Fbhmc=
Received: from MW4PR02CA0022.namprd02.prod.outlook.com (2603:10b6:303:16d::15)
 by MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 14:12:04 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::cd) by MW4PR02CA0022.outlook.office365.com
 (2603:10b6:303:16d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 14:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.19 via Frontend Transport; Thu, 9 Feb 2023 14:12:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 08:12:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: add S/G display parameter
Date: Thu, 9 Feb 2023 09:11:47 -0500
Message-ID: <20230209141150.612825-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|MW3PR12MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: 4881d649-9f25-4e91-2359-08db0aa79f1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mDvjqO0hyfWT9uep39ieWMBxqSHo1XWFkYjYVSCfojya0o7vwgDwEYXBQ/QCgB46/Vv1/zc5UBq+eWJCyuJrEbeecTpZfSVbC4+JVgOJ1R7A0xs5TdPV3IGSCsEYD7EJH4Q8rqhhP5aSLXGz0hTMK4rNqspo9u8T/6vfjVJMjLVt6J290QBtlj0mPrV7WLWVpAC2t6J4J6hRnX99iRK1WihKt9wEuVq00aevogpBQy5eBjiRfCRlF6Gde5nntY/nJUZDNnyRCPJD+SQPjdnc4N7HZQEcWO0B7J18pQy+HMLpy3JXaDRx+KGGxJpjXVuEAmQEw4VQFQp2sjprhj5d9+PUnehFE220BiCniMzT84til9ifMzbTWqtRUBbyBB8s+CQF+7IYvLtQPZSh3tkcV5APHUsSdrK84G8qGoXRElnAjXTT7CNXyFjxrclS2vEw92j1URtKnzAEB2fWgwfBwEXFynpKA3sQjAIJ8PYAgGNm3TVfhY1jnLCyuJgMqV0JIIRS0TohpuRbsrHhwsnCO+GQn6/Ja3CrP44aQkoDjvkbTWp1Ro48O0P/6Xs29FUVPoOJvH4n5yBbzcNDTP4RMi/aPzGbbx3RQryyU5qsgC8QwAPqvf5M9DW2FpZFZ/WT9Z/hasLOBLpWqM7pFDIjLgEHHAhN/XK9c51U+de+aA2BHkd2fHNAW/QaN98pxUvf4sM0Dc68q1KHm09X6dY8pxmsQ1FqcqOVZlK9PByURPM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(36860700001)(82740400003)(2906002)(86362001)(81166007)(82310400005)(7696005)(40460700003)(47076005)(426003)(16526019)(26005)(336012)(356005)(186003)(1076003)(36756003)(40480700001)(2616005)(70586007)(83380400001)(316002)(70206006)(41300700001)(478600001)(4326008)(6666004)(6916009)(5660300002)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 14:12:04.6928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4881d649-9f25-4e91-2359-08db0aa79f1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some users have reported flickerng with S/G display.  We've
tried extensively to reproduce and debug the issue on a wide
variety of platform configurations (DRAM bandwidth, etc.) and
a variety of monitors, but so far have not been able to.  We
disabled S/G display on a number of platforms to address this
but that leads to failure to pin framebuffers errors and
blank displays when there is memory pressure or no displays
at all on systems with limited carveout (e.g., Chromebooks).
Add a option to disable this as a debugging option as a
way for users to disable this, depending on their use case,
and for us to help debug this further.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 64f9cc6fbbf0..187597024c1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -242,6 +242,7 @@ extern int amdgpu_num_kcq;
 
 #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
 extern int amdgpu_vcnfw_log;
+extern int amdgpu_sg_display;
 
 extern int amdgpu_force_sg_display;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index fa3788bb6a2c..afa5c39c9c74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -188,6 +188,7 @@ int amdgpu_num_kcq = -1;
 int amdgpu_smartshift_bias;
 int amdgpu_use_xgmi_p2p = 1;
 int amdgpu_vcnfw_log;
+int amdgpu_sg_display = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -933,6 +934,16 @@ module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
 MODULE_PARM_DESC(vcnfw_log, "Enable vcnfw log(0 = disable (default value), 1 = enable)");
 module_param_named(vcnfw_log, amdgpu_vcnfw_log, int, 0444);
 
+/**
+ * DOC: sg_display (int)
+ * Disable S/G (scatter/gather) display (i.e., display from system memory).
+ * This option is only relevant on APUs.  Set this option to 0 to disable
+ * S/G display if you experience flickering or other issues under memory
+ * pressure and report the issue.
+ */
+MODULE_PARM_DESC(sg_display, "S/G Display (-1 = auto (default), 0 = disable)");
+module_param_named(sg_display, amdgpu_sg_display, int, 0444);
+
 /**
  * DOC: smu_pptable_id (int)
  * Used to override pptable id. id = 0 use VBIOS pptable.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bf06875e6a01..1babdfaa789a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1576,6 +1576,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		}
 		break;
 	}
+	if (init_data.flags.gpu_vm_support &&
+	    (amdgpu_sg_display == 0))
+		adev->mode_info.gpu_vm_support = false;
 
 	if (init_data.flags.gpu_vm_support)
 		adev->mode_info.gpu_vm_support = true;
-- 
2.39.1

