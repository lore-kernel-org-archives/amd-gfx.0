Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FFFC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 05:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CDD10E37F;
	Tue, 22 Nov 2022 05:53:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1728D10E37E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Nov 2022 05:53:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6XpTe/4PbPkTzQDzpID2eYKGfQXUhfue42fopxno89LFZVgd83jcZM7DQNsswqQzstfcHtA864oajZUG5FASKesIOX4z9waoI/ZgI8fNy49/7aRLVV+wMpieag7H6x7HbigJN1iOmWIy6E/WoFQyTdl6ZQePsCVN9mAQMNCLbPzLiW/DK+BXxAbVLTZ8gSQhHN8JyVX35YJ5fcA3khRgZLvRVwhsyD9tdcLkMKyd8MTy3lPDxTh2XjfvdYvB8o6mgHuyLgcMvlVbkHI9fcJlQWrM4nJpqBLyMzj2dqbQe/vRlVdLxgh8ssuw3W5EnxPMpkxTmG/PoW6YJYtoe0O8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U5KBC1v7AlpViL/Mn3fb1uGgFzp24lx59iEvDbbmok=;
 b=T5u8emAR7Cw0AM0sOZOtaeVr7Jrf8c2eclWJHlBL0hW0ax11xT0tc0063a4EZuXbHUT5WQl86zfcBD+kBBm+pNbP1mmKaylGNe9pOJJP2TF3QpEbFuU4seWk7rzks1c3Sp2ttvtertV3IFsMf/BsylscH1RGXdbmNxuqVK2o78gCHO3MNFXTOO8wQ85GXBJ2Lg2BTwXBacb+7+c2RpGoBglUp9ErvOxNkcXbwOcB/p7gYVUrc6P1Lyzvpj0SSuXmcca/NviEvahJa/tr1Ymjwjd3u+1zzcXb4vYMXeorCUCyOJA0O3xVBWIBY8fpZ+gaB3WITkrWIZVIEQ/Ww7iO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U5KBC1v7AlpViL/Mn3fb1uGgFzp24lx59iEvDbbmok=;
 b=Ex/WL/2aQbORh2sed3UxbEx4OCU8ugXf60SoPyKovrEcdBdE/yR/zjVKPGKI1cvUG1zlGzzU4xFOiiwQ/HlquE2AOMZz4tqSHhwlaI4Fr5q/9cYAVyjyUWi9A6lwuMZNVSDhx9gxX4sNJpnxD2uj4TuPoYpa5Kt4+uh8bXfYZKQ=
Received: from DS7PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:3b8::24)
 by DM6PR12MB4092.namprd12.prod.outlook.com (2603:10b6:5:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 05:53:00 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::d) by DS7PR03CA0019.outlook.office365.com
 (2603:10b6:5:3b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Tue, 22 Nov 2022 05:53:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Tue, 22 Nov 2022 05:53:00 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 21 Nov
 2022 23:52:59 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/19] drm/amdgpu: add gmc v11 support for GC 11.0.4
Date: Tue, 22 Nov 2022 13:50:16 +0800
Message-ID: <20221122055025.2104075-10-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221122055025.2104075-1-yifan1.zhang@amd.com>
References: <20221122055025.2104075-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|DM6PR12MB4092:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f165415-bf09-4625-b8d2-08dacc4dd098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bn3BjQODsU40ghXG+LxqAZvyNC8/y5fGmC6prGjXh8XPXvM7ubMqw7EVVfCZq9n7JxA11TheHjWYiSSzhLJoO6msnDyYk1iaVAu2y7Ztm5fsrlUoV+qzlu7Pjy2viG2ggJMiVR3WTcSNoJNvf4hKMi4HbUxkj0L8XzrUhsdCM8PXWHY8TJ3UhDQVrZtCmLD1QLELrvRiRiLzPeLb2D2loklp63u2Y6LZO8fRJ8T90+Ux516BrwSzYiaMJzoKRcDGFt3+CuZ3iTAsrBu5ZQeKfyWbc+/GMfoEFY8JXF+p/LhU7cv1TPCOlx62JO9UTryGoltUfTNo2m1WboJQYSbj3K6/ETXVj0dkkeS1pRVfo5rROnUFrk1TzsIVBjcwltfGP1Ivq2G3akPRB6/v+0IP+R0VLzXUiMpcUWAEAMCoeL2uiTOt9s3Z/swiFqwiOKo+/eevmgDnfmdHsGUpIVO50sDFFuJxj3AsekQkIQ6IQxrSxlDaYYZdhR1swSZCq9WBPhenmldpicr48YhEIRSSD5wBeEQ45PIAK/LYBx/RreXyqPwHs/OuHm5NtlvDcgFr1Mvb82WRptmm7TDlQ+NWQqHe0UG1KsiWTErJrSs+H+U7YQj30wAEEz9Fx4aOqQJyKd2EdDSu/h86l74X/gL4JVEs71xOqjWSMcAHFEXHu65wySOwPU11WE+ab41JcllpO8xWOf0Uo2lzXoBFbFkOBc+uq/BetCk6k4rdy/ooIMGbCfLemGkjAobEUo1xXf7ByjYc0ZtQQQsmJIWOmR+qOokw3uPVpoprIV9m3jnrajI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(70206006)(8676002)(70586007)(316002)(7696005)(40480700001)(41300700001)(54906003)(4326008)(6916009)(26005)(82310400005)(2616005)(36756003)(6666004)(478600001)(4744005)(426003)(40460700003)(82740400003)(47076005)(2906002)(36860700001)(16526019)(8936002)(1076003)(186003)(81166007)(356005)(5660300002)(336012)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:53:00.9783 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f165415-bf09-4625-b8d2-08dacc4dd098
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4092
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add gmc v11 support for GC 11.0.4.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 96e52ec0fb69..4326078689cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -759,6 +759,7 @@ static int gmc_v11_0_sw_init(void *handle)
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
+	case IP_VERSION(11, 0, 4):
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
-- 
2.37.3

