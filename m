Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB0CC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 15:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F7C110E38E;
	Fri, 11 Mar 2022 15:33:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8683710E38E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 15:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzAIZkww2lCosRgbkUBEDfnoITiawQq2ya6auFTWpNyy4LUUhlMKl/8SamrD4JhLuYJu3F1kb+ce2AiC0iOyY3pAxWmiSUD3WT3WyUS17rvKK/cr8u2ogxe5ECdzzi5OYm40bGMJGtadXEUBpDNtcycnJKEXq3AEZofRTWnJP/tvU66sw1meTOveYBhjCyBnFg2Kedsq/o+G8R7LfpBL2st4Qxe2pChwIH+XOd4Up2cp7PFvyAiBW3aSBdIPYsiNPo3nwcaLs+UeD+vApWCS9ojgGeIo0NKNTLlejlzEtcO/SioAxUWzMzZaxgdq7S8ds5lM+hcVmJcRfq12BeG0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFt78g3siaPQJkd3cRUxujFTfJEHrK8R6cXO8Olu50c=;
 b=UKE8ntI68NdcTNqT05LWIdQroG/hNlMXuZhHPpnPp5yGXEuHJxlGYl2F2o0rGqyNdql0h5yydau1DDg2gqPOG7MOW7NTjJcZmpQV5Ockg77VIyjSn5tL8e8DU2A3nq2KL9hd7pKDQpSRNVnNJRFBFKUk4ueERbE5u+tvQcOEDP6H+ovMDGegFT9/yfwZRNVAiTtiPpXGtMDOaZV2p2g8MD/Vz2rJD8lcjlgwpVsQZb//UUdrilWEZ9HCMAnU2RcmYppINitbowbkzcmqbKOlDKSETtTaUnzbzTEwIBD7YjRKtE8wvlUsmSKOZ2w0RJNnLGgDAZcn15ebKtriO1Oa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFt78g3siaPQJkd3cRUxujFTfJEHrK8R6cXO8Olu50c=;
 b=hf8DPFrspDhhRooI9P7iCbWTRLss0pHyq1HycTZmpqM1cOmRGJsbwodyzw8nLHLxNEuwtNzy7QvmKxZfzbHwIoOLSr0UrgyXBKarnsS5S090qDQlyfGQp4p3DQBM2K3JS+uoPRWGoCntKTD4ZMmrI1/fbVvkfLR42Y6o6l51mGM=
Received: from BN0PR04CA0077.namprd04.prod.outlook.com (2603:10b6:408:ea::22)
 by BYAPR12MB3205.namprd12.prod.outlook.com (2603:10b6:a03:134::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 15:33:38 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::43) by BN0PR04CA0077.outlook.office365.com
 (2603:10b6:408:ea::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.23 via Frontend
 Transport; Fri, 11 Mar 2022 15:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.24 via Frontend Transport; Fri, 11 Mar 2022 15:33:37 +0000
Received: from amd-WhiteHaven.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 11 Mar
 2022 09:33:35 -0600
From: Shirish S <shirish.s@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] amd/display: set backlight only if required
Date: Fri, 11 Mar 2022 21:03:20 +0530
Message-ID: <20220311153320.101332-1-shirish.s@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 561520ce-8557-4bb8-693b-08da037482f2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3205:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3205EE31748ED8E4EB98EE49F20C9@BYAPR12MB3205.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ufeY+vsTD0RsFAbVAGoXkeYyrma9nWMfvUkRc7rnvrwtZmueNemIrii0BiGIUXvsHbcg6oN9xhEfCm1++dKFZg0tu5h3pZ0UUNAT7tHwLZQyw0iTnvo0L6VXY8smusz7CB/wT+v/SGF1m0a0UXG6eVx7VgRGj8etCktnVziQs/TrgOL2TzYd6vR+FOid2eR/ySNt+cvh9zA33RmGvO/k46OWk/jvV1zL/9yCGWdXbV2ratMmIetydV9WcaB3WWUVMsubtv5ONvXV+KLn9xc4HxrkPbfU4p8xT5v4ON4j3TJbA2QbDVSJeePppoGpIRuL+Bwj3BnjWXn+gh/p/ZpReScofuLfwChp4ZZ19el6+06mCrPa7AIozUEBhtyub0sO0olG+y9oJ2X9FVHQ+fD5QRMrcqu1Lt/Px3fG9h290jX//Y4Z6RBPUhor4sU7FNtT1AnIWx1udCFsBd8iKyjylDZgz6dzeGYVsLWfG+5o9uAtsVE8dQNZVrwjte0re8HAZ6i7Qy3EvXGx0/gg7NAESRQS71UwZmlSbWRESUr4ryIJxNX7jTPxG/7jdRSxVLFFe8vJ9/UNIhZnlI/HBPxjc3V26CG/M4L+yQJ9ns6ZRk+rtHUIJWTWjNS0E6c68HsPf1fG8soR8RgaiUJ4+vFiGRL8E91QQIlong3D+jNWFt+Mt9opWAB/hLR0C+lWvZ/FdTw8yxONvyBX0cZ7fAjyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(426003)(1076003)(2616005)(8936002)(336012)(26005)(186003)(47076005)(82310400004)(2906002)(7696005)(16526019)(508600001)(36756003)(6636002)(54906003)(6666004)(70586007)(81166007)(70206006)(316002)(36860700001)(83380400001)(8676002)(356005)(4326008)(110136005)(40460700003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 15:33:37.3735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 561520ce-8557-4bb8-693b-08da037482f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3205
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
Cc: amd-gfx@lists.freedesktop.org, Shirish S <shirish.s@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
comparing pwm bl values (coverted) with user brightness(converted)
levels in commit_tail leads to continuous setting of backlight via dmub
as they don't to match.
This leads overdrive in queuing of commands to DMCU that sometimes lead
to depending on load on DMCU fw:

"[drm:dc_dmub_srv_wait_idle] *ERROR* Error waiting for DMUB idle: status=3"

[How]
Store last successfully set backlight value and compare with it instead
of pwm reads which is not what we should compare with.

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 6 ++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index df0980ff9a63..2b8337e47861 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3972,7 +3972,7 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
 				 max - min);
 }
 
-static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 					 int bl_idx,
 					 u32 user_brightness)
 {
@@ -4003,7 +4003,8 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
 	}
 
-	return rc ? 0 : 1;
+	if (rc)
+		dm->actual_brightness[bl_idx] = user_brightness;
 }
 
 static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
@@ -9944,7 +9945,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	/* restore the backlight level */
 	for (i = 0; i < dm->num_of_edps; i++) {
 		if (dm->backlight_dev[i] &&
-		    (amdgpu_dm_backlight_get_level(dm, i) != dm->brightness[i]))
+		    (dm->actual_brightness[i] != dm->brightness[i]))
 			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
 	}
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 372f9adf091a..321279bc877b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -540,6 +540,12 @@ struct amdgpu_display_manager {
 	 * cached backlight values.
 	 */
 	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
+	/**
+	 * @actual_brightness:
+	 *
+	 * last successfully applied backlight values.
+	 */
+	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
 };
 
 enum dsc_clock_force_state {
-- 
2.17.1

