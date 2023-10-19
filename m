Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C37BCDB484
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEADB10E4F7;
	Thu, 19 Oct 2023 13:34:50 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DA7510E4EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZesyt64NfIWAl/0jjBkiQCeuRIvmwpMwTFl1Ll6HnBHPa9Mp1oCaX+m8eT5qIaFhpIkerhm+OvcePPWnkXYVyoyR83n3PXzx12XZ7uxBvhjU1xVEYw3pOOKzPjqwNncVroAwLhj/C1kZlhD1dqMWj+HpKlBFjrX4xkFgQ3VltGQlNqatOm6sG4+WNcm97owpmUjqswmYVJL+QBbrszjUBDpZsA3dXrCVjlafE3frZspowleGRJPOzmPklWWiBM0j84isN0FonKvpWXbro5dVeHJTVm65fn4iB9QpaTUmxSKoCQlVaC52rPI8LcTP0HC2Aiz0rAPfeeiML5HAm3R3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fR7aifFHSWi9WzJ6OJW3rSBeND5LrG7iK1LbH4naelY=;
 b=j6szhFIe1hwnrQ1FsLzP9tuma+MNfjyhYswK+84Fm5FHPDze0j4A4EpNFacNZHB2E/v2c9DccczS/j1BJ4hfkeUXRyVQYgToC1PXtYU2qPm37lWYaxB5ixXGzflGc8y2pOIiPcIjKz08eqTcVdeEWg7PN+7qgEkvfWj/gXkiWVYjUod/sy1bQ23MVdL17I87uRsAEiZbNKzIaxiM5zbbwt/0RtQSHUsfXGoCq4zyx0JJNtTwX7Wj8mR0TPXw65mMVTMynlkaQaPT9ZxzoOFdbgqDqp2Jzn+HYMn/A93FVk7M43kTFWn6rNiwJBA4QJjy0UmMM/sMVNOzmSzEQ3B2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR7aifFHSWi9WzJ6OJW3rSBeND5LrG7iK1LbH4naelY=;
 b=XmxSkCcqq/XU1z7c8NkC6lKWNA1W4t1bDyRZhqKez2KyPlcCw5naXi/P6vO1nI68d9Q3+6QnMg5yMBlgv4Ayx6oQSRC0OZZf9SpK5p4n/B+wLM2HlmeiflGtH4JjISclLzX+M1ODR57nU8/rfyjfH1D39ZMBvX8pED6MGEaDSNc=
Received: from SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 13:34:46 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::b6) by SJ0PR03CA0113.outlook.office365.com
 (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.22 via Frontend Transport; Thu, 19 Oct 2023 13:34:45 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 06:34:19 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:34:19 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 19/24] drm/amd/display: add null check for invalid opps
Date: Thu, 19 Oct 2023 09:32:17 -0400
Message-ID: <20231019133222.1633077-20-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: 64377426-d951-44fe-ca95-08dbd0a828a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaCIVUY6J6p+/M6xgFZ4BzOi9gT5eZJlgKhnQJJXAY8ic4qM0bF8UmOFB3wK7BkyFXLfwNuTs44h1GP4MHLOGiXp3uTalE08NbHgICatS2OC4RBOwftWdYShoweAGHvfS5aJQJybS+NhX42E1sMTJcfBOUydsTLakh1GW9PRnZBuenqN2VNIb0wicFhrpOw8cT/XJ9pJI8A5v+Czzi5DB7AN2deP7lxXheZ/5aF6rkxxtotySiH774TM+RSY5B5TKOxq+mG/vixJVad1LXts18cUsch2NaO1hcgCEbry1CXUhbnbXYlcLr7i6u1b1YN7lHcYQVKpNJb1SjBpZUn5o8BRnkDYNaW3uCQLPGQaw5ZYNonIcaf4U7jydPMr0BToSmePHhpNCJ8iPlDI55dQjhMpy23xcNpdLn+tzNgrcDLE+uhGUCrWjs7BMQ8xjI3KRuN382D7FdHer9+n5nUaRgyr3tXUj0DSnPcchLRy1XyHBrszjff7fN62krn8uX4EHIZJhAHGNnIEOKe+zQZMdTwnIBtobXhNHPkrbrIRHxGrXsb4akJLs1cBccy8T4CHrddwErdrJisce2zBawqt52hCQbdvonG4SUNh+2DdIcOqbQ2iaWFNEoAVEyqWRGsU84ircDkhpZz+UJWuF78QkU8wAACpEcqG2au/4CSGera3FC5g1vhSMLL7Qx6Fy8EQRUnkLscWv+kQM1dozmf70jqYA3j7PAv2Q8Zg2IqzT/0UTuCR5rFjWjY/T5qTBgubrBkooUlvsrxQ0TjcrCEz7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(186009)(64100799003)(82310400011)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(36756003)(40460700003)(40480700001)(70206006)(70586007)(54906003)(86362001)(356005)(26005)(82740400003)(81166007)(1076003)(36860700001)(83380400001)(2616005)(426003)(336012)(7696005)(2906002)(2876002)(6916009)(478600001)(316002)(5660300002)(41300700001)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:45.6793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64377426-d951-44fe-ca95-08dbd0a828a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
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
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
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
index c4962cc4bb93..52e8528aedbe 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3574,7 +3574,8 @@ static void wait_for_outstanding_hw_updates(struct dc *dc, const struct dc_state
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

