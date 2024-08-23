Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A835C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 04:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07C5910E2D7;
	Fri, 23 Aug 2024 04:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a2xhGy1l";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62CC10E2D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 04:37:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT6ZrvQeMxFlKMbyRW8tFcd6SBAoo3HB+WsBMvJOTys6z1ClcNXoabMNW+B5Nx/kYwWCnE1GvCAcYkIflhN6lRdrAeXgF6f0cgZqMGwomWLEJ3kgOcI8jYqcfEz0oLjcCT9lVCmLaHT7WND8XsC9aQqcz63o3Kv5ctDfW/pZBcJWjbF9IsFPp3a/ZmTpLnf0eheoZ6NAoeWkbwmnbab8xKzqDzBzP1eUKjHtBHvhMl+2RKENks2OqTTg8Dr289v6Y4EP096vZFwdrq1MKkg9MtMJBjdcVDHf7FBNomAln/BJRsUCyD8bnK6H/sEVztjVlmYSGUsgX3hfDIPnvXtnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMZNuUJNUpKH5M+BR4FrGRz8RJcyRHG/301dd8kRNJE=;
 b=DJzqVFpq0UUdvGCWGKSVJXBWTpesGOhnn0egtRQXPmYq4Masax+voBg7Azptz2TzLNpDOZTQBbMj8TbEuhGuti2Tr20w3XBKk3UxcSGtbS73LgGKxbucM+kPptZW7JuHeX941vG+LSjipgxZ8H0RIvn/AtLk3v+KYli3eMS0Rn8ZIIyVnjwb3/O6VUQjHNA2Pi8bqylKZ0hGNxan+0lNbsKV9RJ0bT+y2cGqtS1vqApaB6qObYkTWqk916ktbU5qwJFckQLfI6GtQeSRHLO/YjRT/EmpjVs1aYLOUeqQUV4zVPaQNukGTuzur1YGxG0QmyKQz0ZyJUkWzR+8yFBCvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMZNuUJNUpKH5M+BR4FrGRz8RJcyRHG/301dd8kRNJE=;
 b=a2xhGy1lz/qoJMt9E11ISXEVafkMsUxQySSChwcfA4lLM88RtfCsxOhV2PJdLhHM3Pt4EmF9tg0lfyI6InnSqBVHNrwGr4zhYrW74UN2jC9xljktQIjVak2050hKEYYBJsnKVCWvCH0G0/jhQIYGCzND5RL+eMqE2spzM+SeUsM=
Received: from SA0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:806:130::11)
 by MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Fri, 23 Aug
 2024 04:37:06 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::b4) by SA0PR13CA0006.outlook.office365.com
 (2603:10b6:806:130::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 04:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 04:37:05 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 23:36:22 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 0/1] DC Patches August 23, 2024
