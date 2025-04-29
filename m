Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D108C369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 21:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B6E10E21F;
	Tue, 29 Apr 2025 21:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n4BnLTNj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6192E10E21F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 21:40:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qU9BQruiJXhAm8J5ljeeF2QH6mKHfndM42BxKrCfSjjbExwGkag1zdHoPh46iDGbrRoxDJSX6wCBXSqAF75UKOc42wwaCL4ksBfShPMbXlRYbF9ybAfxoLtHechKx5+QWj583evvjPCLrcJ5zEacWiXjHvkEFr7XPrrJi2fokR3LIxbqQ4B11XtQ+j7uVIh5LXAGRMoc9oiuozlqqk8F1fY6wDK4AlzXNn/nOP8Mcb0d2E4x8qYoK6MaaVlmBmFl4RDj9j49bXLrAZZ7U7xD7RSyYWRdIJowD38jshSeOzaNuxY/dvFF3A/76dwJfpvmyyxQBxktAJ3l/sqH6or00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8OkJ8SS0WLZ3I0XGusPNS+cAoBjT2LuDcGipP6igzY=;
 b=byx/GvhV0vHuKP6Syy4+odVouxxz8L5OrKzQvs2kto6VR8xWG6W/mjffdaprhbCOpFralASdGKgkhY6vRTmeWfMdHbtg/FD9vVudAzLfcz66Dl2svayoCJR4CZN6WVQC8aA91qy614fhZPvVny+4aB5xQUHtD1vg6DCJKBdDhZAsNUFLrd/B8C+N0nGBEJ2GJvb0HOHb3YAG/VUkojvLgjLK0a7RATOrmr2YrQkqJ5etaaEaL/8fNC5Kb/XF3XGDR1/M3cnYYK7J5MrS9UKFNPsGYzX6YPRiLY21+3ivynTT9PzHdFzT1AM7V/yQzeIQeG2416HgIW9xz+eUF6pI1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8OkJ8SS0WLZ3I0XGusPNS+cAoBjT2LuDcGipP6igzY=;
 b=n4BnLTNj9zCShWmZCOlCCFx+gs3/yPC0ECl7ve1NPWRA0O8KiVSqFz5/1VpQG3ZPwQXXMffZrzuI0T5X6v/Xaq6ORkOCdXYQttBH2W3qCaoahWs1AXVpNnwh2f5ZY5qEL0lfls8k9Fl+0j0PrnJr+DTxjZGRUFctYuCz+HXgjuA=
