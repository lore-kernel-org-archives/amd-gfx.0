Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8950FC282D0
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2025 16:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2044210ECFF;
	Fri, 28 Feb 2025 16:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ukAVapcc";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8646D10ECFF
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Feb 2025 16:40:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC2XVIWVKbOsjRi6Rv1rUSxTDWF+e7FwLpdN8ZrYeDyhB37vQVKtEsr0o9c2o5QxcVxhtXeTX4tlAShFMF2NRvRgxTY0xSrNRAhNJxWZizPIIg2XXoHG4oSX23OEsgIZIADKbdMIcwrkahlW4pI3d7Mg0ZlNUM2nieNeNd9l5FHp5J92y/2amTowugMWIGN9CYyeTL/Osc0QcpLtiBlIEvEWb1y/XHs5xXrE3Rf7sIoTb58UYNk9phvXuNvc2fxZHdbLW7SWS/oYBOaRRvVRSHRydxZ/gkCsLHhEAFtn59YNTTAeVjwMaszgWtJjkfl+HYWszdW19MP4WVhKcS1iGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WgCjVQ/4CvbkBm7kfB0UgkelS5A3FcGSEVNqc2bvkg=;
 b=PZtjeZuHxzj5rYUC+a5zjucBmANc06dibtqxJJnz8LUQSEVb7g/i/j0LJCzAauE+LyTLqCpqQruvK8Ww8KAyNCdBtQGmTYDwTys/3LSnpl8YDMiq5WAvIoIdmAoE3495+cJcr9sUeU1WWJkhOZcZngTt6wdHeMwrovMOHG+H7N696PB0W5dZ5rjujg61SJEaH5Ngr1sny9TlaMcAomPGprzYrPgqfUOrs5d+W7HyUs0MLVSVUt+QhkapoFw04JNIdPj8t7zet5kXXrR35TH/vk6ZH87XWcRsmjMvloI5WbfUaUT90pJvsyjMm8msOZxTbMoGB+E7niinC0JyjHClEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WgCjVQ/4CvbkBm7kfB0UgkelS5A3FcGSEVNqc2bvkg=;
 b=ukAVapccyCgC7TNY9NfbQH2tdxspfZcRfQQyNW1O8Tue9E+l+E/OYi+MUwD53YHWqG4m9sHMMc/r6UdY/HSW3itgM+VG9oCoXOCos9W7EZyxGagF5IeGD2Jf30D2LArTxJtIvjCDQ9y12ZXJ5Pbgm3KAj3KdQWIvwpcCe88C/Jg=
