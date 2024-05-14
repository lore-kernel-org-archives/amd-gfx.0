Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04123C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 14 May 2024 06:05:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457F410E101;
	Tue, 14 May 2024 06:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vqF5jg3R";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21EF610E0BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 May 2024 06:04:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJtOVx4bGmKzIpCrBnk7jFwFo2vPSa630hovkOZjEekzM84tX+B79LuZEI8Ph+olW95Y1vzpOVBbee0+jk/k4N/2Eh0Utx7lqxG7NgB6lvxzB7G1ORn0gsinIg/PQtXouvobt6pUiwb3FsMG4VNzoav0mVygxybqfKqObtvm0hQbQTPuzLp1TWfFfilYt1BSLMe6ucW/BuonbsMMb+5uI5UdcuFTTiplOx3n1lbsfcmrpDhKvBNL85xNfrb9yJfatf5BwHTSf/fzyit4aJSwhZUWJaf2dCKLrVOBxk8uIaODGd5rGXWx6TXTjHdWJshF+nuBLtkQZo2nUrdUGNFYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jgwadhUzD1uD4GncuJeo5s44Y0+FnpT0stYWYDewaU=;
 b=KcJ8lenEJ9sIgOaw+P0ko/fRBvBOkP+57nuT8JyvhSUQuSwy46VIZN5JJlcD+s5B+0JR9yZkHoCa+m1gfUz0mZbVcZpYKymQwlW/wlDU/v27to9W3U007n1w26wlXTANnNQcqGPARSz8phMRcuWYiEzbWq7NbXL1MooIwn0ooqH4gByGcbbrA9GkmVE4qwlnEilcLdBMgkAZBO4eGpM8X6r7JJExW1HWB0iG89YFBJjUDmS8MkVrt67XLgXIPOzma1u82P5Zn+rlrocclNEtaOgD+BelU+nF5fsOvb+0RB8Qkx/4LQD6FVsIw7nDaSAAYVPNxvDi7xykqnYyh/n+Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jgwadhUzD1uD4GncuJeo5s44Y0+FnpT0stYWYDewaU=;
 b=vqF5jg3R/ew6J/Q3d/7+loaDCf6PLwiSRoJycEo7xBM1t9uSV2LowIPVBqlxhP7XHlur0qCFPcKfUd86YXT2uJXJPd4BNCGUfyp5jAJT4HQZZlN6Oyr80gWD0HYRhckEGWc+sVlP8To1w5PVdTIcSee4wfXRaGWgQ/Rpa1ly9jU=
