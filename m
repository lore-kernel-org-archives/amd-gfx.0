Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151B7C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 11:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CE7310E369;
	Thu, 27 Jul 2023 11:42:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183D810E369
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 11:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFr61HHvziYTLgC44KFv4cFLm20k5hGqNI6SmaryF8vWqwCzkD2KnQZ1/pQZNqw6l31TjOolnkmzOEu5Lc3vE3UGBuMxlqJrSRjC/z7Hf5EwkeQEauGbPpaoP0GEwsCL8+U8wcqu+uZ60ug/Iy1rExTsgKZtCWrqYjj/qLORt8uxw6XQcV5ZTwNFDKSfYzhNi8DLnSVRhBHQ1D0nTtirC4p1styHcTXfaHR+pFEBuibIrMSn/DBamwybr7OQi+6E6qVwjhXzB15kluSYYMK6P+wuRq6oCMFOvpS2wDFNR9f6hHfe/Sh7xFFpKczUadomk1Oozkl+MuEJ1nMNv59Sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9cSiPnwNiXwG4VDlxTYoWQy0NpxC/B0FeU0kyl4L1s=;
 b=kO/lMBddYAPbAW5s45b5DmvVauxkaHug7WwT0YWrUX/ij44qcLv8eASc7Rit12CpeJnIIxT2nPTVdyDNF2Dy0NXoENZOXqQQMOMQPQ68wKIIpP+cIVLV73Gs1Y0cwycXuu86f++K50DZUdlWRbSSNENwlQaL15L10TWe7x7mQJLYTeAJuvj6oAJ+4+5OzbhO/5jw8Bo+a1qciJfuuANGy3WtS2kY3KKalvNDCDh7+ArxXNW5f5M0uHfPfua8mTbgj5pvAL94ktomPH0fIZu6pudzQ5frvHWHLxwYXzbi/T1GykDNULZNLX9R5hjZNyllpN0rbpN5H/zUoc9Kz73tGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9cSiPnwNiXwG4VDlxTYoWQy0NpxC/B0FeU0kyl4L1s=;
 b=ezuY76y05OFhDlwdCCpQyQr4FdToDbJOwS8PaA+pMxAw+Yiku0Dbxr1beHmArJFSVAbwdrb7UQV5tM5UrmE64WCBfQTm35mzgMbYUgIwFzx4BfPcyHT6GlYwZ/k2ItV98kzMeQ7Xck3AKvhET3SFgKMcqGZ7s8wSOyG5k9pDnvk=
Received: from MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 11:41:35 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::94) by MW4P220CA0025.outlook.office365.com
 (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 11:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Thu, 27 Jul 2023 11:41:34 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 06:41:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 04:41:33 -0700
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via
 Frontend Transport; Thu, 27 Jul 2023 06:41:33 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: correct the pcie width for smu 13.0.0
Date: Thu, 27 Jul 2023 19:41:25 +0800
Message-ID: <20230727114125.3891244-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT015:EE_|PH7PR12MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bddb1c3-b243-4fe9-2713-08db8e966e5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: diCVuYug48xwIwKdUUqKQhAOFNOeaCF23ohTYt1i+pinKHPQ5Xm++1znFeS6oZOjAF8irxlusEpAhm+qWXDGsPf7DzbPA6oLnL2wi6RO0i69IuYptM/0cG4YeTfkNwQxIckUj2x1IX6Bd9UFwK0lCHaH4IcHhZjfKQNG1u0rsi9an60vgmFnwtH/Ye96dQyP15WkGLmXInbLilARr1KTm6NLE1wX1oyxRwR4GL+TT0OpOiM/nwCMLN1KG4l7DDkplggLrFPbZfqm18AVqPNdqQbioaZe4b7ysGORmZPyt5yneBOM4keIhxHY018l5APeAedy5cjo0YqgK/GF3+tu7fMmmbcpoNbDUHJfdLXUr+6yQu2Z1m7I3r4F5h9ofuepgkGYowyvFZYKg8+Q+P+Zk+2M0IA1yPWjTNJOiOY0MFlITojgSJqXIxZ2/4pm/xY23Aor8akgyfqKkPNj2JdbxurccsowUGKNJSRhh3skTERa2f/KfCzxmSYClmvct5YeMVphbBipdbwhnrK4pghb3zbwUE6/DMRK02zRXoDvLSTc2yQycO1M/Bp2UcDuIbMaLWyLeBhnuRBVFehPecX/kcB6ITGfjp4e3CPeKamYtMAl5k0jc1ppJGGmcF8bzT2ucz8pjDXAxhu69nj/BTHxOwy2FixhgemzfTOOvaEbGbZkX1PTHmqlUlIvcms1iLlNjYFWg4l9xM3QsLWoPAWBVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(451199021)(82310400008)(46966006)(36840700001)(86362001)(81166007)(36756003)(356005)(508600001)(2906002)(54906003)(47076005)(2616005)(336012)(26005)(1076003)(426003)(36860700001)(186003)(4326008)(8936002)(70206006)(44832011)(8676002)(5660300002)(6666004)(7696005)(83380400001)(70586007)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 11:41:34.9619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bddb1c3-b243-4fe9-2713-08db8e966e5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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
Cc: evan.quan@amd.com, Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

correct the pcie width value in pp_dpm_pcie for smu 13.0.0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 232274423f9e..4bdbd3910e1f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1140,7 +1140,6 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	struct smu_13_0_dpm_table *single_dpm_table;
 	struct smu_13_0_pcie_table *pcie_table;
-	const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
 	uint32_t gen_speed, lane_width;
 	int i, curr_freq, size = 0;
 	int32_t min_value, max_value;
@@ -1256,7 +1255,7 @@ static int smu_v13_0_0_print_clk_levels(struct smu_context *smu,
 					(pcie_table->pcie_lane[i] == 6) ? "x16" : "",
 					pcie_table->clk_freq[i],
 					(gen_speed == DECODE_GEN_SPEED(pcie_table->pcie_gen[i])) &&
-					(lane_width == DECODE_LANE_WIDTH(link_width[pcie_table->pcie_lane[i]])) ?
+					(lane_width == DECODE_LANE_WIDTH(pcie_table->pcie_lane[i])) ?
 					"*" : "");
 		break;
 
-- 
2.34.1

