Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F72C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 07:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF37311B7BA;
	Fri, 20 May 2022 07:59:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D6211B7B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 07:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb4l6M3Q8Y1bOztZnAyl7SIzD9nUwJIrf9jkEccLD2g0N46m2lHe6hpnV2IZzd7SkFth38p+Pb8zxlhQrQKRnYOWP8kxd5V99EaPZ3Jy5oLHMfXJmCuMf0BJRC7L9FsPIAbTkreWMWdoXuPqGN4pH8O2Itotg3DDivgj/Bvl9y/A0H6SsU92XKRK3NVnZKYpWN/kzYby+kFtHAzeruNJGGDhuhWkaqNbgZQVSaRfM8xauF8jn3IwWPz3qg5x0hCKnLYxx6Q76GwUajAGyYITImDyTwdz5CL9mcHLgR8eBms2ATl+8lDOFu7shAFPAe5JKkj/rnWYUZBdU4UtqU3WlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awBqurmgW6qMWp7S/UG/pMpoGx+bTiQhoA6CkeIe7Cs=;
 b=MgQO4NyQELE0ttX8DBmbtdLgPpxgcnNkY35yrrtfB+EM6WbUbElqVNNYLN6Jk4ibqch/1SDR1r+lCgVZggRCxiosNapw1B1P/Q9hpsVm1ufro6IY9jn/783mbregZYt1fE64hsBR4tCe/GZaQrGI7G/CYHHexAHwyP//iFVcPbxSvo7rb7tp0m1Pum4I0Lx7noxsftTLWhv6ZUYG7jcDhxGz1Zavt+5hwTej0wjJ0M5uLRFZkJh0TwcPJq6FyYzpNs7Q9HmitUd2AQ82puFEROGTvG5hxw3ONMokoQc1ZSNX3BMRqocdGYmi2BcuUWYE8uSpLA+TuTDkeqp8og5n9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awBqurmgW6qMWp7S/UG/pMpoGx+bTiQhoA6CkeIe7Cs=;
 b=Rq/TF5t6GeJofKxOKQwN4LLAJaN01HncunImB8DEjh8v2FsA0bf11hZd7qv0IE8iE7RVI4KqKUMs6fq1eWgxshud3nwC1cBVfcYWpVUN8bQPGjYtJ6rxvzLPS3YAoBvMMoojf2u3hnnSupQSkKHf45vooxziMSR76IKJvOx4Vkk=
Received: from BN8PR04CA0062.namprd04.prod.outlook.com (2603:10b6:408:d4::36)
 by DM6PR12MB4313.namprd12.prod.outlook.com (2603:10b6:5:21e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Fri, 20 May
 2022 07:59:50 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::3f) by BN8PR04CA0062.outlook.office365.com
 (2603:10b6:408:d4::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Fri, 20 May 2022 07:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Fri, 20 May 2022 07:59:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 02:59:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 02:59:42 -0500
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Fri, 20 May 2022 02:59:42 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Skip init fbdev if virtual_display is enabled
Date: Fri, 20 May 2022 09:59:32 +0200
Message-ID: <20220520075932.186691-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec15c2d-4810-4e3a-f69a-08da3a36b75c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4313:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB431330ABC150C987A0DA250898D39@DM6PR12MB4313.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4XUtvciBw/YWKigng957HN71aTT7IyudIBg1TMtqklV2X4tAMfYPiPLtwi9+CXam2aVXxK+NCuougjaXtCmdLPxxKNIRh1O3TpIzS40NWmKEGdpNYO7oc+2Z50rKqkd3mKUniRyBrir9W5+ihBBR8cXxPQu2GsNgjGYqBz3sut0G4G3/AVlxrXFIPUMO4GEuM+lL3dGZA/XBAr3zaRlQ0lQuWLs3J4aizMmgnZUdURth6nrZUXbZ4KKGHGnJagUrWeFzvZzcabHsRZjg3EqZxLuL61sPJQTqedp35HpC1m9/Kovx/7gst6ubgPOYGOUx0mk/OM3lvmAMk50BM8O3M9Qh9+9zvwmcSYLIi6Z6vu4X27uwA++lucm4TpNbAQFuulmE1+gIHX+q6aErnlfzlLieKLox4li8y4L5GlnpcgE96NY0w98vde/28cQKoWwSNamwCi8qehA3qP+H7NZb2iH/GVseCWGdluFWabq5OVbIQbLLKYslPoqAbRplkNA1yVktzQHIgegYsIVIO2xQJOT0MvIzM7ZvQ/djpsbZAi2jmakOeiKzMrK+uIOcUzCvTmHzY8nuMW+47BX2u637EILd9Ho0tNM3GhfO8c4TKKS4RjUZxX+b2jqRbaBziv/NsoMPt/TOQ6944X2XtM+rZyqN88tChO7puXpagvbBn+vh6gbEgpCasrfG/aJB//5hN5J3yvr5ge1CVWyCC3+Dmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(4744005)(6666004)(86362001)(5660300002)(81166007)(36860700001)(82310400005)(40460700003)(356005)(7696005)(316002)(8936002)(2616005)(336012)(44832011)(186003)(47076005)(36756003)(4326008)(8676002)(1076003)(70586007)(26005)(426003)(6916009)(508600001)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 07:59:50.4689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec15c2d-4810-4e3a-f69a-08da3a36b75c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4313
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
Cc: Danijel Slivka <danijel.slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In case virtaul_display is enabled there is no hw DCE so
need to skip setting up fbdev.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3b9dc1803be9..8d03eec49eef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2095,6 +2095,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	 * 2. don't init fbdev if there are no connectors
 	 */
 	if (adev->mode_info.mode_config_initialized &&
+	    !adev->enable_virtual_display &&
 	    !list_empty(&adev_to_drm(adev)->mode_config.connector_list)) {
 		/* select 8 bpp console on low vram cards */
 		if (adev->gmc.real_vram_size <= (32*1024*1024))
-- 
2.25.1

