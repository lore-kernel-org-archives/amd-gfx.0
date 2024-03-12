Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078CBC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:24:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7749F112D44;
	Tue, 12 Mar 2024 09:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SGwlt7r6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D71D112D42
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpAYUszICkhumnlsfcQAASzs6I3r28eVdiGYrFD4NisI91N3PeNJ7W8UPxvRMv7oUnEi+ALk15UvDGmo169lpRyOizNtqtafpXZRO9zktZYKbAbTng4qmCBpa1PzppUZOVkHvMda8IfKNOcDHyz2NT2fAZYCCo8xnpMfmXxbEnNBLrofDCFIVEEYn4G+FXN7A3I6TE46GOKhSHceAcsbrWxxsGQl+ujkN92d9jyFUcQZWaw17MP6181ltKgFje/80c1+7xZ0LFUtZBgr9t3TJE2yCXENWINf1ekHYfKp8polM0ssOxGxnyu9rE39hPnpsC3AqACXFDxKoIAdU9JsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wyu6W2rOoImCbsH6/vyfa/89nbn9frZdRDVyOOEnbc=;
 b=fXe6kHniAIjjYG9+UubGfw1hMLRgdhu4Aj7kEAR+cAnpP3OaOgG9tQJsSxmXWoccKQLVe1ruxZrJaKHHhjiGIe2gzbo2/MsBc7lPLf20KZ/6CnnJD6HK4jD8Gbc0o+5SWYPFbgWDzDVRjg574KL74yc7WWu7NGTePKJGkwn2kHypqUiPSs09x6kAM8qscQPjpD6SWVWeNrElrnguFTpElRQ1dokwMyyZRYqVPnC48ulyBKhFQlpwzBVmMFPRZtaRLOesPZsLHSgz8nYuDablQD7IXg+AJpp9aJrNCTou0DQGn5o0QjsQWlk4AEQabiZiKTFkW2bwFeYLNK64SCP4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wyu6W2rOoImCbsH6/vyfa/89nbn9frZdRDVyOOEnbc=;
 b=SGwlt7r6Zn/xQY6/h8F5RlHcl3mQHzrptFZlnVhmBZDiggeb3Ok4Hsw2H8rigfbTNU2xGw/BIx+Ca5AN7aeVCHK/iLwCty9zw7INgPeecJ2AEMt8DiDjyoYSjQsMzVtCqqR0B7VrJDUy/QlW5xCK2SmKWh0Blt9Pf0GUbewwN7I=
