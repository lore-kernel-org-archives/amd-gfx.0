Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4178C4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 03:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90DED10E110;
	Fri,  9 Dec 2022 03:48:53 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5F610E03C
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 03:48:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=POdbqNDbVauoWAkIaYcoVRR/CULzpHsJnH9J44F2uI/TBP/7d1ZiR+i0PG0tgteolaMjIG4zIu5iFyHc73gh6ORs0Du8fcuogINPb5xLjMGZJYyvCVfrnaS2pM1/wwtJJ5B5lGnZ10ID04k70yOLfAuSslEPJHPrROqmtgnblygOkzjtPBiGAoqrHJytOqw4sn4lP4wpsHHwgcPgDoeP6LO0/RS95mq4NpB2JMOScobfd7WE+bY/tWCs4PJLd1BrRCfDAHinpF5wL3u7mf2/QgQBfFO1rMKsvfclqDudCXlBqsCyFxfKTF8lor6853vC/yK5c15efWh/lpKBlKPjmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/IaDttDKfQsuZ1CQiLJ4xFgA4LGX7SunKIiWyShy4g=;
 b=gLTwQksDq217UhFZ3kBo9ynExvF/WeOVnVIxKj7vOkOTm3Cg56cxZ3VcKHG1QiX0/UYE+69pwMQ9dNQliM3/5Wtx1u8W/bKfF6BNjaVlDNxiRlJe4+iaSt9LVWBD+3aGdTwnSt2k1z8GOKuJQL/WQdWpK0gm0CdbzuLRUwObUMYs9iVpFo313iL+NB35aLd4LjY345JBW0fafuz//mYy6PZ/5gvXfCc2rPXJIwJxBKnWFo+674QYRhbxKdI+dqPOe4ZHndKiujXgQPtZkYbPa4CzUicc1ysHLjJbi+wbzKLB+KVo0BgyjUJGyDq5Lypc0PWEK10R26w3MsJrz9Q5jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/IaDttDKfQsuZ1CQiLJ4xFgA4LGX7SunKIiWyShy4g=;
 b=QyapR+HNXg6TqFg+AX+XHl71O3qFqnyD8+BxKXr2knpGgnGC3cFZr9loYCX64mn8BqzGOrEi6xtsSKc2vx4rLdNeuXt4540LmJ61k68T8PaE/1Y63bDJIS8p0ChB8ybALz2wyCgTx4RxQkP2hW0ZpPIzdI2yiuuN1maE/1DInuQ=
Received: from DM6PR06CA0041.namprd06.prod.outlook.com (2603:10b6:5:54::18) by
 DM6PR12MB4529.namprd12.prod.outlook.com (2603:10b6:5:2ab::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.16; Fri, 9 Dec 2022 03:48:46 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::22) by DM6PR06CA0041.outlook.office365.com
 (2603:10b6:5:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Fri, 9 Dec 2022 03:48:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Fri, 9 Dec 2022 03:48:46 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 21:48:44 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/10] drm/amd/pm: enable GPO dynamic control support for
 SMU13.0.7
Date: Fri, 9 Dec 2022 11:48:05 +0800
Message-ID: <20221209034813.2373727-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209034813.2373727-1-evan.quan@amd.com>
References: <20221209034813.2373727-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|DM6PR12MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f69b976-ba16-4bb9-b897-08dad998466b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alKyyL8yBOY+op9xVrztrseoOwE6atXV6xExsjosoU3ZCfMi6IsdkBx/PNGt+25ghrzigjDHqljSVwf+mW//06CR5mu2H67qzx8UUniUW7krbxNcdMbGrAZARmvds1xMXRKjwIbkozC/sX3MTaRFmeZ0waetRUmDLjWi9KWXdG0cTqzc/HOXaKMLjxmD4/dsAK9tWv+dmuDVBx6x1fU5WWgj0iT3zMmTwtElnoUSFhK7/U8LTmKA+nlMXJMGJKhQZXJ9RG1rZBpHoDdB4Ws57vAAGNM3pfwCblqD2kvVjNgeWlFA+sIDlXaEwWP9II2752D2c4vDBQocr/49z43w03q724cSWTEsLnNxTXbciDuPymdBFEhIcziCPhVW9wgtsLikf9xNvmmPP2x/BrCFtrpbdlSEKEO/e4+716ScIyr0e6ffy/Xtwz6Jx2L5WYuteR5kn8BYZtos+M4wjmCkFRLywLmtP4C+Z3NwRYwPKnmY1agykSN5VW28+jtmsxTvRKLHspeRlYbVYhJuXnSjSnSmxR1nXEpBPqZWbKCmCVTg1wGRrGd7SfJ0uJLJYFfIvTjuWKs0N9FaAh7STb9L2AARBFNpXFR3zxRX1AcuqNgcG5zlDoFfgusGHcxmnPeZHIBe6uhWf5fXcUYe3pjYIb763F/CranO5Xdk9kp5dJnDFKqtW9uUb2DfvYTJVlFNgUg79LavY7Wo/qFFyfTSgxN04K4+0Sz/s0hKoPYzDyQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(40460700003)(36756003)(40480700001)(83380400001)(316002)(6916009)(54906003)(41300700001)(70586007)(5660300002)(70206006)(44832011)(8676002)(26005)(4326008)(7696005)(6666004)(1076003)(336012)(186003)(478600001)(2616005)(426003)(47076005)(16526019)(81166007)(356005)(86362001)(82310400005)(36860700001)(8936002)(2906002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 03:48:46.5286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f69b976-ba16-4bb9-b897-08dad998466b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4529
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To better support UMD pstate profilings, the GPO feature needs
to be switched on/off accordingly.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ia0236c05d507b6c253fd558482c665528aa0ceb8
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 94c1aab7861f..60688d3619a4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -123,6 +123,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetMGpuFanBoostLimitRpm,	PPSMC_MSG_SetMGpuFanBoostLimitRpm,     0),
 	MSG_MAP(DFCstateControl,		PPSMC_MSG_SetExternalClientDfCstateAllow, 0),
 	MSG_MAP(ArmD3,				PPSMC_MSG_ArmD3,                       0),
+	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -1689,6 +1690,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.mode1_reset = smu_v13_0_mode1_reset,
 	.set_mp1_state = smu_v13_0_7_set_mp1_state,
 	.set_df_cstate = smu_v13_0_7_set_df_cstate,
+	.gpo_control = smu_v13_0_gpo_control,
 };
 
 void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
-- 
2.34.1

