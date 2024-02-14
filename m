Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D28C48BEB
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Feb 2024 18:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC6410E3A0;
	Wed, 14 Feb 2024 18:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3NaSNoPU";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC73510E34E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Feb 2024 18:40:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNjUGfZNqHv4TUINZRpSIo9iJAWI3UteqjZXOLQKUFg6A41oLw8d+0vlkile6SrHlXMc5iUj2yBIO68dNUBTt9C2Vx9et6tIv66s2gYesrlAC2nA4ZwqwxljlzR8TJjSAhGITokecdwt2mRjVoHmCA0ILATp1IFnSJB0R0YZcoDk2sq7bT5+hRIZMgsAMBkX2bkCf8nufSe0WUnKrqE7R2gp2aQ4Yegq2t0wqErYJE9+pQn59iBY0FwVi0WPmx/ztVL5k/acQpg5oY0OpL7B/Zi/ED8X+3qgq4tW/CLRXXXF/+0P74tzjKgpVWYuP9UvRwkiD9UWm6Nb2NAbb3lWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGIJleYRanr8d6XRRPKZLzyGcwIZVGd0OaCgdNzGbmA=;
 b=mbp5rVhCzzTGBAxp3i9tWqOZ/xKfNZT3bcEb46LuAc4JiEw9f8WCzV9xSZadsqJ1vL/aSPFpqsHSGi6gas3oMGSOk5fd6VxTkcmAUjcaMilSq9r3YqHoMaX3zoHNkTkdnsfnhDmz4eswP3ssa5X35j+e6wtKVtLk5gLO9O5ck1uhKcE8Fx/VDPeFBDrzhvnqK1Lc+yBMX8QDUuScBtM6Tr7DU7PdvPekGdjAI9fM4/UgRpGmHjJE5pXB50/xrm9/n2LHDDUja27aOTB+xxVOAHBtwnIJ1TlLYX8rhXEmoDlurwxJhvUxLfXmbJNZMZfNO/0Vh+wjYZAPkQytdvJnpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGIJleYRanr8d6XRRPKZLzyGcwIZVGd0OaCgdNzGbmA=;
 b=3NaSNoPUVna5QYc+d/Ve6tRe9i3Ga3LeNQobz9YNfY3GibqT1jLY20Obrk+b1tVbi0tC28X0E+pFJRqNjUYoLK9eNuZGZ/F64GBKA8nUhQRT6r74wgz9FeXNEBVJvjuzcu0USzHjGFgH7rK5yf53GRSpPuPU7mNNLpMK6bybBio=
Received: from DM6PR06CA0094.namprd06.prod.outlook.com (2603:10b6:5:336::27)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 18:40:43 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::b7) by DM6PR06CA0094.outlook.office365.com
 (2603:10b6:5:336::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 18:40:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 18:40:43 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 12:40:40 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Charlene Liu <charlene.liu@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>
Subject: [PATCH 08/17] drm/amd/display: Fix S4 hang polling on HW power up
 done for VBIOS DMCUB
Date: Wed, 14 Feb 2024 11:38:39 -0700
Message-ID: <20240214184006.1356137-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dc9125-ae53-4c33-d8d9-08dc2d8c7396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrIoP5NSLIbBRtgi6lVOLl08Mi8SQLjeY/x/xD0hzOaQV3+0D9duKouE62ckvN3Fk7T3gL6dZwkLGGEhkRgEMxIcLG5Y6HKKOTXlVh7T2pqk3mkpNJpQPs8JQiBElxsXG9NWqRdFu8mPS3NkKGdj7/D6FdkV1PdIITXq702c3wb4gKLjqZVWISFH1KTNZ7VdVrSYuvNqCtybWJPi0F9uEWHgi8t9Ayefr6AKYB/cE2seZ4z1qEwfj80CjdNlF1OZLsFWecJgGuCZsky272oPm1gaAoxBZ2fDbPbZsGA9zMS1UUZOoOliJWVjHcn/sJbJBJXcLB+Gja1jgyoe41tjiHQlhgTJyFp8oJcwcf5KCRhiltcJPWSSAW4nfmelnSgH5yx9epfq8iYeKdGzICFJ1lkx/MH7vhZZyxvYIIL1V3omTCTsvo5i/Jr4aeZI1rbA4BbUryVkL4JxDEZbPCuT/6eYwdEMw/5jKkVNfKACswLTO0xUJyAufMq06vjkz8/Wlt0EpVTIKR88fgxNtn0FXrw9egcxcJpiiN6fYFs8lnnr44ao33+Ib8ptkm7GaiSSLHcoDplh9F77pIWtrJDCgjiMoVnJhU5Q6P1EZqoezPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(40470700004)(46966006)(36840700001)(41300700001)(5660300002)(336012)(82740400003)(2906002)(316002)(36756003)(4326008)(26005)(70206006)(426003)(16526019)(478600001)(70586007)(8676002)(2616005)(8936002)(1076003)(356005)(86362001)(81166007)(83380400001)(54906003)(6916009);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 18:40:43.6923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dc9125-ae53-4c33-d8d9-08dc2d8c7396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
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
VBIOS DMCUB firmware doesn't set the dal_fw bit and we end up hanging
waiting for HW power up done because of it.

[How]
Simplify the path and allow mailbox_rdy to be a functional check when
we detect VBIOS firmware.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c | 8 +++++++-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c   | 9 +--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
index 60223efc6fc8..53f359f3fae2 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn35.c
@@ -555,8 +555,14 @@ uint32_t dmub_dcn35_read_inbox0_ack_register(struct dmub_srv *dmub)
 bool dmub_dcn35_is_hw_powered_up(struct dmub_srv *dmub)
 {
 	union dmub_fw_boot_status status;
+	uint32_t is_enable;
+
+	REG_GET(DMCUB_CNTL, DMCUB_ENABLE, &is_enable);
+	if (is_enable == 0)
+		return false;
 
 	status.all = REG_READ(DMCUB_SCRATCH0);
 
-	return status.bits.hw_power_init_done;
+	return (status.bits.dal_fw && status.bits.hw_power_init_done && status.bits.mailbox_rdy) ||
+	       (!status.bits.dal_fw && status.bits.mailbox_rdy);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index fb66832dc996..cd97983cf759 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -800,20 +800,13 @@ enum dmub_status dmub_srv_cmd_execute(struct dmub_srv *dmub)
 
 bool dmub_srv_is_hw_pwr_up(struct dmub_srv *dmub)
 {
-	union dmub_fw_boot_status status;
-
 	if (!dmub->hw_funcs.is_hw_powered_up)
 		return true;
 
 	if (!dmub->hw_funcs.is_hw_powered_up(dmub))
 		return false;
 
-	if (!dmub->hw_funcs.is_hw_init(dmub))
-		return false;
-
-	status = dmub->hw_funcs.get_fw_status(dmub);
-
-	return status.bits.dal_fw && status.bits.mailbox_rdy;
+	return true;
 }
 
 enum dmub_status dmub_srv_wait_for_hw_pwr_up(struct dmub_srv *dmub,
-- 
2.43.0

