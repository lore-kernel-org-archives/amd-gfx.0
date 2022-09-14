Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FBEC6FA8A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 821A810E846;
	Wed, 14 Sep 2022 05:16:06 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E9710E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oG0ho0frfyiJZklCGLPiP91MWtU2SibXvtG3jNhHDh4OGwhsfyV7gCnENxR/BwQzEKyv/2l8sJCdTmdxAaJhrUDRqTy/ccV0OfI6htg5qfSCfNVHRaUEGejHOPoUO7hrKf45kY7Nw+0taitF/h4e9PKlp+QIJFpskqj/PDKVKPuPycqwMo3OCHEtQc1Dfy3MXxUrMESXWJldHUxscW/XmISQMFIVEZ/3PxDjdT1LjolGqzNQt8M4mhvra2l3H6mm/+8m3rYve8jyO3jy+aszaIXXPooc3o7d5rk3TE+2cW7k4QLaMWLu7xVvioSBdBxe6L5z8zpo0v+zhlBTnDEyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcHs1Y/YywvrNge4YAmsX4w+nyGXzTS5JJRKeExEzpE=;
 b=Z07wE8DuQFBR58i9lhPPg9yHEFz8Jz7CQy+G8G2/WkZe6z9Yy6KIfqAVKF0KY3RKbJSnTXoAI8fPMrxlRLB0kX6T5dFSVvGfDoNYvZOK5vhM8/N1z41oS7NftlGcJwGCcgz6PS+rGMkHYcx33gW43N2lXVNBbPQcamXgGqcRJVr06pdtM7hrLBLuPXk0VZPqVL7QP/5hIKPc1tSzbVT8Hai9lSZ7DXHoiyvJIuSNN3E7BmwVxgxN4K1eAwF1ElIzzktiBA1T5HTBd55gCx7n4H8oanxAcVpyH1e22gBiNEuVZpyQaAsn3vw/mODMklqU8oLe2r5Ko5VYmz9BHp9mWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcHs1Y/YywvrNge4YAmsX4w+nyGXzTS5JJRKeExEzpE=;
 b=TMnQkCDdLkeIoFLn6OWfFrs+WZNfiFcfg7GTaZHduTgrVqkzNojAGzJ48GEJ5rU9GwxAcQwkS3s7cZyzYkuTekvjlj9nBSMT1nUuvF4loUvkWyRupD1XP1NX/wyVHpLm4ycePEU6XXH9tV9fwvW+kyrpcGlA26A7p97PAK6zV6o=
Received: from MW4PR03CA0296.namprd03.prod.outlook.com (2603:10b6:303:b5::31)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 05:15:45 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::2d) by MW4PR03CA0296.outlook.office365.com
 (2603:10b6:303:b5::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:09 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:15:03 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 24/47] drm/amd/display: correct hostvm flag
Date: Wed, 14 Sep 2022 13:10:23 +0800
Message-ID: <20220914051046.1131186-25-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 5385bff5-29ba-46b1-3afe-08da96102d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nq8yiUM24Eyn2jGR373XLviWInjAaEgENaya3Nwz4VoLDHHtrauJfbUt5tuNmXmjsenJ6+e5vgCVbUYpbqVxIh6XOONpnAJJljgBPVof3BqcIuP+TdB+OKjVPpvw40nCSe5OFxBkP+8j7GPOyYF2XBFmZRmvxF3Q3wXU9crUJPxbHdlcEPmzzWPxdlwL7OJDdJztdOjoBX35aIPqpySqJv6aJbVfPhNs/wmA89N4Kb3Pbm3o2L9wpGLeZdT/PG2ltxS87tbLRzuxnjaTnBNSphGUblxNP0bRS+kpdlKvmII9nEGZlorC3AaA+DdM1qLjy4xZauLb/VxKp0IkEAeKfQFTjlTPNvGDMvvAHEqIRcjEuHMyzkW5D9WSKLV81DgQTVuCxJgNDovwL4rGBcDrbFy7eshAlFyEGfeZPzUFeEdMTg3Jo5ni+MAhkUi2UGJeGrceACuiVmksTTD0d8fcLCUxaZaL/jZ2EMAhYHC2lOZ9cQE/a3ZBuaWM1IWjMGDDD6SOyaQzb8dn0bM2u/eMOwRs5JgE1nEVM7RpPhe6zxFScYF0dX7XM6tvvUnBpDsnbNk2PxPHFkeav7fdqoS42isOQcnj2eXxbh3clQHZcKeeIdEPahe4+CHc6I/5BaBJBHXRPw0s9Zez0kWxURyayaSg6cve2WMi8wzGJoZWVLf4jc3M94FFk85Cgtt0N0Ck3SKE9Wy5x2rbdZNZ7HI2A+o5/VEULKHt2Etml4RKo5bfg0cUPOSYNUeeu0T7Nc61RiqYkNDc9YjacpMwKlvZI6efNm7qZrlnIDmoj2lLwJJVV9uzKfX6o5y4Aj5hr8+R
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(70586007)(2906002)(478600001)(6666004)(70206006)(81166007)(86362001)(41300700001)(26005)(83380400001)(4326008)(426003)(1076003)(40480700001)(54906003)(356005)(8936002)(316002)(82740400003)(47076005)(5660300002)(7696005)(82310400005)(6916009)(186003)(336012)(2616005)(40460700003)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:45.2491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5385bff5-29ba-46b1-3afe-08da96102d94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Sherry Wang <Yao.Wang1@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sherry Wang <Yao.Wang1@amd.com>

[Why]
Hostvm should be enabled/disabled accordding to
the status of riommu_active, but hostvm always
be disabled on DCN31 which causes underflow

[How]
Set correct hostvm flag on DCN31

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Sherry Wang <Yao.Wang1@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 8745132d6374..8c1a6fb36306 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -890,7 +890,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = true,
 	.optimize_edp_link_rate = true,
 	.enable_z9_disable_interface = true, /* Allow support for the PMFW interface for disable Z9*/
-	.dml_hostvm_override = DML_HOSTVM_OVERRIDE_FALSE,
+	.dml_hostvm_override = DML_HOSTVM_NO_OVERRIDE,
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-- 
2.37.3

