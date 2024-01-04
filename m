Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F65C4706F
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 05:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEBB10E034;
	Thu,  4 Jan 2024 05:16:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A6BA10E034
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 05:16:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhUfgHmddDoktnPPcP4vRDGyB7+3NrOampyJ5pHIhwz5Izl7tdq4Y4Rx3IT91IaE2O+Xu1Kn9OjB9T+xWFpcUdNvymmBBBxBf/U8bdJKxArJi+a8D8W690++DFQuNbmUDnttzzzJmVOEVmOQLZdK6OkpXSDMDApkRoydc+CRPQpOA6JCxGN/xwOCmM/S/C/yL+ZSCta1D3NSZ2Il/6c8+RfOPhRRjF2IufRQyyVVg+M9QxGD/JJ2I9lka9bDjRT9JFrcFpfHhDAFicDREr2Sn/GlxleWeot1NyKb1aPnZI9BaGi6TyLNzLJJAkF4aV6k9URQLpAfJzR4MSOLZ6GgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYftlYoN3Bd4QNY4QYbxtzogX5M6hT1P5oqT5gSIH0s=;
 b=cvmChhDCv2cSE4r96lXVGjTuvy9ilTzt9J+jo4J9ZVn5a/AQ5bgfJGKhPnjxVK43BI7sWhZUuDKPxJ80jqDt3rz3Nm185/CZ1jTB98i9hMlIshXQd79I++IU4m2SpaKeIn6DBQQjDTmIq5ndZsGDhO7MuJcRFaHQzeBhRad7I34y5HZP0y8Df3UGZSDUvdbZzdA982QyP2BkkYaH79USDq2XnwZ5h8z8OspiFbQspV+5+qo6vOnanbkL/DAjgrj2A5zLGiRBhzKTLVnDeO4RX4YQA94IUYRlHtee/DcLeoQbFo3whWCpXiy/4H9o//uj8oRU6OCsP/xeaJNGUJlS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYftlYoN3Bd4QNY4QYbxtzogX5M6hT1P5oqT5gSIH0s=;
 b=yf7N1SInuUPuMBGaAVLK4DRrH0O2iOvSmTgaYFemc928dcztHZ0Uqvahinod1XfOEVKSser22et7de8oaUJC/phw8jONYqtWrLZ/WNhl2GW/CHsHipwp/8kFW76Q+MG5x6fe3iwdM2jOlRcX3S3kmIRMfWUJ4XsU8++Iw+zkaDM=
Received: from CY5PR15CA0218.namprd15.prod.outlook.com (2603:10b6:930:88::21)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 05:16:08 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::80) by CY5PR15CA0218.outlook.office365.com
 (2603:10b6:930:88::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 05:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 05:16:08 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 23:16:06 -0600
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Support poison error injection via ras_ctrl
 debugfs
Date: Thu, 4 Jan 2024 13:15:42 +0800
Message-ID: <20240104051542.3770904-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e8c927f-c10a-42ea-d62a-08dc0ce4424e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIUFaNtFXl8wxymvOqAjghfa5TAFylis7Hc+3NfdlNfdcpUK3iBp5IHy7AA49KiLA+XfQIH2ES+8e9EutmPm7bbXUudHVKUyT3xU9/p+xgJffcDp0R5Vu9jgoJKvswC7+Bii78jzDMIE5z2BgfFdLjJaf+Nm20V9U9IvDs3TGx/+sDJh0Zm+SnNeGfe3jjRTAYkyBIqbUEtUYb8wSu9L36U9VxLBrSE0jkyzXWA1m/air0uisqdT5TPr/CS9iNKFNbDytjp9ThjQ+DJ1PWjT0Vq+jkbRjBPUVbe1Hu+Xg1oZtDtcOvKk3AG4VovXvTgHe4tAHs5hO+4ufedTIi65hMzu0IF9hnGL0p0YPB+SHgK1qxFWQZ9pAzsW7GCtszHwDGkK/GKhgk3CqB4dMQ4asyBQht1FCBhXkGZSiuX/C0OPsXxsV5wupPSaPVea0ZFhb3P5UkcXM6YxTMZS7YZ/7nTjjTB447pE6SJmeBLYze5MO6bMz2B+XxHT1syJYQus4P2JjPLUUK7yVZGiwYrUdvudujzoItIDjMEoCiv+mi5PYta8IqSI+Q+rOF3+Y0KnBIKF71Ze/Re5uT7+s0Dz1TBCFaCW/7Jdw7CBa3R30JWSoHgcpY3offsOvF0W5UvXEsYlbUGgiavUO3o/foT+N/5+G0A0ARuGCyg9yHSQLv0y0fQEsMHks86aSWfg81tmJ5Peee/vuRGEtd2Zx7GS7IzgOx1bbN9S2hMI+17bRsA1lCfrbqSYrwSHftnsl1cVK6JlwELXR2h4q1sMSFCWMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(36840700001)(40470700004)(336012)(82740400003)(356005)(81166007)(36756003)(40460700003)(40480700001)(86362001)(16526019)(426003)(83380400001)(1076003)(36860700001)(26005)(8676002)(41300700001)(70206006)(7696005)(6916009)(316002)(478600001)(6666004)(47076005)(70586007)(8936002)(2616005)(4744005)(5660300002)(44832011)(4326008)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 05:16:08.3369 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8c927f-c10a-42ea-d62a-08dc0ce4424e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Support poison error injection.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index caf00df669bf7e..5851c7a80a5a8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -305,11 +305,13 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 			return -EINVAL;
 
 		data->head.block = block_id;
-		/* only ue and ce errors are supported */
+		/* only ue, ce and poison errors are supported */
 		if (!memcmp("ue", err, 2))
 			data->head.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
 		else if (!memcmp("ce", err, 2))
 			data->head.type = AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE;
+		else if (!memcmp("poison", err, 6))
+			data->head.type = AMDGPU_RAS_ERROR__POISON;
 		else
 			return -EINVAL;
 
-- 
2.25.1

