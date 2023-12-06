Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09CBC4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A95E8825B;
	Wed,  6 Dec 2023 19:52:46 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FC210E5F2
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAAuYO4UTXnOwf83EmAy+oFkN1eD8jJrMOnqU1jQ3oS8h0zP5pFO628IFSyyCLeSEBLb1w84cSSUb1yKshKutCKCP/9VXHPGzoUUpbNtqLY5+Z+g6yzm/O3LbLTR1pf6HEqoUYlM6VoHjPv88tV/Ny9d+GWggMgMpm9jpHyvpJ5hNBEVkZYX4k62DID3F3r/Zw0D84lOKEuMyG1oTlSCK/YE6hBPv6u85C0k1ExtG499tSugOgFUHktUgF6CTJJEl1yRUnmk92JJVqOaqtDTLWSt98ajAPRrpcrtmSS+YQLfUXi/ss/wcxRKt2H48VvpkuHE/OIM5/K/jYYJVkvedg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZefKJP9XBDbg+oB9cFMVzble9B78jFJWlh7J81F1gA=;
 b=G12W9G6f6dU1FJsJwd/Mo123a3KH/IXzDiTSRwg1iLtfvJ8ehkGYRcPJI0mSFtqaS+hxRclur2XiWxwVP5jgnWneJUxp5IbWA4c6N8YdBwjL/n0WUTJ7n0XQorNpPvh89YjSq5LbR2egNzmm2OfcSJAGCxTBUqOpJlKYN25nxy1NXzjHjtnErWtqF3+Iol5QZKoD8kZruL1qNYRMbilRFdUO23wqlhO/xDzRGdmcbF0vEluXezmkBy+Fa8sRTBSc6TZKZNGkwUicEnR19q+weOSC+dUeqc+j4UVgiP47a7EvdDWpfOxsllLD3CFaOjPH2Er1w8JTzvfZxiejoPL4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZefKJP9XBDbg+oB9cFMVzble9B78jFJWlh7J81F1gA=;
 b=pyRGQA66pqN4f3NI1kreA5ZVjbdsUP1R08K/koPXVAnPNjTHlDYoi8BEF0BmGELV5DYlhXFQl1OvMp5Jt9hPW4gX0JRVCen4K4qj8tMFTcb6zlyjN961XpsekKbkBwycS5xJJXCXIVACQKVSVljtwLAkHbOVZKujVx7S1QWMXZU=
Received: from CY5PR15CA0167.namprd15.prod.outlook.com (2603:10b6:930:81::13)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 19:52:42 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::99) by CY5PR15CA0167.outlook.office365.com
 (2603:10b6:930:81::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.26 via Frontend Transport; Wed, 6 Dec 2023 19:52:41 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:39 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 6 Dec
 2023 11:52:39 -0800
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:38 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/13] drm/amd/display: trivial comment change
Date: Wed, 6 Dec 2023 14:52:26 -0500
Message-ID: <20231206195234.182989-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 522c815b-9d6c-44ce-6a0f-08dbf694e886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrkoPKqXKCESelIWxtqqVet66SFibsqEQUNMdCIXQEeKDgguLGO8TrXwqNZHh3LhhbiK/Xgu/34zkpuGjRykLYl8QMYLkLh2EIpa7Gqqg0w5wGGhGatdSf2iD4O/1/fcpuRd6z4c4hnd4ZLbVwmNtyzynkpPFHBJVRKL+qdICf0dlp+rSk3S3KOYFQKzQuVFkX2yMhZV8PcsMKJNqvgTKDdeIijUOkucgOx4vdKomN5WXIk8U8Vi9VRgJFakFV1BHhYwNI6k6QTzoopqFUiViQesprH90dj/4+2Yx8L1xxm0H8f8mSP+cYtzEpS7gP1WvTwfst5WR8gH1iVRMhKyJjmO94uSxYUyiOlsVexj9NgsDx+fWjZOCYOXh4NSwtG1ryy5YBVI1vxJzoYa2TzZq/Hp1IdMowDHzdRMr2wvdRbi2XZ1Iu/eh6pg0Vh0CyyA3PYBTjCqltnbHBI7WGRJc6emwM9ujchGMoQ6Y1MKxdHJryw+FgSkWpF3C6IxJ8Q83A8UUX0F68d2pCuyrOnzGmVW76sBb5NjHv8puoSBUfFUdFeac2QFHyUTFcX0s1IAvrKh+xPLLTRnzUiA2sz57qrtxpmcEqUf8IRJKiQloKOrfvlLuAK2SxU8GwoseB7L9ymBGSrntBFjYAGhjX8dCnGRMzDoFjuecTpCBr3gccVPJfmZyhc+D7by4Bdl6M04z8n3Hyug3bDH30vg2gojXxS/YUL70x76VRIXDh1LhZnY3sQ+qKnj6hnu5XOW6XWicUZvnwK8yIM+tXGXxhA1kA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(82740400003)(36860700001)(426003)(83380400001)(336012)(41300700001)(36756003)(47076005)(44832011)(356005)(81166007)(2906002)(26005)(2616005)(4744005)(1076003)(6666004)(40460700003)(478600001)(7696005)(5660300002)(86362001)(70206006)(70586007)(54906003)(6916009)(316002)(8936002)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:41.8835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 522c815b-9d6c-44ce-6a0f-08dbf694e886
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Chaitanya Dhere <chaitanya.dhere@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

FP guard is valid for all recent asics, not just RV, so fix the comment.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 3e73c4e59d40..7dacb0f82d29 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -368,7 +368,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 	}
 	break;
 
-#endif /* CONFIG_DRM_AMD_DC_FP - Family RV */
+#endif	/* CONFIG_DRM_AMD_DC_FP */
 	default:
 		ASSERT(0); /* Unknown Asic */
 		break;
-- 
2.39.2

