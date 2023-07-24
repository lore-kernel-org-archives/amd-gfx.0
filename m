Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D4BC0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 17:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9EE810E104;
	Mon, 24 Jul 2023 17:53:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F3410E104
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 17:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMAiDjvuhclNBTUCynYCFw0d2GtJQU1X1OUzJk080AvV3RZiMrcwJRy7rn9K6GSqe0tBdkIVsMOtnqJuQOro5ws/dq+5FIHj91kOPs5a8kKP4rbzwf3SGae1SNQ8maucLhuw0NrKDjWHDiiSeOxU2Xcv8AkO1vfdhEJqv+l9n8R27FMHY4af5pE+2UcS8P/+7aNQeevqmO2ca27Gf1SpqlkX+QmsofXGfNUFflrSaKWpAtdxR0yJf3b9fL99L9Hu80J5yvCaaHSHXpiyC9N/OfpB7un2KywyW7VZWwF9/I+9DLhV7siSZ+4a0GqHMdJAPtISq7zMh2+6pfWzv5jiQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QJ3rL/TUTtiX57qgM9n62+Zl1RbyJZkWyme6zd/RNo=;
 b=cs0zYh6ERvISTLKC/aXJwoX3B27WiclD5AEAUpVltAvIA4LUZXEgwr+je9ToYSeit3dXcLFdwEz0RT480Nz+hSYH/HHYyOaFUj9wJk19d+xIQfFeUiHoHszpch7BgSy5K4DHHoXkNiHeR0xgtx4jhQs370e3y8OK+Q87NVZ4VombbjjBv1Es5YSr8fMwFQF7iUtjibU0c+P1zmUWuE/LEiZJ3HmH7BjtC9a+V/BFxLIOFc5ABv29JFFCdy+ESDPe66bm/Tgl7sq2bZ4oC4Tz3hAUzk2OHiYHh7pSrMGtODdEuMueKjcM9NYrQ/agsagQ/8soqTLO8AKkvuXeQOplfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QJ3rL/TUTtiX57qgM9n62+Zl1RbyJZkWyme6zd/RNo=;
 b=yBFO1YBBZZdqPVgcSf8zEuCAOhElK+6dNGrhEFlLzykcE1KM3JsuR2xO/aR1LspMr2yQosgk+Lhe7+xFrJpwh/jPdgyy01H+SCndHFS+q5NPHc4XhqFn++UzYcmi2h6gMWL+UTaZ0ozYwD4VkDnET/vmTSRpc3dJ/ipzd9xruTs=
Received: from BN9PR03CA0975.namprd03.prod.outlook.com (2603:10b6:408:109::20)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 17:53:18 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::4c) by BN9PR03CA0975.outlook.office365.com
 (2603:10b6:408:109::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32 via Frontend
 Transport; Mon, 24 Jul 2023 17:53:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 17:53:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 12:53:17 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: start_cpsch don't map queues
Date: Mon, 24 Jul 2023 13:52:06 -0400
Message-ID: <20230724175206.11054-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: c54bbb10-3e57-4417-2071-08db8c6edc8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9k42wze4PiDEwRIbSc6HBgdRgoBMZEFVGLxrQvWRiy38nkM4TlLbeTkkMw6tQVHLmjL+rR2AZ/e7DLjhkM8S4tYot/6w7BeuL+FnCkXf9dip2DZFIB8ydiXlzLkdORDtmTvUNTH7JuFbzTKhjuds9dU00ULCF7LegEwIHWfFqfRJMdD06/e3b7dP/WTelhCqcYNTP3h4+mWQfiRlNris/xKZx8PO13RJyu703CGGLGw4M8M0kRp0TKvQmOQljtt+2YoGgfzdhn1JFLwWS8JNNBlQY/x2WBcyaffZ/39SySM9IqraqVfTOcGR7dPtpWKQepnCyEhV3Sr2Q70jZUOgdeWSsxPEOi3hEs1z2/EEmCp5FnkaknD875XTPogE13nokws0hsQNgo7khD8Z+KC/4Wdqk1dR06MeRLMGsAGbBymj2ldJU+9rbSUc+A5a6vSVt/v5qBEC0j2ZhDrPEJg6nudYYh/2cXYGWTkqKkJ4d/nZ7ZdNETxNpKB9SABo6AKjAKcuAHa8/oq/LTOTqdq1LQu7et1fImf2KDHpSwpNKq4cNofmBOVsW/GEl2BXzgkY77n1q/m0Y9WQN657unibmAPh3Mn62uJDoKDWlPMSWl/H0EjozaobtmlwKGL9YwGiFHWwxBm6h4fWPvO9en5SA+BZzUTbPeANb3qyDWgTG+BdlRnX1w43CJPD7WmMf095aKo4DPqqGHj3mSRZ2iDKlMyPjpIMPRVjBLqnwiC8x/CmteHgBHjE9kPXKmIrZjZm2AmPZJ8Rq9NPce9XVdtSsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(81166007)(40460700003)(40480700001)(356005)(36860700001)(36756003)(2616005)(426003)(47076005)(83380400001)(8936002)(8676002)(5660300002)(54906003)(6916009)(478600001)(4326008)(70206006)(316002)(70586007)(41300700001)(16526019)(336012)(186003)(26005)(1076003)(7696005)(6666004)(2906002)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 17:53:17.7247 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c54bbb10-3e57-4417-2071-08db8c6edc8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com,
 michel@daenzer.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

start_cpsch map queues when kfd_init_node have race condition with
IOMMUv2 init, and cause the gfx ring test failed later. Remove it
from start_cpsch because map queues will be done when creating queues
and resume queues.

Reported-by: Michel Dänzer <michel@daenzer.net>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 71b7f16c0173..a2d0d0bcf853 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1658,9 +1658,6 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	dqm->is_resetting = false;
 	dqm->sched_running = true;
 
-	if (!dqm->dev->kfd->shared_resources.enable_mes)
-		execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
-
 	/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
 	if (amdgpu_emu_mode == 0 && dqm->dev->adev->gmc.is_app_apu &&
 	    (KFD_GC_VERSION(dqm->dev) == IP_VERSION(9, 4, 3))) {
-- 
2.35.1

