Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB3AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 22:58:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3720B73CDA;
	Fri,  3 Dec 2021 22:58:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1B273CDA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 22:58:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE2CsBlQePFmle7rY3l/JaVLBGBdinPaP8pA/zcTSYJnfYzsgDJUNegO4KhiMWwla1s9gQ1bBj+NR+cmnbcj28hdGzdrT5kmk1C9andNflKwbnBSmfayTH/1Adm+LTZS1WzyVgKuD0rShAbCFlirN+OhNE4JREQVrfusd1QG0dfK1UnPznFxU6fC6i+Jb8xDJyhJCP6/jZr9bYT9QqOPxr4Jux0lPqbR2Fohryy8NW+He5TpK3Det09ml3Y8dsZskNqMMVDZiEbhYccfy7y5CL8qFUXRCzQ27xESlCOV7Y8xVAwLEbs3XldCnwBS2NVpTSw2ibQW01v9A11pFn8ZUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOK04I1GKET3b2G2ep7XykQ/XhRqdm7j/pT1cNd4v8o=;
 b=oOJM0IhMgw8qmbPnMZfIq7NUeNHnc9Eym2q/DaszxMXbyI4QRoqlyW6T+K2L40AkG5ghELrG230SMwwVLDCPhQ4yvvjmsub5PFRu3RiZ3yRQdYj/feIaG9ArUSCyxSu70JmHBr1yCNOCaUUL0l5Je8ccYz3VxVoEjTs7IjKe+kgeK+Gx5bToSgcytEzP/fVm/13VdlpbdKHpQoM/qi8ig15Wfxf8wt/ikHg/hJsrGIId6ZuFIQLPRIkckBIdBgixA55xJjcnej5znufGaPTWILtpT7VB1bGLfV1e0GM2bwMStohpFp4gsASzsTbZ2s6fJzmMwOI3O1vsLBrf1o6HrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOK04I1GKET3b2G2ep7XykQ/XhRqdm7j/pT1cNd4v8o=;
 b=I10kCEnhMmMhO3j4lfNbdiJvS7OoUXFHji0lV+EMT5MJQyGBc45vIuT/iV1USIjrtbz7hORdOrJPtnv/wO2v+Gk2zqQ2fVx9KKSZKgfNWQa0bEhqtxFYyf4kebGEfzU80DevGImJJvGPAMAW+WHX7jUkfrwNvt+QRE+qzRU68S4=
Received: from BN0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:408:e6::16)
 by DM5PR12MB1721.namprd12.prod.outlook.com (2603:10b6:3:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 22:58:36 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::c3) by BN0PR03CA0011.outlook.office365.com
 (2603:10b6:408:e6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Fri, 3 Dec 2021 22:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 22:58:36 +0000
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 3 Dec
 2021 16:58:34 -0600
From: Pavle Kotarac <Pavle.Kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/15] drm/amd/display: Apply LTTPR workarounds to
 non-transparent mode
Date: Fri, 3 Dec 2021 14:57:48 -0800
Message-ID: <20211203225802.651367-2-Pavle.Kotarac@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
References: <20211203225802.651367-1-Pavle.Kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba5e7b26-55d8-4fe0-6846-08d9b6b07069
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1721DCD063141FC959CBC42CFC6A9@DM5PR12MB1721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dn/Qu8uHr3p/JBHVN2Ma6GZ2rpE4y3y5czFXTVmOUIRJ+XqbOKMOj9nb9ABylGtZFPaS905sDkr95cnobBSTigOP3SllcidBRDpVJE8XidXk6NWZvK3SDmKR5GIU0PFMj3TJJ+bVTlSF/irC/PljSnyHztoYEPFIi6pRrMt/UAtjjaVJPllIW5lVmtv1g5I8A/yoqG9Q799qz4PjP+IhGQXny8zW4JJmeUc5W3w3ilSN7uU5oRi8hcdAb0D2OtiW9iQPJYA+Sl+yWwbdGPHWCQ46+P7Gndc01MGRZqVJrh2L8awLA49Ba43e+eTaydwGcRd7b3W33Mw7F8PUjI7MHG/tyn+uZvwza0E5LhXOwRxd0bNt3IEZfGaNMqpXlLciIt59Kf3zq/7SLIDNOxjIip+Z+3hvGjlVqy2j1xYuOiSSkEovsZvN+gKOPrX/KXawy+LqTGn+LgYKilwGYLPBvR6kndrZ/xPMyvvCtfKcJNW+/COTlOmPu63dixgyV/ydhRcPc/EJhO1IwIJSNdNrJ1AlmO3vFuqDXfiYvReLfpYi0Sc3A4og69ZxT97yhiPGsRGa6cQ5bz3SKshHVC/C5U3YZ2nXlkMJLR2I2tORH5nb+SNDJbaxg8AbqfZnrKfhJ9+Ab+NNRCw5CqEkfTCpPQ87ocz/5UUpFjli28jopNWnUQuDur95t2HpoRaAwCt4/PwXnC3RLzyN6TfgP2TnY0ZFGwFicUlXE4UBK851Ymeeqsef8+w0NuIVd3qiDeD9OHLA59pSb2Zb6g6u5lOCSkeZ3vtxTU7eE4xLk3hLjZw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(16526019)(1076003)(2906002)(70586007)(508600001)(26005)(7696005)(36860700001)(8936002)(6916009)(54906003)(4326008)(2616005)(36756003)(6666004)(47076005)(356005)(82310400004)(70206006)(86362001)(5660300002)(8676002)(81166007)(40460700001)(186003)(83380400001)(336012)(316002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 22:58:36.2497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5e7b26-55d8-4fe0-6846-08d9b6b07069
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 George Shen <George.Shen@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <George.Shen@amd.com>

[Why]
Some of the vendor-specific workarounds added for transparent mode
also need to be applied to non-transparent mode in order to succeed
link training consistently.

[How]
Remove transparent mode check for the required workarounds.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: George Shen <George.Shen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 66dacde7a7cc..e952cdbc675e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -620,10 +620,12 @@ enum dc_status dpcd_set_link_settings(
 #endif
 		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
 					(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-					link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+					link->lttpr_mode == LTTPR_MODE_TRANSPARENT)
 			vendor_specific_lttpr_wa_one_start(link);
+
+		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
+					(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN))
 			vendor_specific_lttpr_wa_one_two(link, rate);
-		}
 
 		status = core_link_write_dpcd(link, DP_LINK_BW_SET, &rate, 1);
 	}
@@ -1494,8 +1496,7 @@ static enum link_training_result perform_clock_recovery_sequence(
 			wait_time_microsec = TRAINING_AUX_RD_INTERVAL;
 
 		if (link->dc->debug.apply_vendor_specific_lttpr_wa &&
-				(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN) &&
-				link->lttpr_mode == LTTPR_MODE_TRANSPARENT) {
+				(link->chip_caps & EXT_DISPLAY_PATH_CAPS__DP_FIXED_VS_EN)) {
 			wait_time_microsec = 16000;
 		}
 
-- 
2.32.0

