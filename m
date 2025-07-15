Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914EFC83F17
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 05:45:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3708C10E35E;
	Tue, 15 Jul 2025 05:45:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="scBAyJWD";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502D910E35E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 05:45:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVNK5xh5aka6DSzEWHsuEMpVH9zM6nnGYbMXjncfEAb7SkaADyOu+9am6/Tuk12bSDMaEc4noiVdWRrf0dh0QdSeUuW6qjOgsZldeE4qx+W6dPnX+xcnGc0gqXot9zAAr/QqV/WyVMyHrY14TaRjns0cy6gT/Dy8quwZN/MbnckOxXdePuF8XogmEcAbePZjZTmCf/Bis7xCguycdwg1tSzPZAvAOhP7mw3NA4foUbrlAAlrp8fE+5Ws9Qy8iUt6z1EDUmDnXZnBk1FytI6ZOx6bkgTKp2lEJ+LSQB+7mS/jKIQ+URD/IJFFWky6tLvB30kwRum+2mv+Kb31okxHtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5g+tGJYsIxXqvMXkGClq02A+ejOezo7fZYbXUROIkIQ=;
 b=BrPk9Tte30cx9FpPRaBBRWclV5DjUb7hUP3L8KzN78YCZl30JmVC7TEsapJ8ji9B2p/54cojJrQJgW6TQAC+Cl8Wnw87RE2OaGD1xkyu95d/eLDhK0P8vXSfVmcWwv8+sOonaC3SuxjXCrhFvUnf05Rvl5j6YMWrK2m8CKcqISMjd1fd3aMDWZDo2OY7TwMj4HlTehdkxt21uea6I2OqeL95AjlkFZmbQ9AJlGvJ9Kkj3bAZj+6zg3EKwPCkLHWkgbues76W7gyjlfPWd7ijIHaRCubL6hwSBm9ftMFki1VQjQvjtfeg2nwwXCEdSSaeNNKR61qoLV2NdmuAIB/UGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5g+tGJYsIxXqvMXkGClq02A+ejOezo7fZYbXUROIkIQ=;
 b=scBAyJWD1PIlF+RW51q7tKa1a21M+BPAXjvfa/mIzQp38QsPGUT1iL81GkZS0Ua8oST+ApNDST0xn7QuyBP7XUYpbHTH/zG2H/BifDtZz+AKBJYcUBrsIc0tfPRKnqrW780w7oHvdKrXztOelZOO8WPfh1V2uOCXkG9Y0z0KwXk=
