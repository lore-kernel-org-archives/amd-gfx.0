Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6984C44507
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 08:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AB6810EC6C;
	Tue, 14 Jul 2026 08:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vQeyT9JX";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1265010EC62
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 08:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia0VvruozgnY6DOY7oz7y/Bv8qMNv2mNLYl/lEl3Df/qXKflvinf4GhMHsuK0hNoHNgqdpSGcdGaA5/BHgGIXXt2r++JJxpdgkxMp839mY0jUfzNWnbr2ISgxglVyG0KdWKRrmi4woApOxuzBmOlUSa1CUgbqYyDAinYua+B5Irc/MmkuaF0Z2UI8PUuRj9sc2XxmxVeXzJrQKlXYrRXkAJPAhaR/ee40mArW0Us3xl7hzwAsAHUtsAYS6hG0myhIRwKhBlTyTMB3vLuCa5l3OsqnqcYIWiyYaFfiHz4Uw10nXFUh0A8/5VW8K7P1LPg5td2RS0vot4WMND/726gXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b8fLuzVBRZHxOjDyUgmBj5cl3shb+ZYgI64KBhL1B4=;
 b=jNplqhi31Ygx7T1TEI4YkhDfGAKUrwV8FhZxsCBW8IuPAbTM2qPQb7hR5//w/ezOGX2/JXko0K/KCRCK11qKLm5NPlkflwUX5wfx63tcnaVZsPgxrJgH4VdImuSupp+09WLC6bvt6PXis7pTLGrTiQzletq0r6EABuo3//A4ysqi/qsWXDvpg7kdn8Z7tyC7lIs3HqR82qxupNMQGE9ie5wN8HwTXpb65pgrKUTejOawe6PE4UqKynme1LkYV2B/IUVxA2CNtHlQTw2Yu8ylx499iAYXq0VvL7R7R6fPmYYWiqxAF7VHOiZK7yVI3RU4BEfAzciIHPlGWOL7SxZBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b8fLuzVBRZHxOjDyUgmBj5cl3shb+ZYgI64KBhL1B4=;
 b=vQeyT9JXAwypnrpR49i2Zpase0UbBmJ1g8LdsoWfZPty9TiMNZz0YCIWOC6Fzg2BMbkwcsZCIpaMlthl/3TFX1hLcmbf0VDMaiJ4oiI3J9a4kUGaAV4QvXI9BMl4KHgCrnOXJRnt2dHvt3Vy2InBzidxRvf0NKEkGgRpg9SUZDY=
Received: from SJ0PR13CA0181.namprd13.prod.outlook.com (2603:10b6:a03:2c3::6)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 08:02:40 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::1a) by SJ0PR13CA0181.outlook.office365.com
 (2603:10b6:a03:2c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 08:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 08:02:39 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 14 Jul 2026 03:02:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Prike Liang <Prike.Liang@amd.com>, "Sunil
 Khatri" <sunil.khatri@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v4 2/4] drm/amdgpu/userq: properly account for resets
Date: Tue, 14 Jul 2026 13:32:18 +0530
Message-ID: <20260714080220.3395155-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
References: <20260714080220.3395155-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 12cb7e5d-ab24-4e6f-6c5f-08dee17e4658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: gtrOyJ4awcGkqcEdsDRyA83M6Vk4DG+0SwruJONiUyFM0k82egTn8aulvANi6M5XUY57+UsFcBCf/tjkJ7eVXMLIeXOcYEhh6OxHNh6ULghNhTgXuUEAYloLkAcGB9cJGjH1T6Pev4BJd5Zof4EVijkyaKI6pcIy29ebqBQPZEUeiAmUkQXkWrcLwGS1+V2t2PLKUKj7WR1ZENa+ruTfLkMd7qwn086mIWFzkMokDMidkL9npH6phkMzTRphVnzPqQAVYANeUHhoDZgShhRX8j3QXBMRM2kwCLZcnL75+cYUGHIyoiW29OblhMRJjVXsvs7FbAx73TRZPaV+YUGxYwJPRw9s3xhpvNPA2ABRW8T8TxJFn+jUUHmYp8whopKNRfn+/yCT5JmNCWsNogEHmciZ9vptetoppaoQyCaHwh2gGopjUwvtyOlUV7E7+DqxNQJ708iY1PypOsnYFu2ijLdAIbi2RIEzkU1+4m12xVE9npvcMMxpCDq9/nhqIArSoSxWsV5f/Dk42TZzZTlNsle4DbyvMKFnM6lAR7Yv3H69KMxeSK0d//ZK7Hz2LBJCCXVuRSakBXc8Kcr8jE8IjOC1Cam69Vz6mI3mLsTwZyAWuQjeuwi4WdukcIrpIH+0NK1cQAGLQKnLsbKZ2pSBdk/Jn+72FelrrvNL6ePlhPutU++6iSVyPs8+sah4pkudNTKGypceWVa5W9TeReDm0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LVtDvUHPqSrzO+BhmvVrL0S/FwrY1RMZuiH9/qgT6378KyZ5todRCf4pxkKZ3piwonZd1DUXhgCx+8iaAKhVk69APDjv8QlH07PB0N/aXbAr+OZNgoMpg45Mtrywvfo6RdX2N+MOZgf1j71wiJD3QdhVYcwEZ4HbuQJCOqG3UsGTbO8R4o7Vbl6gfdU9Iaz+KuyTSQFVBWiV6V487CZs9ujzsciW2Ymvr2Q7XApyohCqQbsTy4gPr81K7Je6uSQtS73LlpUCawTIyDGTrz90N6cwahvhH3EoRMguwN7ZJwYvGeDJgZuhBfoThbKLQr6ahhyL+vz+gaeXnRFlLJbap8CPiI4bxThl/xhtQmBdM2QyqekJxUAZEhO6bpEK32q8jcvUr1FnY3KRhDgr5DDw9OEJCJA1yb/sHh9tyipwiTmLPhvChBMrkAg2bvMOFsAj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 08:02:39.4244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cb7e5d-ab24-4e6f-6c5f-08dee17e4658
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
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

From: Alex Deucher <alexander.deucher@amd.com>

We need to increment the reset counter, force fence completion,
and set the wedged event when a user queue is reset.

mes_userq_reset_queue() handles this for collateral damage, but the
caller needs to handle this directly for the original guilty queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Prike Liang <Prike.Liang@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ab3ef3a9f655..fb0d335875af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -167,8 +167,13 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 							 queue, NULL, NULL);
 		else
 			r = userq_funcs->reset(queue);
-		if (r)
+		if (r) {
 			gpu_reset = true;
+		} else {
+			atomic_inc(&adev->gpu_reset_counter);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
+		}
 	} else {
 		gpu_reset = true;
 	}
-- 
2.34.1

