Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF94EE0203
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8069010E245;
	Thu, 14 Sep 2023 02:01:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D21610E244
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xgf4kSKYsNVVupf3KXxURmD4FGo3XhV3X7bp3Gdis+UJpmyIIqRlzuJqdi3JHnm2JZoSVioLPq96gp2H4yqS4JqLWN4GD/MFvZgW9n1uNHAVmlOfMAbin1af0C6IbmMU0gnK53biv1B1jwHs0HtmiRFvJoBJbrvWD6+C5KuTVM5pnjWMxzdv64+/PI75QE33lqYKBbjhfWxxDUBO5aE+RMAyY1exwVchbAL2GdJhkxEVohh+j0MSxCBIFypxvrw6yDaReH+c8Wwcaa4QDluPzDUuIxxtNHlwIvS9M4snyWMmes3E2v01B1MriOVP10lD3WMcQTaw2RnG59sNyTo+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsUQegc+OC0gNJxv2tykL3G2sian9oXe4eQD08eFSZY=;
 b=EL530k8JcI6dyrLlBM+30laGnwUKKqf71FR9lo3lLE7m7c7B3HrFTGJ6xCgCdtAqZa1/eQiSoaG9VH/q/eAh4LtBhu/U16sm08cva7ADdaEMUajTpE33xMG148Lw4LCltnhyayP57HdeUgWWzSXJ2mrCjvbY/7a3CiBOZlUKzfToDjJEQeGMO6H5FcM6ttTC1pu0YXpwkkg00IDRqMGbZc/UUsZB7xs9bcpF3kKPyHx6wIIxg8V/nOcLSdiJzwMXtMjaEJGe3lUlpMkxxaldv5kXLY1WzTMDYhqc0ty9MC01Vp+79EC5QbHr3yxajxA06jddqXNxYoXbov8Btip9rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsUQegc+OC0gNJxv2tykL3G2sian9oXe4eQD08eFSZY=;
 b=Qi38cy4XKZ44135F/nE2ckXQ0r1Gl9XBMO2nYoqh0rqk21wwVEEnI5GFH3Q+e8ZrrKWpVcCvQy/IUbU4Cezwixt5Wwj7f5sV1I4SLPs3sM6/KrYW+Bs8MSM/mlB5zgAewo6dbga1lVauTAFqwd4AmcAUYfj3WQLCeW3uXOfbpmU=
Received: from SN6PR2101CA0002.namprd21.prod.outlook.com
 (2603:10b6:805:106::12) by DM6PR12MB4894.namprd12.prod.outlook.com
 (2603:10b6:5:209::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 02:01:52 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:805:106:cafe::23) by SN6PR2101CA0002.outlook.office365.com
 (2603:10b6:805:106::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.7 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:51 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:47 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/28] drm/amd/display: disable IPS
Date: Wed, 13 Sep 2023 20:00:09 -0600
Message-ID: <20230914020021.2890026-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|DM6PR12MB4894:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e48701a-edf4-4743-af9f-08dbb4c6904c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GX1GxPZ9fB4vis4uBH6j8W7OOI8PR4hvrPCS9AYVuJ8rId/iMyLRM2o3CdZ9WIZ5ArsJGBMMeupwujgo0mF2MIusKB+CujSLeJ5H9zHABR8G0GvIXRKDrFoI9xUVRpXrqFhcOJ6dbV9SSD+kL96c32Hy1TC/3gOaO0OHPsRpXDSXRQWk2NvGYPY3/ESop/AphiHL/xgVyQJXt2lzv2eNg56se6orYHXB6j2tdCDOyPK/tCt/T6a79Yg0f1nywRnpVzwYSJd+TB0u5Te7xDR4DuX48MKQu6X9kS+7uOhJ49rdLzaeriaw5pZwV/7UXs1fqxzlsGBfCBZnnrOWH8hQyEsMmUvjlacthte5DRqI3QvqLX86M6g2cONR4zlMDRBtTuN+btTvlk4ZGKngMGCZpWCQkXAEVx4xCsff6+4ftlEKIVuccpRMK6gS9m15f9gjKgx3lYVe4GZXNDSk8XrZ4cOhqKX8CW6winbxfMArIu30iA1gb0lolCJdDa0ocZ8R2rdHtdFdcf2zkCgUZ9mFpV9vJoXm2yXROKHNFTeqZPiw/+j0/MFEreunVcrivmxroJAwVVU+Y09WbGgNB09vPVsy16Y/78R0rO1SO1kTa4rQ+uTIALig/4A6evec8+VhXHlSFN/CN7C/mS1bCNRd+D7Lyd6S2NsocDQQsfrCfhIYEVzb+p/UptknPgYtICvZRV3F2rEOv70b1+tcFExR7N9ijldVUK4UeDmgQ2R6EteQjcf6nGCeebDk4pPrJxb0okIqDtsj4IlgwY+bbSdzLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(356005)(26005)(16526019)(2616005)(1076003)(478600001)(336012)(426003)(81166007)(6666004)(40480700001)(2906002)(40460700003)(82740400003)(4744005)(47076005)(5660300002)(8676002)(8936002)(4326008)(36756003)(41300700001)(86362001)(70586007)(70206006)(316002)(36860700001)(6916009)(54906003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:51.9276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e48701a-edf4-4743-af9f-08dbb4c6904c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4894
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
 Muhammad Ahmed <ahmed.ahmed@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Duncan Ma <duncan.ma@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

Disable IPS by default till it is ready.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 9fc15a200133..47de1fadf364 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -749,6 +749,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_mem_low_power = true,
 	.ignore_pg = true,
 	.psp_disabled_wa = true,
+	.disable_ips = true,
 };
 
 static const struct dc_panel_config panel_config_defaults = {
-- 
2.40.1

