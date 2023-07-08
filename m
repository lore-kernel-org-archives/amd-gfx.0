Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48AFC0015E
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Jul 2023 02:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9771710E63D;
	Sat,  8 Jul 2023 02:26:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C0110E066
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Jul 2023 02:26:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0sIH4bcxe++q/5vF2g2GVfgIH0kji93O81CgRhFU17HhlSV7ud6s1CNqNqHzx3c8G4doZWL11BYYAWT85V0CK/e5voLxLcBr7/yLjmz1Z8qHVwVDTneDB21YSHrB/MmCmTEoRcP3ogC8gcwO4r1DIRPTAZipsmTRPg1l0etjIHR1kAeEYvRPi1fK0qv8LJ7aFz3tf+sTV7veg1fHJbk0xVb2QhyvF/XXEcOjXXnHnHWYN7cCnxrrRxIaJPDhl6FCed0ewIC/oyJedeGdfd/23HI40ctNjgZGHkyM2d5sAtvpZXgLsgVryMvTdG8/QeykvnjBxvs2sG6kw0wMoJVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqBCbshks2UCNpkP+d6sylGL6NFd3kRA52ZcU7dpyyw=;
 b=bdP073Xqg3y3Nfd8shw3oIG5/VwUaIFBHu63l2PSzC98435M3mOaPRq0pvJ3cKVxlr8EI8bNBCwqY7oj10vrkpLjPhvK+4d/UYmffIuoAPUdIIBbYS03ANflFFhVka8+ckDB0pC90zDI5lOOlSmgH/wz96/3bNoX82XMAHicpxLbk6zpJ/KuRILut4/RTYNC0OjKRHPzynMbERgqvyaxFYFegw5yU7Um+prLhd5XjquW+DM+3aPqRcMNueeBc5FLTFWMV4iVIIndyKYCS936KZRMTFcx2p2N2AjmDeUgqOJig3kZMeHkeIbDucbZsUK5cyorD15Pgxv2b4RzuIPPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqBCbshks2UCNpkP+d6sylGL6NFd3kRA52ZcU7dpyyw=;
 b=ZEmnsV5rZXt4f8eNaCKQP7H1edo1Uiik8y3GX0HgcRiFJF6mmaf0Z0Hvi9NJa5HmxOrQ1bS09S9ttcGKLxhtoO7u1r1QrIoMU0VqoJTacptp9cedF3CsDnTSrrgGAV433TDc7KuBXQvRaymbDbtOC469uXHE8xx1feenOm8Bi0g=
Received: from BN9PR03CA0965.namprd03.prod.outlook.com (2603:10b6:408:109::10)
 by SA0PR12MB4592.namprd12.prod.outlook.com (2603:10b6:806:9b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 02:26:35 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::ae) by BN9PR03CA0965.outlook.office365.com
 (2603:10b6:408:109::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25 via Frontend
 Transport; Sat, 8 Jul 2023 02:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Sat, 8 Jul 2023 02:26:34 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 21:26:34 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amd: Use
 amdgpu_device_pcie_dynamic_switching_supported() for SMU7
Date: Fri, 7 Jul 2023 21:26:10 -0500
Message-ID: <20230708022611.50512-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230708022611.50512-1-mario.limonciello@amd.com>
References: <20230708022611.50512-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|SA0PR12MB4592:EE_
X-MS-Office365-Filtering-Correlation-Id: 69639de8-8f3f-4e0c-6fce-08db7f5ac017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiuhJ2hAY2WFTAp/TdxB+a3MdGRmBwePG/pJgnXLLjA8TjeK4+VD/Po0oj10TtmRvJxba5Aduw99SayMc0d/EZdPmkAkYhyUfXEBtOTiZTaRp4KKwqnwa8fWPDZy8pvyPD0Sz9a8hKQwkrzJk3NrBOajjrvT5pNmPZIrG9ajVfBl1WZgeIgq5KN8BthMmcRHOytu2KvepVrHp62KXcgobeeeuDr6A+zIH97k/Ei5oAhzndUvXQqaBA9xK05qLGuqPt3RZR9F405Ac22ohF+fxhRaJiXaVfBC+Vk/D+IV9VyT/3sJf+qO3kINVvUqKSrUdYnQJEeEy+ux5z1wAM063TexXrFlZDmbZJlimkq2twrS64uFpi/bgnVIeh7//12oqa/LDjBNxLmvw0VOtHAc+9MswD3meOuDHEKbFowFdaT7KB8BDkfxJ2m8u1zm1hASdTIZ+mh/m/VNJ5qoUmDwIg+2XfgZCy5V+JQbqzAySS8iuXoO6Dqk/cE/wsmknnqqNaQRqpKj0IiALPU8/6SNULlyikx35VrW5nGsPe7CTwT16v26aWcXhOJCSaxQWfa6fMEZDHGT8KTyuIjEgX8WELOzpAOROHXReRwFWs4vCoRNdJzcl5aIy5QfB+12fO4i++qH7mEjmZeeWmQSSWt+I5iGxXWdAUmRViWm69ZkVM5gWTdpyaf4q1tglGiwyxFBKmA7VkZC07U0y/J1V8PP4r2nAZCpBUAU4FvIN5AnH6uIsEvnMdKQbDWABUG5giATvGHjg2IrB3gG1BWPr48XxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(478600001)(6666004)(7696005)(54906003)(1076003)(26005)(16526019)(186003)(2906002)(82310400005)(70586007)(316002)(41300700001)(6916009)(4326008)(44832011)(8936002)(8676002)(5660300002)(82740400003)(81166007)(70206006)(356005)(86362001)(40460700003)(36756003)(47076005)(36860700001)(2616005)(83380400001)(426003)(336012)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 02:26:34.9290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69639de8-8f3f-4e0c-6fce-08db7f5ac017
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4592
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
Cc: Evan Quan <evan.quan@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU7 does a check if the dGPU is inserted into a Rocket Lake system,
to turn off DPM.  Extend this check to all systems that have problems
with dynamic switching by using the
amdgpu_device_pcie_dynamic_switching_supported() helper.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 6841a4bce186..1cb402264497 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1798,17 +1798,6 @@ static int smu7_disable_dpm_tasks(struct pp_hwmgr *hwmgr)
 	return result;
 }
 
-static bool intel_core_rkl_chk(void)
-{
-#if IS_ENABLED(CONFIG_X86_64)
-	struct cpuinfo_x86 *c = &cpu_data(0);
-
-	return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ROCKETLAKE);
-#else
-	return false;
-#endif
-}
-
 static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 {
 	struct smu7_hwmgr *data = (struct smu7_hwmgr *)(hwmgr->backend);
@@ -1835,7 +1824,8 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	data->mclk_dpm_key_disabled = hwmgr->feature_mask & PP_MCLK_DPM_MASK ? false : true;
 	data->sclk_dpm_key_disabled = hwmgr->feature_mask & PP_SCLK_DPM_MASK ? false : true;
 	data->pcie_dpm_key_disabled =
-		intel_core_rkl_chk() || !(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
+		!amdgpu_device_pcie_dynamic_switching_supported() ||
+		!(hwmgr->feature_mask & PP_PCIE_DPM_MASK);
 	/* need to set voltage control types before EVV patching */
 	data->voltage_control = SMU7_VOLTAGE_CONTROL_NONE;
 	data->vddci_control = SMU7_VOLTAGE_CONTROL_NONE;
-- 
2.34.1