Received: from SA1P222CA0108.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::29)
 by SN7PR12MB6838.namprd12.prod.outlook.com (2603:10b6:806:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 21:40:19 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::a1) by SA1P222CA0108.outlook.office365.com
 (2603:10b6:806:3c5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Tue,
 29 Apr 2025 21:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 21:40:19 +0000
Received: from asrock-1e715-b03-3.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Apr 2025 16:40:18 -0500
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Victor.Skvortsov@amd.com>, <Ahmad.Rehman@amd.com>,
 <Jeffrey.Chan@amd.com>, <Shravankumar.Gande@amd.com>, <Zhigang.Luo@amd.com>,
 Ellen Pan <yunru.pan@amd.com>, Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: Add Runtime Bad Page message definitions for
 VFs
Date: Tue, 29 Apr 2025 17:40:08 -0400
Message-ID: <20250429214008.93058-1-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SN7PR12MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cca5e4-5882-495b-fad2-08dd87666fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?varByVkTek7D9ralwgInBWcVPNq2ctZvWdt87C4MqqWiL6Bcu22JBduSmELu?=
 =?us-ascii?Q?wJ7O7WcG63k3Daa5hJc8yrIsXpr03BTE/R5PgjcAt2d4Uwg7OJzxanDkLyyT?=
 =?us-ascii?Q?bs/JDQ6dSu16rur02l862XXJ0jHdjR6KMkyF0oUswpgbgXvx8g0f9x5XXI84?=
 =?us-ascii?Q?x07uRL3DvhzMy/4fO11TCnk9I9FPS+Yka9qi2UDI8mGXot5MUTUarAzGv6f7?=
 =?us-ascii?Q?kXbb+ZyZXH3kbrxfNY+rS98Z9MqcEzo7lX7WJM0xK14qXA4ngELDjkff3YaI?=
 =?us-ascii?Q?K4RhK6OQOHeT+XAluC3OqdpZ62lREJiCd6Y0nuCfJqydVzobUBNnRPK7YqPU?=
 =?us-ascii?Q?GafjHe611rsXvRR/Rwz9KvVY8hTGnHUrtzV06HF6+YKJaDITXd1Os/ZhFCfG?=
 =?us-ascii?Q?UKZLjWSnX2p+lCt32KHbRqT59jg4D3mK0Dhym6Gyqt6tkOKXmVCfr1vwmMrW?=
 =?us-ascii?Q?vDOdl1NEaQz3D43vf72tm0/9OLDsu/oLhCcfVTIwTdwHmYHgdX1nPRdP0a8d?=
 =?us-ascii?Q?MHH03BH2rpegVa0SjmlSVWn3iOnhNDfud8R5XyRpshi65N2gLpcQad8g0zXz?=
 =?us-ascii?Q?MWH2GSPphY6z1My3FRYH6+Cz0NRBiafALIWYCCjyVox13DA9UMpqFqY8EKrd?=
 =?us-ascii?Q?CJpL0aceIoZtKykpQ4aMhPDCfT4wjkw/vy6fHvW8SjCrkyr6xKPWD2WGdQuz?=
 =?us-ascii?Q?fkeFPeIcZxynJ/OK9Qw9NuW6Sfv5Ke+wbemAwJ1JvQlVUVJ+sunUhcnqVDHu?=
 =?us-ascii?Q?944yUP5+xfqfnvwVuOGlZzQZAw8IGHvANwiAdUd3hyyMMBh2whCe/j3+7J3x?=
 =?us-ascii?Q?c/01xL+AdZ/OEWWohIPNjL/+i/0F/u+b8CiRqE8lk2zwzF0Ub6Vt3/Be72sY?=
 =?us-ascii?Q?RvOlRMLWgr2enV5iuzVd2CF+NGWyag3/FHeh+3jQPwOe4V9tJANfaUkg3NLg?=
 =?us-ascii?Q?8fms7jvaNdegr5xFmcOv/zpR3BeDGx8jnof6W/ABpeDcPRAYaRYYR2XPkwPC?=
 =?us-ascii?Q?np80JiC0kCYOJbaPOzFI7NF7jX028oufQewTReNIGoGZe7bh+IfXX1nyKSYh?=
 =?us-ascii?Q?REG9gZH9vxepoVehU8mUiMPmO+VTgCh1vTQu+BzFk3TCAwF/nFLifPlqY7/j?=
 =?us-ascii?Q?UZheCMm9O145E8M7YzGVIIaJgGwTdgTJGQ8aPmGWJbDsBqT4DqjOmfrKnNFA?=
 =?us-ascii?Q?/yC7dJKrjrpKaJ3FVRXjJnzSqp2YxBy7UxY+2n9kw/4mxG72AKbEqGvexs32?=
 =?us-ascii?Q?nll7jgqF1a8q2uan8NjohLlniQih0PJlY1o4ael7E+FbvfScus1fd9Y5Qgla?=
 =?us-ascii?Q?0QI8NtvuTIqDfxUxDew9fwPCxNN9s8YexW4XJ4RQ9691BBuzi1Gg3Qb1FzG7?=
 =?us-ascii?Q?vjoIbySm+Aex4c7m+F0K6KjuAf7oHQlclXoUac/tLRnSeF7J6i873134g8Pi?=
 =?us-ascii?Q?9BBMj4uI9NUfhGLIugJYYt9vOjoM1X3A+1oR17Lp2x362yCMMGdo3Fnrv+xw?=
 =?us-ascii?Q?M1hO7kV2fjCVMKL3VQug6V7tO0l7NNZSa0rS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 21:40:19.1340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cca5e4-5882-495b-fad2-08dd87666fff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6838
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

Currently VFs rely on poison consumption interrupt from HW
to kick off the bad page retirement process. Part of this process
includes a VF reset.

This patch adds the following:

1) Host Bad Pages notification message.
2) Guest request bad pages message.

When combined, VFs are able to reserve the pages early, and potentially
avoid future poison consumption that will disrupt user services
from consequent FLR.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
index bea724981309..3b0c55f67fe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
@@ -331,6 +331,7 @@ enum amd_sriov_mailbox_request_message {
 	MB_REQ_MSG_RAS_POISON = 202,
 	MB_REQ_RAS_ERROR_COUNT = 203,
 	MB_REQ_RAS_CPER_DUMP = 204,
+	MB_REQ_RAS_BAD_PAGES = 205,
 };
 
 /* mailbox message send from host to guest  */
@@ -348,6 +349,8 @@ enum amd_sriov_mailbox_response_message {
 	MB_RES_MSG_GPU_RMA			= 10,
 	MB_RES_MSG_RAS_ERROR_COUNT_READY	= 11,
 	MB_REQ_RAS_CPER_DUMP_READY		= 14,
+	MB_RES_MSG_RAS_BAD_PAGES_READY		= 15,
+	MB_RES_MSG_RAS_BAD_PAGES_NOTIFICATION	= 16,
 	MB_RES_MSG_TEXT_MESSAGE			= 255
 };
 
-- 
2.34.1

