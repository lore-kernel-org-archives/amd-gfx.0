Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911F7CCFA05
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 07:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CB1510EA2D;
	Fri,  7 Nov 2025 07:08:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iFIhh5cS";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4905810EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 07:08:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkwFfioBkYVUmnY+6WhU/VIMr6LCav6T11Cmz3aHqdSepcAFnC/ZFEaLKcm/mHqQiA0O8Hmd1boU+PWH3RrL0wC0Ty6XK2crujnEZ2CSQfANBUyaxurppy1MqP4FKTIymNnyg7YwkOI71gIDkp8I+jDDCuVPW9w/7Q0rExd3r/LKh7ETW+LTfnUjqBZ+KVRyciU33Pw/ZI6jCeZJKOBierwB+OcftIDkp/Z1iEKlGC30ec9XFN14uReOrheqiHGbgGEY9rUYVf0G87BToKQDw50V00gk/hMq4fQa1zHo1bNSUTgcNy05/6XKJkNkBK8xbMRjxVv7CJ30bzVeevEM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrxF2N6naBekeQZEghAzfZJ8AvgskVpfdqe0ELvpdd4=;
 b=pnEp1FNi43vu07kXgPNDtpwkpQbhtIHUjacBtQFYVBcpDC61a+KuzKVNdi807V9WJM5vjRqdkrjTg2o/7uor1BAWRVBKwLod01xWvIRSchuBTTRIZ9c0jQFR+gaUG6d708/TeWqv11KN0UDDfshwtk2U8+f2NX2Gw51QzluY/vfxHNHZW1vn7mJ+U53lMaqr8ar98/LR5Z/DVv7u/jYJQsQf60w8L/rzG2IH6dnvh6EUE5AiXnVeIhMMM3K7YLDvV6KeA3+0EgOlE/o8sJ7rVokNWsxgTBV2Ivh2f8cgIDZzA5WL0MeK2DtWdBW2EV2/Ukh9hicu36GpecMUN43FrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrxF2N6naBekeQZEghAzfZJ8AvgskVpfdqe0ELvpdd4=;
 b=iFIhh5cSfNYkeVVtHs8f932RG5jTLq6vnvDkvKPvVPX/JZ9epY/QdZFHVLxDaMyxKm+Is219pQmmzFE+nlyLjAS3suKBoL5wejLGNUEUeFudofZ7yejg/xmtOxMgmjfz57Jhyz7r3c4fzFMQhN4iTgugsnBOZ3MG4IcJ4hEiats=
Received: from PH8P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::30)
 by IA1PR12MB6409.namprd12.prod.outlook.com (2603:10b6:208:38b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 07:08:03 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:510:2db:cafe::45) by PH8P223CA0013.outlook.office365.com
 (2603:10b6:510:2db::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Fri,
 7 Nov 2025 07:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Fri, 7 Nov 2025 07:08:01 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 23:08:00 -0800
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Emily.Deng@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] drm/amdgpu: reduce the full gpu access time in
 amdgpu_device_init.
