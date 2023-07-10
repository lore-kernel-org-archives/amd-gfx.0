Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0BEC001B0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19E3510E2C7;
	Mon, 10 Jul 2023 19:46:05 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15AF110E2D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMw8pK/DN6KfO8Y5/EegWAV7pchlkDTTCHSbiyUgUySVDk6/ORH4AUHqaeeLpzxJAEl9MawgwvGCiUpvCLYOF6cpY9Z00BDbE8OOUXzfqNu03bbwtcZtov/+dBst/SAOOeamoFROzIEpexYDUGK+eDvZWJ4rd5YFrPivahj/kyat/Rp9gI0x513/MYPY/pspUM/s7QMn3VRvfoF/64oPn/e4jwF6C2ovL/cH3DHcJh3l0XQmPxN8L69t7E9QQxzRBE/97gtxkMA7EdxZDg9Ja/iU46gIZlRf0x0TpyhTRBTEVPOQYel7YjHbzsStVpTxJL0X545QyxU6CqEmeDcM5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcaKEyxobzKmw0qTH10M50mtdLpug219dlRm94cEoDY=;
 b=FAoGOFp4ltMpEdSIHmvsiC8oDR0tteTiCz+5Ddx5ycbBdEcomnBzbVzvqTbAQvYQbrnR18YD6qKJDzdN0GM5P6tMH3RWqi8uPf5fie26ET2xgqDzcHfhpQFU3+uRKA1Zb027B1ZuCzi73pq3oufVdPP41sPmqis+HHA1lNxDnbX8JKXh7SyypODfZH2RkEIVHbDCLa8S4hbDEP0dt5vz7mHsx+tKJCT9RDHjMzmBu6eejcOB9vYFytjqDYWoqcWU9xWMI6P9Dj/0738E/LDVJTOG8hTFZFSzLVTl+tdX4Pt08V4nkiXyMppGj3B5QLGW20aToZmw9D/DBLrDuZV1PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcaKEyxobzKmw0qTH10M50mtdLpug219dlRm94cEoDY=;
 b=zHce9z9MZcYMV8SuE19b9PIVoyNRd50drbxowgrX+ee0Y6lPIrHWSFauqgiZcrSSfKGS8mTwqV3v+m4dJdn8d2noj+snlnEWRKGpD6d6YXxxVeSH8SGHTwlwpLQuoxGCw2fbpZXaY0HPZqSo+ALDiRqlcyVTkix67QsrOCvI6m4=
Received: from MW4PR04CA0366.namprd04.prod.outlook.com (2603:10b6:303:81::11)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 19:45:56 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::b6) by MW4PR04CA0366.outlook.office365.com
 (2603:10b6:303:81::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 19:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Mon, 10 Jul 2023 19:45:56 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Jul 2023 14:45:55 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: enable grace period for xcp instance
Date: Mon, 10 Jul 2023 15:45:30 -0400
Message-ID: <20230710194530.214865-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|IA1PR12MB8288:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c4cc7d-4d19-4789-5b88-08db817e4762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmnseRqDoXpWp3nmYnv43Vsh8swoWigqwRojtIZ3EX0QpLPof+XmWQwZE6wUMxJQWWqU39XvV7nJsYuYoLvsnQIWb9Sb1gibf1SnEZF6/Wxbyx5phMc1NCgMuiAyIiMPg+hXsLsdtaHDICmrZpN14pyGR2HvMj83CQlfZr/+nmorXGQ3IZ7YXFwPzJ8bz9KbJVoOI/2CxVP4mZfK8VJxwCPkLeNzYWLPcn9aZhj3zHDTzI1bF2+lwWguftKIDq6GZARkoe3vSWIfgm6oSXBEUHLzdKjbezpyJ0lpPbjRmDt/iQio3mqVOCrg7maiyf21rQS8+lDJGm/o+KpDekR+3MkjoyQ3VbUlcaMif1pwVBFJuNQIxmXJ01QHuz3ts7HzAPHRqRWtou6Xwfq6PaspgCXltXg8wP1Kgef/eApGHlmvVWRYqQb+rI18HY1VDCd4Doh9BlEkR9M7eV03gciw0cMXZuE4zUeUIUBcuA1f47RpyMR4lBwByTkcwzFowegXZx8knImONGzPNegTousYbhjL+ojPWaOqJ0cs5W9wAROuwh4M1M32lJrQOAq1nvE0wlJAWNuuX40EfnyJsYH893IWBGzP84lqQMZ2hw8VHVNLszSaAfEibIWL5b+NXeh+eW0uGKfIzG/L4Kp3HtGbFhwBgKSyc9WnkaDV73HzPMjXHf4YUhM/q8wQ9WOlXpPJ7ACD2fL9ARBZUuYsgy84E+/l24hSHAnor+dzThphJnoK8vuIm48vfC/1S0QyjXy+RvQ44ODpLEMposcbvrIXdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(478600001)(7696005)(54906003)(36860700001)(47076005)(426003)(83380400001)(36756003)(40460700003)(86362001)(40480700001)(2616005)(2906002)(70206006)(82310400005)(186003)(70586007)(16526019)(1076003)(26005)(336012)(81166007)(82740400003)(356005)(8676002)(6916009)(316002)(5660300002)(4326008)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:45:56.4516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c4cc7d-4d19-4789-5b88-08db817e4762
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Read/write grace period from/to first xcc instance of
xcp in kfd node.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 11 ++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c    | 10 +++++++---
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index de83eccdd9de..a95bcb91dc09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1619,10 +1619,15 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 
 	init_sdma_bitmaps(dqm);
 
-	if (dqm->dev->kfd2kgd->get_iq_wait_times)
+	if (dqm->dev->kfd2kgd->get_iq_wait_times) {
+		u32 inst = ffs(dqm->dev->xcc_mask &
+			       (1UL <<
+			       dqm->dev->xcp->id *
+			       dqm->dev->adev->gfx.num_xcc_per_xcp)) - 1;
 		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
-					&dqm->wait_times,
-					0);
+					&dqm->wait_times[inst],
+					inst);
+	}
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 7dd4b177219d..45959c33b944 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -262,7 +262,7 @@ struct device_queue_manager {
 	/* used for GFX 9.4.3 only */
 	uint32_t		current_logical_xcc_start;
 
-	uint32_t		wait_times;
+	uint32_t		wait_times[MAX_XCP];
 
 	wait_queue_head_t	destroy_wait;
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8fda16e6fee6..dd50164c16cd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -292,17 +292,21 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 	struct pm4_mec_write_data_mmio *packet;
 	uint32_t reg_offset = 0;
 	uint32_t reg_data = 0;
+	uint32_t inst = ffs(pm->dqm->dev->xcc_mask &
+			    (1UL <<
+			    pm->dqm->dev->xcp->id *
+			    pm->dqm->dev->adev->gfx.num_xcc_per_xcp)) - 1;
 
 	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
 			pm->dqm->dev->adev,
-			pm->dqm->wait_times,
+			pm->dqm->wait_times[inst],
 			grace_period,
 			&reg_offset,
 			&reg_data,
-			0);
+			inst);
 
 	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
-		reg_data = pm->dqm->wait_times;
+		reg_data = pm->dqm->wait_times[inst];
 
 	packet = (struct pm4_mec_write_data_mmio *)buffer;
 	memset(buffer, 0, sizeof(struct pm4_mec_write_data_mmio));
-- 
2.34.1

