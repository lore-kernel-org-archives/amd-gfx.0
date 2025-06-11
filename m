Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87115C677C4
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 14:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2269B10E69F;
	Wed, 11 Jun 2025 14:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xABPjjOx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D65610E69F
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 14:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WibAvfwGECmfAn0DCD6SkKg56ZpqV9g3P3FONvW/Z5BSe1SFCW+B+9CFrmOGOh1t0dH4LqVFryPJcfhhlE3sxY+5G3oEx8BlivlIkhiygVw6gfn+HanxGV47UyG6IzCEuiUUvLpRuhN+M0gRMuy1kVKI7pwr5kXfXJGXrOAvg9i3z9QoemPQ5YqhYL+dkbr28Hje4Lw0VStWO4tHcF9rBVdbOLCh3JK+EOIMmMw2KA+eCaw1KZREZjgp6JWT554fqqX5RydIsRB+Cg0l50T5X6AVqvnFqm9ap7OPB8+F+UWUsR3f763zAlOGzsEtLelzuDn/xnoadQ6GAa9d0KISQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6TX32RTDTNgRuk6rg1APfbL8qSfTzxe/dE01LmUplQ=;
 b=oZcNId3yMogva4r/KqZaHizors1rFMlDA9pYH6uKJAACt3G/3HE1mpnv66uu5cYAduW2+L7rq93V2Ios6Mko5uM+eXuYYbHNfBRYvNaSQtI/tvREOEOLzt72gmyBI/oZ/p68fhcS56fftDcOmOJcxgmR2fOowqHuGmrwUnLBQmoM6v2Do9nXtpUWMap1nGavyPT538UdogBq60qZsU6FPsDhjFW4frOFFyWEmSlxDoq2SMpozoiGgPlJNl5TLtDqv2EwCy5Nd2ChxEZ+apGjqYC34o8lt0P11VFZFYfLWeRu4g/skP4A0kNmPLT6lUzCfQj9xTQUWFrOC+gxURsx5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6TX32RTDTNgRuk6rg1APfbL8qSfTzxe/dE01LmUplQ=;
 b=xABPjjOxOXeQC1MiI8b2WzdLYXW6j3l+MJIxu7ov2+5cNb98Yl88Igss07kFl+yQ1tfMzaqi+/DX1Z64SVnpDI9Lv2le9pXwtoav+MMNKEvdtw+sxFYmyBGRB+LQf1tOrp0+QPaeBfNCnMRplEugZfikv0cDvJ/ZXHBaoZMF5gQ=
