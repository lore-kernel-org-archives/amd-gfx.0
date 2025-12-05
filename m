Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2166ED339BB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 18:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86DD10EB8E;
	Fri,  5 Dec 2025 18:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GAM/9DRS";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FF010EB8E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 18:42:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCFL85F5oRxJIubYw1t8Mksf5jqiiAhJ3dP5cXshy50DSpD1PZFNXnen5dV7QutAbkXR1XU8KJm1hw2mfcd4EDFfvJVEXRR1uMEnGnUAIiWiZVHMHLpCM1n5cbgqilVAEsC6+Ypjm3IrgCl1babYgmILvpaWGeXsH6HmoU3lZAcZS+ceBEvTGhFeGi21NtW2xla2ekj112BRQ3WTxOwH98RTRIgm2UZ7cYN7tzaoEV6rWTTGjHlW8prx0YyOJuxI276LAzqg0g6dnZdCbAlNtw/fTVVgbR19vKBz3e3kVUwAVPZqkwEp2HBaXCOhbAhiP+oYLZWI9KeliHnsVUieXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MQI2FZ7SCllXrAB9o9ocfufvbpLfoAeTy4KC44BaPA=;
 b=e5DnxpLlVokiclAZVc67ZbYs5DAbKVl+Spd7c8WaCErs3zWe6ZfmavATI/yuRks+DNZ5h9TBb3ytfR4H1w+eFNHXih9TpV/+OzpL/N0K7eJKivcxVTPDSHibSi60gdochdO83dEyfxOi0yQBcyOEdXgtUx+CAVG/7lzyrh/ByzCOFd2RobkwG11Iq+Gkg6Oxwz/mmxf6T48TRLqW3j/tdHnGlULeX0O4i2UKrwA8RvXPyYbJsTJHu6gyL4c6868bAF302eRN94+/MygZtdxls3hU5CctUxKfagcxmSL6q2tyEUqwie/YPnhIHyuxZGr26i562sfv5F4rFnREOff1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MQI2FZ7SCllXrAB9o9ocfufvbpLfoAeTy4KC44BaPA=;
 b=GAM/9DRSxWIMDLmQvoeEf9oT80+vznOD/MtqxqGwUYPkhQ8uzvEHnDd82Ci2SqtNXRxZ6VHOYKZVENppj9bYD0Qwqo+7erdfh3Xnz7FxKZ0c88ADH5wBCEOL3PkGIWH+7b0IBefPH9HFVgc0PCpZU1p2SromBv+KKG+lre2ZTvY=
