Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2119BCDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 16:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AA310E0EC;
	Fri, 20 Oct 2023 16:43:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8662E10E0EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 16:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5pocpQFJrB90lmHRVUmxlbUi6ZWWmhk3xS6h6t9nTbnuaeGcror6OTr/TO0uCoxqyrbKfC4azLHHoa88hS1qNN04eraPXgvJHwmNLRFKXNrwWXQY2fsmi0YYvvinWPH3A7U7w3nRlwpStQPUS5z0hP5cSxmpNUdUgdjvAnvqAKY711YfEQgjEVcu6YwjcNCJw+qsdRDduJvCnYtWttvBNDPVplpy/vAPtFyjsZQ6VmU6xMFTBJ8gegjOkl5Rs6J9aq6apq4Hi/j/ve00g9W9ENcdeYNIisQj+N2VuAEnxwyg0HWos3iEB633rfERWosz508hpmPi67cux5hg8FbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc1ZzD+prJK5Dw8WdXR1cpd7uW1zsf/jJyyEIM2dM60=;
 b=XKrp9d1AzfSHZUOvfs8GS83ex7pSkGDib+rRRX74tEZMeJLTl+RaMQYIZL+uCO2yQ5uU2YTSSVB2MO8OXmT2ZsMrJAsh06xBDWNfuFXUSG/Mw8yl3hKZk+lOTdCk5pJ+dPF7dvKQQEiHG7rJ2DtEtvizlufuxVxPGHUbQ7Ykt86bhd3lgH6QqzGVAIuD96ZbDO9YIhVIgF1IFQ0l22Q1uioFxmtbFcO/Z2cLpAh7slrskXa47VAOODqZaSBpV7RfNG1PFDNEzQJj6CBcXPd/9DZPlAn20811q3JHBPMZyffG6wAKgWhcFyl33fqjVyb0FuZm5Yl/JLcuu+rCjSMZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc1ZzD+prJK5Dw8WdXR1cpd7uW1zsf/jJyyEIM2dM60=;
 b=mT/PFhVJZIEEmxqRCis2WTJoi+TIhLW2IbMdwuOVz0MX/ORAyLWa7Nt3YbZMskXsniyBquB0eq/MkCcAULnwHXJmcIvGCqS6cbjsdymeIwWjzsO11O8UMdgzHLu/AhGYvuKC6csROTGv8PVb7Nz1ZdViw0JDJ1seQzYuUcLL844=
Received: from CY8P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:46::22)
 by DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.25; Fri, 20 Oct
 2023 16:43:03 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:46:cafe::5e) by CY8P220CA0010.outlook.office365.com
 (2603:10b6:930:46::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 16:43:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 16:43:03 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 11:43:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Fix DMUB errors introduced by DML2
Date: Fri, 20 Oct 2023 10:42:04 -0600
Message-ID: <20231020164241.463789-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DS7PR12MB5766:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2ca818-3509-40de-473d-08dbd18ba103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWrzJEMh8Pc9qaYwaLwLsqtSGrsfvB+wH7GnzESDPJYHeU3BklxSiWB3wCdoCar3fZ/lsmsZ9fkZYzPuW/5jjbLja6Nj77nNgPuMcg2YuutfML28rPxRc3E9GZVGEgBpCnY3eGpUP3Jd4XCex66uatm88UIp/4N1qEF3Uttv9XGtg/JajghqZIzXOrmyF/1eT+qNwpHF97Fjfh0sb5hXm91jrp3kYAHgeYBUBOLYsPkFp5LpvEyVI5eHbs8OS/7OsLPH48a5Z3nTPzSEKHE+g2sMZPBKwlb7T31sCDp43pwhBrpuwp7ztaq0cpjPq+xEHz10mC1CnTpLwNgCv+eZ+nPDSVyUwxkeTpTKt6yRJLLpVsPZbUbtJPL+kXvBcFjeTqT0wgyG1FoEiBFLPxpSlXVpnGPDXjjgxK6ZhHXIOANYYF7XKbcK+HjfHcPw7v6va7yMBPs93wqQ5XUlscn35fSzjWPMrUhB5ax5w6jzj6FBPfSDz3LeryY2XGiWjVqFzJcFfWmuJfmnT3VLSoyjKWXo9EEJOP34tIlHXF6McIT+LuliXvE8JPXpRjX5ISec3PngxalQOgyEsvV7fzFJkY/O4ZdP1h7DBkGppjS2uiWa+dykFbvlmFLvotl5FyOLvyiB77+MyBKAytyvyZZ7KXfcNMYWhFCxmh5o8ZQVgLe3L53s0HCru+IHkeXdorVx5x6upf2I2OZ/CCLjbZpVb1mQOjpv20Ft5un9jLuSrJIFEoT6QwyPAotT+erggdE68IMvFYbUgHLS4z0aQNbN0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799009)(186009)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(36756003)(8936002)(6916009)(70206006)(70586007)(54906003)(478600001)(316002)(4326008)(41300700001)(5660300002)(2906002)(86362001)(47076005)(36860700001)(8676002)(2616005)(83380400001)(1076003)(81166007)(16526019)(26005)(426003)(356005)(336012)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:43:03.4125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2ca818-3509-40de-473d-08dbd18ba103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5766
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
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Roman Li <roman.li@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Vitaly Prosyak <vprosyak@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When DML 2 was introduced, it changed part of the generic sequence of
DC, which caused issues on previous DCNs with DMUB support. This commit
ensures the new sequence only works for new DCNs from 3.5 and above.

Cc: Vitaly Prosyak <vprosyak@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Fixes: 7966f319c66d ("drm/amd/display: Introduce DML2")
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 97f402123fbb..73cc6e1b0e65 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -321,10 +321,11 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 				res_pool->ref_clocks.xtalin_clock_inKhz;
 			res_pool->ref_clocks.dchub_ref_clock_inKhz =
 				res_pool->ref_clocks.xtalin_clock_inKhz;
-			if (res_pool->hubbub && res_pool->hubbub->funcs->get_dchub_ref_freq)
-				res_pool->hubbub->funcs->get_dchub_ref_freq(res_pool->hubbub,
-					res_pool->ref_clocks.dccg_ref_clock_inKhz,
-					&res_pool->ref_clocks.dchub_ref_clock_inKhz);
+			if (dc_version >= DCN_VERSION_3_5)
+				if (res_pool->hubbub && res_pool->hubbub->funcs->get_dchub_ref_freq)
+					res_pool->hubbub->funcs->get_dchub_ref_freq(res_pool->hubbub,
+										    res_pool->ref_clocks.dccg_ref_clock_inKhz,
+										    &res_pool->ref_clocks.dchub_ref_clock_inKhz);
 		} else
 			ASSERT_CRITICAL(false);
 	}
-- 
2.42.0