Received: from MW4PR03CA0175.namprd03.prod.outlook.com (2603:10b6:303:8d::30)
 by LV5PR12MB9825.namprd12.prod.outlook.com (2603:10b6:408:2ff::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Wed, 11 Jun
 2025 14:58:19 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:8d:cafe::ef) by MW4PR03CA0175.outlook.office365.com
 (2603:10b6:303:8d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Wed,
 11 Jun 2025 14:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 14:58:18 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 09:58:17 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>
Subject: [PATCH] drm/amdkfd: Fix race in GWS queue scheduling
Date: Wed, 11 Jun 2025 09:58:06 -0500
Message-ID: <20250611145806.3919952-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|LV5PR12MB9825:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ac84f1-c20c-4319-9a0a-08dda8f866bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+48ifNiBsGQB4pVrapR566/t/DzssJgFUTVmOYktSAp0MKK3hyiJRB1NGmIt?=
 =?us-ascii?Q?X5n2QHdGhEIhK7OhohQKrLL82bmRzstgjNCp0qJGnuwv+yNRbS3BQowIfY65?=
 =?us-ascii?Q?nQRk5R3COgvVNCmAimjwgX7KStWE+YN3Zz/ZtgqXyKBgtoN9wauVcJXQsl/g?=
 =?us-ascii?Q?jnqC95Rz2kKDS6g2DszLTeoaRjd5/mrNPv58U1AQMW2xgk0v2Clnp6gq0k22?=
 =?us-ascii?Q?C1lPg6pncA+JzEDQAFHS9s1tm+07FQ63kLID78F870mnOjGe+rwqkwSWddBx?=
 =?us-ascii?Q?nU9KuruHB4ySwsPvjdsuoomUzvhsk7Ddxc2CiEzWluho/iLfp/73A3FW1P0n?=
 =?us-ascii?Q?4+kWm1qhkwJ5BptLEQCodN/zNDTe3is4ybKlJGnRqfBH14NFCe8b/pboawDG?=
 =?us-ascii?Q?fd7ckqWrCBOH7iMHLxmlJisOakaxaI00/uUBNBophbexgGXa2IK9t7DnRKzM?=
 =?us-ascii?Q?u+cEu2lHglaXVvDG1Kevm+aILXcRw5IZuTBRu7jDhe5dVmfny3V2W8EM6h7U?=
 =?us-ascii?Q?siWFT/dOylW8gU8+tcVC8xro4LogA4XgfDswKLeyBWfyHJCuVmx7TEOoI5zl?=
 =?us-ascii?Q?6bzrJs11sztQ+oTrtOh47ogkqNB/VSuNxcQNvCx8kejbhO8P9IYBudSKU1rX?=
 =?us-ascii?Q?P0kcaooLWr3ttMCcv18qCZfjozfPSe1ZVCxezwWskGbuogs/4u+JnTFjygqK?=
 =?us-ascii?Q?gzKqShjQiMEvSRfFCCrRpMIXuLy7oYRqrRTbzDIzmJYiFQt5zeGGAFSFyciR?=
 =?us-ascii?Q?R3e1zh7lYfwuJYKt5fPYjNoXVtM0AWnGfPvQd4cXMOD3N98U+UONedL6PPYK?=
 =?us-ascii?Q?342o+IRzdH4FGsY7k4FnvlVWJhSKKig83lZ5bUqBsbO8tM5Sgama/AsKew91?=
 =?us-ascii?Q?dxINdji6IpWj8yM9MOu3B3nbpSEa9uDKmlA9f7syw4nzjoZBkcCJd6HKgctf?=
 =?us-ascii?Q?jCSTUqxLaq8eW+PkG2P+H1nlintTWSCXv26nvCrDdsUgtepPUf5p+T33VjnN?=
 =?us-ascii?Q?URG1DB935Y7WJYmyhI6MY8Ir0CgBTz2QFm/zq3T6D/HzydYS+U5b8yHbkhkQ?=
 =?us-ascii?Q?3bDzpwZxCT18O23IDH9D3VrLiKhF2EUlzADzERUktq7sGaL9aVfxogiv1smp?=
 =?us-ascii?Q?m3s2v8SAl05cb7fGKyvYy33vZHHXnPuWvRO+o3HNY56RYCpVAH/SX4sygad4?=
 =?us-ascii?Q?rVrWwPN98xyM8WUXOD6M6cL82ThJzB6ITuP9wRKC58Ng09Dr2wW2IDZZhwAq?=
 =?us-ascii?Q?SY2JzxRa8PhllxDJWM2cT7KnNaTvP74fxLMXz27vn209sMFC4XOzBwD8qSI/?=
 =?us-ascii?Q?56ztwtWSUnXqSpwf1KzmFxGnq37Sp3VHWQMPKGZbx/3ywqjVVkQ14PtPPgEe?=
 =?us-ascii?Q?o861AtpexnMJnH6UZKvLoluujnyMxKzBiVd1/eknutHnmnTbJWEuqB8r4iVm?=
 =?us-ascii?Q?9UXJK4tCW8uuSXxP7/XQyIr74W0H/6/gBsStpzI/E9/ZeDMtufpZ9TlHeZ6w?=
 =?us-ascii?Q?2pi/JO5fpnTAun6Nnh//+nV7c/6VTsuf/XLG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:58:18.3935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ac84f1-c20c-4319-9a0a-08dda8f866bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9825
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

q->gws is not updated atomically with qpd->mapped_gws_queue. If a
runlist is created between pqm_set_gws and update_queue it will
contain a queue which uses GWS in a process with no GWS allocated.
This will result in a scheduler hang.

Use q->properties.is_gws which is changed while holding the DQM lock.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 8fa6489b6f5d..505036968a77 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -240,7 +240,7 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 
 	packet->bitfields2.engine_sel =
 		engine_sel__mes_map_queues__compute_vi;
-	packet->bitfields2.gws_control_queue = q->gws ? 1 : 0;
+	packet->bitfields2.gws_control_queue = q->properties.is_gws ? 1 : 0;
 	packet->bitfields2.extended_engine_sel =
 		extended_engine_sel__mes_map_queues__legacy_engine_sel;
 	packet->bitfields2.queue_type =
-- 
2.34.1

