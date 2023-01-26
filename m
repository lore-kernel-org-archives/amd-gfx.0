Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91839C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A66C10E8CA;
	Thu, 26 Jan 2023 00:36:32 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C22C10E8CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:36:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYjbu5Qz0+88EUmeoZUPDBcoWDFkZt0n/9owb3DhSyLHZsS0hDONrJsESf13bjnLhfiiLsrlX78k4JAyf093io2823hfJnQ8pEsl5Sp9nux+AXLJu8krdEyMRiRdLCZd9bOBWEza1abOi0Xq5JRsv37YeoFZI64+gLfl17Np4n0gdkpw1SCntMObIWM5KVIb5HmNzLr40ECgokZna8WasF/BzEDFqQonratGSEx2vZLyV1Gmksfn/G3/KbQiHOHtyS5PdLpurln9cHINZoD9m3I5zosPF5ME69rHI3bmySezFvXLk5Oi6KjFv4qWc5u5PA9L8SNh7nf1PX2BAemOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kSti45630GLDAHIbinkE2gijY2vEx8XGdFdK0drFpqc=;
 b=m4/3iZWKxntqPEOX51hO8XYpeHR0mXJOg5VXa+IWU/izwXoDboKjFlSs6nY/snVbazxcQp0aoBtTlGNkyS13RS5ZfPJUsgv758SMkXkVZKRT83W9U1pCXHJPfiiiskz4YrvjxPqRdYjADoMyu59KdpF0lgFEn3PmlS1YX5iW5D/cpz5f/mzhZ7gPEYnzkLdDZHHu5gL5RQ7VHwhVGrax5l7sRX1b8qbxv1hZXyKQ+SzO6ZiIB04uYQm4LXEkxj2n6/dNLplDmjM5yBzKPtist33uk6UrngUJInfTrgmURWVW9ZK069sPUWmWkeQxy1rWHb3SfaJf6ytB7jymF4O4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSti45630GLDAHIbinkE2gijY2vEx8XGdFdK0drFpqc=;
 b=ls7l5uozZ7zun+BsScsCTpATuwjfELYqQQ0gdZnPAkxGRxi33sf9kpn1kcV9VRJ1xUfoCCImADCCeFaQ/0kfrUE7I1pvW0kBjmhFS4QQ5CY4tmxI+ucQMCig8sJcQfQxHSDjguaWbgqzqB5zBw1lWlP6t9QZ0Lvm245t9Xtnw+8=
Received: from BN8PR07CA0022.namprd07.prod.outlook.com (2603:10b6:408:ac::35)
 by MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 00:36:26 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::d6) by BN8PR07CA0022.outlook.office365.com
 (2603:10b6:408:ac::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17 via Frontend
 Transport; Thu, 26 Jan 2023 00:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.17 via Frontend Transport; Thu, 26 Jan 2023 00:36:25 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:36:23 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/16] drm/amd/display: Unassign does_plane_fit_in_mall
 function from dcn3.2
Date: Wed, 25 Jan 2023 17:32:27 -0700
Message-ID: <20230126003230.4178466-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|MN2PR12MB4192:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4c3bf1-45d3-4c43-16d8-08daff355b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pb7DRkzdtBYv5L/za5PHobLPRQ6j5ztaLbzIFE/Ci7efEJvKzs+emEkQ5CQ3tI2XAWbdoELIBAvRTbuegWVIi5We4+kIBnjO00SiKblBIvKwaLVDDiP83DKG8vnOZMLlx01LpwkjDh/goc/eK3s5dzdjzP+5vJGJlGgU3cyAy/Iimz5eu+deTRFIMWmsSpvpRicpgObdzbX9lX7w6ZJ/TlPA/5kMfecKwMveP2SmQCuEopuI421WSIIkl5AsxVmttzVoHZVuVkCa+U7TwS4vN2tlR9h6H2N+ykdp5mgiz4/BykQN+y3Hz2jk2OiV0WJFJdwG1yVBaEgVBoM1cPaK4nWw9Tnq9zbVnLo9vXT/93U/UjS5LGPhz0BbMYduMCWcr5u8goJCbxNWGkhntSBR21kM9gIExvh//ojPlcOnxP/Wfx6go2OhPvYkW0TPHV4sQEivwMta1VgAls6mgDJvQx3J5J1NHNRDLCmV5g2ubBoC+cudRPPXLK+C94VSDNOdUsXbmTTDZdi7luMiV9RNBmuRFA3UGSwEphDXYW+IOkZMsyCezMjT90ThjgRoYSl+QPADWK9LlZuYdXBfKhnFWB0uKp6LWY9INpclpjIt+cbCfD6i/U0o5AifI5DxERtAkfJ7cPZ+RDeCBftXrXH7qZqkZS4X5TkByJq6DqhhuIBLqYvVHGX8KNJyxt5Z1e2Mc1+fJOPnolmLgkLbaBvrsKWqLQ+NViBkAoD1KGsB3bk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(47076005)(2906002)(54906003)(426003)(70206006)(6916009)(70586007)(8676002)(36756003)(82740400003)(4326008)(40480700001)(40460700003)(86362001)(5660300002)(8936002)(41300700001)(356005)(81166007)(44832011)(36860700001)(1076003)(316002)(26005)(7696005)(478600001)(82310400005)(83380400001)(336012)(186003)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:36:25.5023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4c3bf1-45d3-4c43-16d8-08daff355b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4192
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
The hwss function does_plane_fit_in_mall not applicable to dcn3.2 asics.
Using it with dcn3.2 can result in undefined behaviour.

[How]
Assign the function pointer to NULL.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 330d7cbc7398..a02918eaa2c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -94,7 +94,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.calc_vupdate_position = dcn10_calc_vupdate_position,
 	.apply_idle_power_optimizations = dcn32_apply_idle_power_optimizations,
-	.does_plane_fit_in_mall = dcn30_does_plane_fit_in_mall,
+	.does_plane_fit_in_mall = NULL,
 	.set_backlight_level = dcn21_set_backlight_level,
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.hardware_release = dcn30_hardware_release,
-- 
2.39.1

