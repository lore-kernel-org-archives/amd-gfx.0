Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B293FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554DA10E599;
	Fri,  6 May 2022 15:43:09 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DD410E583
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXHMpXZMRy0NfhtZ//QYoE56dvCQvCdUWqeY+hOnHoOGfOYzJngIjsi98u0HMs2VgbK8WRr2N/uRqBA/i/moVasGKauOWSZFyGEpSwxvuAgIDCt70WJWIE7EgxjRlQIjvL1ZAZ5q/PmchBmDbRhWnK0diXYjIFEn13h1SrxFvnyVzWv38gziAdfjrJKRbkR4pVluV+S/x9oYQzsC5zEIxZT7p15Edcb/D61svYeGGUgoOM/LrV2TO3E0z2LQTmY2A2HsZQJTDTbcpMo6NRMnUbSCJwrn9KbKmOksht/uPAHNPcco81ymPrVLmgDv058cEFgFF9/wzmaQGzWjrRotlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H/PtPGbG55tQ1GKvF/gp/V/8NA+6qU8kd19OrIuDOU=;
 b=ZQFhQxE1mRNM1blE8dtoCRQB7CLwELW9QFGIs2CuXSgQHJHfKg2UEYFo6UH/N8C3DiJBNh16y8luNqOzL7vCMgi0lUFjgwnE70IoTSYYX6TPqof1CC6AM88/9Ovz8iell9+hZm3KPnGk4ZT5+a3vTKxswsTCxIMJmSXC6vw94BrN8STJUske4Qz6ZWkRex+gjryauUYT+xRnk3o/XbTZFrIQGiH05rZxi5vCyg7tNo7SWp88FuWpFEEczoB0Lk9MNn6W9tUalZCpPQM5af/tvUSUmr6xlhbLs8Kxum95gOu0WdED6RTtXnbvWjeSUbpVxEv4S5/8bAcGvUsLcDpmug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H/PtPGbG55tQ1GKvF/gp/V/8NA+6qU8kd19OrIuDOU=;
 b=bu3HB0H9uV98lj3qYF7C8XJPBxqpRXdy4joCZjUyrnrvaoXt3+IYtPTon899a7J0ealdeIvQNI48kAefdPoSlwRAI94qCz367+WIcY2aB7VmqMkXQwEAyQlIWX/DvE5VFv2GW22ulJn+bo5GRvAV3qkZs71efBSZtv+4KOE+lMQ=
Received: from MW4PR03CA0184.namprd03.prod.outlook.com (2603:10b6:303:b8::9)
 by DM5PR12MB1292.namprd12.prod.outlook.com (2603:10b6:3:73::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Fri, 6 May 2022 15:43:05 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::e3) by MW4PR03CA0184.outlook.office365.com
 (2603:10b6:303:b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 15:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:04 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:42:59 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/15] drm/amd/display: do not disable an invalid irq source
 in hdp finish
Date: Fri, 6 May 2022 23:42:03 +0800
Message-ID: <20220506154214.3438665-5-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c5dcf36-3acf-4453-f640-08da2f771c22
X-MS-TrafficTypeDiagnostic: DM5PR12MB1292:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB12921E612D6B1A23A26B9C49FFC59@DM5PR12MB1292.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oA/bmPiEPB1CTucglhK+BXr7da4jlswoFcWbyVTR6MaqT8CXu1j7hDOht9T9e6bI+Fbm5476E5ZX1l96Lof8FqyJydfuj7Svboj5+vz9md2K+U09hgp6uoOSd9mH+VfHrPNgIEK7n1RSWmu7WWHee4dqyF/fKOQmsC4WlVlo4Ii4iF22oxaIVmaifKJRTZA5YkIM9yhc8KYeFf7k+vTyW9r7C8aLCKnHiwYI/XxilU7YHlhlgSrdT5EWEa352BBusss3zWAQ6+2KtL+bp2vQl9WNjeLHIDC93KXSSlO3pd4/XETBX4fe8H6Z4svWZFpPxjX71m9BdXZp9ZAsEpq5TaaAJdCP7LQzEJv0KqZRIUe18QlI+JCk2dHVx3B0oWUnbYwn5doFM9LZuZguQkjlWbbfgv7EaBuHzGX6Ozgir7NSuMhsOLeLmWmYx1k0pcwXCcvzuhdyK7AlQmE770AHK8lyYwQghUvsizb8YvXexvJUYa2qA7/f+Yf85gPspjjv6TeW4mE6HMaj2NULYFjSLL7NawK/vUOzIm71Sw+GPPKjMjxYbBOYRix4xvswToBzMRHz7n5IlUkkVlJp5gF9/MQYJCQsWcwpYlmOwu/7ALjUG+hLgxSGkvOPTFt8OJCkfbEO1Kglfxmec1SnnxZCRZOIqt86OBDw87Yo6Zm9LKkhUfal43s6R3YWHMNEGJhb/uqc7iIAQdRN4fwFFFk9nQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(44832011)(356005)(54906003)(6916009)(316002)(5660300002)(7696005)(47076005)(86362001)(508600001)(426003)(8936002)(1076003)(336012)(26005)(186003)(16526019)(2906002)(70586007)(6666004)(40460700003)(70206006)(83380400001)(82310400005)(36860700001)(4326008)(8676002)(81166007)(2616005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:04.4294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5dcf36-3acf-4453-f640-08da2f771c22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1292
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alan Liu <HaoPing.Liu@amd.com>

[why]
Observing error log about trying to disable non-implemented irq source
when user unload the driver.

[how]
Check and filter the invalid irq source before disabling it.

Reviewed-by: Qingqing (Lillian) Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Alan Liu <HaoPing.Liu@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 4aba0e8c84f8..19f543ba7205 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -928,7 +928,11 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 				to_amdgpu_dm_connector(connector);
 		const struct dc_link *dc_link = amdgpu_dm_connector->dc_link;
 
-		dc_interrupt_set(adev->dm.dc, dc_link->irq_source_hpd, false);
+		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd) {
+			dc_interrupt_set(adev->dm.dc,
+					dc_link->irq_source_hpd,
+					false);
+		}
 
 		if (DC_IRQ_SOURCE_INVALID != dc_link->irq_source_hpd_rx) {
 			dc_interrupt_set(adev->dm.dc,
-- 
2.35.1

