Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664BAC021AD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2025 06:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 070A310E8CA;
	Thu, 20 Feb 2025 06:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ikHbS2Mm";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75EEE10E8CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2025 06:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lVfAI8b2XKVPT5NGBLlYwDyxeRaiivHWS/0cqCzEyBPQlKiBCaaUlllNIyzZOhMC6AQqkdxZVbjXq4p2AQoSIBWmC7CCTaHDlJyCuJnYjgBOYVpY6Pl0FTLhuk9wlbbSY04aNCAaJ3YxtIJgTf5FECOTWU7w33a1H+FKJ4ouACEe57EwCDVkEs0MYgzHwb2EW79IqKpsc3D9xjIng4Cw/jFFXYvZZni0hRcpt2En2P9XxRx3VGFHv0l0rqxdKj/s6frhXVY+0AIBi9QhlnGDxyyaz/h/2fUZYnL6X0+o1GR9iOXzQ6HFeWVNC2wApCvmc4W6/G3wHn5G0PLoQjgt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1q/GCY8aHLRM+sjfjgHw1+owVZq9SL6ow7oB2fwQRo=;
 b=pm8WcMNLv18EhM4cKF+2GP29LWXTCysWYX2Nk95hh0aPn4394H0jIJXWPBU5uxTtSvGFyVRRJrUfJF2roeykD2o1A9yBVaj26oPmmdU6GJ7OYrIQVhbandrg3WgNcbCVwI3YrqMH9lgT6TK+gSLf4eqcuYanBR/WIR/iMz/itkhj2Z8mTHG5D8ivEeIXncOHnvtP+SbD9oVJ2w7i9d0G45mGKWWVgMTCGcOp5cL16pt7MhYjvkjWX1P7VZWg5jOuc16uEYQNhWBIZySGS9a3okoMXd23gOc3UFtaJwmro7T9UCAEiTcx86aW4j9FdPsnx+tBycCFBesl+zGEpvBB6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1q/GCY8aHLRM+sjfjgHw1+owVZq9SL6ow7oB2fwQRo=;
 b=ikHbS2Mm6VmWU9ztUwsSiJ/h/Hx9Re7j+bMXFWafM7RErQdjd4wGdwXktYwYcUggcZ37nTccgRgGVG+DjjFijLGsKEZWqpOt/lYlz/YStA9in7lPXa4n4a1667CKP2ifcGOSiHYk3Xg8ZRI/mDfNsLUW5NB/5zwMqqcZhjymTCY=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 06:25:27 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::ab) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 06:25:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 06:25:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 00:25:25 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 20 Feb 2025 00:25:24 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Skip update vmid in while update queue
