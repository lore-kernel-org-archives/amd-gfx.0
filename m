Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC700C54FB9
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 19:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183B410E58E;
	Wed, 15 Nov 2023 19:44:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6D5810E1A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 19:44:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZlyJ5YVmFcwYmBIETufHiMkR37cFPH04TVgSKzpJpB8xMsOGhKdUkx2TZp36JcQ3GHze4e/0t9E8zmtiZuJaHvdJoKV62OeUJQT1a0vjahtBSt8mKyCO8GRijeeHt2VMFPsItSYi1IC3nWdVRTXPqnzcgSf5+bM1ADBdIglZZ3PcaKIn7MBq0KsmAtP+X87BV5Forx9Lqved19/mQskAiimxJoH/c7f3bQ8anKbJpK5jo1w8oUjwk8krg9dGYCO6KKB/p2GfMQgXtBt7M5pwBt2WHeLcmBEMyYW0VRNzsvUjaslmDh7kkTCZD6i/3Mamlu5rkn8x8o0JabqwuqQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hAmpNkKuIH+x9OCcbEXYuMlzBvQ/YX+GYOJQ2Vpj34=;
 b=SDFAAjPjZ1VAy01cJwe64I+CrPnUK+jBNMS2mTG1cz62SXNsNq3zLaj0ie8r6Xx11Gyf4z5HPEzBbsTxzOnrNFXWNOMzA7cWYmy97/r61tRarmv0DmBbXXe1h7l4YVFOeEuR3b7a4lueOFSKKzXhNVZpE0GciNyYLCgtxkL5JckYY3G6ftBwpefgHqZ8f8LsXEtraDWfugRXNjk8QiMSewqJ5KNNnfwNA/dbBhUbt15jfMYlVV+Uer+5z4ByLnwqUdI3mL2ggP3ofCAUYYW+3b7tyoWqwBT7ZIFKbHVQuAjPyTSge1aBbEpHGx3R4OBo/qff8Mrfa78hiQ9idAHHkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hAmpNkKuIH+x9OCcbEXYuMlzBvQ/YX+GYOJQ2Vpj34=;
 b=SgU6N6m+raI6NsFNEzktTWNHv6CCYl6wlOzOt1TpN5+SRelMuEJ4egW4sqK2pIpGak3r0zGWyBYzX3ICyEAvE/f3rR6xXqDSd13IMBiL1BMt3Sh5crTwTjIuS/PTsu6CcKMj2qreYP67x4cd7/3R6wMPAuTFgK/0Otn9su8mKUE=
Received: from MN2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:208:23e::14)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 19:44:44 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::ae) by MN2PR14CA0009.outlook.office365.com
 (2603:10b6:208:23e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Wed, 15 Nov 2023 19:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 19:44:44 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 13:44:42 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/35] drm/amd/display: Remove config update
Date: Wed, 15 Nov 2023 14:40:43 -0500
Message-ID: <20231115194332.39469-31-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231115194332.39469-1-hamza.mahfooz@amd.com>
References: <20231115194332.39469-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: e51a5d24-51fc-4d6b-7153-08dbe6135119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIeGUHTmEU4/CTckaMJYgN8qqZbRavsqwe8xazXaO/X5nZ0cpd/uSw9hovwo4irTLOcllyJJWiUtptTIzr+pTTR52YCM1Iet25xfDOFD1sDerlAmeZR6Aj7JTLoGtO8Z9HGbSJxvOiO0fl8ps41UBKs9UXwyXXsegbHcCgTybNO6wEn6qI6jna8rsFmFez6ENQHHh6DMmv/f7RDYSoQPo3s8+4j0xyjZsAEYj8Q3BMnevidYhPSFayKemfZ+vrrxBH4hAVx4Xo3l0F0avashOKU0FodZ8B0liDB71U7C8GxTVDmYeyKK61mUkxK312f0LFekpxdy/9wFv87LqULPBofhU5lugVk8NtKmyu0W5vnEKhGnsNlXG7p3y0CjjXnWSz0B3N/xLVrRFFCFn4y6VZkE3KJX4Mmj8+QiTSm/0Dxrjo1PcHAh9uSsaP5PfGYT7H0MgGL61BzHPhn0lCMed4MmIPMfv93xRHr8EmEMfc12nd2cWl1ch+BAhV9L/Kwtg3DHInjOse7s+/uW72UNh/ZKDYHWoboFsOcWoJdi0s8yY18MzS8/BYxi2BxVFrRnpS6RQi95YdRuEMYHckNsf3b6pZRRAggUOK7gdXYieHJFjP8aQfy33vljktKSmKBkL1Rw3Rc2bESDDoWJFz+Pkh+yBcBkxW+HRr0RkGB2g5ZR67zYhnBzYBhP4AM+sOe/3fmXY/fqXGITH8JFK6FrcOiXnNWtxR8mJcbbKTyYk7Rl022WLufvau/jFY3lm6gSQnvBQmGvA1g7BZIexkMPjLle04/mpXupeRn8N1oAEMWkhniDk3QBPUqNnx7J3BnY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(81166007)(426003)(1076003)(336012)(83380400001)(356005)(82740400003)(47076005)(26005)(16526019)(36860700001)(478600001)(2616005)(86362001)(40480700001)(70586007)(54906003)(70206006)(316002)(6916009)(40460700003)(4326008)(8936002)(8676002)(5660300002)(44832011)(36756003)(2906002)(41300700001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 19:44:44.2133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51a5d24-51fc-4d6b-7153-08dbe6135119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <syed.hassan@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <syed.hassan@amd.com>

[Why]
Prevent overwrite of dc->config.use_default_clock_table, as it should be
pre-configured.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Taimur Hassan <syed.hassan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 53eefba0b9dc..1a0ed1c7e2d4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1876,7 +1876,7 @@ static bool dcn35_resource_construct(
 
 	/* Use pipe context based otg sync logic */
 	dc->config.use_pipe_ctx_sync_logic = true;
-	dc->config.use_default_clock_table = false;
+
 	/* read VBIOS LTTPR caps */
 	{
 		if (ctx->dc_bios->funcs->get_lttpr_caps) {
-- 
2.42.0