Date: Fri, 23 Aug 2024 00:35:42 -0400
Message-ID: <20240823043543.1939766-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MN2PR12MB4390:EE_
X-MS-Office365-Filtering-Correlation-Id: 9230329c-87cb-4a27-6473-08dcc32d3dce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ctvaBKQI32tWzv/WQDWSFpfxLOr84IYmuiMZjBnaIQVHdQ12biH/FfN+4AZc?=
 =?us-ascii?Q?aiJRWSGO6cpBBNEjNK+ePsHNsyGI7eq6cL9MOc8QDUQs2Y67C4YZAEjoEN/H?=
 =?us-ascii?Q?XGaP/OJhfyVqurlRiIme6XoE3YrEtxB+svKFRqY4oY6nsYKG1/xEmmTqT1vS?=
 =?us-ascii?Q?VOa41nrk0TTs4c3rNWL2kCc2cgWUiasZlfUxLhUDWXdhHKjD0v4KMxgaou0q?=
 =?us-ascii?Q?IgJC3rQ5386ZuCgGf+hgkAVJ64kBwckNJIbAapK18U3rzMD+QO+Fj4cVGty1?=
 =?us-ascii?Q?9NdC5m6fiphL0IcL5r86pEnuN7C+r+aOKs0bp/fh7X5wkftR+kY9mkfamU+f?=
 =?us-ascii?Q?0Oyyo0KCpOoXn83ckpcuS0xc2pzIUfFTPs/U3rKEQuCQkm20kyAesBi105+v?=
 =?us-ascii?Q?JogYPslsPmCXeH1wrasY18SNmLkmKMPY7Q/hGz+BeINLZ+uWw6+YnzH9jcHK?=
 =?us-ascii?Q?jUKKdI4shltpZgAfFYtoGzMYCpe3XoEecIPTCq1Qwwjhy54VO3o5xHSjKZ+T?=
 =?us-ascii?Q?cGP7I77HJtkkQTaXYYS6YKq457GAVq+MjZbbPSIxTJAwhrb8WI0SJHCap+8e?=
 =?us-ascii?Q?OE2shk6/seytRxbj2gu5bXhgKibFEFMfLhE40UudPqt4GOW6pAW2VeEtW9PW?=
 =?us-ascii?Q?qyv7XZqw93uzETXLBNhqvzvyU+Q/ij3pPxtJVQIOC4PZ82c6eKlJTHDZzHm9?=
 =?us-ascii?Q?pNW9tBQ6vlf0dN/JAcS1DZmca+ysyaCCg/xLx4+ary6ZUr3WmfDxf2vRUUS/?=
 =?us-ascii?Q?438oFle6OhaHVIn7dm+g4Q0V8wPzn4E3qZLKp/E1V40xHSSs12ZFzaWdhF6+?=
 =?us-ascii?Q?jk0IWLuNnuDlb0q/5c+NbcYXDGl9F6zUHCiU0VjGDCBdUpjzsChniOWc0Qse?=
 =?us-ascii?Q?Mv5NiaKkQb9Gt+OIQGip4oUA2FkSfJzDM/sKdXjjjYLfG1Af99KoKRSwLFCj?=
 =?us-ascii?Q?DEoUwrlj7jsANggQLBtkErhQJONk8hPX7M+PN5JvLwWyL23Ci2JYp3xNWdmu?=
 =?us-ascii?Q?m/SG05FJV2BfZkbuCr8DUZnhCtco9Ks9DUulFsbYHH1vMas+Sv5wZbkZi8t7?=
 =?us-ascii?Q?a8Y/U7vlrsAecVS4eqiHcTDWlTVRDNa15hLy8wYNc7cJABqEGUJAGbaFk3nD?=
 =?us-ascii?Q?X9J0qj6rrTRbEaLca2qq1pLjCa8a5eiqTxDrLpXJnojxDHX5sMilfJoEs5BR?=
 =?us-ascii?Q?o1UIkSmDWXklNaE81abtOizAWaIUTcFjH7z841btG9/9gMWau8eoKr0RLPpm?=
 =?us-ascii?Q?e8A3GIBT9zREt2OzMkyoluO3H1sBwnaZFzL/7PoKAyY9BLI/3klsxlyfR5qm?=
 =?us-ascii?Q?95U3LRrS/RjLOw2/Qjc4Y8tLzMleGFJ12SF6qBck+Xu2x6D+qrVqYP38q2Xx?=
 =?us-ascii?Q?K+jwnfQW4qwTqbOHDmrx3Z7xcy45XwvlgratHsl2UGxr/HVgJy47hr5ty4fe?=
 =?us-ascii?Q?fHRtgxerhDPSk79mxXx4Mzyt/Nel9m+Y?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 04:37:05.6242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9230329c-87cb-4a27-6473-08dcc32d3dce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4390
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

One last patch to add to this weeks promotion series to align upstream
with amd-dal.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Zaeem Mohamed (1):
  drm/amdgpu/display: remove unecessary TODO spl_os_types.h

 drivers/gpu/drm/amd/display/dc/spl/spl_os_types.h | 1 -
 1 file changed, 1 deletion(-)

-- 
2.34.1