Received: from CH2PR14CA0048.namprd14.prod.outlook.com (2603:10b6:610:56::28)
 by IA1PR12MB8239.namprd12.prod.outlook.com (2603:10b6:208:3f7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 18:42:18 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::1f) by CH2PR14CA0048.outlook.office365.com
 (2603:10b6:610:56::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 18:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 18:42:18 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Dec 2025 12:42:14 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdkfd: Export the cwsr_size and ctl_stack_size to
 userspace
Date: Fri, 5 Dec 2025 12:41:58 -0600
Message-ID: <20251205184158.2261400-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|IA1PR12MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: 566016ac-85b5-4f78-3784-08de342e048a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MPtWAV+kKSZJXRR8RE+VzMfWZcmzPofZBr9cJMkhygiIqolHZgHo1PdxoSmc?=
 =?us-ascii?Q?tMObU6ytJtBzM7bRS4/eiquJ4FOW8bEyYnDFWXxNRyl0aJmQ06SzPs2QbKV1?=
 =?us-ascii?Q?xbJqOScKeqCHCAeO/hyE3bDGpjkn9PbqrQxZ/yiVORyJMxqwr0c6Zukka4iK?=
 =?us-ascii?Q?iIGmatA1g7cmNg+31tqYZbJnjyFSUeaZ0vbk4LyFHozth8hSSyFqCWP6/ug/?=
 =?us-ascii?Q?I/2m0HSda4TLX6kmWvWOk3vK51zrs2foApD1cHnoDUjUo1/weFpHBTsOfG0l?=
 =?us-ascii?Q?01f2aNQVwc1lVWWheDt7+Rmp7TpU3uDJ/oWZvESu1Wo5oyv3KadrQbo3EPPw?=
 =?us-ascii?Q?0CM0tnMD3OQWn8sEMwcE2o+2eXAHFsUdmyvf9vlnRTenDMGgD3KbqLWLYOsA?=
 =?us-ascii?Q?B1ZiE07flwQF38Px+sKc6/LWB6hJ4JLUDQdGGjOwf+ekNFzTGN5+UfYgMdoI?=
 =?us-ascii?Q?ifMl3x5EeMChp2fUXiH5/OsuTnkDL8YYL5OQFHQkmO7DFv9Lw1UpFeHNl5SV?=
 =?us-ascii?Q?pDOkM6WBGb1JmD2RhdZrlc2LNgKm7Ub9VSaadX2d15VINkE0GBhZjO28b5kQ?=
 =?us-ascii?Q?0kd+LoGHQq0oE36tM+W/qcNRGBZ4rva9bzI3FJUkste3d4QPek7OsNjsefOl?=
 =?us-ascii?Q?0SPDwKtuRqKDjDupAVNPNceSm/0T7N0zBtrN93inpqwsP6pY0BsSFIFKc1fn?=
 =?us-ascii?Q?WvaQq2bZ3BGNDaqK8faRYK0NO14IAHnC5CQuG6CyY5gsfSAc2YC4XUD2lt7E?=
 =?us-ascii?Q?5ksOeKcJE0Naluwx6Jxg1ole5u5cUTFq0WXW+AVGFByz8ahvE1HxLVJ7dC8o?=
 =?us-ascii?Q?2q9ocSNSWeIw1tNiwYsBO4J1Z6VmrU5JARqUmpQBIG60Z7Wg13jyBWAj3wby?=
 =?us-ascii?Q?fHpeDODue/IWafpnedma4ooBHKVBkNisKKonL1HU984a9EeYX+SSsjwlDjf2?=
 =?us-ascii?Q?F/maUAGITLjBzm1hB5MoahfYKHtS7HSkdiXNf+IRq2zAgO8orPFnjUxiU2UY?=
 =?us-ascii?Q?3oaMcUbzgwGsk85j55S8BnXZqd+/xA6kS2krsmTPAFegBwNknz8XbKoLFxsc?=
 =?us-ascii?Q?oVayPzuNLa33fr/FKAUsZFxjE/1+w60tizjqOEttgvfXgp4mjCbrW9lOkCC8?=
 =?us-ascii?Q?4avUudCdSOnFWSBzXRsCJtXpCIzbjH3+rPNPasNXsTSHL+qcv8OOW2zE/fko?=
 =?us-ascii?Q?3K6jjs5yFcK1A/3C+58mZtq1EVIXuOzn6hCrzIdz/oLfIjarraHp09vSKIpm?=
 =?us-ascii?Q?GBEqhx28OZ199nBXa+lCHW/zaGxJMVLCrQXhdGYXJYKTGmwuOWV/lck+FUVm?=
 =?us-ascii?Q?PifGxv84KlYQFSijic20H7qSdlyfx0osUyrrmVMLJW4d1viKK1pQb3LQHWAx?=
 =?us-ascii?Q?yDIHNyJ09hm3YNqPbjFi7MoCPq7sjgm1g9i6irm+F4kng6fGTzWuN2VBnwg8?=
 =?us-ascii?Q?c4mycm4NiuGN1CXpONCeRMRe7GEXQW/BgodeEGnkfIC5rOzk1YKybm2DYlz6?=
 =?us-ascii?Q?WxotJZc0F+Vq3sdhWHgx8AjHamqsRZdz+RUGKDwI2zH8Xm230B3oJwtAmOh+?=
 =?us-ascii?Q?zJNGdRnlRew7xuM0uiQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 18:42:18.1890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566016ac-85b5-4f78-3784-08de342e048a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8239
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

This is important for userspace to avoid hardcoding VGPR size.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 9c3e8f946a3d..a0990dd2378c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -491,6 +491,10 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 			      dev->node_props.num_sdma_queues_per_engine);
 	sysfs_show_32bit_prop(buffer, offs, "num_cp_queues",
 			      dev->node_props.num_cp_queues);
+	sysfs_show_32bit_prop(buffer, offs, "cwsr_size",
+			      dev->node_props.cwsr_size);
+	sysfs_show_32bit_prop(buffer, offs, "ctl_stack_size",
+			      dev->node_props.ctl_stack_size);
 
 	if (dev->gpu) {
 		log_max_watch_addr =
-- 
2.51.2