Received: from BL1PR13CA0380.namprd13.prod.outlook.com (2603:10b6:208:2c0::25)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 06:04:56 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c0:cafe::cb) by BL1PR13CA0380.outlook.office365.com
 (2603:10b6:208:2c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.25 via Frontend
 Transport; Tue, 14 May 2024 06:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Tue, 14 May 2024 06:04:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 14 May
 2024 01:04:54 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 01:04:52 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <Tim.Huang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Lijo Lazar
 <lijo.lazar@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: check specific index for aldebaran
Date: Tue, 14 May 2024 14:04:51 +0800
Message-ID: <20240514060451.3649916-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: d4925d41-e3dc-4630-6d5b-08dc73dbc73e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kkjeEwJkyli+si0ZDnBcCULcjLRaQs0Np8Y5L8drXJvCwQC0RTD8tgE5l4IX?=
 =?us-ascii?Q?qVI1lcDY0MRdlpTwilLQYiN0CLtoFZRtPORLYFOZaR1q4GWo2d/fBQeTMS4i?=
 =?us-ascii?Q?MOHKcKG3VxEKADxKpRRbE2L+z4NWFQGdL7W/MflydH9JHwgmra97xO7a/P8t?=
 =?us-ascii?Q?woWGPmM2e1ij46YGDw+a7sHEMbSFYVSK0X3v/NqndkZQW0DJ5YYcFfW+/5XV?=
 =?us-ascii?Q?eHjVDPYswf/75yLydZQm7CNGSJnuT0s1AZ23GT7PWesJsFoZaz9EyiR+L+0n?=
 =?us-ascii?Q?KzRUhcCGEXtyYXuZd0wGffqja+ADqX8jGqBnFMgQX65oDltCHAQkIM5Jvn/Z?=
 =?us-ascii?Q?c01fjrFmV8o1AGztgbenD9y2OhJwcd4K1wxiAByrm2TDGrOhxKQFxI0ybTBK?=
 =?us-ascii?Q?W1cuUZQRfEw08jZfbdwsspb7plUKKnG9sI8jYRPpZ27ymoCU6+P7nc4d9A/J?=
 =?us-ascii?Q?seKgK29Q+oo3I4Zk2o1WXJTAqfM4wXTYjABmuTOEuc+k0bS8pgxLF8NdV2Ok?=
 =?us-ascii?Q?VNxzIvyn6DZ9FFAP/oVmvwm55GGfY+VAnUhVi+kIAzyhRUdfwqWvOkWPHhZ/?=
 =?us-ascii?Q?3e5X/fgxrOs9zuk+f3hF3Jr32doqX7C6e9BLB71gf3gSwTVLfRlbEZyVkSzr?=
 =?us-ascii?Q?E9XQIAKrdSgHPGIkpkdLKaLiQ0ExWU3w9SA0KLgM8XOuS9eqBLlPGB80xzIw?=
 =?us-ascii?Q?Z/Vq1hOBcIpv8h6U2+mMl5PrpXBDkgDxf/URTNcVTj9iTjYxiaJIYGqhqtgG?=
 =?us-ascii?Q?0bCnnHPnff+RPr9b/ZGjO81D72iF+Yt4YZUw9jwWOVDhxtSmn6ICppl/XvDC?=
 =?us-ascii?Q?u/bL0T69N0zFQOVt6TbWFRSLZxoChfJftI2Du8h3KEZt31RPPHidEZdL8dnz?=
 =?us-ascii?Q?3WN3MTeDeE65iXG8Jmma4lbLhY/PdfhB+QT90nVkcINsVeJCYwNJImGwCep0?=
 =?us-ascii?Q?T88D9kjmDpcYgxdubpG10gJTdxqutDPeg/gyB59uayxG+mODX6FyM+eqve10?=
 =?us-ascii?Q?dndvfOBPCWQ0UFLbwZSFeRyFzzTt4MZ1X+i53e4ajh4Y02IVBJlk9usher3i?=
 =?us-ascii?Q?ytUcHVienGY7oOx9n3WKxrbBixOVpRViYy38iGFvowuySzC2ofXEftNWcUsH?=
 =?us-ascii?Q?3phHqpDeAZ5YZ0fDvZy17WafnlGgyfWkv57BMO7jF/EdXUoW4bjBkmjieeGZ?=
 =?us-ascii?Q?YbdB73io4tFlCOSiWcomKiTgJG2fs5GalmG7l+KiWSTC0e40BluOdCfsUEoj?=
 =?us-ascii?Q?ix/jXTV2lXxj97rCUBpLpulj+Pi52tnT2zBczx5kLvwphy+3mWbEFvjpFx/h?=
 =?us-ascii?Q?Idvjai6l6RjvcPvdtc+ikofZau7BmT6KZXMgbuZwxfrljkiMwEpxfsF2iov5?=
 =?us-ascii?Q?X1mwQGtoKyPuMa6VwdGGpPzb3ofy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2024 06:04:55.6619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4925d41-e3dc-4630-6d5b-08dc73dbc73e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245
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

To avoid warning problems, drop index and
use PPSMC_MSG_GfxDriverReset instead of index for aldebaran.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index a22eb6bbb05e..d671314c46c8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1880,17 +1880,18 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-						SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0 )
-		return -EINVAL;
 	mutex_lock(&smu->message_lock);
 	if (smu->smc_fw_version >= 0x00441400) {
-		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
+		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset,
+								SMU_RESET_MODE_2, NULL);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to mode2 reset!\n");
+			goto out;
+		}
 		/* This is similar to FLR, wait till max FLR timeout */
 		msleep(100);
 		dev_dbg(smu->adev->dev, "restore config space...\n");
-- 
2.25.1

