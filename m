Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8F6C001B0
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Aug 2023 21:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196E710E298;
	Tue, 15 Aug 2023 21:30:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098DB10E298
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Aug 2023 21:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W866XkewXSZ7vQIaW+z9Qqm3f7PaMoPbRTWmoHhHHcCaGUR9VlpKhhcHZ/2NYpZRrq1R35ibgCgiWSJExld0QnJuKXujF0w0o5jkcsaPyvqSnYBld33vsCH5WkWHly5lGr09AHHT3VJ3OGdgsel4nD1JnOIhOUJP/1gxafCrpo2NYdU67vNKpxK4Uh3djzKmdAof5DNo64lKGoDTTQn8BYaJyFIucRfR8iGXYl016su6+a7YZy0NpChlxmPo7Gs6wAhLmCjSxQ2PzGgt9IkM2KLC4Z7ry2xQYMPYo/nGL+G78KzzKFyALsdlfIES4q2k8RNDS5L6CpowYKuIEKPMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8n17hjar16j9B2Fd/awDyhpzZ4r9fW7bb/SxXsP92E=;
 b=gZeT5qEU2DOaKjP4PX54T3xGnxRZKGPa/9M3/9ULlcdTMQx4n7n9USKCw0RopCovLkYG/fqvCntfdCsyU0IXHUFviJVAPHP7SPwa+dE72d9uL4FgFogr6T4S38pUl48N2PeRVUZf0XSkq3DStdxNqg6O9YMyJq9b+Dl/kH55Tfgi6BYEKNjYApsTksd0zfQnqwxgRDk1f7BD/LHnuvjmaVDeN+wVx3dKYirNgxpXvm5LJGYb6oZfXMNQX0mlCGJDnp+DycrczZTMRV4OdQVVhEGVv51EsWq5voQ7YXKTNuVLv7NtXUexRv6A/aHXf57fnZC+LSJPJIvlahS/WzuB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8n17hjar16j9B2Fd/awDyhpzZ4r9fW7bb/SxXsP92E=;
 b=i4Oq24dUqIO5f6Jx4+h0rDMcHh/G0Coi1DyVkWKJGXFxY+k8oLokaZSwkC8hGg0pO3O1tPHHbq8cFoNQ+t4iOECfTWVo0k5m5gXQa1lB+xfh/AW2eo61+NZceWAOxt/XiFmKIyNY4qk1jitTTolRU32Pd4/Mvp+qS2yMzNdHaXY=
Received: from CY5PR15CA0043.namprd15.prod.outlook.com (2603:10b6:930:1b::12)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 21:30:02 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:1b:cafe::7e) by CY5PR15CA0043.outlook.office365.com
 (2603:10b6:930:1b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 21:30:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 21:30:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 16:30:00 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] Revert "Revert "drm/amdgpu/display: change pipe policy for
 DCN 2.0""
Date: Tue, 15 Aug 2023 17:29:48 -0400
Message-ID: <20230815212948.1841247-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa14709-4be2-4d13-bdf5-08db9dd6c8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jXlvSerkJSn+r+sVUBySGixEzgrmAOaBrb6wtZRu9lG7e+UqVnVmK/4Ds/YtXpiRhzGSZCzh3odZRCgVdMTdv81aAxLQ7smUwXBoqAhHif6KTOcvbM4NIet2JeMw97uD5F37AMkAxLHz7F7p1coJ2ircr65u2+h7LwTw5P5int9QNw6Eomt1JYBZN3g5gToScOqgGJ3neOTj9gyzkroeXzHvlIcMH9d7NWLHTQiPKdyrKHohIEFfWEMqtwCyTPKjZ9kX+aS/ZQ0ngzFCNFSfoT9ighFVYQdmPIqEi0USFoDaEiO7igOtTXmiYsFKuOcQQO2xNf8z22pR0UTttrOEXqLKf7sA8AcZD+wUiengC3sBq0bOikn7lItomUX4/yzA3rzn1k5efnmDunzCxAIpDBu9sKsEEQkPhti/JTml7MAusC6KAinY3fE0wAEYdnSScRzPW7iIzainJRcQeRp6K+3pwIwPLLzUtRbKBwh5ju9SwHqTcL+PuTh4YR7j52B1ZGl6l4f6Fbj6PE2xfSgp8vTs98MkgldohXhnUNAoAUU/xh7cDnK02Xwn5sw+fStYAsH7fvVBk0hu0hqde0Vtz7i9nH1kcdcvVeYoQm24xrFI0tsNGfPv04gjC3WZ8N+o+6abXygz2yuNZFkiSg1/G2hbAKtQrlsUagS57RNas894pl9u4DZLoLpxdSapY0/0h+10auevvbnGTzQihHt31nKACB5xH+4xwaBKfmz6tHSbdGabP69/WJHYU1WpQne0
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(40470700004)(36756003)(86362001)(40460700003)(40480700001)(5660300002)(426003)(4326008)(8936002)(8676002)(2906002)(36860700001)(41300700001)(26005)(1076003)(7696005)(16526019)(336012)(47076005)(6666004)(83380400001)(2616005)(478600001)(81166007)(82740400003)(316002)(356005)(70206006)(70586007)(6916009)(966005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:30:01.8469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa14709-4be2-4d13-bdf5-08db9dd6c8be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 27dd79c00aeab36cd7542c7a4481a32549038659.

It appears MPC_SPLIT_DYNAMIC still causes problems with multiple
displays on DCN2.0 hardware.  Switch back to MPC_SPLIT_AVOID_MULT_DISP.
This increases power usage with multiple displays, but avoids hangs.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2475
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index dfecb9602f49..000fe96203c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -712,7 +712,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 		.timing_trace = false,
 		.clock_trace = true,
 		.disable_pplib_clock_request = true,
-		.pipe_split_policy = MPC_SPLIT_DYNAMIC,
+		.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
 		.force_single_disp_pipe_split = false,
 		.disable_dcc = DCC_ENABLE,
 		.vsr_support = true,
-- 
2.41.0

