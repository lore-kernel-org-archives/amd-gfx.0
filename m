Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1ACE77198
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 03:36:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AC410E7E8;
	Wed,  8 Jan 2025 03:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a+Vh10NH";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0763D10E7E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 03:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQuHClBQyqCPV4GDh0te1W7Nje2qjS0r5v8WuSOMVdYiFKgIJT3KPLN0jK86A5ityXpw7b4c/TTTwyEkQ9kpmkJJJ/o4hSYh80uZI7VQNzjZUZbZKL7VTgNevtqwKzplDrxcJZSEZ5g+qaLGN6LPlSLWFTjeihsQcQhqISPMnFMOLiCYQthhM3Zcg7MJuvSKc+pObX6dVTchFIx6DcdVBaEby2jvhIQSHvQgqSmv1/FfulRHaB1HU6DlESS/nO7xGtzHooEBkOkTKDgVvCfAI7UyOq8jeyzSkbxX+uSbbpOGO+sxeKeKJauYLK23EkcO9sf4RHCGZqMTQdNyde7Hhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKAPrm34QQuJ0fRI3XuU6oeaSXqM8GZSpSOgtQC1ZIQ=;
 b=BKG8T9o6xIOJKDLZfqJTqaK9nxB9X23fEvTs40uuXMas2DPene/Rv/QHtLQfvRTsFSulZrUXQgsvIsZEIKCnND61kAnIinnA3gwn7FmlC2M07/B2VJ3OZfGJE4f8eklLgdKfTGc5UVl3Ko5cAWLKoguRp+OYDbcnE8L0K/Qtqy/HNjz6N9/FOvGhTt109ycTclgRoh1pJrxOCFCM0c2pzPhKSEtrntvwF9LGoERmRYOrXad/7MBYSNh1X1oTYFPlxak5wWPEvo1BMv1RwCABX94xt3sxThdgbNDy4C6H7BzDA5uuf1H/L4Ddai5klZAzrctnyZUzt26OXa3sCfxzkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKAPrm34QQuJ0fRI3XuU6oeaSXqM8GZSpSOgtQC1ZIQ=;
 b=a+Vh10NHT/IAROTQTAaUwKlaD7oQDofs0hroW2tJzR4dy8NENhn7jPDY35di9r51HjxHoshctV3KrtVKp6LLVEf4qUOQd1cQpi3wRTIu1Wba/DyGFgyx2qY6h11JEh2OoacQM30YTlb7G/7vcqGx1SYlPyd6xIdq38vytikW6Ns=
Received: from CH0PR03CA0415.namprd03.prod.outlook.com (2603:10b6:610:11b::26)
 by LV2PR12MB5822.namprd12.prod.outlook.com (2603:10b6:408:179::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 03:36:24 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::87) by CH0PR03CA0415.outlook.office365.com
 (2603:10b6:610:11b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Wed,
 8 Jan 2025 03:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 03:36:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 21:36:23 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 7 Jan 2025 21:36:22 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH v2 2/2] drm/amd/display: set the workload based on MALL status
