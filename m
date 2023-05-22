Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D85C77B73
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 01:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6604310E231;
	Mon, 22 May 2023 01:54:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5D810E231
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 01:54:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQRAuAYsMHUCQKbcvJlPNTr/eT0zBS+89nT2AowiJTMBh5difh8OsKwMHjI7HseVM3ZAVgO0biHMLmaOTrprrLQdCYP1uam+PjSbkYWt4ePh0r6Z7JkH2y0gVt2P6FCP9J7wmawPOaWxAWJsr0EZVG+G7Kr8yx9CsgfOVvfD5lk80gdLk4XYUi/HqRI5xR/hSHkwt9tSntYa3aGY6/M57AoRIZzrvmgQhBhbmlbCo/ZC4nzO2xqcDxklEVNq69wzTwKlZFnhLP/VLroywK9E5Ti5CbQnhkVjgAgpaN+oq7pWHajJemPrM6QwIBRviS02doTgmWH4mNsFQdD+JULsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTbAMlxr78bJXglcYy/uYanjR83Wno7hDWwfGT4oVyM=;
 b=RuA5NOixM8Zc2xv6Htt6st/+RI4LRBMOmbuy4lc0h9frtxUgAkrLAfjJQ/9WVJzmT0Ad7c2jYEKJZ98T37qOlGCUVR2ivjdO+t8NnRYlocD4uVfup0YPefFqQaSTphogvldsBInnXryaZkHMyEwSNaRWw156DRkm+trsr4zT/Z912b/uxzst/hJr4Bqj/fwI4c1hVY8weii2zvNJdqWzLJUBJOwOzn8xRHM/KQdLAcFYC6Tx8eeD6XA4GruVNEcTwrohu5z9OICx6pWSQ6nuH0I+968i9DqiOduc5Vcompq2fvSETo1KN35J8SeP/G2Baoe2NUHFQgji568KSYLcFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTbAMlxr78bJXglcYy/uYanjR83Wno7hDWwfGT4oVyM=;
 b=bUpIdQHaAqmU/k8DUW4W23daSmaKZr0ZJfq4hhy764X7nfPbSlfHj8jQupqsLKEwQgTcRzT04ObuPVO6tD4tYKJNFyjXVxzuJEFRINHuDKJXlA6+Dsy53Y4SEBaiRTk/Yi7kpLPYflfeXV7OrI0bspWAaBQMUzlLrVid8AXE5ag=
Received: from DM6PR03CA0006.namprd03.prod.outlook.com (2603:10b6:5:40::19) by
 SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 01:53:59 +0000
Received: from DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::ca) by DM6PR03CA0006.outlook.office365.com
 (2603:10b6:5:40::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 01:53:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT092.mail.protection.outlook.com (10.13.173.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 01:53:58 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 21 May
 2023 20:53:56 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2] drm/amd/pm: add missing NotifyPowerSource message mapping
 for SMU13.0.7
Date: Mon, 22 May 2023 09:53:29 +0800
Message-ID: <20230522015329.1664855-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT092:EE_|SA3PR12MB8438:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fefe699-48dc-4d6c-bcaa-08db5a6768a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Yvy+PwxXiyncqFCPS6BsGnVHr0zHQNY1yHeiMWO0MQA6T6IpPGBdhGlRvpPzeK4vVqsYwp7KACWDwtQ2oRrgOKNgFZON/2OoJ4AmLZH/3jOb61o2EIHeDq4G0nMVHznbsNxJR9bF/ksBnBcYJqEDQjsoQdBsT3bxfiBQxOlswnW92Y7dDT0D5+rcm+Ipv+1n61iMZ5+lmlhHG1jasMbXiA9dOqFRf33FHpMQLwmFcV22EGuvi4LZ3dVwnJGvmyihQxCQXse6WPr+nrF/CoyBX21uzr/ZRKbSYK9bJ6p5CqZFZTck2plEnnq6o8eRm/R+0XJCx1kjXKdHG9XB5esc//0ImSgD3E+wJgno7o4gqcX8VdlKmyZ4EyaJCvftynfA9yq4KXDjFfpMxmqtDqJ5hru1wAqUBcEjQ+fwE4hEQAIjPb3OuVQD4naCAivkcfGoRfe9iLVFkvCps4HwVIGgbs3HsrJ+71F+1GGRHe4tqDmflv/M8840YSIdWqcAyfne29nPH0NVRlS0cMDTSx9ssrvUm4yptR3iEnC/20m7g0Vz0Wkwr+Mx8veAdVHZs3dEmfqaFeACViwA4vmstuL1IuiM5Gte6sdlBgu4OxSQ8qvjBupAwWfLWTXcEuSTmH8LtbG2Zo5u5Pw3GxT9PpCGbubhqHca0ISeauKpSxuV729TEO6GecN9/Mj9fxiiL2d6aq2l0s+vRnFNynjRJAh7vQ9akF/3QH7dvjcya7ys8R3DWf5QdrPb81Iasx7Am2wzB5byPk3wmq4fgdsztqISQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(8676002)(8936002)(83380400001)(44832011)(5660300002)(47076005)(36860700001)(186003)(16526019)(26005)(2616005)(1076003)(336012)(426003)(86362001)(356005)(81166007)(82740400003)(40460700003)(41300700001)(40480700001)(6666004)(478600001)(7696005)(4326008)(6916009)(36756003)(70586007)(70206006)(54906003)(316002)(82310400005)(4744005)(2906002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 01:53:58.6296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fefe699-48dc-4d6c-bcaa-08db5a6768a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8438
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Guchun.Chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Otherwise, the power source switching will fail due to message
unavailable.

Fixes: 4dd9b5392c57 ("drm/amd/pm: fix possible power mode mismatch between driver and PMFW")
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 1b6116cf8b4c..cf6827179fd1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -125,6 +125,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(GetPptLimit,			PPSMC_MSG_GetPptLimit,                 0),
+	MSG_MAP(NotifyPowerSource,		PPSMC_MSG_NotifyPowerSource,           0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
-- 
2.34.1

