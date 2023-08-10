Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B65C04E69
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 03:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C45F10E634;
	Fri, 11 Aug 2023 03:40:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590E310E630
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 03:40:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh5yYzj12ZstK5zq5zclJGBBW00zJ0V08bzWne53HQhMUgOc1w2qlK97xG+Ww6RiT7b0YrklsDei3WzrjBDmnDrm1upT1RLN8+T62dLAjp/7VH2dHGDsrmgkowkvbYuxfs71V19kiIjdpK/qB/3H6Tr5qHSIywMO6vol61Mmkm9OwSBQGvd2EygDeAEKgHyoKaPPs+JxYT3NrcBH/kTgOqknYMwF+raq2bpEK97E6kmwGs4L1b/atSwhAOlAFxBCs2ERHZmWTxIAkocfGaelYs8FDN3iMm9Yz794mvEfKlDfrJPv37f3xrmFyRFF2aDbyFicOETqRfUkAR/PoKw/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+zI63vTmO9J2WDewH5WKCB17dU5WksjrJVojEz9Q1g=;
 b=Es/KQ3UO9KvSAHicnWC/+Oj+YD6fZw8/51xP/pXKmN5etSGgy0nfjZEc8f70nD5iO/6jkqx4sMhaY11jl8wliPzTbwXyqVjx2Du5Wr4NGNDWjKlZ8jG6EkoDnHUCEtK+jLSowcoptNjMSOr3wp5FCdHvc8QmKdI3Gq7XS4ovnavmIVujI0VG6yfFQ05KiLl2zebbmfasS/5RCVdP9jmEEAHI/P98agfdVoemGeiQ3p8juiq5RgFAJ37BnEi94kolP/UnnEpyK9qO3Oc++ACrBJqEOH0kldMK1+N+oaQ6+oHvfHe7fW9Z0Bq9TprgT/+rl11R0bzdJcOEZRK9ridQFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+zI63vTmO9J2WDewH5WKCB17dU5WksjrJVojEz9Q1g=;
 b=Gp7OIYPl/BSO7Tx6QZzKBQhjVAdk71pTJ1JgrQ/jjvixHLRGcM2DU9TWXRMg6meLT+I0JYYjPD1yFCocg09QX/NnvguUZshYIq+Z7IE1TkQptFvm5CVoYptOVke4qMFFJbZO5SozqM2G0xkNg/W7EmharU+kkyIldJnMhbl0+04=
Received: from SA1PR02CA0010.namprd02.prod.outlook.com (2603:10b6:806:2cf::16)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 03:40:45 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::1e) by SA1PR02CA0010.outlook.office365.com
 (2603:10b6:806:2cf::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 03:40:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 03:40:45 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 22:40:10 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/9] drm/amd: Fix SMU 13.0.4/13.0.11 GPU metrics average power
Date: Thu, 10 Aug 2023 05:31:57 -0500
Message-ID: <20230810103202.141225-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103202.141225-1-mario.limonciello@amd.com>
References: <20230810103202.141225-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: ada02288-8ac6-4833-e000-08db9a1cbedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y+MYTkzyGtRAGInPAfMoRrwQOdekpg/FvCK9da4GhMn7eFE4J8d7ma2jeEsvmx8sjXpciJg7LvGH+ILjQ0VU0udFfOVU+gdIxxl2IdqahPEc8RS9iviWzy2CC9du21clu8wcElhhF5DWHx6dIq0N+6DqR3Ehtpuc7+stzfALei9Rs5Qd6khCL6XDBxpqo3SX9wEnhF0lEeAFjGOIVklZnCI8FqRDtGAkIkpaSJ/R77zTcdDn/sLWuk9TSsAS3qitmoYATBvU6JIPGrDOs4vCHaqfTUfRZWuTrdb5b7vzn7zDG76cLj/qmd23jl9/MYdqxMPe4TmJTHepvPvAHHbBNQ8gTZYo1VBHn6vAcxZH6vGR9ZeBSusIjZ2QkCDrQz47MsTdVfw0wzYYaN7q1Qb/M/fBly1ovd6g5hBpxaWmdNV3pgsnUN7pa8JdCK3+NzqxNDzoCFinMOANahWcqQy0h99PBtKMCVNuy4dT+oSWbAbvk0t9N+ReebQ+V4Es4ncyqnIe2yN9H/qlgE5wrBUZuHdopVeHHtTizxPRqy1dbgtd/MQIODA6cJuDOow+pqfL8qW2Et/Tv00aRKFIjAPJFWzxDipMTjUk1hVm+8xXKuuyhjNZg7p86hQk29qvdCGOHl2mxGsOn8y3C1FlzKfxe1j7eCaWPbk4+6UMwWyuSjInaCSrja5wbWOGyrdz5DfQU3Hh3GZ3B1G6Pt5cUJi2YQCDyUmX/+vGPzugxSvA9886jbadIO69K520vJn3nhQyqVEPD81TTKVSiJ+VXUML/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(1800799006)(186006)(82310400008)(46966006)(40470700004)(36840700001)(7696005)(6666004)(478600001)(36756003)(40460700003)(36860700001)(40480700001)(356005)(82740400003)(81166007)(47076005)(26005)(1076003)(16526019)(2906002)(426003)(336012)(2616005)(83380400001)(4326008)(8936002)(6916009)(8676002)(44832011)(5660300002)(86362001)(70586007)(70206006)(316002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 03:40:45.4536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ada02288-8ac6-4833-e000-08db9a1cbedf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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

The average power for the GPU metrics sysfs file contains the input
power not the average power.  The member that is set is called average
power though, so correct it to the right value.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index a4e87984645ec..0951659299c15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -257,7 +257,7 @@ static ssize_t smu_v13_0_4_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
 	gpu_metrics->average_mm_activity = metrics.UvdActivity;
 
-	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
+	gpu_metrics->average_socket_power = metrics.AverageSocketPower;
 	gpu_metrics->average_gfx_power = metrics.Power[0];
 	gpu_metrics->average_soc_power = metrics.Power[1];
 	memcpy(&gpu_metrics->average_core_power[0],
-- 
2.34.1

