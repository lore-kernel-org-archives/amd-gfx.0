Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34FCC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 08:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DA2810E68E;
	Thu,  8 Aug 2024 08:44:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IKgBNbTc";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7759B10E68E
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 08:44:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nlc+joUIWaTQHcHbV02QA2WTTgmbidJCYQxEwGhPUxOhhAsT8VApn7dWo2HsOpqdM+E0wwCRQEwqgfjq6NFrI6IH+C4okVscSLK+EzVdrvqb+H0fJX+DdWi5+nM+lJ3oaxtrJST9PZu/H4u9ZYdf7DLo4mgGx3OGZiECaXr3dwf5AEY/33qFAfyrxUxrrcyGiPK2pmUObC8MjYxivxUVLcip3vIfU1E4kJqxHltRmYEMGLzWP9o8M5c1OrhJnn8PTvg6B3kRjKU3hW7B/AuLfBpcS1kXcZ+QSclVWJnm/mUs8gQR0mTSLkBRhtinUwBjPmhcfykAPbyHf94t0C/NVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rABaWphNzmvTeOaRTYXegtOAI5Vo2ThNZCS36qBaI08=;
 b=Sl1d2ydQt6Ggsy8dKMGELIUtzyWootUm0aLuQlkU1csUacVHolkoweV5CW2kRc41dNkRAqgqh+gffIHdUNixQwewFskFOeDMnQcVbDaqKOq0b5jZWcm90RfviIkJDggTihvnM7GPHARAYSHl96T/j+a9xCzBRb8PMH1cbxY1BFKgkkedrm3II9jUN2rM1Wd4ldsKWwigIyqTZ5bc/XD1zcllclgLWCruTkBFxponRU7/6aZbBTAgspQ/kZiXuisybEZ8/vf1Agb2YZk7hNck0KqLIITugMc7EG8jcc5LgiPlke1KvHC1WSTHRyP7lNlvF/aGgNV5UXgwBuFOxJWt2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rABaWphNzmvTeOaRTYXegtOAI5Vo2ThNZCS36qBaI08=;
 b=IKgBNbTcK6I0rMc+MkTMi4sqrFbnvNN0tjLUNiL5m3qi4e11JqVZxIdEdBXGlGAeRzdL6BQbU0rQ+AGwCc47DPAA2S7eU5RqSln5sjLtRFDUcUGmUOHZZxQykp8CPzas9vJESUkLc82BqV/+afNW1rE+VQWo11bozyXqIRkdFlM=
