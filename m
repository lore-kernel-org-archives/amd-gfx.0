Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC465C87FCC
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 02:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC3210E40E;
	Fri, 25 Jul 2025 02:43:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hx+fio0H";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04AF10E40F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 02:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDOnBXkZ0fQ6YP5j/DwwKuoc+DN4ndVcNlqtiLGLifx9F/2QuLf3QSHidzyD/sSYQw7X09qmDwELol9+007e50YoQhZkGkAtCTh9qv+AuWOU/YZId5MvEgTvsJR1oBOdzmxJ/88RryTKqzCULuRqczAIwqrKmZxAFStimsQGibYgCcpA5pXNm/OVjsOyZZ90N/H26vVTHyfmweh4mGnxJbVFKYtPt6W9nxhf7pmtXAcSD02nih8Amnq8ZpVqCsobeTiiDZ+1jUUui64sAym4RmHc+UE3Won7nho81b4XpXB05pUirxgypm/67AgpuaJH3+JQVcqwow1phaPXMQxM3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkHWgQ3Csg01FvvpoyGJlpraNi5FPuGOWOzNP73kAq8=;
 b=F9xvZiFFyO0VRWf/jgB5ZXAwLd23M00XYX56z+Hxvduc2ea1NAowWIZcnJ07RvFxs+Mx3Y/XDLNW9UYGllEt800UgH10anZd7Jceai24XnLlaqCAlBuC3qBotIyoD5vVFEbeXloi6JSN7eFeWX3EK+CZOJ0aTIIfe3uP+RKIMepRQk6vW0gSUq2hEk5FYNsaQ0497snHlqRoy2vf8xP9M2yFo3rRZ+oYjfJZLcnQrbO0qdV5oP23MtyJcwS/feT4K8MSPJJ777xXiYrdFsREragm/0gMs1fOy/bIfsVaY4+XxnYVaHqbdNqC++5iG6Hfp44jd1rPxitarGlGEhE09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkHWgQ3Csg01FvvpoyGJlpraNi5FPuGOWOzNP73kAq8=;
 b=hx+fio0HQCFi9W0Za1CJfU2RizFV49Ea/jpyAoAbF14hIEu9Ic00XbQsVZBHbZmXzxMcnnfcKSexpy8rMqqo0y+1S/JbCPFtCJiRVUvPRYCU7zp4Tx8CvEKBDsCDr1x6CXu3CJBL+F/Qm/rBZ3GqUd+7GRIPi+mC1QgsuF69rYs=
Received: from CH0PR03CA0105.namprd03.prod.outlook.com (2603:10b6:610:cd::20)
 by LV8PR12MB9261.namprd12.prod.outlook.com (2603:10b6:408:1ed::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 25 Jul
 2025 02:43:43 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::e3) by CH0PR03CA0105.outlook.office365.com
 (2603:10b6:610:cd::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 02:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 02:43:43 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 21:43:41 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <alexander.deucher@amd.com>, <felix.kuehling@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH 7/9] amdkfd: process USERPTR allocation only on the primary
 kfd process
