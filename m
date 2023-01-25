Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EF3C54E94
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jan 2023 18:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 991A010E11F;
	Wed, 25 Jan 2023 18:19:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76AC510E11F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jan 2023 18:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQIn2zHfwAh7YsPCyppXk7U9BqCD5jbMxFgaXJYaGgdPDq4nhseuq8pcMwivvDTUy25+n7+vKaBoO0WoTpwI+yjAfd8ETvBNDCDnRZZ/8GWWdiwQ9PzB38VUbNnAjPgj9XW0UYrE3FFWDeGuI/9fO5QhOlRsDs9vTsftDm4xGcsMZVDM0o6KsoDe1j2GHc/C4dR8B6UqxOOnCulGvNaIAuV0Iz7W43GU4nMAErZRXMSfnKQT1pwL7SYXF8gXO306cfwBOZYHRiSGPKEPhVw7TtwNRoAsdEeOoIWaeEgbt9wE96d5JKL55YsKLgVExH6xonyvvsMPaoDNEJ6ZgpRsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpTSVbFJou/hCne7HwTKFbe25r1HyMTjhCpSRbmLLXA=;
 b=FsEcqTIJNOSy7o8fnoHysZueNBK/agCktwPu6tdC4HWxu7S+06WeYWfcHzytoTYoKceZZZE4uoN8LJ5Uv7L+dTeOtcCJCNqlKkcC+VxKtkYZDcoiyfW7e0wc5zyFbqr+be13CNwN5k0UHVGzRkT7i240VUIdtML/jjIc+O9yM7/jNKgqEIcyKZNDPW+lJ3ZXdHNbhHg0YRQ+JVhrTPuL4d0M4BPAOkJIUHNraL2+ACDRX3g5895PI2QYnm+ojVqLeDudURsS7dcDLMVJ2rPyL1IThcWMPd0ZNMzlWB9lGKo9GYQv7RuQd/nBvVHrlm6W5YxQ+ItjBvXIkMMSuv2gEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpTSVbFJou/hCne7HwTKFbe25r1HyMTjhCpSRbmLLXA=;
 b=GcyOXwWxUcMicp0Q3TomaasUHCjyHWFS65ZRfBKqtU/pd6cqKp3rBv/kEptBpVowPmYPPL+SthtzhF418ZAkpVyB4xT75bBbPFEkSw7HTKgCG8Qjr8Qb4OS4C98RN/bpYXO/iHVb7MvJYd2Cx+l23OPh0c/VZLXb6Q67gNlYCNY=
Received: from MW4PR03CA0033.namprd03.prod.outlook.com (2603:10b6:303:8e::8)
 by BY5PR12MB4951.namprd12.prod.outlook.com (2603:10b6:a03:1d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 18:19:38 +0000
Received: from CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::d3) by MW4PR03CA0033.outlook.office365.com
 (2603:10b6:303:8e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 18:19:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT078.mail.protection.outlook.com (10.13.175.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Wed, 25 Jan 2023 18:19:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 12:19:36 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: disable S/G display on DCN 3.1.2/3
Date: Wed, 25 Jan 2023 13:19:19 -0500
Message-ID: <20230125181919.7719-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT078:EE_|BY5PR12MB4951:EE_
X-MS-Office365-Filtering-Correlation-Id: b28be276-06ab-40ce-5242-08daff00b84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kD2R6n8iPNdTBXuvFxIk8vclIRDTQy0fy/5gGp+spHDr2VcdmOmvsEV7oh9C/ZPqo2sO6Ji2KCPz6lwUjJerYl+K0QH+gKKwbZTD/PBs9s5ian1gsRFjT2l1/eDk6eQmWYreb/nfOPpfcq81SFtnAiHcgvAmX3ni9g/nAFaPfVmowqj/V/5opzUda+M4EiTGrfvLs76PrdHmLBNNGcbaM3lxu1Fp5me05p+wX2CwLRX52czov79ZbUsMQWLIXBiZPKTZN+4qgoV4GeP75wjz3zfNWl+v7Rzby8r1kOEeL5MnxyN9c3rmhetFmrJlB2duVgXpA8ClbdEJRvTgbQ0BrKV5Ew49SoFWka7ayHdmVDD6O/9cfyqQw/H3STf7YWqg7s6DpT2TDyKqvrrNZOz8MIAHpcTQPSyNloIeL91miPaKsiGBpQTyuUrKKVYQKqOY5RXx5ijgrMQbhwXYvix8B/IT8Y49In+tu6miRSsHv5yRFpdGY+0hcR3uns+EglYANsmxET66EWE7S1r+CZD/ZE8xUrlBpQsWWarbd1ev93aFWrKUDc1SYMgAARYaDu5mySFf9UEBoPL7Fs5ttHIjggHfupHL4BCi3H6hiur6sn9eSq3TADGPybt2F6fnlQy+KeBMW70EVccWHSkxptsQN8P+fm6KGPbBu71EeLfQ52tVrv49rctiiEX1cmhmBxf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(6916009)(70586007)(70206006)(40480700001)(83380400001)(36860700001)(4744005)(8936002)(82740400003)(47076005)(2906002)(5660300002)(40460700003)(41300700001)(82310400005)(54906003)(426003)(36756003)(4326008)(8676002)(316002)(16526019)(966005)(336012)(478600001)(356005)(1076003)(2616005)(81166007)(6666004)(26005)(186003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 18:19:38.1785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b28be276-06ab-40ce-5242-08daff00b84d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4951
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
Cc: Alex Deucher <alexander.deucher@amd.com>, yifan1.zhang@amd.com,
 roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Causes flickering or white screens in some configurations.
Disable it for now until we can fix the issue.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2352
Cc: roman.li@amd.com
Cc: yifan1.zhang@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 42d99bf4bbc9..0c6b60183b0d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1536,8 +1536,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			break;
 		case IP_VERSION(2, 1, 0):
 		case IP_VERSION(3, 0, 1):
-		case IP_VERSION(3, 1, 2):
-		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support = true;
 			break;
-- 
2.39.1