Received: from DS7PR03CA0239.namprd03.prod.outlook.com (2603:10b6:5:3ba::34)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Thu, 8 Aug
 2024 08:44:51 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::e6) by DS7PR03CA0239.outlook.office365.com
 (2603:10b6:5:3ba::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29 via Frontend
 Transport; Thu, 8 Aug 2024 08:44:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 08:44:51 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Aug
 2024 03:44:49 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Philip.Yang@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: keep create queue success if cwsr save area
 doesn't match
Date: Thu, 8 Aug 2024 16:44:21 +0800
Message-ID: <20240808084421.2755417-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc39077-d865-4d31-5a94-08dcb7865e1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PcdGv7vO0jl7IngGpvX1OCwudK1BMfNKq7mxNCOMN3rZmeD0FepOmFGfHM3i?=
 =?us-ascii?Q?S7PAxitgR5ugRJJZnfLZu+G2tp/pYueuJUBMAk7lVl6THqosn65qKFbGGqkc?=
 =?us-ascii?Q?9KUmxi3yYhMszp3qjFLOuSATbZIV7GGEhmmxhZ+EfaL7cmAWP4gAi9jhZJnN?=
 =?us-ascii?Q?lkcV/twvVK4FZbCj/rCk48NM3u78fwIQh7bw9syHyDatNsZhFGiRTFJ9CgID?=
 =?us-ascii?Q?RqEIYjz9EOI5nIChRpGQxaeMwCDY2Ie4IPsrDjKXNwFfh2XzenMEMRaPgDIb?=
 =?us-ascii?Q?twwWJXjgBVufiCLsTr8r2k3dcNenKIQisqpAWxgjsEdULKjHnG1Dz8eBNFKo?=
 =?us-ascii?Q?tzH2gOr7vAA06SqNdsl/3KPza5aThiadjFU6CEd51PlmfWkJP4YwzPhORUg6?=
 =?us-ascii?Q?PRJUHl5qm4SfJhFIX/+3TCDLUCrglwhBcITCR4iVAA+yR16sxvwc3bUdF/sA?=
 =?us-ascii?Q?LJr7P3XuspTTuvPruxAdk8LeiQedN/NYw3xE6QnrvWhLkoXpr2K+ERbqVzD1?=
 =?us-ascii?Q?YceFi5/pfawCO8Vl+gK3YIyzqNshqQ8Mg0DMOwGeaV5aFdse9amiYyZtrFU4?=
 =?us-ascii?Q?LX5A7n7wNlP8Wn57jIE5QzrAFJ8uSCRF/gJG07VJv0uOwSuJBqgrjDNh+wit?=
 =?us-ascii?Q?xVmBM/bwniGda/PFPagnlk/ylDZJtMHHgeJdDrpsh4NKoo45UPq6EjHYQ+ZO?=
 =?us-ascii?Q?4OOsqnD2XZdXMZKcNXh1TjGG4ZIwvAQIEYLE9FhWttJjnbE/qnRR2rr7yB85?=
 =?us-ascii?Q?6nepUuB41jBN399EkI+ZjZhACEXa6IWNLVTT3w/xK7OwdFJlKe+n4IIKlRaW?=
 =?us-ascii?Q?G63ZYQ9h4POBL1uxKxpmeQusP7HxEH9UH2EHFcOhwqU+h9ed4DStM8Uag/iZ?=
 =?us-ascii?Q?WDY8pj9Yns1rhxNcvxhsW6y3+fKRKXr4DHEPZRNUenZhxod0KiGnT6Ik4sN7?=
 =?us-ascii?Q?13Ov0ByJHmGTuR40EL99TthSBE6ewq5Fe0vFHDHmfaEDcqxRRynKWBhFcYQe?=
 =?us-ascii?Q?XEvqNX5V5xOWnVw8jyJxPz+Q2B9Q9FI62NAkXwkM3xMqzeVR7lsHZTCLuf+P?=
 =?us-ascii?Q?eOqfDnkcjZhUw/Ik/lS7VqzoAr6nQg1JoiaOx0KqF06nwIiQmJWWi1wqTIW8?=
 =?us-ascii?Q?YP9GTBLZGaXd1pLiGmzsH5eI3Cqnzwh3mygrBoqDjWcBitxKeBPisDG4S5ME?=
 =?us-ascii?Q?es/A3We8mYXsxYqH+/rS4Owl/Yy/yzLOd/NPMKpIyNG7AVGEwYEo/eDHZt7+?=
 =?us-ascii?Q?5OCxfq9Z2MFF98mT/ZIK/VgIB1mtsKyYE9DSlCf/se3n1FLq7RJdWmhSalBY?=
 =?us-ascii?Q?BSjtCN7VHX1tHiiEmAI/7v7USzUlPodJyirp3Nbc2a4aDC+IUO8bJ1GBklvj?=
 =?us-ascii?Q?KyfaFFMcK/RJS6nju9fcjK0gLqpqCB00+zQ4TzF2QuQcY9Wru+Khws6rId+c?=
 =?us-ascii?Q?QU/Hi6Ue+0d+9yp9GrSIu8z4Z8dl9CVo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 08:44:51.1091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc39077-d865-4d31-5a94-08dcb7865e1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
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

If HSA_OVERRIDE_GFX_VERSION is used in ROCm workload, user space
and kernel use different spec to calculate cwsr save area, current
check may fail create queue ioctl. Change error to warn to make
create queue succeed in that case.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index e0a073ae4a49..9f283aff057a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -295,11 +295,9 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	}
 
 	if (properties->ctx_save_restore_area_size != topo_dev->node_props.cwsr_size) {
-		pr_debug("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
+		pr_warn("queue cwsr size 0x%x not equal to node cwsr size 0x%x\n",
 			properties->ctx_save_restore_area_size,
 			topo_dev->node_props.cwsr_size);
-		err = -EINVAL;
-		goto out_err_unreserve;
 	}
 
 	total_cwsr_size = (topo_dev->node_props.cwsr_size + topo_dev->node_props.debug_memory_size)
-- 
2.37.3