Received: from CH0PR03CA0043.namprd03.prod.outlook.com (2603:10b6:610:b3::18)
 by PH8PR12MB7445.namprd12.prod.outlook.com (2603:10b6:510:217::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:24:40 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::5c) by CH0PR03CA0043.outlook.office365.com
 (2603:10b6:610:b3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.43 via Frontend
 Transport; Tue, 12 Mar 2024 09:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:24:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:39 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:24:38 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:24:34 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Duncan Ma <duncan.ma@amd.com>
Subject: [PATCH 36/43] drm/amd/display: Add optional optimization for IPS
 handshake
Date: Tue, 12 Mar 2024 17:20:29 +0800
Message-ID: <20240312092036.3283319-37-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|PH8PR12MB7445:EE_
X-MS-Office365-Filtering-Correlation-Id: 2750005c-c7d3-42d1-08c3-08dc42763e27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fObwgEUISmJnNfBKyTqVQvnZ6FG5Z9+Vt2kZZJjQA/O5PG1iDIQc4aCXUrgx0scpVqNlgg3fSRq5YdDstrinC6RjYkCCMvl/0WMAOtEs9tFOkidM4//3NrtxF3hCTheLpSsup62e5rSShxqHYvbT54V14Tkivc2cOfsqhdY1z0rVbSWyfXJyGif66TbWKTPqnJDmTWifZuqiQs1Fz9noW+F7GbIwJfSkLwTNU+bdRA9aCgvFrgJncWVja8SrLoM1Ueu+2bsPREYxjiVHk9Ymo3yI6kIcEZuFew66244gDAqXogtApY/IE97T1ixXedIceuQ9o2U/vugyLPJLwncIJuziI1D7l6ADzhUg+OkjMMEDbuCAHMvK77ACsrUnKmPgsKZV1f6ZuhgciVlCGTMuNp+uah7mTktgXxET5AR4si5Ugv+ktBueMvx9sD9B1j9eR5yVlUmL9s0mXGmaILz5meNTThQSsoHzjAc488YE8jQs/tsaNPAIJ18PUp48yUKY9WIjFTOrBHEmUCljoSP3JB7KMyHCr7Vd8+VSf7c8aEdU03UK/y1S4Ama5xT8H3kM7OMLEagNIUwkdt3VucJk3S4p6krxO1yao824y15Hp06SqwXY6GRwBGBIyLMO4jDZ7uu0w7Rhb4ZcMlirmfXY7Vlk5H1+6o1OKjad6rWQKAZLxSrIqyLOKg73aSzR64EHYSUCOP2btDeEGmRaVIsd0xpXUHVOEevpPO8LosCCaR2rTQQ2F9IO3d8mGWH9a4n2
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:24:39.5306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2750005c-c7d3-42d1-08c3-08dc42763e27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7445
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
It's possible to skip parts of the eval and exit sequencing if we know
whether DCN is in IPS2 already or if it's committed to going to idle
and not in IPS2.

[How]
Skip IPS2 entry/exit if DMCUB is idle but the IPS2 commit is not set.

Skip the eval delay if DMCUB is already in IPS2 since we know we need
to exit.

These are turned off by default.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h             | 1 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c    | 7 +++++--
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7b22c2efed77..d280f55ebe50 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -988,6 +988,7 @@ struct dc_debug_options {
 	bool psp_disabled_wa;
 	unsigned int ips2_eval_delay_us;
 	unsigned int ips2_entry_delay_us;
+	bool optimize_ips_handshake;
 	bool disable_dmub_reallow_idle;
 	bool disable_timeout;
 	bool disable_extblankadj;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4878e9e50440..12c142cae78b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1318,13 +1318,16 @@ static void dc_dmub_srv_exit_low_power_state(const struct dc *dc)
 		 */
 		dc_dmub_srv->needs_idle_wake = false;
 
-		if (prev_driver_signals.bits.allow_ips2) {
+		if (prev_driver_signals.bits.allow_ips2 &&
+		    (!dc->debug.optimize_ips_handshake ||
+		     ips_fw->signals.bits.ips2_commit || !ips_fw->signals.bits.in_idle)) {
 			DC_LOG_IPS(
 				"wait IPS2 eval (ips1_commit=%d ips2_commit=%d)",
 				ips_fw->signals.bits.ips1_commit,
 				ips_fw->signals.bits.ips2_commit);
 
-			udelay(dc->debug.ips2_eval_delay_us);
+			if (!dc->debug.optimize_ips_handshake || !ips_fw->signals.bits.ips2_commit)
+				udelay(dc->debug.ips2_eval_delay_us);
 
 			if (ips_fw->signals.bits.ips2_commit) {
 				DC_LOG_IPS(
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7b807aea8aa7..818e5d87f0da 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -700,7 +700,8 @@ union dmub_shared_state_ips_fw_signals {
 	struct {
 		uint32_t ips1_commit : 1;  /**< 1 if in IPS1 */
 		uint32_t ips2_commit : 1; /**< 1 if in IPS2 */
-		uint32_t reserved_bits : 30; /**< Reversed */
+		uint32_t in_idle : 1; /**< 1 if DMCUB is in idle */
+		uint32_t reserved_bits : 29; /**< Reversed */
 	} bits;
 	uint32_t all;
 };
-- 
2.37.3