Date: Fri, 7 Nov 2025 15:07:47 +0800
Message-ID: <20251107070747.1663874-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|IA1PR12MB6409:EE_
X-MS-Office365-Filtering-Correlation-Id: 535432d0-801a-4f7c-33f2-08de1dcc63ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ALYAl+kayTPXvbr/S+XXs5WODryEkyi6d5DlXGaKrKTGsRKSQLUITQaYdyxB?=
 =?us-ascii?Q?8GfhJJaGP3wuqS9H54745e34jUa0UKHaFyTlRHGOprkWEGSZIgwuzmSoJotv?=
 =?us-ascii?Q?2lckt/60T9kCrGCVaLoWIMFUfq4hAucOBUtTKhrlLBw0m81k7Zqn3kxOnnsN?=
 =?us-ascii?Q?SYO9Uct9RsHisYEGN5/GOSeAuobjdpjzGxckgn7nvWqsuBoCrcvvNvSu6uS3?=
 =?us-ascii?Q?VWQ+CD/5iBdJ/tGVgGx6WoyzfUaltVCCc33ue/TsyfJsbhXcbz/ss74eytxj?=
 =?us-ascii?Q?FfV2/3X/vt4zrzXNUXKmqA9Cv1CY3kIM3M/nHO5ZQg9eP58ZPPNiNk1g5FwK?=
 =?us-ascii?Q?SIyTtNYxX6cs5jmp6xb056MEFapJVtXv9WqHsOVVA0BVfd/M8uCZM3sYgrZb?=
 =?us-ascii?Q?5euFYT6J7/hokO3x6CjQm1EnZX9Kf+8niuogLMZLaoQ2K2K3TLAj5FOuN9L9?=
 =?us-ascii?Q?GSex2AmK5uAARGfEaVVa/nxPIYySU/LaCT7BZCdz20h4blbrMZUnvvHDCJLN?=
 =?us-ascii?Q?8dBXpVM7OLgWy0NSo0NhGARl0MYG0wevr4FPqzhleH2e0qVkVE0vgBLLOlhF?=
 =?us-ascii?Q?jJw13+qPvZJJQuH3+lPLXQQgavwYS3MHebJvLLGTCneZgKMLkjQMuw1YEZJ6?=
 =?us-ascii?Q?W9OYr1aZ+slqKkeRH00QGAmttWAjRctATzh8UkBvmjHAVHBRMCMh1KxIJydb?=
 =?us-ascii?Q?WVaeoP8akk3jez/LSbF4nW9xKilRVYYKUoGM02ttfyMJZe7qHEYdKllBTaNY?=
 =?us-ascii?Q?zdNDamvIOy8BQ0hDH0OwjtAWdHUf4J9WLWicQHsEWZMav78Id+gIgfEKfLy3?=
 =?us-ascii?Q?P+/wi4vLVX3ZRFYYKwXNyeRSgTFwN2sycs5ZuhZ6eepwsY/Xdal5pmaStwqu?=
 =?us-ascii?Q?hZgw2cU+Gy4Zy1dPCg2mUp1V64EJqtWbbTvcgZ41mDGpzVNlW7hnyXesWMon?=
 =?us-ascii?Q?JzDbIYJ2ApZiEAfaaHyevb1xhF1M6w/Fp7MurSh89YwOM4ijpAnSBwSz5U/B?=
 =?us-ascii?Q?5Xz5kTSbjkhIBGwkAesxYfwrnBRUoGfLDXStGRkMh9Q3GyRTScr0DOxkW0GE?=
 =?us-ascii?Q?bCuHoDP2Y4TbJTJH2OrxJxOlpdWYBd87askjz42Lofy7I9aLvsVsetMGa4NS?=
 =?us-ascii?Q?1yuxgj1wqvoEHvz8FUJsjW8PjCdB/j0KWqMsh5DQ/U0AI6MbYgw8bigWfiOt?=
 =?us-ascii?Q?puhAZttaHba7cz4E0e4+0qw/w8pzlkZnwo2VGAvlzfMfmFL3zFXruSYaBC6l?=
 =?us-ascii?Q?k6Rl0LZdGpnsWGS7BqgssDFYBBJTkEjDUA6i/dV+EtgEwFeyeEAr7a/ERjCt?=
 =?us-ascii?Q?QRQj1PxMJqCb/y2NvEmDMuvrj7bxzQvgFmTFsVfXp4pAmjHA3/J2DOo71gbD?=
 =?us-ascii?Q?6Iwc8aZuFL407IYgS7qT4v30QWFdfOP5VGrrkeVrR8bdrDV5RQ6YvoZJFwOh?=
 =?us-ascii?Q?8nc73tj3P2+jMekhEP626zMXm4mGU86pH0xA/0RPwfYgc3F/23W+0R0ahe2F?=
 =?us-ascii?Q?6HgiOIf7Oaj5UrC6W/iV2PeSuah9jPGRuSQq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 07:08:01.6839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535432d0-801a-4f7c-33f2-08de1dcc63ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6409
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

[Why]
function "devm_memremap_pages" in function "kgd2kfd_init_zone_device",
sometimes cost too much time.

[How]
move the function "kgd2kfd_init_zone_device" after release full gpu access(amdgpu_virt_release_full_gpu).

Signed-off-by: chong li <chongli2@amd.com>
Change-Id: I3eebd7272b8f0c85d08fec80acee67a2c9e59e52
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1e8725abcded..9aacf8fdb38a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3314,7 +3314,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 
 	/* Don't init kfd if whole hive need to be reset during init */
 	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
-		kgd2kfd_init_zone_device(adev);
 		amdgpu_amdkfd_device_init(adev);
 	}
 
@@ -4929,6 +4928,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	if (adev->init_lvl->level == AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
 		amdgpu_xgmi_reset_on_init(adev);
+
+    /* Don't init kfd if whole hive need to be reset during init */
+    if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI)
+		kgd2kfd_init_zone_device(adev);
+
 	/*
 	 * Place those sysfs registering after `late_init`. As some of those
 	 * operations performed in `late_init` might affect the sysfs
-- 
2.48.1

