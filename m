Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326D7C10DC1
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C7510E73A;
	Wed,  6 Dec 2023 19:52:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE43410E66B
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoaZ1fNcFelP1CBW1nl3g2oxsD3U18hXXzvWeDaCenN/cCorhqbIaK/bMApz7VRA8bD6ndY2Mgpa9tQD1MHZZoDmQ+GAkPLcdEcJQaEphD2aUWYoDV818LiBCVJUcytBR7gKdHc1cjdEUVBy/Fqn5bJcAU20rZ6mrXbUy2GBDUKBfHCcfS7NY1Y1RxnItx8VR5TYGQUElYRr6dmdQXDdmzTtswLyQML2rAb2DG6ELnW76ucPwkng0e1TJa07mBX+Xwv9bpbrpV+wnegcMfn/+/Nm6otB/VQLGslZKP2Wr2OrSGjhEAVMJ/cTlKbAGWG0Nok7T9eUYJhvDbHxMok+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yzd0cR5gXa7LZgo8hqHBcME0d+RfeBfiCvohpyZLmgw=;
 b=N0+FBQmjQ/c/CIlmpLf0xf8SdTZtQZ5wzgLqfr/wpbgJjv1p03u6aMITunGyhEx2St0iVSkFRQoLtN+REDAZ8kAzDxVhtmfKHtE2Hi+O9UyYvKPOAofPWRGCkXfuS2BWB/4kZE02MZqF03vfGqgpXHNqkd/COIcAO32BAcSYG3y3TBz5UvA/mIqoURCQcAS8nIA7jUsiKhwxZmi5xILQAUkoVuG3FiZytnnIrH50OYrZZXO9bbsxbdfNfMNriefb3sj0n/59tuROs18eI4mUlDzYpx5PyVpEoJvHQCmuE4CaJy5Di/yOiOdBdxVTQc3rzM9B0UN8QNlmqE6mpMvnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzd0cR5gXa7LZgo8hqHBcME0d+RfeBfiCvohpyZLmgw=;
 b=Kh84+xrugMCwYUwCVmZivhffi3NIVUz1edUB9jD58CzkRIVF2Pn/lDK02248cjwisCP/olBXtBYhfJB0g7JyVa5nQMhYG1gC+bmQcKMWziQcGv9eVZiCXtHxIePFqeSe8WUI0gnkFPXEe2rJAgMUbYDugmoQPlRMKzWMFbTk7bM=
Received: from CY5PR15CA0184.namprd15.prod.outlook.com (2603:10b6:930:81::25)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 19:52:43 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::70) by CY5PR15CA0184.outlook.office365.com
 (2603:10b6:930:81::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.26 via Frontend Transport; Wed, 6 Dec 2023 19:52:42 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:42 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 11:52:42 -0800
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:41 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/13] drm/amd/display: Disable OPTC pg to match DC Hubp/dpp pg
Date: Wed, 6 Dec 2023 14:52:29 -0500
Message-ID: <20231206195234.182989-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c25e3ea-2d00-44fe-0059-08dbf694e91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06DR4IGqeFjLoOAr9tH3CY+TWl0p/6mZdYKq7iyaawTKOWvIpCvq55+C8ysAyDr3b7spPuPJIYHiz8DIQzAvo6gGnMtWk5GNTe08ADQIlrwj1Xh9orB7BV9nMRFKyOEcA8ggH5H7qMRWVnQQ32Fc5HR1ffQtTI2C2fAMI3FpIwVBuw0cHkJkEWoZI7Kz/voXBKgiM8lkPeCBZfuSKs8KYMP2zXKoomdXI5W4KBsC3x3l1be0C0ZLhqtCN+yRR/Lz5Dc1tzZX/YsDGC4Lsl+L6hKjt/ZTXepyBHX5/wOzZNFvx1kLZblVTezHY9WtzLLiGyrcbTTcZSgih6cTMM2xosU6dj9XfbD6g2VsSb9ueriHk1a47Gtqt+ON+KusBA3BmKN1+htmYzU8SgkfWtdzkUeF6VUJKi47hXOaLERLwLUieWsD9D02TQ60Jcqt6sxbLX4LhV8NiKNH0XlKRp/XZGjtLcwGgAqqSOMafVoE9Xv0/mpGMku/PMyW62fC7mG6frU0T2PtklpU5163DoSg7OibZh0wkwKHBZQF2+18EQJ+6w95s1qyAkCh37TANCdC9RWhYRp2XVsdRtpMP1sTI2gSqDL4rEJ3gF0HthvruprDerHi66+bcKH8CcQBGRWVAwLU0Aqfn996j37DTVzqzHqdrpmBF3/pfw2nAl0jN8CaRwz4MK+LAjFdOqKACH90QrWjbfKdGqd0+WzJfG7yvheT4+rDyCX+/BWQyIu2NormjaEhld4MoKqeZk4I58sZyCwFysNUktXjukzy4Mm7gA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(82740400003)(81166007)(356005)(478600001)(5660300002)(2906002)(40480700001)(40460700003)(36860700001)(4744005)(47076005)(44832011)(83380400001)(86362001)(426003)(70586007)(26005)(1076003)(2616005)(36756003)(41300700001)(70206006)(6916009)(54906003)(316002)(8676002)(7696005)(8936002)(6666004)(4326008)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:42.8679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c25e3ea-2d00-44fe-0059-08dbf694e91f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Allen <allen.pan@amd.com>, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Allen <allen.pan@amd.com>

[Why]
To match the hardware sequence

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Allen <allen.pan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 13324422ff50..4eb744f1bc9f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -717,6 +717,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_dcc = DCC_ENABLE,
 	.disable_dpp_power_gate = true,
 	.disable_hubp_power_gate = true,
+	.disable_optc_power_gate = true, /*should the same as above two*/
 	.disable_clock_gate = false,
 	.disable_dsc_power_gate = true,
 	.vsr_support = true,
-- 
2.39.2

