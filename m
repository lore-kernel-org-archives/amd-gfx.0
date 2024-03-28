Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653CDCD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A16710ED48;
	Thu, 28 Mar 2024 19:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5QvnQbgi";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89AA511232A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTVhV0KYGOO1xvWng+XX6ow+odjR/r7kddotdRsYtP8fLpw73Wr2cjWiujo5MP93LOEycZFrSHzif3NbRXFo514rWUa0WL4dacC62r1BOdjBvyUPMmLJuhs3xNBPN88hvE4JnJwMnVyN4nEzmJkCV4Pqx7pMH3DSZfnVQnAgNE7F50xehixeFwuC41EbstKPpGSec9iShfGtOhl/juk7D0KA70xliG860WvyYCIF7pts/dDyZ/jtN3l4IJl39FyE8Q1EhmrrFg0ba5RU9AsVvAydyhD1BuWcBzzA8uBgNHCxqLCDzAG7OBLS++sLYUQqnPb0ShHm7IxhY0upv+AyzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFPTaT7urAdEWgmO39gawWQhiObsyWJblIfUse+BHu0=;
 b=cRj8TR0QZB+UqI744RVDi33nrGGHikVq2pGWOhYREIV7Lh9GciljSm2LtNH33SyXHT6jxPnHl1YkVSvYu+JQpfXMe/3Ks85MFgX+y34x9boeac+eUEOWLm7J8UcX+PsBkjREAcRJZv83wtkLcllT9lwtB96s/NRTsI8ndjL35FkqePgpKdetnSiaG8y3xcVhIw9hGvEJsxGu+AWwIymlgu20Uu7G7mtrhG5LasI4a1VwKCe0NTnr/oj7wQOuDbeKlLgQF6YX+WyIRe2yL7L2AspF8zyFoQjF0rYqpq2RrZBJ1rhLkIOOJt6QbsrA6ksrFPiGnMhtq2HxopcjVjuqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFPTaT7urAdEWgmO39gawWQhiObsyWJblIfUse+BHu0=;
 b=5QvnQbgibZuspIl5FSA1YDMK7bZEw/OexwupUDEMOOduVcwvLINkH8nYsc1xnXGS6jVaPFzegKy1erPw8/x0SfnI38hy+XSNNhUBhk+LwsXDVt28nMaZQTN0ZC0ZIizBEGohVkhvDAqKILwBhAq1OAO86XCjmfFJqEu7zqU/WS8=
Received: from CH5PR02CA0002.namprd02.prod.outlook.com (2603:10b6:610:1ed::14)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:52:09 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::b) by CH5PR02CA0002.outlook.office365.com
 (2603:10b6:610:1ed::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:07 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:07 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 36/43] drm/amd/display: Add missing SFB and OPP_SF
Date: Thu, 28 Mar 2024 15:50:40 -0400
Message-ID: <20240328195047.2843715-37-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|CY8PR12MB7435:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa0665a-f240-49a6-130e-08dc4f608d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hQC7+VQzEJvktiAIMKKrXtwUv1lrL4gwS+1P2KU40w/5yxCeHKcJ+w7YVwat7UdFZcoH4W13dv2EQJfq7DMNAUG4sfgsQQVpymrAfJv43uLy5NNg7r2ijWo1t4G/kYWduGJf+0r1B/cLhlgAU0+Pw6E4Xertll6b5P4EWZL3x3rY6vweeltiowJZkpKeRCqPTXP0QLVUbPrbne5qxbUGOe5aN7P5BXqzEy085a1vyoZ5TYXBpWGn9kxKyq8Tfzxd38vX6IiqCfd4zhU2gLY5xzPiCkTPG+LBPHiN91UD1e1yawD4IJukRwws6qqkludL2Ra9JintMoK9rpNHr2xM9LlOuSzajsYXcvlmCVA1LBHZDlPmwzVEwVmaQl0KZx3QzevVrOmdYvPVo1xXIspJKXgztI0fDiyyOki0f8WcXIE8DxfKVfUrTdsVB6/tmaepykgckt7TiVvwr+g6Y03qeXkUMfez+SELc+cd8b4jXaL55r3De/zbbezm7Zcw+1NcBiFuYd7Q1BTyHY6+pku8uNgCaLP4vRQFsKvctbm2i5lI+It/9qFMmvHHT7VHVwwsMaKDikg2wQfBOgQVIUVFXVg7PmDAt6SCbWqos3iIeI7zfb8nMDy+KWX9G97UWx0IQizR/3FIYzPXp1zGWR+dFtpUi7uwFBVyNg/2EZck0weB9MJq+AioHsMfqmbbvGCUdVYF8LIucYFYbz50f5QhOxv6sgAInzARjDGAksQ+V7+Q0ABMIUdpEcA88M00oA4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:08.8492 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa0665a-f240-49a6-130e-08dc4f608d8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h | 1 +
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
index f98400efdd9b..e34e445a4013 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
@@ -181,6 +181,7 @@ struct dce_mem_input_registers {
 	SFB(blk, GRPH_ENABLE, GRPH_ENABLE, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_DEPTH, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_FORMAT, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
 	SFB(blk, GRPH_X_START, GRPH_X_START, mask_sh),\
 	SFB(blk, GRPH_Y_START, GRPH_Y_START, mask_sh),\
 	SFB(blk, GRPH_X_END, GRPH_X_END, mask_sh),\
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
index bf1ffc3629c7..3d9be87aae45 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
@@ -111,6 +111,7 @@ enum dce110_opp_reg_type {
 	OPP_SF(FMT_DITHER_RAND_R_SEED, FMT_RAND_R_SEED, mask_sh),\
 	OPP_SF(FMT_DITHER_RAND_G_SEED, FMT_RAND_G_SEED, mask_sh),\
 	OPP_SF(FMT_DITHER_RAND_B_SEED, FMT_RAND_B_SEED, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_EN, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_RESET, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_OFFSET, mask_sh),\
 	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_DEPTH, mask_sh),\
-- 
2.34.1

