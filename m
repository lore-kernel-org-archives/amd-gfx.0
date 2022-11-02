Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA90EC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 16:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DCAB10E4DE;
	Wed,  2 Nov 2022 16:03:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA5910E4DE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 16:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg5NuJUDgEzJ0+eRvaNcUo5UUevO2fi16fV494lJDqFOsfLjW5DG2ceisE2H4QF6cJFuP2zh/yYESI9NvROB4i5C/dn7K2MYdBPZL4KVrl3Z1heCaTIKEu30aj/GFDDR9IlZdVYFNWM6UWN19urNIBdHMkFkMT4JMvrxXKxDDajvPCyzNEmir0a+ygS3Y2DlWg1J8J1hcCwBrK7622i/x3CsVpke2d+XT/IFNaMNNk1mVxQ3v2tLmQ467fKPOaReET+PZh0iQnt3lURVH/G0u1X53H39T8Et0En5nAbGNEfSBkbE4wMWt2+4D5MVY+TlKWiHytzmuAYp9jUYh6cQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6F1+1HUwtyQVEgA+ql8zNr2gJ7MbbOwvu/LwE9zTDQ=;
 b=lNe1w31LgZV7T+lMtJo9oIZkVaRTV/qoAC6JNXVEl3077Ddrd7P4v9Yr2tqgoXuz/gCkzJDjdrR9u+fTC15LVBiICJ05YPf1iIayEH00GI1/HZuvGP0Mu8TqODksIaFPoPqyMBqt8BD/ZBrXbrGn+DNPAJoPtcPLIgC7/yhy5jntfWyu7rkIj4mQfBST6KUUkW09Erc0dbIxIiMPot786OK5n9s7Ti+/SjD7uElP1HYrrDvieJAS37yv7/0vDUuNQC+OOu8mhz8rhCKm9wjsMJqA9jwz5gev8y4WB+sZcKT9HDT235GIIcsNtI8nZDloO8y7bNbYUzYUaWMwqeA43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6F1+1HUwtyQVEgA+ql8zNr2gJ7MbbOwvu/LwE9zTDQ=;
 b=cRuC1N42nJWr019a6VN3EghV8+EdSTu3BDFP4vaehgG3rQ/6Hk2Qfn4lA0IICQlkmdz4VOLea1ObFlbWoG6IRG36AclZYJb+zHu00Ry8oijxrMImDhmEzgG/EpGrT4tvzEaH0w7Zlwp1RVph6IBbWvfHXB7sdWEvMSB1bIdPslY=
Received: from DS7PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:3b8::7) by
 DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.18; Wed, 2 Nov 2022 16:03:18 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::2) by DS7PR03CA0002.outlook.office365.com
 (2603:10b6:5:3b8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22 via Frontend
 Transport; Wed, 2 Nov 2022 16:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 16:03:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 11:03:16 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 2 Nov 2022 11:03:12 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/22] drm/amd/display: Waiting for 1 frame to fix the flash
 issue on PSR1
Date: Thu, 3 Nov 2022 00:01:01 +0800
Message-ID: <20221102160117.506511-7-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221102160117.506511-1-HaoPing.Liu@amd.com>
References: <20221102160117.506511-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: be2304d1-227e-4ff2-b277-08dabcebc147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcitWHrfVXWbfimX8eXhfgqxNUjGv44Zk6WzH2CalRUvapuzkEDG9XTr3/Nq49lYMD77Ubsn6B9fQrbdwf8fi8P7f+TXMhZ1krHjApahlOE8UMJZwPBdCBiHuaBjRWSkbixuH96lLweObNDxeNVRLLXV/JLoFKgDCQiWGPkuFbPifB4KBuVLMhOvNRoU7yFqyoZpNMklr2LUEzpvI/o+ypL3AHdG/k0iNm8Q46VC8m+MD8WfjN1XkyJZMYX5FRoXsLu5X5pD7GQz5O5lFYwzuKS8/YL68fiwKjA8+95xMlDJ21HdMQ6f1QqYYpPUHLrgbenUUF5Ie56XdvH5y//JuLqK10Mx4RCt3vKCvra4j2ErM/YdBBsu3r9yBAJbak5n/E/zxLKys386fp0R0YHq5uZg1MZ8SrnQUUjiDUvOBKgfKOdI/beDqbEid8hwf4MbSWHdxpHM9onaJz3ILbQ9Z7dlgOxp57b2G20m47mJNJjQFx63GsUXd14K4jdb/IrSqWpoAmS7uzUCgIWbzHj7ekyuxHtyU+1AL1KfSjt1GcCO1VJr7YCZcvl0JRcK575tuiT5RkMNySaVFMdI/KY69qqdQwS0qdJXNG1pAOhNMhyd0jso59+ciCdsm0phHRwfak+pL+CER8U2TPk9v/v4jtZFTdimQwgEgVcQjeKc6nXQRzVQvH0xvWIsIx/adzz/jbHTe2MY7+5JCqo3Bc9VZiM/7TgoecPQYcGsL5Th4GXbgUgmfoFvUBITb3SgoWtOs26uoaUS4glTsi7SpVUk2UR8o68Mig6n3TplVmNcgimJVBG9wAvwOvyMbz2h7jVO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(356005)(26005)(36860700001)(336012)(2906002)(41300700001)(47076005)(83380400001)(81166007)(186003)(1076003)(7696005)(426003)(8936002)(2616005)(82740400003)(5660300002)(36756003)(40480700001)(478600001)(86362001)(6666004)(70206006)(8676002)(40460700003)(70586007)(4326008)(316002)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:03:17.1603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be2304d1-227e-4ff2-b277-08dabcebc147
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Robin Chen <robin.chen@amd.com>, Bhawanpreet.Lakha@amd.com,
 Ryan Lin <tsung-hua.lin@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ryan Lin <tsung-hua.lin@amd.com>

[Why]
Needs more frames waiting before the PSR_Exit sending for the specific
TCON.

[How]
Add relock_delay_frame_cnt to control how many frames waiting are needed
before the PSR_Exit sending. The default value is 0. The Driver side can
set this variable for specific TCONs.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Ryan Lin <tsung-hua.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c   | 5 +++++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index cda1592c3a5b..2d3201b77d6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -413,6 +413,11 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	else
 		copy_settings_data->debug.bitfields.force_wakeup_by_tps3 = 0;
 
+	//WA for PSR1 on specific TCON, require frame delay for frame re-lock
+	copy_settings_data->relock_delay_frame_cnt = 0;
+	if (link->dpcd_caps.sink_dev_id == DP_BRANCH_DEVICE_ID_001CF8)
+		copy_settings_data->relock_delay_frame_cnt = 2;
+
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 9df330c86a55..34b03bc7f838 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1876,10 +1876,14 @@ struct dmub_cmd_psr_copy_settings_data {
 	 * Use FSM state for PSR power up/down
 	 */
 	uint8_t use_phy_fsm;
+	/**
+	 * frame delay for frame re-lock
+	 */
+	uint8_t relock_delay_frame_cnt;
 	/**
 	 * Explicit padding to 2 byte boundary.
 	 */
-	uint8_t pad3[2];
+	uint8_t pad3;
 };
 
 /**
-- 
2.25.1