Date: Fri, 25 Jul 2025 10:43:14 +0800
Message-ID: <20250725024316.9273-8-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250725024316.9273-1-lingshan.zhu@amd.com>
References: <20250725024316.9273-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|LV8PR12MB9261:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe2a26e-4794-41cd-eadc-08ddcb251255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eBV4fxsIyQ/6Syue3xj6xUIC+O08uAn/B/9ov50yEvSkG5FQ4rG0gQ7FadW0?=
 =?us-ascii?Q?WM3bxjQ/HP8alAVIz374SAPDOJherzdR9VjalLTbpHd5O2evqGAJycwtkKU3?=
 =?us-ascii?Q?XIBjGKphhEsOoVVrQfrJj/woEHrTimtymoXNHq9db3duALgtwFMLoph0ksJ9?=
 =?us-ascii?Q?eN+bI0c02aFsRcZwLttp6nx0E+Kz4MgkFfF8dFtx16wvnuvDPJA4vZ6RmwYE?=
 =?us-ascii?Q?DL1H34wVRtha+Su8odzkEGcTuI4xvoUQ6Go43qJB5t3NujrP0M9JTywWtoTh?=
 =?us-ascii?Q?pz91fn0NgH4pgXRP0Ss8AorJSkhosnDtXhfoBmnKQN7jbEeIM892+NGtAgaZ?=
 =?us-ascii?Q?sUhPXtbxkd89U3Qsx+gX++kVnAbTXAPXPeAJi36XDJRSweqcb6cGH86X1+v4?=
 =?us-ascii?Q?fxtzU1B1ZNgYsZe67oOf3ElTa2Nre6c9gntDu9b/2ad4lzspvD5OSibXfB44?=
 =?us-ascii?Q?VRZAGHXpMPzbgJXTQ2pycyu82M2Vz0ZOGk+wOk67vIc3x7C/F2lM4yqT87sp?=
 =?us-ascii?Q?afd0fpSk3Hr8Fr6fhIfeHmtSJe9JWlkhEUgY4r0xIPHIoO6awClnk+XxZpQ+?=
 =?us-ascii?Q?lL2YuBFAyPT/gRFLC0b1Aj1hCTwXLjtaBZofP+S/QxvFAdIRYhnECrJD/6lM?=
 =?us-ascii?Q?qMzRiiCo+uvYLrDYkqe8ywR/QUqKmOmkh64tQgMGY3PWG+z1wviSzy7Q8wt4?=
 =?us-ascii?Q?vHNxE8/PBDRdJXCBq6op8rftb87URHT85vN8EwP25YucFzCZTUj/XlzBhLZI?=
 =?us-ascii?Q?aWyNFx2MDOcwfuyjmcUYNWu7Mtrwz4MvfKdkPOUIDgDJkFUpaNttThJXoJqO?=
 =?us-ascii?Q?IoTgSvLs5gFJtHgeJJq0v8CWvShE+cS1uDtkspUWL2NPT6ec4KlPCIZIJ5bG?=
 =?us-ascii?Q?R10/x3tHfJvyqPbJYmWnDY4ziFFqjePTXLoajHaQgzHuXs0uIc2zfc8mQWyo?=
 =?us-ascii?Q?0dJaonHw1fCDChxKk5Yey8Cg1opn8XDWJP3UxbYdEciOXSB/rf7Mo0ETp2FK?=
 =?us-ascii?Q?qqBPu1DzUZ1o6FAn+U1LwLD4X6BKLc2wnuzFVhWXjRpwriwbrt7hSzjXo/V/?=
 =?us-ascii?Q?eheSaQ6EN92iyR6h0gYaRqNkehlFaRyzeSgE28mX2fy4t7wx9bixI42s0Cq0?=
 =?us-ascii?Q?VjRR4WgqcQur+3GRLJoguP1W0SR20waSKBTDUUxjKAb6jrV6lbqyn7ycDVup?=
 =?us-ascii?Q?JIZiLQceZmbXbxBgKEN83OqWjs28P9Fmq5nPMpGN+sbcDOlD9EUE+/honKmT?=
 =?us-ascii?Q?wZfUtrP80jMdOc+DBrwV3NLFd02dljN+cy9bdPYZh4J6UvOKhu7cNnqx8keB?=
 =?us-ascii?Q?FaoZpD4z0XVqGEZGsSHcPEkUnIpb9olo3F2SHaNKw7v4nijxcMGJ40PM2GFd?=
 =?us-ascii?Q?xqDCezT5gYTDt7bDBGGe9wW9TolC3+cYOPpBLbd9rthmL++SxgwAeF1yk6V1?=
 =?us-ascii?Q?xzciKRtopG82Yf7IpKGDEyTKd+nhaYJKiSAcoIwMJRvRRjH6ywZjN7ft8FZq?=
 =?us-ascii?Q?+nwSivCmOa2k3PyNhS7qP/Uf3KKVAf7dRaDH?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 02:43:43.7774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe2a26e-4794-41cd-eadc-08ddcb251255
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9261
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

The lifecycle of the primary kfd process is tied to
the user space program, all secondary kfd process
would be destroyed when fd close. Thus only the primary
kfd process should process USERPTR memory allocation.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b1ab1565a4cd..5b22e1c47b2e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1069,6 +1069,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 	if (args->size == 0)
 		return -EINVAL;
 
+	if (!p->primary && (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)) {
+		pr_debug("USERPTR is not supported on non-primary kfd_process\n");
+
+		return -EOPNOTSUPP;
+	}
+
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 	/* Flush pending deferred work to avoid racing with deferred actions
 	 * from previous memory map changes (e.g. munmap).
-- 
2.47.1

