Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94057CDB47E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 17:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27D2510E449;
	Wed, 18 Oct 2023 17:43:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BC2110E43A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 17:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KS35iSDarJjfHJIAqtYqv2qlKRaxA2hC/6C9K2SDuaY0r6UGpk9geTLaq8748IDSACnefbdR2OpJf/rwiTHZMCblVKsI48tJRdFk8pw46ya+8k6NjlGvqxSdupkvWoWmcTrMXJA6IUYiWSvSjIxyg9NXcIiAr2LoGVH8VkRyx8A+QQNO5e1OK1TQuSYfwPs3pqyQnt2npH9b2lx5h70ohUJuAAt62/PSB5XzUSGcE2xgCj8H3+L+uFIz7QGBK9zIE1b3FcIpXy4qu/9LlncTaXvA13lNKTWdSNuD+3aFK8ZZ/0iwZd5BHTESM9v1p1G8C6WypwIHECbrXEOwUa3ebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZogdDSGi+WJ+v8vAMNxYfw78zx1jxLm5eymWlx0QW8=;
 b=YLemJzd4NLu3gWsBoZJZ4nQmss3B2TIpZqb/uweAth4umKVlbqdZ5wNftW7yxDcsOvDdqxZ9h3nLyvqI/Zv2/oEPtHhS0CPJQ8F4yn9rWzTALBaarhtlwkEKhKALqmn4CZCjmodMwo9wPr4sz66DJwhSW3PRGgjkg8y1Psommu9il0sT5NQjUor78tlla+MZ9jgfIf2X8AkGvEpYVFvGkWfNr8ogUwGvnOae87oJWEdnXq6bqw4OTh63uYZ/hXlcNV0dI8cV7EhfX2ijFJplvMhTcP/MnRQCFZ4gh0W0ksmH7l27Y1wTBgxsMsmz7bfexfQsyU8msF5XYMODkdCAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZogdDSGi+WJ+v8vAMNxYfw78zx1jxLm5eymWlx0QW8=;
 b=xoBviDUqE24n3yGqVeIH2I/ywzue2WmaqUif3gq5dyWEiLCcFm06AZAUM3Ugj6DkwhMr+tCEsoStCfLGY38kVlD05D/5WVitm8TFb/2rK4BgecWLqDPRuZkeNRHQQyfdz4nTlyJ7fftoTjl+UoPEe2n1xoJ3uN64PzIqUDexUdo=
Received: from SJ0PR13CA0230.namprd13.prod.outlook.com (2603:10b6:a03:2c1::25)
 by DM6PR12MB4498.namprd12.prod.outlook.com (2603:10b6:5:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 17:43:11 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::78) by SJ0PR13CA0230.outlook.office365.com
 (2603:10b6:a03:2c1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.17 via Frontend
 Transport; Wed, 18 Oct 2023 17:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Wed, 18 Oct 2023 17:43:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:09 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 12:43:09 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 18 Oct 2023 12:43:08 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/26] drm/amd/display: add null check for invalid opps
Date: Wed, 18 Oct 2023 13:41:27 -0400
Message-ID: <20231018174133.1613439-21-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018174133.1613439-1-Roman.Li@amd.com>
References: <20231018174133.1613439-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|DM6PR12MB4498:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0ac469-dff6-4c42-e183-08dbd001b24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vvufci6pbKD3LKoGGxgQj1IczReGYkViywMGs3AmUFTaJq2wS92BzhUkpnvE7YTM1rNO7tt6W1B+jqIy1dYhYDHEJiZoJSohdav0g16v+NR4Ex6PmwnLF5wS+kSAAeegRJ5AyxavYO0PaOR17nIwbwSkiQVFPsteYQcP2hQ0pmC6FQbW3eUKd0trt+1ZdioY3ZPtevWh7SxAWw85pE4y26LNyH1lZXCMX+qEBoWMPXDCT9Z6YNbjAkAz4juuDgiQGS+ilYCK7PAFdw9qvHI66N42FFciuNBL2tCaM9QSxe59jZScdGmE51SzpheDH1Nam/sf+Gq70hrzkbqPDA7hSdBa/1RUxGgJiF8qPrATMrEiHyJ2WgYh06DAzTAsjWg45oHOUG/4uX4TrNUkyFkDx9s/HwPVRonDeXbJ5uKSGrQXYVR6xpcSk94MaGVYC2ayKio7Qp1F/Aetfy5A9LvwoZJYN8FwoIDV0dFAuSlFKLE3pwXzEONZjVMBRHNVsLYrsLn6VzeOfubSSQtIlhfpJxDP5xLv1EcvbBD/rfTWrhyhLQcv7xA52As8tkvaLuYo/GGWRHLEZO36oxotZ3MpwaE/ZkTutVaL8mJEwxwEIQcUfNgLWnLU3zpZi6IoCTK2IlNfQysu09/CaInTqiocraKWvOQijoKjKOsjZ4WPglkePasaXrJb6bRFFCqdPlbIPqe8Twwk9OvunjGL6mN+YvCESlwUWhuYBVO19TwQ6GW/1bYz7rXoYX/X4Nn/FIKSoe8yeUoRqSD1biR2vJgQMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(36756003)(40480700001)(40460700003)(26005)(316002)(54906003)(6916009)(70586007)(70206006)(86362001)(81166007)(356005)(36860700001)(83380400001)(336012)(6666004)(7696005)(2616005)(1076003)(426003)(8936002)(82740400003)(2906002)(478600001)(47076005)(8676002)(5660300002)(2876002)(4326008)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:43:10.6578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0ac469-dff6-4c42-e183-08dbd001b24c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4498
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
In cases where number of pipes available is less
 than num_opp, there will opp instances that are
 null

[How]
Add null check to skip over these opp instances

Fixes: 9e241124fe13 ("drm/amd/display: Update OPP counter from new interface")

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4f2b9911e6ff..4425d9aea81c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3512,7 +3512,8 @@ static void wait_for_outstanding_hw_updates(struct dc *dc, const struct dc_state
 		mpcc_inst = hubp->inst;
 		// MPCC inst is equal to pipe index in practice
 		for (opp_inst = 0; opp_inst < opp_count; opp_inst++) {
-			if (dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst]) {
+			if ((dc->res_pool->opps[opp_inst] != NULL) &&
+				(dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst])) {
 				dc->res_pool->mpc->funcs->wait_for_idle(dc->res_pool->mpc, mpcc_inst);
 				dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst] = false;
 				break;
-- 
2.34.1