Received: from BYAPR05CA0080.namprd05.prod.outlook.com (2603:10b6:a03:e0::21)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Fri, 28 Feb 2025 16:40:06 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::86) by BYAPR05CA0080.outlook.office365.com
 (2603:10b6:a03:e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Fri,
 28 Feb 2025 16:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 16:40:05 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 28 Feb 2025 10:40:04 -0600
From: Andrew Martin <Andrew.Martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <philip.yang@amd.com>, Andrew Martin <Andrew.Martin@amd.com>
Subject: [PATCH]     drm/amdkfd: Fix NULL Pointer Dereference in KFD queue
Date: Fri, 28 Feb 2025 11:39:49 -0500
Message-ID: <20250228163949.1079532-1-Andrew.Martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: c8486ad4-a5c0-4100-d2ec-08dd58168e80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iQplBf57KwrCaZzu+MJwVipCUEsX5VlGEXta/5fIJgPlU1Z1uwNqJZf0NhMt?=
 =?us-ascii?Q?zMHjVz7PKUA6Z6ffpTURPNYmINO/cvmwbU6JZm8cgvvnOi8rTwnApE1U/LgP?=
 =?us-ascii?Q?Z2SDFX28Ql6Ee+QUlMlqZKqpboqOJgQqSX6cJymolDxiqPa9IO3KswbyuDPq?=
 =?us-ascii?Q?44KhMxrk6m1HP8BgypXws5YUS5+mtTlgfsEckGEQ1YlE9hFk7+Db3YRUu9A5?=
 =?us-ascii?Q?gpbk2Zsycux9v0LZV8UoKzBwOBknzSfCy34zudgwcsY5EdaPCzHSu+bmqtEI?=
 =?us-ascii?Q?1QXS1kXk9STF2EM1CZarkox6UUGJGwWBNn0H4TFmtyaPB1R+xnyNAOoC2MPl?=
 =?us-ascii?Q?WgQuGV2KumSmguP8gajf6bteL5avf7hPu6x+bLrt7t6/P3Hge9sIZnJo+w9t?=
 =?us-ascii?Q?dgRoMuRETRy1ZfUDs0JMkBrPgkJWtMFmmDJgkPmCiudMTd/xg4BCdYh4Ugy4?=
 =?us-ascii?Q?hZPeq8ExojDmiA9ipg+bfCgSRii8HPDPU9dFSw/uq5416hHd3Aj348gsQzSh?=
 =?us-ascii?Q?jwStmQCmyyMmfvnuVWT8jTWr9Ny0/BmDIjtj8ch5QoatP0TiP24xSDyuCHe2?=
 =?us-ascii?Q?YKk+tPKsB2NlbBh13Tz10Ef0WxFCSPEQUlljMqb4mSxN66AmiA7a7/YiYTUR?=
 =?us-ascii?Q?emv4AXaKfAIa1m+k64jjyGckbvz4vSUPcv9ymkOSdO061cO7MlUsSAXeAv21?=
 =?us-ascii?Q?QZVY2+gPKNaf+MzzmSvs+kzRYk7timOD6cNMxhOLC8ascesqLTyqMymlnCgC?=
 =?us-ascii?Q?tnW/lhYLE/7blnJVwRdrI+9z9xiqF8Bs/QFfBLvl2gMo/sbz9VC7fNOIZI6W?=
 =?us-ascii?Q?vfMsFAA0//LrVHEWDUfdz9eST2TZi04vVskl/3gz0xAljntJ6IabaVXeWUH/?=
 =?us-ascii?Q?T5FRvUz0NJk5Xnrq9NCw2dJEUNG5PVBjdZk/SwPV+/7FhPXgqvhbztfeH07W?=
 =?us-ascii?Q?3d/GkjP0tf8vygz+vXL4NBUH21qbEph7Z/Z4WAxfXGUOV4+jbZdXT2/ZxIiH?=
 =?us-ascii?Q?NFgo5rzkHKUiBFD8PtUUKc0vzyw/I1ay1z2pIU6W0Qy+UKMoagRVzg43CZSk?=
 =?us-ascii?Q?IaEGiYMYQMitBKVZTD632sIJGbKmEdOgwqeS9NjL4oCDCMAq+qZPaIcPD2O+?=
 =?us-ascii?Q?j0rPmLKZnZwIcx3hyCw/9+sJXpfUDKJ9btGvykUgj+qJT/4Xfz/bFf+yoATw?=
 =?us-ascii?Q?LxdfcXOJ2U1rnxBCIz1dBWvOq+M5nE5IMF2yFK2uuZ3MwZM5BaEYb3Scyz/z?=
 =?us-ascii?Q?tSOMG2H3hGQYBqo8BTAdoQnm2YNSVIY2+T/KHtWZHQv+pJh++NMoAd4uO/GA?=
 =?us-ascii?Q?pBi1wm7kfSjyqW684j9c2KDbseqlWe3MUNvkfqSeI+caXEEK+dwaVtVaQvYU?=
 =?us-ascii?Q?TfWVQtbEeXNioRrygGxlS7OTBS/wfeEgTON86GzZ9Chvj6I26dHEwTtiSaCc?=
 =?us-ascii?Q?+Vq3NXUJglZuFlPrN+iW5rCwp5gwjUKrks77xyi4ePR5Mhn9/p1nFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 16:40:05.8716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8486ad4-a5c0-4100-d2ec-08dd58168e80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448
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

    Through KFD IOCTL Fuzzing we encountered a NULL pointer derefrence
    when calling kfd_queue_acquire_buffers.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 62c635e9d1aa..dc2cdc48e28d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -277,7 +277,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	if (properties->eop_ring_buffer_address) {
 		if (properties->eop_ring_buffer_size != topo_dev->node_props.eop_buffer_size) {
 			pr_debug("queue eop bo size 0x%lx not equal to node eop buf size 0x%x\n",
-				properties->eop_buf_bo->tbo.base.size,
+				properties->eop_ring_buffer_size,
 				topo_dev->node_props.eop_buffer_size);
 			err = -EINVAL;
 			goto out_err_unreserve;
-- 
2.43.0