Date: Wed, 8 Jan 2025 11:36:07 +0800
Message-ID: <20250108033607.13506-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108033607.13506-1-kenneth.feng@amd.com>
References: <20250108033607.13506-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|LV2PR12MB5822:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c19e38b-3799-469a-e1a4-08dd2f95a01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wMlqyzJwabB98HhNd3S8V9on/K5Z45dl5M4ow0z4j9azfilIZcPbSWay3PUU?=
 =?us-ascii?Q?fOc8dnPQQ2lRLZIhToaJrWGaGXUmouYPzIY89IvtO190oHQMQ4RYXTR0DH/g?=
 =?us-ascii?Q?3k05v8VvuqO0ULrgvi/v2lH6H8A107h7P0QtlxEp/HqzAcHeuVZIKJ0cF5/Y?=
 =?us-ascii?Q?OSnaRoTjYSHZyFFObJWIqRv7GcS6ZQeU9pfa+KcfmTZ17RENdvGK7hLX6ghb?=
 =?us-ascii?Q?V9J5XwZ2p+1nbE/pX66iAyYs763xZqN+H7LDMGy7+wi8m87qm3zazWiCcjGB?=
 =?us-ascii?Q?Z4r6WjYmgVggW7coBWLuhI9SsQzGqysxOq/AH5etRRD5KJhEgQX7cqSUL78h?=
 =?us-ascii?Q?g5bMRxGkyXduPaS3Iurva305aW3qZswf8tVS1kETi9iLAGQa7V0oPoYhiBAB?=
 =?us-ascii?Q?o7yHS1iPy7HNe8XIeNhfHOyWtSgXCZpNl3pYeqZXNvx8FXq4yTDG5RSVfiVG?=
 =?us-ascii?Q?mRokQPORKVEhXSTB7VI7WjqVOuUIeL3r3ew6+EH5tHB7ukIPL2mpECFezXBP?=
 =?us-ascii?Q?aNswCD3B5FwekWVDGpCz9u0Y7zclsTfUINDcSeehipooaUMRsTMYQbN+IAVh?=
 =?us-ascii?Q?bIuyfocR3UMMuW6L6w9bRtOUbumcezMvmRlcfW+lAVRTkOPyzn0ab6ncENkY?=
 =?us-ascii?Q?2DorU4tzYvDVZPWE/oVsx4J6HJpknQnQCarF8GYmAyqziuRhgXgODD55qsTY?=
 =?us-ascii?Q?7p43XzC4O080Tkr91dwQV2hWKpYFaKARAEDviz4OAyQv8/0Hy7l/6v5n2PLV?=
 =?us-ascii?Q?AulcHgdNsgj6s6XU1kYYQ1sde4tvhz8Ih08bhL0DlQuQaxiwBENWv6Yoq+of?=
 =?us-ascii?Q?Ff5zTu+V6t0sL3D3Sfekp91+qLK6RelLgeWKWemCtfDbfxh99V1WTuBc6sJp?=
 =?us-ascii?Q?dROLmz/jn7wVsXigr1nZdpeEgDDBBgUQnvWsM3VQXV0J374nOtTnqsCuQzYc?=
 =?us-ascii?Q?ANG8piCEPlie5hIrl1Mn4PFKf7PQXoFkkwGUbKKPeUe6wl/5A12BpMKCY7EN?=
 =?us-ascii?Q?Hc+TWRLzL2jDztTWRMe1BMrNRRZ+/7nv8pvnzRAnRL4dRjPR7DJvNaEX4b+i?=
 =?us-ascii?Q?wgZHEDOWD6/ezRUxn5t7EsyhVx2d8xo+lRkuklEGnL+EoXrpFfJk1VXfo5dU?=
 =?us-ascii?Q?QaKyt4OZJs3CTrzsmRxl8PVHTdlQrRJcqCGSVKfftQpEi5uO9YTuKnBD9KcO?=
 =?us-ascii?Q?bDQ+wlFy13c0ukNlzfTiHXO2sIIluT9m3bK1flBn3SuiHIldpySaKT1C442d?=
 =?us-ascii?Q?bwIY/7sJhyo1HWLxpnEFAtrQYSJTZKOjoRSB4gvMvPc/yzs1SKIhNzL8Qwrs?=
 =?us-ascii?Q?29Q/KH7KPymqPBeL5xa1HpLRzo4L/rw0+Car0pY9RDkKBngSN84ZVgLWOtKn?=
 =?us-ascii?Q?fLgyyO4FBTEO0iGAvMvPShpKr0NuX137jH4X59YrCOtVE91c+Dz+1LZPaO06?=
 =?us-ascii?Q?igPgxa5Rl5KLOPvg/wnmglAukt8rY7CcGjtdZto7C1enNYMCTv/z4nHztCjd?=
 =?us-ascii?Q?0zAMyCeQ+YVTHVc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 03:36:23.8551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c19e38b-3799-469a-e1a4-08dd2f95a01e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5822
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

set the workload based on MALL status

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 8bc73922e3a6..c569c8b4bdf9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -244,6 +244,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
 	struct amdgpu_display_manager *dm = vblank_work->dm;
+	struct amdgpu_device *adev = dm->adev;
+	int ret;
 
 	mutex_lock(&dm->dc_lock);
 
@@ -252,8 +254,14 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	else if (dm->active_vblank_irq_count)
 		dm->active_vblank_irq_count--;
 
-	if (dm->active_vblank_irq_count > 0)
+	if (dm->active_vblank_irq_count > 0) {
+		ret = amdgpu_dpm_set_and_save_bootup_power_profile(adev, false);
+		if (ret) {
+			dev_err(adev->dev, "(%d) failed to exit bootup workload\n", ret);
+			return;
+		}
 		dc_allow_idle_optimizations(dm->dc, false);
+	}
 
 	/*
 	 * Control PSR based on vblank requirements from OS
@@ -271,8 +279,14 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
-	if (dm->active_vblank_irq_count == 0)
+	if (dm->active_vblank_irq_count == 0) {
+		ret = amdgpu_dpm_set_and_save_bootup_power_profile(adev, true);
+		if (ret) {
+			dev_err(adev->dev, "(%d) failed to set bootup workload\n", ret);
+			return;
+		}
 		dc_allow_idle_optimizations(dm->dc, true);
+	}
 
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.34.1

