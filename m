Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B284C25B08
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 18:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 571A9B92F4;
	Fri,  5 Aug 2022 18:00:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41B1B9363
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 18:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eohdI/251UwJKXWHspXA4Ew/cPJ+Co6dtHB7+UBrmYJ6AXl8rfNzZE+UrjWGj6OiUacJPiQXzkvTnAJgbr9Qs3a1nj9Pd+NA4RifgmJUvFEc7/uSIqB2ItkASF7kIzpWEl5Jw2LRzdKVpQ2WXBP1jHkBj95T8V/t8uAVem8GHk6hiCDwB3oDzn98apTUKvjO0jscrlNtjX1EqGK4mo/fDOwcLU3P9bMssphW9oPHi8zsOvBr2E6MExMappjhkxb1V00NPESuPK4ilRyW0Fzqx1FQTOEQedM0xaI3yiJcLKTL2oLzkpHtKXG7Nq5/pilr5FOCAvVFQaR5THvlhZyksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CipF82wFjXJ7EEdy5VqnnHhij4tp/bL8BZ/5qgWuviY=;
 b=WqStVB8nk+0pA3Pmbe28o4Os5yUuJkYngNBtJ4dUHxgKdn1OtpCizQHkJnOmTmYBJkXEKOcHeU2t+geUUarLEpl/cIb4TAp0A3x+MJB+xAXwAMGDx22/bhHCxK46ZUyUtLJAatK7sC3EOAiBzLH7BJISIC2xcQDssQynu6aEtFzmaXTX1SLGe/kdT/edFnO0NWDq31M04YWJMaPoXiErzaeZL6ZXzviYS6eId5cXhoWcD1/HBUURDuwmkJd7nIDX8wWQ6XrTT50rj6vuTe5WQbqK76HvZN+7EcEanP843ucZ7XEXn+oQ3+h2Qziq2sTdC+V65rRqz9os5JmjaOqxBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CipF82wFjXJ7EEdy5VqnnHhij4tp/bL8BZ/5qgWuviY=;
 b=NGKqF1nxgr/JhW2xQx1yB1Kjk7aNxN0rWGstzkB9m3oMzG3wvIreu7wbbgk+5vgnnjW0l7cu003WxpCXs030MDPVgE7w0HBt/z1ku4B+p288OdS6xLVq7xBAAGeex8TSJHXvgDOs/jo/zN3V3qqaBs/lIDtK5/fUxk2tt4X+afU=
Received: from BN6PR17CA0031.namprd17.prod.outlook.com (2603:10b6:405:75::20)
 by MWHPR1201MB0270.namprd12.prod.outlook.com (2603:10b6:301:4f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 18:00:07 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::62) by BN6PR17CA0031.outlook.office365.com
 (2603:10b6:405:75::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 18:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 18:00:06 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 13:00:05 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:00:05 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 13:00:00 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/32] drm/amd/display: Fix HDMI VSIF V3 incorrect issue
