Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456D0C4707C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC55610E4DF;
	Thu,  4 Jan 2024 15:53:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB1C810E4DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crJaNKpp/0WHJRqJvIvTS1Uvkc5T6B26eL6JPG/pSkbaS7cHBGKlip/fPZXmuTCQmutMxEQIGb5kIuq0ui1fRYUJder2JGVFCojEUjcordZHDoNzH4nQ5IGOyaFmIZxKA+KCQYwHiBJj+rMKXLNDQfwrQbPYr6tydLpqogpTA8kz5lPBN4AUMCPAQqoUim6NyaMaI5sAsv2NWBc2qFdAU1yIiFX4MuVB7i0x7mwS+c+P34+9n5gO5abUERBBQs6mW3EyTKNYZ3/DKBhxDdjrVU+cT+7TxalR0P9YrOPMu4WcAySXUjpIZGtazFrxu1jGCPAnXfWxtsF0VIQoBy7o8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/qjEP0F8eb9CpsJ5/HMfsNxo0oBRyOrFw2QzTrB+D4=;
 b=SmVW/MwLhg7eidRhvqE2sY8wCqYufaA5W7yH3yaZjdXj4N8i3e3ZjCr+NHEeS/qdLQWXqYTIh2q/cF5oOTpE9DQoWbax3YgFqCaFh33l+ZF+1z97nVdm7NdzlWzOU9cdyGNTtOO7xjuzEedbrMkq+mIMI9OXOLjOOKlutcPLO73enLnzsL35jbmTGnbOQthE99dZS6cZsTkZBvvjswh64kWpZL23Rm7AvH0kQUIzNFnoDu4UVKn2NtxDIO3jVKtiQP/O5qjJer84cY2MEeguroemAzDAVfZBZCG0Mh38+DmfKVfpgMgdqe7Ib16EaqWitU3n0rY3GblXzX7rO5Ngag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/qjEP0F8eb9CpsJ5/HMfsNxo0oBRyOrFw2QzTrB+D4=;
 b=29XFAqbDhnJI9GOFmmmGChQTVxkEWi/3IyaXLjywoySXeAqKnnWnBFX3cB7g53BGW+QcINeAV38xUc19Ngc5sOpiIJqi8mf9jQk28BCcdn/LOuF7DCD4bojeZU3x/mLr7ZktM4v6XF9sE3kchE6NDn/qGyUtfdzZSAw9BlxteM4=
Received: from PH0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::23)
 by DS0PR12MB9060.namprd12.prod.outlook.com (2603:10b6:8:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 15:53:30 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::a1) by PH0P220CA0023.outlook.office365.com
 (2603:10b6:510:d3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Thu, 4 Jan 2024 15:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:53:29 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 09:53:25 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/10] drm/amd/display: Update z8 latency
Date: Thu, 4 Jan 2024 08:51:04 -0700
Message-ID: <20240104155238.454117-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
References: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR12MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: 623092ab-34b3-4518-f4dc-08dc0d3d4bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FdEqEEwwOAe76CFvO84lBEZdJkO9AH9fEqRZGRdgx8n8agiyOSwocc1TRrlOvpSuL3kFZjHQdfUcWblFQDRsT2U4WbFaB6IY5Mq/VKoaSdvl5XkA/ser1xcNHtLs0EZDBjuy0gjkS8E0V8CQIOjJGIIU2SSIA64I79OOk0/f4gy0kwNueMyvRgJ0gXcVrPhSmybtEN9lXjSWzpn8ZOr84j7Y4V9MeQEEHbuVOVSVO+95vW6/tJcs38m+cEzsolQmvos5osqVMPno5qImQ8/YVfaoqCdyyBYkuYnk3W61bl2MzvluSz6HnKkLWmg76QGXPofZ+CADUKJpNB4ji3e5j5F9Y26iClaMLk74RYb7BbAKOFxYOG5Wg21U0OmoXaVAn7AjkxOcg/vwdpNjk94KDWl/t/9+zcNwlAY6iBdAmBPuragFxlJTTqVyncM1x+QkMW8Yh5O63bFLDh+gj9eQt5sWPwGwMfC0ezVojpPfdc48kp8Z4hlo3ojE8YiW/YOsc3+7JETeNl0sS2rIEBU/C6HnnyR0FnHVvwZ5/kr3tfvJxoy70hFOWXyCgrE4CcUQws8Eb2omlnMg6yy1SI9qjprUx4vF3RNcnJU6Bw5W+jWOmm9i0yzl8m7yVM2GChfvJ25JTvMj9+bPTPH/fqlY3VUp2kIMY7pmxWKaBS5m/aSpo59wRJhYap11UcbsJLXFLYgjn++5S/B1qvUNdUDlJ1rcSK1clMFEUuh9DzIgCJtsfapi8FQjTj/4WDOmjSPwKEkD+LcOabBWRIb5EnEwSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(36840700001)(46966006)(40470700004)(316002)(86362001)(54906003)(6666004)(8936002)(36860700001)(8676002)(47076005)(2616005)(26005)(1076003)(83380400001)(426003)(70586007)(6916009)(70206006)(336012)(16526019)(4326008)(41300700001)(81166007)(5660300002)(82740400003)(356005)(40480700001)(2906002)(36756003)(40460700003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:53:29.2995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623092ab-34b3-4518-f4dc-08dc0d3d4bc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9060
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
 Muhammad Ahmed <ahmed.ahmed@amd.com>, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Adjust z8 latency for performance.

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 3d12dabd39e4..475c4ec43c01 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -166,9 +166,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 	.num_states = 5,
 	.sr_exit_time_us = 14.0,
 	.sr_enter_plus_exit_time_us = 16.0,
-	.sr_exit_z8_time_us = 525.0,
-	.sr_enter_plus_exit_z8_time_us = 715.0,
-	.fclk_change_latency_us = 20.0,
+	.sr_exit_z8_time_us = 210.0,
+	.sr_enter_plus_exit_z8_time_us = 320.0,
+	.fclk_change_latency_us = 24.0,
 	.usr_retraining_latency_us = 2,
 	.writeback_latency_us = 12.0,
 
-- 
2.43.0

