Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1A3C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 17:48:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BA010E30D;
	Fri, 10 Mar 2023 17:48:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4084610E30D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 17:48:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzHFt5IfesVK1UxcgD3+KMNe6hWFyFNWowvFlFe+BrRFsFsJdLktrKiE/j3D63u8TWjq2p3H5RbTyvQ0OE0ieIKceuuBbAnXz5XTiZl7SE65DLRMUAtrTLYMjgAjH6/DDZmIT94VqGdE5EK+4j4secSAIySaxF/k8532ZKaxq1CyW2gIwCdL4e4Bvv6hfO84YweGPT7giMO/EX2/DA7wMEbOru37CMNn662gNqTn4oViwdg0dPVU3GDILVPPWwmqSF2usYkL3pcAvVVimhPXgKJ3vdIOXDQvM/ZAgeRM6X27NEVOFiufTDD6bYIXch18c5cKS4hTEbRRBCnxUdng7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSd3oM3c4b4MYCEgRVc9sUtDHRoOIlSt0bPKufidKXg=;
 b=lEx2Kgnxy3wIBfcW1Oskj7l4pSoo75j8l11bhPO8lWeGpqYM8uV9+SIx8rJApgbdeFf2D/OuSBfeJCKCIRi2BTBSKX3UWKGUIISP6U37YKI3zodpksmpV2bvV8CzCdiZo4sX9TtNnAp6yXGzl1TU/07Dx/EG7Vo3CaEKcqRlzZTDYx6L6QpN3PvjAz37MqWmgbYxmR0FjFQJmtBi+SvD3Uor6Dmx4oZ2bNNExunX6bSsm5iUxK5xqDoc+f6KKpKZKrRdbnhOdLojYbpTzpbVbULplh/7o8BfF5TxEwxOyKlldaZroa6miGf3/QhIMMvW2doWHn8wQrZQUOTFzIV1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSd3oM3c4b4MYCEgRVc9sUtDHRoOIlSt0bPKufidKXg=;
 b=ZxGNmSJv+Oa18YefL40QvmXvUku6UxTtAvMYvn7PnXBtP8QPeN+oxJcjg5+NSLg/Qj29h2Cl0Rgea+kK+wuVMbiYSEVGf+qQJzoez4p71BTaCe0hQU8kYvDO4QsEyhO/sOTbXRP3pV6pW7is2coWYf5h5YCXZRko4FdaWJrR3hw=
Received: from DS7PR05CA0066.namprd05.prod.outlook.com (2603:10b6:8:57::11) by
 BL3PR12MB6572.namprd12.prod.outlook.com (2603:10b6:208:38f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:48:51 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::d6) by DS7PR05CA0066.outlook.office365.com
 (2603:10b6:8:57::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 17:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.20 via Frontend Transport; Fri, 10 Mar 2023 17:48:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 11:48:50 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 09:48:49 -0800
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Fri, 10 Mar 2023 11:48:49 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: Add missing description to DMCUB
 definitions
Date: Fri, 10 Mar 2023 12:48:48 -0500
Message-ID: <20230310174849.1619771-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|BL3PR12MB6572:EE_
X-MS-Office365-Filtering-Correlation-Id: d95bdafc-7e1a-4d19-0e42-08db218fb53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KRqZAHtESzoN8eDkOWsTQK7TjbYyS1+HQg74j3iZAcW2D8E8hyg7xGV9H6HThjkbIUAJeHMBtHQmqLuUmT6kmgFbPV7LZyikLtBSp1jbEd1/hHdS5bO0lJXQa3xTK2w2+vYVqBAGldgofRh4aW0tCzMqd8uBmImS5tu758SKb3DvZhGnwRKYl7VAdoB/V3Rvl8IamEP77AppM1EtZlQFhlcqo0PqE4Ee9gGNJymLr87UqZH9cbIv98IT4inEKSrZ7ZY5txA2DYHPnqqMLPcl9O8ckSVgiWWrJtj8rc2cQOvtO36QIxt9NG1X4zIU3woHK3KW4MBgP5CqbY+Rk8xKHnaJJoFSJVYThcKtB5qf/82BuDqwXPFcGGs3gN4eeUJL90ViJAaVFq/ZsDLeXAuR95qTttZj9tsE9NKYCsyFpQYBnzvSxsFqpHpd7j5UROiPHzv1NZqJkIsIbpWvydRYPCy9dRyFFoImH4Zj+jeTUXVnORKl4HRnndUMggGeacMH7op/RfI/O64Bl0DyIsnna+oNr5oeyC4quPIY4GUNWIPM/Kt1dwcRiWEHS5fY/Sr3gKb4IcHo93EhxIcFHwTVciM1QG46YvVTVV1kMdeM37jMJ7ClJUtC8xWcNn6786bhkSgPFTC+/fgoKWdGDxSdvQH79de6cl/MFA5k3u/VntXWlYpcSzHYLpBn1hJvtQZzqBF4ilISRvIukaZbQYuFZhD4HXtXnfqTQ/6M4huV05U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199018)(40470700004)(46966006)(36840700001)(40460700003)(36756003)(54906003)(5660300002)(7696005)(6916009)(316002)(4744005)(2906002)(8936002)(44832011)(70206006)(70586007)(8676002)(41300700001)(4326008)(40480700001)(26005)(82740400003)(36860700001)(186003)(1076003)(356005)(86362001)(81166007)(2616005)(478600001)(83380400001)(47076005)(336012)(426003)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:48:50.7124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d95bdafc-7e1a-4d19-0e42-08db218fb53f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6572
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
Cc: harry.wentland@amd.com, aurabindo.pillai@amd.com, rodrigo.siqueira@amd.com,
 hamza.mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Provides description for some enums used by DMCUB

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 734b34902fa7..4f67124d8e68 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -717,7 +717,7 @@ enum dmub_cmd_type {
 	 */
 	DMUB_CMD__PANEL_CNTL = 74,
 	/**
-	 * Command type used for <TODO:description>
+	 * Command type used for all CAB commands.
 	 */
 	DMUB_CMD__CAB_FOR_SS = 75,
 
@@ -997,6 +997,9 @@ struct dmub_rb_cmd_cab_for_ss {
 	uint8_t debug_bits;     /* debug bits */
 };
 
+/**
+ * Enum for indicating which MCLK switch mode per pipe
+ */
 enum mclk_switch_mode {
 	NONE = 0,
 	FPO = 1,
-- 
2.39.2

