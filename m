Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812EACDB484
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 925F410E4EB;
	Thu, 19 Oct 2023 13:32:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F71210E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FhissA/nGeVZbQVDk6YqPAsSX6vnqeXIec6SZ8c/4gjo5/MPYxj7KyLhN67PcX/bRk4/KxiY5TE3ne69XqTB7foodbhQ/KcMS4KDIlVEISFAh1h5ZQpqcACjLiaZZrMdYOFBFD4hiqpnP0f6689isQ02SiNKVI4V4hppd0+9XjnDEAF0FMq6wFhyKkIVTa6UGO6UJp/zMgwKxF7TFjV1nkTpx/Ultq0rvI4IhwBfgvVBPlknnxVH5QiVsaMpYriX/6WzEk5RA6uqOICeqBEQ8GZG8FsmXml5o+AhAfDD+poz+M6R3y7HLmR82/wzAxBLA4hI4lJpJfyR3BaP96TqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+W5cl/KBVDgmHcZtLkKEfjnWrUIzuaQlyTIzaJCYGE=;
 b=agt6NzsVh3Aryd3adVx7c6ukmf8cvSALJ5ibOfgDimst6xEmotT7MF7vMvBFWRe6LIcwzjJZMY3fYLXF30r3efnIlZT7Wysf1NdIDp2OmuPjFRm7YOoL3xzwmjQ8gOga/SnJBd+t0NmqkMWpvHuJN5LDPvetaz9YHQp6pEbhhtHW+lGGjPO8TT/br1HbrvqWn4xmerbEjA25LRoMw5I9xz/4LZlMPBJaXH//O6OxdFgloOnrQOBtXfG1XsExvaSXUJXsveBM3xSAWJRDPdZlpvD3OXm8TAkK8WYV1PHGME82TyQ/fDkwrRAaDINSbUz96/lG670o0Evwd3px61EhyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+W5cl/KBVDgmHcZtLkKEfjnWrUIzuaQlyTIzaJCYGE=;
 b=Wkj5UO9OV4P5OOkYzQ99FEhGg/+HgaUnLSBnDznXsxiJBW32//Kcn1U6jLZI3mO7o22aqHIPfyTy03cFVt18GzVgJe8aJ+SeKrh4vT8hJGT/BAWddI21FL+/UM3qnnuTgPJ+glcRswMFHVpcVk+nBGo6XK+cl83L3WNhkWU4jRs=
Received: from BL1P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::9)
 by LV8PR12MB9418.namprd12.prod.outlook.com (2603:10b6:408:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 13:32:33 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::2b) by BL1P223CA0004.outlook.office365.com
 (2603:10b6:208:2c4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 13:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 19 Oct 2023 13:32:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:32:32 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:32:31 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 02/24] drm/amd/display: Remove power sequencing check
Date: Thu, 19 Oct 2023 09:32:00 -0400
Message-ID: <20231019133222.1633077-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV8PR12MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa16d21-05b4-4a0f-0f2f-08dbd0a7d96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ytIkogYk3Lg5oxBsG7ZqjdSadqlkQ/Rr24OK1NhNIUEvOB1vEBvAUXBow6BWnr99JQbIIWHdy6z55EiWVZ0kdP0wmsSm+Ic79Qv6mTVJee1X3k7i+g1pVptFR4iNyZl+YVeUYrN8+rgrGvFOplOHBrUDzUUuAs0Q78SG/cDkMCyGNE4Es+wetu3ICh7zIvpYCi86Nmbklz9vlszfnzszFiQ7+FT8YN+rvqxO/oDqbTOJfK7EqAjnWHBE//iwYCmTF8TQ7zJeWgPhSvjNlj+YHPCeyRRUelxym4ynEkVnvWQGN1rpJoZNV7JG0OeykbCFs+6OzVbgYhjCe9NsoeaAEfeaVqB2ofBZmaPvMTO0D1UItCgmJVF+aAWXarIHlw6cI2lk8YrJkIr0n8NxqCv4Z9Vl4O3thRdxbS1PU9E8iIrfuNxaeFMVe+6N89ZhwPuPtEY0KDmv3Y6FAFzRh9yTkirX61fSwqrHT9b2/cqOC0MU1clzV+tutXlpejt1Biu80+SGW9NosMqgh2N1x11djTpJ8OfpYXOOTw7HtftpZDt3wunEyOmAUPI42dojCpnkWYbGO8L2ufJiB7Pl77kYB2z7VCTLM6iJFcwXij9Onf7OY2hYlzQr66bLmp0KLVXZoR3qThqZHzydTA7uSJiruMd4q7wJfzSxdc5tvRIBcqAZeGEa9n9Pa2RfNizFnqq3ZtEEzVfRCtJiiHoQomqrklAqT2IbVjhUlZJ828ctvmI1WPSNCpZ7xGJ6TYqghSuI
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(6916009)(40460700003)(2876002)(2906002)(7696005)(70586007)(6666004)(1076003)(2616005)(70206006)(86362001)(54906003)(82740400003)(966005)(478600001)(316002)(83380400001)(47076005)(36860700001)(356005)(81166007)(336012)(426003)(26005)(40480700001)(41300700001)(8936002)(4326008)(8676002)(36756003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:32:32.8507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa16d21-05b4-4a0f-0f2f-08dbd0a7d96d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9418
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com,
 Swapnil Patel <swapnil.patel@amd.com>, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, stable@vger.kernel.org,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Agustin Gutierrez <agustin.gutierrez@amd.com>

[Why]
	Some ASICs keep backlight powered on after dpms off
	command has been issued.

[How]
	The check for no edp power sequencing was never going to pass.
	The value is never changed from what it is set by design.

Cc: stable@vger.kernel.org # 6.1+
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2765

Reviewed-by: Swapnil Patel <swapnil.patel@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 4538451945b4..34a4a8c0e18c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1932,8 +1932,7 @@ static void disable_link_dp(struct dc_link *link,
 	dp_disable_link_phy(link, link_res, signal);
 
 	if (link->connector_signal == SIGNAL_TYPE_EDP) {
-		if (!link->dc->config.edp_no_power_sequencing &&
-			!link->skip_implict_edp_power_control)
+		if (!link->skip_implict_edp_power_control)
 			link->dc->hwss.edp_power_control(link, false);
 	}
 
-- 
2.34.1