Date: Sat, 6 Aug 2022 01:58:08 +0800
Message-ID: <20220805175826.2992171-15-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 455f629c-4e56-4460-8b64-08da770c5469
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0270:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yUY0keOBR7/xW4mSg0i3qVNXhkdKOZXw7g2TBRIu208z10HG++pcY1yKkTZyHOqZXBvg7reXtKnQEJ7F+Uqs3KY5QM6TE2jOdlDKGuCxShjWoJAyVOzc25lBNm7vAj30t31hbPhlXBkMRjE+GiIvIv808n1WRKlcfXtrXhoVX9jgzD3BSER9MwvJPwUbnlBxOMD/717j7U100KGN0ELX2UFOqSlkXnLY9+GajNcoQxh6c+V7U/L/f+Ft1G5vQP5tNUtLfSN5DesX+/AqfA/o9Nw1dC1zzvQz2R05qgPcK+/H8fcepreOVlYKW5bzzw9OawCcZRED1GrMU456KozP/t7viWFVcxj9X0njpH+xqnXho5nfqTvirbgyJQA+530YIafNgMzfSY475qg1IA9F86KjpePPHcHPEOdWL8KWhix0LDSs9D70dcvEOLMWPixze5fCBKa7b0yaJMxDcZ+s1YqJCbWl7vebVeZ0halPOQ+IgEcBN/wCqrHG/c/nUQzQH1k0FfgaBC9thCunIdctHXmKEVLqm2O0paIh9X5XVq1ML25PNFGeuUEiiFwZIoRtcJmibmFaDzBoDEyJGZbr9iKl1lT8XeDTnZwxf1xTRoRHevcVfZSGLnkMmK0jEa2/YH+voZ3lj8QDDzdv6JduZl6Cd72HtklT7VO1PDtnB0G/2NQE6pJ4mWgoiieWjHDp8c/ez+d4cEHGY/10y0VUcJIgCFB4NLXNCKetOrC622oxCrGtebqyVIDAqOiJCuc74bnPSRolYziTkGmLQOznKqDk7UFEliIXXu5K38+vhsdrFjC3efayslyJ+u4APrhrDZP5XnpqNNy0J2GmLYDOjg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(36840700001)(40470700004)(46966006)(186003)(47076005)(5660300002)(8936002)(70206006)(8676002)(40480700001)(40460700003)(4326008)(70586007)(86362001)(2906002)(36860700001)(82310400005)(82740400003)(81166007)(356005)(478600001)(36756003)(6916009)(316002)(54906003)(2616005)(83380400001)(336012)(426003)(7696005)(26005)(1076003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 18:00:06.5237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 455f629c-4e56-4460-8b64-08da770c5469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0270
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Leo Ma <hanghong.ma@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Ma <hanghong.ma@amd.com>

[Why]
Reported from customer the checksum in AMD VSIF V3 is incorrect and
causing blank screen issue.

[How]
Fix the packet length issue on AMD HDMI VSIF V3.

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Leo Ma <hanghong.ma@amd.com>
---
 .../drm/amd/display/modules/freesync/freesync.c   | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index da09ba7589f7..0f39ab9dc5b4 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -613,10 +613,6 @@ static void build_vrr_infopacket_data_v1(const struct mod_vrr_params *vrr,
 	 * Note: We should never go above the field rate of the mode timing set.
 	 */
 	infopacket->sb[8] = (unsigned char)((vrr->max_refresh_in_uhz + 500000) / 1000000);
-
-	/* FreeSync HDR */
-	infopacket->sb[9] = 0;
-	infopacket->sb[10] = 0;
 }
 
 static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
@@ -684,10 +680,6 @@ static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
 
 	/* PB16 : Reserved bits 7:1, FixedRate bit 0 */
 	infopacket->sb[16] = (vrr->state == VRR_STATE_ACTIVE_FIXED) ? 1 : 0;
-
-	//FreeSync HDR
-	infopacket->sb[9] = 0;
-	infopacket->sb[10] = 0;
 }
 
 static void build_vrr_infopacket_fs2_data(enum color_transfer_func app_tf,
@@ -772,8 +764,7 @@ static void build_vrr_infopacket_header_v2(enum signal_type signal,
 		/* HB2  = [Bits 7:5 = 0] [Bits 4:0 = Length = 0x09] */
 		infopacket->hb2 = 0x09;
 
-		*payload_size = 0x0A;
-
+		*payload_size = 0x09;
 	} else if (dc_is_dp_signal(signal)) {
 
 		/* HEADER */
@@ -822,9 +813,9 @@ static void build_vrr_infopacket_header_v3(enum signal_type signal,
 		infopacket->hb1 = version;
 
 		/* HB2  = [Bits 7:5 = 0] [Bits 4:0 = Length] */
-		*payload_size = 0x10;
-		infopacket->hb2 = *payload_size - 1; //-1 for checksum
+		infopacket->hb2 = 0x10;
 
+		*payload_size = 0x10;
 	} else if (dc_is_dp_signal(signal)) {
 
 		/* HEADER */
-- 
2.25.1