Date: Thu, 20 Feb 2025 14:25:15 +0800
Message-ID: <20250220062515.2050499-3-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20250220062515.2050499-1-Emily.Deng@amd.com>
References: <20250220062515.2050499-1-Emily.Deng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|BY5PR12MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 33b727d5-8bfe-40bb-e20e-08dd51775d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r0dV8Zi0PZ1SrMK5pnaZTq1EuBgo30zlkfnyf3oxDPfuxWHuQ2A5XgtjuMF/?=
 =?us-ascii?Q?8iqvYyxaXHx9+Fl9za6++vxF+rz532JVgRuQeUfEhWjz/nBpksCqJSi6g72p?=
 =?us-ascii?Q?6j8lMEjCIY6gnUPEDNz/TULKi59633yiSOaPH6xNRmWw41qYFQj+y+VjISGh?=
 =?us-ascii?Q?TrY0efvHYbQLbRAljctwLxOUmKNA4Sh5fjMA+8OwmQ+2zK1Ias642/8v0+So?=
 =?us-ascii?Q?cDjAQTqudywJjCrqR+0ldMvrNnamOuaa371rnHbYtwnXcql1/VfA0DCklCaf?=
 =?us-ascii?Q?MBJw3dZVmaAGciKv6Mi79fC9IhCrmaC8nqeGqj87kWxYTC1t1+YoJ61U5OrJ?=
 =?us-ascii?Q?2YhKgk5xp5sVi5ZDBHg4mh2UksXCQWUzZxpMv0BRS/uSBSVtvOTtFYK6j9l7?=
 =?us-ascii?Q?FJ1ukH9TEDNnjEdX9JY12j2XZOsdoZUFIj5zpyV/3ZyUAV8+uUEqd6muyguY?=
 =?us-ascii?Q?wfUgtCyQgRUEquMtUgPNq1fSvhp96JvJrMsurqJWzzS9xVsoFYdjJE655UTt?=
 =?us-ascii?Q?qxa8V/QRyb0wISO0ObOs/QtNDBZQUGtbKOkeO6EdoI2hsF1QcN48KR4sGHp+?=
 =?us-ascii?Q?UL/5qeZN+0SkbZZR9qPLjqHSTDJPBn+DVm8fJSbq4EYqdn3RVt1mX4uVfmbs?=
 =?us-ascii?Q?w4iKn13hyBojU7kVjRjbzCKRQbBaTb6pRERsp/iztcX4HKJMxan781SLxbXh?=
 =?us-ascii?Q?9RHyvBhJhWZnFT85EVbwxQjSL9nzZpr9npWgjYn7LPr8MNq5is0LBBEo3FQV?=
 =?us-ascii?Q?vjyG97Wjk74Byd2bGds+LM8/rvktJK4C/MvMiFLGML2nxigtam2cd4hAP88y?=
 =?us-ascii?Q?1Bmu+K5ac7KILnGubF+GFevC4zma7svANPk+bCwlLcrhtiWoreMWX4/ZW1YJ?=
 =?us-ascii?Q?4x5u7mVArtfM5llU8RJqgBhOugWT+DEQCV7n2hrZXi4Op6Bg8SdYTC4/gKZY?=
 =?us-ascii?Q?+9wsLC6efKFu/SwzVQZhaj+0031sMg5iKm+Fj2Sc9x/YiUSdj8Ol8alaOFHj?=
 =?us-ascii?Q?NXGqSNOsLpwpwuoGTCNASkICvt5p9nVPS88p1oW//LY0qczlYdccq/Ay7HoK?=
 =?us-ascii?Q?xwAI4e0AHxL4OM02BvB2aI+JqRyWBJ1d2WvB4jbCO7erbn3dz9lk91RRO1Kb?=
 =?us-ascii?Q?StD/zaPpWAz6x9nwsXuJ4KJM86g8uToc59vhszvkW9DrVHepMVGM6t3VQRD/?=
 =?us-ascii?Q?w0XuCEA9Id/iebftwsjhYqU+vWQ5eabn3WoghHJAWnhgHFkGcHpPWsc1/KLc?=
 =?us-ascii?Q?B5fowYn5auTTC+Til/eIVkNXquhZr5qmqo0TBwHRtTNo4+9ED/w9pvhkRUZk?=
 =?us-ascii?Q?+kg4SSyfe+mjEYfU6F/IZucm+ESK8LYpPj1oVVRHkxoLPn+D20NQd01vN8eQ?=
 =?us-ascii?Q?lKuxnLBtPL+NsukFCBQmHj7pzNhdv9QfT5IuMgeNbZBY3UQpd1MJOWODn/lT?=
 =?us-ascii?Q?OS7NlDxKOge3dP80Xra7Rhlo6J5E7gXYfjL09jaqhqsr19oxpuSkBM1VPzvY?=
 =?us-ascii?Q?etj+LSjs1Bx+eVU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 06:25:26.4897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b727d5-8bfe-40bb-e20e-08dd51775d66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
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

Avoid updating the vmid to 0 during the queue update process, as this may
trigger a wptr poll address page fault when a ring doorbell is activated
 in doorbell_mode=1.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 6b38967d5631..3028c16264b2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -219,6 +219,8 @@ static void init_mqd(struct mqd_manager *mm, void **mqd,
 		m->cp_hqd_wg_state_offset = q->ctl_stack_size;
 	}
 
+	m->cp_hqd_vmid = q->vmid;
+
 	*mqd = m;
 	if (gart_addr)
 		*gart_addr = addr;
@@ -288,8 +290,6 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 
 	m->cp_hqd_iq_timer = 0;
 
-	m->cp_hqd_vmid = q->vmid;
-
 	if (q->format == KFD_QUEUE_FORMAT_AQL) {
 		m->cp_hqd_pq_control |= CP_HQD_PQ_CONTROL__NO_UPDATE_RPTR_MASK |
 				2 << CP_HQD_PQ_CONTROL__SLOT_BASED_WPTR__SHIFT |
-- 
2.36.1

