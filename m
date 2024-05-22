Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820BFC25B78
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 19:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF29810E410;
	Wed, 22 May 2024 19:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0OjeSEGG";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C52A10E410
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 19:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd/Z06YpbSTRK9g0onxQRZ3mmP4ecGhKf7uiRv+rmmjRtC8NMSpdYKiOjsRXL1fnUmXmdmJbhPgi86WQYRFMhEXLkZyZreiHZS4T5d7Ln6XfO5cGJwcx7O6oSXoXk/AjCDfGr2AVH4NCkjo5PRIs6+57X2v6rRTOMfIygiHxGGcEujFrzYR8nRcwDxVgTy1m1t3bDFfCRGHHyHucKkEejT4jfMojfBSNC16e0Pc7o3+EKfXLHKhabW+KD99mCfbxJ+l23SmgER8RSS2RDNAYU+gUsfWjYX52XEBVFEZHh+zuftxqWlKFXRWs8cLP32zQi9422hXJp0MmTY120xsPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPtMBHgG7CtjDwGp4rQsaKTeuhp4XX3utREpgnCT8Sg=;
 b=R8xTHKpdNYJLVAn7QQ4rN14Kw+KJKX0NTb6zodWq7sVcJXB4kXlRQKsw8mGQjyI8V02Dbk7Hf36vYQkwa0f9tOTu+wsA2HEqomqHRpZgcPZnSBnzSaPaHrS3dJYld8rVA3H5fx+of3iPWkIYkbB9iZt70Y2qc872JBsEjW5Al4Q1YaAnQPyeKGH89/GTzpXq+dT+zGPOAupR8RmosxKByOYGnXQEeg+04vbf1VBMBM8hflG2QD/LRC+GVBIQjffF9mgLraovtOWYYrdxwNqf7D27Ii5mtKJQ0O0p137ahCEWKbbm9clIedsOcMfjjX7jp0UMhqAMaG9De79buR2eew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPtMBHgG7CtjDwGp4rQsaKTeuhp4XX3utREpgnCT8Sg=;
 b=0OjeSEGGzkcBhWC1UWXXgJWAYITyhnUBRL4PYm7GAGu1ETEmbQ8CubOcUe7kfh43s0y88MKN7Xox9cvJyk3ah/imO4ARnsHhwmzkaZJWAV1sdi1kq15fFqZhfXAbpABAUZFJFaRV/5j2tqHmDoKM1+TL6r1QXh4IoWGjGc+Ajkc=