Received: from SA1P222CA0191.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::24)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 05:45:19 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::97) by SA1P222CA0191.outlook.office365.com
 (2603:10b6:806:3c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.33 via Frontend Transport; Tue,
 15 Jul 2025 05:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Tue, 15 Jul 2025 05:45:18 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Jul
 2025 00:45:16 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>, kernel test robot
 <lkp@intel.com>
Subject: [PATCH] drm/amd/pm: Remove unnecessary variable
Date: Tue, 15 Jul 2025 13:45:02 +0800
Message-ID: <20250715054502.302107-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: dd88c09c-8441-4758-3852-08ddc362c82a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qe5nG2gKD40ddMGaTaTS4DaUzyBFMwC+FBycRXTwGrffNJaTgwzT4TSsej9s?=
 =?us-ascii?Q?PGzfErBZeDfHDJZWUteYwC9DwWKriGjXOCgDJSXqHe8eEgQ5ly3sNlf4w7zx?=
 =?us-ascii?Q?J35QAT+z40T8nxL8p2chyKmJfZ2twKVTPdkgOp8aGKGwgYf9rC+fSAVc0qfs?=
 =?us-ascii?Q?ciBcEHNeqEB+Qln8fZwd86BIuwmju5tJDHvM+0IHIHDsxm6ggFm7aJbY2aHx?=
 =?us-ascii?Q?cucbrDtKNNFqo5cxvvpE4esqro3fuYgyf8g8DoQZ4+aESGDATdTr8SwGf3K9?=
 =?us-ascii?Q?+2H1QlV8tAGC0DoJbJm+1F/+KcLCgvGURsSHVKzGYxk+Sl2rNLrT2vEaVO+u?=
 =?us-ascii?Q?LUUA50TbCe0SfXZxaj+R5A0cA8prDGbfJgjq7x0WR5z6eM0cUui/Qz7EOVjM?=
 =?us-ascii?Q?tCikNUknRXYYpIwNnApMHizPI1Qm9KUgEQbW5YFl+zMJMrthbg5uNQyk80Vq?=
 =?us-ascii?Q?zN6V2JQw50U6nyv26CiM984xzVIXJlXfXqIJH2twrZvxQk6J9/gocvJwS6av?=
 =?us-ascii?Q?vzW/QYVI69FB9AOdnGiS8Rjefrvx3dy7IF0MrKiW8QmuPDXtTlMGFP/umLKb?=
 =?us-ascii?Q?o5vYDpd19djbt5tgrhXtp8l2R+8VuqVfJE0967umtfLSutul3L0GWVHyS2ug?=
 =?us-ascii?Q?LxhGiGn1POWF4Kb+gwSULHvlUdX+90MC+A+taBst3vYtPJzqnl2t638MdIWJ?=
 =?us-ascii?Q?8p0KWZU9NyEkWiPjlcWzTB+LVET/nAn0kMtGUSHQWSLYnLDJcDnxmORFFYrc?=
 =?us-ascii?Q?A3gAB5zywc+zkR4ovnflXxqd/YXb1BK4T9rjDWSCM9XEUgxg6LwnXnJ5blAa?=
 =?us-ascii?Q?pndAfwxDBur7OGrDBKhn9k489K5xy8V1IpsW3M2DAu8v0nCGzGBOxBZhLOuc?=
 =?us-ascii?Q?yayzEolZfCV8bPKoVDcEK/FYK+XdoJp+sf9Y7y6kJsfKudZkdcH+VdpXz75I?=
 =?us-ascii?Q?L1ZIjbwEw4w5YEBcJr+7UVCYXNK0ViOSbct3SMn6dm9bYg3K91zINfGEH7Nx?=
 =?us-ascii?Q?5HbECUyppkj+5MXkKAv7+hdo2ErWGKcQV29CXrOF8CpCgKOTZEol5CKqykT4?=
 =?us-ascii?Q?Y4awCokzd3POaNvoe9PaY0pAWiunEws5YaCx3AInTRBUEoPrakt6Y6fVzgW+?=
 =?us-ascii?Q?uifn9byl9uQ4pZC9MckSCNh2zRXTPwrRC/4ojn4pUHG79VBJuFk2tul4Du+B?=
 =?us-ascii?Q?diJKKzBrgUOR+B8gELlOzWLKlldWjcbWN4JBGzBd0hwGAfyA5sBA5B6YYQP7?=
 =?us-ascii?Q?8P2zzmEbm5ZuYKsM/8n0aiVDAmHJh4MbTSN0mIhWGM8nk2zGDAXqTMWNx2rP?=
 =?us-ascii?Q?6ugPaNRD2VUFZwO57qBUYyUNlXY6zbUyYb6BEKtTUCCmSOtKzncTQYN8UyN/?=
 =?us-ascii?Q?/zLDLkivp34msncxDMlDXfxosvq3HE5pNz+BZE7kcI5HgFrFmcogEgMSCJB/?=
 =?us-ascii?Q?HlH03+E0VFl7IYxK6h1FtBJEsaBiwQ025tkjpdAC1qW5YxONXwHNaaBVwMP5?=
 =?us-ascii?Q?6aG//RDhPi4C7y5zDAls1y6J4lsj6OvJWWl/MCnEcAh7+lQDAIHFsdV9CQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 05:45:18.8246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd88c09c-8441-4758-3852-08ddc362c82a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050
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

Remove unnecessary variable ret from smu_v13_0_12_get_smu_metrics_data

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507150618.WOfvWsQF-lkp@intel.com

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index b3adeb6e43a8..02a455a31c25 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -301,7 +301,6 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 	struct smu_table_context *smu_table = &smu->smu_table;
 	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
 	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
 	int xcc_id;
 
 	/* For clocks with multiple instances, only report the first one */
@@ -357,7 +356,7 @@ int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
 		break;
 	}
 
-	return ret;
+	return 0;
 }
 
 ssize_t smu_v13_0_12_get_xcp_metrics(struct smu_context *smu, struct amdgpu_xcp *xcp, void *table, void *smu_metrics)
-- 
2.46.0

