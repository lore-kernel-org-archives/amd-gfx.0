Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B587C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jun 2022 14:22:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B39301124B1;
	Tue, 14 Jun 2022 14:22:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C09B11249D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jun 2022 14:22:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7jVqQmZZaklZGY2+GGgk4rPSejrBgZ9LSH2kSPtNfvxM/s+XGd/dSaKM25u0yIpfVfDW8Fg4n4sUgch5F+eHEuE5Umt7A5bwpna+uMIKGpkgeUW14aBr9TWPxNqMP56il9n+FOU1yEVxv//D5evSo2hshrnWM1+p+pUWrbZioXh0zttu/7i0y9AzSCts5VB1FdR3EXzVu54j9DI/o+h/rycJqfdm3p6KMlh5ZjS0Zr6hsOYitXnHVZZmoTQBergadZLS6jtbLGCK2PvylsuArQztOAAjWaxhl3xRMvqOMosBCvaqEefn5S6CibYMbZRKkblnIUzWhqSFx/Uxz09oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOaWm5bX4zFwwycCuoyKF18Cr4AC8nOo9PGNTeX8mh0=;
 b=ClJgK09TNtgLXmpjMD9y3/kSz0YfOoinMHlUdbDDkQkKwtc57xjhH1+791f5S/iPH5qO1mRctLFYzKXBZfbWCPLKPqWSGi0DwNu8tSI/oTKdwvz/t823PkSs7+H7bAzT7C+o3rP3GcUg0OyZj2kSYUozY3hUFwbOvPYjVcL8xSYVgGL0ktfvMM33XQ06nRliArH//SRYssimSm6RZTjYbWYEVGYlPC6J5FaUt5kvk93ri9SeUm8QdrZhD9xpR3stkS0fnZFA7s0MLGjCLi/eHi9UQZ6BGNtJ/v6aAiJWXymeOkMDv1zVxuxj++5/F8Cc1eqKq/tB07cYJxpzHuKKHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOaWm5bX4zFwwycCuoyKF18Cr4AC8nOo9PGNTeX8mh0=;
 b=du/rdPi9Ep06z2O20Qj7MSVwRG84uuLv4EBAX8LiuO+zVjBcw/zpyOSxp9iu5h7j04q+P2LJ46FazbjH+2aPcH1TQZGuaY0Lm3/wLczbwLAJ5VWxZM8i54gxRy05aE6fV796GVZmkS9BY39OWjnYaZOwfyVYq/ognfCZpwB47Ek=
Received: from DM5PR17CA0072.namprd17.prod.outlook.com (2603:10b6:3:13f::34)
 by BYAPR12MB2997.namprd12.prod.outlook.com (2603:10b6:a03:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 14:22:26 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::d1) by DM5PR17CA0072.outlook.office365.com
 (2603:10b6:3:13f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.22 via Frontend
 Transport; Tue, 14 Jun 2022 14:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Tue, 14 Jun 2022 14:22:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 14 Jun
 2022 09:22:25 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Don't show warning on reading vbios values for SMU13
 3.1
Date: Tue, 14 Jun 2022 09:22:20 -0500
Message-ID: <20220614142220.19188-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bf1ba7c-0b19-45db-583c-08da4e114e17
X-MS-TrafficTypeDiagnostic: BYAPR12MB2997:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2997FC40B177324BC31D4D7FE2AA9@BYAPR12MB2997.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HYIRVK0cG56efc8TvMxZMiMS+5126y37ia+UhSM3SOova3wk+3c0wivqPP2xTD9NUc9kAZKy73z0XbhQ/hZ+NRFIR3Y3Ie4+rnFa+YXYDOFGmajf5D+1baOm3h/yVLO3WQzhK4FrVYbXPPMw1ET+zTeiHbqMwHGgp/P/n3rQbfRyLsrMVp9XULEUyLhqpPCqd1LscjaJCYUSQKoRQdFdWk509J6vzrUmvrpz92w9m8GvpKi9slA8zzoVpi4fpLqBTVSgq5s5LGKBibkBEaS+Nm3Z1NwnsKgUCQC23RDzXOHRHIXv1BAAeKhZtiZw+y5PXsfbl9GYSEOEKs/fxsJ45gzUuE5MpOW7aW3bEckjmBvSOINFm2u9tlnxZdsz6CtcQ86Rp4TF+6NTueH4Xdh8YXLnfe+i1yadcBgNVmEkZt2pmmJeO8NOAvgMHM1+vFDrWhHS8n3g72jUS7n+h8PdFgylP2tEbDDA3EjqSSEFZ13VuEcyFudgQjysnl1IKfRLn2uU/faBOQqjR23hSXXkfMqwrfOuhFYHoXq82gZS14xLyfrD3Prxfb96popECDTM+inIvsgjufY7lYulIP2TqIT60TJEpgmVqAXSL5H2ogb8lTuGNaqgdqEqbPapBQUmN7KFRYMuSAhzI0RSVV/+G9VoRlLuqhcmZBgp8L0fUQ49Lt1AtK7tKkigSHF9bKhrIUNAKOAoQHwMEnXh0Z9Elg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(40470700004)(46966006)(508600001)(6916009)(356005)(8936002)(81166007)(8676002)(36860700001)(70206006)(70586007)(4326008)(86362001)(40460700003)(7696005)(186003)(6666004)(16526019)(47076005)(2906002)(82310400005)(44832011)(26005)(426003)(316002)(36756003)(336012)(83380400001)(2616005)(1076003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 14:22:25.6816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bf1ba7c-0b19-45db-583c-08da4e114e17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2997
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some APUs with SMU13 are showing the following message:
`amdgpu 0000:63:00.0: amdgpu: Unexpected and unhandled version: 3.1`

This warning isn't relevant for smu info 3.1, as no bootup information
is present in the table.

Fixes: 6a73454350c0 ("drm/amd/pm: correct the way for retrieving bootup clocks")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index f18f9605e586..0e59ab2192bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -731,6 +731,8 @@ int smu_v13_0_get_vbios_bootup_values(struct smu_context *smu)
 			smu->smu_table.boot_values.vclk = smu_info_v3_6->bootup_vclk_10khz;
 			smu->smu_table.boot_values.dclk = smu_info_v3_6->bootup_dclk_10khz;
 			smu->smu_table.boot_values.fclk = smu_info_v3_6->bootup_fclk_10khz;
+		} else if ((frev == 3) && (crev == 1)) {
+			return 0;
 		} else if ((frev == 4) && (crev == 0)) {
 			smu_info_v4_0 = (struct atom_smu_info_v4_0 *)header;
 
-- 
2.25.1