Received: from MW4PR04CA0224.namprd04.prod.outlook.com (2603:10b6:303:87::19)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 19:15:42 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:87:cafe::f9) by MW4PR04CA0224.outlook.office365.com
 (2603:10b6:303:87::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19 via Frontend
 Transport; Wed, 22 May 2024 19:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Wed, 22 May 2024 19:15:41 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 22 May
 2024 14:15:40 -0500
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>,
 <lijo.lazar@amd.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Subject: [PATCH] drm/amdgpu: Make CPX mode auto default in NPS4
Date: Wed, 22 May 2024 15:15:26 -0400
Message-ID: <20240522191526.342975-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 2530075c-87dd-4795-a676-08dc7a939284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?stcc7de2arVOMkKfzoltNuYOQjoG+C0JTb3H3fdp85JRHFRbabXApDOAriWj?=
 =?us-ascii?Q?xqK2rouMo8QIqe14U5+5beZ8aonASQc5bB+2agXb9XH3HigCCVk86BPK3R55?=
 =?us-ascii?Q?MASd9+uU76Oo+DuEQQs9i/qzNWV9Cs5aqX7KQ7SkuLBeOHGDEqvMMdN95Qdj?=
 =?us-ascii?Q?43Ikn7L3qL6BZCnWbYGFLOTzQYX7x2WETRrACyP2JZiLC99FpNPoDjpMJnob?=
 =?us-ascii?Q?QbZa6jzD6tJOR28DYlpzj6GvbWyvih0STxSSiaBv1p3Ar1L/xFQe4KPMjgg4?=
 =?us-ascii?Q?LohVF3KrsGlxNVYepcBwMAUozeVQxbR3XTRPaLJLTO/FGpRkpgiRYeYtGA9k?=
 =?us-ascii?Q?JVftF/iYQW+jzCDu2kQUtbvXPraHiKKEx0DPN5UuWoKPD62G8PlN0XBeXb60?=
 =?us-ascii?Q?VPhc+a7ZaihdR+pwN3BBRCpd911mDTzrpGsJGPOVqEjSzDBacb1WYqGha/oO?=
 =?us-ascii?Q?cDkCskDDAZZSQNDOujW4u4RaMXi3Z3SBQ5KcE4dII6YFiHO9kBhNR7gIL4mi?=
 =?us-ascii?Q?3am2zhJRMFpXsBSkJJF4Fq+ozrleEvyoyXKBF2jT9jZAfgBwWZbbz/9LdJ+x?=
 =?us-ascii?Q?GjPJltOQGPG9Z7mwwddR3JPpWbrrqZERGUwN4QOY4wyHmGM6jsEgDj9BSE+e?=
 =?us-ascii?Q?C8kXecMOyz8u5JqmSGoAOk43hxzkk2vIeboGTvIR9KY8TBQo8dJRYRmrA0sQ?=
 =?us-ascii?Q?rxnlZuCUKhbLF4uNsg1FaZODgtOic7H2Kwtw60VdM2KVt0PkcXZS7+DyC+pf?=
 =?us-ascii?Q?Qvf3Wq4VTPXet8TI2eyouTP47KdNsVRdWaEwXbq3jjHFyHT0CIZq4E3xR8B7?=
 =?us-ascii?Q?ayrzVaoZe/9yLcDib9rltBn4YYS1qJcos10RT0u12PeqD2GmLidQ4wehl6EV?=
 =?us-ascii?Q?z5cgltwm69YfNyATQXJECWfsNF9yAk9zMu9tT49WHd49nmlzd/jHmfCnjxcQ?=
 =?us-ascii?Q?Tw0tUgnbcBzQz8TPDvmWCjKWXCLcKXGrDIuilznCrp4FZ8kD6Vl6Cv5CreMI?=
 =?us-ascii?Q?v7yc8Px/f90EThb7KSVhHUAi9PR44UERT0JLWpoe2eZbS6w4axJ/GKS1squK?=
 =?us-ascii?Q?NaIqwcPqbnedjK8yDytor8d2l/96lduKgSOnoaVGs7s8Ctr1fQr9bDozgTsj?=
 =?us-ascii?Q?FpGDHEU7B6PuJtuptBHlYio6S44wBP6AZoIX/uu9RlP4UqSy/riX+ebafI8y?=
 =?us-ascii?Q?YdtrVP2daq+AnDGFmf+IcTj106O5bAZASqQXwlzTxfNLcB56liLS8LvZQ0ut?=
 =?us-ascii?Q?x03TL3gVIK6obn+07yeWCsDI88VmsWNupHip0U1awJhuzSTWHtsyU3+S2XVr?=
 =?us-ascii?Q?HfO307cKTIrZKPjUdxxer1RWLLQ1bG4x4rn28pzL5Qu2veM9GXeDmc9QlAz+?=
 =?us-ascii?Q?QCE9JillYtya9fsEH61uX6f0oVl2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 19:15:41.5153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2530075c-87dd-4795-a676-08dc7a939284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
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

On GFXIP9.4.3, make CPX mode as the default compute mode if the node is
setup in NPS4 memory partition mode. This change is only applicable for
dGPU, for APU, continue to use TPX mode.

Cc: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index d62cfa4e2d2b..2c9a0aa41e2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -422,7 +422,7 @@ __aqua_vanjaram_get_auto_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 
 	if (adev->gmc.num_mem_partitions == num_xcc / 2)
 		return (adev->flags & AMD_IS_APU) ? AMDGPU_TPX_PARTITION_MODE :
-						    AMDGPU_QPX_PARTITION_MODE;
+						    AMDGPU_CPX_PARTITION_MODE;
 
 	if (adev->gmc.num_mem_partitions == 2 && !(adev->flags & AMD_IS_APU))
 		return AMDGPU_DPX_PARTITION_MODE;
-- 
2.34.1

